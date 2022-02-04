## CannonShooter - VMatrix
CannonShooterCoreBase <- CoreBuilder(ActSkills=c("Cocoball", "ICBM", "SpecialMonkeyEscort", "PoolMaker",
                                                 CommonV("Pirate", "Adventure")), 
                                     ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                                     UsefulSkills=c("CombatOrders", "SharpEyes"), 
                                     SpecSet=get(DPMCalcOption$SpecSet), 
                                     VPassiveList=CannonShooterVPassive, 
                                     VPassivePrior=CannonShooterVPrior, 
                                     SelfBind=F)

CannonShooterCore <- MatrixSet(PasSkills=CannonShooterCoreBase$PasSkills$Skills, 
                               PasLvs=CannonShooterCoreBase$PasSkills$Lv, 
                               PasMP=CannonShooterCoreBase$PasSkills$MP, 
                               ActSkills=CannonShooterCoreBase$ActSkills$Skills, 
                               ActLvs=CannonShooterCoreBase$ActSkills$Lv, 
                               ActMP=CannonShooterCoreBase$ActSkills$MP, 
                               UsefulSkills=CannonShooterCoreBase$UsefulSkills, 
                               UsefulLvs=20, 
                               UsefulMP=0, 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               SpecialCore=CannonShooterCoreBase$SpecialCoreUse)


## CannonShooter - Basic Info
CannonShooterBase <- JobBase(ChrInfo=ChrInfo, 
                             MobInfo=get(DPMCalcOption$MobSet),
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             Job="CannonMaster",
                             CoreData=CannonShooterCore, 
                             BuffDurationNeeded=0, 
                             AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "CannonMaster"), 
                             LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "CannonMaster"), 
                             MonsterLife=get(FindJob(MonsterLifePreSet, "CannonMaster")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                             Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "HandCannon", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                             WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                             SubWeapon=SubWeapon[rownames(SubWeapon)=="PowderKeg", ], 
                             Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                             CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "CannonMaster")))


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

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
CannonAcceleration <- data.frame(option, value)

option <- factor(c("FDR", "CRR", "CDMR"), levels=PSkill)
value <- c(10, 20, 5)
BarrelRoulettePassive <- data.frame(option, value)

