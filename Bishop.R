## Bishop - Data
## Bishop - VMatrix
PasSkills <- c("AngelRay", "HeavensDoor", "Bahamut", "Bigbang", "Genesis")
PasLvs <- c(50, 50, 50, 50, 25)
PasMP <- c(10, 10, 10, 10, 5)
ActSkills <- c("Pray", "AngelofLibra", "PeaceMaker", "DivinePunishment", 
               "OverloadMana", "EtherealForm", "UnstableMemorize", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 1, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 0, 5, 5, 5)
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
BishopCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Bishop - Basic Info
BishopClass1 <- ChrInfo[6, 2]
BishopClass2 <- ChrInfo[6, 3]
BishopMainStatType <- ChrInfo[6, 4]
BishopSubStat1Type <- ChrInfo[6, 5]
BishopChrLv <- ChrInfo[6, 7]
BishopUnionLv <- ChrInfo[6, 8]
BishopArcaneForce <- ChrInfo[6, 9]
BishopCharisma <- ChrInfo[6, 10]
BishopInsight <- ChrInfo[6, 11]
BishopSensibility <- ChrInfo[6, 12]
BishopBaseMastery <- ChrInfo[6, 13]
BishopCRROver <- F
BishopBuffDurationNeeded <- 310

BishopAbility <- Abilities(c("BuffDuration", "DisorderBDR"), c("L", "E"))

