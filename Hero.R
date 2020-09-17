## Hero - Data
## Hero - VMatrix
PasSkills <- c("RagingBlow", "RageUprising", "AdvancedFinalAttack", "Incising", "Panic")
PasLvs <- c(50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 10, 10)
ActSkills <- c("SwordofBurningSoul", "ComboDeathfault", "ComboInstinct", "SwordIllusion", 
               "AuraWeapon", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 5)
UsefulSkills <- c("WindBooster", "CombatOrders", "SharpEyes")
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
HeroCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Hero - Basic Info
HeroClass1 <- ChrInfo[1, 2]
HeroClass2 <- ChrInfo[1, 3]
HeroMainStatType <- ChrInfo[1, 4]
HeroSubStat1Type <- ChrInfo[1, 5]
HeroChrLv <- ChrInfo[1, 7]
HeroUnionLv <- ChrInfo[1, 8]
HeroArcaneForce <- ChrInfo[1, 9]
HeroCharisma <- ChrInfo[1, 10]
HeroInsight <- ChrInfo[1, 11]
HeroSensibility <- ChrInfo[1, 12]
HeroBaseMastery <- ChrInfo[1, 13]
HeroCRROver <- F
HeroBuffDurationNeeded <- 0

HeroAbility <- Abilities(c("BDR", "DisorderBDR"), c("L", "E"))

