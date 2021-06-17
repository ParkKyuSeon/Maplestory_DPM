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