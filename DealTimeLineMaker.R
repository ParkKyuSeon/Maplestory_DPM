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

AdeleDealTL <- DealTimeLine(AdeleDealData$Time, AdeleDealData$Deal)
barplot(AdeleDealTL$Deal/100000000, names.arg=AdeleDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Adele Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

ArchmageFPDealTL <- DealTimeLine(ArchmageFPDealCycle2$Time, ArchmageFPDamage2)
barplot(ArchmageFPDealTL$Deal/100000000, names.arg=ArchmageFPDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Archmage FP Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

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

IlliumDealTL <- DealTimeLine(IlliumDealData$Time, IlliumDealData$Deal)
barplot(IlliumDealTL$Deal/100000000, names.arg=IlliumDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Illium Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

MarksmanDealTL <- DealTimeLine(MarksmanDealCycle$Time, MarksmanFinalDPMwithMax)
barplot(MarksmanDealTL$Deal/100000000, names.arg=MarksmanDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Marksman Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

MechanicDealTL <- DealTimeLine(MechanicDealData$Time, MechanicDealData$Deal)
barplot(MechanicDealTL$Deal/100000000, names.arg=MechanicDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Mechanic Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

MikhailDealTL <- DealTimeLine(MikhailDealData$Time, MikhailDealData$Deal)
barplot(MikhailDealTL$Deal/100000000, names.arg=MikhailDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Mikhail Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

PalladinDealTL <- DealTimeLine(PalladinDealData$Time, PalladinDealData$Deal)
barplot(PalladinDealTL$Deal/100000000, names.arg=PalladinDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="Palladin Deal Time Line")
abline(h=2500 * 1:12, col="gray60")

WindBreakerDealTL <- DealTimeLine(WindBreakerDealData$Time, WindBreakerDealData$Deal)
barplot(WindBreakerDealTL$Deal/100000000, names.arg=WindBreakerDealTL$Time, ylim=c(0, 30000),
        cex.axis=1, cex.names=0.7, las=2, main="WindBreaker Deal Time Line")
abline(h=2500 * 1:12, col="gray60")