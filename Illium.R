## Illium - Data
## Illium - VMatrix
PasSkills <- c("Javelin_EnhancedJavelin", "Destruction", "Machina_Domination", "Deus_Liyo", "CurseMark", "MotalSwing_MotalWingBeat")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 10, 10, 10)
ActSkills <- c("CrystalIgnition", "Gramholder", "SoulofCrystal", "CrystalGate",
               "OverloadMana", "MagicCircuitFullDrive", "EtherealForm", "BlessofGrandis", "SpiderInMirror")
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
IlliumCore <- list(PassiveCore, ActiveCore, UsefulCore)


## Illium - Basic Info
IlliumClass1 <- ChrInfo[36, 2]
IlliumClass2 <- ChrInfo[36, 3]
IlliumMainStatType <- ChrInfo[36, 4]
IlliumSubStat1Type <- ChrInfo[36, 5]
IlliumChrLv <- ChrInfo[36, 7]
IlliumUnionLv <- ChrInfo[36, 8]
IlliumArcaneForce <- ChrInfo[36, 9]
IlliumCharisma <- ChrInfo[36, 10]
IlliumInsight <- ChrInfo[36, 11]
IlliumSensibility <- ChrInfo[36, 12]
IlliumBaseMastery <- ChrInfo[36, 13]
IlliumCRROver <- F
IlliumBuffDurationNeeded <- 0

IlliumAbility <- Abilities(c("CoolTimeReset", "BuffDuration"), c("L", "E"))

IlliumLinkBase <- rbind(LinkBase)
IlliumDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(IlliumDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(IlliumDisorder==T, 6, 0)+ifelse(IlliumChrLv>MobLv, 6, 0), 0, 0, 0)
IlliumLinkBase <- rbind(LinkBase, DemonAvenger, Zero, Phantom) ## Illium Link
IlliumLinkBase <- data.frame(IlliumLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(IlliumLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(IlliumLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(IlliumLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeI21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "MagicGuntlet", "AR")[, 1:16], SubWeapon[18, ], Emblem[3, ])
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

Specs <- c("MainStat", "SubStat1", "ATK", "ATKP", "ATKSub", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
           "SummonedDuration", "ImmuneIgnore", "CoolTimeReset", "SkillLv", "PSkillLv", "CoolReduceP", "CoolReduce", "Disorder", "MainStatP")
IlliumSpec <- data.frame(t(rep(0, 22)))
colnames(IlliumSpec) <- Specs

IlliumSpec$SkillLv <- sum(IlliumCore[[3]][, 1]=="CombatOrders")
IlliumSpec$PSkillLv <- sum(IlliumCore[[3]][, 1]=="CombatOrders") + IlliumAbility$PassiveLv
IlliumSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100 
IlliumSpec$ATKSub <- sum(Item$ATKSub[1:(nrow(Item)-2)])


## Illium - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[16, 6] * 0.2), floor(IlliumSpec$ATKSub * 0.5)))
MagicCircuit <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(20)
MagicGuntlet <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
BlessMark <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
LefMastery <- data.frame(option, value)

option <- factor(c("ATK", "ATKP"), levels=PSkill)
value <- c(40, 10)
Tenacity <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(50, 30, 20)
EndlessResearch <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(46)
BlessMarkCompletion <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(20)
CurseMarkCompletion <- data.frame(option, value)

option <- factor(c("Mastery", "ATKSpeed", "BDR", "IGR", "FDR"), levels=PSkill)
value <- c(70, 1, 30, 25, 35)
WisdomoftheCrystal <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(5 + 2 * IlliumCore[[2]][3, 2])
SoulofCrystal <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(IlliumCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only
}

IlliumPassive <- Passive(list(MagicCircuit=MagicCircuit, MagicGuntlet=MagicGuntlet, BlessMark=BlessMark, LefMastery=LefMastery, Tenacity=Tenacity, EndlessResearch=EndlessResearch, 
                              BlessMarkCompletion=BlessMarkCompletion, CurseMarkCompletion=CurseMarkCompletion, WisdomoftheCrystal=WisdomoftheCrystal, SoulofCrystal=SoulofCrystal))


## Illium - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicGuntletBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(2, 2000, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBuffDummy <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(15)
info <- c(2, 2000, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR"), levels=BSkill)
value <- c(25, 30)
info <- c(20, 60, 30, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryWing <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((IlliumChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(IlliumSpec$SkillLv/2))))
info <- c(900 + 30 * IlliumSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, NA, 30, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FastCharge <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RaceofGod <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * IlliumCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * IlliumCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal1 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal2 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + IlliumCore[[2]][3, 2])
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal1Glory <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + IlliumCore[[2]][3, 2])
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal2Glory <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "ATKSkill"), levels=BSkill)
value <- c(5 + 2 * IlliumCore[[2]][4, 2], 1)
info <- c(ceiling((130 + IlliumCore[[2]][4, 2]) / (25 + ServerLag)) * (25 + ServerLag), 180, 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrystalGateBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + IlliumCore[[2]][6, 2])
info <- c(30 + IlliumCore[[2]][6, 2], 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * IlliumCore[[2]][8, 2] + (min((0.4 + 0.02 * IlliumCore[[2]][8, 2]) * IlliumSpec$ATKSub, floor(ArcaneShade[16, 6] * 1.5))))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandis <- rbind(data.frame(option, value), info)}

IlliumBuff <- Buff(list(MagicGuntletBooster=MagicGuntletBooster, JavelinBuffDummy=JavelinBuffDummy, JavelinBuff=JavelinBuff, GloryWing=GloryWing, MapleSoldier=MapleSoldier, FastCharge=FastCharge, 
                        RaceofGod=RaceofGod, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, SoulofCrystal1=SoulofCrystal1, SoulofCrystal2=SoulofCrystal2, 
                        SoulofCrystal1Glory=SoulofCrystal1Glory, SoulofCrystal2Glory=SoulofCrystal2Glory, CrystalGateBuff=CrystalGateBuff, MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, 
                        BlessofGrandis=BlessofGrandis, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
IlliumAllTimeBuff <- AllTimeBuff(IlliumBuff)
## PetBuff : MagicGuntletBooster, MapleSoldier


## Illium - Union & HyperStat & SoulWeapon
IlliumSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + IlliumPassive$CRR + 
  (Union8000Chr$CRR) + IlliumAbility$CRR + IlliumAllTimeBuff$CRR + 5
IlliumSpec$CRR <- ifelse(IlliumCRROver==T, IlliumSpec$CRR, min(IlliumSpec$CRR, 100))
IlliumSpec$BuffDuration <- MonsterLife$BuffDuration + IlliumPassive$BuffDuration + Union8000Chr$BuffDuration + floor(IlliumSensibility/10) + IlliumAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(IlliumUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, IlliumBuffDurationNeeded, IlliumSpec$BuffDuration, IlliumSpec$CRR, IlliumCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, IlliumBuffDurationNeeded - IlliumSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, IlliumBuffDurationNeeded - IlliumSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(IlliumUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## Illium Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
IlliumSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$INT + Dopings$MainStat + LinkSet$MainStat + IlliumPassive$MainStat + 
  IlliumAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * IlliumChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP + IlliumPassive$MainStatP) / 100) + 10 * IlliumArcaneForce + Union8000Chr$INT + 20
IlliumSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$LUK + Dopings$SubStat1 + LinkSet$SubStat1 + IlliumPassive$SubStat1 + 
  IlliumAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$LUK
IlliumSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + IlliumPassive$ATK + Union8000Chr$ATK + IlliumAbility$CRR + 
  IlliumAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
IlliumSpec$ATKP <- sum(Weapon$ATKP) + IlliumPassive$ATKP + IlliumAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
IlliumSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, IlliumPassive$IGR, Union8000Chr$IGR, floor(IlliumCharisma/5)/2, 
  IlliumAllTimeBuff$IGR, HyperStatBase$IGR))
IlliumSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + IlliumPassive$BDR + Union8000Chr$BDR + IlliumAbility$BDR + IlliumAbility$DisorderBDR + 
  IlliumAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
IlliumSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + IlliumPassive$CRR + 
  (Union8000Chr$CRR + ifelse(IlliumChrLv>=250, 1, 0)) + IlliumAbility$CRR + IlliumAllTimeBuff$CRR + 5
IlliumSpec$CRR <- ifelse(IlliumCRROver==T, IlliumSpec$CRR + rowSums(CRRs), min(IlliumSpec$CRR + rowSums(CRRs), 100))
IlliumSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + IlliumPassive$CDMR + IlliumAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
IlliumSpec$FDR <- FDRCalc(c(IlliumPassive$FDR, IlliumAllTimeBuff$FDR, ArcaneForceFDR(IlliumArcaneForce, MapArc), LevelFDR(IlliumChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "MagicGuntlet", "AR")[19]*100-100)))
IlliumSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "MagicGuntlet", "AR")[17] - Dopings$ATKSpeed - IlliumAllTimeBuff$ATKSpeed - IlliumPassive$ATKSpeed, 2)
IlliumSpec$Mastery <- min(IlliumBaseMastery + IlliumPassive$Mastery, 95)
IlliumSpec$BuffDuration <- IlliumSpec$BuffDuration + UnionBase$BuffDuration
IlliumSpec$SummonedDuration <- MonsterLife$SummonedDuration + IlliumPassive$SummonDuration + Union8000Chr$SummonedDuration
IlliumSpec$ImmuneIgnore <- IlliumPassive$ImmuneIgnore + floor(IlliumInsight/10)/2 + IlliumAllTimeBuff$ImmuneIgnore
IlliumSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + IlliumPassive$CoolTimeReset + IlliumAbility$CoolTimeReset
IlliumSpec$CoolReduceP <- Union8000Chr$CoolReduce
IlliumSpec$CoolReduce <- 0
IlliumSpec$Disorder <- max(IlliumLinkBase$Disorder, IlliumPassive$Disorder, IlliumAllTimeBuff$Disorder)


