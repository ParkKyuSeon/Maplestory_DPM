## DualBlade - Data
## DualBlade - VMatrix
PasSkills <- c("PhantomBlow", "HiddenBlade", "Asura", "BladeFury", "SuddenRaid", "BladeAscension")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 5, 5, 5)
ActSkills <- c("BladeStorm", "KarmaFury", "BladeTornado", "HuntedEdge", 
               "ReadyToDie", "UltimateDarkSight", "MapleWarriors2", "SpiderInMirror")
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
DualBladeCore <- list(PassiveCore, ActiveCore, UsefulCore)


## DualBlade - Basic Info
DualBladeClass1 <- ChrInfo[12, 2]
DualBladeClass2 <- ChrInfo[12, 3]
DualBladeMainStatType <- ChrInfo[12, 4]
DualBladeSubStat1Type <- ChrInfo[12, 5]
DualBladeSubStat2Type <- ChrInfo[12, 6]
DualBladeChrLv <- ChrInfo[12, 7]
DualBladeUnionLv <- ChrInfo[12, 8]
DualBladeArcaneForce <- ChrInfo[12, 9]
DualBladeCharisma <- ChrInfo[12, 10]
DualBladeInsight <- ChrInfo[12, 11]
DualBladeSensibility <- ChrInfo[12, 12]
DualBladeBaseMastery <- ChrInfo[12, 13]
DualBladeCRROver <- F
DualBladeBuffDurationNeeded <- 0

DualBladeAbility <- Abilities(c("BDR", "DisorderBDR"), c("L", "E"))

