library(ggplot2)

DealTimeLine <- function(Time, Deal, BreakTime=5000) {
  Breaks <- ceiling(max(Time)/BreakTime)
  Times <- seq(from=0, to=Breaks*BreakTime, by=BreakTime)
  
  TimeLine <- data.frame(Time, Deal)
  Deals <- list()
  for(i in 1:(length(Times)-1)) {
    Deals[[i]] <- na.omit(subset(TimeLine, TimeLine$Time>=Times[i]&TimeLine$Time<Times[i+1])$Deal)
  }
  
  DealTL <- c()
  for(i in 1:length(Deals)) {
    DealTL[i] <- sum(Deals[[i]])
  }
  DealTL <- data.frame(Times[1:length(Times)-1]/1000, DealTL/100000000)
  colnames(DealTL) <- c("Time", "Deal")
  return(DealTL)
}
TLGraph <- function(DealTL, DealTime, JobName, Cumulative=F, MaxDeal=30000) {
  AVGDeal <- sum(DealTL$Deal) / DealTime * 5
  if(Cumulative==T) {
    CumDeal <- c()
    for(i in 1:nrow(DealTL)) {
      CumDeal[i] <- sum(DealTL$Deal[1:i])
    }
    DealTL <- cbind(DealTL, CumDeal)
    colnames(DealTL) <- c("Time", "Deal", "CumDeal")
    DealTL <- subset(DealTL, DealTL$Time<=360)
  }
  
  
  if(Cumulative==T) {
    barplot(DealTL$CumDeal, names.arg=DealTL$Time, space=0, ylim=c(0, ceiling(max(DealTL$CumDeal)/50000)*50000),
            cex.axis=1, cex.names=0.7, las=2, border="gray60", col="skyblue", 
            main=paste(JobName, "Deal Time Line(Cumulative)"))
    abline(h=25000 * 1:100, col="gray80")
    curve(x * AVGDeal, 0, nrow(DealTL), col="gray40", lwd=3, add=T, 
          xlim=c(0, nrow(DealTL)))
  } else {
    barplot(DealTL$Deal, names.arg=DealTL$Time, ylim=c(0, MaxDeal),
            cex.axis=1, cex.names=0.7, las=2, border=NA, col="skyblue", 
            main=paste(JobName, "Deal Time Line(Non-cumulative)"))
    abline(h=2500 * 1:100, col="gray80")
    abline(h=AVGDeal, col="gray40", lwd=3)
  }
}
DealIrr <- function(DealTL, DealTime) {
  AVGDeal <- sum(DealTL$Deal) / DealTime * 5
  DealTL <- DealTL[1:(nrow(DealTL)-1), ]
  Irr <- sum(abs(DealTL$Deal - AVGDeal) / AVGDeal) / length(DealTL$Deal)
  return(Irr)
}
RRGraph <- function(RestraintTL, JobName, VertLineTime=c(10, 13, 14), col="Skyblue", ylim=c(0, 80000), add=F, reverse=F) {
  RestraintTL$Time <- RestraintTL$Time - RestraintTL$Time[1]
  
  if(reverse==T) {
    RestraintTL$Time <- max(RestraintTL$Time) - RestraintTL$Time
    RestraintTL <- RestraintTL[order(RestraintTL$Time), ]
  }
  RestraintTL$CummulativeDeal <- RestraintTL$Deal
  for(i in 1:nrow(RestraintTL)) {
    RestraintTL$CummulativeDeal[i] <- sum(RestraintTL$Deal[1:i])
  }
  RestraintTL$CummulativeDeal <- RestraintTL$CummulativeDeal / 100000000
  RestraintTL$Time <- RestraintTL$Time / 1000
  if(add==F) {
    plot(RestraintTL$Time, RestraintTL$CummulativeDeal, type="l", col=col, lwd=5, ylim=ylim, xlim=c(0, 15), 
         ylab="Damage(100mil)", xlab="Time(sec)", main=paste(JobName, "Restraint Damage(Cumulative)"))
  } else {
    points(RestraintTL$Time, RestraintTL$CummulativeDeal, type="l", col=col, lwd=5, ylim=ylim, xlim=c(0, 15))
  }
  
  if(add==F) {
    for(i in 0:15) {
      abline(v=i, col="Gray80", lwd=ifelse(i==10, 4, ifelse(sum(i==c(13, 14))==1, 3, 1)))
    }
    for(i in 0:8) {
      abline(h=i*10000, col="Gray80")
    }
    abline(h=31709, col="Gray80", lwd=3)
  }
}
CumulativeDealGraph <- function(RawDealTL, JobName, MaxTime=720, col="Skyblue", ylim=c(0, 800000), add=F) {
  RawDealTL <- RawDealTL[-1 * is.na(RawDealTL$Deal), ]
  RawDealTL$CumulativeDeal <- RawDealTL$Deal
  for(i in 1:nrow(RawDealTL)) {
    RawDealTL$CumulativeDeal[i] <- sum(RawDealTL$Deal[1:i])
  }
  
  DealTL <- RawDealTL
  while(max(DealTL$Time) <= MaxTime * 1000) {
    k <- nrow(DealTL)
    DealTL <- rbind(DealTL, RawDealTL)
    for(i in (k + 1) : (k + nrow(RawDealTL))) {
      DealTL$Time[i] <- DealTL$Time[k] + DealTL$Time[i]
      DealTL$CumulativeDeal[i] <- DealTL$CumulativeDeal[k] + DealTL$CumulativeDeal[i]
    }
  }
  DealTL <- DealTL[DealTL$Time <= MaxTime * 1000, ]
  DealTL$Time <- DealTL$Time / 1000
  DealTL$CumulativeDeal <- DealTL$CumulativeDeal / 100000000
  
  if(add==F) {
    plot(DealTL$Time, DealTL$CumulativeDeal, type="l", col=col, lwd=3, ylim=ylim, xlim=c(0, MaxTime), 
         ylab="Damage(100mil)", xlab="Time(sec)", main=paste(JobName, "Damage(Cumulative)"))
  } else {
    points(DealTL$Time, DealTL$CumulativeDeal, type="l", col=col, lwd=3, ylim=ylim, xlim=c(0, MaxTime))
  }
  
  if(add==F) {
    for(i in 0:(floor(MaxTime)/100)) {
      abline(v=i*100, col="Gray80")
    }
    for(i in 0:8) {
      abline(h=i*100000, col="Gray80")
    }
  }
  abline(v=120, col="Gray80", lwd=2)
  abline(v=180, col="Gray80", lwd=2)
  abline(v=240, col="Gray80", lwd=2)
}

