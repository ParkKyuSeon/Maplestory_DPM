WPEfficiency <- function(DealData, 
                         SwitchingTimes, 
                         WeaponPuffTimes, 
                         Spec, 
                         WeaponPuffTimeBonusStat, 
                         WeaponATK,
                         DPM) {
  CycleTime <- max(DealData$Time)
  
  for(i in 1:length(WeaponPuffTimes)) {
    if(i==1) {
      WP <- subset(DealData, DealData$Time >= WeaponPuffTimes[i])
      WP <- subset(WP, WP$Time <= WeaponPuffTimes[i] + 18000)
    } else {
      WP2 <- subset(DealData, DealData$Time >= WeaponPuffTimes[i])
      WP2 <- subset(WP2, WP2$Time <= WeaponPuffTimes[i] + 18000)
      WP <- rbind(WP, WP2)
    }
  }
  
  for(i in 1:length(SwitchingTimes)) {
    if(i==1) {
      SW <- subset(DealData, DealData$Time <= SwitchingTimes[i])
      SW <- subset(SW, SW$Time >= SwitchingTimes[i] - 5000)
    } else {
      SW2 <- subset(DealData, DealData$Time <= SwitchingTimes[i])
      SW2 <- subset(SW2, SW2$Time >= SwitchingTimes[i] - 5000)
      SW <- rbind(SW, SW2)
    }
  }
  
  WPStat <- WeaponATK * 4 * Spec$MainStatP + WeaponPuffTimeBonusStat
  WPDealIncR <- ((Spec$MainStat + WPStat + WeaponPuffTimeBonusStat) * 4 + Spec$SubStat1 + ifelse(is.null(Spec$SubStat2)==T, 0, Spec$SubStat2)) / 
    ((Spec$MainStat + WeaponPuffTimeBonusStat) * 4 + Spec$SubStat1 + ifelse(is.null(Spec$SubStat2)==T, 0, Spec$SubStat2)) - 1
  WPDealInc <- WPDealIncR * sum(WP$Deal)
  SWDealDec <- sum(SW$Deal)
  
  TotalDeal <- DPM * CycleTime / 60000
  TotalDealNew <- TotalDeal + WPDealInc - SWDealDec
  DPMWithWP <- TotalDealNew / (CycleTime / 60000)
  
  DPM <- data.frame(DPM = DPM, DPMWithWP = DPMWithWP, DPMIncRate = DPMWithWP / DPM - 1,
                    WeaponPuffDealIncRate = WPDealIncR, WeaponPuffDealInc = WPDealInc, WeaponPuffDealIncPerMin = WPDealInc / (CycleTime / 60000), 
                    SwitchingDealDec = SWDealDec, SwitchingDealDecPerMin = SWDealDec / (CycleTime / 60000))
  return(DPM)
}
RREfficiency <- function(JobName,
                         DealData, 
                         Spec, 
                         RestraintTimeBonusATKP, 
                         DPM) {
  CycleTime <- c()
  RRPeriod <- c()
  RREff <- c()
  RRDeal <- c()
  RRDealInc <- c()
  RRDealIncPerMin <- c()
  DPMWithoutRR <- c()
  for(i in 1:length(JobName)) {
    CycleTime[i] <- max(DealData[[i]]$Time)
    RRPeriod[i] <- CycleTime[i] / nrow(subset(DealData[[i]], DealData[[i]]$Skills=="Restraint4")) / 1000
    
    RREff[i] <- (100 + Spec[[i]]$ATKP + RestraintTimeBonusATKP[i] + 100) / (100 + Spec[[i]]$ATKP + RestraintTimeBonusATKP[i])
    RRDeal[i] <- sum(subset(DealData[[i]], DealData[[i]]$R4 > 0)$Deal)
    RRDealInc[i] <- RRDeal[i] - RRDeal[i] / RREff[i]
    RRDealIncPerMin[i] <- RRDealInc[i] / (CycleTime[i] / 60000)
    DPMWithoutRR[i] <- DPM[i] - RRDealIncPerMin[i]
  }
  return(data.frame(JobName = JobName, DPM = DPM, DPMWithoutRR = DPMWithoutRR, 
                    RRPeriod = RRPeriod, RRDealInc = RRDealInc, RRDealIncPerMin = RRDealIncPerMin, RRDealIncRate = DPM / DPMWithoutRR - 1, RREff = RREff - 1))
}
RREfficiencyUns <- function(JobName,
                            DealCycle1, DealCycle2, ATKFinal, BuffFinal, SummonedFinal, Spec, Unsdata, 
                            DPM) {
  BuffFinal[rownames(BuffFinal)=="Restraint4", ]$ATKP <- 0
  if(JobName == "ArchMageTC") {
    DPMWithoutRR <- sum(na.omit(TCDealCalcWithMaxDMR(DealCycle1, DealCycle2, ATKFinal, BuffFinal, SummonedFinal, Spec, Unsdata))) / (Unsdata$DealCycleTime * 1000 / 60000)
  } else {
    DPMWithoutRR <- sum(na.omit(BishopDealCalcWithMaxDMR(DealCycle1, DealCycle2, ATKFinal, BuffFinal, SummonedFinal, Spec, Unsdata))) / (Unsdata$DealCycleTime * 1000 / 60000)
  }
  
  RRDealInc <- DPM * (Unsdata$DealCycleTime / 60) - DPMWithoutRR * (Unsdata$DealCycleTime / 60)
  RRDealIncPerMin <- DPM - DPMWithoutRR
  RRDealIncRate <- DPM / DPMWithoutRR - 1
  RREff <- (Spec$ATKP + 200) / (Spec$ATKP + 100)
  return(data.frame(DPM = DPM, DPMWithoutRR = DPMWithoutRR, RRPeriod = Unsdata$DealCycleTime, RRDealInc = RRDealInc, RRDealIncPerMin = RRDealIncPerMin, RRDealIncRate = DPM / DPMWithoutRR - 1, RREff = RREff - 1))
}
RREfficiencyOthers <- function(JobName,
                               DealCycles, ATKFinal, BuffFinal, SummonedFinal, Spec, DealCycleTimes, DealCycleProbs, 
                               RestraintTimeBonusATKP, 
                               DPM) {
  BuffFinal[rownames(BuffFinal)=="Restraint4", ]$ATKP <- 0
  RRPeriod <- sum((DealCycleTimes * DealCycleProbs)) / nrow(subset(DealCycles[[1]], DealCycles[[1]]$Skills=="Restraint4")) / 1000
  if(JobName == "Eunwol") {
    DPMWithoutRR <- sum(na.omit(EunwolYakjeomGanpa(DealCycles[[1]], ATKFinal, BuffFinal, SummonedFinal, Spec))) / (max(DealCycles[[1]]$Time) / 60000)
  } else if(JobName == "Mechanic") {
    DPMWithoutRR <- sum(na.omit(LuckyDiceDealCalcWithMaxDMR(DealCycles[[1]], ATKFinal, BuffFinal, SummonedFinal, Spec, LuckyDiceProb=c(0.745340, 0.245185, 0.009475)))) / (max(DealCycles[[1]]$Time) / 60000)
  } else {
    DPMWithoutRR <- sum(na.omit(ResetDealCalcWithMaxDMR(DealCycles, ATKFinal, BuffFinal, SummonedFinal, Spec, DealCycleTimes, DealCycleProbs))) / (sum(DealCycleTimes * DealCycleProbs) / 60000)
  }
  
  RRDealInc <- DPM * (sum(DealCycleTimes * DealCycleProbs) / 60000) - DPMWithoutRR * (sum(DealCycleTimes * DealCycleProbs) / 60000)
  RRDealIncPerMin <- DPM - DPMWithoutRR
  RRDealIncRate <- DPM / DPMWithoutRR - 1
  RREff <- (Spec$ATKP + RestraintTimeBonusATKP + 200) / (Spec$ATKP + RestraintTimeBonusATKP + 100)
  return(data.frame(DPM = DPM, DPMWithoutRR = DPMWithoutRR, RRPeriod = RRPeriod, RRDealInc = RRDealInc, RRDealIncPerMin = RRDealIncPerMin, RRDealIncRate = DPM / DPMWithoutRR - 1, RREff = RREff - 1))
}

