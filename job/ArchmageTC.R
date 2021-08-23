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

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(50)
ElementalResetPassive <- data.frame(option, value)

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
value <- c(20 + ceiling(ArchmageTCBase$SkillLv/2), 40)
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

ArchMageTCPassive <- Passive(list(MPIncrease=MPIncrease, SpellMastery=SpellMastery, HighWisdom=HighWisdom, ElementalResetPassive=ElementalResetPassive, 
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

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalReset <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(45, T, ArchMageTCBase$UnionChrs$CoolReduceP, ArchMageTCBase$CoolReduce), Cooldown(45, T, ArchMageTCBase$UnionChrs$CoolReduceP, ArchMageTCBase$CoolReduce), 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlizardBuff <- rbind(data.frame(option, value), info)

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
JupiterThunderFDR <- rbind(data.frame(option, value), info)}

ArchMageTCBuff <- list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, BlizardBuff=BlizardBuff, Infinity=Infinity, MapleSoldier=MapleSoldier, 
                       FrostEffectStack=FrostEffectStack, FrostEffectStackCalc=FrostEffectStackCalc, FrostEffectStackBDR=FrostEffectStackBDR, FrostEffectStackCDMR=FrostEffectStackCDMR, ExtremeMagic=ExtremeMagic, 
                       EpicAdventure=EpicAdventure, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                       OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, JupiterThunderFDR=JupiterThunderFDR, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, MagicBooster(990ms), Meditation(600ms), ElementalReset(990ms), (UsefulAdvancedBless)
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


## ArchMageTC - Unstable Memorize Data
Skills <- c("EnergyBolt", "ColdBeam", "ThunderBolt", "IceStrike", "GlacialChain", "ThunderStorm", 
            "ChainLightning", "Blizard", "FrozenOrb", "Infinity", "Elquines", "LightningSpear", "EpicAdventure")
Ind <- c(1, 5, 5, 10, 10, 10, 
         25, 25, 25, 25, 25, 10, 10)
Prob <- Ind/sum(Ind)
Delays <- c(Delay(810, 2), Delay(810, 2), Delay(810, 2), Delay(840, 2), Delay(870, 2), 900, 
            Delay(780, 2), Delay(900, 2), Delay(900, 2), 600, 600, Delay(1080, 2), 0)
ArchMageTCUnstable <- data.frame(Skills, Ind, Prob, Delays)
BlizardFinalATKProb <- sum(ArchMageTCUnstable$Prob[c(1, 2, 3, 4, 5, 7, 12)]) * (0.6 + 0.02 * ArchMageTCSpec$SkillLv)
UnsFrostEffect <- sum(ArchMageTCUnstable$Prob[c(2, 4, 5, 8)])
UnsFrostEffectCost <- sum(ArchMageTCUnstable$Prob[c(3, 7, 12)])


## ArchMageTC - Attacks
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(ArchMageTCCore, "ChainLightning")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "ChainLightning"))
info <- c(185 + 3 * ArchMageTCSpec$SkillLv, 11, 780, NA, NA, NA, NA, F)
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
info <- c(220, 1, 900, 210, 5, T, T, F)
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
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 0), 12, 660, 210, 40, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 1), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 2), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 3), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak4 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 4), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak5 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 5), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak6 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 6), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak7 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * GetCoreLv(ArchMageTCCore, "ThunderBreak")) * (0.8 ^ 7), 12, 0, NA, NA, NA, NA, F)
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
info <- c(309, ArchMageTCUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(199, 3 * ArchMageTCUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ColdBeamUnstable <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(210, 3 * ArchMageTCUnstable[3, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(335, 4 * ArchMageTCUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceStrikeUnstable <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(383, 3 * ArchMageTCUnstable[5, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GlacialChainUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(ArchMageTCCore, "ChainLightning")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "ChainLightning"))
info <- c(185 + 3 * ArchMageTCSpec$SkillLv, 11 * ArchMageTCUnstable[7, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainLightningUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Blizard")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "Blizard"))
info <- c(301 + 3 * ArchMageTCSpec$SkillLv, 12 * ArchMageTCUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(ArchMageTCCore, "FrozenOrb")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "FrozenOrb"))
info <- c(220, 1 * ArchMageTCUnstable[9, 3], 0, 210, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FrozenOrbUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "LightningSpear")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "LightningSpear"))
info <- c(78, 15 * ArchMageTCUnstable[12, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearEndUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Blizard")>=40, 20, 0), ArchMageTCBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(ArchMageTCCore, "Blizard"))
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, BlizardFinalATKProb, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableBlizardFA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Blizard")>=40, 20, 0), ArchMageTCBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(ArchMageTCCore, "Blizard"))
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, (0.6 + 0.02 * ArchMageTCSpec$SkillLv) * ArchMageTCUnstable$Prob[9], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableBlizardFAOrb <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizePre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, sum(ArchMageTCUnstable$Prob * ArchMageTCUnstable$Delay), NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizeEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 1200, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAuraDummy <- rbind(data.frame(option, value), info)}

ArchMageTCATK <- Attack(list(ChainLightning=ChainLightning, LightningSpearLoop=LightningSpearLoop, LightningSpearEnd=LightningSpearEnd, FrozenOrb=FrozenOrb, Blizard=Blizard, BlizardFA=BlizardFA, 
                             IceAge=IceAge, IceAgeFloor=IceAgeFloor, ThunderBreak=ThunderBreak, ThunderBreak2=ThunderBreak2, ThunderBreak3=ThunderBreak3, ThunderBreak4=ThunderBreak4, 
                             ThunderBreak5=ThunderBreak5, ThunderBreak6=ThunderBreak6, ThunderBreak7=ThunderBreak7, ThunderBreak8=ThunderBreak8, JupiterThunder=JupiterThunder, 
                             EnergyBoltUnstable=EnergyBoltUnstable, ColdBeamUnstable=ColdBeamUnstable, ThunderBoltUnstable=ThunderBoltUnstable, 
                             IceStrikeUnstable=IceStrikeUnstable, GlacialChainUnstable=GlacialChainUnstable, ChainLightningUnstable=ChainLightningUnstable, BlizardUnstable=BlizardUnstable, 
                             FrozenOrbUnstable=FrozenOrbUnstable, LightningSpearEndUnstable=LightningSpearEndUnstable, UnstableBlizardFA=UnstableBlizardFA, UnstableBlizardFAOrb=UnstableBlizardFAOrb, 
                             UnstableMemorizePre=UnstableMemorizePre, UnstableMemorizeEnd=UnstableMemorizeEnd, IceAuraDummy=IceAuraDummy, SpiderInMirror=SpiderInMirror))


## ArchMageTC - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "Elquines")>=40, 20, 0), 2 * GetCoreLv(ArchMageTCCore, "Elquines"))
info <- c(127 + 2 * ArchMageTCSpec$SkillLv, 3, 600, 3030, 260 + 5 * ArchMageTCSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Elquines <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(ArchMageTCCore, "ThunderStorm")>=40, 20, 0), 3 * GetCoreLv(ArchMageTCCore, "ThunderStorm"))
info <- c(430, 1, 900, 1800, 90, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ThunderStorm <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(850 + 34 * GetCoreLv(ArchMageTCCore, "SpiritofSnow"), 9, 720, 3030, 30, 120, T, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiritofSnow <- rbind(data.frame(option, value), info)}

ArchMageTCSummoned <- Summoned(list(Elquines=Elquines, ThunderStorm=ThunderStorm, SpiritofSnow=SpiritofSnow, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, 
                                    SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## ArchMageTC - DealCycle and Deal Calculation
ATKFinal <- data.frame(ArchMageTCATK)
ATKFinal$Delay[c(-2, -29, -30)] <- Delay(ATKFinal$Delay, ArchMageTCSpec$ATKSpeed)[c(-2, -29, -30)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)

BuffFinal <- data.frame(ArchMageTCBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchMageTCSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ArchMageTCSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArchMageTCSpec$SummonedDuration / 100, 0)


## ArchMageTC - DealCycle
DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
ArchMageTCDealCycle <- t(rep(0, length(DealCycle)))
colnames(ArchMageTCDealCycle) <- DealCycle
ArchMageTCDealCycle <- data.frame(ArchMageTCDealCycle)
DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
ArchMageTCDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(ArchMageTCDealCycle2) <- DealCycle
ArchMageTCDealCycle2 <- data.frame(ArchMageTCDealCycle2)

TCInfinityCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCATK(DealCycle, c("IceAuraDummy"), ATKFinal)
  DealCycle <- DCBuff(DealCycle, c("MagicBooster", "Meditation", "ElementalReset", "MapleSoldier", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCSummoned(DealCycle, "Elquines", SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, "ThunderStorm", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  Restraint4 <- c(15)
  LightningSpearLoop <- c(5, 65.6)
  IceAge <- c(15, 72.6)
  JupiterThunderFDR <- c(11)
  ThunderBreak <- c(10, 48.6, 87.2)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  ThunderStorm <- c(30)
  SpiritofSnow <- c(30)
  SpiderInMirror <- c(50)
  
  skills <- list(Restraint4=Restraint4, LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, MapleWarriors2=MapleWarriors2, 
                 SoulContractLink=SoulContractLink, ThunderStorm=ThunderStorm, SpiritofSnow=SpiritofSnow, SpiderInMirror=SpiderInMirror)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          if(sum(skilllist[[p]][j]==c("LightningSpearLoop", "ThunderBreak"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
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
          if(sum(skilllist[[p]][j]==c("JupiterThunderFDR"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)]=="JupiterThunderFDR") {
            DealCycle <- DCATK(DealCycle, "JupiterThunder", ATKFinal)
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
        }
      }
      p <- p + 1
    }
    if(DealCycle$BlizardBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Blizard", ATKFinal)
      DealCycle$BlizardBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="BlizardBuff")$Duration * 1000
    } else {
      DealCycle <- DCATK(DealCycle, "ChainLightning", ATKFinal)
    }
  }
  return(DealCycle)
}
TCUnsCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, "EpicAdventure", BuffFinal)
  
  UnsCool <- subset(ATKFinal, rownames(ATKFinal)=="UnstableMemorizePre")$CoolTime * 1000
  UnsRemain <- 0
  
  InfTime <- subset(DealCycle, DealCycle$Skills=="Infinity")$Time + subset(BuffFinal, rownames(BuffFinal)=="Infinity")$CoolTime * 1000
  TBTime <- max(subset(DealCycle, DealCycle$Skills=="ThunderBreak")$Time) + subset(ATKFinal, rownames(ATKFinal)=="ThunderBreak")$CoolTime * 1000
  TBDummy <- 0
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < InfTime) {
    if(UnsRemain==0) {
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizePre"), ATKFinal)
      UnsRemain <- UnsCool - DealCycle$Time[1]
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizeEnd"), ATKFinal)
      UnsRemain <- UnsRemain - DealCycle$Time[1]
      if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] > TBTime & TBDummy == 0) {
        DealCycle <- DCATK(DealCycle, c("FrozenOrb"), ATKFinal)
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        DealCycle <- DCATK(DealCycle, c("ThunderBreak"), ATKFinal)
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        TBDummy <- 1
      }
    } else if(DealCycle$BlizardBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Blizard", ATKFinal)
      DealCycle$BlizardBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="BlizardBuff")$Duration * 1000
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, c("ChainLightning"), ATKFinal)
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
TCInfinityCycle2 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("Infinity", "EpicAdventure"), BuffFinal)
  DealCycle <- DCSummoned(DealCycle, "ThunderStorm", SummonedFinal)

  LightningSpearLoop <- c(5, 65.6)
  IceAge <- c(15, 72.6)
  JupiterThunderFDR <- c(11)
  ThunderBreak <- c(10, 48.6, 87.2)
  SoulContractLink <- c(31)
  ThunderStorm <- c(30)
  SpiritofSnow <- c(30)
  
  skills <- list(LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, 
                 SoulContractLink=SoulContractLink, ThunderStorm=ThunderStorm, SpiritofSnow=SpiritofSnow)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          if(sum(skilllist[[p]][j]==c("LightningSpearLoop", "ThunderBreak"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
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
          if(sum(skilllist[[p]][j]==c("JupiterThunderFDR"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)]=="JupiterThunderFDR") {
            DealCycle <- DCATK(DealCycle, "JupiterThunder", ATKFinal)
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
        }
      }
      p <- p + 1
    }
    if(DealCycle$BlizardBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Blizard", ATKFinal)
      DealCycle$BlizardBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="BlizardBuff")$Duration * 1000
    } else {
      DealCycle <- DCATK(DealCycle, "ChainLightning", ATKFinal)
    }
  }
  return(DealCycle)
}
TCInfinityCycle3 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCATK(DealCycle, c("IceAuraDummy"), ATKFinal)
  DealCycle <- DCBuff(DealCycle, c("EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCSummoned(DealCycle, "Elquines", SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, "ThunderStorm", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  Restraint4 <- c(15)
  LightningSpearLoop <- c(5, 65.6)
  IceAge <- c(15, 72.6)
  JupiterThunderFDR <- c(11)
  ThunderBreak <- c(10, 48.6, 87.2)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  ThunderStorm <- c(30)
  SpiritofSnow <- c(30)
  
  skills <- list(Restraint4=Restraint4, LightningSpearLoop=LightningSpearLoop, IceAge=IceAge, JupiterThunderFDR=JupiterThunderFDR, ThunderBreak=ThunderBreak, MapleWarriors2=MapleWarriors2, 
                 SoulContractLink=SoulContractLink, ThunderStorm=ThunderStorm, SpiritofSnow=SpiritofSnow)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          if(sum(skilllist[[p]][j]==c("LightningSpearLoop", "ThunderBreak"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
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
          if(sum(skilllist[[p]][j]==c("JupiterThunderFDR"))==1) {
            if(nrow(subset(DealCycle, DealCycle$Skills=="FrozenOrb"))==0) {
              OrbRemain <- 0
            } else {
              OrbRemain <- max(0, OrbCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="FrozenOrb")$Time)))
            }
            if(OrbRemain == 0) {
              DealCycle <- DCATK(DealCycle, "FrozenOrb", ATKFinal)
            }
          }
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)]=="JupiterThunderFDR") {
            DealCycle <- DCATK(DealCycle, "JupiterThunder", ATKFinal)
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
        }
      }
      p <- p + 1
    }
    if(DealCycle$BlizardBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Blizard", ATKFinal)
      DealCycle$BlizardBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="BlizardBuff")$Duration * 1000
    } else {
      DealCycle <- DCATK(DealCycle, "ChainLightning", ATKFinal)
    }
  }
  return(DealCycle)
}
TCAddATKCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, ThunderBreakHits=8, Unstable, ArchMageTCSpec) {
  ## Unstable Memorize Skills
  UnsSkills <- rownames(ATKFinal)[18:26]
  DC <- DealCycle[DealCycle$Skills=="UnstableMemorizeEnd", ]
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1, DC1)
    DC1[2:10, 1] <- UnsSkills
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Rep ATKs (Lightning Spear, Jupiter Thunder, Ice Age, Frozen Orb, Ice Aura Dummy)
  DealCycle <- RepATKCycle(DealCycle, "LightningSpearLoop", 14, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JupiterThunder", 30, 870, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "IceAgeFloor", 18, 800, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FrozenOrb", 19, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FrozenOrbUnstable", 19, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "IceAuraDummy", 300, 0, ATKFinal)
  
  ## Summoned Skills (Thunder Storm, Elquines, Spirit of Snow)
  DealCycle <- DCSummonedATKs(DealCycle, "ThunderStorm", SummonedFinal)
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
                                  "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", "JupiterThunder")) > 0 & DealCycle$BlizardBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("BlizardFA")
    } else if(sum(DealCycle$Skills[i]==c("UnstableMemorizeEnd")) > 0 & DealCycle$BlizardBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("UnstableBlizardFA")
    } else if(sum(DealCycle$Skills[i]==c("FrozenOrbUnstable")) > 0 & DealCycle$BlizardBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("UnstableBlizardFAOrb")
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
                                                                       "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", 
                                                                       "ThunderBoltUnstable", "ChainLightningUnstable", "LightningSpearEndUnstable")) > 0) {
      DealCycle$JupiterThunderFDR[i] <- 1
    } else {
      DealCycle$JupiterThunderFDR[i] <- 0
    }
  }
  
  ## Frost Effect Stack & Extreme Magic
  JTStack <- 0
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FrozenOrb", "Blizard", "IceAge", "IceAgeFloor", "Elquines", "IceAuraDummy")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + 1)
    } else if(sum(DealCycle$Skills[i]==c("BlizardFA")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + (0.6 + 0.02 * ArchMageTCSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("UnstableMemorizeEnd")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + sum(Unstable$Prob[c(2, 4, 5, 8)]) - sum(Unstable$Prob[c(3, 7, 12)]))
    } else if(sum(DealCycle$Skills[i]==c("SpiritofSnow")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + 3)
    } else if(sum(DealCycle$Skills[i]==c("FrozenOrbUnstable")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + Unstable$Prob[9])
    } else if(sum(DealCycle$Skills[i]==c("UnstableBlizardFAOrb")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + Unstable$Prob[9] * (0.6 + 0.02 * ArchMageTCSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("UnstableBlizardFA")) > 0) {
      DealCycle$FrostEffectStack[i] <- min(5, DealCycle$FrostEffectStack[i-1] + sum(Unstable$Prob[c(1, 2, 3, 4, 5, 7, 12)]) * (0.6 + 0.02 * ArchMageTCSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "ThunderBreak", "ThunderBreak2", "ThunderBreak3", 
                                         "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8")) > 0) {
      DealCycle$FrostEffectStackCalc[i] <- DealCycle$FrostEffectStack[i-1]
      DealCycle$FrostEffectStack[i] <- max(0, DealCycle$FrostEffectStack[i-1] - 1)
    } else if(sum(DealCycle$Skills[i]==c("ThunderBoltUnstable", "ChainLightningUnstable", "LightningSpearEndUnstable", "ThunderStorm")) > 0) {
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
  DealCycle$FrostEffectStack <- 0
  DealCycle$FrostEffectStackBDR <- DealCycle$FrostEffectStackCalc * 12
  DealCycle$FrostEffectStackCDMR <- DealCycle$FrostEffectStackCalc * 3
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ChainLightning", "LightningSpearLoop", "LightningSpearEnd", "FrozenOrb", "Blizard", "IceAge", "ThunderBreak", "ThunderBreak2", 
                                  "ThunderBreak3", "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8", "JupiterThunder", 
                                  "EnergyBoltUnstable", "ColdBeamUnstable", "ThunderBoltUnstable", "IceStrikeUnstable", "GlacialChainUnstable", "ChainLightningUnstable", 
                                  "BlizardUnstable", "FrozenOrbUnstable", "LightningSpearEndUnstable")) > 0) {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  return(DealCycle)
}

