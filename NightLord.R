## NightLord - Data
## NightLord - VMatrix
PasSkills <- c("QuadrapleThrow", "SuddenRaid", "MarkofNightLord", "DarkFlare", "Showdown", "FourSeasons")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 5, 5, 5)
ActSkills <- c("SpreadThrow", "ThrowingKnife", "SecretBook", "ThrowBlasting", 
               "UltimateDarkSight", "ReadyToDie", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 5, 5)
UsefulSkills <- c("CombatOrders", "SharpEyes")
UsefulLvs <- c(20, 20)
UsefulMP <- c(0, 0)

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
NightLordCore <- list(PassiveCore, ActiveCore, UsefulCore)


## NightLord - Basic Info
NightLordClass1 <- ChrInfo[10, 2]
NightLordClass2 <- ChrInfo[10, 3]
NightLordMainStatType <- ChrInfo[10, 4]
NightLordSubStat1Type <- ChrInfo[10, 5]
NightLordChrLv <- ChrInfo[10, 7]
NightLordUnionLv <- ChrInfo[10, 8]
NightLordArcaneForce <- ChrInfo[10, 9]
NightLordCharisma <- ChrInfo[10, 10]
NightLordInsight <- ChrInfo[10, 11]
NightLordSensibility <- ChrInfo[10, 12]
NightLordBaseMastery <- ChrInfo[10, 13]
NightLordCRROver <- F
NightLordBuffDurationNeeded <- ceiling((171 / 110 - 1)*100)

NightLordAbility <- Abilities(c("BDR", "BuffDuration"), c("L", "E"))

