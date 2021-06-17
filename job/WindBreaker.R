source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/base/Common.R")
source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/base/Item%20Data.R")
source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/base/PreSets.R")

source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/functions%20set/Functions%20Set.R")
source("https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/functions%20set/JobFunctions.R")


## WindBreaker - Data
## WindBreaker - VMatrix
WindBreakerCore <- MatrixSet(PasSkills=c("SongofSky", "TriflingWhim", "StormBringer", "FairyTurn", "PinpointPierce", "Monsoon"), 
                             PasLvs=c(50, 50, 50, 50, 50, 50), 
                             PasMP=c(10, 10, 10, 0, 0, 0), 
                             ActSkills=c("HowlingGale", "IdleWhim", "WindWall", "VortexSphere", 
                                         CommonV("Bowman", "CygnusKnights")), 
                             ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                             ActMP=c(5, 5, 5, 5, 5, 5, 5, 5, 5), 
                             BlinkLv=1, 
                             BlinkMP=0, 
                             UsefulSkills=c("CombatOrders"), 
                             UsefulLvs=20, 
                             UsefulMP=0, 
                             SpecSet=SpecDefault, 
                             SelfBind=F)


## WindBreaker - Basic Info
WindBreakerBase <- JobBase(ChrInfo=ChrInfo, 
                         MobInfo=MobDefault,
                         SpecSet=SpecDefault, 
                         Job="WindBreaker",
                         CoreData=WindBreakerCore, 
                         BuffDurationNeeded=0, 
                         AbilList=c("BDR", "DisorderBDR"), 
                         LinkList=c("Mikhail", "CygnusKnights", "DemonAvenger", "Phantom"), 
                         MonsterLife=MLTypeD21, 
                         Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Bow", SpecDefault$WeaponType)[, 1:16],
                         WeaponType=SpecDefault$WeaponType, 
                         SubWeapon=SubWeapon[19, ], 
                         Emblem=Emblem[3, ])


## WindBreaker - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(WindBreakerBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
ElementStorm <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
WhisperoftheWind <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
BowAcceleration <- data.frame(option, value)

option <- factor(c("ATKP", "MainStatP"), levels=PSkill)
value <- c(10 + ceiling(WindBreakerBase$PSkillLv/3), 15 + floor(WindBreakerBase$PSkillLv/3))
WindBlessing <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "FDR", "CDMR", "BDR"), levels=PSkill)
value <- c(70 + ceiling(WindBreakerBase$PSkillLv/2), 30 + WindBreakerBase$PSkillLv, 25 + ceiling(WindBreakerBase$PSkillLv/3), 20 + floor(WindBreakerBase$PSkillLv/2), 40 + WindBreakerBase$PSkillLv)
BowExpert <- data.frame(option, value)

