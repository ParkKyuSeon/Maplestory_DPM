## MapleUnion
UnionOptions <- c("STR", "DEX", "INT", "LUK", "HPP", "HP", "STRDEXLUK", "ATK", "IGR", "BDR", "CRR", "CDMR", "SummonedDuration", 
                  "BuffDuration", "CoolReduceP", "Others")
### Union Options
{Hero <- c(10, 20, 40, 80, 100) # STR
Palladin <- c(10, 20, 40, 80, 100) # STR
DarkKnight <- c(2, 3, 4, 5, 6) # HPP
ArchMageFP <- c(0, 0, 0, 0, 0) # MPP
ArchMageTC <- c(10, 20, 40, 80, 100) # INT
Bishop <- c(10, 20, 40, 80, 100) # INT
BowMaster <- c(10, 20, 40, 80, 100) # DEX
Marksman <- c(1, 2, 3, 4, 5) # CRR
PathFinder <- c(10, 20, 40, 80, 100) # DEX
NightLord <- c(1, 2, 3, 4, 5) # CRR
Shadower <- c(10, 20, 40, 80, 100) # LUK
DualBlader <- c(10, 20, 40, 80, 100) # LUK
Viper <- c(10, 20, 40, 80, 100) # STR
Captain <- c(4, 6, 8, 10, 12) # SummonedDuration
CannonMaster <- c(10, 20, 40, 80, 100) # STR
Mikhail <- c(250, 500, 1000, 2000, 2500) # HP
SoulMaster <- c(250, 500, 1000, 2000, 2500) # HP
FlameWizard <- c(10, 20, 40, 80, 100) # INT
WindBreaker <- c(10, 20, 40, 80, 100) # DEX
NightWalker <- c(10, 20, 40, 80, 100) # LUK
Striker <- c(10, 20, 40, 80, 100) # STR
Aran <- c(0, 0, 0, 0, 0) # HPDrain
Evan <- c(0, 0, 0, 0, 0) # MPDrain
Luminous <- c(10, 20, 40, 80, 100) # INT
Mercedes <- c(2, 3, 4, 5, 6) # CoolReduce
Phantom <- c(0, 0, 0, 0, 0) # MesoDrop
Eunwol <- c(1, 2, 3, 5, 6) # CDMR
Blaster <- c(1, 2, 3, 5, 6) # IGR
BattleMage <- c(10, 20, 40, 80, 100) # INT
WildHunter <- c(0.8, 1.6, 2.4, 3.2, 4) # BDR
Mechanic <- c(5, 10, 15, 20, 25) # BuffDuration
Xenon <- c(5, 10, 20, 40, 50) # STRDEXLUK
DemonSlayer <- c(0, 0, 0, 0, 0) # DisorderImmune
DemonAvenger <- c(1, 2, 3, 5, 6) # BDR
Kaiser <- c(10, 20, 40, 80, 100) # STR
Cadena <- c(10, 20, 40, 80, 100) # LUK
AngelicBuster <- c(10, 20, 40, 80, 100) # DEX
Adele <- c(10, 20, 40, 80, 100) # STR
Illium <- c(10, 20, 40, 80, 100) # LUK
Ark <- c(10, 20, 40, 80, 100) # STR
Hoyeong <- c(10, 20, 40, 80, 100) # LUK
Zero <- c(0, 0, 0, 0, 0) # EXP
Kinesis <- c(10, 20, 40, 80, 100) # INT
MapleM <- c(5, 10, 15, 20, NA) # ATK
Options <- c("STR", "STR", "HPP", "Others", "INT", "INT", "DEX", "CRR", "DEX", "CRR", "LUK", "LUK", "STR", "SummonedDuration", "STR",
             "HP", "HP", "INT", "DEX", "LUK", "STR",
             "Others", "Others", "INT", "CoolReduceP", "Others", "CDMR", 
             "IGR", "INT", "BDR", "BuffDuration", "STRDEXLUK", "Others", "BDR", 
             "STR", "LUK", "DEX", "STR", "LUK", "STR", "LUK", "Others", "INT", "ATK")
Union <- rbind(Hero, Palladin, DarkKnight, ArchMageFP, ArchMageTC, Bishop, BowMaster, Marksman, PathFinder, 
               NightLord, Shadower, DualBlader, Viper, Captain, CannonMaster, 
               Mikhail, SoulMaster, FlameWizard, WindBreaker, NightWalker, Striker, 
               Aran, Evan, Luminous, Mercedes, Phantom, Eunwol, 
               Blaster, BattleMage, WildHunter, Mechanic, Xenon, DemonSlayer, DemonAvenger, 
               Kaiser, Cadena, AngelicBuster, Adele, Illium, Ark, Hoyeong, Zero, Kinesis, MapleM)}
