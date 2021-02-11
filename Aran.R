## Aran - Data
## Aran - VMatrix
AranCore <- MatrixSet(PasSkills=c("Swing", "FinalBlow", "Beyonder", "HuntersTargeting", "FinalAttack", "ZoneofMaha"), 
                      PasLvs=c(50, 50, 50, 50, 50, 50), 
                      PasMP=c(10, 10, 10, 10, 10, 10), 
                      ActSkills=c("InstallMaha", "BrandishMaha", "FenrirCrash", "BlizardTempest", 
                                  CommonV("Warrior", "Heroes")), 
                      ActLvs=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                      ActMP=c(5, 5, 5, 5, 5, 0, 0, 5, 5), 
                      UsefulSkills=c("SharpEyes", "CombatOrders"), 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=SpecDefault)


## Aran - Basic Info
AranBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=MobDefault,
                    SpecSet=SpecDefault, 
                    Job="Aran",
                    CoreData=AranCore, 
                    MikhailLink=F, 
                    OtherBuffDuration=0, 
                    AbilList=c("BDR", "DisorderBDR"), 
                    LinkList=c("CygnusKnights", "Aran", "DemonAvenger", "Phantom"), 
                    MonsterLife=MLTypeS22, 
                    Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Polarm", SpecDefault$WeaponType)[, 1:16],
                    WeaponType=SpecDefault$WeaponType, 
                    SubWeapon=SubWeapon[20, ], 
                    Emblem=Emblem[2, ])


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

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(AranBase$PSkillLv/2), 30 + AranBase$PSkillLv, 8)
HighMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + AranBase$PSkillLv)
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c(AranCore[[2]][6, 2]), levels=PSkill)
value <- c(AranCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)}

AranPassive <- Passive(list(RegainedMemory=RegainedMemory, SnowCharge=SnowCharge, PolarmMastery=PolarmMastery, PhysicalTraining=PhysicalTraining, 
                            AdvancedComboAbility=AdvancedComboAbility, Might=Might, CleavingAttack=CleavingAttack, HighMastery=HighMastery, AdvancedFinalAttack=AdvancedFinalAttack, 
                            BodyofStealPassive=BodyofStealPassive))


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
info <- c(5, 10, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwingBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * AranCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * AranCore[[3]][2, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKP", levels=BSkill)
value <- c(5 + AranCore[[2]][5, 2])
info <- c(30 + AranCore[[2]][5, 2], 150, 960, F, T, F, T)
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
value <- c(10 + floor(AranCore[[2]][5, 2]/5), ceiling(AranCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * AranCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * AranCore[[2]][8, 2]) * MapleSoldier[1, 2]) * AranBase$MainStatP), 5 + floor(AranCore[[2]][8, 2]/2))
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