BishopLinkBase <- rbind(LinkBase)
BishopDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(BishopDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(BishopDisorder==T, 6, 0)+ifelse(BishopChrLv>MobLv, 6, 0), 0, 0, 0)
BishopLinkBase <- rbind(LinkBase, Mikhail, DemonAvenger, CygnusKnights, Zero)
BishopLinkBase <- data.frame(BishopLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(BishopLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(BishopLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(BishopLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeI21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", "AR")[, 1:16], SubWeapon[6, ], Emblem[1, ])
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
BishopSpec <- data.frame(t(rep(0, 21)))
colnames(BishopSpec) <- Specs

BishopSpec$SkillLv <- sum(BishopCore[[3]][, 1]=="CombatOrders")
BishopSpec$PSkillLv <- sum(BishopCore[[3]][, 1]=="CombatOrders") + BishopAbility$PassiveLv
BishopSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100


## Bishop - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("CRR", "Mastery"), levels=PSkill)
value <- c(40, 70)
HolyFocus <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(40 + 4*ceiling(BishopSpec$SkillLv/3))
BigbangDebuff <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(3 * PartyMembers)
BlessingHarmony <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * BishopSpec$SkillLv, 50 + 5 * BishopSpec$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(BishopSpec$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(BishopCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only

option <- factor(c("MainStat"), levels=PSkill)
value <- c(BishopCore[[2]][7, 2])
UnstableMemorize <- data.frame(option, value)}

BishopPassive <- Passive(list(SpellMastery=SpellMastery, HighWisdom=HighWisdom, MagicCritical=MagicCritical, HolyFocus=HolyFocus, BigbangDebuff=BigbangDebuff, 
                              BlessingHarmony=BlessingHarmony, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, UnstableMemorize=UnstableMemorize))


## Bishop - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + BishopSpec$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("ATK", "BDR", levels=BSkill)
value <- c(50 + BishopSpec$SkillLv, 10)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdvancedBless <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((BishopChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(BishopSpec$SkillLv/2))))
info <- c(900 + 30 * BishopSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * BishopCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * BishopCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(30 + floor(BishopCore[[2]][1, 2]/2), 180, 360, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Pray <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(14 + floor(BishopCore[[2]][3, 2]/5))
info <- c(8, 10, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * BishopCore[[2]][7, 2]) * MapleSoldier[1, 2]) * BishopSpec$MainStatP), 5 + floor(BishopCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "FDR", "IGR", "ATKSpeed", "ImmuneIgnore"), levels=BSkill)
value <- c(50, 30, 20, 1, 10)
info <- c(3600, 7200, 480, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VengenceofAngel <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(25)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BahamutDebuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(50)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraDebuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * BishopCore[[3]][2, 2], 20000, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyesPart <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * BishopCore[[3]][1, 2], 20000, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrdersPart <- rbind(data.frame(option, value), info)}

BishopBuff <- Buff(list(MagicBooster=MagicBooster, Infinity=Infinity, AdvancedBless=AdvancedBless, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure,
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Pray=Pray, PeaceMakerBuff=PeaceMakerBuff, VengenceofAngel=VengenceofAngel,
                        BahamutDebuff=BahamutDebuff, AngelofLibraDebuff=AngelofLibraDebuff, UsefulSharpEyesPart=UsefulSharpEyesPart, UsefulCombatOrdersPart=UsefulCombatOrdersPart,
                        MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MagicBooster, AdvancedBless, HolySymbol
BishopAllTimeBuff <- AllTimeBuff(BishopBuff)


## Bishop - Union & HyperStat & SoulWeapon
BishopSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + BishopPassive$CRR + 
  (Union8000Chr$CRR) + BishopAbility$CRR + BishopAllTimeBuff$CRR + 5
BishopSpec$CRR <- ifelse(BishopCRROver==T, BishopSpec$CRR, min(BishopSpec$CRR, 100))
BishopSpec$BuffDuration <- MonsterLife$BuffDuration + BishopPassive$BuffDuration + Union8000Chr$BuffDuration + floor(BishopSensibility/10) + BishopAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(BishopUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, BishopBuffDurationNeeded, BishopSpec$BuffDuration, BishopSpec$CRR, BishopCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, BishopBuffDurationNeeded - BishopSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, min(BishopBuffDurationNeeded - BishopSpec$BuffDuration, 40)), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(BishopUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Bishop Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
BishopSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$INT + Dopings$MainStat + LinkSet$MainStat + BishopPassive$MainStat + 
  BishopAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * BishopChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * BishopArcaneForce + Union8000Chr$INT + 20
BishopSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$LUK + Dopings$SubStat1 + LinkSet$SubStat1 + BishopPassive$SubStat1 + 
  BishopAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$LUK
BishopSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + BishopPassive$ATK + Union8000Chr$ATK + BishopAbility$CRR + 
  BishopAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
BishopSpec$ATKP <- sum(Weapon$ATKP) + BishopPassive$ATKP + BishopAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
BishopSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, BishopPassive$IGR, Union8000Chr$IGR, floor(BishopCharisma/5)/2, 
  BishopAllTimeBuff$IGR, HyperStatBase$IGR))
BishopSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + BishopPassive$BDR + Union8000Chr$BDR + BishopAbility$BDR + BishopAbility$DisorderBDR +
  BishopAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
BishopSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + BishopPassive$CRR + 
  (Union8000Chr$CRR + ifelse(BishopChrLv>=250, 1, 0)) + BishopAbility$CRR + BishopAllTimeBuff$CRR + 5
BishopSpec$CRR <- ifelse(BishopCRROver==T, BishopSpec$CRR + rowSums(CRRs), min(BishopSpec$CRR + rowSums(CRRs), 100))
BishopSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + BishopPassive$CDMR + BishopAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
BishopSpec$FDR <- FDRCalc(c(BishopPassive$FDR, BishopAllTimeBuff$FDR, ArcaneForceFDR(BishopArcaneForce, MapArc), LevelFDR(BishopChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", "AR")[19]*100-100), 20))
BishopSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", "AR")[17] - Dopings$ATKSpeed - BishopAllTimeBuff$ATKSpeed - BishopPassive$ATKSpeed, 2)
BishopSpec$Mastery <- min(BishopBaseMastery + BishopPassive$Mastery, 95)
BishopSpec$BuffDuration <- BishopSpec$BuffDuration + UnionBase$BuffDuration
BishopSpec$SummonedDuration <- MonsterLife$SummonedDuration + BishopPassive$SummonDuration + Union8000Chr$SummonedDuration
BishopSpec$ImmuneIgnore <- BishopPassive$ImmuneIgnore + floor(BishopInsight/10)/2 + BishopAllTimeBuff$ImmuneIgnore
BishopSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + BishopPassive$CoolTimeReset + BishopAbility$CoolTimeReset
BishopSpec$CoolReduceP <- Union8000Chr$CoolReduce
BishopSpec$CoolReduce <- 0
BishopSpec$Disorder <- max(BishopLinkBase$Disorder, BishopPassive$Disorder, BishopAllTimeBuff$Disorder)


## Bishop - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * BishopCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BishopCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Bishop - Unstable Memorize Data
Skills <- c("EnergyBolt", "HolyArrow", "Heal", "ShiningRay", "HolyFountain", "Dispel", "DivineProtection", "AngelRay", "Genesis", 
            "Bigbang", "Resurrection", "Infinity", "Bahamut", "HeavensDoor", "EpicAdventure")
Ind <- c(1, 10, 10, 10, 10, 25, 10, 25, 25, 25, 25, 25, 25, 10, 10)
Prob <- Ind/sum(Ind)
Delays <- c(Delay(810, 3), Delay(810, 3), Delay(600, 3), Delay(900, 3), 960, 900, 870, Delay(810, 3), Delay(810, 3), 
            Delay(780, 3), 900, 600, 600, Delay(360, 3), 0)
BishopUnstable <- data.frame(Skills, Ind, Prob, Delays)
BishopUnsHolyATKProb <- sum(BishopUnstable$Prob[c(2, 4, 8, 9, 10)])


## Bishop - Attacks
{option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(309, BishopUnstable[1, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnergyBoltUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(518, BishopUnstable[2, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HolyArrowUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(40, floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(254, 4 * BishopUnstable[4, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShiningRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 7 * BishopUnstable[8, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][5, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][5, 2]>=40, 20, 0))
info <- c(405 + 5 * BishopSpec$SkillLv, 12 * BishopUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GenesisUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][4, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][4, 2]>=40, 20, 0))
info <- c(480 + 6 * BishopSpec$SkillLv, 4 * BishopUnstable[9, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BigbangUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][2, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), 40, ifelse(BishopCore[[1]][2, 2]>=40, 20, 0))
info <- c(1000, 8 * BishopUnstable[14, 3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoorUnstable <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRay <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][2, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][2, 2]>=40, 20, 0))
info <- c(1000, 8, 360, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoor <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMaker <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(175 + 7 * BishopCore[[2]][4, 2], 10, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishment <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentLoop <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 120, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizePre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, sum(BishopUnstable$Prob * BishopUnstable$Delay), NA, 9, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorizeEnd <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * BishopUnsHolyATKProb, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns1 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * BishopCore[[1]][1, 2], floor(BishopCore[[2]][5, 2] / 10) + 8)), ifelse(BishopCore[[1]][1, 2]>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14 * (1-BishopUnsHolyATKProb), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRayAfterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4 * BishopUnsHolyATKProb, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerafterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(350 + 14 * BishopCore[[2]][3, 2], 4 * (1-BishopUnsHolyATKProb), 0, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerafterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8 * BishopUnsHolyATKProb, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionafterUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(500 + 20 * BishopCore[[2]][3, 2], 8 * (1-BishopUnsHolyATKProb), 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosionafterUns2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 6 * BishopCore[[2]][4, 2], 10 * BishopUnsHolyATKProb, 1000, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentWithUns1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(BishopCore[[2]][5, 2] / 10) + 8)
info <- c(150 + 6 * BishopCore[[2]][4, 2], 10 * (1-BishopUnsHolyATKProb), 0, 240, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentWithUns2 <- rbind(data.frame(option, value), info)}

BishopATK <- Attack(list(EnergyBoltUnstable=EnergyBoltUnstable, HolyArrowUnstable=HolyArrowUnstable, ShiningRayUnstable=ShiningRayUnstable, AngelRayUnstable=AngelRayUnstable, 
                         GenesisUnstable=GenesisUnstable, BigbangUnstable=BigbangUnstable, HeavensDoorUnstable=HeavensDoorUnstable, AngelRay=AngelRay, HeavensDoor=HeavensDoor,
                         PeaceMaker=PeaceMaker, PeaceMakerExplosion=PeaceMakerExplosion, DivinePunishmentPre=DivinePunishmentPre, DivinePunishment=DivinePunishment, 
                         DivinePunishmentLoop=DivinePunishmentLoop, DivinePunishmentEnd=DivinePunishmentEnd,
                         UnstableMemorizePre=UnstableMemorizePre, UnstableMemorizeEnd=UnstableMemorizeEnd, AngelRayAfterUns1=AngelRayAfterUns1, AngelRayAfterUns2=AngelRayAfterUns2, 
                         PeaceMakerafterUns1=PeaceMakerafterUns1, PeaceMakerafterUns2=PeaceMakerafterUns2, PeaceMakerExplosionafterUns1=PeaceMakerExplosionafterUns1, 
                         PeaceMakerExplosionafterUns2=PeaceMakerExplosionafterUns2, DivinePunishmentWithUns1=DivinePunishmentWithUns1, DivinePunishmentWithUns2=DivinePunishmentWithUns2,
                         SpiderInMirror=SpiderInMirror))


## Bishop - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * BishopCore[[1]][3, 2], ifelse(BishopCore[[1]][3, 2]>=40, 20, 0))
info <- c(170 + 2 * BishopSpec$SkillLv, 1, 0, 3030, 260, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Bahamut <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(500 + 20 * BishopCore[[2]][2, 2], 12, 540, 3030, 30, 120, F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AngelofLibra <- rbind(data.frame(option, value), info)}

BishopSummoned <- Summoned(list(Bahamut=Bahamut, AngelofLibra=AngelofLibra, SpiderInMirrorStart=SpiderInMirrorStart,
                                SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Bishop - DealCycle
ATKFinal <- data.frame(BishopATK)
ATKFinal$Delay[c(1:11, 18:26)] <- Delay(ATKFinal$Delay, 2)[c(1:11, 18:26)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)

BuffFinal <- data.frame(BishopBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BishopSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(BishopSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BishopSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(BishopBuff))
BishopDealCycle <- t(rep(0, length(DealCycle)))
colnames(BishopDealCycle) <- DealCycle

BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel", "MagicBooster", "AdvancedBless", "MapleSoldier", 
                                             "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCSummoned(BishopDealCycle, "Bahamut", SummonedFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("Infinity", "EpicAdventure", "SoulContractLink"), BuffFinal) 
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 12)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("DivinePunishmentPre", "DivinePunishment", rep("DivinePunishmentLoop", 8), "DivinePunishmentEnd"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 8)), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("MapleWarriors2"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 6)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 12)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, "SpiderInMirror", ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("Pray"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 14)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 11)), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("SoulContractLink"), BuffFinal) 
BishopDealCycle <- DCSummoned(BishopDealCycle, "AngelofLibra", SummonedFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("Restraint4"), BuffFinal) 
BishopDealCycle <- DCATK(BishopDealCycle, c("DivinePunishmentPre", "DivinePunishment", rep("DivinePunishmentLoop", 8), "DivinePunishmentEnd"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("HeavensDoor"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 13)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("EpicAdventure"), BuffFinal) 
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 11)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 9)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("AngelRay"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 8)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 3)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 7)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 4)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 6)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("VengenceofAngel"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 6)), ATKFinal)


## Bishop Unstable
Unsdata <- UnstableData(BishopDealCycle, BishopUnstable[12, 3], BuffFinal$Duration[2], BuffFinal$CoolTime[2], BuffFinal$Duration[6])
{option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * BishopCore[[3]][2, 2], NA, 900 * (Unsdata$BuffNeeded / (180 + 3 * BishopCore[[3]][2, 2])), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyesPart <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 3 * BishopCore[[3]][1, 2], NA, 1500 * (Unsdata$BuffNeeded / (180 + 3 * BishopCore[[3]][2, 2])), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrdersPart <- rbind(data.frame(option, value), info)}

BishopBuff <- Buff(list(MagicBooster=MagicBooster, Infinity=Infinity, AdvancedBless=AdvancedBless, MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure,
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Pray=Pray, PeaceMakerBuff=PeaceMakerBuff, VengenceofAngel=VengenceofAngel,
                        BahamutDebuff=BahamutDebuff, AngelofLibraDebuff=AngelofLibraDebuff, UsefulSharpEyesPart=UsefulSharpEyesPart, UsefulCombatOrdersPart=UsefulCombatOrdersPart,
                        MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))

BuffFinal <- data.frame(BishopBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BishopSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)


## BishopDealCycle - Unstable Infinity
BishopDealCycle <- DCBuff(BishopDealCycle, c("Infinity", "MagicBooster", "AdvancedBless", "MapleSoldier", 
                                             "UsefulSharpEyesPart", "UsefulCombatOrdersPart"), BuffFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 6)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("DivinePunishmentPre", "DivinePunishment", rep("DivinePunishmentLoop", 8), "DivinePunishmentEnd"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCBuff(BishopDealCycle, c("EpicAdventure"), BuffFinal) 
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 4)), ATKFinal)
BishopDealCycle <- DCSummoned(BishopDealCycle, "AngelofLibra", SummonedFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 10)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c("PeaceMaker"), ATKFinal)
BishopDealCycle <- DCATK(BishopDealCycle, c(rep("AngelRay", 21)), ATKFinal)

