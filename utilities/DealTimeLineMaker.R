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
TLGraph <- function(DealTL, DealTime, JobName, Cumulative=F, MaxDeal=30000, CumDealDivider=50000) {
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
    barplot(DealTL$CumDeal, names.arg=DealTL$Time, space=0, ylim=c(0, ceiling(max(DealTL$CumDeal)/CumDealDivider)*CumDealDivider),
            cex.axis=1, cex.names=0.7, las=2, border="gray60", col="skyblue", 
            main=paste(JobName, "Deal Time Line(Cumulative)"))
    abline(h=(CumDealDivider/2) * 1:100, col="gray80")
    curve(x * AVGDeal, 0, nrow(DealTL), col="gray40", lwd=3, add=T, 
          xlim=c(0, nrow(DealTL)))
  } else {
    barplot(DealTL$Deal, names.arg=DealTL$Time, ylim=c(0, MaxDeal),
            cex.axis=1, cex.names=0.7, las=2, border=NA, col="skyblue", 
            main=paste(JobName, "Deal Time Line(Non-cumulative)"))
    abline(h=ifelse(MaxDeal < 50000, 2500, 5000) * 1:100, col="gray80")
    abline(h=AVGDeal, col="gray40", lwd=3)
  }
}
DealIrr <- function(DealTL, DealTime) {
  AVGDeal <- sum(DealTL$Deal) / DealTime * 5
  DealTL <- DealTL[1:(nrow(DealTL)-1), ]
  Irr <- sum(abs(DealTL$Deal - AVGDeal) / AVGDeal) / length(DealTL$Deal)
  return(Irr)
}
RRGraph <- function(RestraintTL, JobName, VertLineTime=c(10, 13, 14), col="Skyblue", ylim=c(0, 80000), add=F, reverse=F, BishopRRDeal=32198) {
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
    for(i in 0:100) {
      abline(h=i*10000, col="Gray80")
    }
    abline(h=BishopRRDeal, col="Gray80", lwd=3)
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

## Deal Graph
HeroDealTL <- DealTimeLine(HeroDealData$Time, HeroDealData$Deal)
PalladinDealTL <- DealTimeLine(PalladinDealData$Time, PalladinDealData$Deal)
DarkKnightDealTL <- DealTimeLine(DarkKnightDealData$Time, DarkKnightDealData$Deal)
ArchMageFPDealTL <- DealTimeLine(ArchMageFPDealCycle2$Time, ArchMageFPDealData2)
ArchMageTCDealTL <- DealTimeLine(ArchMageTCDealCycle3$Time, ArchMageTCDealData3)
BishopDealTL <- DealTimeLine(BishopDealCycle3$Time, BishopDealData3)
BowmasterDealTL <- DealTimeLine(BowmasterDealData$Time, BowmasterDealData$Deal)
MarksmanDealTL <- DealTimeLine(MarksmanDealData$Time, MarksmanDealData$Deal)
PathFinderDealTL <- DealTimeLine(PathFinderDealData$Time, PathFinderDealData$Deal)
NightLordDealTL <- DealTimeLine(NightLordDealData$Time, NightLordDealData$Deal)
ShadowerDealTL <- DealTimeLine(ShadowerDealData$Time, ShadowerDealData$Deal)
DualBladerDealTL <- DealTimeLine(DualBladeDealData$Time, DualBladeDealData$Deal)
CaptainDealTL <- DealTimeLine(CaptainDealData$Time, CaptainDealData$Deal)
CannonMasterDealTL <- DealTimeLine(CannonShooterDealData$Time, CannonShooterDealData$Deal)
ViperDealTL <- DealTimeLine(ViperDealData$Time, ViperDealData$Deal)
MikhailDealTL <- DealTimeLine(MikhailDealData$Time, MikhailDealData$Deal)
SoulMasterDealTL <- DealTimeLine(SoulMasterDealData$Time, SoulMasterDealData$Deal)
FlameWizardDealTL <- DealTimeLine(FlameWizardDealData$Time, FlameWizardDealData$Deal)
WindBreakerDealTL <- DealTimeLine(WindBreakerDealData$Time, WindBreakerDealData$Deal)
NightWalkerDealTL <- DealTimeLine(NightWalkerDealData$Time, NightWalkerDealData$Deal)
StrikerDealTL <- DealTimeLine(StrikerDealData$Time, StrikerDealData$Deal)
AranDealTL <- DealTimeLine(AranDealData$Time, AranDealData$Deal)
EvanDealTL <- DealTimeLine(EvanDealData$Time, EvanDealData$Deal)
LuminousDealTL <- DealTimeLine(LuminousDealData$Time, LuminousDealData$Deal)
MercedesDealTL <- DealTimeLine(MercedesDealData$Time, MercedesDealData$Deal)
PhantomDealTL <- DealTimeLine(PhantomDealData$Time, PhantomDealData$Deal)
EunwolDealTL <- DealTimeLine(EunwolDealData$Time, EunwolDealData$Deal)
DemonSlayerDealTL <- DealTimeLine(DemonSlayerDealData$Time, DemonSlayerDealData$Deal)
DemonAvengerDealTL <- DealTimeLine(DemonAvengerDealData$Time, DemonAvengerDealData$Deal)
BlasterDealTL <- DealTimeLine(BlasterDealData$Time, BlasterDealData$Deal)
BattleMageDealTL <- DealTimeLine(BattleMageDealData$Time, BattleMageDealData$Deal)
WildHunterDealTL <- DealTimeLine(WildHunterDealData$Time, WildHunterDealData$Deal)
MechanicDealTL <- DealTimeLine(MechanicDealData$Time, MechanicDealData$Deal)
KaiserDealTL <- DealTimeLine(KaiserDealData$Time, KaiserDealData$Deal)
KainDealTL <- DealTimeLine(KainDealData$Time, KainDealData$Deal)
CadenaDealTL <- DealTimeLine(CadenaDealData$Time, CadenaDealData$Deal)
AngelicBusterDealTL <- DealTimeLine(AngelicBusterDealData$Time, AngelicBusterDealData$Deal)
IlliumDealTL <- DealTimeLine(IlliumDealData$Time, IlliumDealData$Deal)
AdeleDealTL <- DealTimeLine(AdeleDealData$Time, AdeleDealData$Deal)
ArkDealTL <- DealTimeLine(ArkDealData$Time, ArkDealData$Deal)
LaraDealTL <- DealTimeLine(LaraDealData$Time, LaraDealData$Deal)
HoyeongDealTL <- DealTimeLine(HoyeongDealData$Time, HoyeongDealData$Deal)
ZeroDealTL <- DealTimeLine(ZeroDealData$Time, ZeroDealData$Deal)
XenonDealTL <- DealTimeLine(XenonDealData$Time, XenonDealData$Deal)
KinesisDealTL <- DealTimeLine(KinesisDealData$Time, KinesisDealData$Deal)


DealGraphSave <- function(JobName, DealTL, GetTimeData, Modifier, MaxDeal=30000, CumDealDivider=50000, width=1024, height=576) {
  png(filename=paste("jobdata/", JobName, "/", JobName, "DealTL", Modifier, ".png", sep=""), width=width, height=height)
  TLGraph(DealTL, max(GetTimeData$Time)/1000, JobName, F, MaxDeal=MaxDeal)
  dev.off()
  
  png(filename=paste("jobdata/", JobName, "/", JobName, "DealTL_C", Modifier, ".png", sep=""), width=width, height=height)
  TLGraph(DealTL, max(GetTimeData$Time)/1000, JobName, T, CumDealDivider=CumDealDivider)
  dev.off()
}
RRGraphSave <- function(JobName, DealData, Modifier, MaxDeal=80000, width=1024, height=768, reverse=F, BishopRRDeal=32198) {
  png(filename=paste("jobdata/", JobName, "/", JobName, "RestraintTL", Modifier, ".png", sep=""), width=width, height=height)
  RRDealData <- DealData_RR(DealData)
  RRGraph(RRDealData, JobName, ylim=c(0, MaxDeal), add=F, reverse=reverse, BishopRRDeal=BishopRRDeal)
  dev.off()
}

Modifier <- CSVExportOption$Modifier
MaxDeal <- 80000 ; CumDealDivider <- 100000
for(i in 1:nrow(ChrInfo)) {
  DealGraphSave(JobName=ChrInfo$job[i], 
                DealTL=get(paste(ChrInfo$job[i], "DealTL", sep="")), 
                GetTimeData=get(ifelse(sum(ChrInfo$job[i]==c("ArchMageFP"))==1, paste(ChrInfo$job[i], "DealCycle2", sep=""),
                                       ifelse(sum(ChrInfo$job[i]==c("ArchMageTC", "Bishop"))==1, paste(ChrInfo$job[i], "DealCycle3", sep=""), 
                                       ifelse(ChrInfo$job[i]=="CannonMaster", "CannonShooterDealData", 
                                              ifelse(ChrInfo$job[i]=="DualBlader", "DualBladeDealData", 
                                                     paste(ChrInfo$job[i], "DealData", sep="")))))), 
                Modifier=Modifier, 
                MaxDeal=MaxDeal, 
                CumDealDivider=CumDealDivider)
}

MaxDeal <- 220000 ; BishopRRDeal <- 126008
for(i in 1:nrow(ChrInfo)) {
  RRGraphSave(JobName=ChrInfo$job[i], 
              DealData=get(ifelse(ChrInfo$job[i]=="CannonMaster", "CannonShooterDealData", 
                                  ifelse(ChrInfo$job[i]=="DualBlader", "DualBladeDealData", 
                                         paste(ChrInfo$job[i], "DealData", sep="")))), 
              Modifier=Modifier, 
              MaxDeal=MaxDeal, 
              reverse=ifelse(sum(ChrInfo$job[i]==c("SoulMaster", "ArchMageFP", "ArchMageTC", "Bishop", "FlameWizard", "Striker"))==1, T, F), 
              BishopRRDeal=BishopRRDeal)
}