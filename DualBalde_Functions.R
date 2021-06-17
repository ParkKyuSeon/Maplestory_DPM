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
    if(sum(DealCycle$Skills[i]==c("PhantomBlow", "FinalCut", "SuddenRaid", "Asura", "BladeStormPre", "BladeStorm", "KarmaFury", "BladeTornadoPre", "BladeTornado"))>0 & DealCycle$HiddenBlade[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("HiddenBlade")
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}