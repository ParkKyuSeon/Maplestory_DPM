## Hero Functions
HeroCombo <- function(DealCycle) {
  Combo <- rep(0, nrow(DealCycle))
  ComboFDR <- rep(0, nrow(DealCycle))
  ComboBDR <- rep(0, nrow(DealCycle))
  ComboATK <- rep(0, nrow(DealCycle))
  NewDealCycle <- cbind(DealCycle, Combo, ComboFDR, ComboBDR, ComboATK)
  colnames(NewDealCycle) <- c(colnames(DealCycle), "Combo", "ComboFDR", "ComboBDR", "ComboATK")
  ComboCharge <- 0.8 + (0.8 + 0.02 * HeroSpec$SkillLv) * 0.8
  ComboChargeInstinct <- 0.4 + (0.8 + 0.02 * HeroSpec$SkillLv) * 0.4
  FDRPerCombo <- 12 + ifelse(HeroSpec$SkillLv>0, 1, 0)
  BDRPerCombo <- 2
  ATKPerCombo <- 2
  
  NewDealCycle$Combo[1] <- 10
  NewDealCycle$ComboFDR[1] <- FDRPerCombo * 10
  NewDealCycle$ComboBDR[1] <- BDRPerCombo * 10
  NewDealCycle$ComboATK[1] <- ATKPerCombo * 10
  for(i in 2:nrow(NewDealCycle)) {
    if(NewDealCycle$Skills[i]=="ComboDeathfault") {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$Combo[i] * FDRPerCombo + ifelse(NewDealCycle$ComboDeathfaultBuff[i]>0 & NewDealCycle$Skill[i]!="ComboDeathfault", 6 * FDRPerCombo, 0)
      NewDealCycle$ComboFDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$ComboFDR[i] * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), NewDealCycle$ComboFDR[i])
      NewDealCycle$ComboBDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * BDRPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * BDRPerCombo)
      NewDealCycle$ComboATK[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * ATKPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * ATKPerCombo)
      NewDealCycle$Combo[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, min((NewDealCycle$Combo[i] + ComboChargeInstinct), 10), min((NewDealCycle$Combo[i] + ComboCharge), 10))
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i] - 6
    } else if(NewDealCycle$Skills[i]=="Panic") {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$Combo[i] * FDRPerCombo + ifelse(NewDealCycle$ComboDeathfaultBuff[i]>0 & NewDealCycle$Skill[i]!="ComboDeathfault", 6 * FDRPerCombo, 0)
      NewDealCycle$ComboFDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$ComboFDR[i] * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), NewDealCycle$ComboFDR[i])
      NewDealCycle$ComboBDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * BDRPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * BDRPerCombo)
      NewDealCycle$ComboATK[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * ATKPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * ATKPerCombo)
      NewDealCycle$Combo[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, min((NewDealCycle$Combo[i] + ComboChargeInstinct), 10), min((NewDealCycle$Combo[i] + ComboCharge), 10))
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i] - 2
    } else if(NewDealCycle$Skills[i]=="Incising") {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$Combo[i] * FDRPerCombo + ifelse(NewDealCycle$ComboDeathfaultBuff[i]>0 & NewDealCycle$Skill[i]!="ComboDeathfault", 6 * FDRPerCombo, 0)
      NewDealCycle$ComboFDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$ComboFDR[i] * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), NewDealCycle$ComboFDR[i])
      NewDealCycle$ComboBDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * BDRPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * BDRPerCombo)
      NewDealCycle$ComboATK[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * ATKPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * ATKPerCombo)
      NewDealCycle$Combo[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, min((NewDealCycle$Combo[i] + ComboChargeInstinct), 10), min((NewDealCycle$Combo[i] + ComboCharge), 10))
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i] - 1
    } else if(NewDealCycle$Skills[i]=="RagingBlow" | NewDealCycle$Skills[i]=="RageUprising" | NewDealCycle$Skills[i]=="SwordIllusion" | NewDealCycle$Skills[i]=="SwordIllusionExplosion") {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$Combo[i] * FDRPerCombo + ifelse(NewDealCycle$ComboDeathfaultBuff[i]>0 & NewDealCycle$Skill[i]!="ComboDeathfault", 6 * FDRPerCombo, 0)
      NewDealCycle$ComboFDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$ComboFDR[i] * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), NewDealCycle$ComboFDR[i])
      NewDealCycle$ComboBDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * BDRPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * BDRPerCombo)
      NewDealCycle$ComboATK[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * ATKPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * ATKPerCombo)
      NewDealCycle$Combo[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, min((NewDealCycle$Combo[i] + ComboChargeInstinct), 10), min((NewDealCycle$Combo[i] + ComboCharge), 10))
    } else if(NewDealCycle$Skills[i]=="AdvancedFinalAttack" | NewDealCycle$Skills[i]=="AuraWeapon" | NewDealCycle$Skills[i]=="ScarofSpace") {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$ComboFDR[i-1]
      NewDealCycle$ComboBDR[i] <- NewDealCycle$ComboBDR[i-1]
      NewDealCycle$ComboATK[i] <- NewDealCycle$ComboATK[i-1]
    } else {
      NewDealCycle$Combo[i] <- NewDealCycle$Combo[i-1]
      NewDealCycle$ComboFDR[i] <- NewDealCycle$Combo[i] * FDRPerCombo + ifelse(NewDealCycle$ComboDeathfaultBuff[i]>0 & NewDealCycle$Skill[i]!="ComboDeathfault", 6 * FDRPerCombo, 0)
      NewDealCycle$ComboFDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$ComboFDR[i] * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), NewDealCycle$ComboFDR[i])
      NewDealCycle$ComboBDR[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * BDRPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * BDRPerCombo)
      NewDealCycle$ComboATK[i] <- ifelse(NewDealCycle$ComboInstinct[i]>0, NewDealCycle$Combo[i] * ATKPerCombo * (1 + 0.05 + 0.01 * floor(HeroCore[[2]][3, 2]/2)), 
                                         NewDealCycle$Combo[i] * ATKPerCombo)
    }
  }
  return(NewDealCycle)
}
SwordIllusionCycle <- function(DealCycle, ATKSkillList) {
  DealCycle <- RepATKCycle(DealCycle, c("SwordIllusion"), 13, 1300, ATKSkillList)
  DC1 <- subset(DealCycle, DealCycle$Skills=="SwordIllusion")
  DC2 <- subset(DealCycle, DealCycle$Skills!="SwordIllusion")
  
  t <- floor(nrow(DC1) / 13)
  t <- 1 : t
  t <- 13 * t
  DC1[t, 1] <- "SwordIllusionExplosion"
  
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  DealCycle <- RepATKCycle(DealCycle, c("SwordIllusionExplosion"), 5, 0, ATKSkillList)
  return(DealCycle)
}
AddATKsCycleHero <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Incising" | DealCycle$Skills[i]=="RageUprising" | DealCycle$Skills[i]=="Panic" |
       DealCycle$Skills[i]=="ComboDeathfault" | DealCycle$Skills[i]=="SwordIllusion" | DealCycle$Skills[i]=="SwordIllusionExplosion") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    } else if(DealCycle$Skills[i]=="RagingBlow") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    }
    
    if(DealCycle$Skills[i]=="RagingBlow" & DealCycle$ComboInstinct[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ScarofSpace")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AuraWeaponCycleHero <- function(DealCycle) {
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("RagingBlow", "Panic", "Incising", "RageUprising", "ComboDeathfault", "SwordIllusionStart"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
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

## Palladin Functions
BlessedHammerCycle <- function(DealCycle) {
  SkillInd <- DealCycle[, 1] == "BlessedHammerBigSummoned"
  
  Hammers <- DealCycle[SkillInd, ]
  maxtime <- max(DealCycle[, 2])
  
  for(i in 1:nrow(Hammers)) {
    DC <- Hammers[i, ]
    DC <- rbind(DC, DC)
    DC[2, 1] <- c("BlessedHammerSmall")
    DC[2, 2] <- DC[1, 2] + 33600
    
    p <- 3
    t <- 33000 + 600 * 2
    interval <- ifelse(is.na(Hammers[i+1, 2])==T, maxtime - Hammers[i, 2], Hammers[i+1, 2] - Hammers[i, 2])
    while(t < interval) {
      DC <- rbind(DC, DC[p-1, ])
      DC[p, 2] <- DC[p-1, 2] + 600
      p <- p + 1
      t <- t + 600
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if("BlessedHammerSmall"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  return(DealCycle)
}
AddATKsCyclePalladin <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="LightningCharge" | DealCycle$Skills[i]=="DivineCharge" | DealCycle$Skills[i]=="Blast" | DealCycle$Skills[i]=="Sanctuary" |
       DealCycle$Skills[i]=="GrandCrossSmall" | DealCycle$Skills[i]=="GrandCrossBig" | DealCycle$Skills[i]=="BlessedHammerSmall") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("FinalAttack")
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AuraWeaponCycle <- function(DealCycle) {
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("Blast", "LightningCharge", "DivineCharge", "Sanctuary", "GrandCrossSmall", "GrandCrossBig", "MightyMjolnirStart"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
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
FPDealCycleReduction <- function(DealCycle, RemoveSkill) {
  for(i in 1:length(RemoveSkill)) {
    DealCycle <- DealCycle[DealCycle$Skills!=paste(RemoveSkill[i], "Start", sep=""), ]
    rownames(DealCycle) <- 1:nrow(DealCycle)
  }
  return(DealCycle)
}

## Bishop Functions
LibraCycle <- function(DealCycle) {
  maxtime <- max(DealCycle[, 2])
  Ind1 <- DealCycle[, 1] == "AngelofLibraSummoned"
  Libras <- DealCycle[Ind1, ]
  Libras$Time <- Libras$Time + 30000
  Libras$Skills <- "BahamutSummoned"
  
  DealCycle <- rbind(DealCycle, Libras)
  DealCycle <- subset(DealCycle, DealCycle$Time <= maxtime)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  for(i in 1:nrow(DealCycle)) {
    if("BahamutSummoned"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  SkillInd <- DealCycle[, 1] == "AngelofLibraSummoned" | DealCycle[, 1] == "BahamutSummoned"
  Summons <- DealCycle[SkillInd, ]
  for(i in 1:nrow(Summons)) {
    DC <- Summons[i, ]
    DC <- rbind(DC, DC)
    DC[2, 1] <- ifelse(DC[1, 1]=="AngelofLibraSummoned", "AngelofLibra", "Bahamut")
    DC[2, 2] <- DC[1, 2] + 3030
    
    p <- 3
    t <- 3030 * 2
    interval <- min(ifelse(is.na(Summons[i+1, 2])==T, maxtime - Summons[i, 2], Summons[i+1, 2] - Summons[i, 2]), ifelse(DC[1, 1]=="AngelofLibraSummoned", 30000, 286000))
    while(t < interval) {
      DC <- rbind(DC, DC[p-1, ])
      DC[p, 2] <- DC[p-1, 2] + 3030
      p <- p + 1
      t <- t + 3030
    }
    
    DC <- rbind(DC, DC[2:nrow(DC), ])
    DC[(nrow(DC)/2+1.5):nrow(DC), 1] <- ifelse(DC[1, 1]=="AngelofLibraSummoned", "AngelofLibraDebuff", "BahamutDebuff")
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if("AngelofLibra"==DealCycle[i, 1] | "Bahamut"==DealCycle[i, 1] | "AngelofLibraDebuff"==DealCycle[i, 1] | "BahamutDebuff"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  SkillInd <- DealCycle[, 1] == "AngelofLibraDebuff" | DealCycle[, 1] == "BahamutDebuff"
  Debuffs <- DealCycle[SkillInd, ]
  rowInd <- c(as.numeric(rownames(Debuffs)), nrow(DealCycle))
  for(i in 1:nrow(Debuffs)) {
    k <- 0
    t <- rowInd[i] + 1
    while(k==0 & t < rowInd[i+1]) {
      if(DealCycle$Skills[t]=="AngelRay" | DealCycle$Skills[t]=="PeaceMaker" |  DealCycle$Skills[t]=="UnstableMemorizeEnd" |
         DealCycle$Skills[t]=="PeaceMakerExplosion" | DealCycle$Skills[t]=="DivinePunishment") {
        DealCycle$AngelofLibraDebuff[t] <- ifelse(DealCycle$Skills[rowInd[i]]=="AngelofLibraDebuff", 1, 0)
        DealCycle$BahamutDebuff[t] <- ifelse(DealCycle$Skills[rowInd[i]]=="BahamutDebuff", 1, 0)
        t <- t + 1
        k <- 1
      } else {
        t <- t + 1
      }
    }
  }
  return(DealCycle)
}
PeaceMakerCycle <- function(DealCycle, PeaceMakerHits, ATKSkillsList, PeaceMakerBuffDuration) {
  DealCycle <- RepATKCycle(DealCycle, "PeaceMaker", PeaceMakerHits, 780, ATKSkillsList)
  
  subsets <- DealCycle[DealCycle$Skills=="PeaceMaker", ]
  n <- floor(nrow(subsets) / PeaceMakerHits)
  n <- 1:n * PeaceMakerHits
  for(i in n) {
    DealCycle <- rbind(DealCycle, subsets[i, ], subsets[i, ])
    DealCycle[(nrow(DealCycle)-1), 1] <- "PeaceMakerExplosion"
    DealCycle[nrow(DealCycle), 1] <- "PeaceMakerBuff"
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    DealCycle$PeaceMakerBuff[i] <- ifelse(DealCycle$Skills[i]=="PeaceMakerBuff", PeaceMakerBuffDuration * 1000, max(DealCycle$PeaceMakerBuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0))
  }
  return(DealCycle)
}
BishopInfinity <- function(DealCycle, Interval, StartFDR, ServerLag) {
  DC <- cbind(DealCycle, rep(0, nrow(DealCycle)))
  colnames(DC) <- c(colnames(DealCycle), "InfinityFDR")
  
  infints <- c(seq(max(DealCycle$Infinity) - 1000 * ServerLag, 0, -1 * Interval), 0)
  for(i in 1:length(infints)) {
    infints[i] <- ifelse(infints[i]==0, 0, infints[i] + 1000 * ServerLag)
  }
  infFDRs <- seq(StartFDR, StartFDR + 3 * (length(infints)-1), 3)
  infs <- data.frame(infints, infFDRs)
  
  for(i in 1:nrow(DC)) {
    if(DC$Infinity[i]>0) {
      p <- 1
      while(DC$Infinity[i]<=infs$infints[p]) {
        DC$InfinityFDR[i] <- infs$infFDRs[p]
        p <- p + 1
      }
    }
  }
  return(DC)
}
BishopUnstableCycle <- function(DealCycle, ATKSkillsList) {
  UnsSkills <- rownames(ATKSkillsList)[1:7]
  DC <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  t <- c()
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1)
    DC1[2:8, 1] <- UnsSkills
    DC1$VengenceofAngel <- 0
    DC1$BahamutDebuff[c(2, 8)] <- 0
    DC1$AngelofLibraDebuff[c(2, 8)] <- 0
    t[i] <- ifelse(max(DC1$BahamutDebuff[1], DC1$AngelofLibraDebuff[1])>0, 1, 0)
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DC2 <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  DC2 <- DC2[t[i]==1, ]
  k <- c(as.numeric(rownames(DC2)), nrow(DealCycle))
  if((length(k)-1)>0) {
    for(i in 1:(length(k)-1)) {
      rowInd <- k[i] + 1
      j <- 0
      while(j==0) {
        if(DealCycle$Skills[rowInd]=="AngelRay" | DealCycle$Skills[rowInd]=="DivinePunishment" | DealCycle$Skills[rowInd]=="DivinePunishmentEnd" | 
           DealCycle$Skills[rowInd]=="PeaceMaker" | DealCycle$Skills[rowInd]=="PeaceMakerExplosion") {
          DealCycle <- rbind(DealCycle, DealCycle[rowInd, ])
          DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[rowInd], "AfterUns2", sep="")
          DealCycle$Skills[rowInd] <- paste(DealCycle$Skills[rowInd], "AfterUns1", sep="")
          DealCycle$BahamutDebuff[nrow(DealCycle)] <- DealCycle$BahamutDebuff[k[i]]
          DealCycle$AngelofLibraDebuff[nrow(DealCycle)] <- DealCycle$AngelofLibraDebuff[k[i]]
          rowInd <- rowInd + 1
          j <- 1
        } else if(DealCycle$Skills[rowInd]=="BahamutDebuff" | DealCycle$Skills[rowInd]=="AngelofLibraDebuff") {
          j <- 1
        } else {
          rowInd <- rowInd + 1
        }
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
UnstableData <- function(DealCycle, DealCycle2, UnstableProb, InfinityDuration, InfinityCoolTime) {
  Infs <- DealCycle[DealCycle$Skills=="Infinity", ]
  Uns <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  
  inftime <- Infs$Time
  unstime <- Uns$Time
  
  times <- Uns$Time / 1000 + (DealCycle$Time[nrow(DealCycle)] - Infs$Time[2]) / 1000
  prob <- UnstableProb
  for(i in 2:length(times)) {
    prob[i] <- UnstableProb * (1 - sum(prob[1 : i-1]))
  }
  times[length(times)+1] <- (Infs$Time[2] / 1000) * 0.5 + (DealCycle2$Time[nrow(DealCycle2)] / 1000) * 0.5
  prob[length(prob)+1] <- 1 - sum(prob[1 : length(prob)])
  weight <- times*prob
  weightsum <- sum(weight)
  weight <- weight/weightsum
  inftimes <- c()
  inftimes[1:length(times)-1] <- InfinityDuration * 2
  inftimes[length(times)] <- InfinityDuration
  ratio <- inftimes / times * weight
  unsdata <- data.frame(weight)
  rownames(unsdata) <- c(1:(length(ratio)-1), "Fail")
  
  uns <- list(unsdata, weightsum)
  names(uns) <- c("UnsRatio", "DealCycleTime")
  
  return(uns)
}
InfinityDealCalc <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata, Cores=(detectCores(logical=F)-1), 
                             NotBuffCols=c(), NotBuffColOption=c()) {
  InfinityDeal1 <- DealCalc(DealCycle1, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=F, NotBuffCols, NotBuffColOption)
  InfinityDeal2 <- DealCalc(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=F, NotBuffCols, NotBuffColOption)
  
  Deal1 <- data.frame(DealCycle1$Skills, DealCycle1$Infinity, InfinityDeal1)
  colnames(Deal1) <- c("Skills", "Infinity", "Deal")
  D1 <- Deal1[(Deal1$Skills=="Infinity" | Deal1$Skills=="UnstableMemorizePre"), ]
  Ind <- c(as.numeric(rownames(D1)), nrow(Deal1))
  
  Deals <- c()
  for(i in 1:(length(Ind)-3)) {
    Deals[i] <- (sum(na.omit(Deal1$Deal[1:Ind[i+1]])) + sum(na.omit(Deal1$Deal[Ind[length(Ind)-1]:Ind[length(Ind)]]))) * Unsdata$UnsRatio$weight[i]
  }
  D2 <- Deal1[1:Ind[length(Ind)-1], ]
  DealWithoutUns <- (sum(na.omit(D2$Deal)) + sum(na.omit(InfinityDeal2))) * 0.5 * Unsdata$UnsRatio$weight[length(Unsdata$UnsRatio$weight)]
  DealFinal <- sum(Deals) + DealWithoutUns
  return(DealFinal)
}
InfinityDealCalcWithMaxDMR <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata, Cores=(detectCores(logical=F)-1), 
                                       NotBuffCols=c(), NotBuffColOption=c()) {
  InfinityDeal1 <- DealCalcWithMaxDMR(DealCycle1, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, NotBuffCols, NotBuffColOption)
  InfinityDeal2 <- DealCalcWithMaxDMR(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, NotBuffCols, NotBuffColOption)
  
  Deal1 <- data.frame(DealCycle1$Skills, DealCycle1$Infinity, InfinityDeal1)
  colnames(Deal1) <- c("Skills", "Infinity", "Deal")
  D1 <- Deal1[(Deal1$Skills=="Infinity" | Deal1$Skills=="UnstableMemorizePre"), ]
  Ind <- c(as.numeric(rownames(D1)), nrow(Deal1))
  
  Deals <- c()
  for(i in 1:(length(Ind)-3)) {
    Deals[i] <- (sum(na.omit(Deal1$Deal[1:Ind[i+1]])) + sum(na.omit(Deal1$Deal[Ind[length(Ind)-1]:Ind[length(Ind)]]))) * Unsdata$UnsRatio$weight[i]
  }
  D2 <- Deal1[1:Ind[length(Ind)-1], ]
  DealWithoutUns <- (sum(na.omit(D2$Deal)) + sum(na.omit(InfinityDeal2))) * 0.5 * Unsdata$UnsRatio$weight[length(Unsdata$UnsRatio$weight)]
  DealFinal <- sum(Deals) + DealWithoutUns
  return(DealFinal)
}
InfinityOptimization1 <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Unsdata, Cores=(detectCores(logical=F)-1), 
                                  NotBuffCols=c(), NotBuffColOption=c()) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata, Cores, NotBuffCols, NotBuffColOption)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata, Cores, NotBuffCols, NotBuffColOption)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
InfinityOptimization2 <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, Unsdata, HyperStanceLv=0, Cores=(detectCores(logical=F)-1), 
                                  NotBuffCols=c(), NotBuffColOption=c()) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  originallvs <- lvs
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    } else {
      NewDeal[7] <- sum(na.omit(InfinityDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Unsdata, Cores, NotBuffCols, NotBuffColOption)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  
  SpecInc <- HyperBase
  SpecInc[1, ] <- 0
  for(i in 1:ncol(SpecInc)) {
    if(lvs[i] - originallvs[i] > 0) {
      if(colnames(SpecInc)[i]=="IGR") {
        BeforeIGR <- sum(HyperStats$IGR[1:(originallvs[i])])
        AfterIGR <- sum(HyperStats$IGR[1:(lvs[i])])
        SpecInc[1, i] <- (1 - (((100 - AfterIGR) / 100) / ((100 - BeforeIGR) / 100))) * 100
      } else {
        SpecInc[1, i] <- sum(HyperStats[, colnames(HyperStats)==colnames(SpecInc)[i]][(originallvs[i]+1):lvs[i]])
      }
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(Specs)
  print(lvs)
  return(SpecInc)
}
InfinityDealRatio <- function(DealCycle1, DealCycle2, DealData1, DealData2, UnsData) {
  Skills <- as.factor(DealCycle1$Skills)
  SkillList <- levels(Skills)
  
  DealRatio1 <- data.frame(DealCycle1$Skills, DealData1)
  colnames(DealRatio1) <- c("Skills", "Damage")
  DealRatio1 <- subset(DealRatio1, is.na(DealRatio1$Damage)==F)
  
  D1 <- DealRatio1[(DealRatio1$Skills=="Infinity" | DealRatio1$Skills=="UnstableMemorizePre"), ]
  Ind <- c(as.numeric(rownames(D1)), nrow(DealRatio1))
  
  DealRatios <- list()
  for(i in 1:(length(Ind)-3)) {
    DealRatios[[i]] <- DealRatio(DealCycle1[c(1:Ind[i+1], Ind[length(Ind)-1]:Ind[length(Ind)]), ], DealData1[c(1:Ind[i+1], Ind[length(Ind)-1]:Ind[length(Ind)])])
  }
  DealRatios[[length(Ind)-2]] <- DealRatio(DealCycle1[1:(Ind[length(Ind)-1]), ], DealData1[1:(Ind[length(Ind)-1])])
  DealRatios[[length(Ind)-1]] <- DealRatio(DealCycle2, DealData2)
  
  Weight <- c()
  Weight[1:(length(DealRatios)-2)] <- UnsData$UnsRatio$weight[1:(length(DealRatios)-2)]
  Weight[(length(DealRatios)-1):(length(DealRatios))] <- UnsData$UnsRatio$weight[(length(DealRatios)-1)] / 2
  
  DealRatioFinal <- data.frame(t(rep(0, length(SkillList))))
  DealRatioFinal <- rbind(DealRatioFinal, DealRatioFinal)
  colnames(DealRatioFinal) <- SkillList
  rownames(DealRatioFinal) <- c("Damage", "Ratio")
  
  for(i in 1:ncol(DealRatioFinal)) {
    for(j in 1:length(DealRatios)) {
      DealRatioFinal[1, i] <- DealRatioFinal[1, i] + ifelse(sum(rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])>0, subset(DealRatios[[j]], rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])[1, 1], 0) *
        Weight[j]
      DealRatioFinal[2, i] <- DealRatioFinal[2, i] + ifelse(sum(rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])>0, subset(DealRatios[[j]], rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])[1, 2], 0) *
        Weight[j]
    }
  }
  DealRatioFinal <- data.frame(t(DealRatioFinal))
  DealRatioFinal <- subset(DealRatioFinal, DealRatioFinal$Ratio>0)
  return(DealRatioFinal)
}

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
    DC[2, 2] <- DC[1, 2] + 41710
    
    p <- 3
    t <- 40000 + 1710 * 2
    interval <- ifelse(is.na(Evolves[i+1, 2])==T, maxtime - Evolves[i, 2], Evolves[i+1, 2] - Evolves[i, 2])
    while(t < interval & t < 282000) {
      DC <- rbind(DC, DC[p-1, ])
      DC[p, 2] <- DC[p-1, 2] + 1710
      p <- p + 1
      t <- t + 1710
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
    if(max(MarksmanDealCycle$Skills[i]==c("Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "FullbustShot", "GuidedArrow", "SpiderInMirror", "FinalAttack"))==1) {
      MarksmanDealCycle$DistancingSense[i] <- 1
    }
    ## Distance 0
    if(max(MarksmanDealCycle$Skills[i]==c("SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "Evolve", "Freezer"))==1) {
      MarksmanDealCycle$Distance0[i] <- 1
    }
    ## Distance 400
    if(max(MarksmanDealCycle$Skills[i]==c("TrueSnipe"))==1) {
      MarksmanDealCycle$DistanceSenseTrueSnipe[i] <- 1
    }
    ## LastmanStanding
    if(max(MarksmanDealCycle$Skills[i]==c("Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "TrueSnipe", "FullbustShot", "FinalAttack", "SpiderInMirror"))==1) {
      MarksmanDealCycle$LastmanStanding[i] <- 1
    }
    ## WeaknessFinding
    if(max(MarksmanDealCycle$Skills[i]==c("SpiderInMirror", "Snipe", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "FullbustShot", "GuidedArrow", "FinalAttack"))==1) {
      MarksmanDealCycle$WeaknessFinding[i] <- 1
    }
  }
  return(MarksmanDealCycle)
}

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
    t1 <- 68
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i]
    
    while(t1 > 0 & p < Ind[i+1]) {
      if(DealCycle$Skills[p]=="QuadrapleThrow") {
        if(t1 >= 3) {
          DC <- rbind(DC, DealCycle[p, ])
          DC[nrow(DC), 1] <- c("ThrowBlasting")
          DC <- rbind(DC, DealCycle[p, ])
          DC[nrow(DC), 1] <- c("ThrowBlasting")
          DC <- rbind(DC, DealCycle[p, ])
          DC[nrow(DC), 1] <- c("ThrowBlasting")
          t1 <- t1 - 3
        } else if(t1 > 0) {
          for(i in 1:t1) {
            DC <- rbind(DC, DealCycle[p, ])
            DC[nrow(DC), 1] <- c("ThrowBlasting")
          }
          t1 <- 0
        }
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
    AttackSkills$Damage[nrow(AttackSkills)] <- AttackSkills$Damage[nrow(AttackSkills)] * (AddATKRate/100)
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

## DualBlade Functions
HuntedEdgeCycle <- function(DealCycle, HuntedEdgeCoolTime) {
  t <- HuntedEdgeCoolTime
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i] == "PhantomBlow" & t >= HuntedEdgeCoolTime) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- "HuntedEdge"
      t <- DealCycle$Time[i+1] - DealCycle$Time[i]
    } else if(t < HuntedEdgeCoolTime) {
      t <- t + DealCycle$Time[i+1] - DealCycle$Time[i]
    } else if(DealCycle$Skills[i] != "PhantomBlow" & t >= HuntedEdgeCoolTime) {
      t <- t + DealCycle$Time[i+1] - DealCycle$Time[i]
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AddATKCycleDualBlade <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PhantomBlow", "FinalCut", "SuddenRaid", "Asura", "BladeStormPre", "BladeStorm", "KarmaFury", "BladeTornadoPre", "BladeTornado", "HuntedEdge"))>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "Add", sep="")
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PhantomBlow", "FinalCut", "SuddenRaid", "Asura", "BladeStormPre", "BladeStorm", "KarmaFuryStart", "BladeTornadoPre", "BladeTornado"))>0 & DealCycle$HiddenBlade[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HiddenBlade")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}

## Mikhail Function
RoyalGuardCycle <- function(DealCycle, ATKSkillList, RoyalGuardCoolTime) {
  RGCool <- RoyalGuardCoolTime * 1000
  RG <- subset(DealCycle, DealCycle$Skills=="RoyalGuard")
  if(nrow(RG)==0) {
    DealCycle[1, 2:ncol(DealCycle)] <- 30
    DealCycle <- DCATK(DealCycle, "RoyalGuard", ATKSkillList)
  } else {
    if(DealCycle$Time[nrow(DealCycle)] - RG$Time[nrow(RG)] >= RGCool) {
      DealCycle[1, 2:ncol(DealCycle)] <- 30
      DealCycle <- DCATK(DealCycle, "RoyalGuard", ATKSkillList)
    } else if(DealCycle$Time[nrow(DealCycle)] - RG$Time[nrow(RG)] + DealCycle$Time[1] >= RGCool) {
      DealCycle[1, 2:ncol(DealCycle)] <- round(RGCool - (DealCycle$Time[nrow(DealCycle)] - RG$Time[nrow(RG)]))
      DealCycle <- DCATK(DealCycle, "RoyalGuard", ATKSkillList)
    } else {warning("Cooltime is not finished yet")}
  }
  return(DealCycle)
}
MikhailBuffLogic <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DeadlyChargeBuff") {
      DealCycle$DeadlyChargeBuff[i] <- 0
    } else if(DealCycle$Skills[i]=="DeadlyCharge") {
      DealCycle$DeadlyChargeBuff[i] <- 0
    }
  }
  return(DealCycle)
}
AWCSCycleMikhail <- function(DealCycle) {
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("SoulAssault", "ShingingCross", "DeadlyCharge", "ClaiomhSolais", "SoulLightSlash"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
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
  
  CS <- subset(DealCycle, DealCycle$Skills=="ClaiomhSolaisCool")
  Ind <- rownames(CS)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$ClaiomhSolaisCool[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("SoulAssault", "ShingingCross", "DeadlyCharge", "LightForceRay", "SoulLightSlash"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ClaiomhSolaisAuto")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    if(nrow(DC) >= 2) {
      DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  return(DealCycle)
}
AddATKCycleMikhail <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SoulAssault", "ShiningCross", "RoyalGuard", "DeadlyCharge", "ClaiomhSolais", "SoulLightSlash"))>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}

## WindBreaker Functions
AddATKsCycleWB <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PinpointPierce", "SongofSky", "HowlingGaleSmall", "HowlingGaleBig", "VortexSphere", "VortexSphereGust", "CygnusPhalanx"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("TriflingWhim")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("TriflingWhimEnhanced")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("StormBringer")
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
BlessofCygnusCycle <- function(DealCycle, Interval, ServerLag, BlessofCygnusLv) {
  DC <- cbind(DealCycle, rep(0, nrow(DealCycle)))
  colnames(DC) <- c(colnames(DealCycle), "BlessofCygnusBDR")
  
  infints <- c(seq(max(DealCycle$BlessofCygnus) - 1000 * ServerLag, 0, -1 * Interval), 0)
  for(i in 1:length(infints)) {
    infints[i] <- ifelse(infints[i]==0, 0, infints[i] + 1000 * ServerLag)
  }
  infBDRs <- seq(BlessofCygnusLv, BlessofCygnusLv + (6 + floor(BlessofCygnusLv/15)) * (length(infints)-1), (6 + floor(BlessofCygnusLv/15)))
  infs <- data.frame(infints, infBDRs)
  
  for(i in 1:nrow(DC)) {
    if(DC$BlessofCygnus[i]>0) {
      p <- 1
      while(DC$BlessofCygnus[i]<=infs$infints[p]) {
        DC$BlessofCygnusBDR[i] <- infs$infBDRs[p]
        p <- p + 1
      }
    }
  }
  return(DC)
}

## Mechanic Functions
OverDriveExhaustBuff <- function(DealCycle, OverDriveDuration, OverDriveCoolTime) {
  OD <- subset(DealCycle, DealCycle$Skills=="OverDrive")
  ExhaustD <- OverDriveCoolTime - OverDriveDuration
  OD$Skills <- c("OverDriveExhaust")
  OD$OverDrive <- 0
  OD$OverDriveExhaust <- ExhaustD * 1000
  OD$Time <- OD$Time + OverDriveDuration * 1000
  OD <- subset(OD, OD$Time < max(DealCycle$Time))
  
  DealCycle <- rbind(DealCycle, OD)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="OverDriveExhaust") {
      for(j in 1:ncol(DealCycle)) {
        if(sum(colnames(DealCycle)[j]==c("Skills", "Time", "OverDrive","OverDriveExhaust"))==0) {
          DealCycle[i, j] <- ifelse(DealCycle[i-1, j]>0, max(DealCycle[i-1, j] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
        }
      }
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]!="OverDriveExhaust") {
      DealCycle$OverDriveExhaust[i] <- ifelse(DealCycle$OverDriveExhaust[i-1]>0, max(DealCycle$OverDriveExhaust[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  return(DealCycle)
}
MultipleOptionTime <- function(MultipleOptionSummonedDuration) {
  a <- floor(MultipleOptionSummonedDuration/1.5)
  b <- floor(a / 8) * 12
  return(b)
}
MultipleOptionCycle <- function(DealCycle, SummonedSkillList) {
  DealCycle <- DCSummonedATKs(DealCycle, "MultipleOptionGetling", SummonedSkillList)
  
  DC1 <- subset(DealCycle, DealCycle$Skills=="MultipleOptionGetling")
  DC2 <- subset(DealCycle, DealCycle$Skills!="MultipleOptionGetling")
  
  k <- 1
  for(i in 1:nrow(DC1)) {
    if(k<=3) {
      DC1$Skills[i] <- "MultipleOptionMissile"
      k <- k + 1
    } else {
      k <- ifelse(k==8, 1, k + 1)
    }
  }
  
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
MechCarrierCycle <- function(DealCycle, SummonedSkillList) {
  t <- c(9, 10, 11, 12, 13, 14, 15, 16, 16, 16, 16, 16, 16, 16, 16, 16, 8)
  
  DealCycle <- DCSummonedATKs(DealCycle, "MechCarrier", SummonedSkillList)
  DC1 <- subset(DealCycle, DealCycle$Skills=="MechCarrier")
  DC2 <- subset(DealCycle, DealCycle$Skills!="MechCarrier")
  
  for(i in 1:nrow(DC1)) {
    Ind <- ((i / 17) - floor(i / 17)) * 17
    Ind <- ifelse(Ind==0, 17, Ind)
    k <- 2
    while(k<=t[Ind]) {
      DC1 <- rbind(DC1, DC1[i, ])
      k <- k + 1
    }
  }
  
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
RM1MFCycle <- function(DealCycle, RM1Duration, RM1CoolTime, MFDuration, MFCoolTime, SummonedSkillList) {
  maxtime <- max(DealCycle$Time)
  DealCycle <- DCSummonedATKs(DealCycle, c("RM1"), SummonedFinal)
  if(RM1Duration < RM1CoolTime) {
    RM <- subset(DealCycle, DealCycle$Skills=="RM1Summoned")
    RM$Skills <- "RM1Explosion"
    RM$Time <- RM$Time + 1000 * RM1Duration
  }
  DealCycle <- rbind(DealCycle, RM)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="RM1Explosion") {
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- ifelse(DealCycle[i-1, j]>0, max(DealCycle[i-1, j] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      }
    }
  }
  DealCycle <- subset(DealCycle, DealCycle$Time <= maxtime)
  
  maxtime <- max(DealCycle$Time)
  DealCycle <- DCSummonedATKs(DealCycle, c("MagneticField"), SummonedFinal)
  if(MFDuration < MFCoolTime) {
    MF <- subset(DealCycle, DealCycle$Skills=="MagneticFieldSummoned")
    MF$Skills <- "MagneticFieldExplosion"
    MF$Time <- MF$Time + 1000 * MFDuration
  }
  DealCycle <- rbind(DealCycle, MF)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MagneticFieldExplosion") {
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- ifelse(DealCycle[i-1, j]>0, max(DealCycle[i-1, j] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      }
    }
  }
  DealCycle <- subset(DealCycle, DealCycle$Time <= maxtime)
  return(DealCycle)
}
MechanicAddATKCycle <- function(DealCycle, ATKSkillList) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MetalArmorFullburstBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "HomingMissileMetalArmorAdd"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "HomingMissileMetalArmorAdd", 15, 0, ATKSkillList)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MassiveFire" & DealCycle$MetalArmorFullburstExhaust[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissile")
    } else if(DealCycle$Skills[i]=="HomingMissileMetalArmorAdd") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissileMetalArmor")
    }
  }
  
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HomingMissile" & DealCycle$BomberTime[i]>0 & DealCycle$MetalArmorFullburstExhaust[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissileBomberTime")
    } else if(DealCycle$Skills[i]=="HomingMissileMetalArmor" & DealCycle$BomberTime[i]>0 & DealCycle$MetalArmorFullburstExhaust[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissileMetalArmorBomber")
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MassiveFire") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MassiveFireExplosion")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}

## Adele Functions
AWCycle <- function(DealCycle, ActivationSkills) {
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c(ActivationSkills))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
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
AdeleATKCycle <- function(PreDealCycle, Skills, ATKSkillList) {
  DealCycle <- PreDealCycle[, 1:(ncol(PreDealCycle)-1)]
  Ether <- PreDealCycle$Ether
  for(i in 1:length(Skills)) {
    DealCycle <- DCATK(DealCycle, Skills[i], ATKSkillList)
    if(DealCycle$Skills[nrow(DealCycle)]=="Divide") {
      Ether[length(Ether)+1] <- min(400, Ether[length(Ether)] + floor(12 * ifelse(DealCycle$Restore[nrow(DealCycle)]>0, 150 + AdeleCore[[2]][3, 2], 100)/100))
    } else if(DealCycle$Skills[nrow(DealCycle)]=="Resonance") {
      Ether[length(Ether)+1] <- min(400, Ether[length(Ether)] + floor(20 * ifelse(DealCycle$Restore[nrow(DealCycle)]>0, 150 + AdeleCore[[2]][3, 2], 100)/100))
    } else {
      Ether[length(Ether)+1] <- Ether[length(Ether)]
    }
    if(DealCycle$EtherRecovery[nrow(DealCycle)-1]>=0 & DealCycle$EtherRecovery[nrow(DealCycle)]==0 & Ether[length(Ether)] < 400) {
      Ether[length(Ether)] <- min(400, Ether[length(Ether)] + floor(5 * ifelse(DealCycle$Restore[nrow(DealCycle)]>0, 150 + AdeleCore[[2]][3, 2], 100)/100))
      DealCycle$EtherRecovery[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 10000, 10000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$EtherRecovery[nrow(DealCycle)-1]))
    } else if(Ether[length(Ether)] == 400) {
      DealCycle$EtherRecovery[nrow(DealCycle)] <- 10000
    }
  }
  DC <- cbind(DealCycle, Ether)
  colnames(DC) <- colnames(PreDealCycle)
  return(DC)
}
AdeleBuffCycle <- function(PreDealCycle, Skills, BuffList) {
  DealCycle <- PreDealCycle[, 1:(ncol(PreDealCycle)-1)]
  Ether <- PreDealCycle$Ether
  for(i in 1:length(Skills)) {
    DealCycle <- DCBuff(DealCycle, Skills[i], BuffList)
    if(DealCycle$EtherRecovery[nrow(DealCycle)-1]>=0 & DealCycle$EtherRecovery[nrow(DealCycle)]==0 & Ether[length(Ether)] < 400) {
      Ether[length(Ether)+1] <- min(400, Ether[length(Ether)] + floor(5 * ifelse(DealCycle$Restore[nrow(DealCycle)]>0, 150 + AdeleCore[[2]][3, 2], 100)/100))
      DealCycle$EtherRecovery[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 10000, 10000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$EtherRecovery[nrow(DealCycle)-1]))
    } else if(Ether[length(Ether)] == 400) {
      Ether[length(Ether)+1] <- Ether[length(Ether)]
      DealCycle$EtherRecovery[nrow(DealCycle)] <- 10000
    } else {
      Ether[length(Ether)+1] <- Ether[length(Ether)]
    }
  }
  DC <- cbind(DealCycle, Ether)
  colnames(DC) <- colnames(PreDealCycle)
  return(DC)
}
AdeleSummonedCycle <- function(PreDealCycle, Skills, SummonedSkillList) {
  DealCycle <- PreDealCycle[, 1:(ncol(PreDealCycle)-1)]
  Ether <- PreDealCycle$Ether
  for(i in 1:length(Skills)) {
    DealCycle <- DCSummoned(DealCycle, Skills[i], SummonedSkillList)
    if(DealCycle$Skills[nrow(DealCycle)]=="OrderSummoned" | DealCycle$Skills[nrow(DealCycle)]=="OrderDummySummoned") {
      Ether[length(Ether)+1] <- Ether[length(Ether)] - 100
    } else {
      Ether[length(Ether)+1] <- Ether[length(Ether)]
    }
    if(Ether[length(Ether)] < 0) {
      warning("Order Cannot be Summoned")
    }
    if(DealCycle$EtherRecovery[nrow(DealCycle)-1]>=0 & DealCycle$EtherRecovery[nrow(DealCycle)]==0 & Ether[length(Ether)] < 400) {
      Ether[length(Ether)] <- min(400, Ether[length(Ether)] + floor(5 * ifelse(DealCycle$Restore[nrow(DealCycle)]>0, 150 + AdeleCore[[2]][3, 2], 100)/100))
      DealCycle$EtherRecovery[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 10000, 10000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$EtherRecovery[nrow(DealCycle)-1]))
    } else if(Ether[length(Ether)] == 400) {
      DealCycle$EtherRecovery[nrow(DealCycle)] <- 10000
    }
  }
  DC <- cbind(DealCycle, Ether)
  colnames(DC) <- colnames(PreDealCycle)
  return(DC)
}
RuinTerritoryCycle <- function(DealCycle, ATKSkillList) {
  ## Ruin
  DealCycle <- RepATKCycle(DealCycle, "Ruin", 12, 0, ATKSkillList)
  DC1 <- subset(DealCycle, DealCycle$Skills=="RuinStart")
  DC1$Time <- DC1$Time + 3480
  DC1$Skills <- "RuinExplosion"
  DealCycle <- rbind(DealCycle, DC1)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="RuinExplosion") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "RuinExplosion", 8, 0, ATKSkillList)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Ruin" | DealCycle$Skills[i]=="RuinExplosion" | DealCycle$Skills[i]=="RuinExplosionStart") {
      DealCycle$Ether[i] <- DealCycle$Ether[i-1]
    }
  }
  
  ## Territory
  DealCycle <- RepATKCycle(DealCycle, "Territory", 27, 1500, ATKSkillList)
  DC2 <- subset(DealCycle, DealCycle$Skills=="TerritoryStart")
  DC2$Time <- DC2$Time + 11000
  DC2$Skills <- "TerritoryExplosion"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="TerritoryExplosion") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Territory" | DealCycle$Skills[i]=="TerritoryExplosion") {
      DealCycle$Ether[i] <- DealCycle$Ether[i-1]
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
GatheringBlossomWonderCreationCycle <- function(DealCycle, ATKSkillList) {
  ## Creation
  DC1 <- data.frame(t(rep(0, ncol(DealCycle))))
  colnames(DC1) <- colnames(DealCycle)
  time <- 1501
  for(i in 2:nrow(DealCycle)-1) {
    if(time > 1500 & DealCycle$Skills[i]=="Divide" & DealCycle$Ether[i]>=100) {
      DC1 <- rbind(DC1, DealCycle[i, ])
      DC1[nrow(DC1), 1] <- c("Creation")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  
  DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  for(i in 2:nrow(DealCycle)-1) {
    if(DealCycle$Skills[i]=="Creation" & DealCycle$Ether[i]>=200 & DealCycle$Ether[i] < 300) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- c("Creation")
    } else if(DealCycle$Skills[i]=="Creation" & DealCycle$Ether[i]>=300) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- c("Creation")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- c("Creation")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Wonder
  DC1 <- data.frame(t(rep(0, ncol(DealCycle))))
  colnames(DC1) <- colnames(DealCycle)
  time <- 8001
  for(i in 2:nrow(DealCycle)-1) {
    if(time > 8000 & DealCycle$Skills[i]=="Divide") {
      DC1 <- rbind(DC1, DealCycle[i, ])
      DC1[nrow(DC1), 1] <- c("Wonder")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Blossom
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Blossom1st") {
      if(DealCycle$Order1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
      }
      if(DealCycle$Order2[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
      }
      if(DealCycle$Order3[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
      } 
      if(DealCycle$OrderRestore[i] > 0 & DealCycle$RestoreBuff[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("BlossomRemain")
      }
      DealCycle <- DealCycle[-1 * nrow(DealCycle), ]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Gathering
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Gathering") {
      if(DealCycle$Order1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
      }
      if(DealCycle$Order2[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
      }
      if(DealCycle$Order3[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
      } 
      if(DealCycle$OrderRestore[i] > 0 & DealCycle$RestoreBuff[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle[nrow(DealCycle), 1] <- c("Gathering")
      }
      DealCycle <- DealCycle[-1 * nrow(DealCycle), ]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
StormATKCycle <- function(PreDealCycle, ATKSkillList) {
  DealCycle <- PreDealCycle[, 1:(ncol(PreDealCycle)-1)]
  Ether <- PreDealCycle$Ether
  for(i in 1:1) {
    DealCycle <- DCATK(DealCycle, "Storm", ATKSkillList)
    Ether[length(Ether)+1] <- Ether[length(Ether)]
    DealCycle$Order1[nrow(DealCycle)] <- ifelse(DealCycle$Order1[nrow(DealCycle)-1]>0, 1, 0)
    DealCycle$Order2[nrow(DealCycle)] <- ifelse(DealCycle$Order2[nrow(DealCycle)-1]>0, 1, 0)
    DealCycle$Order3[nrow(DealCycle)] <- ifelse(DealCycle$Order3[nrow(DealCycle)-1]>0, 1, 0)
    DealCycle$OrderRestore[nrow(DealCycle)] <- ifelse(DealCycle$OrderRestore[nrow(DealCycle)-1]>0, 1, 0)
  }
  DC <- cbind(DealCycle, Ether)
  colnames(DC) <- colnames(PreDealCycle)
  return(DC)
}
StormRepATKCycle <- function(DealCycle, ATKSkillList) {
  DC1 <- subset(DealCycle, DealCycle$Skills=="Storm")
  t <- c()
  for(i in 1:nrow(DC1)) {
    t[i] <- sum(c(DC1$Order1[i]>0, DC1$Order2[i]>0, DC1$Order3[i]>0, DC1$OrderRestore[i]>0))
  }
  DealCycle <- RepATKCycle(DealCycle, "Storm", 51, 1890, ATKFinal)
  
  DC2 <- subset(DealCycle, DealCycle$Skills=="StormStart")
  Ind <- c(as.numeric(rownames(DC2)), nrow(DealCycle))
  for(i in 1:(length(Ind)-1)) {
    for(j in Ind[i]:Ind[i+1]) {
      if(DealCycle$Skills[j]=="Storm" & t[i]>1) {
        for(k in 2:t[i]) {
          DealCycle <- rbind(DealCycle, DealCycle[j, ])
          DealCycle[nrow(DealCycle), 1] <- c("Storm")
        }
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Storm") {
      DealCycle$Ether[i] <- DealCycle$Ether[i-1]
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AdeleOrderCycle <- function(DealCycle, SummonedSkillList) {
  DealCycle <- DCSummonedATKs(DealCycle, "Order", SummonedSkillList)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Order") {
      DealCycle$Ether[i] <- DealCycle$Ether[i-1]
    }
  }
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Order") {
      t <- sum(DealCycle$Order2[i]>0, DealCycle$Order3[i]>0, (DealCycle$OrderRestore[i]>0&DealCycle$RestoreBuff[i]>0))
      if(t > 0) {
        for(j in 1:t) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle[nrow(DealCycle), 1] <- c("Order")
        }
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
AdeleMCFAWCycle <- function(DealCycle, MagicCircuitFullDriveActivationSkills, AuraWeaponActivationSkills) {
  DealCycle <- MCFCycle(DealCycle, MagicCircuitFullDriveActivationSkills)
  DealCycle <- AWCycle(DealCycle, AuraWeaponActivationSkills)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AuraWeapon" | DealCycle$Skills[i]=="MagicCircuitFullDrive") {
      DealCycle$Ether[i] <- DealCycle$Ether[i-1]
    }
  }
  return(DealCycle)
}

## Illium Functions
IlliumATKCycle <- function(PreDealCycle, Skills, ATKSkillList, SkipStructure, PreCrystalCharge) {
  CrystalCharge <- PreCrystalCharge
  DealCycle <- PreDealCycle
  for(i in 1:length(Skills)) {
    DealCycle <- DCATKSkip(DealCycle, Skills[i], ATKSkillList, SkipStructure)
    if(DealCycle$Skills[nrow(DealCycle)]=="Orb") {
      DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
    }
    CrystalCharge <- CrystalCharge + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, (ifelse(Skills[i]=="Orb", 2, 0) + ifelse(Skills[i]=="Javelin", 1, 0)) * 2, 
                                            (ifelse(Skills[i]=="Orb", 2, 0) + ifelse(Skills[i]=="Javelin", 1, 0)))
    CrystalCharge <- ifelse(CrystalCharge>=150, 0, CrystalCharge)
    CrystalCharge <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="EnhancedJavelin", 0, CrystalCharge)
  }
  DC <- list(DealCycle, CrystalCharge)
  names(DC) <- c("DealCycle", "CrystalCharge")
  return(DC)
}
JavelinBuffLogic <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Javelin" | DealCycle$Skills[i]=="JavelinAddATK") {
      if(DealCycle$JavelinBuffDummy[i] > 0) {
        DealCycle$JavelinBuff[i] <- 1
      }
    }
  }
  return(DealCycle)
}
SoulofCrystalBuffLogic <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GloryWing") {
      DealCycle$SoulofCrystal1Glory[i] <- ifelse(DealCycle$SoulofCrystal1[i]==0, 0, max(DealCycle$SoulofCrystal1[i], DealCycle$SoulofCrystal2[i]))
      DealCycle$SoulofCrystal2Glory[i] <- ifelse(DealCycle$SoulofCrystal2[i]==0, 0, max(DealCycle$SoulofCrystal1[i], DealCycle$SoulofCrystal2[i]))
      DealCycle$SoulofCrystal1[i] <- 0
      DealCycle$SoulofCrystal2[i] <- 0
    }
  }
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("GloryWing"))==0) {
      DealCycle$SoulofCrystal1Glory[i] <- ifelse(DealCycle$SoulofCrystal1Glory[i-1]>0, max(DealCycle$SoulofCrystal1Glory[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      DealCycle$SoulofCrystal2Glory[i] <- ifelse(DealCycle$SoulofCrystal2Glory[i-1]>0, max(DealCycle$SoulofCrystal2Glory[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("GloryWing", "SoulofCrystal1"))==0) {
      DealCycle$SoulofCrystal1[i] <- ifelse(DealCycle$SoulofCrystal1[i-1]>0, max(DealCycle$SoulofCrystal1[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("GloryWing", "SoulofCrystal2"))==0) {
      DealCycle$SoulofCrystal2[i] <- ifelse(DealCycle$SoulofCrystal2[i-1]>0, max(DealCycle$SoulofCrystal2[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  return(DealCycle)
}
DeusExMachinaLogic <- function(DealCycle, DeusDuration, SummonedSkillList) {
  maxtime <- max(DealCycle$Time)
  d <- subset(DealCycle, DealCycle$Skill=="DeusSummoned")
  DeusTime <- d$Time
  
  l <- subset(DealCycle, DealCycle$Skill=="Liyo1StackSummoned")
  m <- subset(DealCycle, DealCycle$Skill=="MachinaSummoned")
  LiyoTime <- c(l$Time, c(DeusTime + DeusDuration * 1000))
  MachinaTime <- c(m$Time, c(DeusTime + DeusDuration * 1000))
  
  for(i in 2:length(LiyoTime)) {
    l <- rbind(l, l[1, ])
    l$Time[i] <- LiyoTime[i]
  }
  for(i in 2:length(MachinaTime)) {
    m <- rbind(m, m[1, ])
    m$Time[i] <- MachinaTime[i]
  }
  
  ds <- d
  ds$Skills <- "DeusSatelite1stackSummoned"
  DealCycle <- rbind(DealCycle, ds)
  DealCycle <- rbind(DealCycle, l[2:nrow(l), ], m[2:nrow(m), ])
  DealCycle <- subset(DealCycle, DealCycle$Time <= maxtime)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Liyo1StackSummoned" | DealCycle$Skills[i]=="MachinaSummoned") {
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(DealCycle[i-1, j] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0)
      }
    }
  }
  DealCycle <- DCSummonedATKs(DealCycle, "Deus", SummonedFinal)
  
  ## Deus Satelite
  SkillInd <- DealCycle[1, 1] == "DeusSatelite1stackSummoned"
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- c(SkillInd, DealCycle[i, 1] == "DeusSatelite1stackSummoned")
  }
  DEUS <- c("DeusSatelite1stack", "DeusSatelite2stack", "DeusSatelite3stack", "DeusSateliteWait")
  k <- rep(0, 4)
  for(i in 1:4) {
    DEUSCall <- rownames(SummonedSkillList)==DEUS[i]
    p <- 1
    while(k[i] == 0) {
      k[i] <- ifelse(DEUSCall[p]==F, 0, p)
      p <- p + 1
    } 
  }
  
  DC <- DealCycle[SkillInd, ]
  maxtime <- max(DealCycle$Time)
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1)
    DC1[2, 1] <- c("DeusSatelite1stack")
    DC1[2, 2] <- DC1[1, 2] + SummonedSkillList$SubTime[k[1]]
    
    t <- SummonedSkillList$SubTime[k[1]] * 2
    p <- 3
    m <- 2
    s1 <- 1
    while(t < DeusDuration * 1000) {
      DC1 <- rbind(DC1, DC1[1, ])
      DC1[p, 1] <- DEUS[s1]
      DC1[p, 2] <- DC1[p-1, 2] + ifelse(sum(m==c(1, 10, 20))==1, 30, SummonedSkillList$SubTime[k[s1]])
      t <- t + SummonedSkillList$SubTime[k[s1]]
      m <- ifelse(m==40, 1, m + 1)
      s1 <- ifelse(m <= 9, 1, ifelse(m <= 19, 2, ifelse(m <= 39, 3, 4)))
      p <- p + 1
    }
    DC1 <- subset(DC1, DC1$Time<=maxtime)
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DEUS==DealCycle[i, 1])>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  LiyoTime <- LiyoTime[LiyoTime<=maxtime]
  MachinaTime <- MachinaTime[MachinaTime<=maxtime]
  LiyoEnd <- c()
  if(length(DeusTime)>1) {
    if(length(LiyoTime) > length(DeusTime)) {
      LiyoEnd <- c(DeusTime, maxtime)
    } else if(length(LiyoTime) == length(DeusTime)) {
      if(LiyoTime[1] < DeusTime[1]) {
        LiyoEnd <- DeusTime
      } else {
        LiyoEnd <- c(DeusTime[2:length(DeusTime)], maxtime)
      }
    } else {
      LiyoEnd <- DeusTime[2:length(DeusTime)]
    }
  } else {
    if(length(LiyoTime) > length(DeusTime)) {
      LiyoEnd <- c(DeusTime, maxtime)
    } else if(length(LiyoTime) == length(DeusTime)) {
      LiyoEnd <- ifelse(LiyoTime[1] > DeusTime[1], DeusTime, maxtime)
    } else {
      warning("No LiyoSummoned Detected")
    }
  }
  
  MachinaEnd <- c()
  if(length(DeusTime)>1) {
    if(length(MachinaTime) > length(DeusTime)) {
      MachinaEnd <- c(DeusTime, maxtime)
    } else if(length(MachinaTime) == length(DeusTime)) {
      if(MachinaTime[1] < DeusTime[1]) {
        MachinaEnd <- DeusTime
      } else {
        MachinaEnd <- c(DeusTime[2:length(DeusTime)], maxtime)
      }
    } else {
      MachinaEnd <- DeusTime[2:length(DeusTime)]
    }
  } else {
    if(length(MachinaTime) > length(DeusTime)) {
      MachinaEnd <- c(DeusTime, maxtime)
    } else if(length(MachinaTime) == length(DeusTime)) {
      MachinaEnd <- ifelse(MachinaTime[1] > DeusTime[1], DeusTime, maxtime)
    } else {
      warning("No MachinaSummoned Detected")
    }
  }
  
  LiyoDuration <- LiyoEnd - LiyoTime
  MachinaDuration <- MachinaEnd - MachinaTime
  
  ## Liyo
  SkillInd <- DealCycle[1, 1] == "Liyo1StackSummoned"
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- c(SkillInd, DealCycle[i, 1] == "Liyo1StackSummoned")
  }
  LIYO <- c("Liyo1Stack", "Liyo2Stack", "Liyo3Stack", "LiyoWait")
  k <- rep(0, 4)
  for(i in 1:4) {
    LIYOCall <- rownames(SummonedSkillList)==LIYO[i]
    p <- 1
    while(k[i] == 0) {
      k[i] <- ifelse(LIYOCall[p]==F, 0, p)
      p <- p + 1
    } 
  }
  
  DC <- DealCycle[SkillInd, ]
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1)
    DC1[2, 1] <- c("Liyo1Stack")
    DC1[2, 2] <- DC1[1, 2] + SummonedSkillList$SubTime[k[1]]
    
    t <- SummonedSkillList$SubTime[k[1]] * 2
    p <- 3
    m <- 2
    s1 <- 1
    while(t < LiyoDuration[i]) {
      DC1 <- rbind(DC1, DC1[1, ])
      DC1[p, 1] <- LIYO[s1]
      DC1[p, 2] <- DC1[p-1, 2] + ifelse(sum(m==c(1, 10, 20))==1, 30, SummonedSkillList$SubTime[k[s1]])
      t <- t + SummonedSkillList$SubTime[k[s1]]
      m <- ifelse(m == 40, 1, m + 1)
      s1 <- ifelse(m <= 9, 1, ifelse(m <= 19, 2, ifelse(m <= 39, 3, 4)))
      p <- p + 1
    }
    DC1 <- subset(DC1, DC1$Time<=maxtime)
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(LIYO==DealCycle[i, 1])>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  # Machina
  SkillInd <- DealCycle[1, 1] == "MachinaSummoned"
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- c(SkillInd, DealCycle[i, 1] == "MachinaSummoned")
  }
  DealCycleNew <- DealCycle
  for(i in 1) {
    DC <- DealCycle[SkillInd, ]
    for(j in 1:nrow(DC)) {
      DC1 <- rbind(DC[j, ], DC[j, ])
      DC1[2, 1] <- "Machina"
      DC1[2, 2] <- DC1[2, 2] + 3030
      
      p <- 1
      t <- 3030 * 2
      while(t <= MachinaDuration[j]) {
        DC1 <- rbind(DC1, DC1[1, ])
        DC1[p+2, 1] <- "Machina"
        DC1[p+2, 2] <- DC1[p+1, 2] + 3030
        t <- t + 3030
        p <- p + 1
      }
      DC1 <- subset(DC1, DC1$Time<=maxtime)
      if(nrow(DC1)>1) {
        DealCycleNew <- rbind(DealCycleNew, DC1[2:nrow(DC1), ])
      }
    }
  }
  DealCycleNew <- DealCycleNew[order(DealCycleNew$Time), ] 
  rownames(DealCycleNew) <- 1:nrow(DealCycleNew)
  
  for(i in 1:nrow(DealCycleNew)) {
    if(sum("Machina"==DealCycleNew[i, 1])>=1) {
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- DealCycleNew[i-1, 3:ncol(DealCycleNew)] - (DealCycleNew[i, 2] - DealCycleNew[i-1, 2])
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- ifelse(DealCycleNew[i, 3:ncol(DealCycleNew)]<0, 0, DealCycleNew[i, 3:ncol(DealCycleNew)])
    }
  }
  return(DealCycleNew)
}
MCFCycle <- function(DealCycle, ActivationSkills) {
  MCF <- subset(DealCycle, DealCycle$Skills=="MagicCircuitFullDriveBuff")
  Ind <- rownames(MCF)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 4001
    while(p < Ind[i+1] & DealCycle$MagicCircuitFullDriveBuff[p] > 0) {
      if(time>4000 & max(DealCycle$Skills[p]==c(ActivationSkills))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("MagicCircuitFullDrive")
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
AddATKCycleIllium <- function(DealCycle, CrystalGateActivationSkills, DestructionCoolTime, SoulofCrystalReactionCoolTime) {
  ## Destruction
  DC1 <- data.frame(t(rep(0, ncol(DealCycle))))
  colnames(DC1) <- colnames(DealCycle)
  time <- DestructionCoolTime * 1000 + 1
  for(i in 2:nrow(DealCycle)-1) {
    if(time > (DestructionCoolTime * 1000) & DealCycle$Skills[i]=="Javelin") {
      DC1 <- rbind(DC1, DealCycle[i, ])
      DC1[nrow(DC1), 1] <- c("Destruction")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Domination
  DC1 <- data.frame(t(rep(0, ncol(DealCycle))))
  colnames(DC1) <- colnames(DealCycle)
  time <- DestructionCoolTime * 1000 + 1
  for(i in 2:nrow(DealCycle)-1) {
    if(time > (DestructionCoolTime * 1000) & DealCycle$Skills[i]=="Orb") {
      DC1 <- rbind(DC1, DealCycle[i, ])
      DC1[nrow(DC1), 1] <- c("Domination")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle) 
  
  ## Soul of Crystal (Spectrum, Javelin Add ATK)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$SoulofCrystal2[i] > 0 & DealCycle$SoulofCrystal1[i] > 0 & DealCycle$Skills[i]=="Javelin") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("JavelinAddATK")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("JavelinAddFragment")
    } else if(max(DealCycle$Skills[i]==c("ReactionSpectrum"))==1) {
      if(DealCycle$SoulofCrystal1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("ReactionSpectrum")
      }
      if(DealCycle$SoulofCrystal2[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("ReactionSpectrum")
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Soul of Crystal Destruction
  SOC1 <- subset(DealCycle, DealCycle$Skills=="SoulofCrystal1")
  Ind <- rownames(SOC1)
  Ind[length(Ind)+1] <- nrow(SOC1)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 4001
    while(p < Ind[i+1] & DealCycle$SoulofCrystal1[p] > 0) {
      if(time > SoulofCrystalReactionCoolTime * 1000 & max(DealCycle$Skills[p]==c("Javelin"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DestructionSoul")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    if(nrow(DC) >= 2) {
      DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  SOC2 <- subset(DealCycle, DealCycle$Skills=="SoulofCrystal2")
  Ind <- rownames(SOC2)
  Ind[length(Ind)+1] <- nrow(SOC2)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 4001
    while(p < Ind[i+1] & DealCycle$SoulofCrystal2[p] > 0) {
      if(time > SoulofCrystalReactionCoolTime * 1000 & max(DealCycle$Skills[p]==c("Javelin"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DestructionSoul")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    if(nrow(DC) >= 2) {
      DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Soul of Crystal Domination
  SOC1 <- subset(DealCycle, DealCycle$Skills=="SoulofCrystal1")
  Ind <- rownames(SOC1)
  Ind[length(Ind)+1] <- nrow(SOC1)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 4001
    while(p < Ind[i+1] & DealCycle$SoulofCrystal1[p] > 0) {
      if(time > SoulofCrystalReactionCoolTime * 1000 & max(DealCycle$Skills[p]==c("Orb"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DominationSoul")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    if(nrow(DC) >= 2) {
      DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  SOC2 <- subset(DealCycle, DealCycle$Skills=="SoulofCrystal2")
  Ind <- rownames(SOC2)
  Ind[length(Ind)+1] <- nrow(SOC2)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 4001
    while(p < Ind[i+1] & DealCycle$SoulofCrystal2[p] > 0) {
      if(time > SoulofCrystalReactionCoolTime * 1000 & max(DealCycle$Skills[p]==c("Orb"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DominationSoul")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    if(nrow(DC) >= 2) {
      DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## CrystalGate
  CG <- subset(DealCycle, DealCycle$Skills=="CrystalGateBuff")
  Ind <- rownames(CG)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$CrystalGateBuff[p] > 0) {
      if(time>1500 & max(DealCycle$Skills[p]==c(CrystalGateActivationSkills))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("CrystalGate")
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
  
  ## Javelins  
  for(i in 1:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("Javelin"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("JavelinFragment")
    } else if(max(DealCycle$Skills[i]==c("EnhancedJavelin"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("MagicMissile")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## CurseMark
  for(i in 1:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("EnhancedJavelin", "CristalIgnition", "JavelinAddATK"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("CurseMark")
    } else if(max(DealCycle$Skills[i]==c("Javelin"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("CurseMarkJavelin")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}

## Eunwol Functions
EunwolYakjeomGanpa <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores=(detectCores(logical=F)-1), 
                               NotBuffCols=c(), NotBuffColOption=c()) {
  HP <- (50 + EunwolSpec$PSkillLv) / 100
  DealCycle1 <- DealCycle
  DealCycle2 <- DealCycle
  DealCycle2$YakjeomGanpaAdd <- 1
  
  Deal1 <- DealCalc(DealCycle1, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, 
                    NotBuffCols, NotBuffColOption)
  Deal2 <- DealCalc(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, 
                    NotBuffCols, NotBuffColOption)
  Deal1 <- sum(Deal1, na.rm=T)
  Deal2 <- sum(Deal2, na.rm=T)
  
  w1 <- (1 * (1 - HP)) / ((Deal1 / Deal2) * HP + 1 * (1 - HP))
  w2 <- ((Deal1 / Deal2) * HP) / ((Deal1 / Deal2) * HP + 1 * (1 - HP))
  print(paste("w1 is ", round(w1, 4), ", w2 is ", round(w2, 4), sep=""))
  print(c(Deal1, Deal2))
  return(Deal1 * w1 + Deal2 * w2)
}
EunwolOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Cores=(detectCores(logical=F)-1), 
                                NotBuffCols=c(), NotBuffColOption=c()) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, 
                                 NotBuffCols, NotBuffColOption)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                 NotBuffCols, NotBuffColOption)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                 NotBuffCols, NotBuffColOption)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                   NotBuffCols, NotBuffColOption)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                   NotBuffCols, NotBuffColOption)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                 NotBuffCols, NotBuffColOption)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                   NotBuffCols, NotBuffColOption)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                     NotBuffCols, NotBuffColOption)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                                         NotBuffCols, NotBuffColOption)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
EunwolOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, Cores=(detectCores(logical=F)-1), 
                                NotBuffCols=c(), NotBuffColOption=c()) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  originallvs <- lvs
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Cores, 
                                              NotBuffCols, NotBuffColOption)))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Cores, 
                                                   NotBuffCols, NotBuffColOption)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], Cores, 
                                                   NotBuffCols, NotBuffColOption)))
    } else {
      NewDeal[7] <- sum(na.omit(EunwolYakjeomGanpa(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Cores, 
                                                   NotBuffCols, NotBuffColOption)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  
  SpecInc <- HyperBase
  SpecInc[1, ] <- 0
  for(i in 1:ncol(SpecInc)) {
    if(lvs[i] - originallvs[i] > 0) {
      if(colnames(SpecInc)[i]=="IGR") {
        BeforeIGR <- sum(HyperStats$IGR[1:(originallvs[i])])
        AfterIGR <- sum(HyperStats$IGR[1:(lvs[i])])
        SpecInc[1, i] <- (1 - (((100 - AfterIGR) / 100) / ((100 - BeforeIGR) / 100))) * 100
      } else {
        SpecInc[1, i] <- sum(HyperStats[, colnames(HyperStats)==colnames(SpecInc)[i]][(originallvs[i]+1):lvs[i]])
      }
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(Specs)
  print(lvs)
  return(SpecInc)
}

## Zero Functions
ZeroOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Cores=(detectCores(logical=F)-1), 
                              NotBuffCols=c(), NotBuffColOption=c()) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- ZeroPotList
  
  BaseDeal <- DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  if(DealList$IGR==0) {
    AvailablePot <- DealList[, 1:3]
  } else if(DealList$IGR==30) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
  } else if(DealList$IGR==40) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
  } else if(DealList$IGR==58) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
  } else if(DealList$IGR==64) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR64, Plus ATK24
    NewCase1[1] <- DealList$ATKP + 24
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=60) {
      NewCase2 <- c() ## Minus IGR64, Plus BDR80
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase2[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(DealList$IGR==74.8) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    NewCase2 <- c() ## Minus IGR64, Plus ATK24
    NewCase2[1] <- DealList$ATKP + 24
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=60) {
      NewCase3 <- c() ## Minus IGR64, Plus BDR80
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase3[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
  } else if(DealList$IGR==78.4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    NewCase2 <- c() ## Minus IGR64, Plus ATK24
    NewCase2[1] <- DealList$ATKP + 24
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=60) {
      NewCase3 <- c() ## Minus IGR64, Plus BDR80
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase3[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
  } else if(DealList$IGR==84.88) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    NewCase2 <- c() ## Minus IGR40, Plus ATK12
    NewCase2[1] <- DealList$ATKP + 12
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    NewCase3 <- c() ## Minus IGR64, Plus ATK24
    NewCase3[1] <- DealList$ATKP + 24
    NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase3[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase3)
    
    if(DealList$BDR<=60) {
      NewCase4 <- c() ## Minus IGR64, Plus BDR80
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase4[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  } else if(DealList$IGR==89.416) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR51, Plus ATK18
    NewCase2[1] <- DealList$ATKP + 18
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    NewCase3 <- c() ## Minus IGR64, Plus ATK24
    NewCase3[1] <- DealList$ATKP + 24
    NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase3[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase3)
    
    if(DealList$BDR<=60) {
      NewCase4 <- c() ## Minus IGR64, Plus BDR80
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase4[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
    
    if(DealList$BDR<=80) {
      NewCase5 <- c() ## Minus IGR51, Plus BDR60
      NewCase5[1] <- DealList$ATKP
      NewCase5[2] <- IGRCalc(c(DealList$IGR, -3/7*100, -3/7*100))
      NewCase5[3] <- DealList$BDR + 60
      AvailablePot <- rbind(AvailablePot, NewCase5)
    }
  } else if(DealList$IGR==92.5912) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR40, Plus ATK12
    NewCase2[1] <- DealList$ATKP + 12
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    NewCase3 <- c() ## Minus IGR51, Plus ATK18
    NewCase3[1] <- DealList$ATKP + 18
    NewCase3[2] <- IGRCalc(c(DealList$IGR, -3/7*100, -3/7*100))
    NewCase3[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase3)
    
    NewCase4 <- c() ## Minus IGR64, Plus ATK24
    NewCase4[1] <- DealList$ATKP + 24
    NewCase4[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
    NewCase4[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase4)
    
    if(DealList$BDR<=60) {
      NewCase5 <- c() ## Minus IGR64, Plus BDR80
      NewCase5[1] <- DealList$ATKP
      NewCase5[2] <- IGRCalc(c(DealList$IGR, -2/3*100, -2/3*100))
      NewCase5[3] <- DealList$BDR + 80
      AvailablePot <- rbind(AvailablePot, NewCase5)
    }
    
    if(DealList$BDR<=80) {
      NewCase6 <- c() ## Minus IGR51, Plus BDR60
      NewCase6[1] <- DealList$ATKP
      NewCase6[2] <- IGRCalc(c(DealList$IGR, -3/7*100, -3/7*100))
      NewCase6[3] <- DealList$BDR + 60
      AvailablePot <- rbind(AvailablePot, NewCase6)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList,  NewSpecs, Cores, Collapse=T, NotBuffCols, NotBuffColOption)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}

## Xenon Functions
XenonDealCalc <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores=(detectCores(logical=F)-1), Collapse=T) {
  ## Act Skills and Summoned Skills Collapse
  ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
  ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
  ATKSkillsList <- subset(ATKSkillsList, ATKSkillsList$Damage > 0)
  
  BuffSkills <- rownames(BuffList)
  BuffOpList <- colnames(BuffList)
  SpecList <- colnames(Specs)
  
  BuffList <- data.frame(BuffList)
  BuffList$BuffOpRatio <- ifelse(is.na(BuffList$CoolTime)==T, 1, BuffList$Duration / BuffList$CoolTime)
  NonATimeBuff <- subset(BuffList, BuffList$BuffOpRatio<1)
  
  ## DealCycle Collapse
  if(Collapse==T) {
    EffectiveRow <- c()
    for(i in 1:nrow(DealCycle)) {
      EffectiveRow[i] <- sum(DealCycle$Skills[i]==rownames(ATKSkillsList)) >= 1
    }
    DealCycle <- DealCycle[EffectiveRow, ]
  }
  
  t <- c()
  ind <- c()
  p <- c()
  for(i in 1:length(SpecList)) {
    ind[i] <- 0
    p[i] <- 1
    t[i] <- 1
    while(ind[i]==0) {
      t[i] <- ifelse(SpecList[i]==BuffOpList[p[i]], t[i], t[i] + 1)
      ind[i] <- ifelse(SpecList[i]==BuffOpList[p[i]] | p[i] >= length(BuffOpList), 1, 0)
      p[i] <- p[i] + 1
    }
  }
  
  for(i in 1:length(SpecList)) {
    t[i] <- ifelse(t[i] > length(BuffOpList), NA, t[i])
  }
  
  k <- rownames(NonATimeBuff)
  b <- c()
  for(i in 1:(ncol(DealCycle)-2)) {
    b[i] <- max(k==colnames(DealCycle)[i+2])
  }
  c <- data.frame(c(1:length(b)), b)
  c <- subset(c, c$b==1)[, 1] + 2
  
  ## Deal Calculation
  Deal <- c()
  DealCalcEach <- function(i) {
    BuffInd <- DealCycle[i, c] > 0
    
    d <- NonATimeBuff[BuffInd, ]
    if(nrow(d) > 0) {
      BuffEach <- c()
      for(j in 1:ncol(d)) {
        if(colnames(d)[j]=="IGR") {
          BuffEach[j] <- IGRCalc(d[, j])
        } else if(colnames(d)[j]=="FDR") {
          BuffEach[j] <- FDRCalc(d[, j])
        } else if(colnames(d)[j]=="Disorder") {
          BuffEach[j] <- max(d[, j])
        } else if(colnames(d)[j]=="LvDiffIgnore") {
          BuffEach[j] <- max(d[, j])
        } else {
          BuffEach[j] <- sum(d[, j])
        }
      }
      BuffEach <- data.frame(t(BuffEach))
      colnames(BuffEach) <- colnames(d)
    } else {
      BuffEach <- data.frame(t(rep(0, ncol(d))))
      colnames(BuffEach) <- colnames(d)
    }
    SpecEach <- c()
    for(j in 1:ncol(Specs)) {
      if(is.na(t[j]==T)) {
        SpecEach[j] <- Specs[1, j]
      } else if(colnames(Specs)[j]=="IGR") {
        SpecEach[j] <- IGRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="FDR") {
        SpecEach[j] <- FDRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="Disorder" | colnames(Specs)[j]=="LvDiffIgnore") {
        SpecEach[j] <- max(c(Specs[1, j], BuffEach[1, t[j]]))
      } else {
        SpecEach[j] <- Specs[1, j] + BuffEach[1, t[j]]
      }
    }
    SpecEach <- data.frame(t(SpecEach))
    colnames(SpecEach) <- colnames(Specs)
    
    SkillInd <- DealCycle[i, 1]==rownames(ATKSkillsList)
    Skills <- ATKSkillsList[SkillInd, ]
    if(nrow(Skills)==0) {
      Deal <- 0
    } else {
      Deal <- Skills$Damage / 100 * (SpecEach$MainStat + SpecEach$SubStat1 + SpecEach$SubStat2 + 
                                       floor(Specs$MainStatWithoutStatP * DealCycle$SurplusSupplyStack[i] / 100) + 
                                       floor(Specs$SubStat1WithoutStatP * DealCycle$SurplusSupplyStack[i] / 100) + 
                                       floor(Specs$SubStat2WithoutStatP * DealCycle$SurplusSupplyStack[i] / 100)) * 4 * (SpecEach$ATK + Skills$ATK) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobDefault$Basic$Guard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$OverloadModeFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(MobDefault$Basic$PhysicImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
    return(Deal)
  }
  Deal <- mcmapply(DealCalcEach, i=1:nrow(DealCycle), SIMPLIFY=T, mc.cores=Cores)
  return(Deal)
}
XenonDealCalcWithMaxDMR <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores=(detectCores(logical=F)-1)) {
  ## Act Skills and Summoned Skills Collapse
  ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
  ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
  ATKSkillsList <- subset(ATKSkillsList, ATKSkillsList$Damage > 0)
  
  BuffSkills <- rownames(BuffList)
  BuffOpList <- colnames(BuffList)
  SpecList <- colnames(Specs)
  
  BuffList <- data.frame(BuffList)
  BuffList$BuffOpRatio <- ifelse(is.na(BuffList$CoolTime)==T, 1, BuffList$Duration / BuffList$CoolTime)
  NonATimeBuff <- subset(BuffList, BuffList$BuffOpRatio<1)
  
  t <- c()
  ind <- c()
  p <- c()
  for(i in 1:length(SpecList)) {
    ind[i] <- 0
    p[i] <- 1
    t[i] <- 1
    while(ind[i]==0) {
      t[i] <- ifelse(SpecList[i]==BuffOpList[p[i]], t[i], t[i] + 1)
      ind[i] <- ifelse(SpecList[i]==BuffOpList[p[i]] | p[i] >= length(BuffOpList), 1, 0)
      p[i] <- p[i] + 1
    }
  }
  
  for(i in 1:length(SpecList)) {
    t[i] <- ifelse(t[i] > length(BuffOpList), NA, t[i])
  }
  
  k <- rownames(NonATimeBuff)
  b <- c()
  for(i in 1:(ncol(DealCycle)-2)) {
    b[i] <- max(k==colnames(DealCycle)[i+2])
  }
  c <- data.frame(c(1:length(b)), b)
  c <- subset(c, c$b==1)[, 1] + 2
  
  ## Deal Calculation
  Deal <- c()
  DealCalcEach <- function(i) {
    BuffInd <- DealCycle[i, c] > 0
    
    d <- NonATimeBuff[BuffInd, ]
    if(nrow(d) > 0) {
      BuffEach <- c()
      for(j in 1:ncol(d)) {
        if(colnames(d)[j]=="IGR") {
          BuffEach[j] <- IGRCalc(d[, j])
        } else if(colnames(d)[j]=="FDR") {
          BuffEach[j] <- FDRCalc(d[, j])
        } else if(colnames(d)[j]=="Disorder") {
          BuffEach[j] <- max(d[, j])
        } else if(colnames(d)[j]=="LvDiffIgnore") {
          BuffEach[j] <- max(d[, j])
        } else {
          BuffEach[j] <- sum(d[, j])
        }
      }
      BuffEach <- data.frame(t(BuffEach))
      colnames(BuffEach) <- colnames(d)
    } else {
      BuffEach <- data.frame(t(rep(0, ncol(d))))
      colnames(BuffEach) <- colnames(d)
    }
    SpecEach <- c()
    for(j in 1:ncol(Specs)) {
      if(is.na(t[j]==T)) {
        SpecEach[j] <- Specs[1, j]
      } else if(colnames(Specs)[j]=="IGR") {
        SpecEach[j] <- IGRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="FDR") {
        SpecEach[j] <- FDRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="Disorder" | colnames(Specs)[j]=="LvDiffIgnore") {
        SpecEach[j] <- max(c(Specs[1, j], BuffEach[1, t[j]]))
      } else {
        SpecEach[j] <- Specs[1, j] + BuffEach[1, t[j]]
      }
    }
    SpecEach <- data.frame(t(SpecEach))
    colnames(SpecEach) <- colnames(Specs)
    
    SkillInd <- DealCycle[i, 1]==rownames(ATKSkillsList)
    Skills <- ATKSkillsList[SkillInd, ]
    if(nrow(Skills)==0) {
      Deal <- 0
    } else {
      Deal <- Skills$Damage / 100 * (SpecEach$MainStat + SpecEach$SubStat1 + SpecEach$SubStat2 + 
                                       floor(Specs$MainStatWithoutStatP * DealCycle$SurplusSupplyStack[i] / 100) + 
                                       floor(Specs$SubStat1WithoutStatP * DealCycle$SurplusSupplyStack[i] / 100) + 
                                       floor(Specs$SubStat2WithoutStatP * DealCycle$SurplusSupplyStack[i] / 100)) * 4 * (SpecEach$ATK + Skills$ATK) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobDefault$Basic$Guard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$OverloadModeFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(MobDefault$Basic$PhysicImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1) * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
      Deal <- CutDam(Deal, SpecEach$Mastery, SpecEach$CDMR + Skills$CDMR) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
    return(Deal)
  }
  Deal <- mcmapply(DealCalcEach, i=1:nrow(DealCycle), SIMPLIFY=T, mc.cores=Cores)
  return(Deal)
}
XenonOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Cores=(detectCores(logical=F)-1)) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, Collapse=T)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
XenonOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, Cores=(detectCores(logical=F)-1)) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  originallvs <- lvs
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Cores, Collapse=T)))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Cores, Collapse=T)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], Cores, Collapse=T)))
    } else {
      NewDeal[7] <- sum(na.omit(XenonDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Cores, Collapse=T)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  
  SpecInc <- HyperBase
  SpecInc[1, ] <- 0
  for(i in 1:ncol(SpecInc)) {
    if(lvs[i] - originallvs[i] > 0) {
      if(colnames(SpecInc)[i]=="IGR") {
        BeforeIGR <- sum(HyperStats$IGR[1:(originallvs[i])])
        AfterIGR <- sum(HyperStats$IGR[1:(lvs[i])])
        SpecInc[1, i] <- (1 - (((100 - AfterIGR) / 100) / ((100 - BeforeIGR) / 100))) * 100
      } else {
        SpecInc[1, i] <- sum(HyperStats[, colnames(HyperStats)==colnames(SpecInc)[i]][(originallvs[i]+1):lvs[i]])
      }
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(Specs)
  print(lvs)
  return(SpecInc)
}

## DemonAvenger Functions
DemonAvengerOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, Cores=(detectCores(logical=F)-1), 
                                      NotBuffCols=c(), NotBuffColOption=c()) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStatsDA[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }  
  originallvs <- lvs
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStatsDA[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStatsDA[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStatsDA[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Collapse=T, Cores=(detectCores(logical=F)-1), 
                                    NotBuffCols, NotBuffColOption)))
    NewSpecs$MainStatP$MainStatP <- NewSpecs$MainStatP$MainStatP + ifelse(nextlevelpts[1] > remainpts, 0, HyperStatsDA$MainStatP[lvs[1]+1] / 100)
    NewSpecs$MainStatP$MainStat <- NewSpecs$MainStatP$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, floor(NewSpecs$MainStatP$MainStatWithoutStatP * HyperStatsDA$MainStatP[lvs[1]+1] / 100))
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStatsDA$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStatsDA$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStatsDA$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStatsDA$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStatsDA$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStatsDA$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStatsDA$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStatsDA$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStatsDA$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStatsDA$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStatsDA$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStatsDA$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Collapse=T, Cores=(detectCores(logical=F)-1), 
                                         NotBuffCols, NotBuffColOption)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], Collapse=T, Cores=(detectCores(logical=F)-1), 
                                         NotBuffCols, NotBuffColOption)))
    } else {
      NewDeal[7] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Collapse=T, Cores=(detectCores(logical=F)-1), 
                                         NotBuffCols, NotBuffColOption)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStatsDA[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else if(maxeff[1, 1]=="MainStatP") {
        Specs <- NewSpecs$MainStatP
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStatsDA[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  
  SpecInc <- HyperBase
  SpecInc[1, ] <- 0
  for(i in 1:ncol(SpecInc)) {
    if(lvs[i] - originallvs[i] > 0) {
      if(colnames(SpecInc)[i]=="IGR") {
        BeforeIGR <- sum(HyperStatsDA$IGR[1:(originallvs[i])])
        AfterIGR <- sum(HyperStatsDA$IGR[1:(lvs[i])])
        SpecInc[1, i] <- (1 - (((100 - AfterIGR) / 100) / ((100 - BeforeIGR) / 100))) * 100
      } else {
        SpecInc[1, i] <- sum(HyperStatsDA[, colnames(HyperStatsDA)==colnames(SpecInc)[i]][(originallvs[i]+1):lvs[i]])
      }
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(Specs)
  print(lvs)
  return(SpecInc)
}

## Evan Functions
EvanBoW <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores=(detectCores(logical=F)-1), 
                    NotBuffCols=c(), NotBuffColOption=c()) {
  if(nrow(subset(DealCycle, DealCycle$Skills=="BreathofWind")) == 0) {
    Deal1 <- DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, 
                      NotBuffCols, NotBuffColOption)
    Deal1 <- sum(Deal1, na.rm=T)
    return(Deal1)
  } else {
    HP <- (35 + floor(EvanSpec$SkillLv/2)) / 100
    
    DealCycle2 <- DealCycle
    DealCycle2[DealCycle2$Skills=="BreathofWind", ]$Skills <- "BreathofWindBonus"
    
    Deal1 <- DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, 
                      NotBuffCols, NotBuffColOption)
    Deal2 <- DealCalc(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, Collapse=T, 
                      NotBuffCols, NotBuffColOption)
    Deal1 <- sum(Deal1, na.rm=T)
    Deal2 <- sum(Deal2, na.rm=T)
    
    w1 <- (1 * (1 - HP)) / ((Deal1 / Deal2) * HP + 1 * (1 - HP))
    w2 <- ((Deal1 / Deal2) * HP) / ((Deal1 / Deal2) * HP + 1 * (1 - HP))
    print(paste("w1 is ", round(w1, 4), ", w2 is ", round(w2, 4), sep=""))
    print(c(Deal1, Deal2))
    return(Deal1 * w1 + Deal2 * w2)
  }
}
EvanOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Cores=(detectCores(logical=F)-1), 
                              NotBuffCols=c(), NotBuffColOption=c()) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Cores, 
                      NotBuffCols, NotBuffColOption)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                      NotBuffCols, NotBuffColOption)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                      NotBuffCols, NotBuffColOption)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                        NotBuffCols, NotBuffColOption)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                        NotBuffCols, NotBuffColOption)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                      NotBuffCols, NotBuffColOption)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                        NotBuffCols, NotBuffColOption)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                          NotBuffCols, NotBuffColOption)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Cores, 
                                              NotBuffCols, NotBuffColOption)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
EvanOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, Cores=(detectCores(logical=F)-1), 
                              NotBuffCols=c(), NotBuffColOption=c()) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  originallvs <- lvs
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Cores, 
                                   NotBuffCols, NotBuffColOption)))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Cores, 
                                        NotBuffCols, NotBuffColOption)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], Cores, 
                                        NotBuffCols, NotBuffColOption)))
    } else {
      NewDeal[7] <- sum(na.omit(EvanBoW(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Cores, 
                                        NotBuffCols, NotBuffColOption)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  
  SpecInc <- HyperBase
  SpecInc[1, ] <- 0
  for(i in 1:ncol(SpecInc)) {
    if(lvs[i] - originallvs[i] > 0) {
      if(colnames(SpecInc)[i]=="IGR") {
        BeforeIGR <- sum(HyperStats$IGR[1:(originallvs[i])])
        AfterIGR <- sum(HyperStats$IGR[1:(lvs[i])])
        SpecInc[1, i] <- (1 - (((100 - AfterIGR) / 100) / ((100 - BeforeIGR) / 100))) * 100
      } else {
        SpecInc[1, i] <- sum(HyperStats[, colnames(HyperStats)==colnames(SpecInc)[i]][(originallvs[i]+1):lvs[i]])
      }
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(Specs)
  print(lvs)
  return(SpecInc)
}