UnionCharacters <- data.frame(Union, Options, stringsAsFactors=F)
colnames(UnionCharacters) <- c("B", "A", "S", "SS", "SSS", "Options")

### Union Priority
{UnionPrior <- list()
UnionPrior$STR <- c("Marksman", "NightLord", "Captain", "Mercedes", "Eunwol", "Blaster", "WildHunter", "Mechanic", "DemonAvenger", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="STR")), "Xenon", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="DEX")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="LUK")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="INT")))
UnionPrior$DEX <- c("Marksman", "NightLord", "Captain", "Mercedes", "Eunwol", "Blaster", "WildHunter", "Mechanic", "DemonAvenger", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="DEX")), "Xenon", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="STR")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="LUK")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="INT")))
UnionPrior$LUK <- c("Marksman", "NightLord", "Captain", "Mercedes", "Eunwol", "Blaster", "WildHunter", "Mechanic", "DemonAvenger", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="LUK")), "Xenon", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="DEX")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="STR")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="INT")))
UnionPrior$INT <- c("Marksman", "NightLord", "Captain", "Mercedes", "Eunwol", "Blaster", "WildHunter", "Mechanic", "DemonAvenger", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="INT")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="LUK")), "Xenon", 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="DEX")), 
                    rownames(subset(UnionCharacters, UnionCharacters$Options=="STR")))}



## HyperStats
pts <- c(1, 2, 4, 8, 10, 15, 20, 25, 30, 35, 50, 65, 80, 95, 110)
MainStat <- rep(30, 15)
SubStat1 <- rep(30, 15)
SubStat2 <- rep(30, 15)
DMR <- rep(3, 15)
BDR <- c(rep(3, 5), rep(4, 10))
IGR <- rep(3, 15)
CRR <- c(rep(1, 5), rep(2, 10))
CDMR <- rep(1, 15)
ATK <- rep(3, 15)
HyperStats <- cbind(pts, MainStat, SubStat1, SubStat2, DMR, BDR, IGR, CRR, CDMR, ATK)
rownames(HyperStats) <- c(1:15)
HyperStats <- data.frame(HyperStats)

lv <- 140:275
ptsperlv <- floor((lv-110)/10)
lvpts <- data.frame(lv, ptsperlv)
sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])



## Monster Life
MonsterLifeSpecs <- c("BDR", "CRR", "CDMR", "IGR", "SummonedDuration", "BuffDuration", "FinalATKDMR", "CoolTimeReset",
                      "STR", "DEX", "INT", "LUK", "HP", "ATK", "MAT")
{### BDR / DMR
Bigeup <- c(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
VonLeon <- c(5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
VikingCorps <- c(3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## Four Vikings Needed
Cygnus <- c(3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Rang <- c(8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## Eunwol Needed
Scarecrow <- c(4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
BlackViking <- c(2, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0)
PinkBean <- c(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### CRR
RomantistKingSlime <- c(0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
HornTail <- c(0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Lazuli <- c(0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Phantom <- c(0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### CDMR
Hilla <- c(0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### IGR
Magnus <- c(0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Lapis <- c(0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### SummonedDuration
MiniSpider <- c(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
CoupleYeti <- c(0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
GoldYeti <- c(0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### BuffDuration
VonBon <- c(0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Will <- c(0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Akairum <- c(0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0)
### FinalATKDMR
Puso <- c(0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0)
Pierre <- c(0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0)
### CoolTimeReset
BigBalloon <- c(0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0)
Eunwol <- c(0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0)
### STR
FrankenRoid <- c(0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0)
Leica <- c(0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0)
NineTailedFox <- c(0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 0, 0, 0) ## STR + 14 if there is no Leica
### DEX
Lilinoch <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0)
SleepyViking <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## DEX +8 if there is no Birds A+ or S
TiredViking <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## DEX +8 if there is no Birds A+ or S
EnoughViking <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## DEX +10 if there is no Birds S
SeriousViking <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0)
Taeryun <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0)
### INT
Timer <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0)
MachineMT09 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0)
### LUK
Dunas <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
Hogeol <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0)
### STR + INT
ReeperSpector <- c(0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 6, 0, 0, 0, 0)
### STR + LUK
EliteBloodTooth <- c(0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 0)
### DEX + INT
AkairumPriest <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0, 0)
### DEX + LUK
Papulatus <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 6, 0, 0, 0)
### INT + LUK
LightSoul <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 0, 0, 0)
### ATK / MAT
DarkLumi <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5)
EquilLumi <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## ATK/10Lv (Do Not Effected by ATK%)
### ALLSTAT
PapulatusClock <- c(0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0)
Beril <- c(0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0)
Oberon <- c(0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0)
ReinforcedBeril <- c(0, 0, 0, 0, 0, 0, 0, 0, 6, 6, 6, 6, 0, 0, 0)
Lania <- c(0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 0, 0, 0)
### Others
Serf <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
YetiPharaoh <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Shinsoo <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
WolmyoThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
JuniorBalrog <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Orchid <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
LightLumi <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
ToyKnight <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Lich <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
IncongruitySoul <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

## Monster Life Preset (8 Empty Slots)
### Farm Level 21(22 Slots) + No Bigeup, Serf, MiniSpider, LightLumi, PinkBean, SS mix monsters
#### STR Type 1-1 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=F
MLTypeS11 <- rbind(FrankenRoid, Leica, ReeperSpector, EliteBloodTooth, 
                   VonLeon, VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking, Cygnus, BlackViking, 
                   Hilla, Akairum, PapulatusClock, Beril, Oberon, ReinforcedBeril, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Timer

#### STR Type 1-2 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=T


### Farm Level 30(26 Slots) + No Bigeup, Serf, MiniSpider, LightLumi, Pierre, VonBon
#### STR Type 2-1 : STR, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeS21 <- rbind(FrankenRoid, ReeperSpector, EliteBloodTooth, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking, 
                   Oberon, Beril, AkairumPriest, PapulatusClock, 
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeS21) <- MonsterLifeSpecs

#### STR Type 2-2 : STR, SummonedDuration=F, FinalATKDMR=T, CRR=F
MLTypeS22 <- rbind(FrankenRoid, ReeperSpector, EliteBloodTooth, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking, 
                   Oberon, Puso, AkairumPriest, PapulatusClock,
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeS22) <- MonsterLifeSpecs

#### DEX Type 2-1 : DEX, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeD21 <- rbind(Lilinoch, Taeryun, AkairumPriest, Papulatus, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   Oberon, Beril, PapulatusClock,
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeD21) <- MonsterLifeSpecs

#### DEX Type 2-2 : DEX, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeD22 <- rbind(Lilinoch, Taeryun, AkairumPriest, Papulatus, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   CoupleYeti, GoldYeti, PapulatusClock,
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeD22) <- MonsterLifeSpecs

#### DEX Type 2-3 : DEX, SummonedDuration=F, FinalATKDMR=T, CRR=F
MLTypeD23 <- rbind(Lilinoch, Taeryun, AkairumPriest, Papulatus, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   Oberon, Puso, PapulatusClock,
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang,  
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeD23) <- MonsterLifeSpecs

#### INT Type 2-1 : INT, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeI21 <- rbind(Timer, MachineMT09, ReeperSpector, AkairumPriest, NineTailedFox,
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   Oberon, Beril, PapulatusClock, 
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeI21) <- MonsterLifeSpecs

#### INT Type 2-2 : INT, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeI22 <- rbind(Timer, MachineMT09, ReeperSpector, AkairumPriest, NineTailedFox,
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   CoupleYeti, GoldYeti, PapulatusClock, 
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeI22) <- MonsterLifeSpecs

#### LUK Type 2-1 : LUK, SummonedDuration=F, FinalATKDMR=F, CRR=F
MLTypeL21 <- rbind(Dunas, Hogeol, EliteBloodTooth, Papulatus, LightSoul, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   Oberon, Beril, 
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeL21) <- MonsterLifeSpecs

#### LUK Type 2-2 : LUK, SummonedDuration=T, FinalATKDMR=F, CRR=F
MLTypeL22 <- rbind(Dunas, Hogeol, EliteBloodTooth, Papulatus, LightSoul, NineTailedFox, 
                   VikingCorps, SleepyViking, TiredViking, EnoughViking, SeriousViking,
                   CoupleYeti, GoldYeti, 
                   VonLeon, Cygnus, BlackViking, Hilla, Akairum, Scarecrow, Phantom, Eunwol, Rang, 
                   WolmyoThief, ToyKnight, IncongruitySoul, YetiPharaoh)
#### Shinsoo, Leica
colnames(MLTypeL22) <- MonsterLifeSpecs

### Farm Level 40(28 Slots)
#### STR Type 3-1 : STR, SummonedDuration=F, BuffDuration=F, FinalATKDMR=F, CRR=F
}



## LinkSkill
LinkOption <- c("MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
                "MainStatP", "AllstatP", "IGR", "BDR", "CRR", "CDMR", "Disorder")
Disorder <- T
Movable <- T
{AdventureWarrior <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # HPRecovery
AdventureWizard <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 9, 0, 0, 1)
AdventureBowman <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(Disorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
AdventurePirates <- c(70, 70, 70, 1225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Mikhail <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Stance
CygnusKnights <- c(0, 0, 0, 0, 0, 25, 25, 0, 0, 0, 0, 0, 0, 0)
Resistance <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Invincible
Xenon <- c(0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0)
DemonSlayer <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0)
DemonAvenger <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
Aran <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Combo Kill Exp
Evan <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Rune Duration
Luminous <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0)
Mercedes <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Exp
Phantom <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0)
Eunwol <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Survive
Kaiser <- c(0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0) # Kaiser : DMR 3% per Morph Gauge
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(Disorder==T, 6, 0)+ifelse(ChrLv>MobLv, 6, 0), 0, 0, 0)
AngelicBuster <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) # DMR Buff
Adele <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4 + min(PartyMembers * 2, 8), 0, 0, 0)
Illium <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(Movable==T, 12, 0), 0, 0, 0)
Ark <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0)
Zero <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0)
Kinesis <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0)
Hoyeong <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0)}
LinkSkill <- rbind(AdventureWarrior, AdventureWizard, AdventureBowman, AdventureThief, AdventurePirates, 
                   Mikhail, CygnusKnights, Resistance, Xenon, DemonSlayer, DemonAvenger, 
                   Aran, Evan, Luminous, Mercedes, Phantom, Eunwol, Kaiser, Cadena, AngelicBuster, 
                   Adele, Illium, Ark, Hoyeong, Zero, Kinesis)
