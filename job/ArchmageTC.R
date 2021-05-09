## ArchMageTC - Data
## ArchMageTC - VMatrix
ArchMageTCCore <- MatrixSet(PasSkills=c("ChainLightning", "LightningSpear", "FrozenOrb", "Elquines", "Blizard", "ThunderStorm"), 
                            PasLvs=c(50, 50, 50, 50, 50, 50), 
                            PasMP=c(10, 10, 10, 10, 10, 10), 
                            ActSkills=c("IceAge", "ThunderBreak", "SpiritofSnow", "JupiterThunder", 
                                        CommonV("Wizard", "Adventure")), 
                            ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                            ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                            BlinkLv=1, 
                            BlinkMP=0, 
                            UsefulSkills=c("SharpEyes", "CombatOrders", "WindBooster"), 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=SpecDefault, 
                            SelfBind=F)


## ArchMageTC - Basic Info
## Link Check Needed
ArchMageTCBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=MobDefault,
                          SpecSet=SpecDefault, 
                          Job="ArchMageTC",
                          CoreData=ArchMageTCCore, 
                          BuffDurationNeeded=310, 
                          AbilList=c("BuffDuration", "DisorderBDR"), 
                          LinkList=c("Zero", "Mikhail", "DemonAvenger", "Phantom"), 
                          MonsterLife=MLTypeI21, 
                          Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", SpecDefault$WeaponType)[, 1:16],
                          WeaponType=SpecDefault$WeaponType, 
                          SubWeapon=SubWeapon[5, ], 
                          Emblem=Emblem[1, ],
                          CoolReduceHat=F)


