## ArchmageFP - Data
## ArchmageFP - VMatrix
PasSkills <- c("Paralyze", "FlameHaze", "MistEruption", "FireAura", "Meteor", "Ignite")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 10, 10, 10)
ActSkills <- c("DotPunisher", "PoisonNova", "FuryofIfrit", "PosionChain", 
               "OverloadMana", "EtherealForm", "UnstableMemorize", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 1, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 0, 5, 5, 0)
UsefulSkills <- c("CombatOrders", "SharpEyes", "WindBooster")
UsefulLvs <- c(20, 20, 20)
UsefulMP <- c(0, 0, 0)

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
ArchmageFPCore <- list(PassiveCore, ActiveCore, UsefulCore)


## ArchmageFP - Basic Info
ArchmageFPClass1 <- ChrInfo[4, 2]
ArchmageFPClass2 <- ChrInfo[4, 3]
ArchmageFPMainStatType <- ChrInfo[4, 4]
ArchmageFPSubStat1Type <- ChrInfo[4, 5]
ArchmageFPChrLv <- ChrInfo[4, 7]
ArchmageFPUnionLv <- ChrInfo[4, 8]
ArchmageFPArcaneForce <- ChrInfo[4, 9]
ArchmageFPCharisma <- ChrInfo[4, 10]
ArchmageFPInsight <- ChrInfo[4, 11]
ArchmageFPSensibility <- ChrInfo[4, 12]
ArchmageFPBaseMastery <- ChrInfo[4, 13]
ArchmageFPCRROver <- F
ArchmageFPBuffDurationNeeded <- 310

ArchmageFPAbility <- Abilities(c("BuffDuration", "DisorderBDR"), c("L", "E"))