HeroLinkBase <- rbind(LinkBase)
HeroDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(HeroDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(HeroDisorder==T, 6, 0)+ifelse(HeroChrLv>MobLv, 6, 0), 0, 0, 0)
HeroLinkBase <- rbind(LinkBase, AdventureWarrior, DemonAvenger, Phantom, AdventureBowman) ## Cygnus Check Needed
HeroLinkBase <- data.frame(HeroLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(HeroLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(HeroLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(HeroLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeS22) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandAxe", "AR")[, 1:16], SubWeapon[1, ], Emblem[1, ])
rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem")
colnames(Weapon) <- SubWeaponOption
Weapon <- data.frame(Weapon)
Weapon <- WeaponAddpotential(Weapon, c("U", "U", "U"), c("A", "A", "O"))

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
HeroSpec <- data.frame(t(rep(0, 21)))
colnames(HeroSpec) <- Specs

HeroSpec$SkillLv <- sum(HeroCore[[3]][, 1]=="CombatOrders")
HeroSpec$PSkillLv <- sum(HeroCore[[3]][, 1]=="CombatOrders") + HeroAbility$PassiveLv
HeroSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100


## Hero - Passive
{option <- factor(c("FDR", "BDR"), levels=PSkill)
value <- c(10, 5)
WeaponMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("CRR", levels=PSkill)
value <- c(20)
ChanceAttack <- data.frame(option, value) ## FDR - Buff

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(25, 20)
Enrage <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70)
AdvancedCombo <- data.frame(option, value) ## Combo - Logic

option <- factor(c("IGR"), levels=PSkill)
value <- c(50 + HeroSpec$PSkillLv)
CombatMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + HeroSpec$PSkillLv)
AdvancedFinalAttack <- data.frame(option, value)}

HeroPassive <- Passive(list(WeaponMastery, PhysicalTraining, ChanceAttack, Enrage, AdvancedCombo, CombatMastery, AdvancedFinalAttack))


## Hero - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Fury <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(25)
info <- c(40, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PanicBuff <- rbind(data.frame(option, value), info)

option <- factor("DMR", levels=BSkill)
value <- c(25 + ceiling(HeroSpec$SkillLv/2))
info <- c(30, 31, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IncisingBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((HeroChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(HeroSpec$SkillLv/2))))
info <- c(900 + 30 * HeroSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * HeroCore[[3]][3, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * HeroCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * HeroCore[[3]][2, 2], NA, 1500, F, NA, NA, T)
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
value <- c(50)
info <- c(30, 150, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Valhalla <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(30, 240, 450, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboInstinct <- rbind(data.frame(option, value), info) ## Combo Data

option <- factor(levels=BSkill)
value <- c()
info <- c(5, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfaultBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(HeroCore[[2]][5, 2]/5), ceiling(HeroCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * HeroCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * HeroCore[[2]][6, 2]) * MapleSoldier[1, 2]) * HeroSpec$MainStatP), 5 + floor(HeroCore[[2]][6, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

HeroBuff <- Buff(list(WeaponBooster=WeaponBooster, Fury=Fury, PanicBuff=PanicBuff, IncisingBuff=IncisingBuff, MapleSoldier=MapleSoldier,
                      UsefulSharpEyes=UsefulSharpEyes, UsefulWindBooster=UsefulWindBooster, UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, 
                      Valhalla=Valhalla, ComboInstinct=ComboInstinct, ComboDeathfaultBuff=ComboDeathfaultBuff, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, 
                      Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : Fury, WeaponBooster, MapleWarriors
HeroAllTimeBuff <- AllTimeBuff(HeroBuff)


## Hero - Union & HyperStat & SoulWeapon
HeroSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + HeroPassive$CRR + 
  (Union8000Chr$CRR) + HeroAbility$CRR + HeroAllTimeBuff$CRR + 5
HeroSpec$CRR <- ifelse(HeroCRROver==T, HeroSpec$CRR, min(HeroSpec$CRR, 100))
HeroSpec$BuffDuration <- MonsterLife$BuffDuration + HeroPassive$BuffDuration + Union8000Chr$BuffDuration + floor(HeroSensibility/10) + HeroAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(HeroUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, HeroBuffDurationNeeded, HeroSpec$BuffDuration, HeroSpec$CRR, HeroCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, HeroBuffDurationNeeded - HeroSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, HeroBuffDurationNeeded - HeroSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(HeroUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Hero Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
HeroSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$STR + Dopings$MainStat + LinkSet$MainStat + HeroPassive$MainStat + 
  HeroAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * HeroChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * HeroArcaneForce + Union8000Chr$STR + 20
HeroSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$DEX + Dopings$SubStat1 + LinkSet$SubStat1 + HeroPassive$SubStat1 + 
  HeroAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$DEX
HeroSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + HeroPassive$ATK + Union8000Chr$ATK + HeroAbility$CRR + 
  HeroAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
HeroSpec$ATKP <- sum(Weapon$ATKP) + HeroPassive$ATKP + HeroAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
HeroSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, HeroPassive$IGR, Union8000Chr$IGR, floor(HeroCharisma/5)/2, 
  HeroAllTimeBuff$IGR, HyperStatBase$IGR))
HeroSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + HeroPassive$BDR + Union8000Chr$BDR + HeroAbility$BDR + HeroAbility$DisorderBDR + 
  HeroAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
HeroSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + HeroPassive$CRR + 
  (Union8000Chr$CRR + ifelse(HeroChrLv>=250, 1, 0)) + HeroAbility$CRR + HeroAllTimeBuff$CRR + 5
HeroSpec$CRR <- ifelse(HeroCRROver==T, HeroSpec$CRR + rowSums(CRRs), min(HeroSpec$CRR + rowSums(CRRs), 100))
HeroSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + HeroPassive$CDMR + HeroAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
HeroSpec$FDR <- FDRCalc(c(HeroPassive$FDR, HeroAllTimeBuff$FDR, ArcaneForceFDR(HeroArcaneForce, MapArc), LevelFDR(HeroChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandAxe", "AR")[19]*100-100+10)))
HeroSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandAxe", "AR")[17] - Dopings$ATKSpeed - HeroAllTimeBuff$ATKSpeed - HeroPassive$ATKSpeed, 2)
HeroSpec$Mastery <- min(HeroBaseMastery + HeroPassive$Mastery, 95)
HeroSpec$BuffDuration <- HeroSpec$BuffDuration + UnionBase$BuffDuration
HeroSpec$SummonedDuration <- MonsterLife$SummonedDuration + HeroPassive$SummonDuration + Union8000Chr$SummonedDuration
HeroSpec$ImmuneIgnore <- HeroPassive$ImmuneIgnore + floor(HeroInsight/10)/2 + HeroAllTimeBuff$ImmuneIgnore
HeroSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + HeroPassive$CoolTimeReset + HeroAbility$CoolTimeReset
HeroSpec$CoolReduceP <- Union8000Chr$CoolReduce
HeroSpec$CoolReduce <- 0
HeroSpec$Disorder <- max(HeroLinkBase$Disorder, HeroPassive$Disorder, HeroAllTimeBuff$Disorder)


## Hero - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * HeroCore[[2]][7, 2], 12, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * HeroCore[[2]][7, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][7, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][7, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][7, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HeroCore[[2]][7, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Hero - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][5, 2]>=40, 20, 0), 3 * HeroCore[[1]][5, 2])
info <- c(1150, 1, 960, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Panic <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][1, 2]>=40, 20, 0), 20, 2 * HeroCore[[1]][1, 2])
info <- c(215 + HeroSpec$SkillLv * 3, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RagingBlow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][4, 2]>=40, 20, 0), 2 * HeroCore[[1]][4, 2])
info <- c(576 + HeroSpec$SkillLv * 7, 4, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Incising <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][3, 2]>=40, 20, 0), 10, 2 * HeroCore[[1]][3, 2])
info <- c(170 + HeroSpec$SkillLv * 2, (0.75 + 0.01 * HeroSpec$SkillLv) * 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HeroCore[[1]][2, 2]>=40, 20, 0), 2 * HeroCore[[1]][2, 2])
info <- c(500, 8, 990, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RageUprising <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * HeroCore[[2]][2, 2], 14, 1680, NA, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ComboDeathfault <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * HeroCore[[2]][3, 2], 18, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScarofSpace <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(125 + 5 * HeroCore[[2]][4, 2], 4, 870, 120, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * HeroCore[[2]][4, 2], 5, 0, 60, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordIllusionExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * HeroCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

HeroATK <- Attack(list(Panic=Panic, RagingBlow=RagingBlow, Incising=Incising, AdvancedFinalAttack=AdvancedFinalAttack, RageUprising=RageUprising, 
                       ComboDeathfault=ComboDeathfault, ScarofSpace=ScarofSpace, SwordIllusion=SwordIllusion, SwordIllusionExplosion=SwordIllusionExplosion, AuraWeapon=AuraWeapon, 
                       SpiderInMirror=SpiderInMirror))


## Hero - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(315 + 12 * HeroCore[[2]][1, 2], 6, 810 * 2, 1000, 60 + floor(HeroCore[[2]][1, 2]/2), 120, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SwordofBurningSoul <- rbind(data.frame(option, value), info)}

HeroSummoned <- Summoned(list(SwordofBurningSoul=SwordofBurningSoul, SpiderInMirrorStart=SpiderInMirrorStart,
                              SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))



## Hero - DealCycle
ATKFinal <- data.frame(HeroATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, HeroSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)

BuffFinal <- data.frame(HeroBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, HeroSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(HeroSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, HeroSpec$CoolReduceP, HeroSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * HeroSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(HeroBuff))
HeroDealCycle <- t(rep(0, length(DealCycle)))
colnames(HeroDealCycle) <- DealCycle

HeroDealCycle <- DCBuff(HeroDealCycle, c("WeaponBooster", "Fury", "MapleSoldier", "UsefulCombatOrders", 
                                         "UsefulSharpEyes", "UsefulWindBooster"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SpiderInMirror"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("AuraWeaponBuff", "MapleWarriors2"), BuffFinal) 
HeroDealCycle <- DCSummoned(HeroDealCycle, Skill="SwordofBurningSoul", SummonedFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("Valhalla"), BuffFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("SoulContractLink"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("EpicAdventure", "ComboInstinct", "Restraint4"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, rep("RagingBlow", 55), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 16), "RageUprising", rep("RagingBlow", 22)), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 13)), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RagingBlow"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RagingBlow"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 21)), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 16), "RageUprising", rep("RagingBlow", 7)), ATKFinal)
HeroDealCycle <- DCSummoned(HeroDealCycle, Skill="SwordofBurningSoul", SummonedFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c(rep("RagingBlow", 8)), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c(rep("RagingBlow", 3)), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("EpicAdventure", "SoulContractLink"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 16), "RageUprising", rep("RagingBlow", 22)), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 8)), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c(rep("RagingBlow", 7), "RageUprising", rep("RagingBlow", 22)), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 16), "RageUprising", rep("RagingBlow", 11)), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("PanicBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Panic", rep("RagingBlow", 10)), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("SwordIllusion"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("ComboDeathfaultBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("ComboDeathfault"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCBuff(HeroDealCycle, c("IncisingBuff"), BuffFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("Incising"), ATKFinal)
HeroDealCycle <- DCATK(HeroDealCycle, c("RageUprising", rep("RagingBlow", 16), "RageUprising", rep("RagingBlow", 5)), ATKFinal)

HeroDealCycle

HeroDealCycle <- DealCycleFinal(HeroDealCycle)
HeroDealCycle <- DCSummonedATKs(HeroDealCycle, "SwordofBurningSoul", SummonedFinal)
HeroDealCycle <- SwordIllusionCycle(HeroDealCycle, ATKFinal)
HeroDealCycle <- AddATKsCycleHero(HeroDealCycle)
HeroDealCycle <- AuraWeaponCycleHero(HeroDealCycle)
HeroDealCycle <- DCSpiderInMirror(HeroDealCycle, SummonedFinal)
HeroDealCycle <- HeroCombo(HeroDealCycle)

HeroDealCycleReduction <- DealCycleReduction(HeroDealCycle, c("ComboFDR", "ComboBDR", "ComboATK"))

HeroDealCalc(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpec)

HeroSpecOpt1 <- HeroOptimization1(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpec, UnionRemained)
HeroSpecOpt <- HeroSpec
HeroSpecOpt$ATKP <- HeroSpecOpt$ATKP + HeroSpecOpt1$ATKP
HeroSpecOpt$BDR <- HeroSpecOpt$BDR + HeroSpecOpt1$BDR
HeroSpecOpt$IGR <- IGRCalc(c(HeroSpecOpt$IGR, HeroSpecOpt1$IGR))

HeroSpecOpt2 <- HeroOptimization2(HeroDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt, HyperStatBase, HeroChrLv, HeroCRROver)
HeroFinalDPM <- HeroDealCalc(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt2)
HeroFinalDPMwithMax <- HeroDealCalcWithMaxDMR(HeroDealCycle, ATKFinal, BuffFinal, SummonedFinal, HeroSpecOpt2)

DPM12338$Hero[1] <- sum(na.omit(HeroFinalDPMwithMax)) / (229440 / 60000)
DPM12338$Hero[2] <- sum(na.omit(HeroFinalDPM)) / (229440 / 60000) - sum(na.omit(HeroFinalDPMwithMax)) / (229440 / 60000)

HeroDealData <- data.frame(HeroDealCycle$Skills, HeroDealCycle$Time, HeroDealCycle$Restraint4, HeroFinalDPMwithMax)
colnames(HeroDealData) <- c("Skills", "Time", "R4", "Deal")

HeroRR <- HeroDealData[58:180, ]
sum((HeroRR$Deal)) ## 5154908797513

Hero40s <- HeroDealData[30:359, ]
sum((Hero40s$Deal)) ## 9190982581038

DealRatio(HeroDealCycle, HeroFinalDPMwithMax)