BishopDealCycle <- DealCycleFinal(BishopDealCycle)
BishopDealCycle <- RepATKCycle(BishopDealCycle, c("DivinePunishment"), 37, 0, ATKFinal)
BishopDealCycle <- PeaceMakerCycle(BishopDealCycle, 3, ATKFinal, 8 + ServerLag)
BishopDealCycle <- DCSpiderInMirror(BishopDealCycle, SummonedFinal)
BishopDealCycle <- LibraCycle(BishopDealCycle)
BishopDealCycle <- BishopUnstableCycle(BishopDealCycle, ATKFinal)
BishopDealCycle <- BishopInfinity(BishopDealCycle, 6000, 70 + BishopSpec$SkillLv, ServerLag)

DealCycle <- c("Skills", "Time", rownames(BishopBuff))
BishopDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(BishopDealCycle2) <- DealCycle

BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel", "MagicBooster", "AdvancedBless", "MapleSoldier", 
                                             "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCSummoned(BishopDealCycle2, "Bahamut", SummonedFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("Infinity", "EpicAdventure", "SoulContractLink"), BuffFinal) 
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 12)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("DivinePunishmentPre", "DivinePunishment", rep("DivinePunishmentLoop", 8), "DivinePunishmentEnd"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 8)), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("MapleWarriors2"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 6)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("Pray"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 14)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 11)), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("SoulContractLink"), BuffFinal) 
BishopDealCycle2 <- DCSummoned(BishopDealCycle2, "AngelofLibra", SummonedFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("AngelRay"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("AngelRay"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 15)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("Restraint4"), BuffFinal) 
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("DivinePunishmentPre", "DivinePunishment", rep("DivinePunishmentLoop", 8), "DivinePunishmentEnd"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("HeavensDoor"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 13)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("EpicAdventure"), BuffFinal) 
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 11)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("AngelRay"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 9)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("AngelRay"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("AngelRay"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 8)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 3)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 7)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 4)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("PeaceMaker"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 6)), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizePre"), ATKFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c("UnstableMemorizeEnd"), ATKFinal)
BishopDealCycle2 <- DCBuff(BishopDealCycle2, c("VengenceofAngel"), BuffFinal)
BishopDealCycle2 <- DCATK(BishopDealCycle2, c(rep("AngelRay", 7)), ATKFinal)