option <- factor(c("ATK", "ATKSpeed", "FDR"), levels=PSkill)
value <- c(40, 1, 5)
ReinforceCannon <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(5)
CounterShooter <- data.frame(option, value)

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
value <- c(10 + GetCoreLv(CannonShooterCore, "LoadedDice"))
LoadedDicePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(CannonShooterCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(CannonShooterCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

CannonShooterPassive <- Passive(list(BuildupCannon=BuildupCannon, CriticalFire=CriticalFire, PirateTraining=PirateTraining, CannonAcceleration=CannonAcceleration, 
                                     BarrelRoulettePassive=BarrelRoulettePassive, ReinforceCannon=ReinforceCannon, CounterShooter=CounterShooter, PirateSpiritPassive=PirateSpiritPassive, OverburningCannon=OverburningCannon, 
                                     BuckShotPassive=BuckShotPassive, LoadedDicePassive=LoadedDicePassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


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

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MiniCannonballStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MiniCannonballCharge <- rbind(data.frame(option, value), info)
 
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

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(20, 15)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice53 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(20, 25)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice533 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(30, 15)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice553 <- rbind(data.frame(option, value), info)

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

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(60, 10, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MonkeyFuriousBuff <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(CannonShooterCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + floor(GetCoreLv(CannonShooterCore, "SpecialMonkeyEscort")/2), 120, 780, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpecialMonkeyEscort <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 60, 960, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoolMakerStart <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15 + floor(GetCoreLv(CannonShooterCore, "PoolMaker")/2))
info <- c(20, 60, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoolMakerBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(CannonShooterCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="HandCannon", 6]))
info <- c(30, 70 - floor(GetCoreLv(CannonShooterCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="HandCannon", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(CannonShooterCore, "OverDrive")/5), T, CannonShooterBase$UnionChrs$CoolReduceP, CannonShooterBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(GetCoreLv(CannonShooterCore, "OverDrive")/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((CannonShooterBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(GetCoreLv(CannonShooterCore, "PirateFlag")/2)) * CannonShooterBase$MainStatP), 
           10 + floor(GetCoreLv(CannonShooterCore, "PirateFlag")/2))
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(CannonShooterCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * CannonShooterBase$MainStatP), 5 + floor(GetCoreLv(CannonShooterCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

CannonShooterBuff <- list(CocoballStack=CocoballStack, CocoballCharge=CocoballCharge, MiniCannonballStack=MiniCannonballStack, MiniCannonballCharge=MiniCannonballCharge, 
                          BarrelRouletteIce=BarrelRouletteIce, BarrelRouletteLightning=BarrelRouletteLightning, BarrelRouletteOthers=BarrelRouletteOthers, 
                          LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice555=LuckyDice555, LuckyDice53=LuckyDice53, LuckyDice533=LuckyDice533, LuckyDice553=LuckyDice553, 
                          HyperMonkeySpell=HyperMonkeySpell, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, MonkeyFuriousBuff=MonkeyFuriousBuff, 
                          UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, SpecialMonkeyEscort=SpecialMonkeyEscort, PoolMakerStart=PoolMakerStart, PoolMakerBuff=PoolMakerBuff, 
                          OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                          SoulContractLink=SoulContractLink, Restraint4=Restraint4)
## Petbuff : HyperMonkeySpell(1080ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  CannonShooterBuff[[length(CannonShooterBuff)+1]] <- UsefulAdvancedBless
  names(CannonShooterBuff)[[length(CannonShooterBuff)]] <- "UsefulAdvancedBless"
}
CannonShooterBuff <- Buff(CannonShooterBuff)
CannonShooterAllTimeBuff <- AllTimeBuff(CannonShooterBuff)


## CannonShooter - Union & HyperStat & SoulWeapon
CannonShooterSpec <- JobSpec(JobBase=CannonShooterBase, 
                             Passive=CannonShooterPassive, 
                             AllTimeBuff=CannonShooterAllTimeBuff, 
                             MobInfo=get(DPMCalcOption$MobSet), 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             WeaponName="HandCannon", 
                             UnionStance=0)

CannonShooterUnionRemained <- CannonShooterSpec$UnionRemained
CannonShooterHyperStatBase <- CannonShooterSpec$HyperStatBase
CannonShooterCoolReduceType <- CannonShooterSpec$CoolReduceType
CannonShooterSpec <- CannonShooterSpec$Spec


## CannonShooter - Spider In Mirror
SIM <- SIMData(GetCoreLv(CannonShooterCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## CannonShooter - ATK
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CannonShooterCore, "MonkeyFurious_MiniCannonball")>=40, 20, 0), 3 * GetCoreLv(CannonShooterCore, "MonkeyFurious_MiniCannonball"))
info <- c(180 * 0.45, 3 * 3, 810, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyFurious <- rbind(data.frame(option, value), info) ## ATKSpeed Applied

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CannonShooterCore, "BarrelRoulette")>=40, 20, 0), CannonShooterBase$MonsterLife$FinalATKDMR, 3 * GetCoreLv(CannonShooterCore, "BarrelRoulette"))
info <- c(175 * 0.45, 0.5 * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BarrelRoulette <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(20 + floor(CannonShooterSpec$SkillLv/2), ifelse(GetCoreLv(CannonShooterCore, "CannonBuster")>=40, 20, 0))), 2 * GetCoreLv(CannonShooterCore, "CannonBuster"))
info <- c((750 + 5 * CannonShooterSpec$SkillLv) * 0.45, 5 * 3, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CannonBuster <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CannonShooterCore, "RollingCannonRainbow")>=40, 20, 0), 2 * GetCoreLv(CannonShooterCore, "RollingCannonRainbow"))
info <- c(600, 3, 480, 480, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RollingCannonRainbow <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((450 + 15 * GetCoreLv(CannonShooterCore, "Cocoball")) * 0.45, 4 * 3, 780, 210, 0.5, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Cocoball <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((800 + 32 * GetCoreLv(CannonShooterCore, "ICBM")) * 0.45, 5 * 3, 660 + 510, 150, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ICBM <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * GetCoreLv(CannonShooterCore, "ICBM")) * 0.45, 1 * 3, 0, 500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ICBMFloor <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * GetCoreLv(CannonShooterCore, "SpecialMonkeyEscort"), 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyEscortCannon <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(450 + 18 * GetCoreLv(CannonShooterCore, "SpecialMonkeyEscort"), 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MonkeyEscortBomb <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((700 + 28 * GetCoreLv(CannonShooterCore, "PoolMaker")) * 0.45, 3 * 3, 0, 1020, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoolMaker <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CannonShooterCore, "MonkeyFurious_MiniCannonball")>=40, 20, 0), 3 * GetCoreLv(CannonShooterCore, "MonkeyFurious_MiniCannonball"))
info <- c(180 * 0.45, 5 * 3, 0, NA, NA, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MiniCannonball <- rbind(data.frame(option, value), info)
}

CannonShooterATK <- Attack(list(MonkeyFurious=MonkeyFurious, BarrelRoulette=BarrelRoulette, CannonBuster=CannonBuster, RollingCannonRainbow=RollingCannonRainbow, 
                                Cocoball=Cocoball, ICBM=ICBM, ICBMFloor=ICBMFloor, MonkeyEscortCannon=MonkeyEscortCannon, MonkeyEscortBomb=MonkeyEscortBomb, PoolMaker=PoolMaker, MiniCannonball=MiniCannonball, 
                                SpiderInMirror=SpiderInMirror))


## CannonShooter - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CannonShooterCore, "SupportMonkeyTwins")>=40, 20, 0), 2 * GetCoreLv(CannonShooterCore, "SupportMonkeyTwins"))
info <- c((295 + 8 * CannonShooterSpec$SkillLv) * 0.6, 2 * 3, 0, 930, 60 + 2 * CannonShooterSpec$SkillLv, 10, T, NA, NA, F)
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
BuffFinal[rownames(BuffFinal)=="SoulContractLink", ]$CoolTime <- 90

SummonedFinal <- data.frame(CannonShooterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, CannonShooterSpec$CoolReduceP, CannonShooterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * CannonShooterSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(CannonShooterBuff))
CannonShooterDealCycle <- t(rep(0, length(DealCycle)))
colnames(CannonShooterDealCycle) <- DealCycle

CannonShooterCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                               Period=c(180, 182.4), CycleTime=c(360, 364.8)) {
  BuffSummonedPrior <- c("BarrelRouletteOthers", "LuckyDice5", "HyperMonkeySpell", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "SupportMonkeyTwins", "MapleWarriors2", "SpecialMonkeyEscort", "PoolMakerStart", "OverDrive", "SoulContractLink", "Restraint4")
  Times180 <- c(1, 1, 0, 0, 0, 0, 0, 
                3, 1, 1.5, 3, 2, 2, 1)
  Times182 <- c(1, 1, 0, 0, 0, 0, 0, 
                3, 1, 1.5, 3, 3, 2, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    Times182 <- Times182[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period - min(2.4, Spec$CoolReduce), length(BuffSummonedPrior))
  TotalTime <- CycleTime - min(2.4, Spec$CoolReduce)
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
  DealCycle$MiniCannonballStack[2] <- 0 ; DealCycle$MiniCannonballCharge[2] <- 5000
  
  ## Cocoball, Mini Cannonball Stack
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
    
    if(DealCycle$Skills[nrow(DealCycle)]=="MiniCannonball") {
      DealCycle$MiniCannonballStack[nrow(DealCycle)] <- DealCycle$MiniCannonballStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$MiniCannonballStack[nrow(DealCycle)] <- DealCycle$MiniCannonballStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$MiniCannonballCharge[nrow(DealCycle)-1] >= 0 & DealCycle$MiniCannonballCharge[nrow(DealCycle)]==0 & DealCycle$MiniCannonballStack[nrow(DealCycle)] < 5) {
      DealCycle$MiniCannonballStack[nrow(DealCycle)] <- DealCycle$MiniCannonballStack[nrow(DealCycle)] + 1
      DealCycle$MiniCannonballCharge[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 5000, 5000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$MiniCannonballCharge[nrow(DealCycle)-1]))
    } else if(DealCycle$MiniCannonballStack[nrow(DealCycle)] == 5) {
      DealCycle$MiniCannonballCharge[nrow(DealCycle)] <- 5000
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
        }
      }
      ## Cocoball
      if(DealCycle$CocoballStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] > 0 & sum(k==c(5, 9))==0 | 
         DealCycle$CocoballStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] > 0 & sum(k==c(5, 9)) > 0 & 
         DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + (3 - DealCycle$CocoballStack[nrow(DealCycle)] + 1) * 25000 - (25000 - DealCycle$CocoballCharge[nrow(DealCycle)]) <= BuffStartTime)  {
        DealCycle <- DCATK(DealCycle, "Cocoball", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        
        while(DealCycle$CocoballStack[nrow(DealCycle)] > 0) { 
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle <- CocoballStack(DealCycle)
        }
      }
      ## ICBM
      else if(ICBMRemain==0 & sum(k==c(5, 9))==0 | 
              ICBMRemain==0 & sum(k==c(5, 9)) > 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ICBMCool <= BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "ICBMFloor", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- ICBMCool - DealCycle$Time[1]
        
        DealCycle <- DCATK(DealCycle, "ICBM", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
      }
      ## Pirate Flag
      else if(PFRemain==0 & k!=9 | 
              PFRemain==0 & k==9 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + PFCool <= BuffStartTime) {
        DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- PFCool - DealCycle$Time[1]
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
      }
      ## Monkey Furious
      else if(DealCycle$MonkeyFuriousBuff[nrow(DealCycle)] - DealCycle$Time[1] < 5000) {
        DealCycle <- DCBuff(DealCycle, "MonkeyFuriousBuff", BuffFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MonkeyFurious", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
      }
      ## Cannon Buster
      else {
        DealCycle <- DCATK(DealCycle, "CannonBuster", ATKFinal)
        DealCycle <- CocoballStack(DealCycle)
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        
        if(DealCycle$MiniCannonballStack[nrow(DealCycle)] > 0) {
          DealCycle[1, 2:ncol(DealCycle)] <- 540
          DealCycle <- DCATK(DealCycle, "MiniCannonball", ATKFinal)
          DealCycle <- CocoballStack(DealCycle)
          DealCycle[1, 2:ncol(DealCycle)] <- ATKFinal[rownames(ATKFinal)=="CannonBuster", ]$Delay - 540
        }
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="SoulContractLink") {
            DealCycle <- DCATK(DealCycle, "RollingCannonRainbow", ATKFinal)
            DealCycle <- CocoballStack(DealCycle)
            PFRemain <- max(0, PFRemain - DealCycle$Time[1])
            ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
          } 
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- CocoballStack(DealCycle)
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          ICBMRemain <- max(0, ICBMRemain - DealCycle$Time[1])
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
CannonShooterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, BarrelRouletteFinalATK=F, CocoballHits=40) {
  ## Barrel Roulette Final Attack
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$BarrelRouletteLightning[i] > 0 & sum(DealCycle$Skills[i]==c("MonkeyFurious", "MonkeyWave", "CannonBuster"))>=1 | 
       BarrelRouletteFinalATK==T & DealCycle$BarrelRouletteOthers[i] > 0 & sum(DealCycle$Skills[i]==c("MonkeyFurious", "MonkeyWave", "CannonBuster"))>=1) {
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
CannonShooterProbBuff <- function(DealCycle, LuckyDice=c(5, 55, 555, 53, 533, 553), BarrelRoulette=c("Ice", "Lightning", "Others")) {
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
  } else if(LuckyDice==53) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$LuckyDice5[i] > 0) {
        DealCycle$LuckyDice53[i] <- DealCycle$LuckyDice5[i]
        DealCycle$LuckyDice5[i] <- 0
      }
    }
  } else if(LuckyDice==533) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$LuckyDice5[i] > 0) {
        DealCycle$LuckyDice533[i] <- DealCycle$LuckyDice5[i]
        DealCycle$LuckyDice5[i] <- 0
      }
    }
  } else if(LuckyDice==553) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$LuckyDice5[i] > 0) {
        DealCycle$LuckyDice553[i] <- DealCycle$LuckyDice5[i]
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

## DealCycle Generation
CSList <- data.frame(LuckyDice=c(5, 5, 5, 55, 55, 55, 555, 555, 555, 53, 53, 53, 533, 533, 533, 553, 553, 553), 
                     BarrelRoulette=c(rep(c("Lightning", "Ice", "Others"), 6)), 
                     BarrelRouletteFinalATK=c(rep(c(T, F, F), 6)))
CannonShooterLuckyDiceProbs <- c(rep(0.592680, 3), rep(0.208894, 3), rep(0.009475, 3), rep(0.135320, 3), rep(0.017340, 3), rep(0.036291, 3))
CannonShooterBarrelRouletteProbs <- c(rep(c(0.25, 0.25, 0.5), 6))
CannonShooterCycleProbs <- CannonShooterLuckyDiceProbs * CannonShooterBarrelRouletteProbs
CannonShooterCycleNames <- c()
for(i in 1:nrow(CSList)) {
  CannonShooterCycleNames <- c(CannonShooterCycleNames, paste("CannonShooterDealCycle_", CSList$LuckyDice[i], CSList$BarrelRoulette[i], sep=""))
}
CSList$CycleProbs <- CannonShooterCycleProbs
CSList$CycleNames <- CannonShooterCycleNames
rm(CannonShooterLuckyDiceProbs) ; rm(CannonShooterBarrelRouletteProbs) ; rm(CannonShooterCycleProbs) ; rm(CannonShooterCycleNames)

DealCycleDummy1 <- CannonShooterAddATK(CannonShooterDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       CannonShooterSpec,
                                       BarrelRouletteFinalATK=F,
                                       CocoballHits=40)
DealCycleDummy2 <- CannonShooterAddATK(CannonShooterDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       CannonShooterSpec,
                                       BarrelRouletteFinalATK=T,
                                       CocoballHits=40)

for(i in 1:nrow(CSList)) {
  if(CSList$BarrelRouletteFinalATK[i] == F) {
    DealCycleDummy <- CannonShooterProbBuff(DealCycleDummy1, CSList$LuckyDice[i], CSList$BarrelRoulette[i])
  } else {
    DealCycleDummy <- CannonShooterProbBuff(DealCycleDummy2, CSList$LuckyDice[i], CSList$BarrelRoulette[i])
  }
  DealCycleDummy <- OverDriveExhaustBuff(DealCycleDummy, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
  assign(paste("CannonShooterDealCycle_", CSList$LuckyDice[i], CSList$BarrelRoulette[i], sep=""), DealCycleDummy)
  rm(DealCycleDummy)
}
rm(DealCycleDummy1)
rm(DealCycleDummy2)

CannonShooterDealCycleReduction <- DealCycleReduction(CannonShooterDealCycle_5Others)

for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="CannonMaster") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  CannonShooterSpecOpt1 <- Optimization1(CannonShooterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpec, CannonShooterUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- CannonShooterSpecOpt1[1, 1:3]
} else {
  CannonShooterSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
CannonShooterSpecOpt <- OptDataAdd(CannonShooterSpec, CannonShooterSpecOpt1, "Potential", CannonShooterBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  CannonShooterSpecOpt2 <- Optimization2(CannonShooterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt, CannonShooterHyperStatBase, CannonShooterBase$ChrLv, CannonShooterBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- CannonShooterSpecOpt2[1, ]
} else {
  CannonShooterSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
CannonShooterSpecOpt <- OptDataAdd(CannonShooterSpecOpt, CannonShooterSpecOpt2, "HyperStat", CannonShooterBase$CRROver, DemonAvenger=F)

CannonShooterFinalDPM <- ResetDealCalc(DealCycles=GetList(CSList$CycleNames), 
                                       ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt, rep(max(CannonShooterDealCycle$Time), nrow(CSList)), CSList$CycleProbs)
CannonShooterFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=GetList(CSList$CycleNames), 
                                                        ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt, rep(max(CannonShooterDealCycle$Time), nrow(CSList)), CSList$CycleProbs)

set(get(DPMCalcOption$DataName), as.integer(1), "CannonMaster", sum(na.omit(CannonShooterFinalDPMwithMax)) / (max(CannonShooterDealCycle_5Others$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "CannonMaster", sum(na.omit(CannonShooterFinalDPM)) / (max(CannonShooterDealCycle_5Others$Time) / 60000) - 
      sum(na.omit(CannonShooterFinalDPMwithMax)) / (max(CannonShooterDealCycle_5Others$Time) / 60000))

CannonShooterDealDatas <- list()
for(i in 1:nrow(CSList)) {
  CannonShooterDealDatas[[i]] <- DealCalcWithMaxDMR(get(CSList$CycleNames[i]), ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt)
}
CannonShooterDealRatio <- ResetDealRatio(DealCycles=GetList(CSList$CycleNames), 
                                         DealDatas=CannonShooterDealDatas, 
                                         rep(max(CannonShooterDealCycle$Time), nrow(CSList)), 
                                         CSList$CycleProbs)

CannonShooterDealData <- data.frame(CannonShooterDealCycle_5Others$Skills, CannonShooterDealCycle_5Others$Time, CannonShooterDealCycle_5Others$Restraint4, 
                                    CannonShooterDealDatas[[3]])
colnames(CannonShooterDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "CannonMaster", Deal_RR(CannonShooterDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "CannonMaster", Deal_40s(CannonShooterDealData))

CannonShooterSpecMean <- ResetSpecMean("CannonShooter", 
                                       GetList(CSList$CycleNames), 
                                       CannonShooterDealDatas, 
                                       ATKFinal, BuffFinal, SummonedFinal, CannonShooterSpecOpt, rep(max(CannonShooterDealCycle$Time), nrow(CSList)), CSList$CycleProbs)