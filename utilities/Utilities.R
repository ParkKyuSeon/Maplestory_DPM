DamperATK <- function(DealData, ATKSkillData, SummonedSkillData, MAX=T, Min=F, SkillName=c()) {
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
  
  if(MAX==T & length(SkillName)==0) {
    return(DealData[DealData$DamperATKeach==max(DealData$DamperATKeach), ][1, ])
  } else if(Min==T & length(SkillName)==0) {
    return(DealData[DealData$DamperATKeach==min(DealData$DamperATKeach), ][1, ])
  } else if(MAX==T) {
    DealData <- subset(DealData, DealData$Skills==SkillName)
    return(DealData[DealData$DamperATKeach==max(DealData$DamperATKeach), ][1, ])
  } else if(Min==T) {
    DealData <- subset(DealData, DealData$Skills==SkillName)
    return(DealData[DealData$DamperATKeach==min(DealData$DamperATKeach), ][1, ])
  } else {
    DealData <- subset(DealData, DealData$Skills==SkillName)
    DealData <- DealData[order(DealData$DamperATKeach), ]
    DealData <- DealData[, colnames(DealData)!="Time"]
    DealData <- DealData[, colnames(DealData)!="R4"]
    return(unique(DealData))
  }
}

DealPeak <- function(DealData) {
  Deal1slist <- c()
  Deal5slist <- c()
  Deal10slist <- c()
  for(i in 2:nrow(DealData)) {
    Deal1s <- DealData[DealData$Time >= DealData$Time[i] & DealData$Time < DealData$Time[i] + 1000, ]
    Deal5s <- DealData[DealData$Time >= DealData$Time[i] & DealData$Time < DealData$Time[i] + 5000, ]
    Deal10s <- DealData[DealData$Time >= DealData$Time[i] & DealData$Time < DealData$Time[i] + 10000, ]
    Deal1slist <- c(Deal1slist, sum(Deal1s$Deal, na.rm=T))
    Deal5slist <- c(Deal5slist, sum(Deal5s$Deal, na.rm=T))
    Deal10slist <- c(Deal10slist, sum(Deal10s$Deal, na.rm=T))
  }
  return(data.frame(max1sdeal=max(Deal1slist), max5sdeal=max(Deal5slist), max10sdeal=max(Deal10slist)))
}

GuardianSlime <- function(DealData) {
  DealData$SlimeDeal <- 0
  if(nrow(DealData[DealData$Skills == "Restraint4", ]) == 1) {
    RRTime <- DealData[DealData$Skills == "Restraint4", ]$Time
    for(i in 2:nrow(DealData)) {
      if(DealData$R4[i] > 0) {
        DealData$SlimeDeal[i] <- DealData$Deal[i] * 1.1 / 1.5  ## Groggy Time, Divide By 1.5 : ArcaneForce FDR Not Applied
      } else if(DealData$R4[i] == 0 & DealData$Time[i] < RRTime + 160000 & DealData$Time[i] > RRTime) {
        DealData$SlimeDeal[i] <- DealData$Deal[i] * 0.7 / 1.5  ## Normal Time
      } else {
        DealData$SlimeDeal[i] <- 0  ## Pattern Time
      }
    }
  } else {
    ## Time Adjustment for Pattern (SubTime : 190s)
    RRTime <- DealData[DealData$Skills == "Restraint4", ]$Time
    RRTime <- c(RRTime, max(DealData$Time) + RRTime[1])
    
    LineNumbers <- as.numeric(rownames(DealData[DealData$Skills == "Restraint4", ]))
    LineNumbers <- c(LineNumbers, nrow(DealData))
    
    RRDiff <- diff(RRTime)
    AddedTime <- c()
    for(i in 1:length(RRDiff)) {
      if(RRDiff[i] < 190000) {
        AddedTime[i] <- 190000 - RRDiff[i]
      } else {
        AddedTime[i] <- 0
      }
    }
    
    for(i in length(AddedTime):2) {
      AddedTime[i] <- sum(AddedTime[1:i])
    }
    
    for(i in 1:(length(AddedTime)-1)) {
      DealData$Time[LineNumbers[i+1] : (LineNumbers[i+2]-1)] <- DealData$Time[LineNumbers[i+1] : (LineNumbers[i+2]-1)] + AddedTime[i]
    }
    DealData$Time[nrow(DealData)] <- DealData$Time[nrow(DealData)] + AddedTime[length(AddedTime)]
    
    RRTime <- DealData[DealData$Skills == "Restraint4", ]$Time
    for(i in 2:nrow(DealData)) {
      if(DealData$R4[i] > 0) {
        DealData$SlimeDeal[i] <- DealData$Deal[i] * 1.1 / 1.5  ## Groggy Time, Divide By 1.5 : ArcaneForce FDR Not Applied
      } else {
        ind <- 0
        for(j in 1:length(RRTime)) {
          if(DealData$R4[i] == 0 & DealData$Time[i] < RRTime[j] + 160000 & DealData$Time[i] > RRTime[j]) {
            DealData$SlimeDeal[i] <- DealData$Deal[i] * 0.7 / 1.5  ## Normal Time
            ind <- 1
          } 
        }
        if(ind == 0) { 
          DealData$SlimeDeal[i] <- 0  ## Pattern Time
        }
      }
    }
  }
  return(sum(DealData$SlimeDeal) / max(DealData$Time) * 60000)
}