RREfficiencyOthers("Eunwol", 
                   list(EunwolDealCycleFixed), ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2, max(EunwolDealCycleFixed$Time), 1, 
                   0, 
                   DPM12347$Eunwol[1])

RREfficiencyOthers("Mechanic", 
                   list(MechanicDealCycle), ATKFinal, BuffFinal, SummonedFinal, MechanicSpecOpt2, max(MechanicDealCycle$Time), 1, 
                   0, 
                   DPM12347$Mechanic[1])

RREfficiencyOthers("CannonShooter", 
                   CannonShooterDealCycles, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2, rep(max(CannonShooterFinalCycle$Time), 9), CannonShooterCycleProbs, 
                   0, 
                   DPM12347$CannonMaster[1])

RREfficiencyOthers("Viper", 
                   list(ViperDealCycle5, 
                        ViperDealCycle55, ViperDealCycle57, 
                        ViperDealCycle555, ViperDealCycle557, ViperDealCycle577), ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2, rep(max(ViperDealCycle5$Time), 6), ViperDealCycleProbs, 
                   0, 
                   DPM12347$Viper[1])

RREfficiencyOthers("Phantom", 
                   list(PhantomDealCycle, PhantomDealCycle2), ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt2, rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4), 
                   0, 
                   DPM12347$Phantom[1])

RREfficiencyOthers("Kaiser", 
                   KaiserDealCycles, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2, KaiserDealCycleTimes, KaiserDealCycleProbs, 
                   0, 
                   DPM12347$Kaiser[1])

RREfficiencyOthers("AngelicBuster", 
                   ABDealCycles, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt2, ABDealCycleTimes, ABDealCycleProbs, 
                   0, 
                   DPM12347$AngelicBuster[1])

RREfficiency(c("Hero", "Palladin", "DarkKnight"), 
             list(HeroDealData, PalladinDealData, DarkKnightDealData), 
             list(HeroSpecOpt2, PalladinSpecOpt2, DarkKnightSpecOpt2),  
             c(0, 0, 0),
             c(DPM12347$Hero[1], DPM12347$Palladin[1], DPM12347$DarkKnight[1]))

RREfficiency(c("Marksman", "Bowmaster", "PathFinder"), 
             list(data.frame(Skills=MarksmanDealCycle$Skills, Deal=MarksmanFinalDPM, Time=MarksmanDealCycle$Time, R4=MarksmanDealCycle$Restraint4), 
                  BowmasterDealData, PathFinderDealData), 
             list(MarksmanSpecOpt2, BowmasterSpecOpt2, PathFinderSpecOpt2),
             c(0, 20, 0), 
             c(DPM12347$Marksman[1], DPM12347$Bowmaster[1], DPM12347$PathFinder[1]))

RREfficiency(c("NightLord", "DualBlade"), 
             list(NightLordDealData, DualBladeDealData), 
             list(NightLordSpecOpt2, DualBladeSpecOpt2),  
             c(0, 0, 0),
             c(DPM12347$NightLord[1], DPM12347$DualBlader[1]))

RREfficiency(c("Aran", "Luminous", "Mercedes"), 
             list(AranDealData, LuminousDealData, MercedesDealData), 
             list(AranSpecOpt2, LuminousSpecOpt2, MercedesSpecOpt2_2),  
             c(35, 0, 0),
             c(DPM12347$Aran[1], DPM12347$Luminous[1], DPM12347$Mercedes[1]))

RREfficiency(c("Mikhail", "SoulMaster", "FlameWizard", "WindBreaker", "NightWalker", "Striker"), 
             list(MikhailDealData, SoulMasterDealData, FlameWizardDealData, WindBreakerDealData, NightWalkerDealData, StrikerDealData), 
             list(MikhailSpecOpt2, SoulMasterSpecOpt2, FlameWizardSpecOpt2, WindBreakerSpecOpt2, NightWalkerSpecOpt2, StrikerSpecOpt2),  
             c(30, 0, 0, 0, 0, 0),
             c(DPM12347$Mikhail[1], DPM12347$SoulMaster[1], DPM12347$FlameWizard[1], DPM12347$WindBreaker[1], DPM12347$NightWalker[1], DPM12347$Striker[1]))

