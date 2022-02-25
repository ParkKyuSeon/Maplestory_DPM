## ArchMageTC - Data
## ArchMageTC - VMatrix
ArchMageTCCoreBase <- CoreBuilder(ActSkills=c("IceAge", "ThunderBreak", "SpiritofSnow", "JupiterThunder", 
                                              CommonV("Wizard", "Adventure")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                  UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=ArchMageTCVPassive, 
                                  VPassivePrior=ArchMageTCVPrior, 
                                  SelfBind=F)

ArchMageTCCore <- MatrixSet(PasSkills=ArchMageTCCoreBase$PasSkills$Skills, 
                            PasLvs=ArchMageTCCoreBase$PasSkills$Lv, 
                            PasMP=ArchMageTCCoreBase$PasSkills$MP, 
                            ActSkills=ArchMageTCCoreBase$ActSkills$Skills, 
                            ActLvs=ArchMageTCCoreBase$ActSkills$Lv, 
                            ActMP=ArchMageTCCoreBase$ActSkills$MP, 
                            UsefulSkills=ArchMageTCCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=ArchMageTCCoreBase$SpecialCoreUse)


## ArchMageTC - Basic Info
## Link Check Needed
ArchMageTCBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="ArchMageTC",
                          CoreData=ArchMageTCCore, 
                          BuffDurationNeeded=310, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "ArchMageTC"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "ArchMageTC"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "ArchMageTC")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="TCGrimoire", ], 
                          Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "ArchMageTC")))


