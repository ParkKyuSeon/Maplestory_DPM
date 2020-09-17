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
HeroDealCalc <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
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
  for(i in 1:(ncol(DealCycle)-5)) {
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
      Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK + DealCycle$ComboATK[i]) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR + DealCycle$ComboBDR[i]) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$ComboFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
  }
  return(Deal)
}
HeroDealCalcWithMaxDMR <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
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
      Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK + DealCycle$ComboATK[i]) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobGuard) / 100 * (100 + SpecEach$BDR + Skills$BDR + DealCycle$ComboBDR[i]) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR, DealCycle$ComboFDR[i])) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(PhysicsImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1)
      Deal[i] <- CutDam(Deal[i], SpecEach$Mastery, SpecEach$CDMR + Skills$CDMR) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
  }
  return(Deal)
}
HeroOptimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
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
      NewDeal[p] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
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
    NewDeal[1] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
        
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
          NewDeal[p+2] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList,  NewSpecs)))
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
HeroOptimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0) {
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
    PreDeal <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]])))
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
      NewDeal[i] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]])))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]])))
    } else {
      NewDeal[7] <- sum(na.omit(HeroDealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]])))
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