## WindBreaker - Data
## WindBreaker - VMatrix
PasSkills <- c("SongofSky", "TriflingWhim", "StormBringer", "FairyTurn", "PinpointPierce", "Monsoon")
PasLvs <- c(50, 50, 50, 50, 50, 50)
PasMP <- c(10, 10, 10, 0, 0, 0)
ActSkills <- c("HowlingGale", "IdleWhim", "WindWall", "VortexSphere",
               "GuidedArrow", "CygnusPhalanx", "CriticalReinforce", "BlessofCygnus", "SpiderInMirror")
ActLvs <- c(25, 25, 25, 25, 25, 25, 25, 25, 25)
ActMP <- c(5, 5, 5, 5, 5, 5, 5, 5, 5)
UsefulSkills <- c("CombatOrders")
UsefulLvs <- c(20)
UsefulMP <- c(0)

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
WindBreakerCore <- list(PassiveCore, ActiveCore, UsefulCore)


## WindBreaker - Basic Info
WindBreakerClass1 <- ChrInfo[19, 2]
WindBreakerClass2 <- ChrInfo[19, 3]
WindBreakerMainStatType <- ChrInfo[19, 4]
WindBreakerSubStat1Type <- ChrInfo[19, 5]
WindBreakerChrLv <- ChrInfo[19, 7]
WindBreakerUnionLv <- ChrInfo[19, 8]
WindBreakerArcaneForce <- ChrInfo[19, 9]
WindBreakerCharisma <- ChrInfo[19, 10]
WindBreakerInsight <- ChrInfo[19, 11]
WindBreakerSensibility <- ChrInfo[19, 12]
WindBreakerBaseMastery <- ChrInfo[19, 13]
WindBreakerCRROver <- T
WindBreakerBuffDurationNeeded <- ceiling((171 / 110 - 1)*100)

WindBreakerAbility <- Abilities(c("BDR", "BuffDuration"), c("L", "E"))

WindBreakerLinkBase <- rbind(LinkBase)
WindBreakerDisorder <- max(LinkBase$Disorder)
AdventureThief <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(WindBreakerDisorder==T, (10+ServerLag)/20*18, 0), 0, 0, 0)
Cadena <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ifelse(WindBreakerDisorder==T, 6, 0)+ifelse(WindBreakerChrLv>MobLv, 6, 0), 0, 0, 0)
WindBreakerLinkBase <- rbind(LinkBase, Mikhail, DemonAvenger, Phantom, CygnusKnights)
WindBreakerLinkBase <- data.frame(WindBreakerLinkBase)
LinkSet <- c()
for(i in c(1:9, 11:13)) {
  LinkSet[i] <- sum(WindBreakerLinkBase[, i]) 
}
LinkSet[10] <- IGRCalc(WindBreakerLinkBase[, 10])
LinkSet <- data.frame(t(LinkSet))
colnames(LinkSet) <- colnames(WindBreakerLinkBase)[1:13]
rownames(LinkSet) <- c("Links")

CommonSkillSet <- data.frame(t(colSums(CommonSkills)))

MonsterLife <- colSums(MLTypeD21) ## IGR Logic Needed
MonsterLife <- data.frame(t(MonsterLife))

Dopings <- colSums(DopingSet) ## IGR Logic Needed
Dopings <- data.frame(t(Dopings))