NightLordLinkBase <- rbind(LinkBase)
NightLordDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(NightLordDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(NightLordDisorder==T, 6, 0)+ifelse(NightLordChrLv>MobLv, 6, 0), 0, 0, 0)
NightLordLinkBase <- rbind(LinkBase, Mikhail, DemonAvenger, Phantom, Zero) ## Cygnus Check Needed
NightLordLinkBase <- data.frame(NightLordLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(NightLordLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(NightLordLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(NightLordLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeL22) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", "AR")[, 1:16], SubWeapon[11, ], Emblem[1, ])
rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem")
colnames(Weapon) <- SubWeaponOption
Weapon <- data.frame(Weapon)
Weapon <- WeaponAddpotential(Weapon, c("U", "U", "U"), c("A", "A", "O"))
FlameJavelin <- c(0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
Weapon <- rbind(Weapon, FlameJavelin)
rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem", "FlameJavelin")

Item <- rbind(SpecSet1, SetOption(SpecSet1, "AR"), PetSetOption(c("D", "D", "D")))
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
NightLordSpec <- data.frame(t(rep(0, 21)))
colnames(NightLordSpec) <- Specs

NightLordSpec$SkillLv <- sum(NightLordCore[[3]][, 1]=="CombatOrders")
NightLordSpec$PSkillLv <- sum(NightLordCore[[3]][, 1]=="CombatOrders") + NightLordAbility$PassiveLv
NightLordSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100


## NightLord - Passive
{option <- factor("MainStat", levels=PSkill)
value <- c(20)
NimbleBody <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(50, 5)
CriticalThrow <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("FDR", levels=PSkill)
value <- c(25)
ExpertJavelin <- data.frame(option, value)

option <- factor("CDMR", levels=PSkill)
value <- c(10)
Adrenaline <- data.frame(option, value)

option <- factor(c("ATK", "IGR"), levels=PSkill)
value <- c(40 + NightLordSpec$PSkillLv, 30 + NightLordSpec$PSkillLv)
DarkSerenity <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(NightLordSpec$PSkillLv/2), 30 + NightLordSpec$PSkillLv, 15 + floor(NightLordSpec$PSkillLv/3))
JavelinExpert <- data.frame(option, value)

option <- factor("BDR", levels=PSkill)
value <- c(10 + ceiling(NightLordSpec$PSkillLv/3))
PurgeArea <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(NightLordCore[[2]][6, 2])
ReadyToDie <- data.frame(option, value)}

NightLordPassive <- Passive(list(NimbleBody, CriticalThrow, PhysicalTraining, ExpertJavelin, Adrenaline, 
                                 DarkSerenity, JavelinExpert, PurgeArea, ReadyToDie))
NightLordSpec$SummonedDuration <- MonsterLife$SummonedDuration + NightLordPassive$SummonDuration + Union8000Chr$SummonedDuration


## NightLord - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Haste <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBooster <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowPartner <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritJavelin <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(30 + NightLordSpec$SkillLv)
info <- c(40 * (1 + NightLordSpec$SummonedDuration / 100), NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PurgeArea <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((NightLordChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(NightLordSpec$SkillLv/2))))
info <- c(900 + 30 * NightLordSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * NightLordCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * NightLordCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(60)
info <- c(80, 180, 780, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BleedingToxin <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(20 + NightLordCore[[2]][1, 2], 180, 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpreadThrow <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(60, 120, 960, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ThrowBlastingBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(NightLordCore[[2]][5, 2]/5))
info <- c(30, 220 - NightLordCore[[2]][5, 2], 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateDarkSight <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(NightLordCore[[2]][6, 2]/10))
info <- c(30, 90 - floor(NightLordCore[[2]][6, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(NightLordCore[[2]][6, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(NightLordCore[[2]][6, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * NightLordCore[[2]][8, 2]) * MapleSoldier[1, 2]) * NightLordSpec$MainStatP), 5 + floor(NightLordCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

NightLordBuff <- Buff(list(JavelinBooster=JavelinBooster, ShadowPartner=ShadowPartner, SpiritJavelin=SpiritJavelin, PurgeArea=PurgeArea, MapleSoldier=MapleSoldier, 
                           UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, BleedingToxin=BleedingToxin, 
                           SpreadThrow=SpreadThrow, ThrowBlastingBuff=ThrowBlastingBuff, UltimateDarkSight=UltimateDarkSight, ReadyToDie1Stack=ReadyToDie1Stack, 
                           ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : JavelinBooster, ShadowPartner, SpiritJavelin

NightLordAllTimeBuff <- AllTimeBuff(NightLordBuff)


## NightLord - Union & HyperStat & SoulWeapon
NightLordSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + NightLordPassive$CRR + 
  (Union8000Chr$CRR + ifelse(NightLordChrLv>=250, 1, 0)) + NightLordAbility$CRR + NightLordAllTimeBuff$CRR + 5
NightLordSpec$CRR <- ifelse(NightLordCRROver==T, NightLordSpec$CRR, min(NightLordSpec$CRR, 100))
NightLordSpec$BuffDuration <- MonsterLife$BuffDuration + NightLordPassive$BuffDuration + Union8000Chr$BuffDuration + floor(NightLordSensibility/10) + NightLordAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(NightLordUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, NightLordBuffDurationNeeded, NightLordSpec$BuffDuration, NightLordSpec$CRR, NightLordCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, NightLordBuffDurationNeeded - NightLordSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, NightLordBuffDurationNeeded - NightLordSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(NightLordUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## NightLord Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
NightLordSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$LUK + Dopings$MainStat + LinkSet$MainStat + NightLordPassive$MainStat + 
  NightLordAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * NightLordChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * NightLordArcaneForce + Union8000Chr$LUK
NightLordSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$DEX + Dopings$SubStat1 + LinkSet$SubStat1 + NightLordPassive$SubStat1 + 
  NightLordAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$DEX
NightLordSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + NightLordPassive$ATK + Union8000Chr$ATK + NightLordAbility$CRR + 
  NightLordAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
NightLordSpec$ATKP <- sum(Weapon$ATKP) + NightLordPassive$ATKP + NightLordAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
NightLordSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, NightLordPassive$IGR, Union8000Chr$IGR, floor(NightLordCharisma/5)/2, 
  NightLordAllTimeBuff$IGR, HyperStatBase$IGR))
NightLordSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + NightLordPassive$BDR + Union8000Chr$BDR + NightLordAbility$BDR + NightLordAbility$DisorderBDR + 
  NightLordAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
NightLordSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + NightLordPassive$CRR + 
  (Union8000Chr$CRR + ifelse(NightLordChrLv>=250, 1, 0)) + NightLordAbility$CRR + NightLordAllTimeBuff$CRR + 5
NightLordSpec$CRR <- ifelse(NightLordCRROver==T, NightLordSpec$CRR + rowSums(CRRs), min(NightLordSpec$CRR + rowSums(CRRs), 100))
NightLordSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + NightLordPassive$CDMR + NightLordAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
NightLordSpec$FDR <- FDRCalc(c(NightLordPassive$FDR, NightLordAllTimeBuff$FDR, ArcaneForceFDR(NightLordArcaneForce, MapArc), LevelFDR(NightLordChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", "AR")[19]*100-100)))
NightLordSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", "AR")[17] - Dopings$ATKSpeed - NightLordAllTimeBuff$ATKSpeed - NightLordPassive$ATKSpeed, 2)
NightLordSpec$Mastery <- min(NightLordBaseMastery + NightLordPassive$Mastery, 95)
NightLordSpec$BuffDuration <- NightLordSpec$BuffDuration + UnionBase$BuffDuration
NightLordSpec$SummonedDuration <- MonsterLife$SummonedDuration + NightLordPassive$SummonDuration + Union8000Chr$SummonedDuration
NightLordSpec$ImmuneIgnore <- NightLordPassive$ImmuneIgnore + floor(NightLordInsight/10)/2 + NightLordAllTimeBuff$ImmuneIgnore
NightLordSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + NightLordPassive$CoolTimeReset + NightLordAbility$CoolTimeReset
NightLordSpec$CoolReduceP <- Union8000Chr$CoolReduce
NightLordSpec$CoolReduce <- 0
NightLordSpec$Disorder <- max(NightLordLinkBase$Disorder, NightLordPassive$Disorder, NightLordAllTimeBuff$Disorder)
SpreadThrowStems <- 3


## NightLord - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * NightLordCore[[2]][8, 2], 12, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * NightLordCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightLordCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## NightLord - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][1, 2]>=40, 20, 0), 40, 2 * NightLordCore[[1]][1, 2])
info <- c(378 + NightLordSpec$SkillLv * 4, 5, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuadrapleThrow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][1, 2]>=40, 20, 0), 40, 2 * NightLordCore[[1]][1, 2])
info <- c((378 + NightLordSpec$SkillLv * 4) * 0.85, 5 * SpreadThrowStems, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuadrapleThrowSpread <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][2, 2]>=40, 20, 0), 2 * NightLordCore[[1]][2, 2])
info <- c(1150 + NightLordSpec$SkillLv * 15, 3, 900, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SuddenRaid <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][3, 2]>=40, 20, 0), 2 * NightLordCore[[1]][3, 2])
info <- c(60 + NightLordSpec$PSkillLv * 3 + NightLordChrLv, 3 / (1/(0.6 + 0.02 * NightLordSpec$PSkillLv) + 1), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofNightLord <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(NightLordCore[[1]][3, 2]>=40, 20, 0), 2 * NightLordCore[[1]][3, 2])
info <- c(60 + NightLordSpec$PSkillLv * 3 + NightLordChrLv, 45 / (1/(0.6 + 0.02 * NightLordSpec$PSkillLv) + 1), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofNightLordSpread <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * NightLordCore[[2]][2, 2], 5, 480, 180, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThrowingKnife <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=ASkill)
value <- c(30)
info <- c(900 + 36 * NightLordCore[[2]][3, 2], 10, 0, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SecretBookExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(475 + 19 * NightLordCore[[2]][4, 2], 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThrowBlasting <- rbind(data.frame(option, value), info)}

NightLordATK <- Attack(list(QuadrapleThrow=QuadrapleThrow, QuadrapleThrowSpread=QuadrapleThrowSpread, SuddenRaid=SuddenRaid, MarkofNightLord=MarkofNightLord, MarkofNightLordSpread=MarkofNightLordSpread,
                            ThrowingKnife=ThrowingKnife, SecretBookExplosion=SecretBookExplosion, ThrowBlasting=ThrowBlasting,
                            SpiderInMirror=SpiderInMirror))


## NightLord - Summoned
{option <- factor("IGR", "FDR", levels=SSkill)
value <- c(ifelse(NightLordCore[[1]][4, 2]>=40, 20, 0), NightLordCore[[1]][4, 2] * 3)
info <- c(280, 1, 600, 900, 60, 60, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DarkFlare <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=SSkill)
value <- c(30)
info <- c(350 + 14 * NightLordCore[[2]][3, 2], 12, 360, 990, 12, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SecretBook <- rbind(data.frame(option, value), info)}

NightLordSummoned <- Summoned(list(DarkFlare=DarkFlare, SecretBook=SecretBook, SpiderInMirrorStart=SpiderInMirrorStart, 
                                   SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                   SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## NightLord - DealCycle & Deal Calculation
ATKFinal <- data.frame(NightLordATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, NightLordSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)
ATKFinal <- AddATKRateSkills("ShadowPartner", BuffFinal, ATKFinal, c("QuadrapleThrow", "SuddenRaid", "ThrowingKnife", "ThrowBlasting"))

BuffFinal <- data.frame(NightLordBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, NightLordSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(NightLordSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, NightLordSpec$CoolReduceP, NightLordSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * NightLordSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(NightLordBuff))
NightLordDealCycle <- t(rep(0, length(DealCycle)))
colnames(NightLordDealCycle) <- DealCycle

NightLordDealCycle <- DCBuff(NightLordDealCycle, c("JavelinBooster", "ShadowPartner", "SpiritJavelin", "MapleSoldier", 
                                                   "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("SpiderInMirror"), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "DarkFlare", SummonedFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("BleedingToxin", "ThrowBlastingBuff", "MapleWarriors2", "SpreadThrow", "EpicAdventure", "SoulContractLink", "UltimateDarkSight", "ReadyToDie2Stack", 
                                                   "Restraint4", "PurgeArea"), BuffFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 40)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 30)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 11)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", "SuddenRaid", rep("QuadrapleThrow", 11)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 14)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "DarkFlare", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 12)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 8), "SuddenRaid", rep("QuadrapleThrow", 5)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("SoulContractLink"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 6)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 18), "ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 14)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("ReadyToDie2Stack", "EpicAdventure"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("SuddenRaid"), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("ThrowBlastingBuff"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 8)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 12)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 13)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 11), "SuddenRaid", rep("QuadrapleThrow", 3)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "DarkFlare", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 10)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 43), "SuddenRaid"), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("JavelinBooster", "ShadowPartner", "SpiritJavelin", "MapleSoldier", 
                                                   "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("BleedingToxin", "MapleWarriors2", "SpreadThrow", "EpicAdventure", "SoulContractLink", "UltimateDarkSight", "ReadyToDie2Stack", 
                                                   "Restraint4", "PurgeArea"), BuffFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 40)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 13)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "DarkFlare", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 16)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 11)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", "SuddenRaid", rep("QuadrapleThrow", 10)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("ThrowBlastingBuff"), BuffFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 26)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife", rep("QuadrapleThrow", 8), "SuddenRaid", rep("QuadrapleThrow", 5)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("SoulContractLink"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 5)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 19), "ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 13)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "DarkFlare", SummonedFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("ReadyToDie2Stack", "EpicAdventure"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("SuddenRaid"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 10)), ATKFinal)
NightLordDealCycle <- DCSummoned(NightLordDealCycle, "SecretBook", SummonedFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 13)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 13)), ATKFinal)
NightLordDealCycle <- DCBuff(NightLordDealCycle, c("PurgeArea"), BuffFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 11), "SuddenRaid", rep("QuadrapleThrow", 14)), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c("ThrowingKnife"), ATKFinal)
NightLordDealCycle <- DCATK(NightLordDealCycle, c(rep("QuadrapleThrow", 39), "SuddenRaid"), ATKFinal)