## ArchMageTC - Passive
{option <- factor(c("CRR", "ATKSpeed"), levels=PSkill)
value <- c(5, 1)
MPIncrease <- data.frame(option, value) ## Wand Only

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
MagicAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("FDR", "ImmuneIgnore"), levels=PSkill)
value <- c(50, 10)
ElementalReset <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(50)
ElementAmplification <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70 + ceiling(ArchMageTCBase$SkillLv/2))
ElquinesPassive <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * ArchMageTCBase$PSkillLv, 50 + 5 * ArchMageTCBase$PSkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(ArchMageTCBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(ArchMageTCCore, "UnstableMemorize"))
UnstableMemorizePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ArchMageTCCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(ArchMageTCCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

ArchMageTCPassive <- Passive(list(MPIncrease=MPIncrease, MagicAcceleration=MagicAcceleration, SpellMastery=SpellMastery, HighWisdom=HighWisdom, ElementalReset=ElementalReset, 
                                  MagicCritical=MagicCritical, ElementAmplification=ElementAmplification, ElquinesPassive=ElquinesPassive, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, 
                                  UnstableMemorizePassive=UnstableMemorizePassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## ArchMageTC - Buff
## FrostEffect, ExtremeMagic, FrozenBreak, OverloadMana
{option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Meditation <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + ArchMageTCBase$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ArchMageTCBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ArchMageTCBase$SkillLv/2))))
info <- c(900 + 30 * ArchMageTCBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FrostEffectStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FrostEffectStackCalc <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FrostEffectStackBDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FrostEffectStackCDMR <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ExtremeMagic <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(ArchMageTCCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(ArchMageTCCore, "OverloadMana")/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(ArchMageTCCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * ArchMageTCBase$MainStatP), 5 + floor(GetCoreLv(ArchMageTCCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(12)
info <- c(10.87, 12, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JupiterThunderFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(15, 60, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IceCyclone <- rbind(data.frame(option, value), info)}

ArchMageTCBuff <- list(Meditation=Meditation, Infinity=Infinity, MapleSoldier=MapleSoldier, 
                       FrostEffectStack=FrostEffectStack, FrostEffectStackCalc=FrostEffectStackCalc, FrostEffectStackBDR=FrostEffectStackBDR, FrostEffectStackCDMR=FrostEffectStackCDMR, ExtremeMagic=ExtremeMagic, 
                       EpicAdventure=EpicAdventure, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                       OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, JupiterThunderFDR=JupiterThunderFDR, IceCyclone=IceCyclone, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, Meditation(600ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  ArchMageTCBuff[[length(ArchMageTCBuff)+1]] <- UsefulAdvancedBless
  names(ArchMageTCBuff)[[length(ArchMageTCBuff)]] <- "UsefulAdvancedBless"
}
ArchMageTCBuff <- Buff(ArchMageTCBuff)
ArchMageTCAllTimeBuff <- AllTimeBuff(ArchMageTCBuff)


## ArchMageTC - Union & HyperStat & SoulWeapon
ArchMageTCSpec <- JobSpec(JobBase=ArchMageTCBase, 
                          Passive=ArchMageTCPassive, 
                          AllTimeBuff=ArchMageTCAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="Wand", 
                          UnionStance=0, 
                          JobConstant=1.2)

ArchMageTCUnionRemained <- ArchMageTCSpec$UnionRemained
ArchMageTCHyperStatBase <- ArchMageTCSpec$HyperStatBase
ArchMageTCCoolReduceType <- ArchMageTCSpec$CoolReduceType
ArchMageTCSpec <- ArchMageTCSpec$Spec


## ArchMageTC - Spider In Mirror
SIM <- SIMData(GetCoreLv(ArchMageTCCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## ArchMageTC - Attacks
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(ArchMageTCCore, "ChainLightning")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "ChainLightning"))
info <- c(200 + 3 * ArchMageTCSpec$SkillLv, 11, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainLightning <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "LightningSpear")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "LightningSpear"))
info <- c(150, 15, 3600, 270, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearLoop <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "LightningSpear")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "LightningSpear"))
info <- c(780, 15, 1080, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearEnd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(ArchMageTCCore, "FrozenOrb")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "FrozenOrb"))
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, 1, 900, 210, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FrozenOrb <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Blizard")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "Blizard"))
info <- c(301 + 3 * ArchMageTCSpec$SkillLv, 12, 900, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blizard <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Blizard")>=40, 20, 0), ArchMageTCBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(ArchMageTCCore, "Blizard"))
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, 0.6 + 0.02 * ArchMageTCSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardFA <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(500 + 20 * GetCoreLv(ArchMageTCCore, "IceAge"), 10, 0, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAge <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(125 + 5 * GetCoreLv(ArchMageTCCore, "IceAge"), 3, 870, 800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAgeFloor <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 0), 12, 660, 210, 40, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 1), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 2), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 3), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak4 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 4), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak5 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 5), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak6 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 6), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak7 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((925 + 38 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 7), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak8 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(300 + 12 * GetCoreLv(ArchMageTCCore, "JupiterThunder"), 8, 810, 330, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JupiterThunder <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 430 - 3 * GetCoreLv(ArchMageTCCore, "UnstableMemorize"), F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorize <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 1200, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAuraDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1260, 300, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceCycloneDummy <- rbind(data.frame(option, value), info)}

ArchMageTCATK <- Attack(list(ChainLightning=ChainLightning, LightningSpearLoop=LightningSpearLoop, LightningSpearEnd=LightningSpearEnd, FrozenOrb=FrozenOrb, Blizard=Blizard, BlizardFA=BlizardFA, 
                             IceAge=IceAge, IceAgeFloor=IceAgeFloor, ThunderBreak=ThunderBreak, ThunderBreak2=ThunderBreak2, ThunderBreak3=ThunderBreak3, ThunderBreak4=ThunderBreak4, 
                             ThunderBreak5=ThunderBreak5, ThunderBreak6=ThunderBreak6, ThunderBreak7=ThunderBreak7, ThunderBreak8=ThunderBreak8, JupiterThunder=JupiterThunder, 
                             UnstableMemorize=UnstableMemorize, IceAuraDummy=IceAuraDummy, IceCycloneDummy=IceCycloneDummy, SpiderInMirror=SpiderInMirror))


## ArchMageTC - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Elquines")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "Elquines"))
info <- c(127 + 2 * ArchMageTCSpec$SkillLv, 3, 600, 3030, 260 + 5 * ArchMageTCSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Elquines <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "ThunderSphere")>=40, 20, 0), 3 * GetCoreLv(ArchMageTCCore, "ThunderSphere"))
info <- c(370, 3, 900, 1080, 50, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ThunderSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(850 + 34 * GetCoreLv(ArchMageTCCore, "SpiritofSnow"), 9, 720, 3030, 30, 120, T, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiritofSnow <- rbind(data.frame(option, value), info)}

ArchMageTCSummoned <- Summoned(list(Elquines=Elquines, ThunderSphere=ThunderSphere, SpiritofSnow=SpiritofSnow, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, 
                                    SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## ArchMageTC - DealCycle and Deal Calculation
ATKFinal <- data.frame(ArchMageTCATK)
ATKFinal$Delay[c(-2, -18)] <- Delay(ATKFinal$Delay, ArchMageTCSpec$ATKSpeed)[c(-2, -18)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)

BuffFinal <- data.frame(ArchMageTCBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchMageTCSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ArchMageTCSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArchMageTCSpec$SummonedDuration / 100, 0)


## Unstable Memorize Data
UnstableCoolReduceProb <- c(1, 6, 6, 6, 10, 11, 12, 12, 12, 8, 6, 5, 2, 2, 1)
UnstableCoolReduceP <- c(20, 23, 24, 25, 27, 30, 33, 35, 38, 40, 45, 50, 55, 60, 65)

UnstableCool <- c()
for(i in 1:length(UnstableCoolReduceP)) {
  UnstableCool <- c(UnstableCool, ATKFinal[rownames(ATKFinal)=="UnstableMemorize", ]$CoolTime * ((100 - UnstableCoolReduceP[i]) / 100) * ((100 - ArchMageTCSpec$CoolReduceP) / 100) - ArchMageTCSpec$CoolReduce)
}
UnstableCool <- UnstableCool[UnstableCool > BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2]
UnstableCool <- c(UnstableCool, BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2)
UnstableProb <- UnstableCoolReduceProb[1:(length(UnstableCool)-1)] / 100
UnstableProb <- c(UnstableProb, 1 - sum(UnstableProb))
UnstableCycleNames <- c()
UnstableCycleNames_TB <- c()
UnstableDealDataNames <- c()
for(i in 1:length(UnstableCool)) {
  UnstableCycleNames <- c(UnstableCycleNames, paste("ArchMageTCDealCycle", i, sep=""))
  UnstableCycleNames_TB <- c(UnstableCycleNames_TB, paste("ArchMageTCDealCycleTB", i, sep=""))
  UnstableDealDataNames <- c(UnstableDealDataNames, paste("ArchMageTCDealData", i, sep=""))
}
UnstableCyclesTC <- data.frame(Cool = UnstableCool, 
                               Prob = UnstableProb, 
                               CycleNames = UnstableCycleNames, 
                               CycleNames_TB = UnstableCycleNames_TB, 
                               DealDatas = UnstableDealDataNames, 
                               CycleTimes = rep(0, length(UnstableCool)), 
                               stringsAsFactors = F)


## ArchMageTC - DealCycle
ArchMageTCCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, UnstableCool) {
  DealCycle <- DCATK(DealCycle, c("IceAuraDummy"), ATKFinal)
  DealCycle <- DCBuff(DealCycle, c("Meditation", "MapleSoldier", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
  BuffList <- c("Meditation", "MapleSoldier", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders")
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCSummoned(DealCycle, "Elquines", SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, "ThunderSphere", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  ## 1st, 3rd, 5th Infinity
  ## IceCyclone <- c(16)
  Restraint4 <- c(15)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    LightningSpearLoop <- c(5)
  } else {
    LightningSpearLoop <- c(5, 66)
  }
  IceAge <- c(15, 73)
  JupiterThunderFDR <- c(11)
  ThunderBreak <- c(10, 49, 88)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  SpiritofSnow <- c(30)
  SpiderInMirror <- c(50)
  ## skills1 <- list(IceCyclone=IceCyclone, Restraint4=Restraint4, LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, MapleWarriors2=MapleWarriors2, 
  ##                 SoulContractLink=SoulContractLink, SpiritofSnow=SpiritofSnow, SpiderInMirror=SpiderInMirror)
  skills1 <- list(Restraint4=Restraint4, LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, SpiritofSnow=SpiritofSnow, SpiderInMirror=SpiderInMirror)
  
  ## 2nd, 4th, 6th Infinity
  ## IceCyclone <- c(16)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    LightningSpearLoop <- c(5)
  } else {
    LightningSpearLoop <- c(5, 66)
  }
  IceAge <- c(15, 73)
  JupiterThunderFDR <- c(11)
  ThunderBreak <- c(10, 49, 88)
  SoulContractLink <- c(31)
  SpiritofSnow <- c(30)
  ## skills2 <- list(IceCyclone=IceCyclone, LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, 
  ##                 SoulContractLink=SoulContractLink, SpiritofSnow=SpiritofSnow)
  skills2 <- list(LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, 
                  SoulContractLink=SoulContractLink, SpiritofSnow=SpiritofSnow)
  
  for(k in 1:6) {
    if(sum(k==c(1, 3, 5)) >= 1) {
      skills <- skills1
    } else if(sum(k==c(2, 4, 6)) >= 1) {
      skills <- skills2
    } 
  
    times <- c()
    for(i in 1:length(skills)) {
      times <- c(times, skills[[i]])
    }
    times <- unique(times)
    times <- times[order(times, decreasing=T)]
    
    skilllist <- list()
    for(i in 1:length(times)) {
      skilllist[[i]] <- 1
      for(j in 1:length(skills)) {
        if(sum(skills[[j]]==times[[i]])==1) {
          skilllist[[i]] <- c(skilllist[[i]], names(skills)[[j]])
        }
      }
      skilllist[[i]] <- skilllist[[i]][-1]
    }
    names(skilllist) <- times
    times <- times * 1000
    OrbCool <- subset(ATKFinal, rownames(ATKFinal)=="FrozenOrb")$CoolTime * 1000
    BZCool <- subset(ATKFinal, rownames(ATKFinal)=="Blizard")$CoolTime * 1000
    TSCool <- 45000
    
    p <- 1
    while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
      if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
        for(j in 1:length(skilllist[[p]])) {
          if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
            if(skilllist[[p]][j]=="ThunderBreak") {
              DealCycle[1, 2:ncol(DealCycle)] <- 30
            }
            DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
            if(DealCycle$Skills[nrow(DealCycle)]=="IceAge") {
              DealCycle <- DCATK(DealCycle, "IceAgeFloor", ATKFinal)
            } else if(DealCycle$Skills[nrow(DealCycle)]=="LightningSpearLoop") {
              DealCycle <- DCATK(DealCycle, "LightningSpearEnd", ATKFinal)
            }
          } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
            DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
            if(DealCycle$Skills[nrow(DealCycle)]=="JupiterThunderFDR") {
              DealCycle <- DCATK(DealCycle, "JupiterThunder", ATKFinal)
            } else if(DealCycle$Skills[nrow(DealCycle)]=="IceCyclone") {
              DealCycle <- DCATK(DealCycle, "IceCycloneDummy", ATKFinal)
            }
          } else {
            DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
          }
        }
        p <- p + 1
      }
      
      if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
        OrbRemain <- 0
      } else {
        OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
      }
      if(nrow(subset(DealCycle, DealCycle$Skills=="Blizard"))==0) {
        BZRemain <- 0
      } else {
        BZRemain <- max(0, BZCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Blizard")$Time)))
      }
      TSRemain <- max(0, TSCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="ThunderSphereSummoned")$Time)))
      
      if(OrbRemain == 0) {
        DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
      } else if(BZRemain == 0 & nrow(DealCycle[DealCycle$Skills=="Blizard", ]) < 2 * k) {
        DealCycle <- DCATK(DealCycle, "Blizard", ATKFinal)
      } else if(TSRemain == 0) {
        DealCycle <- DCSummoned(DealCycle, "ThunderSphere", SummonedFinal)
      } else {
        DealCycle <- DCATK(DealCycle, "ChainLightning", ATKFinal)
      }
    }
    
    if(sum(k==c(1, 3, 5)) >= 1) {
      DealCycle <- DCBuff(DealCycle, c("EpicAdventure"), BuffFinal)
      DealCycle <- DCSummoned(DealCycle, "ThunderSphere", SummonedFinal)
      DealCycle <- DCATK(DealCycle, c("UnstableMemorize"), ATKFinal)
      DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
    } else if(sum(k==c(2, 4, 6)) >= 1) {
      while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - 
            (UnstableCool * 1000 - BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 1000 + max(DealCycle[DealCycle$Skills=="UnstableMemorize", ]$Time) - min(DealCycle[DealCycle$Skills=="Infinity", ]$Time)) < 0) {
        DealCycle <- DCATK(DealCycle, "ChainLightning", ATKFinal)
      }
      
      if(k != 6) {
        for(i in 1:length(BuffList)) {
          DealCycle <- DCBuff(DealCycle, BuffList[i], BuffFinal)
        }
        
        if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
          DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
        }
        DealCycle <- DCSummoned(DealCycle, "Elquines", SummonedFinal)
        DealCycle <- DCSummoned(DealCycle, "ThunderSphere", SummonedFinal)
        DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
      }
    }
  }
  return(DealCycle)
}
TCAddATKCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, ThunderBreakHits=8, ArchMageTCSpec) {
  ## Rep ATKs (Lightning Spear, Jupiter Thunder, Ice Age, Frozen Orb, Ice Aura Dummy)
  DealCycle <- RepATKCycle(DealCycle, "LightningSpearLoop", 14, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JupiterThunder", 30, 870, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "IceAgeFloor", 18, 800, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FrozenOrb", 19, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "IceAuraDummy", 800, 0, ATKFinal)
  ## DealCycle <- RepATKCycle(DealCycle, "IceCycloneDummy", 47, 0, ATKFinal)
  
  IceAuraDel <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="IceAuraDummy" & DealCycle$IceCyclone[i] > 0) {
      IceAuraDel <- c(IceAuraDel, i)
    }
  }
  if(length(IceAuraDel) > 0) {
    DealCycle <- DealCycle[-IceAuraDel, ]
    DealCycle <- DealCycle[order(DealCycle$Time), ]
    rownames(DealCycle) <- 1:nrow(DealCycle)
  }
  
  ## Summoned Skills (Thunder Sphere, Elquines, Spirit of Snow)
  DealCycle <- DCSummonedATKs(DealCycle, "ThunderSphere", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "Elquines", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "SpiritofSnow", SummonedFinal)
  
  ## Thunder Break
  DealCycle <- RepATKCycle(DealCycle, "ThunderBreak", ThunderBreakHits, 0, ATKFinal)
  k <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ThunderBreak") {
      if(k != 1) {
        DealCycle$Skills[i] <- paste("ThunderBreak", k, sep="")
      }
      k <- ifelse(k==ThunderBreakHits, 1, k + 1)
    }
  }
  
  ## Blizard Add ATK
  for(i in 1:(nrow(DealCycle))) {
    if(sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "FrozenOrb", "IceAge", "ThunderBreak", "ThunderBreak2", "ThunderBreak3", 
                                  "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", "JupiterThunder")) > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("BlizardFA")
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Spider In Mirror
  if(nrow(subset(DealCycle, DealCycle$Skills=="SpiderInMirror")) > 0) {
    DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  }
  
  ## Jupiter Thunder Buff
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$JupiterThunderFDR[i] > 10000) {
      DealCycle$JupiterThunderFDR[i] <- 0
    }
    if(DealCycle$JupiterThunderFDR[i] > 0 & sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "ThunderBreak", "ThunderBreak2", "ThunderBreak3", 
                                                                       "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", "ThunderSphere")) > 0) {
      DealCycle$JupiterThunderFDR[i] <- 1
    } else {
      DealCycle$JupiterThunderFDR[i] <- 0
    }
  }
  
  ## Frost Effect Stack & Extreme Magic
  JTStack <- 0
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FrozenOrb", "Blizard", "IceAge", "IceAgeFloor", "Elquines", "IceAuraDummy", "IceCycloneDummy")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + 1)
    } else if(sum(DealCycle$Skills[i]==c("BlizardFA")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + (0.6 + 0.02 * ArchMageTCSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("SpiritofSnow")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + 3)
    } else if(sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "ThunderBreak", "ThunderBreak2", "ThunderBreak3", 
                                         "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8")) > 0) {
      DealCycle$FrostEffectStackCalc[i] <- DealCycle$FrostEffectStack[i-1]
      DealCycle$FrostEffectStack[i] <- max(0, DealCycle$FrostEffectStack[i-1] - 1)
    } else if(sum(DealCycle$Skills[i]==c("ThunderSphere")) > 0) {
      DealCycle$FrostEffectStackCalc[i] <- DealCycle$FrostEffectStack[i-1]
      DealCycle$FrostEffectStack[i] <- DealCycle$FrostEffectStack[i-1]
    } else if(sum(DealCycle$Skills[i]==c("JupiterThunder")) > 0) {
      DealCycle$FrostEffectStackCalc[i] <- DealCycle$FrostEffectStack[i-1]
      JTStack <- min(5, JTStack + 1)
      if(JTStack==5) {
        DealCycle$FrostEffectStack[i] <- max(0, DealCycle$FrostEffectStack[i-1] - 1)
      } else {
        DealCycle$FrostEffectStack[i] <- DealCycle$FrostEffectStack[i-1]
      }
    } else {
      DealCycle$FrostEffectStack[i] <- DealCycle$FrostEffectStack[i-1]
    }
    
    if(DealCycle$FrostEffectStack[i]!=0 | DealCycle$FrostEffectStackCalc[i]!=0) {
      DealCycle$ExtremeMagic[i] <- 1
    }
  }
  DealCycle$FrostEffectStackBDR <- DealCycle$FrostEffectStackCalc * 12
  DealCycle$FrostEffectStackCDMR <- DealCycle$FrostEffectStackCalc * 3
  for(i in 1:nrow(DealCycle)) {
    DealCycle$FrostEffectStackCalc[i] <- max(DealCycle$FrostEffectStack[i], DealCycle$FrostEffectStackCalc[i]) * 2
  }
  DealCycle$FrostEffectStack <- 0
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "FrozenOrb", "Blizard", "IceAge", "ThunderBreak", "ThunderBreak2", 
                                  "ThunderBreak3", "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", "JupiterThunder")) > 0) {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  return(DealCycle)
}

