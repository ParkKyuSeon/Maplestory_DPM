## Marksman - Data
## Marksman - VMatrix
PasSkills <- c("Snipe", "Piercing", "Freezer", "FinalAttack")
PasLvs <- c(50, 50, 50, 50)
PasMP <- c(10, 10, 5, 5)
ActSkills <- c("TrueSnipe", "SplitArrow", "ChargedArrow", "FullbustShot",
               "GuidedArrow", "Evolve", "CriticalReinforce", "MapleWarriors2",
               "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 5, 5, 5)
UsefulSkills <- c("CombatOrders", "WindBooster")
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
MarksmanCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Marksman - Basic Info
MarksmanClass1 <- ChrInfo[8, 2]
MarksmanClass2 <- ChrInfo[8, 3]
MarksmanMainStatType <- ChrInfo[8, 4]
MarksmanSubStat1Type <- ChrInfo[8, 5]
MarksmanChrLv <- ChrInfo[8, 7]
MarksmanUnionLv <- ChrInfo[8, 8]
MarksmanArcaneForce <- ChrInfo[8, 9]
MarksmanCharisma <- ChrInfo[8, 10]
MarksmanInsight <- ChrInfo[8, 11]
MarksmanSensibility <- ChrInfo[8, 12]
MarksmanBaseMastery <- ChrInfo[8, 13]
MarksmanCRROver <- T
MarksmanBuffDurationNeeded <- ceiling((171 / 110 - 1)*100)
Distance <- 400

MarksmanAbility <- Abilities(c("BDR", "BuffDuration"), c("L", "E"))

MarksmanLinkBase <- rbind(LinkBase)
MarksmanDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(MarksmanDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(MarksmanDisorder==T, 6, 0)+ifelse(MarksmanChrLv>MobLv, 6, 0), 0, 0, 0)
MarksmanLinkBase <- rbind(LinkBase, Mikhail, DemonAvenger, Phantom, AdventureBowman)
MarksmanLinkBase <- data.frame(MarksmanLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(MarksmanLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(MarksmanLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(MarksmanLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeD21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", "AR")[, 1:16], SubWeapon[8, ], Emblem[1, ])
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
MarksmanSpec <- data.frame(t(rep(0, 21)))
colnames(MarksmanSpec) <- Specs

MarksmanSpec$SkillLv <- sum(MarksmanCore[[3]][, 1]=="CombatOrders")
MarksmanSpec$PSkillLv <- sum(MarksmanCore[[3]][, 1]=="CombatOrders") + MarksmanAbility$PassiveLv
MarksmanSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100


## Marksman - Passive
{option <- factor("CRR", levels=PSkill)
value <- c(40)
CriticalShot <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor("CDMR", levels=PSkill)
value <- c(20)
ExtremeArchery <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(25, 15)
Marksmanship <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(MarksmanSpec$PSkillLv/2), 30 + MarksmanSpec$PSkillLv, 8)
CrossbowExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40 + MarksmanSpec$PSkillLv)
IllusionStep <- data.frame(option, value)}

MarksmanPassive <- Passive(list(CriticalShot, PhysicalTraining, ExtremeArchery, Marksmanship, 
                                IllusionStep, CrossbowExpert))


## Marksman - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrossbowBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulArrow <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MarksmanChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MarksmanSpec$SkillLv/2))))
info <- c(900 + 30 * MarksmanSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(MarksmanSpec$SkillLv/2), 15 + ceiling(MarksmanSpec$SkillLv/2))
info <- c(300 + 3 * MarksmanSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MarksmanCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MarksmanCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR", "IGR", "BDR"), levels=BSkill)
value <- c(20, 10, 20, 20)
info <- c(30, 90, 960, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bullseye <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 810, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SplitArrowBuff <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 660, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FullbustShotBuff <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(MarksmanSpec$CRR * (0.2 + 0.01 * MarksmanCore[[2]][7, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * MarksmanCore[[2]][8, 2]) * MapleSoldier[1, 2]) * MarksmanSpec$MainStatP), 5 + floor(MarksmanCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(IGRCalc(c(30, 10 + ifelse(MarksmanSpec$PSkillLv>0, 5, 4))))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Distance0 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(ifelse(Distance>=200, min(40+MarksmanSpec$PSkillLv, floor((Distance-200)/18)*4), 0), 
           ifelse(Distance<200, min(30+MarksmanSpec$PSkillLv, floor((200-Distance)/18)*3), 0))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DistancingSense <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(min(10 + ifelse(MarksmanSpec$PSkillLv>0, 5, 4) + MarksmanSpec$PSkillLv + floor(Distance/40)*ifelse(MarksmanSpec$PSkillLv>0, 5, 4), 50 + MarksmanSpec$PSkillLv))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaknessFinding <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(20 + 2 * MarksmanSpec$PSkillLv)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LastmanStanding <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(2)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MotalBlow <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(20 * (0.2 + 0.01 * MarksmanCore[[2]][7, 2]))
info <- c(0, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Synergy <- rbind(data.frame(option, value), info)}

MarksmanBuff <- Buff(list(CrossbowBooster=CrossbowBooster, SoulArrow=SoulArrow, MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, UsefulWindBooster=UsefulWindBooster, 
                          UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                          SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, CriticalReinforce=CriticalReinforce, Synergy=Synergy, Distance0=Distance0, 
                          DistancingSense=DistancingSense, WeaknessFinding=WeaknessFinding, LastmanStanding=LastmanStanding, MotalBlow=MotalBlow, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
### PetBuff : CrossbowBooster, SoulArrow, SharpEyes

MarksmanAllTimeBuff <- AllTimeBuff(MarksmanBuff)


## Marksman - Union & HyperStat & SoulWeapon
MarksmanSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + MarksmanPassive$CRR + 
  (Union8000Chr$CRR + ifelse(MarksmanChrLv>=250, 1, 0)) + MarksmanAbility$CRR + MarksmanAllTimeBuff$CRR + 5
MarksmanSpec$CRR <- ifelse(MarksmanCRROver==T, MarksmanSpec$CRR, min(MarksmanSpec$CRR, 100))
MarksmanSpec$BuffDuration <- MonsterLife$BuffDuration + MarksmanPassive$BuffDuration + Union8000Chr$BuffDuration + floor(MarksmanSensibility/10) + MarksmanAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(MarksmanUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, MarksmanBuffDurationNeeded, MarksmanSpec$BuffDuration, MarksmanSpec$CRR, MarksmanCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, MarksmanBuffDurationNeeded - MarksmanSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, MarksmanBuffDurationNeeded - MarksmanSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(MarksmanUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Marksman Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
MarksmanSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$DEX + Dopings$MainStat + LinkSet$MainStat + MarksmanPassive$MainStat + 
  MarksmanAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * MarksmanChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP) / 100) + 10 * MarksmanArcaneForce + Union8000Chr$DEX
MarksmanSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$STR + Dopings$SubStat1 + LinkSet$SubStat1 + MarksmanPassive$SubStat1 + 
  MarksmanAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$STR
MarksmanSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + MarksmanPassive$ATK + Union8000Chr$ATK + MarksmanAbility$CRR + 
  MarksmanAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
MarksmanSpec$ATKP <- sum(Weapon$ATKP) + MarksmanPassive$ATKP + MarksmanAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
MarksmanSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, MarksmanPassive$IGR, Union8000Chr$IGR, floor(MarksmanCharisma/5)/2, 
  MarksmanAllTimeBuff$IGR, HyperStatBase$IGR))
MarksmanSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + MarksmanPassive$BDR + Union8000Chr$BDR + MarksmanAbility$BDR + MarksmanAbility$DisorderBDR + 
  MarksmanAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
MarksmanSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + MarksmanPassive$CRR + 
  (Union8000Chr$CRR + ifelse(MarksmanChrLv>=250, 1, 0)) + MarksmanAbility$CRR + MarksmanAllTimeBuff$CRR + 5
MarksmanSpec$CRR <- ifelse(MarksmanCRROver==T, MarksmanSpec$CRR + rowSums(CRRs), min(MarksmanSpec$CRR + rowSums(CRRs), 100))
MarksmanSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + MarksmanPassive$CDMR + MarksmanAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
MarksmanSpec$FDR <- FDRCalc(c(MarksmanPassive$FDR, MarksmanAllTimeBuff$FDR, ArcaneForceFDR(MarksmanArcaneForce, MapArc), LevelFDR(MarksmanChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", "AR")[19]*100-100)))
MarksmanSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", "AR")[17] - Dopings$ATKSpeed - MarksmanAllTimeBuff$ATKSpeed - MarksmanPassive$ATKSpeed, 2)
MarksmanSpec$Mastery <- min(MarksmanBaseMastery + MarksmanPassive$Mastery, 95)
MarksmanSpec$BuffDuration <- MarksmanSpec$BuffDuration + UnionBase$BuffDuration
MarksmanSpec$SummonedDuration <- MonsterLife$SummonedDuration + MarksmanPassive$SummonDuration + Union8000Chr$SummonedDuration
MarksmanSpec$ImmuneIgnore <- MarksmanPassive$ImmuneIgnore + floor(MarksmanInsight/10)/2 + MarksmanAllTimeBuff$ImmuneIgnore
MarksmanSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + MarksmanPassive$CoolTimeReset + MarksmanAbility$CoolTimeReset
MarksmanSpec$CoolReduceP <- Union8000Chr$CoolReduce
MarksmanSpec$CoolReduce <- 0
MarksmanSpec$Disorder <- max(MarksmanLinkBase$Disorder, MarksmanPassive$Disorder, MarksmanAllTimeBuff$Disorder)


## Marksman - CriticalReinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(MarksmanSpec$CRR * (0.2 + 0.01 * MarksmanCore[[2]][7, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}

MarksmanBuff <- Buff(list(CrossbowBooster=CrossbowBooster, SoulArrow=SoulArrow, MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, UsefulWindBooster=UsefulWindBooster, 
                          UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                          SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, CriticalReinforce=CriticalReinforce, Synergy=Synergy, Distance0=Distance0, 
                          DistancingSense=DistancingSense, WeaknessFinding=WeaknessFinding, LastmanStanding=LastmanStanding, MotalBlow=MotalBlow, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## Marksman - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MarksmanCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Marksman - Attacks
{option <- factor(c("IGR", "BDR", "CRR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20 + ceiling(MarksmanSpec$SkillLv/3)*2, ifelse(MarksmanCore[[1]][1, 2]>=40, 20, 0))), 
           30, 100, 2 * MarksmanCore[[1]][1, 2])
info <- c(465 + MarksmanSpec$SkillLv * 5, 10, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Snipe <- rbind(data.frame(option, value), info)

option <- factor(c("WhenBuffOnly"), levels=ASkill)
value <- c(T)
info <- c(600 + 24 * MarksmanCore[[2]][2, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SplitArrow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrowStart <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "CRR"), levels=ASkill)
value <- c(50, 100)
info <- c(750 + 30 * MarksmanCore[[2]][3, 2], 11, 480, NA, 10, T, F, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "CRR"), levels=ASkill)
value <- c(50, 100)
info <- c(500 + 20 * MarksmanCore[[2]][3, 2], 11, 480, NA, 10, T, F, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrowUncharged <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR"), levels=ASkill)
value <- c(100, 100, 100)
info <- c(0, 0, 150, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TrueSnipeStart <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR"), levels=ASkill)
value <- c(100, 100, 100)
info <- c(950 + 30 * MarksmanCore[[2]][1, 2], 15, 900, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TrueSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "WhenBuffOnly"), levels=ASkill)
value <- c(25, T)
info <- c(300 + 12 * MarksmanCore[[2]][4, 2], 24, 1080, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FullbustShot <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MarksmanCore[[1]][4, 2]>=40, 20, 0), 4 * MarksmanCore[[1]][4, 2])
info <- c(140, 0.4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)}

MarksmanATK <- Attack(list(Snipe=Snipe, SplitArrow=SplitArrow, ChargedArrowStart=ChargedArrowStart, ChargedArrow=ChargedArrow, ChargedArrowUncharged=ChargedArrowUncharged, 
                           TrueSnipe=TrueSnipe, TrueSnipeStart=TrueSnipeStart, FullbustShot=FullbustShot, FinalAttack=FinalAttack, 
                           SpiderInMirror=SpiderInMirror))


## Marksman - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 15 * MarksmanCore[[2]][6, 2], 7, 600, 3030, 40, 105, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Evolve <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * MarksmanCore[[1]][3, 2], ifelse(MarksmanCore[[1]][3, 2]>=40, 20, 0))
info <- c(390, 1, 0, 3030, 220, 105, T, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Freezer <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * MarksmanCore[[2]][5, 2], 1, 720, 500, 0.5*89+0.72+0.01, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

MarksmanSummoned <- Summoned(list(Evolve=Evolve, Freezer=Freezer, GuidedArrow=GuidedArrow, SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Marksman - DealCycle & Deal Calculation
ATKFinal <- data.frame(MarksmanATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, MarksmanSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)

BuffFinal <- data.frame(MarksmanBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MarksmanSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(MarksmanSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MarksmanSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(MarksmanBuff))
MarksmanDealCycle <- t(rep(0, length(DealCycle)))
colnames(MarksmanDealCycle) <- DealCycle

MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("CrossbowBooster", "SoulArrow", "SharpEyes", "MapleSoldier", 
                                                 "UsefulWindBooster", "UsefulCombatOrders"), BuffFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("SpiderInMirror"), ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="Evolve", SummonedFinal)
MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("FullbustShotBuff", "MapleWarriors2", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "Restraint4", "EpicAdventure"), BuffFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("FullbustShot", 8)), T, ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("TrueSnipeStart", rep("TrueSnipe", 7)), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 13)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 14)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 7)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="Evolve", SummonedFinal)
MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("FullbustShotBuff", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "EpicAdventure"), BuffFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("FullbustShot"), ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("FullbustShot"), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("FullbustShot", 6), rep("Snipe", 12)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 9)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("Snipe"), ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("Snipe"), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 11)), T, ATKFinal)

MarksmanDealCycle <- DealCycleFinal(MarksmanDealCycle)
MarksmanDealCycle <- AddATKsCycle(MarksmanDealCycle)
MarksmanDealCycle <- DCSummonedATKs(MarksmanDealCycle, Skill=c("GuidedArrow", "Evolve"), SummonedFinal)
MarksmanDealCycle <- DCSpiderInMirror(MarksmanDealCycle, SummonedFinal)
MarksmanDealCycle <- EvolveCycle(MarksmanDealCycle)
MarksmanDealCycle <- MarksmanSynergy(MarksmanDealCycle)
MarksmanDealCycle <- MarksmanDistance(MarksmanDealCycle)

MarksmanDealCycleReduction <- DealCycleReduction(MarksmanDealCycle)

DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec)
MarksmanDealData <- data.frame(MarksmanDealCycle$Skills, DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec))
colnames(MarksmanDealData) <- c("Skills", "Deal")


## Damage Optimization
MarksmanSpecOpt1 <- Optimization1(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec, UnionRemained)
MarksmanSpecOpt <- MarksmanSpec
MarksmanSpecOpt$ATKP <- MarksmanSpecOpt$ATKP + MarksmanSpecOpt1$ATKP
MarksmanSpecOpt$BDR <- MarksmanSpecOpt$BDR + MarksmanSpecOpt1$BDR
MarksmanSpecOpt$IGR <- IGRCalc(c(MarksmanSpecOpt$IGR, MarksmanSpecOpt1$IGR))

MarksmanSpecOpt2 <- Optimization2(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt, HyperStatBase, MarksmanChrLv, MarksmanCRROver)
MarksmanFinalDPM <- DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)
MarksmanFinalDPMwithMax <- DealCalcWithMaxDMR(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)
MarksmanFinalDPM - MarksmanFinalDPMwithMax

DPM12338$Marksman[1] <- sum(na.omit(MarksmanFinalDPMwithMax))/(233910/60000)
DPM12338$Marksman[2] <- sum(na.omit(MarksmanFinalDPM))/(233910/60000) - sum(na.omit(MarksmanFinalDPMwithMax))/(233910/60000)


## Restraint Deal and 40s Damage
MRestraint <- data.frame(MarksmanDealCycle$Skills, MarksmanFinalDPMwithMax, MarksmanDealCycle$Time, MarksmanDealCycle$Restraint4)
colnames(MRestraint) <- c("Skills", "Damage", "Time", "R4")
MRestraint <- subset(MRestraint, MRestraint$R4>0)
DPM12338$Marksman[3] <- sum(MRestraint$Damage)

Marksman40s <- data.frame(MarksmanDealCycle$Skills, MarksmanFinalDPMwithMax, MarksmanDealCycle$Time, MarksmanDealCycle$Restraint4)
colnames(Marksman40s) <- c("Skills", "Damage", "Time", "R4")
Marksman40s <- Marksman40s[37:355, ]
DPM12338$Marksman[4] <- sum((Marksman40s$Damage))


## Damage Distribution
Mastery <- 0.85
CriticalDamage <- 1.23

plot(x=c(), y=c(), xlim=c(Mastery*(CriticalDamage+1.2), CriticalDamage+1.5), ylim=c(0, 4), main="Damage Distribution", ylab="", xlab="Mastery*CDMR")
curve(log(x/(Mastery*(CriticalDamage+1.2)))*(1/((1-Mastery)*0.3)), add=T, from=Mastery*(CriticalDamage+1.2), to=Mastery*(CriticalDamage+1.5))
curve(log((CriticalDamage+1.5)/(CriticalDamage+1.2))*(1/((1-Mastery)*0.3)) + 0*x, add=T, from=Mastery*(CriticalDamage+1.5), to=CriticalDamage+1.2)
curve(log((CriticalDamage+1.5)/x)*(1/((1-Mastery)*0.3)), add=T, from=CriticalDamage+1.2, to=CriticalDamage+1.5)

Mastery <- 0.95
CriticalDamage <- 0.8

plot(x=c(), y=c(), xlim=c(Mastery*(CriticalDamage+1.2), CriticalDamage+1.5), ylim=c(0, 4), main="Damage Distribution", ylab="", xlab="Mastery*CDMR")
curve(log(x/(Mastery*(CriticalDamage+1.2)))*(1/((1-Mastery)*0.3)), add=T, from=Mastery*(CriticalDamage+1.2), to=CriticalDamage+1.2)
curve(log(1/Mastery)*(1/((1-Mastery)*0.3)) + 0*x, add=T, from=CriticalDamage+1.2, to=Mastery*(CriticalDamage+1.5))
curve(log((CriticalDamage+1.5)/x)*(1/((1-Mastery)*0.3)), add=T, from=Mastery*(CriticalDamage+1.5), to=CriticalDamage+1.5)

curve(log(x/(Mastery*(CriticalDamage+1.2)))*(1/((1-Mastery)*0.3)), xlim=c(0, 3))


## Marksman Deal Ratio
MarksmanDealRatio <- DealRatio(MarksmanDealCycle, MarksmanFinalDPMwithMax)