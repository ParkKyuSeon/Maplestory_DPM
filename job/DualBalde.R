## DualBlade - Data
## DualBlade - VMatrix
DualBladeCoreBase <- CoreBuilder(ActSkills=c("BladeStorm", "KarmaFury", "BladeTornado", "HuntedEdge", 
                                             CommonV("Thief", "Adventure")), 
                                 ActSkillsLv=c(25, 25, 25, 25, 1, 25, 25, 25, 25), 
                                 UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                 SpecSet=get(DPMCalcOption$SpecSet), 
                                 VPassiveList=DualBladeVPassive, 
                                 VPassivePrior=DualBladeVPrior, 
                                 SelfBind=F)

DualBladeCore <- MatrixSet(PasSkills=DualBladeCoreBase$PasSkills$Skills, 
                           PasLvs=DualBladeCoreBase$PasSkills$Lv, 
                           PasMP=DualBladeCoreBase$PasSkills$MP, 
                           ActSkills=DualBladeCoreBase$ActSkills$Skills, 
                           ActLvs=DualBladeCoreBase$ActSkills$Lv, 
                           ActMP=DualBladeCoreBase$ActSkills$MP, 
                           UsefulSkills=DualBladeCoreBase$UsefulSkills, 
                           UsefulLvs=20, 
                           UsefulMP=0, 
                           SpecSet=get(DPMCalcOption$SpecSet), 
                           SpecialCore=DualBladeCoreBase$SpecialCoreUse)

## DualBlade - Basic Info
DualBladeBase <- JobBase(ChrInfo=ChrInfo, 
                         MobInfo=get(DPMCalcOption$MobSet),
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         Job="DualBlader",
                         CoreData=DualBladeCore, 
                         BuffDurationNeeded=0, 
                         AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "DualBlader"), 
                         LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "DualBlader"), 
                         MonsterLife=get(FindJob(MonsterLifePreSet, "DualBlader")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                         Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                         WeaponType=SpecDefault$WeaponType, 
                         SubWeapon=BladeUpgrade(1, DPMCalcOption$WeaponSF, DPMCalcOption$DualBladeBladeType), 
                         Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                         CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "DualBlader")))


## DualBlade - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Karma <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
DualBladeAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + DualBladeBase$PSkillLv)
ThornsEffect <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(35 + 3 * DualBladeBase$PSkillLv, 13 + DualBladeBase$PSkillLv)
Sharpness <- data.frame(option, value)

