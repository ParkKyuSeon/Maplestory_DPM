DamperATK <- function(DealData, ATKSkillData, SummonedSkillData, MAX=T) {
  ATKTimes <- rep(0, nrow(DealData))
  DealData <- cbind(DealData, ATKTimes)
  DealData <- data.frame(DealData)
  
  for(i in 1:nrow(DealData)) {
    if(sum(DealData$Skills[i]==rownames(ATKSkillData)) >= 1) {
      DealData$ATKTimes[i] <- subset(ATKSkillData, rownames(ATKSkillData)==DealData$Skills[i])$AttackTimes
    } else if(sum(DealData$Skills[i]==rownames(SummonedSkillData)) >= 1) {
      DealData$ATKTimes[i] <- subset(SummonedSkillData, rownames(SummonedSkillData)==DealData$Skills[i])$AttackTimes
    } 
  }

  DamperATKeach <- c()
  for(i in 1:nrow(DealData)) {
    if(DealData$ATKTimes[i]==0) {
      DamperATKeach[i] <- 0
    } else {
      DamperATKeach[i] <- DealData$Deal[i] / DealData$ATKTimes[i]
    }
  }
  DealData <- cbind(DealData, DamperATKeach)
  DealData <- data.frame(DealData)
  
  if(MAX==T) {
    return(DealData[DealData$DamperATKeach==max(DealData$DamperATKeach), ][1, ])
  }
}

DamperATK(HeroDealData, data.frame(HeroATK), data.frame(HeroSummoned))
DamperATK(PalladinDealData, data.frame(PalladinATK), data.frame(PalladinSummoned))
DamperATK(DarkKnightDealData, data.frame(DarkKnightATK), data.frame(DarkKnightSummoned))
DamperATK(ArchMageFPDealData, data.frame(ArchMageFPATK), data.frame(ArchMageFPSummoned))
DamperATK(ArchMageTCDealData, data.frame(ArchMageTCATK), data.frame(ArchMageTCSummoned))
DamperATK(BishopDealData, data.frame(BishopATK), data.frame(BishopSummoned))
DamperATK(BowmasterDealData, data.frame(BowmasterATK), data.frame(BowmasterSummoned))
DamperATK(MarksmanDealData, data.frame(MarksmanATK), data.frame(MarksmanSummoned))
DamperATK(PathFinderDealData, data.frame(PathFinderATK), data.frame(PathFinderSummoned))
DamperATK(NightLordDealData, data.frame(NightLordATK), data.frame(NightLordSummoned))
DamperATK(ShadowerDealData, data.frame(ShadowerATK), data.frame(ShadowerSummoned))
DamperATK(DualBladeDealData, data.frame(DualBladeATK), data.frame(DualBladeSummoned))
DamperATK(ViperDealData, data.frame(ViperATK), data.frame(ViperSummoned))
DamperATK(CaptainDealData, data.frame(CaptainATK), data.frame(CaptainSummoned))
DamperATK(CannonShooterDealData, data.frame(CannonShooterATK), data.frame(CannonShooterSummoned))
DamperATK(MikhailDealData, data.frame(MikhailATK), data.frame(MikhailSummoned))
DamperATK(SoulMasterDealData, data.frame(SoulMasterATK), data.frame(SoulMasterSummoned))
DamperATK(FlameWizardDealData, data.frame(FlameWizardATK), data.frame(FlameWizardSummoned))
DamperATK(WindBreakerDealData, data.frame(WindBreakerATK), data.frame(WindBreakerSummoned))
DamperATK(NightWalkerDealData, data.frame(NightWalkerATK), data.frame(NightWalkerSummoned))
DamperATK(StrikerDealData, data.frame(StrikerATK), data.frame(StrikerSummoned))
DamperATK(BlasterDealData, data.frame(BlasterATK), data.frame(BlasterSummoned))
DamperATK(DemonSlayerDealData, data.frame(DemonSlayerATK), data.frame(DemonSlayerSummoned))
DamperATK(DemonAvengerDealData, data.frame(DemonAvengerATK), data.frame(DemonAvengerSummoned))
DamperATK(BattleMageDealData, data.frame(BattleMageATK), data.frame(BattleMageSummoned))
DamperATK(WildHunterDealData, data.frame(WildHunterATK), data.frame(WildHunterSummoned))
DamperATK(XenonDealData, data.frame(XenonATK), data.frame(XenonSummoned))
DamperATK(MechanicDealData, data.frame(MechanicATK), data.frame(MechanicSummoned))
DamperATK(AranDealData, data.frame(AranATK), data.frame(AranSummoned))
DamperATK(EvanDealData, data.frame(EvanATK), data.frame(EvanSummoned))
DamperATK(LuminousDealData, data.frame(LuminousATK), data.frame(LuminousSummoned))
DamperATK(MercedesDealData, data.frame(MercedesATK), data.frame(MercedesSummoned))
DamperATK(PhantomDealData, data.frame(PhantomATK), data.frame(PhantomSummoned))
DamperATK(EunwolDealData, data.frame(EunwolATK), data.frame(EunwolSummoned))
DamperATK(KaiserDealData, data.frame(KaiserATK), data.frame(KaiserSummoned))
DamperATK(KainDealData, data.frame(KainATK), data.frame(KainSummoned))
DamperATK(AngelicBusterDealData, data.frame(AngelicBusterATK), data.frame(AngelicBusterSummoned))
DamperATK(AdeleDealData, data.frame(AdeleATK), data.frame(AdeleSummoned))
DamperATK(IlliumDealData, data.frame(IlliumATK), data.frame(IlliumSummoned))
DamperATK(ArkDealData, data.frame(ArkATK), data.frame(ArkSummoned))
DamperATK(LaraDealData, data.frame(LaraATK), data.frame(LaraSummoned))
DamperATK(HoyeongDealData, data.frame(HoyeongATK), data.frame(HoyeongSummoned))
DamperATK(ZeroDealData, data.frame(ZeroATK), data.frame(ZeroSummoned))
DamperATK(KinesisDealData, data.frame(KinesisATK), data.frame(KinesisSummoned))