## Adele - Data
## Adele - VMatrix
AdeleCoreBase <- CoreBuilder(ActSkills=c("Ruin", "Infinite", "Restore", "Storm", 
                                         CommonV("Warrior", "Lef")), 
                             ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                             UsefulSkills=c("SharpEyes", "CombatOrders"), 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             VPassiveList=AdeleVPassive, 
                             VPassivePrior=AdeleVPrior, 
                             SelfBind=F)

AdeleCore <- MatrixSet(PasSkills=AdeleCoreBase$PasSkills$Skills, 
                       PasLvs=AdeleCoreBase$PasSkills$Lv, 
                       PasMP=AdeleCoreBase$PasSkills$MP, 
                       ActSkills=AdeleCoreBase$ActSkills$Skills, 
                       ActLvs=AdeleCoreBase$ActSkills$Lv, 
                       ActMP=AdeleCoreBase$ActSkills$MP, 
                       UsefulSkills=AdeleCoreBase$UsefulSkills, 
                       UsefulLvs=20, 
                       UsefulMP=0, 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       SpecialCore=AdeleCoreBase$SpecialCoreUse)


## Adele - Basic Info
AdeleBase <- JobBase(ChrInfo=ChrInfo, 
                     MobInfo=get(DPMCalcOption$MobSet),
                     SpecSet=get(DPMCalcOption$SpecSet), 
                     Job="Adele",
                     CoreData=AdeleCore, 
                     BuffDurationNeeded=0, 
                     AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Adele"), 
                     LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Adele"), 
                     MonsterLife=get(FindJob(MonsterLifePreSet, "Adele")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                     Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                     WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                     SubWeapon=SubWeapon[rownames(SubWeapon)=="Bracelet", ], 
                     Emblem=Emblem[rownames(Emblem)=="Knight", ], 
                     CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Adele")))


## Adele - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[rownames(ArcaneShade)=="Tuner", 6] * 0.15), floor(AdeleBase$ItemSet$ATKSub * 0.35)))
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
value <- c(30 + AdeleBase$PSkillLv, 70 + ceiling(AdeleBase$PSkillLv/2))
Expert <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(30 + AdeleBase$PSkillLv, 20 + AdeleBase$PSkillLv)
Demolition <- data.frame(option, value)

option <- factor(c("ATK", "BDR", "CRR"), levels=PSkill)
value <- c(30 + AdeleBase$PSkillLv, 10 + ceiling(AdeleBase$PSkillLv/2), 20 + AdeleBase$PSkillLv)
Attain <- data.frame(option, value)

option <- factor(c("BDR", "IGR"), levels=PSkill)
value <- c(20 + floor(AdeleBase$SkillLv/2), 10)
GraveDebuff <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(AdeleCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(AdeleCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(AdeleCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

AdelePassive <- Passive(list(MagicCircuit=MagicCircuit, Pace=Pace, Rudiment=Rudiment, Mastery=Mastery, Train=Train, 
                             Ascent=Ascent, Expert=Expert, Demolition=Demolition, Attain=Attain, GraveDebuff=GraveDebuff, BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive, 
                             RopeConnectPassive=RopeConnectPassive))


## Adele - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Booster <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(10, 10)
info <- c(30, NA, 0, F, NA, NA, F)
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
value <- c(floor((AdeleBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(AdeleBase$SkillLv/2))))
info <- c(900 + 30 * AdeleBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15)
info <- c(20, 180, 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Nobility <- rbind(data.frame(option, value), info)

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

option <- factor(c("BDR"), levels=BSkill)
value <- c(15 + GetCoreLv(AdeleCore, "Restore"))
info <- c(30, 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RestoreBuff <- rbind(data.frame(option, value), info) ## EtherPlus

Useful <- UsefulSkills(AdeleCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(AdeleCore, "AuraWeapon")/5), ceiling(GetCoreLv(AdeleCore, "AuraWeapon")/5))
info <- c(80 + 2 * GetCoreLv(AdeleCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + GetCoreLv(AdeleCore, "MagicCircuitFullDrive"))
info <- c(30 + GetCoreLv(AdeleCore, "MagicCircuitFullDrive"), 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * GetCoreLv(AdeleCore, "BlessofGrandisGoddess") + (min((0.4 + 0.02 * GetCoreLv(AdeleCore, "BlessofGrandisGoddess")) * AdeleBase$ItemSet$ATKSub, floor(ArcaneShade[rownames(ArcaneShade)=="Tuner", 6] * 1.5))))
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

AdeleBuff <- list(Booster=Booster, ResonanceBuff=ResonanceBuff, GatheringDebuff=GatheringDebuff, MapleSoldier=MapleSoldier, Nobility=Nobility, RaceofGod=RaceofGod,
                  InfiniteBuff=InfiniteBuff, RestoreBuff=RestoreBuff, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, AuraWeaponBuff=AuraWeaponBuff, 
                  MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, BlessofGrandis=BlessofGrandis, Restraint4=Restraint4, SoulContractLink=SoulContractLink, EtherRecovery=EtherRecovery,
                  Order1=Order1, Order2=Order2, Order3=Order3, OrderRestore=OrderRestore, Ether=Ether)
## PetBuff : Booster, MapleSoldier, UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  AdeleBuff[[length(AdeleBuff)+1]] <- UsefulAdvancedBless
  names(AdeleBuff)[[length(AdeleBuff)]] <- "UsefulAdvancedBless"
}
AdeleBuff <- Buff(AdeleBuff)
AdeleAllTimeBuff <- AllTimeBuff(AdeleBuff)


## Adele - Union & HyperStat & SoulWeapon
AdeleSpec <- JobSpec(JobBase=AdeleBase, 
                     Passive=AdelePassive, 
                     AllTimeBuff=AdeleAllTimeBuff, 
                     MobInfo=get(DPMCalcOption$MobSet), 
                     SpecSet=get(DPMCalcOption$SpecSet), 
                     WeaponName="Tuner", 
                     UnionStance=0)

AdeleUnionRemained <- AdeleSpec$UnionRemained
AdeleHyperStatBase <- AdeleSpec$HyperStatBase
AdeleCoolReduceType <- AdeleSpec$CoolReduceType
AdeleSpec <- AdeleSpec$Spec


## Adele - Spider In Mirror
SIM <- SIMData(GetCoreLv(AdeleCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Adele - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Shard_Wonder")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Shard_Wonder"))
info <- c(450 + 3 * AdeleSpec$SkillLv, 15, 0, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Wonder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Creation_Gathering")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Creation_Gathering"))
info <- c(710 + 3 * AdeleSpec$SkillLv, 2, 0, NA, 1.5, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Creation <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Impale_Resonance_Marker")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(AdeleCore, "Impale_Resonance_Marker"), 75)))
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
value <- c(ifelse(GetCoreLv(AdeleCore, "Creation_Gathering")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Creation_Gathering"))
info <- c(560 + 3 * AdeleSpec$SkillLv, 4, 0, 0, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Gathering <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Territory_Tred")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Territory_Tred"))
info <- c(400 + 5 * AdeleSpec$SkillLv, 4, 540, 360, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Territory <- rbind(data.frame(option, value), info) ## ATKSpeed Uneffected

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Territory_Tred")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Territory_Tred"))
info <- c(850 + 5 * AdeleSpec$SkillLv, 12, 0, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TerritoryExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Divide")>=40, 20, 0), 20, 2 * GetCoreLv(AdeleCore, "Divide"))
info <- c(375 + 3 * AdeleSpec$SkillLv, 6, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Divide <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Blossom")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Blossom"))
info <- c(650 + 6 * AdeleSpec$SkillLv, 8, 420, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blossom1st <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Blossom")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Blossom"))
info <- c((650 + 6 * AdeleSpec$SkillLv) * 0.75, 8, 0, NA, Cooldown(20, T, 25 + AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlossomRemain <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Order_Grave")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Order_Grave"))
info <- c(800 + 20 * AdeleSpec$SkillLv, 10, 840, NA, 90, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Grave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Impale_Resonance_Marker")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Impale_Resonance_Marker"))
info <- c(2000, 6, 900, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Marker <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(AdeleCore, "Ruin"), 6, 780, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ruin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(AdeleCore, "Ruin"), 9, 0, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RuinExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * GetCoreLv(AdeleCore, "Infinite"), 36, 0, 1050, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Infinite <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 36 * GetCoreLv(AdeleCore, "Restore"), 3, 0, 3000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Restore <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(AdeleCore, "Storm"), 2, 780, 300, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Storm <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(AdeleCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(AdeleCore, "MagicCircuitFullDrive"), 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

AdeleATK <- Attack(list(Wonder=Wonder, Creation=Creation, Resonance=Resonance, ResonanceMove=ResonanceMove, Gathering=Gathering, Territory=Territory, TerritoryExplosion=TerritoryExplosion,
                        Divide=Divide, Blossom1st=Blossom1st, BlossomRemain=BlossomRemain, Grave=Grave, Marker=Marker, Ruin=Ruin, RuinExplosion=RuinExplosion, Infinite=Infinite, 
                        Restore=Restore, Storm=Storm, AuraWeapon=AuraWeapon, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Adele - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(AdeleCore, "Order_Grave")>=40, 20, 0), 2 * GetCoreLv(AdeleCore, "Order_Grave"))
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(AdeleSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * AdeleSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(AdeleBuff))
AdeleDealCycle <- t(rep(0, length(DealCycle)))
colnames(AdeleDealCycle) <- DealCycle
AdeleDealCycle <- data.frame(AdeleDealCycle)
AdeleDealCycle$Ether <- 400

AdeleATKFinal <- function(ATKFinal, Hyper=c("Nobility", "TriggerBK", "Dike")) {
  ATKFinal$BDR[rownames(ATKFinal)=="Divide"] <- ifelse(Hyper=="TriggerBK", ATKFinal$BDR[rownames(ATKFinal)=="Divide"] + 20, ATKFinal$BDR[rownames(ATKFinal)=="Divide"])
  return(ATKFinal)
}
AdeleBuffFinal <- function(BuffFinal, ShieldRate=100) {
  BuffFinal$BDR[rownames(BuffFinal)=="Nobility"] <- BuffFinal$BDR[rownames(BuffFinal)=="Nobility"] * (ShieldRate / 100)
  return(BuffFinal)
}
AdeleCycle <-  function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, Period=180, Hyper=c("Nobility", "TriggerBK", "Dike")) {
  DealCycle <- PreDealCycle
  Period <- Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  ## First Cycle
  ## Start Buff
  DealCycle <- AdeleBuffCycle(DealCycle, c("Booster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders"), BuffFinal) 
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
    DealCycle <- AdeleBuffCycle(DealCycle, c("UsefulAdvancedBless"), BuffFinal) 
  }
  DealCycle <- AdeleBuffCycle(DealCycle, c("RaceofGod", "AuraWeaponBuff"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("SpiderInMirror"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("MagicCircuitFullDriveBuff", "BlessofGrandis"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("Restore"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("RestoreBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Infinite"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("InfiniteBuff"), BuffFinal)
  
  GBCool <- subset(ATKFinal, rownames(ATKFinal)=="BlossomRemain")$CoolTime * 1000
  TECool <- subset(ATKFinal, rownames(ATKFinal)=="Territory")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000
  GRCool <- subset(ATKFinal, rownames(ATKFinal)=="Grave")$CoolTime * 1000
  RUCool <- subset(ATKFinal, rownames(ATKFinal)=="Ruin")$CoolTime * 1000 
  
  ## Order Summon 
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("Order"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  
  ## Ether 400 & Storm
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)
  if(Hyper=="Nobility") {
    DealCycle <- AdeleBuffCycle(DealCycle, c("Nobility"), BuffFinal)
  } else {
    DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  }
  DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
  DealCycle <- StormATKCycle(DealCycle, ATKFinal)
  
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Grave"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Marker"), ATKFinal)
  
  ## Repeats
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= Period * 1000 + 2100) {
    if(DealCycle$RaceofGod[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "RaceofGod", BuffFinal)
    } 
    if(DealCycle$UsefulSharpEyes[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "UsefulSharpEyes", BuffFinal)
    }
    if(DealCycle$UsefulCombatOrders[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "UsefulCombatOrders", BuffFinal)
    }
    if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
      if(DealCycle$UsefulAdvancedBless[nrow(DealCycle)] < 3000) {
        DealCycle <- AdeleBuffCycle(DealCycle, "UsefulAdvancedBless", BuffFinal)
      }
    }
    if(DealCycle$Booster[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "Booster", BuffFinal)
    }
    ## Order Summon
    if(DealCycle$Ether[nrow(DealCycle)] == 400 & (Period * 1000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > 10000) {
      if(DealCycle$Order1[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order2[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order3[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      }
    }
    ## Gathering - Blossom
    if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="GatheringDebuff")$Time) >= GBCool & 
       (Period * 1000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > (GBCool - 6000)) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
    }
    ## Territory - Resonance
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Territory")$Time) >= TECool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
      DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
    }
    ## Ruin
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Ruin")$Time) >= RUCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
    }
    ## Soul Contract
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= SCCool) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
    }
    ## Grave - Marker
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Grave")$Time) >= GRCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Grave", "Marker"), ATKFinal)
    }
    ## Divide
    else {
      DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
    }
  }
  
  
  ## Second Cycle
  ## Start Buff
  DealCycle <- AdeleBuffCycle(DealCycle, c("AuraWeaponBuff"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("Restore"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("RestoreBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Infinite"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("InfiniteBuff"), BuffFinal)
  
  ## Order Summon 
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("Order"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  
  ## Ether 400 & Storm
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)
  if(Hyper=="Nobility") {
    DealCycle <- AdeleBuffCycle(DealCycle, c("Nobility"), BuffFinal)
  } else {
    DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  }
  DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
  DealCycle <- StormATKCycle(DealCycle, ATKFinal)
  
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Grave"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Marker"), ATKFinal)
  
  ## Repeats
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= Period * 2000 + 2100) {
    if(DealCycle$RaceofGod[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "RaceofGod", BuffFinal)
    }
    if(DealCycle$UsefulSharpEyes[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "UsefulSharpEyes", BuffFinal)
    }
    if(DealCycle$UsefulCombatOrders[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "UsefulCombatOrders", BuffFinal)
    }
    if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
      if(DealCycle$UsefulAdvancedBless[nrow(DealCycle)] < 3000) {
        DealCycle <- AdeleBuffCycle(DealCycle, "UsefulAdvancedBless", BuffFinal)
      }
    }
    if(DealCycle$Booster[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "Booster", BuffFinal)
    }
    ## Order Summon
    if(DealCycle$Ether[nrow(DealCycle)] == 400 & (Period * 2000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > 10000) {
      if(DealCycle$Order1[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order2[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order3[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      }
    }
    ## Gathering - Blossom
    if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="GatheringDebuff")$Time) >= GBCool & 
       (Period * 2000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > (GBCool - 6000)) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
    }
    ## Territory - Resonance
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Territory")$Time) >= TECool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
      DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
    }
    ## Ruin
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Ruin")$Time) >= RUCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
    }
    ## Soul Contract
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= SCCool) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
    }
    ## Grave - Marker
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Grave")$Time) >= GRCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Grave", "Marker"), ATKFinal)
    }
    ## Divide
    else {
      DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
    }
  }
  
  ## Divide
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - Period * 1000 <= max(subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")$Time)) {
    DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
  }
  return(DealCycle)
}

## Main - Trigger - Boss Killer
ATKFinalTrigger <- AdeleATKFinal(ATKFinal, Hyper="TriggerBK")
AdeleDealCycleTrigger <- AdeleCycle(PreDealCycle=AdeleDealCycle, 
                                    ATKFinal=ATKFinalTrigger, 
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal, 
                                    Spec=AdeleSpec, 
                                    Hyper="TriggerBK")
AdeleDealCycleTrigger <- DealCycleFinal(AdeleDealCycleTrigger)
AdeleDealCycleTrigger <- RuinTerritoryCycle(AdeleDealCycleTrigger, ATKFinalTrigger)
AdeleDealCycleTrigger <- GatheringBlossomWonderCreationCycle(AdeleDealCycleTrigger, ATKFinalTrigger)
AdeleDealCycleTrigger <- StormRepATKCycle(AdeleDealCycleTrigger, ATKFinalTrigger)
AdeleDealCycleTrigger <- AdeleOrderCycle(AdeleDealCycleTrigger, SummonedFinal)
AdeleDealCycleTrigger <- RepATKCycle(AdeleDealCycleTrigger, "Infinite", 29, 0, ATKFinalTrigger)
AdeleDealCycleTrigger <- RepATKCycle(AdeleDealCycleTrigger, "Restore", 10, 3000, ATKFinalTrigger)
AdeleDealCycleTrigger <- AdeleMCFAWCycle(AdeleDealCycleTrigger, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycleTrigger <- DCSpiderInMirror(AdeleDealCycleTrigger, SummonedFinal)
AdeleDealCycleTriggerReduction <- DealCycleReduction(AdeleDealCycleTrigger)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Adele") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  AdeleSpecOpt1 <- Optimization1(AdeleDealCycleTriggerReduction, ATKFinalTrigger, BuffFinal, SummonedFinal, AdeleSpec, AdeleUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- AdeleSpecOpt1[1, 1:3]
} else {
  AdeleSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
AdeleSpecOpt <- OptDataAdd(AdeleSpec, AdeleSpecOpt1, "Potential", AdeleBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  AdeleSpecOpt2 <- Optimization2(AdeleDealCycleTriggerReduction, ATKFinalTrigger, BuffFinal, SummonedFinal, AdeleSpecOpt, AdeleHyperStatBase, AdeleBase$ChrLv, AdeleBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- AdeleSpecOpt2[1, ]
} else {
  AdeleSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
AdeleSpecOpt <- OptDataAdd(AdeleSpecOpt, AdeleSpecOpt2, "HyperStat", AdeleBase$CRROver, DemonAvenger=F)

AdeleFinalDPM <- DealCalc(AdeleDealCycleTrigger, ATKFinalTrigger, BuffFinal, SummonedFinal, AdeleSpecOpt, Collapse=F)
AdeleFinalDPMwithMax <- DealCalcWithMaxDMR(AdeleDealCycleTrigger, ATKFinalTrigger, BuffFinal, SummonedFinal, AdeleSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Adele", sum(na.omit(AdeleFinalDPMwithMax)) / (max(AdeleDealCycleTrigger$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Adele", sum(na.omit(AdeleFinalDPM)) / (max(AdeleDealCycleTrigger$Time) / 60000) - sum(na.omit(AdeleFinalDPMwithMax)) / (max(AdeleDealCycleTrigger$Time) / 60000))

AdeleDealRatio <- DealRatio(AdeleDealCycleTrigger, AdeleFinalDPMwithMax)

AdeleDealData <- data.frame(AdeleDealCycleTrigger$Skills, AdeleDealCycleTrigger$Time, AdeleDealCycleTrigger$Restraint4, AdeleFinalDPMwithMax)
colnames(AdeleDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Adele", Deal_RR(AdeleDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Adele", Deal_40s(AdeleDealData, F, StartTime=subset(AdeleDealData, AdeleDealData$Skills=="InfiniteBuff")$Time[1]))

AdeleSpecMean <- SpecMean("Adele", AdeleDealCycleTriggerReduction, 
                          DealCalcWithMaxDMR(AdeleDealCycleTriggerReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt), 
                          ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt)


## Other Hypers - Nobility
AdeleDealCycleNobility <- AdeleCycle(PreDealCycle=AdeleDealCycle, 
                             ATKFinal=ATKFinal, 
                             BuffFinal=BuffFinal, 
                             SummonedFinal=SummonedFinal, 
                             Spec=AdeleSpec, 
                             Hyper="Nobility")
AdeleDealCycleNobility <- DealCycleFinal(AdeleDealCycleNobility)
AdeleDealCycleNobility <- RuinTerritoryCycle(AdeleDealCycleNobility, ATKFinal)
AdeleDealCycleNobility <- GatheringBlossomWonderCreationCycle(AdeleDealCycleNobility, ATKFinal)
AdeleDealCycleNobility <- StormRepATKCycle(AdeleDealCycleNobility, ATKFinal)
AdeleDealCycleNobility <- AdeleOrderCycle(AdeleDealCycleNobility, SummonedFinal)
AdeleDealCycleNobility <- RepATKCycle(AdeleDealCycleNobility, "Infinite", 29, 0, ATKFinal)
AdeleDealCycleNobility <- RepATKCycle(AdeleDealCycleNobility, "Restore", 10, 3000, ATKFinal)
AdeleDealCycleNobility <- AdeleMCFAWCycle(AdeleDealCycleNobility, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycleNobility <- DCSpiderInMirror(AdeleDealCycleNobility, SummonedFinal)

AdeleDPMNobility <- DealCalcWithMaxDMR(AdeleDealCycleNobility, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt)
NobilityDPM <- sum(na.omit(AdeleDPMNobility)) / (max(AdeleDealCycleNobility$Time) / 60000)

AdeleDealDataNobility <- data.frame(AdeleDealCycleNobility$Skills, AdeleDealCycleNobility$Time, AdeleDealCycleNobility$Restraint4, AdeleDPMNobility)
colnames(AdeleDealDataNobility) <- c("Skills", "Time", "R4", "Deal")

AdeleRRNobility <- Deal_RR(AdeleDealDataNobility)
Adele40sNobility <- Deal_40s(AdeleDealDataNobility, F, StartTime=subset(AdeleDealDataNobility, AdeleDealDataNobility$Skills=="InfiniteBuff")$Time[1])

  
## Other Hypers - Dike
DealCycle <- c("Skills", "Time", rownames(AdeleBuff))
AdeleDealCycle <- t(rep(0, length(DealCycle)))
colnames(AdeleDealCycle) <- DealCycle
AdeleDealCycle <- data.frame(AdeleDealCycle)
AdeleDealCycle$Ether <- 400

ATKFinalDike <- AdeleATKFinal(ATKFinal, Hyper="Dike")
AdeleDealCycleDike <- AdeleCycle(PreDealCycle=AdeleDealCycle, 
                                 ATKFinal=ATKFinalDike, 
                                 BuffFinal=BuffFinal, 
                                 SummonedFinal=SummonedFinal, 
                                 Spec=AdeleSpec, 
                                 Hyper="Dike")
AdeleDealCycleDike <- DealCycleFinal(AdeleDealCycleDike)
AdeleDealCycleDike <- RuinTerritoryCycle(AdeleDealCycleDike, ATKFinalDike)
AdeleDealCycleDike <- GatheringBlossomWonderCreationCycle(AdeleDealCycleDike, ATKFinalDike)
AdeleDealCycleDike <- StormRepATKCycle(AdeleDealCycleDike, ATKFinalDike)
AdeleDealCycleDike <- AdeleOrderCycle(AdeleDealCycleDike, SummonedFinal)
AdeleDealCycleDike <- RepATKCycle(AdeleDealCycleDike, "Infinite", 29, 0, ATKFinalDike)
AdeleDealCycleDike <- RepATKCycle(AdeleDealCycleDike, "Restore", 10, 3000, ATKFinalDike)
AdeleDealCycleDike <- AdeleMCFAWCycle(AdeleDealCycleDike, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycleDike <- DCSpiderInMirror(AdeleDealCycleDike, SummonedFinal)

AdeleDPMDike <- DealCalcWithMaxDMR(AdeleDealCycleDike, ATKFinalDike, BuffFinal, SummonedFinal, AdeleSpecOpt)
DikeDPM <- sum(na.omit(AdeleDPMDike)) / (max(AdeleDealCycleDike$Time) / 60000)

AdeleDealDataDike <- data.frame(AdeleDealCycleDike$Skills, AdeleDealCycleDike$Time, AdeleDealCycleDike$Restraint4, AdeleDPMDike)
colnames(AdeleDealDataDike) <- c("Skills", "Time", "R4", "Deal")

AdeleRRDike <- Deal_RR(AdeleDealDataDike)
Adele40sDike <- Deal_40s(AdeleDealDataDike, F, StartTime=subset(AdeleDealDataDike, AdeleDealDataDike$Skills=="InfiniteBuff")$Time[1])


## Other Hypers - Nobility 50%
BuffFinalNobility50 <- AdeleBuffFinal(BuffFinal, ShieldRate=50)
AdeleDealCycleNobility50 <- AdeleCycle(PreDealCycle=AdeleDealCycle, 
                             ATKFinal=ATKFinal, 
                             BuffFinal=BuffFinalNobility50, 
                             SummonedFinal=SummonedFinal, 
                             Spec=AdeleSpec, 
                             Hyper="Nobility")
AdeleDealCycleNobility50 <- DealCycleFinal(AdeleDealCycleNobility50)
AdeleDealCycleNobility50 <- RuinTerritoryCycle(AdeleDealCycleNobility50, ATKFinal)
AdeleDealCycleNobility50 <- GatheringBlossomWonderCreationCycle(AdeleDealCycleNobility50, ATKFinal)
AdeleDealCycleNobility50 <- StormRepATKCycle(AdeleDealCycleNobility50, ATKFinal)
AdeleDealCycleNobility50 <- AdeleOrderCycle(AdeleDealCycleNobility50, SummonedFinal)
AdeleDealCycleNobility50 <- RepATKCycle(AdeleDealCycleNobility50, "Infinite", 29, 0, ATKFinal)
AdeleDealCycleNobility50 <- RepATKCycle(AdeleDealCycleNobility50, "Restore", 10, 3000, ATKFinal)
AdeleDealCycleNobility50 <- AdeleMCFAWCycle(AdeleDealCycleNobility50, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycleNobility50 <- DCSpiderInMirror(AdeleDealCycleNobility50, SummonedFinal)

AdeleDPMNobility50 <- DealCalcWithMaxDMR(AdeleDealCycleNobility50, ATKFinal, BuffFinalNobility50, SummonedFinal, AdeleSpecOpt)
Nobility50DPM <- sum(na.omit(AdeleDPMNobility50)) / (max(AdeleDealCycleNobility50$Time) / 60000)

AdeleDealDataNobility50 <- data.frame(AdeleDealCycleNobility50$Skills, AdeleDealCycleNobility50$Time, AdeleDealCycleNobility50$Restraint4, AdeleDPMNobility50)
colnames(AdeleDealDataNobility50) <- c("Skills", "Time", "R4", "Deal")

AdeleRRNobility50 <- Deal_RR(AdeleDealDataNobility50)
Adele40sNobility50 <- Deal_40s(AdeleDealDataNobility50, F, StartTime=subset(AdeleDealDataNobility50, AdeleDealDataNobility50$Skills=="InfiniteBuff")$Time[1])

print(list(ADNobility=data.frame(NobilityDPM=NobilityDPM, NobilityRR=AdeleRRNobility, Nobility40s=Adele40sNobility), 
           ADDike=data.frame(DikeDPM=DikeDPM, DikeRR=AdeleRRDike, Dike40s=Adele40sDike), 
           ADNobility50=data.frame(Nobility50DPM=Nobility50DPM, Nobility50RR=AdeleRRNobility50, Nobility5040s=Adele40sNobility50)))