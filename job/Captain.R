## Captain - Data
## Captain - Core
CaptainCore <- MatrixSet(PasSkills=c("RapidFire", "OctaQuaterdeck", "BattleShipBomber", "SummonCrew", "HeadShot", "CaptainDignity", "Fusilrade", "Nautilus"), 
                         PasLvs=c(50, 50, 50, 50, 50, 50, 50, 25), 
                         PasMP=c(10, 10, 5, 10, 10, 10, 5, 0), 
                         ActSkills=c("BulletParty", "DeadEye", "NautilusAssault", "DeathTrigger",
                                     CommonV("Pirate", "Adventure")), 
                         ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 0), 
                         BlinkLv=1, 
                         BlinkMP=0, 
                         UsefulSkills=c("SharpEyes", "CombatOrders"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault, 
                         SelfBind=F)


## Captain - Basic Info
## Link - Xenon vs CygnusKnights
CaptainBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Captain",
                       CoreData=CaptainCore, 
                       BuffDurationNeeded=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("AdventurePirates", "Mikhail", "DemonAvenger", "CygnusKnights"), 
                       MonsterLife=MLTypeD24, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Gun", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[16, ], 
                       Emblem=Emblem[1, ])


## Captain - Passive
{option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(20, 5)
CriticalRoar <- data.frame(option, value) 

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(60)
HollowPointBullet <- data.frame(option, value)

option <- factor(c("FDR", "CRR", "IGR"), levels=PSkill)
value <- c(20, 30, 20)
FullMetalJacket <- data.frame(option, value)

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(25 + 2 * CaptainBase$SkillLv, 20 + CaptainBase$SkillLv)
ContinualAiming <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(15 + CaptainBase$PSkillLv)
CounterAttack <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(45 + 3 * CaptainBase$PSkillLv, 30 + CaptainBase$PSkillLv, 10 + floor(CaptainBase$PSkillLv/3))
CrewCommandership <- data.frame(option, value) ## Crew FDR 15 + PSkillLv%

option <- factor(c("Mastery", "ATK"), levels=PSkill)
value <- c(70 + floor(CaptainBase$PSkillLv/2), 30 + CaptainBase$PSkillLv)
CaptainDignityPassive <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(10)
UnwearyingNectar <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + CaptainCore[[2]][5, 2])
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(CaptainCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(22)
GiantBullet <- data.frame(option, value)}

CaptainPassive <- Passive(list(CriticalRoar, PhysicalTraining, HollowPointBullet, FullMetalJacket, ContinualAiming, CounterAttack, CrewCommandership, CaptainDignityPassive, UnwearyingNectar,
                               LoadedDice, BlinkPassive, GiantBullet))


