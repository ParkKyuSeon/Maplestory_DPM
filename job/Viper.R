## Viper - Data
## Viper - VMatrix
ViperCore <- MatrixSet(PasSkills=c("FistEnrage", "Nautilus", "DragonStrike", "UnityofPower", "EnergyBlast", "ScrewPunch"), 
                       PasLvs=c(50, 50, 50, 50, 50, 50), 
                       PasMP=c(10, 10, 10, 0, 0, 0), 
                       ActSkills=c("Transform", "SerpentScrew", "FuriousCharge", "HawlingFist",
                                   CommonV("Pirate", "Adventure")), 
                       ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                       ActMP=c(5, 5, 5, 5, 5, 5, 5, 5, 5), 
                       BlinkLv=1, 
                       BlinkMP=0, 
                       UsefulSkills=c("SharpEyes", "CombatOrders"), 
                       UsefulLvs=20, 
                       UsefulMP=0, 
                       SpecSet=SpecDefault, 
                       SelfBind=T)


## Viper - Basic Info
ViperBase <- JobBase(ChrInfo=ChrInfo, 
                     MobInfo=MobDefault,
                     SpecSet=SpecDefault, 
                     Job="Viper",
                     CoreData=ViperCore, 
                     BuffDurationNeeded=0, 
                     AbilList=c("BDR", "DisorderBDR"), 
                     LinkList=c("AdventurePirates", "Xenon", "DemonAvenger", "CygnusKnights"), 
                     MonsterLife=MLTypeS21, 
                     Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", SpecDefault$WeaponType)[, 1:16],
                     WeaponType=SpecDefault$WeaponType, 
                     SubWeapon=SubWeapon[15, ], 
                     Emblem=Emblem[1, ])


## Viper - Passive
{option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(20, 5)
CriticalRoar <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
MentalClearity <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CRR", "CDMR", "ATK"), levels=PSkill)
value <- c(35, 10, 30)
CriticalRage <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70 + ceiling(ViperBase$SkillLv/2))
VipersitionPassive <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(25 + 2 * ViperBase$SkillLv)
CounterAttack <- data.frame(option, value)

