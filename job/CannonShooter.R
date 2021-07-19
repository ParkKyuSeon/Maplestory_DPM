## CannonShooter - VMatrix
CannonShooterCore <- MatrixSet(PasSkills=c("CannonBuster", "RollingCannonRainbow", "SupportMonkeyTwins", "MonkeyFurious", "BarrelRoulette", "MokeyWave", "CannonBazuka", "MagneticAnchor"), 
                               PasLvs=c(50, 50, 50, 50, 50, 25, 50, 50), 
                               PasMP=c(10, 10, 10, 10, 5, 5, 5, 5), 
                               ActSkills=c("Cocoball", "ICBM", "SpecialMonkeyEscort", "PoolMaker",
                                           CommonV("Pirate", "Adventure")), 
                               ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                               ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 0), 
                               BlinkLv=1, 
                               BlinkMP=0, 
                               UsefulSkills=c("CombatOrders", "SharpEyes"), 
                               UsefulLvs=20, 
                               UsefulMP=0, 
                               SpecSet=SpecDefault, 
                               SelfBind=F)


## CannonShooter - Basic Info
CannonShooterBase <- JobBase(ChrInfo=ChrInfo, 
                             MobInfo=MobDefault,
                             SpecSet=SpecDefault, 
                             Job="CannonMaster",
                             CoreData=CannonShooterCore, 
                             BuffDurationNeeded=0, 
                             AbilList=c("BDR", "DisorderBDR"), 
                             LinkList=c("Xenon", "DemonAvenger", "AdventurePirates", "Phantom"), 
                             MonsterLife=MLTypeS23, 
                             Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "HandCannon", SpecDefault$WeaponType)[, 1:16],
                             WeaponType=SpecDefault$WeaponType, 
                             SubWeapon=SubWeapon[17, ], 
                             Emblem=Emblem[1, ], 
                             CoolReduceHat=F)


## CannonShooter - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
BuildupCannon <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(20, 5)
CriticalFire <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PirateTraining <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(20)
MonkeyWavePassive <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(10)
BarrelRoulettePassive <- data.frame(option, value)

option <- factor(c("ATK", "ATKSpeed"), levels=PSkill)
value <- c(40, 1)
ReinforceCannon <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(40 + CannonShooterBase$SkillLv)
PirateSpiritPassive <- data.frame(option, value)

option <- factor(c("FDR", "ATKSpeed", "Mastery", "IGR"), levels=PSkill)
value <- c(30 + CannonShooterBase$SkillLv, 1, 70 + ceiling(CannonShooterBase$SkillLv/2), 20 + floor(CannonShooterBase$SkillLv/2))
OverburningCannon <- data.frame(option, value)

