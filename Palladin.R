## Palladin - Data
## Palladin - VMatrix
PalladinCore <- MatrixSet(PasSkills=c("Blast", "FinalAttack", "Sanctuary", "LinghtningCharge", "DevineCharge"), 
                          PasLvs=c(50, 50, 50, 50, 50), 
                          PasMP=c(10, 10, 10, 5, 5), 
                          ActSkills=c("HolyUnity", "BlessedHammer", "GrandCross", "MightyMjolnir", 
                                      CommonV("Warrior", "Adventure")), 
                          ActLvs=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                          ActMP=c(5, 5, 5, 5, 5, 5, 0, 5, 5), 
                          UsefulSkills=c("WindBooster", "SharpEyes"), 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=SpecDefault)



## Palladin - Basic Info
PalladinBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=MobDefault,
                        SpecSet=SpecDefault, 
                        Job="Palladin",
                        CoreData=PalladinCore, 
                        MikhailLink=F, 
                        OtherBuffDuration=0, 
                        AbilList=c("BDR", "DisorderBDR"), 
                        LinkList=c("AdventureWarrior", "Xenon", "DemonAvenger", "Phantom"), 
                        MonsterLife=MLTypeS21, 
                        Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandHammer", SpecDefault$WeaponType)[, 1:16],
                        WeaponType=SpecDefault$WeaponType, 
                        SubWeapon=SubWeapon[2, ], 
                        Emblem=Emblem[1, ])



## Palladin - Passive
{option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(20)
ParashockGuard <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(10)
ShieldMastery <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(20)
BlessingArmor <- data.frame(option, value)

option <- factor(c("DMR", "ATK"), levels=PSkill)
value <- c(25, 60)
AdvancedCharge <- data.frame(option, value)

option <- factor(c("Mastery", "CRR", "CDMR", "IGR", "FDR"), levels=PSkill)
value <- c(71, 42, 20, 37.9, 42)
PalladinExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(PalladinCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)}

PalladinPassive <- Passive(list(PhysicalTraining, ParashockGuard, ShieldMastery, BlessingArmor, AdvancedCharge, PalladinExpert, BodyofStealPassive))