AranBuff <- Buff(list(PolarmBooster=PolarmBooster, SnowCharge=SnowCharge, AdrenalineBoost=AdrenalineBoost, AdrenalineGenerator=AdrenalineGenerator, 
                      BlessingMaha=BlessingMaha, MapleSoldier=MapleSoldier, SwingBuff=SwingBuff, HeroesOath=HeroesOath, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                      InstallMahaBuff=InstallMahaBuff, DireWolfCurse=DireWolfCurse, DireWolfCurseStack=DireWolfCurseStack, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, Combo=Combo, 
                      Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## Petbuff : PolarmBooster, SnowCharge, BlessingMaha
AranAllTimeBuff <- AllTimeBuff(AranBuff)


## Aran - Union & HyperStat & SoulWeapon
AranSpec <- JobSpec(JobBase=AranBase, 
                    Passive=AranPassive, 
                    AllTimeBuff=AranAllTimeBuff, 
                    MobInfo=MobDefault, 
                    SpecSet=SpecDefault, 
                    WeaponName="Polarm", 
                    UnionStance=0)

AranUnionRemained <- AranSpec$UnionRemained
AranHyperStatBase <- AranSpec$HyperStatBase
AranCoolReduceType <- AranSpec$CoolReduceType
AranSpec <- AranSpec$Spec
AranTargetPlus <- 0


## Aran - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * AranCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * AranCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AranCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AranCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AranCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AranCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Aran - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(AranCore[[1]][1, 2]>=40, 20, 0), 2 * AranCore[[1]][1, 2])
info <- c(825 + 51 * AranSpec$PSkillLv, 2, 450, NA, NA, NA, NA, F) ## Dynamic Mastery Check Needed
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Swing <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(10)
info <- c(380 + 40 * AranSpec$PSkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAfterimage <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(AranCore[[1]][2, 2]>=40, 20, 0), 15)), 2 * AranCore[[1]][2, 2])
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
value <- c(20 + (1.06 ^ (5 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(385 + 10 * AranSpec$SkillLv, 6, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ (5 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(400 + 10 * AranSpec$SkillLv, 6, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ (5 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(415 + 10 * AranSpec$SkillLv, 6, 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder3 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][4, 2]>=40, 20, 0), 2 * AranCore[[1]][4, 2])
info <- c(1195 + 10 * AranSpec$SkillLv + 1 * AranSpec$PSkillLv, 15, 450, 30, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HuntersTargeting <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][5, 2]>=40, 20, 0), 10, 2 * AranCore[[1]][5, 2])
info <- c(185 + 1 * AranSpec$PSkillLv, 3 * (0.6 + 0.01 * ceiling(AranSpec$PSkillLv/2)), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][6, 2]>=40, 20, 0), 2 * AranCore[[1]][6, 2])
info <- c(900, 5, 30, NA, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMaha <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][6, 2]>=40, 20, 0), 2 * AranCore[[1]][6, 2])
info <- c(600, 3, 0, 1000, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaZone <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(AranCore[[1]][1, 2]>=40, 20, 0), 2 * AranCore[[1]][1, 2])
info <- c(975 + 51 * AranSpec$PSkillLv, 4, 450, NA, NA, NA, NA, F) ## Dynamic Mastery Check Needed
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAdrelaine <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(10)
info <- c(530 + 40 * AranSpec$PSkillLv, 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwingAfterimageAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(AranCore[[1]][2, 2]>=40, 20, 0), 15)), 2 * AranCore[[1]][2, 2])
info <- c(620 + 3 * AranSpec$PSkillLv, 7, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalBlowCommandAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][2, 2]>=40, 20, 0), 2 * AranCore[[1]][2, 2])
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
value <- c(20 + (1.06 ^ (10 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(535 + 10 * AranSpec$SkillLv, 8, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder1Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ (10 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(550 + 10 * AranSpec$SkillLv, 8, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder2Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ (10 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 50)), 2 * AranCore[[1]][3, 2])
info <- c(565 + 10 * AranSpec$SkillLv, 8, 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Beyonder3Adrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 2 * AranCore[[1]][3, 2])
info <- c(500, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BeyonderWave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][5, 2]>=40, 20, 0), 10, 2 * AranCore[[1]][5, 2])
info <- c(335 + 1 * AranSpec$PSkillLv, 5 * (0.6 + 0.01 * ceiling(AranSpec$PSkillLv/2)), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][6, 2]>=40, 20, 0), 2 * AranCore[[1]][6, 2])
info <- c(1050, 7, 30, NA, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][6, 2]>=40, 20, 0), 2 * AranCore[[1]][6, 2])
info <- c(750, 3, 0, 1000, 150, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ZoneofMahaZoneAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * AranCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(550 + 18 * AranCore[[2]][1, 2], 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
InstallMaha <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(725 + 24 * AranCore[[2]][2, 2] + AranSpec$PSkillLv, 15, 960, 420, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BrandishMahaCommand <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ (10 + AranTargetPlus + c(ifelse(AranCore[[1]][3, 2]>=20, 1, 0))) - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 70)), 2 * AranCore[[1]][3, 2])
info <- c(600 + 5 * AranCore[[2]][3, 2], 7 + floor(AranCore[[2]][3, 2]/30), 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrash <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + (1.06 ^ 14 - 1) * 100, IGRCalc(c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 70)), 2 * AranCore[[1]][3, 2])
info <- c(750 + 5 * AranCore[[2]][3, 2], 9 + floor(AranCore[[2]][3, 2]/30), 600, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrashAdrenaline <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AranCore[[1]][3, 2]>=40, 20, 0), 2 * AranCore[[1]][3, 2])
info <- c(600 + 5 * AranCore[[2]][3, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FenrirCrashIceberg <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 32 * AranCore[[2]][4, 2], 8, 990, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlizardTempest <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(575 + 19 * AranCore[[2]][4, 2], 1, 0, NA, NA, NA, NA, F)
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
                       ZoneofMaha=ZoneofMaha, ZoneofMahaZone=ZoneofMahaZone, SwingAdrelaine=SwingAdrelaine, SwingAfterimageAdrenaline=SwingAfterimageAdrenaline, 
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
ATKFinal$Delay <- Delay(ATKFinal$Delay, AranSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, AranSpec$CoolReduceP, AranSpec$CoolReduce)

BuffFinal <- data.frame(AranBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, AranSpec$CoolReduceP, AranSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, AranSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

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
AranSkipATK$SwingAdrelaine <- c(rep(F, 26), T, T, rep(F, 5))
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


AranCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec) {
  StartBuff <- c("PolarmBooster", "SnowCharge", "BlessingMaha", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "HeroesOath") 
  DealCycle <- PreDealCycle
  DealCycle <- DCBuff(DealCycle, StartBuff, BuffFinal)
  DealCycle$Combo <- 500
  BMCoolDown <- 0
  BMCool <- subset(ATKFinal, rownames(ATKFinal)=="BrandishMahaCommand")$CoolTime * 1000 ; BMCoolIM <- BMCool / 2
  CycleDummy <- 0 ; ADDummy <- 0
  
  AranSkillSetA <- c("FinalBlowCommand", "Beyonder1", "Beyonder2", "Beyonder3", "FenrirCrash")
  
  while(DealCycle$Combo[nrow(DealCycle)] <= 900) {
    if(BMCoolDown==0) {
      DealCycle <- DCATK(DealCycle, "BrandishMahaCommand", ATKFinal)
      DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 30
    }
    if(CycleDummy==0) {
      DealCycle <- DCATKSkip(DealCycle, "Swing", ATKFinal, SkipStructure)
      DealCycle$SwingBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SwingBuff")$Duration * 1000
      DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 2
    }
    for(i in 1:length(AranSkillSetA)) {
      if(AranSkillSetA[i]=="FinalBlowCommand") {
        DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
        DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 5
      } else if(AranSkillSetA[i]=="FenrirCrash") {
        DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
        DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + subset(ATKFinal, rownames(ATKFinal)=="FenrirCrash")$AttackTimes
      } else {
        DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
        DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 6
      }
      CycleDummy <- CycleDummy + 1
      CycleDummy <- ifelse(CycleDummy==3, 0, CycleDummy)
    }
    BMCoolDown <- max(BMCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="BrandishMahaCommand")$Time)), 0)
  }
  
  DealCycle <- DCBuff(DealCycle, c("AuraWeaponBuff", "MapleWarriors2"), BuffFinal)
  DealCycle <- DCATK(DealCycle, c("SpiderInMirror", "ZoneofMaha", "GatheringCatcherCommand", "ZoneofMahaZone"), ATKFinal)
  DealCycle <- DCBuff(DealCycle, c("SoulContractLink", "InstallMahaBuff"), BuffFinal)
  DealCycle$AdrenalineBoost[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AdrenalineBoost")$Duration * 1000
  DealCycle$Combo[nrow(DealCycle)] <- 0
  DealCycle <- DCBuff(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle <- DCATK(DealCycle, c("DireWolfCurseDummy", "BlizardTempest"), ATKFinal)
  DealCycle$DireWolfCurse[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="DireWolfCurse")$Duration * 1000
  
  DealCycle <- DCATKSkip(DealCycle, "Swing", ATKFinal, SkipStructure)
  DealCycle$SwingBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SwingBuff")$Duration * 1000
  DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 2
  CycleDummy <- 1
  
  DealCycle <- DCATK(DealCycle, c("HuntersTargeting"), ATKFinal)
  
  ComboF <- function(DealCycle, AddCombo, ADDummy) {
    if(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & ADDummy == 0) {
      Combo <- 500
      DealCycle$AdrenalineBoost[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AdrenalineBoost")$Duration * 1000
    } else if(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0) {
      Combo <- 500
    } else {
      Combo <- DealCycle$Combo[nrow(DealCycle)-1] + AddCombo
      if(Combo >= 1000) {
        Combo <- 500
        DealCycle$AdrenalineBoost[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AdrenalineBoost")$Duration * 1000
      }
    }
    DealCycle$Combo[nrow(DealCycle)] <- Combo
    return(DealCycle)
  }
  ADDummyF <- function(DealCycle, ADDummy) {
    if(DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      ADDummy <- ADDummy + 1
      print(paste("Adrenaline End : ", DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1], sep=""))
    } else if(DealCycle$AdrenalineBoost[nrow(DealCycle)-1] > 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] == subset(BuffFinal, rownames(BuffFinal)=="AdrenalineBoost")$Duration * 1000) {
      ADDummy <- ADDummy + 1
      print(paste("Adrenaline End : ", DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1], sep=""))
    }
    return(ADDummy)
  }
  
  while(ADDummy < 5) {
    if(DealCycle$HeroesOath[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
      DealCycle <- DCBuff(DealCycle, "HeroesOath", BuffFinal)
      DealCycle <- ComboF(DealCycle, 0, ADDummy)
    } else if(CycleDummy == 0 & DealCycle$AdrenalineBoost[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & BMCoolDown == 0) {
      DealCycle <- DCATK(DealCycle, "BrandishMahaCommand", ATKFinal)
      DealCycle$Combo[nrow(DealCycle)] <- DealCycle$Combo[nrow(DealCycle)-1] + 30
      DealCycle <- ComboF(DealCycle, 30, ADDummy)
      ADDummy <- ADDummyF(DealCycle, ADDummy)
    } else if(CycleDummy == 0) {
      DealCycle <- DCATKSkip(DealCycle, "Swing", ATKFinal, SkipStructure)
      DealCycle$SwingBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SwingBuff")$Duration * 1000
      DealCycle <- ComboF(DealCycle, 2, ADDummy)
      ADDummy <- ADDummyF(DealCycle, ADDummy)
      CycleDummy <- ifelse(DealCycle$InstallMaha[nrow(DealCycle)] > 0, 2, 1)
    } else {
      for(i in 1:length(AranSkillSetA)) {
        if(AranSkillSetA[i]=="FinalBlowCommand") {
          DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
          DealCycle <- ComboF(DealCycle, 5, ADDummy)
          ADDummy <- ADDummyF(DealCycle, ADDummy)
        } else if(AranSkillSetA[i]=="FenrirCrash") {
          DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
          DealCycle <- ComboF(DealCycle, subset(ATKFinal, rownames(ATKFinal)=="FenrirCrash")$AttackTimes, ADDummy)
          ADDummy <- ADDummyF(DealCycle, ADDummy)
        } else {
          DealCycle <- DCATKSkip(DealCycle, AranSkillSetA[i], ATKFinal, SkipStructure)
          DealCycle <- ComboF(DealCycle, 6, ADDummy)
          ADDummy <- ADDummyF(DealCycle, ADDummy)
        }
        CycleDummy <- CycleDummy + 1
        CycleDummy <- ifelse(CycleDummy==4, 0, CycleDummy)
      }
    }
    if(max(subset(DealCycle, DealCycle$Skills=="HuntersTargeting")$Time) < 
       max(subset(DealCycle, DealCycle$AdrenalineBoost==(subset(BuffFinal, rownames(BuffFinal)=="AdrenalineBoost")$Duration * 1000))$Time) & 
       DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0) {
      if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) > 
         subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000 & 
         DealCycle$AdrenalineBoost[nrow(DealCycle)] > 0) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- ComboF(DealCycle, 0, ADDummy)
        ADDummy <- ADDummyF(DealCycle, ADDummy)
      }
      DealCycle <- DCATK(DealCycle, "HuntersTargeting", ATKFinal)
      DealCycle <- ComboF(DealCycle, 0, ADDummy)
      ADDummy <- ADDummyF(DealCycle, ADDummy)
    }
    Cool <- ifelse(DealCycle$InstallMaha[nrow(DealCycle)] > 0, BMCoolIM, BMCool)
    BMCoolDown <- max(Cool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="BrandishMahaCommand")$Time)), 0)
  }
  End <- c()
  for(i in (nrow(DealCycle)-4):nrow(DealCycle)) {
    if(DealCycle$AdrenalineBoost[i] == 0) {
      End <- c(End, i)
    }
  }
  if(length(End)!=0) {
    DealCycle <- DealCycle[-End, ]
  }
  DealCycle[1, -1] <- subset(ATKFinal, rownames(ATKFinal)==DealCycle$Skills[nrow(DealCycle)])$Delay
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
AranAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- RepATKCycle(DealCycle, "HuntersTargeting", 7, subset(ATKFinal, rownames(ATKFinal)=="HuntersTargeting")$Delay, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BrandishMahaCommand", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "DireWolfCurseDummy", 19, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ZoneofMahaZone", 8, 1650, ATKFinal)

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
  return(DealCycle)
}