## Captain - Buff
{option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GunBooster <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfiniteBullet <- rbind(data.frame(option, value), info)

option <- factor(c("ATKP"), levels=BSkill)
value <- c(20 + CaptainBase$SkillLv)
info <- c(180 + 6 * CaptainBase$SkillLv, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateStyle <- rbind(data.frame(option, value), info) 

option <- factor("MainStat", levels=BSkill)
value <- c(floor((CaptainBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(CaptainBase$SkillLv/2))))
info <- c(900 + 30 * CaptainBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

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
info <- c(Cooldown(30, T, CaptainBase$UnionChrs$CoolReduceP, CaptainBase$CoolReduce), 30, Delay(900, 2), F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
NautilusBuff <- rbind(data.frame(option, value), info) ## Captain Dignity FDR 30%

option <- factor(c("FDR"), levels=BSkill)
value <- c(25 + CaptainBase$SkillLv)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDraw <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * CaptainCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * CaptainCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * CaptainCore[[2]][6, 2]) * ArcaneShade[27, 6]))
info <- c(30, 70 - floor(CaptainCore[[2]][6, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[27, 6]))
info <- c(Cooldown(70 - floor(CaptainCore[[2]][6, 2]/5), T, CaptainBase$UnionChrs$CoolReduceP, CaptainBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(CaptainCore[[2]][6, 2]/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((CaptainBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(CaptainCore[[2]][7, 2]/2)) * CaptainBase$MainStatP), 10 + floor(CaptainCore[[2]][7, 2]/2))
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * CaptainCore[[2]][8, 2]) * MapleSoldier[1, 2]) * CaptainBase$MainStatP), 5 + floor(CaptainCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

CaptainBuff <- Buff(list(GunBooster=GunBooster, InfiniteBullet=InfiniteBullet, PirateStyle=PirateStyle, MapleSoldier=MapleSoldier, NautilusBuff=NautilusBuff, QuickDraw=QuickDraw, 
                         LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice555=LuckyDice555, EpicAdventure=EpicAdventure, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                         Transform=Transform, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                         SoulContractLink=SoulContractLink, Restraint4=Restraint4))
## Petbuff : InfiniteBullet(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms)
CaptainAllTimeBuff <- AllTimeBuff(CaptainBuff)


## Captain - Union & HyperStat & SoulWeapon
CaptainSpec <- JobSpec(JobBase=CaptainBase, 
                       Passive=CaptainPassive, 
                       AllTimeBuff=CaptainAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="Gun", 
                       UnionStance=0)

CaptainUnionRemained <- CaptainSpec$UnionRemained
CaptainHyperStatBase <- CaptainSpec$HyperStatBase
CaptainCoolReduceType <- CaptainSpec$CoolReduceType
CaptainSpec <- CaptainSpec$Spec


## Captain - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * CaptainCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * CaptainCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CaptainCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CaptainCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CaptainCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * CaptainCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Captain - Attack
## Hyper : Rapid Fire - Boss Killer, Add Range, Reinforce / Head Shot - Bonus Attack, Reinforce
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(50, ifelse(CaptainCore[[1]][1, 2]>=40, 20, 0), 2 * CaptainCore[[1]][1, 2])
info <- c(325 + 3 * CaptainBase$SkillLv, 1, 120, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidFire <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(60, ifelse(CaptainCore[[1]][5, 2]>=40, 20, 0))), 2 * CaptainCore[[1]][5, 2])
info <- c(525 + 5 * CaptainBase$SkillLv, 13, 570, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeadShot <- rbind(data.frame(option, value), info) ## ATKSpeed Check Needed

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CaptainCore[[1]][8, 2]>=40, 20, 0), 2 * CaptainCore[[1]][8, 2])
info <- c(440 + 130 + 7 * CaptainBase$SkillLv, 7, 0, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Nautilus <- rbind(data.frame(option, value), info) ## Delay on NautilusBuff, Special CoolDown Logic Needed(With Natuilus Assault)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CaptainCore[[1]][6, 2]>=40, 20, 0), 2 * CaptainCore[[1]][6, 2])
info <- c(275, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CaptainDignity <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(CaptainCore[[1]][6, 2]>=40, 20, 0), FDRCalc(c(2 * CaptainCore[[1]][6, 2], 30)))
info <- c(275, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CaptainDignityNautilusBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(230 + 9 * CaptainCore[[2]][1, 2], 5, 11180, NA, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulletParty <- rbind(data.frame(option, value), info) ## SubTime on WCR : 150ms, Pre : 180ms, End : 180ms

option <- factor(c("FDR"), levels=ASkill)
value <- c(FDRCalc(c(200, 44)))
info <- c(320 + 13 * CaptainCore[[2]][2, 2], 15, 600, NA, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeadEye <- rbind(data.frame(option, value), info) ## Aiming Needed (Time Check Needed), ATKSpeed Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * CaptainCore[[2]][3, 2], 6, 900, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusAssaultPre <- rbind(data.frame(option, value), info) ## ATKSpeed Check Needed, 7 Times, 2000ms(?), SubTime Check Needed(120ms?), StartATK Time Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * CaptainCore[[2]][3, 2], 12, 0, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusAssaultLast <- rbind(data.frame(option, value), info) ## 36 Times, 7200ms(?), SubTime Check Needed(120ms?), StartATK Time Check Needed

option <- factor(levels=ASkill)
value <- c()
info <- c(325 + 13 * CaptainCore[[2]][3, 2], 49, 0, NA, 45, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathTrigger <- rbind(data.frame(option, value), info) ## SubTime Check Needed, 7 * 7 Hits, If Dignity Occurs, Need to add 7 rows
}

CaptainATK <- Attack(list(RapidFire=RapidFire, HeadShot=HeadShot, Nautilus=Nautilus, CaptainDignity=CaptainDignity, CaptainDignityNautilusBuff=CaptainDignityNautilusBuff, 
                          BulletParty=BulletParty, DeadEye=DeadEye, NautilusAssaultPre=NautilusAssaultPre, NautilusAssaultLast=NautilusAssaultLast, DeathTrigger=DeathTrigger, 
                          SpiderInMirror=SpiderInMirror))


## Captain - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][2, 2]>=40, 20, 0), 3 * CaptainCore[[1]][2, 2])
info <- c(300, 1, 630, 0, 30, 10, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
OctaQuaterdeck <- rbind(data.frame(option, value), info) ## SubTime Check Needed (540ms?), ATKSpeed Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(500, 1 * 1/2, 900, 0, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewMurat <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(560, 1 * 1/2, 0, 0, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewValery <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(320, 1 * 1/2, 0, 0, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewJack <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(480, 1 * 1/2, 0, 0, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewStoner <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(330 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 390, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberDauntless1 <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(445 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberBlackbark1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(200 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberSchultz1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(320 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberJonathan1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(330 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 390, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberDauntless2 <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(445 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberBlackbark2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(200 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberSchultz2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(CaptainCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * CaptainCore[[1]][4, 2])))
info <- c(320 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 0, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberJonathan2 <- rbind(data.frame(option, value), info)}

CaptainSummoned <- Summoned(list(OctaQuaterdeck=OctaQuaterdeck, 
                                 AssembleCrewMurat=AssembleCrewMurat, AssembleCrewValery=AssembleCrewValery, AssembleCrewJack=AssembleCrewJack, AssembleCrewStoner=AssembleCrewStoner, 
                                 BattleShipBomberDauntless1=BattleShipBomberDauntless1, BattleShipBomberBlackbark1=BattleShipBomberBlackbark1, BattleShipBomberSchultz1=BattleShipBomberSchultz1, 
                                 BattleShipBomberJonathan1=BattleShipBomberJonathan1, BattleShipBomberDauntless2=BattleShipBomberDauntless2, BattleShipBomberBlackbark2=BattleShipBomberBlackbark2, 
                                 BattleShipBomberSchultz2=BattleShipBomberSchultz2, BattleShipBomberJonathan2=BattleShipBomberJonathan2, 
                                 SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))
