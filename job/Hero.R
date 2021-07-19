## Hero - Data
## Hero - VMatrix
HeroCore <- MatrixSet(PasSkills=c("RagingBlow", "RageUprising", "AdvancedFinalAttack", "Incising", "Panic"), 
                      PasLvs=c(50, 50, 50, 50, 50), 
                      PasMP=c(10, 10, 10, 10, 10), 
                      ActSkills=c("SwordofBurningSoul", "ComboDeathfault", "ComboInstinct", "SwordIllusion",
                                  CommonV("Warrior", "Adventure")), 
                      ActLvs=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                      ActMP=c(5, 5, 5, 5, 5, 0, 0, 5, 5), 
                      BlinkLv=1, 
                      BlinkMP=0, 
                      UsefulSkills=c("CombatOrders", "SharpEyes"), 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=SpecDefault, 
                      SelfBind=F)


## Hero - Basic Info
## Link, CoolReduceHat Check Needed
HeroBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=MobDefault,
                    SpecSet=SpecDefault, 
                    Job="Hero",
                    CoreData=HeroCore, 
                    BuffDurationNeeded=0, 
                    AbilList=c("BDR", "DisorderBDR"), 
                    LinkList=c("AdventureWarrior", "AdventureBowman", "DemonAvenger", "Phantom"), 
                    MonsterLife=MLTypeS22, 
                    Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandAxe", SpecDefault$WeaponType)[, 1:16],
                    WeaponType=SpecDefault$WeaponType, 
                    SubWeapon=SubWeapon[1, ], 
                    Emblem=Emblem[1, ], 
                    CoolReduceHat=T)


## Hero - Passive
{option <- factor(c("FDR", "BDR", "ATKSpeed"), levels=PSkill)
value <- c(10, 5, 1)
WeaponMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("CRR", levels=PSkill)
value <- c(20)
ChanceAttack <- data.frame(option, value) ## FDR - Buff

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(25, 20)
Enrage <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70)
AdvancedCombo <- data.frame(option, value) ## Combo - Logic