## ArchMageTC - Passive
{option <- factor(c("CRR"), levels=PSkill)
value <- c(5)
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
value <- c(70)
ElquinesPassive <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * ArchMageTCBase$PSkillLv, 50 + 5 * ArchMageTCBase$PSkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(ArchmageTCBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(ArchMageTCCore[[2]][7, 2])
UnstableMemorizePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(ArchMageTCCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

ArchMageTCPassive <- Passive(list(MPIncrease=MPIncrease, SpellMastery=SpellMastery, HighWisdom=HighWisdom, ElementalResetPassive=ElementalResetPassive, 
                                  MagicCritical=MagicCritical, ElementAmplification=ElementAmplification, ElquinesPassive=ElquinesPassive, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, 
                                  UnstableMemorizePassive=UnstableMemorizePassive, BlinkPassive=BlinkPassive))


## ArchMageTC - Buff
## FrostEffect, ExtremeMagic, FrozenBreak, OverloadMana
{option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(240, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Meditation <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(240, NA, 990, T, NA, NA, T)
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

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * ArchMageTCCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ArchMageTCCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ArchMageTCCore[[3]][3, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(ArchMageTCCore[[2]][5, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * ArchMageTCCore[[2]][8, 2]) * MapleSoldier[1, 2]) * ArchMageTCBase$MainStatP), 5 + floor(ArchMageTCCore[[2]][8, 2]/2))
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

ArchMageTCBuff <- Buff(list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, BlizardBuff=BlizardBuff, Infinity=Infinity, MapleSoldier=MapleSoldier, 
                            FrostEffectStack=FrostEffectStack, FrostEffectStackCalc=FrostEffectStackCalc, ExtremeMagic=ExtremeMagic, 
                            EpicAdventure=EpicAdventure, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulWindBooster=UsefulWindBooster, 
                            OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, JupiterThunderFDR=JupiterThunderFDR, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, UsefulWindBooster
ArchMageTCAllTimeBuff <- AllTimeBuff(ArchMageTCBuff)


## ArchMageTC - Union & HyperStat & SoulWeapon
ArchMageTCSpec <- JobSpec(JobBase=ArchMageTCBase, 
                          Passive=ArchMageTCPassive, 
                          AllTimeBuff=ArchMageTCAllTimeBuff, 
                          MobInfo=MobDefault, 
                          SpecSet=SpecDefault, 
                          WeaponName="Wand", 
                          UnionStance=0, 
                          JobConstant=1.2)

ArchMageTCUnionRemained <- ArchMageTCSpec$UnionRemained
ArchMageTCHyperStatBase <- ArchMageTCSpec$HyperStatBase
ArchMageTCCoolReduceType <- ArchMageTCSpec$CoolReduceType
ArchMageTCSpec <- ArchMageTCSpec$Spec


## ArchMageTC - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * ArchMageTCCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * ArchMageTCCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageTCCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageTCCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageTCCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageTCCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


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
value <- c(20, ifelse(ArchMageTCCore[[1]][1, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][1, 2])
info <- c(185 + 3 * ArchMageTCSpec$SkillLv, 11, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainLightning <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][2, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][2, 2])
info <- c(150, 15, 3600, 270, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearLoop <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][2, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][2, 2])
info <- c(780, 15, 1080, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearEnd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(ArchMageTCCore[[1]][3, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][3, 2])
info <- c(220, 1, 900, 210, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FrozenOrb <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
info <- c(301 + 3 * ArchMageTCSpec$SkillLv, 12, 900, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blizard <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, 0.6 + 0.02 * ArchMageTCSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardFA <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(500 + 20 * ArchMageTCCore[[2]][1, 2], 10, 0, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAge <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(125 + 5 * ArchMageTCCore[[2]][1, 2], 3, 870, 800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IceAgeFloor <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 0), 12, 660, 210, 40, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 1), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 2), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 3), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak4 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 4), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak5 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 5), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak6 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 6), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak7 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((800 + 32 * ArchMageTCCore[[2]][2, 2]) * (0.8 ^ 7), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThunderBreak8 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(300 + 12 * ArchMageTCCore[[2]][4, 2], 8, 810, 330, 120, T, F, F)
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
info <- c(383, 3 * ArchMageTCUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GlacialChainUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(ArchMageTCCore[[1]][1, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][1, 2])
info <- c(185 + 3 * ArchMageTCSpec$SkillLv, 11 * ArchMageTCUnstable[7, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainLightningUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
info <- c(301 + 3 * ArchMageTCSpec$SkillLv, 12 * ArchMageTCUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(ArchMageTCCore[[1]][3, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][3, 2])
info <- c(220, 1 * ArchMageTCUnstable[9, 3], 0, 210, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FrozenOrbUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][2, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][2, 2])
info <- c(78, 15 * ArchMageTCUnstable[12, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearEndUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
info <- c(220 + 4 * ArchMageTCSpec$SkillLv, BlizardFinalATKProb, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableBlizardFA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
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
value <- c(ifelse(ArchMageTCCore[[1]][4, 2]>=40, 20, 0), 2 * ArchMageTCCore[[1]][4, 2])
info <- c(127 + 2 * ArchMageTCSpec$SkillLv, 3, 600, 3030, 260 + 5 * ArchMageTCSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Elquines <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(ArchMageTCCore[[1]][6, 2]>=40, 20, 0), 3 * ArchMageTCCore[[1]][6, 2])
info <- c(430, 1, 900, 1800, 90, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ThunderStorm <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(850 + 34 * ArchMageTCCore[[2]][2, 2], 9, 720, 3030, 30, 120, T, T, F, F)
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
  ifelse(BuffFinal$ServerLag==T, 3, 0)

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
  DealCycle <- DCBuff(DealCycle, c("MagicBooster", "Meditation", "ElementalReset", "MapleSoldier", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster"), BuffFinal)
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
  DealCycle <- DCBuff(DealCycle, c("EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster"), BuffFinal)
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

Unsdata <- UnstableData(ArchMageTCDealCycle, ArchMageTCDealCycle2, ArchMageTCUnstable[10, 3], BuffFinal$Duration[5], BuffFinal$CoolTime[5])

ArchMageTCBuff <- Buff(list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, BlizardBuff=BlizardBuff, Infinity=Infinity, MapleSoldier=MapleSoldier, 
                            FrostEffectStack=FrostEffectStack, FrostEffectStackCalc=FrostEffectStackCalc, ExtremeMagic=ExtremeMagic, 
                            EpicAdventure=EpicAdventure, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulWindBooster=UsefulWindBooster,
                            OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, JupiterThunderFDR=JupiterThunderFDR, Restraint4=Restraint4, SoulContractLink=SoulContractLink))

BuffFinal <- data.frame(ArchMageTCBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchMageTCSpec$CoolReduceP, ArchMageTCSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchMageTCSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

ArchMageTCDealCycle <- TCAddATKCycle(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal, 8, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycle <- BishopInfinity(ArchMageTCDealCycle, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)

ArchMageTCDealCycle2 <- TCAddATKCycle(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, 8, ArchMageTCUnstable, ArchMageTCSpec)
ArchMageTCDealCycle2 <- BishopInfinity(ArchMageTCDealCycle2, 6000, 70 + ArchMageTCSpec$SkillLv, General$General$Serverlag)


## ArchMageTC Deal Calc
TCDealCalc(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpec, Unsdata)
TCDealCalcWithMaxDMR(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpec, Unsdata)

ArchMageTCSpecOpt1 <- TCOptimization1(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpec, ArchMageTCUnionRemained, Unsdata)
ArchMageTCSpecOpt <- ArchMageTCSpec
ArchMageTCSpecOpt$ATKP <- ArchMageTCSpecOpt$ATKP + ArchMageTCSpecOpt1$ATKP
ArchMageTCSpecOpt$BDR <- ArchMageTCSpecOpt$BDR + ArchMageTCSpecOpt1$BDR
ArchMageTCSpecOpt$IGR <- IGRCalc(c(ArchMageTCSpecOpt$IGR, ArchMageTCSpecOpt1$IGR))

ArchMageTCSpecOpt2 <- TCOptimization2(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt, ArchMageTCHyperStatBase, ArchMageTCBase$ChrLv, ArchMageTCBase$CRROver, Unsdata)
ArchMageTCFinalDPM <- TCDealCalc(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2, Unsdata)
ArchMageTCFinalDPMwithMax <- TCDealCalcWithMaxDMR(ArchMageTCDealCycle, ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2, Unsdata)

DPM12347$ArchMageTC[1] <- sum(na.omit(ArchMageTCFinalDPMwithMax)) / (Unsdata$DealCycleTime * 1000 / 60000)
DPM12347$ArchMageTC[2] <- sum(na.omit(ArchMageTCFinalDPM)) / (Unsdata$DealCycleTime * 1000 / 60000) - sum(na.omit(ArchMageTCFinalDPMwithMax)) / (Unsdata$DealCycleTime * 1000 / 60000)

ArchMageTCDamage <- TCDealCalcGeneral(ArchMageTCDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2)
ArchMageTC40s <- data.frame(ArchMageTCDealCycle$Skills, ArchMageTCDealCycle$Time, ArchMageTCDealCycle$Restraint4, ArchMageTCDealCycle$Infinity, ArchMageTCDealCycle$InfinityFDR, ArchMageTCDamage)
colnames(ArchMageTC40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")
subset(ArchMageTC40s, ArchMageTC40s$RR4>0)

DPM12347$ArchMageTC[3] <- sum(ArchMageTC40s$Damage[732:1011])
DPM12347$ArchMageTC[4] <- sum(ArchMageTC40s$Damage[591:1011])

ArchMageTCDamage2 <- TCDealCalcGeneral(ArchMageTCDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2)

ArchMageTCDealRatio <- TCDealRatio(ArchMageTCDealCycle, ArchMageTCDealCycle2, ArchMageTCDamage, ArchMageTCDamage2, UnsData)



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

ArchMageTCFinalDPM2 <- TCDealCalc(ArchMageTCDealCycleTB, ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2, Unsdata)
ArchMageTCFinalDPMwithMax2 <- TCDealCalcWithMaxDMR(ArchMageTCDealCycleTB, ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2, Unsdata)

TCTB2Hits <- sum(na.omit(ArchMageTCFinalDPMwithMax2)) / (Unsdata$DealCycleTime * 1000 / 60000)
TCTB2HitDamage <- TCDealCalcGeneral(ArchMageTCDealCycleTB, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2)
TCTB2HitDamage2 <- TCDealCalcGeneral(ArchMageTCDealCycleTB2, ATKFinal, BuffFinal, SummonedFinal, ArchMageTCSpecOpt2)
TBTB2HitsDealRatio <- TCDealRatio(ArchMageTCDealCycleTB, ArchMageTCDealCycleTB2, TCTB2HitDamage, TCTB2HitDamage2, UnsData)

TCTB2Hit40s <- data.frame(ArchMageTCDealCycleTB$Skills, ArchMageTCDealCycleTB$Time, ArchMageTCDealCycleTB$Restraint4, ArchMageTCDealCycleTB$Infinity, ArchMageTCDealCycleTB$InfinityFDR, TCTB2HitDamage)
colnames(TCTB2Hit40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")
subset(TCTB2Hit40s, TCTB2Hit40s$RR4>0)

TCTB2HitR4 <- sum(TCTB2Hit40s$Damage[708:975])
TCTB2Hit40s <- sum(TCTB2Hit40s$Damage[567:975])