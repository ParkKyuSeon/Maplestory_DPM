## Palladin - Data
## Palladin - VMatrix
PasSkills <- c("Blast", "FinalAttack", "Sanctuary", "LinghtningCharge", "DevineCharge")
PasLvs <- c(50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 5, 5)
ActSkills <- c("HolyUnity", "BlessedHammer", "GrandCross", "MightyMjolnir", 
               "AuraWeapon", "BodyofSteal", "MapleWarriors2", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 1, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 5, 5)
UsefulSkills <- c("WindBooster", "SharpEyes")
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
PalladinCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Palladin - Basic Info
PalladinClass1 <- ChrInfo[2, 2]
PalladinClass2 <- ChrInfo[2, 3]
PalladinMainStatType <- ChrInfo[2, 4]
PalladinSubStat1Type <- ChrInfo[2, 5]
PalladinChrLv <- ChrInfo[2, 7]
PalladinUnionLv <- ChrInfo[2, 8]
PalladinArcaneForce <- ChrInfo[2, 9]
PalladinCharisma <- ChrInfo[2, 10]
PalladinInsight <- ChrInfo[2, 11]
PalladinSensibility <- ChrInfo[2, 12]
PalladinBaseMastery <- ChrInfo[2, 13]
PalladinCRROver <- F
PalladinBuffDurationNeeded <- 0

PalladinAbility <- Abilities(c("BDR", "DisorderBDR"), c("L", "E"))

