## Shadower - Data
## Shadower - Core
ShadowerCoreBase <- CoreBuilder(ActSkills=c("ShadowAssault", "Eviscerate", "SonicBlow", "Myeolgwichamyeongjin",
                                            CommonV("Thief", "Adventure")), 
                                ActSkillsLv=c(25, 25, 25, 25, 1, 25, 25, 25, 25), 
                                UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                SpecSet=get(DPMCalcOption$SpecSet), 
                                VPassiveList=ShadowerVPassive, 
                                VPassivePrior=ShadowerVPrior, 
                                SelfBind=F)

ShadowerCore <- MatrixSet(PasSkills=ShadowerCoreBase$PasSkills$Skills, 
                          PasLvs=ShadowerCoreBase$PasSkills$Lv, 
                          PasMP=ShadowerCoreBase$PasSkills$MP, 
                          ActSkills=ShadowerCoreBase$ActSkills$Skills, 
                          ActLvs=ShadowerCoreBase$ActSkills$Lv, 
                          ActMP=ShadowerCoreBase$ActSkills$MP, 
                          UsefulSkills=ShadowerCoreBase$UsefulSkills, 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          SpecialCore=ShadowerCoreBase$SpecialCoreUse)


## Shadower - Basic Info
ShadowerBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=get(DPMCalcOption$MobSet),
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        Job="Shadower",
                        CoreData=ShadowerCore, 
                        BuffDurationNeeded=0, 
                        AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Shadower"), 
                        LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Shadower"), 
                        MonsterLife=get(FindJob(MonsterLifePreSet, "Shadower")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                        Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                        WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                        SubWeapon=SubWeapon[rownames(SubWeapon)=="DaggerSheath", ], 
                        Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                        CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Shadower")))


## Shadower - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(20)
NimbleBody <- data.frame(option, value)

option <- factor(c("CDMR", "CRR"), levels=PSkill)
value <- c(5, 25)
CriticalEdge <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
DaggerAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Karma <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(15)
ShieldMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(25)
Grid <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(25 + floor(ShadowerBase$SkillLv/3) * 2)
CruelStabPassive <- data.frame(option, value)

option <- factor(c("MainStat", "CDMR"), levels=PSkill)
value <- c(10, 20)
BloodyPocketPassive <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "IGR"), levels=PSkill)
value <- c(50 + 2 * ShadowerBase$PSkillLv, 15 + ceiling(ShadowerBase$PSkillLv/2), 20 + ShadowerBase$PSkillLv)
ShadowerInstinct <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(ShadowerBase$SkillLv/2), 40 + ShadowerBase$SkillLv, 15 + floor(ShadowerBase$SkillLv/3))
DaggerExpert <- data.frame(option, value)

