## Options Setting
DPMCalcOption <- data.frame(SpecSet = "SpecDefault", 
                            ZeroSpecSet = "SpecDefaultZero", 
                            XenonSpecSet = "SpecDefaultXenon_A6S6", 
                            XenonSpecSetAlt = "SpecDefaultXenon_A6A3", 
                            DemonAvengerSpecSet = "SpecDefaultDemonAvenger", 
                            MobSet = "MobDefault", 
                            MonsterLifeLevel = 2, ## Not a Monster Life Farm Level
                            WeaponSF = 17, 
                            DemonAvengerSF = 264, 
                            Optimization = T, 
                            OptdataDelete = T,
                            DataName = "DPM12352", 
                            
                            DualBladeBladeType = "AB", 
                            stringsAsFactors=F)
CSVExportOption <- data.frame(Leakage = F, 
                              OrderBy = "DPM", ## Default, JobName, DPM, Restratint, 40s
                              RatioStandard = "Bishop", ## Bishop, Minimum, Maximum
                              FileName = "DPM12352",
                              
                              stringsAsFactors=F)


## DPM Data Frame Make
Dummy <- data.frame(t(rep(0, 45)))
Dummy <- rbind(Dummy, Dummy, Dummy, Dummy)
colnames(Dummy) <- job
rownames(Dummy) <- c("DPM", "DamageLeakage", "Restraint", "40s")
assign(DPMCalcOption$DataName, Dummy)


## Ability List, Link List, Monster Life List Preset
SpecDefaultAbility <- data.frame(Ability1=rep("", nrow(ChrInfo)), 
                                 Ability2=rep("", nrow(ChrInfo)), 
                                 row.names=ChrInfo$job, 
                                 stringsAsFactors=F)
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Hero", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Palladin", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="DarkKnight", ] <- c("BuffDuration", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="ArchMageFP", ] <- c("BuffDuration", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="ArchMageTC", ] <- c("BuffDuration", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Bishop", ] <- c("BuffDuration", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Bowmaster", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Marksman", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="PathFinder", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="NightLord", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Shadower", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="DualBlader", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Viper", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Captain", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="CannonMaster", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Mikhail", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="SoulMaster", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="FlameWizard", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="WindBreaker", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="NightWalker", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Striker", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Aran", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Evan", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Luminous", ] <- c("BuffDuration", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Mercedes", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Phantom", ] <- c("BDR", "BuffDuration")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Eunwol", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Blaster", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="BattleMage", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="WildHunter", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Xenon", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Mechanic", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="DemonSlayer", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="DemonAvenger", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Kaiser", ] <- c("BDR", "BuffDuration")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Kain", ] <- c("PassiveLv", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Cadena", ] <- c("CoolTimeReset", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="AngelicBuster", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Adele", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Illium", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Ark", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Lara", ] <- c("PassiveLv", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Hoyeong", ] <- c("PassiveLv", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Zero", ] <- c("BDR", "DisorderBDR")
SpecDefaultAbility[rownames(SpecDefaultAbility)=="Kinesis", ] <- c("PassiveLv", "DisorderBDR")

SpecDefaultLink <- data.frame(Link1=rep("", nrow(ChrInfo)), 
                              Link2=rep("", nrow(ChrInfo)), 
                              Link3=rep("", nrow(ChrInfo)), 
                              Link4=rep("", nrow(ChrInfo)), 
                              row.names=ChrInfo$job, 
                              stringsAsFactors=F)
