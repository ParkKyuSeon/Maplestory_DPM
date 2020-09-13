## Mechanic - Data
## Mechanic - VMatrix
PasSkills <- c("MassiveFire", "HomingMissile", "DistortionField", "RM7", "RM1", "MagneticField")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 10, 10, 10)
ActSkills <- c("MultipleOption", "MicroMissileContainer", "MetalArmorFullburst", "MechCarrier", 
               "LoadedDice", "ResistanceLineInfantry", "OverDrive", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 0, 5, 5, 5, 0)
UsefulSkills <- c("CombatOrders", "SharpEyes")
UsefulLvs <- c(20, 20)
UsefulMP <- c(0, 0) ## SpiderInMirror DealRatio Check

CoreNumbers <- ceiling(sum(PasLvs) / 75) + length(ActSkills) + length(UsefulSkills)
if(CoreNumbers > Cores) {warning("Invalid Input")}

MPs <- ceiling(sum(PasMP) / 15) * 5 + sum(ActMP)
if(MPs > MatrixPoints) {warning("Invalid Input")}

PassiveCore <- data.frame(PasSkills, PasLvs + PasMP)
colnames(PassiveCore) <- c("Passive", "Levels")

ActiveCore <- data.frame(ActSkills, ActLvs + ActMP)
colnames(ActiveCore) <- c("Active", "Levels")

UsefulCore <- data.frame(UsefulSkills, UsefulLvs + UsefulMP)
colnames(UsefulCore) <- c("Useful", "Levels")
MechanicCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Mechanic - Basic Info
MechanicClass1 <- ChrInfo[31, 2]
MechanicClass2 <- ChrInfo[31, 3]
MechanicMainStatType <- ChrInfo[31, 4]
MechanicSubStat1Type <- ChrInfo[31, 5]
MechanicChrLv <- ChrInfo[31, 7]
MechanicUnionLv <- ChrInfo[31, 8]
MechanicArcaneForce <- ChrInfo[31, 9]
MechanicCharisma <- ChrInfo[31, 10]
MechanicInsight <- ChrInfo[31, 11]
MechanicSensibility <- ChrInfo[31, 12]
MechanicBaseMastery <- ChrInfo[31, 13]
MechanicCRROver <- F
MechanicBuffDurationNeeded <- 0

MechanicAbility <- Abilities(c("PassiveLv", "DisorderBDR"), c("L", "E"))

MechanicLinkBase <- rbind(LinkBase)
MechanicDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(MechanicDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(MechanicDisorder==T, 6, 0)+ifelse(MechanicChrLv>MobLv, 6, 0), 0, 0, 0)
MechanicLinkBase <- rbind(LinkBase, DemonAvenger, Hoyeong, Zero, CygnusKnights) ## Check Needed
MechanicLinkBase <- data.frame(MechanicLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(MechanicLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(MechanicLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(MechanicLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeD22) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Gun", "AR")[, 1:16], SubWeapon[29, ], Emblem[4, ])
rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem")
colnames(Weapon) <- SubWeaponOption
Weapon <- data.frame(Weapon)
Weapon <- WeaponAddpotential(Weapon, c("U", "U", "U"), c("A", "A", "O"))

MechanicParts <- c(0, 10, 10, 5, 300, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) ## Engine Upgrade ATK + 9

Item <- rbind(SpecSet2, SetOption(SpecSet2, "AR"), PetSetOption(c("D", "D", "D")), MechanicParts)
ItemSet <- c()
for(i in c(2:10, 17:19)) {
  ItemSet[i] <- sum(Item[, i])
}
ItemSet[16] <- IGRCalc(Item[, 16])
ItemSet <- data.frame(t(ItemSet))
colnames(ItemSet) <- colnames(Item)
rownames(ItemSet) <- c("Item")

Specs <- c("MainStat", "SubStat1", "ATK", "ATKP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
           "SummonedDuration", "ImmuneIgnore", "CoolTimeReset", "SkillLv", "PSkillLv", "CoolReduceP", "CoolReduce", "Disorder", "MainStatP")
MechanicSpec <- data.frame(t(rep(0, 21)))
colnames(MechanicSpec) <- Specs

MechanicSpec$SkillLv <- sum(MechanicCore[[3]][, 1]=="CombatOrders")
MechanicSpec$PSkillLv <- sum(MechanicCore[[3]][, 1]=="CombatOrders") + MechanicAbility$PassiveLv
MechanicSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100 
MechanicSpec$CoolReduce <- 2
MechanicSpec$CoolReduceP <- Union8000Chr$CoolReduce


## Mechanic - Passive
{option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
HiddenPiece <- data.frame(option, value)

option <- factor(c("ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(20, 10, 5)
MechanicMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(30)
MetalArmorTank <- data.frame(option, value)

option <- factor(c("FDR", "CRR", "IGR"), levels=PSkill)
value <- c(20, 20, 30)
OverTuning <- data.frame(option, value)

option <- factor(c("Mastery", "ATK"), levels=PSkill)
value <- c(70 + ceiling(MechanicSpec$PSkillLv/2), 55 + MechanicSpec$PSkillLv)
MetalArmorExtreme <- data.frame(option, value)

option <- factor(c("BDR", "SummonDuration"), levels=PSkill)
value <- c((7 + ceiling(MechanicSpec$PSkillLv/5)) * 3, 40 + MechanicSpec$PSkillLv)
RobotMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + MechanicCore[[2]][5, 2])
LoadedDice <- data.frame(option, value)}

MechanicPassive <- Passive(list(HiddenPiece=HiddenPiece, MechanicMastery=MechanicMastery, PhysicalTraining=PhysicalTraining, MetalArmorTank=MetalArmorTank, 
                                OverTuning=OverTuning, MetalArmorExtreme=MetalArmorExtreme, RobotMastery=RobotMastery, LoadedDice=LoadedDice))

MechanicSpec$SummonedDuration <- MonsterLife$SummonedDuration + MechanicPassive$SummonDuration + Union8000Chr$SummonedDuration


## Mechanic - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MechanicBooster <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(15 + ceiling(MechanicSpec$PSkillLv/2))
info <- c(80 * (100 + MechanicSpec$SummonedDuration) / 100, NA, 630, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SupportWaiver <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c((7 + ceiling(MechanicSpec$PSkillLv/5)))
info <- c(30 * (100 + MechanicSpec$SummonedDuration) / 100, 60, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RM1Buff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(300 * (100 + MechanicSpec$SummonedDuration) / 100, 0, 1260, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OpenGate <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c((7 + ceiling(MechanicSpec$PSkillLv/5)))
info <- c(70, 200, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MechCarrierBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c((7 + ceiling(MechanicSpec$PSkillLv/5)))
info <- c(75 + 2 * MechanicCore[[2]][1, 2], 200, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MultipleOptionBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MechanicChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MechanicSpec$SkillLv/2))))
info <- c(900 + 30 * MechanicSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 1800, 2040, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(30)
info <- c(180, 1800, 2040, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice55 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(180, 1800, 2040, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice555 <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(10, 100, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BomberTime <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WillofLiberty <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * MechanicCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MechanicCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(10, 200, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MetalArmorFullburstBuff <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(2, 200, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MetalArmorFullburstExhaust <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * MechanicCore[[2]][7, 2]) * 216))
info <- c(30, 70 - floor(MechanicCore[[2]][7, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * 216))
info <- c(Cooldown(70 - floor(MechanicCore[[2]][7, 2]/5), T, MechanicSpec$CoolReduceP, MechanicSpec$CoolReduce) - 30 - ServerLag, 70 - floor(MechanicCore[[2]][7, 2]/5), 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * MechanicCore[[2]][8, 2]) * MapleSoldier[1, 2]) * MechanicSpec$MainStatP), 5 + floor(MechanicCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

MechanicBuff <- Buff(list(MechanicBooster=MechanicBooster, SupportWaiver=SupportWaiver, RM1Buff=RM1Buff, OpenGate=OpenGate, MechCarrierBuff=MechCarrierBuff, 
                          MultipleOptionBuff=MultipleOptionBuff, MapleSoldier=MapleSoldier, LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, 
                          LuckyDice555=LuckyDice555, BomberTime=BomberTime, WillofLiberty=WillofLiberty, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                          MetalArmorFullburstBuff=MetalArmorFullburstBuff, MetalArmorFullburstExhaust=MetalArmorFullburstExhaust, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, MapleWarriors2=MapleWarriors2,
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MechanicBooster, MapleSoldier
MechanicAllTimeBuff <- AllTimeBuff(MechanicBuff)


## Mechanic - Union & HyperStat & SoulWeapon
MechanicSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + MechanicPassive$CRR + 
  (Union8000Chr$CRR) + MechanicAbility$CRR + MechanicAllTimeBuff$CRR + 5
MechanicSpec$CRR <- ifelse(MechanicCRROver==T, MechanicSpec$CRR, min(MechanicSpec$CRR, 100))
MechanicSpec$BuffDuration <- MonsterLife$BuffDuration + MechanicPassive$BuffDuration + Union8000Chr$BuffDuration + floor(MechanicSensibility/10) + MechanicAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(MechanicUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, MechanicBuffDurationNeeded, MechanicSpec$BuffDuration, MechanicSpec$CRR, MechanicCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, MechanicBuffDurationNeeded - MechanicSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, MechanicBuffDurationNeeded - MechanicSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(MechanicUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
  UnionBase$SubStat2 / 5 - UnionBase$ATK - UnionBase$Stance

HyperStatBase <- data.frame(t(c(0, 0, 0, 10, 10, 10, ifelse(CRRs$Hyper<=5, CRRs$Hyper, 5+(CRRs$Hyper-5)/2), 10, 0)))
colnames(HyperStatBase) <- colnames(HyperStats)[2:10]
HyperSP <- 0
for(i in 1:9) {
  lvs <- HyperStatBase[1, i]
  HyperStatBase[1, i] <- ifelse(lvs==0, 0, sum(HyperStats[1:lvs, i+1]))
  HyperSP <- HyperSP + ifelse(lvs==0, 0, sum(HyperStats[1:lvs, 1]))
}

SoulWeaponOptions <- c("ATK", "ATKP", "CRR")
SoulWeapon <- data.frame(t(c(20, ifelse(CRRs[1, 3]==0, 3, 0), ifelse(CRRs[1, 3]==12, 12, 0))))
colnames(SoulWeapon) <- SoulWeaponOptions


## Mechanic Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
MechanicSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$DEX + Dopings$MainStat + LinkSet$MainStat + MechanicPassive$MainStat + 
  MechanicAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * MechanicChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP + MechanicPassive$MainStatP) / 100) + 10 * MechanicArcaneForce + Union8000Chr$DEX
MechanicSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$STR + Dopings$SubStat1 + LinkSet$SubStat1 + MechanicPassive$SubStat1 + 
  MechanicAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$STR
MechanicSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + MechanicPassive$ATK + Union8000Chr$ATK + MechanicAbility$CRR + 
  MechanicAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
MechanicSpec$ATKP <- sum(Weapon$ATKP) + MechanicPassive$ATKP + MechanicAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
MechanicSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, MechanicPassive$IGR, Union8000Chr$IGR, floor(MechanicCharisma/5)/2, 
  MechanicAllTimeBuff$IGR, HyperStatBase$IGR))
MechanicSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + MechanicPassive$BDR + Union8000Chr$BDR + MechanicAbility$BDR + MechanicAbility$DisorderBDR + 
  MechanicAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
MechanicSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + MechanicPassive$CRR + 
  (Union8000Chr$CRR + ifelse(MechanicChrLv>=250, 1, 0)) + MechanicAbility$CRR + MechanicAllTimeBuff$CRR + 5
MechanicSpec$CRR <- ifelse(MechanicCRROver==T, MechanicSpec$CRR + rowSums(CRRs), min(MechanicSpec$CRR + rowSums(CRRs), 100))
MechanicSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + MechanicPassive$CDMR + MechanicAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
MechanicSpec$FDR <- FDRCalc(c(MechanicPassive$FDR, MechanicAllTimeBuff$FDR, ArcaneForceFDR(MechanicArcaneForce, MapArc), LevelFDR(MechanicChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Gun", "AR")[19]*100-100)))
MechanicSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Gun", "AR")[17] - Dopings$ATKSpeed - MechanicAllTimeBuff$ATKSpeed - MechanicPassive$ATKSpeed, 2)
MechanicSpec$Mastery <- min(MechanicBaseMastery + MechanicPassive$Mastery, 95)
MechanicSpec$BuffDuration <- MechanicSpec$BuffDuration + UnionBase$BuffDuration + 5
MechanicSpec$ImmuneIgnore <- MechanicPassive$ImmuneIgnore + floor(MechanicInsight/10)/2 + MechanicAllTimeBuff$ImmuneIgnore
MechanicSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + MechanicPassive$CoolTimeReset + MechanicAbility$CoolTimeReset
MechanicSpec$Disorder <- max(MechanicLinkBase$Disorder, MechanicPassive$Disorder, MechanicAllTimeBuff$Disorder)


## Mechanic - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MechanicCore[[2]][9, 2], 12, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * MechanicCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MechanicCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MechanicCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MechanicCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MechanicCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Mechanic - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][1, 2]>=40, 20, 0), 10, 2 * MechanicCore[[1]][1, 2])
info <- c(285 + 6 * MechanicSpec$SkillLv, 7, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MassiveFire <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][1, 2]>=40, 20, 0), 10, 2 * MechanicCore[[1]][1, 2])
info <- c(350 + 10 * MechanicSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MassiveFireExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][5, 2]>=40, 20, 0), FDRCalc(c(2 * MechanicCore[[1]][5, 2], 105 + 3 * MechanicSpec$PSkillLv)))
info <- c(500 + 5 * MechanicSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RM1Explosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][2, 2]>=40, 20, 0), 2 * MechanicCore[[1]][2, 2])
info <- c(300, 9 + MechanicSpec$PSkillLv, 780, NA, NA, NA, NA, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HomingMissile <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][2, 2]>=40, 20, 0), 2 * MechanicCore[[1]][2, 2])
info <- c(300, 10, 780, NA, NA, NA, NA, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HomingMissileBomberTime <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][2, 2]>=40, 20, 0), 2 * MechanicCore[[1]][2, 2])
info <- c(300, 7, 780, 600, NA, NA, NA, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HomingMissileMetalArmorFullBust <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MechanicCore[[1]][3, 2]>=40, 20, 0), 2 * MechanicCore[[1]][3, 2])
info <- c(350, 2, 900, 250, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DistortionField <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 10 * MechanicCore[[2]][1, 2], 8, 0, NA, 200, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MultipleOptionMissile <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(425 + 17 * MechanicCore[[2]][2, 2], 5, 540, 30, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MicroMissileContainer <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1380, 0, 200, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MetalArmorFullburstPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * MechanicCore[[2]][3, 2], 11, 10000, 210, 200, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MetalArmorFullburst <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1800, 0, 200, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MetalArmorFullburstEnd <- rbind(data.frame(option, value), info)}

MechanicATK <- Attack(list(MassiveFire=MassiveFire, MassiveFireExplosion=MassiveFireExplosion, RM1Explosion=RM1Explosion, HomingMissile=HomingMissile, HomingMissileBomberTime=HomingMissileBomberTime, 
                           HomingMissileMetalArmorFullBust=HomingMissileMetalArmorFullBust, DistortionField=DistortionField, MultipleOptionMissile=MultipleOptionMissile, 
                           MicroMissileContainer=MicroMissileContainer, MetalArmorFullburstPre=MetalArmorFullburstPre, MetalArmorFullburst=MetalArmorFullburst, MetalArmorFullburstEnd=MetalArmorFullburstEnd,
                           SpiderInMirror=SpiderInMirror))


## Mechanic - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * MechanicCore[[2]][6, 2], 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(MechanicCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * MechanicCore[[1]][4, 2], 105 + 3 * MechanicSpec$PSkillLv)))
info <- c(385 + 4 * MechanicSpec$PSkillLv, 1, 630, 1000, 60, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
RM7 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(MechanicCore[[1]][5, 2]>=40, 20, 0), FDRCalc(c(2 * MechanicCore[[1]][5, 2], 105 + 3 * MechanicSpec$PSkillLv)))
info <- c(500 + 5 * MechanicSpec$SkillLv, 3, 630, 3000, 30, 60, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
RM1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=SSkill)
value <- c(105 + 3 * MechanicSpec$PSkillLv)
info <- c(200 + 8 * MechanicCore[[2]][1, 2], 6, 780, 1500, 75 + 2 * MechanicCore[[2]][1, 2], 200, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
MultipleOptionGetling <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(250 + 10 * MechanicCore[[2]][4, 2], 4, 720, 4000, 70, 200, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
MechCarrier <- rbind(data.frame(option, value), info)}

MechanicSummoned <- Summoned(list(ResistanceLineInfantry=ResistanceLineInfantry, RM7=RM7, RM1=RM1, MultipleOptionGetling=MultipleOptionGetling, MechCarrier=MechCarrier,
                                  SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Mechanic - DealCycle & Deal Calculation
ATKFinal <- data.frame(MechanicATK)
ATKFinal$Delay[c(-10, -11, -12)] <- Delay(ATKFinal$Delay, MechanicSpec$ATKSpeed)[c(-10, -11, -12)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MechanicSpec$CoolReduceP, MechanicSpec$CoolReduce)

BuffFinal <- data.frame(MechanicBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MechanicSpec$CoolReduceP, MechanicSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MechanicSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(MechanicSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MechanicSpec$CoolReduceP, MechanicSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MechanicSpec$SummonedDuration / 100, 0)
SummonedFinal$Duration[4] <- MultipleOptionTime(SummonedFinal$Duration[4])

DealCycle <- c("Skills", "Time", rownames(MechanicBuff))
MechanicDealCycle <- t(rep(0, length(DealCycle)))
colnames(MechanicDealCycle) <- DealCycle

MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MechanicBooster", "MapleSoldier", "SupportWaiver", "OpenGate", "LuckyDice5",
                                                 "UsefulSharpEyes", "UsefulCombatOrders", "WillofLiberty"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("SpiderInMirror"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MultipleOptionBuff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("MultipleOptionGetling"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive", "MapleWarriors2", "MechCarrierBuff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("MechCarrier"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SoulContractLink"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("BomberTime", "Restraint4"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburstPre"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MetalArmorFullburstBuff"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburst"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MetalArmorFullburstExhaust"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburstEnd"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MassiveFire", "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 5), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 6), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField", "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "DistortionField", rep("MassiveFire", 13)), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("WillofLiberty", "RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SupportWaiver"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SoulContractLink", "BomberTime"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 6), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 5), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MassiveFire"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10)), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 2), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 4), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 7), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MechanicBooster", "SupportWaiver", "LuckyDice5"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "WillofLiberty"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MultipleOptionBuff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("MultipleOptionGetling"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MapleWarriors2", "MechCarrierBuff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("MechCarrier"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SoulContractLink"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("BomberTime", "Restraint4"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburstPre"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MetalArmorFullburstBuff"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburst"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("MetalArmorFullburstExhaust"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MetalArmorFullburstEnd"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MassiveFire", "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 5), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 6), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField", "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "DistortionField", rep("MassiveFire", 13)), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("WillofLiberty", "RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SupportWaiver"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("SoulContractLink", "BomberTime"), BuffFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 6), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 5), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MassiveFire"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10)), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c("DistortionField"), ATKFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("OverDrive"), BuffFinal)
MechanicDealCycle <- DCBuff(MechanicDealCycle, c("RM1Buff"), BuffFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("RM1"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 10), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 9), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 2), "DistortionField", rep("MassiveFire", 13), "DistortionField", rep("MassiveFire", 13), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 4), "MicroMissileContainer"), ATKFinal)
MechanicDealCycle <- DCSummoned(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 7), "DistortionField"), ATKFinal)
MechanicDealCycle <- DCATK(MechanicDealCycle, c(rep("MassiveFire", 13), "DistortionField"), ATKFinal)

MechanicDealCycle <- DealCycleFinal(MechanicDealCycle)
MechanicDealCycle <- OverDriveExhaustBuff(MechanicDealCycle, BuffFinal$Duration[17], BuffFinal$CoolTime[17])
MechanicDealCycle <- DCSummonedATKs(MechanicDealCycle, c("RM7"), SummonedFinal)
MechanicDealCycle <- RM1Cycle(MechanicDealCycle, SummonedFinal$Duration[3], SummonedFinal$CoolTime[3], SummonedFinal)
MechanicDealCycle <- DCSummonedATKs(MechanicDealCycle, c("ResistanceLineInfantry"), SummonedFinal)
MechanicDealCycle <- RepATKCycle(MechanicDealCycle, c("MetalArmorFullburst"), 49, 0, ATKFinal)
MechanicDealCycle <- RepATKCycle(MechanicDealCycle, c("MicroMissileContainer"), 30 + floor(MechanicCore[[2]][2, 2]/3), 1440, ATKFinal)
MechanicDealCycle <- RepATKCycle(MechanicDealCycle, c("DistortionField"), 15, 0, ATKFinal)
MechanicDealCycle <- MultipleOptionCycle(MechanicDealCycle, SummonedFinal)
MechanicDealCycle <- MechCarrierCycle(MechanicDealCycle, SummonedFinal)
MechanicDealCycle <- DCSpiderInMirror(MechanicDealCycle, SummonedFinal)
MechanicDealCycle <- MechanicAddATKCycle(MechanicDealCycle, ATKFinal)
MechanicDealCycleReduction <- DealCycleReduction(MechanicDealCycle)