AranDealCycle <- AranCycle(PreDealCycle=AranDealCycle, 
                           ATKFinal=ATKFinal, 
                           BuffFinal=BuffFinal, 
                           SummonedFinal=SummonedFinal, 
                           SkipStructure=AranSkipATK, 
                           Spec=AranSpec)
AranDealCycle <- AranAddATK(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal)
AranDealCycle <- DCSpiderInMirror(AranDealCycle, SummonedFinal)
AranDealCycleReduction <- DealCycleReduction(AranDealCycle)


DealCalc(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpec)
AranDealData <- data.frame(AranDealCycle$Skills, DealCalc(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpec))
colnames(AranDealData) <- c("Skills", "Deal")

## Damage Optimization
AranSpecOpt1 <- Optimization1(AranDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AranSpec, AranUnionRemained)
AranSpecOpt <- AranSpec
AranSpecOpt$ATKP <- AranSpecOpt$ATKP + AranSpecOpt1$ATKP
AranSpecOpt$BDR <- AranSpecOpt$BDR + AranSpecOpt1$BDR
AranSpecOpt$IGR <- IGRCalc(c(AranSpecOpt$IGR, AranSpecOpt1$IGR))

AranSpecOpt2 <- Optimization2(AranDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt, AranHyperStatBase, AranBase$ChrLv, AranBase$CRROver)
AranFinalDPM <- DealCalc(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt2)
AranFinalDPMwithMax <- DealCalcWithMaxDMR(AranDealCycle, ATKFinal, BuffFinal, SummonedFinal, AranSpecOpt2)

DPM12338$Aran[1] <- sum(na.omit(AranFinalDPMwithMax)) / (240750 / 60000)
DPM12338$Aran[2] <- sum(na.omit(AranFinalDPM)) / (240750 / 60000) - sum(na.omit(AranFinalDPMwithMax)) / (240750 / 60000)

AranDealRatio <- DealRatio(AranDealCycle, AranFinalDPMwithMax)

AranDealData <- data.frame(AranDealCycle$Skills, AranDealCycle$Time, AranDealCycle$Restraint4, AranFinalDPMwithMax, AranFinalDPM-AranFinalDPMwithMax)
colnames(AranDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(AranDealData, AranDealData$R4>0)

AranRR <- AranDealData[151:676, ]
DPM12338$Aran[3] <- sum((AranRR$Deal))

Aran40s <-  AranDealData[151:1011, ]
DPM12338$Aran[4] <- sum((Aran40s$Deal))