SpecDefaultLink[rownames(SpecDefaultLink)=="Hero", ] <- c("AdventureWarrior", "AdventureBowman", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Palladin", ] <- c("AdventureWarrior", "Xenon", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="DarkKnight", ] <- c("Xenon", "CygnusKnights", "DemonAvenger", "AdventureWarrior")
SpecDefaultLink[rownames(SpecDefaultLink)=="ArchMageFP", ] <- c("Zero", "Mikhail", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="ArchMageTC", ] <- c("Zero", "Mikhail", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Bishop", ] <- c("Zero", "Mikhail", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Bowmaster", ] <- c("Mikhail", "DemonAvenger", "Phantom", "AdventureBowman")
SpecDefaultLink[rownames(SpecDefaultLink)=="Marksman", ] <- c("AdventureBowman", "Mikhail", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="PathFinder", ] <- c("AdventureBowman", "Phantom", "DemonAvenger", "Mikhail")
SpecDefaultLink[rownames(SpecDefaultLink)=="NightLord", ] <- c("Mikhail", "Xenon", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Shadower", ] <- c("CygnusKnights", "Mikhail", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="DualBlader", ] <- c("CygnusKnights", "Xenon", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Viper", ] <- c("AdventurePirates", "Xenon", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Captain", ] <- c("AdventurePirates", "Mikhail", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="CannonMaster", ] <- c("Xenon", "DemonAvenger", "AdventurePirates", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Mikhail", ] <- c("Mikhail", "Xenon", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="SoulMaster", ] <- c("CygnusKnights", "Zero", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="FlameWizard", ] <- c("CygnusKnights", "Mikhail", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="WindBreaker", ] <- c("Mikhail", "CygnusKnights", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="NightWalker", ] <- c("CygnusKnights", "Mikhail", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Striker", ] <- c("CygnusKnights", "Xenon", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Aran", ] <- c("Xenon", "Aran", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Evan", ] <- c("Xenon", "DemonAvenger", "Evan", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Luminous", ] <- c("Xenon", "Phantom", "DemonAvenger", "Mikhail")
SpecDefaultLink[rownames(SpecDefaultLink)=="Mercedes", ] <- c("Mikhail", "Mercedes", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Phantom", ] <- c("Phantom", "DemonAvenger", "Mikhail", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="Eunwol", ] <- c("Eunwol", "DemonAvenger", "Phantom", "AdventureBowman")
SpecDefaultLink[rownames(SpecDefaultLink)=="Blaster", ] <- c("CygnusKnights", "DemonAvenger", "Xenon", "Zero")
SpecDefaultLink[rownames(SpecDefaultLink)=="BattleMage", ] <- c("CygnusKnights", "Illium", "DemonAvenger", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="WildHunter", ] <- c("Xenon", "DemonAvenger", "Mikhail", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Xenon", ] <- c("CygnusKnights", "DemonAvenger", "Xenon", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Mechanic", ] <- c("CygnusKnights", "Xenon", "DemonAvenger", "Zero")
SpecDefaultLink[rownames(SpecDefaultLink)=="DemonSlayer", ] <- c("Xenon", "DemonAvenger", "CygnusKnights", "Zero")
SpecDefaultLink[rownames(SpecDefaultLink)=="DemonAvenger", ] <- c("Kaiser", "Phantom", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Kaiser", ] <- c("Kaiser", "Mikhail", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="Kain", ] <- c("Kain", "Mikhail", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="Cadena", ] <- c("Xenon", "DemonAvenger", "CygnusKnights", "Mikhail")
SpecDefaultLink[rownames(SpecDefaultLink)=="AngelicBuster", ] <- c("Xenon", "Phantom", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Adele", ] <- c("Adele", "CygnusKnights", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="Illium", ] <- c("Phantom", "DemonAvenger", "Xenon", "Eunwol") ## Eunwol : Dummy
SpecDefaultLink[rownames(SpecDefaultLink)=="Ark", ] <- c("Zero", "Xenon", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Lara", ] <- c("Lara", "Mikhail", "DemonAvenger", "Xenon")
SpecDefaultLink[rownames(SpecDefaultLink)=="Hoyeong", ] <- c("Mikhail", "Hoyeong", "DemonAvenger", "CygnusKnights")
SpecDefaultLink[rownames(SpecDefaultLink)=="Zero", ] <- c("Mikhail", "DemonAvenger", "Zero", "Phantom")
SpecDefaultLink[rownames(SpecDefaultLink)=="Kinesis", ] <- c("Phantom", "CygnusKnights", "DemonAvenger", "Xenon")

SpecDefaultCoolReduceHat <- data.frame(CoolReduceHat=rep("", nrow(ChrInfo)), 
                                       row.names=ChrInfo$job, 
                                       stringsAsFactors=F)
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Hero", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Palladin", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="DarkKnight", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="ArchMageFP", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="ArchMageTC", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Bishop", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Bowmaster", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Marksman", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="PathFinder", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="NightLord", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Shadower", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="DualBlader", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Viper", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Captain", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="CannonMaster", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Mikhail", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="SoulMaster", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="FlameWizard", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="WindBreaker", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="NightWalker", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Striker", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Aran", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Evan", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Luminous", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Mercedes", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Phantom", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Eunwol", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Blaster", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="BattleMage", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="WildHunter", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Xenon", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Mechanic", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="DemonSlayer", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="DemonAvenger", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Kaiser", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Kain", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Cadena", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="AngelicBuster", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Adele", ] <- T
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Illium", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Ark", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Lara", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Hoyeong", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Zero", ] <- F
SpecDefaultCoolReduceHat[rownames(SpecDefaultCoolReduceHat)=="Kinesis", ] <- F

MonsterLifePreSet <- data.frame(Level1=rep("", nrow(ChrInfo)), 
                                Level2=rep("", nrow(ChrInfo)), 
                                Level3=rep("", nrow(ChrInfo)), 
                                row.names=ChrInfo$job, 
                                stringsAsFactors=F)
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Hero", ] <- c("", "MLTypeS22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Palladin", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="DarkKnight", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="ArchMageFP", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="ArchMageTC", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Bishop", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Bowmaster", ] <- c("", "MLTypeD23", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Marksman", ] <- c("", "MLTypeD21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="PathFinder", ] <- c("", "MLTypeD21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="NightLord", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Shadower", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="DualBlader", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Viper", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Captain", ] <- c("", "MLTypeD24", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="CannonMaster", ] <- c("", "MLTypeS23", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Mikhail", ] <- c("", "MLTypeS22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="SoulMaster", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="FlameWizard", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="WindBreaker", ] <- c("", "MLTypeD21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="NightWalker", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Striker", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Aran", ] <- c("", "MLTypeS22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Evan", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Luminous", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Mercedes", ] <- c("", "MLTypeD23", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Phantom", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Eunwol", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Blaster", ] <- c("", "MLTypeS22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="BattleMage", ] <- c("", "MLTypeI21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="WildHunter", ] <- c("", "MLTypeD23", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Xenon", ] <- c("", "MLTypeA21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Mechanic", ] <- c("", "MLTypeD22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="DemonSlayer", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="DemonAvenger", ] <- c("", "MLTypeH21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Kaiser", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Kain", ] <- c("", "MLTypeD21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Cadena", ] <- c("", "MLTypeL21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="AngelicBuster", ] <- c("", "MLTypeD21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Adele", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Illium", ] <- c("", "MLTypeI22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Ark", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Lara", ] <- c("", "MLTypeI22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Hoyeong", ] <- c("", "MLTypeL22", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Zero", ] <- c("", "MLTypeS21", "")
MonsterLifePreSet[rownames(MonsterLifePreSet)=="Kinesis", ] <- c("", "MLTypeI21", "")


## Optimization Data
if(DPMCalcOption$Optimization == T & DPMCalcOption$OptdataDelete == T & sum(names(PotentialOpt) == DPMCalcOption$SpecSet) >= 1) {
  Idx1 <- c()
  for(i in 1:length(PotentialOpt)) {
    if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
      Idx1 <- i
    }
  }
  PotentialOpt[[Idx1]][ , ] <- 0
  HyperStatOpt[[Idx1]][ , ] <- 0
} else if(DPMCalcOption$Optimization == T & sum(names(PotentialOpt) == DPMCalcOption$SpecSet) == 0) {
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
}


## Sourcing and Calculation
source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/job/BattleMage.R")


## Make csv File
FinalData <- get(DPMCalcOption$DataName)
FinalData <- data.frame(t(FinalData))
FinalData <- round(FinalData)
colnames(FinalData)[4] <- "X40s"

if(CSVExportOption$OrderBy == "JobName") {
  FinalData <- FinalData[order(rownames(FinalData)), ]
} else if(CSVExportOption$OrderBy == "DPM") {
  FinalData <- FinalData[order(FinalData$DPM, decreasing=T), ]
} else if(CSVExportOption$OrderBy == "Restraint") {
  FinalData <- FinalData[order(FinalData$Restraint, decreasing=T), ]
} else if(CSVExportOption$OrderBy == "40s") {
  FinalData <- FinalData[order(FinalData$X40s, decreasing=T), ]
}

if(CSVExportOption$RatioStandard=="Bishop") {
  StandardDPM <- FinalData[rownames(FinalData)=="Bishop", ]$DPM
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- FinalData[rownames(FinalData)=="Bishop", ]$Restraint
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- FinalData[rownames(FinalData)=="Bishop", ]$X40s
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
} else if(CSVExportOption$RatioStandard=="Maximum") {
  StandardDPM <- max(FinalData$DPM)
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- max(FinalData$Restraint)
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- max(FinalData$X40s)
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
} else if(CSVExportOption$RatioStandard=="Minimum") {
  StandardDPM <- min(FinalData$DPM)
  FinalData$DPMRatio <- FinalData$DPM / StandardDPM
  
  StandardRR <- min(FinalData$Restraint)
  FinalData$RestraintRatio <- FinalData$Restraint / StandardRR
  
  Standard40s <- min(FinalData$X40s)
  FinalData$X40sRatio <- FinalData$X40s / Standard40s
}
FinalData$DPMRatio <- round(FinalData$DPMRatio, 4)
FinalData$RestraintRatio <- round(FinalData$RestraintRatio, 4)
FinalData$X40sRatio <- round(FinalData$X40sRatio, 4)

FinalData <- FinalData[, c(1, 5, 3, 6, 4, 7, 2)]
colnames(FinalData)[5:6] <- c("40s", "40sRatio")

if(CSVExportOption$Leakage == F) {
  FinalData <- FinalData[, -7]
}

write.csv(FinalData, paste(CSVExportOption$FileName, ".csv", sep=""))