PalladinLinkBase <- rbind(LinkBase)
PalladinDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(PalladinDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(PalladinDisorder==T, 6, 0)+ifelse(PalladinChrLv>MobLv, 6, 0), 0, 0, 0)
PalladinLinkBase <- rbind(LinkBase, AdventureWarrior, DemonAvenger, Phantom, Zero) ## Cygnus Check Needed
PalladinLinkBase <- data.frame(PalladinLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(PalladinLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(PalladinLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(PalladinLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeS21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandHammer", "AR")[, 1:16], SubWeapon[2, ], Emblem[1, ])
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
PalladinSpec <- data.frame(t(rep(0, 21)))
colnames(PalladinSpec) <- Specs


## Palladin - CombatOrders
{option <- factor("SkillLv", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CombatOrders <- rbind(data.frame(option, value), info)}
PalladinBuff <- Buff(list(CombatOrders=CombatOrders))
PalladinAllTimeBuff <- AllTimeBuff(PalladinBuff)

PalladinSpec$SkillLv <- PalladinAllTimeBuff$SkillLv
PalladinSpec$PSkillLv <- PalladinAllTimeBuff$SkillLv + PalladinAbility$PassiveLv
PalladinSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100


## Palladin - Passive
{option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(20)
ParashockGuard <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(10)
ShieldMastery <- data.frame(option, value)

option <- factor("ATK", levels=PSkill)
value <- c(20)
BlessingArmor <- data.frame(option, value)

option <- factor(c("DMR", "ATK"), levels=PSkill)
value <- c(25, 60)
AdvancedCharge <- data.frame(option, value)

option <- factor(c("Mastery", "CRR", "CDMR", "IGR", "FDR"), levels=PSkill)
value <- c(71, 42, 20, 37.9, 42)
PalladinExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(PalladinCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)}

PalladinPassive <- Passive(list(PhysicalTraining, ParashockGuard, ShieldMastery, BlessingArmor, AdvancedCharge, PalladinExpert, BodyofStealPassive))


## Palladin - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(50)
info <- c(80, NA, 1080, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Threat <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(21)
info <- c(206, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalForce <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((PalladinChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(PalladinSpec$SkillLv/2))))
info <- c(900 + 30 * PalladinSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * PalladinCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * PalladinCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(PalladinCore[[2]][5, 2]/5), ceiling(PalladinCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * PalladinCore[[2]][5, 2], 180, 720, F, T, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(35 + floor(PalladinCore[[2]][5, 2]/2))
info <- c(40 + PalladinCore[[2]][1, 2], 120, 600, F, T, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HolyUnity <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * PalladinCore[[2]][7, 2]) * MapleSoldier[1, 2]) * PalladinSpec$MainStatP), 5 + floor(PalladinCore[[2]][7, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

PalladinBuff <- Buff(list(WeaponBooster=WeaponBooster, CombatOrders=CombatOrders, Threat=Threat, ElementalForce=ElementalForce, MapleSoldier=MapleSoldier, 
                          UsefulSharpEyes=UsefulSharpEyes, UsefulWindBooster=UsefulWindBooster, EpicAdventure=EpicAdventure, 
                          AuraWeaponBuff=AuraWeaponBuff, HolyUnity=HolyUnity, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : CombatOrders, WeaponBooster, ElementalForce
PalladinAllTimeBuff <- AllTimeBuff(PalladinBuff)


## Palladin - Union & HyperStat & SoulWeapon
PalladinSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + PalladinPassive$CRR + 
  (Union8000Chr$CRR) + PalladinAbility$CRR + PalladinAllTimeBuff$CRR + 5
PalladinSpec$CRR <- ifelse(PalladinCRROver==T, PalladinSpec$CRR, min(PalladinSpec$CRR, 100))
PalladinSpec$BuffDuration <- MonsterLife$BuffDuration + PalladinPassive$BuffDuration + Union8000Chr$BuffDuration + floor(PalladinSensibility/10) + PalladinAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(PalladinUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, PalladinBuffDurationNeeded, PalladinSpec$BuffDuration, PalladinSpec$CRR, PalladinCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, PalladinBuffDurationNeeded - PalladinSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, PalladinBuffDurationNeeded - PalladinSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(PalladinUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Palladin Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
PalladinSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$STR + Dopings$MainStat + LinkSet$MainStat + PalladinPassive$MainStat + 
  PalladinAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * PalladinChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * PalladinArcaneForce + Union8000Chr$STR + 20
PalladinSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$DEX + Dopings$SubStat1 + LinkSet$SubStat1 + PalladinPassive$SubStat1 + 
  PalladinAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$DEX
PalladinSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + PalladinPassive$ATK + Union8000Chr$ATK + PalladinAbility$CRR + 
  PalladinAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
PalladinSpec$ATKP <- sum(Weapon$ATKP) + PalladinPassive$ATKP + PalladinAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
PalladinSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, PalladinPassive$IGR, Union8000Chr$IGR, floor(PalladinCharisma/5)/2, 
  PalladinAllTimeBuff$IGR, HyperStatBase$IGR))
PalladinSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + PalladinPassive$BDR + Union8000Chr$BDR + PalladinAbility$BDR + PalladinAbility$DisorderBDR + 
  PalladinAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
PalladinSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + PalladinPassive$CRR + 
  (Union8000Chr$CRR + ifelse(PalladinChrLv>=250, 1, 0)) + PalladinAbility$CRR + PalladinAllTimeBuff$CRR + 5
PalladinSpec$CRR <- ifelse(PalladinCRROver==T, PalladinSpec$CRR + rowSums(CRRs), min(PalladinSpec$CRR + rowSums(CRRs), 100))
PalladinSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + PalladinPassive$CDMR + PalladinAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
PalladinSpec$FDR <- FDRCalc(c(PalladinPassive$FDR, PalladinAllTimeBuff$FDR, ArcaneForceFDR(PalladinArcaneForce, MapArc), LevelFDR(PalladinChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandHammer", "AR")[19]*100-100)))
PalladinSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandHammer", "AR")[17] - Dopings$ATKSpeed - PalladinAllTimeBuff$ATKSpeed - PalladinPassive$ATKSpeed, 2)
PalladinSpec$Mastery <- min(PalladinBaseMastery + PalladinPassive$Mastery, 95)
PalladinSpec$BuffDuration <- PalladinSpec$BuffDuration + UnionBase$BuffDuration
PalladinSpec$SummonedDuration <- MonsterLife$SummonedDuration + PalladinPassive$SummonDuration + Union8000Chr$SummonedDuration
PalladinSpec$ImmuneIgnore <- PalladinPassive$ImmuneIgnore + floor(PalladinInsight/10)/2 + PalladinAllTimeBuff$ImmuneIgnore
PalladinSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + PalladinPassive$CoolTimeReset + PalladinAbility$CoolTimeReset
PalladinSpec$CoolReduceP <- Union8000Chr$CoolReduce
PalladinSpec$CoolReduce <- 0
PalladinSpec$Disorder <- max(PalladinLinkBase$Disorder, PalladinPassive$Disorder, PalladinAllTimeBuff$Disorder)


## Palladin - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * PalladinCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * PalladinCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PalladinCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Palladin - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][2, 2]>=40, 20, 0), 4 * PalladinCore[[1]][2, 2])
info <- c(80, 0.8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][4, 2]>=40, 20, 0), 2 * PalladinCore[[1]][4, 2])
info <- c(462, 5, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningCharge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][5, 2]>=40, 20, 0), 2 * PalladinCore[[1]][5, 2])
info <- c(462, 5, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivineCharge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][1, 2]>=40, 20, 0), 20, 2 * PalladinCore[[1]][1, 2])
info <- c(291, 12, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blast <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PalladinCore[[1]][3, 2]>=40, 20, 0), 30, 2 * PalladinCore[[1]][3, 2])
info <- c(580, 8, 990, NA, 9.75, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Sanctuary <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 900, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossPre <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 100)
info <- c(175 + 7 * PalladinCore[[2]][3, 2], 12, 3500, 270, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossSmall <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 100)
info <- c(300 + 12 * PalladinCore[[2]][3, 2], 12, 6500, 150, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 450, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrandCrossEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(225 + 9 * PalladinCore[[2]][4, 2], 6, 0, 630, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MightyMjolnir <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * PalladinCore[[2]][4, 2], 9, 840, 630, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MightyMjolnirExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * PalladinCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

PalladinATK <- Attack(list(FinalAttack=FinalAttack, LightningCharge=LightningCharge, DivineCharge=DivineCharge, Blast=Blast, Sanctuary=Sanctuary, 
                           GrandCrossPre=GrandCrossPre, GrandCrossSmall=GrandCrossSmall, GrandCrossBig=GrandCrossBig, GrandCrossEnd=GrandCrossEnd, 
                           MightyMjolnir=MightyMjolnir, MightyMjolnirExplosion=MightyMjolnirExplosion, AuraWeapon=AuraWeapon, 
                           SpiderInMirror=SpiderInMirror))


## Palladin - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(250 + 10 * PalladinCore[[2]][2, 2], 2, 0, 600, 60, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlessedHammerSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(525 + 21 * PalladinCore[[2]][2, 2], 3, 360, 600, 30 + ServerLag, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlessedHammerBig <- rbind(data.frame(option, value), info)}

PalladinSummoned <- Summoned(list(BlessedHammerSmall=BlessedHammerSmall, BlessedHammerBig=BlessedHammerBig, SpiderInMirrorStart=SpiderInMirrorStart,
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Palladin - DealCycle
ATKFinal <- data.frame(PalladinATK)
ATKFinal$Delay[c(1:5, 10:13)] <- Delay(ATKFinal$Delay, PalladinSpec$ATKSpeed)[c(1:5, 10:13)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)

BuffFinal <- data.frame(PalladinBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, PalladinSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(PalladinSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, PalladinSpec$CoolReduceP, PalladinSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * PalladinSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(PalladinBuff))
PalladinDealCycle <- t(rep(0, length(DealCycle)))
colnames(PalladinDealCycle) <- DealCycle

{PalladinDealCycle <- DCBuff(PalladinDealCycle, c("WeaponBooster", "CombatOrders", "ElementalForce", "MapleSoldier", 
                                                 "UsefulSharpEyes", "UsefulWindBooster"), BuffFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("SpiderInMirror"), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("Threat", "AuraWeaponBuff", "MapleWarriors2"), BuffFinal) 
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("EpicAdventure", "SoulContractLink", "HolyUnity", "Restraint4"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", "GrandCrossPre", "GrandCrossSmall", "GrandCrossBig", "GrandCrossEnd", 
                                                "MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15)), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("Sanctuary", "DivineCharge", rep("Blast", 5), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 14), "MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("Blast"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("Blast"), ATKFinal)
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 3), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 7), "LightningCharge", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("Threat"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 14)), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("SoulContractLink"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary", rep("Blast", 2), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 12), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 10), "DivineCharge", rep("Blast", 4), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 10)), ATKFinal)
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("EpicAdventure", "HolyUnity"), BuffFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", rep("Blast", 4), "Sanctuary", "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 14), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 6), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 7), "LightningCharge", rep("Blast", 7), "Sanctuary", "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8)), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("Threat"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 4), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 13), "DivineCharge"), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("WeaponBooster", "CombatOrders", "ElementalForce", "UsefulSharpEyes", "UsefulWindBooster", 
                                                 "AuraWeaponBuff", "MapleWarriors2"), BuffFinal)
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("SoulContractLink", "Restraint4"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", "GrandCrossPre", "GrandCrossSmall", "GrandCrossBig", "GrandCrossEnd", 
                                                "MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("LightningCharge", rep("Blast", 7)), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 14), "MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 6), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 7), "DivineCharge", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("Blast"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("Blast"), ATKFinal)
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("HolyUnity"), BuffFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8)), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("Threat", "EpicAdventure"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 15), "LightningCharge"), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("SoulContractLink"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c("MightyMjolnir", "MightyMjolnirExplosion", "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 10), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 4), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 17), "Sanctuary", "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 6)), ATKFinal)
PalladinDealCycle <- DCSummoned(PalladinDealCycle, Skill="BlessedHammerBig", SummonedFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 7), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8), "DivineCharge", "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 5), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 16), "Sanctuary", "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCBuff(PalladinDealCycle, c("Threat"), BuffFinal) 
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 12), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 8), "MightyMjolnir", "MightyMjolnirExplosion"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c(rep("Blast", 6), "Sanctuary"), ATKFinal)
PalladinDealCycle <- DCATK(PalladinDealCycle, c("LightningCharge", rep("Blast", 10)), ATKFinal)