sum(na.omit(LuckyDiceDealCalc(MechanicDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MechanicSpec, LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))))
sum(na.omit(LuckyDiceDealCalcWithMaxDMR(MechanicDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MechanicSpec, LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))))

MechanicSpecOpt1 <- LuckyDiceOptimization1(MechanicDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MechanicSpec, UnionRemained, LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))
MechanicSpecOpt <- MechanicSpec
MechanicSpecOpt$ATKP <- MechanicSpecOpt$ATKP + MechanicSpecOpt1$ATKP
MechanicSpecOpt$BDR <- MechanicSpecOpt$BDR + MechanicSpecOpt1$BDR
MechanicSpecOpt$IGR <- IGRCalc(c(MechanicSpecOpt$IGR, MechanicSpecOpt1$IGR))

MechanicSpecOpt2 <- LuckyDiceOptimization2(MechanicDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MechanicSpecOpt, HyperStatBase, MechanicChrLv, MechanicCRROver, 
                                           LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))
MechanicFinalDPM <- LuckyDiceDealCalc(MechanicDealCycle, ATKFinal, BuffFinal, SummonedFinal, MechanicSpecOpt2, LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))
MechanicFinalDPMwithMax <- LuckyDiceDealCalcWithMaxDMR(MechanicDealCycle, ATKFinal, BuffFinal, SummonedFinal, MechanicSpecOpt2, LuckyDiceProb=c(0.721368012, 0.268516988, 0.010115))

DPMTver$Mechanic[1] <- sum(na.omit(MechanicFinalDPMwithMax)) / (404180 / 60000)
DPMTver$Mechanic[2] <- sum(na.omit(MechanicFinalDPM)) / (404180 / 60000) - sum(na.omit(MechanicFinalDPMwithMax)) / (404180 / 60000)

MechanicDealData <- data.frame(MechanicDealCycle$Skills, MechanicDealCycle$Time, MechanicDealCycle$Restraint4, 
                               LuckyDiceDealCalcWithMaxDMR(MechanicDealCycle, ATKFinal, BuffFinal, SummonedFinal, MechanicSpecOpt2, LuckyDiceProb=c(1, 0, 0)))
colnames(MechanicDealData) <- c("Skills", "Time", "R4", "Deal")

MechanicRR <- MechanicDealData[49:298, ]
sum((MechanicRR$Deal)) ## 3,444,683,404,196

Mechanic40s <-  MechanicDealData[34:651, ]
sum((Mechanic40s$Deal)) ## 5,505,711,601,591

DealRatio(MechanicDealCycle, MechanicFinalDPMwithMax)