option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
BuckShotPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + CannonShooterCore[[2]][5, 2])
LoadedDicePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(CannonShooterCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

CannonShooterPassive <- Passive(list(BuildupCannon=BuildupCannon, CriticalFire=CriticalFire, PirateTraining=PirateTraining, MonkeyWavePassive=MonkeyWavePassive, 
                                     BarrelRoulettePassive=BarrelRoulettePassive, ReinforceCannon=ReinforceCannon, PirateSpiritPassive=PirateSpiritPassive, OverburningCannon=OverburningCannon, 
                                     BuckShotPassive=BuckShotPassive, LoadedDicePassive=LoadedDicePassive, BlinkPassive=BlinkPassive))


## CannonShooter - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CocoballStack <- rbind(data.frame(option, value), info)
  
option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CocoballCharge <- rbind(data.frame(option, value), info)
  
option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CannonBooster <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(5)
info <- c(180, 1800, 840, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BarrelRouletteIce <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, 1800, 840, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BarrelRouletteLightning <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, 1800, 840, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BarrelRouletteOthers <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(30)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice55 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice555 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 6 * CannonShooterBase$SkillLv, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateSpirit <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "SubStat1"), levels=BSkill)
value <- c(60 + CannonShooterBase$PSkillLv, 60 + CannonShooterBase$PSkillLv)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HyperMonkeySpell <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((CannonShooterBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(CannonShooterBase$SkillLv/2))))
info <- c(900 + 30 * CannonShooterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BuckShot <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(30, 10, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MonkeyFuriousBuff <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(5)
info <- c(60, 0, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MonkeyWaveBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * CannonShooterCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * CannonShooterCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + floor(CannonShooterCore[[2]][3, 2]/2), 120, 780, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpecialMonkeyEscort <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 60, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoolMakerStart <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15 + floor(CannonShooterCore[[2]][4, 2]/2))
info <- c(20, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoolMakerBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * CannonShooterCore[[2]][6, 2]) * ArcaneShade[rownames(ArcaneShade)=="HandCannon", 6]))
info <- c(30, 70 - floor(CannonShooterCore[[2]][6, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="HandCannon", 6]))
info <- c(Cooldown(70 - floor(CannonShooterCore[[2]][6, 2]/5), T, CannonShooterBase$UnionChrs$CoolReduceP, CannonShooterBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(CannonShooterCore[[2]][6, 2]/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((CannonShooterBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(CannonShooterCore[[2]][7, 2]/2)) * CannonShooterBase$MainStatP), 
           # 10 + floor(CannonShooterCore[[2]][7, 2]/2)
           0)
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * CannonShooterCore[[2]][8, 2]) * MapleSoldier[1, 2]) * CannonShooterBase$MainStatP), 5 + floor(CannonShooterCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

CannonShooterBuff <- Buff(list(CocoballStack=CocoballStack, CocoballCharge=CocoballCharge, CannonBooster=CannonBooster, 
                               BarrelRouletteIce=BarrelRouletteIce, BarrelRouletteLightning=BarrelRouletteLightning, BarrelRouletteOthers=BarrelRouletteOthers, 
                               LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice555=LuckyDice555, PirateSpirit=PirateSpirit, HyperMonkeySpell=HyperMonkeySpell, MapleSoldier=MapleSoldier,
                               BuckShot=BuckShot, EpicAdventure=EpicAdventure, MonkeyFuriousBuff=MonkeyFuriousBuff, MonkeyWaveBuff=MonkeyWaveBuff, 
                               UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, SpecialMonkeyEscort=SpecialMonkeyEscort, PoolMakerStart=PoolMakerStart, PoolMakerBuff=PoolMakerBuff, 
                               OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                               SoulContractLink=SoulContractLink, Restraint4=Restraint4))
## Petbuff : HyperMonkeySpell(1080ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms)
CannonShooterAllTimeBuff <- AllTimeBuff(CannonShooterBuff)


## CannonShooter - Union & HyperStat & SoulWeapon
CannonShooterSpec <- JobSpec(JobBase=CannonShooterBase, 
                             Passive=CannonShooterPassive, 
                             AllTimeBuff=CannonShooterAllTimeBuff, 
                             MobInfo=MobDefault, 
                             SpecSet=SpecDefault, 
                             WeaponName="HandCannon", 
                             UnionStance=10)

CannonShooterUnionRemained <- CannonShooterSpec$UnionRemained
CannonShooterHyperStatBase <- CannonShooterSpec$HyperStatBase
CannonShooterCoolReduceType <- CannonShooterSpec$CoolReduceType
CannonShooterSpec <- CannonShooterSpec$Spec


## CannonShooter - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * CannonShooterCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * CannonShooterCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CannonShooterCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CannonShooterCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CannonShooterCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CannonShooterCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## CannonShooter - ATK
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CannonShooterCore[[1]][4, 2]>=40, 20, 0), 3 * CannonShooterCore[[1]][4, 2])
info <- c(180 * 0.45, 3 * 3, 810, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyFurious <- rbind(data.frame(option, value), info) ## ATKSpeed Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CannonShooterCore[[1]][6, 2]>=40, 20, 0), 3 * CannonShooterCore[[1]][6, 2])
info <- c(860 * 0.45, 1 * 3, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyWave <- rbind(data.frame(option, value), info) ## ATKSpeed Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CannonShooterCore[[1]][5, 2]>=40, 20, 0), 3 * CannonShooterCore[[1]][5, 2])
info <- c(150 * 0.45, 0.5 * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BarrelRoulette <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(20 + floor(CannonShooterSpec$SkillLv/2), ifelse(CannonShooterCore[[1]][1, 2]>=40, 20, 0))), 2 * CannonShooterCore[[1]][1, 2])
info <- c((750 + 5 * CannonShooterSpec$SkillLv) * 0.45, 5 * 3, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CannonBuster <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CannonShooterCore[[1]][2, 2]>=40, 20, 0), 2 * CannonShooterCore[[1]][2, 2])
info <- c(600, 3, 480, 480, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RollingCannonRainbow <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((450 + 15 * CannonShooterCore[[2]][1, 2]) * 0.45, 4 * 3, 780, 210, 3, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Cocoball <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((800 + 32 * CannonShooterCore[[2]][2, 2]) * 0.45, 5 * 3, 660 + 510, 150, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ICBM <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * CannonShooterCore[[2]][2, 2]) * 0.45, 1 * 3, 0, 500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ICBMFloor <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * CannonShooterCore[[2]][3, 2], 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyEscortCannon <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(450 + 18 * CannonShooterCore[[2]][3, 2], 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyEscortBomb <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((700 + 28 * CannonShooterCore[[2]][4, 2]) * 0.45, 3 * 3, 960, 1020, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoolMaker <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied
}

CannonShooterATK <- Attack(list(MonkeyFurious=MonkeyFurious, MonkeyWave=MonkeyWave, BarrelRoulette=BarrelRoulette, CannonBuster=CannonBuster, RollingCannonRainbow=RollingCannonRainbow, 
                                Cocoball=Cocoball, ICBM=ICBM, ICBMFloor=ICBMFloor, MonkeyEscortCannon=MonkeyEscortCannon, MonkeyEscortBomb=MonkeyEscortBomb, PoolMaker=PoolMaker, 
                                SpiderInMirror=SpiderInMirror))


## CannonShooter - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CannonShooterCore[[1]][3, 2]>=40, 20, 0), 2 * CannonShooterCore[[1]][3, 2])
info <- c((295 + 8 * CannonShooterSpec$SkillLv) * 0.6, 2 * 3, 0, 930, 60, 10, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SupportMonkeyTwins <- rbind(data.frame(option, value), info)}

CannonShooterSummoned <- Summoned(list(SupportMonkeyTwins=SupportMonkeyTwins, SpiderInMirrorStart=SpiderInMirrorStart, 
                                       SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                       SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))



## CannonShooter - DealCycle & Deal Calculation
ATKFinal <- data.frame(CannonShooterATK)
ATKFinal$Delay[c(-5, -6, -7, -11)] <- Delay(ATKFinal$Delay, CannonShooterSpec$ATKSpeed)[c(-5, -6, -7, -11)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, CannonShooterSpec$CoolReduceP, CannonShooterSpec$CoolReduce)

BuffFinal <- data.frame(CannonShooterBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, CannonShooterSpec$CoolReduceP, CannonShooterSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, CannonShooterSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)
BuffFinal[rownames(BuffFinal)=="SoulContractLink", ]$CoolTime <- 90

SummonedFinal <- data.frame(CannonShooterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, CannonShooterSpec$CoolReduceP, CannonShooterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * CannonShooterSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(CannonShooterBuff))
CannonShooterDealCycle <- t(rep(0, length(DealCycle)))
colnames(CannonShooterDealCycle) <- DealCycle

CannonShooterCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                               Period=c(180, 182.4), CycleTime=c(360, 364.8)) {
  BuffSummonedPrior <- c("CannonBooster", "BarrelRouletteOthers", "LuckyDice5", "PirateSpirit", "HyperMonkeySpell", "BuckShot", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", 
                         "SupportMonkeyTwins", "MapleWarriors2", "SpecialMonkeyEscort", "PoolMakerStart", "OverDrive", "SoulContractLink", "Restraint4")
  Times180 <- c(1, 1, 1, 1, 0, 0, 0, 0, 0, 
                3, 1, 1.5, 3, 2, 2, 1)
  Times182 <- c(1, 1, 1, 1, 0, 0, 0, 0, 0, 
                3, 1, 1.5, 3, 3, 2, 1)
  
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    if(Period==180) {
      SubTime[i] <- SubTime[i] / ifelse(Times180[i]==0, Inf, Times180[i])
    } else if(Period==182.4) {
      SubTime[i] <- SubTime[i] / ifelse(Times182[i]==0, Inf, Times182[i])
    }
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
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$CocoballStack[2] <- 3 ; DealCycle$CocoballCharge[2] <- 25000
  
  CocoballStack <- function(DealCycle) {
    if(DealCycle$Skills[nrow(DealCycle)]=="Cocoball") {
      DealCycle$CocoballStack[nrow(DealCycle)] <- DealCycle$CocoballStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$CocoballStack[nrow(DealCycle)] <- DealCycle$CocoballStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$CocoballCharge[nrow(DealCycle)-1] >= 0 & DealCycle$CocoballCharge[nrow(DealCycle)]==0 & DealCycle$CocoballStack[nrow(DealCycle)] < 3) {
      DealCycle$CocoballStack[nrow(DealCycle)] <- DealCycle$CocoballStack[nrow(DealCycle)] + 1
      DealCycle$CocoballCharge[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 25000, 25000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$CocoballCharge[nrow(DealCycle)-1]))
    } else if(DealCycle$CocoballStack[nrow(DealCycle)] == 3) {
      DealCycle$CocoballCharge[nrow(DealCycle)] <- 25000
    }
    return(DealCycle)
  }
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- CocoballStack(DealCycle)
      if(BuffList[[1]][i]=="SoulContractLink") {
        DealCycle <- DCATK(DealCycle, "RollingCannonRainbow", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
      } 
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- CocoballStack(DealCycle)
      if(BuffList[[1]][i]=="SupportMonkeyTwins") {
        DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        DealCycle <- DCBuff(DealCycle, "MonkeyFuriousBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        DealCycle <- DCATK(DealCycle, "MonkeyFurious", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        DealCycle <- DCBuff(DealCycle, "MonkeyWaveBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        DealCycle <- DCATK(DealCycle, "MonkeyWave", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
      }
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
  PFCool <- Cooldown(30, T, Spec$CoolReduceP, Spec$CoolReduce) * 1000
  ICBMCool <- subset(ATKFinal, rownames(ATKFinal)=="ICBM")$CoolTime * 1000
  CCCool <- subset(ATKFinal, rownames(ATKFinal)=="Cocoball")$CoolTime * 1000
  
  PFRemain <- max(0, PFCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="PirateFlag")$Time))
  ICBMRemain <- 0 ; CCRemain <- 0
  
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
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        }
      }
      ## Cocoball
      if(CCRemain==0 & DealCycle$CocoballStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] > 0 & sum(k==c(5, 9))==0 | 
         CCRemain==0 & DealCycle$CocoballStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] > 0 & sum(k==c(5, 9)) > 0 & 
         DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + (3 - DealCycle$CocoballStack[nrow(DealCycle)] + 1) * 25000 - (25000 - DealCycle$CocoballCharge[nrow(DealCycle)]) <= BuffStartTime)  {
        DealCycle <- DCATK(DealCycle, "Cocoball", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- CCCool - DealCycle$Time[1]
      }
      ## ICBM
      else if(ICBMRemain==0 & sum(k==c(5, 9))==0 | 
              ICBMRemain==0 & sum(k==c(5, 9)) > 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ICBMCool <= BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "ICBMFloor", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- ICBMCool - DealCycle$Time[1]
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "ICBM", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
      }
      ## Pirate Flag, Monkey Furious, Monkey Wave
      else if(PFRemain==0 & k!=9 | 
              PFRemain==0 & k==9 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + PFCool <= BuffStartTime) {
        DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- PFCool - DealCycle$Time[1]
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "MonkeyFuriousBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MonkeyFurious", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        
        if(DealCycle$MonkeyWaveBuff[nrow(DealCycle)] - DealCycle$Time[1] < 10000) {
          DealCycle <- DCBuff(DealCycle, "MonkeyWaveBuff", BuffFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          CCRemain <- max(0, CCRemain - DealCycle$Time[1])
          DealCycle <- DCATK(DealCycle, "MonkeyWave", ATKFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        }
      }
      else if(PFRemain==0) {
        DealCycle <- DCBuff(DealCycle, "MonkeyFuriousBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- PFCool - DealCycle$Time[1]
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MonkeyFurious", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "MonkeyWaveBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MonkeyWave", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
      }
      ## Cannon Buster
      else {
        DealCycle <- DCATK(DealCycle, "CannonBuster", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        CCRemain <- max(0, CCRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          CCRemain <- max(0, CCRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="SoulContractLink") {
            DealCycle <- DCATK(DealCycle, "RollingCannonRainbow", ATKFinal)
            DealCycle <- CocoballStack(DealCycle)
            PFRemain <- max(0, PFRemain - DealCycle$Time[1])
            ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
            CCRemain <- max(0, CCRemain - DealCycle$Time[1])
          } 
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          CCRemain <- max(0, CCRemain - DealCycle$Time[1])
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
CannonShooterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                                LuckyDice=c(5, 55, 555), BarrelRoulette=c("Ice", "Lightning", "Others"), CocoballHits=22) {
  ## Lucky Dice and Barrel Roulette
  if(LuckyDice==55) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$LuckyDice5[i] > 0) {
        DealCycle$LuckyDice55[i] <- DealCycle$LuckyDice5[i]
        DealCycle$LuckyDice5[i] <- 0
      }
    }
  } else if(LuckyDice==555) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$LuckyDice5[i] > 0) {
        DealCycle$LuckyDice555[i] <- DealCycle$LuckyDice5[i]
        DealCycle$LuckyDice5[i] <- 0
      }
    }
  }
  
  if(BarrelRoulette=="Ice") {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$BarrelRouletteOthers[i] > 0) {
        DealCycle$BarrelRouletteIce[i] <- DealCycle$BarrelRouletteOthers[i]
        DealCycle$BarrelRouletteOthers[i] <- 0
      }
    }
  } else if(BarrelRoulette=="Lightning") {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$BarrelRouletteOthers[i] > 0) {
        DealCycle$BarrelRouletteLightning[i] <- DealCycle$BarrelRouletteOthers[i] 
        DealCycle$BarrelRouletteOthers[i] <- 0
      }
    }
  }
  
  
  ## Barrel Roulette Final Attack
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$BarrelRouletteLightning[i] > 0 & sum(DealCycle$Skills[i]==c("MonkeyFurious", "MonkeyWave", "CannonBuster"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BarrelRoulette"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Cocoball, ICBM, ICBM Floor, Support Monkey Twins, Spider In Mirror
  DealCycle <- RepATKCycle(DealCycle, "Cocoball", CocoballHits, 630, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ICBM", 6, 450 + 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ICBMFloor", 27, 2500 + 660, ATKFinal)
  
  DealCycle <- DCSummonedATKs(DealCycle, "SupportMonkeyTwins", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Pool Maker
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PoolMakerStart") {
      DealCycle$Skills[i] <- "PoolMaker"
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "PoolMaker", 20, 1020, ATKFinal)
  
  
  ## Rolling Cannon Rainbow
  RCDuration <- 12000 * (100 + Spec$SummonedDuration) / 100
  RCHits <- ceiling((RCDuration - 1020) / 480)
  DealCycle <- RepATKCycle(DealCycle, "RollingCannonRainbow", RCHits, 1020, ATKFinal)
  
  
  ## Special Monkey Escort
  RoyBomb <- seq(2400, 2400 + 990*30 + 1500*6, 990*5 + 1500)
  RoyCannon <- c(2400 + 1500) ; k <- 1
  for(i in 2:33) {
    RoyCannon[i] <- ifelse(k==5, RoyCannon[i-1] + 990 + 1500, RoyCannon[i-1] + 990)
    k <- ifelse(k==5, 1, k+1)
  }
  
  MaxiBomb <- seq(2400, 2400 + 720*40 + 1200, 720*40 + 1200)
  MaxiCannon <- c(2400 + 1200) ; k <- 1
  for(i in 2:56) {
    MaxiCannon[i] <- ifelse(k==40, MaxiCannon[i-1] + 720 + 1200, MaxiCannon[i-1] + 720)
    k <- ifelse(k==40, 1, k+1)
  }
  
  KhakiBomb <- seq(2400, 2400 + 3000*7 + 2520*7, 3000 + 2520)
  KhakiCannon <- seq(2400 + 3000, 2400 + 3000*8 + 2520*7, 3000 + 2520)
  
  RoyBomb <- RoyBomb[RoyBomb < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  RoyCannon <- RoyCannon[RoyCannon < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  MaxiBomb <- MaxiBomb[MaxiBomb < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  MaxiCannon <- MaxiCannon[MaxiCannon < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  KhakiBomb <- KhakiBomb[KhakiBomb < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  KhakiCannon <- KhakiCannon[KhakiCannon < subset(BuffFinal, rownames(BuffFinal)=="SpecialMonkeyEscort")$Duration * 1000]
  
  Bomb <- c(RoyBomb, MaxiBomb, KhakiBomb)
  Cannon <- c(RoyCannon, MaxiCannon, KhakiCannon)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SpecialMonkeyEscort") {
      for(j in 1:length(Bomb)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "MonkeyEscortBomb"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + Bomb[j]
      }
      for(j in 1:length(Cannon)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "MonkeyEscortCannon"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + Cannon[j]
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MonkeyEscortBomb", "MonkeyEscortCannon"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$CocoballStack <- 0
  DealCycle$CocoballCharge <- 0
  DealCycle$SpecialMonkeyEscort <- 0
  DealCycle$PoolMakerStart <- 0
  return(DealCycle)
}
      
      
      
CannonShooterDealCycle <- CannonShooterCycle(CannonShooterDealCycle, 
                                             ATKFinal, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             CannonShooterSpec,
                                             Period=182.4, 
                                             CycleTime=364.8)
CannonShooterDealCycle <- DealCycleFinal(CannonShooterDealCycle)

## DealCycle Optimization
CannonShooter_5Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                             ATKFinal, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             CannonShooterSpec,
                                             LuckyDice=5,
                                             BarrelRoulette="Others", 
                                             CocoballHits=27)
CannonShooter_5Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                ATKFinal, 
                                                BuffFinal, 
                                                SummonedFinal, 
                                                CannonShooterSpec,
                                                LuckyDice=5,
                                                BarrelRoulette="Lightning", 
                                                CocoballHits=27)
CannonShooter_5Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                          ATKFinal, 
                                          BuffFinal, 
                                          SummonedFinal, 
                                          CannonShooterSpec,
                                          LuckyDice=5,
                                          BarrelRoulette="Ice", 
                                          CocoballHits=27)

CannonShooter_55Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                             ATKFinal, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             CannonShooterSpec,
                                             LuckyDice=55,
                                             BarrelRoulette="Others", 
                                             CocoballHits=27)
CannonShooter_55Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                ATKFinal, 
                                                BuffFinal, 
                                                SummonedFinal, 
                                                CannonShooterSpec,
                                                LuckyDice=55,
                                                BarrelRoulette="Lightning", 
                                                CocoballHits=27)
CannonShooter_55Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                          ATKFinal, 
                                          BuffFinal, 
                                          SummonedFinal, 
                                          CannonShooterSpec,
                                          LuckyDice=55,
                                          BarrelRoulette="Ice", 
                                          CocoballHits=27)

CannonShooter_555Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                               ATKFinal, 
                                               BuffFinal, 
                                               SummonedFinal, 
                                               CannonShooterSpec,
                                               LuckyDice=555,
                                               BarrelRoulette="Others", 
                                               CocoballHits=27)
