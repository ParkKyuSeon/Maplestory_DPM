## Bishop - Data
## Bishop - VMatrix
BishopCore <- MatrixSet(PasSkills=c("AngelRay", "HeavensDoor", "Bahamut", "Bigbang", "Genesis"), 
                        PasLvs=c(50, 50, 50, 50, 50), 
                        PasMP=c(10, 10, 10, 10, 5), 
                        ActSkills=c("Pray", "AngelofLibra", "PeaceMaker", "DivinePunishment", 
                                    CommonV("Wizard", "Adventure")), 
                        ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                        ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 5), 
                        BlinkLv=1, 
                        BlinkMP=0, 
                        UsefulSkills=c("CombatOrders", "SharpEyes"), 
                        UsefulLvs=c(20, 20), 
                        UsefulMP=c(0, 0), 
                        SpecSet=SpecDefault, 
                        SelfBind=F)


## Bishop - Basic Info
BishopBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=MobDefault,
                      SpecSet=SpecDefault, 
                      Job="Bishop",
                      CoreData=BishopCore, 
                      BuffDurationNeeded=310, 
                      AbilList=c("BuffDuration", "DisorderBDR"), 
                      LinkList=c("Zero", "Mikhail", "DemonAvenger", "CygnusKnights"), 
                      MonsterLife=MLTypeI21, 
                      Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", SpecDefault$WeaponType)[, 1:16],
                      WeaponType=SpecDefault$WeaponType, 
                      SubWeapon=SubWeapon[6, ], 
                      Emblem=Emblem[1, ],
                      CoolReduceHat=F)

