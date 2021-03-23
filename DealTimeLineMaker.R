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
  DealTL <- data.frame(Times[1:length(Times)-1]/1000, DealTL)
  colnames(DealTL) <- c("Time", "Deal")
  return(DealTL)
}

NightLordDealTL <- DealTimeLine(NightLordDealData$Time, NightLordDealData$Deal)
barplot(NightLordDealTL$Deal/100000000, names.arg=NightLordDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="NightLord Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$NightLord[1]/1200000000, col="skyblue", lwd=3)
sum(abs(NightLordDealTL$Deal/100000000 - DPM12344$NightLord[1]/1200000000) / (DPM12344$NightLord[1]/1200000000)) / length(NightLordDealTL$Deal)

AdeleDealTL <- DealTimeLine(AdeleDealData$Time, AdeleDealData$Deal)
barplot(AdeleDealTL$Deal/100000000, names.arg=AdeleDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Adele Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$Adele[1]/1200000000, col="skyblue", lwd=3)
sum(abs(AdeleDealTL$Deal/100000000 - DPM12344$Adele[1]/1200000000) / (DPM12344$Adele[1]/1200000000)) / length(AdeleDealTL$Deal)

ArchmageFPDealTL <- DealTimeLine(ArchmageFPDealCycle2$Time, ArchmageFPDamage2)
barplot(ArchmageFPDealTL$Deal/100000000, names.arg=ArchmageFPDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Archmage FP Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$ArchMageFP[1]/1200000000, col="skyblue", lwd=3)

BishopDealTL <- DealTimeLine(BishopDealCycle2$Time, BishopDamage2)
barplot(BishopDealTL$Deal/100000000, names.arg=BishopDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Bishop Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

DualBladeDealTL <- DealTimeLine(DualBladeDealData$Time, DualBladeDealData$Deal)
barplot(DualBladeDealTL$Deal/100000000, names.arg=DualBladeDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="DualBlade Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

HeroDealTL <- DealTimeLine(HeroDealData$Time, HeroDealData$Deal)
barplot(HeroDealTL$Deal/100000000, names.arg=HeroDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Hero Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(HeroDealTL$Deal/100000000 - DPM12344$Hero[1]/1200000000) / (DPM12344$Hero[1]/1200000000)) / length(HeroDealTL$Deal)

IlliumDealTL <- DealTimeLine(IlliumDealData$Time, IlliumDealData$Deal)
barplot(IlliumDealTL$Deal/100000000, names.arg=IlliumDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Illium Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$Illium[1]/1200000000, col="skyblue", lwd=3)
sum(abs(IlliumDealTL$Deal/100000000 - DPM12344$Illium[1]/1200000000) / (DPM12344$Illium[1]/1200000000)) / length(IlliumDealTL$Deal)

MarksmanDealTL <- DealTimeLine(MarksmanDealCycle$Time, MarksmanFinalDPMwithMax)
barplot(MarksmanDealTL$Deal/100000000, names.arg=MarksmanDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Marksman Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(MarksmanDealTL$Deal/100000000 - DPM12344$Marksman[1]/1200000000) / (DPM12344$Marksman[1]/1200000000)) / length(MarksmanDealTL$Deal)

MechanicDealTL <- DealTimeLine(MechanicDealData$Time, MechanicDealData$Deal)
barplot(MechanicDealTL$Deal/100000000, names.arg=MechanicDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Mechanic Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

MikhailDealTL <- DealTimeLine(MikhailDealData$Time, MikhailDealData$Deal)
barplot(MikhailDealTL$Deal/100000000, names.arg=MikhailDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Mikhail Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(MikhailDealTL$Deal/100000000 - DPM12344$Mikhail[1]/1200000000) / (DPM12344$Mikhail[1]/1200000000)) / length(MikhailDealTL$Deal)

PalladinDealTL <- DealTimeLine(PalladinDealData$Time, PalladinDealData$Deal)
barplot(PalladinDealTL$Deal/100000000, names.arg=PalladinDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Palladin Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(PalladinDealTL$Deal/100000000 - DPM12344$Palladin[1]/1200000000) / (DPM12344$Palladin[1]/1200000000)) / length(PalladinDealTL$Deal)

WindBreakerDealTL <- DealTimeLine(WindBreakerDealData$Time, WindBreakerDealData$Deal)
barplot(WindBreakerDealTL$Deal/100000000, names.arg=WindBreakerDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="WindBreaker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$WindBreaker[1]/1200000000, col="skyblue", lwd=3)
sum(abs(WindBreakerDealTL$Deal/100000000 - DPM12344$WindBreaker[1]/1200000000) / (DPM12344$WindBreaker[1]/1200000000)) / length(WindBreakerDealTL$Deal)

MercedesDealTL <- DealTimeLine(MercedesDealData$Time, MercedesDealData$Deal)
barplot(MercedesDealTL$Deal/100000000, names.arg=MercedesDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Mercedes Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(MercedesDealTL$Deal/100000000 - DPM12344$Mercedes[1]/1200000000) / (DPM12344$Mercedes[1]/1200000000)) / length(MercedesDealTL$Deal)

BowmasterDealTL <- DealTimeLine(BowmasterDealData$Time, BowmasterDealData$Deal)
barplot(BowmasterDealTL$Deal/100000000, names.arg=BowmasterDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Bowmaster Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(BowmasterDealTL$Deal/100000000 - DPM12344$Bowmaster[1]/1200000000) / (DPM12344$Bowmaster[1]/1200000000)) / length(BowmasterDealTL$Deal)

AranDealTL <- DealTimeLine(AranDealData$Time, AranDealData$Deal)
barplot(AranDealTL$Deal/100000000, names.arg=AranDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Aran Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(AranDealTL$Deal/100000000 - DPM12344$Aran[1]/1200000000) / (DPM12344$Aran[1]/1200000000)) / length(AranDealTL$Deal)

SoulMasterDealTL <- DealTimeLine(SoulMasterDealData$Time, SoulMasterDealData$Deal)
barplot(SoulMasterDealTL$Deal/100000000, names.arg=SoulMasterDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, border=NA, col="skyblue", main="SoulMaster Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$SoulMaster[1]/1200000000, col="Black", lwd=3)
sum(abs(SoulMasterDealTL$Deal/100000000 - DPM12344$SoulMaster[1]/1200000000) / (DPM12344$SoulMaster[1]/1200000000)) / length(SoulMasterDealTL$Deal)

FlameWizardDealTL <- DealTimeLine(FlameWizardDealData$Time, FlameWizardDealData$Deal)
barplot(FlameWizardDealTL$Deal/100000000, names.arg=FlameWizardDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="FlameWizard Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(FlameWizardDealTL$Deal/100000000 - DPM12344$FlameWizard[1]/1200000000) / (DPM12344$FlameWizard[1]/1200000000)) / length(FlameWizardDealTL$Deal)

StrikerDealTL <- DealTimeLine(StrikerDealData$Time, StrikerDealData$Deal)
barplot(StrikerDealTL$Deal/100000000, names.arg=StrikerDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Striker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(StrikerDealTL$Deal/100000000 - DPM12344$Striker[1]/1200000000) / (DPM12344$Striker[1]/1200000000)) / length(StrikerDealTL$Deal)

BattleMageDealTL <- DealTimeLine(BattleMageDealData$Time, BattleMageDealData$Deal)
barplot(BattleMageDealTL$Deal/100000000, names.arg=BattleMageDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="BattleMage Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(BattleMageDealTL$Deal/100000000 - DPM12344$BattleMage[1]/1200000000) / (DPM12344$BattleMage[1]/1200000000)) / length(BattleMageDealTL$Deal)

NightWalkerDealTL <- DealTimeLine(NightWalkerDealData$Time, NightWalkerDealData$Deal)
barplot(NightWalkerDealTL$Deal/100000000, names.arg=NightWalkerDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="NightWalker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(NightWalkerDealTL$Deal/100000000 - DPM12344$NightWalker[1]/1200000000) / (DPM12344$NightWalker[1]/1200000000)) / length(NightWalkerDealTL$Deal)

NightWalkerDealTL80 <- DealTimeLine(NightWalkerDealData80$Time, NightWalkerDealData80$Deal)
barplot(NightWalkerDealTL80$Deal/100000000, names.arg=NightWalkerDealTL80$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="NightWalker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

NightWalkerDealTL0 <- DealTimeLine(NightWalkerDealData0$Time, NightWalkerDealData0$Deal)
barplot(NightWalkerDealTL0$Deal/100000000, names.arg=NightWalkerDealTL0$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="NightWalker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

ArchMageTCDealTL <- DealTimeLine(ArchMageTCDealCycle2$Time, ArchMageTCDamage2)
barplot(ArchMageTCDealTL$Deal/100000000, names.arg=ArchMageTCDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="ArchMageTC Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

PathFinderDealTL <- DealTimeLine(PathFinderDealCycle$Time, PathFinderDealData$Deal)
barplot(PathFinderDealTL$Deal/100000000, names.arg=PathFinderDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="PathFinder Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(PathFinderDealTL$Deal/100000000 - DPM12344$PathFinder[1]/1200000000) / (DPM12344$PathFinder[1]/1200000000)) / length(PathFinderDealTL$Deal)

LuminousDealTL <- DealTimeLine(LuminousDealCycle$Time, LuminousDealData$Deal)
barplot(LuminousDealTL$Deal/100000000, names.arg=LuminousDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Luminous Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
sum(abs(LuminousDealTL$Deal/100000000 - DPM12344$Luminous[1]/1200000000) / (DPM12344$Luminous[1]/1200000000)) / length(LuminousDealTL$Deal)

DarkKnightDealTL <- DealTimeLine(DarkKnightDealData$Time, DarkKnightDealData$Deal)
barplot(DarkKnightDealTL$Deal/100000000, names.arg=DarkKnightDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, border=NA, col="skyblue", main="DarkKnight Deal Time Line")
abline(h=2500 * 1:12, col="gray60")
abline(h=DPM12344$DarkKnight[1]/1200000000, col="black", lwd=3)
sum(abs(DarkKnightDealTL$Deal/100000000 - DPM12344$DarkKnight[1]/1200000000) / (DPM12344$DarkKnight[1]/1200000000)) / length(DarkKnightDealTL$Deal)

