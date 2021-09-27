## Option Setting
EvanWeaponType <- "Staff"
EvanDealCycleType <- "DoE-DB-BoW"  ## "DoE-DB-BoW", "SoT-DoE-DB"

## Evan - Data
## Evan - Core
EvanCoreBase <- CoreBuilder(ActSkills=c("ElementalBlast", "DragonBreak", "JodiacRay", "SpiralofMana",
                                        CommonV("Wizard", "Heroes")[c(1, 2, 4, 5)]), 
                            ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25), 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            VPassiveList=EvanVPassive, 
                            VPassivePrior=EvanVPrior, 
                            SelfBind=F)

EvanCore <- MatrixSet(PasSkills=EvanCoreBase$PasSkills$Skills, 
                      PasLvs=EvanCoreBase$PasSkills$Lv, 
                      PasMP=EvanCoreBase$PasSkills$MP, 
                      ActSkills=EvanCoreBase$ActSkills$Skills, 
                      ActLvs=EvanCoreBase$ActSkills$Lv, 
                      ActMP=EvanCoreBase$ActSkills$MP, 
                      UsefulSkills=EvanCoreBase$UsefulSkills, 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      SpecialCore=EvanCoreBase$SpecialCoreUse)


## Evan - Basic Info
EvanBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=get(DPMCalcOption$MobSet),
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    Job="Evan",
                    CoreData=EvanCore, 
                    BuffDurationNeeded=0, 
                    AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Evan"), 
                    LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Evan"), 
                    MonsterLife=get(FindJob(MonsterLifePreSet, "Evan")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                    Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, EvanWeaponType, get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                    WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="EvanDocument", ], 
                    Emblem=Emblem[rownames(Emblem)=="Heroes", ], 
                    CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Evan")))