## Bishop - Passive
{option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
MPIncrease <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("CRR", "Mastery"), levels=PSkill)
value <- c(40, 70)
HolyFocus <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(40 + 4*ceiling(BishopBase$SkillLv/3))
BigbangDebuff <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(3 * General$General$PartyMembers)
BlessingHarmony <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * BishopBase$SkillLv, 50 + 5 * BishopBase$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(BishopBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(BishopCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only

option <- factor(c("MainStat"), levels=PSkill)
value <- c(BishopCore[[2]][7, 2])
UnstableMemorizePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(BishopCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

BishopPassive <- Passive(list(MPIncrease=MPIncrease, SpellMastery=SpellMastery, HighWisdom=HighWisdom, MagicCritical=MagicCritical, HolyFocus=HolyFocus, BigbangDebuff=BigbangDebuff, 
                              BlessingHarmony=BlessingHarmony, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, UnstableMemorizePassive=UnstableMemorizePassive, BlinkPassive=BlinkPassive))


## Bishop - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + BishopBase$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("ATK", "BDR", levels=BSkill)
value <- c(50 + BishopBase$SkillLv, 10)
info <- c(240, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdvancedBless <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((BishopBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(BishopBase$SkillLv/2))))
info <- c(900 + 30 * BishopBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * BishopCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * BishopCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(30 + floor(BishopCore[[2]][1, 2]/2), 180, 360, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Pray <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(14 + floor(BishopCore[[2]][3, 2]/5))
info <- c(8, 10, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * BishopCore[[2]][7, 2]) * MapleSoldier[1, 2]) * BishopBase$MainStatP), 5 + floor(BishopCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "FDR", "IGR", "ATKSpeed", "ImmuneIgnore"), levels=BSkill)
value <- c(50, 30, 20, 1, 10)
info <- c(3600, 7200, 480, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VengenceofAngel <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(25)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BahamutDebuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(50)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraDebuff <- rbind(data.frame(option, value), info)}

BishopBuff <- Buff(list(MagicBooster=MagicBooster, Infinity=Infinity, AdvancedBless=AdvancedBless, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure,
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Pray=Pray, PeaceMakerBuff=PeaceMakerBuff, VengenceofAngel=VengenceofAngel,
                        BahamutDebuff=BahamutDebuff, AngelofLibraDebuff=AngelofLibraDebuff,
                        MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MagicBooster(990ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms)
BishopAllTimeBuff <- AllTimeBuff(BishopBuff)


## Bishop - Union & HyperStat & SoulWeapon
BishopSpec <- JobSpec(JobBase=BishopBase, 
                      Passive=BishopPassive, 
                      AllTimeBuff=BishopAllTimeBuff, 
                      MobInfo=MobDefault, 
                      SpecSet=SpecDefault, 
                      WeaponName="Staff", 
                      UnionStance=0, 
                      JobConstant=1.2)

BishopUnionRemained <- BishopSpec$UnionRemained
BishopHyperStatBase <- BishopSpec$HyperStatBase
BishopCoolReduceType <- BishopSpec$CoolReduceType
BishopSpec <- BishopSpec$Spec


## Bishop - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * BishopCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Bishop - Unstable Memorize Data
Skills <- c("EnergyBolt", "HolyArrow", "Heal", "ShiningRay", "HolyFountain", "Dispel", "DivineProtection", "AngelRay", "Genesis", 
            "Bigbang", "Resurrection", "Infinity", "Bahamut", "HeavensDoor", "EpicAdventure")
Ind <- c(1, 10, 10, 10, 10, 25, 10, 25, 25, 25, 25, 25, 25, 10, 10)
Prob <- Ind/sum(Ind)
Delays <- c(Delay(810, 2), Delay(810, 2), Delay(600, 2), Delay(900, 2), 960, 900, 870, Delay(810, 2), Delay(810, 2), 
            Delay(780, 2), 900, 600, 600, 360, 0)
BishopUnstable <- data.frame(Skills, Ind, Prob, Delays)
BishopUnsHolyATKProb <- sum(BishopUnstable$Prob[c(2, 4, 8, 9, 10)])


## Bishop - Attacks
{option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(309, BishopUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(518, BishopUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HolyArrowUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(254, 4 * BishopUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShiningRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 7 * BishopUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][5, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][5, 2]>=40, 20, 0))
info <- c(405 + 5 * BishopSpec$SkillLv, 12 * BishopUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GenesisUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][4, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][4, 2]>=40, 20, 0))
info <- c(480 + 6 * BishopSpec$SkillLv, 4 * BishopUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BigbangUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][2, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][2, 2]>=40, 20, 0))
info <- c(1000, 8 * BishopUnstable[14, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoorUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRay <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][2, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][2, 2]>=40, 20, 0))
info <- c(1000, 8, 360, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoor <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMaker <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishment <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10, 120, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizePre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, sum(BishopUnstable$Prob * BishopUnstable$Delay), NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizeEnd <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * BishopUnsHolyATKProb, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * (1-BishopUnsHolyATKProb), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4 * BishopUnsHolyATKProb, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4 * (1-BishopUnsHolyATKProb), 0, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8 * BishopUnsHolyATKProb, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8 * (1-BishopUnsHolyATKProb), 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10 * BishopUnsHolyATKProb, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10 * (1-BishopUnsHolyATKProb), 0, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10 * BishopUnsHolyATKProb, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEndAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * BishopCore[[2]][4, 2], 10 * (1-BishopUnsHolyATKProb), 0, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEndAfterUns2 <- rbind(data.frame(option, value), info)}

BishopATK <- Attack(list(EnergyBoltUnstable=EnergyBoltUnstable, HolyArrowUnstable=HolyArrowUnstable, ShiningRayUnstable=ShiningRayUnstable, AngelRayUnstable=AngelRayUnstable, 
                         GenesisUnstable=GenesisUnstable, BigbangUnstable=BigbangUnstable, HeavensDoorUnstable=HeavensDoorUnstable, AngelRay=AngelRay, HeavensDoor=HeavensDoor,
                         PeaceMaker=PeaceMaker, PeaceMakerExplosion=PeaceMakerExplosion, DivinePunishmentPre=DivinePunishmentPre, DivinePunishment=DivinePunishment, DivinePunishmentEnd=DivinePunishmentEnd,
                         UnstableMemorizePre=UnstableMemorizePre, UnstableMemorizeEnd=UnstableMemorizeEnd, AngelRayAfterUns1=AngelRayAfterUns1, AngelRayAfterUns2=AngelRayAfterUns2, 
                         PeaceMakerAfterUns1=PeaceMakerAfterUns1, PeaceMakerAfterUns2=PeaceMakerAfterUns2, PeaceMakerExplosionAfterUns1=PeaceMakerExplosionAfterUns1, 
                         PeaceMakerExplosionAfterUns2=PeaceMakerExplosionAfterUns2, DivinePunishmentAfterUns1=DivinePunishmentAfterUns1, DivinePunishmentAfterUns2=DivinePunishmentAfterUns2, 
                         DivinePunishmentEndAfterUns1=DivinePunishmentEndAfterUns1, DivinePunishmentEndAfterUns2=DivinePunishmentEndAfterUns2, SpiderInMirror=SpiderInMirror))