NightLordDealCycle <- DealCycleFinal(NightLordDealCycle)
NightLordDealCycle <- RepATKCycle(NightLordDealCycle, c("ThrowingKnife"), 12, 420, ATKFinal)
NightLordDealCycle <- SecretBookCycle(NightLordDealCycle, SummonedFinal)
NightLordDealCycle <- ThrowBlastingCycle(NightLordDealCycle)
NightLordDealCycle <- AddATKsCycleNightLord(NightLordDealCycle)
NightLordDealCycle <- DCSummonedATKs(NightLordDealCycle, Skill=c("DarkFlare"), SummonedFinal)
NightLordDealCycle <- DCSpiderInMirror(NightLordDealCycle, SummonedFinal)
NightLordDealCycleReduction <- DealCycleReduction(NightLordDealCycle)

DealCalc(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpec)

NightLordSpecOpt1 <- Optimization1(NightLordDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightLordSpec, UnionRemained)
NightLordSpecOpt <- NightLordSpec
NightLordSpecOpt$ATKP <- NightLordSpecOpt$ATKP + NightLordSpecOpt1$ATKP
NightLordSpecOpt$BDR <- NightLordSpecOpt$BDR + NightLordSpecOpt1$BDR
NightLordSpecOpt$IGR <- IGRCalc(c(NightLordSpecOpt$IGR, NightLordSpecOpt1$IGR))

NightLordSpecOpt2 <- Optimization2(NightLordDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt, HyperStatBase, NightLordChrLv, NightLordCRROver)
NightLordFinalDPM <- DealCalc(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt2)
NightLordFinalDPMwithMax <- DealCalcWithMaxDMR(NightLordDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightLordSpecOpt2)

DPMTver$NightLord[1] <- sum(na.omit(NightLordFinalDPMwithMax)) / (361740 / 60000)
DPMTver$NightLord[2] <- sum(na.omit(NightLordFinalDPM)) / (361740 / 60000) - sum(na.omit(NightLordFinalDPMwithMax)) / (361740 / 60000)

NightLordDealData <- data.frame(NightLordDealCycle$Skills, NightLordDealCycle$Time, NightLordDealCycle$Restraint4, NightLordFinalDPMwithMax)
colnames(NightLordDealData) <- c("Skills", "Time", "R4", "Deal")

NightLordRR <- NightLordDealData[31:365, ]
sum((NightLordRR$Deal)) ## 6,451,217,719,327

NightLord40s <- NightLordDealData[31:656, ]
sum((NightLord40s$Deal)) ## 9,360,504,390,231

DealRatio(NightLordDealCycle, NightLordFinalDPMwithMax)