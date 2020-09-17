## NightLord Functions
SecretBookCycle <- function(DealCycle, SummonedSkillList) {
  Skills <- c("SecretBook")
  Summons <- rownames(SummonedSkillList)
  
  k <- c()
  for(i in 1:length(Skills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(Skills[i]==Summons[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  SkillInd <- DealCycle[1, 1] == paste(Skills, "Summoned", sep="")
  
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- rbind(SkillInd, DealCycle[i, 1] == paste(Skills, "Summoned", sep=""))
  }
  
  maxtime <- max(DealCycle$Time)
  DealCycleNew <- DealCycle
  colnames(SkillInd) <- Skills
  rownames(SkillInd) <- 1:nrow(SkillInd)
  for(i in 1:ncol(SkillInd)) {
    DC <- DealCycle[SkillInd[, i], ]
    for(j in 1:nrow(DC)) {
      DC1 <- rbind(DC[j, ], DC[j, ])
      DC1[2, 1] <- Skills[i]
      DC1[2, 2] <- DC1[2, 2] + SummonedSkillList$SubTime[k[i]] * 2
      
      p <- 1
      t <- SummonedSkillList$SubTime[k[i]] * 3
      while(t <= SummonedSkillList$Duration[k[i]]*1000& t <= ifelse(is.na(DC[j+1, 2])==F, DC[j+1, 2]-DC[j, 2], Inf)) {
        DC1 <- rbind(DC1, DC1[1, ])
        DC1[p+2, 1] <- Skills[i]
        DC1[p+2, 2] <- DC1[p+1, 2] + SummonedSkillList$SubTime[k[i]]
        t <- t + SummonedSkillList$SubTime[k[i]]
        p <- p + 1
      }
      DC1 <- rbind(DC1, DC1[1, ])
      DC1[nrow(DC1), 1] <- c("SecretBookExplosion")
      DC1[nrow(DC1), 2] <- DC1[1, 2] + 12000
      
      DC1 <- subset(DC1, DC1$Time<=maxtime)
      if(nrow(DC1)>1) {
        DealCycleNew <- rbind(DealCycleNew, DC1[2:nrow(DC1), ])
      }
    }
  }
  DealCycleNew <- DealCycleNew[order(DealCycleNew$Time), ] 
  rownames(DealCycleNew) <- 1:nrow(DealCycleNew)
  
  for(i in 1:nrow(DealCycleNew)) {
    if(sum(Skills==DealCycleNew[i, 1])>=1 | DealCycleNew[i, 1]=="SecretBookExplosion") {
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- DealCycleNew[i-1, 3:ncol(DealCycleNew)] - (DealCycleNew[i, 2] - DealCycleNew[i-1, 2])
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- ifelse(DealCycleNew[i, 3:ncol(DealCycleNew)]<0, 0, DealCycleNew[i, 3:ncol(DealCycleNew)])
    }
  }
  return(DealCycleNew)
}
ThrowBlastingCycle <- function(DealCycle) {
  TB <- subset(DealCycle, DealCycle$Skills=="ThrowBlastingBuff")
  Ind <- rownames(TB)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    t1 <- 45
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i]
    
    while(t1 > 0 & p < Ind[i+1]) {
      if(DealCycle$Skills[p]=="QuadrapleThrow") {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ThrowBlasting")
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ThrowBlasting")
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ThrowBlasting")
        t1 <- t1 - 3
      }
      p <- p + 1 
    }
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1]) {
      if(time>10000 & DealCycle$Skills[p]=="QuadrapleThrow") {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ThrowBlasting")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AddATKRateSkills <- function(AddATKSKillName, BuffSkills, AttackSkills, AddATKAppliedSkills) {
  AddATKRateSkill <- BuffSkills[rownames(BuffSkills)==AddATKSKillName, ]
  AddATKRate <- AddATKRateSkill$AddATKRate
  
  for(i in 1:length(AddATKAppliedSkills)) {
    AttackSkills <- rbind(AttackSkills, AttackSkills[AddATKAppliedSkills[i]==rownames(AttackSkills), ])
    rownames(AttackSkills)[nrow(AttackSkills)] <- paste(AddATKAppliedSkills[i], "Add", sep="")
    AttackSkills$Damage[nrow(AttackSkills)] <- AttackSkills$Damage[nrow(AttackSkills)] * 0.7
  }
  return(AttackSkills)
}
AddATKsCycleNightLord <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="QuadrapleThrow" & DealCycle$SpreadThrow[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("QuadrapleThrowSpread")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="QuadrapleThrow") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MarkofNightLord")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("QuadrapleThrowAdd")
    } else if(DealCycle$Skills[i]=="QuadrapleThrowSpread") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MarkofNightLordSpread")
    } else if(DealCycle$Skills[i]=="SuddenRaid") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MarkofNightLord")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SuddenRaidAdd")
    } else if(DealCycle$Skills[i]=="ThrowingKnife") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MarkofNightLord")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ThrowingKnifeAdd")
    } else if(DealCycle$Skills[i]=="ThrowBlasting") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MarkofNightLord")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ThrowBlastingAdd")
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}