## Illium - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * IlliumCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Illium - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][6, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(600 + 2 * IlliumSpec$SkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalSwing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][2, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][2, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(550, 8 * (100 + IlliumSpec$CoolTimeReset) / 100, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Destruction <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(550, 2 * (100 + IlliumSpec$CoolTimeReset) / 100, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Domination <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(550 * (0.01 * IlliumCore[[2]][3, 2] + 0.5), 2, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DominationSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][2, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][2, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(550 * (0.01 * IlliumCore[[2]][3, 2] + 0.5), 8, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DestructionSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 12, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Javelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 4, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], 40, floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(465 + 3 * IlliumSpec$SkillLv, 7, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnhancedJavelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, 2 * IlliumCore[[1]][1, 2])
info <- c(250 + 5 * IlliumSpec$SkillLv, 9, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicMissile <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(300 + 4 * IlliumSpec$SkillLv, 1, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Orb <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][6, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(1070 + 20 * IlliumSpec$SkillLv, 15, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalWingBeat <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), 2 * IlliumCore[[1]][6, 2])
info <- c(200, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CurseMark <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), 2 * IlliumCore[[1]][6, 2])
info <- c(200, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CurseMarkJavelin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 720, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnitionPre <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(20, floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(750 + 30 * IlliumCore[[2]][1, 2], 4, 10000, 160, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnition <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 630, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnitionEnd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(20, floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(1000 + 40 * IlliumCore[[2]][1, 2], 5, 0, 1000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReactionSpectrum <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * IlliumCore[[2]][4, 2], 5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalGate <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * IlliumCore[[2]][6, 2], 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

IlliumATK <- Attack(list(MotalSwing=MotalSwing, Destruction=Destruction, Domination=Domination, DestructionSoul=DestructionSoul, DominationSoul=DominationSoul, 
                         Javelin=Javelin, JavelinAddATK=JavelinAddATK, JavelinFragment=JavelinFragment, JavelinAddFragment=JavelinAddFragment, EnhancedJavelin=EnhancedJavelin, MagicMissile=MagicMissile, Orb=Orb, 
                         MotalWingBeat=MotalWingBeat, CurseMark=CurseMark, CurseMarkJavelin=CurseMarkJavelin, CrystalIgnitionPre=CrystalIgnitionPre, CrystalIgnition=CrystalIgnition, 
                         CrystalIgnitionEnd=CrystalIgnitionEnd, ReactionSpectrum=ReactionSpectrum, CrystalGate=CrystalGate, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Illium - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(160, 1, 30, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo1Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(200, 1, 0, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(300, 1, 0, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo3Stack <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 1800, 1800, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
LiyoWait <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(350, 4, 30, 3030, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Machina <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(500 + 4 * IlliumSpec$SkillLv, 6, 30, 3030, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Deus <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(160, 2, 30, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite1stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(200, 2, 0, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite2stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(300, 2, 0, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite3stack <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 1800, 1800, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSateliteWait <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=SSkill)
value <- c(floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c((1000 + 40 * IlliumCore[[2]][1, 2]) * 2, 6, 210, 3030, 30, 180, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Gramholder <- rbind(data.frame(option, value), info)}

IlliumSummoned <- Summoned(list(Liyo1Stack=Liyo1Stack, Liyo2Stack=Liyo2Stack, Liyo3Stack=Liyo3Stack, LiyoWait=LiyoWait, Machina=Machina, Deus=Deus, 
                                DeusSatelite1stack=DeusSatelite1stack, DeusSatelite2stack=DeusSatelite2stack, DeusSatelite3stack=DeusSatelite3stack, DeusSateliteWait=DeusSateliteWait, 
                                Gramholder=Gramholder, SpiderInMirrorStart=SpiderInMirrorStart, 
                                SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Illium - DealCycle & Deal Calculation
ATKFinal <- data.frame(IlliumATK)
ATKFinal$Delay[c(-16, -17, -18)] <- Delay(ATKFinal$Delay, IlliumSpec$ATKSpeed)[c(-16, -17, -18)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)

BuffFinal <- data.frame(IlliumBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, IlliumSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(IlliumSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * IlliumSpec$SummonedDuration / 100, 0)


## Illium - Delay Skip Structure
IlliumSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
IlliumSkipATK <- data.frame(IlliumSkipATK, row.names=c(rownames(ATKFinal)))
colnames(IlliumSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

IlliumSkipATK$Javelin <- c(rep(F, 11), T, rep(F, 10))
IlliumSkipATK$Orb <- c(rep(F, 5), T, rep(F, 16))
IlliumSkipATK$SkippedDelay <- c(rep(0, 5), Delay(500, IlliumSpec$ATKSpeed), rep(0, 5), Delay(500, IlliumSpec$ATKSpeed), rep(0, 10))
IlliumSkipATK <- subset(IlliumSkipATK, IlliumSkipATK$SkippedDelay>0)


## Illium - DealCycle 1 (FastCharge Reset OFF / SoulContract Reset OFF)
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
IlliumDealCycle <- t(rep(0, length(DealCycle)))
colnames(IlliumDealCycle) <- DealCycle
IlliumDealCycle <- data.frame(IlliumDealCycle)

## 1 ~ 180s
{IlliumDealCycle <- DCBuff(IlliumDealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                             "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle <- DCSummoned(IlliumDealCycle, c("Liyo1Stack"), SummonedFinal)
IlliumDealCycle <- DCSummoned(IlliumDealCycle, c("Machina"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, 0)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 26)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1", "MagicCircuitFullDriveBuff", "BlessofGrandis", "SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)}

## 180 ~ 360s
{IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 30)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)}

## 360 ~ 540s
{IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                                                 "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 25)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 30)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)}

## 540 ~ 720s
{IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCSummoned(IlliumDealCycle$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)
IlliumDealCycle$DealCycle <- DCBuff(IlliumDealCycle$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle <- IlliumATKCycle(IlliumDealCycle$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle$CrystalCharge)}


## Illium - DealCycle 2 (FastCharge Reset ON / SoulContract Reset OFF)
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
IlliumDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(IlliumDealCycle2) <- DealCycle
IlliumDealCycle2 <- data.frame(IlliumDealCycle2)

## 0 ~ 171s
{IlliumDealCycle2 <- DCBuff(IlliumDealCycle2, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                             "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle2 <- DCSummoned(IlliumDealCycle2, c("Liyo1Stack"), SummonedFinal)
IlliumDealCycle2 <- DCSummoned(IlliumDealCycle2, c("Machina"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, 0)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 26)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1", "MagicCircuitFullDriveBuff", "BlessofGrandis", "SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 34)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)}

## 171 ~ 342s
{IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin", "Orb"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Javelin", rep(c("Orb", "Javelin"), 33)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)}

# 342 ~ 513s
{IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                                                   "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 25)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 35)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff", "SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)}

# 513 ~ 684s
{IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Gramholder"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("FastCharge"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("RaceofGod"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulContractLink"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 34)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal1"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("SoulofCrystal2"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCSummoned(IlliumDealCycle2$DealCycle, c("Deus"), SummonedFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)
IlliumDealCycle2$DealCycle <- DCBuff(IlliumDealCycle2$DealCycle, c("GloryWing"), BuffFinal)
IlliumDealCycle2 <- IlliumATKCycle(IlliumDealCycle2$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle2$CrystalCharge)}


## Illium - DealCycle 3 (FastCharge Reset OFF / SoulContract Reset ON)
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
IlliumDealCycle3 <- t(rep(0, length(DealCycle)))
colnames(IlliumDealCycle3) <- DealCycle
IlliumDealCycle3 <- data.frame(IlliumDealCycle3)

## 1 ~ 180s
{IlliumDealCycle3 <- DCBuff(IlliumDealCycle3, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                              "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle3 <- DCSummoned(IlliumDealCycle3, c("Liyo1Stack"), SummonedFinal)
  IlliumDealCycle3 <- DCSummoned(IlliumDealCycle3, c("Machina"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, 0)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 26)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1", "MagicCircuitFullDriveBuff", "BlessofGrandis", "SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)}

## 180 ~ 360s
{IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 30)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)}

## 360 ~ 540s
{IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                                                  "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 25)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 30)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)}

## 540 ~ 720s
{IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("EnhancedJavelin"), 22)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 29)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCSummoned(IlliumDealCycle3$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)
  IlliumDealCycle3$DealCycle <- DCBuff(IlliumDealCycle3$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle3 <- IlliumATKCycle(IlliumDealCycle3$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle3$CrystalCharge)}


## Illium - DealCycle 4 (FastCharge Reset ON / SoulContract Reset ON)
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
IlliumDealCycle4 <- t(rep(0, length(DealCycle)))
colnames(IlliumDealCycle4) <- DealCycle
IlliumDealCycle4 <- data.frame(IlliumDealCycle4)

## 0 ~ 171s
{IlliumDealCycle4 <- DCBuff(IlliumDealCycle4, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                                "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle4 <- DCSummoned(IlliumDealCycle4, c("Liyo1Stack"), SummonedFinal)
  IlliumDealCycle4 <- DCSummoned(IlliumDealCycle4, c("Machina"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, 0)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 26)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1", "MagicCircuitFullDriveBuff", "BlessofGrandis", "SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 34)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)}

## 171 ~ 342s
{IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin", "Orb"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Javelin", rep(c("Orb", "Javelin"), 33)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)}

# 342 ~ 513s
{IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", 
                                                                    "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("SpiderInMirror"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 25)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 35)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("BlessofGrandis", "MagicCircuitFullDriveBuff", "SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)}

# 513 ~ 684s
{IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 24)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink", "SoulofCrystal2", "Restraint4"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing", "CrystalIgnitionPre", "ReactionSpectrum", "CrystalIgnition", "CrystalIgnitionEnd"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Gramholder"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("Orb", "Javelin"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulContractLink"), BuffFinal)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("FastCharge"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 12)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("RaceofGod"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 5)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 34)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal1"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 3)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("SoulofCrystal2"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c(rep(c("Orb", "Javelin"), 13)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCSummoned(IlliumDealCycle4$DealCycle, c("Deus"), SummonedFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalSwing"), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)
  IlliumDealCycle4$DealCycle <- DCBuff(IlliumDealCycle4$DealCycle, c("GloryWing"), BuffFinal)
  IlliumDealCycle4 <- IlliumATKCycle(IlliumDealCycle4$DealCycle, c("MotalWingBeat", rep(c("EnhancedJavelin"), 47)), ATKFinal, IlliumSkipATK, IlliumDealCycle4$CrystalCharge)}


IlliumDealCycle <- DealCycleFinal(IlliumDealCycle$DealCycle)
IlliumDealCycle <- RepATKCycle(IlliumDealCycle, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle <- RepATKCycle(IlliumDealCycle, "ReactionSpectrum", 9, 1000, ATKFinal)
IlliumDealCycle <- MCFCycle(IlliumDealCycle, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle <- SoulofCrystalBuffLogic(IlliumDealCycle)
IlliumDealCycle <- AddATKCycleIllium(IlliumDealCycle, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2])
IlliumDealCycle <- JavelinBuffLogic(IlliumDealCycle)
IlliumDealCycle <- DeusExMachinaLogic(IlliumDealCycle, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle <- DCSummonedATKs(IlliumDealCycle, "Gramholder", SummonedFinal)
IlliumDealCycle <- DCSpiderInMirror(IlliumDealCycle, SummonedFinal)
IlliumDealCycleReduction <- DealCycleReduction(IlliumDealCycle)

IlliumDealCycle2 <- DealCycleFinal(IlliumDealCycle2$DealCycle)
IlliumDealCycle2 <- RepATKCycle(IlliumDealCycle2, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle2 <- RepATKCycle(IlliumDealCycle2, "ReactionSpectrum", 9, 1000, ATKFinal)
IlliumDealCycle2 <- MCFCycle(IlliumDealCycle2, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle2 <- SoulofCrystalBuffLogic(IlliumDealCycle2)
IlliumDealCycle2 <- AddATKCycleIllium(IlliumDealCycle2, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2])
IlliumDealCycle2 <- JavelinBuffLogic(IlliumDealCycle2)
IlliumDealCycle2 <- DeusExMachinaLogic(IlliumDealCycle2, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle2 <- DCSummonedATKs(IlliumDealCycle2, "Gramholder", SummonedFinal)
IlliumDealCycle2 <- DCSpiderInMirror(IlliumDealCycle2, SummonedFinal)
IlliumDealCycle2Reduction <- DealCycleReduction(IlliumDealCycle2)

IlliumDealCycle3 <- DealCycleFinal(IlliumDealCycle3$DealCycle)
IlliumDealCycle3 <- RepATKCycle(IlliumDealCycle3, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle3 <- RepATKCycle(IlliumDealCycle3, "ReactionSpectrum", 9, 1000, ATKFinal)
IlliumDealCycle3 <- MCFCycle(IlliumDealCycle3, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle3 <- SoulofCrystalBuffLogic(IlliumDealCycle3)
IlliumDealCycle3 <- AddATKCycleIllium(IlliumDealCycle3, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2])
IlliumDealCycle3 <- JavelinBuffLogic(IlliumDealCycle3)
IlliumDealCycle3 <- DeusExMachinaLogic(IlliumDealCycle3, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle3 <- DCSummonedATKs(IlliumDealCycle3, "Gramholder", SummonedFinal)
IlliumDealCycle3 <- DCSpiderInMirror(IlliumDealCycle3, SummonedFinal)
IlliumDealCycle3Reduction <- DealCycleReduction(IlliumDealCycle3)

IlliumDealCycle4 <- DealCycleFinal(IlliumDealCycle4$DealCycle)
IlliumDealCycle4 <- RepATKCycle(IlliumDealCycle4, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle4 <- RepATKCycle(IlliumDealCycle4, "ReactionSpectrum", 9, 1000, ATKFinal)
IlliumDealCycle4 <- MCFCycle(IlliumDealCycle4, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle4 <- SoulofCrystalBuffLogic(IlliumDealCycle4)
IlliumDealCycle4 <- AddATKCycleIllium(IlliumDealCycle4, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2])
IlliumDealCycle4 <- JavelinBuffLogic(IlliumDealCycle4)
IlliumDealCycle4 <- DeusExMachinaLogic(IlliumDealCycle4, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle4 <- DCSummonedATKs(IlliumDealCycle4, "Gramholder", SummonedFinal)
IlliumDealCycle4 <- DCSpiderInMirror(IlliumDealCycle4, SummonedFinal)
IlliumDealCycle4Reduction <- DealCycleReduction(IlliumDealCycle4)

IlliumDealCycleTimes <- c(max(IlliumDealCycle$Time), max(IlliumDealCycle2$Time), max(IlliumDealCycle3$Time), max(IlliumDealCycle4$Time))
IlliumDealCycleProbs <- c(0.76 * 0.76, 0.76 * 0.24, 0.24 * 0.76, 0.24 * 0.24)
IlliumDealCycleTimeAVG <- sum(IlliumDealCycleTimes * IlliumDealCycleProbs)

ResetDealCalc(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction), ATKFinal, BuffFinal, SummonedFinal, IlliumSpec,
              IlliumDealCycleTimes, IlliumDealCycleProbs)
ResetDealCalcWithMaxDMR(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction), ATKFinal, BuffFinal, SummonedFinal, IlliumSpec,
              IlliumDealCycleTimes, IlliumDealCycleProbs)

IlliumSpecOpt1 <- ResetOptimization1(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction), 
                                     ATKFinal, BuffFinal, SummonedFinal, IlliumSpec, UnionRemained, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumSpecOpt <- IlliumSpec
IlliumSpecOpt$ATKP <- IlliumSpecOpt$ATKP + IlliumSpecOpt1$ATKP
IlliumSpecOpt$BDR <- IlliumSpecOpt$BDR + IlliumSpecOpt1$BDR
IlliumSpecOpt$IGR <- IGRCalc(c(IlliumSpecOpt$IGR, IlliumSpecOpt1$IGR))

IlliumSpecOpt2 <- ResetOptimization2(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction),
                                     ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt, HyperStatBase, IlliumChrLv, IlliumCRROver, 0, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumFinalDPM <- ResetDealCalc(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction), 
                                ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=list(IlliumDealCycleReduction, IlliumDealCycle2Reduction, IlliumDealCycle3Reduction, IlliumDealCycle4Reduction), 
                                                 ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2, IlliumDealCycleTimes, IlliumDealCycleProbs)

DPM12338$Illium[1] <- sum(na.omit(IlliumFinalDPMwithMax)) / (724698 / 60000)
DPM12338$Illium[2] <- sum(na.omit(IlliumFinalDPM)) / (724698 / 60000) - sum(na.omit(IlliumFinalDPMwithMax)) / (724698 / 60000)

IlliumDeal1 <- DealCalcWithMaxDMR(IlliumDealCycle, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal2 <- DealCalcWithMaxDMR(IlliumDealCycle2, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal3 <- DealCalcWithMaxDMR(IlliumDealCycle3, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal4 <- DealCalcWithMaxDMR(IlliumDealCycle4, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDealWithoutMax <- DealCalc(IlliumDealCycle, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)

ResetDealRatio(DealCycles=list(IlliumDealCycle, IlliumDealCycle2, IlliumDealCycle3, IlliumDealCycle4), DealDatas=list(IlliumDeal1, IlliumDeal2, IlliumDeal3, IlliumDeal4), 
               IlliumDealCycleTimes, IlliumDealCycleProbs)

IlliumDealData <- data.frame(IlliumDealCycle$Skills, IlliumDealCycle$Time, IlliumDealCycle$Restraint4, IlliumDeal1, IlliumDealWithoutMax-IlliumDeal1)
colnames(IlliumDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(IlliumDealData, IlliumDealData$Leakage > 0)

IlliumRR <- IlliumDealData[220:407, ]
sum((IlliumRR$Deal)) ## 3,795,760,796,297

Illium40s <- IlliumDealData[220:667, ]
sum((Illium40s$Deal)) ## 7,227,667,732,715