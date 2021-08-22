## DarkKnight - Data
## DarkKnight - VMatrix
DarkKnightCoreBase <- CoreBuilder(ActSkills=c("DarkSpear", "BeholderImpact", "PierceCyclone", "DarknessAura", 
                                              CommonV("Warrior", "Adventure")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                                  UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=DarkKnightVPassive, 
                                  VPassivePrior=DarkKnightVPrior, 
                                  SelfBind=F)

DarkKnightCore <- MatrixSet(PasSkills=DarkKnightCoreBase$PasSkills$Skills, 
                            PasLvs=DarkKnightCoreBase$PasSkills$Lv, 
                            PasMP=DarkKnightCoreBase$PasSkills$MP, 
                            ActSkills=DarkKnightCoreBase$ActSkills$Skills, 
                            ActLvs=DarkKnightCoreBase$ActSkills$Lv, 
                            ActMP=DarkKnightCoreBase$ActSkills$MP, 
                            UsefulSkills=DarkKnightCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=DarkKnightCoreBase$SpecialCoreUse)


## DarkKnight - Basic Info
DarkKnightBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="DarkKnight",
                          CoreData=DarkKnightCore, 
                          BuffDurationNeeded=85, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "DarkKnight"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "DarkKnight"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "DarkKnight")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Spear", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="DarkKnightChain", ], 
                          Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "DarkKnight")))


## DarkKnight - Passive
## Hyper : Beholder - Reinforce, Beholder - Buff Reinforce, Gugnir Descent - Reinforce, Reincarnation - Damage, Reincarnation - Critical Rate
{option <- factor(c("ATKSpeed", "BDR"), levels=PSkill)
value <- c(1, 5)
WeaponMastery <- data.frame(option, value) ## Spear Only

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(50)
CrossOverChainPassive <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 8)
LordofDarkness <- data.frame(option, value)

option <- factor(c("ATK", "CRR"), levels=PSkill)
value <- c(70, 10)
BeholdersBuff <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30 + DarkKnightBase$SkillLv)
SacrificePassive <- data.frame(option, value)

option <- factor(c("FDR", "CRR", "CDMR"), levels=PSkill)
value <- c(30 + DarkKnightBase$SkillLv, 30 + ceiling(DarkKnightBase$SkillLv/3), 15)
ReincarnationPassive <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CMDR"), levels=PSkill)
value <- c(70 + ceiling(DarkKnightBase$SkillLv/2), 30 + DarkKnightBase$SkillLv, 15)
AdvancedWeaponMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(DarkKnightCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(DarkKnightCore, "Blink"))
BlinkPassive <- data.frame(option, value)}

DarkKnightPassive <- Passive(list(WeaponMastery=WeaponMastery, PhysicalTraining=PhysicalTraining, CrossOverChainPassive=CrossOverChainPassive, LordofDarkness=LordofDarkness, BeholdersBuff=BeholdersBuff, 
                                  SacrificePassive=SacrificePassive, ReincarnationPassive=ReincarnationPassive, AdvancedWeaponMastery=AdvancedWeaponMastery, 
                                  BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive))


