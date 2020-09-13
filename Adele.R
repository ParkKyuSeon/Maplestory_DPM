## Adele - Data
## Adele - VMatrix
PasSkills <- c("Divide", "Order_Grave", "Territory_Tred", "Creation_Gathering", "Blossom", "Shard_Wonder", "Impale_Resonance_Marker")
PasLvs <- c(50, 50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 10, 10, 5, 5)
ActSkills <- c("Ruin", "Infinite", "Restore", "Storm", 
               "AuraWeapon", "MagicCircuitFullDrive", "BodyofSteal", "BlessofGrandis", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 1, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 0, 5, 0)
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
AdeleCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Adele - Basic Info
AdeleClass1 <- ChrInfo[38, 2]
AdeleClass2 <- ChrInfo[38, 3]
AdeleMainStatType <- ChrInfo[38, 4]
AdeleSubStat1Type <- ChrInfo[38, 5]
AdeleChrLv <- ChrInfo[38, 7]
AdeleUnionLv <- ChrInfo[38, 8]
AdeleArcaneForce <- ChrInfo[38, 9]
AdeleCharisma <- ChrInfo[38, 10]
AdeleInsight <- ChrInfo[38, 11]
AdeleSensibility <- ChrInfo[38, 12]
AdeleBaseMastery <- ChrInfo[38, 13]
AdeleCRROver <- F
AdeleBuffDurationNeeded <- 0

AdeleAbility <- Abilities(c("BDR", "DisorderBDR"), c("L", "E"))

