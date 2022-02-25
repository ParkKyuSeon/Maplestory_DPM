## Hero - Data
## Hero - VMatrix
HeroCoreBase <- CoreBuilder(ActSkills=c("SwordofBurningSoul", "ComboDeathfault", "ComboInstinct", "SwordIllusion",
                                        CommonV("Warrior", "Adventure")), 
                            ActSkillsLv=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            VPassiveList=HeroVPassive, 
                            VPassivePrior=HeroVPrior, 
                            SelfBind=F)

HeroCore <- MatrixSet(PasSkills=HeroCoreBase$PasSkills$Skills, 
                      PasLvs=HeroCoreBase$PasSkills$Lv, 
                      PasMP=HeroCoreBase$PasSkills$MP, 
                      ActSkills=HeroCoreBase$ActSkills$Skills, 
                      ActLvs=HeroCoreBase$ActSkills$Lv, 
                      ActMP=HeroCoreBase$ActSkills$MP, 
                      UsefulSkills=HeroCoreBase$UsefulSkills, 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      SpecialCore=HeroCoreBase$SpecialCoreUse)


## Hero - Basic Info
## Link, CoolReduceHat Check Needed
HeroBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=get(DPMCalcOption$MobSet),
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    Job="Hero",
                    CoreData=HeroCore, 
                    BuffDurationNeeded=0, 
                    AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Hero"), 
                    LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Hero"), 
                    MonsterLife=get(FindJob(MonsterLifePreSet, "Hero")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                    Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandAxe", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                    WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="HeroMedal", ], 
                    Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                    CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Hero")))


## Hero - Passive
{option <- factor(c("FDR", "BDR", "ATKSpeed"), levels=PSkill) ## Axe
value <- c(10, 5, 1)
WeaponMastery <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
WeaponAcceleration <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CRR", "FDR"), levels=PSkill)
value <- c(20, 25)
ChanceAttack <- data.frame(option, value)

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(25, 20)
Enrage <- data.frame(option, value)

option <- factor(c("Mastery", "FDR", "BDR", "ATK"), levels=PSkill)
value <- c(70, (12 + ceiling(HeroBase$PSkillLv / 6)) * 10, 2 * 10, 2 * 10)
AdvancedCombo <- data.frame(option, value) ## 10 Combo

option <- factor(c("IGR"), levels=PSkill)
value <- c(50 + HeroBase$PSkillLv)
CombatMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + HeroBase$PSkillLv)
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(HeroCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(HeroCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(HeroCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

HeroPassive <- Passive(list(WeaponMastery, WeaponAcceleration, PhysicalTraining, ChanceAttack, Enrage, AdvancedCombo, CombatMastery, AdvancedFinalAttack, BodyofSteelPassive, BlinkPassive, RopeConnectPassive))


## Hero - Buff
{option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritBlade <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ScaringSword <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(25 + ceiling(HeroBase$SkillLv/2))
info <- c(60, 61, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IncisingBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((HeroBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(HeroBase$SkillLv/2))))
info <- c(900 + 30 * HeroBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(HeroCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(50)
info <- c(30, 120, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Valhalla <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSkill", "FDR", "BDR", "ATK"), levels=BSkill)
value <- c(1, 
           (((12 + ceiling(HeroBase$PSkillLv / 6)) * 10 * (1.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2)) + 100) / ((12 + ceiling(HeroBase$PSkillLv / 6)) * 10 + 100) - 1) * 100, 
           2 * 10 * (0.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2)), 
           2 * 10 * (0.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2)))
info <- c(30, 240, 450, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboInstinct <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(((100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 16) / (100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 10) - 1) * 100)
info <- c(5, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfaultBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c((floor(100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 16 * (1.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2))) / 
             (100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 10 * (1.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2))) - 1) * 100)
info <- c(5, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfaultBuffInstinct <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(((floor(100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 6 * (1.05 + 0.01 * floor(GetCoreLv(HeroCore, "ComboInstinct")/2))) + ((12 + ceiling(HeroBase$PSkillLv / 6)) * 10)) / 
              (100 + (12 + ceiling(HeroBase$PSkillLv / 6)) * 10) - 1) * 100)
info <- c(5, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfaultBuffAfter <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(HeroCore, "AuraWeapon")/5), ceiling(GetCoreLv(HeroCore, "AuraWeapon")/5), 1)
info <- c(80 + 2 * GetCoreLv(HeroCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(HeroCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * HeroBase$MainStatP), 5 + floor(GetCoreLv(HeroCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

HeroBuff <- list(SpiritBlade=SpiritBlade, ScaringSword=ScaringSword, IncisingBuff=IncisingBuff, MapleSoldier=MapleSoldier,
                 UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, 
                 Valhalla=Valhalla, ComboInstinct=ComboInstinct, ComboDeathfaultBuff=ComboDeathfaultBuff, ComboDeathfaultBuffInstinct=ComboDeathfaultBuffInstinct, ComboDeathfaultBuffAfter=ComboDeathfaultBuffAfter, 
                 AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), SpiritBlade(1080ms), ScaringSword(1080ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  HeroBuff[[length(HeroBuff)+1]] <- UsefulAdvancedBless
  names(HeroBuff)[[length(HeroBuff)]] <- "UsefulAdvancedBless"
}
HeroBuff <- Buff(HeroBuff)
HeroAllTimeBuff <- AllTimeBuff(HeroBuff)


## Hero - Union & HyperStat & SoulWeapon
HeroSpec <- JobSpec(JobBase=HeroBase, 
                    Passive=HeroPassive, 
                    AllTimeBuff=HeroAllTimeBuff, 
                    MobInfo=get(DPMCalcOption$MobSet), 
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    WeaponName="TwohandAxe", 
                    UnionStance=0, 
                    JobConstant=1.44/1.34)

HeroUnionRemained <- HeroSpec$UnionRemained
HeroHyperStatBase <- HeroSpec$HyperStatBase
HeroCoolReduceType <- HeroSpec$CoolReduceType
HeroSpec <- HeroSpec$Spec


## Hero - Spider In Mirror
SIM <- SIMData(GetCoreLv(HeroCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Hero - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(HeroCore, "RagingBlow")>=40, 20, 0), 20, 2 * GetCoreLv(HeroCore, "RagingBlow"))
info <- c(215 + HeroSpec$SkillLv * 3, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RagingBlow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(HeroCore, "Incising")>=40, 20, 0), 2 * GetCoreLv(HeroCore, "Incising"))
info <- c(400 + HeroSpec$SkillLv * 3, 4, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Incising <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(HeroCore, "AdvancedFinalAttack")>=40, 20, 0), HeroBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(HeroCore, "AdvancedFinalAttack"))
info <- c(170 + HeroSpec$SkillLv * 2, (0.75 + 0.01 * HeroSpec$SkillLv) * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(HeroCore, "Valhalla")>=40, 20, 0), 2 * GetCoreLv(HeroCore, "Valhalla"))
info <- c(370, 2 * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ValhallaATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(HeroCore, "RageUprising")>=40, 20, 0), 2 * GetCoreLv(HeroCore, "RageUprising"))
info <- c(500, 8, 900, NA, 10, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RageUprising <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(HeroCore, "ComboDeathfault"), 14, 1680, NA, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfault <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * GetCoreLv(HeroCore, "ComboInstinct"), 18, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScarofSpace <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(125 + 5 * GetCoreLv(HeroCore, "SwordIllusion"), 4, 870, 120, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(HeroCore, "SwordIllusion"), 5, 0, 60, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusionExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(HeroCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

HeroATK <- Attack(list(RagingBlow=RagingBlow, Incising=Incising, AdvancedFinalAttack=AdvancedFinalAttack, ValhallaATK=ValhallaATK, RageUprising=RageUprising, 
                       ComboDeathfault=ComboDeathfault, ScarofSpace=ScarofSpace, SwordIllusion=SwordIllusion, SwordIllusionExplosion=SwordIllusionExplosion, AuraWeapon=AuraWeapon, 
                       SpiderInMirror=SpiderInMirror))


## Hero - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(315 + 12 * GetCoreLv(HeroCore, "SwordofBurningSoul"), 6, 810 * 2, 1000, 60 + floor(GetCoreLv(HeroCore, "SwordofBurningSoul")/2), 120, F, T, F, F)
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(HeroSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * HeroSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(HeroBuff))
HeroDealCycle <- t(rep(0, length(DealCycle)))
colnames(HeroDealCycle) <- DealCycle

HeroCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=240, CycleTime=720) {
  BuffSummonedPrior <- c("SpiritBlade", "ScaringSword", "MapleSoldier", "UsefulCombatOrders", "UsefulSharpEyes", "UsefulAdvancedBless", "EpicAdventure", 
                         "AuraWeaponBuff", "MapleWarriors2", "SwordofBurningSoul", "Valhalla", "SoulContractLink", "ComboInstinct", "Restraint4")
  Times240 <- c(0, 0, 0, 0, 0, 0, 0, 
                4/3, 1, 2, 2, 2, 1, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times240 <- Times240[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
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
        DealCycle <- DCBuff(DealCycle, "IncisingBuff", BuffFinal)
        DealCycle <- DCATK(DealCycle, "Incising", ATKFinal)
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
  CDCool <- subset(ATKFinal, rownames(ATKFinal)=="ComboDeathfault")$CoolTime * 1000
  RURemain <- 0
  SIRemain <- 0
  CDRemain <- 0
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
      ## Combo Deathfault
      if(CDRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="ComboDeathfault")) < floor(TotalTime / CDCool)) {
        if(DealCycle$ComboInstinct[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCBuff(DealCycle, "ComboDeathfaultBuffInstinct", BuffFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
          CDRemain <- CDCool - DealCycle$Time[1]
        } else {
          DealCycle <- DCBuff(DealCycle, "ComboDeathfaultBuff", BuffFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
          CDRemain <- CDCool - DealCycle$Time[1]
        }
        DealCycle <- DCATK(DealCycle, "ComboDeathfault", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])        
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
      }
      ## Sword Illusion
      else if(SIRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="SwordIllusion")) < floor(TotalTime / SICool)) {
        DealCycle <- DCATK(DealCycle, "SwordIllusion", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- SICool - DealCycle$Time[1]
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
      }
      ## Rage Uprising
      else if(RURemain==0 & DealCycle$ComboInstinct[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCATK(DealCycle, "RageUprising", ATKFinal)
        RURemain <- RUCool - DealCycle$Time[1]
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])   
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
      }
      ## Incising
      else if(DealCycle$IncisingBuff[nrow(DealCycle)] <= 3000) {
        DealCycle <- DCBuff(DealCycle, "IncisingBuff", BuffFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Incising", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
      }
      ## Raging Blow
      else {
        DealCycle <- DCATK(DealCycle, "RagingBlow", ATKFinal)
        RURemain <- max(0, RURemain - DealCycle$Time[1])
        SIRemain <- max(0, SIRemain - DealCycle$Time[1])
        CDRemain <- max(0, CDRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
          CDRemain <- max(0, CDRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="MapleWarriors2") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            RURemain <- max(0, RURemain - DealCycle$Time[1])
            SIRemain <- max(0, SIRemain - DealCycle$Time[1])
            CDRemain <- max(0, CDRemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          RURemain <- max(0, RURemain - DealCycle$Time[1])
          SIRemain <- max(0, SIRemain - DealCycle$Time[1])
          CDRemain <- max(0, CDRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  while(SIRemain - min(DealCycle[DealCycle$Skills=="SwordIllusion", ]$Time) > 0 & 
        CDRemain - min(DealCycle[DealCycle$Skills=="ComboDeathfault", ]$Time) > 0) {
    DealCycle <- DCATK(DealCycle, "RagingBlow", ATKFinal)
    RURemain <- max(0, RURemain - DealCycle$Time[1])
    SIRemain <- max(0, SIRemain - DealCycle$Time[1])
    CDRemain <- max(0, CDRemain - DealCycle$Time[1])
  }
  return(DealCycle)
}
HeroAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Sword of Burning Soul
  DealCycle <- DCSummonedATKs(DealCycle, "SwordofBurningSoul", SummonedFinal)
  
  
  ## Sword Illusion
  DealCycle <- RepATKCycle(DealCycle, c("SwordIllusion"), 13, 1300, ATKFinal)
  DC1 <- subset(DealCycle, DealCycle$Skills=="SwordIllusion")
  DC2 <- subset(DealCycle, DealCycle$Skills!="SwordIllusion")
  
  t <- floor(nrow(DC1) / 13)
  t <- 1 : t
  t <- 13 * t
  DC1[t, 1] <- "SwordIllusionExplosion"
  
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  DealCycle <- RepATKCycle(DealCycle, c("SwordIllusionExplosion"), 5, 0, ATKFinal)

  
  ## Advanced Final Attack, Combo Instinct Scar of Space
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Incising" | DealCycle$Skills[i]=="RageUprising" | 
       DealCycle$Skills[i]=="ComboDeathfault" | DealCycle$Skills[i]=="SwordIllusion" | DealCycle$Skills[i]=="SwordIllusionExplosion") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    } else if(DealCycle$Skills[i]=="RagingBlow") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    }
    
    if(DealCycle$Skills[i]=="RagingBlow" & DealCycle$ComboInstinct[i]>0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ScarofSpace")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Combo Deathfault Buff Adjust
  DealCycle[DealCycle$Skills=="ComboDeathfault", ]$ComboDeathfaultBuff <- 0
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$ComboDeathfaultBuffInstinct[i] > 0 & DealCycle$ComboInstinct[i] == 0) {
      DealCycle$ComboDeathfaultBuffInstinct[i] <- DealCycle$ComboDeathfaultBuffAfter[i]
      DealCycle$ComboDeathfaultBuffInstinct[i] <- 0
    }
  }
  
  ## Aura Weapon
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("RagingBlow", "Incising", "RageUprising", "ComboDeathfault", "SwordIllusionStart"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Valhalla
  VH <- subset(DealCycle, DealCycle$Skills=="Valhalla")
  Ind <- rownames(VH)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    t <- 0
    
    time <- 901
    while(p < Ind[i+1] & DealCycle$Valhalla[p] > 0 & t < 12) {
      if(time > 900 & max(DealCycle$Skills[p]==c("RagingBlow", "Incising", "RageUprising", "ComboDeathfault", "SwordIllusionStart"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ValhallaATK")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
        t <- t + 1
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  return(DealCycle)
}
      

HeroDealCycle <- HeroCycle(PreDealCycle=HeroDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=HeroSpec,
                                   Period=240, 
                                   CycleTime=720)
HeroDealCycle <- DealCycleFinal(HeroDealCycle)
HeroDealCycle <- HeroAddATK(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpec)
HeroDealCycleReduction <- DealCycleReduction(HeroDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Hero") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  HeroSpecOpt1 <- Optimization1(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpec, HeroUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- HeroSpecOpt1[1, 1:3]
} else {
  HeroSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
HeroSpecOpt <- OptDataAdd(HeroSpec, HeroSpecOpt1, "Potential", HeroBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  HeroSpecOpt2 <- Optimization2(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt, HeroHyperStatBase, HeroBase$ChrLv, HeroBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- HeroSpecOpt2[1, ]
} else {
  HeroSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
HeroSpecOpt <- OptDataAdd(HeroSpecOpt, HeroSpecOpt2, "HyperStat", HeroBase$CRROver, DemonAvenger=F)

HeroFinalDPM <- DealCalc(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt, Collapse=F)
HeroFinalDPMwithMax <- DealCalcWithMaxDMR(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Hero", sum(na.omit(HeroFinalDPMwithMax)) / (max(HeroDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Hero", sum(na.omit(HeroFinalDPM)) / (max(HeroDealCycle$Time) / 60000) - sum(na.omit(HeroFinalDPMwithMax)) / (max(HeroDealCycle$Time) / 60000))

HeroDealRatio <- DealRatio(HeroDealCycle, HeroFinalDPMwithMax)

HeroDealData <- data.frame(HeroDealCycle$Skills, HeroDealCycle$Time, HeroDealCycle$Restraint4, HeroFinalDPMwithMax)
colnames(HeroDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Hero", Deal_RR(HeroDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Hero", Deal_40s(HeroDealData, F, StartTime=subset(HeroDealData, HeroDealData$Skills=="SwordIllusionStart")$Time[1]))

HeroSpecMean <- SpecMean("Hero", HeroDealCycleReduction, 
                         DealCalcWithMaxDMR(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt), 
                         ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt)