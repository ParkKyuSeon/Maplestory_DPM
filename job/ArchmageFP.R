## ArchmageFP - Data
## ArchmageFP - VMatrix
ArchMageFPCore <- MatrixSet(PasSkills=c("Paralyze", "FlameHaze", "MistEruption", "FireAura", "Meteor", "Ignite", "MegiddoFlame", "Ifrit", "TeleportMastery"), 
                            PasLvs=c(50, 50, 50, 50, 50, 50, 25, 25, 25), 
                            PasMP=c(10, 10, 10, 10, 10, 10, 0, 0, 0), 
                            ActSkills=c("DotPunisher", "PoisonNova", "FuryofIfrit", "PosionChain",
                                        CommonV("Wizard", "Adventure")), 
                            ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                            ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                            BlinkLv=1, 
                            BlinkMP=0, 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=SpecDefault,
                            SelfBind=F)


## ArchmageFP - Basic Info
## Link Check Needed
ArchMageFPBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=MobDefault,
                          SpecSet=SpecDefault, 
                          Job="ArchMageFP",
                          CoreData=ArchMageFPCore, 
                          BuffDurationNeeded=310, 
                          AbilList=c("BuffDuration", "DisorderBDR"), 
                          LinkList=c("Zero", "Mikhail", "DemonAvenger", "Phantom"), 
                          MonsterLife=MLTypeI21, 
                          Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", SpecDefault$WeaponType)[, 1:16],
                          WeaponType=SpecDefault$WeaponType, 
                          SubWeapon=SubWeapon[5, ], 
                          Emblem=Emblem[1, ],
                          CoolReduceHat=T)