## DarkKnight - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IronWall <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HyperBody <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrossOverChain <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((DarkKnightBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(DarkKnightBase$SkillLv/2))))
info <- c(900 + 30 * DarkKnightBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR"), levels=BSkill)
value <- c(10 + ceiling(DarkKnightBase$SkillLv/3), 10 + ceiling(DarkKnightBase$SkillLv/3))
info <- c(30 * (100 + DarkKnightBase$BuffDurationNeeded) / 100 + General$General$Serverlag, Cooldown(70, T, DarkKnightBase$UnionChrs$CoolReduceP, DarkKnightBase$CoolReduce) - 7.7, 1080, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Sacrifice <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(70, T, DarkKnightBase$UnionChrs$CoolReduceP, DarkKnightBase$CoolReduce), 70, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SacrificeCooldown <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(((1.6 + 0.01 * DarkKnightBase$SkillLv) / (1.3 + 0.01 * DarkKnightBase$SkillLv) - 1) * 100)
info <- c(40 + DarkKnightBase$SkillLv, Cooldown(900, T, DarkKnightBase$UnionChrs$CoolReduceP, DarkKnightBase$CoolReduce) - 300, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Reincarnation <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(80)
info <- c(30, 120, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkThirst <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(DarkKnightCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 180, 600, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarknessAuraBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(DarkKnightCore, "AuraWeapon")/5), ceiling(GetCoreLv(DarkKnightCore, "AuraWeapon")/5))
info <- c(80 + 2 * GetCoreLv(DarkKnightCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(DarkKnightCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * DarkKnightBase$MainStatP), 5 + floor(GetCoreLv(DarkKnightCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

DarkKnightBuff <- list(WeaponBooster=WeaponBooster, IronWall=IronWall, HyperBody=HyperBody, CrossOverChain=CrossOverChain, MapleSoldier=MapleSoldier,
                       Sacrifice=Sacrifice, SacrificeCooldown=SacrificeCooldown, Reincarnation=Reincarnation, EpicAdventure=EpicAdventure, DarkThirst=DarkThirst, 
                       UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, DarknessAuraBuff=DarknessAuraBuff, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, 
                       Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  DarkKnightBuff[[length(DarkKnightBuff)+1]] <- UsefulAdvancedBless
  names(DarkKnightBuff)[[length(DarkKnightBuff)]] <- "UsefulAdvancedBless"
}
DarkKnightBuff <- Buff(DarkKnightBuff)
DarkKnightAllTimeBuff <- AllTimeBuff(DarkKnightBuff)
## PetBuff : WeaponBooster(990ms), HyperBody(600ms), CrossOverChain(720ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)


## DarkKnight - Union & HyperStat & SoulWeapon
DarkKnightSpec <- JobSpec(JobBase=DarkKnightBase, 
                          Passive=DarkKnightPassive, 
                          AllTimeBuff=DarkKnightAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="Spear", 
                          UnionStance=0)

DarkKnightUnionRemained <- DarkKnightSpec$UnionRemained
DarkKnightHyperStatBase <- DarkKnightSpec$HyperStatBase
DarkKnightCoolReduceType <- DarkKnightSpec$CoolReduceType
DarkKnightSpec <- DarkKnightSpec$Spec


## DarkKnight - Spider In Mirror
SIM <- SIMData(GetCoreLv(DarkKnightCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## DarkKnight - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(30 + DarkKnightSpec$SkillLv, ifelse(GetCoreLv(DarkKnightCore, "GungnirDescent")>=40, 20, 0))), 20, 2 * GetCoreLv(DarkKnightCore, "GungnirDescent"))
info <- c(225 + DarkKnightSpec$SkillLv, 12, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GungnirDescent <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(DarkKnightCore, "Beholder")>=40, 20, 0), 150, 3 * GetCoreLv(DarkKnightCore, "Beholder"))
info <- c(515 + 5 * DarkKnightSpec$SkillLv, 6, 0, NA, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BeholderShock <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(DarkKnightCore, "FinalAttack")>=40, 20, 0), DarkKnightBase$MonsterLife$FinalATKDMR, 4 * GetCoreLv(DarkKnightCore, "FinalAttack"))
info <- c(80, 0.8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(325 + 13 * GetCoreLv(DarkKnightCore, "DarkSpear"), 7, 990, 90, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkSpear <- rbind(data.frame(option, value), info) ## 10 Hits

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(DarkKnightCore, "Beholder")>=40, 20, 0))), 150, 3 * GetCoreLv(DarkKnightCore, "Beholder"))
info <- c(100 + GetCoreLv(DarkKnightCore, "BeholderImpact"), 6, 0, 240, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BeholderImpact <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 90, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PierceCyclonePre <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(400 + 16 * GetCoreLv(DarkKnightCore, "PierceCyclone"), 12, 360, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PierceCycloneTick <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(400 + 16 * GetCoreLv(DarkKnightCore, "PierceCyclone"), 12, 270, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PierceCycloneRemain <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(300 + 12 * GetCoreLv(DarkKnightCore, "PierceCyclone"), 15, 1200, 30, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PierceCycloneEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(DarkKnightCore, "DarknessAura"), 5, 0, 1500, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarknessAura <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(675 + 26 * GetCoreLv(DarkKnightCore, "DarknessAura"), 13, 0, 30, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarknessAuraEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(DarkKnightCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

DarkKnightATK <- Attack(list(GungnirDescent=GungnirDescent, BeholderShock=BeholderShock, FinalAttack=FinalAttack, DarkSpear=DarkSpear, BeholderImpact=BeholderImpact, 
                             PierceCyclonePre=PierceCyclonePre, PierceCycloneTick=PierceCycloneTick, PierceCycloneRemain=PierceCycloneRemain, PierceCycloneEnd=PierceCycloneEnd, 
                             DarknessAura=DarknessAura, DarknessAuraEnd=DarknessAuraEnd, AuraWeapon=AuraWeapon, SpiderInMirror=SpiderInMirror))


## DarkKnight - Summoned
{option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(DarkKnightCore, "Beholder")>=40, 20, 0), 150, 3 * GetCoreLv(DarkKnightCore, "Beholder"))
info <- c(210, 1, 0, 3030, 2000, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BeholderDominant <- rbind(data.frame(option, value), info)}

DarkKnightSummoned <- Summoned(list(BeholderDominant=BeholderDominant, SpiderInMirrorStart=SpiderInMirrorStart, 
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## DarkKnight - DealCycle & Deal Calculation
ATKFinal <- data.frame(DarkKnightATK)
ATKFinal$Delay[c(-6, -7, -8, -9)] <- Delay(ATKFinal$Delay, DarkKnightSpec$ATKSpeed)[c(-6, -7, -8, -9)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, DarkKnightSpec$CoolReduceP, DarkKnightSpec$CoolReduce)

BuffFinal <- data.frame(DarkKnightBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, DarkKnightSpec$CoolReduceP, DarkKnightSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, DarkKnightSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(DarkKnightSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, DarkKnightSpec$CoolReduceP, DarkKnightSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * DarkKnightSpec$SummonedDuration / 100, 0)


## DarkKnight DealCycle
DealCycle <- c("Skills", "Time", rownames(DarkKnightBuff))
DarkKnightDealCycle <- t(rep(0, length(DealCycle)))
colnames(DarkKnightDealCycle) <- DealCycle

DarkKnightCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(720), Reincarnation=T) {
  BuffSummonedPrior <- c("WeaponBooster", "IronWall", "HyperBody", "CrossOverChain", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "EpicAdventure", 
                         "Sacrifice", "AuraWeaponBuff", "MapleWarriors2", "DarknessAuraBuff")
  if(Reincarnation==T) {
    BuffSummonedPrior <- c(BuffSummonedPrior, "Reincarnation")
  }
  
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 
                3, 1, 1, 1)
  if(Reincarnation==T) {
    Times180 <- c(Times180, 0.25)
  }
  
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- SubTime[1] * 4
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
  DealCycle <- DCSummoned(DealCycle, "BeholderDominant", SummonedFinal)
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="DarknessAuraBuff") {
        DealCycle <- DCATK(DealCycle, "DarknessAura", ATKFinal)
      } else if(BuffList[[1]][i]=="Sacrifice") {
        DealCycle <- DCBuff(DealCycle, "SacrificeCooldown", BuffFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="MapleSoldier") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
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
  
  BSCool <- subset(ATKFinal, rownames(ATKFinal)=="BeholderShock")$CoolTime * 1000
  DSCool <- subset(ATKFinal, rownames(ATKFinal)=="DarkSpear")$CoolTime * 1000
  BSRemain <- 0 ; DSRemain <- 0
  ImpactDummy <- 0 ; SCDummy <- 0
  
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
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        }
      }
      ## Dark Thirst, Soul Contract, Restraint
      if(DealCycle$DarknessAuraBuff[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$DarknessAuraBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 10000 & 
         DealCycle$Restraint4[nrow(DealCycle)] == 0) {
        DealCycle <- DCBuff(DealCycle, "DarkThirst", BuffFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        SCDummy <- 1
      } else if(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) >= 1 & 
                DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - ifelse(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) >= 1, 
                                                                             max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time), 0) >=
                subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000 & SCDummy == 1) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        SCDummy <- 0
      }
      ## Dark Spear and Beholder Impact
      else if(DSRemain==0 & ImpactDummy==0) {
        DealCycle <- DCATK(DealCycle, "DarkSpear", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- DSCool - DealCycle$Time[1]
        DealCycle <- DCATK(DealCycle, "BeholderImpact", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        ImpactDummy <- 1
      } else if(DSRemain==0 & ImpactDummy==1) {
        DealCycle <- DCATK(DealCycle, "DarkSpear", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- DSCool - DealCycle$Time[1]
        ImpactDummy <- 0
      }
      ## Pierce Cyclone and Darkness Aura
      else if(DealCycle$Restraint4[nrow(DealCycle)] >= 10000) {
        DealCycle <- DCATK(DealCycle, "PierceCyclonePre", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        for(i in 1:24) {
          if(DealCycle$DarknessAuraBuff[nrow(DealCycle)] > 0 & DealCycle$DarknessAuraBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
            DealCycle <- DCATK(DealCycle, "DarknessAuraEnd", ATKFinal)
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
            DealCycle$DarknessAuraBuff[nrow(DealCycle)] <- 0
          }
          DealCycle <- DCATK(DealCycle, "PierceCycloneTick", ATKFinal)
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        }
        DealCycle <- DCATK(DealCycle, "PierceCycloneRemain", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "PierceCycloneEnd", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
      } 
      ## Beholder Shock
      else if(BSRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="BeholderImpact")$Time) >= 3660) {
        DealCycle <- DCATK(DealCycle, "BeholderShock", ATKFinal)
        BSRemain <- BSCool - DealCycle$Time[1]
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
      }
      ## Gungnir Descent
      else {
        DealCycle <- DCATK(DealCycle, "GungnirDescent", ATKFinal)
        BSRemain <- max(0, BSRemain - DealCycle$Time[1])
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
      }
    }
      
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="DarknessAuraBuff") {
            DealCycle <- DCATK(DealCycle, "DarknessAura", ATKFinal)
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          } else if(BuffList[[k]][i]=="Sacrifice") {
            DealCycle <- DCBuff(DealCycle, "SacrificeCooldown", BuffFinal)
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="MapleSoldier") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            BSRemain <- max(0, BSRemain - DealCycle$Time[1])
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          BSRemain <- max(0, BSRemain - DealCycle$Time[1])
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}
DarkKnightAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Beholder Summon
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BeholderShock") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BeholderDominantSummoned"
    } else if(DealCycle$Skills[i]=="BeholderImpact") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BeholderDominantSummoned"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + 3660
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 3:nrow(DealCycle)) {
    if("BeholderDominantSummoned"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  ## Beholder ATK
  DealCycle <- DCSummonedATKs(DealCycle, "BeholderDominant", SummonedFinal)
  BeholderRM <- c()
  k <- as.numeric(rownames(subset(DealCycle, DealCycle$Skills=="BeholderImpact")[1, ]))
  for(i in k:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BeholderDominant" & DealCycle$Time[i] - max(subset(DealCycle[1:i, ], DealCycle[1:i, ]$Skills=="BeholderImpact")$Time) <= 3660) {
      BeholderRM <- c(BeholderRM, i)
    }
  }
  DealCycle <- DealCycle[-BeholderRM, ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Beholder Impact
  DealCycle <- RepATKCycle(DealCycle, "BeholderImpact", 11, 780, ATKFinal)
  
  ## Sacrifice Cooldown
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("BeholderImpact", "BeholderDominant", "BeholderShock"))==1) {
      DealCycle$SacrificeCooldown[i] <- max(0, DealCycle$SacrificeCooldown[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) - 350)
    } else if(DealCycle$Skills[i]!="SacrificeCooldown") {
      DealCycle$SacrificeCooldown[i] <- max(0, DealCycle$SacrificeCooldown[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    }
  }
  
  ## Dark Spear, Darkness Aura, Darkness Aura End, Pierce Cyclone, Pierce Cyclone End
  DealCycle <- RepATKCycle(DealCycle, "DarkSpear", 10, 60, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "DarknessAura", 26, 1500, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "DarknessAuraEnd", 6, 600, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "PierceCycloneEnd", 5, 150, ATKFinal)
  
  ## Final Attack
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("GungnirDescent", "PierceCycloneTick", "PierceCycloneTickRemain", "PierceCycloneEndStart"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "FinalAttack"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Aura Weapon
  DealCycle <- AWCycle(DealCycle, c("PierceCycloneEndStart", "DarkSpearStart", "GungnirDescent"))
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  return(DealCycle)
}

DarkKnightDealCycle <- DarkKnightCycle(PreDealCycle=DarkKnightDealCycle, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal, 
                                       SummonedFinal=SummonedFinal, 
                                       Spec=DarkKnightSpec,
                                       Period=180, 
                                       CycleTime=720, 
                                       Reincarnation=T)
DarkKnightDealCycle <- DealCycleFinal(DarkKnightDealCycle)
DarkKnightDealCycle <- DarkKnightAddATK(DealCycle=DarkKnightDealCycle, 
                                        ATKFinal=ATKFinal,
                                        BuffFinal=BuffFinal, 
                                        SummonedFinal=SummonedFinal, 
                                        Spec=DarkKnightSpec)
DarkKnightDealCycleReduction <- DealCycleReduction(DarkKnightDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="DarkKnight") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  DarkKnightSpecOpt1 <- Optimization1(DarkKnightDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DarkKnightSpec, DarkKnightUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- DarkKnightSpecOpt1[1, 1:3]
} else {
  DarkKnightSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
DarkKnightSpecOpt <- OptDataAdd(DarkKnightSpec, DarkKnightSpecOpt1, "Potential", DarkKnightBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  DarkKnightSpecOpt2 <- Optimization2(DarkKnightDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DarkKnightSpecOpt, DarkKnightHyperStatBase, DarkKnightBase$ChrLv, DarkKnightBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- DarkKnightSpecOpt2[1, ]
} else {
  DarkKnightSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
DarkKnightSpecOpt <- OptDataAdd(DarkKnightSpecOpt, DarkKnightSpecOpt2, "HyperStat", DarkKnightBase$CRROver, DemonAvenger=F)

DarkKnightFinalDPM <- DealCalc(DarkKnightDealCycle, ATKFinal, BuffFinal, SummonedFinal, DarkKnightSpecOpt, Collapse=F)
DarkKnightFinalDPMwithMax <- DealCalcWithMaxDMR(DarkKnightDealCycle, ATKFinal, BuffFinal, SummonedFinal, DarkKnightSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "DarkKnight", sum(na.omit(DarkKnightFinalDPMwithMax)) / (max(DarkKnightDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "DarkKnight", sum(na.omit(DarkKnightFinalDPM)) / (max(DarkKnightDealCycle$Time) / 60000) - sum(na.omit(DarkKnightFinalDPMwithMax)) / (max(DarkKnightDealCycle$Time) / 60000))

DarkKnightDealRatio <- DealRatio(DarkKnightDealCycle, DarkKnightFinalDPMwithMax)

DarkKnightDealData <- data.frame(DarkKnightDealCycle$Skills, DarkKnightDealCycle$Time, DarkKnightDealCycle$Restraint4, DarkKnightFinalDPMwithMax)
colnames(DarkKnightDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "DarkKnight", Deal_RR(DarkKnightDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "DarkKnight", Deal_40s(DarkKnightDealData, F, NA, FinishTime=subset(DarkKnightDealData, DarkKnightDealData$Skills=="Restraint4")$Time[1] + 15000))


## Reincarnation OFF
DealCycle <- c("Skills", "Time", rownames(DarkKnightBuff))
DarkKnightDealCycleReincOff <- t(rep(0, length(DealCycle)))
colnames(DarkKnightDealCycleReincOff) <- DealCycle

DarkKnightDealCycleReincOff <- DarkKnightCycle(PreDealCycle=DarkKnightDealCycleReincOff, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal, 
                                       SummonedFinal=SummonedFinal, 
                                       Spec=DarkKnightSpec,
                                       Period=180, 
                                       CycleTime=720, 
                                       Reincarnation=F)
DarkKnightDealCycleReincOff <- DealCycleFinal(DarkKnightDealCycleReincOff)
DarkKnightDealCycleReincOff <- DarkKnightAddATK(DealCycle=DarkKnightDealCycleReincOff, 
                                        ATKFinal=ATKFinal,
                                        BuffFinal=BuffFinal, 
                                        SummonedFinal=SummonedFinal, 
                                        Spec=DarkKnightSpec)

DarkKnightReincOff <- DealCalcWithMaxDMR(DarkKnightDealCycleReincOff, ATKFinal, BuffFinal, SummonedFinal, DarkKnightSpecOpt)
ReincOffDPM <- sum(na.omit(DarkKnightReincOff)) / (max(DarkKnightDealCycleReincOff$Time) / 60000)

ReincOffDealData <- data.frame(DarkKnightDealCycleReincOff$Skills, DarkKnightDealCycleReincOff$Time, DarkKnightDealCycleReincOff$Restraint4, DarkKnightReincOff)
colnames(ReincOffDealData) <- c("Skills", "Time", "R4", "Deal")

ReincOffRR <- Deal_RR(ReincOffDealData)
ReincOff40s <- Deal_40s(ReincOffDealData, F, NA, FinishTime=subset(ReincOffDealData, ReincOffDealData$Skills=="Restraint4")$Time[1] + 15000)

print(data.frame(ReincOffDPM=ReincOffDPM, ReincOffRR=ReincOffRR, ReincOff40s=ReincOff40s))