AdeleLinkBase <- rbind(LinkBase)
AdeleDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(AdeleDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(AdeleDisorder==T, 6, 0)+ifelse(AdeleChrLv>MobLv, 6, 0), 0, 0, 0)
AdeleLinkBase <- rbind(LinkBase, DemonAvenger, Adele, Zero, Phantom) ## Check Needed
AdeleLinkBase <- data.frame(AdeleLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(AdeleLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(AdeleLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(AdeleLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeS21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", "AR")[, 1:16], SubWeapon[37, ], Emblem[9, ])
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

Specs <- c("MainStat", "SubStat1", "ATK", "ATKSub", "ATKP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
           "SummonedDuration", "ImmuneIgnore", "CoolTimeReset", "SkillLv", "PSkillLv", "CoolReduceP", "CoolReduce", "Disorder", "MainStatP")
AdeleSpec <- data.frame(t(rep(0, 22)))
colnames(AdeleSpec) <- Specs

AdeleSpec$SkillLv <- sum(AdeleCore[[3]][, 1]=="CombatOrders")
AdeleSpec$PSkillLv <- sum(AdeleCore[[3]][, 1]=="CombatOrders") + AdeleAbility$PassiveLv
AdeleSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100 
AdeleSpec$ATKSub <- sum(Item$ATKSub[1:(nrow(Item)-2)])


## Adele - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[10, 6] * 0.15), floor(AdeleSpec$ATKSub * 0.35)))
MagicCircuit <- data.frame(option, value)

option <- factor(c("CDMR", "ATKP"), levels=PSkill)
value <- c(10, 10)
Pace <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Rudiment <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Mastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
Train <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "CRR"), levels=PSkill)
value <- c(30, 15, 20)
Ascent <- data.frame(option, value)

option <- factor(c("ATK", "Mastery"), levels=PSkill)
value <- c(30 + AdeleSpec$PSkillLv, 70 + floor(AdeleSpec$PSkillLv/2))
Expert <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(30 + AdeleSpec$PSkillLv, 20 + AdeleSpec$PSkillLv)
Demolition <- data.frame(option, value)

option <- factor(c("ATK", "BDR", "CRR"), levels=PSkill)
value <- c(30 + AdeleSpec$PSkillLv, 10 + floor(AdeleSpec$PSkillLv/2), 20 + AdeleSpec$PSkillLv)
Attain <- data.frame(option, value)

option <- factor(c("BDR", "IGR"), levels=PSkill)
value <- c(20 + floor(AdeleSpec$SkillLv/2), 10)
GraveDebuff <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(AdeleCore[[2]][7, 2])
BodyofStealPassive <- data.frame(option, value)}

AdelePassive <- Passive(list(MagicCircuit=MagicCircuit, Pace=Pace, Rudiment=Rudiment, Mastery=Mastery, Train=Train, 
                             Ascent=Ascent, Expert=Expert, Demolition=Demolition, Attain=Attain, GraveDebuff=GraveDebuff, BodyofStealPassive=BodyofStealPassive))


## Adele - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Booster <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(10, 10)
info <- c(30, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ResonanceBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(10)
info <- c(30, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GatheringDebuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((AdeleChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(AdeleSpec$SkillLv/2))))
info <- c(900 + 30 * AdeleSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RaceofGod <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(30, 180, 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfiniteBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATKSkill"), levels=BSkill)
value <- c(15 + AdeleCore[[2]][3, 2], 1)
info <- c(30, 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RestoreBuff <- rbind(data.frame(option, value), info) ## EtherPlus

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * AdeleCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * AdeleCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(AdeleCore[[2]][5, 2]/5), ceiling(AdeleCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * AdeleCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + AdeleCore[[2]][6, 2])
info <- c(30 + AdeleCore[[2]][6, 2], 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * AdeleCore[[2]][8, 2] + (min((0.4 + 0.02 * AdeleCore[[2]][8, 2]) * AdeleSpec$ATKSub, floor(ArcaneShade[16, 6] * 1.5))))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandis <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EtherRecovery <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order1 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order3 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OrderRestore <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Ether <- rbind(data.frame(option, value), info)}

AdeleBuff <- Buff(list(Booster=Booster, ResonanceBuff=ResonanceBuff, GatheringDebuff=GatheringDebuff, MapleSoldier=MapleSoldier, RaceofGod=RaceofGod,
                       InfiniteBuff=InfiniteBuff, RestoreBuff=RestoreBuff, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, AuraWeaponBuff=AuraWeaponBuff, 
                       MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, BlessofGrandis=BlessofGrandis, Restraint4=Restraint4, SoulContractLink=SoulContractLink, EtherRecovery=EtherRecovery,
                       Order1=Order1, Order2=Order2, Order3=Order3, OrderRestore=OrderRestore, Ether=Ether))
## PetBuff : Booster, MapleSoldier
AdeleAllTimeBuff <- AllTimeBuff(AdeleBuff)


## Adele - Union & HyperStat & SoulWeapon
AdeleSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + AdelePassive$CRR + 
  (Union8000Chr$CRR) + AdeleAbility$CRR + AdeleAllTimeBuff$CRR + 5
AdeleSpec$CRR <- ifelse(AdeleCRROver==T, AdeleSpec$CRR, min(AdeleSpec$CRR, 100))
AdeleSpec$BuffDuration <- MonsterLife$BuffDuration + AdelePassive$BuffDuration + Union8000Chr$BuffDuration + floor(AdeleSensibility/10) + AdeleAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(AdeleUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, AdeleBuffDurationNeeded, AdeleSpec$BuffDuration, AdeleSpec$CRR, AdeleCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, AdeleBuffDurationNeeded - AdeleSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, AdeleBuffDurationNeeded - AdeleSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(AdeleUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Adele Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
AdeleSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$STR + Dopings$MainStat + LinkSet$MainStat + AdelePassive$MainStat + 
  AdeleAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * AdeleChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP + AdelePassive$MainStatP) / 100) + 10 * AdeleArcaneForce + Union8000Chr$STR + 20
AdeleSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$DEX + Dopings$SubStat1 + LinkSet$SubStat1 + AdelePassive$SubStat1 + 
  AdeleAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$DEX
AdeleSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + AdelePassive$ATK + Union8000Chr$ATK + AdeleAbility$CRR + 
  AdeleAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
AdeleSpec$ATKP <- sum(Weapon$ATKP) + AdelePassive$ATKP + AdeleAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
AdeleSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, AdelePassive$IGR, Union8000Chr$IGR, floor(AdeleCharisma/5)/2, 
                            AdeleAllTimeBuff$IGR, HyperStatBase$IGR))
AdeleSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + AdelePassive$BDR + Union8000Chr$BDR + AdeleAbility$BDR + AdeleAbility$DisorderBDR + 
  AdeleAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
AdeleSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + AdelePassive$CRR + 
  (Union8000Chr$CRR + ifelse(AdeleChrLv>=250, 1, 0)) + AdeleAbility$CRR + AdeleAllTimeBuff$CRR + 5
AdeleSpec$CRR <- ifelse(AdeleCRROver==T, AdeleSpec$CRR + rowSums(CRRs), min(AdeleSpec$CRR + rowSums(CRRs), 100))
AdeleSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + AdelePassive$CDMR + AdeleAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
AdeleSpec$FDR <- FDRCalc(c(AdelePassive$FDR, AdeleAllTimeBuff$FDR, ArcaneForceFDR(AdeleArcaneForce, MapArc), LevelFDR(AdeleChrLv, MobLv), 
                            (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", "AR")[19]*100-100)))
AdeleSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", "AR")[17] - Dopings$ATKSpeed - AdeleAllTimeBuff$ATKSpeed - AdelePassive$ATKSpeed, 2)
AdeleSpec$Mastery <- min(AdeleBaseMastery + AdelePassive$Mastery, 95)
AdeleSpec$BuffDuration <- AdeleSpec$BuffDuration + UnionBase$BuffDuration
AdeleSpec$SummonedDuration <- MonsterLife$SummonedDuration + AdelePassive$SummonDuration + Union8000Chr$SummonedDuration
AdeleSpec$ImmuneIgnore <- AdelePassive$ImmuneIgnore + floor(AdeleInsight/10)/2 + AdeleAllTimeBuff$ImmuneIgnore
AdeleSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + AdelePassive$CoolTimeReset + AdeleAbility$CoolTimeReset
AdeleSpec$CoolReduceP <- Union8000Chr$CoolReduce
AdeleSpec$CoolReduce <- 0
AdeleSpec$Disorder <- max(AdeleLinkBase$Disorder, AdelePassive$Disorder, AdeleAllTimeBuff$Disorder)


## Adele - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * AdeleCore[[2]][9, 2], 12, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Adele - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][6, 2]>=40, 20, 0), 2 * AdeleCore[[1]][6, 2])
info <- c(450 + 3 * AdeleSpec$SkillLv, 15, 0, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Wonder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][4, 2]>=40, 20, 0), 2 * AdeleCore[[1]][4, 2])
info <- c(710 + 3 * AdeleSpec$SkillLv, 2, 0, NA, 1.5, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Creation <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][7, 2]>=40, 20, 0), FDRCalc(c(2 * AdeleCore[[1]][7, 2], (1.15^5-1)*100)))
info <- c(510 + 3 * AdeleSpec$SkillLv, 6, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Resonance <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ResonanceMove <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][4, 2]>=40, 20, 0), 2 * AdeleCore[[1]][4, 2])
info <- c(560 + 3 * AdeleSpec$SkillLv, 4, 0, 0, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Gathering <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][3, 2]>=40, 20, 0), 2 * AdeleCore[[1]][3, 2])
info <- c(400 + 5 * AdeleSpec$SkillLv, 4, 540, 360, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Territory <- rbind(data.frame(option, value), info) ## ATKSpeed Uneffected

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][3, 2]>=40, 20, 0), 2 * AdeleCore[[1]][3, 2])
info <- c(850 + 5 * AdeleSpec$SkillLv, 12, 0, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TerritoryExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][1, 2]>=40, 20, 0), 20, 2 * AdeleCore[[1]][1, 2])
info <- c(375 + 3 * AdeleSpec$SkillLv, 6, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Divide <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][5, 2]>=40, 20, 0), 2 * AdeleCore[[1]][5, 2])
info <- c(650 + 6 * AdeleSpec$SkillLv, 8, 420, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blossom1st <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][5, 2]>=40, 20, 0), 2 * AdeleCore[[1]][5, 2])
info <- c((650 + 6 * AdeleSpec$SkillLv) * 0.75, 8, 0, NA, Cooldown(20, T, 25 + AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlossomRemain <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][2, 2]>=40, 20, 0), 2 * AdeleCore[[1]][2, 2])
info <- c(800 + 20 * AdeleSpec$SkillLv, 10, 840, NA, 90, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Grave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][7, 2]>=40, 20, 0), 2 * AdeleCore[[1]][7, 2])
info <- c(4000, 6, 900, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Marker <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * AdeleCore[[2]][1, 2], 6, 780, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ruin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * AdeleCore[[2]][1, 2], 9, 0, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RuinExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * AdeleCore[[2]][2, 2], 36, 0, 1050, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Infinite <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 36 * AdeleCore[[2]][3, 2], 3, 0, 3000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Restore <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * AdeleCore[[2]][4, 2], 2, 780, 300, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Storm <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * AdeleCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * AdeleCore[[2]][6, 2], 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

AdeleATK <- Attack(list(Wonder=Wonder, Creation=Creation, Resonance=Resonance, ResonanceMove=ResonanceMove, Gathering=Gathering, Territory=Territory, TerritoryExplosion=TerritoryExplosion,
                        Divide=Divide, Blossom1st=Blossom1st, BlossomRemain=BlossomRemain, Grave=Grave, Marker=Marker, Ruin=Ruin, RuinExplosion=RuinExplosion, Infinite=Infinite, 
                        Restore=Restore, Storm=Storm, AuraWeapon=AuraWeapon, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Adele - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(AdeleCore[[1]][2, 2]>=40, 20, 0), 2 * AdeleCore[[1]][2, 2])
info <- c(360 + 3 * AdeleSpec$SkillLv, 4, 0, 1050, 1000, 0.5, F, F, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Order <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 0, 40, 0.5, F, F, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
OrderDummy <- rbind(data.frame(option, value), info)}

AdeleSummoned <- Summoned(list(Order=Order, OrderDummy=OrderDummy, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                               SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Adele - DealCycle & Deal Calculation
ATKFinal <- data.frame(AdeleATK)
ATKFinal$Delay[c(-6)] <- Delay(ATKFinal$Delay, AdeleSpec$ATKSpeed)[c(-6)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)

BuffFinal <- data.frame(AdeleBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, AdeleSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(AdeleSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * AdeleSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(AdeleBuff))
AdeleDealCycle <- t(rep(0, length(DealCycle)))
colnames(AdeleDealCycle) <- DealCycle
AdeleDealCycle <- data.frame(AdeleDealCycle)
AdeleDealCycle$Ether <- 400

AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Booster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "AuraWeaponBuff", "MagicCircuitFullDriveBuff", 
                                                   "BlessofGrandis"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Territory"), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("SpiderInMirror"), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Infinite"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("InfiniteBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Restore"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("RestoreBuff"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("Order"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("OrderRestore"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)
AdeleDealCycle <- StormATKCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("SoulContractLink"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Restraint4"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Ruin", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("OrderRestore"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Grave", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 14), "Territory"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 13)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 7), "Marker"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 12)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 3), "Territory", rep("Divide", 7)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 10)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Ruin", 1), rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8), "Territory", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("SoulContractLink"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 2), "Grave", rep("Divide", 3)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 5)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Marker", rep("Divide", 11), "Territory", rep("Divide", 5)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("RaceofGod", "GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 15), "Ruin", "Divide"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 14), "Territory"), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 9)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 14)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)

AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "AuraWeaponBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Territory"), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Infinite"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("InfiniteBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Restore"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("RestoreBuff"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("Order"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("OrderRestore"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 15)), ATKFinal)
AdeleDealCycle <- StormATKCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("SoulContractLink"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Restraint4"), BuffFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Ruin", 1)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("OrderRestore"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Grave", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 14), "Territory"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 13)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 7), "Marker"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 12)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 3), "Territory", rep("Divide", 7)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("RaceofGod", "GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 10)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Ruin", 1), rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8), "Territory", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 8)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("SoulContractLink"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 2), "Grave", rep("Divide", 3)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 5)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Marker", rep("Divide", 11), "Territory", rep("Divide", 5)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 15), "Ruin", "Divide"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("ResonanceBuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 3)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order3"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 15), "Territory"), ATKFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 4)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order1"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 9)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("Order2"), BuffFinal)
AdeleDealCycle <- AdeleSummonedCycle(AdeleDealCycle, c("OrderDummy"), SummonedFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c(rep("Divide", 14)), ATKFinal)
AdeleDealCycle <- AdeleBuffCycle(AdeleDealCycle, c("GatheringDebuff"), BuffFinal)
AdeleDealCycle <- AdeleATKCycle(AdeleDealCycle, c("Gathering", "Blossom1st", rep("Divide", 12)), ATKFinal)