option <- factor(c("ATK", "Mastery", "FDR"), levels=PSkill)
value <- c(30 + DualBladeBase$PSkillLv, 70 + ceiling(DualBladeBase$PSkillLv/2), 20 + floor(DualBladeBase$PSkillLv/2))
DualBladeExpert <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(GetCoreLv(DualBladeCore, "ReadyToDie"))
ReadyToDie <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(GetCoreLv(DualBladeCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(DualBladeCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

DualBladePassive <- Passive(list(Karma=Karma, PhysicalTraining=PhysicalTraining, DualBladeAcceleration=DualBladeAcceleration, ThornsEffect=ThornsEffect, Sharpness=Sharpness, DualBladeExpert=DualBladeExpert, 
                                 ReadyToDie=ReadyToDie, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## DualBlade - Buff
{option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(200, NA, 900, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MirrorImaging <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(40 + DualBladeBase$SkillLv)
info <- c(60, 60, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalCutBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((DualBladeBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(DualBladeBase$SkillLv/2))))
info <- c(900 + 30 * DualBladeBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(25, 60, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FlashBangBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATKSkill"), levels=BSkill)
value <- c(10, 1)
info <- c(60, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HiddenBladeBuff <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(DualBladeCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(DualBladeCore, "UltimateDarkSight")/5))
info <- c(30, 220 - GetCoreLv(DualBladeCore, "UltimateDarkSight"), 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateDarkSight <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(GetCoreLv(DualBladeCore, "ReadyToDie")/10))
info <- c(30, 90 - floor(GetCoreLv(DualBladeCore, "ReadyToDie")/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(DualBladeCore, "ReadyToDie")/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(GetCoreLv(DualBladeCore, "ReadyToDie")/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(DualBladeCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * DualBladeBase$MainStatP), 5 + floor(GetCoreLv(DualBladeCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

DualBladeBuff <- list(MirrorImaging=MirrorImaging, FinalCutBuff=FinalCutBuff, MapleSoldier=MapleSoldier, FlashBangBuff=FlashBangBuff, EpicAdventure=EpicAdventure, 
                      HiddenBladeBuff=HiddenBladeBuff, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UltimateDarkSight=UltimateDarkSight, 
                      ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : NA -> Not Use Useful Advanced Bless
DualBladeBuff <- Buff(DualBladeBuff)
DualBladeAllTimeBuff <- AllTimeBuff(DualBladeBuff)
## Useful Skill Delay
DualBladeBuff <- data.frame(DualBladeBuff)
DualBladeBuff[rownames(DualBladeBuff)=="UsefulSharpEyes", ]$Delay <- 900
DualBladeBuff[rownames(DualBladeBuff)=="UsefulCombatOrders", ]$Delay <- 1500


## DualBlade - Union & HyperStat & SoulWeapon
DualBladeSpec <- JobSpec(JobBase=DualBladeBase, 
                         Passive=DualBladePassive, 
                         AllTimeBuff=DualBladeAllTimeBuff, 
                         MobInfo=get(DPMCalcOption$MobSet), 
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         WeaponName="Dagger", 
                         UnionStance=0)

DualBladeUnionRemained <- DualBladeSpec$UnionRemained
DualBladeHyperStatBase <- DualBladeSpec$HyperStatBase
DualBladeCoolReduceType <- DualBladeSpec$CoolReduceType
DualBladeSpec <- DualBladeSpec$Spec


## DualBlade - Spider In Mirror
SIM <- SIMData(GetCoreLv(DualBladeCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## DualBlade - Attacks
{option <- factor("BDR", levels=ASkill)
value <- c(-10)
info <- c(250, 1, 510, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlashBang <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(DualBladeCore, "PhantomBlow"), 20, IGRCalc(c(ifelse(GetCoreLv(DualBladeCore, "PhantomBlow")>=40, 20, 0), 20, 30 + DualBladeSpec$SkillLv)))
info <- c(315 + 3 * DualBladeSpec$SkillLv, 7, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PhantomBlow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1000, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCutPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(2000 + 20 * DualBladeSpec$SkillLv, 1, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCut <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(DualBladeCore, "SuddenRaid"), ifelse(GetCoreLv(DualBladeCore, "SuddenRaid")>=40, 20, 0))
info <- c(494 + 5 * DualBladeSpec$SkillLv, 7, 900, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SuddenRaid <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(DualBladeCore, "HiddenBlade"), DualBladeBase$MonsterLife$FinalATKDMR, ifelse(GetCoreLv(DualBladeCore, "HiddenBlade")>=40, 20, 0))
info <- c(140, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HiddenBlade <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 600, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AsuraPre <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(DualBladeCore, "Asura"), 100)
info <- c(693, 5, 4400, 330, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Asura <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AsuraEnd <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(580 + 23 * GetCoreLv(DualBladeCore, "BladeStorm"), 7, 30, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStormPre <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(565 + 12 * GetCoreLv(DualBladeCore, "BladeStorm"), 5, 4970, 210, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStorm <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 120, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStormEnd <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(30)
info <- c(400 + 16 * GetCoreLv(DualBladeCore, "KarmaFury"), 7, 990, 180, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
KarmaFury <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(600 + 24 * GetCoreLv(DualBladeCore, "BladeTornado"), 7, 0, NA, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeTornadoPre <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(400 + 16 * GetCoreLv(DualBladeCore, "BladeTornado"), 6, 720, 120, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeTornado <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(30)
info <- c(410 + 8 * GetCoreLv(DualBladeCore, "HuntedEdge"), 4, 0, 90, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HuntedEdge <- rbind(data.frame(option, value), info)}

DualBladeATK <- Attack(list(FlashBang=FlashBang, PhantomBlow=PhantomBlow, FinalCutPre=FinalCutPre, FinalCut=FinalCut, SuddenRaid=SuddenRaid, HiddenBlade=HiddenBlade, AsuraPre=AsuraPre, Asura=Asura, AsuraEnd=AsuraEnd, 
                            BladeStormPre=BladeStormPre, BladeStorm=BladeStorm, BladeStormEnd=BladeStormEnd, KarmaFury=KarmaFury, BladeTornadoPre=BladeTornadoPre, BladeTornado=BladeTornado, HuntedEdge=HuntedEdge,
                            SpiderInMirror=SpiderInMirror))


## DualBlade - Summoned
DualBladeSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart,
                                   SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                   SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## DualBlade - DealCycle
ATKFinal <- data.frame(DualBladeATK)
ATKFinal$Delay[c(-3, -7, -8, -9, -10, -11, -12)] <- Delay(ATKFinal$Delay, DualBladeSpec$ATKSpeed)[c(-3, -7, -8, -9, -10, -11, -12)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)

BuffFinal <- data.frame(DualBladeBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, DualBladeSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
ATKFinal <- AddATKRateSkills("MirrorImaging", BuffFinal, ATKFinal, c("PhantomBlow", "FinalCut", "SuddenRaid", "Asura", "BladeStormPre", "BladeStorm", "KarmaFury", "BladeTornadoPre", "BladeTornado", "HuntedEdge"))

SummonedFinal <- data.frame(DualBladeSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * DualBladeSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(DualBladeBuff))
DualBladeDealCycle <- t(rep(0, length(DealCycle)))
colnames(DualBladeDealCycle) <- DealCycle

DualBladeCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                           Period=180.5, CycleTime=361) {
  BuffSummonedPrior <- c("MirrorImaging", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure", "HiddenBladeBuff", "FlashBangBuff", "FinalCutBuff",
                         "MapleWarriors2", "UltimateDarkSight", "SoulContractLink", "ReadyToDie2Stack", "Restraint4")
  Times180 <- c(1, 1, 1, 1, 0, 1, 2, 0, 1, 1, 2, 2, 1)
  
  SubTime <- rep(Period - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime - (CycleTime/Period) * Spec$CoolReduce
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
      if(BuffList[[1]][i]=="FinalCutBuff") {
        DealCycle <- DCATK(DealCycle, "FinalCutPre", ATKFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)] == "EpicAdventure") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      } else if(DealCycle$Skills[nrow(DealCycle)] == "FinalCutBuff") {
        DealCycle <- DCATK(DealCycle, "FinalCut", ATKFinal)
        DealCycle <- DCATK(DealCycle, "SuddenRaid", ATKFinal)
      } else if(DealCycle$Skills[nrow(DealCycle)] == "FlashBangBuff") {
        DealCycle <- DCATK(DealCycle, "FlashBang", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c()
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
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  SRCool <- subset(ATKFinal, rownames(ATKFinal)=="SuddenRaid")$CoolTime * 1000
  SRRemain <- subset(ATKFinal, rownames(ATKFinal)=="SuddenRaid")$CoolTime * 1000 - subset(DealCycle, DealCycle$Skills=="SuddenRaid")$Time - DealCycle$Time[1]
  BTCool <- subset(ATKFinal, rownames(ATKFinal)=="BladeTornado")$CoolTime * 1000
  KFCool <- subset(ATKFinal, rownames(ATKFinal)=="KarmaFury")$CoolTime * 1000
  BSCool <- subset(ATKFinal, rownames(ATKFinal)=="BladeStorm")$CoolTime * 1000
  BTRemain <- 0 ; KFRemain <- 0 ; BSRemain <- 0

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
          if(colnames(DealCycle)[ColNums[i]]=="FinalCutBuff") {
            DealCycle <- DCATK(DealCycle, "FinalCutPre", ATKFinal)
            KFRemain <- max(0, KFRemain - DealCycle$Time[1])
            BTRemain <- max(0, BTRemain - DealCycle$Time[1])
            SRRemain <- max(0, SRRemain - DealCycle$Time[1])
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DealCycle <- DCBuff(DealCycle, "FinalCutBuff", BuffFinal)
            KFRemain <- max(0, KFRemain - DealCycle$Time[1])
            BTRemain <- max(0, BTRemain - DealCycle$Time[1])
            SRRemain <- max(0, SRRemain - DealCycle$Time[1])
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DealCycle <- DCATK(DealCycle, "FinalCut", ATKFinal)
            KFRemain <- max(0, KFRemain - DealCycle$Time[1])
            BTRemain <- max(0, BTRemain - DealCycle$Time[1])
            SRRemain <- max(0, SRRemain - DealCycle$Time[1])
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          } else {
            DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
            KFRemain <- max(0, KFRemain - DealCycle$Time[1])
            BTRemain <- max(0, BTRemain - DealCycle$Time[1])
            SRRemain <- max(0, SRRemain - DealCycle$Time[1])
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          }
        }
      }
      ## Blade Tornado
      if(BTRemain == 0) {
        DealCycle <- DCATK(DealCycle, "BladeTornadoPre", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- BTCool - DealCycle$Time[1]
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "BladeTornado", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
      }
      ## Karma Fury
      else if(KFRemain == 0) {
        DealCycle <- DCATK(DealCycle, "KarmaFury", ATKFinal)
        KFRemain <- KFCool - DealCycle$Time[1]
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
      }
      ## Blade Storm, Asura
      else if(BSRemain==0 & BTRemain > BTCool - 7000 & DealCycle$ReadyToDie2Stack[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "PhantomBlow", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "BladeStormPre", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- BSCool - DealCycle$Time[1]
        DealCycle <- DCATK(DealCycle, "BladeStorm", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "BladeStormEnd", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "AsuraPre", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Asura", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "AsuraEnd", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "BladeTornadoPre", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- BTCool - DealCycle$Time[1]
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "BladeTornado", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "KarmaFury", ATKFinal)
        KFRemain <- KFCool - DealCycle$Time[1]
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "PhantomBlow", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
      }
      ## Sudden Raid
      else if(SRRemain==0) {
        DealCycle <- DCATK(DealCycle, "SuddenRaid", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- SRCool - DealCycle$Time[1]
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
      }
      ## Phantom Blow
      else {
        DealCycle <- DCATK(DealCycle, "PhantomBlow", ATKFinal)
        KFRemain <- max(0, KFRemain - DealCycle$Time[1])
        BTRemain <- max(0, BTRemain - DealCycle$Time[1])
        SRRemain <- max(0, SRRemain - DealCycle$Time[1])
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          KFRemain <- max(0, KFRemain - DealCycle$Time[1])
          BTRemain <- max(0, BTRemain - DealCycle$Time[1])
          SRRemain <- max(0, SRRemain - DealCycle$Time[1])
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)] == "FlashBangBuff") {
            DealCycle <- DCATK(DealCycle, "FlashBang", ATKFinal)
            KFRemain <- max(0, KFRemain - DealCycle$Time[1])
            BTRemain <- max(0, BTRemain - DealCycle$Time[1])
            SRRemain <- max(0, SRRemain - DealCycle$Time[1])
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          KFRemain <- max(0, KFRemain - DealCycle$Time[1])
          BTRemain <- max(0, BTRemain - DealCycle$Time[1])
          SRRemain <- max(0, SRRemain - DealCycle$Time[1])
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}

DualBladeDealCycle <- DualBladeCycle(PreDealCycle=DualBladeDealCycle, 
                                         ATKFinal=ATKFinal, 
                                         BuffFinal=BuffFinal, 
                                         SummonedFinal=SummonedFinal, 
                                         Spec=DualBladeSpec, 
                                         Period=180.5, 
                                         CycleTime=361)
DualBladeDealCycle <- DealCycleFinal(DualBladeDealCycle)
DualBladeDealCycle <- HuntedEdgeCycle(DualBladeDealCycle, ATKFinal[rownames(ATKFinal)=="HuntedEdge", ]$CoolTime * 1000)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "HuntedEdge", 5, 30, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "KarmaFury", 5, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "BladeTornado", 5, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "Asura", 14, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "BladeStorm", 42, 0, ATKFinal)
DualBladeDealCycle <- AddATKCycleDualBlade(DualBladeDealCycle)
DualBladeDealCycle <- DCSpiderInMirror(DualBladeDealCycle, SummonedFinal)
DualBladeDealCycleReduction <- DealCycleReduction(DualBladeDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="DualBlader") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  DualBladeSpecOpt1 <- Optimization1(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpec, DualBladeUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- DualBladeSpecOpt1[1, 1:3]
} else {
  DualBladeSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
DualBladeSpecOpt <- OptDataAdd(DualBladeSpec, DualBladeSpecOpt1, "Potential", DualBladeBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  DualBladeSpecOpt2 <- Optimization2(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt, DualBladeHyperStatBase, DualBladeBase$ChrLv, DualBladeBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- DualBladeSpecOpt2[1, ]
} else {
  DualBladeSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
DualBladeSpecOpt <- OptDataAdd(DualBladeSpecOpt, DualBladeSpecOpt2, "HyperStat", DualBladeBase$CRROver, DemonAvenger=F)

DualBladeFinalDPM <- DealCalc(DualBladeDealCycle, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt, Collapse=F)
DualBladeFinalDPMwithMax <- DealCalcWithMaxDMR(DualBladeDealCycle, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "DualBlader", sum(na.omit(DualBladeFinalDPMwithMax)) / (max(DualBladeDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "DualBlader", sum(na.omit(DualBladeFinalDPM)) / (max(DualBladeDealCycle$Time) / 60000) - sum(na.omit(DualBladeFinalDPMwithMax)) / (max(DualBladeDealCycle$Time) / 60000))

DualBladeDealRatio <- DealRatio(DualBladeDealCycle, DualBladeFinalDPMwithMax)

DualBladeDealData <- data.frame(DualBladeDealCycle$Skills, DualBladeDealCycle$Time, DualBladeDealCycle$Restraint4, DualBladeFinalDPMwithMax)
colnames(DualBladeDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "DualBlader", Deal_RR(DualBladeDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "DualBlader", Deal_40s(DualBladeDealData))

DualBladeSpecMean <- SpecMean("DualBlade", DualBladeDealCycleReduction, 
                              DealCalcWithMaxDMR(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt), 
                              ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt)