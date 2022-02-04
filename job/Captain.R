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

option <- factor(c("CRR"), levels=PSkill)
value <- c(10)
GunMastery <- data.frame(option, value) 

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
GunAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
InfiniteBullet <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(60)
HollowPointBullet <- data.frame(option, value)

option <- factor(c("FDR", "CRR", "IGR"), levels=PSkill)
value <- c(20, 30, 20)
FullMetalJacket <- data.frame(option, value)

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(25 + 2 * CaptainBase$SkillLv, 20 + CaptainBase$SkillLv)
ContinualAimingPassive <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(15 + CaptainBase$PSkillLv)
OffenseForm <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(45 + 3 * CaptainBase$PSkillLv, 30 + CaptainBase$PSkillLv, 10 + floor(CaptainBase$PSkillLv/3))
CrewCommandership <- data.frame(option, value) ## Crew FDR 15 + PSkillLv%

option <- factor(c("Mastery", "ATK", "FDR"), levels=PSkill)
value <- c(70 + floor(CaptainBase$PSkillLv/2), 30 + CaptainBase$PSkillLv, 8)
CaptainDignityPassive <- data.frame(option, value)

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

CaptainPassive <- Passive(list(CriticalRoar, GunMastery, PhysicalTraining, GunAcceleration, InfiniteBullet, HollowPointBullet, FullMetalJacket, ContinualAimingPassive, OffenseForm, CrewCommandership, CaptainDignityPassive, 
                               LoadedDice, BlinkPassive, RopeConnectPassive, GiantBullet))


