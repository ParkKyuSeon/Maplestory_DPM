## WildHunter - Data
## WildHunter - VMatrix
WildHunterCoreBase <- CoreBuilder(ActSkills=c("JaguarMaximum", "JaguarStorm", "WildGrenade", "WildVulcanTypeX",
                                              CommonV("Bowman", "Resistance")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                                  UsefulSkills=c("CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=WildHunterVPassive, 
                                  VPassivePrior=WildHunterVPrior, 
                                  SelfBind=F)

WildHunterCore <- MatrixSet(PasSkills=WildHunterCoreBase$PasSkills$Skills, 
                            PasLvs=WildHunterCoreBase$PasSkills$Lv, 
                            PasMP=WildHunterCoreBase$PasSkills$MP, 
                            ActSkills=WildHunterCoreBase$ActSkills$Skills, 
                            ActLvs=WildHunterCoreBase$ActSkills$Lv, 
                            ActMP=WildHunterCoreBase$ActSkills$MP, 
                            UsefulSkills=WildHunterCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=WildHunterCoreBase$SpecialCoreUse)


## WildHunter - Basic Info
WildHunterBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="WildHunter",
                          CoreData=WildHunterCore, 
                          BuffDurationNeeded=0, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "WildHunter"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "WildHunter"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "WildHunter")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="Arrowhead", ],
                          Emblem=Emblem[rownames(Emblem)=="Resistance", ],
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "WildHunter")))


## WildHunter - Passive
{option <- factor(c("CRR"), levels=PSkill)
value <- c(5)
Jayla <- data.frame(option, value)

option <- factor(c("CDMR"), levels=PSkill)
value <- c(8)
SummonJaguar <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
AutomaticShootingDevice <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(25)
NaturesWrath <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
CrossbowMastery <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
CrossbowAcceleration <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
Flurry <- data.frame(option, value)

option <- factor(c("ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(10, 18, 12)
JaguarLink <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "FDR"), levels=PSkill)
value <- c(60 + 2 * WildHunterBase$PSkillLv, 60 + 2 * WildHunterBase$PSkillLv, 20)
ExtendMagazine <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(WildHunterBase$PSkillLv/2), 30 + WildHunterBase$PSkillLv, 20 + floor(WildHunterBase$PSkillLv/2))
CrossbowExpert <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30 + 3 * WildHunterBase$PSkillLv)
WildInstinct <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20 + ceiling(WildHunterBase$PSkillLv/2))
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(5 + 2 * GetCoreLv(WildHunterCore, "JaguarStorm"))
JaguarStormPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(WildHunterCore, "Blink"))
BlinkPassive <- data.frame(option, value)}

WildHunterPassive <- Passive(list(Jayla=Jayla, SummonJaguar=SummonJaguar, AutomaticShootingDevice=AutomaticShootingDevice, NaturesWrath=NaturesWrath, 
                                  CrossbowMastery=CrossbowMastery, CrossbowAcceleration=CrossbowAcceleration, 
                                  PhysicalTraining=PhysicalTraining, Flurry=Flurry, JaguarLink=JaguarLink, ExtendMagazine=ExtendMagazine, CrossbowExpert=CrossbowExpert, WildInstinct=WildInstinct, 
                                  AdvancedFinalAttack=AdvancedFinalAttack, JaguarStormPassive=JaguarStormPassive, BlinkPassive=BlinkPassive))


## WildHunter - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AnotherBiteDebuffStack <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(20)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulArrow <- rbind(data.frame(option, value), info)

option <- factor("ATKP", levels=BSkill)
value <- c(10)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Hawling <- rbind(data.frame(option, value), info)