DualBladeLinkBase <- rbind(LinkBase)
DualBladeDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(DualBladeDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(DualBladeDisorder==T, 6, 0)+ifelse(DualBladeChrLv>MobLv, 6, 0), 0, 0, 0)
DualBladeLinkBase <- rbind(LinkBase, DemonAvenger, Phantom, Zero, Cygnus)
DualBladeLinkBase <- data.frame(DualBladeLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(DualBladeLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(DualBladeLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(DualBladeLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeL21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", "AR")[, 1:16], BladeUpgrade(1, 17, "AB"), Emblem[1, ])
rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem")
colnames(Weapon) <- SubWeaponOption
Weapon <- data.frame(Weapon)
Weapon <- WeaponAddpotential(Weapon, c("U", "U", "U"), c("A", "A", "O"))

Item <- rbind(SpecSet2, SetOption(SpecSet2, "AR"), PetSetOption(c("D", "D", "D")))
ItemSet <- c()
for(i in c(2:10, 17:19)) {
  ItemSet[i] <- sum(Item[, i])
}
ItemSet[16] <- IGRCalc(Item[, 16])
ItemSet <- data.frame(t(ItemSet))
colnames(ItemSet) <- colnames(Item)
rownames(ItemSet) <- c("Item")

Specs <- c("MainStat", "SubStat1", "SubStat2", "ATK", "ATKP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
           "SummonedDuration", "ImmuneIgnore", "CoolTimeReset", "SkillLv", "PSkillLv", "CoolReduceP", "CoolReduce", "Disorder", "MainStatP")
DualBladeSpec <- data.frame(t(rep(0, 22)))
colnames(DualBladeSpec) <- Specs

DualBladeSpec$SkillLv <- sum(DualBladeCore[[3]][, 1]=="CombatOrders")
DualBladeSpec$PSkillLv <- sum(DualBladeCore[[3]][, 1]=="CombatOrders") + DualBladeAbility$PassiveLv
DualBladeSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100
DualBladeSpec$CoolReduce <- 2


## DualBlade - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Karma <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + DualBladeSpec$PSkillLv)
ThornsEffect <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(35 + 3 * DualBladeSpec$PSkillLv, 13 + DualBladeSpec$PSkillLv)
Sharpness <- data.frame(option, value)

option <- factor(c("ATK", "Mastery", "FDR"), levels=PSkill)
value <- c(30 + DualBladeSpec$PSkillLv, 70 + ceiling(DualBladeSpec$PSkillLv/2), 20 + floor(DualBladeSpec$PSkillLv/2))
DualBladeExpert <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(DualBladeCore[[2]][5, 2])
ReadyToDie <- data.frame(option, value)}

DualBladePassive <- Passive(list(Karma=Karma, PhysicalTraining=PhysicalTraining, ThornsEffect=ThornsEffect, Sharpness=Sharpness, DualBladeExpert=DualBladeExpert, ReadyToDie=ReadyToDie))


## DualBlade - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DualBladeBooster <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MirrorImaging <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(40 + DualBladeSpec$SkillLv)
info <- c(60, 60, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalCutBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((DualBladeChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(DualBladeSpec$SkillLv/2))))
info <- c(900 + 30 * DualBladeSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "AddATKSkill"), levels=BSkill)
value <- c(10, 1)
info <- c(60, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HiddenBladeBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * DualBladeCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * DualBladeCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(DualBladeCore[[2]][5, 2]/5))
info <- c(30, 220 - DualBladeCore[[2]][5, 2], 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UltimateDarkSight <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(DualBladeCore[[2]][6, 2]/10))
info <- c(30, 90 - floor(DualBladeCore[[2]][6, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(DualBladeCore[[2]][6, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(DualBladeCore[[2]][6, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * DualBladeCore[[2]][8, 2]) * MapleSoldier[1, 2]) * DualBladeSpec$MainStatP), 5 + floor(DualBladeCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

DualBladeBuff <- Buff(list(DualBladeBooster=DualBladeBooster, MirrorImaging=MirrorImaging, FinalCutBuff=FinalCutBuff, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, 
                           HiddenBladeBuff=HiddenBladeBuff, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UltimateDarkSight=UltimateDarkSight, 
                           ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : DualBladeBooster, MirrorImaging, MapleSoldier
DualBladeAllTimeBuff <- AllTimeBuff(DualBladeBuff)


## DualBlade - Union & HyperStat & SoulWeapon
DualBladeSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + DualBladePassive$CRR + 
  (Union8000Chr$CRR) + DualBladeAbility$CRR + DualBladeAllTimeBuff$CRR + 5
DualBladeSpec$BuffDuration <- MonsterLife$BuffDuration + DualBladePassive$BuffDuration + Union8000Chr$BuffDuration + floor(DualBladeSensibility/10) + DualBladeAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(DualBladeUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, DualBladeBuffDurationNeeded, DualBladeSpec$BuffDuration, DualBladeSpec$CRR, DualBladeCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, DualBladeBuffDurationNeeded - DualBladeSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, min(DualBladeBuffDurationNeeded - DualBladeSpec$BuffDuration, 40)), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(DualBladeUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## DualBlade Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
DualBladeSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$LUK + Dopings$MainStat + LinkSet$MainStat + DualBladePassive$MainStat + 
  DualBladeAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * DualBladeChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * DualBladeArcaneForce + Union8000Chr$LUK + 20
DualBladeSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$DEX + Dopings$SubStat1 + LinkSet$SubStat1 + DualBladePassive$SubStat1 + 
  DualBladeAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$DEX
DualBladeSpec$SubStat2 <- floor((sum(Weapon$SubStat2) + ItemSet$SubStat2 + MonsterLife$STR + Dopings$SubStat2 + LinkSet$SubStat2 + DualBladePassive$SubStat2 + 
  DualBladeAllTimeBuff$SubStat2 + CommonSkillSet$SubStat2 + UnionBase$SubStat2 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$STR
DualBladeSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + DualBladePassive$ATK + Union8000Chr$ATK + DualBladeAbility$CRR + 
  DualBladeAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
DualBladeSpec$ATKP <- sum(Weapon$ATKP) + DualBladePassive$ATKP + DualBladeAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
DualBladeSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, DualBladePassive$IGR, Union8000Chr$IGR, floor(DualBladeCharisma/5)/2, 
  DualBladeAllTimeBuff$IGR, HyperStatBase$IGR))
DualBladeSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + DualBladePassive$BDR + Union8000Chr$BDR + DualBladeAbility$BDR + DualBladeAbility$DisorderBDR + 
  DualBladeAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
DualBladeSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + DualBladePassive$CRR + 
  (Union8000Chr$CRR + ifelse(DualBladeChrLv>=250, 1, 0)) + DualBladeAbility$CRR + DualBladeAllTimeBuff$CRR + 5
DualBladeSpec$CRR <- ifelse(DualBladeCRROver==T, DualBladeSpec$CRR + rowSums(CRRs), min(DualBladeSpec$CRR + rowSums(CRRs), 100))
DualBladeSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + DualBladePassive$CDMR + DualBladeAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
DualBladeSpec$FDR <- FDRCalc(c(DualBladePassive$FDR, DualBladeAllTimeBuff$FDR, ArcaneForceFDR(DualBladeArcaneForce, MapArc), LevelFDR(DualBladeChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", "AR")[19]*100-100)))
DualBladeSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Dagger", "AR")[17] - Dopings$ATKSpeed - DualBladeAllTimeBuff$ATKSpeed - DualBladePassive$ATKSpeed, 2)
DualBladeSpec$Mastery <- min(DualBladeBaseMastery + DualBladePassive$Mastery, 95)
DualBladeSpec$BuffDuration <- DualBladeSpec$BuffDuration + UnionBase$BuffDuration
DualBladeSpec$SummonedDuration <- MonsterLife$SummonedDuration + DualBladePassive$SummonDuration + Union8000Chr$SummonedDuration
DualBladeSpec$ImmuneIgnore <- DualBladePassive$ImmuneIgnore + floor(DualBladeInsight/10)/2 + DualBladeAllTimeBuff$ImmuneIgnore
DualBladeSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + DualBladePassive$CoolTimeReset + DualBladeAbility$CoolTimeReset
DualBladeSpec$CoolReduceP <- Union8000Chr$CoolReduce
DualBladeSpec$Disorder <- max(DualBladeLinkBase$Disorder, DualBladePassive$Disorder, DualBladeAllTimeBuff$Disorder)


## DualBlade - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * DualBladeCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * DualBladeCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * DualBladeCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * DualBladeCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * DualBladeCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * DualBladeCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## DualBlade - Attacks
{option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * DualBladeCore[[1]][1, 2], 20, IGRCalc(c(ifelse(DualBladeCore[[1]][1, 2]>=40, 20, 0), 50 + DualBladeSpec$SkillLv)))
info <- c(315 + 3 * DualBladeSpec$SkillLv, 7, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PhantomBlow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1000, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCutPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(2000 + 20 * DualBladeSpec$SkillLv, 1, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCut <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * DualBladeCore[[1]][5, 2], ifelse(DualBladeCore[[1]][1, 2]>=40, 20, 0))
info <- c(1150 + 15 * DualBladeSpec$SkillLv, 3, 900, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SuddenRaid <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * DualBladeCore[[1]][2, 2], ifelse(DualBladeCore[[1]][2, 2]>=40, 20, 0))
info <- c(140, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HiddenBlade <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 900, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AsuraPre <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * DualBladeCore[[1]][3, 2], 100)
info <- c(420, 4, 8100, 300, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Asura <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AsuraEnd <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(580 + 23 * DualBladeCore[[2]][1, 2], 7, 120, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStormPre <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(350 + 10 * DualBladeCore[[2]][1, 2], 5, 10000, 210, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStorm <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 120, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeStormEnd <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(30)
info <- c(400 + 16 * DualBladeCore[[2]][2, 2], 7, 990, 180, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
KarmaFury <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(600 + 24 * DualBladeCore[[2]][3, 2], 7, 0, NA, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeTornadoPre <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(400 + 16 * DualBladeCore[[2]][3, 2], 6, 720, 120, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BladeTornado <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(30)
info <- c(200 + 8 * DualBladeCore[[2]][4, 2], 4, 0, 90, 14, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HuntedEdge <- rbind(data.frame(option, value), info)}

DualBladeATK <- Attack(list(PhantomBlow=PhantomBlow, FinalCutPre=FinalCutPre, FinalCut=FinalCut, SuddenRaid=SuddenRaid, HiddenBlade=HiddenBlade, AsuraPre=AsuraPre, Asura=Asura, AsuraEnd=AsuraEnd, 
                            BladeStormPre=BladeStormPre, BladeStorm=BladeStorm, BladeStormEnd=BladeStormEnd, KarmaFury=KarmaFury, BladeTornadoPre=BladeTornadoPre, BladeTornado=BladeTornado, HuntedEdge=HuntedEdge,
                            SpiderInMirror=SpiderInMirror))


## DualBlade - Summoned
DualBladeSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart,
                                   SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                   SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## DualBlade - DealCycle
ATKFinal <- data.frame(DualBladeATK)
ATKFinal$Delay[c(-2, -6, -7, -8, -9, -10, -11)] <- Delay(ATKFinal$Delay, DualBladeSpec$ATKSpeed)[c(-2, -6, -7, -8, -9, -10, -11)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)
ATKFinal <- AddATKRateSkills("ShadowPartner", BuffFinal, ATKFinal, c("PhantomBlow", "FinalCut", "SuddenRaid", "Asura", "BladeStormPre", "BladeStorm", "KarmaFury", "BladeTornadoPre", "BladeTornado", "HuntedEdge"))

BuffFinal <- data.frame(DualBladeBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, DualBladeSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(DualBladeSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, DualBladeSpec$CoolReduceP, DualBladeSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * DualBladeSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(DualBladeBuff))
DualBladeDealCycle <- t(rep(0, length(DealCycle)))
colnames(DualBladeDealCycle) <- DealCycle

DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("DualBladeBooster", "MirrorImaging", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCutPre"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("FinalCutBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCut"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SuddenRaid"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SpiderInMirror"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("EpicAdventure", "HiddenBladeBuff", "MapleWarriors2", "SoulContractLink", "ReadyToDie2Stack", "UltimateDarkSight", "Restraint4"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("BladeTornadoPre", "BladeTornado", "KarmaFury", "BladeStormPre", "BladeStorm", "BladeStormEnd", "KarmaFury", 
                                                  "BladeTornadoPre", "BladeTornado", "AsuraPre", "Asura", "AsuraEnd", "BladeTornadoPre", "BladeTornado", "KarmaFury", "SuddenRaid"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", rep("PhantomBlow", 2), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 12), "KarmaFury", rep("PhantomBlow", 4), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 10), "KarmaFury", rep("PhantomBlow", 6), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 8), "KarmaFury", "FinalCutPre"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("FinalCutBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCut", rep("PhantomBlow", 6), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SuddenRaid", rep("PhantomBlow", 5), "KarmaFury", rep("PhantomBlow", 10), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 4), "KarmaFury", rep("PhantomBlow", 8)), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("EpicAdventure", "SoulContractLink", "ReadyToDie2Stack"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("BladeTornadoPre", "BladeTornado", "PhantomBlow", "PhantomBlow", "KarmaFury", "BladeStormPre", "BladeStorm", "BladeStormEnd", "KarmaFury", 
                                                  "BladeTornadoPre", "BladeTornado", "AsuraPre", "Asura", "AsuraEnd", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("HiddenBladeBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("KarmaFury"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SuddenRaid"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", rep("PhantomBlow", 2), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 12), "KarmaFury", "FinalCutPre"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("FinalCutBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCut", "PhantomBlow", "SuddenRaid", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 10), "KarmaFury", rep("PhantomBlow", 6), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 8), "KarmaFury", rep("PhantomBlow", 8), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 6), "KarmaFury"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("DualBladeBooster", "MirrorImaging", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SuddenRaid"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("EpicAdventure", "MapleWarriors2", "SoulContractLink", "ReadyToDie2Stack", "UltimateDarkSight", "Restraint4"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("BladeTornadoPre", "BladeTornado", "KarmaFury", "BladeStormPre", "BladeStorm", "BladeStormEnd", "KarmaFury", 
                                                  "BladeTornadoPre", "BladeTornado", "AsuraPre", "Asura", "AsuraEnd", "BladeTornadoPre", "BladeTornado", "KarmaFury"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 15), "KarmaFury", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", rep("PhantomBlow", 2), "BladeTornadoPre", "BladeTornado", "FinalCutPre"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("FinalCutBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCut", "SuddenRaid", rep("PhantomBlow", 9), "KarmaFury", rep("PhantomBlow", 4), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 10), "KarmaFury"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("HiddenBladeBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 6), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 8), "KarmaFury", rep("PhantomBlow", 8), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 6), "KarmaFury", "SuddenRaid"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 9), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 4), "KarmaFury", rep("PhantomBlow", 12), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("EpicAdventure", "SoulContractLink", "ReadyToDie2Stack"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("KarmaFury", "BladeStormPre", "BladeStorm", "BladeStormEnd", "KarmaFury", 
                                                  "BladeTornadoPre", "BladeTornado", "AsuraPre", "Asura", "AsuraEnd", "BladeTornadoPre", "BladeTornado", "KarmaFury", "FinalCutPre"), ATKFinal)
DualBladeDealCycle <- DCBuff(DualBladeDealCycle, c("FinalCutBuff"), BuffFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("FinalCut", "SuddenRaid", rep("PhantomBlow", 12), "KarmaFury", "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 14), "KarmaFury", rep("PhantomBlow", 2), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 12), "KarmaFury", rep("PhantomBlow", 4), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c("SuddenRaid", rep("PhantomBlow", 9), "KarmaFury", rep("PhantomBlow", 6), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 8), "KarmaFury", rep("PhantomBlow", 8), "BladeTornadoPre", "BladeTornado"), ATKFinal)
DualBladeDealCycle <- DCATK(DualBladeDealCycle, c(rep("PhantomBlow", 6), "KarmaFury", rep("PhantomBlow", 5)), ATKFinal)

DualBladeDealCycle <- DealCycleFinal(DualBladeDealCycle)
DualBladeDealCycle <- HuntedEdgeCycle(DualBladeDealCycle, ATKFinal$CoolTime[15] * 1000)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "HuntedEdge", 5, 30, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "KarmaFury", 5, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "BladeTornado", 5, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "Asura", 28, 0, ATKFinal)
DualBladeDealCycle <- RepATKCycle(DualBladeDealCycle, "BladeStorm", 48, 0, ATKFinal)
DualBladeDealCycle <- AddATKCycleDualBlade(DualBladeDealCycle)
DualBladeDealCycle <- DCSpiderInMirror(DualBladeDealCycle, SummonedFinal)
DualBladeDealCycleReduction <- DealCycleReduction(DualBladeDealCycle)

sum(na.omit(DealCalc(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpec)))

DualBladeSpecOpt1 <- Optimization1(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpec, UnionRemained)
DualBladeSpecOpt <- DualBladeSpec
DualBladeSpecOpt$ATKP <- DualBladeSpecOpt$ATKP + DualBladeSpecOpt1$ATKP
DualBladeSpecOpt$BDR <- DualBladeSpecOpt$BDR + DualBladeSpecOpt1$BDR
DualBladeSpecOpt$IGR <- IGRCalc(c(DualBladeSpecOpt$IGR, DualBladeSpecOpt1$IGR))

DualBladeSpecOpt2 <- Optimization2(DualBladeDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt, HyperStatBase, DualBladeChrLv, DualBladeCRROver, HyperStanceLv=4)
DualBladeFinalDPM <- DealCalc(DualBladeDealCycle, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt2)
DualBladeFinalDPMwithMax <- DealCalcWithMaxDMR(DualBladeDealCycle, ATKFinal, BuffFinal, SummonedFinal, DualBladeSpecOpt2)

DPM12338$DualBlader[1] <- sum(na.omit(DualBladeFinalDPMwithMax)) / (360690 / 60000)
DPM12338$DualBlader[2] <- sum(na.omit(DualBladeFinalDPM)) / (360690 / 60000) - sum(na.omit(DualBladeFinalDPMwithMax)) / (360690 / 60000)

DualBladeDealData <- data.frame(DualBladeDealCycle$Skills, DualBladeDealCycle$Time, DualBladeDealCycle$Restraint4, DualBladeFinalDPMwithMax)
colnames(DualBladeDealData) <- c("Skills", "Time", "R4", "Deal")

DualBladeRR <- DualBladeDealData[25:270, ]
DPM12338$DualBlader[3] <- sum((DualBladeRR$Deal)) ## 4003515655234

DualBlade40s <- DualBladeDealData[25:535, ]
DPM12338$DualBlader[4] <- sum((DualBlade40s$Deal)) ## 5988177534483

DealRatio(DualBladeDealCycle, DualBladeFinalDPMwithMax)