## ArchMageFP - Passive
{option <- factor(c("CRR", "ATKSpeed"), levels=PSkill)
value <- c(5, 1)
MPIncrease <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(40)
ElementalReset <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(50)
ElementAmplification <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(20)
ExtremeMagic <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(25)
FerventDrain <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * ArchMageFPBase$SkillLv, 50 + 5 * ArchMageFPBase$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(ArchMageFPBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70 + ceiling(ArchMageFPBase$SkillLv/2))
Ifrit <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(ArchMageFPCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only

option <- factor(c("MainStat"), levels=PSkill)
value <- c(ArchMageFPCore[[2]][7, 2])
UnstableMemorize <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(ArchMageFPCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

ArchMageFPPassive <- Passive(list(MPIncrease=MPIncrease, HighWisdom=HighWisdom, SpellMastery=SpellMastery, ElementalReset=ElementalReset, ElementAmplification=ElementAmplification, 
                                  MagicCritical=MagicCritical, ExtremeMagic=ExtremeMagic, FerventDrain=FerventDrain, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, 
                                  Ifrit=Ifrit, UnstableMemorize=UnstableMemorize, BlinkPassive=BlinkPassive))


## ArchMageFP - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(240, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Meditation <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(240, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalReset <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(Cooldown(45, T, ArchMageFPBase$UnionChrs$CoolReduceP, ArchMageFPBase$CoolReduce), Cooldown(45, T, ArchMageFPBase$UnionChrs$CoolReduceP, ArchMageFPBase$CoolReduce), 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MeteorBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + ArchMageFPBase$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ArchMageFPBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ArchMageFPBase$SkillLv/2))))
info <- c(900 + 30 * ArchMageFPBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(2400, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FireAura <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * ArchMageFPCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ArchMageFPCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * ArchMageFPCore[[2]][7, 2]) * MapleSoldier[1, 2]) * ArchMageFPBase$MainStatP), 5 + floor(ArchMageFPCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ArchMageFPBuff <- Buff(list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, MeteorBuff=MeteorBuff, Infinity=Infinity, 
                            MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, FireAura=FireAura, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                            MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, MagicBooster(990ms)
ArchMageFPAllTimeBuff <- AllTimeBuff(ArchMageFPBuff)


## ArchmageFP - Union & HyperStat & SoulWeapon
ArchMageFPSpec <- JobSpec(JobBase=ArchMageFPBase, 
                          Passive=ArchMageFPPassive, 
                          AllTimeBuff=ArchMageFPAllTimeBuff, 
                          MobInfo=MobDefault, 
                          SpecSet=SpecDefault, 
                          WeaponName="Wand", 
                          UnionStance=0, 
                          JobConstant=1.2)

ArchMageFPUnionRemained <- ArchMageFPSpec$UnionRemained
ArchMageFPHyperStatBase <- ArchMageFPSpec$HyperStatBase
ArchMageFPCoolReduceType <- ArchMageFPSpec$CoolReduceType
ArchMageFPSpec <- ArchMageFPSpec$Spec


## ArchMageFP - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * ArchMageFPCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * ArchMageFPCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageFPCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageFPCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageFPCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchMageFPCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## ArchMageFP - Unstable Memorize Data
Skills <- c("EnergyBolt", "FlameOrb", "PoisonBreath", "Explosion", "PosionMist", "UnstableFail", 
            "Paralyze", "MistEruption", "Meteor", "FlameHaze", "Infinity", "Ifrit", "MegiddoFlame", "EpicAdventure")
Ind <- c(1, 5, 5, 10, 10, 10, 25, 25, 25, 25, 25, 25, 25, 10)
Prob <- Ind/sum(Ind)
Delays <- c(Delay(810, 2), Delay(810, 2), Delay(800, 2), Delay(720, 2) + Delay(180, 2), Delay(1500, 2), Delay(990, 2), 
            Delay(780, 2), Delay(930, 2), Delay(900, 2), Delay(1440, 2), 600, 600, Delay(900, 2), 0)
ArchMageFPUnstable <- data.frame(Skills, Ind, Prob, Delays)
MeteorFinalATKProb <- sum(ArchMageFPUnstable$Prob[c(1, 2, 3, 4, 5, 7, 8, 9, 10, 13)]) * (0.6 + 0.02 * ArchMageFPSpec$SkillLv)
IgniteUnsProb <- (sum(ArchMageFPUnstable$Prob[c(2, 4, 7, 9, 10, 13)])) * 0.5



## ArchMageFP - Attacks
{option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(309, ArchMageFPUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(301, 2 * ArchMageFPUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameOrbUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(180, ArchMageFPUnstable[3, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonBreathUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(405, 2 * ArchMageFPUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExplosionUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(270, ArchMageFPUnstable[5, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonMistUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][1, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), 10, ifelse(ArchMageFPCore[[1]][1, 2]>=40, 20, 0))
info <- c(220 + 3 * ArchMageFPSpec$SkillLv, 8 * ArchMageFPUnstable[7, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ParalyzeUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][3, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), 10, IGRCalc(c(ifelse(ArchMageFPCore[[1]][3, 2]>=40, 20, 0), 20, 40 + ArchMageFPSpec$SkillLv)))
info <- c((125 + ArchMageFPSpec$SkillLv) * 2.25, 20 * ArchMageFPUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MistEruptionUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][5, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(315 + 3 * ArchMageFPSpec$SkillLv, 12 * ArchMageFPUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][2, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchMageFPCore[[1]][2, 2]>=40, 20, 0))
info <- c(202 + 3 * ArchMageFPSpec$SkillLv, 15 * ArchMageFPUnstable[10, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameHazeUnstable <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][7, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)))
info <- c(420, 15 * ArchMageFPUnstable[13, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlameUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][1, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), 10, ifelse(ArchMageFPCore[[1]][1, 2]>=40, 20, 0))
info <- c(220 + 3 * ArchMageFPSpec$SkillLv, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Paralyze <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][6, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), 10, IGRCalc(c(ifelse(ArchMageFPCore[[1]][3, 2]>=40, 20, 0), 20, 40 + ArchMageFPSpec$SkillLv)))
info <- c((125 + ArchMageFPSpec$SkillLv) * 2.25, 20, 930, NA, 8 * (1 - 0.5 - ArchMageFPSpec$CoolReduceP/100), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MistEruption <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][5, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(315 + 3 * ArchMageFPSpec$SkillLv, 12, 900, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Meteor <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchMageFPCore[[1]][5, 2], ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchMageFPSpec$SkillLv, 0.6 + 0.02 * ArchMageFPSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchMageFPCore[[1]][5, 2], ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchMageFPSpec$SkillLv, MeteorFinalATKProb, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchMageFPCore[[1]][5, 2], ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchMageFPSpec$SkillLv, ifelse(BossSize=="Scarecrow", 4, 12) * (0.6 + 0.02 * ArchMageFPSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackPoisonNova <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchMageFPCore[[1]][5, 2], ifelse(ArchMageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchMageFPSpec$SkillLv, 22 * (0.6 + 0.02 * ArchMageFPSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackDotPunisher <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][2, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchMageFPCore[[1]][2, 2]>=40, 20, 0))
info <- c(202 + 3 * ArchMageFPSpec$SkillLv, 15, 1440, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameHaze <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(3 * ArchMageFPCore[[1]][9, 2])
info <- c(272, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TeleportMastery <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(FDRCalc(c(2 * ArchMageFPCore[[1]][7, 2], floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)))
info <- c(420, 15, 900, NA, 50, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlame <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ignite <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, IgniteUnsProb * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, (ArchMageFPSpec$SkillLv * 0.02 + 0.6) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteMeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, MeteorFinalATKProb * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteUnstableFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 22 * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteDotPunisher <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 22 * (ArchMageFPSpec$SkillLv * 0.02 + 0.6) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteDotPunisherFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchMageFPCore[[1]][6, 2], ifelse(ArchMageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, (ifelse(BossSize=="Scarecrow", 4, 12) * (ArchMageFPSpec$SkillLv * 0.02 + 0.6)) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgnitePoisonNova <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR", "IGR"), levels=ASkill)
value <- c(-50, 2 * ArchMageFPCore[[1]][4, 2], ifelse(ArchMageFPCore[[1]][4, 2]>=40, 20, 0))
info <- c(400, 2, 0, 3000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FireAura <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(400 + 15 * ArchMageFPCore[[2]][1, 2], 5, 900, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisher1st <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c((400 + 15 * ArchMageFPCore[[2]][1, 2]) * 0.65, 5 * 21, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisherRemain <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(250 + 10 * ArchMageFPCore[[2]][2, 2], 12, 750, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaStart <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * ArchMageFPCore[[2]][2, 2], 36, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNova123 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c((225 + 9 * ArchMageFPCore[[2]][2, 2]) * 0.5, ifelse(BossSize=="Scarecrow", 12, 108), 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaRemain <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * ArchMageFPCore[[2]][3, 2], 6, 480, 180, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuryofIfrit <- rbind(data.frame(option, value), info) # FuryofIfrit StartDelay : 1560ms

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(250 + 10 * ArchMageFPCore[[2]][4, 2], 4, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 6 * ArchMageFPCore[[2]][4, 2], 6, 780, 1800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 1 * (30 + ArchMageFPCore[[2]][4, 2]) + 6 * ArchMageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 2 * (30 + ArchMageFPCore[[2]][4, 2]) + 6 * ArchMageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain3 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 3 * (30 + ArchMageFPCore[[2]][4, 2]) + 6 * ArchMageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain4 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 4 * (30 + ArchMageFPCore[[2]][4, 2]) + 6 * ArchMageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain5 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchMageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 5 * (30 + ArchMageFPCore[[2]][4, 2]) + 6 * ArchMageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainMax <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizePre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, sum(ArchMageFPUnstable$Prob * ArchMageFPUnstable$Delay), NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizeEnd <- rbind(data.frame(option, value), info)}

ArchMageFPATK <- Attack(list(EnergyBoltUnstable=EnergyBoltUnstable, FlameOrbUnstable=FlameOrbUnstable, PoisonBreathUnstable=PoisonBreathUnstable, ExplosionUnstable=ExplosionUnstable, 
                             PoisonMistUnstable=PoisonMistUnstable, ParalyzeUnstable=ParalyzeUnstable, MistEruptionUnstable=MistEruptionUnstable, MeteorUnstable=MeteorUnstable, 
                             FlameHazeUnstable=FlameHazeUnstable, MegiddoFlameUnstable=MegiddoFlameUnstable, TeleportMastery=TeleportMastery,
                             Paralyze=Paralyze, MistEruption=MistEruption, Meteor=Meteor, MeteorFinalAttack=MeteorFinalAttack, MeteorFinalAttackUnstable=MeteorFinalAttackUnstable,
                             MeteorFinalAttackPoisonNova=MeteorFinalAttackPoisonNova, MeteorFinalAttackDotPunisher=MeteorFinalAttackDotPunisher,
                             FlameHaze=FlameHaze, MegiddoFlame=MegiddoFlame, Ignite=Ignite, IgniteUnstable=IgniteUnstable, IgniteDotPunisher=IgniteDotPunisher, 
                             IgniteDotPunisherFinalAttack=IgniteDotPunisherFinalAttack, IgnitePoisonNova=IgnitePoisonNova, IgniteUnstableFinalAttack=IgniteUnstableFinalAttack, 
                             IgniteMeteorFinalAttack=IgniteMeteorFinalAttack, FireAura=FireAura, DotPunisher1st=DotPunisher1st, DotPunisherRemain=DotPunisherRemain, 
                             PoisonNovaStart=PoisonNovaStart, PoisonNova123=PoisonNova123, PoisonNovaRemain=PoisonNovaRemain, FuryofIfrit=FuryofIfrit,
                             PoisonChainPre=PoisonChainPre, PoisonChain1=PoisonChain1, PoisonChain2=PoisonChain2, PoisonChain3=PoisonChain3, PoisonChain4=PoisonChain4, 
                             PoisonChain5=PoisonChain5, PoisonChainMax=PoisonChainMax, UnstableMemorizePre=UnstableMemorizePre, UnstableMemorizeEnd=UnstableMemorizeEnd,
                             SpiderInMirror=SpiderInMirror))


## ArchMageFP - Summoned
{option <- factor("FDR", levels=SSkill)
value <- c(2 * ArchMageFPCore[[1]][8, 2])
info <- c(150 + 2 * ArchMageFPSpec$SkillLv, 3, 600, 3030, 260 + 5 * ArchMageFPSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Ifrit <- rbind(data.frame(option, value), info)}

ArchMageFPSummoned <- Summoned(list(Ifrit=Ifrit, SpiderInMirrorStart=SpiderInMirrorStart,
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## ArchMageFP - DealCycle and Deal Calculation
ATKFinal <- data.frame(ArchMageFPATK)
ATKFinal$Delay[c(-42, -43)] <- Delay(ATKFinal$Delay, ArchMageFPSpec$ATKSpeed)[c(-42, -43)]
ATKFinal$CoolTime[-13] <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)[-13]

BuffFinal <- data.frame(ArchMageFPBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchMageFPSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(ArchMageFPSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArchMageFPSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(ArchMageFPBuff))
ArchMageFPDealCycle <- t(rep(0, length(DealCycle)))
colnames(ArchMageFPDealCycle) <- DealCycle

DealCycle <- c("Skills", "Time", rownames(ArchMageFPBuff))
ArchMageFPDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(ArchMageFPDealCycle2) <- DealCycle

FPInfinityCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("FireAura", "MagicBooster", "Meditation", "ElementalReset", "MapleSoldier", "EpicAdventure",
                                   "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
  DealCycle <- DCSummoned(DealCycle, "Ifrit", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  Restraint4 <- c(15)
  FuryofIfrit <- c(10, 80)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  SpiderInMirror <- c(50)
  MegiddoFlame <- c(1, 61)

  skills <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror, MegiddoFlame=MegiddoFlame)
  
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
  HazeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameHaze")$CoolTime * 1000
  ErupCool <- subset(ATKFinal, rownames(ATKFinal)=="MistEruption")$CoolTime * 1000
  PNCool <- subset(ATKFinal, rownames(ATKFinal)=="PoisonNovaStart")$CoolTime * 1000
  ErupRemain <- 0 ; HazeRemain <- 0 ; PNRemain <- 2000
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(DealCycle$MeteorBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Meteor", ATKFinal)
      DealCycle$MeteorBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="MeteorBuff")$Duration * 1000
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(PNRemain==0) {
      DealCycle <- DCATK(DealCycle, "TeleportMastery", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonNovaStart", ATKFinal)
      PNRemain <- PNCool - DealCycle$Time[1]
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "DotPunisher1st", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChainPre", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChain1", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(ErupRemain==0) {
      DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- 0
      ErupRemain <- ErupCool - DealCycle$Time[1]
    } else if(HazeRemain==0) {
      DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- HazeCool - DealCycle$Time[1]
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, "Paralyze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
FPUnsCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, "EpicAdventure", BuffFinal)
  
  UnsCool <- subset(ATKFinal, rownames(ATKFinal)=="UnstableMemorizePre")$CoolTime * 1000
  UnsRemain <- 0
  
  InfTime <- subset(DealCycle, DealCycle$Skills=="Infinity")$Time + subset(BuffFinal, rownames(BuffFinal)=="Infinity")$CoolTime * 1000
  PNCool <- subset(ATKFinal, rownames(ATKFinal)=="PoisonNovaStart")$CoolTime * 1000
  PNRemain <- PNCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="PoisonNovaStart")$Time))
  PNDummy <- 0
  
  HazeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameHaze")$CoolTime * 1000
  ErupCool <- subset(ATKFinal, rownames(ATKFinal)=="MistEruption")$CoolTime * 1000
  HazeRemain <- HazeCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="FlameHaze")$Time))
  ErupRemain <- ErupCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="MistEruption")$Time))
  
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < InfTime) {
    if(UnsRemain==0) {
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizePre"), ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      UnsRemain <- UnsCool - DealCycle$Time[1]
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizeEnd"), ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      UnsRemain <- UnsRemain - DealCycle$Time[1]
      if(PNRemain==0 & PNDummy==0) {
        DealCycle <- DCATK(DealCycle, c("PoisonNovaStart"), ATKFinal)
        PNRemain <- PNCool - DealCycle$Time[1]
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, c("DotPunisher1st"), ATKFinal)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, c("PoisonChainPre"), ATKFinal)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, c("PoisonChain1"), ATKFinal)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, c("MistEruption"), ATKFinal)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        HazeRemain <- 0
        ErupRemain <- ErupCool - DealCycle$Time[1]
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        PNDummy <- 1
      }
    } else if(DealCycle$MeteorBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Meteor", ATKFinal)
      DealCycle$MeteorBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="MeteorBuff")$Duration * 1000
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    } else if(ErupRemain==0) {
      DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- 0
      ErupRemain <- ErupCool - DealCycle$Time[1]
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    } else if(HazeRemain==0) {
      DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- HazeCool - DealCycle$Time[1]
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, c("Paralyze"), ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
    }
  }
  DealCycle <- DCATK(DealCycle, c("MegiddoFlame"), ATKFinal)
  return(DealCycle)
}
FPInfinityCycle2 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("Infinity", "EpicAdventure"), BuffFinal)
  
  FuryofIfrit <- c(28)
  SoulContractLink <- c(31)
  MegiddoFlame <- c(1, 61)
  
  skills <- list(FuryofIfrit=FuryofIfrit, SoulContractLink=SoulContractLink, MegiddoFlame=MegiddoFlame)
  
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
  HazeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameHaze")$CoolTime * 1000
  ErupCool <- subset(ATKFinal, rownames(ATKFinal)=="MistEruption")$CoolTime * 1000
  PNCool <- subset(ATKFinal, rownames(ATKFinal)=="PoisonNovaStart")$CoolTime * 1000
  ErupRemain <- ErupCool ; HazeRemain <- HazeCool
  PNWOIF <- max(subset(DealCycle, DealCycle$Skills=="PoisonNovaStart")$Time)
  Uns <- subset(DealCycle, DealCycle$Skills=="UnstableMemorizePre")$Time
  Uns <- Uns[Uns > PNWOIF][1]
  PNRemain <- PNCool - (Uns - PNWOIF) - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="Infinity")$Time))
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 1000) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(DealCycle$MeteorBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Meteor", ATKFinal)
      DealCycle$MeteorBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="MeteorBuff")$Duration * 1000
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(PNRemain==0) {
      DealCycle <- DCATK(DealCycle, "TeleportMastery", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonNovaStart", ATKFinal)
      PNRemain <- PNCool - DealCycle$Time[1]
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "DotPunisher1st", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChainPre", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChain1", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(ErupRemain==0) {
      DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- 0
      ErupRemain <- ErupCool - DealCycle$Time[1]
    } else if(HazeRemain==0) {
      DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- HazeCool - DealCycle$Time[1]
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, "Paralyze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    }
  }
  DealCycle <- DCATK(DealCycle, "Paralyze", ATKFinal)
  DealCycle <- DCATK(DealCycle, "Paralyze", ATKFinal)
  return(DealCycle)
}
FPInfinityCycle3 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("FireAura", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
  DealCycle <- DCSummoned(DealCycle, "Ifrit", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  Restraint4 <- c(15)
  FuryofIfrit <- c(10, 80)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  MegiddoFlame <- c(1, 61)
  
  skills <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, MegiddoFlame=MegiddoFlame)
  
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
  HazeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameHaze")$CoolTime * 1000
  ErupCool <- subset(ATKFinal, rownames(ATKFinal)=="MistEruption")$CoolTime * 1000
  PNCool <- subset(ATKFinal, rownames(ATKFinal)=="PoisonNovaStart")$CoolTime * 1000
  ErupRemain <- 0 ; HazeRemain <- 0 ; PNRemain <- 2000
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(DealCycle$MeteorBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle <- DCATK(DealCycle, "Meteor", ATKFinal)
      DealCycle$MeteorBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="MeteorBuff")$Duration * 1000
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(PNRemain==0) {
      DealCycle <- DCATK(DealCycle, "TeleportMastery", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonNovaStart", ATKFinal)
      PNRemain <- PNCool - DealCycle$Time[1]
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "DotPunisher1st", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChainPre", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, "PoisonChain1", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(ErupRemain==0) {
      DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- 0
      ErupRemain <- ErupCool - DealCycle$Time[1]
    } else if(HazeRemain==0) {
      DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- HazeCool - DealCycle$Time[1]
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, "Paralyze", ATKFinal)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}

ArchMageFPDealCycle <- FPInfinityCycle(ArchMageFPDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageFPDealCycle <- FPUnsCycle(ArchMageFPDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageFPDealCycle <- FPInfinityCycle2(ArchMageFPDealCycle, ATKFinal, BuffFinal, SummonedFinal)
ArchMageFPDealCycle <- DealCycleFinal(ArchMageFPDealCycle)
ArchMageFPDealCycle2 <- FPInfinityCycle3(ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageFPDealCycle2 <- FPUnsCycle(ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
ArchMageFPDealCycle2 <- DealCycleFinal(ArchMageFPDealCycle2)

FPUnsdata <- UnstableData(ArchMageFPDealCycle, ArchMageFPDealCycle2, ArchMageFPUnstable[11, 3], BuffFinal$Duration[5], BuffFinal$CoolTime[5])

ArchMageFPDealCycle <- DCSummonedATKs(ArchMageFPDealCycle, "Ifrit", SummonedFinal)
ArchMageFPDealCycle <- FuryofIfritCycle(ArchMageFPDealCycle, ATKFinal)
ArchMageFPDealCycle <- PoisonChainCycle(ArchMageFPDealCycle, ATKFinal)
ArchMageFPDealCycle <- FPUnstableCycle(ArchMageFPDealCycle, ATKFinal)
ArchMageFPDealCycle <- FPAddATKCycle(ArchMageFPDealCycle, ATKFinal)
ArchMageFPDealCycle <- DCSpiderInMirror(ArchMageFPDealCycle, SummonedFinal)
ArchMageFPDealCycle <- RepATKCycle(ArchMageFPDealCycle, "FireAura", 100, 0, ATKFinal)
ArchMageFPDealCycle <- BishopInfinity(ArchMageFPDealCycle, 6000, 70 + ArchMageFPSpec$SkillLv, General$General$Serverlag)

ArchMageFPDealCycle2 <- DCSummonedATKs(ArchMageFPDealCycle2, "Ifrit", SummonedFinal)
ArchMageFPDealCycle2 <- FuryofIfritCycle(ArchMageFPDealCycle2, ATKFinal)
ArchMageFPDealCycle2 <- PoisonChainCycle(ArchMageFPDealCycle2, ATKFinal)
ArchMageFPDealCycle2 <- FPUnstableCycle(ArchMageFPDealCycle2, ATKFinal)
ArchMageFPDealCycle2 <- FPAddATKCycle(ArchMageFPDealCycle2, ATKFinal)
ArchMageFPDealCycle2 <- RepATKCycle(ArchMageFPDealCycle2, "FireAura", 70, 0, ATKFinal)
ArchMageFPDealCycle2 <- BishopInfinity(ArchMageFPDealCycle2, 6000, 70 + ArchMageFPSpec$SkillLv, General$General$Serverlag)


## ArchMageFP Deal Calc
BishopDealCalc(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpec, FPUnsdata)
BishopDealCalcWithMaxDMR(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpec, FPUnsdata)

ArchMageFPSpecOpt1 <- BishopOptimization1(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpec, ArchMageFPUnionRemained, FPUnsdata)
ArchMageFPSpecOpt <- ArchMageFPSpec
ArchMageFPSpecOpt$ATKP <- ArchMageFPSpecOpt$ATKP + ArchMageFPSpecOpt1$ATKP
ArchMageFPSpecOpt$BDR <- ArchMageFPSpecOpt$BDR + ArchMageFPSpecOpt1$BDR
ArchMageFPSpecOpt$IGR <- IGRCalc(c(ArchMageFPSpecOpt$IGR, ArchMageFPSpecOpt1$IGR))

ArchMageFPSpecOpt2 <- BishopOptimization2(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, ArchMageFPHyperStatBase, ArchMageFPBase$ChrLv, ArchMageFPBase$CRROver, FPUnsdata)
ArchMageFPFinalDPM <- BishopDealCalc(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt2, FPUnsdata)
ArchMageFPFinalDPMwithMax <- BishopDealCalcWithMaxDMR(ArchMageFPDealCycle, ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt2, FPUnsdata)

DPM12349$ArchMageFP[1] <- sum(na.omit(ArchMageFPFinalDPMwithMax)) / (FPUnsdata$DealCycleTime * 1000 / 60000)
DPM12349$ArchMageFP[2] <- sum(na.omit(ArchMageFPFinalDPM)) / (FPUnsdata$DealCycleTime * 1000 / 60000) - sum(na.omit(ArchMageFPFinalDPMwithMax)) / (FPUnsdata$DealCycleTime * 1000 / 60000)

ArchMageFPDamage <- BishopDealCalcGeneral(ArchMageFPDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt2)
ArchMageFP40s <- data.frame(ArchMageFPDealCycle$Skills, ArchMageFPDealCycle$Time, ArchMageFPDealCycle$Restraint4, ArchMageFPDealCycle$Infinity, ArchMageFPDealCycle$InfinityFDR, ArchMageFPDamage)
colnames(ArchMageFP40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")
subset(ArchMageFP40s, ArchMageFP40s$RR4>0)

DPM12349$ArchMageFP[3] <- sum(ArchMageFP40s$Damage[1495:1829])
DPM12349$ArchMageFP[4] <- sum(ArchMageFP40s$Damage[1149:1838])

ArchMageFPDamage2 <- BishopDealCalcGeneral(ArchMageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt2)

FPDealRatio <- BishopDealRatio(ArchMageFPDealCycle, ArchMageFPDealCycle2, ArchMageFPDamage, ArchMageFPDamage2, FPUnsdata)