CannonShooter_555Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                  ATKFinal, 
                                                  BuffFinal, 
                                                  SummonedFinal, 
                                                  CannonShooterSpec,
                                                  LuckyDice=555,
                                                  BarrelRoulette="Lightning", 
                                                  CocoballHits=27)
CannonShooter_555Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                            ATKFinal, 
                                            BuffFinal, 
                                            SummonedFinal, 
                                            CannonShooterSpec,
                                            LuckyDice=555,
                                            BarrelRoulette="Ice", 
                                            CocoballHits=27)

CannonShooter_5Others <- OverDriveExhaustBuff(CannonShooter_5Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_5Lightning <- OverDriveExhaustBuff(CannonShooter_5Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_5Ice <- OverDriveExhaustBuff(CannonShooter_5Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

CannonShooter_55Others <- OverDriveExhaustBuff(CannonShooter_55Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_55Lightning <- OverDriveExhaustBuff(CannonShooter_55Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_55Ice <- OverDriveExhaustBuff(CannonShooter_55Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

CannonShooter_555Others <- OverDriveExhaustBuff(CannonShooter_555Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_555Lightning <- OverDriveExhaustBuff(CannonShooter_555Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CannonShooter_555Ice <- OverDriveExhaustBuff(CannonShooter_555Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

CannonShooter_5Others <- DealCycleReduction(CannonShooter_5Others)
CannonShooter_5Lightning <- DealCycleReduction(CannonShooter_5Lightning)
CannonShooter_5Ice <- DealCycleReduction(CannonShooter_5Ice)

CannonShooter_55Others <- DealCycleReduction(CannonShooter_55Others)
CannonShooter_55Lightning <- DealCycleReduction(CannonShooter_55Lightning)
CannonShooter_55Ice <- DealCycleReduction(CannonShooter_55Ice)

CannonShooter_555Others <- DealCycleReduction(CannonShooter_555Others)
CannonShooter_555Lightning <- DealCycleReduction(CannonShooter_555Lightning)
CannonShooter_555Ice <- DealCycleReduction(CannonShooter_555Ice)

CannonShooterCycleProbs <- c(0.745340 * 0.5, 0.745340 * 0.25, 0.745340 * 0.25, 0.245185 * 0.5, 0.245185 * 0.25, 0.245185 * 0.25, 0.009475 * 0.5, 0.009475 * 0.25, 0.009475 * 0.25)
CannonShooterDealCycles <- list(CannonShooter_5Others, CannonShooter_5Lightning, CannonShooter_5Ice, 
                                CannonShooter_55Others, CannonShooter_55Lightning, CannonShooter_55Ice, 
                                CannonShooter_555Others, CannonShooter_555Lightning, CannonShooter_555Ice)

CannonShooterSpecOpt1 <- ResetOptimization1(DealCycles=CannonShooterDealCycles, 
                                            ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpec, CannonShooterUnionRemained, rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)
CannonShooterSpecOpt <- CannonShooterSpec
CannonShooterSpecOpt$ATKP <- CannonShooterSpecOpt$ATKP + CannonShooterSpecOpt1$ATKP
CannonShooterSpecOpt$BDR <- CannonShooterSpecOpt$BDR + CannonShooterSpecOpt1$BDR
CannonShooterSpecOpt$IGR <- IGRCalc(c(CannonShooterSpecOpt$IGR, CannonShooterSpecOpt1$IGR))

CannonShooterSpecOpt2 <- ResetOptimization2(DealCycles=CannonShooterDealCycles,
                                            ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt, CannonShooterHyperStatBase, CannonShooterBase$ChrLv, CannonShooterBase$CRROver, HyperStanceLv=4, 
                                            rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)
CannonShooterFinalDPM <- ResetDealCalc(DealCycles=CannonShooterDealCycles, 
                                       ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2, rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)
CannonShooterFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=CannonShooterDealCycles, 
                                                        ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2, rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)


CannonShooterFinalCycle <- CannonShooterAddATK(CannonShooterDealCycle, 
                                               ATKFinal, 
                                               BuffFinal, 
                                               SummonedFinal, 
                                               CannonShooterSpec,
                                               LuckyDice=5,
                                               BarrelRoulette="Others", 
                                               CocoballHits=27)
CannonShooterFinalCycle <- OverDriveExhaustBuff(CannonShooterFinalCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

DPM12349$CannonMaster[1] <- sum(na.omit(CannonShooterFinalDPMwithMax)) / (max(CannonShooterFinalCycle$Time)/ 60000)
DPM12349$CannonMaster[2] <- sum(na.omit(CannonShooterFinalDPM)) / (max(CannonShooterFinalCycle$Time) / 60000) - sum(na.omit(CannonShooterFinalDPMwithMax)) / (max(CannonShooterFinalCycle$Time) / 60000)


CannonShooterDeal1 <- DealCalcWithMaxDMR(CannonShooter_5Others, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal2 <- DealCalcWithMaxDMR(CannonShooter_5Lightning, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal3 <- DealCalcWithMaxDMR(CannonShooter_5Ice, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal4 <- DealCalcWithMaxDMR(CannonShooter_55Others, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal5 <- DealCalcWithMaxDMR(CannonShooter_55Lightning, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal6 <- DealCalcWithMaxDMR(CannonShooter_55Ice, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal7 <- DealCalcWithMaxDMR(CannonShooter_555Others, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal8 <- DealCalcWithMaxDMR(CannonShooter_555Lightning, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDeal9 <- DealCalcWithMaxDMR(CannonShooter_555Ice, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDealDatas <- list(CannonShooterDeal1, CannonShooterDeal2, CannonShooterDeal3, 
                               CannonShooterDeal4, CannonShooterDeal5, CannonShooterDeal6, 
                               CannonShooterDeal7, CannonShooterDeal8, CannonShooterDeal9)

CannonShooterDealRatio <- ResetDealRatio(DealCycles=list(CannonShooterDealCycles[[2]], CannonShooterDealCycles[[1]], CannonShooterDealCycles[[3]], 
                                                         CannonShooterDealCycles[[4]], CannonShooterDealCycles[[5]], CannonShooterDealCycles[[6]],
                                                         CannonShooterDealCycles[[7]], CannonShooterDealCycles[[8]], CannonShooterDealCycles[[9]]), 
                                         DealDatas=list(CannonShooterDealDatas[[2]], CannonShooterDealDatas[[1]], CannonShooterDealDatas[[3]], 
                                                         CannonShooterDealDatas[[4]], CannonShooterDealDatas[[5]], CannonShooterDealDatas[[6]],
                                                         CannonShooterDealDatas[[7]], CannonShooterDealDatas[[8]], CannonShooterDealDatas[[9]]), 
                                         rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs[c(2, 1, 3:9)])

CannonShooterFinalDeal <- DealCalcWithMaxDMR(CannonShooterFinalCycle, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2)
CannonShooterDealData <- data.frame(CannonShooterFinalCycle$Skills, CannonShooterFinalCycle$Time, CannonShooterFinalCycle$Restraint4, CannonShooterFinalDeal)
colnames(CannonShooterDealData) <- c("Skills", "Time", "R4", "Deal")

subset(CannonShooterDealData, CannonShooterDealData$R4>0)

CannonShooterRR <- CannonShooterDealData[39:277, ]
DPM12349$CannonMaster[3] <- sum((CannonShooterRR$Deal))

CannonShooter40s <- CannonShooterDealData[39:483, ]
DPM12349$CannonMaster[4] <- sum((CannonShooter40s$Deal))



## Cocoball 5 Hits
BuffFinalFlag <- BuffFinal
BuffFinalFlag[rownames(BuffFinalFlag)=="PirateFlag", ]$IGR <- 10 + floor(CannonShooterCore[[2]][7, 2]/2)
{Cocoball5Hits_5Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                             ATKFinal, 
                                             BuffFinalFlag, 
                                             SummonedFinal, 
                                             CannonShooterSpec,
                                             LuckyDice=5,
                                             BarrelRoulette="Others", 
                                             CocoballHits=5)
Cocoball5Hits_5Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                ATKFinal, 
                                                BuffFinalFlag, 
                                                SummonedFinal, 
                                                CannonShooterSpec,
                                                LuckyDice=5,
                                                BarrelRoulette="Lightning", 
                                                CocoballHits=5)
Cocoball5Hits_5Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                          ATKFinal, 
                                          BuffFinalFlag, 
                                          SummonedFinal, 
                                          CannonShooterSpec,
                                          LuckyDice=5,
                                          BarrelRoulette="Ice", 
                                          CocoballHits=5)

Cocoball5Hits_55Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                              ATKFinal, 
                                              BuffFinalFlag, 
                                              SummonedFinal, 
                                              CannonShooterSpec,
                                              LuckyDice=55,
                                              BarrelRoulette="Others", 
                                              CocoballHits=5)
Cocoball5Hits_55Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                 ATKFinal, 
                                                 BuffFinalFlag, 
                                                 SummonedFinal, 
                                                 CannonShooterSpec,
                                                 LuckyDice=55,
                                                 BarrelRoulette="Lightning", 
                                                 CocoballHits=5)
Cocoball5Hits_55Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                           ATKFinal, 
                                           BuffFinalFlag, 
                                           SummonedFinal, 
                                           CannonShooterSpec,
                                           LuckyDice=55,
                                           BarrelRoulette="Ice", 
                                           CocoballHits=5)

Cocoball5Hits_555Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                               ATKFinal, 
                                               BuffFinalFlag, 
                                               SummonedFinal, 
                                               CannonShooterSpec,
                                               LuckyDice=555,
                                               BarrelRoulette="Others", 
                                               CocoballHits=5)
Cocoball5Hits_555Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                  ATKFinal, 
                                                  BuffFinalFlag, 
                                                  SummonedFinal, 
                                                  CannonShooterSpec,
                                                  LuckyDice=555,
                                                  BarrelRoulette="Lightning", 
                                                  CocoballHits=5)
Cocoball5Hits_555Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                            ATKFinal, 
                                            BuffFinalFlag, 
                                            SummonedFinal, 
                                            CannonShooterSpec,
                                            LuckyDice=555,
                                            BarrelRoulette="Ice", 
                                            CocoballHits=5)

Cocoball5Hits_5Others <- OverDriveExhaustBuff(Cocoball5Hits_5Others, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_5Lightning <- OverDriveExhaustBuff(Cocoball5Hits_5Lightning, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_5Ice <- OverDriveExhaustBuff(Cocoball5Hits_5Ice, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)

Cocoball5Hits_55Others <- OverDriveExhaustBuff(Cocoball5Hits_55Others, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_55Lightning <- OverDriveExhaustBuff(Cocoball5Hits_55Lightning, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_55Ice <- OverDriveExhaustBuff(Cocoball5Hits_55Ice, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)

Cocoball5Hits_555Others <- OverDriveExhaustBuff(Cocoball5Hits_555Others, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_555Lightning <- OverDriveExhaustBuff(Cocoball5Hits_555Lightning, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)
Cocoball5Hits_555Ice <- OverDriveExhaustBuff(Cocoball5Hits_555Ice, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$Duration, BuffFinalFlag[rownames(BuffFinalFlag)=="OverDrive", ]$CoolTime)}

Cocoball5HitsDealCycles <- list(Cocoball5Hits_5Others, Cocoball5Hits_5Lightning, Cocoball5Hits_5Ice, 
                                Cocoball5Hits_55Others, Cocoball5Hits_55Lightning, Cocoball5Hits_55Ice, 
                                Cocoball5Hits_555Others, Cocoball5Hits_555Lightning, Cocoball5Hits_555Ice)
Cocoball5HitsDPM <- ResetDealCalcWithMaxDMR(DealCycles=Cocoball5HitsDealCycles, 
                                           ATKFinal, BuffFinalFlag, SummonedFinal, CannonShooterSpecOpt2, rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)
Cocoball5HitsDPM <- sum(na.omit(Cocoball5HitsDPM)) / (max(CannonShooterFinalCycle$Time)/ 60000)

Cocoball5HitsDealData <- data.frame(Cocoball5Hits_5Others$Skills, Cocoball5Hits_5Others$Time, Cocoball5Hits_5Others$Restraint4, 
                                    DealCalcWithMaxDMR(Cocoball5Hits_5Others, ATKFinal, BuffFinalFlag, SummonedFinal, CannonShooterSpecOpt2))
colnames(Cocoball5HitsDealData) <- c("Skills", "Time", "R4", "Deal")

subset(Cocoball5HitsDealData, Cocoball5HitsDealData$R4>0)

Cocoball5HitsRR <- Cocoball5HitsDealData[39:211, ]
Cocoball5HitsRR <- sum((Cocoball5HitsRR$Deal))

Cocoball5Hits40s <- Cocoball5HitsDealData[39:395, ]
Cocoball5Hits40s <- sum((Cocoball5Hits40s$Deal))


## Cocoball 40 Hits
{Cocoball40Hits_5Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                              ATKFinal, 
                                              BuffFinal, 
                                              SummonedFinal, 
                                              CannonShooterSpec,
                                              LuckyDice=5,
                                              BarrelRoulette="Others", 
                                              CocoballHits=40)
Cocoball40Hits_5Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                 ATKFinal, 
                                                 BuffFinal, 
                                                 SummonedFinal, 
                                                 CannonShooterSpec,
                                                 LuckyDice=5,
                                                 BarrelRoulette="Lightning", 
                                                 CocoballHits=40)
Cocoball40Hits_5Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                           ATKFinal, 
                                           BuffFinal, 
                                           SummonedFinal, 
                                           CannonShooterSpec,
                                           LuckyDice=5,
                                           BarrelRoulette="Ice", 
                                           CocoballHits=40)

Cocoball40Hits_55Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                               ATKFinal, 
                                               BuffFinal, 
                                               SummonedFinal, 
                                               CannonShooterSpec,
                                               LuckyDice=55,
                                               BarrelRoulette="Others", 
                                               CocoballHits=40)
Cocoball40Hits_55Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                  ATKFinal, 
                                                  BuffFinal, 
                                                  SummonedFinal, 
                                                  CannonShooterSpec,
                                                  LuckyDice=55,
                                                  BarrelRoulette="Lightning", 
                                                  CocoballHits=49)
Cocoball40Hits_55Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                            ATKFinal, 
                                            BuffFinal, 
                                            SummonedFinal, 
                                            CannonShooterSpec,
                                            LuckyDice=55,
                                            BarrelRoulette="Ice", 
                                            CocoballHits=40)

Cocoball40Hits_555Others <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                ATKFinal, 
                                                BuffFinal, 
                                                SummonedFinal, 
                                                CannonShooterSpec,
                                                LuckyDice=555,
                                                BarrelRoulette="Others", 
                                                CocoballHits=40)
Cocoball40Hits_555Lightning <- CannonShooterAddATK(CannonShooterDealCycle, 
                                                   ATKFinal, 
                                                   BuffFinal, 
                                                   SummonedFinal, 
                                                   CannonShooterSpec,
                                                   LuckyDice=555,
                                                   BarrelRoulette="Lightning", 
                                                   CocoballHits=40)
Cocoball40Hits_555Ice <- CannonShooterAddATK(CannonShooterDealCycle, 
                                             ATKFinal, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             CannonShooterSpec,
                                             LuckyDice=555,
                                             BarrelRoulette="Ice", 
                                             CocoballHits=40)

Cocoball40Hits_5Others <- OverDriveExhaustBuff(Cocoball40Hits_5Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_5Lightning <- OverDriveExhaustBuff(Cocoball40Hits_5Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_5Ice <- OverDriveExhaustBuff(Cocoball40Hits_5Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

Cocoball40Hits_55Others <- OverDriveExhaustBuff(Cocoball40Hits_55Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_55Lightning <- OverDriveExhaustBuff(Cocoball40Hits_55Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_55Ice <- OverDriveExhaustBuff(Cocoball40Hits_55Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

Cocoball40Hits_555Others <- OverDriveExhaustBuff(Cocoball40Hits_555Others, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_555Lightning <- OverDriveExhaustBuff(Cocoball40Hits_555Lightning, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
Cocoball40Hits_555Ice <- OverDriveExhaustBuff(Cocoball40Hits_555Ice, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)}

Cocoball40HitsDealCycles <- list(Cocoball40Hits_5Others, Cocoball40Hits_5Lightning, Cocoball40Hits_5Ice, 
                                 Cocoball40Hits_55Others, Cocoball40Hits_55Lightning, Cocoball40Hits_55Ice, 
                                 Cocoball40Hits_555Others, Cocoball40Hits_555Lightning, Cocoball40Hits_555Ice)
Cocoball40HitsDPM <- ResetDealCalcWithMaxDMR(DealCycles=Cocoball40HitsDealCycles, 
                                             ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2, rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs)
Cocoball40HitsDPM <- sum(na.omit(Cocoball40HitsDPM)) / (max(CannonShooterFinalCycle$Time)/ 60000)

Cocoball40HitsDealData <- data.frame(Cocoball40Hits_5Others$Skills, Cocoball40Hits_5Others$Time, Cocoball40Hits_5Others$Restraint4, 
                                     DealCalcWithMaxDMR(Cocoball40Hits_5Others, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt2))
colnames(Cocoball40HitsDealData) <- c("Skills", "Time", "R4", "Deal")

subset(Cocoball40HitsDealData, Cocoball40HitsDealData$R4>0)

Cocoball40HitsRR <- Cocoball40HitsDealData[39:315, ]
Cocoball40HitsRR <- sum((Cocoball40HitsRR$Deal))

Cocoball40Hits40s <- Cocoball40HitsDealData[39:535, ]
Cocoball40Hits40s <- sum((Cocoball40Hits40s$Deal))