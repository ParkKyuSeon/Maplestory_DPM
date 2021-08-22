MonsterLifeData <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/monsterlifedata.csv"
MonsterLifeData <- read.csv(MonsterLifeData, header=T, row.names=1, stringsAsFactors=F, encoding="EUC-KR")

MonsterLifeSpecs <- function(MonsterLifeData, Monsters) {
  MLSet <- MonsterLifeData[1, ]
  MLSet <- MLSet[-1, ]
  
  for(i in 1:length(Monsters)) {
    MLSet <- rbind(MLSet, subset(MonsterLifeData, rownames(MonsterLifeData)==Monsters[i]))
  }
  
  for(i in 1:nrow(MLSet)) {
    if(MLSet$SpecialCondition[i]==1 & nrow(rbind(subset(MLSet, rownames(MLSet)=="SleepyViking"), 
                                                 subset(MLSet, rownames(MLSet)=="TiredViking"), 
                                                 subset(MLSet, rownames(MLSet)=="EnoughViking"), 
                                                 subset(MLSet, rownames(MLSet)=="SeriousViking"))) < 4) {
      MLSet[i, 3:(ncol(MLSet)-1)] <- 0
    }
    if(MLSet$SpecialCondition[i]==2 & nrow(subset(MLSet, rownames(MLSet)=="Eunwol")) < 1) {
      MLSet[i, 3:(ncol(MLSet)-1)] <- 0
    } 
    if(MLSet$SpecialCondition[i]==3 & nrow(rbind(subset(MLSet, rownames(MLSet)=="DarkLumi"), 
                                                 subset(MLSet, rownames(MLSet)=="EquilLumi"), 
                                                 subset(MLSet, rownames(MLSet)=="LightLumi"))) < 3) {
      MLSet[i, 3:(ncol(MLSet)-1)] <- 0
    }
  }
  
  Categories <- unique(MLSet$Category)
  
  MLSetFinal <- MLSet[1, ]
  MLSetFinal <- MLSetFinal[-1, ]
  for(i in 1:length(Categories)) {
    MLSet1 <- subset(MLSet, MLSet$Category==Categories[i])
    if(Categories[i]!="Special") {
      if(nrow(subset(MLSet1, MLSet1$Rank=="SS")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="SS")[1, ])
      } else if(nrow(subset(MLSet1, MLSet1$Rank=="S")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="S")[1, ])
      } else if(nrow(subset(MLSet1, MLSet1$Rank=="A+")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="A+")[1, ])
      } else if(nrow(subset(MLSet1, MLSet1$Rank=="A")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="A")[1, ])
      } else if(nrow(subset(MLSet1, MLSet1$Rank=="B+")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="B+")[1, ])
      } else if(nrow(subset(MLSet1, MLSet1$Rank=="B")) >= 1) {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="B")[1, ])
      } else {
        MLSetFinal <- rbind(MLSetFinal, subset(MLSet1, MLSet1$Rank=="C")[1, ])
      }
    } else {
      MLSetFinal <- rbind(MLSetFinal, MLSet1)
    }
  }
  
  MLSetFinal <- rbind(MLSetFinal, MLSetFinal[nrow(MLSetFinal), ])
  rownames(MLSetFinal)[nrow(MLSetFinal)] <- "Sum"
  MLSetFinal[nrow(MLSetFinal), 3:ncol(MLSetFinal)] <- 0
  for(i in 3:(ncol(MLSetFinal)-1)) {
    if(colnames(MLSetFinal)[i]!="IGR") {
      MLSetFinal[nrow(MLSetFinal), i] <- sum(MLSetFinal[, i])
    } else {
      MLSetFinal[nrow(MLSetFinal), i] <- IGRCalc(c(MLSetFinal[1:(nrow(MLSetFinal)-1), i]))
    }
  }
  return(MLSetFinal[nrow(MLSetFinal), 3:(ncol(MLSetFinal)-1)])
}