option <- factor(c("ATKP", "ATKSpeed"), levels=BSkill)
value <- c(25, 1)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BeastForm <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(WildHunterBase$SkillLv/2), 15 + ceiling(WildHunterBase$SkillLv/2))
info <- c(300 + 3 * WildHunterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((WildHunterBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(WildHunterBase$SkillLv/2))))
info <- c(900 + 30 * WildHunterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WillofLiberty <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(40, 120, 600, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SilentRampage <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(WildHunterCore)
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("AddATKRate", levels=BSkill)
value <- c(180 + GetCoreLv(WildHunterCore, "JaguarStorm"))
info <- c(40, 150 - GetCoreLv(WildHunterCore, "JaguarStorm"), 840, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JaguarStorm <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(4.5, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WildGrenadePrep <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WildGrenadeStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(WildHunterCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * WildHunterBase$MainStatP), 5 + floor(GetCoreLv(WildHunterCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("CDMR"), levels=BSkill)
value <- c(-8)
info <- c(0.66 + 0.03 + 7.74, 120, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JaguarMaximumCDMR <- rbind(data.frame(option, value), info)}

WildHunterBuff <- list(AnotherBiteDebuffStack=AnotherBiteDebuffStack, SoulArrow=SoulArrow, Hawling=Hawling, BeastForm=BeastForm, SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, 
                       WillofLiberty=WillofLiberty, SilentRampage=SilentRampage, UsefulCombatOrders=UsefulCombatOrders, JaguarStorm=JaguarStorm, 
                       WildGrenadePrep=WildGrenadePrep, WildGrenadeStack=WildGrenadeStack, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, JaguarMaximumCDMR=JaguarMaximumCDMR,
                       Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  WildHunterBuff[[length(WildHunterBuff)+1]] <- UsefulAdvancedBless
  names(WildHunterBuff)[[length(WildHunterBuff)]] <- "UsefulAdvancedBless"
}
WildHunterBuff <- Buff(WildHunterBuff)
## Petbuff : SoulArrow, Hawling, BeastForm, SharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
WildHunterAllTimeBuff <- AllTimeBuff(WildHunterBuff)


## WildHunter - Union & HyperStat & SoulWeapon
WildHunterSpec <- JobSpec(JobBase=WildHunterBase, 
                          Passive=WildHunterPassive, 
                          AllTimeBuff=WildHunterAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="Crossbow", 
                          UnionStance=0)

WildHunterUnionRemained <- WildHunterSpec$UnionRemained
WildHunterHyperStatBase <- WildHunterSpec$HyperStatBase
WildHunterCoolReduceType <- WildHunterSpec$CoolReduceType
WildHunterSpec <- WildHunterSpec$Spec


## WildHunter - Critical Reinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(WildHunterSpec$CRR * (0.2 + 0.01 * GetCoreLv(WildHunterCore, "CriticalReinforce")))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}
WildHunterBuff <- list(AnotherBiteDebuffStack=AnotherBiteDebuffStack, SoulArrow=SoulArrow, Hawling=Hawling, BeastForm=BeastForm, SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, 
                       WillofLiberty=WillofLiberty, SilentRampage=SilentRampage, UsefulCombatOrders=UsefulCombatOrders, JaguarStorm=JaguarStorm, 
                       WildGrenadePrep=WildGrenadePrep, WildGrenadeStack=WildGrenadeStack, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, JaguarMaximumCDMR=JaguarMaximumCDMR,
                       Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  WildHunterBuff[[length(WildHunterBuff)+1]] <- UsefulAdvancedBless
  names(WildHunterBuff)[[length(WildHunterBuff)]] <- "UsefulAdvancedBless"
}
WildHunterBuff <- Buff(WildHunterBuff)


## WildHunter - Spider In Mirror
SIM <- SIMData(GetCoreLv(WildHunterCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## WildHunter - Attacks
## Hyper : Wild Vulcan - Reinforce / Wild Vulcan - Boss Killer / Beast Form - Reinforce / Summon Jaguar - CoolTime Reduce / Summon Jaguar - Reinforce
{option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "WildVulcan"), 50, ifelse(GetCoreLv(WildHunterCore, "WildVulcan")>=40, 20, 0))
info <- c(370 + 2 * WildHunterSpec$SkillLv, 1, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WildVulcan <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "AnotherBite_SummonJaguar"), WildHunterBase$MonsterLife$FinalATKDMR, ifelse(GetCoreLv(WildHunterCore, "AnotherBite_SummonJaguar")>=40, 20, 0))
info <- c(60 + floor(WildHunterBase$ChrLv/3), 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AnotherBite <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "AnotherBite_SummonJaguar"), ifelse(GetCoreLv(WildHunterCore, "AnotherBite_SummonJaguar")>=40, 20, 0))
info <- c(140 + WildHunterBase$ChrLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonJaguar <- rbind(data.frame(option, value), info) ## 960ms

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "AdvancedFinalAttack"), WildHunterBase$MonsterLife$FinalATKDMR, ifelse(GetCoreLv(WildHunterCore, "AdvancedFinalAttack")>=40, 20, 0))
info <- c(210 + 2 * WildHunterSpec$PSkillLv, 0.7 + 0.01 * WildHunterSpec$PSkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "AdvancedFinalAttack"), WildHunterBase$MonsterLife$FinalATKDMR, ifelse(GetCoreLv(WildHunterCore, "AdvancedFinalAttack")>=40, 20, 0))
info <- c(210 + 2 * WildHunterSpec$PSkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackRampage <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "RampageasOne"), 20, ifelse(GetCoreLv(WildHunterCore, "RampageasOne")>=40, 20, 0))
info <- c(500 + WildHunterBase$ChrLv, 9, 0, NA, 12, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RampageasOne <- rbind(data.frame(option, value), info) ## 1440ms

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "SonicBoom_JaguarSoul"), 20, ifelse(GetCoreLv(WildHunterCore, "SonicBoom_JaguarSoul")>=40, 20, 0))
info <- c(220 + WildHunterBase$ChrLv, 6, 0, NA, 6 * (100 - WildHunterSpec$CoolReduceP - 20) / 100, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SonicBoom <- rbind(data.frame(option, value), info) ## 960ms

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "SonicBoom_JaguarSoul"), 20, ifelse(GetCoreLv(WildHunterCore, "SonicBoom_JaguarSoul")>=40, 20, 0))
info <- c(270 + WildHunterBase$ChrLv, 12, 0, NA, 210, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JaguarSoul <- rbind(data.frame(option, value), info) ## 1320ms

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "ClawCut"), 20, ifelse(GetCoreLv(WildHunterCore, "ClawCut")>=40, 20, 0))
info <- c(200 + WildHunterBase$ChrLv, 4, 0, NA, 5 * (100 - WildHunterSpec$CoolReduceP - 20) / 100, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ClawCut <- rbind(data.frame(option, value), info) ## 1530ms

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "CrossRoad"), 20, ifelse(GetCoreLv(WildHunterCore, "CrossRoad")>=40, 20, 0))
info <- c(225 + WildHunterBase$ChrLv, 2, 0, NA, 7 * (100 - WildHunterSpec$CoolReduceP - 20) / 100, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrossRoad <- rbind(data.frame(option, value), info) ## 990ms

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(350 + 13 * GetCoreLv(WildHunterCore, "JaguarMaximum"), 12, 30, 82.5, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JaguarMaximum <- rbind(data.frame(option, value), info) ## StartATK : 990ms

option <- factor(c("IGR"), levels=ASkill)
value <- c(100)
info <- c(450 + 18 * GetCoreLv(WildHunterCore, "JaguarMaximum"), 15, 0, 30, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JaguarMaximumEnd <- rbind(data.frame(option, value), info) ## StartATK : 2160 - 30 + 360ms

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * GetCoreLv(WildHunterCore, "WildGrenade"), 6, 0, NA, 0.5, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WildGrenade <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 540, NA, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WildVulcanTypeXPre <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(20)
info <- c(525 + 21 * GetCoreLv(WildHunterCore, "WildVulcanTypeX"), 5, 6660, 100, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WildVulcanTypeXLoop <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 540, NA, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WildVulcanTypeXEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JaguarSummon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JaguarRiding <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * GetCoreLv(WildHunterCore, "AssistantHuntingUnit"), ifelse(GetCoreLv(WildHunterCore, "AssistantHuntingUnit")>=40, 20, 0))
info <- c(150, 3, 660, 300, 8, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AssistantHuntingUnit <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(WildHunterCore, "DrillContainer"), ifelse(GetCoreLv(WildHunterCore, "DrillContainer")>=40, 20, 0))
info <- c(430, 1, 660, 270, 30, T, T, F) ## FirstATK 1200ms, 55 hits
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DrillContainer <- rbind(data.frame(option, value), info)}

WildHunterATK <- Attack(list(WildVulcan=WildVulcan, AnotherBite=AnotherBite, SummonJaguar=SummonJaguar, AdvancedFinalAttack=AdvancedFinalAttack, AdvancedFinalAttackRampage=AdvancedFinalAttackRampage, 
                             RampageasOne=RampageasOne, SonicBoom=SonicBoom, JaguarSoul=JaguarSoul, ClawCut=ClawCut, CrossRoad=CrossRoad, JaguarMaximum=JaguarMaximum, JaguarMaximumEnd=JaguarMaximumEnd, 
                             WildGrenade=WildGrenade, WildVulcanTypeXPre=WildVulcanTypeXPre, WildVulcanTypeXLoop=WildVulcanTypeXLoop, WildVulcanTypeXEnd=WildVulcanTypeXEnd, 
                             JaguarSummon=JaguarSummon, JaguarRiding=JaguarRiding, AssistantHuntingUnit=AssistantHuntingUnit, DrillContainer=DrillContainer, SpiderInMirror=SpiderInMirror))


## WildHunter - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(WildHunterCore, "GuidedArrow"), 1, 720, 500, 0.5*89+0.51, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * GetCoreLv(WildHunterCore, "ResistanceLineInfantry"), 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)}

WildHunterSummoned <- Summoned(list(GuidedArrow=GuidedArrow, ResistanceLineInfantry=ResistanceLineInfantry, SpiderInMirrorStart=SpiderInMirrorStart, 
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## WildHunter - DealCycle
ATKFinal <- data.frame(WildHunterATK)
ATKFinal$Delay[c(-1, -11, -14:-20)] <- Delay(ATKFinal$Delay, WildHunterSpec$ATKSpeed)[c(-1, -11, -14:-20)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, WildHunterSpec$CoolReduceP, WildHunterSpec$CoolReduce)

BuffFinal <- data.frame(WildHunterBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, WildHunterSpec$CoolReduceP, WildHunterSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, WildHunterSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
ATKFinal <- AddATKRateSkills("JaguarStorm", BuffFinal, ATKFinal, c("SummonJaguar", "RampageasOne", "SonicBoom", "JaguarSoul", "ClawCut", "CrossRoad"))

SummonedFinal <- data.frame(WildHunterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, WildHunterSpec$CoolReduceP, WildHunterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * WildHunterSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(WildHunterBuff))
WildHunterDealCycle <- t(rep(0, length(DealCycle)))
colnames(WildHunterDealCycle) <- DealCycle

WildHunterCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, CycleTime=240) {
  BuffSummonedPrior <- c("SoulArrow", "Hawling", "BeastForm", "SharpEyes", "MapleSoldier", "UsefulCombatOrders", "UsefulAdvancedBless", "WillofLiberty", 
                         "GuidedArrow", "ResistanceLineInfantry", "SilentRampage", "JaguarStorm", "MapleWarriors2", "CriticalReinforce", "SoulContractLink", "Restraint4")
  Times120 <- c(0, 0, 0, 0, 0, 0, 0, 0, 
                2, 5, 1, 1, 0.5, 1, 1, 0.5)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times120 <- Times120[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(120, length(BuffSummonedPrior))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times120[i]==0, Inf, Times120[i])
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
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="WillofLiberty") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DCATK(DealCycle, "AssistantHuntingUnit", ATKFinal)
        DealCycle <- DCATK(DealCycle, "DrillContainer", ATKFinal)
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
  
  AHDur <- 31500
  DCCool <- subset(ATKFinal, rownames(ATKFinal)=="DrillContainer")$CoolTime * 1000
  AHRemain <- AHDur - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - subset(DealCycle, DealCycle$Skills=="AssistantHuntingUnit")$Time)
  DCRemain <- DCCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - subset(DealCycle, DealCycle$Skills=="DrillContainer")$Time)
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
          AHRemain <- max(0, AHRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        }
      }
      ## Jaguar Maximum & Wild Vulcan Type X
      if(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="JaguarRiding"))) {
        DealCycle <- DCBuff(DealCycle, "JaguarMaximumCDMR", BuffFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "JaguarRiding", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "JaguarMaximum", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "JaguarMaximumEnd", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "WildVulcanTypeXPre", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "WildVulcanTypeXLoop", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "WildVulcanTypeXEnd", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "JaguarSummon", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
      }
      ## Assistant Hunting Unit
      else if(AHRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="AssistantHuntingUnit")) <= 6) {
        DealCycle <- DCATK(DealCycle, "AssistantHuntingUnit", ATKFinal)
        AHRemain <- AHDur - DealCycle$Time[1]
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
      }
      ## Drill Container
      else if(DCRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="DrillContainer")) <= 7) {
        DealCycle <- DCATK(DealCycle, "DrillContainer", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- DCCool - DealCycle$Time[1]
      }
      ## Wild Vulcan
      else {
        DealCycle <- DCATK(DealCycle, "WildVulcan", ATKFinal)
        AHRemain <- max(0, AHRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          AHRemain <- max(0, AHRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          AHRemain <- max(0, AHRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        }
      }
    }
  }
  DealCycle <- DealCycleFinal(DealCycle)
  
  ## Grenade Cycle
  GrenadeDealCycle <- function(DealCycle, StartStack) {
    GrenadeCycle <- data.frame(Skills=c(0), Time=c(0))
    GrenadeRemain <- 0
    Stack <- StartStack
    Prep <- 4500
    VulcanXTime <- subset(DealCycle, DealCycle$Skills=="WildVulcanTypeXPre")$Time[2]
    for(i in 0 : (max(DealCycle$Time)/10)) {
      if(Stack==8) {
        Prep <- 4500
      } else {
        Prep <- Prep - 10
        if(Prep==0) {
          Stack <- Stack + 1
          Prep <- 4500
        }
      }
      if(Stack >= 1 & GrenadeRemain==0) {
        if(i * 10 <= VulcanXTime - 4500 * 8 | i * 10 >= VulcanXTime & i * 10 <= max(DealCycle$Time) - 4500 * StartStack) {
          UsingSkills <- subset(DealCycle, DealCycle$Time <= i * 10)
          UsingSkills <- UsingSkills[nrow(UsingSkills), ]$Skills
          if(sum(UsingSkills==c("WildVulcan", "WildVulcanTypeXPre", "WildVulcanTypeXLoop", "WildVulcanTypeXEnd"))==1) {
            Cycle <- data.frame(Skills=c("WildGrenade"), Time=i*10)
            GrenadeCycle <- rbind(GrenadeCycle, Cycle)
            Stack <- Stack - 1
            GrenadeRemain <- 500
          }
        }
      }
      GrenadeRemain <- max(0, GrenadeRemain - 10)
    }
    return(GrenadeCycle)
  }
  GrenadeCycle <- GrenadeDealCycle(DealCycle, 6)
  GrenadeCycleBuffs <- matrix(nrow=nrow(GrenadeCycle), ncol=length(rownames(BuffFinal)))
  colnames(GrenadeCycleBuffs) <- rownames(BuffFinal)
  GrenadeCycle <- cbind(GrenadeCycle, GrenadeCycleBuffs)
  GrenadeCycle <- data.frame(GrenadeCycle)
  GrenadeCycle <- GrenadeCycle[-1, ]
  
  DealCycle <- rbind(DealCycle, GrenadeCycle)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("WildGrenade"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  ## Jaguar Cycle
  JaguarSkills <- c("SummonJaguar", "RampageasOne", "SonicBoom", "ClawCut", "CrossRoad")
  Delays <- c(960, 1440, 960, 1530, 990)
  CoolTime <- rep(0, 5)
  Damage <- rep(0, 5)
  DamageperDelay <- rep(0, 5)
  for(i in 1:length(JaguarSkills)) {
    a <- subset(ATKFinal, rownames(ATKFinal)==JaguarSkills[i])
    CoolTime[i] <- a$CoolTime * 1000
    Damage[i] <- a$Damage * a$AttackTimes * (100 + a$FDR) / 100
    DamageperDelay[i] <- Damage[i] / Delays[i]
  }
  Prior <- 6 - rank(DamageperDelay)
  JaguarData <- data.frame(Delay=Delays, CoolTime=CoolTime, Damage=Damage, Prior=Prior)
  rownames(JaguarData) <- JaguarSkills
  JaguarData <- JaguarData[order(JaguarData$Prior), ]
  JaguarData <- data.frame(t(JaguarData))
  
  JaguarDealCycle <- function(DealCycle, JaguarData) {
    JaguarRiding <- subset(DealCycle, DealCycle$Skills=="JaguarRiding")
    JaguarSummon <- subset(DealCycle, DealCycle$Skills=="JaguarSummon")
    JaguarSummon$Time <- JaguarSummon$Time + 540
    JaguarMaximum <- rbind(JaguarRiding, JaguarSummon)
    JaguarMaximum <- JaguarMaximum[order(JaguarMaximum$Time), ]
    Time1 <- JaguarMaximum$Time[1]
    Time2 <- JaguarMaximum$Time[2]
    Time3 <- JaguarMaximum$Time[3]
    Time4 <- JaguarMaximum$Time[4]
    JaguarCycle <- data.frame(Skills=c(0), Time=c(0))
    
    Skill1Cool <- JaguarData[2, 1]
    Skill2Cool <- JaguarData[2, 2]
    Skill3Cool <- JaguarData[2, 3]
    Skill4Cool <- JaguarData[2, 4]
    Skill5Cool <- JaguarData[2, 5]
    
    Skill1Remain <- 0
    Skill2Remain <- 0
    Skill3Remain <- 0
    Skill4Remain <- 0
    Skill5Remain <- 0
    RemainedDelay <- 0
    
    for(i in 0 : (Time1 / 10)) {
      if(RemainedDelay==0) {
        Cycle <- data.frame(Skills="SummonJaguar", Time=i*10)
        RemainedDelay <- JaguarData$SummonJaguar[1] - 10
        JaguarCycle <- rbind(JaguarCycle, Cycle)
      } else {
        RemainedDelay <- RemainedDelay - 10
      }
    }
    Cycle <- data.frame(Skills="RampageasOne", Time=Time1)
    JaguarCycle <- rbind(JaguarCycle, Cycle)
    if(JaguarData$RampageasOne[4]==1) {
      Skill1Remain <- max(0, Skill1Cool - 1440)
    } else if(JaguarData$RampageasOne[4]==2) {
      Skill2Remain <- max(0, Skill2Cool - 1440)
    } else if(JaguarData$RampageasOne[4]==3) {
      Skill3Remain <- max(0, Skill3Cool - 1440)
    } else {
      Skill4Remain <- max(0, Skill4Cool - 1440)
    }
    Cycle <- data.frame(Skills="JaguarMaximumDummy", Time=Time1)
    JaguarCycle <- rbind(JaguarCycle, Cycle)
    Cycle <- data.frame(Skills="JaguarSoul", Time=Time1 + 1440)
    JaguarCycle <- rbind(JaguarCycle, Cycle)
    Skill1Remain <- max(0, Skill1Remain - 1320)
    Skill2Remain <- max(0, Skill2Remain - 1320)
    Skill3Remain <- max(0, Skill3Remain - 1320)
    Skill4Remain <- max(0, Skill4Remain - 1320)
    RemainedDelay <- 0
    for(i in ((Time1 + 1440 + 1320) / 10) : ((Time2 - 10) / 10)) {
      if(Skill1Remain==0 & colnames(JaguarData)[1]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[1], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 1] - 10
          Skill1Remain <- Skill1Cool - 10
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        }
      } else if(Skill2Remain==0 & colnames(JaguarData)[2]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[2], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 2] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- Skill2Cool - 10
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill3Remain==0 & colnames(JaguarData)[3]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[3], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 3] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- Skill3Cool - 10
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill4Remain==0 & colnames(JaguarData)[4]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[4], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 4] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- Skill4Cool - 10
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else {
        if(RemainedDelay==0) {
          Cycle <- data.frame(Skills=colnames(JaguarData)[5], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 5] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      }
    }
    for(i in (Time2 / 10) : ((Time3 - 35010) / 10)) {
      if(Skill1Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[1], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 1] - 10
          Skill1Remain <- Skill1Cool - 10
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        }
      } else if(Skill2Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[2], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 2] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- Skill2Cool - 10
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill3Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[3], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 3] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- Skill3Cool - 10
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill4Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[4], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 4] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- Skill4Cool - 10
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else {
        if(RemainedDelay==0) {
          Cycle <- data.frame(Skills=colnames(JaguarData)[5], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 5] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      }
    }
    for(i in ((Time3 - 35000) / 10) : ((Time3 - 10) / 10)) {
      if(Skill1Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[1], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 1] - 10
          Skill1Remain <- ifelse(colnames(JaguarData)[1]=="RampageasOne", Skill1Cool + 2000, Skill1Cool) - 10
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        }
      } else if(Skill2Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[2], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 2] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- ifelse(colnames(JaguarData)[2]=="RampageasOne", Skill2Cool + 2000, Skill2Cool) - 10
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill3Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[3], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 3] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- ifelse(colnames(JaguarData)[3]=="RampageasOne", Skill3Cool + 2000, Skill3Cool) - 10
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill4Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[4], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 4] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- ifelse(colnames(JaguarData)[4]=="RampageasOne", Skill4Cool + 2000, Skill4Cool) - 10
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else {
        if(RemainedDelay==0) {
          Cycle <- data.frame(Skills=colnames(JaguarData)[5], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 5] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      }
    }
    Cycle <- data.frame(Skills="JaguarMaximumDummy", Time=Time3)
    JaguarCycle <- rbind(JaguarCycle, Cycle)
    for(i in (Time3 / 10) : ((Time4 - 10) / 10)) {
      if(Skill1Remain==0 & colnames(JaguarData)[1]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[1], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 1] - 10
          Skill1Remain <- Skill1Cool - 10
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        }
      } else if(Skill2Remain==0 & colnames(JaguarData)[2]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[2], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 2] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- Skill2Cool - 10
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill3Remain==0 & colnames(JaguarData)[3]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[3], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 3] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- Skill3Cool - 10
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill4Remain==0 & colnames(JaguarData)[4]!="RampageasOne") {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[4], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 4] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- Skill4Cool - 10
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else {
        if(RemainedDelay==0) {
          Cycle <- data.frame(Skills=colnames(JaguarData)[5], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 5] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      }
    }
    for(i in (Time4 / 10) : max(DealCycle$Time/10)) {
      if(Skill1Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[1], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 1] - 10
          Skill1Remain <- Skill1Cool - 10
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        }
      } else if(Skill2Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[2], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 2] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- Skill2Cool - 10
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill3Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[3], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 3] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- Skill3Cool - 10
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else if(Skill4Remain==0) {
        if(RemainedDelay==0 | JaguarCycle$Skills[nrow(JaguarCycle)]=="SummonJaguar") {
          Cycle <- data.frame(Skills=colnames(JaguarData)[4], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 4] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- Skill4Cool - 10
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      } else {
        if(RemainedDelay==0) {
          Cycle <- data.frame(Skills=colnames(JaguarData)[5], Time=i*10)
          JaguarCycle <- rbind(JaguarCycle, Cycle)
          RemainedDelay <- JaguarData[1, 5] - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } else {
          RemainedDelay <- RemainedDelay - 10
          Skill1Remain <- max(0, Skill1Remain - 10)
          Skill2Remain <- max(0, Skill2Remain - 10)
          Skill3Remain <- max(0, Skill3Remain - 10)
          Skill4Remain <- max(0, Skill4Remain - 10)
        } 
      }
    }
    return(JaguarCycle)
  }
  JaguarCycle <- JaguarDealCycle(DealCycle, JaguarData)
  JaguarCycle <- JaguarCycle[JaguarCycle$Skills!="JaguarMaximumDummy", ]
  JaguarCycleBuffs <- matrix(nrow=nrow(JaguarCycle), ncol=length(rownames(BuffFinal)))
  colnames(JaguarCycleBuffs) <- rownames(BuffFinal)
  JaguarCycle <- cbind(JaguarCycle, JaguarCycleBuffs)
  JaguarCycle <- data.frame(JaguarCycle)
  JaguarCycle <- JaguarCycle[-1, ]
  
  DealCycle <- rbind(DealCycle, JaguarCycle)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SummonJaguar", "CrossRoad", "ClawCut", "SonicBoom", "JaguarSoul", "RampageasOne"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  return(DealCycle)
}
WildHunterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, StormHits=3) {
  ## Jaguar Storm
  Idx <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$JaguarStorm[i] > 0 & sum(DealCycle$Skills[i]==c("SummonJaguar", "RampageasOne", "SonicBoom", "JaguarSoul", "ClawCut", "CrossRoad"))>=1) {
      for(j in 1:StormHits) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "Add", sep="")
      }
      if(DealCycle$JaguarMaximumCDMR[i] > 0) {
        Idx <- c(Idx, i)
      }
    }
  }
  DealCycle <- DealCycle[-Idx, ]
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Drill Container, Wild Vulcan Type X, Jaguar Maximum
  DealCycle <- RepATKCycle(DealCycle, "DrillContainer", 55, 1200, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "WildVulcanTypeXLoop", 56, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JaguarMaximum", 9, 990, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JaguarMaximumEnd", 4, 2160 - 30 + 360, ATKFinal)
  
  ## Assistant Hunting Unit
  DealCycle$Skills[DealCycle$Skills=="AssistantHuntingUnit"] <- "AssistantHuntingUnitStart"
  HuntingUnitDelay <- c(seq(840, 3540, 300), seq(7600, 10600, 300), seq(14600, 17600, 300), seq(21600, 24600, 300), seq(28600, 31300, 300))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AssistantHuntingUnitStart") {
      for(j in 1:length(HuntingUnitDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "AssistantHuntingUnit"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HuntingUnitDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AssistantHuntingUnit") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  ## Final Attack, Another Bite
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("WildVulcan", "WildVulcanTypeXLoop"))>=1 & DealCycle$SilentRampage[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AdvancedFinalAttackRampage"
      for(j in 1:3) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "AnotherBite"
      }
    } else if(sum(DealCycle$Skills[i]==c("WildVulcan", "WildVulcanTypeXLoop"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AdvancedFinalAttack"
      for(j in 1:3) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "AnotherBite"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Resistance Line Infanctry, Guided Arrow, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, "ResistanceLineInfantry", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "GuidedArrow", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  return(DealCycle)
}

WildHunterDealCycle <- WildHunterCycle(WildHunterDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       Spec=WildHunterSpec, 
                                       CycleTime=240)
WildHunterDealCycle <- WildHunterAddATK(WildHunterDealCycle, 
                                        ATKFinal, 
                                        BuffFinal,
                                        SummonedFinal, 
                                        Spec=WildHunterSpec, 
                                        StormHits=3)
WildHunterDealCycleReduction <- DealCycleReduction(WildHunterDealCycle)

## Jaguar Storm 3 Hits
## Damage Optimization
Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="WildHunter") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  WildHunterSpecOpt1 <- Optimization1(WildHunterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WildHunterSpec, WildHunterUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- WildHunterSpecOpt1[1, 1:3]
} else {
  WildHunterSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
WildHunterSpecOpt <- OptDataAdd(WildHunterSpec, WildHunterSpecOpt1, "Potential", WildHunterBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  WildHunterSpecOpt2 <- Optimization2(WildHunterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WildHunterSpecOpt, WildHunterHyperStatBase, WildHunterBase$ChrLv, WildHunterBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- WildHunterSpecOpt2[1, ]
} else {
  WildHunterSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
WildHunterSpecOpt <- OptDataAdd(WildHunterSpecOpt, WildHunterSpecOpt2, "HyperStat", WildHunterBase$CRROver, DemonAvenger=F)
BuffFinal <- CriReinAdj(WildHunterSpec, WildHunterSpecOpt, BuffFinal, GetCoreLv(WildHunterCore, "CriticalReinforce"))

WildHunterFinalDPM <- DealCalc(WildHunterDealCycle, ATKFinal, BuffFinal, SummonedFinal, WildHunterSpecOpt, Collapse=F)
WildHunterFinalDPMwithMax <- DealCalcWithMaxDMR(WildHunterDealCycle, ATKFinal, BuffFinal, SummonedFinal, WildHunterSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "WildHunter", sum(na.omit(WildHunterFinalDPMwithMax)) / (max(WildHunterDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "WildHunter", sum(na.omit(WildHunterFinalDPM)) / (max(WildHunterDealCycle$Time) / 60000) - sum(na.omit(WildHunterFinalDPMwithMax)) / (max(WildHunterDealCycle$Time) / 60000))

WildHunterDealRatio <- DealRatio(WildHunterDealCycle, WildHunterFinalDPMwithMax)

WildHunterDealData <- data.frame(WildHunterDealCycle$Skills, WildHunterDealCycle$Time, WildHunterDealCycle$Restraint4, WildHunterFinalDPMwithMax)
colnames(WildHunterDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "WildHunter", Deal_RR(WildHunterDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "WildHunter", Deal_40s(WildHunterDealData))


## Jaguar Storm 2 Hits
DealCycle <- c("Skills", "Time", rownames(WildHunterBuff))
WildHunterDealCycleStorm2Hit <- t(rep(0, length(DealCycle)))
colnames(WildHunterDealCycleStorm2Hit) <- DealCycle

WildHunterDealCycleStorm2Hit <- WildHunterCycle(WildHunterDealCycleStorm2Hit, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       Spec=WildHunterSpec, 
                                       CycleTime=240)
WildHunterDealCycleStorm2Hit <- WildHunterAddATK(WildHunterDealCycleStorm2Hit, 
                                        ATKFinal, 
                                        BuffFinal,
                                        SummonedFinal, 
                                        Spec=WildHunterSpec, 
                                        StormHits=2)
Storm2Hit <- DealCalc(WildHunterDealCycleStorm2Hit, ATKFinal, BuffFinal, SummonedFinal, WildHunterSpecOpt, Collapse=F)
Storm2HitDPM <- sum(na.omit(Storm2Hit)) / (max(WildHunterDealCycleStorm2Hit$Time)/ 60000)

Storm2HitDealData <- data.frame(WildHunterDealCycleStorm2Hit$Skills, WildHunterDealCycleStorm2Hit$Time, WildHunterDealCycleStorm2Hit$Restraint4, Storm2Hit)
colnames(Storm2HitDealData) <- c("Skills", "Time", "R4", "Deal")

Storm2HitRR <- Deal_RR(Storm2HitDealData)
Storm2Hit40s <- Deal_40s(Storm2HitDealData)

print(data.frame(Storm2HitDPM=Storm2HitDPM, Storm2HitRR=Storm2HitRR, Storm2Hit40s=Storm2Hit40s))