## Ark - Data
## Ark - VMatrix
ArkCoreBase <- CoreBuilder(ActSkills=c("InfinitySpell", "AbyssalRecall", "DeviousNightmare_Dream", "EndlesslyStarvingBeast",
                                       CommonV("Pirate", "Lef")), 
                           ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                           UsefulSkills=c("CombatOrders", "SharpEyes"), 
                           SpecSet=get(DPMCalcOption$SpecSet), 
                           VPassiveList=ArkVPassive, 
                           VPassivePrior=ArkVPrior, 
                           SelfBind=T)

ArkCore <- MatrixSet(PasSkills=ArkCoreBase$PasSkills$Skills, 
                     PasLvs=ArkCoreBase$PasSkills$Lv, 
                     PasMP=ArkCoreBase$PasSkills$MP, 
                     ActSkills=ArkCoreBase$ActSkills$Skills, 
                     ActLvs=ArkCoreBase$ActSkills$Lv, 
                     ActMP=ArkCoreBase$ActSkills$MP, 
                     UsefulSkills=ArkCoreBase$UsefulSkills, 
                     UsefulLvs=20, 
                     UsefulMP=0, 
                     SpecSet=get(DPMCalcOption$SpecSet), 
                     SpecialCore=ArkCoreBase$SpecialCoreUse)


## Ark - Basic Info
ArkBase <- JobBase(ChrInfo=ChrInfo, 
                   MobInfo=get(DPMCalcOption$MobSet),
                   SpecSet=get(DPMCalcOption$SpecSet), 
                   Job="Ark",
                   CoreData=ArkCore, 
                   BuffDurationNeeded=0, 
                   AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Ark"), 
                   LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Ark"), 
                   MonsterLife=get(FindJob(MonsterLifePreSet, "Ark")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                   Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                   WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                   SubWeapon=SubWeapon[rownames(SubWeapon)=="PathofAbyss", ], 
                   Emblem=Emblem[rownames(Emblem)=="Abyss", ], 
                   CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Ark")))


## Ark - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6] * 0.10), floor(ArkBase$ItemSet$ATKSub * 0.25)))
MagicCircuit <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
MysticAchMastery <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
KnuckleMastery <- data.frame(option, value) 

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value) 

option <- factor(c("FDR", "CRR"), levels=PSkill)
value <- c(10, 20)
InitateFusion <- data.frame(option, value) 

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(ArkBase$PSkillLv/2), 30 + ArkBase$PSkillLv, 30 + ArkBase$PSkillLv) 
KnuckleExpert <- data.frame(option, value) 

option <- factor(c("ATK", "CRR", "IGR", "BDR"), levels=PSkill)
value <- c(40 + ArkBase$PSkillLv, 10 + ceiling(ArkBase$PSkillLv/3), 30 + ArkBase$PSkillLv, 30 + ArkBase$PSkillLv)
CompleteFusion <- data.frame(option, value) 

