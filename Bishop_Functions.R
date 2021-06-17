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
        if(DealCycle$Skills[rowInd]=="AngelRay" | DealCycle$Skills[rowInd]=="DivinePunishment" | DealCycle$Skills[rowInd]=="PeaceMaker" | DealCycle$Skills[rowInd]=="PeaceMakerExplosion") {
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
UnstableData <- function(DealCycle, UnstableProb, InfinityDuration, InfinityCoolTime, UsefulSkillDuration) {
  Infs <- DealCycle[DealCycle$Skills=="Infinity", ]
  Uns <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  
  inftime <- Infs$Time
  unstime <- Uns$Time
  
  times <- (Uns$Time - Infs$Time) / 1000 + InfinityDuration
  prob <- UnstableProb
  for(i in 2:length(times)) {
    prob[i] <- UnstableProb * (1 - sum(prob[1 : i-1]))
  }
  times[length(times)+1] <- InfinityCoolTime
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
  
  remaintimes <- c()
  for(i in 1:length(times)) {
    remaintimes[i] <- max(times[i] - (UsefulSkillDuration - 3), 0) * prob[i]
  }
  remain <- sum(remaintimes)
  uns <- list(unsdata, remain, weightsum)
  names(uns) <- c("UnsRatio", "BuffNeeded", "DealCycleTime")
  
  return(uns)
}
BishopDealCalc <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata) {
  a <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
    ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
    ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
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
    
    Deal <- c()
    for(i in 2:nrow(DealCycle)) {
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
        Deal[i] <- 0
      } else {
        Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
          (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
          CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$InfinityFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
          ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1) * Skills$AttackTimes
      }
    }
    return(Deal)
  }
  
  BishopDeal1 <- a(DealCycle1, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  BishopDeal2 <- a(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  
  Deal1 <- data.frame(DealCycle1$Skills, DealCycle1$Infinity, BishopDeal1)
  colnames(Deal1) <- c("Skills", "Infinity", "Deal")
  D1 <- Deal1[(Deal1$Skills=="Infinity" | Deal1$Skills=="UnstableMemorizePre"), ]
  Ind <- c(as.numeric(rownames(D1)), nrow(Deal1))
  
  Deals <- c()
  for(i in 1:(length(Ind)-3)) {
    Deals[i] <- (sum(na.omit(Deal1$Deal[1:Ind[i+1]])) + sum(na.omit(Deal1$Deal[Ind[length(Ind)-1]:Ind[length(Ind)]]))) * Unsdata$UnsRatio$weight[i]
  }
  D2 <- Deal1[1:Ind[length(Ind)-1], ]
  DealWithoutUns <- (sum(na.omit(D2$Deal)) + sum(na.omit(BishopDeal2))) * 0.5 * Unsdata$UnsRatio$weight[length(Unsdata$UnsRatio$weight)]
  DealFinal <- sum(Deals) + DealWithoutUns
  return(DealFinal)
}
BishopDealCalcWithMaxDMR <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata) {
  a <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
    ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
    ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
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
    
    Deal <- c()
    for(i in 2:nrow(DealCycle)) {
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
        Deal[i] <- 0
      } else {
        Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
          (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
          CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$InfinityFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
          ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1)
        Deal[i] <- CutDam(Deal[i], SpecEach$Mastery, SpecEach$CDMR + Skills$CDMR) * Skills$AttackTimes
      }
    }
    return(Deal)
  }
  
  BishopDeal1 <- a(DealCycle1, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  BishopDeal2 <- a(DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  
  Deal1 <- data.frame(DealCycle1$Skills, DealCycle1$Infinity, BishopDeal1)
  colnames(Deal1) <- c("Skills", "Infinity", "Deal")
  D1 <- Deal1[(Deal1$Skills=="Infinity" | Deal1$Skills=="UnstableMemorizePre"), ]
  Ind <- c(as.numeric(rownames(D1)), nrow(Deal1))
  
  Deals <- c()
  for(i in 1:(length(Ind)-3)) {
    Deals[i] <- (sum(na.omit(Deal1$Deal[1:Ind[i+1]])) + sum(na.omit(Deal1$Deal[Ind[length(Ind)-1]:Ind[length(Ind)]]))) * Unsdata$UnsRatio$weight[i]
  }
  D2 <- Deal1[1:Ind[length(Ind)-1], ]
  DealWithoutUns <- (sum(na.omit(D2$Deal)) + sum(na.omit(BishopDeal2))) * 0.5 * Unsdata$UnsRatio$weight[length(Unsdata$UnsRatio$weight)]
  DealFinal <- sum(Deals) + DealWithoutUns
  return(DealFinal)
}
BishopOptimization1 <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, Unsdata) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, Unsdata)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
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
      NewDeal[p] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
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
    NewDeal[1] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
        
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
          NewDeal[p+2] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, Unsdata)))
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
BishopOptimization2 <- function(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, Unsdata, HyperStanceLv=0) {
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
    PreDeal <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], Unsdata)))
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
      NewDeal[i] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], Unsdata)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Unsdata)))
    } else {
      NewDeal[7] <- sum(na.omit(BishopDealCalc(DealCycle1, DealCycle2, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], Unsdata)))
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
BishopDealCalcGeneral <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
  a <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
    ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
    ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
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
    
    Deal <- c()
    for(i in 2:nrow(DealCycle)) {
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
        Deal[i] <- 0
      } else {
        Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
          (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
          CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$InfinityFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
          ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1)
        Deal[i] <- CutDam(Deal[i], SpecEach$Mastery, SpecEach$CDMR + Skills$CDMR) * Skills$AttackTimes
      }
    }
    return(Deal)
  }
  
  BishopDeal1 <- a(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  return(BishopDeal1)
}
BishopDealCalcGeneralWithoutMax <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
  a <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
    ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
    ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
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
    
    Deal <- c()
    for(i in 2:nrow(DealCycle)) {
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
        Deal[i] <- 0
      } else {
        Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
          (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
          CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$InfinityFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
          ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1)
        Deal[i] <- Deal[i] * Skills$AttackTimes
      }
    }
    return(Deal)
  }
  
  BishopDeal1 <- a(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  return(BishopDeal1)
}
BishopDealRatio <- function(DealCycle1, DealCycle2, DealData1, DealData2, UnsData) {
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
  Weight[1:(length(DealRatios)-2)] <- Unsdata$UnsRatio$weight[1:(length(DealRatios)-2)]
  Weight[(length(DealRatios)-1):(length(DealRatios))] <- Unsdata$UnsRatio$weight[(length(DealRatios)-1)] / 2
  
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