Weapon <- rbind(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Bow", "AR")[, 1:16], SubWeapon[19, ], Emblem[3, ])
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
WindBreakerSpec <- data.frame(t(rep(0, 21)))
colnames(WindBreakerSpec) <- Specs

WindBreakerSpec$SkillLv <- sum(WindBreakerCore[[3]][, 1]=="CombatOrders")
WindBreakerSpec$PSkillLv <- sum(WindBreakerCore[[3]][, 1]=="CombatOrders") + WindBreakerAbility$PassiveLv
WindBreakerSpec$MainStatP <- (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP + (15 + floor(WindBreakerSpec$PSkillLv/3))) / 100 ## WindBlessing DEXP


## WindBreaker - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(WindBreakerChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
WhisperoftheWind <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATKP", "MainStatP"), levels=PSkill)
value <- c(10 + ceiling(WindBreakerSpec$PSkillLv/3), 15 + floor(WindBreakerSpec$PSkillLv/3))
WindBlessing <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "FDR", "CDMR", "BDR"), levels=PSkill)
value <- c(70 + ceiling(WindBreakerSpec$PSkillLv/2), 30 + WindBreakerSpec$PSkillLv, 25 + ceiling(WindBreakerSpec$PSkillLv/3), 20 + floor(WindBreakerSpec$PSkillLv/2), 40 + WindBreakerSpec$PSkillLv)
BowExpert <- data.frame(option, value)}

WindBreakerPassive <- Passive(list(ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, WhisperoftheWind=WhisperoftheWind, PhysicalTraining=PhysicalTraining, 
                                   WindBlessing=WindBlessing, BowExpert=BowExpert))