## Monster Life Preset (6~8 Empty Slots : 8 in level 1, 7 in level 2, 6 in level 3)
### Farm Level 21(22 Slots) + No Bigeup, Serf, MiniSpider, LightLumi, PinkBean, SS mix monsters
#### STR Type 1-1 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=F
MLTypeS11 <- MonsterLifeSpecs(MonsterLifeData, c("FrankenRoid", "Leica", "ReeperSpecter", "EliteBloodTooth", 
                                                 "VonLeon", "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking", "Cygnus", "BlackViking", 
                                                 "Hilla", "Akairum", "PapulatusClock", "Beril", "Oberon", "ReinforcedBeril", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul", "YetiPharaoh"))
#### Shinsoo, Timer

#### STR Type 1-2 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=T


### Farm Level 30(26 Slots) + No Bigeup, Serf, MiniSpider, LightLumi, Pierre, VonBon
#### STR Type 2-1 : STR, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeS21 <- MonsterLifeSpecs(MonsterLifeData, c("FrankenRoid", "ReeperSpecter", "Leica", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking", 
                                                 "Oberon", "Beril", "AkairumPriest", "PapulatusClock", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### STR Type 2-2 : STR, SummonedDuration=F, FinalATKDMR=T, CRR=F
MLTypeS22 <- MonsterLifeSpecs(MonsterLifeData, c("FrankenRoid", "ReeperSpecter", "Leica", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking", 
                                                 "Oberon", "Beril", "Puso", "AkairumPriest", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### STR Type 2-3 : STR, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeS23 <- MonsterLifeSpecs(MonsterLifeData, c("FrankenRoid", "ReeperSpecter", "Leica", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking", 
                                                 "Oberon", "GoldYeti", "CoupleYeti", "AkairumPriest", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### HP Type 2-1 : HP, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeH21 <- MonsterLifeSpecs(MonsterLifeData, c("ModifiedFireBoar", "Dodo", "Leica", "NineTailedFox", "AkairumPriest",  
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking", 
                                                 "CoupleYeti", "Oberon", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", "RomantistKingSlime",
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### DEX Type 2-1 : DEX, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeD21 <- MonsterLifeSpecs(MonsterLifeData, c("Lilinoch", "Taeryun", "AkairumPriest", "Papulatus", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "Beril", "PapulatusClock", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### DEX Type 2-2 : DEX, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeD22 <- MonsterLifeSpecs(MonsterLifeData, c("Lilinoch", "Taeryun", "AkairumPriest", "Papulatus", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "GoldYeti", "CoupleYeti", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### DEX Type 2-3 : DEX, SummonedDuration=F, FinalATKDMR=T, CRR=F
MLTypeD23 <- MonsterLifeSpecs(MonsterLifeData, c("Lilinoch", "Taeryun", "AkairumPriest", "Papulatus", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "Beril", "Puso", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli",  
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### DEX Type 2-4 : DEX, SummonedDuration=T, FinalATKDMR=T, CRR=F
MLTypeD24 <- MonsterLifeSpecs(MonsterLifeData, c("Lilinoch", "Taeryun", "AkairumPriest", "CoupleYeti", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "GoldYeti", "Puso", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli",  
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### INT Type 2-1 : INT, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeI21 <- MonsterLifeSpecs(MonsterLifeData, c("Timer", "MachineMT09", "ReeperSpecter", "AkairumPriest", "NineTailedFox",
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "Beril", "PapulatusClock", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### INT Type 2-2 : INT, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeI22 <- MonsterLifeSpecs(MonsterLifeData, c("Timer", "MachineMT09", "ReeperSpecter", "AkairumPriest", "NineTailedFox",
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "GoldYeti", "CoupleYeti", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### LUK Type 2-1 : LUK, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeL21 <- MonsterLifeSpecs(MonsterLifeData, c("Dunas", "Hogeol", "Papulatus", "LightSoul", "AkairumPriest", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "Beril", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### LUK Type 2-2 : LUK, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeL22 <- MonsterLifeSpecs(MonsterLifeData, c("Dunas", "Hogeol", "Papulatus", "LightSoul", "AkairumPriest", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "CoupleYeti", "GoldYeti", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

#### Allstat Type 2-1 : ALLSTAT(Xenon), SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeA21 <- MonsterLifeSpecs(MonsterLifeData, c("Hogeol", "Leica", "Papulatus", "Taeryun", "AkairumPriest", "NineTailedFox", 
                                                 "VikingCorps", "SleepyViking", "TiredViking", "EnoughViking", "SeriousViking",
                                                 "Oberon", "Beril", "Phantom", "Eunwol", "Rang",
                                                 "VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", "Scarecrow", "Lazuli", 
                                                 "WolmyoThief", "ToyKnight", "IncongruitySoul", "YetiPharaoh"))
#### Shinsoo, EliteBloodTooth, YetiPharaoh

### Farm Level 40(28 Slots)
#### STR Type 3-1 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=F