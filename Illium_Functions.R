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
      DealCycle$SoulofCrystal1Glory[i] <- DealCycle$SoulofCrystal1[i]
      DealCycle$SoulofCrystal2Glory[i] <- DealCycle$SoulofCrystal2[i]
      DealCycle$SoulofCrystal1[i] <- 0
      DealCycle$SoulofCrystal2[i] <- 0
    }
  }
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("GloryWing", "SoulofCrystal1", "SoulofCrystal2"))==0) {
      DealCycle$SoulofCrystal1[i] <- ifelse(DealCycle$SoulofCrystal1[i-1]>0, max(DealCycle$SoulofCrystal1[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      DealCycle$SoulofCrystal2[i] <- ifelse(DealCycle$SoulofCrystal2[i-1]>0, max(DealCycle$SoulofCrystal2[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      DealCycle$SoulofCrystal1Glory[i] <- ifelse(DealCycle$SoulofCrystal1Glory[i-1]>0, max(DealCycle$SoulofCrystal1Glory[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
      DealCycle$SoulofCrystal2Glory[i] <- ifelse(DealCycle$SoulofCrystal2Glory[i-1]>0, max(DealCycle$SoulofCrystal2Glory[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$GloryWing[i]==0) {
      DealCycle$SoulofCrystal1Glory[i] <- 0
      DealCycle$SoulofCrystal2Glory[i] <- 0
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
      DC1[p, 2] <- DC1[p-1, 2] + SummonedSkillList$SubTime[k[s1]]
      t <- t + SummonedSkillList$SubTime[k[s1]]
      m <- ifelse(m==41, 1, m + 1)
      s1 <- ifelse(m<=10, 1, ifelse(m<=20, 2, ifelse(m<=40, 3, 4)))
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
      DC1[p, 2] <- DC1[p-1, 2] + SummonedSkillList$SubTime[k[s1]]
      t <- t + SummonedSkillList$SubTime[k[s1]]
      m <- ifelse(m==41, 1, m + 1)
      s1 <- ifelse(m<=10, 1, ifelse(m<=20, 2, ifelse(m<=40, 3, 4)))
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
AddATKCycleIllium <- function(DealCycle, CrystalGateActivationSkills, DestructionCoolTime) {
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
  
  ## SoulofCrystal
  for(i in 1:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("Destruction"))==1) {
      if(DealCycle$SoulofCrystal1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("DestructionSoul")
      }
      if(DealCycle$SoulofCrystal2[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("DestructionSoul")
      }
      if(DealCycle$SoulofCrystal2[i] > 0 & DealCycle$SoulofCrystal1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("JavelinAddATK")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("JavelinAddFragment")
      }
    } else if(max(DealCycle$Skills[i]==c("Domination"))==1) {
      if(DealCycle$SoulofCrystal1[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("DominationSoul")
      }
      if(DealCycle$SoulofCrystal2[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("DominationSoul")
      }
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