colorset <- c("#EF847D", "#DE8344", "#F5C242", "#7EAC55", "#6A99CF", 
              "#4E70BD", "#CB86F9", "#475468", "#A4A5A5", "#515252")

## Cumulative Deal Graph(720s)
## Warrior
CumulativeDealGraph(HeroDealData, "Warrior(1)", col=colorset[2])
CumulativeDealGraph(PalladinDealData, "Palladin", col=colorset[3], add=T)
CumulativeDealGraph(DarkKnightDealData, "DarkKnight", col=colorset[4], add=T)
CumulativeDealGraph(MikhailDealData, "Mikhail", col=colorset[5], add=T)
CumulativeDealGraph(SoulMasterDealData, "SoulMaster", col=colorset[6], add=T)

legend(x=0, y=800000, legend=c("Hero", "Palladin", "DarkKnight", "Mikhail", 
                               "SoulMaster"), col=colorset[2:6], lty=1, lwd=3)

CumulativeDealGraph(AranDealData, "Warrior(2)", col=colorset[2])
CumulativeDealGraph(BlasterDealData, "Blaster", col=colorset[3], add=T)
CumulativeDealGraph(DemonSlayerDealData, "DemonSlayer", col=colorset[4], add=T)
CumulativeDealGraph(AdeleDealData, "Adele", col=colorset[5], add=T)
CumulativeDealGraph(ZeroDealData, "Zero", col=colorset[6], add=T)

legend(x=0, y=800000, legend=c("Aran", "Blaster", "DemonSlayer", "Adele", 
                               "Zero"), col=colorset[2:6], lty=1, lwd=3)

## Wizard
CumulativeDealGraph(data.frame(Time=ArchMageFPDealCycle2$Time, Deal=ArchMageFPDamage2), "Wizard", col=colorset[2])
CumulativeDealGraph(data.frame(Time=ArchMageTCDealCycle2$Time, Deal=ArchMageTCDamage2), "ArchMageTC", col=colorset[3], add=T)
CumulativeDealGraph(data.frame(Time=BishopDealCycle2$Time, Deal=BishopDamage2), "Bishop", col=colorset[4], add=T)
CumulativeDealGraph(FlameWizardDealData, "FlameWizard", col=colorset[5], add=T)
CumulativeDealGraph(LuminousDealData, "Luminous", col=colorset[6], add=T)
CumulativeDealGraph(BattleMageDealData, "BattleMage", col=colorset[8], add=T)
CumulativeDealGraph(IlliumDealData, "Illium", col=colorset[9], add=T)

legend(x=0, y=800000, legend=c("ArchMageFP", "ArchMageTC", "Bishop", 
                              "FlameWizard", "Luminous", "BattleMage", "Illium"), col=colorset[c(2:6, 8, 9)], lty=1, lwd=3)

## Archer
CumulativeDealGraph(BowmasterDealData, "Archer", col=colorset[2])
CumulativeDealGraph(data.frame(Time=MarksmanDealCycle$Time, Deal=MarksmanFinalDPMwithMax), "Marksman", col=colorset[3], add=T)
CumulativeDealGraph(PathFinderDealData, "PathFinder", col=colorset[4], add=T)
CumulativeDealGraph(WindBreakerDealData, "WindBreaker", col=colorset[5], add=T)
CumulativeDealGraph(MercedesDealData, "Mercedes", col=colorset[6], add=T)
CumulativeDealGraph(WildHunterDealData, "WildHunter", col=colorset[9], add=T)

