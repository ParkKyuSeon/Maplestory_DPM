## Marksman Functions
ChargedArrowCycle <- function(PreDealCycle, BetweenSkills, AutoCharge, ATKSkillList) {
  s <- function(PreDealCycle, BetweenSkills, AutoCharge, ATKSkillList) {
    if(PreDealCycle[nrow(PreDealCycle), 1]=="Dummy") {
      PreDealCycle[nrow(PreDealCycle), 1] <- c("ChargedArrowStart")
      DealCycle <- PreDealCycle
      ind <- 1
      DealCycle[1, 2] <- DealCycle[1, 2] - (DealCycle[nrow(DealCycle), 2] - DealCycle[nrow(DealCycle)-1, 2])
      for(i in 3:ncol(DealCycle)) {
        DealCycle[1, i] <- DealCycle[1, 2]
      }
    } else {
      a <- rep(0, ncol(PreDealCycle))
      a <- data.frame(t(a))
      colnames(a) <- colnames(PreDealCycle)
      a[1, 1] <- c("ChargedArrowStart")
      for(i in 2:ncol(PreDealCycle)) {
        a[1, i] <- PreDealCycle[nrow(PreDealCycle), i]
      }
      DealCycle <- rbind(PreDealCycle, a)
      DealCycle[nrow(DealCycle), 2] <- DealCycle[nrow(DealCycle), 2] + DealCycle[1, 2]
      DealCycle[1, 2] <- 0
      for(i in 3:ncol(DealCycle)) {
        DealCycle[nrow(DealCycle), i] <- max(DealCycle[nrow(DealCycle), i] - DealCycle[1, i], 0)
        DealCycle[1, i] <- 0
      }
      ind <- 2
    }
    DC1 <- DealCycle[1, ]
    DC2 <- DealCycle[-1, ]
    DC2 <- DC2[order(DC2$Time), ]
    DealCycle <- rbind(DC1, DC2)
    
    ChargedTime <- 0
    b <- 1
    while(ChargedTime<=5000&b<=length(BetweenSkills)) {
      DealCycle <- DCATK(DealCycle, BetweenSkills[b], ATKSkillList)
      b <- b + 1
      ChargedTime <- DealCycle[nrow(DealCycle), 2] - ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2])
    }
    
    if(ChargedTime>5000) {
      DealCycle[nrow(DealCycle), 2] <- ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2]) + 5000
      for(i in 3:ncol(DealCycle)) {
        DealCycle[nrow(DealCycle), i] <- max(ifelse(ind==1, DealCycle[nrow(PreDealCycle), i], DealCycle[nrow(PreDealCycle) + 1, i]) - 5000, 0)
      }
      ChargedTime <- 5000
    }
    
    if(nrow(DealCycle) - nrow(PreDealCycle) - 1 < length(BetweenSkills)) {
      k <- ifelse(AutoCharge==F, 9500, 10000)
      t <- nrow(DealCycle) - nrow(PreDealCycle)
      while(ChargedTime<=k&t<=length(BetweenSkills)) {
        DealCycle <- DCATK(DealCycle, BetweenSkills[t], ATKSkillList)
        t <- t + 1
        ChargedTime <- DealCycle[nrow(DealCycle), 2] - ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2]) + DealCycle[1, 2]
      }
    }
    
    if(AutoCharge==F | AutoCharge==T&ChargedTime<=10000) {
      ChargedTime <- DealCycle[nrow(DealCycle), 2] - ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2]) + DealCycle[1, 2] - ATKSkillList$Delay[4]
      PreSkillDelay <- DealCycle[1, 2]
      DealCycle <- DCATK(DealCycle, ifelse(ChargedTime < 5000, c("ChargedArrowUncharged"), c("ChargedArrow")), ATKSkillList)
      for(i in 3:ncol(DealCycle)) {
        DealCycle[nrow(DealCycle), i] <- max(DealCycle[nrow(DealCycle)-1, i] - PreSkillDelay + ATKSkillList$Delay[4], 0)
      }
      DealCycle[nrow(DealCycle), 2] <- DealCycle[nrow(DealCycle)-1, 2] + PreSkillDelay - ATKSkillList$Delay[4]
    } else {
      DealCycle <- DCATK(DealCycle, c("ChargedArrow"), ATKSkillList)
      DealCycle[nrow(DealCycle), 2] <- ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2]) + 10000
      for(i in 3:ncol(DealCycle)) {
        DealCycle[nrow(DealCycle), i] <- max(ifelse(ind==1, DealCycle[nrow(PreDealCycle), i], DealCycle[nrow(PreDealCycle) + 1, i]) - 10000, 0)
      }
    }
    
    if(nrow(DealCycle) - nrow(PreDealCycle) - 2 < length(BetweenSkills)) {
      k <- ifelse(AutoCharge==F, 9500, 11000)
      t <- nrow(DealCycle) - nrow(PreDealCycle) - 1
      while(ChargedTime<=k&t<=length(BetweenSkills)) {
        DealCycle <- DCATK(DealCycle, BetweenSkills[t], ATKSkillList)
        ChargedTime <- DealCycle[nrow(DealCycle), 2] - ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2], DealCycle[nrow(PreDealCycle) + 1, 2]) + DealCycle[1, 2]
        t <- t + 1
      }
    }
    
    k <- ifelse(AutoCharge==F, 9500, 11000)
    if((ChargedTime + DealCycle[1, 2])>=k) {
      a <- rep(0, ncol(PreDealCycle))
      a <- data.frame(t(a))
      colnames(a) <- colnames(PreDealCycle)
      a[1, 1] <- c("Dummy")
      a[1, 2] <- ifelse(AutoCharge==F, DealCycle[nrow(DealCycle), 2], ifelse(ind==1, DealCycle[nrow(PreDealCycle), 2] + 11000, DealCycle[nrow(PreDealCycle) + 1, 2] + 11000))
      for(i in 3:ncol(PreDealCycle)) {
        a[1, i] <- ifelse(AutoCharge==F, DealCycle[nrow(DealCycle), i], max(ifelse(ind==1, DealCycle[nrow(PreDealCycle), i] - 11000, DealCycle[nrow(PreDealCycle) + 1, i] - 11000), 0))
      }
      DealCycle <- rbind(DealCycle, a)
    }
    return(DealCycle)
  }
  DealCycle <- s(PreDealCycle, BetweenSkills, AutoCharge, ATKSkillList)
  DC1 <- DealCycle[1, ]
  DC2 <- DealCycle[-1, ]
  DC2 <- DC2[order(DC2$Time), ]
  DealCycle <- rbind(DC1, DC2)
  return(DealCycle)
}
AddATKsCycle <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Snipe" & DealCycle$SplitArrowBuff[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
    } else if (DealCycle$Skills[i]=="FullbustShot" & DealCycle$SplitArrowBuff[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
    }
    if(DealCycle$Skills[i]=="FullbustShot" | DealCycle$Skills[i]=="Snipe") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("FinalAttack")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
EvolveCycle <- function(DealCycleWithEvolve) {
  SkillInd <- DealCycleWithEvolve[, 1] == "EvolveSummoned"
  
  Evolves <- DealCycleWithEvolve[SkillInd, ]
  maxtime <- max(DealCycleWithEvolve[, 2])
  
  for(i in 1:nrow(Evolves)) {
    DC <- Evolves[i, ]
    DC <- rbind(DC, DC)
    DC[2, 1] <- c("Freezer")
    DC[2, 2] <- DC[1, 2] + 43030
    
    p <- 3
    t <- 40000 + 3030 * 2
    interval <- ifelse(is.na(Evolves[i+1, 2])==T, maxtime - Evolves[i, 2], Evolves[i+1, 2] - Evolves[i, 2])
    while(t < interval & t < 282000) {
      DC <- rbind(DC, DC[p-1, ])
      DC[p, 2] <- DC[p-1, 2] + 3030
      p <- p + 1
      t <- t + 3030
    }
    DealCycleWithEvolve <- rbind(DealCycleWithEvolve, DC[2:nrow(DC), ])
  }
  DealCycleWithEvolve <- DealCycleWithEvolve[order(DealCycleWithEvolve$Time), ] 
  rownames(DealCycleWithEvolve) <- 1:nrow(DealCycleWithEvolve)
  
  for(i in 1:nrow(DealCycleWithEvolve)) {
    if("Freezer"==DealCycleWithEvolve[i, 1]) {
      DealCycleWithEvolve[i, 3:ncol(DealCycleWithEvolve)] <- DealCycleWithEvolve[i-1, 3:ncol(DealCycleWithEvolve)] - (DealCycleWithEvolve[i, 2] - DealCycleWithEvolve[i-1, 2])
      DealCycleWithEvolve[i, 3:ncol(DealCycleWithEvolve)] <- ifelse(DealCycleWithEvolve[i, 3:ncol(DealCycleWithEvolve)]<0, 0, DealCycleWithEvolve[i, 3:ncol(DealCycleWithEvolve)])
    }
  }
  return(DealCycleWithEvolve)
} ## Freezer Duration Logic Needed
MarksmanSynergy <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$CriticalReinforce[i] > 0 & DealCycle$Bullseye[i] > 0) {
      DealCycle$Synergy[i] <- DealCycle$Bullseye[i]
    }
  }
  return(DealCycle)
}
MarksmanDistance <- function(MarksmanDealCycle) {
  for(i in 1:nrow(MarksmanDealCycle)) {
    ## MotalBlow
    if(max(MarksmanDealCycle$Skills[i]==c("Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "TrueSnipe", "FullbustShot", "GuidedArrow", "SpiderInMirror"))==1) {
      MarksmanDealCycle$MotalBlow[i] <- 1
    }
    ## DistancingSense
    if(max(MarksmanDealCycle$Skills[i]==c("Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "TrueSnipe", "FullBustShot", "SpiderInMirror", "FinalAttack"))==1) {
      MarksmanDealCycle$DistancingSense[i] <- 1
    }
    ## Distance 0
    if(max(MarksmanDealCycle$Skills[i]==c("SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "Evolve", "Freezer"))==1) {
      MarksmanDealCycle$Distance0[i] <- 1
    }
    ## LastmanStanding
    if(max(MarksmanDealCycle$Skills[i]==c("Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "TrueSnipe", "FullbustShot", "FinalAttack", "SpiderInMirror"))==1) {
      MarksmanDealCycle$LastmanStanding[i] <- 1
    }
    ## WeaknessFinding
    if(max(MarksmanDealCycle$Skills[i]==c("SpiderInMirror", "Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "FullbustShot", "FinalAttack"))==1) {
      MarksmanDealCycle$WeaknessFinding[i] <- 1
    }
  }
  return(MarksmanDealCycle)
}