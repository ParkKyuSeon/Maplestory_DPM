MonsterLifeData <- read.csv("data/monsterlifedata.csv", header=T, row.names=1, stringsAsFactors=F, encoding="UTF-8")

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
#### STR Type 3-1 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeS31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "MasterRednug", 
                                                 "Bigeup", "IncongruitySoul", "FrankenRoid", "Leica", "ReeperSpecter",
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox", "KingSlime"))
#### EliteBloodTooth, DemonWarrior, ThiefCrow, Ifrit

#### STR Type 3-2 : STR, SummonedDuration=F, BuffDuration=T, FinalATKDMR=F, CRR=F
MLTypeS32 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", 
                                                 "Lazuli", "Tinman", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "MasterRednug", 
                                                 "IncongruitySoul", "FrankenRoid", "Leica", "DemonWarrior",
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox", "PapulatusClock"))
#### EliteBloodTooth, AkairumPriest, Victor, Ifrit

#### STR Type 3-3 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=T, CRR=T
MLTypeS33 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "Pierre", 
                                                 "Puso", "Bigeup", "IncongruitySoul", "FrankenRoid", "Leica", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox", "Targa"))
#### EliteBloodTooth, KingSlime, ThiefCrow, Ifrit


#### STR Type 3-5 : STR, SummonedDuration=T, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeS35 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "BigPumpkin", 
                                                 "CoupleYeti", "GoldYeti", "IncongruitySoul", "FrankenRoid", "Leica", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox", "KingSlime"))
#### EliteBloodTooth, Giant, ThiefCrow, Ifrit


#### HP Type 3-1 : HP(DemonAvenger), SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeH31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "GiantDarkSoul", "InnerRage", "Tinman", "SmallBalloon", "KingCastleGolem", 
                                                 "Bigeup", "IncongruitySoul", "Dodo", "ModifiedFireBoar", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "KingSlime", "NineTailedFox", "Giant"))
#### EliteBloodTooth, StrangeMonster, ThiefCrow, PrimeMinister


#### DEX Type 3-1 : DEX, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeD31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "MasterRelic", 
                                                 "Bigeup", "IncongruitySoul", "Lilinoch", "Taeryun", "AkairumPriest", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox"))
#### EliteBloodTooth, KingSlime, GuwaruVestige, Ifrit

#### DEX Type 3-2 : DEX, SummonedDuration=F, BuffDuration=F, FinalATKDMR=T, CRR=T
MLTypeD32 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "Pierre", 
                                                 "Puso", "Bigeup", "IncongruitySoul", "Lilinoch", "Taeryun", "AkairumPriest", 
                                                 "Targa", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox"))
#### EliteBloodTooth, KingSlime, ThiefCrow, Ifrit

#### DEX Type 3-3 : DEX, SummonedDuration=T, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeD33 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "BigPumpkin", 
                                                 "CoupleYeti", "GoldYeti", "IncongruitySoul", "Lilinoch", "Taeryun", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox", "KingSlime"))
#### EliteBloodTooth, Giant, ThiefCrow, Ifrit

#### DEX Type 3-4 : DEX, SummonedDuration=T, BuffDuration=F, FinalATKDMR=T, CRR=F
MLTypeD34 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "Tinman", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "Pierre", 
                                                 "CoupleYeti", "GoldYeti", "IncongruitySoul", "Lilinoch", "Taeryun", "PapulatusClock", 
                                                 "Targa", "Oberon", "SeriousViking", "WolmyoThief", "NineTailedFox"))
#### EliteBloodTooth, Victor, ThiefCrow, Ifrit

#### INT Type 3-1 : INT, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeI31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "MasterMargana", 
                                                 "Bigeup", "IncongruitySoul", "Timer", "MachineMT09", "AkairumPriest", "DemonMagician", 
                                                 "ToyKnight", "Oberon", "WolmyoThief", "NineTailedFox", "Ifrit"))
#### EliteBloodTooth, KingSlime, ThiefCrow, SeriousViking

#### INT Type 3-2 : INT, SummonedDuration=F, BuffDuration=T, FinalATKDMR=F, CRR=T
MLTypeI32 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "Will", "VonBon", "HugeSpider", 
                                                 "MiniSpider", "IncongruitySoul", "Timer", "MachineMT09", "AkairumPriest", "ReeperSpecter", 
                                                 "ToyKnight", "Oberon", "WolmyoThief", "NineTailedFox"))
#### SeriousViking, EliteBloodTooth, KingSlime, Grief

#### INT Type 3-3 : INT, SummonedDuration=F, BuffDuration=T, FinalATKDMR=F, CRR=F
MLTypeI33 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", 
                                                 "Lazuli", "Tinman", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "Will", "VonBon", "HugeSpider", 
                                                 "MiniSpider", "IncongruitySoul", "Timer", "MachineMT09", "AkairumPriest", "PapulatusClock", 
                                                 "ToyKnight", "Oberon", "WolmyoThief", "NineTailedFox"))
#### SeriousViking, EliteBloodTooth, Victor, Grief

#### INT Type 3-5 : INT, SummonedDuration=T, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeI35 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "BigPumpkin", 
                                                 "CoupleYeti", "GoldYeti", "IncongruitySoul", "Timer", "MachineMT09", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "Ifrit", "NineTailedFox"))
#### EliteBloodTooth, Giant, ThiefCrow, KingSlime

#### LUK Type 3-1 : LUK, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeL31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "MasterHisab", 
                                                 "Bigeup", "IncongruitySoul", "Dunas", "Hogeol", "Papulatus", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "Ifrit", "NineTailedFox"))
#### EliteBloodTooth, ThiefCrow, KingSlime, Ergoth

#### LUK Type 3-2 : LUK, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=T, CoolTimeReset=T
MLTypeL32 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "Lapis", "SmallBalloon", "BigBalloon", 
                                                 "Bigeup", "IncongruitySoul", "Dunas", "Hogeol", "Papulatus", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "Ifrit", "NineTailedFox"))
#### EliteBloodTooth, ThiefCrow, KingSlime, PrimeMinister

#### LUK Type 3-3 : LUK, SummonedDuration=T, BuffDuration=F, FinalATKDMR=F, CRR=T
MLTypeL33 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "BigPumpkin", 
                                                 "CoupleYeti", "GoldYeti", "IncongruitySoul", "Dunas", "Hogeol", "NineTailedFox", 
                                                 "ToyKnight", "Oberon", "SeriousViking", "WolmyoThief", "Ifrit"))
#### EliteBloodTooth, Giant, ThiefCrow, KingSlime

#### Allstat Type 3-1 : ALLSTAT(Xenon), SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=F
MLTypeA31 <- MonsterLifeSpecs(MonsterLifeData, c("VonLeon", "Cygnus", "BlackViking", "Hilla", "Akairum", 
                                                 "Lazuli", "RomantistKingSlime", "Scarecrow", "Phantom", "Eunwol", "Rang", 
                                                 "LightLumi", "DarkLumi", "EquilLumi", "Lania", "DarkMageShadow", "Lapis", "Tinman", 
                                                 "Bigeup", "IncongruitySoul", "Beril", "PapulatusClock",
                                                 "ToyKnight", "Oberon", "Victor", "SeriousViking", "WolmyoThief", "NineTailedFox"))
#### EliteBloodTooth, AkariumPriest, Ifrit, KingSlime