## WindBreaker - Buff
{option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(200, NA, 270, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementStorm <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BowBooster <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "CRR"), levels=BSkill)
value <- c(20, 10)
info <- c(200, NA, 270, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SylphsAid <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(15, 15)
info <- c(30, 40, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PinpointPierceBuff <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "DMR", "IGR", "CRR", "ATKSpeed"), levels=BSkill)
value <- c(50 + WindBreakerSpec$SkillLv, 25 + 2 * floor(WindBreakerSpec$SkillLv/2), 15 + floor(WindBreakerSpec$SkillLv/3), 25 + floor(WindBreakerSpec$SkillLv/2), 1)
info <- c(200, NA, 180, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AlbatrossMaximum <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(WindBreakerSpec$SkillLv/2), 15 + ceiling(WindBreakerSpec$SkillLv/2))
info <- c(300 + 3 * WindBreakerSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((WindBreakerChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(WindBreakerSpec$SkillLv/2))))
info <- c(900 + 30 * WindBreakerSpec$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(200, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
StormBringer <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * WindBreakerCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(45, 90, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindWallBuff <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(WindBreakerSpec$CRR * (0.2 + 0.01 * WindBreakerCore[[2]][7, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)
}

## PetBuff : SharpEyes, BowBooster, StormBringer
WindBreakerBuff <- Buff(list(ElementStorm=ElementStorm, BowBooster=BowBooster, SylphsAid=SylphsAid, PinpointPierceBuff=PinpointPierceBuff, AlbatrossMaximum=AlbatrossMaximum, 
                             SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, GloryofGardians=GloryofGardians, StormBringer=StormBringer, UsefulCombatOrders=UsefulCombatOrders, 
                             WindWallBuff=WindWallBuff, CriticalReinforce=CriticalReinforce, BlessofCygnus=BlessofCygnus,
                             Restraint4=Restraint4, SoulContractLink=SoulContractLink))
WindBreakerAllTimeBuff <- AllTimeBuff(WindBreakerBuff)


## WindBreaker - Union & HyperStat & SoulWeapon
WindBreakerSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + WindBreakerPassive$CRR + 
  (Union8000Chr$CRR) + WindBreakerAbility$CRR + WindBreakerAllTimeBuff$CRR + 5
WindBreakerSpec$CRR <- ifelse(WindBreakerCRROver==T, WindBreakerSpec$CRR, min(WindBreakerSpec$CRR, 100))
WindBreakerSpec$BuffDuration <- MonsterLife$BuffDuration + WindBreakerPassive$BuffDuration + Union8000Chr$BuffDuration + floor(WindBreakerSensibility/10) + WindBreakerAbility$BuffDuration

UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")

UnionBase <- data.frame(t(c(40, 0, 0, 0, 0, 5, 1, 1, 5, 0)))
colnames(UnionBase) <- UnionFieldOption
UnionFields <- ifelse(WindBreakerUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - sum(UnionBase)

CRRs <- CRRGet(UnionFields, WindBreakerBuffDurationNeeded, WindBreakerSpec$BuffDuration, WindBreakerSpec$CRR, WindBreakerCRROver)
UnionBase <- UnionPlace(UnionFields - max(0, WindBreakerBuffDurationNeeded - WindBreakerSpec$BuffDuration) - CRRs$Union, UnionBase, 
                        max(0, WindBreakerBuffDurationNeeded - WindBreakerSpec$BuffDuration), CRRs$Union)
UnionBase$CDMR <- UnionBase$CDMR/2
UnionBase$MainStat <- UnionBase$MainStat*5
UnionBase$SubStat1 <- UnionBase$SubStat1*5
UnionBase$SubStat2 <- UnionBase$SubStat2*5
UnionRemained <- ifelse(WindBreakerUnionLv==8000, FieldNumbers[2], FieldNumbers[1]) - UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
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


## WindBreaker Final Specs W/O UnionBDR&IGR, HyperStatAlpha, Potential
WindBreakerSpec$MainStat <- floor((sum(Weapon$MainStat) + ItemSet$MainStat + MonsterLife$DEX + Dopings$MainStat + LinkSet$MainStat + WindBreakerPassive$MainStat + 
  WindBreakerAllTimeBuff$MainStat + CommonSkillSet$MainStat + UnionBase$MainStat + 18 + 5 * WindBreakerChrLv) * (100 + ItemSet$MainStatP + ItemSet$AllstatP + sum(Weapon$AllstatP) + 
  Dopings$AllstatP + LinkSet$AllstatP + WindBreakerPassive$MainStatP) / 100) + 10 * WindBreakerArcaneForce + Union8000Chr$DEX + 20
WindBreakerSpec$SubStat1 <- floor((sum(Weapon$SubStat1) + ItemSet$SubStat1 + MonsterLife$STR + Dopings$SubStat1 + LinkSet$SubStat1 + WindBreakerPassive$SubStat1 + 
  WindBreakerAllTimeBuff$SubStat1 + CommonSkillSet$SubStat1 + UnionBase$SubStat1 + 4) * (100 + ItemSet$AllstatP + sum(Weapon$AllstatP) + Dopings$AllstatP + LinkSet$AllstatP) / 100) + 
  Union8000Chr$STR
WindBreakerSpec$ATK <- sum(Weapon$ATK) + ItemSet$ATK + MonsterLife$ATK + Dopings$ATK + LinkSet$ATK + WindBreakerPassive$ATK + Union8000Chr$ATK + WindBreakerAbility$CRR + 
  WindBreakerAllTimeBuff$ATK + CommonSkillSet$ATK + UnionBase$ATK + SoulWeapon$ATK
WindBreakerSpec$ATKP <- sum(Weapon$ATKP) + WindBreakerPassive$ATKP + WindBreakerAllTimeBuff$ATKP + CommonSkillSet$ATKP + SoulWeapon$ATKP
WindBreakerSpec$IGR <- IGRCalc(c(IGRCalc(c(Weapon$IGR)), ItemSet$IGR, MonsterLife$IGR, Dopings$IGR, LinkSet$IGR, WindBreakerPassive$IGR, Union8000Chr$IGR, floor(WindBreakerCharisma/5)/2, 
  WindBreakerAllTimeBuff$IGR, HyperStatBase$IGR))
WindBreakerSpec$BDR <- sum(Weapon$BDR) + ItemSet$BDR + MonsterLife$BDR + Dopings$BDR + LinkSet$BDR + WindBreakerPassive$BDR + Union8000Chr$BDR + WindBreakerAbility$BDR + WindBreakerAbility$DisorderBDR + 
  WindBreakerAllTimeBuff$BDR + HyperStatBase$BDR + HyperStatBase$DMR
WindBreakerSpec$CRR <- sum(Weapon$CRR) + ItemSet$CRR + MonsterLife$CRR + Dopings$CRR + LinkSet$CRR + WindBreakerPassive$CRR + 
  (Union8000Chr$CRR + ifelse(WindBreakerChrLv>=250, 1, 0)) + WindBreakerAbility$CRR + WindBreakerAllTimeBuff$CRR + 5
WindBreakerSpec$CRR <- ifelse(WindBreakerCRROver==T, WindBreakerSpec$CRR + rowSums(CRRs), min(WindBreakerSpec$CRR + rowSums(CRRs), 100))
WindBreakerSpec$CDMR <- sum(Weapon$CDMR) + ItemSet$CDMR + MonsterLife$CDMR + Dopings$CDMR + LinkSet$CDMR + WindBreakerPassive$CDMR + WindBreakerAllTimeBuff$CDMR + Union8000Chr$CDMR +
  HyperStatBase$CDMR + UnionBase$CDMR
WindBreakerSpec$FDR <- FDRCalc(c(WindBreakerPassive$FDR, WindBreakerAllTimeBuff$FDR, ArcaneForceFDR(WindBreakerArcaneForce, MapArc), LevelFDR(WindBreakerChrLv, MobLv), 
  (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Bow", "AR")[19]*100-100)))
WindBreakerSpec$ATKSpeed <- max(WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Bow", "AR")[17] - Dopings$ATKSpeed - WindBreakerAllTimeBuff$ATKSpeed - WindBreakerPassive$ATKSpeed, 2)
WindBreakerSpec$Mastery <- min(WindBreakerBaseMastery + WindBreakerPassive$Mastery, 95)
WindBreakerSpec$BuffDuration <- WindBreakerSpec$BuffDuration + UnionBase$BuffDuration
WindBreakerSpec$SummonedDuration <- MonsterLife$SummonedDuration + WindBreakerPassive$SummonDuration + Union8000Chr$SummonedDuration
WindBreakerSpec$ImmuneIgnore <- WindBreakerPassive$ImmuneIgnore + floor(WindBreakerInsight/10)/2 + WindBreakerAllTimeBuff$ImmuneIgnore
WindBreakerSpec$CoolTimeReset <- MonsterLife$CoolTimeReset + WindBreakerPassive$CoolTimeReset + WindBreakerAbility$CoolTimeReset
WindBreakerSpec$CoolReduceP <- Union8000Chr$CoolReduce
WindBreakerSpec$CoolReduce <- 0
WindBreakerSpec$Disorder <- max(WindBreakerLinkBase$Disorder, WindBreakerPassive$Disorder, WindBreakerAllTimeBuff$Disorder)


## WindBreaker - CriticalReinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(WindBreakerSpec$CRR * (0.2 + 0.01 * WindBreakerCore[[2]][7, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}

WindBreakerBuff <- Buff(list(ElementStorm=ElementStorm, BowBooster=BowBooster, SylphsAid=SylphsAid, PinpointPierceBuff=PinpointPierceBuff, AlbatrossMaximum=AlbatrossMaximum, 
                             SharpEyes=SharpEyes, MapleSoldier=MapleSoldier, GloryofGardians=GloryofGardians, StormBringer=StormBringer, UsefulCombatOrders=UsefulCombatOrders, 
                             WindWallBuff=WindWallBuff, CriticalReinforce=CriticalReinforce, BlessofCygnus=BlessofCygnus,
                             Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## WindBreaker - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * WindBreakerCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * WindBreakerCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## WindBreaker - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][5, 2]>=40, 20, 0), 3 * WindBreakerCore[[1]][5, 2])
info <- c(340, 2, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PinpointPierce <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][1, 2]>=40, 20, 0), ((1.2 + 0.01 * floor(WindBreakerSpec$SkillLv/2))^ifelse(WindBreakerCore[[1]][1, 2]>=20, 4, 3)) * 100 - 100 + 50, 2 * WindBreakerCore[[1]][1, 2])
info <- c(345, 1, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SongofSky <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][2, 2]>=40, 20, 0), 20, 2 * WindBreakerCore[[1]][2, 2])
info <- c(290 + 3 * WindBreakerSpec$PSkillLv, 2 * (0.6 + 0.01 * floor(WindBreakerSpec$PSkillLv/2)) * 0.8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriflingWhim <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][2, 2]>=40, 20, 0), 20, 2 * WindBreakerCore[[1]][2, 2])
info <- c(390 + 3 * WindBreakerSpec$PSkillLv, 2 * (0.6 + 0.01 * floor(WindBreakerSpec$PSkillLv/2)) * 0.2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriflingWhimEnhanced <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(WindBreakerCore[[1]][3, 2]>=40, 20, 0), 2 * WindBreakerCore[[1]][3, 2])
info <- c(500, 0.3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
StormBringer <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * WindBreakerCore[[2]][2, 2], 3, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IdleWhimFirst <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * WindBreakerCore[[2]][2, 2]) * 0.75, 27, 600, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IdleWhimRemain <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * WindBreakerCore[[2]][1, 2], 3, 840, 150, 20, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HowlingGaleSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * WindBreakerCore[[2]][1, 2], 3, 840, 150, 40, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HowlingGaleBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((550 + 22 * WindBreakerCore[[2]][3, 2]) * 0.5, 15, 0, 2000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WindWall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * WindBreakerCore[[2]][4, 2], 8, 960, 180, 35, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VortexSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1, 1, 0, 2400, 35, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VortexSphereGust <- rbind(data.frame(option, value), info)}

WindBreakerATK <- Attack(list(PinpointPierce=PinpointPierce, SongofSky=SongofSky, TriflingWhim=TriflingWhim, TriflingWhimEnhanced=TriflingWhimEnhanced, StormBringer=StormBringer,
                              IdleWhimFirst=IdleWhimFirst, IdleWhimRemain=IdleWhimRemain, HowlingGaleSmall=HowlingGaleSmall, HowlingGaleBig=HowlingGaleBig, WindWall=WindWall, 
                              VortexSphere=VortexSphere, VortexSphereGust=VortexSphereGust, SpiderInMirror=SpiderInMirror))


## WindBreaker - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * WindBreakerCore[[2]][5, 2], 1, 720, 500, 0.5*89+0.51, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * WindBreakerCore[[2]][6, 2], 1, 780, 240, 0.24*89+0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

WindBreakerSummoned <- Summoned(list(GuidedArrow=GuidedArrow, CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, 
                                     SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                     SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## WindBreaker - DealCycle & Deal Calculation
ATKFinal <- data.frame(WindBreakerATK)
ATKFinal$Delay[c(-2)] <- Delay(ATKFinal$Delay, WindBreakerSpec$ATKSpeed)[c(-2)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)

BuffFinal <- data.frame(WindBreakerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, WindBreakerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(WindBreakerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, WindBreakerSpec$CoolReduceP, WindBreakerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * WindBreakerSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(WindBreakerBuff))
WindBreakerDealCycle <- t(rep(0, length(DealCycle)))
colnames(WindBreakerDealCycle) <- DealCycle

WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("BowBooster", "SharpEyes", "StormBringer", "ElementStorm", "SylphsAid", "AlbatrossMaximum", 
                                                     "MapleSoldier", "UsefulCombatOrders", "GloryofGardians"), BuffFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("GuidedArrow"), SummonedFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("SpiderInMirror"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff", "BlessofCygnus"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("WindWall"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("WindWallBuff", "SoulContractLink", "CriticalReinforce", "Restraint4"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleBig"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 76)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 72)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 19)), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 17), "PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 28)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 27)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 41)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 71)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 13)), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("GuidedArrow"), SummonedFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 33), "PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 3)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 16)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 55)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 3)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 67)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 23)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 41)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 70)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 76)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 32)), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("StormBringer", "GloryofGardians"), BuffFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("GuidedArrow"), SummonedFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("WindWall"), ATKFinal)                                          
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("WindWallBuff", "SoulContractLink", "CriticalReinforce"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 38)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleBig"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 33)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 76)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 36)), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 3)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 19)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 29)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 41)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 54)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 17)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 29)), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("GuidedArrow"), SummonedFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 24), "PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 5)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 61)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("HowlingGaleSmall"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 10)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphereGust"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("VortexSphere"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 70)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 33)), ATKFinal)
WindBreakerDealCycle <- DCSummoned(WindBreakerDealCycle, c("CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 38)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("PinpointPierce"), ATKFinal)
WindBreakerDealCycle <- DCBuff(WindBreakerDealCycle, c("PinpointPierceBuff"), BuffFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 70)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 76)), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimFirst"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c("IdleWhimRemain"), ATKFinal)
WindBreakerDealCycle <- DCATK(WindBreakerDealCycle, c(rep("SongofSky", 6)), ATKFinal)

