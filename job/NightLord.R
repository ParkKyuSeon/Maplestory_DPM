## NightLord - Data
## NightLord - VMatrix
NightLordCore <- MatrixSet(PasSkills=c("QuadrapleThrow", "SuddenRaid", "MarkofNightLord", "DarkFlare", "Showdown", "FourSeasons"), 
                           PasLvs=c(50, 50, 50, 50, 50, 50), 
                           PasMP=c(10, 10, 10, 5, 5, 5), 
                           ActSkills=c("SpreadThrow", "ThrowingKnife", "SecretBook", "ThrowBlasting", 
                                       CommonV("Thief", "Adventure")), 
                           ActLvs=c(25, 25, 25, 25, 1, 25, 25, 25, 25), 
                           ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 0), 
                           BlinkLv=1, 
                           BlinkMP=5, 
                           UsefulSkills=c("CombatOrders", "SharpEyes"), 
                           UsefulLvs=20, 
                           UsefulMP=0, 
                           SpecSet=SpecDefault, 
                           SelfBind=F)



## NightLord - Basic Info
## Link Check Needed
NightLordBase <- JobBase(ChrInfo=ChrInfo, 
                         MobInfo=MobDefault,
                         SpecSet=SpecDefault, 
                         Job="NightLord",
                         CoreData=NightLordCore, 
                         BuffDurationNeeded=0, 
                         AbilList=c("BDR", "DisorderBDR"), 
                         LinkList=c("Mikhail", "Xenon", "DemonAvenger", "CygnusKnights"), 
                         MonsterLife=MLTypeL21, 
                         Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", SpecDefault$WeaponType)[, 1:16],
                         WeaponType=SpecDefault$WeaponType, 
                         SubWeapon=SubWeapon[11, ], 
                         Emblem=Emblem[1, ])


## NightLord - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(29)
FlameJavelin <- data.frame(option, value)
  
option <- factor("MainStat", levels=PSkill)
value <- c(20)
NimbleBody <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(50, 5)
CriticalThrow <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("FDR", levels=PSkill)
value <- c(25)
ExpertJavelin <- data.frame(option, value)

option <- factor("CDMR", levels=PSkill)
value <- c(10)
Adrenaline <- data.frame(option, value)

option <- factor(c("ATK", "IGR"), levels=PSkill)
value <- c(40 + NightLordBase$PSkillLv, 30 + NightLordBase$PSkillLv)
DarkSerenity <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(NightLordBase$PSkillLv/2), 30 + NightLordBase$PSkillLv, 15 + floor(NightLordBase$PSkillLv/3))
JavelinExpert <- data.frame(option, value)

