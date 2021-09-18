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