WindBreakerDealCycle <- DealCycleFinal(WindBreakerDealCycle)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "VortexSphere", 17, 540, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "VortexSphereGust", 1, 2400, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "HowlingGaleSmall", 56, 1000, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "HowlingGaleBig", 66, 0, ATKFinal)
WindBreakerDealCycle <- RepATKCycle(WindBreakerDealCycle, "WindWall", 25, 0, ATKFinal)
WindBreakerDealCycle <- DCSummonedATKs(WindBreakerDealCycle, Skill=c("GuidedArrow", "CygnusPhalanx"), SummonedFinal)
WindBreakerDealCycle <- AddATKsCycleWB(WindBreakerDealCycle)
WindBreakerDealCycle <- DCSpiderInMirror(WindBreakerDealCycle, SummonedFinal)
WindBreakerDealCycle <- BlessofCygnusCycle(WindBreakerDealCycle, 6000, ServerLag, WindBreakerCore[[2]][8, 2])

WindBreakerDealCycleReduction <- DealCycleReduction(WindBreakerDealCycle, "BlessofCygnusBDR")

sum(na.omit(WindBreakerDealCalc(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpec)))

WindBreakerSpecOpt1 <- WindBreakerOptimization1(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpec, UnionRemained)
WindBreakerSpecOpt <- WindBreakerSpec
WindBreakerSpecOpt$ATKP <- WindBreakerSpecOpt$ATKP + WindBreakerSpecOpt1$ATKP
WindBreakerSpecOpt$BDR <- WindBreakerSpecOpt$BDR + WindBreakerSpecOpt1$BDR
WindBreakerSpecOpt$IGR <- IGRCalc(c(WindBreakerSpecOpt$IGR, WindBreakerSpecOpt1$IGR))