PalladinDealCycle}

PalladinDealCycle <- DealCycleFinal(PalladinDealCycle)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("MightyMjolnir"), 4, 630, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("MightyMjolnirExplosion"), 4, 630, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("GrandCrossSmall"), 13, 0, ATKFinal)
PalladinDealCycle <- RepATKCycle(PalladinDealCycle, c("GrandCrossBig"), 43, 0, ATKFinal)
PalladinDealCycle <- DCSummonedATKs(PalladinDealCycle, Skill=c("BlessedHammerBig"), SummonedFinal)
PalladinDealCycle <- BlessedHammerCycle(PalladinDealCycle)
PalladinDealCycle <- AddATKsCyclePalladin(PalladinDealCycle)
PalladinDealCycle <- AuraWeaponCycle(PalladinDealCycle)
PalladinDealCycle <- DCSpiderInMirror(PalladinDealCycle, SummonedFinal)
PalladinDealCycleReduction <- DealCycleReduction(PalladinDealCycle)

DealCalc(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpec)

PalladinSpecOpt1 <- Optimization1(PalladinDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PalladinSpec, UnionRemained)
PalladinSpecOpt <- PalladinSpec
PalladinSpecOpt$ATKP <- PalladinSpecOpt$ATKP + PalladinSpecOpt1$ATKP
PalladinSpecOpt$BDR <- PalladinSpecOpt$BDR + PalladinSpecOpt1$BDR
PalladinSpecOpt$IGR <- IGRCalc(c(PalladinSpecOpt$IGR, PalladinSpecOpt1$IGR))

