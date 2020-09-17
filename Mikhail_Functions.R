## Mikhail Function
RoyalGuardCycle <- function(DealCycle, ATKSkillList, RoyalGuardCoolTime) {
  RGCool <- RoyalGuardCoolTime * 1000
  RG <- subset(DealCycle, DealCycle$Skills=="RoyalGuard")
  if(nrow(RG)==0) {
    DealCycle[1, 2:ncol(DealCycle)] <- 0
    DealCycle <- DCATK(DealCycle, "RoyalGuard", ATKSkillList)
  } else {
    if(DealCycle$Time[nrow(DealCycle)] - RG$Time[nrow(RG)] >= RGCool) {
      DealCycle[1, 2:ncol(DealCycle)] <- 0
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
    if(DealCycle$Skills[i]=="LightofCourageEnd") {
      DealCycle$LightofCourageBuff[i] <- 0
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]!="LightofCourageBuff" & DealCycle$LightofCourageBuff[i] > 0) {
      DealCycle$LightofCourageBuff[i] <- ifelse(DealCycle$LightofCourageBuff[i-1]>0, max(DealCycle$LightofCourageBuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DeadlyChargeBuff") {
      DealCycle$DeadlyChargeBuff[i] <- 0
    } else if(DealCycle$Skills[i]=="DeadlyCharge") {
      DealCycle$DeadlyChargeBuff[i] <- 0
    }
  }
  return(DealCycle)
}
AuraWeaponCycleMikhail <- function(DealCycle) {
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
  return(DealCycle)
}
AddATKCycleMikhail <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SoulAssault", "ShiningCross", "RoyalGuard", "DeadlyCharge", "ClaiomhSolais", "SoulLightSlash"))>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SoulAssault", "ShiningCross", "RoyalGuard", "DeadlyCharge", "ClaiomhSolais", "SoulLightSlash"))>0 & DealCycle$LightofCourageBuff[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("LightofCourageAddAttack")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}