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
## Link Check Needed
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
option <- factor(c("CRR"), levels=PSkill)
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



## Tier4 ~ Needed