RRDealData <- function(DealData, CycleTime=NA) {
  RR <- subset(DealData, DealData$R4 > 0)
  rownames(RR) <- 1:nrow(RR)
  Idx <- as.numeric(rownames(subset(RR, RR$Skills=="Restraint4")))
  RRDeal <- c()
  if(length(Idx)==1) {
    RRDeal <- sum(RR$Deal)
  } else {
    for(i in 1:(length(Idx)-1)) {
      RRDeal <- c(RRDeal, sum(RR[Idx[i]:(Idx[i+1]-1), ]$Deal))
    }
    RRDeal <- c(RRDeal, sum(RR[Idx[(length(Idx))]:nrow(RR), ]$Deal))
  }
  
  RRSubTime <- round(ifelse(is.na(CycleTime)==T, max(DealData$Time) / length(Idx), CycleTime / length(Idx)) / 1000, 2)
  RRDealAvg <- mean(RRDeal)
  RRDealPerMin <- sum(RRDeal) / (ifelse(is.na(CycleTime)==T, max(DealData$Time), CycleTime) / 60000)
  return(list(RRDealList = RRDeal, 
              RRSubTime = RRSubTime, 
              RRDealAvg = RRDealAvg, 
              RRDealPerMin = RRDealPerMin))
}

InfinityData <- function(UnstableCycles, BuffFinal) {
  FDRMean <- c()
  for(i in 1:nrow(UnstableCycles)) {
    DealWithoutUns <- get(UnstableCycles$DealDatas[i]) / ((100 + get(UnstableCycles$CycleNames[i])$InfinityFDR) / 100)
    FDRMean <- c(FDRMean, (sum(get(UnstableCycles$DealDatas[i])) / sum(DealWithoutUns) - 1) * 100)
  }
  
  WeightedTime <- sum(UnstableCycles$CycleTimes * UnstableCycles$Prob)
  Weight <- UnstableCycles$CycleTimes * UnstableCycles$Prob / WeightedTime
  
  FDRMean <- sum(FDRMean * Weight)
  
  InfinityTimeRatio <- BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 1000 * 6 / UnstableCycles$CycleTimes
  InfinityTimeRatio <- sum(InfinityTimeRatio * Weight)
  return(data.frame(FDRMean=FDRMean, 
                    InfinityTimeRatio=InfinityTimeRatio))
}

GetSkillsList <- function(JobNames, MaxSkillsCount) {
  SkillList <- rep(NA, MaxSkillsCount)
  JobNames[JobNames=="DualBlader"] <- "DualBlade"
  JobNames[JobNames=="CannonMaster"] <- "CannonShooter"
  for(i in 1:length(JobNames)) {
    
  }
}