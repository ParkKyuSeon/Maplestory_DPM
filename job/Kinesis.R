## Kinesis - Data
## Kinesis - Core
KinesisCoreBase <- CoreBuilder(ActSkills=c("PsychicTornado", "UltimateMovingMatter", "UltimatePsychicBullet", "LawofGravity",
                                           na.omit(CommonV("Wizard", "Supernatural"))), 
                               ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25), 
                               UsefulSkills=c("SharpEyes", "CombatOrders"), 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               VPassiveList=KinesisVPassive, 
                               VPassivePrior=KinesisVPrior, 
                               SelfBind=F)

KinesisCore <- MatrixSet(PasSkills=KinesisCoreBase$PasSkills$Skills, 
                         PasLvs=KinesisCoreBase$PasSkills$Lv, 
                         PasMP=KinesisCoreBase$PasSkills$MP, 
                         ActSkills=KinesisCoreBase$ActSkills$Skills, 
                         ActLvs=KinesisCoreBase$ActSkills$Lv, 
                         ActMP=KinesisCoreBase$ActSkills$MP, 
                         UsefulSkills=KinesisCoreBase$UsefulSkills, 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         SpecialCore=KinesisCoreBase$SpecialCoreUse)


## Kinesis - Basic Info
## Ability Check Needed
KinesisBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=get(DPMCalcOption$MobSet),
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       Job="Kinesis",
                       CoreData=KinesisCore, 
                       BuffDurationNeeded=0, 
                       AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Kinesis"), 
                       LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Kinesis"), 
                       MonsterLife=get(FindJob(MonsterLifePreSet, "Kinesis")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                       Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "ESPLimiter", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                       WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                       SubWeapon=SubWeapon[rownames(SubWeapon)=="ChessPiece", ], 
                       Emblem=Emblem[rownames(Emblem)=="Kinesis", ], 
                       CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Kinesis")))


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
value <- c(30 + KinesisBase$SkillLv)
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
value <- c(GetCoreLv(KinesisCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(KinesisCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

KinesisPassive <- Passive(list(ESP, PsychicForcePassive, Najae1, PsychicForce2Passive, InnocentPower, Najae2, ESPMastery, PsychicForce3Passive, JeongsinGanghwa, Jeonggyo, 
                               PsychicChargingPassive, ESPBattleOrder, Gakseong, JeongsinJipjung, Jeondal, Sukdal, BlinkPassive, RopeConnectPassive))


## Kinesis - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PP <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateBPMPP <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicOverPP <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicDrainPP <- rbind(data.frame(option, value), info)

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
PsychicForceDebuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(13, 16)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicGroundDebuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(15)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychoBreakBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(15)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicShotDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(15, 5, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicDrain <- rbind(data.frame(option, value), info)

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
info <- c(180, NA, 0, T, F, F, T)
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
info <- c(30, 210, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PsychicOver <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(KinesisCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(KinesisCore, "OverloadMana")/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(5 + ceiling(GetCoreLv(KinesisCore, "BlessofMasteriaGoddess")/5))
info <- c(40, 120, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofMasteriaGoddess <- rbind(data.frame(option, value), info)}

KinesisBuff <- list(PP=PP, UltimateBPMPP=UltimateBPMPP, PsychicOverPP=PsychicOverPP, PsychicDrainPP=PsychicDrainPP, 
                    GakseongUltimate=GakseongUltimate, PsychicForceDebuff=PsychicForceDebuff, PsychicGroundDebuff=PsychicGroundDebuff, PsychoBreakBuff=PsychoBreakBuff, 
                    PsychicDrain=PsychicDrain, PsychicShotDebuff=PsychicShotDebuff, LawofGravityDebuff=LawofGravityDebuff, LawofGravityFDR=LawofGravityFDR, 
                    ESPBooster=ESPBooster, PsychicShield=PsychicShield, MapleSoldier=MapleSoldier, PsychicOver=PsychicOver, 
                    UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, OverloadMana=OverloadMana, BlessofMasteriaGoddess=BlessofMasteriaGoddess, 
                    Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, PsychicShield, ESPBooster, MapleSoldier, (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  KinesisBuff[[length(KinesisBuff)+1]] <- UsefulAdvancedBless
  names(KinesisBuff)[[length(KinesisBuff)]] <- "UsefulAdvancedBless"
}
KinesisBuff <- Buff(KinesisBuff)
KinesisAllTimeBuff <- AllTimeBuff(KinesisBuff)


## Kinesis - Union & HyperStat & SoulWeapon
KinesisSpec <- JobSpec(JobBase=KinesisBase, 
                       Passive=KinesisPassive, 
                       AllTimeBuff=KinesisAllTimeBuff, 
                       MobInfo=get(DPMCalcOption$MobSet), 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       WeaponName="ESPLimiter", 
                       UnionStance=0)

KinesisUnionRemained <- KinesisSpec$UnionRemained
KinesisHyperStatBase <- KinesisSpec$HyperStatBase
KinesisCoolReduceType <- KinesisSpec$CoolReduceType
KinesisSpec <- KinesisSpec$Spec


## Kinesis - Spider In Mirror
SIM <- SIMData(GetCoreLv(KinesisCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Kinesis - Attacks
## Hyper : Psychic Grab - Boss Point, Psychic Grab - Reinforce, Psychic Ground - Reduce Guard, Psychic Ground - Persist, Psycho Break - Enhance
{option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, NA, 1, F, F, F)
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
value <- c(20, ifelse(GetCoreLv(KinesisCore, "PsychicGrab_UltimatePsychicShot")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "PsychicGrab_UltimatePsychicShot"))
info <- c(470 + 4 * KinesisSpec$PSkillLv, 5, 600, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicSmashing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "Telekinesis")>=40, 20, 0), 3 * GetCoreLv(KinesisCore, "Telekinesis"))
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
info <- c(0, 0, 0, NA, 45 - KinesisSpec$SkillLv, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicCharging <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "PsychoBreak")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "PsychoBreak"))
info <- c(1000 + 7 * KinesisSpec$SkillLv, 4, 840, NA, 30, T, T, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychoBreak <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "UltimateMaterial")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "UltimateMaterial"))
info <- c(120 + 130 + 140 + 310 + 3 * KinesisSpec$SkillLv, 10, 810, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMaterial <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "UltimateTrain")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "UltimateTrain"))
info <- c(120 + 100 + 3 * KinesisSpec$SkillLv, 6, 810, 660, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateTrain <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KinesisCore, "PsychicGrab_UltimatePsychicShot")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "PsychicGrab_UltimatePsychicShot"))
info <- c(300 + 3 * KinesisSpec$PSkillLv, 3 * 5 * 2 * 0.8, 870, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimatePsychicShot <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "UltimateBPM")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "UltimateBPM"))
info <- c(175 + 2 * KinesisSpec$SkillLv, 7, 0, 600, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateBPM <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "EverPsychic")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "EverPsychic"))
info <- c(400, 1, 60, 360, 120, F, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EverPsychic <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "EverPsychic")>=40, 20, 0), 2 * GetCoreLv(KinesisCore, "EverPsychic"))
info <- c(1500, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
EverPsychicLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(KinesisCore, "PsychicTornado"), 4, 720, 1000, 120, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornado <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(200)
info <- c(200 + 3 * GetCoreLv(KinesisCore, "PsychicTornado"), 2, 720, NA, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornadoObject <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(200)
info <- c(350 + 10 * GetCoreLv(KinesisCore, "PsychicTornado"), 10, 0, 120, 0, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
PsychicTornadoExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(KinesisCore, "UltimateMovingMatter"), 5, 630, 480, 90, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMovingMatter <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(700 + 28 * GetCoreLv(KinesisCore, "UltimateMovingMatter"), 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
UltimateMovingMatterExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * GetCoreLv(KinesisCore, "LawofGravity"), 6, 960, NA, 60, T, F, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravity <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(KinesisCore, "LawofGravity"), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravityPull <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * GetCoreLv(KinesisCore, "LawofGravity"), 15, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo,info)
colnames(info) <- c("option", "value")
LawofGravityExp <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1200 + 48 * GetCoreLv(KinesisCore, "BlessofMasteriaGoddess"), 3, 0, 4000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OtherworldEmptiness <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 90, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Delay1 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 240, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Delay2 <- rbind(data.frame(option, value), info)}

KinesisATK <- Attack(list(PsychicForce3=PsychicForce3, PsychicGrab=PsychicGrab, PsychicSmashing=PsychicSmashing, Telekinesis=Telekinesis, PsychicGround=PsychicGround, PsychicCharging=PsychicCharging, 
                          PsychoBreak=PsychoBreak, 
                          UltimateMaterial=UltimateMaterial, UltimateTrain=UltimateTrain, UltimatePsychicShot=UltimatePsychicShot, UltimateBPM=UltimateBPM, EverPsychic=EverPsychic, EverPsychicLast=EverPsychicLast, 
                          PsychicTornado=PsychicTornado, PsychicTornadoObject=PsychicTornadoObject, PsychicTornadoExp=PsychicTornadoExp, 
                          UltimateMovingMatter=UltimateMovingMatter, UltimateMovingMatterExp=UltimateMovingMatterExp, LawofGravity=LawofGravity, LawofGravityPull=LawofGravityPull, LawofGravityExp=LawofGravityExp, 
                          OtherworldEmptiness=OtherworldEmptiness,
                          Delay1=Delay1, Delay2=Delay2, 
                          SpiderInMirror=SpiderInMirror))


## Kinesis - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(KinesisCore, "PsychicDrain")>=40, 20, 0), 5 * GetCoreLv(KinesisCore, "PsychicDrain"))
info <- c(150, 1, Delay(690, KinesisSpec$ATKSpeed), 500, 14.9, 5, F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
PsychicDrainATK <- rbind(data.frame(option, value), info)}

KinesisSummoned <- Summoned(list(PsychicDrainATK=PsychicDrainATK, 
                                 SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Kinesis - DealCycle
ATKFinal <- data.frame(KinesisATK)
ATKFinal$Delay[c(-5, -12, -23, -24)] <- Delay(ATKFinal$Delay, KinesisSpec$ATKSpeed)[c(-5, -12, -23, -24)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)
ATKFinalUltimateTrain <- function(ATKFinal) {
  UT <- subset(ATKFinal, rownames(ATKFinal)=="UltimateTrain")
  
  for(i in 1:16) {
    UT <- rbind(UT, UT[nrow(UT), ])
    rownames(UT)[nrow(UT)] <- paste("UltimateTrain", i + 1, sep="")
    
    UT$Damage[nrow(UT)] <- UT$Damage[nrow(UT)] - 5
  }
  UT <- UT[-1, ]
  return(rbind(ATKFinal, UT))
}
ATKFinal <- ATKFinalUltimateTrain(ATKFinal)

BuffFinal <- data.frame(KinesisBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, KinesisSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(KinesisSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, KinesisSpec$CoolReduceP, KinesisSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * KinesisSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(KinesisBuff))
KinesisDealCycle <- t(rep(0, length(DealCycle)))
colnames(KinesisDealCycle) <- DealCycle
KinesisDealCycle <- data.frame(KinesisDealCycle)

KinesisCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(360), PsychicShotUse=c(T, F)) {
  BuffSummonedPrior <- c("ESPBooster", "PsychicShield", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "BlessofMasteriaGoddess", "SoulContractLink", "PsychicOver")
  Times180 <- c(0, 0, 0, 0, 0, 0, 
                1.5, 2, 0.5)
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
  
  DealCycle <- DCATK(DealCycle, "UltimateBPM", ATKFinal)
  DealCycle$PP[2] <- 15
  DealCycle$UltimateBPMPP[2] <- 600
  
  KIStack <- function(DealCycle) {
    ## PP By Skill
    if(DealCycle$Skills[nrow(DealCycle)]=="PsychicSmashing") {
      DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[(nrow(DealCycle)-1)] + 2)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PsychicForce3", "PsychicGround", "PsychoBreak")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[(nrow(DealCycle)-1)] + 1)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("EverPsychic")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- ifelse(DealCycle$PsychicOver[nrow(DealCycle)] > 0, 39, 38)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PsychicCharging")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[(nrow(DealCycle)-1)] + floor((40 - DealCycle$PP[(nrow(DealCycle)-1)]) / 2))
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateMaterial")) >= 1 & DealCycle$PsychicOver[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 3)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateMaterial")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 7)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateTrain", "PsychicTornado")) >= 1 & DealCycle$PsychicOver[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 7)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateTrain", "PsychicTornado")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 15)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimatePsychicShot", "LawofGravity")) >= 1 & DealCycle$PsychicOver[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 2)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimatePsychicShot", "LawofGravity")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 5)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateMovingMatter")) >= 1 & DealCycle$PsychicOver[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 5)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UltimateMovingMatter")) >= 1) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[(nrow(DealCycle)-1)] - 10)
    } else {
      DealCycle$PP[nrow(DealCycle)] <- DealCycle$PP[(nrow(DealCycle)-1)]
    }
    
    ## PP By Ultimate BPM
    if(DealCycle$UltimateBPMPP[nrow(DealCycle)-1] >= 0 & DealCycle$UltimateBPMPP[nrow(DealCycle)]==0) {
      DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[nrow(DealCycle)] - 1)
      DealCycle$UltimateBPMPP[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 600, 600 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$UltimateBPMPP[nrow(DealCycle)-1]))
      if(DealCycle$UltimateBPMPP[nrow(DealCycle)] < 0) {
        while(DealCycle$UltimateBPMPP[nrow(DealCycle)] < 0) {
          DealCycle$PP[nrow(DealCycle)] <- max(0, DealCycle$PP[nrow(DealCycle)] - 1)
          DealCycle$UltimateBPMPP[nrow(DealCycle)] <- DealCycle$UltimateBPMPP[nrow(DealCycle)] + 600
        }
      }
    } 
    
    ## PP By Psychic Over
    if(DealCycle$PsychicOverPP[nrow(DealCycle)-1] >= 0 & DealCycle$PsychicOverPP[nrow(DealCycle)]==0 & DealCycle$PsychicOver[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[nrow(DealCycle)] + 1)
      DealCycle$PsychicOverPP[nrow(DealCycle)] <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicOver", 
                                                         750, 750 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$PsychicOverPP[nrow(DealCycle)-1]))
      if(DealCycle$PsychicOverPP[nrow(DealCycle)] < 0) {
        while(DealCycle$PsychicOverPP[nrow(DealCycle)] < 0) {
          DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[nrow(DealCycle)] + 1)
          DealCycle$PsychicOverPP[nrow(DealCycle)] <- DealCycle$PsychicOverPP[nrow(DealCycle)] + 750
        }
      }
    } 
    
    ## PP By Psychic Drain
    if(DealCycle$PsychicDrainPP[nrow(DealCycle)-1] >= 0 & DealCycle$PsychicDrainPP[nrow(DealCycle)]==0 & DealCycle$PsychicDrain[nrow(DealCycle)] > 0) {
      DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[nrow(DealCycle)] + 1)
      DealCycle$PsychicDrainPP[nrow(DealCycle)] <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicDrain", 
                                                          500, 500 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$PsychicDrainPP[nrow(DealCycle)-1]))
      if(DealCycle$PsychicDrainPP[nrow(DealCycle)] < 0) {
        while(DealCycle$PsychicDrainPP[nrow(DealCycle)] < 0) {
          DealCycle$PP[nrow(DealCycle)] <- min(40, DealCycle$PP[nrow(DealCycle)] + 1)
          DealCycle$PsychicDrainPP[nrow(DealCycle)] <- DealCycle$PsychicDrainPP[nrow(DealCycle)] + 500
        }
      }
    }
    
    ## Buff / Debuff Connection
    if(DealCycle$Skills[nrow(DealCycle)]=="PsychicForce3") {
      DealCycle$PsychicForceDebuff[nrow(DealCycle)] <- 30000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="PsychicGround") {
      DealCycle$PsychicGroundDebuff[nrow(DealCycle)] <- 45000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="PsychoBreak") {
      DealCycle$PsychoBreakBuff[nrow(DealCycle)] <- 30000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="UltimatePsychicShot") {
      DealCycle$PsychicShotDebuff[nrow(DealCycle)] <- 10000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="PsychicDrainATKSummoned") {
      DealCycle$PsychicDrain[nrow(DealCycle)] <- BuffFinal[rownames(BuffFinal)=="PsychicDrain", ]$Duration * 1000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="LawofGravity") {
      DealCycle$LawofGravityDebuff[nrow(DealCycle)] <- BuffFinal[rownames(BuffFinal)=="LawofGravityDebuff", ]$Duration * 1000
    }
    return(DealCycle)
  }
  TornadoThrowing <- function(DealCycle) {
    if(nrow(subset(DealCycle, DealCycle$Skills=="PsychicTornado")) > 0) {
      if(nrow(subset(DealCycle, DealCycle$Skills=="PsychicTornado")) > nrow(subset(DealCycle, DealCycle$Skills=="PsychicTornadoObject")) & 
         DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="PsychicTornado")$Time) >= 20000) {
        DealCycle[1, 2:ncol(DealCycle)] <- 20000 - (DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PsychicTornado")$Time))
        DealCycle <- DCATK(DealCycle, "PsychicTornadoObject", ATKFinal)
        DealCycle <- KIStack(DealCycle)
      }
    }
    return(DealCycle)
  }
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="BlessofMasteriaGoddess") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- KIStack(DealCycle)
      } 
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- KIStack(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- KIStack(DealCycle)
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
  
  PGCool <- subset(ATKFinal, rownames(ATKFinal)=="PsychicGround")$CoolTime * 1000
  PCCool <- subset(ATKFinal, rownames(ATKFinal)=="PsychicCharging")$CoolTime * 1000
  EPCool <- subset(ATKFinal, rownames(ATKFinal)=="EverPsychic")$CoolTime * 1000
  PTCool <- subset(ATKFinal, rownames(ATKFinal)=="PsychicTornado")$CoolTime * 1000
  MMCool <- subset(ATKFinal, rownames(ATKFinal)=="UltimateMovingMatter")$CoolTime * 1000
  LGCool <- subset(ATKFinal, rownames(ATKFinal)=="LawofGravity")$CoolTime * 1000
  R4Cool <- subset(BuffFinal, rownames(BuffFinal)=="Restraint4")$CoolTime * 1000
  TRCool <- 12000
  
  PGRemain <- 0 ; PCRemain <- 0 ; EPRemain <- 0 ; PTRemain <- 0 ; MMRemain <- 0 ; LGRemain <- 0 ; R4Remain <- 0 ; GrabRemain <- 0 ; TRRemain <- 0
  PsychicGrabStack <- 0
  
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
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        }
      }
      ## Psychic Drain (Buff/Debuff)
      if(DealCycle$PsychicDrain[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCSummoned(DealCycle, "PsychicDrainATK", SummonedFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Psychic Ground + Psychic Force + Psycho Break (Buff/Debuff)
      else if(PGRemain == 0) {
        DealCycle <- DCATK(DealCycle, "PsychicGround", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        
        DealCycle <- DCATK(DealCycle, "PsychicForce3", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        
        DealCycle <- DCATK(DealCycle, "PsychoBreak", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Pyschic Shot
      else if(PsychicShotUse == T & DealCycle$PsychicShotDebuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$PP[nrow(DealCycle)] >= 5 | 
              PsychicShotUse == T & DealCycle$PsychicShotDebuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$PP[nrow(DealCycle)] >= 2 & DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        if(DealCycle$Skills[nrow(DealCycle)]=="UltimatePsychicShot") {
          DealCycle <- DCATK(DealCycle, "Delay2", ATKFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          
          DealCycle <- DCATK(DealCycle, "PsychicGrab", ATKFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PsychicGrabStack <- 5
        } else if(PsychicGrabStack == 0 | GrabRemain == 0) {
          DealCycle <- DCATK(DealCycle, "PsychicGrab", ATKFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PsychicGrabStack <- 5
        }
        
        DealCycle <- DCATK(DealCycle, "UltimatePsychicShot", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PsychicGrabStack <- 0
      }
      ## Restraint 4
      else if(R4Remain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) * 2 < nrow(subset(DealCycle, DealCycle$Skills=="UltimateMovingMatter")) & 
              nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) * 3 < nrow(subset(DealCycle, DealCycle$Skills=="LawofGravity"))) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Cool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## EverPsychic
      else if(EPRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="EverPsychic")) < nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) & DealCycle$PP[nrow(DealCycle)] <= 10) {
        DealCycle <- DCATK(DealCycle, "EverPsychic", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Psychic Charging
      else if(PCRemain == 0 & DealCycle$PP[nrow(DealCycle)] <= 10) {
        DealCycle <- DCATK(DealCycle, "PsychicCharging", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Ultimate - Moving Matter
      else if(MMRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 10 & nrow(subset(DealCycle, DealCycle$Skills=="UltimateMovingMatter")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) | 
              MMRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 5 & nrow(subset(DealCycle, DealCycle$Skills=="UltimateMovingMatter")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) & 
              DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "UltimateMovingMatter", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Psychic Tornado
      else if(PTRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 15 & nrow(subset(DealCycle, DealCycle$Skills=="PsychicTornado")) < nrow(subset(DealCycle, DealCycle$Skills=="BlessofMasteriaGoddess")) | 
              PTRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 7 & nrow(subset(DealCycle, DealCycle$Skills=="PsychicTornado")) < nrow(subset(DealCycle, DealCycle$Skills=="BlessofMasteriaGoddess")) & 
              DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "PsychicTornado", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Law of Gravity
      else if(LGRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 5 & nrow(subset(DealCycle, DealCycle$Skills=="LawofGravity")) < nrow(subset(DealCycle, DealCycle$Skills=="BlessofMasteriaGoddess")) * 2 | 
              LGRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 2 & nrow(subset(DealCycle, DealCycle$Skills=="LawofGravity")) < nrow(subset(DealCycle, DealCycle$Skills=="BlessofMasteriaGoddess")) * 2 & 
              DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "LawofGravity", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Ultimate - Train
      else if(TRRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 15 | 
              TRRemain == 0 & DealCycle$PP[nrow(DealCycle)] >= 7 & DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "UltimateTrain", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRCool - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Ultimate - Material
      else if(DealCycle$PP[nrow(DealCycle)] >= 22 | 
              DealCycle$PP[nrow(DealCycle)] >= 10 & DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0 | 
              DealCycle$PP[nrow(DealCycle)] >= 7 & PCRemain == 0 | 
              DealCycle$PP[nrow(DealCycle)] >= 3 & PCRemain == 0 & DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "UltimateMaterial", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      ## Psychic Grab - Psychic Smashing
      else if(GrabRemain == 0 | PsychicGrabStack == 0) {
        if(DealCycle$Skills[nrow(DealCycle)]=="UltimatePsychicShot") {
          DealCycle <- DCATK(DealCycle, "Delay2", ATKFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        }
        
        DealCycle <- DCATK(DealCycle, "PsychicGrab", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PsychicGrabStack <- 5
      } 
      else {
        if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PsychicSmashing")) >= 1) {
          DealCycle <- DCATK(DealCycle, "Delay1", ATKFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        }
        
        DealCycle <- DCATK(DealCycle, "PsychicSmashing", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PsychicGrabStack <- PsychicGrabStack - 1
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- KIStack(DealCycle)
          DealCycle <- TornadoThrowing(DealCycle)
          PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
          GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        }
      }
    }
  }
  
  while(max(PGRemain - min(subset(DealCycle, DealCycle$Skills=="PsychicGround")$Time), 
            PCRemain - min(subset(DealCycle, DealCycle$Skills=="PsychicCharging")$Time), 
            EPRemain - min(subset(DealCycle, DealCycle$Skills=="EverPsychic")$Time),
            PTRemain - min(subset(DealCycle, DealCycle$Skills=="PsychicTornado")$Time), 
            MMRemain - min(subset(DealCycle, DealCycle$Skills=="UltimateMovingMatter")$Time), 
            LGRemain - min(subset(DealCycle, DealCycle$Skills=="LawofGravity")$Time), 
            R4Remain - min(subset(DealCycle, DealCycle$Skills=="Restraint4")$Time)) > 0) {
    ## Ultimate - Material
    if(DealCycle$PP[nrow(DealCycle)] >= 22 | 
       DealCycle$PP[nrow(DealCycle)] >= 10 & DealCycle$PsychicOver[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
      DealCycle <- DCATK(DealCycle, "UltimateMaterial", ATKFinal)
      DealCycle <- KIStack(DealCycle)
      DealCycle <- TornadoThrowing(DealCycle)
      PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
    }
    ## Psychic Grab - Psychic Smashing
    else if(GrabRemain == 0 | PsychicGrabStack == 0) {
      if(DealCycle$Skills[nrow(DealCycle)]=="UltimatePsychicShot") {
        DealCycle <- DCATK(DealCycle, "Delay2", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      
      DealCycle <- DCATK(DealCycle, "PsychicGrab", ATKFinal)
      DealCycle <- KIStack(DealCycle)
      DealCycle <- TornadoThrowing(DealCycle)
      PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PsychicGrabStack <- 5
    } 
    else {
      if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PsychicGrab", "PsychicSmashing")) >= 1) {
        DealCycle <- DCATK(DealCycle, "Delay1", ATKFinal)
        DealCycle <- KIStack(DealCycle)
        DealCycle <- TornadoThrowing(DealCycle)
        PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
        GrabRemain <- max(0, GrabRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      }
      
      DealCycle <- DCATK(DealCycle, "PsychicSmashing", ATKFinal)
      DealCycle <- KIStack(DealCycle)
      DealCycle <- TornadoThrowing(DealCycle)
      PGRemain <- max(0, PGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PCRemain <- max(0, PCRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      EPRemain <- max(0, EPRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PTRemain <- max(0, PTRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      MMRemain <- max(0, MMRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      LGRemain <- max(0, LGRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      R4Remain <- max(0, R4Remain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      TRRemain <- max(0, TRRemain - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      GrabRemain <- max(0, 10000 - DealCycle$Time[1] - ifelse(DealCycle$Skills[nrow(DealCycle)]=="PsychicTornadoObject", DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)], 0))
      PsychicGrabStack <- PsychicGrabStack - 1
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
KinesisAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## EverPsychic(Last), Ultimate - Moving Matter(Explosion), Bless of Masteria Goddess(Otherworld Emptiness Start), Psychic Tornado(Object, Object Explosion Start), Law of Gravity(Explosion)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="EverPsychic") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "EverPsychicLast"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 6900
    } else if(DealCycle$Skills[i]=="UltimateMovingMatter") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "UltimateMovingMatterExp"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 30000
    } else if(DealCycle$Skills[i]=="BlessofMasteriaGoddess") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "OtherworldEmptiness"
    } else if(DealCycle$Skills[i]=="PsychicTornadoObject") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "PsychicTornadoExp"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 1000 + 2400
      DealCycle$Time[i] <- DealCycle$Time[i] + 1000
    } else if(DealCycle$Skills[i]=="LawofGravity") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "LawofGravityExp"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 22000
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("EverPsychicLast", "UltimateMovingMatterExp", "PsychicTornadoObject", "PsychicTornadoExp", "LawofGravityExp")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## EverPsychic, Ultimate - Moving Matter, Bless of Masteria Goddess(Otherworld Emptiness), Psychic Tornado(ATK, Explosion), Ultimate - Train (ATK)
  DealCycle <- RepATKCycle(DealCycle, "EverPsychic", 15, 1800, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "UltimateMovingMatter", 63, 480, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "OtherworldEmptiness", 10, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "PsychicTornado", 19, 1000, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "PsychicTornadoExp", 3, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "UltimateTrain", 17, 1050, ATKFinal)
  
  
  ## Ultimate - B.P.M.
  BPMATKTimes <- ceiling(DealCycle$Time[nrow(DealCycle)] / ATKFinal[rownames(ATKFinal)=="UltimateBPM", ]$SubTime)
  DealCycle <- RepATKCycle(DealCycle, "UltimateBPM", BPMATKTimes, 0, ATKFinal)
  
  
  ## Psychic Drain, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, "PsychicDrainATK", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Law of Gravity
  LawofGravityDelay <- c(750, 750 + 2790, seq(750 + 2790 + 1980, 750 + 2790 + 1980 + 1200 * 13, 1200))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="LawofGravity") {
      for(j in 1:length(LawofGravityDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "LawofGravityPull"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + LawofGravityDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="LawofGravityPull") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## Telekinesis
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PsychicSmashing", "PsychicGround", "PsychoBreak", "PsychicTornado", "PsychicTornadoObject", "PsychicTornadoExp", 
                                  "LawofGravity", "LawofGravityPull", "LawofGravityExp")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Telekinesis"
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Law of Gravity (Pull FDR), Overload Mana, Gakseong (Ultimate Skills)
  LOGFDR <- rep(c(0, 12, 24, 36, rep(40, 12)), 10)
  k <- 1
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PsychicForce3", "PsychicSmashing", "PsychoBreak", 
                                  "UltimateMaterial", "UltimateTrain", "UltimatePsychicShot", "UltimateBPM", 
                                  "EverPsychic", "EverPsychicLast", 
                                  "PsychicTornado", "PsychicTornadoObject", "PsychicTornadoExp", "UltimateMovingMatter", "UltimateMovingMatterExp", 
                                  "LawofGravity", "LawofGravityPull", "LawofGravityExp")) >= 1) {
      DealCycle$OverloadMana[i] <- 1
    }
    if(sum(DealCycle$Skills[i]==c("UltimateMaterial", "UltimateTrain", "UltimatePsychicShot", "UltimateBPM", "UltimateMovingMatter", "UltimateMovingMatterExp")) >= 1) {
      DealCycle$GakseongUltimate[i] <- 1
    }
    if(DealCycle$Skills[i]=="LawofGravityPull") {
      DealCycle$LawofGravityFDR[i] <- LOGFDR[k]
      k <- k + 1
    }
  }
  
  
  ## Ultimate - Train (Damage)
  t <- 1
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="UltimateTrain") {
      if(t != 1) {
        DealCycle$Skills[i] <- paste(DealCycle$Skills[i], t, sep="")
      }
      t <- t + 1
      t <- ifelse(t==18, 1, t)
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$PP <- 0
  DealCycle$UltimateBPMPP <- 0
  DealCycle$PsychicOverPP <- 0
  DealCycle$PsychicDrainPP <- 0
  DealCycle$PsychicDrain <- 0
  DealCycle$LawofGravityDebuff <- 0
  
  return(DealCycle)
}

KinesisDealCycle <- KinesisCycle(KinesisDealCycle, 
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 KinesisSpec, 
                                 180, 360, T)
KinesisDealCycle <- DealCycleFinal(KinesisDealCycle)
KinesisDealCycle <- KinesisAddATK(KinesisDealCycle, 
                                  ATKFinal, 
                                  BuffFinal, 
                                  SummonedFinal, 
                                  KinesisSpec)
KinesisDealCycleReduction <- DealCycleReduction(KinesisDealCycle, c("LawofGravityFDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Kinesis") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  KinesisSpecOpt1 <- Optimization1(KinesisDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KinesisSpec, KinesisUnionRemained, 
                                   NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- KinesisSpecOpt1[1, 1:3]
} else {
  KinesisSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
KinesisSpecOpt <- OptDataAdd(KinesisSpec, KinesisSpecOpt1, "Potential", KinesisBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  KinesisSpecOpt2 <- Optimization2(KinesisDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KinesisSpecOpt, KinesisHyperStatBase, KinesisBase$ChrLv, KinesisBase$CRROver, HyperStanceLv=10, 
                                   NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- KinesisSpecOpt2[1, ]
} else {
  KinesisSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
KinesisSpecOpt <- OptDataAdd(KinesisSpecOpt, KinesisSpecOpt2, "HyperStat", KinesisBase$CRROver, DemonAvenger=F)

KinesisFinalDPM <- DealCalc(KinesisDealCycle, ATKFinal, BuffFinal, SummonedFinal, KinesisSpecOpt, Collapse=F, 
                            NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR"))
KinesisFinalDPMwithMax <- DealCalcWithMaxDMR(KinesisDealCycle, ATKFinal, BuffFinal, SummonedFinal, KinesisSpecOpt, 
                                             NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Kinesis", sum(na.omit(KinesisFinalDPMwithMax)) / (max(KinesisDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Kinesis", sum(na.omit(KinesisFinalDPM)) / (max(KinesisDealCycle$Time) / 60000) - sum(na.omit(KinesisFinalDPMwithMax)) / (max(KinesisDealCycle$Time) / 60000))

KinesisDealRatio <- DealRatio(KinesisDealCycle, KinesisFinalDPMwithMax)

KinesisDealData <- data.frame(KinesisDealCycle$Skills, KinesisDealCycle$Time, KinesisDealCycle$Restraint4, KinesisFinalDPMwithMax)
colnames(KinesisDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Kinesis", Deal_RR(KinesisDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Kinesis", Deal_40s(KinesisDealData))

KinesisSpecMean <- SpecMean("Kinesis", KinesisDealCycleReduction, 
                            DealCalcWithMaxDMR(KinesisDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KinesisSpecOpt, 
                                               NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR")), 
                            ATKFinal, BuffFinal, SummonedFinal, KinesisSpecOpt, 
                            NotBuffCols=c("LawofGravityFDR"), NotBuffColOption=c("FDR"))