option <- factor(c("BDR", "CRR"), levels=PSkill)
value <- c(25, 25)
FlipTheCoin <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ShadowerCore, "ReadyToDie"))
ReadyToDie <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ShadowerCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(ShadowerCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

ShadowerPassive <- Passive(list(NimbleBody, CriticalEdge, DaggerAcceleration, Karma, PhysicalTraining, ShieldMastery, Grid, CruelStabPassive, BloodyPocketPassive, ShadowerInstinct, DaggerExpert, FlipTheCoin, 
                                ReadyToDie, BlinkPassive, RopeConnectPassive))


## Shadower - Buff
## Haste : Not Used
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MesoStack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(15)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdvancedDarkSightDummy <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(50)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Assassination2KP <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(180, 1800, 810/0.49, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
StealBuff <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(200, 0, 900, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowPartner <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ShadowerBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ShadowerBase$SkillLv/2))))
info <- c(900 + 30 * ShadowerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(20 + 2 * ceiling(ShadowerBase$SkillLv/3))
info <- c(30, 150 - 2 * ShadowerBase$SkillLv, 810, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SmokeShell <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(12, 60, 900, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VeilofShadowBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(ShadowerCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(GetCoreLv(ShadowerCore, "ReadyToDie")/10))
info <- c(30, 90 - floor(GetCoreLv(ShadowerCore, "ReadyToDie")/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(ShadowerCore, "ReadyToDie")/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(GetCoreLv(ShadowerCore, "ReadyToDie")/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(((125 + floor(GetCoreLv(ShadowerCore, "UltimateDarkSight")/5)) / 115 - 1) * 100)
info <- c(30, 220 - GetCoreLv(ShadowerCore, "UltimateDarkSight"), 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateDarkSight <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(ShadowerCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * ShadowerBase$MainStatP), 5 + floor(GetCoreLv(ShadowerCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ShadowerBuff <- list(MesoStack=MesoStack, AdvancedDarkSightDummy=AdvancedDarkSightDummy, Assassination2KP=Assassination2KP, 
                     ShadowPartner=ShadowPartner, MapleSoldier=MapleSoldier, SmokeShell=SmokeShell, 
                     VeilofShadowBuff=VeilofShadowBuff, EpicAdventure=EpicAdventure, 
                     UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                     ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, UltimateDarkSight=UltimateDarkSight, MapleWarriors2=MapleWarriors2, 
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## Petbuff : NA -> Not Use Useful Advanced Bless
ShadowerBuff <- Buff(ShadowerBuff)
ShadowerAllTimeBuff <- AllTimeBuff(ShadowerBuff)
## Useful Skill Delay
ShadowerBuff <- data.frame(ShadowerBuff)
ShadowerBuff[rownames(ShadowerBuff)=="UsefulSharpEyes", ]$Delay <- 900
ShadowerBuff[rownames(ShadowerBuff)=="UsefulCombatOrders", ]$Delay <- 1500


## Shadower - Union & HyperStat & SoulWeapon
ShadowerSpec <- JobSpec(JobBase=ShadowerBase, 
                        Passive=ShadowerPassive, 
                        AllTimeBuff=ShadowerAllTimeBuff, 
                        MobInfo=get(DPMCalcOption$MobSet), 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        WeaponName="Dagger", 
                        UnionStance=0)

ShadowerUnionRemained <- ShadowerSpec$UnionRemained
ShadowerHyperStatBase <- ShadowerSpec$HyperStatBase
ShadowerCoolReduceType <- ShadowerSpec$CoolReduceType
ShadowerSpec <- ShadowerSpec$Spec


## Shadower - Spider In Mirror
SIM <- SIMData(GetCoreLv(ShadowerCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Shadower - Attacks
## Hyper : Meso Explosion - Reinforce / Enhance, Assassination - Reinforce / Boss Killer / Ignore Guard
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, IGRCalc(c(10, ifelse(GetCoreLv(ShadowerCore, "Assassination")>=40, 20, 0))), 2 * GetCoreLv(ShadowerCore, "Assassination"))
info <- c(270 + 3 * ShadowerSpec$SkillLv, 6, 690, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Assassination1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(ShadowerCore, "Assassination")>=40, 20, 0), 2 * GetCoreLv(ShadowerCore, "Assassination"))
info <- c(490 + 5 * ShadowerSpec$SkillLv, 6, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Assassination2 <- rbind(data.frame(option, value), info) ## Delay Skipped By Jeolgae : 480ms

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(50, IGRCalc(c(10, ifelse(GetCoreLv(ShadowerCore, "MesoExplosion")>=40, 20, 0))), 3 * GetCoreLv(ShadowerCore, "MesoExplosion"))
info <- c(120, 2 * 0.4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MesoExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ShadowerCore, "VeilofShadow")>=40, 20, 0), 2 * GetCoreLv(ShadowerCore, "VeilofShadow"))
info <- c(800, 1, 0, 900, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VeilofShadow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(720 + 20 * GetCoreLv(ShadowerCore, "ShadowAssault"), 6, 570 * 4, 570, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowAssault <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(675 + 27 * GetCoreLv(ShadowerCore, "Eviscerate"), 7, 570, 60, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Eviscerate <- rbind(data.frame(option, value), info) ## StartATK : 150ms

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(500 + 20 * GetCoreLv(ShadowerCore, "SonicBlow"), 7, 2550, 120, 45, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SonicBlow <- rbind(data.frame(option, value), info) ## StartATK : 780ms

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 390, 0, 80, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SonicBlowEnd <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(425 + 17 * GetCoreLv(ShadowerCore, "Myeolgwichamyeongjin"), 8, 0, 0, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Myeolgwichamyeongjin <- rbind(data.frame(option, value), info) ## 150ms, 900ms, 1680ms, 2460ms, 3120ms, 3600ms, 3960ms, 4200ms, 4440ms, 4620ms, 4800ms, 4920ms (11 Times)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(625 + 25 * GetCoreLv(ShadowerCore, "Myeolgwichamyeongjin"), 15, 0, 90, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MyeolgwichamyeongjinLast <- rbind(data.frame(option, value), info) ## StartATK : 5370 + 900

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 120, 0, 0, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkSight <- rbind(data.frame(option, value), info)}

ShadowerATK <- Attack(list(Assassination1=Assassination1, Assassination2=Assassination2, MesoExplosion=MesoExplosion, VeilofShadow=VeilofShadow, 
                           ShadowAssault=ShadowAssault, Eviscerate=Eviscerate, SonicBlow=SonicBlow, SonicBlowEnd=SonicBlowEnd, 
                           Myeolgwichamyeongjin=Myeolgwichamyeongjin, MyeolgwichamyeongjinLast=MyeolgwichamyeongjinLast, DarkSight=DarkSight, 
                           SpiderInMirror=SpiderInMirror))


## Shadower - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(ShadowerCore, "DarkFlare")>=40, 20, 0), GetCoreLv(ShadowerCore, "DarkFlare") * 3)
info <- c(360, 1, 600, 900, 60, 60, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DarkFlare <- rbind(data.frame(option, value), info)}

ShadowerSummoned <- Summoned(list(DarkFlare=DarkFlare, 
                                  SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Shadower - DealCycle
ATKFinal <- data.frame(ShadowerATK)
ATKFinal$Delay[c(-5, -6, -7, -8, -11)] <- Delay(ATKFinal$Delay, ShadowerSpec$ATKSpeed)[c(-5, -6, -7, -8, -11)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ShadowerSpec$CoolReduceP, ShadowerSpec$CoolReduce)

BuffFinal <- data.frame(ShadowerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ShadowerSpec$CoolReduceP, ShadowerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ShadowerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ShadowerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ShadowerSpec$CoolReduceP, ShadowerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ShadowerSpec$SummonedDuration / 100, 0)


## Shadower - Delay Skip Structure
ShadowerSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
ShadowerSkipATK <- data.frame(ShadowerSkipATK, row.names=c(rownames(ATKFinal)))
colnames(ShadowerSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

ShadowerSkipATK$MesoExplosion <- c(F, T, rep(F, 10))
ShadowerSkipATK$Eviscerate <- c(F, T, rep(F, 10))

ShadowerSkipATK$SkippedDelay <- c(NA, Delay(360, ShadowerSpec$ATKSpeed), rep(NA, 10))
ShadowerSkipATK <- subset(ShadowerSkipATK, ShadowerSkipATK$SkippedDelay>0)


## Shadow Partner
ATKFinal <- AddATKRateSkills("ShadowPartner", BuffFinal, ATKFinal, c("Assassination1", "Assassination2", "VeilofShadow", "ShadowAssault", "Eviscerate", "SonicBlow"))


DealCycle <- c("Skills", "Time", rownames(ShadowerBuff))
ShadowerDealCycle <- t(rep(0, length(DealCycle)))
colnames(ShadowerDealCycle) <- DealCycle
ShadowerDealCycle <- data.frame(ShadowerDealCycle)

ShadowerCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure, 
                         Period=c(180.5), CycleTime=c(361), AddDelay=30) {
  BuffSummonedPrior <- c("ShadowPartner", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure", "DarkFlare",
                         "MapleWarriors2", "SoulContractLink", "UltimateDarkSight", "ReadyToDie2Stack")
  
  Times180 <- c(1, 1, 1, 1, 0, 3, 
                1, 2, 1, 2)
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
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="EpicAdventure") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DCATKSkip(DealCycle, "Assassination1", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "Assassination2", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
        
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
  VSCool <- subset(ATKFinal, rownames(ATKFinal)=="VeilofShadow")$CoolTime * 1000
  EVCool <- subset(ATKFinal, rownames(ATKFinal)=="Eviscerate")$CoolTime * 1000
  SBCool <- subset(ATKFinal, rownames(ATKFinal)=="SonicBlow")$CoolTime * 1000
  SSCool <- subset(BuffFinal, rownames(BuffFinal)=="SmokeShell")$CoolTime * 1000
  MYCool <- subset(ATKFinal, rownames(ATKFinal)=="Myeolgwichamyeongjin")$CoolTime * 1000
  
  VSRemain <- 0 ; EVRemain <- 0 ; SBRemain <- 0 ; SSRemain <- 0 ; MYRemain <- 0
  WoundStack <- 3
  EVDummy <- 0
  
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
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          EVRemain <- max(0, EVRemain - DealCycle$Time[1])
          SBRemain <- max(0, SBRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        }
      }
      ## Restraint 4
      if(nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) < nrow(subset(DealCycle, DealCycle$Skills=="UltimateDarkSight")) & SBRemain == 0) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
      }
      ## Eviscerate
      else if(EVRemain <= 540 + 270 & WoundStack >= 2) {
        if(nrow(subset(DealCycle, DealCycle$Skills=="Myeolgwichamyeongjin")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) & MYRemain == 0) {
          DealCycle <- DCATKSkip(DealCycle, "Myeolgwichamyeongjin", ATKFinal, SkipStructure)
          DealCycle <- DCATKSkip(DealCycle, "MyeolgwichamyeongjinLast", ATKFinal, SkipStructure)
          MYRemain <- MYCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "Assassination1", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        
        DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        
        DealCycle <- DCATKSkip(DealCycle, "Assassination2", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        EVRemain <- max(0, EVRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        SBRemain <- max(0, SBRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        SSRemain <- max(0, SSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        MYRemain <- max(0, MYRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        
        DealCycle <- DCATKSkip(DealCycle, "Eviscerate", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVCool - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        WoundStack <- 0
        EVDummy <- 1
      }
      ## Sonic Blow
      else if(SBRemain == 0 & sum(nrow(subset(DealCycle, DealCycle$Skills=="SonicBlow")) == c(0, 4)) >= 1 & DealCycle$Restraint4[nrow(DealCycle)] > 0 | 
              SBRemain == 0 & sum(nrow(subset(DealCycle, DealCycle$Skills=="SonicBlow")) == c(1, 5)) >= 1 & DealCycle$SmokeShell[nrow(DealCycle)] > 0 | 
              SBRemain == 0 & sum(nrow(subset(DealCycle, DealCycle$Skills=="SonicBlow")) == c(0, 1, 4, 5)) == 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="SonicBlow")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) * 2) {
        DealCycle <- DCATKSkip(DealCycle, "SonicBlow", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBCool - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        
        DealCycle <- DCATKSkip(DealCycle, "SonicBlowEnd", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
      }
      ## Veil of Shadow
      else if(VSRemain == 0 & DealCycle$UltimateDarkSight[nrow(DealCycle)] - DealCycle$Time[1] <= 2000) {
        if(DealCycle$UltimateDarkSight[nrow(DealCycle)] - DealCycle$Time[1] <= 0 | DealCycle$SmokeShell[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
          DealCycle <- DCATKSkip(DealCycle, "DarkSight", ATKFinal, SkipStructure)
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          EVRemain <- max(0, EVRemain - DealCycle$Time[1])
          SBRemain <- max(0, SBRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        }
        DealCycle <- DCBuff(DealCycle, "VeilofShadowBuff", BuffFinal)
        VSRemain <- max(0, VSCool - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
      } 
      ## SmokeShell
      else if(SSRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="SmokeShell")) < nrow(subset(DealCycle, DealCycle$Skills=="UltimateDarkSight")) & 
              DealCycle$UltimateDarkSight[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$VeilofShadowBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCBuff(DealCycle, "SmokeShell", BuffFinal)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSCool - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        
        DealCycle <- DCATKSkip(DealCycle, "DarkSight", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
      }
      ## Assassination
      else {
        if(nrow(subset(DealCycle, DealCycle$Skills=="Myeolgwichamyeongjin")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) & MYRemain == 0) {
          DealCycle <- DCATKSkip(DealCycle, "Myeolgwichamyeongjin", ATKFinal, SkipStructure)
          DealCycle <- DCATKSkip(DealCycle, "MyeolgwichamyeongjinLast", ATKFinal, SkipStructure)
          MYRemain <- MYCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "Assassination1", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        
        if(EVDummy == 1) {
          DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          EVRemain <- max(0, EVRemain - DealCycle$Time[1])
          SBRemain <- max(0, SBRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          MYRemain <- max(0, MYRemain - DealCycle$Time[1])
          EVDummy <- 0
        }
        
        DealCycle <- DCATKSkip(DealCycle, "Assassination2", ATKFinal, SkipStructure)
        VSRemain <- max(0, VSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        EVRemain <- max(0, EVRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        SBRemain <- max(0, SBRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        SSRemain <- max(0, SSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        MYRemain <- max(0, MYRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
        WoundStack <- min(3, WoundStack + 1)
        
        DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
        DealCycle[1, 2:ncol(DealCycle)] <- AddDelay
        VSRemain <- max(0, VSRemain - DealCycle$Time[1])
        EVRemain <- max(0, EVRemain - DealCycle$Time[1])
        SBRemain <- max(0, SBRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        MYRemain <- max(0, MYRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          EVRemain <- max(0, EVRemain - DealCycle$Time[1])
          SBRemain <- max(0, SBRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          MYRemain <- max(0, MYRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="UsefulCombatOrders") {
            DealCycle <- DCATKSkip(DealCycle, "Assassination1", ATKFinal, SkipStructure)
            VSRemain <- max(0, VSRemain - DealCycle$Time[1])
            EVRemain <- max(0, EVRemain - DealCycle$Time[1])
            SBRemain <- max(0, SBRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            MYRemain <- max(0, MYRemain - DealCycle$Time[1])
    
            DealCycle <- DCATKSkip(DealCycle, "Assassination2", ATKFinal, SkipStructure)
            VSRemain <- max(0, VSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
            EVRemain <- max(0, EVRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
            SBRemain <- max(0, SBRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
            SSRemain <- max(0, SSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
            MYRemain <- max(0, MYRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
            WoundStack <- min(3, WoundStack + 1)
            
            DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
            VSRemain <- max(0, VSRemain - DealCycle$Time[1])
            EVRemain <- max(0, EVRemain - DealCycle$Time[1])
            SBRemain <- max(0, SBRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            MYRemain <- max(0, MYRemain - DealCycle$Time[1])
            DealCycle[1, 2:ncol(DealCycle)] <- AddDelay
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          VSRemain <- max(0, VSRemain - DealCycle$Time[1])
          EVRemain <- max(0, EVRemain - DealCycle$Time[1])
          SBRemain <- max(0, SBRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          MYRemain <- max(0, MYRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="VeilofShadowBuff")$Time) + min(subset(DealCycle, DealCycle$Skills=="VeilofShadowBuff")$Time) < VSCool | 
        WoundStack < 1) {
    DealCycle <- DCATKSkip(DealCycle, "Assassination1", ATKFinal, SkipStructure)
    VSRemain <- max(0, VSRemain - DealCycle$Time[1])
    EVRemain <- max(0, EVRemain - DealCycle$Time[1])
    SBRemain <- max(0, SBRemain - DealCycle$Time[1])
    SSRemain <- max(0, SSRemain - DealCycle$Time[1])
    MYRemain <- max(0, MYRemain - DealCycle$Time[1])
    
    DealCycle <- DCATKSkip(DealCycle, "Assassination2", ATKFinal, SkipStructure)
    VSRemain <- max(0, VSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
    EVRemain <- max(0, EVRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
    SBRemain <- max(0, SBRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
    SSRemain <- max(0, SSRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
    MYRemain <- max(0, MYRemain - DealCycle$Time[1] + ATKFinal[rownames(ATKFinal)=="Assassination2", ]$Delay - ShadowerSkipATK[rownames(ShadowerSkipATK)=="Assassination2", ]$SkippedDelay)
    WoundStack <- min(3, WoundStack + 1)
    
    DealCycle <- DCATKSkip(DealCycle, "MesoExplosion", ATKFinal, SkipStructure)
    VSRemain <- max(0, VSRemain - DealCycle$Time[1])
    EVRemain <- max(0, EVRemain - DealCycle$Time[1])
    SBRemain <- max(0, SBRemain - DealCycle$Time[1])
    SSRemain <- max(0, SSRemain - DealCycle$Time[1])
    MYRemain <- max(0, MYRemain - DealCycle$Time[1])
    DealCycle[1, 2:ncol(DealCycle)] <- AddDelay
  }
  
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
ShadowerAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Sonic Blow
  DealCycle <- RepATKCycle(DealCycle, "SonicBlow", 15, 780, ATKFinal)
  
  
  ## Eviscerate
  DealCycle <- RepATKCycle(DealCycle, "Eviscerate", 4, 60, ATKFinal)
  
  
  ## Veil of Shadow
  DealCycle[DealCycle$Skills=="VeilofShadowBuff", ]$Skills <- "VeilofShadow"
  DealCycle <- RepATKCycle(DealCycle, "VeilofShadow", 14, 1200, ATKFinal)
  
  
  ## Myeolgwichamyeongjin
  DealCycle[DealCycle$Skills=="Myeolgwichamyeongjin", ]$Skills <- "MyeolgwichamyeongjinStart"
  MYTime <- c(150, 900, 1680, 2460, 3120, 3600, 3960, 4200, 4440, 4620, 4800, 4920)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MyeolgwichamyeongjinStart") {
      for(j in 1:length(MYTime)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "Myeolgwichamyeongjin"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + MYTime[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Myeolgwichamyeongjin") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  DealCycle <- RepATKCycle(DealCycle, "MyeolgwichamyeongjinLast", 4, 5370 + 900, ATKFinal)
  
  
  ## Dark Flare
  DealCycle <- DCSummonedATKs(DealCycle, "DarkFlare", SummonedFinal)
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Meso Explosion
  Skills <- c("Assassination1", "Assassination2", "VeilofShadow", "ShadowAssault", "Eviscerate", "SonicBlow")
  Stack <- c(12, 12, 2, 12, 14, 14)
  Meso <- data.frame(Skills=Skills, Stack=Stack, StringsAsFactors=F)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i-1]=="MesoExplosion") {
      DealCycle$MesoStack[i] <- 0
    } else {
      DealCycle$MesoStack[i] <- DealCycle$MesoStack[i-1]
    }
    if(sum(DealCycle$Skills[i]==Meso$Skills) >= 1) {
      DealCycle$MesoStack[i] <- min(20 / 0.4, DealCycle$MesoStack[i] + subset(Meso, Meso$Skills==DealCycle$Skills[i])$Stack)
    }
  }
  DealCycle[DealCycle$Skills=="MesoExplosion", ]$Skills <- "MesoExplosionDummy"
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MesoExplosionDummy") {
      for(j in 1:DealCycle$MesoStack[i]) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "MesoExplosion"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Assasination 2 Killing Point (Saleui Buff)
  for(i in 1:nrow(DealCycle)) {
    DealCycle$AdvancedDarkSightDummy[i] <- max(DealCycle$UltimateDarkSight[i], DealCycle$SmokeShell[i], DealCycle$VeilofShadowBuff[i])
    if(DealCycle$Skills[i]=="Assassination2") {
      DealCycle$Assassination2KP[i] <- 1
    }
  }
  
  ## Shadow Partner
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Assassination1", "Assassination2", "VeilofShadow", "ShadowAssault", "Eviscerate", "SonicBlow")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "Add", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Dummy Reduction
  DealCycle <- DealCycle[DealCycle$Skills!="MesoExplosionDummy", ]
  DealCycle$MesoStack <- 0
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  return(DealCycle)
}
        
ShadowerDealCycle <- ShadowerCycle(ShadowerDealCycle, 
                                   ATKFinal, 
                                   BuffFinal, 
                                   SummonedFinal, 
                                   ShadowerSpec, 
                                   ShadowerSkipATK, 
                                   Period=180.5, CycleTime=361, AddDelay=30)
ShadowerDealCycle <- DealCycleFinal(ShadowerDealCycle)
ShadowerDealCycle <- ShadowerAddATK(ShadowerDealCycle, 
                                    ATKFinal, 
                                    BuffFinal, 
                                    SummonedFinal, 
                                    ShadowerSpec)
ShadowerDealCycleReduction <- DealCycleReduction(ShadowerDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Shadower") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  ShadowerSpecOpt1 <- Optimization1(ShadowerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpec, ShadowerUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- ShadowerSpecOpt1[1, 1:3]
} else {
  ShadowerSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ShadowerSpecOpt <- OptDataAdd(ShadowerSpec, ShadowerSpecOpt1, "Potential", ShadowerBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ShadowerSpecOpt2 <- Optimization2(ShadowerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt, ShadowerHyperStatBase, ShadowerBase$ChrLv, ShadowerBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ShadowerSpecOpt2[1, ]
} else {
  ShadowerSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ShadowerSpecOpt <- OptDataAdd(ShadowerSpecOpt, ShadowerSpecOpt2, "HyperStat", ShadowerBase$CRROver, DemonAvenger=F)

ShadowerFinalDPM <- DealCalc(ShadowerDealCycle, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt, Collapse=F)
ShadowerFinalDPMwithMax <- DealCalcWithMaxDMR(ShadowerDealCycle, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Shadower", sum(na.omit(ShadowerFinalDPMwithMax)) / (max(ShadowerDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Shadower", sum(na.omit(ShadowerFinalDPM)) / (max(ShadowerDealCycle$Time) / 60000) - sum(na.omit(ShadowerFinalDPMwithMax)) / (max(ShadowerDealCycle$Time) / 60000))

ShadowerDealRatio <- DealRatio(ShadowerDealCycle, ShadowerFinalDPMwithMax)

ShadowerDealData <- data.frame(ShadowerDealCycle$Skills, ShadowerDealCycle$Time, ShadowerDealCycle$Restraint4, ShadowerFinalDPMwithMax)
colnames(ShadowerDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Shadower", Deal_RR(ShadowerDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Shadower", Deal_40s(ShadowerDealData))

ShadowerSpecMean <- SpecMean("Shadower", ShadowerDealCycleReduction, 
                             DealCalcWithMaxDMR(ShadowerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt), 
                             ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt)


## Shadower - Add Delay 60ms
DealCycle <- c("Skills", "Time", rownames(ShadowerBuff))
ShadowerDealCycle60 <- t(rep(0, length(DealCycle)))
colnames(ShadowerDealCycle60) <- DealCycle
ShadowerDealCycle60 <- data.frame(ShadowerDealCycle60)

ShadowerDealCycle60 <- ShadowerCycle(ShadowerDealCycle60, 
                                     ATKFinal, 
                                     BuffFinal, 
                                     SummonedFinal, 
                                     ShadowerSpec, 
                                     ShadowerSkipATK, 
                                     Period=180.5, CycleTime=361, AddDelay=60)
ShadowerDealCycle60 <- DealCycleFinal(ShadowerDealCycle60)
ShadowerDealCycle60 <- ShadowerAddATK(ShadowerDealCycle60, 
                                      ATKFinal, 
                                      BuffFinal, 
                                      SummonedFinal, 
                                      ShadowerSpec)

ShadowerFinalDPM60 <- DealCalcWithMaxDMR(ShadowerDealCycle60, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt)
Shadower60DPM <- sum(na.omit(ShadowerFinalDPM60)) / (max(ShadowerDealCycle60$Time)/ 60000)

ShadowerDealData60 <- data.frame(ShadowerDealCycle60$Skills, ShadowerDealCycle60$Time, ShadowerDealCycle60$Restraint4, ShadowerFinalDPM60)
colnames(ShadowerDealData60) <- c("Skills", "Time", "R4", "Deal")

Shadower60RR <- Deal_RR(ShadowerDealData60)
Shadower6040s <- Deal_40s(ShadowerDealData60)


## Shadower - Add Delay 90ms
DealCycle <- c("Skills", "Time", rownames(ShadowerBuff))
ShadowerDealCycle90 <- t(rep(0, length(DealCycle)))
colnames(ShadowerDealCycle90) <- DealCycle
ShadowerDealCycle90 <- data.frame(ShadowerDealCycle90)

ShadowerDealCycle90 <- ShadowerCycle(ShadowerDealCycle90, 
                                     ATKFinal, 
                                     BuffFinal, 
                                     SummonedFinal, 
                                     ShadowerSpec, 
                                     ShadowerSkipATK, 
                                     Period=180.5, CycleTime=361, AddDelay=90)
ShadowerDealCycle90 <- DealCycleFinal(ShadowerDealCycle90)
ShadowerDealCycle90 <- ShadowerAddATK(ShadowerDealCycle90, 
                                      ATKFinal, 
                                      BuffFinal, 
                                      SummonedFinal, 
                                      ShadowerSpec)

ShadowerFinalDPM90 <- DealCalcWithMaxDMR(ShadowerDealCycle90, ATKFinal, BuffFinal, SummonedFinal, ShadowerSpecOpt)
Shadower90DPM <- sum(na.omit(ShadowerFinalDPM90)) / (max(ShadowerDealCycle90$Time)/ 60000)

ShadowerDealData90 <- data.frame(ShadowerDealCycle90$Skills, ShadowerDealCycle90$Time, ShadowerDealCycle90$Restraint4, ShadowerFinalDPM90)
colnames(ShadowerDealData90) <- c("Skills", "Time", "R4", "Deal")

Shadower90RR <- Deal_RR(ShadowerDealData90)
Shadower9040s <- Deal_40s(ShadowerDealData90)

print(list(Shadower60ms=data.frame(Shadower60DPM=Shadower60DPM, Shadower60RR=Shadower60RR, Shadower6040s=Shadower6040s), 
           Shadower90ms=data.frame(Shadower90DPM=Shadower90DPM, Shadower90RR=Shadower90RR, Shadower9040s=Shadower9040s)))