colnames(LinkSkill) <- LinkOption

LinkBase <- rbind(Resistance, AngelicBuster, DemonSlayer, AdventureWizard, 
                  AdventureThief, Luminous, Cadena, Ark, Kinesis)
colnames(LinkBase) <- LinkOption
LinkBase <- data.frame(LinkBase)



## Doping
DopingOption <- c("MainStat", "SubStat1", "SubStat2", "MaxHP", "ATK", "ATKSub", 
                  "AllstatP", "IGR", "BDR", "CRR", "CDMR", "ATKSpeed", "ArcaneForce")
{BDRArcanum <- c(0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0)
DMRArcanum <- c(0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0)
IGRArcanum <- c(0, 0, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0)
ATKArcanum <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
ALLArcanum <- c(0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0)
CRRArcanum <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
EqipArtisan <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0)
GuildBless <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
UnionPower <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
BreadDrop <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
UrusDrop <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
ExtremeRed <- c(0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0)
ExtremeGreen <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
Lv250Buff <- c(0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0)
Lv275Buff <- c(0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0)
MainStatSyrup <- c(27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SubStat1Syrup <- c(0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
SubStat2Syrup <- c(0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
MatchingBuff <- c(0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0)
SP30Guild <- c(0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 30, 0, 0)
SP44Guild <- c(0, 0, 0, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0)
SP60Guild <- c(0, 0, 0, 0, 0, 0, 0, 0, 2, 30, 0, 0, 0)
Guild <- c(40, 40, 40, 2000, 15, 15, 0, 0, 0, 0, 0, 0, 30)}
Doping <- rbind(BDRArcanum, DMRArcanum, IGRArcanum, ATKArcanum, ALLArcanum, CRRArcanum, EqipArtisan, 
                GuildBless, UnionPower, BreadDrop, UrusDrop, ExtremeRed, ExtremeGreen, Lv250Buff, Lv275Buff, 
                MainStatSyrup, SubStat1Syrup, SubStat2Syrup, MatchingBuff, SP30Guild, SP44Guild, SP60Guild, Guild)
colnames(Doping) <- DopingOption

DopingSet <- rbind(BDRArcanum, ATKArcanum, GuildBless, UnionPower, BreadDrop, UrusDrop, 
                   ExtremeRed, ExtremeGreen, Lv250Buff, MainStatSyrup, SubStat1Syrup, SubStat2Syrup, 
                   MatchingBuff, SP30Guild, SP44Guild, Guild)
colnames(DopingSet) <- DopingOption



## Ability Data
AbilityOption <- c("BDR", "CRR", "BuffDuration", "CoolTimeReset", "PassiveLv", "DisorderBDR", "ATK")
Legendry <- c(20, 30, 50, 20, 1, 10, 30)
Unique <- c(8, 18, 36, 8, NA, 8, 18) ## 60% fractile of range
Epic <- c(NA, NA, 22, NA, NA, 5, 9)
Ability <- rbind(Legendry, Unique, Epic)
colnames(Ability) <- AbilityOption



## Common Skills
CommonSkillOptions <- c("ATKP", "MainStat", "SubStat1", "SubStat2", "ATK")
WillOfUnion <- c(0, 5, 5, 5, 5)
BlessofSpirit <- c(0, 0, 0, 0, 30)
EchoofHero <- c(4, 0, 0, 0, 0)
CommonSkills <- rbind(WillOfUnion, BlessofSpirit, EchoofHero)
colnames(CommonSkills) <- CommonSkillOptions



## Spider in Mirror - Data
{SIMLv <- 30
option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * SIMLv, 15, 960, NA, 250, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 1800, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorStart <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * SIMLv, 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * SIMLv, 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * SIMLv, 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * SIMLv, 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * SIMLv, 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}



## SeedRing & Soul Contract Data
{option <- factor("ATKP", levels=BSkill)
value <- c(100)
info <- c(15, 180, 30, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Restraint4 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(45)
info <- c(10, 90, 900, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulContractLink <- rbind(data.frame(option, value), info)}