legend(x=0, y=800000, legend=c("Bowmaster", "Marksman", "PathFinder", 
                               "WindBreaker", "Mercedes", "WildHunter"), col=colorset[c(2:6, 9)], lty=1, lwd=3)

## Thief
CumulativeDealGraph(NightLordDealData, "Thief", col=colorset[2])
CumulativeDealGraph(DualBladeDealData, "DualBlader", col=colorset[3], add=T)
CumulativeDealGraph(NightWalkerDealData, "NightWalker", col=colorset[4], add=T)
CumulativeDealGraph(PhantomDealData, "Phantom", col=colorset[5], add=T)
CumulativeDealGraph(HoyeongDealData, "Hoyeong", col=colorset[6], add=T)

legend(x=0, y=800000, legend=c("NightLord", "DualBlader", "NightWlaker", 
                              "Phantom", "Hoyeong"), col=colorset[2:6], lty=1, lwd=3)

## Pirates
CumulativeDealGraph(CannonShooterDealData, "Pirates", col=colorset[2])
CumulativeDealGraph(ViperDealData, "Viper", col=colorset[3], add=T)
CumulativeDealGraph(StrikerDealData, "Striker", col=colorset[4], add=T)
CumulativeDealGraph(EunwolDealDataFixed, "Eunwol(Fixed Boss)", col=colorset[5], add=T)
CumulativeDealGraph(MechanicDealData, "Mechanic", col=colorset[6], add=T)
CumulativeDealGraph(ArkDealData, "Ark", col=colorset[8], add=T)
CumulativeDealGraph(ABDealData2, "AngelicBuster", col=colorset[9], add=T)

legend(x=0, y=800000, legend=c("CannonShooter", "Viper", "Striker", "Eunwol(Fixed)", "Mechanic", 
                               "Ark", "AngelicBuster"), col=colorset[c(2:6, 8, 9)], lty=1, lwd=3)






