## Aran - Data
## Aran - VMatrix
AranCoreBase <- CoreBuilder(ActSkills=c("InstallMaha", "BrandishMaha", "FenrirCrash", "BlizardTempest", 
                                        CommonV("Warrior", "Heroes")), 
                            ActSkillsLv=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                            UsefulSkills=c("CombatOrders", "SharpEyes"), 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            VPassiveList=AranVPassive, 
                            VPassivePrior=AranVPrior, 
                            SelfBind=F)

AranCore <- MatrixSet(PasSkills=AranCoreBase$PasSkills$Skills, 
                      PasLvs=AranCoreBase$PasSkills$Lv, 
                      PasMP=AranCoreBase$PasSkills$MP, 
                      ActSkills=AranCoreBase$ActSkills$Skills, 
                      ActLvs=AranCoreBase$ActSkills$Lv, 
                      ActMP=AranCoreBase$ActSkills$MP, 
                      UsefulSkills=AranCoreBase$UsefulSkills, 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      SpecialCore=AranCoreBase$SpecialCoreUse)


## Aran - Basic Info
AranBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=get(DPMCalcOption$MobSet),
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    Job="Aran",
                    CoreData=AranCore, 
                    BuffDurationNeeded=0, 
                    AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Aran"), 
                    LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Aran"), 
                    MonsterLife=get(FindJob(MonsterLifePreSet, "Aran")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                    Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Polarm", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                    WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="AranWeight", ], 
                    Emblem=Emblem[rownames(Emblem)=="Heroes", ], 
                    CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Aran")))


## Aran - Passive
{option <- factor(c("ATKP"), levels=PSkill)
value <- c(5)
RegainedMemory <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
SnowCharge <- data.frame(option, value)

option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
PolarmMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(50, 50, 10)
AdvancedComboAbility <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(40)
Might <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(40, 10)
CleavingAttack <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR", "FDR"), levels=PSkill)
value <- c(70 + ceiling(AranBase$PSkillLv/2), 30 + AranBase$PSkillLv, 8, 8)
HighMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + AranBase$PSkillLv)
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(AranCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(AranCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(AranCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

AranPassive <- Passive(list(RegainedMemory=RegainedMemory, SnowCharge=SnowCharge, PolarmMastery=PolarmMastery, PhysicalTraining=PhysicalTraining, 
                            AdvancedComboAbility=AdvancedComboAbility, Might=Might, CleavingAttack=CleavingAttack, HighMastery=HighMastery, AdvancedFinalAttack=AdvancedFinalAttack, 
                            BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## Aran - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PolarmBooster <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SnowCharge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(20, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdrenalineBoost <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(20, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdrenalineGenerator <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessingMaha <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((AranBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(AranBase$SkillLv/2))))
info <- c(900 + 30 * AranBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR"), levels=BSkill)
value <- c(15 + AranBase$PSkillLv, 20)
info <- c(20, 10, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwingBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(AranCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("ATKP", levels=BSkill)
value <- c(5 + GetCoreLv(AranCore, "InstallMaha"))
info <- c(25 + floor(GetCoreLv(AranCore, "InstallMaha")/2), 90, 960, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InstallMahaBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(20, 180, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DireWolfCurse <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 180, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DireWolfCurseStack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(AranCore, "AuraWeapon")/5), ceiling(GetCoreLv(AranCore, "AuraWeapon")/5), 1)
info <- c(80 + 2 * GetCoreLv(AranCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(AranCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * AranBase$MainStatP), 5 + floor(GetCoreLv(AranCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Combo <- rbind(data.frame(option, value), info)}

AranBuff <- list(PolarmBooster=PolarmBooster, SnowCharge=SnowCharge, AdrenalineBoost=AdrenalineBoost, AdrenalineGenerator=AdrenalineGenerator, 
                 BlessingMaha=BlessingMaha, MapleSoldier=MapleSoldier, SwingBuff=SwingBuff, HeroesOath=HeroesOath, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                 InstallMahaBuff=InstallMahaBuff, DireWolfCurse=DireWolfCurse, DireWolfCurseStack=DireWolfCurseStack, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, Combo=Combo, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## Petbuff : SnowCharge(900ms), PolarmBooster(600ms), BlessingMaha(600ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  AranBuff[[length(AranBuff)+1]] <- UsefulAdvancedBless
  names(AranBuff)[[length(AranBuff)]] <- "UsefulAdvancedBless"
}
AranBuff <- Buff(AranBuff)
AranAllTimeBuff <- AllTimeBuff(AranBuff)


## Aran - Union & HyperStat & SoulWeapon
AranSpec <- JobSpec(JobBase=AranBase, 
                    Passive=AranPassive, 
                    AllTimeBuff=AranAllTimeBuff, 
                    MobInfo=get(DPMCalcOption$MobSet), 
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    WeaponName="Polarm", 
                    UnionStance=0)

AranUnionRemained <- AranSpec$UnionRemained
AranHyperStatBase <- AranSpec$HyperStatBase
AranCoolReduceType <- AranSpec$CoolReduceType
AranSpec <- AranSpec$Spec


## Aran - Spider In Mirror
SIM <- SIMData(GetCoreLv(AranCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Aran - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(AranCore, "Swing")>=40, 20, 0), 2 * GetCoreLv(AranCore, "Swing"))
info <- c(825 + 51 * AranSpec$PSkillLv, 2, 450, NA, NA, NA, NA, F) ## Dynamic Mastery Check Needed
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Swing <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(AranBase$MonsterLife$FinalATKDMR)
info <- c(380 + 40 * AranSpec$PSkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAfterimage <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(GetCoreLv(AranCore, "FinalBlow")>=40, 20, 0), 15)), 2 * GetCoreLv(AranCore, "FinalBlow"))
info <- c(470 + 3 * AranSpec$PSkillLv, 5, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalBlowCommand <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(295 + 1 * AranSpec$PSkillLv, 2, 750, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GatheringCatcherCommand <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(385 + 10 * AranSpec$SkillLv, 6, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(400 + 10 * AranSpec$SkillLv, 6, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(415 + 10 * AranSpec$SkillLv, 6, 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder3 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(30, ifelse(GetCoreLv(AranCore, "HuntersTargeting")>=40, 20, 0), 2 * GetCoreLv(AranCore, "HuntersTargeting"))
info <- c(1195 + 10 * AranSpec$SkillLv + 1 * AranSpec$PSkillLv, 15, 600, 30, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HuntersTargeting <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "FinalAttack")>=40, 20, 0), AranBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(AranCore, "FinalAttack"))
info <- c(185 + 1 * AranSpec$PSkillLv, 3 * (0.6 + 0.01 * ceiling(AranSpec$PSkillLv/2)), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "ZoneofMaha")>=40, 20, 0), 2 * GetCoreLv(AranCore, "ZoneofMaha"))
info <- c(900, 5, 30, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMaha <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "ZoneofMaha")>=40, 20, 0), 2 * GetCoreLv(AranCore, "ZoneofMaha"))
info <- c(600, 3, 0, 1000, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaZone <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(AranCore, "Swing")>=40, 20, 0), 2 * GetCoreLv(AranCore, "Swing"))
info <- c(975 + 51 * AranSpec$PSkillLv, 4, 450, NA, NA, NA, NA, F) ## Dynamic Mastery Check Needed
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(AranBase$MonsterLife$FinalATKDMR)
info <- c(530 + 40 * AranSpec$PSkillLv, 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAfterimageAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(GetCoreLv(AranCore, "FinalBlow")>=40, 20, 0), 15)), 2 * GetCoreLv(AranCore, "FinalBlow"))
info <- c(620 + 3 * AranSpec$PSkillLv, 7, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalBlowCommandAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "FinalBlow")>=40, 20, 0), 2 * GetCoreLv(AranCore, "FinalBlow"))
info <- c(450, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalBlowWave <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(445 + 1 * AranSpec$PSkillLv, 4, 750, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GatheringCatcherCommandAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(535 + 10 * AranSpec$SkillLv, 8, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder1Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(550 + 10 * AranSpec$SkillLv, 8, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder2Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 5 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 30)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(565 + 10 * AranSpec$SkillLv, 8, 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder3Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(500, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BeyonderWave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "FinalAttack")>=40, 20, 0), AranBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(AranCore, "FinalAttack"))
info <- c(335 + 1 * AranSpec$PSkillLv, 5 * (0.6 + 0.01 * ceiling(AranSpec$PSkillLv/2)), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "ZoneofMaha")>=40, 20, 0), 2 * GetCoreLv(AranCore, "ZoneofMaha"))
info <- c(1050, 7, 30, NA, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "ZoneofMaha")>=40, 20, 0), 2 * GetCoreLv(AranCore, "ZoneofMaha"))
info <- c(750, 3, 0, 1000, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaZoneAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(AranCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(550 + 18 * GetCoreLv(AranCore, "InstallMaha"), 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
InstallMaha <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(725 + 24 * GetCoreLv(AranCore, "BrandishMaha") + AranSpec$PSkillLv, 15, 960, 420, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BrandishMahaCommand <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 9 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 50)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(600 + 5 * GetCoreLv(AranCore, "FenrirCrash"), 7 + floor(GetCoreLv(AranCore, "FenrirCrash")/30), 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrash <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 9 - 1) * 100, IGRCalc(c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 50)), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(750 + 5 * GetCoreLv(AranCore, "FenrirCrash"), 9 + floor(GetCoreLv(AranCore, "FenrirCrash")/30), 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrashAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AranCore, "Beyonder")>=40, 20, 0), 2 * GetCoreLv(AranCore, "Beyonder"))
info <- c(600 + 5 * GetCoreLv(AranCore, "FenrirCrash"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrashIceberg <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 32 * GetCoreLv(AranCore, "BlizardTempest"), 8, 990, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardTempest <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(575 + 19 * GetCoreLv(AranCore, "BlizardTempest"), 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardTempestIce <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 1, 0, 1020, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DireWolfCurseDummy <- rbind(data.frame(option, value), info)}

AranATK <- Attack(list(Swing=Swing, SwingAfterimage=SwingAfterimage, FinalBlowCommand=FinalBlowCommand, GatheringCatcherCommand=GatheringCatcherCommand, 
                       Beyonder1=Beyonder1, Beyonder2=Beyonder2, Beyonder3=Beyonder3, HuntersTargeting=HuntersTargeting, AdvancedFinalAttack=AdvancedFinalAttack, 
                       ZoneofMaha=ZoneofMaha, ZoneofMahaZone=ZoneofMahaZone, SwingAdrenaline=SwingAdrenaline, SwingAfterimageAdrenaline=SwingAfterimageAdrenaline, 
                       FinalBlowCommandAdrenaline=FinalBlowCommandAdrenaline, FinalBlowWave=FinalBlowWave, GatheringCatcherCommandAdrenaline=GatheringCatcherCommandAdrenaline, 
                       Beyonder1Adrenaline=Beyonder1Adrenaline, Beyonder2Adrenaline=Beyonder2Adrenaline, Beyonder3Adrenaline=Beyonder3Adrenaline, BeyonderWave=BeyonderWave, 
                       AdvancedFinalAttackAdrenaline=AdvancedFinalAttackAdrenaline, ZoneofMahaAdrenaline=ZoneofMahaAdrenaline, ZoneofMahaZoneAdrenaline=ZoneofMahaZoneAdrenaline, 
                       AuraWeapon=AuraWeapon, InstallMaha=InstallMaha, BrandishMahaCommand=BrandishMahaCommand, FenrirCrash=FenrirCrash, FenrirCrashAdrenaline=FenrirCrashAdrenaline, 
                       FenrirCrashIceberg=FenrirCrashIceberg, BlizardTempest=BlizardTempest, BlizardTempestIce=BlizardTempestIce, DireWolfCurseDummy=DireWolfCurseDummy, SpiderInMirror=SpiderInMirror))


## Aran - Summoned
AranSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Aran - DealCycle & Deal Calculation
ATKFinal <- data.frame(AranATK)
ATKFinal$Delay[-8] <- Delay(ATKFinal$Delay, AranSpec$ATKSpeed)[-8]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, AranSpec$CoolReduceP, AranSpec$CoolReduce)

BuffFinal <- data.frame(AranBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, AranSpec$CoolReduceP, AranSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, AranSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(AranSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, AranSpec$CoolReduceP, AranSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * AranSpec$SummonedDuration / 100, 0)


## Aran - Delay Skip Structure
AranSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
AranSkipATK <- data.frame(AranSkipATK, row.names=c(rownames(ATKFinal)))
colnames(AranSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

AranSkipATK$Swing <- c(rep(F, 26), T, T, rep(F, 5))
AranSkipATK$FinalBlowCommand <- c(T, rep(F, 10), T, rep(F, 14), T, T, rep(F, 5))
AranSkipATK$Beyonder1 <- c(F, F, T, rep(F, 10), T, rep(F, 19))
AranSkipATK$Beyonder2 <- c(F, F, F, F, T, rep(F, 11), T, rep(F, 16))
AranSkipATK$Beyonder3 <- c(F, F, F, F, F, T, rep(F, 11), T, rep(F, 15))
AranSkipATK$SwingAdrenaline <- c(rep(F, 26), T, T, rep(F, 5))
AranSkipATK$FinalBlowCommandAdrenaline <- c(T, rep(F, 10), T, rep(F, 21))
AranSkipATK$Beyonder1Adrenaline <- c(F, F, T, rep(F, 10), T, rep(F, 19))
AranSkipATK$Beyonder2Adrenaline <- c(F, F, F, F, T, rep(F, 11), T, rep(F, 16))
AranSkipATK$Beyonder3Adrenaline <- c(F, F, F, F, F, T, rep(F, 11), T, rep(F, 15))
AranSkipATK$FenrirCrash <- c(F, F, F, F, F, F, T, rep(F, 11), T, rep(F, 14))
AranSkipATK$FenrirCrashAdrenaline <- c(F, F, F, F, F, F, T, rep(F, 11), T, rep(F, 14))
AranSkipATK$SkippedDelay <- c(Delay(450, AranSpec$ATKSpeed), 0, Delay(540, AranSpec$ATKSpeed), 0, Delay(540, AranSpec$ATKSpeed), Delay(480, AranSpec$ATKSpeed), Delay(540, AranSpec$ATKSpeed), 
                              0, 0, 0, 0, Delay(450, AranSpec$ATKSpeed), 0, Delay(540, AranSpec$ATKSpeed), 0, 0, Delay(540, AranSpec$ATKSpeed), Delay(480, AranSpec$ATKSpeed), Delay(540, AranSpec$ATKSpeed), 
                              0, 0, 0, 0, 0, 0, 0, Delay(540, AranSpec$ATKSpeed), Delay(540, AranSpec$ATKSpeed), 0, 0, 0, 0, 0)
AranSkipATK <- subset(AranSkipATK, AranSkipATK$SkippedDelay>0)


## Aran - DealCycle
DealCycle <- c("Skills", "Time", rownames(AranBuff))
AranDealCycle <- t(rep(0, length(DealCycle)))
colnames(AranDealCycle) <- DealCycle
AranDealCycle <- data.frame(AranDealCycle)

AranCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, 
                      Period=180, CycleTime=720) {
  BuffSummonedPrior <- c("PolarmBooster", "SnowCharge", "BlessingMaha", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "HeroesOath", 
                         "AuraWeaponBuff", "MapleWarriors2", "InstallMahaBuff", "SoulContractLink", "Restraint4")
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 0, 
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
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="AuraWeaponBuff") {
        DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ZoneofMaha", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "GatheringCatcherCommand", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "ZoneofMahaZone", ATKFinal, SkipStructure)
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
  
  BMCool <- subset(ATKFinal, rownames(ATKFinal)=="BrandishMahaCommand")$CoolTime * 1000
  BMCool_IM <- subset(ATKFinal, rownames(ATKFinal)=="BrandishMahaCommand")$CoolTime * 1000 / 2
  GNCool <- 240000
  BMRemain <- 0 ; GNRemain <- 0
  ADDummy <- 0 ; CycleDummy <- 0
  DealCycle$Combo[nrow(DealCycle)] <- 1000
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
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1]
        }
      }
      ## Adrenaline Boost
      if(k != length(BuffList) & ADDummy < 4 & DealCycle$Combo[nrow(DealCycle)] == 1000 & BuffEndTime - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > 8000 | 
         k == length(BuffList) & ADDummy < 3 & DealCycle$Combo[nrow(DealCycle)] == 1000) {
        DealCycle <- DCBuff(DealCycle, "AdrenalineBoost", BuffFinal)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- 500
        ADDummy <- ADDummy + 1
      }
      ## Adrenaline Generator
      else if(GNRemain - DealCycle$Time[1] <= 0 & DealCycle$Combo[nrow(DealCycle)] <= 600 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCBuff(DealCycle, "AdrenalineGenerator", BuffFinal)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- GNCool
        DealCycle$Combo[nrow(DealCycle)] <- 500
        DealCycle <- DCBuff(DealCycle, "AdrenalineBoost", BuffFinal)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- 500
        ADDummy <- ADDummy + 1
      }
      ## Blizard Tempest
      else if(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) > nrow(subset(DealCycle, DealCycle$Skills=="BlizardTempest"))) {
        DealCycle <- DCATKSkip(DealCycle, "DireWolfCurseDummy", ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- 500
        DealCycle <- DCATKSkip(DealCycle, "BlizardTempest", ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$DireWolfCurse[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="DireWolfCurse")$Duration * 1000
        DealCycle$Combo[nrow(DealCycle)] <- 500
      }
      ## Swing
      else if(DealCycle$SwingBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
        DealCycle <- DCATKSkip(DealCycle, "Swing", ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$SwingBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SwingBuff")$Duration * 1000
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 2))
      }
      ## Hunters Targeting
      else if(nrow(subset(DealCycle, DealCycle$Skills=="AdrenalineBoost")) > nrow(subset(DealCycle, DealCycle$Skills=="HuntersTargeting"))) {
        DealCycle <- DCATKSkip(DealCycle, c("HuntersTargeting"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CycleDummy <- CycleDummy + 1
        CycleDummy <- ifelse(CycleDummy==4, 0, CycleDummy)
        DealCycle$Combo[nrow(DealCycle)] <- 500
      }
      ## Spider In Mirror
      else if(nrow(subset(DealCycle, DealCycle$Skills=="SpiderInMirror")) < 3 & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SpiderInMirror")$Time) >= ATKFinal[rownames(ATKFinal)=="SpiderInMirror", ]$CoolTime * 1000) {
        DealCycle <- DCATKSkip(DealCycle, c("SpiderInMirror"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] 
      }
      ## Brandish Maha
      else if(BMRemain - DealCycle$Time[1] <= 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCATKSkip(DealCycle, "BrandishMahaCommand", ATKFinal, SkipStructure)
        BMRemain <- ifelse(DealCycle$InstallMahaBuff[nrow(DealCycle)] > 0, BMCool_IM, BMCool)
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 30)
      }
      ## General Cycle (Final Blow - Beyonder - Fenrir Crash)
      else {
        DealCycle <- DCATKSkip(DealCycle, c("FinalBlowCommand"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 5))
        
        DealCycle <- DCATKSkip(DealCycle, c("Beyonder1"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
        
        DealCycle <- DCATKSkip(DealCycle, c("Beyonder2"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
        
        DealCycle <- DCATKSkip(DealCycle, c("Beyonder3"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
        
        DealCycle <- DCATKSkip(DealCycle, c("FenrirCrash"), ATKFinal, SkipStructure)
        BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + subset(ATKFinal, rownames(ATKFinal)=="FenrirCrash")$AttackTimes))
      }
    }
    
    if(sum(k == c(3, 5, 7, 9)) == 1) {
      while(DealCycle$Combo[nrow(DealCycle)] < 920 & GNRemain - DealCycle$Time[1] > 0) {
        if(DealCycle$SwingBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
          DealCycle <- DCATKSkip(DealCycle, "Swing", ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$SwingBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SwingBuff")$Duration * 1000
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 2))
        }
        else if(BMRemain - DealCycle$Time[1] <= 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
          DealCycle <- DCATKSkip(DealCycle, "BrandishMahaCommand", ATKFinal, SkipStructure)
          BMRemain <- ifelse(DealCycle$InstallMahaBuff[nrow(DealCycle)] > 0, BMCool_IM, BMCool)
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 30)
        }
        else {
          DealCycle <- DCATKSkip(DealCycle, c("FinalBlowCommand"), ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 5))
          
          DealCycle <- DCATKSkip(DealCycle, c("Beyonder1"), ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
          
          DealCycle <- DCATKSkip(DealCycle, c("Beyonder2"), ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
          
          DealCycle <- DCATKSkip(DealCycle, c("Beyonder3"), ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 6))
          
          DealCycle <- DCATKSkip(DealCycle, c("FenrirCrash"), ATKFinal, SkipStructure)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + subset(ATKFinal, rownames(ATKFinal)=="FenrirCrash")$AttackTimes))
        }
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          if(BuffList[[k]][i]=="InstallMahaBuff") {
            DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 80))
          } else {
            DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1]
          }
          
          if(BuffList[[k]][i]=="AuraWeaponBuff") {
            DealCycle <- DCATKSkip(DealCycle, "ZoneofMaha", ATKFinal, SkipStructure)
            BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 5))
            
            DealCycle <- DCATKSkip(DealCycle, "GatheringCatcherCommand", ATKFinal, SkipStructure)
            BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$Combo[nrow(DealCycle)] <- ifelse(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0, 500, min(1000, DealCycle$Combo[nrow(DealCycle)-1] + 2))
            
            DealCycle <- DCATKSkip(DealCycle, "ZoneofMahaZone", ATKFinal, SkipStructure)
            BMRemain <- max(0, BMRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GNRemain <- max(0, GNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1]
            
            ADDummy <- 0
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        }
      }
    }
  }
  return(DealCycle)
}
AranAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- RepATKCycle(DealCycle, "HuntersTargeting", 7, subset(ATKFinal, rownames(ATKFinal)=="HuntersTargeting")$Delay, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BrandishMahaCommand", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "DireWolfCurseDummy", 19, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ZoneofMahaZone", 6, 1650, ATKFinal)

  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DireWolfCurseDummyStart") {
      DealCycle$DireWolfCurseStack[i] <- 1
      DealCycle$DireWolfCurse[i] <- DealCycle$DireWolfCurse[i-1]
    }
  }
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BlizardTempest") {
      DealCycle$DireWolfCurseStack[i] <- 1
    } else if(DealCycle$DireWolfCurse[i] > 0) {
      if(sum(DealCycle$Skills[i]==c("Swing", "FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", 
                                    "HuntersTargeting", "BrandishMahaCommand", "FenrirCrash", "DireWolfCurseDummy"))==1) {
        DealCycle$DireWolfCurseStack[i] <- min(DealCycle$DireWolfCurseStack[i-1] + 1, 6)
      } else {
        DealCycle$DireWolfCurseStack[i] <- DealCycle$DireWolfCurseStack[i-1]
      }
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Swing", "FinalBlowCommand", "Beyonder1", "Beyonder2", "Beyonder3", "BrandishMahaCommandStart", "HuntersTargetingStart", "FenrirCrash"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  SwingAF <- 0
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", "BrandishMahaCommandStart", "FenrirCrash"))==1 & 
       DealCycle$SwingBuff[i] > 0 & SwingAF == 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SwingAfterimage")
      SwingAF <- 1
    } else if(DealCycle$Skills[i]=="Swing") {
      SwingAF <- 0
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time>5000 & max(DealCycle$Skills[p]==c("Swing", "FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", "HuntersTargeting", 
                                                "BrandishMahaCommand", "FenrirCrash"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  IM <- subset(DealCycle, DealCycle$Skills=="InstallMahaBuff")
  Ind <- rownames(IM)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$InstallMahaBuff[p] > 0) {
      if(time>3000 & max(DealCycle$Skills[p]==c("Swing", "FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", "HuntersTargeting", 
                                                "BrandishMahaCommand", "FenrirCrash"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("InstallMaha")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Swing", "FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", 
                                  "HuntersTargeting", "BrandishMahaCommand", "FenrirCrash"))==1 & DealCycle$DireWolfCurseStack[i] > 0) {
      for(j in 1:(DealCycle$DireWolfCurseStack[i]+3)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("BlizardTempestIce")
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Swing", "SwingAfterimage", "FinalBlowCommand", "GatheringCatcherCommand", "Beyonder1", "Beyonder2", "Beyonder3", 
                                  "AdvancedFinalAttack", "ZoneofMaha", "ZoneofMahaZone", "FenrirCrash"))==1 & DealCycle$AdrenalineBoost[i] > 0) {
      DealCycle$Skills[i] <- paste(DealCycle$Skills[i], "Adrenaline", sep="")
      if(DealCycle$Skills[i]=="FinalBlowCommandAdrenaline") {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("FinalBlowWave")
      } else if(sum(DealCycle$Skills[i]==c("Beyonder1Adrenaline", "Beyonder2Adrenaline", "Beyonder3Adrenaline"))==1) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("BeyonderWave")
      } else if(DealCycle$Skills[i]=="FenrirCrashAdrenaline") {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("FenrirCrashIceberg")
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Swing", "SwingAdrenaline"))==1) {
      DealCycle$SwingBuff[i] <- 0
    }
  }
  return(DealCycle)
}