option <- factor(c("IGR", "ATK"), levels=PSkill)
value <- c(40 + 2 * ViperBase$SkillLv, 30 + ViperBase$SkillLv)
GuardCrush <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20)
StimulatePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + ViperCore[[2]][5, 2])
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(ViperCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

ViperPassive <- Passive(list(CriticalRoar, MentalClearity, PhysicalTraining, CriticalRage, VipersitionPassive, CounterAttack, GuardCrush, StimulatePassive,
                             LoadedDice, BlinkPassive))


## Viper - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Energy <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FullCharge <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
StimulateEnergy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(270, 1, 600, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SerpentScrewOn <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FuriousChargeStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FuriousChargeDummy <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
KnuckleBooster <- rbind(data.frame(option, value), info) 

option <- factor(c("ATKP"), levels=BSkill)
value <- c(30 + ViperBase$SkillLv)
info <- c(180 + 4 * ViperBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Vipersition <- rbind(data.frame(option, value), info) 

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180 + 4 * ViperBase$SkillLv, NA, 900, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindBooster <- rbind(data.frame(option, value), info) 

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ViperBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ViperBase$SkillLv/2))))
info <- c(900 + 30 * ViperBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(60, T, ViperBase$UnionChrs$CoolReduceP, ViperBase$CoolReduce), 60, Delay(900, 2), F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
NautilusBuff <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR"), levels=BSkill)
value <- c(20 + floor(ViperBase$SkillLv/2))
info <- c(15, 16, Delay(900, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DragonStrikeDebuff <- rbind(data.frame(option, value), info) 

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

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(20, 20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice57 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice555 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(30, 20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice557 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(20, 30)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice577 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(120, 240, 930, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Stimulate <- rbind(data.frame(option, value), info) ## SubTime : 4000ms

option <- factor(c("CDMR"), levels=BSkill)
value <- c(40)
info <- c(90, NA, Delay(900, 2), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UnityofPowerBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * ViperCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ViperCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20 + floor(ViperCore[[2]][1, 2]/5))
info <- c(50 + ViperCore[[2]][1, 2], 180, 450, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Transform <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * ViperCore[[2]][6, 2]) * ArcaneShade[28, 6]))
info <- c(30, 70 - floor(ViperCore[[2]][6, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[28, 6]))
info <- c(Cooldown(70 - floor(ViperCore[[2]][6, 2]/5), T, ViperBase$UnionChrs$CoolReduceP, ViperBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(ViperCore[[2]][6, 2]/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((ViperBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(ViperCore[[2]][7, 2]/2)) * ViperBase$MainStatP), 10 + floor(ViperCore[[2]][7, 2]/2))
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * ViperCore[[2]][8, 2]) * MapleSoldier[1, 2]) * ViperBase$MainStatP), 5 + floor(ViperCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ViperBuff <- Buff(list(Energy=Energy, FullCharge=FullCharge, StimulateEnergy=StimulateEnergy, SerpentScrewOn=SerpentScrewOn, FuriousChargeStack=FuriousChargeStack, FuriousChargeDummy=FuriousChargeDummy, 
                       KnuckleBooster=KnuckleBooster, Vipersition=Vipersition, WindBooster=WindBooster, MapleSoldier=MapleSoldier, 
                       NautilusBuff=NautilusBuff, DragonStrikeDebuff=DragonStrikeDebuff, 
                       LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice57=LuckyDice57, LuckyDice555=LuckyDice555, LuckyDice557=LuckyDice557, LuckyDice577=LuckyDice577, 
                       Stimulate=Stimulate, UnityofPowerBuff=UnityofPowerBuff, EpicAdventure=EpicAdventure, 
                       UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                       Transform=Transform, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                       SoulContractLink=SoulContractLink, Restraint4=Restraint4))
## Petbuff : Vipersition(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms)
ViperAllTimeBuff <- AllTimeBuff(ViperBuff)


## Viper - Union & HyperStat & SoulWeapon
ViperSpec <- JobSpec(JobBase=ViperBase, 
                     Passive=ViperPassive, 
                     AllTimeBuff=ViperAllTimeBuff, 
                     MobInfo=MobDefault, 
                     SpecSet=SpecDefault, 
                     WeaponName="Knuckle", 
                     UnionStance=0)

ViperUnionRemained <- ViperSpec$UnionRemained
ViperHyperStatBase <- ViperSpec$HyperStatBase
ViperCoolReduceType <- ViperSpec$CoolReduceType
ViperSpec <- ViperSpec$Spec


## Viper - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * ViperCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * ViperCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ViperCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ViperCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ViperCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ViperCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Viper - ATK
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(200, ifelse(ViperCore[[1]][6, 2]>=40, 20, 0), 2 * ViperCore[[1]][6, 2])
info <- c(120, 3, 120, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScrewPunch <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(ViperCore[[1]][1, 2]>=40, 20, 0), 2 * ViperCore[[1]][1, 2])
info <- c(320 + 4 * ViperSpec$SkillLv, 9, 780, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FistEnrage <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(ViperCore[[1]][1, 2]>=40, 20, 0), 2 * ViperCore[[1]][1, 2])
info <- c(320 + 4 * ViperSpec$SkillLv, 11, 780, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FistEnrageFullCharge <- rbind(data.frame(option, value), info) ## Energy Cost : 150

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ViperCore[[1]][3, 2]>=40, 20, 0), 2 * ViperCore[[1]][3, 2])
info <- c(300 + 4 * ViperSpec$SkillLv, 12, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonStrike <- rbind(data.frame(option, value), info) ## Energy Cost : 180

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ViperCore[[1]][2, 2]>=40, 20, 0), 2 * ViperCore[[1]][2, 2])
info <- c(440 + 4 * ViperSpec$SkillLv, 7, 0, NA, 60, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Nautilus <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ViperCore[[1]][2, 2]>=40, 20, 0), 2 * ViperCore[[1]][2, 2])
info <- c(165 + 2 * ViperSpec$SkillLv, 2, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusFinalATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(ViperCore[[1]][4, 2]>=40, 20, 0), 2 * ViperCore[[1]][4, 2])
info <- c(650, 5, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnityofPower <- rbind(data.frame(option, value), info) ## Energy Cost : 1000

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(450 + 18 * ViperCore[[2]][1, 2], 3, 1020, 150, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TransformOrb <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c()
info <- c(360 + 14 * ViperCore[[2]][2, 2], 3, 270, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SerpentScrewTick <- rbind(data.frame(option, value), info) ## Energy Cost : 60 / sec, 25.5 / Tick

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SerpentScrewOffDummy <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(30)
info <- c(600 + 24 * ViperCore[[2]][3, 2], 10, 540, NA, 0.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuriousCharge <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(425 + 17 * ViperCore[[2]][4, 2], 6, 2100, 240, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HawlingFistStart <- rbind(data.frame(option, value), info) ## Energy Cost : 1250

option <- factor(levels=ASkill)
value <- c()
info <- c(525 + 21 * ViperCore[[2]][4, 2], 10, 2580, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HawlingFistLast <- rbind(data.frame(option, value), info) 
## 120ms(1), 840ms(2), 1080ms(3), 1260ms(4), 1350ms(5), 1440ms(6), 1530ms(7), 1620ms(8), 1710ms(9), 1800ms(10), 1890ms(11), 1980ms(12), 2070ms(13), 2160ms(14)
}

ViperATK <- Attack(list(ScrewPunch=ScrewPunch, FistEnrage=FistEnrage, FistEnrageFullCharge=FistEnrageFullCharge, DragonStrike=DragonStrike, Nautilus=Nautilus, NautilusFinalATK=NautilusFinalATK, 
                        UnityofPower=UnityofPower, TransformOrb=TransformOrb, SerpentScrewTick=SerpentScrewTick, SerpentScrewOffDummy=SerpentScrewOffDummy, 
                        FuriousCharge=FuriousCharge, HawlingFistStart=HawlingFistStart, HawlingFistLast=HawlingFistLast, 
                        SpiderInMirror=SpiderInMirror))


## Viper - Summoned
ViperSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, 
                               SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                               SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Viper - DealCycle & Deal Calculation
ATKFinal <- data.frame(ViperATK)
ATKFinal$Delay[c(-1, -9, -12)] <- Delay(ATKFinal$Delay, ViperSpec$ATKSpeed)[c(-1, -9, -12)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)

BuffFinal <- data.frame(ViperBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ViperSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(ViperSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ViperSpec$SummonedDuration / 100, 0)


## Viper - DealCycle and Deal Calc
DealCycle <- c("Skills", "Time", rownames(ViperBuff))
ViperDealCycle <- t(rep(0, length(DealCycle)))
colnames(ViperDealCycle) <- DealCycle
ViperDealCycle <- data.frame(ViperDealCycle)

ViperCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                       Period=c(182.4), CycleTime=c(729.6)) {
  BuffSummonedPrior <- c("Vipersition", "KnuckleBooster", "WindBooster", "LuckyDice5", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure", 
                         "Stimulate", "Transform", "MapleWarriors2", "OverDrive", "PirateFlag", "SoulContractLink", "Restraint4")
  
  Times180 <- c(0, 1, 1, 1, 0, 0, 0, 
                0.75, 1, 1, 3, 6, 2, 1)
  SubTime <- rep(Period, length(BuffSummonedPrior)) * 10
  TotalTime <- CycleTime * 10
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
  
  ## Energy Charge : 700 (Screw Punch, Fist Enrage, Furious Charge, Nautilus) / 800 (Stimulate Tick)
  ## Energy Cost : 150 (Fist Enrage(Charged)) / 180 (Dragon Strike) / 1000 (Unity of Power) / 25.5 (Serpent Screw Tick) / 60 (Serpent Screw per sec) / 1250 (Hawling Fist)
  ViperStacks <- function(DealCycle) {
    ## Energy Cost
    DealCycle$Energy[nrow(DealCycle)] <- DealCycle$Energy[nrow(DealCycle)-1]
    DealCycle$FullCharge[nrow(DealCycle)] <- DealCycle$FullCharge[nrow(DealCycle)-1]
    if(DealCycle$Skills[nrow(DealCycle)]=="FistEnrage" & DealCycle$FullCharge[nrow(DealCycle)] > 0) {
      DealCycle$Skills[nrow(DealCycle)] <- "FistEnrageFullCharge"
    }
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ScrewPunch", "FistEnrage", "FuriousCharge", "Nautilus")) >= 1 & DealCycle$FullCharge[nrow(DealCycle)]==0) {
      DealCycle$Energy[nrow(DealCycle)] <- min(10000, DealCycle$Energy[nrow(DealCycle)] + 700)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==10000, 1, DealCycle$FullCharge[nrow(DealCycle)])
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("FistEnrageFullCharge")) >= 1 & DealCycle$FullCharge[nrow(DealCycle)] > 0) {
      DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - 150)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("DragonStrike")) >= 1 & DealCycle$FullCharge[nrow(DealCycle)] > 0) {
      DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - 180)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("UnityofPower")) >= 1 & DealCycle$FullCharge[nrow(DealCycle)] > 0) {
      DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - 1000)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("HawlingFistStart")) >= 1 & DealCycle$FullCharge[nrow(DealCycle)] > 0) {
      DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - 1250)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("Stimulate", "Transform")) >= 1) {
      DealCycle$Energy[nrow(DealCycle)] <- 10000
      DealCycle$FullCharge[nrow(DealCycle)] <- 1
    }
    
    if(DealCycle$StimulateEnergy[nrow(DealCycle)-1] >= 0 & DealCycle$StimulateEnergy[nrow(DealCycle)]==0 & 
       DealCycle$Stimulate[nrow(DealCycle)] > 0 & DealCycle$Skills[nrow(DealCycle)]!="Stimulate") {
      DealCycle$Energy[nrow(DealCycle)] <- min(10000, DealCycle$Energy[nrow(DealCycle)] + 800)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==10000, 1, DealCycle$FullCharge[nrow(DealCycle)])
      DealCycle$StimulateEnergy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 5000, 5000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$StimulateEnergy[nrow(DealCycle)-1]))
    } else if(DealCycle$Skills[nrow(DealCycle)]=="Stimulate") {
      DealCycle$StimulateEnergy[nrow(DealCycle)] <- 5000
    } 
    
    if(DealCycle$SerpentScrewOn[nrow(DealCycle)] > 0 & DealCycle$Skills[nrow(DealCycle)]!="SerpentScrewOn") {
      DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - (ceiling(DealCycle$SerpentScrewOn[nrow(DealCycle)-1]/1000) - ceiling(DealCycle$SerpentScrewOn[nrow(DealCycle)]/1000)) * 60)
      DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
    }
    
    ## Furious Charge
    DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)-1]
    if(DealCycle$FuriousChargeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$FuriousChargeDummy[nrow(DealCycle)]==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] < 6) {
      DealCycle$FuriousChargeStack[nrow(DealCycle)] <- min(6, DealCycle$FuriousChargeStack[nrow(DealCycle)] + 1)
      DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 8000, 
                                                              8000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$FuriousChargeDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$Skills[nrow(DealCycle)]=="FuriousCharge") {
      DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)] - 1
    } else if(DealCycle$FuriousChargeStack[nrow(DealCycle)] == 6) {
      DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- 8000
    }
    
    SerpentTimeList <- seq(0, 270000, 270)[order(seq(0, 270000, 270), decreasing=T)][c(-1, -2)]
    ## Serpent Screw (Tick)
    if(DealCycle$SerpentScrewOn[nrow(DealCycle)] > 0) {
      Serpent <- SerpentTimeList[SerpentTimeList <= DealCycle$SerpentScrewOn[nrow(DealCycle)]]
      Serpent <- Serpent[Serpent > DealCycle$SerpentScrewOn[nrow(DealCycle)] - DealCycle$Time[1]]
      
      if(length(Serpent) > 0) {
        OriginalTime <- DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]
        for(i in 1:length(Serpent)) {
          if(DealCycle$SerpentScrewOn[nrow(DealCycle)] > 0) {
            DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$SerpentScrewOn[nrow(DealCycle)] - Serpent[i]
            DealCycle <- DCATK(DealCycle, "SerpentScrewTick", ATKFinal)
            DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)-1] - 
                                                       (ceiling(DealCycle$SerpentScrewOn[nrow(DealCycle)-1]/1000) - ceiling(DealCycle$SerpentScrewOn[nrow(DealCycle)]/1000)) * 60)
            DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)-1])
            if(DealCycle$Energy[nrow(DealCycle)]==0) {
              DealCycle$Skills[nrow(DealCycle)] <- "SerpentScrewOffDummy"
              DealCycle$SerpentScrewOn[nrow(DealCycle)] <- 0
            }
            
            DealCycle$Energy[nrow(DealCycle)] <- max(0, DealCycle$Energy[nrow(DealCycle)] - 25.5)
            DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==0, 0, DealCycle$FullCharge[nrow(DealCycle)])
            
            if(DealCycle$StimulateEnergy[nrow(DealCycle)-1] >= 0 & DealCycle$StimulateEnergy[nrow(DealCycle)]==0 & 
               DealCycle$Stimulate[nrow(DealCycle)] > 0 & DealCycle$Skills[nrow(DealCycle)]!="Stimulate") {
              DealCycle$Energy[nrow(DealCycle)] <- min(10000, DealCycle$Energy[nrow(DealCycle)] + 800)
              DealCycle$FullCharge[nrow(DealCycle)] <- ifelse(DealCycle$Energy[nrow(DealCycle)]==10000, 1, DealCycle$FullCharge[nrow(DealCycle)])
              DealCycle$StimulateEnergy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 5000, 
                                                                   5000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$StimulateEnergy[nrow(DealCycle)-1]))
            } 
            
            DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)-1]
            if(DealCycle$FuriousChargeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$FuriousChargeDummy[nrow(DealCycle)]==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] < 6) {
              DealCycle$FuriousChargeStack[nrow(DealCycle)] <- min(6, DealCycle$FuriousChargeStack[nrow(DealCycle)] + 1)
              DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 8000, 
                                                                      8000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$FuriousChargeDummy[nrow(DealCycle)-1]))
            } else if(DealCycle$Skills[nrow(DealCycle)]=="FuriousCharge") {
              DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)] - 1
            } else if(DealCycle$FuriousChargeDummy[nrow(DealCycle)] == 6) {
              DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- 8000
            }
          } 
          if(i==length(Serpent)) {
            DealCycle[1, 2:ncol(DealCycle)] <- OriginalTime - DealCycle$Time[nrow(DealCycle)]
          }
        }
      }
    }
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$FuriousChargeStack[nrow(DealCycle)] <- 6
  DealCycle$Energy[nrow(DealCycle)] <- 1000
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="Stimulate") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- ViperStacks(DealCycle)
        DealCycle <- DCATK(DealCycle, "UnityofPower", ATKFinal)
        DealCycle <- ViperStacks(DealCycle)
        DealCycle <- DCBuff(DealCycle, "UnityofPowerBuff", BuffFinal)
        DealCycle <- ViperStacks(DealCycle)
        DealCycle <- DCATK(DealCycle, "Nautilus", ATKFinal)
        DealCycle <- ViperStacks(DealCycle)
        DealCycle <- DCBuff(DealCycle, "NautilusBuff", BuffFinal)
        DealCycle <- ViperStacks(DealCycle)
        DealCycle <- DCBuff(DealCycle, "SerpentScrewOn", BuffFinal)
        DealCycle <- ViperStacks(DealCycle)
      } 
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- ViperStacks(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- ViperStacks(DealCycle)
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
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime/10, stringsAsFactors=F)
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
  DSCool <- subset(ATKFinal, rownames(ATKFinal)=="DragonStrike")$CoolTime * 1000
  NACool <- subset(ATKFinal, rownames(ATKFinal)=="Nautilus")$CoolTime * 1000
  FCCool <- subset(ATKFinal, rownames(ATKFinal)=="FuriousCharge")$CoolTime * 1000
  UPCool <- subset(ATKFinal, rownames(ATKFinal)=="UnityofPower")$CoolTime * 1000
  
  DSRemain <- 0 ; FCRemain <- 0
  NARemain <- NACool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="Nautilus")$Time)
  UPRemain <- UPCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="UnityofPower")$Time)
  
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes/10, TotalTime/10000)
  
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
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          UPRemain <- max(0, UPRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        }
      }
      ## Serpent Screw
      if(DealCycle$Energy[nrow(DealCycle)] >= 200 & DealCycle$SerpentScrewOn[nrow(DealCycle)] == 0) {
        DealCycle <- DCBuff(DealCycle, "SerpentScrewOn", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Dragon Strike Debuff
      else if(DSRemain == 0 & DealCycle$Energy[nrow(DealCycle)] >= 180 & DealCycle$FullCharge[nrow(DealCycle)] > 0 & DealCycle$DragonStrikeDebuff[nrow(DealCycle)] < 3000) {
        DealCycle <- DCATK(DealCycle, "DragonStrike", ATKFinal)
        DSRemain <- DSCool - DealCycle$Time[1]
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "DragonStrikeDebuff", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      } else if(DSRemain == 0 & DealCycle$Energy[nrow(DealCycle)] >= 180 & DealCycle$FullCharge[nrow(DealCycle)] > 0 & DealCycle$Energy[nrow(DealCycle)] <= 500) {
        DealCycle <- DCATK(DealCycle, "DragonStrike", ATKFinal)
        DSRemain <- DSCool - DealCycle$Time[1]
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "DragonStrikeDebuff", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Unity of Power
      else if(UPRemain == 0 & DealCycle$Energy[nrow(DealCycle)] >= 1000 & DealCycle$FullCharge[nrow(DealCycle)] > 0 & DealCycle$UnityofPowerBuff[nrow(DealCycle)] < 20000) {
        DealCycle <- DCATK(DealCycle, "UnityofPower", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- UPCool - DealCycle$Time[1]
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "UnityofPowerBuff", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Nautilus
      else if(NARemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="Nautilus")) <= 11) {
        DealCycle <- DCATK(DealCycle, "Nautilus", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- NACool - DealCycle$Time[1]
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "NautilusBuff", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Hawling Fist
      else if(DealCycle$Energy[nrow(DealCycle)] >= 1250 & 
              nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="HawlingFistStart"))) {
        DealCycle <- DCATK(DealCycle, "HawlingFistStart", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "HawlingFistLast", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Transform Orb
      else if(nrow(subset(DealCycle, DealCycle$Skills=="Transform")) * 3 > nrow(subset(DealCycle, DealCycle$Skills=="TransformOrb"))) {
        DealCycle <- DCATK(DealCycle, "TransformOrb", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Furious Charge
      else if(k < length(BuffList) - 1 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] - DealCycle$Time[1] > 0 | 
              k < length(BuffList) - 1 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & DealCycle$SoulContractLink[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "FuriousCharge", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- FCCool - DealCycle$Time[1]
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      } else if(k == length(BuffList) - 1 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & 
                DealCycle$Time[nrow(DealCycle)] + (6 - DealCycle$FuriousChargeStack[nrow(DealCycle)] + 1) * 8000 - (8000 - DealCycle$FuriousChargeDummy[nrow(DealCycle)]) < BuffStartTime + 30400) {
        DealCycle <- DCATK(DealCycle, "FuriousCharge", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- FCCool - DealCycle$Time[1]
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Fist Enrage
      else if(DealCycle$FullCharge[nrow(DealCycle)]==0) {
        DealCycle <- DCATK(DealCycle, "ScrewPunch", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "FistEnrage", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      } else {
        DealCycle <- DCATK(DealCycle, "FistEnrageFullCharge", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        UPRemain <- max(0, UPRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="Stimulate") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
            NARemain <- max(0, NARemain - DealCycle$Time[1])
            FCRemain <- max(0, FCRemain - DealCycle$Time[1])
            UPRemain <- max(0, UPRemain - DealCycle$Time[1])
            DealCycle <- ViperStacks(DealCycle)
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          UPRemain <- max(0, UPRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          UPRemain <- max(0, UPRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        }
      }
    }
  }
  return(DealCycle)
}
ViperAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                        LuckyDice=c(5, 55, 57, 555, 557, 577)) {
  ## Transform Orb
  DealCycle <- RepATKCycle(DealCycle, "TransformOrb", 5, 1500, ATKFinal)
  
  ## Hawling Fist
  DealCycle <- RepATKCycle(DealCycle, "HawlingFistStart", 8, 240, ATKFinal)
  
  DealCycle$Skills[DealCycle$Skills=="HawlingFistLast"] <- "HawlingFistLastStart"
  HawlingFistLastDelay <- c(120, 840, 1080, 1260, 1350, 1440, 1530, 1620, 1710, 1800, 1890, 1980, 2070, 2160)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HawlingFistLastStart") {
      for(j in 1:length(HawlingFistLastDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "HawlingFistLast"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HawlingFistLastDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HawlingFistLast") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  ## Nautilus Add ATK
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ScrewPunch", "FistEnrage", "FistEnrageFullCharge", "FuriousCharge", "HawlingFistStart", "HawlingFistLast")) >= 1 & DealCycle$NautilusBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NautilusFinalATK"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Lucky Dice
  if(LuckyDice==55) {
    DealCycle$LuckyDice55 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==57) {
    DealCycle$LuckyDice57 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==555) {
    DealCycle$LuckyDice555 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==557) {
    DealCycle$LuckyDice557 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==577) {
    DealCycle$LuckyDice577 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  }
  
  ## Dummy Reduction
  DealCycle$Energy <- 0
  DealCycle$FullCharge <- 0
  DealCycle$StimulateEnergy <- 0
  DealCycle$FuriousChargeStack <- 0
  DealCycle$FuriousChargeDummy <- 0
  
  return(DealCycle)
}

ViperDealCycle <- ViperCycle(DealCycle=ViperDealCycle, 
                             ATKFinal, 
                             BuffFinal, 
                             SummonedFinal, 
                             Spec=ViperSpec, 
                             Period=182.4, 
                             CycleTime=729.6)
ViperDealCycle <- DealCycleFinal(ViperDealCycle)
ViperDealCycle5 <- ViperAddATK(DealCycle=ViperDealCycle, 
                               ATKFinal, 
                               BuffFinal, 
                               SummonedFinal, 
                               Spec=ViperSpec, 
                               LuckyDice=5)
ViperDealCycle55 <- ViperAddATK(DealCycle=ViperDealCycle, 
                                ATKFinal, 
                                BuffFinal, 
                                SummonedFinal, 
                                Spec=ViperSpec, 
                                LuckyDice=55)
ViperDealCycle57 <- ViperAddATK(DealCycle=ViperDealCycle, 
                                ATKFinal, 
                                BuffFinal, 
                                SummonedFinal, 
                                Spec=ViperSpec, 
                                LuckyDice=57)
ViperDealCycle555 <- ViperAddATK(DealCycle=ViperDealCycle, 
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 Spec=ViperSpec, 
                                 LuckyDice=555)
ViperDealCycle557 <- ViperAddATK(DealCycle=ViperDealCycle, 
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 Spec=ViperSpec, 
                                 LuckyDice=557)
ViperDealCycle577 <- ViperAddATK(DealCycle=ViperDealCycle, 
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 Spec=ViperSpec, 
                                 LuckyDice=577)

ViperDealCycle5 <- OverDriveExhaustBuff(ViperDealCycle5, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ViperDealCycle55 <- OverDriveExhaustBuff(ViperDealCycle55, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ViperDealCycle57 <- OverDriveExhaustBuff(ViperDealCycle57, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ViperDealCycle555 <- OverDriveExhaustBuff(ViperDealCycle555, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ViperDealCycle557 <- OverDriveExhaustBuff(ViperDealCycle557, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ViperDealCycle577 <- OverDriveExhaustBuff(ViperDealCycle577, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

ViperDealCycle5Reduction <- DealCycleReduction(ViperDealCycle5)

ViperDealCycleProbs <- c(0.637500, 
                         0.238417, 0.094355, 
                         0.010363, 0.016205, 0.003161)

ViperSpecOpt1 <- Optimization1(ViperDealCycle5Reduction, ATKFinal, BuffFinal, SummonedFinal, ViperSpec, ViperUnionRemained)
print(ViperSpecOpt1)
ViperSpecOpt <- ViperSpec
ViperSpecOpt$ATKP <- ViperSpecOpt$ATKP + ViperSpecOpt1$ATKP
ViperSpecOpt$BDR <- ViperSpecOpt$BDR + ViperSpecOpt1$BDR
ViperSpecOpt$IGR <- IGRCalc(c(ViperSpecOpt$IGR, ViperSpecOpt1$IGR))

ViperSpecOpt2 <- Optimization2(ViperDealCycle5Reduction, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt, ViperHyperStatBase, ViperBase$ChrLv, ViperBase$CRROver)
ViperFinalDPM <- ResetDealCalc(DealCycles=list(ViperDealCycle5, 
                                               ViperDealCycle55, ViperDealCycle57, 
                                               ViperDealCycle555, ViperDealCycle557, ViperDealCycle577), 
                               ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2, rep(max(ViperDealCycle5$Time), 6), ViperDealCycleProbs)
ViperFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=list(ViperDealCycle5, 
                                                                ViperDealCycle55, ViperDealCycle57, 
                                                                ViperDealCycle555, ViperDealCycle557, ViperDealCycle577), 
                                                ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2, rep(max(ViperDealCycle5$Time), 6), ViperDealCycleProbs)

ViperDealDatas <- list(DealCalcWithMaxDMR(ViperDealCycle5, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2), 
                       DealCalcWithMaxDMR(ViperDealCycle55, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2), 
                       DealCalcWithMaxDMR(ViperDealCycle57, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2), 
                       DealCalcWithMaxDMR(ViperDealCycle555, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2), 
                       DealCalcWithMaxDMR(ViperDealCycle557, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2), 
                       DealCalcWithMaxDMR(ViperDealCycle577, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt2))

ViperDealRatio <- ResetDealRatio(DealCycles=list(ViperDealCycle5, 
                                                 ViperDealCycle55, ViperDealCycle57, 
                                                 ViperDealCycle555, ViperDealCycle557, ViperDealCycle577), 
                                 DealDatas=ViperDealDatas, rep(max(ViperDealCycle5$Time), 6), ViperDealCycleProbs)

DPM12347$Viper[1] <- sum(na.omit(ViperFinalDPMwithMax)) / (max(ViperDealCycle5$Time) / 60000)
DPM12347$Viper[2] <- sum(na.omit(ViperFinalDPM)) / (max(ViperDealCycle5$Time) / 60000) - sum(na.omit(ViperFinalDPMwithMax)) / (max(ViperDealCycle5$Time) / 60000)

ViperDealData <- data.frame(ViperDealCycle5$Skills, ViperDealCycle5$Time, ViperDealCycle5$Restraint4, ViperDealDatas[[1]])
colnames(ViperDealData) <- c("Skills", "Time", "R4", "Deal")
subset(ViperDealData, ViperDealData$R4>0)

ViperRR <- ViperDealData[45:210, ]
DPM12347$Viper[3] <- sum((ViperRR$Deal))

Viper40s <- ViperDealData[45:400, ]
DPM12347$Viper[4] <- sum((Viper40s$Deal))