## Palladin - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CombatOrders <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(50)
info <- c(80, NA, 720, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Threat <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(21)
info <- c(206, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalForce <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((PalladinChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(PalladinBase$SkillLv/2))))
info <- c(900 + 30 * PalladinBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * PalladinCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * PalladinCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(PalladinCore[[2]][5, 2]/5), ceiling(PalladinCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * PalladinCore[[2]][5, 2], 180, 720, F, T, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(35 + floor(PalladinCore[[2]][5, 2]/2))
info <- c(40 + PalladinCore[[2]][1, 2], 120, 600, F, T, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HolyUnity <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * PalladinCore[[2]][8, 2]) * MapleSoldier[1, 2]) * PalladinBase$MainStatP), 5 + floor(PalladinCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

PalladinBuff <- Buff(list(WeaponBooster=WeaponBooster, CombatOrders=CombatOrders, Threat=Threat, ElementalForce=ElementalForce, MapleSoldier=MapleSoldier, 
                          UsefulSharpEyes=UsefulSharpEyes, UsefulWindBooster=UsefulWindBooster, EpicAdventure=EpicAdventure, 
                          AuraWeaponBuff=AuraWeaponBuff, HolyUnity=HolyUnity, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : CombatOrders, WeaponBooster, ElementalForce
PalladinAllTimeBuff <- AllTimeBuff(PalladinBuff)


## Palladin - Union & HyperStat & SoulWeapon
PalladinSpec <- JobSpec(JobBase=PalladinBase, 
                      Passive=PalladinPassive, 
                      AllTimeBuff=PalladinAllTimeBuff, 
                      MobInfo=MobDefault, 
                      SpecSet=SpecDefault, 
                      WeaponName="TwohandHammer", 
                      UnionStance=0)

PalladinUnionRemained <- PalladinSpec$UnionRemained
PalladinHyperStatBase <- PalladinSpec$HyperStatBase
PalladinCoolReduceType <- PalladinSpec$CoolReduceType
PalladinSpec <- PalladinSpec$Spec


## Palladin - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * PalladinCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * PalladinCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Palladin - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][2, 2]>=40, 20, 0), 4 * PalladinCore[[1]][2, 2])
info <- c(80, 0.8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][4, 2]>=40, 20, 0), 2 * PalladinCore[[1]][4, 2])
info <- c(462, 5, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningCharge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][5, 2]>=40, 20, 0), 2 * PalladinCore[[1]][5, 2])
info <- c(462, 5, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivineCharge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][1, 2]>=40, 20, 0), 20, 2 * PalladinCore[[1]][1, 2])
info <- c(291, 12, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blast <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][3, 2]>=40, 20, 0), 30, 2 * PalladinCore[[1]][3, 2])
info <- c(580, 8, 990, NA, 9.75, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Sanctuary <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 900, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossPre <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 100)
info <- c(175 + 7 * PalladinCore[[2]][3, 2], 12, 2600, 210, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossSmall <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 100)
info <- c(300 + 12 * PalladinCore[[2]][3, 2], 12, 6500, 150, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 450, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(225 + 9 * PalladinCore[[2]][4, 2], 6, 0, 630, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MightyMjolnir <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * PalladinCore[[2]][4, 2], 9, 840, 630, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MightyMjolnirExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * PalladinCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

PalladinATK <- Attack(list(FinalAttack=FinalAttack, LightningCharge=LightningCharge, DivineCharge=DivineCharge, Blast=Blast, Sanctuary=Sanctuary, 
                           GrandCrossPre=GrandCrossPre, GrandCrossSmall=GrandCrossSmall, GrandCrossBig=GrandCrossBig, GrandCrossEnd=GrandCrossEnd, 
                           MightyMjolnir=MightyMjolnir, MightyMjolnirExplosion=MightyMjolnirExplosion, AuraWeapon=AuraWeapon, 
                           SpiderInMirror=SpiderInMirror))


## Palladin - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(250 + 10 * PalladinCore[[2]][2, 2], 2, 0, 600, 60, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlessedHammerSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(525 + 21 * PalladinCore[[2]][2, 2], 3, 360, 600, 30 + ServerLag, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlessedHammerBig <- rbind(data.frame(option, value), info)}

PalladinSummoned <- Summoned(list(BlessedHammerSmall=BlessedHammerSmall, BlessedHammerBig=BlessedHammerBig, SpiderInMirrorStart=SpiderInMirrorStart,
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Palladin - DealCycle
ATKFinal <- data.frame(PalladinATK)
ATKFinal$Delay[c(1:5, 10:13)] <- Delay(ATKFinal$Delay, PalladinSpec$ATKSpeed)[c(1:5, 10:13)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)

BuffFinal <- data.frame(PalladinBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, PalladinSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(PalladinSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * PalladinSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(PalladinBuff))
PalladinDealCycle <- t(rep(0, length(DealCycle)))
colnames(PalladinDealCycle) <- DealCycle


PalladinCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                          Period=c(150, 180), CycleTime=360) {
  BuffSummonedPrior <- c("WeaponBooster", "CombatOrders", "ElementalForce", "MapleSoldier", "UsefulSharpEyes", "UsefulWindBooster", "EpicAdventure", 
                         "Threat", "AuraWeaponBuff", "MapleWarriors2", "BlessedHammerBig", "SoulContractLink", "HolyUnity", "Restraint4")
  Times150 <- c()
  Times180 <- c(1, 1, 1, 1, 1, 1, 0, 2.5, 1, 1, 3, 2, 1.5, 1)
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  for(i in 1:length(BuffSummonedPrior)) {
    if(Period==150) {
      SubTime[i] <- SubTime[i] / ifelse(Times150[i]==0, Inf, Times150[i])
    } else if(Period==180) {
      SubTime[i] <- SubTime[i] / ifelse(Times180[i]==0, Inf, Times180[i])
    }
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
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="EpicAdventure") {
        DealCycle <- DCATK(DealCycle, "DivineCharge", ATKFinal)
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
  ChargeBuffRemain <- 30000 * (100 + Spec$BuffDuration) / 100 - (DealCycle$Time[nrow(DealCycle)] - subset(DealCycle, DealCycle$Skills=="DivineCharge")$Time + DealCycle$Time[1])
  STCool <- subset(ATKFinal, rownames(ATKFinal)=="Sanctuary")$CoolTime * 1000
  MMCool <- subset(ATKFinal, rownames(ATKFinal)=="MightyMjolnir")$CoolTime * 1000
  STRemain <- 0 ; MMRemain <- 0
  GCSubTime <- Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
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
        }
      }
      ## Grand Cross
      if(nrow(subset(DealCycle, DealCycle$Skills=="GrandCrossPre"))==0) {
        DealCycle <- DCATK(DealCycle, "MightyMjolnir", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MightyMjolnirExplosion", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossPre", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossSmall", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossBig", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossEnd", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        STRemain <- 0 ; MMRemain <- 0
      } else if(nrow(subset(DealCycle, DealCycle$Skills=="GrandCrossPre")) > 0 & 
                DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="GrandCrossPre")$Time) > GCSubTime * 1000) {
        DealCycle <- DCATK(DealCycle, "MightyMjolnir", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MightyMjolnirExplosion", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossPre", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossSmall", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossBig", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "GrandCrossEnd", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        STRemain <- 0 ; MMRemain <- 0
      } 
      ## Charge Buff
      else if(ChargeBuffRemain <= 2000) {
        if(nrow(subset(DealCycle, DealCycle$Skills=="LightningCharge"))==0) {
          DealCycle <- DCATK(DealCycle, "LightningCharge", ATKFinal)
          ChargeBuffRemain <- 30000 * (100 + Spec$BuffDuration) / 100 - DealCycle$Time[1]
          STRemain <- max(0, STRemain - DealCycle$Time[1])
          MMRemain <- max(0, MMRemain - DealCycle$Time[1])
        } else if(max(subset(DealCycle, DealCycle$Skills=="DivineCharge")$Time) > max(subset(DealCycle, DealCycle$Skills=="LightningCharge")$Time)) {
          DealCycle <- DCATK(DealCycle, "LightningCharge", ATKFinal)
          ChargeBuffRemain <- 30000 * (100 + Spec$BuffDuration) / 100 - DealCycle$Time[1]
          STRemain <- max(0, STRemain - DealCycle$Time[1])
          MMRemain <- max(0, MMRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "DivineCharge", ATKFinal)
          ChargeBuffRemain <- 30000 * (100 + Spec$BuffDuration) / 100 - DealCycle$Time[1]
          STRemain <- max(0, STRemain - DealCycle$Time[1])
          MMRemain <- max(0, MMRemain - DealCycle$Time[1])
        }
      }
      ## Mighty Mjolnir
      else if(MMRemain==0) {
        DealCycle <- DCATK(DealCycle, "MightyMjolnir", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        STRemain <- max(0, STRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MightyMjolnirExplosion", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        STRemain <- max(0, STRemain - DealCycle$Time[1])
        if(sum(BuffList[[k]]=="Restraint4")==1 & BuffEndTime - DealCycle$Time[nrow(DealCycle)] >= 20000 & BuffEndTime - DealCycle$Time[nrow(DealCycle)] <= 35000) {
          MMRemain <- BuffEndTime - DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[1]
        } else {
          MMRemain <- MMCool - DealCycle$Time[1]
        }
      }
      ## Sanctuary
      else if(STRemain==0) {
        DealCycle <- DCATK(DealCycle, "Sanctuary", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        MMRemain <- max(0, MMRemain - DealCycle$Time[1])
        STRemain <- STCool - DealCycle$Time[1]
      }
      ## Blast
      else {
        DealCycle <- DCATK(DealCycle, "Blast", ATKFinal)
        ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
        MMRemain <- max(0, MMRemain - DealCycle$Time[1])
        STRemain <- max(0, STRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
          MMRemain <- max(0, MMRemain - DealCycle$Time[1])
          STRemain <- max(0, STRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          ChargeBuffRemain <- max(0, ChargeBuffRemain - DealCycle$Time[1])
          MMRemain <- max(0, MMRemain - DealCycle$Time[1])
          STRemain <- max(0, STRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  return(DealCycle)
}
  


PalladinDealCycle <- PalladinCycle(PreDealCycle=PalladinDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=PalladinSpec,
                                   Period=180, 
                                   CycleTime=360)
PalladinDealCycle <- DealCycleFinal(PalladinDealCycle)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("MightyMjolnir"), 4, 630, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("MightyMjolnirExplosion"), 4, 630, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("GrandCrossSmall"), 13, 0, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("GrandCrossBig"), 43, 0, ATKFinal)
PalladinDealCycle <- DCSummonedATKs(PalladinDealCycle, Skill=c("BlessedHammerBig"), SummonedFinal)
PalladinDealCycle <- BlessedHammerCycle(PalladinDealCycle)
PalladinDealCycle <- AddATKsCyclePalladin(PalladinDealCycle)
PalladinDealCycle <- AuraWeaponCycle(PalladinDealCycle)
PalladinDealCycle <- DCSpiderInMirror(PalladinDealCycle, SummonedFinal)
PalladinDealCycleReduction <- DealCycleReduction(PalladinDealCycle)


## Palladin - Deal Calc
DealCalc(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpec)

PalladinSpecOpt1 <- Optimization1(PalladinDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PalladinSpec, PalladinUnionRemained)
PalladinSpecOpt <- PalladinSpec
PalladinSpecOpt$ATKP <- PalladinSpecOpt$ATKP + PalladinSpecOpt1$ATKP
PalladinSpecOpt$BDR <- PalladinSpecOpt$BDR + PalladinSpecOpt1$BDR
PalladinSpecOpt$IGR <- IGRCalc(c(PalladinSpecOpt$IGR, PalladinSpecOpt1$IGR))

PalladinSpecOpt2 <- Optimization2(PalladinDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt, PalladinHyperStatBase, PalladinBase$ChrLv, PalladinBase$CRROver)
PalladinFinalDPM <- DealCalc(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt2)
PalladinFinalDPMwithMax <- DealCalcWithMaxDMR(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt2)

DPM12344$Palladin[1] <- sum(na.omit(PalladinFinalDPMwithMax)) / (345380 / 60000)
DPM12344$Palladin[2] <- sum(na.omit(PalladinFinalDPM)) / (345380 / 60000) - sum(na.omit(PalladinFinalDPMwithMax)) / (345380 / 60000)

PalladinDealData <- data.frame(PalladinDealCycle$Skills, PalladinDealCycle$Time, PalladinDealCycle$Restraint4, PalladinFinalDPMwithMax)
colnames(PalladinDealData) <- c("Skills", "Time", "R4", "Deal")
subset(PalladinDealData, PalladinDealData$R4>0)

PalladinRR <- PalladinDealData[26:209, ]
DPM12344$Palladin[3] <- sum((PalladinRR$Deal))

Palladin40s <- PalladinDealData[26:373, ]
DPM12344$Palladin[4] <- sum((Palladin40s$Deal))

PalladinDealRatio <- DealRatio(PalladinDealCycle, PalladinFinalDPMwithMax)