option <- factor(c("IGR"), levels=PSkill)
value <- c(50 + HeroBase$PSkillLv)
CombatMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + HeroBase$PSkillLv)
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(HeroCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(HeroCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

HeroPassive <- Passive(list(WeaponMastery, PhysicalTraining, ChanceAttack, Enrage, AdvancedCombo, CombatMastery, AdvancedFinalAttack, BodyofStealPassive, BlinkPassive))


## Hero - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Fury <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(25)
info <- c(40, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PanicBuff <- rbind(data.frame(option, value), info)

option <- factor("DMR", levels=BSkill)
value <- c(25 + ceiling(HeroBase$SkillLv/2))
info <- c(30, 31, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IncisingBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((HeroBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(HeroBase$SkillLv/2))))
info <- c(900 + 30 * HeroBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * HeroCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * HeroCore[[3]][1, 2], NA, 0, F, NA, NA, T)
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
value <- c(50)
info <- c(30, 150, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Valhalla <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(30, 240, 450, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboInstinct <- rbind(data.frame(option, value), info) ## Combo Data

option <- factor(levels=BSkill)
value <- c()
info <- c(5, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfaultBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(HeroCore[[2]][5, 2]/5), ceiling(HeroCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * HeroCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * HeroCore[[2]][8, 2]) * MapleSoldier[1, 2]) * HeroBase$MainStatP), 5 + floor(HeroCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

HeroBuff <- Buff(list(WeaponBooster=WeaponBooster, Fury=Fury, PanicBuff=PanicBuff, IncisingBuff=IncisingBuff, MapleSoldier=MapleSoldier,
                      UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, 
                      Valhalla=Valhalla, ComboInstinct=ComboInstinct, ComboDeathfaultBuff=ComboDeathfaultBuff, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, 
                      Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : UsefulSharpEyes, UsefulCombatOrders,Fury(1080ms)
HeroAllTimeBuff <- AllTimeBuff(HeroBuff)


## Hero - Union & HyperStat & SoulWeapon
HeroSpec <- JobSpec(JobBase=HeroBase, 
                    Passive=HeroPassive, 
                    AllTimeBuff=HeroAllTimeBuff, 
                    MobInfo=MobDefault, 
                    SpecSet=SpecDefault, 
                    WeaponName="TwohandAxe", 
                    UnionStance=0, 
                    JobConstant=1.44/1.34)

HeroUnionRemained <- HeroSpec$UnionRemained
HeroHyperStatBase <- HeroSpec$HyperStatBase
HeroCoolReduceType <- HeroSpec$CoolReduceType
HeroSpec <- HeroSpec$Spec


## Hero - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * HeroCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * HeroCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Hero - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][5, 2]>=40, 20, 0), 3 * HeroCore[[1]][5, 2])
info <- c(1150, 1, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Panic <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][1, 2]>=40, 20, 0), 20, 2 * HeroCore[[1]][1, 2])
info <- c(215 + HeroSpec$SkillLv * 3, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RagingBlow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][4, 2]>=40, 20, 0), 2 * HeroCore[[1]][4, 2])
info <- c(576 + HeroSpec$SkillLv * 7, 4, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Incising <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][3, 2]>=40, 20, 0), 10, 2 * HeroCore[[1]][3, 2])
info <- c(170 + HeroSpec$SkillLv * 2, (0.75 + 0.01 * HeroSpec$SkillLv) * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][2, 2]>=40, 20, 0), 2 * HeroCore[[1]][2, 2])
info <- c(500, 8, 990, NA, 10, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RageUprising <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * HeroCore[[2]][2, 2], 14, 1680, NA, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfault <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * HeroCore[[2]][3, 2], 18, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScarofSpace <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(125 + 5 * HeroCore[[2]][4, 2], 4, 870, 120, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * HeroCore[[2]][4, 2], 5, 0, 60, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusionExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * HeroCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

HeroATK <- Attack(list(Panic=Panic, RagingBlow=RagingBlow, Incising=Incising, AdvancedFinalAttack=AdvancedFinalAttack, RageUprising=RageUprising, 
                       ComboDeathfault=ComboDeathfault, ScarofSpace=ScarofSpace, SwordIllusion=SwordIllusion, SwordIllusionExplosion=SwordIllusionExplosion, AuraWeapon=AuraWeapon, 
                       SpiderInMirror=SpiderInMirror))


## Hero - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(315 + 12 * HeroCore[[2]][1, 2], 6, 810 * 2, 1000, 60 + floor(HeroCore[[2]][1, 2]/2), 120, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SwordofBurningSoul <- rbind(data.frame(option, value), info)}

HeroSummoned <- Summoned(list(SwordofBurningSoul=SwordofBurningSoul, SpiderInMirrorStart=SpiderInMirrorStart,
                              SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))



## Hero - DealCycle
ATKFinal <- data.frame(HeroATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, HeroSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)

BuffFinal <- data.frame(HeroBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, HeroSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(HeroSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * HeroSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(HeroBuff))
HeroDealCycle <- t(rep(0, length(DealCycle)))
colnames(HeroDealCycle) <- DealCycle

HeroCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=240, CycleTime=240) {
  BuffSummonedPrior <- c("WeaponBooster", "Fury", "MapleSoldier", "UsefulCombatOrders", "UsefulSharpEyes", "EpicAdventure", 
                         "AuraWeaponBuff", "MapleWarriors2", "SwordofBurningSoul", "Valhalla", "SoulContractLink", "ComboInstinct", "Restraint4")
  
  Times240 <- c(0, 0, 0, 0, 0, 0, 1, 1, 2, 1, 2, 1, 1)
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times240[i]==0, Inf, Times240[i])
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
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      } else if(BuffList[[1]][i]=="Valhalla") {
        DealCycle <- DCBuff(DealCycle, "PanicBuff", BuffFinal)
        DealCycle <- DCATK(DealCycle, "Panic", ATKFinal)
        DealCycle <- DCBuff(DealCycle, "IncisingBuff", BuffFinal)
        DealCycle <- DCATK(DealCycle, "Incising", ATKFinal)
      } else if(BuffList[[1]][i]=="SoulContractLink") {
        DealCycle <- DCATK(DealCycle, "SwordIllusion", ATKFinal)
        DealCycle <- DCBuff(DealCycle, "ComboDeathfaultBuff", BuffFinal)
        DealCycle <- DCATK(DealCycle, "ComboDeathfault", ATKFinal)
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
  RUCool <- subset(ATKFinal, rownames(ATKFinal)=="RageUprising")$CoolTime * 1000
  SICool <- subset(ATKFinal, rownames(ATKFinal)=="SwordIllusion")$CoolTime * 1000
  RURemain <- 0 ; RUDummy <- 0
  SIRemain <- subset(ATKFinal, rownames(ATKFinal)=="SwordIllusion")$CoolTime * 1000 - subset(DealCycle, DealCycle$Skills=="SwordIllusion")$Time - DealCycle$Time[1]
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
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        }
      }
      ## Panic
      if(DealCycle$PanicBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 2000 & DealCycle$ComboInstinct[nrow(DealCycle)]==0) {
        DealCycle <- DCBuff(DealCycle, "PanicBuff", BuffFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Panic", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
      }
      ## Sword Illusion + Combo Deathfault & Incising + Rage Uprising
      else if(SIRemain==0 & DealCycle$ComboInstinct[nrow(DealCycle)]==0) {
        DealCycle <- DCATK(DealCycle, "SwordIllusion", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- SICool - DealCycle$Time[1]
        DealCycle <- DCBuff(DealCycle, "ComboDeathfaultBuff", BuffFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "ComboDeathfault", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "IncisingBuff", BuffFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Incising", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "IncisingBuff", BuffFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Incising", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "RageUprising", ATKFinal)
        RURemain <- RUCool - DealCycle$Time[1]
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        RUDummy <- 0
      }
      ## Rage Uprising
      else if(RURemain==0 & RUDummy==0 & DealCycle$ComboInstinct[nrow(DealCycle)]==0) {
        DealCycle <- DCATK(DealCycle, "RageUprising", ATKFinal)
        RURemain <- RUCool - DealCycle$Time[1]
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        RUDummy <- 1
      }
      ## Raging Blow
      else {
        DealCycle <- DCATK(DealCycle, "RagingBlow", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}
      

HeroDealCycle <- HeroCycle(PreDealCycle=HeroDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=HeroSpec,
                                   Period=240, 
                                   CycleTime=240)
HeroDealCycle <- DealCycleFinal(HeroDealCycle)
HeroDealCycle <- DCSummonedATKs(HeroDealCycle, "SwordofBurningSoul", SummonedFinal)
HeroDealCycle <- SwordIllusionCycle(HeroDealCycle, ATKFinal)
HeroDealCycle <- AddATKsCycleHero(HeroDealCycle)
HeroDealCycle <- AuraWeaponCycleHero(HeroDealCycle)
HeroDealCycle <- DCSpiderInMirror(HeroDealCycle, SummonedFinal)
HeroDealCycle <- HeroCombo(HeroDealCycle)

HeroDealCycleReduction <- DealCycleReduction(HeroDealCycle, c("ComboFDR", "ComboBDR", "ComboATK"))

HeroDealCalc(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpec)

HeroSpecOpt1 <- HeroOptimization1(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpec, HeroUnionRemained)
HeroSpecOpt <- HeroSpec
HeroSpecOpt$ATKP <- HeroSpecOpt$ATKP + HeroSpecOpt1$ATKP
HeroSpecOpt$BDR <- HeroSpecOpt$BDR + HeroSpecOpt1$BDR
HeroSpecOpt$IGR <- IGRCalc(c(HeroSpecOpt$IGR, HeroSpecOpt1$IGR))

HeroSpecOpt2 <- HeroOptimization2(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt, HeroHyperStatBase, HeroBase$ChrLv, HeroBase$CRROver)
HeroFinalDPM <- HeroDealCalc(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt2)
HeroFinalDPMwithMax <- HeroDealCalcWithMaxDMR(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt2)

DPM12349$Hero[1] <- sum(na.omit(HeroFinalDPMwithMax)) / (max(HeroDealCycle$Time) / 60000)
DPM12349$Hero[2] <- sum(na.omit(HeroFinalDPM)) / (max(HeroDealCycle$Time) / 60000) - sum(na.omit(HeroFinalDPMwithMax)) / (max(HeroDealCycle$Time) / 60000)

HeroDealData <- data.frame(HeroDealCycle$Skills, HeroDealCycle$Time, HeroDealCycle$Restraint4, HeroFinalDPMwithMax)
colnames(HeroDealData) <- c("Skills", "Time", "R4", "Deal")
subset(HeroDealData, HeroDealData$R4>0)

HeroRR <- HeroDealData[57:179, ]
DPM12349$Hero[3] <- sum((HeroRR$Deal))

Hero40s <- HeroDealData[30:361, ]
DPM12349$Hero[4] <- sum((Hero40s$Deal)) 

DealRatio(HeroDealCycle, HeroFinalDPMwithMax)