RREfficiency(c("DemonSlayer", "Blaster", "BattleMage", "WildHunter", "Zero", "Hoyeong"), 
             list(DemonSlayerDealData, BlasterDealData, BattleMageDealData, WildHunterDealData, ZeroDealData, HoyeongDealData), 
             list(DemonSlayerSpecOpt2, BlasterSpecOpt2, BattleMageSpecOpt2, WildHunterSpecOpt2, ZeroSpecOpt2, HoyeongSpecOpt2),  
             c(0, 0, 0, 0, 0, 0),
             c(DPM12347$DemonSlayer[1], DPM12347$Blaster[1], DPM12347$BattleMage[1], DPM12347$WildHunter[1], DPM12347$Zero[1], DPM12347$Hoyeong[1]))

RREfficiency(c("Adele", "Illium", "Ark"), 
             list(AdeleDealData, IlliumDealData, ArkDealData), 
             list(AdeleSpecOpt2, IlliumSpecOpt2, ArkSpecOpt2),  
             c(0, 0, 0),
             c(DPM12347$Adele[1], DPM12347$Illium[1], DPM12347$Ark[1]))

RREfficiencyUns("ArchMageFP", 
                ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt2, FPUnsdata, 
                DPM12347$ArchMageFP[1])
RREfficiencyUns("ArchMageTC", 
                ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2, TCUnsdata, 
                DPM12347$ArchMageTC[1])
RREfficiencyUns("Bishop", 
                BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2, BIUnsdata, 
                DPM12347$Bishop[1])

WPEfficiency(data.frame(Deal=MarksmanFinalDPM, Time=MarksmanDealCycle$Time), 
             c(120310, max(MarksmanDealCycle$Time)), 
             c(125740), 
             MarksmanSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", SpecDefault$WeaponType))$ATK, 
             DPM12347$Marksman[1])

WPEfficiency(BowmasterDealData, 
             c(119340, max(BowmasterDealCycle$Time)), 
             c(124020), 
             BowmasterSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Bow", SpecDefault$WeaponType))$ATK, 
             DPM12347$Bowmaster[1])

WPEfficiency(ZeroDealData, 
             c(124340, max(ZeroDealCycle$Time)), 
             c(124400), 
             ZeroSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 0, 0, 0, "LongSword", SpecDefault$WeaponType))$ATK + 5, 
             DPM12347$Zero[1])

WPEfficiency(HeroDealData, 
             c(115650, max(HeroDealCycle$Time)), 
             c(118170), 
             HeroSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandSword", SpecDefault$WeaponType))$ATK, 
             DPM12347$Hero[1])

WPEfficiency(KaiserDealData, 
             c(116490, 228150, 341940, 454740, 568290, max(KaiserDealCycle0$Time)), 
             c(122340, 346410, 572040), 
             KaiserSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandSword", SpecDefault$WeaponType))$ATK, 
             sum(na.omit(KaiserDealDatas[[1]]) / (KaiserDealCycleTimes[1] / 60000)))

WPEfficiency(WildHunterDealData, 
             c(122730, max(WildHunterDealCycle$Time)), 
             c(126930), 
             WildHunterSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", SpecDefault$WeaponType))$ATK, 
             DPM12347$WildHunter[1])

WPEfficiency(NightWalkerDealData, 
             c(92040, 183270, 274740, max(NightWalkerDealCycle$Time)), 
             c(95280, 277980), 
             NightWalkerSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", SpecDefault$WeaponType))$ATK, 
             DPM12347$NightWalker[1])

WPEfficiency(NightWalkerDealData, 
             c(92040, 183270, 274740, max(NightWalkerDealCycle$Time)), 
             c(95280, 277980), 
             NightWalkerSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", SpecDefault$WeaponType))$ATK, 
             DPM12347$NightWalker[1])

WPEfficiency(DualBladeDealData, 
             c(91930, 181930, 271300, max(DualBladeDealCycle$Time)), 
             c(94780, 274150), 
             DualBladeSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", SpecDefault$WeaponType))$ATK, 
             DPM12347$DualBlade[1])

WPEfficiency(HoyeongDealData, 
             c(100920, 195060, 293430, max(HoyeongDealCycle$Time)), 
             c(104730, 297240), 
             HoyeongSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Fan", SpecDefault$WeaponType))$ATK, 
             DPM12347$Hoyeong[1])

WPEfficiency(AdeleDealData, 
             c(100620, 171630, 270180, max(AdeleDealCycleTrigger$Time)), 
             c(101520, 271080), 
             AdeleSpecOpt2, 
             0, 
             data.frame(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", SpecDefault$WeaponType))$ATK, 
             DPM12347$Adele[1])