option <- factor(c("FDR"), levels=PSkill)
value <- c(20 + ArkBase$PSkillLv)
BattleFrenzy <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + GetCoreLv(ArkCore, "LoadedDice"))
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ArkCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(ArkCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

ArkPassive <- Passive(list(MagicCircuit, MysticAchMastery, KnuckleMastery, PhysicalTraining, InitateFusion, KnuckleExpert, CompleteFusion, BattleFrenzy, LoadedDice, BlinkPassive, RopeConnectPassive))


## Ark - Buff
{option <- factor(c("ATK"), levels=BSkill)
value <- c(30)
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Spectre <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Lef <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpecterGaugeDummy <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpecterGauge <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VengefulHateStack <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 0, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AbyssalRecallBuff <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(3)
info <- c(300, 600, 720, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ContactCaravan <- rbind(data.frame(option, value), info) 

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
KnuckleBooster <- rbind(data.frame(option, value), info) 

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ArkBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ArkBase$SkillLv/2))))
info <- c(900 + 30 * ArkBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "CRR"), levels=BSkill)
value <- c(30, 20)
info <- c(60, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ScarletBuff <- rbind(data.frame(option, value), info) 

option <- factor(c("ATK", "CRR"), levels=BSkill)
value <- c(30, 20)
info <- c(60, 120, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ScarletBuffAmplification <- rbind(data.frame(option, value), info) 

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(1)
info <- c(60, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GustBuff <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR","IGR"), levels=BSkill)
value <- c(50 + ArkSpec$SkillLv + floor(ArkSpec$SkillLv/2), 20 + floor(ArkSpec$SkillLv/2))
info <- c(60, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AbyssBuff <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR","IGR"), levels=BSkill)
value <- c(50 + ArkSpec$SkillLv + floor(ArkSpec$SkillLv/2), ifelse(ArkSpec$SkillLv >= 2, 26.582278, 25))
info <- c(60, 120, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AbyssSpellBuffAmplification <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(60, 120, 720, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ChargeSpellAmplification <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR"), levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RaceofGod <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + 2 * GetCoreLv(ArkCore, "InfinitySpell"), 240, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfinitySpell <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 180, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(ArkCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6]))
info <- c(30, 70 - floor(GetCoreLv(ArkCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info) 

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(ArkCore, "OverDrive")/5), T, ArkBase$UnionChrs$CoolReduceP, ArkBase$CoolReduce) - 30 - General$General$Serverlag, 70 - floor(GetCoreLv(ArkCore, "OverDrive")/5), 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(19 + GetCoreLv(ArkCore, "MagicCircuitFullDrive"))
info <- c(30 + GetCoreLv(ArkCore, "MagicCircuitFullDrive"), 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info) 

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * GetCoreLv(ArkCore, "BlessofGrandisGoddess") + (min((0.4 + 0.02 * GetCoreLv(ArkCore, "BlessofGrandisGoddess")) * ArkBase$ItemSet$ATKSub, floor(ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6] * 1.5))))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandis <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(ArkCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}
}

ArkBuff <- list(Spectre=Spectre, Lef=Lef, SpecterGauge=SpecterGauge, SpecterGaugeDummy=SpecterGaugeDummy, VengefulHateStack=VengefulHateStack, AbyssalRecallBuff=AbyssalRecallBuff, 
                ContactCaravan=ContactCaravan, KnuckleBooster=KnuckleBooster, MapleSoldier=MapleSoldier, 
                ScarletBuff=ScarletBuff, ScarletBuffAmplification=ScarletBuffAmplification, GustBuff=GustBuff, AbyssBuff=AbyssBuff, AbyssSpellBuffAmplification=AbyssSpellBuffAmplification, 
                ChargeSpellAmplification=ChargeSpellAmplification, RaceofGod=RaceofGod, InfinitySpell=InfinitySpell, LuckyDice5=LuckyDice5, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, 
                MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, BlessofGrandis=BlessofGrandis, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  ArkBuff[[length(ArkBuff)+1]] <- UsefulAdvancedBless
  names(ArkBuff)[[length(ArkBuff)]] <- "UsefulAdvancedBless"
}
ArkBuff <- Buff(ArkBuff)
ArkAllTimeBuff <- AllTimeBuff(ArkBuff)
## Petbuff : UsefulCombatOrders, UsefulSharpEyes, KnuckleBooster, MapleSoldier, (UsefulAdvancedBless)


## Ark - Union & HyperStat & SoulWeapon
ArkSpec <- JobSpec(JobBase=ArkBase, 
                   Passive=ArkPassive, 
                   AllTimeBuff=ArkAllTimeBuff, 
                   MobInfo=get(DPMCalcOption$MobSet), 
                   SpecSet=get(DPMCalcOption$SpecSet), 
                   WeaponName="Knuckle", 
                   UnionStance=0)

ArkUnionRemained <- ArkSpec$UnionRemained
ArkHyperStatBase <- ArkSpec$HyperStatBase
ArkCoolReduceType <- ArkSpec$CoolReduceType
ArkSpec <- ArkSpec$Spec


## Ark - Spider In Mirror
SIM <- SIMData(GetCoreLv(ArkCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Ark - Attacks
## Hyper - Battle Arts - Reinforce / Ignore Guard / Boss Killer, Spectre - Extra Healing / Enhance 
{option <- factor(levels=ASkill)
value <- c() 
info <- c(0, 0, 30, NA, 3, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
LeftoSpectre <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(0, 0, 30, NA, 3, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
SpectretoLef <- rbind(data.frame(option, value), info) 
  
option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "PlainChargeDrive")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "PlainChargeDrive")) 
info <- c(610 + 3 * ArkSpec$PSkillLv, 3, 720, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
PlainChargeDrive <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "PlainChargeDrive")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "PlainChargeDrive")) 
info <- c(370 + 3 * ArkSpec$PSkillLv, 2, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
PlainSpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")) 
info <- c(350 + 3 * ArkSpec$PSkillLv, 3, 690, 1650, 3, T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
ScarletChargeDrive <- rbind(data.frame(option, value), info)  # 2 Hits

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")) 
info <- c(220 + 1 * ArkSpec$PSkillLv, 5, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
ScarletSpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")) 
info <- c(510 + 3 * ArkSpec$PSkillLv, 6, 630, NA, 3, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GrievousWound <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "UnstoppableImpulse_TenaciousInstinct")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "UnstoppableImpulse_TenaciousInstinct")) 
info <- c(435 + 3 * ArkSpec$PSkillLv, 5, 720, NA, 6, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
UnstoppableImpulse <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "UnstoppableImpulse_TenaciousInstinct")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "UnstoppableImpulse_TenaciousInstinct")) 
info <- c(460 + 3 * ArkSpec$PSkillLv, 6, 720, NA, 6, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
TenaciousInstinct <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "ImpendingDeath_VengefulHate")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "ImpendingDeath_VengefulHate"))
info <- c(450 + 3 * ArkSpec$PSkillLv, 2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ImpendingDeath <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")) 
info <- c(400 + 3 * ArkSpec$PSkillLv, 6, 600, NA, 5, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GustChargeDrive <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")) 
info <- c(230 + 1 * ArkSpec$PSkillLv, 4, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GustSpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")) 
info <- c(1290 + 3 * ArkSpec$PSkillLv, 15, 900, NA, 60, T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
CreepingTerror <- rbind(data.frame(option, value), info) 
  
option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")) 
info <- c(510 + 3 * ArkSpec$PSkillLv, 7, 990, NA, 5 , T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
InsatiableHunger <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "ImpendingDeath_VengefulHate")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "ImpendingDeath_VengefulHate"))
info <- c(320 + 3 * ArkSpec$PSkillLv, 6, 0, NA, 12, T, F, F) 
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VengefulHate <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "EndlessNightmare_Dream")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "EndlessNightmare_Dream")) 
info <- c(440 + 3 * ArkSpec$SkillLv, 6, 720, NA, 2, T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EndlessNightmare <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "EndlessNightmare_Dream")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "EndlessNightmare_Dream")) 
info <- c(445 + 3 * ArkSpec$SkillLv, 6, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EndlessOminousDream <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")) 
info <- c(340 + 3 * ArkSpec$SkillLv, 4, 810, 30, 9, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssChargeDrive1 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")) 
info <- c(410 + 3 * ArkSpec$SkillLv, 6, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssChargeDrive2 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")) 
info <- c(70 + 2 * ArkSpec$SkillLv, 2, 0, 300, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssSpell <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")) 
info <- c(440 + 3 * ArkSpec$SkillLv, 12, 1080, NA, 9, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
UnbridledChaos <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony"))
info <- c(600 + 10 * ArkSpec$SkillLv, 6, 900, NA, 180, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
BlissfulRestraint <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony"))
info <- c(400 + 10 * ArkSpec$SkillLv, 3, 0, 450, 0, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
BlissfulRestraintContinuousATK <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0))), 40, 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony"))
info <- c(1000 + 10 * ArkSpec$SkillLv, 8, 0, 0, F, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
BlissfulRestraintLastATK <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony"))
info <- c(300, 3, 3000, 180, 63, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EndlessAgony <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony")>=40, 20, 0), 2 * GetCoreLv(ArkCore, "CreepingTerror_BlissfulRestraint_EndlessAgony"))
info <- c(350, 12, 1590, 30, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EndlessAgonyLast <- rbind(data.frame(option, value), info) ## StartATK 180ms

option <- factor(levels=ASkill)
value <- c() 
info <- c(400 + 16 * GetCoreLv(ArkCore, "AbyssalRecall"), 6, 9960, 210, 200, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssalRecall <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(1200 + 48 * GetCoreLv(ArkCore, "AbyssalRecall"), 72, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssalRecallExplosion <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(500 + 20 * GetCoreLv(ArkCore, "DeviousNightmare_Dream"), 9, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DeviousNightmare <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(600 + 24 * GetCoreLv(ArkCore, "DeviousNightmare_Dream"), 9, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DeviousOminousDream <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(400 + 16 * GetCoreLv(ArkCore, "EndlesslyStarvingBeast"), 12, 690, 30, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EndlesslyStarvingBeast <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(ArkCore, "MagicCircuitFullDrive"), 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "PlainChargeDrive")>=40, 20, 0), 20, 2 * GetCoreLv(ArkCore, "PlainChargeDrive")) 
info <- c(370 + 3 * ArkSpec$PSkillLv, 2, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
PlainSpellInfinitySpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")>=40, 20, 0), 20, 2 * GetCoreLv(ArkCore, "ScarletChargeDrive_GrievousWound")) 
info <- c(220 + 1 * ArkSpec$PSkillLv, 5, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
ScarletSpellInfinitySpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")>=40, 20, 0), 20, 2 * GetCoreLv(ArkCore, "GustChargeDrive_InsatiableHunger")) 
info <- c(230 + 1 * ArkSpec$PSkillLv, 4, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GustSpellInfinitySpell <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")>=40, 20, 0), 20, 2 * GetCoreLv(ArkCore, "AbyssChargeDrive_UnbridledChaos")) 
info <- c(70 + 2 * ArkSpec$SkillLv, 2, 0, 300, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
AbyssSpellInfinitySpell <- rbind(data.frame(option, value), info)}

ArkATK <- Attack(list(PlainChargeDrive=PlainChargeDrive, ScarletChargeDrive=ScarletChargeDrive, GustChargeDrive=GustChargeDrive, AbyssChargeDrive1=AbyssChargeDrive1, AbyssChargeDrive2=AbyssChargeDrive2, 
                      PlainSpell=PlainSpell, ScarletSpell=ScarletSpell, GustSpell=GustSpell, AbyssSpell=AbyssSpell, 
                      PlainSpellInfinitySpell=PlainSpellInfinitySpell, ScarletSpellInfinitySpell=ScarletSpellInfinitySpell, 
                      GustSpellInfinitySpell=GustSpellInfinitySpell, AbyssSpellInfinitySpell=AbyssSpellInfinitySpell,
                      EndlessNightmare=EndlessNightmare, EndlessOminousDream=EndlessOminousDream, 
                      GrievousWound=GrievousWound, InsatiableHunger=InsatiableHunger, UnbridledChaos=UnbridledChaos, 
                      UnstoppableImpulse=UnstoppableImpulse, TenaciousInstinct=TenaciousInstinct, 
                      ImpendingDeath=ImpendingDeath, VengefulHate=VengefulHate, CreepingTerror=CreepingTerror, 
                      BlissfulRestraint=BlissfulRestraint, BlissfulRestraintContinuousATK=BlissfulRestraintContinuousATK, BlissfulRestraintLastATK=BlissfulRestraintLastATK, 
                      EndlessAgony=EndlessAgony, EndlessAgonyLast=EndlessAgonyLast, 
                      AbyssalRecall=AbyssalRecall, AbyssalRecallExplosion=AbyssalRecallExplosion, DeviousNightmare=DeviousNightmare, DeviousOminousDream=DeviousOminousDream, 
                      EndlesslyStarvingBeast=EndlesslyStarvingBeast, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror,
                      LeftoSpectre=LeftoSpectre, SpectretoLef=SpectretoLef))


## Ark - Summoned
ArkSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, 
                             SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                             SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Ark - DealCycle & Deal Calculation
ATKFinal <- data.frame(ArkATK)
ATKFinal$Delay[c(-27:-29)] <- Delay(ATKFinal$Delay, ArkSpec$ATKSpeed)[c(-27:-29)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArkSpec$CoolReduceP, ArkSpec$CoolReduce)

BuffFinal <- data.frame(ArkBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArkSpec$CoolReduceP, ArkSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArkSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ArkSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArkSpec$CoolReduceP, ArkSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArkSpec$SummonedDuration / 100, 0)


## Ark - Delay Skip Structure
ArkSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
ArkSkipATK <- data.frame(ArkSkipATK, row.names=c(rownames(ATKFinal)))
colnames(ArkSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

ArkSkipATK$ScarletChargeDrive <- c(T, rep(F, 36))
ArkSkipATK$GustChargeDrive <- c(T, rep(F, 36))
ArkSkipATK$AbyssChargeDrive1 <- c(T, rep(F, 36))
ArkSkipATK$EndlessNightmare <- c(T, rep(F, 36))
ArkSkipATK$UnstoppableImpulse <- c(T, rep(F, 36))

ArkSkipATK$EndlessOminousDream <- c(rep(F, 16), T, T, F, F, F, F, T, T, F, F, F, T, rep(F, 9))
ArkSkipATK$GrievousWound <- c(rep(F, 14), T, F, F, F, F, F, F, F, T, T, F, F, F, T, rep(F, 9))
ArkSkipATK$InsatiableHunger <- c(rep(F, 14), T, F, F, F, F, F, F, F, T, T, F, F, F, T, rep(F, 9))
ArkSkipATK$UnbridledChaos <- c(rep(F, 14), T, F, F, F, F, F, F, F, T, T, F, F, F, T, rep(F, 9))
ArkSkipATK$TenaciousInstinct <- c(rep(F, 14), T, F, F, F, F, F, F, F, T, T, F, F, F, T, rep(F, 9))
ArkSkipATK$CreepingTerror <- c(rep(F, 14), T, F, T, T, F, F, F, F, F, T, F, F, F, T, rep(F, 9))
ArkSkipATK$BlissfulRestraint <- c(rep(F, 14), T, F, T, T, F, F, F, F, T, F, F, F, F, T, rep(F, 9))
ArkSkipATK$EndlessAgony <- c(rep(F, 14), T, F, T, T, F, F, F, F, T, T, F, F, F, F, rep(F, 9))
ArkSkipATK$AbyssalRecall <- c(rep(F, 14), T, F, T, T, F, F, F, F, T, T, F, F, F, T, rep(F, 9))

ArkSkipATK$SkippedDelay <- c(270, rep(NA, 13), 210, NA, 690, 750, rep(NA, 4), 420, rep(NA, 4), 1080, rep(NA, 9))
ArkSkipATK <- subset(ArkSkipATK, ArkSkipATK$SkippedDelay>0)


## Ark - DealCycle
DealCycle <- c("Skills", "Time", rownames(ArkBuff))
ArkDealCycle <- t(rep(0, length(DealCycle)))
colnames(ArkDealCycle) <- DealCycle
ArkDealCycle <- data.frame(ArkDealCycle)

ArkCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure, 
                     Period=182.4, CycleTime=729.6, CancelDelay=30) {
  SkipStructure$SkippedDelay <- SkipStructure$SkippedDelay + (CancelDelay - 30)
  BuffSummonedPrior <- c("KnuckleBooster", "LuckyDice5", "ContactCaravan", "RaceofGod", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "ChargeSpellAmplification", "MagicCircuitFullDriveBuff", "OverDrive", "BlessofGrandis", "InfinitySpell", "SoulContractLink", "Restraint4")
  Times180 <- c(0, 0, 1/4, 0, 0, 0, 0, 
                1.5, 3/4, 3, 3/4, 3/4, 1.5, 3/4)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period - min(2.4, Spec$CoolReduce), length(BuffSummonedPrior))
  TotalTime <- CycleTime - min(2.4, Spec$CoolReduce) * (CycleTime/Period)
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times180[i]==0, Inf, Times180[i])
  }
  
  SubTimeUniques <- unique(SubTime)
  SubTimeUniques <- SubTimeUniques[SubTimeUniques > 0]
  TimeTypes <- c()
  for(i in 1:length(SubTimeUniques)) {
    Time <- 0 ; r <- 1
    while(Time < TotalTime) {
      Time <- SubTimeUniques[i] * r
      r <- r + 1
      TimeTypes <- c(TimeTypes, Time)
    }
  }
  TimeTypes <- TimeTypes[TimeTypes < TotalTime]
  TimeTypes <- unique(TimeTypes)
  TimeTypes <- TimeTypes[order(TimeTypes)]
  
  Buffs <- data.frame(Buff=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  Buffs <- subset(Buffs, Buffs$SubTime > 0)
  
  BuffList <- list()
  BuffList[[1]] <- BuffSummonedPrior
  for(i in 1:length(TimeTypes)) {
    s <- c()
    for(j in 1:nrow(Buffs)) {
      if(round(TimeTypes[i] / Buffs[j, 2]) == TimeTypes[i] / Buffs[j, 2]) {
        s <- c(s, Buffs[j, 1])
      }
    }
    BuffList[[i+1]] <- s
  }
  
  DelayDataB <- data.frame(Name=rownames(BuffFinal), Delay=BuffFinal$Delay)
  DelayDataS <- data.frame(Name=rownames(SummonedFinal), Delay=SummonedFinal$Delay)
  DelayData <- rbind(DelayDataB, DelayDataS)
  
  BuffDelays <- list()
  for(i in 1:length(BuffList)) {
    t <- c()
    for(j in 1:length(BuffList[[i]])) {
      for(k in 1:nrow(DelayData)) {
        if(DelayData$Name[k]==BuffList[[i]][j]) {
          t <- c(t, k)
        }
      }
    }
    BuffDelays[[i]] <- DelayData$Delay[t]
  } 
  
  ArkGauge <- function(DealCycle) {
    DealCycle$SpecterGauge[nrow(DealCycle)] <- DealCycle$SpecterGauge[nrow(DealCycle)-1]
    
    if(DealCycle$Skills[nrow(DealCycle)]=="EndlessAgony") {
      DealCycle$SpecterGaugeDummy[nrow(DealCycle)] <- DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1] + 3000
    } else if(DealCycle$Skills[nrow(DealCycle)]=="AbyssalRecall") {
      DealCycle$SpecterGaugeDummy[nrow(DealCycle)] <- DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1] + 10040
    }
    
    if(DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SpecterGaugeDummy[nrow(DealCycle)]==0 & DealCycle$Spectre[nrow(DealCycle)-1] > 0 & 
            DealCycle$AbyssalRecallBuff[nrow(DealCycle)-1] > 0) {
      DealCycle$SpecterGauge[nrow(DealCycle)] <- DealCycle$SpecterGauge[nrow(DealCycle)]
      DealCycle$SpecterGaugeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 1000, 1000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1]))
    }
    else if(DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SpecterGaugeDummy[nrow(DealCycle)]==0 & DealCycle$Spectre[nrow(DealCycle)-1] > 0) {
      DealCycle$SpecterGauge[nrow(DealCycle)] <- min(1000, DealCycle$SpecterGauge[nrow(DealCycle)] - 23)
      DealCycle$SpecterGaugeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 1000, 1000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1]))
    } 
    else if(DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SpecterGaugeDummy[nrow(DealCycle)]==0 & DealCycle$Lef[nrow(DealCycle)-1] > 0) {
      DealCycle$SpecterGauge[nrow(DealCycle)] <- min(1000, DealCycle$SpecterGauge[nrow(DealCycle)] + 14.3)
      DealCycle$SpecterGaugeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 1000, 1000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SpecterGaugeDummy[nrow(DealCycle)-1]))
    }
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$SpecterGauge[2] <- 900 ; DealCycle$SpecterGaugeDummy[2] <- 1000 ; DealCycle$Lef[2] <- 100000
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="SoulContractLink") {
        DealCycle <- DCATKSkip(DealCycle, "EndlesslyStarvingBeast", ATKFinal, SkipStructure)
        DealCycle$Spectre[nrow(DealCycle)] <- 10000 + DealCycle$BlessofGrandis[nrow(DealCycle)]
        DealCycle$Lef[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- ArkGauge(DealCycle)
      if(BuffList[[1]][i]=="ChargeSpellAmplification") {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle <- DCATKSkip(DealCycle, "ScarletChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle$ScarletBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="ScarletBuff")$Duration * 1000
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle <- DCATKSkip(DealCycle, "GustChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle$GustBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="GustBuff")$Duration * 1000
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle <- DCATKSkip(DealCycle, "AbyssChargeDrive1", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle$AbyssBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AbyssBuff")$Duration * 1000
        DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
      } else if(BuffList[[1]][i]=="SoulContractLink") {
        DealCycle <- DCATKSkip(DealCycle, "BlissfulRestraint", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- ArkGauge(DealCycle)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c() ; NoSubTimeSummoned <- c()
  for(i in 1:length(NoSubTime)) {
    NoSubTimeBuff <- c(NoSubTimeBuff, NoSubTime[i])
  }
  ColNums <- c()
  for(i in 1:length(NoSubTimeBuff)) {
    for(j in 1:length(colnames(DealCycle))) {
      if(NoSubTimeBuff[i]==colnames(DealCycle)[j]) {
        ColNums[i] <- j
      }
    }
  }
  SCCool <- subset(ATKFinal, rownames(ATKFinal)=="ScarletChargeDrive")$CoolTime * 1000
  GCCool <- subset(ATKFinal, rownames(ATKFinal)=="GustChargeDrive")$CoolTime * 1000
  ACCool <- subset(ATKFinal, rownames(ATKFinal)=="AbyssChargeDrive1")$CoolTime * 1000
  ENCool <- subset(ATKFinal, rownames(ATKFinal)=="EndlessNightmare")$CoolTime * 1000
  DNCool <- subset(ATKFinal, rownames(ATKFinal)=="DeviousNightmare")$CoolTime * 1000
  DNSCDummy <- 0 ; DNGCDummy <- 0 ; DNACDummy <- 0
  
  GWCool <- subset(ATKFinal, rownames(ATKFinal)=="GrievousWound")$CoolTime * 1000
  IHCool <- subset(ATKFinal, rownames(ATKFinal)=="InsatiableHunger")$CoolTime * 1000
  UCCool <- subset(ATKFinal, rownames(ATKFinal)=="UnbridledChaos")$CoolTime * 1000
  VHCool <- subset(ATKFinal, rownames(ATKFinal)=="VengefulHate")$CoolTime * 1000
  EACool <- subset(ATKFinal, rownames(ATKFinal)=="EndlessAgony")$CoolTime * 1000
  CTCool <- subset(ATKFinal, rownames(ATKFinal)=="CreepingTerror")$CoolTime * 1000
  DOCool <- subset(ATKFinal, rownames(ATKFinal)=="DeviousOminousDream")$CoolTime * 1000
  DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
  
  TFCool <- subset(ATKFinal, rownames(ATKFinal)=="LeftoSpectre")$CoolTime * 1000
  UICool <- subset(ATKFinal, rownames(ATKFinal)=="UnstoppableImpulse")$CoolTime * 1000
  
  SCRemain <- 0 ; GCRemain <- 0 ; ACRemain <- 0 ; ENRemain <- 0 ; DNRemain <- 0 ; 
  GWRemain <- 0 ; IHRemain <- 0 ; UCRemain <- 0 ; VHRemain <- 0 ; EARemain <- 0 ; CTRemain <- 0 ; DORemain <- 0 
  TFRemain <- 0 ; UIRemain <- 0
  
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  
  for(k in 2:length(BuffList)) {
    CycleBuffList <- data.frame(Skills=BuffList[[k]], Delay=BuffDelays[[k]])
    BuffEndTime <- c()
    for(i in 1:length(BuffList[[k]])) {
      a <- subset(DealCycle, BuffList[[k]][i]==DealCycle$Skills)
      a <- rbind(a, subset(DealCycle, paste(BuffList[[k]][i], "Summoned", sep="")==DealCycle$Skills))
      for(j in 1:nrow(CycleBuffList)) {
        if(CycleBuffList$Skills[j]==BuffList[[k]][i]) {
          Idx <- j
          break
        }
      }
      BuffEndTime[i] <- max(a$Time) + 
        min(subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000, subset(BuffFinal, rownames(BuffFinal)==BuffList[[k]][i])$CoolTime * 1000, 
            subset(SummonedFinal, rownames(SummonedFinal)==BuffList[[k]][i])$CoolTime * 1000) + 
        sum(CycleBuffList$Delay[Idx:nrow(CycleBuffList)])
    }
    BuffEndTime <- max(BuffEndTime)
    BuffEndTime <- max(BuffEndTime, TimeTypes[k] * 1000)
    BuffStartTime <- BuffEndTime - sum(CycleBuffList$Delay)
    if(sum(k==c(5, 9, 13))==1) {
      BuffStartTime <- BuffStartTime - 3000
    }
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          DealCycle <- ArkGauge(DealCycle)
          SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        }
      }
      ## Endless Agony, Creeping Terror, Abyssal Recall
      if(DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] > 10000)  {
        DealCycle <- DCATKSkip(DealCycle, "EndlessAgony", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- EACool
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "EndlessAgonyLast", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "CreepingTerror", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- CTCool
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "AbyssalRecall", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        DealCycle$AbyssalRecallBuff[nrow(DealCycle)] <- 30000 + General$General$Serverlag * 1000
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
      else if(EARemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("EndlessOminousDream", "InsatiableHunger", "UnbridledChaos", "CreepingTerror"))>=1, 
                                subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) <= 0 & sum(k==c(5, 9, 13))==0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessAgony", ATKFinal, SkipStructure)
        DealCycle$Spectre[nrow(DealCycle)] <- 16000
        DealCycle$Lef[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- EACool
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "EndlessAgonyLast", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "CreepingTerror", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- CTCool
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      else if(CTRemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("EndlessOminousDream", "InsatiableHunger", "UnbridledChaos", "EndlessAgonyLast"))>=1, 
                                subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) <= 0 & sum(k==c(5, 9, 13))>=1) {
        DealCycle <- DCATKSkip(DealCycle, "CreepingTerror", ATKFinal, SkipStructure)
        DealCycle$Spectre[nrow(DealCycle)] <- 13000
        DealCycle$Lef[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- CTCool
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Unbridled Chaos
      else if(UCRemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("InsatiableHunger", "UnbridledChaos", "CreepingTerror", "EndlessAgonyLast"))>=1, 
                                subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) - 150 - CancelDelay <= 0 & DealCycle$Spectre[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessOminousDream", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))

        if(DORemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousOminousDream"
          DORemain <- DOCool
          DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "UnbridledChaos", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- UCCool
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DOUCDummy==0) {
          DOUCDummy <- 1
          DORemain <- max(0, DORemain - 1000)
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Insatiable Hunger 
      else if(IHRemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("InsatiableHunger", "UnbridledChaos", "CreepingTerror", "EndlessAgonyLast"))>=1, 
                                subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) - 150 - CancelDelay <= 0 & DealCycle$Spectre[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessOminousDream", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DORemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousOminousDream"
          DORemain <- DOCool
          DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "InsatiableHunger", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- IHCool
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DOIHDummy==0) {
          DOIHDummy <- 1
          DORemain <- max(0, DORemain - 1000)
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Grievous Wound
      else if(GWRemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("InsatiableHunger", "UnbridledChaos", "CreepingTerror", "EndlessAgonyLast"))>=1, 
                                subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) - 150 - CancelDelay <= 0 & DealCycle$Spectre[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessOminousDream", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DORemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousOminousDream"
          DORemain <- DOCool
          DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "GrievousWound", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- GWCool
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DOGWDummy==0) {
          DOGWDummy <- 1
          DORemain <- max(0, DORemain - 1000)
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Tenacious Instinct
      else if(UIRemain - ifelse(sum(DealCycle$Skills[nrow(DealCycle)]==c("InsatiableHunger", "UnbridledChaos", "CreepingTerror", "EndlessAgonyLast"))>=1, 
                                 subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay, DealCycle$Time[1]) - 150 - CancelDelay <= 0 & DealCycle$Spectre[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessOminousDream", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DORemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousOminousDream"
          DORemain <- DOCool
          DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
        
        DealCycle <- DCATKSkip(DealCycle, "TenaciousInstinct", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- UICool
        
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Endless Ominous Dream
      else if(DealCycle$Spectre[nrow(DealCycle)] > 0) {
        DealCycle <- DCATKSkip(DealCycle, "EndlessOminousDream", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DORemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousOminousDream"
          DORemain <- DOCool
          DOGWDummy <- 0 ; DOIHDummy <- 0 ; DOUCDummy <- 0
        }
        if(VHRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "VengefulHate"
          VHRemain <- VHCool
        }
      }
      ## Abyss ChargeDrive
      else if(ACRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))==0 |
              ACRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))>=1 & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 240 + CancelDelay + ACCool < BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "AbyssChargeDrive1", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- ACCool
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$AbyssBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AbyssBuff")$Duration * 1000
        
        if(DNACDummy==0) {
          DNACDummy <- 1
          DNRemain <- max(0, DNRemain - 1000)
        }
      }
      ## Gust ChargeDrive
      else if(GCRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))==0 |
              GCRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))>=1 & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 240 + CancelDelay + GCCool < BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "GustChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- GCCool
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$GustBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="GustBuff")$Duration * 1000
        
        if(DNGCDummy==0) {
          DNGCDummy <- 1
          DNRemain <- max(0, DNRemain - 1000)
        }
      }
      ## Scarlet ChargeDrive
      else if(SCRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))==0 |
              SCRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & sum(k==c(3, 5, 7, 9, 11, 13))>=1 & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 240 +  CancelDelay + SCCool < BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "ScarletChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- SCCool
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DealCycle$ScarletBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="ScarletBuff")$Duration * 1000
        
        if(DNSCDummy==0) {
          DNSCDummy <- 1
          DNRemain <- max(0, DNRemain - 1000)
        }
      }
      ## Endless Nightmare
      else if(ENRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & DealCycle$InfinitySpell[nrow(DealCycle)] == 0 | 
              ENRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & DealCycle$InfinitySpell[nrow(DealCycle)] > 0 &
              DNRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0) {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "EndlessNightmare", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- ENCool
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        if(DNRemain==0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "DeviousNightmare"
          DNRemain <- DNCool
          DNSCDummy <- 0 ; DNGCDummy <- 0 ; DNACDummy <- 0
        }
      }
      ## Unstoppable Impulse
      else if(UIRemain - DealCycle$Time[1] - 240 - CancelDelay <= 0 & DealCycle$Lef[nrow(DealCycle)] > 0 & DealCycle$InfinitySpell[nrow(DealCycle)] == 0) {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        
        DealCycle <- DCATKSkip(DealCycle, "UnstoppableImpulse", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- UICool
      }
      ## Plain ChargeDrive
      else {
        DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
      ## Lef to Spectre
      if(TFRemain - DealCycle$Time[1] <= 0 & DealCycle$Spectre[nrow(DealCycle)] == 0 & DealCycle$Lef[nrow(DealCycle)] < 10000 & sum(k==c(3, 5, 7, 9, 11, 13))==0 |
         TFRemain - DealCycle$Time[1] <= 0 & DealCycle$Spectre[nrow(DealCycle)] == 0 & DealCycle$Lef[nrow(DealCycle)] < 10000 & sum(k==c(3, 5, 7, 9, 11, 13))>=1 & 
         DealCycle$Time[nrow(DealCycle)] + 3000 < BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "LeftoSpectre", ATKFinal, SkipStructure)
        DealCycle$Lef[nrow(DealCycle)] <- 0
        DealCycle$Spectre[nrow(DealCycle)] <- ifelse(DealCycle$InfinitySpell[nrow(DealCycle)] - DealCycle$Time[1] > 0, 16000, 13000)
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- TFCool
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
      ## Spectre to Lef
      else if(TFRemain - DealCycle$Time[1] <= 0 & DealCycle$Lef[nrow(DealCycle)] == 0 & DealCycle$Spectre[nrow(DealCycle)] < 10000 & sum(k==c(4, 5, 8, 9, 12, 13))==0 | 
              TFRemain - DealCycle$Time[1] <= 0 & DealCycle$Lef[nrow(DealCycle)] == 0 & DealCycle$Spectre[nrow(DealCycle)] < 10000 & sum(k==c(4, 5, 8, 9, 12, 13))>=1 &
              DealCycle$Time[nrow(DealCycle)] + 35000 < BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "SpectretoLef", ATKFinal, SkipStructure)
        DealCycle$Lef[nrow(DealCycle)] <- ifelse(DealCycle$InfinitySpell[nrow(DealCycle)] - DealCycle$Time[1] > 0, 13000, 16000)
        DealCycle$Spectre[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- TFCool
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
      else if(TFRemain - DealCycle$Time[1] <= 0 & DealCycle$Lef[nrow(DealCycle)] == 0 & DealCycle$Spectre[nrow(DealCycle)] < 10000 & sum(k==c(4, 5, 8, 9, 12, 13))>=1 & 
              DealCycle$Time[nrow(DealCycle)] + 35000 >= BuffStartTime) {
        DealCycle <- DCATKSkip(DealCycle, "SpectretoLef", ATKFinal, SkipStructure)
        DealCycle$Lef[nrow(DealCycle)] <- 45000
        DealCycle$Spectre[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- TFCool
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
    }
    
    if(k != length(BuffList)) {
      if(sum(k==c(3, 5, 7, 9, 11, 13)) >= 1 & DealCycle$Lef[nrow(DealCycle)]==0) {
        DealCycle <- DCATKSkip(DealCycle, "SpectretoLef", ATKFinal, SkipStructure)
        DealCycle$Lef[nrow(DealCycle)] <- ifelse(DealCycle$InfinitySpell[nrow(DealCycle)] - DealCycle$Time[1] > 0, 16000, 13000)
        DealCycle$Spectre[nrow(DealCycle)] <- 0
        DealCycle <- ArkGauge(DealCycle)
        SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        TFRemain <- TFCool
        UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
      }
      
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="SoulContractLink") {
            DealCycle <- DCATKSkip(DealCycle, "EndlesslyStarvingBeast", ATKFinal, SkipStructure)
            DealCycle$Spectre[nrow(DealCycle)] <- 10000 + ifelse(sum(k==c(5, 9))==1, DealCycle$BlessofGrandis[nrow(DealCycle)], 7000)
            DealCycle$Lef[nrow(DealCycle)] <- 0
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- ArkGauge(DealCycle)
          SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          if(BuffList[[k]][i]=="ChargeSpellAmplification") {
            DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            
            DealCycle <- DCATKSkip(DealCycle, "ScarletChargeDrive", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- SCCool
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$ScarletBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="ScarletBuff")$Duration * 1000
            
            DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            
            DealCycle <- DCATKSkip(DealCycle, "GustChargeDrive", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- GCCool
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$GustBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="GustBuff")$Duration * 1000
            
            DealCycle <- DCATKSkip(DealCycle, "PlainChargeDrive", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            
            DealCycle <- DCATKSkip(DealCycle, "AbyssChargeDrive1", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- ACCool
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DealCycle$AbyssBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AbyssBuff")$Duration * 1000
            
            if(sum(k==c(5, 9))>=1) {
              DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
              DealCycle <- ArkGauge(DealCycle)
              SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
              UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            }
          } else if(BuffList[[k]][i]=="SoulContractLink" & sum(k==c(5, 9))>=1) {
            DealCycle <- DCATKSkip(DealCycle, "BlissfulRestraint", ATKFinal, SkipStructure)
            DealCycle <- ArkGauge(DealCycle)
            SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
            UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- ArkGauge(DealCycle)
          SCRemain <- max(0, SCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GCRemain <- max(0, GCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ACRemain <- max(0, ACRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          ENRemain <- max(0, ENRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DNRemain <- max(0, DNRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          GWRemain <- max(0, GWRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          IHRemain <- max(0, IHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UCRemain <- max(0, UCRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          VHRemain <- max(0, VHRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          EARemain <- max(0, EARemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          CTRemain <- max(0, CTRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          DORemain <- max(0, DORemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          TFRemain <- max(0, TFRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
          UIRemain <- max(0, UIRemain - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
ArkAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, InfinitySpellLv) {
  ## Abyssal Recall
  DealCycle <- RepATKCycle(DealCycle, "AbyssalRecall", 43, 1050, ATKFinal)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AbyssalRecallStart") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AbyssalRecallExplosion"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + 1050 + 210 * 42
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("AbyssalRecallExplosion"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Abyssal Recall Done")
  
  
  ## Endless Agony
  DealCycle <- RepATKCycle(DealCycle, "EndlessAgony", 15, 360, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "EndlessAgonyLast", 5, 180, ATKFinal)
  print("Endless Agony Done")
  
  
  ## Impending Death (without Magic Circuit FullDrive, Endlessly Starving Beast)
  InfSpellDeath <- ifelse(InfinitySpellLv>=25, 4, 3)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("EndlessOminousDream", "GrievousWound", "InsatiableHunger", "UnbridledChaos", "TenaciousInstinct", "CreepingTerror", 
                                  "EndlessAgony", "EndlessAgonyLast", "DeviousOminousDream"))>=1) {
      if(DealCycle$InfinitySpell[i] > 0) {
        for(j in 1:InfSpellDeath) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "ImpendingDeath"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "ImpendingDeath"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Impending Death (1/2) Done")
  
  
  ## Charge Spell, Infinity Spell, Scarlet ChargeDrive, Abyss ChargeDrive
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PlainChargeDrive") {
      if(DealCycle$InfinitySpell[i] > 0) {
        for(j in 1:5) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "PlainSpellInfinitySpell"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "PlainSpell"
      }
    } else if(DealCycle$Skills[i]=="ScarletChargeDrive") {
      if(DealCycle$InfinitySpell[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "ScarletSpellInfinitySpell"
        for(j in 1:4) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "PlainSpellInfinitySpell"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "ScarletSpell"
      }
    } else if(DealCycle$Skills[i]=="GustChargeDrive") {
      if(DealCycle$InfinitySpell[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "GustSpellInfinitySpell"
        for(j in 1:4) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "PlainSpellInfinitySpell"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "GustSpell"
      }
    } else if(DealCycle$Skills[i]=="AbyssChargeDrive1") {
      if(DealCycle$InfinitySpell[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "AbyssSpellInfinitySpell"
        for(j in 1:4) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "PlainSpellInfinitySpell"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "AbyssSpell"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle <- RepATKCycle(DealCycle, "AbyssSpell", 12, 1050, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "AbyssSpellInfinitySpell", 12, 1050, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "AbyssChargeDrive1", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ScarletChargeDrive", 2, 0, ATKFinal)
  
  t <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AbyssChargeDrive1" & t==2) {
      DealCycle$Skills[i] <- "AbyssChargeDrive2"
      t <- 1
    } else if(DealCycle$Skills[i]=="AbyssChargeDrive1" & t==1) {
      t <- 2
    }
  }
  print("Charge Spell Done")
  
  
  ## Charge Spell Amplification
  Ind <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ChargeSpellAmplification") {
      Ind <- c(Ind, i)
    }
  }
  Ind <- c(Ind, nrow(DealCycle))
  for(i in 1:(length(Ind)-1)) {
    for(j in Ind[i]:(Ind[i+1]-1)) {
      if(DealCycle$ChargeSpellAmplification[j] > 0 & nrow(subset(DealCycle[Ind[i]:j, ], DealCycle[Ind[i]:j, ]$Skills=="ScarletChargeDriveStart")) >= 1) {
        DealCycle$ScarletBuffAmplification[j] <- DealCycle$ScarletBuff[j]
      }
      if(DealCycle$ChargeSpellAmplification[j] > 0 & nrow(subset(DealCycle[Ind[i]:j, ], DealCycle[Ind[i]:j, ]$Skills=="AbyssChargeDrive1Start")) >= 1) {
        DealCycle$AbyssSpellBuffAmplification[j] <- DealCycle$AbyssBuff[j]
      }
    }
  }
  
  DealCycle <- DealCycle[DealCycle$Skills!="AbyssChargeDrive1Start", ]
  DealCycle <- DealCycle[DealCycle$Skills!="ScarletChargeDriveStart", ]
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Charge Spell Amplification Done")
  
  
  ## Blissful Restraint
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BlissfulRestraint") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BlissfulRestraintContinuousATK"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BlissfulRestraintLastATK"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + 10780
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("BlissfulRestraintLastATK"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "BlissfulRestraintContinuousATK", 20, 1940, ATKFinal)
  print("Blissful Restraint Done")
  
  
  ## Endlessly Starving Beast
  Ind <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="EndlesslyStarvingBeast") {
      Ind <- c(Ind, i)
    }
  }
  for(i in 1:length(Ind)) {
    Time <- 9600
    RealTime <- 0
    k <- Ind[i] + 1
    Dummy <- 0
    while(Time > 0) {
      if(sum(DealCycle$Skills[k]==c("ImpendingDeath", "AbyssSpell", "AbyssSpellInfinitySpell", "BlissfulRestraintContinuousATK", "BlissfulRestraintLastATK", 
                                    "EndlessAgony", "AbyssalRecall"))>=1) {
        Time <- Time - 180
      } else if(sum(DealCycle$Skills[k]==c("AbyssalRecallExplosion"))>=1) {
        Time <- Time - 180 * 6
      } else if(sum(DealCycle$Skills[k]==c("EndlessNightmare", "EndlessOminousDream", "GrievousWound", "UnstoppableImpulse", "TenaciousInstinct", "InsatiableHunger", 
                                           "CreepingTerror", "AbyssChargeDrive1", "UnbridledChaos", "DeviousNightmare", "DeviousOminousDream"))>=1) {
        Time <- Time - 600
      }
      if(Time > 0) {
        Time <- Time - (DealCycle$Time[k] - DealCycle$Time[k-1])
        if(Time <= 0) {
          Dummy <- 1
        }
      }
      RealTime <- RealTime + (DealCycle$Time[k] - DealCycle$Time[k-1])
      k <- k + 1
    }
    DealCycle <- rbind(DealCycle, DealCycle[Ind[i], ])
    DealCycle$Skills[Ind[i]] <- "EndlesslyStarvingBeastUse"
    DealCycle$Skills[nrow(DealCycle)] <- "EndlesslyStarvingBeastDummy"
    DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + ifelse(Dummy==0, RealTime, RealTime + Time)
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  Times <- c(1740, 1740 + 1200, seq(1740 + 1200 + 30, 1740 + 1200 + 30*18, 30))
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="EndlesslyStarvingBeastDummy") {
      for(j in 1:length(Times)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "EndlesslyStarvingBeast"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + Times[j]
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("EndlesslyStarvingBeast"))>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Endlessly Starving Beast Done")
  
  
  ## Magic Circuit FullDrive
  DealCycle <- MCFCycle(DealCycle, c("PlainChargeDrive", "ScarletChargeDrive", "GustChargeDrive", "AbyssChargeDrive1", "AbyssSpell", "AbyssSpellInfinitySpell", 
                                     "EndlessNightmare", "EndlessOminousDream", "GrievousWound", "InsatiableHunger", "UnbridledChaos", "UnstoppableImpulse", "TenaciousInstinct", 
                                     "CreepingTerror", "BlissfulRestraint", "BlissfulRestraintContinuousATK", "BlissfulRestraintLastATK", "EndlessAgony", "EndlessAgonyLast", 
                                     "AbyssalRecall", "AbyssalRecallExplosion", "EndlesslyStarvingBeast", "SpiderInMirror"))
  print("Magic Circuit FullDrive Done")
  
  
  ## Impending Death (Magic Circuit FullDrive, Endlessly Starving Beast)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MagicCircuitFullDrive", "EndlesslyStarvingBeast"))>=1) {
      if(DealCycle$InfinitySpell[i] > 0) {
        for(j in 1:InfSpellDeath) {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
          DealCycle$Skills[nrow(DealCycle)] <- "ImpendingDeath"
        }
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "ImpendingDeath"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Impending Death (2/2) Done")
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  print("Spider In Mirror Done")
  
  
  ## Vengeful Hate
  Stacks <- c()
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ImpendingDeath") {
      DealCycle$VengefulHateStack[i] <- min(12, DealCycle$VengefulHateStack[i-1] + 0.2)
    } else if(DealCycle$Skills[i]=="VengefulHate") {
      if(floor(DealCycle$VengefulHateStack[i-1] == 0)) {
        Stacks <- c(Stacks, 0)
        DealCycle$VengefulHateStack[i] <- min(12, DealCycle$VengefulHateStack[i-1] + 0.2)
      } else {
        Stacks <- c(Stacks, floor(DealCycle$VengefulHateStack[i-1]))
        DealCycle$VengefulHateStack[i] <- DealCycle$VengefulHateStack[i-1] - floor(DealCycle$VengefulHateStack[i-1])
      }
    } else {
      DealCycle$VengefulHateStack[i] <- DealCycle$VengefulHateStack[i-1]
    }
  }
  
  DC1 <- subset(DealCycle, DealCycle$Skills!="VengefulHate")
  DC2 <- subset(DealCycle, DealCycle$Skills=="VengefulHate")
  DC3 <- DC1[1, ]
  for(i in 1:nrow(DC2)) {
    if(Stacks[i] > 0) {
      for(j in 1:Stacks[i]) {
        DC3 <- rbind(DC3, DC2[i, ])
      }
    }
  }
  DC3 <- DC3[-1, ]
  DealCycle <- rbind(DC1, DC3)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Vengeful Hate Done")
  
  ## Dummy Reduction
  DealCycle$SpecterGauge <- 0
  DealCycle$SpecterGaugeDummy <- 0
  DealCycle$VengefulHateStack <- 0
  
  return(DealCycle)
}
      
ArkDealCycle <- ArkCycle(ArkDealCycle, 
                         ATKFinal, 
                         BuffFinal, 
                         SummonedFinal, 
                         Spec=ArkSpec, 
                         SkipStructure=ArkSkipATK, 
                         Period=182.4, 
                         CycleTime=729.6, 
                         CancelDelay=30)
ArkDealCycle <- ArkAddATK(ArkDealCycle, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal, 
                              ArkSpec,
                              30)
ArkDealCycle <- OverDriveExhaustBuff(ArkDealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
ArkDealCycleReduction <- DealCycleReduction(ArkDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Ark") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  ArkSpecOpt1 <- Optimization1(ArkDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArkSpec, ArkUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- ArkSpecOpt1[1, 1:3]
} else {
  ArkSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ArkSpecOpt <- OptDataAdd(ArkSpec, ArkSpecOpt1, "Potential", ArkBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ArkSpecOpt2 <- Optimization2(ArkDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt, ArkHyperStatBase, ArkBase$ChrLv, ArkBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ArkSpecOpt2[1, ]
} else {
  ArkSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ArkSpecOpt <- OptDataAdd(ArkSpecOpt, ArkSpecOpt2, "HyperStat", ArkBase$CRROver, DemonAvenger=F)

ArkFinalDPM <- DealCalc(ArkDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt, Collapse=F)
ArkFinalDPMwithMax <- DealCalcWithMaxDMR(ArkDealCycle, ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Ark", sum(na.omit(ArkFinalDPMwithMax)) / (max(ArkDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Ark", sum(na.omit(ArkFinalDPM)) / (max(ArkDealCycle$Time) / 60000) - sum(na.omit(ArkFinalDPMwithMax)) / (max(ArkDealCycle$Time) / 60000))

ArkDealRatio <- DealRatio(ArkDealCycle, ArkFinalDPMwithMax)

ArkDealData <- data.frame(ArkDealCycle$Skills, ArkDealCycle$Time, ArkDealCycle$Restraint4, ArkFinalDPMwithMax)
colnames(ArkDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Ark", Deal_RR(ArkDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Ark", Deal_40s(ArkDealData))

ArkSpecMean <- SpecMean("Ark", ArkDealCycleReduction, 
                        DealCalcWithMaxDMR(ArkDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt), 
                        ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt)

# chaos : 50, hunger : 71, wound : 77, terror : 12, deviousominousdream : 53, restraint : 3, agony : 9, beast : 6, recall : 3, hate : 44
# abyss : 57, gust : 86, scarlet : 101, nightmare : 97, deviousnightmare : 54


## Ark - Cancel Delay 60ms
DealCycle <- c("Skills", "Time", rownames(ArkBuff))
ArkDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(ArkDealCycle2) <- DealCycle
ArkDealCycle2 <- data.frame(ArkDealCycle2)

ArkDealCycle2 <- ArkCycle(ArkDealCycle2, 
                          ATKFinal, 
                          BuffFinal, 
                          SummonedFinal, 
                          Spec=ArkSpec, 
                          SkipStructure=ArkSkipATK, 
                          Period=182.4, 
                          CycleTime=729.6, 
                          CancelDelay=60)
ArkDealCycle2 <- ArkAddATK(ArkDealCycle2, 
                           ATKFinal, 
                           BuffFinal, 
                           SummonedFinal, 
                           ArkSpec,
                           30)
ArkDealCycle2 <- OverDriveExhaustBuff(ArkDealCycle2, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)

Ark60ms <- DealCalcWithMaxDMR(ArkDealCycle2, ATKFinal, BuffFinal, SummonedFinal, ArkSpecOpt)
Ark60msDPM <- sum(na.omit(Ark60ms)) / (max(ArkDealCycle2$Time)/ 60000)

ArkDealData2 <- data.frame(ArkDealCycle2$Skills, ArkDealCycle2$Time, ArkDealCycle2$Restraint4, Ark60ms)
colnames(ArkDealData2) <- c("Skills", "Time", "R4", "Deal")

Ark60msRR <- Deal_RR(ArkDealData2)
Ark60ms40s <- Deal_40s(ArkDealData2)

print(data.frame(Ark60msDPM=Ark60msDPM, Ark60msRR=Ark60msRR, Ark60ms40s=Ark60ms40s))