## Cumulative Deal Graph (360s)
## Warrior
CumulativeDealGraph(HeroDealData, "Warrior(1)", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(PalladinDealData, "Palladin", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(DarkKnightDealData, "DarkKnight", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(MikhailDealData, "Mikhail", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(SoulMasterDealData, "SoulMaster", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("Hero", "Palladin", "DarkKnight", "Mikhail", 
                               "SoulMaster"), col=colorset[2:6], lty=1, lwd=3)

CumulativeDealGraph(AranDealData, "Warrior(2)", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(BlasterDealData, "Blaster", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(DemonSlayerDealData, "DemonSlayer", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(AdeleDealData, "Adele", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(ZeroDealData, "Zero", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("Aran", "Blaster", "DemonSlayer", "Adele", 
                               "Zero"), col=colorset[2:6], lty=1, lwd=3)

## Wizard
CumulativeDealGraph(data.frame(Time=ArchMageFPDealCycle2$Time, Deal=ArchMageFPDamage2), "Wizard", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(data.frame(Time=ArchMageTCDealCycle2$Time, Deal=ArchMageTCDamage2), "ArchMageTC", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(data.frame(Time=BishopDealCycle2$Time, Deal=BishopDamage2), "Bishop", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(FlameWizardDealData, "FlameWizard", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(LuminousDealData, "Luminous", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(BattleMageDealData, "BattleMage", col=colorset[8], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(IlliumDealData, "Illium", col=colorset[9], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("ArchMageFP", "ArchMageTC", "Bishop", 
                               "FlameWizard", "Luminous", "BattleMage", "Illium"), col=colorset[c(2:6, 8, 9)], lty=1, lwd=3)

## Archer
CumulativeDealGraph(BowmasterDealData, "Archer", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(data.frame(Time=MarksmanDealCycle$Time, Deal=MarksmanFinalDPMwithMax), "Marksman", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(PathFinderDealData, "PathFinder", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(WindBreakerDealData, "WindBreaker", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(MercedesDealData, "Mercedes", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(WildHunterDealData, "WildHunter", col=colorset[9], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("Bowmaster", "Marksman", "PathFinder", 
                               "WindBreaker", "Mercedes", "WildHunter"), col=colorset[c(2:6, 9)], lty=1, lwd=3)

## Thief
CumulativeDealGraph(NightLordDealData, "Thief", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(DualBladeDealData, "DualBlader", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(NightWalkerDealData, "NightWalker", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(PhantomDealData, "Phantom", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(HoyeongDealData, "Hoyeong", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("NightLord", "DualBlader", "NightWlaker", 
                               "Phantom", "Hoyeong"), col=colorset[2:6], lty=1, lwd=3)

## Pirates
CumulativeDealGraph(CannonShooterDealData, "Pirates", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(ViperDealData, "Viper", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(StrikerDealData, "Striker", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(EunwolDealDataFixed, "Eunwol(Fixed Boss)", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(MechanicDealData, "Mechanic", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(ArkDealData, "Ark", col=colorset[8], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(ABDealData, "AngelicBuster", col=colorset[9], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("CannonShooter", "Viper", "Striker", "Eunwol(Fixed)", "Mechanic", 
                               "Ark", "AngelicBuster"), col=colorset[c(2:6, 8, 9)], lty=1, lwd=3)

## 1~5
CumulativeDealGraph(AdeleDealData, "", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(BlasterDealData, "Blaster", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(HoyeongDealData, "Hoyeong", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(IlliumDealData, "Illium", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(ArkDealData, "Ark", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("Adele", "Blaster", "Hoyeong", "Illium", "Ark"), col=colorset[c(2:6)], lty=1, lwd=3)

## 31_35
CumulativeDealGraph(data.frame(Time=BishopDealCycle2$Time, Deal=BishopDamage2), "", col=colorset[2], MaxTime=360, ylim=c(0, 400000))
CumulativeDealGraph(WindBreakerDealData, "WindBreaker", col=colorset[3], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(PalladinDealData, "Palladin", col=colorset[4], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(MercedesDealData, "Mercedes", col=colorset[5], MaxTime=360, ylim=c(0, 400000), add=T)
CumulativeDealGraph(BattleMageDealData, "BattleMage", col=colorset[6], MaxTime=360, ylim=c(0, 400000), add=T)

legend(x=0, y=400000, legend=c("Bishop", "WindBreaker", "Palladin", "Mercedes", "BattleMage"), col=colorset[c(2:6)], lty=1, lwd=3)






## Cummulative RR Deal Graph
## Warrior
RRGraph(HeroDealData[57:179, ], "Warrior(1)", col=colorset[2])
RRGraph(PalladinDealData[25:208, ], "Palladin", col=colorset[3], add=T)
RRGraph(DarkKnightDealData[260:390, ], "DarkKnight", col=colorset[4], add=T)
RRGraph(MikhailDealData[46:203, ], "Mikhail", col=colorset[5], add=T)
RRGraph(SoulMasterDealData[360:577, ], "SoulMaster", col=colorset[6], add=T, reverse=T)

legend(x=0, y=80000, legend=c("Hero", "Palladin", "DarkKnight", "Mikhail", 
                              "SoulMaster(R)"), col=colorset[2:6], lty=1, lwd=4)

RRGraph(AranDealData[151:664, ], "Warrior(2)", col=colorset[2])
RRGraph(BlasterDealData[19:275, ], "Blaster", col=colorset[3], add=T)
RRGraph(DemonSlayerDealData[56:295, ], "DemonSlayer", col=colorset[4], add=T)
RRGraph(KaiserDealData[39:278, ], "Kaiser", col=colorset[5], add=T)
RRGraph(AdeleDealData[165:577, ], "Adele", col=colorset[6], add=T)
RRGraph(ZeroDealData[11:173, ], "Zero", col=colorset[9], add=T)

legend(x=0, y=80000, legend=c("Aran", "Blaster", "DemonSlayer", "Kaiser",
                              "Adele", "Zero"), col=colorset[c(2:6, 9)], lty=1, lwd=4)

## Wizard
RRGraph(data.frame(Time=ArchMageFP40s$Time, Deal=ArchMageFP40s$Damage)[1495:1829, ], "Wizard(1)", col=colorset[2], reverse=T)
RRGraph(data.frame(Time=ArchMageTC40s$Time, Deal=ArchMageTC40s$Damage)[730:1009, ], "ArchMageTC", col=colorset[3], add=T, reverse=T)
RRGraph(data.frame(Time=Bishop40s$Time, Deal=Bishop40s$Damage)[341:424, ], "Bishop", col=colorset[4], add=T, reverse=T)
RRGraph(FlameWizardDealData[89:257, ], "FlameWizard", col=colorset[5], add=T)

legend(x=0, y=80000, legend=c("ArchMageFP(R)", "ArchMageTC(R)", "Bishop(R)", "FlameWizard"), col=colorset[c(2:5)], lty=1, lwd=4)

RRGraph(LuminousDealData[622:755, ], "Wizard(2)", col=colorset[2])
RRGraph(BattleMageDealData[18:183, ], "BattleMage", col=colorset[3], add=T)
RRGraph(IlliumDealData[220:405, ], "Illium(Ground)", col=colorset[4], add=T)
RRGraph(WinggnitionDealData[220:392, ], "Illium(Wing)", col=colorset[5], add=T)

legend(x=0, y=80000, legend=c("Luminous", "BattleMage", "Illium(Ground)", "Illium(Wing)"), col=colorset[c(2:5)], lty=1, lwd=4)

## Archer
RRGraph(BowmasterDealData[70:766, ], "Archer", col=colorset[2])
RRGraph(data.frame(Time=MRestraint$Time, Deal=MRestraint$Damage), "Marksman", col=colorset[3], add=T)
RRGraph(PathFinderDealData[58:444, ], "PathFinder", col=colorset[4], add=T)
RRGraph(WindBreakerDealData[114:1139, ], "WindBreaker", col=colorset[5], add=T)
RRGraph(MercedesDealData[42:452, ], "Mercedes", col=colorset[6], add=T)
RRGraph(WildHunterDealData[81:687, ], "WildHunter", col=colorset[9], add=T)

legend(x=0, y=80000, legend=c("Bowmaster", "Marksman", "PathFinder", 
                              "WindBreaker", "Mercedes", "WildHunter"), col=colorset[c(2:6, 9)], lty=1, lwd=4)

## Thief
RRGraph(NightLordDealData[31:434, ], "Thief", col=colorset[2])
RRGraph(DualBladeDealData[30:279, ], "DualBlader", col=colorset[3], add=T)
RRGraph(NightWalkerDealData[59:826, ], "NightWalker", col=colorset[4], add=T)
RRGraph(PhantomDealData[23:430, ], "Phantom", col=colorset[5], add=T)
RRGraph(HoyeongDealData[67:232, ], "Hoyeong", col=colorset[6], add=T)

legend(x=0, y=80000, legend=c("NightLord", "DualBlader", "NightWlaker", 
                              "Phantom", "Hoyeong"), col=colorset[2:6], lty=1, lwd=4)

## Pirates
RRGraph(CannonShooterDealData[39:274, ], "Pirates", col=colorset[2])
RRGraph(StrikerDealData[34:236, ], "Striker", col=colorset[3], add=T)
RRGraph(EunwolDealData[72:1825, ], "Eunwol(Moving Boss)", col=colorset[4], add=T)
RRGraph(EunwolDealDataFixed[51:1579, ], "Eunwol(Fixed Boss)", col=colorset[5], add=T)
RRGraph(MechanicDealData[46:339, ], "Mechanic", col=colorset[6], add=T)
RRGraph(ArkDealData[58:395, ], "Ark", col=colorset[8], add=T)
RRGraph(ABDealData[517:1180, ], "AngelicBuster", col=colorset[9], add=T)
RRGraph(ViperDealData[45:207, ], "Viper", col=colorset[10], add=T)

legend(x=0, y=80000, legend=c("CannonShooter", "Striker", "Eunwol(Moving)", 
                              "Eunwol(Fixed)", "Mechanic", "Ark", "AngelicBuster", "Viper"), col=colorset[c(2:6, 8, 9, 10)], lty=1, lwd=4)

## 1~5
RRGraph(NightLordDealData[31:434, ], "", col=colorset[2])
RRGraph(ArkDealData[58:391, ], "Ark", col=colorset[3], add=T)
RRGraph(HoyeongDealData[67:232, ], "Hoyeong", col=colorset[4], add=T)
RRGraph(AdeleDealData[165:577, ], "Adele", col=colorset[5], add=T)
RRGraph(data.frame(Time=ArchMageTC40s$Time, Deal=ArchMageTC40s$Damage)[730:1009, ], "ArchMageTC", col=colorset[6], add=T, reverse=T)

legend(x=0, y=80000, legend=c("NightLord", "Ark", "Hoyeong", "Adele", "ArchMageTC(R)"), col=colorset[c(2:6)], lty=1, lwd=4)

## 29~33
RRGraph(StrikerDealData[34:236, ], "", col=colorset[2])
RRGraph(WindBreakerDealData[114:1139, ], "WindBreaker", col=colorset[3], add=T)
RRGraph(data.frame(Time=Bishop40s$Time, Deal=Bishop40s$Damage)[341:424, ], "Bishop", col=colorset[4], add=T, reverse=T)
RRGraph(LuminousDealData[622:755, ], "Luminous", col=colorset[5], add=T)
RRGraph(SoulMasterDealData[360:577, ], "SoulMaster", col=colorset[6], add=T, reverse=T)

legend(x=0, y=80000, legend=c("Striker", "WindBreaker", "Bishop(R)", "Luminous", "SoulMaster(R)"), col=colorset[c(2:6)], lty=1, lwd=4)






## Deal Graph
## Hero
HeroDealTL <- DealTimeLine(HeroDealData$Time, HeroDealData$Deal)
TLGraph(HeroDealTL, max(HeroDealData$Time)/1000, "Hero", F)
TLGraph(HeroDealTL, max(HeroDealData$Time)/1000, "Hero", T)
DealIrr(HeroDealTL, max(HeroDealData$Time)/1000)

## Palladin
PalladinDealTL <- DealTimeLine(PalladinDealData$Time, PalladinDealData$Deal)
TLGraph(PalladinDealTL, max(PalladinDealData$Time)/1000, "Paladin", F)
TLGraph(PalladinDealTL, max(PalladinDealData$Time)/1000, "Paladin", T)
DealIrr(PalladinDealTL, max(PalladinDealData$Time)/1000)

## DarkKnight
DarkKnightDealTL <- DealTimeLine(DarkKnightDealData$Time, DarkKnightDealData$Deal)
TLGraph(DarkKnightDealTL, max(DarkKnightDealData$Time)/1000, "DarkKnight", F)
TLGraph(DarkKnightDealTL, max(DarkKnightDealData$Time)/1000, "DarkKnight", T)
DealIrr(DarkKnightDealTL, max(DarkKnightDealData$Time)/1000)

## ArchMageFP
ArchMageFPDealTL <- DealTimeLine(ArchMageFPDealCycle2$Time, ArchMageFPDamage2)
TLGraph(ArchMageFPDealTL, max(ArchMageFPDealCycle2$Time)/1000, "ArchMageFP", F)
TLGraph(ArchMageFPDealTL, max(ArchMageFPDealCycle2$Time)/1000, "ArchMageFP", T)
DealIrr(ArchMageFPDealTL, max(ArchMageFPDealCycle2$Time)/1000)

## ArchMageTC
ArchMageTCDealTL <- DealTimeLine(ArchMageTCDealCycle2$Time, ArchMageTCDamage2)
TLGraph(ArchMageTCDealTL, max(ArchMageTCDealCycle2$Time)/1000, "ArchMageIL", F)
TLGraph(ArchMageTCDealTL, max(ArchMageTCDealCycle2$Time)/1000, "ArchMageIL", T)
DealIrr(ArchMageTCDealTL, max(ArchMageTCDealCycle2$Time)/1000)

## Bishop
BishopDealTL <- DealTimeLine(BishopDealCycle2$Time, BishopDamage2)
TLGraph(BishopDealTL, max(BishopDealCycle2$Time)/1000, "Bishop", F)
TLGraph(BishopDealTL, max(BishopDealCycle2$Time)/1000, "Bishop", T)
DealIrr(BishopDealTL, max(BishopDealCycle2$Time)/1000)

## Bowmaster
BowmasterDealTL <- DealTimeLine(BowmasterDealData$Time, BowmasterDealData$Deal)
TLGraph(BowmasterDealTL, max(BowmasterDealData$Time)/1000, "Bowmaster", F)
TLGraph(BowmasterDealTL, max(BowmasterDealData$Time)/1000, "Bowmaster", T)
DealIrr(BowmasterDealTL, max(BowmasterDealData$Time)/1000)

## Marksman
MarksmanDealTL <- DealTimeLine(MarksmanDealCycle$Time, MarksmanFinalDPMwithMax)
TLGraph(MarksmanDealTL, max(MarksmanDealCycle$Time)/1000, "Marksman", F)
TLGraph(MarksmanDealTL, max(MarksmanDealCycle$Time)/1000, "Marksman", T)
DealIrr(MarksmanDealTL, max(MarksmanDealCycle$Time)/1000)

## PathFinder
PathFinderDealTL <- DealTimeLine(PathFinderDealData$Time, PathFinderDealData$Deal)
TLGraph(PathFinderDealTL, max(PathFinderDealData$Time)/1000, "PathFinder", F)
TLGraph(PathFinderDealTL, max(PathFinderDealData$Time)/1000, "PathFinder", T)
DealIrr(PathFinderDealTL, max(PathFinderDealData$Time)/1000)

## NightLord
NightLordDealTL <- DealTimeLine(NightLordDealData$Time, NightLordDealData$Deal)
TLGraph(NightLordDealTL, max(NightLordDealData$Time)/1000, "NightLord", F)
TLGraph(NightLordDealTL, max(NightLordDealData$Time)/1000, "NightLord", T)
DealIrr(NightLordDealTL, max(NightLordDealData$Time)/1000)

## DualBlade
DualBladeDealTL <- DealTimeLine(DualBladeDealData$Time, DualBladeDealData$Deal)
TLGraph(DualBladeDealTL, max(DualBladeDealData$Time)/1000, "DualBlade", F)
TLGraph(DualBladeDealTL, max(DualBladeDealData$Time)/1000, "DualBlade", T)
DealIrr(DualBladeDealTL, max(DualBladeDealData$Time)/1000)

## CannonShooter
CannonShooterDealTL <- DealTimeLine(CannonShooterDealData$Time, CannonShooterDealData$Deal)
TLGraph(CannonShooterDealTL, max(CannonShooterDealData$Time)/1000, "CannonShooter", F)
TLGraph(CannonShooterDealTL, max(CannonShooterDealData$Time)/1000, "CannonShooter", T)
DealIrr(CannonShooterDealTL, max(CannonShooterDealData$Time)/1000)

## Viper
ViperDealTL <- DealTimeLine(ViperDealData$Time, ViperDealData$Deal)
TLGraph(ViperDealTL, max(ViperDealData$Time)/1000, "Viper", F)
TLGraph(ViperDealTL, max(ViperDealData$Time)/1000, "Viper", T)
DealIrr(ViperDealTL, max(ViperDealData$Time)/1000)

## Mikhail
MikhailDealTL <- DealTimeLine(MikhailDealData$Time, MikhailDealData$Deal)
TLGraph(MikhailDealTL, max(MikhailDealData$Time)/1000, "Mikhail", F)
TLGraph(MikhailDealTL, max(MikhailDealData$Time)/1000, "Mikhail", T)
DealIrr(MikhailDealTL, max(MikhailDealData$Time)/1000)

## SoulMaster
SoulMasterDealTL <- DealTimeLine(SoulMasterDealData$Time, SoulMasterDealData$Deal)
TLGraph(SoulMasterDealTL, max(SoulMasterDealData$Time)/1000, "SoulMaster", F)
TLGraph(SoulMasterDealTL, max(SoulMasterDealData$Time)/1000, "SoulMaster", T)
DealIrr(SoulMasterDealTL, max(SoulMasterDealData$Time)/1000)

## FlameWizard
FlameWizardDealTL <- DealTimeLine(FlameWizardDealData$Time, FlameWizardDealData$Deal)
TLGraph(FlameWizardDealTL, max(FlameWizardDealData$Time)/1000, "FlameWizard", F)
TLGraph(FlameWizardDealTL, max(FlameWizardDealData$Time)/1000, "FlameWizard", T)
DealIrr(FlameWizardDealTL, max(FlameWizardDealData$Time)/1000)

## WindBreaker
WindBreakerDealTL <- DealTimeLine(WindBreakerDealData$Time, WindBreakerDealData$Deal)
TLGraph(WindBreakerDealTL, max(WindBreakerDealData$Time)/1000, "WindBreaker", F)
TLGraph(WindBreakerDealTL, max(WindBreakerDealData$Time)/1000, "WindBreaker", T)
DealIrr(WindBreakerDealTL, max(WindBreakerDealData$Time)/1000)

## NightWalker
NightWalkerDealTL <- DealTimeLine(NightWalkerDealData$Time, NightWalkerDealData$Deal)
TLGraph(NightWalkerDealTL, max(NightWalkerDealData$Time)/1000, "NightWalker", F)
TLGraph(NightWalkerDealTL, max(NightWalkerDealData$Time)/1000, "NightWalker", T)
DealIrr(NightWalkerDealTL, max(NightWalkerDealData$Time)/1000)

## Striker
StrikerDealTL <- DealTimeLine(StrikerDealData$Time, StrikerDealData$Deal)
TLGraph(StrikerDealTL, max(StrikerDealData$Time)/1000, "Striker", F)
TLGraph(StrikerDealTL, max(StrikerDealData$Time)/1000, "Striker", T)
DealIrr(StrikerDealTL, max(StrikerDealData$Time)/1000)

## Aran
AranDealTL <- DealTimeLine(AranDealData$Time, AranDealData$Deal)
TLGraph(AranDealTL, max(AranDealData$Time)/1000, "Aran", F)
TLGraph(AranDealTL, max(AranDealData$Time)/1000, "Aran", T)
DealIrr(AranDealTL, max(AranDealData$Time)/1000)

## Luminous
LuminousDealTL <- DealTimeLine(LuminousDealData$Time, LuminousDealData$Deal)
TLGraph(LuminousDealTL, max(LuminousDealData$Time)/1000, "Luminous", F)
TLGraph(LuminousDealTL, max(LuminousDealData$Time)/1000, "Luminous", T)
DealIrr(LuminousDealTL, max(LuminousDealData$Time)/1000)

## Mercedes
MercedesDealTL <- DealTimeLine(MercedesDealData$Time, MercedesDealData$Deal)
TLGraph(MercedesDealTL, max(MercedesDealData$Time)/1000, "Mercedes", F)
TLGraph(MercedesDealTL, max(MercedesDealData$Time)/1000, "Mercedes", T)
DealIrr(MercedesDealTL, max(MercedesDealData$Time)/1000)

## Phantom
PhantomDealTL <- DealTimeLine(PhantomDealData$Time, PhantomDealData$Deal)
TLGraph(PhantomDealTL, max(PhantomDealData$Time)/1000, "Phantom", F)
TLGraph(PhantomDealTL, max(PhantomDealData$Time)/1000, "Phantom", T)
DealIrr(PhantomDealTL, max(PhantomDealData$Time)/1000)

## Eunwol
EunwolDealTL <- DealTimeLine(EunwolDealDataFixed$Time, EunwolDealDataFixed$Deal)
TLGraph(EunwolDealTL, max(EunwolDealData$Time)/1000, "Eunwol", F)
TLGraph(EunwolDealTL, max(EunwolDealData$Time)/1000, "Eunwol", T)
DealIrr(EunwolDealTL, max(EunwolDealData$Time)/1000)

## DemonSlayer
DemonSlayerDealTL <- DealTimeLine(DemonSlayerDealData$Time, DemonSlayerDealData$Deal)
TLGraph(DemonSlayerDealTL, max(DemonSlayerDealData$Time)/1000, "DemonSlayer", F)
TLGraph(DemonSlayerDealTL, max(DemonSlayerDealData$Time)/1000, "DemonSlayer", T)
DealIrr(DemonSlayerDealTL, max(DemonSlayerDealData$Time)/1000)

## Blaster
BlasterDealTL <- DealTimeLine(BlasterDealData$Time, BlasterDealData$Deal)
TLGraph(BlasterDealTL, max(BlasterDealData$Time)/1000, "Blaster", F)
TLGraph(BlasterDealTL, max(BlasterDealData$Time)/1000, "Blaster", T)
DealIrr(BlasterDealTL, max(BlasterDealData$Time)/1000)

## BattleMage
BattleMageDealTL <- DealTimeLine(BattleMageDealData$Time, BattleMageDealData$Deal)
TLGraph(BattleMageDealTL, max(BattleMageDealData$Time)/1000, "BattleMage", F)
TLGraph(BattleMageDealTL, max(BattleMageDealData$Time)/1000, "BattleMage", T)
DealIrr(BattleMageDealTL, max(BattleMageDealData$Time)/1000)

## WildHunter
WildHunterDealTL <- DealTimeLine(WildHunterDealData$Time, WildHunterDealData$Deal)
TLGraph(WildHunterDealTL, max(WildHunterDealData$Time)/1000, "WildHunter", F)
TLGraph(WildHunterDealTL, max(WildHunterDealData$Time)/1000, "WildHunter", T)
DealIrr(WildHunterDealTL, max(WildHunterDealData$Time)/1000)

## Mechanic
MechanicDealTL <- DealTimeLine(MechanicDealData$Time, MechanicDealData$Deal)
TLGraph(MechanicDealTL, max(MechanicDealData$Time)/1000, "Mechanic", F)
TLGraph(MechanicDealTL, max(MechanicDealData$Time)/1000, "Mechanic", T)
DealIrr(MechanicDealTL, max(MechanicDealData$Time)/1000)

## Kaiser
KaiserDealTL <- DealTimeLine(KaiserDealData$Time, KaiserDealData$Deal)
TLGraph(KaiserDealTL, max(KaiserDealData$Time)/1000, "Kaiser", F)
TLGraph(KaiserDealTL, max(KaiserDealData$Time)/1000, "Kaiser", T)
DealIrr(KaiserDealTL, max(KaiserDealData$Time)/1000)

## AngelicBuster
AngelicBusterDealTL <- DealTimeLine(ABDealData2$Time, ABDealData2$Deal)
TLGraph(AngelicBusterDealTL, max(ABDealData2$Time)/1000, "AngelicBuster", F)
TLGraph(AngelicBusterDealTL, max(ABDealData2$Time)/1000, "AngelicBuster", T)
DealIrr(AngelicBusterDealTL, max(ABDealData2$Time)/1000)

## Illium
IlliumDealTL <- DealTimeLine(IlliumDealData$Time, IlliumDealData$Deal)
TLGraph(IlliumDealTL, max(IlliumDealData$Time)/1000, "Illium", F)
TLGraph(IlliumDealTL, max(IlliumDealData$Time)/1000, "Illium", T)
DealIrr(IlliumDealTL, max(IlliumDealData$Time)/1000)

## Adele
AdeleDealTL <- DealTimeLine(AdeleDealData$Time, AdeleDealData$Deal)
TLGraph(AdeleDealTL, max(AdeleDealData$Time)/1000, "Adele", F)
TLGraph(AdeleDealTL, max(AdeleDealData$Time)/1000, "Adele", T)
DealIrr(AdeleDealTL, max(AdeleDealData$Time)/1000)

## Ark
ArkDealTL <- DealTimeLine(ArkDealData$Time, ArkDealData$Deal)
TLGraph(ArkDealTL, max(ArkDealData$Time)/1000, "Ark", F)
TLGraph(ArkDealTL, max(ArkDealData$Time)/1000, "Ark", T)
DealIrr(ArkDealTL, max(ArkDealData$Time)/1000)

## Hoyeong
HoyeongDealTL <- DealTimeLine(HoyeongDealData$Time, HoyeongDealData$Deal)
TLGraph(HoyeongDealTL, max(HoyeongDealData$Time)/1000, "Hoyeong", F)
TLGraph(HoyeongDealTL, max(HoyeongDealData$Time)/1000, "Hoyeong", T)
DealIrr(HoyeongDealTL, max(HoyeongDealData$Time)/1000)

## Zero
ZeroDealTL <- DealTimeLine(ZeroDealData$Time, ZeroDealData$Deal)
TLGraph(ZeroDealTL, max(ZeroDealData$Time)/1000, "Zero", F)
TLGraph(ZeroDealTL, max(ZeroDealData$Time)/1000, "Zero", T)
DealIrr(ZeroDealTL, max(ZeroDealData$Time)/1000)





## Toy Job
set.seed(1)
ToyJobDeal <- rnorm(66, 6000, 400)
ToyJobTL <- data.frame(Time=seq(0, 355, 5), 
                       Deal=c(16500, 16000, 15500, ToyJobDeal[1:33], 16500, 16000, 15500, ToyJobDeal[34:66]))
TLGraph(ToyJobTL, 360, "ToyJob", F)
TLGraph(ToyJobTL, 360, "ToyJob", T)
sum(ToyJobTL$Deal)/6

## Toy Job
set.seed(1)
ToyJobDeal <- rnorm(66, 6000, 400)
ToyJobTL <- data.frame(Time=seq(0, 355, 5), 
                       Deal=c(10500, 10000, 9500, ToyJobDeal[1:33], 10500, 10000, 9500, ToyJobDeal[34:66]))
TLGraph(ToyJobTL, 360, "ToyJob", F)
TLGraph(ToyJobTL, 360, "ToyJob", T)
sum(ToyJobTL$Deal)/6