PalladinSpecOpt2 <- Optimization2(PalladinDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt, HyperStatBase, PalladinChrLv, PalladinCRROver)
PalladinFinalDPM <- DealCalc(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt2)
PalladinFinalDPMwithMax <- DealCalcWithMaxDMR(PalladinDealCycle, ATKFinal, BuffFinal, SummonedFinal, PalladinSpecOpt2)

DPMTver$Palladin[1] <- sum(na.omit(PalladinFinalDPMwithMax)) / (345330 / 60000)
DPMTver$Palladin[2] <- sum(na.omit(PalladinFinalDPM)) / (345330 / 60000) - sum(na.omit(PalladinFinalDPMwithMax)) / (345330 / 60000)

PalladinDealData <- data.frame(PalladinDealCycle$Skills, PalladinDealCycle$Time, PalladinDealCycle$Restraint4, PalladinFinalDPMwithMax)
colnames(PalladinDealData) <- c("Skills", "Time", "R4", "Deal")

PalladinRR <- PalladinDealData[25:199, ]
sum((PalladinRR$Deal)) ## 3,519,543,612,093

Palladin40s <- PalladinDealData[18:367, ]
sum((Palladin40s$Deal)) ## 5,506,647,320,042

DealRatio(PalladinDealCycle, PalladinFinalDPMwithMax)