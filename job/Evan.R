## Evan - Data
## Evan - Core
## Matrix Point Setting
EvanCore <- MatrixSet(PasSkills=c("CircleofMana", "DragonSparking", "MagicFragment", 
                                  "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "CircleofEarth_BrethofEarth_DiveofEarth", 
                                  "DragonBreath_BreathReturn", "DragonSwift", "SummonOnixDragon"), 
                      PasLvs=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                      PasMP=c(10, 10, 10, 10, 10, 10, 5, 5, 5), 
                      ActSkills=c("ElemantalBlast", "DragonBreak", "JodiacRay", "SpiralofMana",
                                  CommonV("Wizard", "Heroes")[c(1, 2, 4, 5)]), 
                      ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                      ActMP=c(5, 5, 5, 5, 5, 0, 5, 0), 
                      BlinkLv=1, 
                      BlinkMP=0, 
                      UsefulSkills=c("SharpEyes", "CombatOrders"), 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=SpecDefault, 
                      SelfBind=F)


## Evan - Basic Info
## CoolReduceHat Check Needed, Mikhail Link Check Needed, Wand vs Staff, Link Check Needed, Monster Life Set Check Needed(FinalATKBDR - Dragon Sparking Deal Ratio)
EvanBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=MobDefault,
                    SpecSet=SpecDefault, 
                    Job="Evan",
                    CoreData=EvanCore, 
                    BuffDurationNeeded=0, 
                    AbilList=c("BDR", "DisorderBDR"), 
                    LinkList=c("Mikhail", "DemonAvenger", "Evan", "CygnusKnights"), 
                    MonsterLife=MLTypeI21, 
                    Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", SpecDefault$WeaponType)[, 1:16],
                    WeaponType=SpecDefault$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="EvanDocument", ], 
                    Emblem=Emblem[rownames(Emblem)=="Heroes", ], 
                    CoolReduceHat=F)


## Evan - Passive
{option <- factor(c("ATK", "MainStat", "SubStat1"), levels=PSkill)
value <- c(10, 10, 10)
InheritedWill <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
LinkedMagic <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("CRR", "ATK"), levels=PSkill)
value <- c(15, 10)
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
value <- c(EvanCore[[2]][4, 2])
SpiralofManaPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(EvanCore[[2]][9, 2])
BlinkPassive <- data.frame(option, value)}

EvanPassive <- Passive(list(InheritedWill, LinkedMagic, HighWisdom, SpellMastery, ElementalReset, CriticalMagic, MagicAmplification, DragonPotential, MagicMastery, DragonFury, HighDragonPotential, 
                            SpiralofManaPassive, BlinkPassive))


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
info <- c(180, 0, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor(c("ImmuneIgnore"), levels=BSkill)
value <- c(10)
info <- c(180, 0, 630, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalReset <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(80 + 2 * EvanBase$SkillLv)
info <- c(180, 0, 600, F, F, F, F)
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
info <- c(60, 0, 30, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwiftReturnDebuff <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(1)
info <- c(60, 0, 30, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DiveReturnBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(20 + 2 * EvanBase$SkillLv)
info <- c(Cooldown(40, T, EvanBase$UnionChrs$CoolReduceP, EvanBase$CoolReduce), Cooldown(40, T, EvanBase$UnionChrs$CoolReduceP, EvanBase$CoolReduce), Delay(1160, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkFogBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * EvanCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * EvanCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(EvanCore[[2]][5, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * EvanCore[[2]][7, 2]) * MapleSoldier[1, 2]) * EvanBase$MainStatP), 5 + floor(EvanCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

EvanBuff <- Buff(list(MagicFragmentStack=MagicFragmentStack, Communion=Communion, ElementalBlastBuff=ElementalBlastBuff, ElementalBlastFDR=ElementalBlastFDR, MirSkill=MirSkill, FusionSkill=FusionSkill, 
                      JodiacRayStack=JodiacRayStack, JodiacRayRemained=JodiacRayRemained, SpiralofManaRedBuff=SpiralofManaRedBuff,
                      MagicBooster=MagicBooster, ElementalReset=ElementalReset, BlessofOnix=BlessofOnix, MapleSoldier=MapleSoldier, 
                      SwiftReturnDebuff=SwiftReturnDebuff, DiveReturnBuff=DiveReturnBuff, DarkFogBuff=DarkFogBuff, 
                      HeroesOath=HeroesOath, 
                      UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                      OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, 
                      Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MagicBooster(1020ms), UsefulSharpEyes, UsefulCombatOrders
EvanAllTimeBuff <- AllTimeBuff(EvanBuff)


## Evan - Union & HyperStat & SoulWeapon
EvanSpec <- JobSpec(JobBase=EvanBase, 
                    Passive=EvanPassive, 
                    AllTimeBuff=EvanAllTimeBuff, 
                    MobInfo=MobDefault, 
                    SpecSet=SpecDefault, 
                    WeaponName="Staff", 
                    UnionStance=0,
                    JobConstant=1.2)

EvanUnionRemained <- EvanSpec$UnionRemained
EvanHyperStatBase <- EvanSpec$HyperStatBase
EvanCoolReduceType <- EvanSpec$CoolReduceType
EvanSpec <- EvanSpec$Spec


## Evan - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * EvanCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * EvanCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EvanCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EvanCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EvanCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EvanCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Evan - Attacks
## Hyper : Dragon Swift - CoolTime Reduce / Drgon Dive - CoolTime Reduce / Dragon Dive - Earth Enhance / Dragon Breath - CoolTime Reduce / Dragon Breath - Wind Bonus Chance or Dragon Swift - Thunder Bonus ATK
option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][1, 2]>=40, 20, 0), 2 * EvanCore[[1]][1, 2])
info <- c(290 + EvanSpec$SkillLv, 4, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofMana1 <- rbind(data.frame(option, value), info) ## Cancel Delay : 240ms

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][1, 2]>=40, 20, 0), 2 * EvanCore[[1]][1, 2])
info <- c(330 + EvanSpec$SkillLv, 4, 510, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofMana2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][2, 2]>=40, 20, 0), 3 * EvanCore[[1]][2, 2])
info <- c(150, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedDragonSparking <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][3, 2]>=40, 20, 0), 2 * EvanCore[[1]][3, 2])
info <- c(110 + 2 * EvanSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][3, 2]>=40, 20, 0), 2 * EvanCore[[1]][3, 2])
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 1, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][3, 2]>=40, 20, 0), 2 * EvanCore[[1]][3, 2])
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 2, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment3 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][3, 2]>=40, 20, 0), 2 * EvanCore[[1]][3, 2])
info <- c(110 + 2 * EvanSpec$SkillLv + (100 + EvanSpec$SkillLv) * 3, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicFragment4 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 2 * EvanSpec$SkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkFog <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][4, 2]>=40, 20, 0), 2 * EvanCore[[1]][4, 2])
info <- c(108 + 212 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofWind <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][5, 2]>=40, 20, 0), 2 * EvanCore[[1]][5, 2])
info <- c(170 + 150 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofThunder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][6, 2]>=40, 20, 0), 2 * EvanCore[[1]][6, 2])
info <- c(320 + EvanSpec$SkillLv, 5, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CircleofEarth <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(95 + 320 + 2 * EvanSpec$SkillLv, 4, 0, NA, Cooldown(8, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonSwift <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(130 + 195 + EvanSpec$SkillLv, 3, 0, NA, Cooldown(8, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonDive <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][7, 2]>=40, 20, 0), 2 * EvanCore[[1]][7, 2])
info <- c(130 + 195 + EvanSpec$SkillLv, 3, 0, NA, Cooldown(10, T, 25 + EvanSpec$CoolReduceP, EvanSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonBreath <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][4, 2]>=40, 20, 0), 2 * EvanCore[[1]][4, 2])
info <- c(240 + EvanSpec$SkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwiftofWind <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][5, 2]>=40, 20, 0), 2 * EvanCore[[1]][5, 2])
info <- c(150 + 300 + EvanSpec$SkillLv, 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwiftofThunder <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][4, 2]>=40, 20, 0), 2 * EvanCore[[1]][4, 2])
info <- c(215 + EvanSpec$SkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofWind <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][4, 2]>=40, 20, 0), 2 * EvanCore[[1]][4, 2])
info <- c(215 + EvanSpec$SkillLv + 5 + EvanSpec$SkillLv + 85, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofWindBonus <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][6, 2]>=40, 20, 0), 2 * EvanCore[[1]][6, 2])
info <- c(280 + EvanSpec$SkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofEarth <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(EvanCore[[1]][6, 2]>=40, 20, 0), 2 * EvanCore[[1]][6, 2])
info <- c(190 + EvanSpec$SkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DiveofEarth <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * EvanCore[[2]][1, 2], 6, 780, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElementalBlast <- rbind(data.frame(option, value), info) ## ATKs : 0ms, 660ms, 1230ms, 2070ms

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * EvanCore[[2]][2, 2], 7, 0, NA, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonBreak <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * EvanCore[[2]][2, 2], 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ImperialBreath <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(150 + 6 * EvanCore[[2]][2, 2], 3, 30, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreakReturn <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(400 + 16 * EvanCore[[2]][3, 2], 6, 780, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JodiacRay <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][1, 2]>=40, 20, 0), 2 * EvanCore[[1]][1, 2])
info <- c(235 + EvanCore[[2]][4, 2], 6, 360, NA, 5 - 0.05 * EvanCore[[2]][4, 2], T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiralofMana <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(EvanCore[[1]][1, 2]>=40, 20, 0), 2 * EvanCore[[1]][1, 2])
info <- c(235 + EvanCore[[2]][4, 2], 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiralofManaRed <- rbind(data.frame(option, value), info)

EvanATK <- Attack(list(CircleofMana1=CircleofMana1, CircleofMana2=CircleofMana2, AdvancedDragonSparking=AdvancedDragonSparking, DarkFog=DarkFog, 
                       MagicFragment1=MagicFragment1, MagicFragment2=MagicFragment2, MagicFragment3=MagicFragment3, MagicFragment4=MagicFragment4, 
                       CircleofWind=CircleofWind, CircleofThunder=CircleofThunder, CircleofEarth=CircleofEarth, 
                       DragonSwift=DragonSwift, DragonDive=DragonDive, DragonBreath=DragonBreath, 
                       SwiftofWind=SwiftofWind, SwiftofThunder=SwiftofThunder, BreathofWind=BreathofWind, BreathofWindBonus=BreathofWindBonus, BreathofEarth=BreathofEarth, DiveofEarth=DiveofEarth, 
                       ElementalBlast=ElementalBlast, DragonBreak=DragonBreak, ImperialBreath=ImperialBreath, BreakReturn=BreakReturn, JodiacRay=JodiacRay, SpiralofMana=SpiralofMana, SpiralofManaRed=SpiralofManaRed, 
                       SpiderInMirror=SpiderInMirror))

SwiftofThunderHits <- 4