## Bishop - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * BishopCore[[1]][3, 2], ifelse(BishopCore[[1]][3, 2]>=40, 20, 0))
info <- c(170 + 2 * BishopSpec$SkillLv, 3, 0, 3030, 260, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Bahamut <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(500 + 20 * BishopCore[[2]][2, 2], 12, 540, 3030, 30, 120, F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AngelofLibra <- rbind(data.frame(option, value), info)}

BishopSummoned <- Summoned(list(Bahamut=Bahamut, AngelofLibra=AngelofLibra, SpiderInMirrorStart=SpiderInMirrorStart,
                                SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Bishop - DealCycle
ATKFinal <- data.frame(BishopATK)
ATKFinal$Delay[c(1:8, 10, 11, 17:27)] <- Delay(ATKFinal$Delay, 2)[c(1:8, 10, 11, 17:27)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)

BuffFinal <- data.frame(BishopBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BishopSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(BishopSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BishopSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(BishopBuff))
BishopDealCycle <- t(rep(0, length(DealCycle)))
colnames(BishopDealCycle) <- DealCycle
DealCycle <- c("Skills", "Time", rownames(BishopBuff))
BishopDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(BishopDealCycle2) <- DealCycle

BishopInfinityCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("VengenceofAngel", "MagicBooster", "AdvancedBless", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure"), BuffFinal)
  DealCycle <- DCATK(DealCycle, c("PeaceMaker"), ATKFinal)
  PMCool <- subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$CoolTime * 1000
  PMRemain <- PMCool - DealCycle$Time[1]
  DealCycle <- DCSummoned(DealCycle, "Bahamut", SummonedFinal)
  PMRemain <- PMCool - DealCycle$Time[1]
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  PMRemain <- PMCool - DealCycle$Time[1]
  
  Restraint4 <- c(15)
  DivinePunishmentPre <- c(12, 82.5)
  HeavensDoor <- c(1)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  AngelofLibra <- c(30)
  SpiderInMirror <- c(50)
  Pray <- c(48)
  
  skills <- list(Restraint4=Restraint4, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                 SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, SpiderInMirror=SpiderInMirror, Pray=Pray)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)]=="DivinePunishmentPre") {
            if(times[p]==80000) {
              for(k in 1:30) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            } else {
              for(k in 1:40) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            }
          }
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==0 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > times[p] + 11000 & 
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 2500 & 
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else {
      DealCycle <- DCATK(DealCycle, "AngelRay", ATKFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
BishopUnsCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, "EpicAdventure", BuffFinal)
  
  UnsCool <- subset(ATKFinal, rownames(ATKFinal)=="UnstableMemorizePre")$CoolTime * 1000
  UnsRemain <- 0 ; UnsDummy <- 0
  
  InfTime <- subset(DealCycle, DealCycle$Skills=="Infinity")$Time + subset(BuffFinal, rownames(BuffFinal)=="Infinity")$CoolTime * 1000
  PMCool <- subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$CoolTime * 1000
  PMRemain <- max(0, PMCool - (DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PeaceMaker")$Time)) - DealCycle$Time[1])
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < InfTime + 500) {
    if(UnsRemain==0) {
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizePre"), ATKFinal)
      UnsRemain <- UnsCool - DealCycle$Time[1]
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      DealCycle <- DCATK(DealCycle, c("UnstableMemorizeEnd"), ATKFinal)
      UnsRemain <- UnsRemain - DealCycle$Time[1]
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      DealCycle <- DCBuff(DealCycle, c("VengenceofAngel"), BuffFinal)
      UnsRemain <- UnsRemain - DealCycle$Time[1]
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      if(PMRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < InfTime & UnsDummy <= 5) {
        DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
        UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
        PMRemain <- PMCool - DealCycle$Time[1]
      }
      if(UnsDummy != 6) {
        DealCycle <- DCATK(DealCycle, c("DivinePunishmentPre"), ATKFinal)
        UnsRemain <- UnsRemain - DealCycle$Time[1]
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        for(i in 1:5) {
          DealCycle <- DCATK(DealCycle, c("DivinePunishment"), ATKFinal)
          UnsRemain <- UnsRemain - DealCycle$Time[1]
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        }
        DealCycle <- DCATK(DealCycle, c("DivinePunishmentEnd"), ATKFinal)
        UnsRemain <- UnsRemain - DealCycle$Time[1]
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      }
      UnsDummy <- UnsDummy + 1
    } else if(PMRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < InfTime & UnsDummy <= 5) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
      PMRemain <- PMCool - DealCycle$Time[1]
    } else {
      DealCycle <- DCATK(DealCycle, c("AngelRay"), ATKFinal)
      UnsRemain <- max(0, UnsRemain - DealCycle$Time[1])
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
BishopInfinityCycle2 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  PMCool <- subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$CoolTime * 1000
  PMRemain <- PMCool - subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$Delay - subset(ATKFinal, rownames(ATKFinal)=="UnstableMemorizePre")$Delay - 
              subset(ATKFinal, rownames(ATKFinal)=="UnstableMemorizeEnd")$Delay - subset(BuffFinal, rownames(BuffFinal)=="VengenceofAngel")$Delay
  
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  PMRemain <- max(0, PMRemain - DealCycle$Time[1])
  DealCycle <- DCBuff(DealCycle, c("EpicAdventure"), BuffFinal)
  PMRemain <- max(0, PMRemain - DealCycle$Time[1])
  
  DivinePunishmentPre <- c(12, 82.5)
  HeavensDoor <- c(1)
  SoulContractLink <- c(31)
  AngelofLibra <- c(30)
  
  skills <- list(DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)]=="DivinePunishmentPre") {
            if(times[p]==80000) {
              for(k in 1:25) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            } else {
              for(k in 1:40) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            }
          }
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==0 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > times[p] + 11000 &
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 2500 &
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else {
      DealCycle <- DCATK(DealCycle, "AngelRay", ATKFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
BishopInfinityCycle3 <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- DCBuff(DealCycle, c("VengenceofAngel", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure"), BuffFinal)
  DealCycle <- DCATK(DealCycle, c("PeaceMaker"), ATKFinal)
  PMCool <- subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$CoolTime * 1000
  PMRemain <- PMCool - DealCycle$Time[1]
  DealCycle <- DCSummoned(DealCycle, "Bahamut", SummonedFinal)
  PMRemain <- PMCool - DealCycle$Time[1]
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  PMRemain <- PMCool - DealCycle$Time[1]
  
  Restraint4 <- c(15)
  DivinePunishmentPre <- c(12, 82.5)
  HeavensDoor <- c(1)
  MapleWarriors2 <- c(63)
  SoulContractLink <- c(31)
  AngelofLibra <- c(30)
  Pray <- c(48)
  
  skills <- list(Restraint4=Restraint4, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                 SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, Pray=Pray)
  
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
  
  p <- 1
  while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
      for(j in 1:length(skilllist[[p]])) {
        if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)]=="DivinePunishmentPre") {
            if(times[p]==80000) {
              for(k in 1:30) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            } else {
              for(k in 1:40) {
                DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
              }
              DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
              PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            }
          }
        } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
          DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        }
      }
      p <- p + 1
    }
    if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==0 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > times[p] + 11000 & 
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else if(PMRemain==0 & sum("DivinePunishmentPre"==skilllist[[min(p, length(skilllist))]])==1 & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 2500 & 
              DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] >= 1580) {
      DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
      PMRemain <- PMCool - DealCycle$Time[1]
    } else {
      DealCycle <- DCATK(DealCycle, "AngelRay", ATKFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}

BishopDealCycle <- BishopInfinityCycle(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal)
BishopDealCycle <- BishopUnsCycle(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal)
BishopDealCycle <- BishopInfinityCycle2(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal)
BishopDealCycle <- DealCycleFinal(BishopDealCycle)
BishopDealCycle2 <- BishopInfinityCycle3(BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
BishopDealCycle2 <- BishopUnsCycle(BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal)
BishopDealCycle2 <- DealCycleFinal(BishopDealCycle2)

## Bishop Unstable
BIUnsdata <- UnstableData(BishopDealCycle, BishopDealCycle2, BishopUnstable[12, 3], BuffFinal$Duration[2], BuffFinal$CoolTime[2])

BishopDealCycle <- PeaceMakerCycle(BishopDealCycle, 3, ATKFinal, 8 + General$General$Serverlag)
BishopDealCycle <- DCSpiderInMirror(BishopDealCycle, SummonedFinal)
BishopDealCycle <- LibraCycle(BishopDealCycle)
BishopDealCycle <- BishopUnstableCycle(BishopDealCycle, ATKFinal)
BishopDealCycle <- BishopInfinity(BishopDealCycle, 6000, 70 + BishopSpec$SkillLv, General$General$Serverlag)

BishopDealCycle2 <- PeaceMakerCycle(BishopDealCycle2, 3, ATKFinal, 8 + General$General$Serverlag)
BishopDealCycle2 <- LibraCycle(BishopDealCycle2)
BishopDealCycle2 <- BishopUnstableCycle(BishopDealCycle2, ATKFinal)
BishopDealCycle2 <- BishopInfinity(BishopDealCycle2, 6000, 70 + BishopSpec$SkillLv, General$General$Serverlag)


## Bishop Deal Calc
BishopDealCalc(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, BIUnsdata)
BishopDealCalcWithMaxDMR(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, BIUnsdata)

BishopSpecOpt1 <- BishopOptimization1(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, BishopUnionRemained, BIUnsdata)
BishopSpecOpt <- BishopSpec
BishopSpecOpt$ATKP <- BishopSpecOpt$ATKP + BishopSpecOpt1$ATKP
BishopSpecOpt$BDR <- BishopSpecOpt$BDR + BishopSpecOpt1$BDR
BishopSpecOpt$IGR <- IGRCalc(c(BishopSpecOpt$IGR, BishopSpecOpt1$IGR))

BishopSpecOpt2 <- BishopOptimization2(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, BishopHyperStatBase, BishopBase$ChrLv, BishopBase$CRROver, BIUnsdata)
BishopFinalDPM <- BishopDealCalc(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2, BIUnsdata)
BishopFinalDPMwithMax <- BishopDealCalcWithMaxDMR(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2, BIUnsdata)

DPM12347$Bishop[1] <- sum(na.omit(BishopFinalDPMwithMax)) / (BIUnsdata$DealCycleTime * 1000 / 60000)
DPM12347$Bishop[2] <- sum(na.omit(BishopFinalDPM)) / (BIUnsdata$DealCycleTime * 1000 / 60000) - sum(na.omit(BishopFinalDPMwithMax)) / (BIUnsdata$DealCycleTime * 1000 / 60000)

## PrayFDR Logic Needed
## Divine Puninshment Stack Logic Needed

BishopDamage <- BishopDealCalcGeneral(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2)
Bishop40s <- data.frame(BishopDealCycle$Skills, BishopDealCycle$Time, BishopDealCycle$Restraint4, BishopDealCycle$Infinity, BishopDealCycle$InfinityFDR, BishopDamage)
colnames(Bishop40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")

subset(Bishop40s, Bishop40s$RR4>0)

DPM12347$Bishop[3] <- sum(Bishop40s$Damage[341:424]) 
DPM12347$Bishop[4] <- sum(Bishop40s$Damage[257:424])

BishopDamage2 <- BishopDealCalcGeneral(BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2)

BSDealRatio <- BishopDealRatio(BishopDealCycle, BishopDealCycle2, BishopDamage, BishopDamage2, BIUnsdata)