for(i in 1:nrow(UnstableCyclesTC)) {
  DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
  ArchMageTCDealCycleDummy <- t(rep(0, length(DealCycle)))
  colnames(ArchMageTCDealCycleDummy) <- DealCycle
  
  ArchMageTCDealCycleDummy <- ArchMageTCCycle(ArchMageTCDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, UnstableCool = UnstableCool[i])
  ArchMageTCDealCycleDummy <- DealCycleFinal(ArchMageTCDealCycleDummy)
  
  ArchMageTCDealCycleDummy <- TCAddATKCycle(ArchMageTCDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, 8, ArchMageTCSpec)
  ArchMageTCDealCycleDummy <- BishopInfinity(ArchMageTCDealCycleDummy, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)
  
  UnstableCyclesTC$CycleTimes[i] <- max(ArchMageTCDealCycleDummy$Time)
  assign(paste("ArchMageTCDealCycle", i, sep=""), ArchMageTCDealCycleDummy)
  rm(ArchMageTCDealCycleDummy)
}

ArchMageTCDealCycleReduction <- DealCycleReduction(get(UnstableCyclesTC$CycleNames[nrow(UnstableCyclesTC)]), NotBuffColNames=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="ArchMageTC") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  ArchMageTCSpecOpt1 <- Optimization1(ArchMageTCDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpec, ArchMageTCUnionRemained, 
                                      NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
  PotentialOpt[[Idx1]][Idx2, ] <- ArchMageTCSpecOpt1[1, 1:3]
} else {
  ArchMageTCSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ArchMageTCSpecOpt <- OptDataAdd(ArchMageTCSpec, ArchMageTCSpecOpt1, "Potential", ArchMageTCBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ArchMageTCSpecOpt2 <- Optimization2(ArchMageTCDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, ArchMageTCHyperStatBase, ArchMageTCBase$ChrLv, ArchMageTCBase$CRROver, 
                                      NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ArchMageTCSpecOpt2[1, ]
} else {
  ArchMageTCSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ArchMageTCSpecOpt <- OptDataAdd(ArchMageTCSpecOpt, ArchMageTCSpecOpt2, "HyperStat", ArchMageTCBase$CRROver, DemonAvenger=F)

ArchMageTCFinalDPM <- ResetDealCalc(DealCycles=GetList(UnstableCyclesTC$CycleNames), 
                                    ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, UnstableCyclesTC$CycleTimes, UnstableCyclesTC$Prob, 
                                    NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
ArchMageTCFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=GetList(UnstableCyclesTC$CycleNames), 
                                                     ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, UnstableCyclesTC$CycleTimes, UnstableCyclesTC$Prob, 
                                                     NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))

set(get(DPMCalcOption$DataName), as.integer(1), "ArchMageTC", sum(na.omit(ArchMageTCFinalDPMwithMax)) / (sum(UnstableCyclesTC$Prob * UnstableCyclesTC$CycleTimes) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "ArchMageTC", sum(na.omit(ArchMageTCFinalDPM)) / (sum(UnstableCyclesTC$Prob * UnstableCyclesTC$CycleTimes) / 60000) - 
      sum(na.omit(ArchMageTCFinalDPMwithMax)) / (sum(UnstableCyclesTC$Prob * UnstableCyclesTC$CycleTimes) / 60000))

ArchMageTCDealData <- data.frame(ArchMageTCDealCycle1$Skills, ArchMageTCDealCycle1$Time, ArchMageTCDealCycle1$Restraint4, 
                                 DealCalcWithMaxDMR(ArchMageTCDealCycle1, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                    NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")))
colnames(ArchMageTCDealData) <- c("Skills", "Time", "R4", "Deal")

for(i in 1:nrow(UnstableCyclesTC)) {
  ArchMageTCDealDummy <- DealCalcWithMaxDMR(get(UnstableCyclesTC$CycleNames[i]), ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                            NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
  assign(paste("ArchMageTCDealData", i, sep=""), ArchMageTCDealDummy)
  rm(ArchMageTCDealDummy)
}
ArchMageTCDealRatio <- ResetDealRatio(DealCycles=GetList(UnstableCyclesTC$CycleNames), 
                                      DealDatas=GetList(UnstableCyclesTC$DealDatas), 
                                      times=UnstableCyclesTC$CycleTimes, 
                                      prob=UnstableCyclesTC$Prob)

set(get(DPMCalcOption$DataName), as.integer(3), "ArchMageTC", Deal_RR(ArchMageTCDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "ArchMageTC", Deal_40s(ArchMageTCDealData, F, NA, FinishTime=subset(ArchMageTCDealData, ArchMageTCDealData$Skills=="Restraint4")$Time[1] + 15000))

ArchMageTCSpecMean <- ResetSpecMean("ArchMageTC", 
                                    GetList(UnstableCyclesTC$CycleNames), 
                                    GetList(UnstableCyclesTC$DealDatas), 
                                    ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, UnstableCyclesTC$CycleTimes, UnstableCyclesTC$Prob, 
                                    NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))


## ThunderBreak 2Hits
for(i in 1:nrow(UnstableCyclesTC)) {
  DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
  ArchMageTCDealCycleDummy <- t(rep(0, length(DealCycle)))
  colnames(ArchMageTCDealCycleDummy) <- DealCycle
  
  ArchMageTCDealCycleDummy <- ArchMageTCCycle(ArchMageTCDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, UnstableCool = UnstableCool[i])
  ArchMageTCDealCycleDummy <- DealCycleFinal(ArchMageTCDealCycleDummy)
  
  ArchMageTCDealCycleDummy <- TCAddATKCycle(ArchMageTCDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, 2, ArchMageTCSpec)
  ArchMageTCDealCycleDummy <- BishopInfinity(ArchMageTCDealCycleDummy, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)
  
  assign(paste("ArchMageTCDealCycleTB", i, sep=""), ArchMageTCDealCycleDummy)
  rm(ArchMageTCDealCycleDummy)
}
ArchMageTCFinalDPM2 <- ResetDealCalc(DealCycles=GetList(UnstableCyclesTC$CycleNames_TB), 
                                     ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, UnstableCyclesTC$CycleTimes, UnstableCyclesTC$Prob, 
                                     NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
TCTB2Hits <- sum(na.omit(ArchMageTCFinalDPM2)) / (sum(UnstableCyclesTC$Prob * UnstableCyclesTC$CycleTimes) / 60000)

ArchMageTCDealDataTB <- data.frame(ArchMageTCDealCycleTB1$Skills, ArchMageTCDealCycleTB1$Time, ArchMageTCDealCycleTB1$Restraint4, 
                                   DealCalcWithMaxDMR(ArchMageTCDealCycleTB1, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                      NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")))
colnames(ArchMageTCDealDataTB) <- c("Skills", "Time", "R4", "Deal")

TCTB2HitR4 <- Deal_RR(ArchMageTCDealDataTB)
TCTB2Hit40s <- Deal_40s(ArchMageTCDealDataTB, F, NA, FinishTime=subset(ArchMageTCDealDataTB, ArchMageTCDealDataTB$Skills=="Restraint4")$Time[1] + 15000)

print(data.frame(ThunderBreak2HitsDPM=TCTB2Hits, ThunderBreak2HitsRR=TCTB2HitR4, ThunderBreak2Hits40s=TCTB2Hit40s))