## Captain - Buff
{option <- factor(c("ATKP"), levels=BSkill)
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

option <- factor(levels=BSkill)
value <- c()
info <- c(60 + 4 * CaptainBase$SkillLv, NA, Delay(870, 2), F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SignofBombard <- rbind(data.frame(option, value), info) ## Continual Aiming Delay

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

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDrawFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QuickDrawStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 390, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UnwearyingNectar <- rbind(data.frame(option, value), info)

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

CaptainBuff <- list(PirateStyle=PirateStyle, MapleSoldier=MapleSoldier, SignofBombard=SignofBombard, QuickDrawFDR=QuickDrawFDR, QuickDrawStack=QuickDrawStack, 
                    LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice555=LuckyDice555, LuckyDice53=LuckyDice53, LuckyDice533=LuckyDice533, LuckyDice553=LuckyDice553, 
                    UnwearyingNectar=UnwearyingNectar, EpicAdventure=EpicAdventure, 
                    UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                    OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                    SoulContractLink=SoulContractLink, Restraint4=Restraint4)
## Petbuff : PirateStyle(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
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
## Hyper : Rapid Fire - Add Range, Reinforce / Head Shot - Bonus Attack, Reinforce, Boss Killer
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(30, ifelse(GetCoreLv(CaptainCore, "RapidFire")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "RapidFire"))
info <- c(375 + 3 * CaptainBase$SkillLv, 1, 120, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidFire <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, IGRCalc(c(60, ifelse(GetCoreLv(CaptainCore, "HeadShot")>=40, 20, 0))), 2 * GetCoreLv(CaptainCore, "HeadShot"))
info <- c(1185 + 13 * CaptainBase$SkillLv, 14, 570, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeadShot <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "ContinualAiming")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "ContinualAiming"))
info <- c(610 + 16 * CaptainBase$SkillLv, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ContinualAiming <- rbind(data.frame(option, value), info) ## Delay on Sign of Bombard

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "CaptainDignity")>=40, 20, 0), CaptainBase$MonsterLife$FinalATKDMR, FDRCalc(c(30, 2 * GetCoreLv(CaptainCore, "CaptainDignity"))))
info <- c(275 + 3 * CaptainBase$SkillLv, 1, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CaptainDignity <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(230 + 9 * GetCoreLv(CaptainCore, "BulletParty"), 5, Cooldown(5, T, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce) * 1000 - Delay(570, 2) + 180, 180, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulletParty <- rbind(data.frame(option, value), info) ## SubTime : 180ms, Pre : 180ms, End : 180ms

option <- factor(c("FDR"), levels=ASkill)
value <- c(FDRCalc(c(200, 44)))
info <- c(320 + 13 * GetCoreLv(CaptainCore, "DeadEye"), 15, 600, NA, Cooldown(30, T, CaptainSpec$CoolReduceP, CaptainSpec$CoolReduce) + 3.48, F, F, F)
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

CaptainATK <- Attack(list(RapidFire=RapidFire, HeadShot=HeadShot, ContinualAiming=ContinualAiming, CaptainDignity=CaptainDignity, 
                          BulletParty=BulletParty, DeadEye=DeadEye, NautilusAssaultPre=NautilusAssaultPre, NautilusAssaultLast=NautilusAssaultLast, DeathTrigger=DeathTrigger, 
                          SpiderInMirror=SpiderInMirror))


## Captain - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SeizeBomber")>=40, 20, 0), 3 * GetCoreLv(CaptainCore, "SeizeBomber"))
info <- c(300, 1, 630, 540, 60, 0, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SeizeBomber <- rbind(data.frame(option, value), info) ## ATKSpeed Check Needed, StartATK 1260ms (Function Needed)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SeizeBomber")>=40, 20, 0), 3 * GetCoreLv(CaptainCore, "SeizeBomber"))
info <- c(450, 1, 630, 540, 60, 0, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SeizeBomberNectar <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(200, 3 * 2, 900, 3030, 120, 45, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewDualPistol <- rbind(data.frame(option, value), info) ## ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(285, 3 * 2, 900, 1200, 120, 45, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewDualPistolNectar <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(170, 4, 0, 3030, 120, 45, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewMarksman <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "SummonCrew")>=40, 20, 0), FDRCalc(c(15 + CaptainSpec$SkillLv, 2 * GetCoreLv(CaptainCore, "SummonCrew"))))
info <- c(220, 4, 0, 1440, 120, 45, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AssembleCrewMarksmanNectar <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(400 + 3 * CaptainSpec$PSkillLv, 3, 510, 1110, 60, 0.5, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomber1 <- rbind(data.frame(option, value), info) ## ATKSpeed/Delay Check Needed

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(500, 3, 510, 1080, 60, 0.5, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomber1Nectar <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(400 + 3 * CaptainSpec$PSkillLv, 3, 390, 1110, 60, 0.5, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomber2 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(CaptainCore, "BattleShipBomber")>=40, 20, 0), 2 * GetCoreLv(CaptainCore, "BattleShipBomber"))
info <- c(500, 3, 390, 1080, 60, 0.5, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BattleShipBomber2Nectar <- rbind(data.frame(option, value), info) 
}

CaptainSummoned <- Summoned(list(SeizeBomber=SeizeBomber, SeizeBomberNectar=SeizeBomberNectar, 
                                 AssembleCrewDualPistol=AssembleCrewDualPistol, AssembleCrewDualPistolNectar=AssembleCrewDualPistolNectar, 
                                 AssembleCrewMarksman=AssembleCrewMarksman, AssembleCrewMarksmanNectar=AssembleCrewMarksmanNectar, 
                                 BattleShipBomber1=BattleShipBomber1, BattleShipBomber1Nectar=BattleShipBomber1Nectar, BattleShipBomber2=BattleShipBomber2, BattleShipBomber2Nectar=BattleShipBomber2Nectar, 
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
  BuffSummonedPrior <- c("SignofBombard", "SeizeBomber", "AssembleCrewDualPistol", "BattleShipBomber1", "BattleShipBomber2",
                         "PirateStyle", "MapleSoldier", "LuckyDice5", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "UnwearyingNectar", "MapleWarriors2", "OverDrive", "SoulContractLink", "Restraint4")
  Times180 <- c(3, 3, 3/2, 3, 3, 
                0, 0, 1, 0, 0, 0, 0, 
                1, 1, 2, 2, 1)
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
  PFCool <- subset(BuffFinal, rownames(BuffFinal)=="PirateFlag")$CoolTime * 1000
  DECool <- subset(ATKFinal, rownames(ATKFinal)=="DeadEye")$CoolTime * 1000
  DEReaim <- 1900 + 3120 + 3480
  DTCool <- subset(ATKFinal, rownames(ATKFinal)=="DeathTrigger")$CoolTime * 1000
  NAACool <- subset(ATKFinal, rownames(ATKFinal)=="NautilusAssaultPre")$CoolTime * 1000
  NACommon <- Cooldown(8, T, Spec$CoolReduceP, Spec$CoolReduce) * 1000
  
  PFRemain <- PFCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="PirateFlag")$Time)
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
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        }
      }
      ## DeadEye
      if(DERemain == 0) {
        ## if(sum(nrow(DealCycle[DealCycle$Skills=="DeadEye", ])==c(6))==1) {
        ##   for(i in 1:7) {
        ##     DealCycle <- DCATK(DealCycle, "RapidFire", ATKFinal)
        ##    HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        ##    PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        ##    DERemain <- max(0, DERemain - DealCycle$Time[1])
        ##    DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        ##    NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        ##  }
        ## }
        DealCycle <- DCATK(DealCycle, "DeadEye", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        DERemain <- max(0, DECool - DealCycle$Time[1]) + ifelse(sum(nrow(DealCycle[DealCycle$Skills=="DeadEye", ])==c(5, 10))==1, DEReaim, 600)
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Death Trigger
      else if(DTRemain == 0) {
        DealCycle <- DCATK(DealCycle, "DeathTrigger", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTCool - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Nautilus Assault
      else if(NAARemain == 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] >= 6100) {
        DealCycle <- DCATK(DealCycle, "NautilusAssaultPre", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAACool - DealCycle$Time[1])
      }
      ## HeadShot & Bullet Party
      else if(HSRemain == 0) {
        DealCycle <- DCATK(DealCycle, "HeadShot", ATKFinal)
        HSRemain <- max(0, HSCool - DealCycle$Time[1])
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        
        if(nrow(DealCycle[DealCycle$Skills=="SoulContractLink", ]) > nrow(DealCycle[DealCycle$Skills=="BulletParty", ]) & 
           nrow(DealCycle[DealCycle$Skills=="DeathTrigger", ]) > nrow(DealCycle[DealCycle$Skills=="BulletParty", ]) * 2) {
          DealCycle <- DCATK(DealCycle, "BulletParty", ATKFinal)
          HSRemain <- max(0, HSRemain - DealCycle$Time[1])
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        }
      }
      ## Pirate Flag
      else if(PFRemain == 0 & nrow(DealCycle[DealCycle$Skills=="PirateFlag", ]) < 12) {
        DealCycle <- DCBuff(DealCycle, "PirateFlag", BuffFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        PFRemain <- max(0, PFCool - DealCycle$Time[1])
        DERemain <- max(0, DERemain - DealCycle$Time[1])
        DTRemain <- max(0, DTRemain - DealCycle$Time[1])
        NAARemain <- max(0, NAARemain - DealCycle$Time[1])
      }
      ## Rapid Fire
      else {
        DealCycle <- DCATK(DealCycle, "RapidFire", ATKFinal)
        HSRemain <- max(0, HSRemain - DealCycle$Time[1])
        PFRemain <- max(0, PFRemain - DealCycle$Time[1])
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
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
          DERemain <- max(0, DERemain - DealCycle$Time[1])
          DTRemain <- max(0, DTRemain - DealCycle$Time[1])
          NAARemain <- max(0, NAARemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          HSRemain <- max(0, HSRemain - DealCycle$Time[1])
          PFRemain <- max(0, PFRemain - DealCycle$Time[1])
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
  ## Continual Aiming ATK / Nautilus Assault / Assemble Crew Dummy Generation
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AssembleCrewDualPistolSummoned") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewMarksmanSummoned"
    } else if(DealCycle$Skills[i]=="NautilusAssaultPre") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NautilusAssaultLast"
    } else if(DealCycle$Skills[i]=="SignofBombard") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ContinualAiming"
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
  DealCycle <- RepATKCycle(DealCycle, "BulletParty", 24, 180, ATKFinal)
  print("Nautilus Assault, Bullet Party Done")
  

  ## Seize Bomber, Assemble Crew, BattleShip Bomber, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, "SeizeBomber", SummonedFinal)
  
  NectarStart <- DealCycle[DealCycle$Skills=="UnwearyingNectar", ]$Time
  NectarDuration <- BuffFinal[rownames(BuffFinal) =="UnwearyingNectar", ]$Duration * 1000
  NectarON <- function(Time, NectarStart, NectarDuration) {
    for(i in 1:length(NectarStart)) {
      if(NectarStart[i] <= Time & NectarStart[i] + NectarDuration > Time) {
        return(T)
      } 
    }
    return(F)
  }
  
  AssembleCrewTime <- DealCycle[DealCycle$Skills=="AssembleCrewDualPistolSummoned", ]$Time
  AssembleCrewTime <- c(AssembleCrewTime, max(DealCycle$Time))
  DualPistolATKTime <- c()
  MarksmanATKTime <- c()
  for(i in 1:(length(AssembleCrewTime)-1)) {
    Time <- AssembleCrewTime[i]
    while(Time < AssembleCrewTime[i+1]) {
      if(NectarON(Time, NectarStart, NectarDuration) == T) {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "AssembleCrewDualPistolNectar", ]$SubTime
        DualPistolATKTime <- c(DualPistolATKTime, Time)
      } else {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "AssembleCrewDualPistol", ]$SubTime
        DualPistolATKTime <- c(DualPistolATKTime, Time)
      }
    }
    
    Time <- AssembleCrewTime[i]
    while(Time < AssembleCrewTime[i+1]) {
      if(NectarON(Time, NectarStart, NectarDuration) == T) {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "AssembleCrewMarksmanNectar", ]$SubTime
        MarksmanATKTime <- c(MarksmanATKTime, Time)
      } else {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "AssembleCrewMarksman", ]$SubTime
        MarksmanATKTime <- c(MarksmanATKTime, Time)
      }
    }
    DualPistolATKTime <- DualPistolATKTime[DualPistolATKTime < AssembleCrewTime[i+1]]
    MarksmanATKTime <- MarksmanATKTime[MarksmanATKTime < AssembleCrewTime[i+1]]
  }
  
  Bomber1Time <- DealCycle[DealCycle$Skills=="BattleShipBomber1Summoned", ]$Time
  Bomber1Time <- c(Bomber1Time, max(DealCycle$Time))
  Bomber1ATKTime <- c()
  
  for(i in 1:(length(Bomber1Time)-1)) {
    Time <- Bomber1Time[i]
    while(Time < Bomber1Time[i+1]) {
      if(NectarON(Time, NectarStart, NectarDuration) == T) {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "BattleShipBomber1Nectar", ]$SubTime
        Bomber1ATKTime <- c(Bomber1ATKTime, Time)
      } else {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "BattleShipBomber1", ]$SubTime
        Bomber1ATKTime <- c(Bomber1ATKTime, Time)
      }
    }
    Bomber1ATKTime <- Bomber1ATKTime[Bomber1ATKTime < Bomber1Time[i+1]]
  }
  
  Bomber2Time <- DealCycle[DealCycle$Skills=="BattleShipBomber2Summoned", ]$Time
  Bomber2Time <- c(Bomber2Time, max(DealCycle$Time))
  Bomber2ATKTime <- c()
  
  for(i in 1:(length(Bomber2Time)-1)) {
    Time <- Bomber2Time[i]
    while(Time < Bomber2Time[i+1]) {
      if(NectarON(Time, NectarStart, NectarDuration) == T) {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "BattleShipBomber2Nectar", ]$SubTime
        Bomber2ATKTime <- c(Bomber2ATKTime, Time)
      } else {
        Time <- Time + SummonedFinal[rownames(SummonedFinal) == "BattleShipBomber2", ]$SubTime
        Bomber2ATKTime <- c(Bomber2ATKTime, Time)
      }
    }
    Bomber2ATKTime <- Bomber2ATKTime[Bomber2ATKTime < Bomber2Time[i+1]]
  }
  
  for(i in 1:length(DualPistolATKTime)) {
    DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
    DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewDualPistol"
    DealCycle$Time[nrow(DealCycle)] <- DualPistolATKTime[i]
  }
  for(i in 1:length(MarksmanATKTime)) {
    DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
    DealCycle$Skills[nrow(DealCycle)] <- "AssembleCrewMarksman"
    DealCycle$Time[nrow(DealCycle)] <- MarksmanATKTime[i]
  }
  for(i in 1:length(Bomber1ATKTime)) {
    DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
    DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomber1"
    DealCycle$Time[nrow(DealCycle)] <- Bomber1ATKTime[i]
  }
  for(i in 1:length(Bomber2ATKTime)) {
    DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
    DealCycle$Skills[nrow(DealCycle)] <- "BattleShipBomber2"
    DealCycle$Time[nrow(DealCycle)] <- Bomber2ATKTime[i]
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("AssembleCrewDualPistol", "AssembleCrewMarksman", "BattleShipBomber1", "BattleShipBomber2")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i] == c("SeizeBomber", "AssembleCrewDualPistol", "AssembleCrewMarksman", "BattleShipBomber1", "BattleShipBomber2")) >= 1 & DealCycle$UnwearyingNectar[i] > 0) {
      DealCycle$Skills[i] <- paste(DealCycle$Skills[i], "Nectar", sep="")
    }
  }
  
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
  print("Captain Dignity Done")
  
  
  ## Quick Draw
  ## FDR By Expectation
  QuickDrawProb <- 0.08 + ceiling(Spec$SkillLv / 2) * 0.01
  QuickDrawFD <- 25 + Spec$SkillLv
  DealCycle$QuickDrawStack[3] <- 0
  for(i in 4:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("RapidFire", "BulletParty", "HeadShot", "NautilusAssaultPre", "NautilusAssualtLast", "DeathTrigger", "CaptainDignity")) >= 1 & 
       DealCycle$QuickDrawStack[i-1] < 1) {
      DealCycle$QuickDrawStack[i] <- min(1, DealCycle$QuickDrawStack[i-1] + QuickDrawProb)
    } else if(sum(DealCycle$Skills[i]==c("HeadShot", "DeadEye")) >= 1) {
      DealCycle$QuickDrawFDR[i] <- QuickDrawFD * DealCycle$QuickDrawStack[i-1]
      DealCycle$QuickDrawStack[i] <- 0
    } else {
      DealCycle$QuickDrawStack[i] <- DealCycle$QuickDrawStack[i-1]
    }
  }
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
CaptainDealCycleReduction <- DealCycleReduction(CaptainDealCycle, c("QuickDrawFDR"))

