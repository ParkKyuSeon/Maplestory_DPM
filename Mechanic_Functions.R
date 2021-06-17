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
RM1Cycle <- function(DealCycle, RM1Duration, RM1CoolTime, SummonedSkillList) {
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
  return(DealCycle)
}
MechanicAddATKCycle <- function(DealCycle, ATKSkillList) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MetalArmorFullburstBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "HomingMissileMetalArmorFullBust"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "HomingMissileMetalArmorFullBust", 15, 0, ATKSkillList)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MassiveFire" & DealCycle$MetalArmorFullburstExhaust[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissile")
    } else if(DealCycle$Skills[i]=="HomingMissileMetalArmorFullBust") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissile")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HomingMissile" & DealCycle$BomberTime[i]>0 & DealCycle$MetalArmorFullburstExhaust[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HomingMissileBomberTime")
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
LuckyDiceDealCalc <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, LuckyDiceProb=c(0.752405723, 0.240369277, 0.007225)) {
  DC1 <- DealCycle
  DC2 <- DealCycle
  DC2$LuckyDice5 <- 0
  DC2$LuckyDice55 <- 1
  DC3 <- DealCycle
  DC3$LuckyDice5 <- 0
  DC3$LuckyDice555 <- 1
  
  Deal1 <- DealCalc(DC1, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[1]
  Deal2 <- DealCalc(DC2, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[2]
  Deal3 <- DealCalc(DC3, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[3]
  return(Deal1 + Deal2 + Deal3)
} ## Base prob is prob of LuckyDice Lv 5
LuckyDiceDealCalcWithMaxDMR <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, LuckyDiceProb=c(0.752405723, 0.240369277, 0.007225)) {
  DC1 <- DealCycle
  DC2 <- DealCycle
  DC2$LuckyDice5 <- 0
  DC2$LuckyDice55 <- 1
  DC3 <- DealCycle
  DC3$LuckyDice5 <- 0
  DC3$LuckyDice555 <- 1
  
  Deal1 <- DealCalcWithMaxDMR(DC1, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[1]
  Deal2 <- DealCalcWithMaxDMR(DC2, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[2]
  Deal3 <- DealCalcWithMaxDMR(DC3, ATKSkillsList, BuffList, SummonedSkillsList, Specs) * LuckyDiceProb[3]
  return(Deal1 + Deal2 + Deal3)
}
LuckyDiceOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, LuckyDiceProb=c(0.752405723, 0.240369277, 0.007225)) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, LuckyDiceProb)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
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
      NewDeal[p] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
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
    NewDeal[1] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
        
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
          NewDeal[p+2] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, LuckyDiceProb)))
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
LuckyDiceOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, LuckyDiceProb=c(0.752405723, 0.240369277, 0.007225)) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  
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
    PreDeal <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], LuckyDiceProb)))
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
      NewDeal[i] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], LuckyDiceProb)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], LuckyDiceProb)))
    } else {
      NewDeal[7] <- sum(na.omit(LuckyDiceDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], LuckyDiceProb)))
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
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(lvs)
  return(Specs)
}