## Evan - Passive
{option <- factor(c("ATK", "MainStat", "SubStat1"), levels=PSkill)
value <- c(11, 18, 14)
DragonEquip <- data.frame(option, value)
## Abyss Mask : ATK + 1 + 10(Chaos), MainStat + 10 + 2(Level), SubStat + 2(Level)
## Reverse Pendant : MainStat + 2(Level), SubStat + 6 + 2(Level)
## Reverse Wings : MainStat + 2(Level), SubStat + 2(Level)
## Reverse Tail : MainStat + 2(Level), SubStat + 2(Level)
  
option <- factor(c("ATK", "MainStat", "SubStat1"), levels=PSkill)
value <- c(10, 10, 10)
InheritedWill <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
LinkedMagic <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("CRR", "ATK"), levels=PSkill)
value <- c(15 + ifelse(EvanWeaponType=="Wand", 5, 0), 10)
SpellMastery <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(15)
ElementalReset <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 20)
CriticalMagic <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(30)
MagicAmplification <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(20)
DragonPotential <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + EvanBase$PSkillLv, 30 + EvanBase$PSkillLv, 20 + floor(EvanBase$PSkillLv/2))
MagicMastery <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(35 + EvanBase$PSkillLv)
DragonFury <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20 + EvanBase$PSkillLv)
HighDragonPotential <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(5 + GetCoreLv(EvanCore, "SpiralofMana"))
SpiralofManaPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(EvanCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(EvanCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

EvanPassive <- Passive(list(DragonEquip, InheritedWill, LinkedMagic, HighWisdom, SpellMastery, ElementalReset, CriticalMagic, MagicAmplification, DragonPotential, MagicMastery, DragonFury, HighDragonPotential, 
                            SpiralofManaPassive, BlinkPassive, RopeConnectPassive))


## Evan - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicFragmentStack <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(20)
info <- c(5, 10, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Communion <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 14, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalBlastBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalBlastFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MirSkill <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FusionSkill <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 2, 30, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Return <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JodiacRayStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JodiacRayRemained <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiralofManaRedBuff <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, 0, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor(c("ImmuneIgnore"), levels=BSkill)
value <- c(10)
info <- c(180, 0, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalReset <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(80 + 2 * EvanBase$SkillLv)
info <- c(180, 0, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofOnix <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((EvanBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(EvanBase$SkillLv/2))))
info <- c(900 + 30 * EvanBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(10)
info <- c(60, 0, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwiftReturnDebuff <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(1)
info <- c(60, 0, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DiveReturnBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(20 + 2 * EvanBase$SkillLv)
info <- c(Cooldown(40, T, EvanBase$UnionChrs$CoolReduceP, EvanBase$CoolReduce), Cooldown(40, T, EvanBase$UnionChrs$CoolReduceP, EvanBase$CoolReduce) + 1, Delay(1160, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkFogBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(EvanCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(EvanCore, "OverloadMana")/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(EvanCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * EvanBase$MainStatP), 5 + floor(GetCoreLv(EvanCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

EvanBuff <- list(MagicFragmentStack=MagicFragmentStack, Communion=Communion, ElementalBlastBuff=ElementalBlastBuff, ElementalBlastFDR=ElementalBlastFDR, MirSkill=MirSkill, FusionSkill=FusionSkill, Return=Return, 
                 JodiacRayStack=JodiacRayStack, JodiacRayRemained=JodiacRayRemained, SpiralofManaRedBuff=SpiralofManaRedBuff,
                 MagicBooster=MagicBooster, ElementalReset=ElementalReset, BlessofOnix=BlessofOnix, MapleSoldier=MapleSoldier, 
                 SwiftReturnDebuff=SwiftReturnDebuff, DiveReturnBuff=DiveReturnBuff, DarkFogBuff=DarkFogBuff, 
                 HeroesOath=HeroesOath, 
                 UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                 OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : MagicBooster(1020ms), ElementalReset(630ms), BlessofOnix(600ms), UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  EvanBuff[[length(EvanBuff)+1]] <- UsefulAdvancedBless
  names(EvanBuff)[[length(EvanBuff)]] <- "UsefulAdvancedBless"
}
EvanBuff <- Buff(EvanBuff)
EvanAllTimeBuff <- AllTimeBuff(EvanBuff)


## Evan - Union & HyperStat & SoulWeapon
EvanSpec <- JobSpec(JobBase=EvanBase, 
                    Passive=EvanPassive, 
                    AllTimeBuff=EvanAllTimeBuff, 
                    MobInfo=get(DPMCalcOption$MobSet), 
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    WeaponName=EvanWeaponType, 
                    UnionStance=0,
                    JobConstant=1.2)

EvanUnionRemained <- EvanSpec$UnionRemained
EvanHyperStatBase <- EvanSpec$HyperStatBase
EvanCoolReduceType <- EvanSpec$CoolReduceType
EvanSpec <- EvanSpec$Spec


## Evan - Spider In Mirror
SIM <- SIMData(GetCoreLv(EvanCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Evan - Attacks
## Hyper : Dragon Swift - CoolTime Reduce / Drgon Dive - CoolTime Reduce / Dragon Dive - Earth Enhance / Dragon Breath - CoolTime Reduce / Dragon Breath - Wind Bonus Chance or Dragon Swift - Thunder Bonus ATK (Vary By DealCycle)
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofMana")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofMana"))
info <- c(290 + EvanSpec$SkillLv, 4, 240, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofMana1 <- rbind(data.frame(option, value), info) ## Cancel Delay : 240ms

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofMana")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofMana"))
info <- c(330 + EvanSpec$SkillLv, 4, 510, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofMana2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DragonSparking")>=40, 20, 0), EvanBase$MonsterLife$FinalATKDMR, 3 * GetCoreLv(EvanCore, "DragonSparking"))
info <- c(150, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedDragonSparking <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "MagicFragment")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "MagicFragment"))
info <- c(110 + 2 * EvanSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "MagicFragment")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "MagicFragment"))
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 1, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "MagicFragment")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "MagicFragment"))
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 2, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment3 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "MagicFragment")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "MagicFragment"))
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 3, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment4 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DarkFog")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "DarkFog"))
info <- c(400 + 2 * EvanSpec$SkillLv, 6, 0, NA, 40, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkFog <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind"))
info <- c(108 + 212 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofWind <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofThunder_SwiftofThunder_DiveofThunder")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofThunder_SwiftofThunder_DiveofThunder"))
info <- c(170 + 150 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofThunder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth"))
info <- c(320 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofEarth <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofWindCancel <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofThunderCancel <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofEarthCancel <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DragonSwift")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "DragonSwift"))
info <- c(95 + 320 + 2 * EvanSpec$SkillLv, 4, 0, 540, Cooldown(8, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonSwift <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DragonDive")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "DragonDive"))
info <- c(130 + 195 + EvanSpec$SkillLv, 3, 0, 390, Cooldown(8, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonDive <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DragonBreath_BreathReturn")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "DragonBreath_BreathReturn"))
info <- c(240 + EvanSpec$SkillLv, 5, 0, 390, Cooldown(10, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonBreath <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "DragonBreath_BreathReturn")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "DragonBreath_BreathReturn"))
info <- c(150 + EvanSpec$SkillLv, 1, 0, 450, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathReturn <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind"))
info <- c((55 + 160 + EvanSpec$SkillLv) * 0.65, 2 * 3, 0, 480, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwiftofWind <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofThunder_SwiftofThunder_DiveofThunder")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofThunder_SwiftofThunder_DiveofThunder"))
info <- c(150 + 300 + EvanSpec$SkillLv, 6 + ifelse(EvanDealCycleType=="SoT-DoE-DB", 1, 0), 0, 390, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwiftofThunder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind"))
info <- c(215 + EvanSpec$SkillLv, 5, 0, 390, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofWind <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofWind_SwiftofWind_BreathofWind"))
info <- c(215 + EvanSpec$SkillLv + 65 + EvanSpec$SkillLv + ifelse(EvanDealCycleType=="SoT-DoE-DB", 0, 85), 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofWindBonus <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth"))
info <- c(280 + EvanSpec$SkillLv, 5, 0, 450, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofEarth <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofEarth_BrethofEarth_DiveofEarth"))
info <- c(190 + EvanSpec$SkillLv + 420 + 2 * EvanSpec$SkillLv, 6, 0, 480, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DiveofEarth <- rbind(data.frame(option, value), info) ## 0ms, 900ms, 1380ms, 1860ms

option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * GetCoreLv(EvanCore, "ElementalBlast"), 6, 780, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElementalBlast <- rbind(data.frame(option, value), info) ## ATKs : 0ms, 660ms, 1230ms, 2070ms

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(EvanCore, "DragonBreak"), 7, 0, 360, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonBreak <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(EvanCore, "DragonBreak"), 7, 0, 240, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ImperialBreath <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(150 + 6 * GetCoreLv(EvanCore, "DragonBreak"), 3, 0, 510, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreakReturn <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(400 + 16 * GetCoreLv(EvanCore, "JodiacRay"), 6, 780, 180, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JodiacRay <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofMana")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofMana"))
info <- c(235 + GetCoreLv(EvanCore, "SpiralofMana"), 6, 360, 450, 5 - 0.05 * GetCoreLv(EvanCore, "SpiralofMana"), T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiralofMana <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(EvanCore, "CircleofMana")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "CircleofMana"))
info <- c(235 + GetCoreLv(EvanCore, "SpiralofMana"), 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiralofManaRed <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 30, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JodiacRayDelay <- rbind(data.frame(option, value), info)}

EvanATK <- Attack(list(CircleofMana1=CircleofMana1, CircleofMana2=CircleofMana2, AdvancedDragonSparking=AdvancedDragonSparking, DarkFog=DarkFog, 
                       MagicFragment1=MagicFragment1, MagicFragment2=MagicFragment2, MagicFragment3=MagicFragment3, MagicFragment4=MagicFragment4, 
                       CircleofWind=CircleofWind, CircleofThunder=CircleofThunder, CircleofEarth=CircleofEarth, 
                       CircleofWindCancel=CircleofWindCancel, CircleofThunderCancel=CircleofThunderCancel, CircleofEarthCancel=CircleofEarthCancel, 
                       DragonSwift=DragonSwift, DragonDive=DragonDive, DragonBreath=DragonBreath, BreathReturn=BreathReturn, 
                       SwiftofWind=SwiftofWind, SwiftofThunder=SwiftofThunder, BreathofWind=BreathofWind, BreathofWindBonus=BreathofWindBonus, BreathofEarth=BreathofEarth, DiveofEarth=DiveofEarth, 
                       ElementalBlast=ElementalBlast, DragonBreak=DragonBreak, ImperialBreath=ImperialBreath, BreakReturn=BreakReturn, JodiacRay=JodiacRay, SpiralofMana=SpiralofMana, SpiralofManaRed=SpiralofManaRed, 
                       JodiacRayDelay=JodiacRayDelay, 
                       SpiderInMirror=SpiderInMirror))


## Evan - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(EvanCore, "SummonOnixDragon")>=40, 20, 0), 2 * GetCoreLv(EvanCore, "SummonOnixDragon"))
info <- c(550, 2, 900, 3030, 40, 80, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SummonOnixDragon <- rbind(data.frame(option, value), info)}

EvanSummoned <- Summoned(list(SummonOnixDragon=SummonOnixDragon, 
                              SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Evan - DealCycle
ATKFinal <- data.frame(EvanATK)
ATKFinal$Delay[c(-29, -30)] <- Delay(ATKFinal$Delay, EvanSpec$ATKSpeed)[c(-29, -30)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, EvanSpec$CoolReduceP, EvanSpec$CoolReduce)

BuffFinal <- data.frame(EvanBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, EvanSpec$CoolReduceP, EvanSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, EvanSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(EvanSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, EvanSpec$CoolReduceP, EvanSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * EvanSpec$SummonedDuration / 100, 0)


EvanCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=c(180), CycleTime=c(360), DealCycleType=c("DoE-DB-BoW", "SoT-DoE-DB"), ActiveCoreData=EvanCore[[2]]) {
  BuffSummonedPrior <- c("MagicBooster", "ElementalReset", "BlessofOnix", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "HeroesOath", 
                         "SummonOnixDragon", "MapleWarriors2")
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 
                2, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce * (CycleTime/Period)
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
  
  DragonBuff <- function(DealCycle) {
    i <- nrow(DealCycle)
    if(DealCycle$Skills[i]=="DragonSwift") {
      DealCycle$MirSkill[i] <- 13510
    } else if(DealCycle$Skills[i]=="DragonDive") {
      DealCycle$MirSkill[i] <- 23240
    } else if(DealCycle$Skills[i]=="DragonBreath") {
      DealCycle$MirSkill[i] <- 33120
    } else if(DealCycle$Skills[i]=="DragonBreak") {
      DealCycle$MirSkill[i] <- 42580
    } else if(DealCycle$Skills[i]=="SwiftofWind") {
      DealCycle$FusionSkill[i] <- 113600
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="SwiftofThunder") {
      DealCycle$FusionSkill[i] <- 123360
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="DiveofEarth") {
      DealCycle$FusionSkill[i] <- 213000
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="BreathofWind") {
      DealCycle$FusionSkill[i] <- 313330
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="BreathofEarth") {
      DealCycle$FusionSkill[i] <- 323000
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="ImperialBreath") {
      DealCycle$FusionSkill[i] <- 416660
      DealCycle$MirSkill[i] <- 0
    } else if(DealCycle$Skills[i]=="Return") {
      if(DealCycle$FusionSkill[i] == 0 & DealCycle$MirSkill[i] < 20000) {
        DealCycle$SwiftReturnDebuff[i] <- BuffFinal[rownames(BuffFinal)=="SwiftReturnDebuff", ]$Duration * 1000
        DealCycle$MirSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] == 0 & DealCycle$MirSkill[i] < 30000) {
        DealCycle$DiveReturnBuff[i] <- BuffFinal[rownames(BuffFinal)=="DiveReturnBuff", ]$Duration * 1000
        DealCycle$MirSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] == 0 & DealCycle$MirSkill[i] < 40000) {
        DealCycle$Skills[i] <- "BreathReturn"
        DealCycle$MirSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] == 0 & DealCycle$MirSkill[i] < 50000) {
        DealCycle$Skills[i] <- "BreakReturn"
        DealCycle$MirSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] < 200000) {
        DealCycle$SwiftReturnDebuff[i] <- BuffFinal[rownames(BuffFinal)=="SwiftReturnDebuff", ]$Duration * 1000
        DealCycle$FusionSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] < 300000) {
        DealCycle$DiveReturnBuff[i] <- BuffFinal[rownames(BuffFinal)=="DiveReturnBuff", ]$Duration * 1000
        DealCycle$FusionSkill[i] <- 0
      } else if(DealCycle$FusionSkill[i] < 400000) {
        DealCycle$Skills[i] <- "BreathReturn"
        DealCycle$FusionSkill[i] <- 0
      } else {
        DealCycle$Skills[i] <- "BreakReturn"
        DealCycle$FusionSkill[i] <- 0
      }
    }
    if(DealCycle$MirSkill[i-1] != 0 & floor(DealCycle$MirSkill[i-1] / 10000) != floor(DealCycle$MirSkill[i] / 10000)) {
      DealCycle$MirSkill[i] <- 0
    }
    if(DealCycle$FusionSkill[i-1] != 0 & floor(DealCycle$FusionSkill[i-1] / 10000) != floor(DealCycle$FusionSkill[i] / 10000)) {
      DealCycle$FusionSkill[i] <- 0
    }
    if(sum(DealCycle$Skills[i]==c("DragonSwift", "DragonDive", "DragonBreath", "DragonBreak")) >= 1) {
      DealCycle$Communion[i] <- BuffFinal[rownames(BuffFinal)=="Communion", ]$Duration * 1000
    }
    return(DealCycle)
  }
  MagicFragmentATK <- function(DealCycle) {
    SkillDelay <- DealCycle[1, 2]
    DealCycle[1, 2:ncol(DealCycle)] <- 150
    DealCycle <- DCATK(DealCycle, "MagicFragment1", ATKFinal)
    DealCycle[1, 2:ncol(DealCycle)] <- SkillDelay - 150
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle <- DCATK(DealCycle, "DragonDive", ATKFinal)
  DealCycle <- DragonBuff(DealCycle)
  
  DealCycle <- DCBuff(DealCycle, "DarkFogBuff", BuffFinal)
  DealCycle[1, 2:ncol(DealCycle)] <- 30
  
  DealCycle <- DCBuff(DealCycle, "Return", BuffFinal)
  DealCycle <- DragonBuff(DealCycle)
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="MapleWarriors2") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
      } else if(BuffList[[1]][i]=="Return") {
        DealCycle <- DCATK(DealCycle, "DragonDive", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- DragonBuff(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- DragonBuff(DealCycle)
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
  
  RTCool <- subset(BuffFinal, rownames(BuffFinal)=="Return")$CoolTime * 1000
  DFCool <- subset(ATKFinal, rownames(ATKFinal)=="DarkFog")$CoolTime * 1000
  R4Cool <- subset(BuffFinal, rownames(BuffFinal)=="Restraint4")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000
  DSCool <- subset(ATKFinal, rownames(ATKFinal)=="DragonSwift")$CoolTime * 1000
  DDCool <- subset(ATKFinal, rownames(ATKFinal)=="DragonDive")$CoolTime * 1000
  DBHCool <- subset(ATKFinal, rownames(ATKFinal)=="DragonBreath")$CoolTime * 1000
  DBKCool <- subset(ATKFinal, rownames(ATKFinal)=="DragonBreak")$CoolTime * 1000
  EBCool <- subset(ATKFinal, rownames(ATKFinal)=="ElementalBlast")$CoolTime * 1000
  JRCool <- subset(ATKFinal, rownames(ATKFinal)=="JodiacRay")$CoolTime * 1000
  SMCool <- 7780
  
  RTRemain <- max(0, RTCool - subset(DealCycle, DealCycle$Skills=="Return")$Time - DealCycle$Time[1])
  DDRemain <- max(0, DDCool - subset(DealCycle, DealCycle$Skills=="DragonDive")$Time - DealCycle$Time[1])
  DFRemain <- max(0, DFCool - subset(DealCycle, DealCycle$Skills=="DarkFogBuff")$Time - DealCycle$Time[1])
  R4Remain <- 0 ; SCRemain <- 0
  DSRemain <- 0 ; DBHRemain <- 0 ; DBKRemain <- 0 ; EBRemain <- 0 ; JRRemain <- 0 ; SMRemain <- 0
  
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
          DealCycle <- DragonBuff(DealCycle)
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        }
      }
      ## Jodiac Ray
      if(JRRemain <= 0 & nrow(subset(DealCycle, DealCycle$Skills=="JodiacRay")) < nrow(subset(DealCycle, DealCycle$Skills=="MapleWarriors2"))) {
        DealCycle <- DCATK(DealCycle, "JodiacRay", ATKFinal)
        DealCycle$JodiacRayRemained[nrow(DealCycle)] <- (14 + floor(ActiveCoreData[ActiveCoreData$Active=="JodiacRay", 2] / 10)) * 1000
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRCool - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "MagicFragment1", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "DragonBreath", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DBHRemain <- DBHCool - DealCycle$Time[1]

        DealCycle <- DCATK(DealCycle, "JodiacRayDelay", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "BreathofWind", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "CircleofWind", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 0
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "JodiacRayDelay", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        DealCycle <- DCBuff(DealCycle, "Return", BuffFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTCool - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "DragonSwift", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DSRemain <- DSCool - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "JodiacRayDelay", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "SwiftofWind", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "CircleofWindCancel", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "CircleofEarth", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        DealCycle <- MagicFragmentATK(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "CircleofThunder", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        DealCycle <- MagicFragmentATK(DealCycle)
      }
      ## Soul Contract
      else if(SCRemain <= 0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) < nrow(subset(DealCycle, DealCycle$Skills=="JodiacRay")) * 2) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCCool - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
      }
      ## Restraint 4
      else if(R4Remain <= 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) < nrow(subset(DealCycle, DealCycle$Skills=="JodiacRay"))) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Cool - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
      }
      ## Dragon Break - Elemental Blast / Dragon Break
      else if(EBRemain <= 0 & DBKRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0) {
        DealCycle <- DCATK(DealCycle, "DragonBreak", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "ImperialBreath", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "ElementalBlast", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKCool - DealCycle$Time[1]
        EBRemain <- EBCool - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
      }
      else if(DBKRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="DragonBreak")) < nrow(subset(DealCycle, DealCycle$Skills=="ElementalBlast")) * 3) {
        DealCycle <- DCATK(DealCycle, "DragonBreak", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DBKRemain <- DBKCool - DealCycle$Time[1]
      }
      ## Dragon Swift (SoT-DoE-DB Only, DoE-DB-BoW : Only for Buff)
      else if(DealCycleType == "SoT-DoE-DB" & DSRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0 | 
              DealCycleType == "DoE-DB-BoW" & DSRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0 & 
              DealCycle$SwiftReturnDebuff[nrow(DealCycle)] - DealCycle$Time[1] < 10000) {
        DealCycle <- DCATK(DealCycle, "DragonSwift", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DSRemain <- DSCool - DealCycle$Time[1]
      }
      ## Dragon Dive (To Dive of Earth)
      else if(DDRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0) {
        DealCycle <- DCATK(DealCycle, "DragonDive", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DDRemain <- DDCool - DealCycle$Time[1]
      }
      ## Dragon Breath (DoE-DB-BoW - To Breath of Wind, SoT-DoE-DB - Only Dragon Breath)
      else if(DBHRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0) {
        DealCycle <- DCATK(DealCycle, "DragonBreath", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DBHRemain <- DBHCool - DealCycle$Time[1]
      }
      ## Break - Return, Breath - Return, Dive - Return
      else if(### Break - Return
              RTRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] > 40030 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 40780 | 
              RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 410030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 412220 | 
              ### Breath - Return
              DealCycleType == "SoT-DoE-DB" & RTRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] > 30030 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 30780 | 
              RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 310030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 310600 | 
              RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 320030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 320720 | 
              ### Breath - Return (Swift Buff) 
              RTRemain <= 0 & DealCycle$SwiftReturnDebuff[nrow(DealCycle)] - DealCycle$Time[1] < 10000 & 
              DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 310030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 400000 | 
              ### Breath - Return (If Dragon Break CoolTime is 0 or Dragon Dive CoolTime is -1000)
              RTRemain <= 0 & DBKRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] > 30030 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 40000 | 
              RTRemain <= 0 & DBKRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 310030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 400000 | 
              RTRemain <= 0 & DDRemain <= -1000 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] > 30030 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 40000 | 
              RTRemain <= 0 & DDRemain <= -1000 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 310030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 400000 | 
              ### Dive - Return
              RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 210030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 211140 | 
              ### Dive - Return (If Dragon Break CoolTime is 0)
              RTRemain <= 0 & DBKRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 210030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 300000 | 
              ### Swift - Return (SoT-DoE-DB Only)
              DealCycleType == "SoT-DoE-DB" & RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 120030 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 121320 | 
              ### Swift - Return (for Buff)
              DealCycleType == "DoE-DB-BoW" & RTRemain <= 0 & DealCycle$SwiftReturnDebuff[nrow(DealCycle)] - DealCycle$Time[1] < 10000 & DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] > 10030 & 
              DealCycle$MirSkill[nrow(DealCycle)] - DealCycle$Time[1] < 20000 | 
              DealCycleType == "DoE-DB-BoW" & RTRemain <= 0 & DealCycle$SwiftReturnDebuff[nrow(DealCycle)] - DealCycle$Time[1] < 10000 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 110030 & 
              DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 200000 |
              ### Swift - Return (If Dragon Break CoolTime is 0)
              RTRemain <= 0 & DBKRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 110030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 200000) {
        ### Dark Fog Return Cancel
        if(DFRemain <= 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DFCool <= TotalTime) {
          DealCycle <- DCBuff(DealCycle, "DarkFogBuff", BuffFinal)
          DealCycle[1, 2:ncol(DealCycle)] <- 30
          DealCycle <- DragonBuff(DealCycle)
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFCool - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        }
        
        DealCycle <- DCBuff(DealCycle, "Return", BuffFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTCool - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
      }
      ## Circle of Mana (Fusion Skill Cancel, Spiral of Mana)
      else {
        ## Circle of Mana 1
        DealCycle <- DCATK(DealCycle, "CircleofMana1", ATKFinal)
        DealCycle <- DragonBuff(DealCycle)
        DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 1000
        RTRemain <- RTRemain - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
        
        ### Swift of Thunder (Circle of Thunder Cancel)
        if(DealCycle$MirSkill[nrow(DealCycle)] > 10000 & DealCycle$MirSkill[nrow(DealCycle)] < 20000) {
          DealCycle <- DCATK(DealCycle, "CircleofThunderCancel", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          
          DealCycle <- DCATK(DealCycle, "SwiftofThunder", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
        } 
        ### Dive of Earth (Circle of Earth Cancel)
        else if(DealCycle$MirSkill[nrow(DealCycle)] > 20000 & DealCycle$MirSkill[nrow(DealCycle)] < 30000) {
          DealCycle <- DCATK(DealCycle, "CircleofEarthCancel", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          
          DealCycle <- DCATK(DealCycle, "DiveofEarth", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
        }
        ### Breath of Wind (Circle of Wind Cancel, DoE-DB-BoW Only)
        else if(DealCycleType == "DoE-DB-BoW" & DealCycle$MirSkill[nrow(DealCycle)] > 30000 & DealCycle$MirSkill[nrow(DealCycle)] < 30780) {
          DealCycle <- DCATK(DealCycle, "CircleofWindCancel", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          
          DealCycle <- DCATK(DealCycle, "BreathofWind", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
        }
        
        ## Spiral of Mana
        if(SMRemain <= 0) {
          DealCycle <- DCATK(DealCycle, "SpiralofMana", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 0
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMCool - DealCycle$Time[1]
        } 
        ## Circle of Mana 2
        else {
          DealCycle <- DCATK(DealCycle, "CircleofMana2", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 1000
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        }
      }
    }
    
    if(sum(k == c(3, 5)) >= 1) {
      while(max(EBRemain - 5700, DBKRemain - 5700, DBHRemain - 3300, DSRemain - 3400) > 0) {
        if(DDRemain <= 0 & DealCycle$MirSkill[nrow(DealCycle)] == 0 & DealCycle$FusionSkill[nrow(DealCycle)] == 0) {
          DealCycle <- DCATK(DealCycle, "DragonDive", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          DDRemain <- DDCool - DealCycle$Time[1]
        } 
        else if(RTRemain <= 0 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] > 210030 & DealCycle$FusionSkill[nrow(DealCycle)] - DealCycle$Time[1] < 211140) {
          ### Dark Fog Return Cancel
          if(DFRemain <= 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DFCool <= TotalTime) {
            DealCycle <- DCBuff(DealCycle, "DarkFogBuff", BuffFinal)
            DealCycle[1, 2:ncol(DealCycle)] <- 30
            DealCycle <- DragonBuff(DealCycle)
            RTRemain <- RTRemain - DealCycle$Time[1]
            DFRemain <- DFCool - DealCycle$Time[1]
            R4Remain <- R4Remain - DealCycle$Time[1]
            SCRemain <- SCRemain - DealCycle$Time[1]
            DSRemain <- DSRemain - DealCycle$Time[1]
            DDRemain <- DDRemain - DealCycle$Time[1]
            DBHRemain <- DBHRemain - DealCycle$Time[1]
            DBKRemain <- DBKRemain - DealCycle$Time[1]
            EBRemain <- EBRemain - DealCycle$Time[1]
            JRRemain <- JRRemain - DealCycle$Time[1]
            SMRemain <- SMRemain - DealCycle$Time[1]
          }
          
          DealCycle <- DCBuff(DealCycle, "Return", BuffFinal)
          DealCycle <- DragonBuff(DealCycle)
          RTRemain <- RTCool - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        } 
        else {
          ## Circle of Mana (Fusion Skill Cancel, Spiral of Mana)
          ## Circle of Mana 1
          DealCycle <- DCATK(DealCycle, "CircleofMana1", ATKFinal)
          DealCycle <- DragonBuff(DealCycle)
          DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 1000
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
          
          ### Swift of Thunder (Circle of Thunder Cancel)
          if(DealCycle$MirSkill[nrow(DealCycle)] > 10000 & DealCycle$MirSkill[nrow(DealCycle)] < 20000) {
            DealCycle <- DCATK(DealCycle, "CircleofThunderCancel", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
            
            DealCycle <- DCATK(DealCycle, "SwiftofThunder", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
          } 
          ### Dive of Earth (Circle of Earth Cancel)
          else if(DealCycle$MirSkill[nrow(DealCycle)] > 20000 & DealCycle$MirSkill[nrow(DealCycle)] < 30000) {
            DealCycle <- DCATK(DealCycle, "CircleofEarthCancel", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
            
            DealCycle <- DCATK(DealCycle, "DiveofEarth", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
          }
          ### Breath of Wind (Circle of Wind Cancel, DoE-DB-BoW Only)
          else if(DealCycleType == "DoE-DB-BoW" & DealCycle$MirSkill[nrow(DealCycle)] > 30000 & DealCycle$MirSkill[nrow(DealCycle)] < 30780) {
            DealCycle <- DCATK(DealCycle, "CircleofWindCancel", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
            
            DealCycle <- DCATK(DealCycle, "BreathofWind", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
          }
          
          ## Spiral of Mana
          if(SMRemain <= 0) {
            DealCycle <- DCATK(DealCycle, "SpiralofMana", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
            DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 0
            RTRemain <- RTRemain - DealCycle$Time[1]
            DFRemain <- DFRemain - DealCycle$Time[1]
            R4Remain <- R4Remain - DealCycle$Time[1]
            SCRemain <- SCRemain - DealCycle$Time[1]
            DSRemain <- DSRemain - DealCycle$Time[1]
            DDRemain <- DDRemain - DealCycle$Time[1]
            DBHRemain <- DBHRemain - DealCycle$Time[1]
            DBKRemain <- DBKRemain - DealCycle$Time[1]
            EBRemain <- EBRemain - DealCycle$Time[1]
            JRRemain <- JRRemain - DealCycle$Time[1]
            SMRemain <- SMCool - DealCycle$Time[1]
          } 
          ## Circle of Mana 2
          else {
            DealCycle <- DCATK(DealCycle, "CircleofMana2", ATKFinal)
            DealCycle <- DragonBuff(DealCycle)
            DealCycle$SpiralofManaRedBuff[nrow(DealCycle)] <- 1000
            RTRemain <- RTRemain - DealCycle$Time[1]
            DFRemain <- DFRemain - DealCycle$Time[1]
            R4Remain <- R4Remain - DealCycle$Time[1]
            SCRemain <- SCRemain - DealCycle$Time[1]
            DSRemain <- DSRemain - DealCycle$Time[1]
            DDRemain <- DDRemain - DealCycle$Time[1]
            DBHRemain <- DBHRemain - DealCycle$Time[1]
            DBKRemain <- DBKRemain - DealCycle$Time[1]
            EBRemain <- EBRemain - DealCycle$Time[1]
            JRRemain <- JRRemain - DealCycle$Time[1]
            SMRemain <- SMRemain - DealCycle$Time[1]
          }
        }
      }
      
      if(DealCycle$FusionSkill[nrow(DealCycle)] > 0 | DealCycle$MirSkill[nrow(DealCycle)] > 0) {
        DealCycle <- DCBuff(DealCycle, "Return", BuffFinal)
        DealCycle <- DragonBuff(DealCycle)
        RTRemain <- RTCool - DealCycle$Time[1]
        DFRemain <- DFRemain - DealCycle$Time[1]
        R4Remain <- R4Remain - DealCycle$Time[1]
        SCRemain <- SCRemain - DealCycle$Time[1]
        DSRemain <- DSRemain - DealCycle$Time[1]
        DDRemain <- DDRemain - DealCycle$Time[1]
        DBHRemain <- DBHRemain - DealCycle$Time[1]
        DBKRemain <- DBKRemain - DealCycle$Time[1]
        EBRemain <- EBRemain - DealCycle$Time[1]
        JRRemain <- JRRemain - DealCycle$Time[1]
        SMRemain <- SMRemain - DealCycle$Time[1]
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- DragonBuff(DealCycle)
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- DragonBuff(DealCycle)
          RTRemain <- RTRemain - DealCycle$Time[1]
          DFRemain <- DFRemain - DealCycle$Time[1]
          R4Remain <- R4Remain - DealCycle$Time[1]
          SCRemain <- SCRemain - DealCycle$Time[1]
          DSRemain <- DSRemain - DealCycle$Time[1]
          DDRemain <- DDRemain - DealCycle$Time[1]
          DBHRemain <- DBHRemain - DealCycle$Time[1]
          DBKRemain <- DBKRemain - DealCycle$Time[1]
          EBRemain <- EBRemain - DealCycle$Time[1]
          JRRemain <- JRRemain - DealCycle$Time[1]
          SMRemain <- SMRemain - DealCycle$Time[1]
        }
      }
    }
  }
  return(DealCycle)
}
EvanAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                       DealCycleType=c("DoE-DB-BoW", "SoT-DoE-DB"), DiveofEarthHit=4, SwiftofThunderHit=3, BreakReturnATK=F) {
  MirSkillReduction <- function(DealCycle, Skill, Code) {
    Idx <- c()
    if(Code < 10) {
      for(i in 2:nrow(DealCycle)) {
        if(DealCycle$Skills[i]==Skill & DealCycle$MirSkill[i] < Code * 10000 - 1 | 
           DealCycle$Skills[i]==Skill & DealCycle$MirSkill[i] >= (Code + 1) * 10000) {
          Idx <- c(Idx, i)
        }
      }
    } else {
      for(i in 2:nrow(DealCycle)) {
        if(DealCycle$Skills[i]==Skill & DealCycle$FusionSkill[i] < Code * 10000 - 1 | 
           DealCycle$Skills[i]==Skill & DealCycle$FusionSkill[i] >= (Code + 1) * 10000) {
          Idx <- c(Idx, i)
        }
      }
    }
    if(length(Idx) > 0) {
      DealCycle <- DealCycle[-Idx, ]
    }
    DealCycle <- DealCycle[order(DealCycle$Time), ] 
    rownames(DealCycle) <- 1:nrow(DealCycle)
    return(DealCycle)
  }
  ## Mir Skills
  ### Dragon Swift
  DealCycle <- RepATKCycle(DealCycle, "DragonSwift", 6, 1, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "DragonSwift", 1)
  print(paste("Dragon Swift Hits", nrow(subset(DealCycle, DealCycle$Skills=="DragonSwift")), "Times"))
  ### Dragon Dive
  DealCycle <- RepATKCycle(DealCycle, "DragonDive", 9, 60, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "DragonDive", 2)
  print(paste("Dragon Dive Hits", nrow(subset(DealCycle, DealCycle$Skills=="DragonDive")), "Times"))
  ### Dragon Breath
  DealCycle <- RepATKCycle(DealCycle, "DragonBreath", 8, 1, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "DragonBreath", 3)
  print(paste("Dragon Breath Hits", nrow(subset(DealCycle, DealCycle$Skills=="DragonBreath")), "Times"))
  ### Dragon Break
  DealCycle <- RepATKCycle(DealCycle, "DragonBreak", 6, 1, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "DragonBreak", 4)
  print(paste("Dragon Break Hits", nrow(subset(DealCycle, DealCycle$Skills=="DragonBreak")), "Times"))
  
  
  ## Fusion Skills
  ### Swift of Wind
  DealCycle <- RepATKCycle(DealCycle, "SwiftofWind", 8, 1, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "SwiftofWind", 11)
  print(paste("Swift of Wind Hits", nrow(subset(DealCycle, DealCycle$Skills=="SwiftofWind")), "Times"))
  ### Swift of Thunder
  DealCycle <- RepATKCycle(DealCycle, "SwiftofThunder", SwiftofThunderHit, 480, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "SwiftofThunder", 12)
  print(paste("Swift of Thunder Hits", nrow(subset(DealCycle, DealCycle$Skills=="SwiftofThunder")), "Times"))
  ### Dive of Earth
  DealCycle <- RepATKCycle(DealCycle, "DiveofEarth", (DiveofEarthHit - 1), 900, ATKFinal)
  DealCycle[DealCycle$Skills=="DiveofEarthStart", ]$Skills <- "DiveofEarth"
  DealCycle <- MirSkillReduction(DealCycle, "DiveofEarth", 21)
  print(paste("Dive of Earth Hits", nrow(subset(DealCycle, DealCycle$Skills=="DiveofEarth")), "Times"))
  ### Breath of Wind
  if(DealCycleType=="DoE-DB-BoW") {
    DealCycle <- RepATKCycle(DealCycle, "BreathofWind", 8, 1, ATKFinal)
    DealCycle <- MirSkillReduction(DealCycle, "BreathofWind", 31)
  }
  print(paste("Breath of Wind Hits", nrow(subset(DealCycle, DealCycle$Skills=="BreathofWind")), "Times"))
  ### Imperial Breath
  DealCycle <- RepATKCycle(DealCycle, "ImperialBreath", 16, 840, ATKFinal)
  DealCycle <- MirSkillReduction(DealCycle, "ImperialBreath", 41)
  print(paste("Imperial Breath Hits", nrow(subset(DealCycle, DealCycle$Skills=="ImperialBreath")), "Times"))
  
  
  ## Dark Fog ATK
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DarkFogBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "DarkFog"
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print(paste("Dark Fog Hits", nrow(subset(DealCycle, DealCycle$Skills=="DarkFog")), "Times"))
  
  
  ## Breath - Return
  SS <- subset(DealCycle, DealCycle$Skills=="BreathReturn")
  SS <- rbind(SS, DealCycle[nrow(DealCycle), ])
  BreathReturnTimes <- c()
  for(i in 1:(nrow(SS)-1)) {
    BreathReturnTimes <- c(BreathReturnTimes, seq(SS$Time[i] + 750, SS$Time[i+1], ATKFinal[rownames(ATKFinal)=="BreathReturn", ]$SubTime))
  }
  DealCycle[DealCycle$Skills=="BreathReturn", ]$Skills <- "BreathReturnStart"
  for(i in 1:length(BreathReturnTimes)) {
    DealCycle <- rbind(DealCycle, DealCycle[2, ])
    DealCycle$Time[nrow(DealCycle)] <- BreathReturnTimes[i]
    DealCycle$Skills[nrow(DealCycle)] <- "BreathReturn"
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("BreathReturn")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print(paste("Breath - Return Hits", nrow(subset(DealCycle, DealCycle$Skills=="BreathReturn")), "Times"))
  
  
  ## Break - Return
  if(BreakReturnATK==T) {
    DealCycle <- RepATKCycle(DealCycle, "BreakReturn", 9, 450, ATKFinal)
  } else {
    DealCycle[DealCycle$Skills=="BreakReturn", ]$Skills <- "BreakReturnDummy"
  }
  print(paste("Break - Return Hits", nrow(subset(DealCycle, DealCycle$Skills=="BreakReturn")), "Times"))
  
  
  ## Magic Fragment (Stack)
  DealCycle$MagicFragmentStack[2] <- 1
  FragmentUse <- 0
  LastFragmentTime <- 0
  FragmentDelay <- 0
  for(i in 3:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i-1]=="MagicFragment1" | FragmentUse==1) {
      DealCycle$MagicFragmentStack[i] <- 0
      FragmentUse <- 0
    } else {
      DealCycle$MagicFragmentStack[i] <- DealCycle$MagicFragmentStack[i-1]
    }
    
    if(sum(DealCycle$Skills[i]==c("SwiftofWind", "SwiftofThunder", "DiveofEarth", "BreathofWind", "BreathofEarth", "ImperialBreath")) >= 1 & FragmentDelay == 0) {
      DealCycle$MagicFragmentStack[i] <- min(15, DealCycle$MagicFragmentStack[i] + 1)
      FragmentDelay <- 400 - (DealCycle$Time[i+1] - DealCycle$Time[i])
    } else {
      DealCycle$MagicFragmentStack[i] <- DealCycle$MagicFragmentStack[i]
      FragmentDelay <- max(0, FragmentDelay - (DealCycle$Time[i+1] - DealCycle$Time[i]))
    }
    
    if(DealCycle$MagicFragmentStack[i] >= 10 & sum(DealCycle$Skills[i]==c("CircleofMana1", "CircleofMana2", "SpiralofMana")) >= 1 | 
       DealCycle$MagicFragmentStack[i] >= 1 & sum(DealCycle$Skills[i]==c("CircleofMana1", "CircleofMana2", "SpiralofMana")) >= 1 & DealCycle$Time[i] - LastFragmentTime > 18000) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "MagicFragment1"
      FragmentUse <- 1
      LastFragmentTime <- DealCycle$Time[i]
    } else if(DealCycle$Skills[i]=="MagicFragment1") {
      LastFragmentTime <- DealCycle$Time[i]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Jodiac Ray
  ByDragonBreath <- 0 ; ByBreathofWind <- 0 ; ByBreathReturn <- 0 ; BySwiftofWind <- 0
  ByCircleofWind <- 0 ; ByCircleofThunder <- 0 ; ByCircleofEarth <- 0 
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$JodiacRayRemained[i] > 0) {
      if(DealCycle$Skills[i]=="JodiacRay") {
        ByDragonBreath <- 0 ; ByBreathofWind <- 0 ; ByBreathReturn <- 0 ; BySwiftofWind <- 0
        ByCircleofWind <- 0 ; ByCircleofThunder <- 0 ; ByCircleofEarth <- 0 
      } else if(sum(DealCycle$Skills[i]==c("MagicFragment1", "DragonSwift")) >= 1) {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 1)
      } else if(ByDragonBreath == 0 & DealCycle$Skills[i]=="DragonBreath") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByDragonBreath <- 1
      } else if(ByBreathofWind == 0 & DealCycle$Skills[i]=="BreathofWind") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByBreathofWind <- 1
      } else if(ByBreathReturn == 0 & DealCycle$Skills[i]=="BreathReturn") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByBreathReturn <- 1
      } else if(BySwiftofWind == 0 & DealCycle$Skills[i]=="SwiftofWind") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        BySwiftofWind <- 1
      } else if(ByCircleofWind == 0 & DealCycle$Skills[i]=="CircleofWind") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByCircleofWind <- 1
      } else if(ByCircleofThunder == 0 & DealCycle$Skills[i]=="CircleofThunder") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByCircleofThunder <- 1
      } else if(ByCircleofEarth == 0 & DealCycle$Skills[i]=="CircleofEarth") {
        DealCycle$JodiacRayStack[i] <- min(25, DealCycle$JodiacRayStack[i-1] + 3)
        ByCircleofEarth <- 1
      } else {
        DealCycle$JodiacRayStack[i] <- DealCycle$JodiacRayStack[i-1]
      }
      
      if(DealCycle$JodiacRayStack[i] == 25 & nrow(subset(DealCycle, DealCycle$Skills=="JodiacRayStartDummy")) < nrow(subset(DealCycle, DealCycle$Skills=="JodiacRay" & DealCycle$Time<=DealCycle$Time[i]))) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "JodiacRayStartDummy"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle[DealCycle$Skills=="JodiacRay", ]$Skills <- "JodiacRayUse"
  DealCycle[DealCycle$Skills=="JodiacRayStartDummy", ]$Skills <- "JodiacRayStart"
  JodiacRayTimes <- c()
  for(i in 1:nrow(DealCycle[DealCycle$Skills=="JodiacRayStart", ])) {
   JodiacRayTimes <- c(JodiacRayTimes, seq(DealCycle[DealCycle$Skills=="JodiacRayStart", ]$Time[i] + 1800, 
                                           DealCycle[DealCycle$Skills=="JodiacRayStart", ]$Time[i] + DealCycle[DealCycle$Skills=="JodiacRayStart", ]$JodiacRayRemained[i], 
                                           ATKFinal[rownames(ATKFinal)=="JodiacRay", ]$SubTime)) 
  }
  for(i in 1:length(JodiacRayTimes)) {
    DealCycle <- rbind(DealCycle, DealCycle[2, ])
    DealCycle$Time[nrow(DealCycle)] <- JodiacRayTimes[i]
    DealCycle$Skills[nrow(DealCycle)] <- "JodiacRay"
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("JodiacRay")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print(paste("Jodiac Ray Hits", nrow(subset(DealCycle, DealCycle$Skills=="JodiacRay")), "Times"))
  
  
  ## Magic Fragment(ATK)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="MagicFragment1") {
      if(DealCycle$MagicFragmentStack[i] < 5) {
        if(DealCycle$MagicFragmentStack[i] > 1) {
          for(j in 1:(DealCycle$MagicFragmentStack[i]-1)) {
            DealCycle <- rbind(DealCycle, DealCycle[i, ])
            DealCycle$Skills[nrow(DealCycle)] <- "MagicFragment1"
          }
        }
      } else if(DealCycle$MagicFragmentStack[i] < 10) {
        DealCycle$Skills[i] <- "MagicFragment2"
        for(j in 1:(DealCycle$MagicFragmentStack[i]-1)) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "MagicFragment2"
        }
      } else if(DealCycle$MagicFragmentStack[i] < 15) {
        DealCycle$Skills[i] <- "MagicFragment3"
        for(j in 1:(DealCycle$MagicFragmentStack[i]-1)) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "MagicFragment3"
        }
      } else {
        DealCycle$Skills[i] <- "MagicFragment4"
        for(j in 1:(DealCycle$MagicFragmentStack[i]-1)) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "MagicFragment4"
        }
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print(paste("Magic Fragment(1) Hits", nrow(subset(DealCycle, DealCycle$Skills=="MagicFragment1")), "Times"))
  print(paste("Magic Fragment(2) Hits", nrow(subset(DealCycle, DealCycle$Skills=="MagicFragment2")), "Times"))
  print(paste("Magic Fragment(3) Hits", nrow(subset(DealCycle, DealCycle$Skills=="MagicFragment3")), "Times"))
  print(paste("Magic Fragment(4) Hits", nrow(subset(DealCycle, DealCycle$Skills=="MagicFragment4")), "Times"))
  
  
  ## Spiral of Mana
  DealCycle <- RepATKCycle(DealCycle, "SpiralofMana", 16, 870, ATKFinal)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SpiralofMana" & DealCycle$SpiralofManaRedBuff[i] > 0) {
      DealCycle$Skills[i] <- "SpiralofManaRed"
    }
  }
  print(paste("Spiral of Mana Hits", nrow(subset(DealCycle, DealCycle$Skills=="SpiralofMana")), "Times"))
  print(paste("Spiral of Mana(Reduced) Hits", nrow(subset(DealCycle, DealCycle$Skills=="SpiralofManaRed")), "Times"))
  
  
  ## Spider In Mirror, Summon Onix Dragon
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "SummonOnixDragon", SummonedFinal)
  print(paste("Summon Onix Dragon Hits", nrow(subset(DealCycle, DealCycle$Skills=="SummonOnixDragon")), "Times"))
  
  
  ## Elemental Blast (ATK, FDR Buff)
  ElementalBlastDelay <- c(660, 1230, 2070)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ElementalBlast") {
      for(j in 1:length(ElementalBlastDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + ElementalBlastDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ElementalBlast") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print(paste("Elemental Blast Hits", nrow(subset(DealCycle, DealCycle$Skills=="ElementalBlast")), "Times"))
  
  t <- 0
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ElementalBlast") {
      t <- t + 1
      DealCycle$ElementalBlastBuff[i] <- BuffFinal[rownames(BuffFinal)=="ElementalBlastBuff", ]$Duration * 1000
      DealCycle$ElementalBlastFDR[i] <- 5 * t
      t <- ifelse(t==4, 0, t)
    } else if(DealCycle$ElementalBlastBuff[i-1] > 0) {
      DealCycle$ElementalBlastBuff[i] <- max(0, DealCycle$ElementalBlastBuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
      DealCycle$ElementalBlastFDR[i] <- ifelse(DealCycle$ElementalBlastBuff[i] > 0, DealCycle$ElementalBlastFDR[i-1], 0)
    } else {
      DealCycle$ElementalBlastBuff[i] <- 0
      DealCycle$ElementalBlastFDR[i] <- 0
    }
  }
  DealCycle[DealCycle$Skills=="ElementalBlast", ]$ElementalBlastFDR <- DealCycle[DealCycle$Skills=="ElementalBlast", ]$ElementalBlastFDR - 5
  
  
  ## Dragon Sparking
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("CircleofMana2", "CircleofWind", "CircleofEarth", "CircleofThunder")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AdvancedDragonSparking"
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print(paste("Advance Dragon Sparking Hits", nrow(subset(DealCycle, DealCycle$Skills=="AdvancedDragonSparking")), "Times"))
  
  
  ## Overload Mana, Dark Fog Buff Only for Magic Fragment
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("CircleofMana1", "CircleofMana2", "DarkFog", 
                                  "MagicFragment1", "MagicFragment2", "MagicFragment3", "MagicFragment4", 
                                  "CircleofWind", "CircleofThunder", "CircleofEarth", 
                                  "DragonSwift", "DragonDive", "DragonBreath", "BreathReturn", 
                                  "SwiftofWind", "SwiftofThunder", "BreathofWind", "BreathofWindBonus", "BreathofEarth", "DiveofEarth", 
                                  "ElementalBlast", "DragonBreak", "ImperialBreath", "BreakReturn", "SpiralofMana", "SpiralofManaRed")) >= 1) {
      DealCycle$OverloadMana[i] <- 1
    }
    if(sum(DealCycle$Skills[i]==c("MagicFragment1", "MagicFragment2", "MagicFragment3", "MagicFragment4")) >= 1 & DealCycle$DarkFogBuff[i] > 0) {
      DealCycle$DarkFogBuff[i] <- 1
    } else {
      DealCycle$DarkFogBuff[i] <- 0
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$MagicFragmentStack <- 0
  DealCycle$ElementalBlastBuff <- 0
  DealCycle$MirSkill <- 0
  DealCycle$FusionSkill <- 0
  DealCycle$JodiacRayStack <- 0
  DealCycle$JodiacRayRemained <- 0
  DealCycle$SpiralofManaRedBuff <- 0
  
  return(DealCycle)
}


## DoE-DB-BoW Cycle
if(EvanDealCycleType=="DoE-DB-BoW") {
  ## DoE(4) - DB - BoW
  DealCycle <- c("Skills", "Time", rownames(EvanBuff))
  EvanDealCycle <- t(rep(0, length(DealCycle)))
  colnames(EvanDealCycle) <- DealCycle
  EvanDealCycle <- data.frame(EvanDealCycle)
  
  EvanDealCycle <- EvanCycle(EvanDealCycle, 
                             ATKFinal, 
                             BuffFinal, 
                             SummonedFinal,
                             EvanSpec, 
                             180, 360, "DoE-DB-BoW", EvanCore[[2]])
  EvanDealCycle <- DealCycleFinal(EvanDealCycle)
  EvanDealCycle <- EvanAddATK(EvanDealCycle, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal, 
                              Spec, 
                              "DoE-DB-BoW", 4, 3, F)
  EvanDealCycleReduction <- DealCycleReduction(EvanDealCycle, c("ElementalBlastFDR"))
  
  Idx1 <- c() ; Idx2 <- c()
  for(i in 1:length(PotentialOpt)) {
    if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
      Idx1 <- i
    }
  }
  for(i in 1:nrow(PotentialOpt[[Idx1]])) {
    if(rownames(PotentialOpt[[Idx1]])[i]=="Evan") {
      Idx2 <- i
    }
  }
  if(DPMCalcOption$Optimization==T) {
    EvanSpecOpt1 <- EvanOptimization1(EvanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, EvanSpec, EvanUnionRemained, 
                                      NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
    PotentialOpt[[Idx1]][Idx2, ] <- EvanSpecOpt1[1, 1:3]
  } else {
    EvanSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
  }
  EvanSpecOpt <- OptDataAdd(EvanSpec, EvanSpecOpt1, "Potential", EvanBase$CRROver, DemonAvenger=F)
  
  if(DPMCalcOption$Optimization==T) {
    EvanSpecOpt2 <- EvanOptimization2(EvanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, EvanHyperStatBase, EvanBase$ChrLv, EvanBase$CRROver, 
                                      NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
    HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- EvanSpecOpt2[1, ]
  } else {
    EvanSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
  }
  EvanSpecOpt <- OptDataAdd(EvanSpecOpt, EvanSpecOpt2, "HyperStat", EvanBase$CRROver, DemonAvenger=F)
  
  EvanFinalDPMwithMax <- EvanBoW(EvanDealCycle, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, 
                                 NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
  
  set(get(DPMCalcOption$DataName), as.integer(1), "Evan", sum(na.omit(EvanFinalDPMwithMax)) / (max(EvanDealCycle$Time) / 60000))

  EvanDealData <- data.frame(EvanDealCycle$Skills, EvanDealCycle$Time, EvanDealCycle$Restraint4, 
                             DealCalc(EvanDealCycle, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, Collapse=F, 
                                      NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR")))
  colnames(EvanDealData) <- c("Skills", "Time", "R4", "Deal")
  
  EvanDealCycle_2 <- EvanDealCycle
  EvanDealCycle_2[EvanDealCycle_2$Skills=="BreathofWind", ]$Skills <- "BreathofWindBonus"
  EvanDeal1 <- DealCalc(EvanDealCycle, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, Collapse=F, 
                        NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
  EvanDeal2 <- DealCalc(EvanDealCycle_2, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, Collapse=F, 
                        NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
  EvanDealRatio <- ResetDealRatio(list(EvanDealCycle, EvanDealCycle_2), list(EvanDeal1, EvanDeal2), 
                                  rep(max(EvanDealCycle$Time), 2), c(0.6518, 0.3482))
  
  set(get(DPMCalcOption$DataName), as.integer(3), "Evan", Deal_RR(EvanDealData))
  set(get(DPMCalcOption$DataName), as.integer(4), "Evan", Deal_40s(EvanDealData))
  
  EvanSpecMean <- ResetSpecMean("Evan", 
                                list(EvanDealCycle, EvanDealCycle_2), 
                                list(EvanDeal1, EvanDeal2), 
                                ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, rep(max(EvanDealCycle$Time), 2), c(0.6518, 0.3482))
  
  
  ## DoE(3) - DB - BoW
  DealCycle <- c("Skills", "Time", rownames(EvanBuff))
  EvanDealCycle2 <- t(rep(0, length(DealCycle)))
  colnames(EvanDealCycle2) <- DealCycle
  EvanDealCycle2 <- data.frame(EvanDealCycle2)
  
  EvanDealCycle2 <- EvanCycle(EvanDealCycle2, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal,
                              EvanSpec, 
                              180, 360, "DoE-DB-BoW", EvanCore[[2]])
  EvanDealCycle2 <- DealCycleFinal(EvanDealCycle2)
  EvanDealCycle2 <- EvanAddATK(EvanDealCycle2, 
                               ATKFinal, 
                               BuffFinal, 
                               SummonedFinal, 
                               Spec, 
                               "DoE-DB-BoW", 3, 3, F)
  
  EvanDoE3HitsDPM <- EvanBoW(EvanDealCycle2, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, 
                             NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
  EvanDoE3HitsDPM <- sum(na.omit(EvanDoE3HitsDPM)) / (max(EvanDealCycle2$Time) / 60000)
  
  EvanDealData2 <- data.frame(EvanDealCycle2$Skills, EvanDealCycle2$Time, EvanDealCycle2$Restraint4, 
                              DealCalc(EvanDealCycle2, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, Collapse=F, 
                                       NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR")))
  colnames(EvanDealData2) <- c("Skills", "Time", "R4", "Deal")
  
  EvanDoE3HitsRR <- Deal_RR(EvanDealData2)
  EvanDoE3Hits40s <- Deal_40s(EvanDealData2)
  
  print(data.frame(EvanDoE3HitsDPM=EvanDoE3HitsDPM, EvanDoE3HitsRR=EvanDoE3HitsRR, EvanDoE3Hits40s=EvanDoE3Hits40s))
} else {
  Idx1 <- c() ; Idx2 <- c()
  for(i in 1:length(PotentialOpt)) {
    if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
      Idx1 <- i
    }
  }
  for(i in 1:nrow(PotentialOpt[[Idx1]])) {
    if(rownames(PotentialOpt[[Idx1]])[i]=="Evan") {
      Idx2 <- i
    }
  }
  EvanSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
  EvanSpecOpt <- OptDataAdd(EvanSpec, EvanSpecOpt1, "Potential", EvanBase$CRROver, DemonAvenger=F)
  
  EvanSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
  EvanSpecOpt <- OptDataAdd(EvanSpecOpt, EvanSpecOpt2, "HyperStat", EvanBase$CRROver, DemonAvenger=F)
  
  ## SoT - DoE - DB
  DealCycle <- c("Skills", "Time", rownames(EvanBuff))
  EvanDealCycle3 <- t(rep(0, length(DealCycle)))
  colnames(EvanDealCycle3) <- DealCycle
  EvanDealCycle3 <- data.frame(EvanDealCycle3)
  
  EvanDealCycle3 <- EvanCycle(EvanDealCycle3, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal,
                              EvanSpec, 
                              180, 360, "SoT-DoE-DB", EvanCore[[2]])
  EvanDealCycle3 <- DealCycleFinal(EvanDealCycle3)
  EvanDealCycle3 <- EvanAddATK(EvanDealCycle3, 
                               ATKFinal, 
                               BuffFinal, 
                               SummonedFinal, 
                               Spec, 
                               "SoT-DoE-DB", 4, 4, F)
  
  EvanSoT4HitsDPM <- EvanBoW(EvanDealCycle3, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, 
                             NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR"))
  EvanSoT4HitsDPM <- sum(na.omit(EvanSoT4HitsDPM)) / (max(EvanDealCycle3$Time) / 60000)
  
  EvanDealData3 <- data.frame(EvanDealCycle3$Skills, EvanDealCycle3$Time, EvanDealCycle3$Restraint4, 
                              DealCalc(EvanDealCycle3, ATKFinal, BuffFinal, SummonedFinal, EvanSpecOpt, Collapse=F, 
                                       NotBuffCols=c("ElementalBlastFDR"), NotBuffColOption=c("FDR")))
  colnames(EvanDealData3) <- c("Skills", "Time", "R4", "Deal")
  
  EvanSoT4HitsRR <- Deal_RR(EvanDealData3)
  EvanSoT4Hits40s <- Deal_40s(EvanDealData3)
  
  print(data.frame(EvanSoT4HitsDPM=EvanSoT4HitsDPM, EvanSoT4HitsRR=EvanSoT4HitsRR, EvanSoT4Hits40s=EvanSoT4Hits40s))
}