option <- factor("BDR", levels=PSkill)
value <- c(10 + ceiling(NightLordBase$PSkillLv/3))
PurgeArea <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(NightLordCore[[2]][6, 2])
ReadyToDie <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(NightLordCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

NightLordPassive <- Passive(list(FlameJavelin, NimbleBody, CriticalThrow, PhysicalTraining, ExpertJavelin, Adrenaline, 
                                 DarkSerenity, JavelinExpert, PurgeArea, ReadyToDie, BlinkPassive))


## NightLord - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Haste <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBooster <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(200, NA, 900, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowPartner <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritJavelin <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(30 + NightLordBase$SkillLv)
info <- c(40 * (1 + (NightLordBase$MonsterLife$SummonedDuration + NightLordPassive$SummonDuration + NightLordBase$UnionChrs$SummonedDuration) / 100), NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PurgeArea <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((NightLordBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(NightLordBase$SkillLv/2))))
info <- c(900 + 30 * NightLordBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * NightLordCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * NightLordCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(60)
info <- c(80, 180, 780, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BleedingToxin <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(20 + NightLordCore[[2]][1, 2], 180, 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpreadThrow <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(90, 180, 960, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ThrowBlastingBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(NightLordCore[[2]][7, 2]/5))
info <- c(30, 220 - NightLordCore[[2]][7, 2], 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateDarkSight <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(NightLordCore[[2]][6, 2]/10))
info <- c(30, 90 - floor(NightLordCore[[2]][6, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(NightLordCore[[2]][6, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(NightLordCore[[2]][6, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * NightLordCore[[2]][8, 2]) * MapleSoldier[1, 2]) * NightLordBase$MainStatP), 5 + floor(NightLordCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

NightLordBuff <- Buff(list(JavelinBooster=JavelinBooster, ShadowPartner=ShadowPartner, SpiritJavelin=SpiritJavelin, PurgeArea=PurgeArea, MapleSoldier=MapleSoldier, 
                           UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, BleedingToxin=BleedingToxin, 
                           SpreadThrow=SpreadThrow, ThrowBlastingBuff=ThrowBlastingBuff, UltimateDarkSight=UltimateDarkSight, ReadyToDie1Stack=ReadyToDie1Stack, 
                           ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : NA
NightLordAllTimeBuff <- AllTimeBuff(NightLordBuff)


## NightLord - Union & HyperStat & SoulWeapon
NightLordSpec <- JobSpec(JobBase=NightLordBase, 
                         Passive=NightLordPassive, 
                         AllTimeBuff=NightLordAllTimeBuff, 
                         MobInfo=MobDefault, 
                         SpecSet=SpecDefault, 
                         WeaponName="Wristband", 
                         UnionStance=0)

NightLordUnionRemained <- NightLordSpec$UnionRemained
NightLordHyperStatBase <- NightLordSpec$HyperStatBase
NightLordCoolReduceType <- NightLordSpec$CoolReduceType
NightLordSpec <- NightLordSpec$Spec
SpreadThrowStems <- 3


## NightLord - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * NightLordCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * NightLordCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## NightLord - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][1, 2]>=40, 20, 0), 40, 2 * NightLordCore[[1]][1, 2])
info <- c(420 + NightLordSpec$SkillLv * 4, 5, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuadrapleThrow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][1, 2]>=40, 20, 0), 40, 2 * NightLordCore[[1]][1, 2])
info <- c((420 + NightLordSpec$SkillLv * 4) * 0.8, 5 * SpreadThrowStems, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuadrapleThrowSpread <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][2, 2]>=40, 20, 0), 2 * NightLordCore[[1]][2, 2])
info <- c(1150 + NightLordSpec$SkillLv * 15, 3, 900, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SuddenRaid <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][3, 2]>=40, 20, 0), 2 * NightLordCore[[1]][3, 2])
info <- c(60 + NightLordSpec$PSkillLv * 3 + NightLordBase$ChrLv, 3 / (1/(0.6 + 0.02 * NightLordSpec$PSkillLv) + 1), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofNightLord <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][3, 2]>=40, 20, 0), 2 * NightLordCore[[1]][3, 2])
info <- c(60 + NightLordSpec$PSkillLv * 3 + NightLordBase$ChrLv, 45 / (1/(0.6 + 0.02 * NightLordSpec$PSkillLv) + 1), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofNightLordSpread <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * NightLordCore[[2]][2, 2], 5, 480, 180, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThrowingKnife <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=ASkill)
value <- c(30)
info <- c(900 + 36 * NightLordCore[[2]][3, 2], 10, 0, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SecretBookExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(475 + 19 * NightLordCore[[2]][4, 2], 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThrowBlasting <- rbind(data.frame(option, value), info)}

NightLordATK <- Attack(list(QuadrapleThrow=QuadrapleThrow, QuadrapleThrowSpread=QuadrapleThrowSpread, SuddenRaid=SuddenRaid, MarkofNightLord=MarkofNightLord, MarkofNightLordSpread=MarkofNightLordSpread,
                            ThrowingKnife=ThrowingKnife, SecretBookExplosion=SecretBookExplosion, ThrowBlasting=ThrowBlasting,
                            SpiderInMirror=SpiderInMirror))


## NightLord - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(NightLordCore[[1]][4, 2]>=40, 20, 0), NightLordCore[[1]][4, 2] * 3)
info <- c(280, 1, 600, 900, 60, 60, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DarkFlare <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=SSkill)
value <- c(30)
info <- c(350 + 14 * NightLordCore[[2]][3, 2], 12, 360, 990, 12, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SecretBook <- rbind(data.frame(option, value), info)}

NightLordSummoned <- Summoned(list(DarkFlare=DarkFlare, SecretBook=SecretBook, SpiderInMirrorStart=SpiderInMirrorStart, 
                                   SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                   SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## NightLord - DealCycle & Deal Calculation
ATKFinal <- data.frame(NightLordATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, NightLordSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)

BuffFinal <- data.frame(NightLordBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, NightLordSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)
ATKFinal <- AddATKRateSkills("ShadowPartner", BuffFinal, ATKFinal, c("QuadrapleThrow", "SuddenRaid", "ThrowingKnife", "ThrowBlasting"))

SummonedFinal <- data.frame(NightLordSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * NightLordSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(NightLordBuff))
NightLordDealCycle <- t(rep(0, length(DealCycle)))
colnames(NightLordDealCycle) <- DealCycle



NightLordCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, Period=180.5, CycleTime=361) {
  BuffSummonedPrior <- c("JavelinBooster", "ShadowPartner", "SpiritJavelin", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure", "DarkFlare", 
                         "BleedingToxin", "ThrowBlastingBuff", "MapleWarriors2", "SpreadThrow",
                         "SoulContractLink", "UltimateDarkSight", "ReadyToDie2Stack", "Restraint4", "PurgeArea", "SecretBook")
  
  Times180 <- c(1, 1, 1, 1, 1, 1, 0, -180.5/57, 1, 1, 1, 1, 2, 1, -180.5/71.25, 1, 4, -180.5/57)
  
  SubTime <- rep(Period, length(Times180))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times180[i]==0, Inf, Times180[i])
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
  TimeTypes <- c(TimeTypes, 57, 114, 237.5, 294.5, 109, 289.5)
  TimeTypes <- TimeTypes[TimeTypes < TotalTime]
  TimeTypes <- unique(TimeTypes)
  TimeTypes <- TimeTypes[order(TimeTypes)]
  
  Buffs <- data.frame(Buff=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  Buffs <- subset(Buffs, Buffs$SubTime > 0)
  
  BuffList <- list()
  BuffList[[1]] <- BuffSummonedPrior
  for(i in 1:length(TimeTypes)) {
    s <- c()
    if(TimeTypes[i]==180.5) {
      s <- BuffSummonedPrior[Times180!=0]
    } else {
      if(sum(TimeTypes[i]==c(57, 114, 237.5, 294.5))==1) {
        s <- c(s, "DarkFlare")
      }
      for(j in 1:nrow(Buffs)) {
        if(round(TimeTypes[i] / Buffs[j, 2]) == TimeTypes[i] / Buffs[j, 2]) {
          s <- c(s, Buffs[j, 1])
        }
      }
      if(sum(TimeTypes[i]==c(57, 114, 237.5, 294.5))==1) {
        s <- c(s, "SecretBook")
      }
      if(sum(TimeTypes[i]==c(109, 289.5))==1) {
        s <- c(s, "ReadyToDie2Stack")
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
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  SubTimeList$SubTime <- abs(SubTimeList$SubTime)
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
  TNCool <- subset(ATKFinal, rownames(ATKFinal)=="ThrowingKnife")$CoolTime * 1000
  SRCool <- subset(ATKFinal, rownames(ATKFinal)=="SuddenRaid")$CoolTime * 1000
  TNRemain <- 0 ; SRRemain <- 0
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  RTDDummy <- 0

  for(k in 2:length(BuffList)) {
    CycleBuffList <- data.frame(Skills=BuffList[[k]], Delay=BuffDelays[[k]])
    if(RTDDummy==0 & sum(BuffList[[k]]=="ReadyToDie2Stack")==1) {
      SubTimeList$SubTime[SubTimeList$Skills=="ReadyToDie2Stack"] <- 108.5
      RTDDummy <- 1
    } else if(RTDDummy==1 & sum(BuffList[[k]]=="ReadyToDie2Stack")==1) {
      SubTimeList$SubTime[SubTimeList$Skills=="ReadyToDie2Stack"] <- subset(BuffFinal, rownames(BuffFinal)=="ReadyToDie2Stack")$CoolTime
      RTDDummy <- 0
    }
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
      BuffEndTime[i] <- max(a$Time) + ifelse(BuffList[[k]][i]=="ReadyToDie2Stack", subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000, 
        min(subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000, subset(BuffFinal, rownames(BuffFinal)==BuffList[[k]][i])$CoolTime * 1000, 
            subset(SummonedFinal, rownames(SummonedFinal)==BuffList[[k]][i])$CoolTime * 1000)) + 
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
      ## Throwing Knife
      if(TNRemain==0) {
        DealCycle <- DCATK(DealCycle, "ThrowingKnife", ATKFinal)
        TNRemain <- TNCool - DealCycle$Time[1]
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
      } 
      ## Sudden Raid
      else if(SRRemain==0 & (DealCycle$SpreadThrow[nrow(DealCycle)] - DealCycle$Time[1]) <= 0) {
        DealCycle <- DCATK(DealCycle, "SuddenRaid", ATKFinal)
        TNRemain <- max(0, TNRemain - DealCycle$Time[1])
        SRRemain <- SRCool - DealCycle$Time[1]
      }
      ## Quadraple Throw
      else {
        DealCycle <- DCATK(DealCycle, "QuadrapleThrow", ATKFinal)
        TNRemain <- max(0, TNRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
      }
    }
      
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          TNRemain <- max(0, TNRemain - DealCycle$Time[1])
          SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          TNRemain <- max(0, TNRemain - DealCycle$Time[1])
          SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}
  
NightLordDealCycle <- NightLordCycle(PreDealCycle=NightLordDealCycle, 
                                     ATKFinal=ATKFinal,
                                     BuffFinal=BuffFinal, 
                                     SummonedFinal=SummonedFinal, 
                                     Spec=NightLordSpec,
                                     Period=180.5, 
                                     CycleTime=361)
NightLordDealCycle <- DealCycleFinal(NightLordDealCycle)
NightLordDealCycle <- RepATKCycle(NightLordDealCycle, c("ThrowingKnife"), 12, 420, ATKFinal)
NightLordDealCycle <- SecretBookCycle(NightLordDealCycle, SummonedFinal)
NightLordDealCycle <- ThrowBlastingCycle(NightLordDealCycle)
NightLordDealCycle <- AddATKsCycleNightLord(NightLordDealCycle)
NightLordDealCycle <- DCSummonedATKs(NightLordDealCycle, Skill=c("DarkFlare"), SummonedFinal)
NightLordDealCycle <- DCSpiderInMirror(NightLordDealCycle, SummonedFinal)
NightLordDealCycleReduction <- DealCycleReduction(NightLordDealCycle)

DealCalc(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpec)

NightLordSpecOpt1 <- Optimization1(NightLordDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightLordSpec, NightLordUnionRemained)
NightLordSpecOpt <- NightLordSpec
NightLordSpecOpt$ATKP <- NightLordSpecOpt$ATKP + NightLordSpecOpt1$ATKP
NightLordSpecOpt$BDR <- NightLordSpecOpt$BDR + NightLordSpecOpt1$BDR
NightLordSpecOpt$IGR <- IGRCalc(c(NightLordSpecOpt$IGR, NightLordSpecOpt1$IGR))

NightLordSpecOpt2 <- Optimization2(NightLordDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt, NightLordHyperStatBase, NightLordBase$ChrLv, NightLordBase$CRROver)
NightLordFinalDPM <- DealCalc(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt2)
NightLordFinalDPMwithMax <- DealCalcWithMaxDMR(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt2)

DPM12347$NightLord[1] <- sum(na.omit(NightLordFinalDPMwithMax)) / (max(NightLordDealCycle$Time) / 60000)
DPM12347$NightLord[2] <- sum(na.omit(NightLordFinalDPM)) / (max(NightLordDealCycle$Time) / 60000) - sum(na.omit(NightLordFinalDPMwithMax)) / (max(NightLordDealCycle$Time) / 60000)

NightLordDealData <- data.frame(NightLordDealCycle$Skills, NightLordDealCycle$Time, NightLordDealCycle$Restraint4, NightLordFinalDPMwithMax)
colnames(NightLordDealData) <- c("Skills", "Time", "R4", "Deal")
subset(NightLordDealData, NightLordDealData$R4>0)

NightLordRR <- NightLordDealData[31:434, ]
DPM12347$NightLord[3] <- sum((NightLordRR$Deal))

NightLord40s <- NightLordDealData[31:726, ]
DPM12347$NightLord[4] <- sum((NightLord40s$Deal))

NightLordDealRatio <- DealRatio(NightLordDealCycle, NightLordFinalDPMwithMax)