ArchMageTCDealCycle <- TCInfinityCycle(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycle <- TCUnsCycle(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycle <- TCInfinityCycle2(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycle <- DealCycleFinal(ArchMageTCDealCycle)
ArchMageTCDealCycle2 <- TCInfinityCycle3(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycle2 <- TCUnsCycle(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycle2 <- DealCycleFinal(ArchMageTCDealCycle2)

TCUnsdata <- UnstableData(ArchMageTCDealCycle, ArchMageTCDealCycle2, ArchMageTCUnstable[10, 3], BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration, BuffFinal[rownames(BuffFinal)=="Infinity", ]$CoolTime)

ArchMageTCDealCycle <- TCAddATKCycle(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal, 8, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycle <- BishopInfinity(ArchMageTCDealCycle, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)

ArchMageTCDealCycle2 <- TCAddATKCycle(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, 8, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycle2 <- BishopInfinity(ArchMageTCDealCycle2, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)

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
  ArchMageTCSpecOpt1 <- InfinityOptimization1(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpec, ArchMageTCUnionRemained, TCUnsdata, 
                                              NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
  PotentialOpt[[Idx1]][Idx2, ] <- ArchMageTCSpecOpt1[1, 1:3]
} else {
  ArchMageTCSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ArchMageTCSpecOpt <- OptDataAdd(ArchMageTCSpec, ArchMageTCSpecOpt1, "Potential", ArchMageTCBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ArchMageTCSpecOpt2 <- InfinityOptimization2(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, ArchMageTCHyperStatBase, ArchMageTCBase$ChrLv, ArchMageTCBase$CRROver, TCUnsdata, 
                                              NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ArchMageTCSpecOpt2[1, ]
} else {
  ArchMageTCSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ArchMageTCSpecOpt <- OptDataAdd(ArchMageTCSpecOpt, ArchMageTCSpecOpt2, "HyperStat", ArchMageTCBase$CRROver, DemonAvenger=F)
BuffFinal <- PrayFDRAdj(ArchMageTCSpec, ArchMageTCSpecOpt, BuffFinal)

ArchMageTCFinalDPM <- InfinityDealCalc(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, TCUnsdata, 
                                       NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
ArchMageTCFinalDPMwithMax <- InfinityDealCalcWithMaxDMR(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, TCUnsdata, 
                                                        NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))

set(get(DPMCalcOption$DataName), as.integer(1), "ArchMageTC", sum(na.omit(ArchMageTCFinalDPMwithMax)) / (TCUnsdata$DealCycleTime * 1000 / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "ArchMageTC", sum(na.omit(ArchMageTCFinalDPM)) / (TCUnsdata$DealCycleTime * 1000 / 60000) - sum(na.omit(ArchMageTCFinalDPMwithMax)) / (TCUnsdata$DealCycleTime * 1000 / 60000))

ArchMageTCDealData <- data.frame(ArchMageTCDealCycle$Skills, ArchMageTCDealCycle$Time, ArchMageTCDealCycle$Restraint4, 
                                 DealCalcWithMaxDMR(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                    NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")))
colnames(ArchMageTCDealData) <- c("Skills", "Time", "R4", "Deal")
ArchMageTCDealRatio <- InfinityDealRatio(ArchMageTCDealCycle, ArchMageTCDealCycle2, 
                                         DealCalcWithMaxDMR(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                            NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")), 
                                         DealCalcWithMaxDMR(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                            NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")), TCUnsdata)

set(get(DPMCalcOption$DataName), as.integer(3), "ArchMageTC", Deal_RR(ArchMageTCDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "ArchMageTC", Deal_40s(ArchMageTCDealData, F, NA, FinishTime=subset(ArchMageTCDealData, ArchMageTCDealData$Skills=="Restraint4")$Time[1] + 15000))


## ThunderBreak 2Hits
## ArchMageTC - DealCycle
DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
ArchMageTCDealCycleTB <- t(rep(0, length(DealCycle)))
colnames(ArchMageTCDealCycleTB) <- DealCycle
ArchMageTCDealCycleTB <- data.frame(ArchMageTCDealCycleTB)

ArchMageTCDealCycleTB <- TCInfinityCycle(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycleTB <- TCUnsCycle(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycleTB <- TCInfinityCycle2(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycleTB <- DealCycleFinal(ArchMageTCDealCycleTB)
ArchMageTCDealCycleTB <- TCAddATKCycle(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal, 2, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycleTB <- BishopInfinity(ArchMageTCDealCycleTB, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)

DealCycle <- c("Skills", "Time", rownames(ArchMageTCBuff))
ArchMageTCDealCycleTB2 <- t(rep(0, length(DealCycle)))
colnames(ArchMageTCDealCycleTB2) <- DealCycle
ArchMageTCDealCycleTB2 <- data.frame(ArchMageTCDealCycleTB2)

ArchMageTCDealCycleTB2 <- TCInfinityCycle3(ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycleTB2 <- TCUnsCycle(ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageTCDealCycleTB2 <- DealCycleFinal(ArchMageTCDealCycleTB2)
ArchMageTCDealCycleTB2 <- TCAddATKCycle(ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal, 2, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycleTB2 <- BishopInfinity(ArchMageTCDealCycleTB2, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)

ArchMageTCFinalDPM2 <- InfinityDealCalcWithMaxDMR(ArchMageTCDealCycleTB, ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, TCUnsdata, 
                                                  NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR"))
TCTB2Hits <- sum(na.omit(ArchMageTCFinalDPM2)) / (TCUnsdata$DealCycleTime * 1000 / 60000)

ArchMageTCDealData2 <- data.frame(ArchMageTCDealCycleTB$Skills, ArchMageTCDealCycleTB$Time, ArchMageTCDealCycleTB$Restraint4, 
                                 DealCalcWithMaxDMR(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, 
                                                    NotBuffCols=c("InfinityFDR", "FrostEffectStackCalc", "FrostEffectStackBDR", "FrostEffectStackCDMR"), NotBuffColOption=c("FDR", "IGR", "BDR", "CDMR")))
colnames(ArchMageTCDealData2) <- c("Skills", "Time", "R4", "Deal")

TCTB2HitR4 <- Deal_RR(ArchMageTCDealData2)
TCTB2Hit40s <- Deal_40s(ArchMageTCDealData2, F, NA, FinishTime=subset(ArchMageTCDealData2, ArchMageTCDealData2$Skills=="Restraint4")$Time[1] + 15000)

print(data.frame(ThunderBreak2HitsDPM=TCTB2Hits, ThunderBreak2HitsRR=TCTB2HitR4, ThunderBreak2Hits40s=TCTB2Hit40s))