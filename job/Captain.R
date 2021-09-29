## Captain - Data
## Captain - Core
CaptainCoreBase <- CoreBuilder(ActSkills=c("BulletParty", "DeadEye", "NautilusAssault", "DeathTrigger",
                                           CommonV("Pirate", "Adventure")), 
                               ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                               UsefulSkills=c("SharpEyes", "CombatOrders"), 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               VPassiveList=CaptainVPassive, 
                               VPassivePrior=CaptainVPrior, 
                               SelfBind=F)

CaptainCore <- MatrixSet(PasSkills=CaptainCoreBase$PasSkills$Skills, 
                         PasLvs=CaptainCoreBase$PasSkills$Lv, 
                         PasMP=CaptainCoreBase$PasSkills$MP, 
                         ActSkills=CaptainCoreBase$ActSkills$Skills, 
                         ActLvs=CaptainCoreBase$ActSkills$Lv, 
                         ActMP=CaptainCoreBase$ActSkills$MP, 
                         UsefulSkills=CaptainCoreBase$UsefulSkills, 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         SpecialCore=CaptainCoreBase$SpecialCoreUse)


## Captain - Basic Info
## Link - Xenon vs CygnusKnights
CaptainBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=get(DPMCalcOption$MobSet),
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       Job="Captain",
                       CoreData=CaptainCore, 
                       BuffDurationNeeded=0, 
                       AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Captain"), 
                       LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Captain"), 
                       MonsterLife=get(FindJob(MonsterLifePreSet, "Captain")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                       Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Gun", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                       WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                       SubWeapon=SubWeapon[rownames(SubWeapon)=="Sight", ], 
                       Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                       CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Captain")))

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
value <- c(10 + GetCoreLv(CaptainCore, "LoadedDice"))
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(CaptainCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(CaptainCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(22)
GiantBullet <- data.frame(option, value)}

CaptainPassive <- Passive(list(CriticalRoar, PhysicalTraining, HollowPointBullet, FullMetalJacket, ContinualAiming, CounterAttack, CrewCommandership, CaptainDignityPassive, UnwearyingNectar,
                               LoadedDice, BlinkPassive, RopeConnectPassive, GiantBullet))


## Captain - Buff
{option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
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
info <- c(180 + 6 * CaptainBase$SkillLv, NA, 0, T, NA, NA, T)
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

option <- factor(c("FDR"), levels=BSkill)
value <- c(30)
info <- c(Cooldown(30, T, CaptainBase$UnionChrs$CoolReduceP, CaptainBase$CoolReduce), 60, Delay(900, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
NautilusBuff <- rbind(data.frame(option, value), info) ## Captain Dignity FDR 30%

option <- factor(c("FDR"), levels=BSkill)
value <- c(25 + CaptainBase$SkillLv)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDraw <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(25 + CaptainBase$SkillLv)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDrawHeadShot <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDrawStack <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(CaptainCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(CaptainCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="Gun", 6]))
info <- c(30, 70 - floor(GetCoreLv(CaptainCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="Gun", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(CaptainCore, "OverDrive")/5), T, CaptainBase$UnionChrs$CoolReduceP, CaptainBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(GetCoreLv(CaptainCore, "OverDrive")/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((CaptainBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(GetCoreLv(CaptainCore, "PirateFlag")/2)) * CaptainBase$MainStatP), 10 + floor(GetCoreLv(CaptainCore, "PirateFlag")/2))
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(CaptainCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * CaptainBase$MainStatP), 5 + floor(GetCoreLv(CaptainCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

CaptainBuff <- list(GunBooster=GunBooster, InfiniteBullet=InfiniteBullet, PirateStyle=PirateStyle, MapleSoldier=MapleSoldier, NautilusBuff=NautilusBuff, 
                    QuickDraw=QuickDraw, QuickDrawHeadShot=QuickDrawHeadShot, QuickDrawStack=QuickDrawStack, 
                    LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice555=LuckyDice555, EpicAdventure=EpicAdventure, 
                    UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                    OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                    SoulContractLink=SoulContractLink, Restraint4=Restraint4)
## Petbuff : GunBooster(600ms), InfiniteBullet(990ms), PirateStyle(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  CaptainBuff[[length(CaptainBuff)+1]] <- UsefulAdvancedBless
  names(CaptainBuff)[[length(CaptainBuff)]] <- "UsefulAdvancedBless"
}
CaptainBuff <- Buff(CaptainBuff)
CaptainAllTimeBuff <- AllTimeBuff(CaptainBuff)


## Captain - Union & HyperStat & SoulWeapon
CaptainSpec <- JobSpec(JobBase=CaptainBase, 
                       Passive=CaptainPassive, 
                       AllTimeBuff=CaptainAllTimeBuff, 
                       MobInfo=get(DPMCalcOption$MobSet), 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       WeaponName="Gun", 
                       UnionStance=0)

CaptainUnionRemained <- CaptainSpec$UnionRemained
CaptainHyperStatBase <- CaptainSpec$HyperStatBase
CaptainCoolReduceType <- CaptainSpec$CoolReduceType
CaptainSpec <- CaptainSpec$Spec


## Captain - Spider In Mirror
SIM <- SIMData(GetCoreLv(CaptainCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Captain - Attack
## Hyper : Rapid Fire - Boss Killer, Add Range, Reinforce / Head Shot - Bonus Attack, Reinforce
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(50, ifelse(GetCoreLv(CaptainCore, "RapidFire")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "RapidFire"))
info <- c(325 + 3 * CaptainBase$SkillLv, 1, 120, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidFire <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(60, ifelse(GetCoreLv(CaptainCore, "HeadShot")>=40, 20, 0))), 2 * GetCoreLv(CaptainCore, "HeadShot"))
info <- c(525 + 5 * CaptainBase$SkillLv, 13, 570, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeadShot <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "Nautilus")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "Nautilus"))
info <- c(440 + 130 + 7 * CaptainBase$SkillLv, 7, 0, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Nautilus <- rbind(data.frame(option, value), info) ## Delay on NautilusBuff

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "CaptainDignity")>=40, 20, 0), CaptainBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(CaptainCore, "CaptainDignity"))
info <- c(275 + 3 * CaptainBase$SkillLv, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CaptainDignity <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(230 + 9 * GetCoreLv(CaptainCore, "BulletParty"), 5, 12180 + 1000 * General$General$Serverlag, 180, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulletParty <- rbind(data.frame(option, value), info) ## SubTime : 180ms, Pre : 180ms, End : 180ms

option <- factor(c("FDR"), levels=ASkill)
value <- c(FDRCalc(c(200, 44)))
info <- c(320 + 13 * GetCoreLv(CaptainCore, "DeadEye"), 15, 600, NA, Cooldown(30, T, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce) + 5.4 + 3.48, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeadEye <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * GetCoreLv(CaptainCore, "NautilusAssault"), 6, 450, 150, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusAssaultPre <- rbind(data.frame(option, value), info) ## 7 Times, StartATK : 480ms

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * GetCoreLv(CaptainCore, "NautilusAssault"), 12, 0, 90, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusAssaultLast <- rbind(data.frame(option, value), info) ## 36 Times, StartATK : 1500ms

option <- factor(levels=ASkill)
value <- c()
info <- c(325 + 13 * GetCoreLv(CaptainCore, "DeathTrigger"), 7, 990, NA, 45, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathTrigger <- rbind(data.frame(option, value), info) ## 7 * 7 * 4 Hits
}

CaptainATK <- Attack(list(RapidFire=RapidFire, HeadShot=HeadShot, Nautilus=Nautilus, CaptainDignity=CaptainDignity, 
                          BulletParty=BulletParty, DeadEye=DeadEye, NautilusAssaultPre=NautilusAssaultPre, NautilusAssaultLast=NautilusAssaultLast, DeathTrigger=DeathTrigger, 
                          SpiderInMirror=SpiderInMirror))


## Captain - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "OctaQuaterdeck")>=40, 20, 0), 3 * GetCoreLv(CaptainCore, "OctaQuaterdeck"))
info <- c(300, 1, 630, 540, 30, 10, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
OctaQuaterdeck <- rbind(data.frame(option, value), info) ## SubTime Check Needed (540ms?), ATKSpeed Check Needed, StartATK 1260ms (Function Needed)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(500, 1 * 1/2, 900, 3030, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewMurat <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(560, 1 * 1/2, 0, 3030, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewValery <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(320, 1 * 1/2, 0, 600, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewJack <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(480, 1 * 1/2, 0, 3030, 120, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewStoner <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(330 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 390, 690, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberDauntless1 <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(445 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 930, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberBlackbark1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(200 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 630, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberSchultz1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(320 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 690, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberJonathan1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(330 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 390, 690, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberDauntless2 <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(445 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 930, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberBlackbark2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(200 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 630, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomberSchultz2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(320 + 3 * CaptainSpec$PSkillLv, 3 * 1/4, 0, 690, 60, 30, T, T, T, F)
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

## Captain - DealCycle
ATKFinal <- data.frame(CaptainATK)
ATKFinal$Delay[c(-1, -5, -7, -9)] <- Delay(ATKFinal$Delay, CaptainSpec$ATKSpeed)[c(-1, -5, -7, -9)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce)

BuffFinal <- data.frame(CaptainBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, CaptainSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(CaptainSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * CaptainSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(CaptainBuff))
CaptainDealCycle <- t(rep(0, length(DealCycle)))
colnames(CaptainDealCycle) <- DealCycle
CaptainDealCycle <- data.frame(CaptainDealCycle)

CaptainCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(360)) {
  BuffSummonedPrior <- c("OctaQuaterdeck", "AssembleCrewMurat", "BattleShipBomberDauntless1",
                         "GunBooster", "InfiniteBullet", "PirateStyle", "MapleSoldier", "LuckyDice5", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "MapleWarriors2", "OverDrive", "SoulContractLink", "Restraint4")
  Times180 <- c(5.5, 3/2, 5.5, 
                0, 0, 0, 0, 1, 0, 0, 0, 0, 
                1, 2, 2, 1)
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
  
  DealCycle <- DCBuff(DealCycle, "NautilusBuff", BuffFinal)
  DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="UsefulCombatOrders") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      if(BuffList[[1]][i]=="BattleShipBomberDauntless1") {
        DealCycle[1, 2:ncol(DealCycle)] <- 0
        DealCycle <- DCSummoned(DealCycle, "BattleShipBomberDauntless2", SummonedFinal)
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
  HSCool <- subset(ATKFinal, rownames(ATKFinal)=="HeadShot")$CoolTime * 1000
  NACool <- subset(ATKFinal, rownames(ATKFinal)=="Nautilus")$CoolTime * 1000
  DECool <- subset(ATKFinal, rownames(ATKFinal)=="DeadEye")$CoolTime * 1000
  DEReaim <- 1900 + 3120 + 3480
  DTCool <- subset(ATKFinal, rownames(ATKFinal)=="DeathTrigger")$CoolTime * 1000
  NAACool <- subset(ATKFinal, rownames(ATKFinal)=="NautilusAssaultPre")$CoolTime * 1000
  NACommon <- Cooldown(8, T, Spec$CoolReduceP, Spec$CoolReduce) * 1000
  
  NARemain <- NACool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="NautilusBuff")$Time)
  HSRemain <- 0 ; DERemain <- 0 ; DTRemain <- 0 ; NAARemain <- 0
  
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
          HSRemain <- max(0, HSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        }
      }
      ## DeadEye
      if(DERemain == 0) {
        if(sum(nrow(DealCycle[DealCycle$Skills=="DeadEye", ])==c(6))==1) {
          for(i in 1:7) {
            DealCycle <- DCATK(DealCycle, "RapidFire", ATKFinal)
            HSRemain <- max(0, HSRemain - DealCycle$Time[1])
            NARemain <- max(0, NARemain - DealCycle$Time[1])
            DERemain <- max(0, DERemain - DealCycle$Time[1])
            DTRemain <- max(0, DTRemain - DealCycle$Time[1])
            NAARemain <- max(0, NAARemain - DealCycle$Time[1])
          }
        }
        DealCycle <- DCATK(DealCycle, "DeadEye", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DECool - DealCycle$Time[1]) + ifelse(sum(nrow(DealCycle[DealCycle$Skills=="DeadEye", ])==c(1, 3, 5, 7))==1, 1800, DEReaim)
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Death Trigger
      else if(DTRemain == 0) {
        DealCycle <- DCATK(DealCycle, "DeathTrigger", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTCool - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## HeadShot
      else if(HSRemain == 0) {
        DealCycle <- DCATK(DealCycle, "HeadShot", ATKFinal)
        HSRemain <- max(0, HSCool - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Nautilus Assault
      else if(NAARemain == 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] >= 6100) {
        DealCycle <- DCATK(DealCycle, "NautilusAssaultPre", ATKFinal)
        HSRemain <- max(0, HSCool - DealCycle$Time[1])
        NARemain <- max(0, NACommon - DealCycle$Time[1], NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAACool - DealCycle$Time[1])
      }
      ## Pirate Flag, Nautilus
      else if(NARemain == 0 & nrow(DealCycle[DealCycle$Skills=="PirateFlag", ]) < 12) {
        DealCycle <- DCBuff(DealCycle, "NautilusBuff", BuffFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NACool - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1], NACommon - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Bullet Party
      else if(nrow(DealCycle[DealCycle$Skills=="SoulContractLink", ]) > nrow(DealCycle[DealCycle$Skills=="BulletParty", ]) & 
              nrow(DealCycle[DealCycle$Skills=="DeathTrigger", ]) > nrow(DealCycle[DealCycle$Skills=="BulletParty", ]) * 2) {
        DealCycle <- DCATK(DealCycle, "BulletParty", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Rapid Fire
      else {
        DealCycle <- DCATK(DealCycle, "RapidFire", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        NARemain <- max(0, NARemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
    }
      
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          HSRemain <- max(0, HSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          HSRemain <- max(0, HSRemain - DealCycle$Time[1])
          NARemain <- max(0, NARemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
CaptainAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Nautilus ATK / Nautilus Assault / Assemble Crew / BattleShip Bomber Dummy Generation
  k <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BattleShipBomberDauntless1Summoned" & k == 1) {
      k <- 2
    } else if(DealCycle$Skills[i]=="BattleShipBomberDauntless1Summoned" & k == 2) {
      DealCycle$Skills[i] <- "BattleShipBomberDauntless2Summoned"
      k <- 1
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="NautilusBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Nautilus"
    } else if(DealCycle$Skills[i]=="AssembleCrewMuratSummoned") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewValerySummoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewJackSummoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewStonerSummoned"
    } else if(DealCycle$Skills[i]=="BattleShipBomberDauntless1Summoned") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberBlackbark1Summoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberSchultz1Summoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberJonathan1Summoned"
    } else if(DealCycle$Skills[i]=="BattleShipBomberDauntless2Summoned") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberBlackbark2Summoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberSchultz2Summoned"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomberJonathan2Summoned"
    } else if(DealCycle$Skills[i]=="NautilusAssaultPre") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NautilusAssaultLast"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Dummy Generation Done")
  
  
  ## Death Trigger
  DealCycle$Skills[DealCycle$Skills=="DeathTrigger"] <- "DeathTriggerStart"
  DTDelay1 <- seq(300, 300 + 120 * 6, 120)
  DTDelay2 <- c()
  for(i in 1:length(DTDelay1)) {
    DTDelay2 <- c(DTDelay2, seq(DTDelay1[i], DTDelay1[i] + 660 * 3, 660))
  }
  DTDelay2 <- DTDelay2[order(DTDelay2)]
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DeathTriggerStart") {
      for(j in 1:length(DTDelay2)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "DeathTrigger"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + DTDelay2[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DeathTrigger") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Death Trigger Done")
  
  
  ## Nautilus Assault, Bullet Party
  DealCycle <- RepATKCycle(DealCycle, "NautilusAssaultPre", 7, 480, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "NautilusAssaultLast", 36, 2880, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BulletParty", 83, 180, ATKFinal)
  print("Nautilus Assault, Bullet Party Done")
  

  ## Octa Quaterdeck, Assemble Crew, BattleShip Bomber, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, "OctaQuaterdeck", SummonedFinal)
  
  DealCycle <- DCSummonedATKs(DealCycle, "AssembleCrewMurat", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "AssembleCrewValery", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "AssembleCrewJack", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "AssembleCrewStoner", SummonedFinal)
  
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberDauntless1", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberBlackbark1", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberSchultz1", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberJonathan1", SummonedFinal)
  
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberDauntless2", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberBlackbark2", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberSchultz2", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "BattleShipBomberJonathan2", SummonedFinal)
  
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  print("Summoned Skills Done")
  
  
  ## Captain Dignity
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("RapidFire", "HeadShot", "BulletParty", "DeadEye")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
    } else if(DealCycle$Skills[i]=="DeathTriggerStart") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "CaptainDignity"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Nautilus Assault Buff
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="CaptainDignity" & DealCycle$NautilusBuff[i] > 0) {
      DealCycle$NautilusBuff[i] <- 1
    } else {
      DealCycle$NautilusBuff[i] <- 0
    }
  }
  print("Captain Dignity Done")
  
  
  ## Quick Draw
  ## DeadEye : Always Applied, Head Shot Before DeadEye : Always Not Applied
  QuickDrawProb <- 0.08 + ceiling(Spec$SkillLv / 2) * 0.01
  DealCycle$QuickDrawStack[3] <- 1
  for(i in 4:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("RapidFire", "BulletParty", "HeadShot", "Nautilus", "NautilusAssaultPre", "NautilusAssualtLast", "DeathTrigger", "CaptainDignity")) >= 1 & 
       DealCycle$QuickDrawStack[i-1] < 1) {
      DealCycle$QuickDrawStack[i] <- DealCycle$QuickDrawStack[i-1] + QuickDrawProb
    } else if(sum(DealCycle$Skills[i]==c("NautilusAssaultPre", "NautilusAssaultLast", "DeathTrigger")) >= 1 & DealCycle$QuickDrawStack[i-1] >= 1) {
      DealCycle$QuickDrawStack[i] <- DealCycle$QuickDrawStack[i-1] - 1
      DealCycle$QuickDraw[i] <- 1
    } else if(sum(DealCycle$Skills[i]==c("HeadShot")) >= 1) {
      DealCycle$QuickDrawStack[i] <- 0
      DealCycle$QuickDrawHeadShot[i] <- 1
    } else if(sum(DealCycle$Skills[i]==c("DeadEye")) >= 1) {
      DealCycle$QuickDrawStack[i] <- 0
      DealCycle$QuickDrawHeadShot[i] <- 1
    } else {
      DealCycle$QuickDrawStack[i] <- DealCycle$QuickDrawStack[i-1]
    }
  }
  
  DC1 <- subset(DealCycle, DealCycle$QuickDrawHeadShot == 0)
  DC2 <- subset(DealCycle, DealCycle$QuickDrawHeadShot > 0)
  
  for(i in 2:(nrow(DC2)-1)) {
    if(DC2$Skills[i]=="HeadShot" & DC2$Time[i+1] - DC2$Time[i] < ATKFinal[rownames(ATKFinal)=="HeadShot", ]$CoolTime * 1000 & DC2$Skills[i+1]=="DeadEye") {
      DC2$QuickDrawHeadShot[i] <- 0
    } 
  }
  DC2$QuickDrawHeadShot[nrow(DC2)] <- 0
  
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Quick Draw Done")
  
  
  ## Dummy Reduction
  DealCycle$QuickDrawStack <- 0
  
  return(DealCycle)
}

CaptainDealCycle <- CaptainCycle(CaptainDealCycle,
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 CaptainSpec, 
                                 Period=180, CycleTime=360)
CaptainDealCycle <- DealCycleFinal(CaptainDealCycle)
CaptainDealCycle <- CaptainAddATK(CaptainDealCycle,
                                  ATKFinal, 
                                  BuffFinal, 
                                  SummonedFinal, 
                                  CaptainSpec)
CaptainDealCycle <- OverDriveExhaustBuff(CaptainDealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
CaptainDealCycleReduction <- DealCycleReduction(CaptainDealCycle)

CaptainDealCycle5 <- CaptainDealCycle
CaptainDealCycle55 <- CaptainDealCycle
CaptainDealCycle555 <- CaptainDealCycle

CaptainDealCycle55$LuckyDice55 <- CaptainDealCycle55$LuckyDice5
CaptainDealCycle55$LuckyDice5 <- 0

CaptainDealCycle555$LuckyDice555 <- CaptainDealCycle555$LuckyDice5
CaptainDealCycle555$LuckyDice5 <- 0

CaptainDealCycleProbs <- c(0.745340, 0.245185, 0.009475)

for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Captain") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  CaptainSpecOpt1 <- Optimization1(CaptainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CaptainSpec, CaptainUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- CaptainSpecOpt1[1, 1:3]
} else {
  CaptainSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
CaptainSpecOpt <- OptDataAdd(CaptainSpec, CaptainSpecOpt1, "Potential", CaptainBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  CaptainSpecOpt2 <- Optimization2(CaptainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, CaptainHyperStatBase, CaptainBase$ChrLv, CaptainBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- CaptainSpecOpt2[1, ]
} else {
  CaptainSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
CaptainSpecOpt <- OptDataAdd(CaptainSpecOpt, CaptainSpecOpt2, "HyperStat", CaptainBase$CRROver, DemonAvenger=F)

CaptainFinalDPM <- ResetDealCalc(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555), 
                                 ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 3), CaptainDealCycleProbs)
CaptainFinalDPMwithMax <- ResetDealCalcWithMaxDMR(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555), 
                                                  ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 3), CaptainDealCycleProbs)

set(get(DPMCalcOption$DataName), as.integer(1), "Captain", sum(na.omit(CaptainFinalDPMwithMax)) / (max(CaptainDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Captain", sum(na.omit(CaptainFinalDPM)) / (max(CaptainDealCycle$Time) / 60000) - sum(na.omit(CaptainFinalDPMwithMax)) / (max(CaptainDealCycle$Time) / 60000))

CaptainDeal1 <- DealCalcWithMaxDMR(CaptainDealCycle5, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt)
CaptainDeal2 <- DealCalcWithMaxDMR(CaptainDealCycle55, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt)
CaptainDeal3 <- DealCalcWithMaxDMR(CaptainDealCycle555, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt)
CaptainDealDatas <- list(CaptainDeal1, CaptainDeal2, CaptainDeal3)
CaptainDealRatio <- ResetDealRatio(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555), 
                                   CaptainDealDatas, rep(max(CaptainDealCycle$Time), 3), CaptainDealCycleProbs)

CaptainDealData <- data.frame(CaptainDealCycle$Skills, CaptainDealCycle$Time, CaptainDealCycle$Restraint4, CaptainDeal1)
colnames(CaptainDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Captain", Deal_RR(CaptainDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Captain", Deal_40s(CaptainDealData))

CaptainSpecMean <- ResetSpecMean("Captain", 
                                 list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555), 
                                 list(CaptainDeal1, CaptainDeal2, CaptainDeal3), 
                                 ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 3), CaptainDealCycleProbs)