BishopDealCycle2 <- DealCycleFinal(BishopDealCycle2)
BishopDealCycle2 <- RepATKCycle(BishopDealCycle2, c("DivinePunishment"), 37, 0, ATKFinal)
BishopDealCycle2 <- PeaceMakerCycle(BishopDealCycle2, 3, ATKFinal, 8 + ServerLag)
BishopDealCycle2 <- LibraCycle(BishopDealCycle2)
BishopDealCycle2 <- BishopUnstableCycle(BishopDealCycle2, ATKFinal)
BishopDealCycle2 <- BishopInfinity(BishopDealCycle2, 6000, 70 + BishopSpec$SkillLv, ServerLag)


## Bishop Deal Calc
BishopDealCalc(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, Unsdata)
BishopDealCalcWithMaxDMR(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, Unsdata)

BishopSpecOpt1 <- BishopOptimization1(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, UnionRemained, Unsdata)
BishopSpecOpt <- BishopSpec
BishopSpecOpt$ATKP <- BishopSpecOpt$ATKP + BishopSpecOpt1$ATKP
BishopSpecOpt$BDR <- BishopSpecOpt$BDR + BishopSpecOpt1$BDR
BishopSpecOpt$IGR <- IGRCalc(c(BishopSpecOpt$IGR, BishopSpecOpt1$IGR))

