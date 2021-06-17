## ArchmageFP Functions
FuryofIfritCycle <- function(DealCycle, ATKSkillList) {
  DealCycle <- RepATKCycle(DealCycle, c("FuryofIfrit"), 25, 1560, ATKSkillList)
  
  DC1 <- subset(DealCycle, DealCycle$Skills=="FuryofIfritStart")
  FOIStartTime <- DC1$Time
  
  except <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Ifrit") {
      for(j in 1:length(FOIStartTime)) {
        if(DealCycle$Time[i]>=FOIStartTime[j] & DealCycle$Time[i]<=(FOIStartTime[j] + 6000)) {
          except <- c(except, i)
        }
      }
    }
  }
  
  DealCycle <- DealCycle[-1 * except, ]
  return(DealCycle)
}
PoisonChainCycle <- function(DealCycle, ATKSkillList) {
  DealCycle <- RepATKCycle(DealCycle, c("PoisonChain1"), 9, 0, ATKSkillList)
  p <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PoisonChain1") {
      if(p==1) {
        p <- p + 1
      } else if(p==2) {
        DealCycle$Skills[i] <- "PoisonChain2"
        p <- p + 1
      } else if(p==3) {
        DealCycle$Skills[i] <- "PoisonChain3"
        p <- p + 1
      } else if(p==4) {
        DealCycle$Skills[i] <- "PoisonChain4"
        p <- p + 1
      } else if(p==5) {
        DealCycle$Skills[i] <- "PoisonChain5"
        p <- p + 1
      } else {
        DealCycle$Skills[i] <- "PoisonChainMax"
        p <- ifelse(p==9, 1, p + 1)
      }
    }
  }
  return(DealCycle)
}
FPUnstableCycle <- function(DealCycle, ATKSkillsList) {
  UnsSkills <- rownames(ATKSkillsList)[1:10]
  DC <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1)
    DC1[2:11, 1] <- UnsSkills
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
FPAddATKCycle <- function(DealCycle, ATKSkillList) {
  DC1 <- subset(DealCycle, DealCycle$Skills=="PoisonNovaStart")
  Ind <- as.numeric(rownames(DC1))
  Ind <- c(Ind, nrow(DealCycle))
  TimeInd <- DC1$Time
  
  for(i in 1:(length(Ind)-1)) {
    k <- 0
    p <- Ind[i]
    while(k==0 & p < Ind[i+1]) {
      if(DealCycle$Skills[p]=="MistEruption" & DealCycle$Time[p] - TimeInd[i] >= (2000 - Delay(930, 2))) {
        DealCycle <- rbind(DealCycle, DealCycle[p, ])
        DealCycle <- rbind(DealCycle, DealCycle[p, ])
        DealCycle$Skills[nrow(DealCycle)-1] <- c("PoisonNova123")
        DealCycle$Skills[nrow(DealCycle)] <- c("PoisonNovaRemain")
        k <- 1
      }
      p <- p + 1
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]==c("DotPunisher1st")) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("DotPunisherRemain")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgniteDotPunisher")
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Paralyze", "MistEruption", "FlameHaze", "MegiddoFlame", "PoisonNovaStart"))==1 & DealCycle$MeteorBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MeteorFinalAttack")
    } else if(DealCycle$Skills[i]==c("PoisonNova123") & DealCycle$MeteorBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MeteorFinalAttackPoisonNova")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgnitePoisonNova")
    } else if(DealCycle$Skills[i]==c("DotPunisher1st") & DealCycle$MeteorBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MeteorFinalAttackDotPunisher")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgniteDotPunisherFinalAttack")
    } else if(DealCycle$Skills[i]==c("UnstableMemorizePre") & DealCycle$MeteorBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MeteorFinalAttackUnstable")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgniteUnstableFinalAttack")
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Paralyze", "Meteor", "FlameHaize", "MegiddoFlame", "Ifrit", "FuryofIfrit"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("Ignite")
    } else if(DealCycle$Skills[i]==c("MeteorFinalAttack")) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgniteMeteorFinalAttack")
    } else if(DealCycle$Skills[i]==c("UnstableMemorizePre")) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("IgniteUnstable")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle <- RepATKCycle(DealCycle, "Ignite", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgniteUnstable", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgniteDotPunisher", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgniteDotPunisherFinalAttack", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgnitePoisonNova", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgniteUnstableFinalAttack", 3, 1500, ATKSkillList)
  DealCycle <- RepATKCycle(DealCycle, "IgniteMeteorFinalAttack", 3, 1500, ATKSkillList)
  return(DealCycle)
} ## PoisonNovaExplosion, DotPunisherRemain, MeteorFinalATK, Ignite