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


## Hero
HeroDealTL <- DealTimeLine(HeroDealData$Time, HeroDealData$Deal)
TLGraph(HeroDealTL, max(HeroDealData$Time)/1000, "Hero", F)
TLGraph(HeroDealTL, max(HeroDealData$Time)/1000, "Hero", T)
DealIrr(HeroDealTL, max(HeroDealData$Time)/1000)

## Palladin
PalladinDealTL <- DealTimeLine(PalladinDealData$Time, PalladinDealData$Deal)
TLGraph(PalladinDealTL, max(PalladinDealData$Time)/1000, "Palladin", F)
TLGraph(PalladinDealTL, max(PalladinDealData$Time)/1000, "Palladin", T)
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
TLGraph(ArchMageTCDealTL, max(ArchMageTCDealCycle2$Time)/1000, "ArchMageTC", F)
TLGraph(ArchMageTCDealTL, max(ArchMageTCDealCycle2$Time)/1000, "ArchMageTC", T)
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

abs(NightLordDealTL$Deal - (DPM12344$NightLord[1]/12000000000))^2

## DualBlade
DualBladeDealTL <- DealTimeLine(DualBladeDealData$Time, DualBladeDealData$Deal)
TLGraph(DualBladeDealTL, max(DualBladeDealData$Time)/1000, "DualBlade", F)
TLGraph(DualBladeDealTL, max(DualBladeDealData$Time)/1000, "DualBlade", T)
DealIrr(DualBladeDealTL, max(DualBladeDealData$Time)/1000)

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

## BattleMage
BattleMageDealTL <- DealTimeLine(BattleMageDealData$Time, BattleMageDealData$Deal)
TLGraph(BattleMageDealTL, max(BattleMageDealData$Time)/1000, "BattleMage", F)
TLGraph(BattleMageDealTL, max(BattleMageDealData$Time)/1000, "BattleMage", T)
DealIrr(BattleMageDealTL, max(BattleMageDealData$Time)/1000)

## Mechanic
MechanicDealTL <- DealTimeLine(MechanicDealData$Time, MechanicDealData$Deal)
TLGraph(MechanicDealTL, max(MechanicDealData$Time)/1000, "Mechanic", F)
TLGraph(MechanicDealTL, max(MechanicDealData$Time)/1000, "Mechanic", T)
DealIrr(MechanicDealTL, max(MechanicDealData$Time)/1000)

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