BishopSpecOpt2 <- BishopOptimization2(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, HyperStatBase, BishopChrLv, BishopCRROver, Unsdata)
BishopFinalDPM <- BishopDealCalc(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2, Unsdata)
BishopFinalDPMwithMax <- BishopDealCalcWithMaxDMR(BishopDealCycle, BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2, Unsdata)

DPM12338$Bishop[1] <- sum(na.omit(BishopFinalDPMwithMax)) / (211669.8 / 60000)
DPM12338$Bishop[2] <- sum(na.omit(BishopFinalDPM)) / (211669.8 / 60000) - sum(na.omit(BishopFinalDPMwithMax)) / (211669.8 / 60000)

## PrayFDR Logic Needed

BishopDamage <- BishopDealCalcGeneral(BishopDealCycle, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2)
Bishop40s <- data.frame(BishopDealCycle$Skills, BishopDealCycle$Time, BishopDealCycle$Restraint4, BishopDealCycle$Infinity, BishopDealCycle$InfinityFDR, BishopDamage)
colnames(Bishop40s) <- c("Skills", "Time", "RR4", "Infinity", "InfinityFDR", "Damage")

DPM12338$Bishop[3] <- sum(Bishop40s$Damage[341:428]) ## 2,627,388,806,826
DPM12338$Bishop[4] <- sum(Bishop40s$Damage[264:437]) ## 4,589,763,955,359

BishopDamage2 <- BishopDealCalcGeneral(BishopDealCycle2, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt2)

BishopDealRatio(BishopDealCycle, BishopDealCycle2, BishopDamage, BishopDamage2, UnsData)