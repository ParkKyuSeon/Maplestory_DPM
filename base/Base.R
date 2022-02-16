## Package Loading
library(data.table)
library(parallel)


## Option Settings
options("scipen"=500)
options("max.print"=100000)


## DPM Data Frame Make
Dummy <- data.frame(t(rep(0, 45)))
Dummy <- rbind(Dummy, Dummy, Dummy, Dummy)
colnames(Dummy) <- job
rownames(Dummy) <- c("DPM", "DamageLeakage", "Restraint", "40s")
Dummy <- get0(DPMCalcOption$DataName, ifnotfound = Dummy)
assign(DPMCalcOption$DataName, Dummy)


## Optimization Data
if(exists("PotentialOpt") == F) {
  PotentialOpt <- list()
  PotentialOpt$Dummy <- data.frame(ATKP=rep(0, nrow(ChrInfo)), 
                                   IGR=rep(0, nrow(ChrInfo)), 
                                   BDR=rep(0, nrow(ChrInfo)), 
                                   row.names=ChrInfo$job, 
                                   stringsAsFactors=F)
}

if(exists("HyperStatOpt") == F) {
  HyperStatOpt <- list()
  HyperStatOpt$Dummy <- data.frame(MainStat=rep(0, nrow(ChrInfo)), 
                                   MainStatP=rep(0, nrow(ChrInfo)), 
                                   SubStat1=rep(0, nrow(ChrInfo)), 
                                   SubStat2=rep(0, nrow(ChrInfo)), 
                                   DMR=rep(0, nrow(ChrInfo)), 
                                   BDR=rep(0, nrow(ChrInfo)), 
                                   IGR=rep(0, nrow(ChrInfo)), 
                                   CRR=rep(0, nrow(ChrInfo)), 
                                   CDMR=rep(0, nrow(ChrInfo)), 
                                   ATK=rep(0, nrow(ChrInfo)), 
                                   row.names=ChrInfo$job, 
                                   stringsAsFactors=F)
}

if(DPMCalcOption$Optimization == T & sum(names(PotentialOpt) == DPMCalcOption$SpecSet) == 0) {
  PotentialOpt[[length(PotentialOpt)+1]] <- data.frame(ATKP=rep(0, nrow(ChrInfo)), 
                                                       IGR=rep(0, nrow(ChrInfo)), 
                                                       BDR=rep(0, nrow(ChrInfo)), 
                                                       row.names=ChrInfo$job, 
                                                       stringsAsFactors=F)
  HyperStatOpt[[length(HyperStatOpt)+1]] <- data.frame(MainStat=rep(0, nrow(ChrInfo)), 
                                                       MainStatP=rep(0, nrow(ChrInfo)), 
                                                       SubStat1=rep(0, nrow(ChrInfo)), 
                                                       SubStat2=rep(0, nrow(ChrInfo)), 
                                                       DMR=rep(0, nrow(ChrInfo)), 
                                                       BDR=rep(0, nrow(ChrInfo)), 
                                                       IGR=rep(0, nrow(ChrInfo)), 
                                                       CRR=rep(0, nrow(ChrInfo)), 
                                                       CDMR=rep(0, nrow(ChrInfo)), 
                                                       ATK=rep(0, nrow(ChrInfo)), 
                                                       row.names=ChrInfo$job, 
                                                       stringsAsFactors=F)
  names(PotentialOpt)[[length(PotentialOpt)]] <- DPMCalcOption$SpecSet
  names(HyperStatOpt)[[length(HyperStatOpt)]] <- DPMCalcOption$SpecSet
} else if(DPMCalcOption$Optimization == F & sum(names(PotentialOpt) == DPMCalcOption$SpecSet) == 0) {
  stop("No Optimization Data : Set Optimization Option as True")
}