option <- factor(c("ATK", "DMR", "IGR", "CRR", "ATKSpeed"), levels=PSkill)
value <- c(50 + WindBreakerBase$SkillLv, 25 + 2 * floor(WindBreakerBase$SkillLv/3), 15 + floor(WindBreakerBase$SkillLv/3), 25 + floor(WindBreakerBase$SkillLv/3), 2)
AlbatrossMaximum <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(WindBreakerCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

WindBreakerPassive <- Passive(list(ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, ElementStorm=ElementStorm, WhisperoftheWind=WhisperoftheWind, 
                                   PhysicalTraining=PhysicalTraining, BowAcceleration=BowAcceleration, WindBlessing=WindBlessing, BowExpert=BowExpert, AlbatrossMaximum=AlbatrossMaximum, 
                                   BlinkPassive=BlinkPassive))


## WindBreaker - Buff
{option <- factor(c("ATK", "CRR"), levels=BSkill)
value <- c(20, 10)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SylphsAid <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(15, 15)
info <- c(60, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PinpointPierceBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(10 + floor(WindBreakerBase$PSkillLv/2))
info <- c(60 * (100 + WindBreakerBase$UnionChrs$SummonedDuration + WindBreakerBase$MonsterLife$SummonedDuration) / 100, NA, 900, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EmeraldDust <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(WindBreakerBase$SkillLv/2), 15 + ceiling(WindBreakerBase$SkillLv/2))
info <- c(300 + 3 * WindBreakerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((WindBreakerBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(WindBreakerBase$SkillLv/2))))
info <- c(900 + 30 * WindBreakerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(200, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
StormBringer <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * WindBreakerCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(45, 90, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindWallBuff <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(0)
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

## PetBuff : SharpEyes(900ms), SylphsAid(270ms), UsefulCombatOrders(1500ms)
WindBreakerBuff <- Buff(list(SylphsAid=SylphsAid, PinpointPierceBuff=PinpointPierceBuff, 
                             SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, GloryofGardians=GloryofGardians, StormBringer=StormBringer, UsefulCombatOrders=UsefulCombatOrders, 
                             WindWallBuff=WindWallBuff, CriticalReinforce=CriticalReinforce, BlessofCygnus=BlessofCygnus,
                             Restraint4=Restraint4, SoulContractLink=SoulContractLink))
WindBreakerAllTimeBuff <- AllTimeBuff(WindBreakerBuff)


## WindBreaker - Union & HyperStat & SoulWeapon
WindBreakerSpec <- JobSpec(JobBase=WindBreakerBase, 
                           Passive=WindBreakerPassive, 
                           AllTimeBuff=WindBreakerAllTimeBuff, 
                           MobInfo=MobDefault, 
                           SpecSet=SpecDefault, 
                           WeaponName="Bow", 
                           UnionStance=0)

WindBreakerUnionRemained <- WindBreakerSpec$UnionRemained
WindBreakerHyperStatBase <- WindBreakerSpec$HyperStatBase
WindBreakerCoolReduceType <- WindBreakerSpec$CoolReduceType
WindBreakerSpec <- WindBreakerSpec$Spec


## WindBreaker - CriticalReinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(WindBreakerSpec$CRR * (0.2 + 0.01 * WindBreakerCore[[2]][6, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}

WindBreakerBuff <- Buff(list(SylphsAid=SylphsAid, PinpointPierceBuff=PinpointPierceBuff, 
                             SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, GloryofGardians=GloryofGardians, StormBringer=StormBringer, UsefulCombatOrders=UsefulCombatOrders, 
                             WindWallBuff=WindWallBuff, CriticalReinforce=CriticalReinforce, BlessofCygnus=BlessofCygnus,
                             Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## WindBreaker - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * WindBreakerCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## WindBreaker - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][5, 2]>=40, 20, 0), 3 * WindBreakerCore[[1]][5, 2])
info <- c(340, 2, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PinpointPierce <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][1, 2]>=40, 20, 0), ((1.2 + 0.01 * floor(WindBreakerSpec$SkillLv/2))^3) * 100 - 100 + 50, 2 * WindBreakerCore[[1]][1, 2])
info <- c(345, 1, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SongofSky <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][2, 2]>=40, 20, 0), 20, 2 * WindBreakerCore[[1]][2, 2])
info <- c(290 + 3 * WindBreakerSpec$PSkillLv, 2 * (0.6 + 0.01 * floor(WindBreakerSpec$PSkillLv/2)) * 0.8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriflingWhim <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][2, 2]>=40, 20, 0), 20, 2 * WindBreakerCore[[1]][2, 2])
info <- c(390 + 3 * WindBreakerSpec$PSkillLv, 2 * (0.6 + 0.01 * floor(WindBreakerSpec$PSkillLv/2)) * 0.2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriflingWhimEnhanced <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][3, 2]>=40, 20, 0), 2 * WindBreakerCore[[1]][3, 2])
info <- c(500, 0.3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
StormBringer <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * WindBreakerCore[[2]][2, 2], 3, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IdleWhimFirst <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * WindBreakerCore[[2]][2, 2]) * 0.75, 27, 600, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IdleWhimRemain <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * WindBreakerCore[[2]][1, 2], 3, 840, 150, 20, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HowlingGaleSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * WindBreakerCore[[2]][1, 2], 3, 840, 150, 40, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HowlingGaleBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((550 + 22 * WindBreakerCore[[2]][3, 2]) * 0.5, 15, 0, 2000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WindWall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * WindBreakerCore[[2]][4, 2], 8, 960, 180, 35, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VortexSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1, 1, 0, 2400, 35, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VortexSphereGust <- rbind(data.frame(option, value), info)}

WindBreakerATK <- Attack(list(PinpointPierce=PinpointPierce, SongofSky=SongofSky, TriflingWhim=TriflingWhim, TriflingWhimEnhanced=TriflingWhimEnhanced, StormBringer=StormBringer,
                              IdleWhimFirst=IdleWhimFirst, IdleWhimRemain=IdleWhimRemain, HowlingGaleSmall=HowlingGaleSmall, HowlingGaleBig=HowlingGaleBig, WindWall=WindWall, 
                              VortexSphere=VortexSphere, VortexSphereGust=VortexSphereGust, SpiderInMirror=SpiderInMirror))


