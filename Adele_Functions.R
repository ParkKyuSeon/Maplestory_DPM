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
  DealCycle <- RepATKCycle(DealCycle, "RuinExplosion", 6, 0, ATKSkillList)
  
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