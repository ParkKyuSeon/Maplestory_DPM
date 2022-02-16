## DPM csv File
FinalData <- get(DPMCalcOption$DataName)
FinalData <- data.frame(t(FinalData))
FinalData <- round(FinalData)
colnames(FinalData)[4] <- "X40s"

if(CSVExportOption$OrderBy == "JobName") {
  FinalData <- FinalData[order(rownames(FinalData)), ]
} else if(CSVExportOption$OrderBy == "DPM") {
  FinalData <- FinalData[order(FinalData$DPM, decreasing=T), ]
} else if(CSVExportOption$OrderBy == "Restraint") {
  FinalData <- FinalData[order(FinalData$Restraint, decreasing=T), ]
} else if(CSVExportOption$OrderBy == "40s") {
  FinalData <- FinalData[order(FinalData$X40s, decreasing=T), ]
}

if(CSVExportOption$RatioStandard=="Bishop") {
  StandardDPM <- FinalData[rownames(FinalData)=="Bishop", ]$DPM
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- FinalData[rownames(FinalData)=="Bishop", ]$Restraint
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- FinalData[rownames(FinalData)=="Bishop", ]$X40s
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
} else if(CSVExportOption$RatioStandard=="Maximum") {
  StandardDPM <- max(FinalData$DPM)
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- max(FinalData$Restraint)
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- max(FinalData$X40s)
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
} else if(CSVExportOption$RatioStandard=="Minimum") {
  StandardDPM <- min(FinalData$DPM)
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- min(FinalData$Restraint)
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- min(FinalData$X40s)
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
}
FinalData$DPMRatio <- round(FinalData$DPMRatio, 4)
FinalData$RestraintRatio <- round(FinalData$RestraintRatio, 4)
FinalData$X40sRatio <- round(FinalData$X40sRatio, 4)

FinalData <- FinalData[, c(1, 5, 3, 6, 4, 7, 2)]
colnames(FinalData)[5:6] <- c("40s", "40sRatio")

if(CSVExportOption$Leakage == F) {
  FinalData <- FinalData[, -7]
}

write.csv(FinalData, paste(CSVExportOption$FileName, ".csv", sep=""))



## Spec Mean Data
SpecMeanData <- get(paste(ChrInfo$job[1], "SpecMean", sep=""))
for(i in 2:length(ChrInfo$job)) {
  if(sum(ChrInfo$job[i] == c("DualBlader")) >= 1) {
    SpecMeanData <- rbind(SpecMeanData, get(paste("DualBlade", "SpecMean", sep="")))
  } else if(sum(ChrInfo$job[i] == c("CannonMaster")) >= 1) {
    SpecMeanData <- rbind(SpecMeanData, get(paste("CannonShooter", "SpecMean", sep="")))
  } else {
    SpecMeanData <- rbind(SpecMeanData, get(paste(ChrInfo$job[i], "SpecMean", sep="")))
  }
}
rownames(SpecMeanData) <- ChrInfo$job
Modifier <- "_L"
write.csv(SpecMeanData, paste("SpecMeanData", Modifier, ".csv", sep=""))