WindBreakerSpecOpt2 <- WindBreakerOptimization2(WindBreakerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt, HyperStatBase, WindBreakerChrLv, WindBreakerCRROver)
WindBreakerFinalDPM <- WindBreakerDealCalc(WindBreakerDealCycle, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt2)
WindBreakerFinalDPMwithMax <- WindBreakerDealCalcWithMaxDMR(WindBreakerDealCycle, ATKFinal, BuffFinal, SummonedFinal, WindBreakerSpecOpt2)

DPMTver$WindBreaker[1] <- sum(na.omit(WindBreakerFinalDPMwithMax)) / (222920 / 60000)
DPMTver$WindBreaker[2] <- sum(na.omit(WindBreakerFinalDPM)) / (222920 / 60000) - sum(na.omit(WindBreakerFinalDPMwithMax)) / (222920 / 60000)

WindBreakerDealData <- data.frame(WindBreakerDealCycle$Skills, WindBreakerDealCycle$Time, WindBreakerDealCycle$Restraint4, WindBreakerFinalDPMwithMax)
colnames(WindBreakerDealData) <- c("Skills", "Time", "R4", "Deal")

WindBreakerRR <- WindBreakerDealData[126:1197, ]
sum((WindBreakerRR$Deal)) ## 2,971,470,062,667

WindBreaker40s <- WindBreakerDealData[126:2585, ]
sum((WindBreaker40s$Deal)) ## 5,029,342,027,630

DealRatio(WindBreakerDealCycle, WindBreakerFinalDPMwithMax)