## WindBreaker - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * WindBreakerCore[[2]][5, 2], 1, 720, 500, 0.5*89+0.51, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * WindBreakerCore[[2]][7, 2], 1, 780, 240, 0.24*(39 + WindBreakerCore[[2]][6, 2])+0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

WindBreakerSummoned <- Summoned(list(GuidedArrow=GuidedArrow, CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, 
                                     SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                     SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## WindBreaker - DealCycle & Deal Calculation
ATKFinal <- data.frame(WindBreakerATK)
ATKFinal$Delay[c(-2)] <- Delay(ATKFinal$Delay, WindBreakerSpec$ATKSpeed)[c(-2)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)

BuffFinal <- data.frame(WindBreakerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, WindBreakerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(WindBreakerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * WindBreakerSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(WindBreakerBuff))
WindBreakerDealCycle <- t(rep(0, length(DealCycle)))
colnames(WindBreakerDealCycle) <- DealCycle

WindBreakerCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                          Period=c(120), CycleTime=240) {
  BuffSummonedPrior <- c("SharpEyes", "StormBringer", "SylphsAid", "MapleSoldier", "UsefulCombatOrders", "GloryofGardians", 
                         "GuidedArrow", "CygnusPhalanx", "PinpointPierceBuff", "BlessofCygnus", "WindWallBuff", "SoulContractLink", "CriticalReinforce", "Restraint4")
  Times120 <- c(0.5, 0, 0.5, 0.5, 0, 0, 2, 4, 2, 0.5, 1, 1, 1, 0.5)
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times120[i]==0, Inf, Times120[i])
  }
  
  SubTimeUniques <- unique(SubTime)
  SubTimeUniques <- SubTimeUniques[SubTimeUniques > 0]
  TimeTypes <- c()
  for(i in 1:length(SubTimeUniques)) {
    Time <- 0 ; r <- 1
    while(Time < TotalTime) {
      Time <- SubTimeUniques[i] * r
      r <- r + 1
      TimeTypes <- c(TimeTypes, Time)
    }
  }
  TimeTypes <- TimeTypes[TimeTypes < TotalTime]
  TimeTypes <- unique(TimeTypes)
  TimeTypes <- TimeTypes[order(TimeTypes)]
  
  Buffs <- data.frame(Buff=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  Buffs <- subset(Buffs, Buffs$SubTime > 0)
  
  BuffList <- list()
  BuffList[[1]] <- BuffSummonedPrior
  for(i in 1:length(TimeTypes)) {
    s <- c()
    for(j in 1:nrow(Buffs)) {
      if(round(TimeTypes[i] / Buffs[j, 2]) == TimeTypes[i] / Buffs[j, 2]) {
        s <- c(s, Buffs[j, 1])
      }
    }
    BuffList[[i+1]] <- s
  }
  
  DelayDataB <- data.frame(Name=rownames(BuffFinal), Delay=BuffFinal$Delay)
  DelayDataS <- data.frame(Name=rownames(SummonedFinal), Delay=SummonedFinal$Delay)
  DelayData <- rbind(DelayDataB, DelayDataS)
  
  BuffDelays <- list()
  for(i in 1:length(BuffList)) {
    t <- c()
    for(j in 1:length(BuffList[[i]])) {
      for(k in 1:nrow(DelayData)) {
        if(DelayData$Name[k]==BuffList[[i]][j]) {
          t <- c(t, k)
        }
      }
    }
    BuffDelays[[i]] <- DelayData$Delay[t]
  } 
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="PinpointPierceBuff") {
        DealCycle <- DCATK(DealCycle, "PinpointPierce", ATKFinal)
      } else if(BuffList[[1]][i]=="WindWallBuff") {
        DealCycle <- DCATK(DealCycle, "WindWall", ATKFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="GloryofGardians") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c() ; NoSubTimeSummoned <- c()
  for(i in 1:length(NoSubTime)) {
    NoSubTimeBuff <- c(NoSubTimeBuff, NoSubTime[i])
  }
  ColNums <- c()
  for(i in 1:length(NoSubTimeBuff)) {
    for(j in 1:length(colnames(DealCycle))) {
      if(NoSubTimeBuff[i]==colnames(DealCycle)[j]) {
        ColNums[i] <- j
      }
    }
  }
  GaleBigCool <- 40000
  GaleSmallCool <- 20000
  IWCool <- subset(ATKFinal, rownames(ATKFinal)=="IdleWhimFirst")$CoolTime * 1000
  VSCool <- subset(ATKFinal, rownames(ATKFinal)=="VortexSphere")$CoolTime * 1000
  GaleRemain <- 0 ; IWRemain <- 0 ; VSRemain <- 0 ; GaleDummy <- 0
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  
  for(k in 2:length(BuffList)) {
    CycleBuffList <- data.frame(Skills=BuffList[[k]], Delay=BuffDelays[[k]])
    BuffEndTime <- c()
    for(i in 1:length(BuffList[[k]])) {
      a <- subset(DealCycle, BuffList[[k]][i]==DealCycle$Skills)
      a <- rbind(a, subset(DealCycle, paste(BuffList[[k]][i], "Summoned", sep="")==DealCycle$Skills))
      for(j in 1:nrow(CycleBuffList)) {
        if(CycleBuffList$Skills[j]==BuffList[[k]][i]) {
          Idx <- j
          break
        }
      }
      BuffEndTime[i] <- max(a$Time) + 
        min(subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000, subset(BuffFinal, rownames(BuffFinal)==BuffList[[k]][i])$CoolTime * 1000, 
            subset(SummonedFinal, rownames(SummonedFinal)==BuffList[[k]][i])$CoolTime * 1000) + 
        sum(CycleBuffList$Delay[Idx:nrow(CycleBuffList)])
    }
    BuffEndTime <- max(BuffEndTime)
    BuffEndTime <- max(BuffEndTime, TimeTypes[k] * 1000)
    BuffStartTime <- BuffEndTime - sum(CycleBuffList$Delay)
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
          IWRemain <- max(0, IWRemain - DealCycle$Time[1])
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        }
      }
      ## Vortex Sphere
      if(VSRemain==0) {
        DealCycle <- DCATK(DealCycle, "VortexSphereGust", ATKFinal)
        DealCycle <- DCATK(DealCycle, "VortexSphere", ATKFinal)
        GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
        IWRemain <- max(0, IWRemain - DealCycle$Time[1])
        VSRemain <- VSCool - DealCycle$Time[1]
      } 
      ## Howling Gale(Big)
      else if(GaleRemain==0 & GaleDummy!=1 & GaleDummy < 6) {
        DealCycle <- DCATK(DealCycle, "HowlingGaleBig", ATKFinal)
        GaleRemain <- ifelse(nrow(subset(DealCycle, DealCycle$Skills=="HowlingGaleBig")) != 1, GaleBigCool, GaleSmallCool) - DealCycle$Time[1]
        IWRemain <- max(0, IWRemain - DealCycle$Time[1])
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        GaleDummy <- GaleDummy + 1
      }
      ## Howling Gale(Small) 
      else if(GaleRemain==0 & GaleDummy==1 & GaleDummy < 6) {
        DealCycle <- DCATK(DealCycle, "HowlingGaleSmall", ATKFinal)
        IWRemain <- max(0, IWRemain - DealCycle$Time[1])
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        GaleDummy <- GaleDummy + 1
        GaleRemain <- GaleBigCool - DealCycle$Time[1]
      }
      ## Idle Whim
      else if(IWRemain==0) {
        DealCycle <- DCATK(DealCycle, "IdleWhimFirst", ATKFinal)
        DealCycle <- DCATK(DealCycle, "IdleWhimRemain", ATKFinal)
        IWRemain <- IWCool - DealCycle$Time[1]
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
      }
      ## Song of Sky
      else {
        DealCycle <- DCATK(DealCycle, "SongofSky", ATKFinal)
        IWRemain <- max(0, IWRemain - DealCycle$Time[1])
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="PinpointPierceBuff") {
            DealCycle <- DCATK(DealCycle, "PinpointPierce", ATKFinal)
            IWRemain <- max(0, IWRemain - DealCycle$Time[1])
            VSRemain <- max(0, VSRemain - DealCycle$Time[1])
            GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
          } else if(BuffList[[k]][i]=="WindWallBuff") {
            DealCycle <- DCATK(DealCycle, "WindWall", ATKFinal)
            IWRemain <- max(0, IWRemain - DealCycle$Time[1])
            VSRemain <- max(0, VSRemain - DealCycle$Time[1])
            GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          IWRemain <- max(0, IWRemain - DealCycle$Time[1])
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          IWRemain <- max(0, IWRemain - DealCycle$Time[1])
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          GaleRemain <- max(0, GaleRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  VSFirst <- min(subset(DealCycle, DealCycle$Skills=="VortexSphereGust")$Time)
  VSRemain <- VSRemain - VSFirst
  while(VSRemain > 0) {
    DealCycle <- DCATK(DealCycle, "SongofSky", ATKFinal)
    VSRemain <- max(0, VSRemain - DealCycle$Time[1])
  }
  return(DealCycle)
}

WindBreakerDealCycle <- WindBreakerCycle(PreDealCycle=WindBreakerDealCycle, 
                                         ATKFinal=ATKFinal,
                                         BuffFinal=BuffFinal, 
                                         SummonedFinal=SummonedFinal, 
                                         Spec=WindBreakerSpec,
                                         Period=120, 
                                         CycleTime=240)
WindBreakerDealCycle <- DealCycleFinal(WindBreakerDealCycle)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "VortexSphere", 17, 540, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "VortexSphereGust", 1, 2400, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "HowlingGaleSmall", 57, 840, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "HowlingGaleBig", 66, 0, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "WindWall", 25, 0, ATKFinal)
WindBreakerDealCycle <- DCSummonedATKs(WindBreakerDealCycle, Skill=c("GuidedArrow", "CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- AddATKsCycleWB(WindBreakerDealCycle)
WindBreakerDealCycle <- DCSpiderInMirror(WindBreakerDealCycle, SummonedFinal)
WindBreakerDealCycle <- BlessofCygnusCycle(WindBreakerDealCycle, 4000, ServerLag, WindBreakerCore[[2]][8, 2])
WindBreakerDealCycleReduction <- DealCycleReduction(WindBreakerDealCycle, "BlessofCygnusBDR")

sum(na.omit(WindBreakerDealCalc(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpec)))

WindBreakerSpecOpt1 <- WindBreakerOptimization1(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpec, WindBreakerUnionRemained)
WindBreakerSpecOpt <- WindBreakerSpec
WindBreakerSpecOpt$ATKP <- WindBreakerSpecOpt$ATKP + WindBreakerSpecOpt1$ATKP
WindBreakerSpecOpt$BDR <- WindBreakerSpecOpt$BDR + WindBreakerSpecOpt1$BDR
WindBreakerSpecOpt$IGR <- IGRCalc(c(WindBreakerSpecOpt$IGR, WindBreakerSpecOpt1$IGR))

WindBreakerSpecOpt2 <- WindBreakerOptimization2(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt, WindBreakerHyperStatBase, WindBreakerBase$ChrLv, WindBreakerBase$CRROver)

WindBreakerFinalDPM <- WindBreakerDealCalc(WindBreakerDealCycle, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt2)
WindBreakerFinalDPMwithMax <- WindBreakerDealCalcWithMaxDMR(WindBreakerDealCycle, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt2)

DPM12347$WindBreaker[1] <- sum(na.omit(WindBreakerFinalDPMwithMax)) / (max(WindBreakerDealCycle$Time) / 60000)
DPM12347$WindBreaker[2] <- sum(na.omit(WindBreakerFinalDPM)) / (max(WindBreakerDealCycle$Time) / 60000) - sum(na.omit(WindBreakerFinalDPMwithMax)) / (max(WindBreakerDealCycle$Time) / 60000)

WindBreakerDealData <- data.frame(WindBreakerDealCycle$Skills, WindBreakerDealCycle$Time, WindBreakerDealCycle$Restraint4, WindBreakerFinalDPMwithMax)
colnames(WindBreakerDealData) <- c("Skills", "Time", "R4", "Deal")

WindBreakerRR <- WindBreakerDealData[112:1136, ]
DPM12347$WindBreaker[3] <- sum((WindBreakerRR$Deal))

WindBreaker40s <- WindBreakerDealData[112:2546, ]
DPM12347$WindBreaker[4] <- sum((WindBreaker40s$Deal))

WindBreakerDealRatio <- DealRatio(WindBreakerDealCycle, WindBreakerFinalDPMwithMax)