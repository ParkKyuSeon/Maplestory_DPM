## ArchmageFP - Data
## ArchmageFP - VMatrix
ArchMageFPCoreBase <- CoreBuilder(ActSkills=c("DotPunisher", "PoisonNova", "FuryofIfrit", "PoisonChain",
                                              CommonV("Wizard", "Adventure")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                  UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=ArchMageFPVPassive, 
                                  VPassivePrior=ArchMageFPVPrior, 
                                  SelfBind=F)

ArchMageFPCore <- MatrixSet(PasSkills=ArchMageFPCoreBase$PasSkills$Skills, 
                            PasLvs=ArchMageFPCoreBase$PasSkills$Lv, 
                            PasMP=ArchMageFPCoreBase$PasSkills$MP, 
                            ActSkills=ArchMageFPCoreBase$ActSkills$Skills, 
                            ActLvs=ArchMageFPCoreBase$ActSkills$Lv, 
                            ActMP=ArchMageFPCoreBase$ActSkills$MP, 
                            UsefulSkills=ArchMageFPCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=ArchMageFPCoreBase$SpecialCoreUse)


## ArchmageFP - Basic Info
## Link Check Needed
ArchMageFPBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="ArchMageFP",
                          CoreData=ArchMageFPCore, 
                          BuffDurationNeeded=310, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "ArchMageFP"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "ArchMageFP"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "ArchMageFP")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="FPGrimoire", ], 
                          Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "ArchMageFP")))


## ArchMageFP - Passive
{option <- factor(c("CRR", "ATKSpeed"), levels=PSkill)
value <- c(5, 1)
MPIncrease <- data.frame(option, value) ## Wand

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
MagicAcceleration <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("FDR", "ImmuneIgnore"), levels=PSkill)
value <- c(50, 10)
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
value <- c(30 + 3 * ArchMageFPBase$SkillLv, 50 + 5 * ArchMageFPBase$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(ArchMageFPBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70 + ceiling(ArchMageFPBase$SkillLv/2))
IfritPassive <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(ArchMageFPCore, "UnstableMemorize"))
UnstableMemorize <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ArchMageFPCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(ArchMageFPCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

ArchMageFPPassive <- Passive(list(MPIncrease=MPIncrease, MagicAcceleration=MagicAcceleration, HighWisdom=HighWisdom, SpellMastery=SpellMastery, ElementalReset=ElementalReset, ElementAmplification=ElementAmplification, 
                                  MagicCritical=MagicCritical, ExtremeMagic=ExtremeMagic, FerventDrain=FerventDrain, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, 
                                  IfritPassive=IfritPassive, UnstableMemorize=UnstableMemorize, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## ArchMageFP - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(60 * ((100 + ArchMageFPBase$MonsterLife$SummonedDuration + ArchMageFPBase$UnionChrs$SummonedDuration) / 100), 30, 990, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoisonRegionBuff <- rbind(data.frame(option, value), info)  

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoisonRegion1 <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoisonRegion2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PoisonRegion3 <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Meditation <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + ArchMageFPBase$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ArchMageFPBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ArchMageFPBase$SkillLv/2))))
info <- c(900 + 30 * ArchMageFPBase$SkillLv, NA, 0, T, NA, NA, T)
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

Useful <- UsefulSkills(ArchMageFPCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(ArchMageFPCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * ArchMageFPBase$MainStatP), 5 + floor(GetCoreLv(ArchMageFPCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ArchMageFPBuff <- list(PoisonRegionBuff=PoisonRegionBuff, PoisonRegion1=PoisonRegion1, PoisonRegion2=PoisonRegion2, PoisonRegion3=PoisonRegion3,
                       Meditation=Meditation, Infinity=Infinity, 
                       MapleSoldier=MapleSoldier, EpicAdventure=EpicAdventure, FireAura=FireAura, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                       MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, Meditation(600ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  ArchMageFPBuff[[length(ArchMageFPBuff)+1]] <- UsefulAdvancedBless
  names(ArchMageFPBuff)[[length(ArchMageFPBuff)]] <- "UsefulAdvancedBless"
}
ArchMageFPBuff <- Buff(ArchMageFPBuff)
ArchMageFPAllTimeBuff <- AllTimeBuff(ArchMageFPBuff)


## ArchmageFP - Union & HyperStat & SoulWeapon
ArchMageFPSpec <- JobSpec(JobBase=ArchMageFPBase, 
                          Passive=ArchMageFPPassive, 
                          AllTimeBuff=ArchMageFPAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="Wand", 
                          UnionStance=0, 
                          JobConstant=1.2)

ArchMageFPUnionRemained <- ArchMageFPSpec$UnionRemained
ArchMageFPHyperStatBase <- ArchMageFPSpec$HyperStatBase
ArchMageFPCoolReduceType <- ArchMageFPSpec$CoolReduceType
ArchMageFPSpec <- ArchMageFPSpec$Spec


## ArchMageFP - Spider In Mirror
SIM <- SIMData(GetCoreLv(ArchMageFPCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## ArchMageFP - Attacks
{option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion"), ifelse(GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion")>=40, 20, 0))
info <- c(272, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TeleportMastery <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(3 * GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion")>=40, 20, 0))
info <- c(192, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonRegion <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(3 * GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "TeleportMastery_PoisonRegion")>=40, 20, 0))
info <- c(192 * 0.5, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonRegionAdd <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "FlameSweep"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), 10, ifelse(GetCoreLv(ArchMageFPCore, "FlameSweep")>=40, 20, 0))
info <- c(220 + 3 * ArchMageFPSpec$SkillLv, 8, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameSweep <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "MistEruption"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), 10, 
           IGRCalc(c(ifelse(GetCoreLv(ArchMageFPCore, "MistEruption")>=40, 20, 0), 20, 40 + ArchMageFPSpec$SkillLv)))
info <- c((125 + ArchMageFPSpec$SkillLv) * 2.25, 10 * 2, 930, NA, 8 * (1 - 0.5 - ArchMageFPSpec$CoolReduceP/100), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MistEruption <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "Meteor"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "Meteor")>=40, 20, 0))
info <- c(315 + 3 * ArchMageFPSpec$SkillLv, 12, 900, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Meteor <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(ArchMageFPCore, "Meteor"), ArchMageFPBase$MonsterLife$FinalATKDMR,  ifelse(GetCoreLv(ArchMageFPCore, "Meteor")>=40, 20, 0))
info <- c(220 + 4 * ArchMageFPSpec$SkillLv, 0.6 + 0.02 * ArchMageFPSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "FlameHaze"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "FlameHaze")>=40, 20, 0))
info <- c(202 + 3 * ArchMageFPSpec$SkillLv, 15, 1170, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameHaze <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "MegiddoFlame"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "MegiddoFlame")>=40, 20, 0))
info <- c(380, 4, 900, NA, 50, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlame <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(ArchMageFPCore, "MegiddoFlame"), floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(ArchMageFPCore, "MegiddoFlame")>=40, 20, 0))
info <- c(380 * 0.45, 4 * 10, 0, NA, 50, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegiddoFlameAdd <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * GetCoreLv(ArchMageFPCore, "Ignite"), ifelse(GetCoreLv(ArchMageFPCore, "Ignite")>=40, 20, 0))
info <- c(40, 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ignite <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(4 * GetCoreLv(ArchMageFPCore, "Ignite"), ifelse(GetCoreLv(ArchMageFPCore, "Ignite")>=40, 20, 0))
info <- c(40, (ArchMageFPSpec$SkillLv * 0.02 + 0.6) * 3 * 0.5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
IgniteMeteorFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR", "IGR"), levels=ASkill)
value <- c(-50, 2 * GetCoreLv(ArchMageFPCore, "FireAura"), ifelse(GetCoreLv(ArchMageFPCore, "FireAura")>=40, 20, 0))
info <- c(400, 2, 0, 3000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FireAura <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(400 + 15 * GetCoreLv(ArchMageFPCore, "DotPunisher"), 5, 900, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisher1st <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c((400 + 15 * GetCoreLv(ArchMageFPCore, "DotPunisher")) * 0.65, 5 * 23, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DotPunisherRemain <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(250 + 10 * GetCoreLv(ArchMageFPCore, "PoisonNova"), 12, 750, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaStart <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(ArchMageFPCore, "PoisonNova"), 36, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNova123 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c((225 + 9 * GetCoreLv(ArchMageFPCore, "PoisonNova")) * 0.5, ifelse(get(DPMCalcOption$MobSet)$Basic$Size==1, 12, 108), 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonNovaRemain <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(200 + 8 * GetCoreLv(ArchMageFPCore, "FuryofIfrit"), 6, 480, 180, 75, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuryofIfrit <- rbind(data.frame(option, value), info) # FuryofIfrit StartDelay : 1560ms

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(250 + 10 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 4, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 780, 1800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain1 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 1 * (30 + GetCoreLv(ArchMageFPCore, "PoisonChain")) + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 2 * (30 + GetCoreLv(ArchMageFPCore, "PoisonChain")) + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain3 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 3 * (30 + GetCoreLv(ArchMageFPCore, "PoisonChain")) + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain4 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 4 * (30 + GetCoreLv(ArchMageFPCore, "PoisonChain")) + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChain5 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(ArchMageFPCore, "OverloadMana") / 10) + 8)
info <- c(150 + 5 * (30 + GetCoreLv(ArchMageFPCore, "PoisonChain")) + 6 * GetCoreLv(ArchMageFPCore, "PoisonChain"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PoisonChainMax <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 430 - 3 * GetCoreLv(ArchMageFPCore, "UnstableMemorize"), F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorize <- rbind(data.frame(option, value), info)}

ArchMageFPATK <- Attack(list(TeleportMastery=TeleportMastery, PoisonRegion=PoisonRegion, PoisonRegionAdd=PoisonRegionAdd, 
                             FlameSweep=FlameSweep, MistEruption=MistEruption, Meteor=Meteor, MeteorFinalAttack=MeteorFinalAttack, 
                             FlameHaze=FlameHaze, MegiddoFlame=MegiddoFlame, MegiddoFlameAdd=MegiddoFlameAdd, Ignite=Ignite, IgniteMeteorFinalAttack=IgniteMeteorFinalAttack, FireAura=FireAura, 
                             DotPunisher1st=DotPunisher1st, DotPunisherRemain=DotPunisherRemain, 
                             PoisonNovaStart=PoisonNovaStart, PoisonNova123=PoisonNova123, PoisonNovaRemain=PoisonNovaRemain, FuryofIfrit=FuryofIfrit,
                             PoisonChainPre=PoisonChainPre, PoisonChain1=PoisonChain1, PoisonChain2=PoisonChain2, PoisonChain3=PoisonChain3, PoisonChain4=PoisonChain4, 
                             PoisonChain5=PoisonChain5, PoisonChainMax=PoisonChainMax, UnstableMemorize=UnstableMemorize,
                             SpiderInMirror=SpiderInMirror))


## ArchMageFP - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * GetCoreLv(ArchMageFPCore, "Ifrit"), ifelse(GetCoreLv(ArchMageFPCore, "Ifrit")>=40, 20, 0))
info <- c(150 + 2 * ArchMageFPSpec$SkillLv, 3, 600, 3030, 260 + 5 * ArchMageFPSpec$SkillLv, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Ifrit <- rbind(data.frame(option, value), info)}

ArchMageFPSummoned <- Summoned(list(Ifrit=Ifrit, SpiderInMirrorStart=SpiderInMirrorStart,
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## ArchMageFP - DealCycle and Deal Calculation
ATKFinal <- data.frame(ArchMageFPATK)
ATKFinal$Delay[c(-27)] <- Delay(ATKFinal$Delay, ArchMageFPSpec$ATKSpeed)[c(-27)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)

BuffFinal <- data.frame(ArchMageFPBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ArchMageFPSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ArchMageFPSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ArchMageFPSpec$CoolReduceP, ArchMageFPSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ArchMageFPSpec$SummonedDuration / 100, 0)


## Unstable Memorize Data
UnstableCoolReduceProb <- c(1, 6, 6, 6, 10, 11, 12, 12, 12, 8, 6, 5, 2, 2, 1)
UnstableCoolReduceP <- c(20, 23, 24, 25, 27, 30, 33, 35, 38, 40, 45, 50, 55, 60, 65)

UnstableCool <- c()
for(i in 1:length(UnstableCoolReduceP)) {
  UnstableCool <- c(UnstableCool, ATKFinal[rownames(ATKFinal)=="UnstableMemorize", ]$CoolTime * ((100 - UnstableCoolReduceP[i]) / 100) * ((100 - ArchMageFPSpec$CoolReduceP) / 100) - ArchMageFPSpec$CoolReduce)
}
UnstableCool <- UnstableCool[UnstableCool > BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2]
UnstableCool <- c(UnstableCool, BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2)
UnstableProb <- UnstableCoolReduceProb[1:(length(UnstableCool)-1)] / 100
UnstableProb <- c(UnstableProb, 1 - sum(UnstableProb))
UnstableCycleNames <- c()
UnstableDealDataNames <- c()
for(i in 1:length(UnstableCool)) {
  UnstableCycleNames <- c(UnstableCycleNames, paste("ArchMageFPDealCycle", i, sep=""))
  UnstableDealDataNames <- c(UnstableDealDataNames, paste("ArchMageFPDealData", i, sep=""))
}
UnstableCyclesFP <- data.frame(Cool = UnstableCool, 
                             Prob = UnstableProb, 
                             CycleNames = UnstableCycleNames, 
                             DealDatas = UnstableDealDataNames, 
                             CycleTimes = rep(0, length(UnstableCool)), 
                             stringsAsFactors = F)


ArchMageFPCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, UnstableCool) {
  DealCycle <- DCBuff(DealCycle, c("FireAura", "Meditation", "MapleSoldier", "EpicAdventure",
                                   "UsefulSharpEyes", "UsefulCombatOrders", "PoisonRegionBuff"), BuffFinal)
  BuffList <- c("Meditation", "MapleSoldier", "EpicAdventure", "UsefulSharpEyes", "UsefulCombatOrders", "PoisonRegionBuff")
  DealCycle$PoisonRegion1[nrow(DealCycle)] <- 2400
  DealCycle$PoisonRegion2[nrow(DealCycle)] <- 2400
  DealCycle$PoisonRegion3[nrow(DealCycle)] <- 3300
  
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCSummoned(DealCycle, "Ifrit", SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  
  ## 1st Infinity
  Restraint4 <- c(15)
  FuryofIfrit <- c(10, 100)
  MapleWarriors2 <- c(60)
  SoulContractLink <- c(120, 30)
  SpiderInMirror <- c(50)
  MegiddoFlame <- c(5, 65)
  skills1 <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror, MegiddoFlame=MegiddoFlame)
  
  ## 2nd Infinity
  FuryofIfrit <- c(40)
  SoulContractLink <- c(60)
  MegiddoFlame <- c(5, 65)
  skills2 <- list(FuryofIfrit=FuryofIfrit, SoulContractLink=SoulContractLink, MegiddoFlame=MegiddoFlame)
  
  ## 3rd Infinity
  Restraint4 <- c(80)
  FuryofIfrit <- c(75)
  MapleWarriors2 <- c(120)
  SoulContractLink <- c(90)
  SpiderInMirror <- c(50)
  MegiddoFlame <- c(5, 65)
  skills3 <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror, MegiddoFlame=MegiddoFlame)
  
  ## 4th Infinity
  Restraint4 <- c(15)
  FuryofIfrit <- c(10, 100)
  MapleWarriors2 <- c(60)
  SoulContractLink <- c(120, 30)
  MegiddoFlame <- c(5, 65)
  skills4 <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, MegiddoFlame=MegiddoFlame)
  
  ## 5th Infinity
  FuryofIfrit <- c(40)
  SoulContractLink <- c(60)
  SpiderInMirror <- c(50)
  MegiddoFlame <- c(5, 65)
  skills5 <- list(FuryofIfrit=FuryofIfrit, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror, MegiddoFlame=MegiddoFlame)
  
  ## 6th Infinity
  Restraint4 <- c(80)
  FuryofIfrit <- c(75)
  MapleWarriors2 <- c(120)
  SoulContractLink <- c(90)
  MegiddoFlame <- c(5, 65)
  skills6 <- list(Restraint4=Restraint4, FuryofIfrit=FuryofIfrit, MapleWarriors2=MapleWarriors2, SoulContractLink=SoulContractLink, MegiddoFlame=MegiddoFlame)
  
  PoisonRegionCycle <- function(DealCycle) {
    if(DealCycle$Skills[nrow(DealCycle)] == "PoisonRegionBuff") {
      PRDummy <- 0
      if(DealCycle$PoisonRegion1[nrow(DealCycle)] == 0) {
        DealCycle$PoisonRegion1[nrow(DealCycle)] <- 2400
        PRDummy <- PRDummy + 1
      } 
      if(DealCycle$PoisonRegion2[nrow(DealCycle)] == 0) {
        DealCycle$PoisonRegion2[nrow(DealCycle)] <- 2400
        PRDummy <- PRDummy + 1
      } 
      if(DealCycle$PoisonRegion3[nrow(DealCycle)] == 0 & PRDummy < 2) {
        DealCycle$PoisonRegion3[nrow(DealCycle)] <- 2400
      }
    } else if(sum(DealCycle$Skills[nrow(DealCycle)] == c("Meteor", "FlameHaze", "FlameSweep", "MegiddoFlame", "DotPunisher1st", "FuryofIfrit")) >= 1) {
      PRDummy <- 0
      if(DealCycle$PoisonRegion1[nrow(DealCycle)] == 0) {
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- "PoisonRegion"
        DealCycle$PoisonRegion1[nrow(DealCycle)] <- 900 - ((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) - 
                                                             floor((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) / 900) * 900) + 1500
        PRDummy <- PRDummy + 1
      }
      if(DealCycle$PoisonRegion2[nrow(DealCycle)] == 0) {
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- "PoisonRegion"
        DealCycle$PoisonRegion2[nrow(DealCycle)] <- 900 - ((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) - 
                                                             floor((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) / 900) * 900) + 1500
        PRDummy <- PRDummy + 1
      } 
      if(DealCycle$PoisonRegion3[nrow(DealCycle)] == 0) {
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- "PoisonRegion"
        if(PRDummy == 2) {
          DealCycle$PoisonRegion3[nrow(DealCycle)] <- 900 - ((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) - 
                                                               floor((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) / 900) * 900) + 2400
        } else {
          DealCycle$PoisonRegion3[nrow(DealCycle)] <- 900 - ((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) - 
                                                               floor((DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="PoisonRegionBuff")$Time)) / 900) * 900) + 1500
        }
      }
    }
    return(DealCycle)
  }
  
  for(k in 1:6) {
    if(sum(k==c(1)) >= 1) {
      skills <- skills1
    } else if(sum(k==c(2)) >= 1) {
      skills <- skills2
    } else if(sum(k==c(3)) >= 1) {
      skills <- skills3
    } else if(sum(k==c(4)) >= 1) {
      skills <- skills4
    } else if(sum(k==c(5)) >= 1) {
      skills <- skills5
    } else if(sum(k==c(6)) >= 1) {
      skills <- skills6
    }
    
    times <- c()
    for(i in 1:length(skills)) {
      times <- c(times, skills[[i]])
    }
    times <- unique(times)
    times <- times[order(times, decreasing=T)]
    
    skilllist <- list()
    for(i in 1:length(times)) {
      skilllist[[i]] <- 1
      for(j in 1:length(skills)) {
        if(sum(skills[[j]]==times[[i]])==1) {
          skilllist[[i]] <- c(skilllist[[i]], names(skills)[[j]])
        }
      }
      skilllist[[i]] <- skilllist[[i]][-1]
    }
    names(skilllist) <- times
    times <- times * 1000
    HazeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameHaze")$CoolTime * 1000
    MTCool <- subset(ATKFinal, rownames(ATKFinal)=="Meteor")$CoolTime * 1000
    ErupCool <- subset(ATKFinal, rownames(ATKFinal)=="MistEruption")$CoolTime * 1000
    PNCool <- subset(ATKFinal, rownames(ATKFinal)=="PoisonNovaStart")$CoolTime * 1000
    if(k==1) {
      ErupRemain <- 0 ; HazeRemain <- 0 ; MTRemain <- 0 ; PNRemain <- 0
    } else if(sum(k==c(3, 6)) >= 1) {
      PNRemain <- max(2000, PNCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(DealCycle[DealCycle$Skills=="PoisonNovaStart", ]$Time)))
    }
    
    p <- 1
    while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
      if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
        for(j in 1:length(skilllist[[p]])) {
          if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
            DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
            DealCycle <- PoisonRegionCycle(DealCycle)
            PNRemain <- max(0, PNRemain - DealCycle$Time[1])
            MTRemain <- max(0, MTRemain - DealCycle$Time[1])
            HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
            ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
          } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
            DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
            DealCycle <- PoisonRegionCycle(DealCycle)
            PNRemain <- max(0, PNRemain - DealCycle$Time[1])
            MTRemain <- max(0, MTRemain - DealCycle$Time[1])
            HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
            ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
          }
        }
        p <- p + 1
      }
      if(MTRemain == 0) {
        DealCycle <- DCATK(DealCycle, "Meteor", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- MTCool - DealCycle$Time[1]
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      } else if(DealCycle$PoisonRegionBuff[nrow(DealCycle)] - DealCycle$Time[1] < 2000) {
        DealCycle <- DCBuff(DealCycle, "PoisonRegionBuff", BuffFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      } else if(PNRemain==0 & nrow(DealCycle[DealCycle$Skills=="TeleportMastery", ]) < nrow(DealCycle[DealCycle$Skills=="Infinity", ]) * 5 + ceiling(nrow(DealCycle[DealCycle$Skills=="Infinity", ]) / 3)) {
        DealCycle <- DCATK(DealCycle, "TeleportMastery", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "PoisonNovaStart", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- PNCool - DealCycle$Time[1]
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "DotPunisher1st", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "PoisonChainPre", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "PoisonChain1", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      } else if(ErupRemain==0) {
        DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- 0
        ErupRemain <- ErupCool - DealCycle$Time[1]
      } else if(HazeRemain==0) {
        DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- HazeCool - DealCycle$Time[1]
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      } else {
        DealCycle <- DCATK(DealCycle, "FlameSweep", ATKFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      }
    }
    
    if(sum(k==c(1, 3, 5)) >= 1) {
      DealCycle <- DCBuff(DealCycle, c("EpicAdventure"), BuffFinal)
      DealCycle <- PoisonRegionCycle(DealCycle)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      MTRemain <- max(0, MTRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      
      DealCycle <- DCATK(DealCycle, c("UnstableMemorize"), ATKFinal)
      DealCycle <- PoisonRegionCycle(DealCycle)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      MTRemain <- max(0, MTRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      
      DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
      DealCycle <- PoisonRegionCycle(DealCycle)
      PNRemain <- max(0, PNRemain - DealCycle$Time[1])
      MTRemain <- max(0, MTRemain - DealCycle$Time[1])
      HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
      ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
    } else if(sum(k==c(2, 4, 6)) >= 1) {
      while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - 
            (UnstableCool * 1000 - BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 1000 + max(DealCycle[DealCycle$Skills=="UnstableMemorize", ]$Time) - min(DealCycle[DealCycle$Skills=="Infinity", ]$Time)) < 0) {
        if(ErupRemain==0) {
          DealCycle <- DCATK(DealCycle, "MistEruption", ATKFinal)
          DealCycle <- PoisonRegionCycle(DealCycle)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          MTRemain <- max(0, MTRemain - DealCycle$Time[1])
          HazeRemain <- 0
          ErupRemain <- ErupCool - DealCycle$Time[1]
        } else if(HazeRemain==0) {
          DealCycle <- DCATK(DealCycle, "FlameHaze", ATKFinal)
          DealCycle <- PoisonRegionCycle(DealCycle)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          MTRemain <- max(0, MTRemain - DealCycle$Time[1])
          HazeRemain <- HazeCool - DealCycle$Time[1]
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "FlameSweep", ATKFinal)
          DealCycle <- PoisonRegionCycle(DealCycle)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          MTRemain <- max(0, MTRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
      }
      
      if(k != 6) {
        for(i in 1:length(BuffList)) {
          DealCycle <- DCBuff(DealCycle, BuffList[i], BuffFinal)
          DealCycle <- PoisonRegionCycle(DealCycle)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          MTRemain <- max(0, MTRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
        
        if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
          DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
          DealCycle <- PoisonRegionCycle(DealCycle)
          PNRemain <- max(0, PNRemain - DealCycle$Time[1])
          MTRemain <- max(0, MTRemain - DealCycle$Time[1])
          HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
          ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        }
        DealCycle <- DCSummoned(DealCycle, "Ifrit", SummonedFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
        DealCycle <- PoisonRegionCycle(DealCycle)
        PNRemain <- max(0, PNRemain - DealCycle$Time[1])
        MTRemain <- max(0, MTRemain - DealCycle$Time[1])
        HazeRemain <- max(0, HazeRemain - DealCycle$Time[1])
        ErupRemain <- max(0, ErupRemain - DealCycle$Time[1])
      }
    }
  }
  return(DealCycle)
}

for(i in 1:nrow(UnstableCyclesFP)) {
  DealCycle <- c("Skills", "Time", rownames(ArchMageFPBuff))
  ArchMageFPDealCycleDummy <- t(rep(0, length(DealCycle)))
  colnames(ArchMageFPDealCycleDummy) <- DealCycle
  
  ArchMageFPDealCycleDummy <- ArchMageFPCycle(ArchMageFPDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, UnstableCool = UnstableCool[i])
  ArchMageFPDealCycleDummy <- DealCycleFinal(ArchMageFPDealCycleDummy)
  
  ArchMageFPDealCycleDummy <- DCSummonedATKs(ArchMageFPDealCycleDummy, "Ifrit", SummonedFinal)
  ArchMageFPDealCycleDummy <- FuryofIfritCycle(ArchMageFPDealCycleDummy, ATKFinal)
  ArchMageFPDealCycleDummy <- PoisonChainCycle(ArchMageFPDealCycleDummy, ATKFinal)
  ArchMageFPDealCycleDummy <- FPAddATKCycle(ArchMageFPDealCycleDummy, ATKFinal)
  ArchMageFPDealCycleDummy <- DCSpiderInMirror(ArchMageFPDealCycleDummy, SummonedFinal)
  ArchMageFPDealCycleDummy <- RepATKCycle(ArchMageFPDealCycleDummy, "FireAura", 300, 0, ATKFinal)
  ArchMageFPDealCycleDummy <- BishopInfinity(ArchMageFPDealCycleDummy, 6000, 70 + ArchMageFPSpec$SkillLv, General$General$Serverlag)
  ArchMageFPDealCycleDummy <- FPDealCycleReduction(ArchMageFPDealCycleDummy, c("Ignite", "IgniteMeteorFinalAttack"))
  UnstableCyclesFP$CycleTimes[i] <- max(ArchMageFPDealCycleDummy$Time)
  assign(paste("ArchMageFPDealCycle", i, sep=""), ArchMageFPDealCycleDummy)
  rm(ArchMageFPDealCycleDummy)
}

ArchMageFPDealCycleReduction <- DealCycleReduction(get(UnstableCyclesFP$CycleNames[nrow(UnstableCyclesFP)]), NotBuffColNames=c("InfinityFDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="ArchMageFP") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  ArchMageFPSpecOpt1 <- Optimization1(ArchMageFPDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpec, ArchMageFPUnionRemained, 
                                      NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- ArchMageFPSpecOpt1[1, 1:3]
} else {
  ArchMageFPSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ArchMageFPSpecOpt <- OptDataAdd(ArchMageFPSpec, ArchMageFPSpecOpt1, "Potential", ArchMageFPBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ArchMageFPSpecOpt2 <- Optimization2(ArchMageFPDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, ArchMageFPHyperStatBase, ArchMageFPBase$ChrLv, ArchMageFPBase$CRROver, 
                                      NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ArchMageFPSpecOpt2[1, ]
} else {
  ArchMageFPSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ArchMageFPSpecOpt <- OptDataAdd(ArchMageFPSpecOpt, ArchMageFPSpecOpt2, "HyperStat", ArchMageFPBase$CRROver, DemonAvenger=F)

ArchMageFPFinalDPM <- ResetDealCalc(DealCycles=GetList(UnstableCyclesFP$CycleNames), 
                                    ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, UnstableCyclesFP$CycleTimes, UnstableCyclesFP$Prob, 
                                    NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
ArchMageFPFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=GetList(UnstableCyclesFP$CycleNames), 
                                                     ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, UnstableCyclesFP$CycleTimes, UnstableCyclesFP$Prob, 
                                                     NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "ArchMageFP", sum(na.omit(ArchMageFPFinalDPMwithMax)) / (sum(UnstableCyclesFP$Prob * UnstableCyclesFP$CycleTimes) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "ArchMageFP", sum(na.omit(ArchMageFPFinalDPM)) / (sum(UnstableCyclesFP$Prob * UnstableCyclesFP$CycleTimes) / 60000) - 
      sum(na.omit(ArchMageFPFinalDPMwithMax)) / (sum(UnstableCyclesFP$Prob * UnstableCyclesFP$CycleTimes) / 60000))

ArchMageFPDealData <- data.frame(ArchMageFPDealCycle1$Skills, ArchMageFPDealCycle1$Time, ArchMageFPDealCycle1$Restraint4, 
                                 DealCalcWithMaxDMR(ArchMageFPDealCycle1, ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, 
                                                    NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR")))
colnames(ArchMageFPDealData) <- c("Skills", "Time", "R4", "Deal")

for(i in 1:nrow(UnstableCyclesFP)) {
  ArchMageFPDealDummy <- DealCalcWithMaxDMR(get(UnstableCyclesFP$CycleNames[i]), ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, 
                                            NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))
  assign(paste("ArchMageFPDealData", i, sep=""), ArchMageFPDealDummy)
  rm(ArchMageFPDealDummy)
}
ArchMageFPDealRatio <- ResetDealRatio(DealCycles=GetList(UnstableCyclesFP$CycleNames), 
                                      DealDatas=GetList(UnstableCyclesFP$DealDatas), 
                                      times=UnstableCyclesFP$CycleTimes, 
                                      prob=UnstableCyclesFP$Prob)

set(get(DPMCalcOption$DataName), as.integer(3), "ArchMageFP", Deal_RR(ArchMageFPDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "ArchMageFP", Deal_40s(ArchMageFPDealData, F, NA, FinishTime=subset(ArchMageFPDealData, ArchMageFPDealData$Skills=="Restraint4")$Time[1] + 15000))

ArchMageFPSpecMean <- ResetSpecMean("ArchMageFP", 
                                    GetList(UnstableCyclesFP$CycleNames), 
                                    GetList(UnstableCyclesFP$DealDatas), 
                                    ATKFinal, BuffFinal, SummonedFinal, ArchMageFPSpecOpt, UnstableCyclesFP$CycleTimes, UnstableCyclesFP$Prob, 
                                    NotBuffCols=c("InfinityFDR"), NotBuffColOption=c("FDR"))