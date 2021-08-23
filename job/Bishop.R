## Bishop - Data
## Bishop - VMatrix
BishopCoreBase <- CoreBuilder(ActSkills=c("Pray", "AngelofLibra", "PeaceMaker", "DivinePunishment", 
                                          CommonV("Wizard", "Adventure")), 
                              ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                              UsefulSkills=c("CombatOrders", "SharpEyes"), 
                              SpecSet=get(DPMCalcOption$SpecSet), 
                              VPassiveList=BishopVPassive, 
                              VPassivePrior=BishopVPrior, 
                              SelfBind=F)

BishopCore <- MatrixSet(PasSkills=BishopCoreBase$PasSkills$Skills, 
                        PasLvs=BishopCoreBase$PasSkills$Lv, 
                        PasMP=BishopCoreBase$PasSkills$MP, 
                        ActSkills=BishopCoreBase$ActSkills$Skills, 
                        ActLvs=BishopCoreBase$ActSkills$Lv, 
                        ActMP=BishopCoreBase$ActSkills$MP, 
                        UsefulSkills=BishopCoreBase$UsefulSkills, 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        SpecialCore=BishopCoreBase$SpecialCoreUse)


## Bishop - Basic Info
BishopBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      Job="Bishop",
                      CoreData=BishopCore, 
                      BuffDurationNeeded=310, 
                      AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Bishop"), 
                      LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Bishop"), 
                      MonsterLife=get(FindJob(MonsterLifePreSet, "Bishop")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                      Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                      WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                      SubWeapon=SubWeapon[rownames(SubWeapon)=="BishopGrimoire", ], 
                      Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                      CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Bishop")))

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

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(BishopCore, "UnstableMemorize"))
UnstableMemorizePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(BishopCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(BishopCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

BishopPassive <- Passive(list(MPIncrease=MPIncrease, SpellMastery=SpellMastery, HighWisdom=HighWisdom, MagicCritical=MagicCritical, HolyFocus=HolyFocus, BigbangDebuff=BigbangDebuff, 
                              BlessingHarmony=BlessingHarmony, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, UnstableMemorizePassive=UnstableMemorizePassive, BlinkPassive=BlinkPassive, 
                              RopeConnectPassive=RopeConnectPassive))


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
info <- c(240, NA, 0, T, NA, NA, T)
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

Useful <- UsefulSkills(BishopCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders

option <- factor("FDR", levels=BSkill)
value <- c(0)
info <- c(30 + floor(GetCoreLv(BishopCore, "Pray")/2), 180, 360, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Pray <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(14 + floor(GetCoreLv(BishopCore, "PeaceMaker")/5))
info <- c(8, 10, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(BishopCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * BishopBase$MainStatP), 5 + floor(GetCoreLv(BishopCore, "MapleWarriors2")/2))
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
## PetBuff : MagicBooster(990ms), AdvancedBless(600ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms)
BishopAllTimeBuff <- AllTimeBuff(BishopBuff)


## Bishop - Union & HyperStat & SoulWeapon
BishopSpec <- JobSpec(JobBase=BishopBase, 
                      Passive=BishopPassive, 
                      AllTimeBuff=BishopAllTimeBuff, 
                      MobInfo=get(DPMCalcOption$MobSet), 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      WeaponName="Staff", 
                      UnionStance=0, 
                      JobConstant=1.2)

BishopUnionRemained <- BishopSpec$UnionRemained
BishopHyperStatBase <- BishopSpec$HyperStatBase
BishopCoolReduceType <- BishopSpec$CoolReduceType
BishopSpec <- BishopSpec$Spec


## Bishop - Pray (RE)
{option <- factor("FDR", levels=BSkill)
value <- c(5 + floor((BishopSpec$MainStat + BishopBuff[rownames(BishopBuff)=="MapleWarriors2", 1]) / 2500))
info <- c(30 + floor(GetCoreLv(BishopCore, "Pray")/2), 180, 360, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Pray <- rbind(data.frame(option, value), info)}
BishopBuff <- Buff(list(MagicBooster=MagicBooster, Infinity=Infinity, AdvancedBless=AdvancedBless, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure,
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Pray=Pray, PeaceMakerBuff=PeaceMakerBuff, VengenceofAngel=VengenceofAngel,
                        BahamutDebuff=BahamutDebuff, AngelofLibraDebuff=AngelofLibraDebuff,
                        MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## Bishop - Spider In Mirror
SIM <- SIMData(GetCoreLv(BishopCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


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
value <- c(40, floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(309, BishopUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(518, BishopUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HolyArrowUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(BishopCore, "ShiningRay")>=40, 20, 0), FDRCalc(c(3 * GetCoreLv(BishopCore, "ShiningRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)))
info <- c(254, 4 * BishopUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShiningRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "AngelRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), 40, ifelse(GetCoreLv(BishopCore, "AngelRay")>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 7 * BishopUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "Genesis"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), 40, ifelse(GetCoreLv(BishopCore, "Genesis")>=40, 20, 0))
info <- c(405 + 5 * BishopSpec$SkillLv, 12 * BishopUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GenesisUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "Bigbang"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), 40, ifelse(GetCoreLv(BishopCore, "Bigbang")>=40, 20, 0))
info <- c(480 + 6 * BishopSpec$SkillLv, 4 * BishopUnstable[10, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BigbangUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "HeavensDoor"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), 40, ifelse(GetCoreLv(BishopCore, "HeavensDoor")>=40, 20, 0))
info <- c(1000, 8 * BishopUnstable[14, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoorUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "AngelRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "AngelRay")>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRay <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "HeavensDoor"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "HeavensDoor")>=40, 20, 0))
info <- c(1000, 8, 360, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoor <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(350 + 14 * GetCoreLv(BishopCore, "PeaceMaker"), 4, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMaker <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(500 + 20 * GetCoreLv(BishopCore, "PeaceMaker"), 8, 0, NA, 10, T, F, F)
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
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishment <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10, 120, NA, 8.5, F, F, F)
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
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "AngelRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "AngelRay")>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * BishopUnsHolyATKProb, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "AngelRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "AngelRay")>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * (1-BishopUnsHolyATKProb), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(350 + 14 * GetCoreLv(BishopCore, "PeaceMaker"), 4 * BishopUnsHolyATKProb, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(350 + 14 * GetCoreLv(BishopCore, "PeaceMaker"), 4 * (1-BishopUnsHolyATKProb), 0, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(500 + 20 * GetCoreLv(BishopCore, "PeaceMaker"), 8 * BishopUnsHolyATKProb, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(500 + 20 * GetCoreLv(BishopCore, "PeaceMaker"), 8 * (1-BishopUnsHolyATKProb), 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10 * BishopUnsHolyATKProb, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10 * (1-BishopUnsHolyATKProb), 0, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10 * BishopUnsHolyATKProb, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEndAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10 * (1-BishopUnsHolyATKProb), 0, 240, 8.5, F, F, F)
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
value <- c(2 * GetCoreLv(BishopCore, "Bahamut"), ifelse(GetCoreLv(BishopCore, "Bahamut")>=40, 20, 0))
info <- c(170 + 2 * BishopSpec$SkillLv, 3, 0, 3030, 260, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Bahamut <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(BishopCore, "AngelofLibra"), 12, 540, 3030, 30, 120, F, T, T, F)
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

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
BIUnsdata <- UnstableData(BishopDealCycle, BishopDealCycle2, BishopUnstable[12, 3], BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration, BuffFinal[rownames(BuffFinal)=="Infinity", ]$CoolTime)

BishopDealCycle <- PeaceMakerCycle(BishopDealCycle, 3, ATKFinal, 8 + General$General$Serverlag)
BishopDealCycle <- DCSpiderInMirror(BishopDealCycle, SummonedFinal)
BishopDealCycle <- LibraCycle(BishopDealCycle)
BishopDealCycle <- BishopUnstableCycle(BishopDealCycle, ATKFinal)
BishopDealCycle <- BishopInfinity(BishopDealCycle, 6000, 70 + BishopSpec$SkillLv, General$General$Serverlag)

BishopDealCycle2 <- PeaceMakerCycle(BishopDealCycle2, 3, ATKFinal, 8 + General$General$Serverlag)
BishopDealCycle2 <- LibraCycle(BishopDealCycle2)
BishopDealCycle2 <- BishopUnstableCycle(BishopDealCycle2, ATKFinal)
BishopDealCycle2 <- BishopInfinity(BishopDealCycle2, 6000, 70 + BishopSpec$SkillLv, General$General$Serverlag)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Bishop") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  BishopSpecOpt1 <- InfinityOptimization1(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, BishopUnionRemained, BIUnsdata,
                                          NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- BishopSpecOpt1[1, 1:3]
} else {
  BishopSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
BishopSpecOpt <- OptDataAdd(BishopSpec, BishopSpecOpt1, "Potential", BishopBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  BishopSpecOpt2 <- InfinityOptimization2(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, BishopHyperStatBase, BishopBase$ChrLv, BishopBase$CRROver, BIUnsdata, 
                                          NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- BishopSpecOpt2[1, ]
} else {
  BishopSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
BishopSpecOpt <- OptDataAdd(BishopSpecOpt, BishopSpecOpt2, "HyperStat", BishopBase$CRROver, DemonAvenger=F)
BuffFinal <- PrayFDRAdj(BishopSpec, BishopSpecOpt, BuffFinal)

BishopFinalDPM <- InfinityDealCalc(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, BIUnsdata, 
                                   NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
BishopFinalDPMwithMax <- InfinityDealCalcWithMaxDMR(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, BIUnsdata, 
                                                    NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Bishop", sum(na.omit(BishopFinalDPMwithMax)) / (BIUnsdata$DealCycleTime * 1000 / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Bishop", sum(na.omit(BishopFinalDPM)) / (BIUnsdata$DealCycleTime * 1000 / 60000) - sum(na.omit(BishopFinalDPMwithMax)) / (BIUnsdata$DealCycleTime * 1000 / 60000))

BishopDealData <- data.frame(BishopDealCycle$Skills, BishopDealCycle$Time, BishopDealCycle$Restraint4, 
                             DealCalcWithMaxDMR(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, 
                                                NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR")))
colnames(BishopDealData) <- c("Skills", "Time", "R4", "Deal")
BishopDealRatio <- InfinityDealRatio(BishopDealCycle, BishopDealCycle2, 
                                     DealCalcWithMaxDMR(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, 
                                                        NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR")), 
                                     DealCalcWithMaxDMR(BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, 
                                                        NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR")), BIUnsdata)

set(get(DPMCalcOption$DataName), as.integer(3), "Bishop", Deal_RR(BishopDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Bishop", Deal_40s(BishopDealData, F, NA, FinishTime=subset(BishopDealData, BishopDealData$Skills=="Restraint4")$Time[1] + 15000))