AdeleDealCycle <- DealCycleFinal(AdeleDealCycle)
AdeleDealCycle <- RuinTerritoryCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- GatheringBlossomWonderCreationCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- StormRepATKCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- AdeleOrderCycle(AdeleDealCycle, SummonedFinal)
AdeleDealCycle <- RepATKCycle(AdeleDealCycle, "Infinite", 29, 0, ATKFinal)
AdeleDealCycle <- RepATKCycle(AdeleDealCycle, "Restore", 10, 3000, ATKFinal)
AdeleDealCycle <- AdeleMCFAWCycle(AdeleDealCycle, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycle <- DCSpiderInMirror(AdeleDealCycle, SummonedFinal)
AdeleDealCycleReduction <- DealCycleReduction(AdeleDealCycle)

DealCalc(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpec)

AdeleSpecOpt1 <- Optimization1(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpec, UnionRemained)
AdeleSpecOpt <- AdeleSpec
AdeleSpecOpt$ATKP <- AdeleSpecOpt$ATKP + AdeleSpecOpt1$ATKP
AdeleSpecOpt$BDR <- AdeleSpecOpt$BDR + AdeleSpecOpt1$BDR
AdeleSpecOpt$IGR <- IGRCalc(c(AdeleSpecOpt$IGR, AdeleSpecOpt1$IGR))

AdeleSpecOpt2 <- Optimization2(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt, HyperStatBase, AdeleChrLv, AdeleCRROver)
AdeleFinalDPM <- DealCalc(AdeleDealCycle, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt2)
AdeleFinalDPMwithMax <- DealCalcWithMaxDMR(AdeleDealCycle, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt2)

DPMTver$Adele[1] <- sum(na.omit(AdeleFinalDPMwithMax)) / (346950 / 60000)
DPMTver$Adele[2] <- sum(na.omit(AdeleFinalDPM)) / (346950 / 60000) - sum(na.omit(AdeleFinalDPMwithMax)) / (346950 / 60000)

AdeleDealRatio <- DealRatio(AdeleDealCycle, AdeleFinalDPMwithMax)

AdeleDealData <- data.frame(AdeleDealCycle$Skills, AdeleDealCycle$Time, AdeleDealCycle$Restraint4, AdeleFinalDPMwithMax, AdeleFinalDPM-AdeleFinalDPMwithMax)
colnames(AdeleDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(AdeleDealData, AdeleDealData$Leakage > 0)

AdeleRR <- AdeleDealData[188:565, ]
sum((AdeleRR$Deal)) ## 5,584,350,395,323

Adele40s <-  AdeleDealData[24:712, ]
sum((Adele40s$Deal)) ## 9,654,505,978,950