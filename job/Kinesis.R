## Kinesis - Data
## Kinesis - Core
KinesisCore <- MatrixSet(PasSkills=c("PsychicGrab_UltimatePsychicShot", "UltimateMaterial", "UltimateBPM", "Telekinesis", "PsychicDrain", "UltimateTrain", 
                                     "PsychicForce", "PsychoBreak", "EverPsychic"), 
                         PasLvs=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 10, 10, 0, 0, 0), 
                         ActSkills=c("PsychicTornado", "UltimateMovingMatter", "LawofGravity",
                                     na.omit(CommonV("Wizard", "Supernatural"))), 
                         ActLvs=c(25, 25, 25, 25, 1, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 0, 5, 5), 
                         BlinkLv=1, 
                         BlinkMP=5, 
                         UsefulSkills=c("SharpEyes", "CombatOrders"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault, 
                         SelfBind=F)


## Kinesis - Basic Info
## Link Check Needed, Ability Check Needed
KinesisBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Kinesis",
                       CoreData=KinesisCore, 
                       BuffDurationNeeded=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("Phantom", "Mikhail", "DemonAvenger", "Xenon"), 
                       MonsterLife=MLTypeI21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "ESPLimiter", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[44, ], 
                       Emblem=Emblem[14, ], 
                       CoolReduceHat=F)


## Kinesis - Passive
{option <- factor(c("CRR"), levels=PSkill)
value <- c(10)
ESP <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
PsychicForcePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
Najae1 <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
PsychicForce2Passive <- data.frame(option, value)

option <- factor(c("BDR", "ATKSpeed"), levels=PSkill)
value <- c(20, 1)
InnocentPower <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
Najae2 <- data.frame(option, value)

option <- factor(c("CRR", "MainStat"), levels=PSkill)
value <- c(10, 40)
ESPMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
PsychicForce3Passive <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
JeongsinGanghwa <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(20, 20)
Jeonggyo <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(30 + KinesisBase$PSkillLv)
PsychicChargingPassive <- data.frame(option, value)

option <- factor(c("ATK", "BDR"), levels=PSkill)
value <- c(50 + 2 * KinesisBase$PSkillLv, 20 + KinesisBase$PSkillLv)
ESPBattleOrder <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(30 + KinesisBase$PSkillLv)
Gakseong <- data.frame(option, value) ## Gakseong CDMR -> Buff(Ultimate Skill Only)

option <- factor(c("BuffDuration"), levels=PSkill)
value <- c(20 + KinesisBase$PSkillLv)
JeongsinJipjung <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(25 + KinesisBase$PSkillLv)
Jeondal <- data.frame(option, value)

option <- factor(c("Mastery", "CDMR"), levels=PSkill)
value <- c(70 + 2 * KinesisBase$PSkillLv, 10 + KinesisBase$PSkillLv)
Sukdal <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(KinesisCore[[2]][8, 2])
BlinkPassive <- data.frame(option, value)}

KinesisPassive <- Passive(list(ESP, PsychicForcePassive, Najae1, PsychicForce2Passive, InnocentPower, Najae2, ESPMastery, PsychicForce3Passive, JeongsinGanghwa, Jeonggyo, 
                               PsychicChargingPassive, ESPBattleOrder, Gakseong, JeongsinJipjung, Jeondal, Sukdal, BlinkPassive))


## Kinesis - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PP <- rbind(data.frame(option, value), info)

option <- factor(c("CDMR"), levels=BSkill)
value <- c(20 + KinesisBase$PSkillLv)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GakseongUltimate <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(20)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicForceDebuff <- rbind(data.frame(option, value), info)  ## Duration 30s

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(13, 16)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicGroundDebuff <- rbind(data.frame(option, value), info)  ## 1 target, Duration 45s

option <- factor(c("FDR"), levels=BSkill)
value <- c(15)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychoBreakBuff <- rbind(data.frame(option, value), info)  ## 30s

option <- factor(levels=BSkill)
value <- c()
info <- c(15, 5, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicDrain <- rbind(data.frame(option, value), info)  ## SummonDuration Applying Check Needed

option <- factor(levels=BSkill)
value <- c()
info <- c(22, 60, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LawofGravityDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LawofGravityFDR <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 900, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ESPBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicShield <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((KinesisBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(KinesisBase$SkillLv/2))))
info <- c(900 + 30 * KinesisBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 210, NA, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicOver <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * KinesisCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * KinesisCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(KinesisCore[[2]][4, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(5 + ceiling(KinesisCore[[2]][6, 2]/5))
info <- c(40, 120, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofMasteriaGoddess <- rbind(data.frame(option, value), info)}

KinesisBuff <- Buff(list(PP=PP, GakseongUltimate=GakseongUltimate, PsychicForceDebuff=PsychicForceDebuff, PsychicGroundDebuff=PsychicGroundDebuff, PsychoBreakBuff=PsychoBreakBuff, PsychicDrain=PsychicDrain, 
                         LawofGravityDebuff=LawofGravityDebuff, LawofGravityFDR=LawofGravityFDR, 
                         ESPBooster=ESPBooster, PsychicShield=PsychicShield, MapleSoldier=MapleSoldier, PsychicOver=PsychicOver, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, OverloadMana=OverloadMana, BlessofMasteriaGoddess=BlessofMasteriaGoddess, 
                         Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, PsychicShield
KinesisAllTimeBuff <- AllTimeBuff(KinesisBuff)


## Kinesis - Union & HyperStat & SoulWeapon
KinesisSpec <- JobSpec(JobBase=KinesisBase, 
                       Passive=KinesisPassive, 
                       AllTimeBuff=KinesisAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="ESPLimiter", 
                       UnionStance=0)

KinesisUnionRemained <- KinesisSpec$UnionRemained
KinesisHyperStatBase <- KinesisSpec$HyperStatBase
KinesisCoolReduceType <- KinesisSpec$CoolReduceType
KinesisSpec <- KinesisSpec$Spec


## Kinesis - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * KinesisCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * KinesisCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KinesisCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KinesisCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KinesisCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KinesisCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Kinesis - Attacks
## Hyper : Psychic Grab - Boss Point, Psychic Grab - Reinforce, Psychic Ground - Reduce Guard, Psychic Ground - Persist, Psycho Break - Enhance
option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicForce3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 240, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicGrab <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(KinesisCore[[1]][1, 2]>=40, 20, 0), 2 * KinesisCore[[1]][1, 2])
info <- c(470 + 4 * KinesisSpec$PSkillLv, 5, 600, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicSmashing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][4, 2]>=40, 20, 0), 3 * KinesisCore[[1]][4, 2])
info <- c(350, 0.7, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
Telekinesis <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 10 * KinesisSpec$SkillLv, 1, 360, NA, 30, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicGround <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, 45, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicCharging <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][8, 2]>=40, 20, 0), 2 * KinesisCore[[1]][8, 2])
info <- c(1000 + 7 * KinesisSpec$SkillLv, 4, 840, NA, 30, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychoBreak <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][2, 2]>=40, 20, 0), 2 * KinesisCore[[1]][2, 2])
info <- c(120 + 130 + 140 + 310 + 3 * KinesisSpec$SkillLv, 10, 810, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMeterial <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][6, 2]>=40, 20, 0), 2 * KinesisCore[[1]][6, 2])
info <- c(120 + 100 + 3 * KinesisSpec$SkillLv, 6, 810, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateTrain <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][3, 2]>=40, 20, 0), 2 * KinesisCore[[1]][3, 2])
info <- c(175 + 2 * KinesisSpec$SkillLv, 7, 0, 600, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateBPM <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][9, 2]>=40, 20, 0), 2 * KinesisCore[[1]][9, 2])
info <- c(400, 1, 0, NA, 120, F, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EverPsychic <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KinesisCore[[1]][9, 2]>=40, 20, 0), 2 * KinesisCore[[1]][9, 2])
info <- c(1500, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EverPsychicLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * KinesisCore[[2]][1, 2], 4, 720, NA, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornado <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(200)
info <- c(200 + 3 * KinesisCore[[2]][1, 2], 2, 720, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornadoObject <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(200)
info <- c(350 + 10 * KinesisCore[[2]][1, 2], 10, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornadoExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * KinesisCore[[2]][2, 2], 5, 630, 480, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMovingMatter <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(700 + 28 * KinesisCore[[2]][2, 2], 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMovingMatterExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * KinesisCore[[2]][3, 2], 6, 960, NA, 60, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravity <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * KinesisCore[[2]][3, 2], 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravityPull <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * KinesisCore[[2]][3, 2], 15, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravityExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1200 + 48 * KinesisCore[[2]][6, 2], 3, 0, 4000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OtherworldEmptiness <- rbind(data.frame(option, value), info)

KinesisATK <- Attack(list(PsychicForce3=PsychicForce3, PsychicGrab=PsychicGrab, PsychicSmashing=PsychicSmashing, Telekinesis=Telekinesis, PsychicGround=PsychicGround, PsychicCharging=PsychicCharging, 
                          PsychoBreak=PsychoBreak, 
                          UltimateMeterial=UltimateMeterial, UltimateTrain=UltimateTrain, UltimateBPM=UltimateBPM, EverPsychic=EverPsychic, EverPsychicLast=EverPsychicLast, 
                          PsychicTornado=PsychicTornado, PsychicTornadoObject=PsychicTornadoObject, PsychicTornadoExp=PsychicTornadoExp, 
                          UltimateMovingMatter=UltimateMovingMatter, UltimateMovingMatterExp=UltimateMovingMatterExp, LawofGravity=LawofGravity, LawofGravityPull=LawofGravityPull, LawofGravityExp=LawofGravityExp, 
                          OtherworldEmptiness=OtherworldEmptiness,
                          SpiderInMirror=SpiderInMirror))


## Kinesis - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(KinesisCore[[1]][5, 2]>=40, 20, 0), 5 * KinesisCore[[1]][5, 2])
info <- c(150, 1, 690, NA, 15, 5, F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
PsychicDrain <- rbind(data.frame(option, value), info)}

KinesisSummoned <- Summoned(list(PsychicDrain=PsychicDrain, 
                                 SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Kinesis - DealCycle
ATKFinal <- data.frame(KinesisATK)
ATKFinal$Delay[] <- Delay(ATKFinal$Delay, KinesisSpec$ATKSpeed)[]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)

BuffFinal <- data.frame(KinesisBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, KinesisSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(KinesisSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * KinesisSpec$SummonedDuration / 100, 0)