AranDealCycle <- AranCycle(PreDealCycle=AranDealCycle, 
                           ATKFinal=ATKFinal, 
                           BuffFinal=BuffFinal, 
                           SummonedFinal=SummonedFinal, 
                           SkipStructure=AranSkipATK, 
                           Spec=AranSpec)
AranDealCycle <- DealCycleFinal(AranDealCycle)
AranDealCycle <- AranAddATK(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal)
AranDealCycle <- DCSpiderInMirror(AranDealCycle, SummonedFinal)
AranDealCycleReduction <- DealCycleReduction(AranDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Aran") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  AranSpecOpt1 <- Optimization1(AranDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AranSpec, AranUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- AranSpecOpt1[1, 1:3]
} else {
  AranSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
AranSpecOpt <- OptDataAdd(AranSpec, AranSpecOpt1, "Potential", AranBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  AranSpecOpt2 <- Optimization2(AranDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt, AranHyperStatBase, AranBase$ChrLv, AranBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- AranSpecOpt2[1, ]
} else {
  AranSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
AranSpecOpt <- OptDataAdd(AranSpecOpt, AranSpecOpt2, "HyperStat", AranBase$CRROver, DemonAvenger=F)

AranFinalDPM <- DealCalc(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt, Collapse=F)
AranFinalDPMwithMax <- DealCalcWithMaxDMR(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Aran", sum(na.omit(AranFinalDPMwithMax)) / (max(AranDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Aran", sum(na.omit(AranFinalDPM)) / (max(AranDealCycle$Time) / 60000) - sum(na.omit(AranFinalDPMwithMax)) / (max(AranDealCycle$Time) / 60000))

AranDealRatio <- DealRatio(AranDealCycle, AranFinalDPMwithMax)

AranDealData <- data.frame(AranDealCycle$Skills, AranDealCycle$Time, AranDealCycle$Restraint4, AranFinalDPMwithMax)
colnames(AranDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Aran", Deal_RR(AranDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Aran", Deal_40s(AranDealData))

AranSpecMean <- SpecMean("Aran", AranDealCycleReduction, 
                         DealCalcWithMaxDMR(AranDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt), 
                         ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt)