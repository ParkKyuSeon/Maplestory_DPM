## Zero - Data
## Zero - VMatrix
ZeroCore <- MatrixSet(PasSkills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                  "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "WindCutter_GigaCrash", 
                                  "WindStrike_JumpingCrash", "StormBreak_EarthBreak", "ShadowRain"), 
                      PasLvs=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                      PasMP=c(10, 10, 10, 10, 10, 10, 10, 10, 10), 
                      ActSkills=c("LimitBreak", "JointAttack", "ShadowFlash", "EgoWeapon", 
                                  na.omit(CommonV("Warrior", "Transcedent"))), 
                      ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                      ActMP=c(5, 5, 5, 5, 5, 0, 0, 0), 
                      BlinkLv=1, 
                      BlinkMP=0, 
                      UsefulSkills=c("SharpEyes", "WindBooster"), 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=SpecDefault, 
                      SelfBind=F)


## Zero - Basic Info
## Link Check Needed
ZeroBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=MobDefault,
                    SpecSet=SpecDefaultZero, 
                    Job="Zero",
                    CoreData=ZeroCore, 
                    BuffDurationNeeded=0, 
                    AbilList=c("BDR", "DisorderBDR"), 
                    LinkList=c("Mikhail", "DemonAvenger", "Zero", "Phantom"), 
                    MonsterLife=MLTypeS21, 
                    Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 0, 0, 0, "LongSword", SpecDefault$WeaponType)[, 1:16],
                    WeaponType=SpecDefault$WeaponType, 
                    SubWeapon=SubWeapon[43, ], 
                    Emblem=Emblem[13, ], 
                    CoolReduceHat=F)


## Zero - Passive
## WeaponAddOption BDR : 0
{option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
DivineForce <- data.frame(option, value)

option <- factor(c("FDR", "MainStat"), levels=PSkill)
value <- c(25, 50)
ResolveTime <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "Mastery", "CRR", "ATKSpeed"), levels=PSkill)
value <- c(40, 5, 70, 15, 3)
Mastery <- data.frame(option, value)

option <- factor(c("BDR", "CRR", "ATKSpeed"), levels=PSkill)
value <- c(10, 20, 1)
RapidTime <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(50)
ImmuneBarrier <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "ATK"), levels=PSkill)
value <- c(-5, -5, -5)
NoWillofUnion <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(ZeroCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(ZeroCore[[2]][9, 2])
BlinkPassive <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(0 * 2)
WeaponAddOption <- data.frame(option, value)}

ZeroPassive <- Passive(list(DivineForce, ResolveTime, Mastery, RapidTime, ImmuneBarrier, NoWillofUnion, BodyofStealPassive, BlinkPassive, WeaponAddOption))


## Zero - Buff
{option <- factor(c("IGR", "CDMR"), levels=BSkill)
value <- c(30, 50)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Alpha <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "BDR", "FDR"), levels=BSkill)
value <- c(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 0, 0, 0, "HeavySword", SpecDefault$WeaponType)[, 6] - WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 0, 0, 0, "LongSword", SpecDefault$WeaponType)[, 6] + 40, 
           30, (1.49 / 1.34 - 1)*100)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Beta <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(3.1, 4, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Tag <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BetaTargetBDR <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ZeroBase$ChrLv * 5 + 18) * 0.15))
info <- c(900, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(25)
info <- c(30, 240, 540, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TimeDistortion <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(10)
info <- c(90, 180, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TimeHolding <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * ZeroCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ZeroCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(ZeroCore[[2]][5, 2] / 5), ceiling(ZeroCore[[2]][5, 2] / 5))
info <- c(80 + 2 * ZeroCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("ATK"), levels=BSkill)
value <- c(10 + 3 * ZeroCore[[2]][7, 2])
info <- c(30 + floor(ZeroCore[[2]][7, 2] / 2), 240, 480, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofRhinneBuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(30 + floor(ZeroCore[[2]][1, 2] / 5))
info <- c(30 + floor(ZeroCore[[2]][1, 2] / 2), 240, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LimitBreakBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CDMR"), levels=BSkill)
value <- c(20)
info <- c(4, 39, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalBindDebuff <- rbind(data.frame(option, value), info)}

ZeroBuff <- Buff(list(Alpha=Alpha, Beta=Beta, Tag=Tag, BetaTargetBDR=BetaTargetBDR, MapleSoldier=MapleSoldier, TimeDistortion=TimeDistortion, TimeHolding=TimeHolding, 
                      UsefulSharpEyes=UsefulSharpEyes, UsefulWindBooster=UsefulWindBooster, AuraWeaponBuff=AuraWeaponBuff, BlessofRhinneBuff=BlessofRhinneBuff, LimitBreakBuff=LimitBreakBuff, 
                      CriticalBindDebuff=CriticalBindDebuff, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## Petbuff : UsefulSharpEyes, UsefulWindBooster
ZeroAllTimeBuff <- AllTimeBuff(ZeroBuff)


## Zero - Union & HyperStat & SoulWeapon
ZeroSpec <- JobSpec(JobBase=ZeroBase, 
                    Passive=ZeroPassive, 
                    AllTimeBuff=ZeroAllTimeBuff, 
                    MobInfo=MobDefault, 
                    SpecSet=SpecDefault, 
                    WeaponName="LongSword", 
                    UnionStance=0)

ZeroUnionRemained <- ZeroSpec$UnionRemained
ZeroHyperStatBase <- ZeroSpec$HyperStatBase
ZeroCoolReduceType <- ZeroSpec$CoolReduceType
ZeroSpec <- ZeroSpec$Spec


## Zero - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * ZeroCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * ZeroCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Zero - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][1, 2]>=40, 20, 0), 3 * ZeroCore[[1]][1, 2])
info <- c(120, 6, 510, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
MoonStrike <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][2, 2]>=40, 20, 0), 3 * ZeroCore[[1]][2, 2])
info <- c(170, 6, 660, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PierceThrust <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][1, 2]>=40, 20, 0), 3 * ZeroCore[[1]][1, 2])
info <- c(195, 8, Delay(300, ZeroSpec$ATKSpeed) + 90, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowStrike <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][1, 2]>=40, 20, 0), 3 * ZeroCore[[1]][1, 2])
info <- c(310, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowStrikeAura <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(165, 8, 630, NA, 5, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
FlashAssaulter <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][3, 2]>=40, 20, 0), 2 * ZeroCore[[1]][3, 2])
info <- c(260 + 3 * ZeroSpec$SkillLv, 10, 840, NA, 5, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
SpinCutter <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][3, 2]>=40, 20, 0), 2 * ZeroCore[[1]][3, 2])
info <- c(130 + 3 * ZeroSpec$SkillLv, 4, 0, NA, 5, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
SpinCutterAura <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][4, 2]>=40, 20, 0), 2 * ZeroCore[[1]][4, 2])
info <- c(365 + 3 * ZeroSpec$SkillLv, 12, 1260, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
RollingCurve <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][4, 2]>=40, 20, 0), 2 * ZeroCore[[1]][4, 2])
info <- c(350 + ZeroSpec$SkillLv, 2, 0, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
RollingCurveAura <- rbind(data.frame(option, value), info) ## Assist

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][4, 2]>=40, 20, 0), 2 * ZeroCore[[1]][4, 2])
info <- c(350 + ZeroSpec$SkillLv, 1, 0, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
RollingCurveAura2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][5, 2]>=40, 20, 0), 2 * ZeroCore[[1]][5, 2])
info <- c(375 + 2 * ZeroSpec$SkillLv, 12, 1260, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
RollingAssaulter <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][5, 2]>=40, 20, 0), 2 * ZeroCore[[1]][5, 2])
info <- c(250 + ZeroSpec$SkillLv, 3, 0, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
RollingAssaulterAura <- rbind(data.frame(option, value), info) ## Assist

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][6, 2]>=40, 20, 0), 2 * ZeroCore[[1]][6, 2])
info <- c(165, 8, 720, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
WindCutter <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][6, 2]>=40, 20, 0), 2 * ZeroCore[[1]][6, 2])
info <- c(110, 3, 0, 510, 15, T, T ,F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
WindCutterVortex <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][7, 2]>=40, 20, 0), 2 * ZeroCore[[1]][7, 2])
info <- c(250, 8, 810, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
WindStrike <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(335 + 2 * ZeroSpec$SkillLv, 10, 900, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
StormBreak <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(335 + 2 * ZeroSpec$SkillLv, 4, 0, 510, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
StormBreakVortex <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(230 + 2 * ZeroSpec$SkillLv, 1, 0, 900, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
StormBreakFloor <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][1, 2]>=40, 20, 0), 3 * ZeroCore[[1]][1, 2])
info <- c(210, 6, 930, NA, 0, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UpperSlash <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][2, 2]>=40, 20, 0), 3 * ZeroCore[[1]][2, 2])
info <- c(330 + 5 * ZeroSpec$SkillLv, 9, 750, NA, 0, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PowerStump <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][2,2]>=40, 20, 0), 3 * ZeroCore[[1]][2,2])
info <- c(330 + 5 * ZeroSpec$SkillLv, 9, 0, NA, 0, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PowerStumpShockwave <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(205, 6, 840, NA, 5, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
FrontSlash <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][3, 2]>=40, 20, 0), 2 * ZeroCore[[1]][3, 2])
info <- c(550 + 5 * ZeroSpec$SkillLv, 2, 480, 300, 5, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ThrowingWeapon <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][4, 2]>=40, 20, 0), 2 * ZeroCore[[1]][4, 2])
info <- c(260, 6, 720, NA, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
TurningDrive <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][5, 2]>=40, 20, 0), 2 * ZeroCore[[1]][5, 2])
info <- c(200 + 2 * ZeroSpec$SkillLv, 2, 60, 120, 10, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
WhirlWind <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][6, 2]>=40, 20, 0), 2 * ZeroCore[[1]][6, 2])
info <- c(250, 6, 840, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
GigaCrash <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][7, 2]>=40, 20, 0), 2 * ZeroCore[[1]][7, 2])
info <- c(225, 6, Delay(390, ZeroSpec$ATKSpeed) + Delay(270, ZeroSpec$ATKSpeed), NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JumpingCrash <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][7,2 ]>=40, 20, 0), 2 * ZeroCore[[1]][7, 2])
info <- c(225, 3, 0, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JumpingCrashShockwave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(380 + 3 * ZeroSpec$SkillLv, 10, 1560, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EarthBreak <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(285 + 3 * ZeroSpec$SkillLv, 10, 0, NA, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EarthBreakShockwave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][8, 2]>=40, 20, 0), 2 * ZeroCore[[1]][8, 2])
info <- c(340 + 3 * ZeroSpec$SkillLv, 1, 0, 900, 15, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EarthBreakFloor <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][9, 2]>=40, 20, 0), 2 * ZeroCore[[1]][9, 2])
info <- c(1400, 14, 4410, NA, 300, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowRainAlpha <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ZeroCore[[1]][9, 2]>=40, 20, 0), 2 * ZeroCore[[1]][9, 2])
info <- c(1400, 14, 4980, NA, 300, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowRainBeta <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 15 * ZeroCore[[2]][1, 2], 5, 600, NA, 240, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LimitBreak <- rbind(data.frame(option, value), info) ## Beta

option <- factor(levels=ASkill)
value <- c()
info <- c(650 + 26 * ZeroCore[[2]][1, 2], 12, 0, 30, 240, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LimitBreakLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(875 + 35 * ZeroCore[[2]][2, 2], 8, 3240, 540, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JointAttack1 <- rbind(data.frame(option, value), info) ## Beta / 0ms(1), 540ms(2), 990ms(3), 1440ms(4), 2160ms(5), 2520ms(6), 3240ms(Last) / ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c(835 + 33 * ZeroCore[[2]][2, 2], 12, 0, 450, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JointAttack2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1000 + 40 * ZeroCore[[2]][2, 2], 13, 0, 360, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JointAttack3 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(900 + 36 * ZeroCore[[2]][2, 2], 15, 1380, 120, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
JointAttackLast <- rbind(data.frame(option, value), info) ## ATKSpeed Applied

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * ZeroCore[[2]][3, 2], 6, 670, NA, 40, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowFlashAlphaInstall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * ZeroCore[[2]][3, 2], 15, 880, 90, 40, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowFlashAlphaExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * ZeroCore[[2]][3, 2], 5, 670, NA, 40, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowFlashBetaInstall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * ZeroCore[[2]][3, 2], 12, 880, 150, 40, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
ShadowFlashBetaExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][4, 2], 6, 0, 120, 15, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EgoWeaponAlpha <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(175 + 7 * ZeroCore[[2]][4, 2], 9, 0, NA, 15, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EgoWeaponBeta <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * ZeroCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(125 + 5 * ZeroCore[[2]][7, 2], 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlessofRhinne <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 30, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AlphaWait <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 30, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BetaWait <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AlphatoBeta <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BetatoAlpha <- rbind(data.frame(option, value), info)}

ZeroATK <- Attack(list(MoonStrike=MoonStrike, PierceThrust=PierceThrust, ShadowStrike=ShadowStrike, ShadowStrikeAura=ShadowStrikeAura, 
                       FlashAssaulter=FlashAssaulter, SpinCutter=SpinCutter, SpinCutterAura=SpinCutterAura, 
                       RollingCurve=RollingCurve, RollingCurveAura=RollingCurveAura, RollingCurveAura2=RollingCurveAura2, RollingAssaulter=RollingAssaulter, RollingAssaulterAura=RollingAssaulterAura, 
                       WindCutter=WindCutter, WindCutterVortex=WindCutterVortex, WindStrike=WindStrike, StormBreak=StormBreak, StormBreakVortex=StormBreakVortex, StormBreakFloor=StormBreakFloor, 
                       UpperSlash=UpperSlash, PowerStump=PowerStump, PowerStumpShockwave=PowerStumpShockwave, 
                       FrontSlash=FrontSlash, ThrowingWeapon=ThrowingWeapon, 
                       TurningDrive=TurningDrive, WhirlWind=WhirlWind, 
                       GigaCrash=GigaCrash, JumpingCrash=JumpingCrash, JumpingCrashShockwave=JumpingCrashShockwave, EarthBreak=EarthBreak, EarthBreakShockwave=EarthBreakShockwave, EarthBreakFloor=EarthBreakFloor, 
                       ShadowRainAlpha=ShadowRainAlpha, ShadowRainBeta=ShadowRainBeta, 
                       LimitBreak=LimitBreak, LimitBreakLast=LimitBreakLast, JointAttack1=JointAttack1, JointAttack2=JointAttack2, JointAttack3=JointAttack3, JointAttackLast=JointAttackLast, 
                       ShadowFlashAlphaInstall=ShadowFlashAlphaInstall, ShadowFlashAlphaExp=ShadowFlashAlphaExp, ShadowFlashBetaInstall=ShadowFlashBetaInstall, ShadowFlashBetaExp=ShadowFlashBetaExp, 
                       EgoWeaponAlpha=EgoWeaponAlpha, EgoWeaponBeta=EgoWeaponBeta, AuraWeapon=AuraWeapon, BlessofRhinne=BlessofRhinne, 
                       AlphaWait=AlphaWait, BetaWait=BetaWait, AlphatoBeta=AlphatoBeta, BetatoAlpha=BetatoAlpha, SpiderInMirror=SpiderInMirror))


## Zero - Summoned
ZeroSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, 
                              SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Zero - DealCycle & Deal Calculation
ATKFinal <- data.frame(ZeroATK)
ATKFinal$Delay[c(-3, -23, -25, -32, -33, -36, -48, -49)] <- Delay(ATKFinal$Delay, ZeroSpec$ATKSpeed)[c(-3, -23, -25, -32, -33, -36, -48, -49)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ZeroSpec$CoolReduceP, ZeroSpec$CoolReduce)

BuffFinal <- data.frame(ZeroBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ZeroSpec$CoolReduceP, ZeroSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ZeroSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(ZeroSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ZeroSpec$CoolReduceP, ZeroSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ZeroSpec$SummonedDuration / 100, 0)


## Zero - Delay Skip Structure
ZeroSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
ZeroSkipATK <- data.frame(ZeroSkipATK, row.names=c(rownames(ATKFinal)))
colnames(ZeroSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

ZeroSkipATK$PierceThrust <- c(T, rep(F, 51))
ZeroSkipATK$ShadowStrike <- c(F, T, rep(F, 50))
ZeroSkipATK$SpinCutter <- c(F, F, F, F, T, rep(F, 47))
ZeroSkipATK$RollingAssaulter <- c(rep(F, 7), T, rep(F, 44))
ZeroSkipATK$WindStrike <- c(rep(F, 12), T, rep(F, 39))
ZeroSkipATK$StormBreak <- c(rep(F, 14), T, rep(F, 37))

ZeroSkipATK$PowerStump <- c(rep(F, 18), T, rep(F, 33))
ZeroSkipATK$ThrowingWeapon <- c(rep(F, 21), T, rep(F, 30))
ZeroSkipATK$WhirlWind <- c(rep(F, 23), T, rep(F, 28))
ZeroSkipATK$JumpingCrash <- c(rep(F, 25), T, rep(F, 26))
ZeroSkipATK$EarthBreak <- c(rep(F, 27), T, rep(F, 24))

ZeroSkipATK$SkippedDelay <- c(Delay(420, ZeroSpec$ATKSpeed), Delay(480, ZeroSpec$ATKSpeed), NA, NA, Delay(360, ZeroSpec$ATKSpeed), NA, NA, 
                              960, NA, NA, NA, NA, Delay(540, ZeroSpec$ATKSpeed), NA, Delay(630, ZeroSpec$ATKSpeed), NA, NA, NA, 
                              Delay(510, ZeroSpec$ATKSpeed), NA, NA, Delay(600, ZeroSpec$ATKSpeed), NA, Delay(480, ZeroSpec$ATKSpeed), NA, 
                              Delay(720, ZeroSpec$ATKSpeed), 510, rep(NA, 25))
ZeroSkipATK <- subset(ZeroSkipATK, ZeroSkipATK$SkippedDelay>0)


DealCycle <- c("Skills", "Time", rownames(ZeroBuff))
ZeroDealCycle <- t(rep(0, length(DealCycle)))
colnames(ZeroDealCycle) <- DealCycle
ZeroDealCycle <- data.frame(ZeroDealCycle)

ZeroCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure, 
                      Period=240, CycleTime=240, DealCycleType=c("WMM-WTWT", "WMM-WTWTA", "WMPMP-WTWT", "MMMW-WAWTA"), TagCancelDelay=60) {
  BuffSummonedPrior <- c("UsefulSharpEyes", "UsefulWindBooster", 
                         "AuraWeaponBuff", "TimeDistortion", "SoulContractLink", "LimitBreakBuff", "Restraint4")
  
  Times240 <- c(1, 1, 
                1, 1, 1, 1, 1)
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times240[i]==0, Inf, Times240[i])
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
  
  WMM <- function(DealCycle, AfterSkill=c("NA", "BlessofRhinneBuff_ShadowFlashExp_ShadowRain", "ShadowFlashInstall_ShadowFlashExp_ShadowRain", 
                                          "SoulContractLink", "TimeDistortion", "ShadowFlashInstall", "ShadowFlashExp")) {
    DealCycle <- DCATKSkip(DealCycle, "BetatoAlpha", ATKFinal, SkipStructure)
    DealCycle$Tag[nrow(DealCycle)] <- 3100
    DealCycle$Alpha[nrow(DealCycle)] <- 13100
    DealCycle$Beta[nrow(DealCycle)] <- 0
    DealCycle <- DCATKSkip(DealCycle, "WindCutter", ATKFinal, SkipStructure)
    DealCycle <- DCATKSkip(DealCycle, "WindStrike", ATKFinal, SkipStructure)
    DealCycle <- DCATKSkip(DealCycle, "StormBreak", ATKFinal, SkipStructure)
    
    if(AfterSkill=="NA") {
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowStrike", ATKFinal, SkipStructure)
      
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowStrike", ATKFinal, SkipStructure)
      DealCycle[1, 2:ncol(DealCycle)] <- TagCancelDelay
    } else if(AfterSkill=="BlessofRhinneBuff_ShadowFlashExp_ShadowRain") {
      DealCycle <- DCBuff(DealCycle, "BlessofRhinneBuff", BuffFinal)
      DealCycle <- DCATKSkip(DealCycle, "ShadowFlashAlphaExp", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowRainAlpha", ATKFinal, SkipStructure)
      DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Tag[nrow(DealCycle)]
    } else if(AfterSkill=="ShadowFlashInstall_ShadowFlashExp_ShadowRain") {
      DealCycle <- DCATKSkip(DealCycle, "ShadowFlashAlphaInstall", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowFlashAlphaExp", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowRainAlpha", ATKFinal, SkipStructure)
      DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Tag[nrow(DealCycle)]
    } else if(sum(AfterSkill==c("SoulContractLink", "TimeDistortion"))==1) {
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowStrike", ATKFinal, SkipStructure)
      
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCBuff(DealCycle, AfterSkill, BuffFinal)
      DealCycle[1, 2:ncol(DealCycle)] <- TagCancelDelay
    } else {
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowStrike", ATKFinal, SkipStructure)
      
      DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "PierceThrust", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, AfterSkill, ATKFinal, SkipStructure)
      DealCycle[1, 2:ncol(DealCycle)] <- TagCancelDelay
    }
    return(DealCycle)
  }
  WMMAssist <- function(AssistCycle, DealCycle, AfterSkill=c("NA", "BlessofRhinneBuff_ShadowFlashExp_ShadowRain", "ShadowFlashInstall_ShadowFlashExp_ShadowRain", 
                                                             "SoulContractLink", "TimeDistortion", "ShadowFlashInstall", "ShadowFlashExp")) {
    AssistNew <- subset(DealCycle, DealCycle$Skills=="BetatoAlpha")
    AssistNew <- AssistNew[nrow(AssistNew), ]
    
    if(sum(AfterSkill==c("BlessofRhinneBuff_ShadowFlashExp_ShadowRain", "ShadowFlashInstall_ShadowFlashExp_ShadowRain"))==1) {
      AssistNew <- rbind(AssistNew, AssistNew, AssistNew)
      AssistNew$Skills[1] <- "GigaCrash Assist"
      AssistNew$Skills[2] <- "JumpingCrash Assist"
      AssistNew$Skills[3] <- "EarthBreak Assist"
      
      AssistNew$Time[1] <- AssistNew$Time[1] + 60
      AssistNew$Time[2] <- AssistNew$Time[1] + 630
      AssistNew$Time[3] <- AssistNew$Time[2] + 510
    } else {
      AssistNew <- rbind(AssistNew, AssistNew, AssistNew, AssistNew, AssistNew, AssistNew)
      AssistNew$Skills[1] <- "GigaCrash Assist"
      AssistNew$Skills[2] <- "JumpingCrash Assist"
      AssistNew$Skills[3] <- "EarthBreak Assist"
      AssistNew$Skills[4] <- "UpperSlash Assist"
      AssistNew$Skills[5] <- "PowerStump Assist"
      AssistNew$Skills[6] <- "UpperSlash Assist"
      
      AssistNew$Time[1] <- AssistNew$Time[1] + 60
      AssistNew$Time[2] <- AssistNew$Time[1] + 630
      AssistNew$Time[3] <- AssistNew$Time[2] + 510
      AssistNew$Time[4] <- AssistNew$Time[3] + 720
      AssistNew$Time[5] <- AssistNew$Time[4] + 270
      AssistNew$Time[6] <- AssistNew$Time[5] + 720
    }
    
    AssistCycle <- rbind(AssistCycle, AssistNew)
    return(AssistCycle)
  }
  
  WTWTA <- function(DealCycle, AfterSkill=c("NA", "ShadowFlashExp_ShadowRain", "TimeHolding_JointAttack_ShadowFlashInstall_ShadowFlashExp", "JointAttack", 
                                           "SoulContractLink", "TimeDistortion", "ShadowFlashInstall", "ShadowFlashExp")) {
    DealCycle <- DCATKSkip(DealCycle, "AlphatoBeta", ATKFinal, SkipStructure)
    DealCycle$Tag[nrow(DealCycle)] <- 3100
    DealCycle$Beta[nrow(DealCycle)] <- 13100
    DealCycle$Alpha[nrow(DealCycle)] <- 0
    
    if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
      DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
      DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
    } ## LimitBreak LastATK FDR Accept Needed
    
    if(AfterSkill=="JointAttack") {
      DealCycle <- DCATKSkip(DealCycle, "TurningDrive", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "WhirlWind", ATKFinal, SkipStructure)
      
      DealCycle <- DCATKSkip(DealCycle, "JointAttack1", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "JointAttackLast", ATKFinal, SkipStructure)
    } else if(AfterSkill=="TimeHolding_JointAttack_ShadowFlashInstall_ShadowFlashExp") {
      DealCycle <- DCATKSkip(DealCycle, "TurningDrive", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "WhirlWind", ATKFinal, SkipStructure)
      
      DealCycle <- DCBuff(DealCycle, "TimeHolding", BuffFinal)
      DealCycle <- DCATKSkip(DealCycle, "JointAttack1", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "JointAttackLast", ATKFinal, SkipStructure)
      
      DealCycle <- DCATKSkip(DealCycle, "ShadowFlashBetaInstall", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ShadowFlashBetaExp", ATKFinal, SkipStructure)
      DealCycle[1, 2:ncol(DealCycle)] <- TagCancelDelay
    } else {
      DealCycle <- DCATKSkip(DealCycle, "TurningDrive", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "WhirlWind", ATKFinal, SkipStructure)
      if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
        DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
      }
      
      DealCycle <- DCATKSkip(DealCycle, "FrontSlash", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "ThrowingWeapon", ATKFinal, SkipStructure)
      if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
        DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
      }
      for(i in 1:5) {
        DealCycle <- DCATKSkip(DealCycle, "BetaWait", ATKFinal, SkipStructure)
      }
      
      DealCycle <- DCATKSkip(DealCycle, "TurningDrive", ATKFinal, SkipStructure)
      DealCycle <- DCATKSkip(DealCycle, "WhirlWind", ATKFinal, SkipStructure)
      if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
        DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
      }
      
      if(AfterSkill=="NA") {
        DealCycle <- DCATKSkip(DealCycle, "FrontSlash", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ThrowingWeapon", ATKFinal, SkipStructure)
        if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
          DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
          DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
        }
        
        DealCycle <- DCATKSkip(DealCycle, "UpperSlash", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "PowerStump", ATKFinal, SkipStructure)
        DealCycle[1, 2:ncol(DealCycle)] <- TagCancelDelay
      } else if(sum(AfterSkill==c("SoulContractLink", "TimeDistortion"))==1) {
        DealCycle <- DCATKSkip(DealCycle, "FrontSlash", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ThrowingWeapon", ATKFinal, SkipStructure)
        
        DealCycle <- DCBuff(DealCycle, AfterSkill, BuffFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Tag[nrow(DealCycle)]
      } else if(AfterSkill=="ShadowFlashExp_ShadowRain") {
        DealCycle <- DCATKSkip(DealCycle, "ShadowFlashBetaExp", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ShadowRainBeta", ATKFinal, SkipStructure)
        DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Tag[nrow(DealCycle)]
      } else {
        DealCycle <- DCATKSkip(DealCycle, "FrontSlash", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ThrowingWeapon", ATKFinal, SkipStructure)
        if(nrow(subset(DealCycle, DealCycle$Skills=="LimitBreakLast"))==0 & DealCycle$LimitBreakBuff[nrow(DealCycle)] < 4000 & DealCycle$LimitBreakBuff[nrow(DealCycle)] > 0) {
          DealCycle <- DCATKSkip(DealCycle, "LimitBreakLast", ATKFinal, SkipStructure)
          DealCycle$LimitBreakBuff[nrow(DealCycle)] <- 0
        }
        
        DealCycle <- DCATKSkip(DealCycle, AfterSkill, ATKFinal, SkipStructure)
        DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Tag[nrow(DealCycle)]
      }
    }
    return(DealCycle)
  }
  WTWTAAssist <- function(AssistCycle, DealCycle, AfterSkill=c("NA", "ShadowFlashExp_ShadowRain", "JointAttack_ShadowFlashInstall_ShadowFlashExp", "JointAttack", 
                                                              "SoulContractLink", "TimeDistortion", "ShadowFlashInstall", "ShadowFlashExp")) {
    AssistNew <- subset(DealCycle, DealCycle$Skills=="AlphatoBeta")
    AssistNew <- AssistNew[nrow(AssistNew), ]
    
    if(sum(AfterSkill==c("TimeHolding_JointAttack_ShadowFlashInstall_ShadowFlashExp", "JointAttack"))==1) {
      AssistNew <- rbind(AssistNew, AssistNew)
      AssistNew$Skills[1] <- "RollingCurve Assist"
      AssistNew$Skills[2] <- "RollingAssaulter Assist"
      
      AssistNew$Time[1] <- AssistNew$Time[1] + 60
      AssistNew$Time[2] <- AssistNew$Time[1] + 960
      AssistCycle <- rbind(AssistCycle, AssistNew)
      return(AssistCycle)
    } else if(sum(AfterSkill==c("ShadowFlashExp_ShadowRain"))==1) {
      AssistNew <- rbind(AssistNew, AssistNew, AssistNew, AssistNew, AssistNew)
      AssistNew$Skills[1] <- "RollingCurve Assist"
      AssistNew$Skills[2] <- "RollingAssaulter Assist"
      AssistNew$Skills[3] <- "SpinCutter Assist"
      AssistNew$Skills[4] <- "RollingCurve Assist"
      AssistNew$Skills[5] <- "RollingAssaulter Assist"
      
      AssistNew$Time[1] <- AssistNew$Time[1] + 60
      AssistNew$Time[2] <- AssistNew$Time[1] + 360
      AssistNew$Time[3] <- AssistNew$Time[2] + 600
      AssistNew$Time[4] <- AssistNew$Time[3] + 480
      AssistNew$Time[5] <- AssistNew$Time[4] + 960
      
      AssistCycle <- rbind(AssistCycle, AssistNew)
      return(AssistCycle)
    } else {
      AssistNew <- rbind(AssistNew, AssistNew, AssistNew, AssistNew, AssistNew, AssistNew)
      AssistNew$Skills[1] <- "RollingCurve Assist"
      AssistNew$Skills[2] <- "RollingAssaulter Assist"
      AssistNew$Skills[3] <- "SpinCutter Assist"
      AssistNew$Skills[4] <- "RollingCurve Assist"
      AssistNew$Skills[5] <- "RollingAssaulter Assist"
      AssistNew$Skills[6] <- "SpinCutter Assist"
      
      AssistNew$Time[1] <- AssistNew$Time[1] + 60
      AssistNew$Time[2] <- AssistNew$Time[1] + 360
      AssistNew$Time[3] <- AssistNew$Time[2] + 600
      AssistNew$Time[4] <- AssistNew$Time[3] + 480
      AssistNew$Time[5] <- AssistNew$Time[4] + 420
      AssistNew$Time[6] <- AssistNew$Time[5] + 600
      
      AssistCycle <- rbind(AssistCycle, AssistNew)
      return(AssistCycle)
    }
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$Alpha[2] <- 13100
  AssistCycle <- DealCycle[1, ]
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="LimitBreakBuff") {
        DealCycle <- DCATKSkip(DealCycle, "LimitBreak", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
      } 
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  
  if(DealCycleType=="WMM-WTWTA") {
    DealCycle <- WTWTA(DealCycle, "ShadowFlashExp_ShadowRain")
    AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "ShadowFlashExp_ShadowRain")
    
    DealCycle <- WMM(DealCycle, "BlessofRhinneBuff_ShadowFlashExp_ShadowRain")
    AssistCycle <- WMMAssist(AssistCycle, DealCycle, "BlessofRhinneBuff_ShadowFlashExp_ShadowRain")
    
    DealCycle <- WTWTA(DealCycle, "TimeHolding_JointAttack_ShadowFlashInstall_ShadowFlashExp")
    AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "TimeHolding_JointAttack_ShadowFlashInstall_ShadowFlashExp")
    
    DealCycle <- WMM(DealCycle, "ShadowFlashInstall_ShadowFlashExp_ShadowRain")
    AssistCycle <- WMMAssist(AssistCycle, DealCycle, "ShadowFlashInstall_ShadowFlashExp_ShadowRain")
    
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
        ## Time Distortion
        if(DealCycle$LimitBreakBuff[nrow(DealCycle)] < 33000 & nrow(subset(DealCycle, DealCycle$Skills=="TimeDistortion"))==1) {
          if(DealCycle$Beta[nrow(DealCycle)] > 0) {
            DealCycle <- WMM(DealCycle, "TimeDistortion")
            AssistCycle <- WMMAssist(AssistCycle, DealCycle, "TimeDistortion")
          } else {
            DealCycle <- WTWTA(DealCycle, "TimeDistortion")
            AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "TimeDistortion")
          }
        }
        ## Soul Contract
        else if(DealCycle$LimitBreakBuff[nrow(DealCycle)] < 18000 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink"))==1) {
          if(DealCycle$Beta[nrow(DealCycle)] > 0) {
            DealCycle <- WMM(DealCycle, "SoulContractLink")
            AssistCycle <- WMMAssist(AssistCycle, DealCycle, "SoulContractLink")
          } else {
            DealCycle <- WTWTA(DealCycle, "SoulContractLink")
            AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "SoulContractLink")
          }
        }
        ## Joint Attack
        else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$Delay - max(subset(DealCycle, DealCycle$Skills=="JointAttack1")$Time) >=
                subset(ATKFinal, rownames(ATKFinal)=="JointAttack1")$CoolTime * 1000 & DealCycle$Alpha[nrow(DealCycle)] > 0) {
          DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
          DealCycle <- WTWTA(DealCycle, "JointAttack")
          AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "JointAttack")
        }
        ## Shadow Flash - Beta
        else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 2850 - max(subset(DealCycle, DealCycle$Skills=="ShadowFlashBetaInstall")$Time) >=
                subset(ATKFinal, rownames(ATKFinal)=="ShadowFlashBetaInstall")$CoolTime * 1000 & nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashBetaInstall")) < 4 &
                DealCycle$Alpha[nrow(DealCycle)] > 0) {
          DealCycle <- WTWTA(DealCycle, "ShadowFlashBetaInstall")
          AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "ShadowFlashBetaInstall")
        }
        else if(BuffStartTime + min(subset(DealCycle, DealCycle$Skills=="ShadowFlashBetaInstall")$Time) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) < 
                subset(ATKFinal, rownames(ATKFinal)=="ShadowFlashBetaInstall")$CoolTime * 1000 + 5000 & 
                nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashBetaInstall")) == 4 & DealCycle$Alpha[nrow(DealCycle)] > 0) {
          DealCycle <- WTWTA(DealCycle, "ShadowFlashBetaInstall")
          AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "ShadowFlashBetaInstall")
        }
        else if(nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashBetaExp")) < 5 & 
                nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaExp")) == nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")) & DealCycle$Alpha[nrow(DealCycle)] > 0) {
          DealCycle <- WTWTA(DealCycle, "ShadowFlashBetaExp")
          AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "ShadowFlashBetaExp")
        }
        ## Shadow Flash - Alpha
        else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 3300 - max(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")$Time) >=
                subset(ATKFinal, rownames(ATKFinal)=="ShadowFlashAlphaInstall")$CoolTime * 1000 & nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")) < 4 &
                DealCycle$Beta[nrow(DealCycle)] > 0) {
          DealCycle <- WMM(DealCycle, "ShadowFlashAlphaInstall")
          AssistCycle <- WMMAssist(AssistCycle, DealCycle, "ShadowFlashAlphaInstall")
        }
        else if(BuffStartTime + min(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")$Time) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) < 
                subset(ATKFinal, rownames(ATKFinal)=="ShadowFlashAlphaInstall")$CoolTime * 1000 + 5000 & 
                nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")) == 4 & DealCycle$Beta[nrow(DealCycle)] > 0) {
          DealCycle <- WMM(DealCycle, "ShadowFlashAlphaInstall")
          AssistCycle <- WMMAssist(AssistCycle, DealCycle, "ShadowFlashAlphaInstall")
        }
        else if(nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaExp")) < 5 & 
                nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaExp")) == nrow(subset(DealCycle, DealCycle$Skills=="ShadowFlashAlphaInstall")) & DealCycle$Beta[nrow(DealCycle)] > 0) {
          DealCycle <- WMM(DealCycle, "ShadowFlashAlphaExp")
          AssistCycle <- WMMAssist(AssistCycle, DealCycle, "ShadowFlashAlphaExp")
        }
        ## General Cycle
        else {
          if(DealCycle$Beta[nrow(DealCycle)] > 0) {
            DealCycle <- WMM(DealCycle, "NA")
            AssistCycle <- WMMAssist(AssistCycle, DealCycle, "NA")
          } else {
            DealCycle <- WTWTA(DealCycle, "NA")
            AssistCycle <- WTWTAAssist(AssistCycle, DealCycle, "NA")
          }
        }
        print(DealCycle[nrow(DealCycle), ])
      }
      
      if(k != length(BuffList)) {
        for(i in 1:length(BuffList[[k]])) {
          if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
            DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          } else {
            DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          }
        }
      }
    }
  }
  if(DealCycle$Beta[nrow(DealCycle)] > 0) {
    DealCycle <- DCATKSkip(DealCycle, "MoonStrike", ATKFinal, SkipStructure)
    DealCycle$Tag[nrow(DealCycle)] <- 3100
    DealCycle$Alpha[nrow(DealCycle)] <- 13100
    DealCycle$Beta[nrow(DealCycle)] <- 0
    
    AssistCycle <- rbind(AssistCycle, DealCycle[nrow(DealCycle), ])
    AssistCycle$Time[nrow(AssistCycle)] <- AssistCycle$Time[nrow(AssistCycle)] + 60
    AssistCycle$Skills[nrow(AssistCycle)] <- "UpperSlash Assist"
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle <- DealCycleFinal(DealCycle)
  
  AssistCycle <- AssistCycle[-1, ]
  DealCycle <- rbind(DealCycle, AssistCycle)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(length(strsplit(DealCycle$Skills[i], split=" ")[[1]])==2) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  return(DealCycle)
}
ZeroAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, DealCycleType=c("WMM-WTWT", "WMM-WTWTA", "WMPMP-WTWT", "MMMW-WAWTA")) {
  ## Assist Text Remove
  for(i in 2:nrow(DealCycle)) {
    DealCycle$Skills[i] <- strsplit(DealCycle$Skills[i], split=" ")[[1]][1]
  }
  
  
  ## Shadow Strike (Aura), Spin Cutter (Aura), Rolling Curve(Aura), Rolling Assaulter(Aura), Wind Cutter(Vortex), Storm Break(Vortex, Floor)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ShadowStrike") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ShadowStrikeAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 900
    } else if(DealCycle$Skills[i]=="SpinCutter") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "SpinCutterAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 420
    } else if(DealCycle$Skills[i]=="RollingCurve") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingCurveAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 240
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingCurveAura2"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 1380 # 50% Hit
    } else if(DealCycle$Skills[i]=="RollingAssaulter") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingAssaulterAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 120
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingAssaulterAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 480
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingAssaulterAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 1410
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RollingAssaulterAura"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 1710
    } else if(DealCycle$Skills[i]=="WindCutter") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "WindCutterVortex"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 90
    } else if(DealCycle$Skills[i]=="StromBreak") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "StormBreakVortex"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 270
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "StormBreakFloor"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 2000
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ShadowStrikeAura", "SpinCutterAura", "RollingCurveAura", "RollingCurveAura2", "RollingAssaulterAura", 
                                  "WindCutterVortex", "StormBreakVortex", "StormBreakFloor"))==1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  DealCycle <- RepATKCycle(DealCycle, "WindCutterVortex", ifelse(DealCycle!="MMMW-WAWTA", 2, 6), 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "StormBreakFloor", 3, 0, ATKFinal)
  
  
  ## Power Stump(Shockwave), Throwing Weapon, Jumping Crash(Shockwave), Earth Break(Shockwave, Floor)
  for(i in 2:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i]=="PowerStump") {
      if(nrow(subset(DealCycle[(i+1):nrow(DealCycle), ], DealCycle[(i+1):nrow(DealCycle), ]$Skills=="PowerStump"))!=0) { 
         if(min(subset(DealCycle[(i+1):nrow(DealCycle), ], DealCycle[(i+1):nrow(DealCycle), ]$Skills=="PowerStump")$Time) > DealCycle$Time[i] + 960) {
           DealCycle <- rbind(DealCycle, DealCycle[i, ])
           DealCycle$Skills[nrow(DealCycle)] <- "PowerStumpShockwave"
           DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 960
         }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "PowerStumpShockwave"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 960
      }
    } else if(DealCycle$Skills[i]=="JumpingCrash") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "JumpingCrashShockwave"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 270
    } else if(DealCycle$Skills[i]=="EarthBreak") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "EarthBreakShockwave"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 690
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "EarthBreakFloor"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 2700
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PowerStumpShockwave", "JumpingCrashShockwave", "EarthBreakShockwave", "EarthBreakFloor"))==1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  DealCycle <- RepATKCycle(DealCycle, "EarthBreakFloor", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ThrowingWeapon", 5, 480, ATKFinal)
  
  
  # Joint Attack
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="JointAttack1") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "JointAttack2"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 990
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "JointAttack3"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 2160
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("JointAttack2", "JointAttack3"))==1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  DealCycle <- RepATKCycle(DealCycle, "JointAttack1", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JointAttack2", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JointAttack3", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JointAttackLast", 3, 0, ATKFinal)
  
  
  ## Limit Break(Last), Shadow Flash(Explosion)
  DealCycle <- RepATKCycle(DealCycle, "LimitBreak", 6, 240, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ShadowFlashAlphaExp", 3, 510, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ShadowFlashBetaExp", 2, 510, ATKFinal)
  
  
  ## Ego Weapon
  
  
  ## Aura Weapon
  
  
  ## Bless of Rhinne
  
  
  ## Spider In Mirror
  
  
  ## Alpha / Beta Change, Beta Target BDR
  
  
  ## Critical Bind
  
  
  ## Dummy Reduction
}


ZeroDealCycle <- ZeroCycle(DealCycle=ZeroDealCycle, 
                           ATKFinal, 
                           BuffFinal, 
                           SummonedFinal, 
                           Spec=ZeroSpec, 
                           SkipStructure=ZeroSkipATK,
                           Period=240, 
                           CycleTime=240, 
                           DealCycleType="WMM-WTWTA", 
                           TagCancelDelay=60)
ZeroDealCycleTest <- ZeroAddATK(DealCycle=ZeroDealCycle, 
                                ATKFinal, 
                                BuffFinal, 
                                SummonedFinal, 
                                Spec=ZeroSpec, 
                                DealCycleType="WMM-WTWTA")

ZeroDealCycleTest[1:400, ]
nrow(subset(ZeroDealCycleTest, ZeroDealCycleTest$Skills=="PowerStump"))
nrow(subset(ZeroDealCycleTest, ZeroDealCycleTest$Skills=="PowerStumpShockwave"))