CaptainDealCycle5 <- CaptainDealCycle
CaptainDealCycle55 <- CaptainDealCycle
CaptainDealCycle555 <- CaptainDealCycle
CaptainDealCycle53 <- CaptainDealCycle
CaptainDealCycle533 <- CaptainDealCycle
CaptainDealCycle553 <- CaptainDealCycle

CaptainDealCycle55$LuckyDice55 <- CaptainDealCycle55$LuckyDice5
CaptainDealCycle55$LuckyDice5 <- 0

CaptainDealCycle555$LuckyDice555 <- CaptainDealCycle555$LuckyDice5
CaptainDealCycle555$LuckyDice5 <- 0

CaptainDealCycle53$LuckyDice53 <- CaptainDealCycle53$LuckyDice5
CaptainDealCycle53$LuckyDice5 <- 0

CaptainDealCycle533$LuckyDice533 <- CaptainDealCycle533$LuckyDice5
CaptainDealCycle533$LuckyDice5 <- 0

CaptainDealCycle553$LuckyDice533 <- CaptainDealCycle553$LuckyDice5
CaptainDealCycle553$LuckyDice5 <- 0

CaptainDealCycleProbs <- c(0.592680, 0.208894, 0.009475, 
                           0.135320, 0.017340, 0.036291)

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
  CaptainSpecOpt1 <- Optimization1(CaptainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CaptainSpec, CaptainUnionRemained, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- CaptainSpecOpt1[1, 1:3]
} else {
  CaptainSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
CaptainSpecOpt <- OptDataAdd(CaptainSpec, CaptainSpecOpt1, "Potential", CaptainBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  CaptainSpecOpt2 <- Optimization2(CaptainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, CaptainHyperStatBase, CaptainBase$ChrLv, CaptainBase$CRROver, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- CaptainSpecOpt2[1, ]
} else {
  CaptainSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
CaptainSpecOpt <- OptDataAdd(CaptainSpecOpt, CaptainSpecOpt2, "HyperStat", CaptainBase$CRROver, DemonAvenger=F)

CaptainFinalDPM <- ResetDealCalc(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555, 
                                      CaptainDealCycle53, CaptainDealCycle533, CaptainDealCycle553), 
                                 ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 6), CaptainDealCycleProbs, 
                                 NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainFinalDPMwithMax <- ResetDealCalcWithMaxDMR(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555, 
                                                       CaptainDealCycle53, CaptainDealCycle533, CaptainDealCycle553), 
                                                  ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 6), CaptainDealCycleProbs, 
                                                  NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Captain", sum(na.omit(CaptainFinalDPMwithMax)) / (max(CaptainDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Captain", sum(na.omit(CaptainFinalDPM)) / (max(CaptainDealCycle$Time) / 60000) - sum(na.omit(CaptainFinalDPMwithMax)) / (max(CaptainDealCycle$Time) / 60000))