ArchmageFPLinkBase <- rbind(LinkBase)
ArchmageFPDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(ArchmageFPDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(ArchmageFPDisorder==T, 6, 0)+ifelse(ArchmageFPChrLv>MobLv, 6, 0), 0, 0, 0)
ArchmageFPLinkBase <- rbind(LinkBase, Mikhail, DemonAvenger, Phantom, AdventureBowman)
ArchmageFPLinkBase <- data.frame(ArchmageFPLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(ArchmageFPLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(ArchmageFPLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(ArchmageFPLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeI21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", "AR")[, 1:16], SubWeapon[6, ], Emblem[1, ])
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

Specs <- c("MainStat", "SubStat1", "ATK", "ATKP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
           "SummonedDuration", "ImmuneIgnore", "CoolTimeReset", "SkillLv", "PSkillLv", "CoolReduceP", "CoolReduce", "Disorder", "MainStatP")
ArchmageFPSpec <- data.frame(t(rep(0, 21)))
colnames(ArchmageFPSpec) <- Specs

ArchmageFPSpec$SkillLv <- sum(ArchmageFPCore[[3]][, 1]=="CombatOrders")
ArchmageFPSpec$PSkillLv <- sum(ArchmageFPCore[[3]][, 1]=="CombatOrders") + ArchmageFPAbility$PassiveLv
ArchmageFPSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100
ArchmageFPSpec$CoolReduce <- 2
ArchmageFPSpec$CoolReduceP <- Union8000Chr$CoolReduce


## ArchmageFP - Passive
{option <- factor(c("CRR"), levels=PSkill)
value <- c(5)
MPIncrease <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(40)
ElementalReset <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(50)
ElementAmplification <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(20)
ExtremeMagic <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(25)
FerventDrain <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * ArchmageFPSpec$SkillLv, 50 + 5 * ArchmageFPSpec$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(ArchmageFPSpec$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70)
Ifrit <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(ArchmageFPCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only

option <- factor(c("MainStat"), levels=PSkill)
value <- c(ArchmageFPCore[[2]][7, 2])
UnstableMemorize <- data.frame(option, value)}

ArchmageFPPassive <- Passive(list(MPIncrease=MPIncrease, HighWisdom=HighWisdom, SpellMastery=SpellMastery, ElementalReset=ElementalReset, ElementAmplification=ElementAmplification, 
                                  MagicCritical=MagicCritical, ExtremeMagic=ExtremeMagic, FerventDrain=FerventDrain, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, 
                                  Ifrit=Ifrit, OverloadMana=OverloadMana, UnstableMemorize=UnstableMemorize))


## ArchmageFP - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Meditation <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalReset <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(Cooldown(45, T, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce), Cooldown(45, T, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce), 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MeteorBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + ArchmageFPSpec$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ArchmageFPChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ArchmageFPSpec$SkillLv/2))))
info <- c(900 + 30 * ArchmageFPSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(2400, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FireAura <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * ArchmageFPCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ArchmageFPCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * ArchmageFPCore[[3]][3, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][2, 2], 20000, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyesPart <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][1, 2], 20000, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrdersPart <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][3, 2], 20000, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBoosterPart <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * ArchmageFPCore[[2]][7, 2]) * MapleSoldier[1, 2]) * ArchmageFPSpec$MainStatP), 5 + floor(ArchmageFPCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ArchmageFPBuff <- Buff(list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, MeteorBuff=MeteorBuff, Infinity=Infinity, 
                            MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, FireAura=FireAura, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                            UsefulWindBooster=UsefulWindBooster, UsefulSharpEyesPart=UsefulSharpEyesPart, UsefulCombatOrdersPart=UsefulCombatOrdersPart, UsefulWindBoosterPart=UsefulWindBoosterPart, 
                            MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MagicBooster, Meditation, ElementalReset
ArchmageFPAllTimeBuff <- AllTimeBuff(ArchmageFPBuff)


## ArchmageFP - Union & HyperStat & SoulWeapon
ArchmageFPSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + ArchmageFPPassive$CRR + 
  (Union8000Chr$CRR) + ArchmageFPAbility$CRR + ArchmageFPAllTimeBuff$CRR + 5
ArchmageFPSpec$BuffDuration <- MonsterLife$BuffDuration + ArchmageFPPassive$BuffDuration + Union8000Chr$BuffDuration + floor(ArchmageFPSensibility/10) + ArchmageFPAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(ArchmageFPUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, ArchmageFPBuffDurationNeeded, ArchmageFPSpec$BuffDuration, ArchmageFPSpec$CRR, ArchmageFPCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, ArchmageFPBuffDurationNeeded - ArchmageFPSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, min(ArchmageFPBuffDurationNeeded - ArchmageFPSpec$BuffDuration, 40)), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(ArchmageFPUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## ArchmageFP Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
ArchmageFPSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$INT + Dopings$MainStat + LinkSet$MainStat + ArchmageFPPassive$MainStat + 
  ArchmageFPAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * ArchmageFPChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * ArchmageFPArcaneForce + Union8000Chr$INT
ArchmageFPSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$LUK + Dopings$SubStat1 + LinkSet$SubStat1 + ArchmageFPPassive$SubStat1 + 
  ArchmageFPAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$LUK
ArchmageFPSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + ArchmageFPPassive$ATK + Union8000Chr$ATK + ArchmageFPAbility$CRR + 
  ArchmageFPAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
ArchmageFPSpec$ATKP <- sum(Weapon$ATKP) + ArchmageFPPassive$ATKP + ArchmageFPAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
ArchmageFPSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, ArchmageFPPassive$IGR, Union8000Chr$IGR, floor(ArchmageFPCharisma/5)/2, 
  ArchmageFPAllTimeBuff$IGR, HyperStatBase$IGR))
ArchmageFPSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + ArchmageFPPassive$BDR + Union8000Chr$BDR + ArchmageFPAbility$BDR + ArchmageFPAbility$DisorderBDR + 
  ArchmageFPAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
ArchmageFPSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + ArchmageFPPassive$CRR + 
  (Union8000Chr$CRR + ifelse(ArchmageFPChrLv>=250, 1, 0)) + ArchmageFPAbility$CRR + ArchmageFPAllTimeBuff$CRR + 5
ArchmageFPSpec$CRR <- ifelse(ArchmageFPCRROver==T, ArchmageFPSpec$CRR + rowSums(CRRs), min(ArchmageFPSpec$CRR + rowSums(CRRs), 100))
ArchmageFPSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + ArchmageFPPassive$CDMR + ArchmageFPAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
ArchmageFPSpec$FDR <- FDRCalc(c(ArchmageFPPassive$FDR, ArchmageFPAllTimeBuff$FDR, ArcaneForceFDR(ArchmageFPArcaneForce, MapArc), LevelFDR(ArchmageFPChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", "AR")[19]*100-100), 20))
ArchmageFPSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", "AR")[17] - Dopings$ATKSpeed - ArchmageFPAllTimeBuff$ATKSpeed - ArchmageFPPassive$ATKSpeed, 2)
ArchmageFPSpec$Mastery <- min(ArchmageFPBaseMastery + ArchmageFPPassive$Mastery, 95)
ArchmageFPSpec$BuffDuration <- ArchmageFPSpec$BuffDuration + UnionBase$BuffDuration
ArchmageFPSpec$SummonedDuration <- MonsterLife$SummonedDuration + ArchmageFPPassive$SummonDuration + Union8000Chr$SummonedDuration
ArchmageFPSpec$ImmuneIgnore <- ArchmageFPPassive$ImmuneIgnore + floor(ArchmageFPInsight/10)/2 + ArchmageFPAllTimeBuff$ImmuneIgnore
ArchmageFPSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + ArchmageFPPassive$CoolTimeReset + ArchmageFPAbility$CoolTimeReset
ArchmageFPSpec$Disorder <- max(ArchmageFPLinkBase$Disorder, ArchmageFPPassive$Disorder, ArchmageFPAllTimeBuff$Disorder)


## ArchmageFP - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * ArchmageFPCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * ArchmageFPCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchmageFPCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchmageFPCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchmageFPCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * ArchmageFPCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## ArchmageFP - Unstable Memorize Data
Skills <- c("EnergyBolt", "FlameOrb", "PoisonBreath", "Explosion", "PosionMist", "UnstableFail", 
            "Paralyze", "MistEruption", "Meteor", "FlameHaze", "Infinity", "Ifrit", "MegiddoFlame", "EpicAdventure")
Ind <- c(1, 5, 5, 10, 10, 10, 25, 25, 25, 25, 25, 25, 25, 10)
Prob <- Ind/sum(Ind)
Delays <- c(Delay(810, 2), Delay(810, 2), Delay(800, 2), Delay(720, 2), Delay(1500, 2), Delay(990, 2), 
            Delay(780, 2), Delay(930, 2), Delay(900, 2), Delay(1440, 2), 600, 600, Delay(900, 2), 0)
ArchmageFPUnstable <- data.frame(Skills, Ind, Prob, Delays)
MeteorFinalATKProb <- sum(ArchmageFPUnstable$Prob[c(1, 2, 3, 4, 5, 7, 8, 9, 10, 13)]) * (0.6 + 0.02 * ArchmageFPSpec$SkillLv)
IgniteUnsProb <- (sum(ArchmageFPUnstable$Prob[c(2, 4, 7, 9, 10, 13)])) * 0.5



## ArchmageFP - Attacks
{option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(309, ArchmageFPUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(301, 2 * ArchmageFPUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameOrbUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(180, ArchmageFPUnstable[3, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonBreathUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(405, 2 * ArchmageFPUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExplosionUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(270, ArchmageFPUnstable[5, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonMistUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][1, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), 10, ifelse(ArchmageFPCore[[1]][1, 2]>=40, 20, 0))
info <- c(220 + 3 * ArchmageFPSpec$SkillLv, 8 * ArchmageFPUnstable[7, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ParalyzeUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][3, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), 10, IGRCalc(c(ifelse(ArchmageFPCore[[1]][3, 2]>=40, 20, 0), 60 + ArchmageFPSpec$SkillLv)))
info <- c((45 + ArchmageFPSpec$SkillLv) * 2.25, 60 * ArchmageFPUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MistEruptionUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][5, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(315 + 3 * ArchmageFPSpec$SkillLv, 12 * ArchmageFPUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][2, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchmageFPCore[[1]][2, 2]>=40, 20, 0))
info <- c(202 + 3 * ArchmageFPSpec$SkillLv, 15 * ArchmageFPUnstable[10, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameHazeUnstable <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(420, 15 * ArchmageFPUnstable[13, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlameUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][1, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), 10, ifelse(ArchmageFPCore[[1]][1, 2]>=40, 20, 0))
info <- c(220 + 3 * ArchmageFPSpec$SkillLv, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Paralyze <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][6, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), 10, IGRCalc(c(ifelse(ArchmageFPCore[[1]][3, 2]>=40, 20, 0), 60 + ArchmageFPSpec$SkillLv)))
info <- c((45 + ArchmageFPSpec$SkillLv) * 2.25, 60, 930, NA, 8 * (1 - 0.5 - ArchmageFPSpec$CoolReduceP/100), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MistEruption <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][5, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(315 + 3 * ArchmageFPSpec$SkillLv, 12, 900, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Meteor <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchmageFPCore[[1]][5, 2], ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchmageFPSpec$SkillLv, 0.6 + 0.02 * ArchmageFPSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchmageFPCore[[1]][5, 2], ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchmageFPSpec$SkillLv, MeteorFinalATKProb, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchmageFPCore[[1]][5, 2], ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchmageFPSpec$SkillLv, ifelse(BossSize=="Scarecrow", 4, 12) * (0.6 + 0.02 * ArchmageFPSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackPoisonNova <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchmageFPCore[[1]][5, 2], ifelse(ArchmageFPCore[[1]][5, 2]>=40, 20, 0))
info <- c(220 + 4 * ArchmageFPSpec$SkillLv, 22 * (0.6 + 0.02 * ArchmageFPSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttackDotPunisher <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * ArchmageFPCore[[1]][2, 2], floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)), ifelse(ArchmageFPCore[[1]][2, 2]>=40, 20, 0))
info <- c(202 + 3 * ArchmageFPSpec$SkillLv, 15, 1440, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameHaze <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(272, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TeleportMastery <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(420, 15, 900, NA, 50, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlame <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ignite <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, IgniteUnsProb * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, (ArchmageFPSpec$SkillLv * 0.02 + 0.6) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteMeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, MeteorFinalATKProb * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteUnstableFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 22 * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteDotPunisher <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, 22 * (ArchmageFPSpec$SkillLv * 0.02 + 0.6) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteDotPunisherFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * ArchmageFPCore[[1]][6, 2], ifelse(ArchmageFPCore[[1]][6, 2]>=40, 20, 0))
info <- c(40, (ifelse(BossSize=="Scarecrow", 4, 12) * (ArchmageFPSpec$SkillLv * 0.02 + 0.6)) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgnitePoisonNova <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * ArchmageFPCore[[1]][4, 2], ifelse(ArchmageFPCore[[1]][4, 2]>=40, 20, 0))
info <- c(400, 2, 0, 3000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FireAura <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(400 + 15 * ArchmageFPCore[[2]][1, 2], 5, 900, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisher1st <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c((400 + 15 * ArchmageFPCore[[2]][1, 2]) * 0.65, 5 * 21, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisherRemain <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(250 + 10 * ArchmageFPCore[[2]][2, 2], 12, 750, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaStart <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(225 + 9 * ArchmageFPCore[[2]][2, 2], 36, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNova123 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c((225 + 9 * ArchmageFPCore[[2]][2, 2]) * 0.5, ifelse(BossSize=="Scarecrow", 12, 108), 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaRemain <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * ArchmageFPCore[[2]][3, 2], 6, 480, 180, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuryofIfrit <- rbind(data.frame(option, value), info) # FuryofIfrit StartDelay : 1560ms

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(300 + 12 * ArchmageFPCore[[2]][4, 2], 4, 0, NA, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 6 * ArchmageFPCore[[2]][4, 2], 6, 780, 1800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 1 * (30 + ArchmageFPCore[[2]][4, 2]) + 6 * ArchmageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 2 * (30 + ArchmageFPCore[[2]][4, 2]) + 6 * ArchmageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain3 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 3 * (30 + ArchmageFPCore[[2]][4, 2]) + 6 * ArchmageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain4 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 4 * (30 + ArchmageFPCore[[2]][4, 2]) + 6 * ArchmageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain5 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(ArchmageFPCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 5 * (30 + ArchmageFPCore[[2]][4, 2]) + 6 * ArchmageFPCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainMax <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizePre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, sum(ArchmageFPUnstable$Prob * ArchmageFPUnstable$Delay), NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizeEnd <- rbind(data.frame(option, value), info)}

ArchmageFPATK <- Attack(list(EnergyBoltUnstable=EnergyBoltUnstable, FlameOrbUnstable=FlameOrbUnstable, PoisonBreathUnstable=PoisonBreathUnstable, ExplosionUnstable=ExplosionUnstable, 
                             PoisonMistUnstable=PoisonMistUnstable, ParalyzeUnstable=ParalyzeUnstable, MistEruptionUnstable=MistEruptionUnstable, MeteorUnstable=MeteorUnstable, 
                             FlameHazeUnstable=FlameHazeUnstable, MegiddoFlameUnstable=MegiddoFlameUnstable, TeleportMastery=TeleportMastery,
                             Paralyze=Paralyze, MistEruption=MistEruption, Meteor=Meteor, MeteorFinalAttack=MeteorFinalAttack, MeteorFinalAttackUnstable=MeteorFinalAttackUnstable,
                             MeteorFinalAttackPoisonNova=MeteorFinalAttackPoisonNova, MeteorFinalAttackDotPunisher=MeteorFinalAttackDotPunisher,
                             FlameHaze=FlameHaze, MegiddoFlame=MegiddoFlame, Ignite=Ignite, IgniteUnstable=IgniteUnstable, IgniteDotPunisher=IgniteDotPunisher, 
                             IgniteDotPunisherFinalAttack=IgniteDotPunisherFinalAttack, IgnitePoisonNova=IgnitePoisonNova, IgniteUnstableFinalAttack=IgniteUnstableFinalAttack, 
                             IgniteMeteorFinalAttack=IgniteMeteorFinalAttack, FireAura=FireAura, DotPunisher1st=DotPunisher1st, DotPunisherRemain=DotPunisherRemain, 
                             PoisonNovaStart=PoisonNovaStart, PoisonNova123=PoisonNova123, PoisonNovaRemain=PoisonNovaRemain, FuryofIfrit=FuryofIfrit,
                             PoisonChainPre=PoisonChainPre, PoisonChain1=PoisonChain1, PoisonChain2=PoisonChain2, PoisonChain3=PoisonChain3, PoisonChain4=PoisonChain4, 
                             PoisonChain5=PoisonChain5, PoisonChainMax=PoisonChainMax, UnstableMemorizePre=UnstableMemorizePre, UnstableMemorizeEnd=UnstableMemorizeEnd,
                             SpiderInMirror=SpiderInMirror))


## ArchmageFP - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(150 + 2 * ArchmageFPSpec$SkillLv, 1, 600, 3030, 260 + 5 * ArchmageFPSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Ifrit <- rbind(data.frame(option, value), info)}

ArchmageFPSummoned <- Summoned(list(Ifrit=Ifrit, SpiderInMirrorStart=SpiderInMirrorStart,
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## ArchmageFP - DealCycle and Deal Calculation
ATKFinal <- data.frame(ArchmageFPATK)
ATKFinal$Delay[c(-34, -42, -43)] <- Delay(ATKFinal$Delay, ArchmageFPSpec$ATKSpeed)[c(-34, -42, -43)]
ATKFinal$CoolTime[-13] <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce)[-13]

BuffFinal <- data.frame(ArchmageFPBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchmageFPSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(ArchmageFPSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArchmageFPSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(ArchmageFPBuff))
ArchmageFPDealCycle <- t(rep(0, length(DealCycle)))
colnames(ArchmageFPDealCycle) <- DealCycle

ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("FireAura", "MagicBooster", "Meditation", "ElementalReset", "MapleSoldier", 
                                                     "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster"), BuffFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor"), ATKFinal)
ArchmageFPDealCycle <- DCSummoned(ArchmageFPDealCycle, "Ifrit", SummonedFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MegiddoFlame"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("EpicAdventure", "SoulContractLink", "Infinity"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChainPre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChain1"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 2), "FuryofIfrit", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChainPre", "PoisonChain1", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MapleWarriors2"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChainPre", "PoisonChain1", "FlameHaze", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MegiddoFlame", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("SpiderInMirror", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChainPre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChain1"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("SoulContractLink"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("Restraint4"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c(rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 2), "PoisonChainPre", "PoisonChain1", "FuryofIfrit", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "Paralyze", "Paralyze", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze", "MistEruption", "MegiddoFlame"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("EpicAdventure"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor"), ATKFinal)                           
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 5), "MistEruption", "UnstableMemorizePre", "UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st", "Paralyze", "MistEruption", "PoisonChainPre", "PoisonChain1"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)


Unsdata <- UnstableData(ArchmageFPDealCycle, ArchmageFPUnstable[11, 3], BuffFinal$Duration[5], BuffFinal$CoolTime[5], BuffFinal$Duration[9])
{option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][2, 2], 20000, 900 * (Unsdata$BuffNeeded / (180 + 3 * ArchmageFPCore[[3]][2, 2])), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyesPart <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][1, 2], 20000, 1500 * (Unsdata$BuffNeeded / (180 + 3 * ArchmageFPCore[[3]][1, 2])), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrdersPart <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * ArchmageFPCore[[3]][3, 2], 20000, 900 * (Unsdata$BuffNeeded / (180 + 3 * ArchmageFPCore[[3]][3, 2])), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBoosterPart <- rbind(data.frame(option, value), info)}

ArchmageFPBuff <- Buff(list(MagicBooster=MagicBooster, Meditation=Meditation, ElementalReset=ElementalReset, MeteorBuff=MeteorBuff, Infinity=Infinity, 
                            MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, FireAura=FireAura, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                            UsefulWindBooster=UsefulWindBooster, UsefulSharpEyesPart=UsefulSharpEyesPart, UsefulCombatOrdersPart=UsefulCombatOrdersPart, UsefulWindBoosterPart=UsefulWindBoosterPart, 
                            MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))

BuffFinal <- data.frame(ArchmageFPBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchmageFPSpec$CoolReduceP, ArchmageFPSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchmageFPSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("Infinity", "UsefulSharpEyesPart", "UsefulCombatOrdersPart", "UsefulWindBoosterPart"), BuffFinal)
ArchmageFPDealCycle <- DCSummoned(ArchmageFPDealCycle, "Ifrit", SummonedFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChainPre"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("PoisonChain1"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MegiddoFlame"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "PoisonChainPre", "PoisonChain1", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "Paralyze", "PoisonChainPre", "PoisonChain1", "Paralyze", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "MegiddoFlame", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3)), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("EpicAdventure"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle <- DCBuff(ArchmageFPDealCycle, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Meteor"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FuryofIfrit", rep("Paralyze", 1), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "PoisonChainPre", "PoisonChain1", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("FlameHaze", "TeleportMastery", "Paralyze", "PoisonNovaStart", "DotPunisher1st", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle <- DCATK(ArchmageFPDealCycle, c("Paralyze"), ATKFinal)

ArchmageFPDealCycle <- DealCycleFinal(ArchmageFPDealCycle)
ArchmageFPDealCycle <- DCSummonedATKs(ArchmageFPDealCycle, "Ifrit", SummonedFinal)
ArchmageFPDealCycle <- FuryofIfritCycle(ArchmageFPDealCycle, ATKFinal)
ArchmageFPDealCycle <- PoisonChainCycle(ArchmageFPDealCycle, ATKFinal)
ArchmageFPDealCycle <- FPUnstableCycle(ArchmageFPDealCycle, ATKFinal)
ArchmageFPDealCycle <- FPAddATKCycle(ArchmageFPDealCycle, ATKFinal)
ArchmageFPDealCycle <- DCSpiderInMirror(ArchmageFPDealCycle, SummonedFinal)
ArchmageFPDealCycle <- RepATKCycle(ArchmageFPDealCycle, "FireAura", 100, 0, ATKFinal)
ArchmageFPDealCycle <- BishopInfinity(ArchmageFPDealCycle, 6000, 70 + ArchmageFPSpec$SkillLv, ServerLag)

DealCycle <- c("Skills", "Time", rownames(ArchmageFPBuff))
ArchmageFPDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(ArchmageFPDealCycle2) <- DealCycle

ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("FireAura", "MagicBooster", "Meditation", "ElementalReset", "MapleSoldier", 
                                                     "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster"), BuffFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Meteor"), ATKFinal)
ArchmageFPDealCycle2 <- DCSummoned(ArchmageFPDealCycle2, "Ifrit", SummonedFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MegiddoFlame"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("EpicAdventure", "SoulContractLink", "Infinity"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChainPre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChain1"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 2), "FuryofIfrit", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChainPre", "PoisonChain1", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Meteor", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MapleWarriors2"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChainPre", "PoisonChain1", "FlameHaze", "Paralyze", "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MegiddoFlame", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Paralyze", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Meteor", "FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChainPre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("PoisonChain1"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("SoulContractLink"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 2), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("Restraint4"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c(rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 2), "PoisonChainPre", "PoisonChain1", "FuryofIfrit", "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "Paralyze", "Paralyze", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Paralyze", "MistEruption", "MegiddoFlame"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("EpicAdventure"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Meteor"), ATKFinal)                           
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Paralyze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", rep("Paralyze", 5), "MistEruption", "UnstableMemorizePre", "UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "PoisonNovaStart", "DotPunisher1st", "Paralyze", "MistEruption", "PoisonChainPre", "PoisonChain1"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze", "TeleportMastery", "Paralyze", "Paralyze"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd", "PoisonNovaStart", "DotPunisher1st"), ATKFinal)
ArchmageFPDealCycle2 <- DCBuff(ArchmageFPDealCycle2, c("MeteorBuff"), BuffFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("Meteor", "MistEruption", "FlameHaze", rep("Paralyze", 3), "MistEruption"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizePre"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
ArchmageFPDealCycle2 <- DCATK(ArchmageFPDealCycle2, c("FlameHaze"), ATKFinal)

ArchmageFPDealCycle2 <- DealCycleFinal(ArchmageFPDealCycle2)
ArchmageFPDealCycle2 <- DCSummonedATKs(ArchmageFPDealCycle2, "Ifrit", SummonedFinal)
ArchmageFPDealCycle2 <- FuryofIfritCycle(ArchmageFPDealCycle2, ATKFinal)
ArchmageFPDealCycle2 <- PoisonChainCycle(ArchmageFPDealCycle2, ATKFinal)
ArchmageFPDealCycle2 <- FPUnstableCycle(ArchmageFPDealCycle2, ATKFinal)
ArchmageFPDealCycle2 <- FPAddATKCycle(ArchmageFPDealCycle2, ATKFinal)
ArchmageFPDealCycle2 <- RepATKCycle(ArchmageFPDealCycle2, "FireAura", 70, 0, ATKFinal)
ArchmageFPDealCycle2 <- BishopInfinity(ArchmageFPDealCycle2, 6000, 70 + ArchmageFPSpec$SkillLv, ServerLag)


## ArchmageFP Deal Calc
BishopDealCalc(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpec, Unsdata)
BishopDealCalcWithMaxDMR(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpec, Unsdata)

ArchmageFPSpecOpt1 <- BishopOptimization1(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpec, UnionRemained, Unsdata)
ArchmageFPSpecOpt <- ArchmageFPSpec
ArchmageFPSpecOpt$ATKP <- ArchmageFPSpecOpt$ATKP + ArchmageFPSpecOpt1$ATKP
ArchmageFPSpecOpt$BDR <- ArchmageFPSpecOpt$BDR + ArchmageFPSpecOpt1$BDR
ArchmageFPSpecOpt$IGR <- IGRCalc(c(ArchmageFPSpecOpt$IGR, ArchmageFPSpecOpt1$IGR))

ArchmageFPSpecOpt2 <- BishopOptimization2(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpecOpt, HyperStatBase, ArchmageFPChrLv, ArchmageFPCRROver, Unsdata)
ArchmageFPFinalDPM <- BishopDealCalc(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpecOpt2, Unsdata)
ArchmageFPFinalDPMwithMax <- BishopDealCalcWithMaxDMR(ArchmageFPDealCycle, ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpecOpt2, Unsdata)

DPM12338$ArchMageFP[1] <- sum(na.omit(ArchmageFPFinalDPMwithMax)) / (218671.2 / 60000)
DPM12338$ArchMageFP[2] <- sum(na.omit(ArchmageFPFinalDPM)) / (218671.2 / 60000) - sum(na.omit(ArchmageFPFinalDPMwithMax)) / (218671.2 / 60000)

ArchmageFPDamage <- BishopDealCalcGeneral(ArchmageFPDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpecOpt2)
ArchmageFP40s <- data.frame(ArchmageFPDealCycle$Skills, ArchmageFPDealCycle$Time, ArchmageFPDealCycle$Restraint4, ArchmageFPDealCycle$Infinity, ArchmageFPDealCycle$InfinityFDR, ArchmageFPDamage)
colnames(ArchmageFP40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")

DPM12338$ArchMageFP[3] <- sum(ArchmageFP40s$Damage[1510:1796]) ## 3803325307364
DPM12338$ArchMageFP[4] <- sum(ArchmageFP40s$Damage[1168:1803]) ## 6724137302925

ArchmageFPDamage2 <- BishopDealCalcGeneral(ArchmageFPDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArchmageFPSpecOpt2)

FPDealRatio <- BishopDealRatio(ArchmageFPDealCycle, ArchmageFPDealCycle2, ArchmageFPDamage, ArchmageFPDamage2, UnsData)