CaptainDeal1 <- DealCalcWithMaxDMR(CaptainDealCycle5, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDeal2 <- DealCalcWithMaxDMR(CaptainDealCycle55, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDeal3 <- DealCalcWithMaxDMR(CaptainDealCycle555, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDeal4 <- DealCalcWithMaxDMR(CaptainDealCycle53, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDeal5 <- DealCalcWithMaxDMR(CaptainDealCycle533, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDeal6 <- DealCalcWithMaxDMR(CaptainDealCycle553, ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, 
                                   NotBuffCols=c("QuickDrawFDR"), NotBuffColOption=c("FDR"))
CaptainDealDatas <- list(CaptainDeal1, CaptainDeal2, CaptainDeal3, CaptainDeal4, CaptainDeal5, CaptainDeal6)
CaptainDealRatio <- ResetDealRatio(list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555, 
                                        CaptainDealCycle53, CaptainDealCycle533, CaptainDealCycle553), 
                                   CaptainDealDatas, rep(max(CaptainDealCycle$Time), 6), CaptainDealCycleProbs)

CaptainDealData <- data.frame(CaptainDealCycle$Skills, CaptainDealCycle$Time, CaptainDealCycle$Restraint4, CaptainDeal1)
colnames(CaptainDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Captain", Deal_RR(CaptainDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Captain", Deal_40s(CaptainDealData))

CaptainSpecMean <- ResetSpecMean("Captain", 
                                 list(CaptainDealCycle5, CaptainDealCycle55, CaptainDealCycle555, 
                                      CaptainDealCycle53, CaptainDealCycle533, CaptainDealCycle553), 
                                 list(CaptainDeal1, CaptainDeal2, CaptainDeal3, CaptainDeal4, CaptainDeal5, CaptainDeal6), 
                                 ATKFinal, BuffFinal, SummonedFinal, CaptainSpecOpt, rep(max(CaptainDealCycle$Time), 6), CaptainDealCycleProbs)