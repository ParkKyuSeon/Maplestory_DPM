## Xenon - Data
## Xenon - Core
XenonCoreBase <- CoreBuilder(ActSkills=c("MegaSmasher", "OverloadMode", "HologramGrafityFusion", "PhotonRay",
                                         unique(c(CommonV("Thief", "Resistance"), CommonV("Pirate", "Resistance")))[2:7]), 
                             ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25, 25), 
                             UsefulSkills=c("SharpEyes", "CombatOrders", "HyperBody"), 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             VPassiveList=XenonVPassive, 
                             VPassivePrior=XenonVPrior, 
                             SelfBind=T)

XenonCore <- MatrixSet(PasSkills=XenonCoreBase$PasSkills$Skills, 
                       PasLvs=XenonCoreBase$PasSkills$Lv, 
                       PasMP=XenonCoreBase$PasSkills$MP, 
                       ActSkills=XenonCoreBase$ActSkills$Skills, 
                       ActLvs=XenonCoreBase$ActSkills$Lv, 
                       ActMP=XenonCoreBase$ActSkills$MP, 
                       UsefulSkills=XenonCoreBase$UsefulSkills, 
                       UsefulLvs=20, 
                       UsefulMP=0, 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       SpecialCore=XenonCoreBase$SpecialCoreUse)


## Xenon - Basic Info
XenonBase <- JobBase(ChrInfo=ChrInfo, 
                     MobInfo=get(DPMCalcOption$MobSet),
                     SpecSet=get(DPMCalcOption$XenonSpecSet), 
                     Job="Xenon",
                     CoreData=XenonCore, 
                     BuffDurationNeeded=0, 
                     AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Xenon"), 
                     LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Xenon"), 
                     MonsterLife=get(FindJob(MonsterLifePreSet, "Xenon")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                     Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "EnergySword", get(DPMCalcOption$XenonSpecSet)$WeaponType, Xenon=T)[, 1:16],
                     WeaponType=get(DPMCalcOption$XenonSpecSet)$WeaponType, 
                     SubWeapon=SubWeapon[rownames(SubWeapon)=="Controller", ], 
                     Emblem=Emblem[rownames(Emblem)=="Resistance", ], 
                     CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Xenon")))
XenonBase2 <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$XenonSpecSetAlt), 
                      Job="Xenon",
                      CoreData=XenonCore, 
                      BuffDurationNeeded=0, 
                      AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Xenon"), 
                      LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Xenon"), 
                      MonsterLife=get(FindJob(MonsterLifePreSet, "Xenon")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                      Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "EnergySword", get(DPMCalcOption$XenonSpecSetAlt)$WeaponType, Xenon=T)[, 1:16],
                      WeaponType=get(DPMCalcOption$XenonSpecSetAlt)$WeaponType, 
                      SubWeapon=SubWeapon[rownames(SubWeapon)=="Controller", ], 
                      Emblem=Emblem[rownames(Emblem)=="Resistance", ], 
                      CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Xenon")))

## Xenon - Passive
{option <- factor(c("MainStat", "SubStat1", "SubStat2"), levels=PSkill)
value <- c(70, 70, 70)
ConversionStarForce <- data.frame(option, value)
  
option <- factor(c("BDR"), levels=PSkill)
value <- c(3)
MultiLateralI <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(5)
MultiLateralII <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(7)
MultiLateralIII <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
MultiLateralIV <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
MultiLateralV <- data.frame(option, value)

option <- factor(c("BDR", "FDR"), levels=PSkill)
value <- c(5, 15)
MultiLateralVI <- data.frame(option, value)

option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(2)
XenonBoost <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(40)
LinearPerspective <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "SubStat2"), levels=PSkill)
value <- c(25, 25, 25)
MinoritySupport <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
XenonMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "SubStat2"), levels=PSkill)
value <- c(10, 10, 10)
DualbridDefensive <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(XenonBase$PSkillLv/2), 30 + XenonBase$PSkillLv, 8)
XenonExpert <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30 + XenonBase$PSkillLv)
OffensiveMatrix <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(XenonCore, "ReadyToDie"))
ReadyToDiePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + GetCoreLv(XenonCore, "LoadedDice"))
LoadedDicePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(XenonCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "SubStat2"), levels=PSkill)
value <- c(rep(GetCoreLv(XenonCore, "RopeConnect"), 3))
RopeConnectPassive <- data.frame(option, value)}

XenonPassive <- Passive(list(ConversionStarForce, MultiLateralI, MultiLateralII, MultiLateralIII, MultiLateralIV, MultiLateralV, MultiLateralVI, 
                             XenonBoost, LinearPerspective, MinoritySupport, XenonMastery, DualbridDefensive, XenonExpert, OffensiveMatrix, 
                             ReadyToDiePassive, LoadedDicePassive, BlinkPassive, RopeConnectPassive))


## Xenon - Buff
OverloadModeTime <- ifelse(DPMCalcOption$MonsterLifeLevel >= 3, 70.5, 70)
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SurplusSupplyDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SurplusSupplyStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadModeFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TriangleFormationStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(90, 165, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MegaSmasherCharge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PhotonRayStack <- rbind(data.frame(option, value), info)

option <- factor(c("AddATKRate"), levels=BSkill)
value <- c(70)
info <- c(0, 0, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VirtualProjection <- rbind(data.frame(option, value), info)

option <- factor(c("ATK"), levels=BSkill)
value <- c(30)
info <- c(240, 0, 990, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InclinePower <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR"), levels=BSkill)
value <- c(30 + floor(XenonBase$SkillLv/2), 30 + XenonBase$SkillLv)
info <- c(40, 0, 600, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OOPArtCode <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "SubStat1", "SubStat2"), levels=BSkill)
value <- c(floor((XenonBase$ChrLv * 5 + 26 - 660) * (0.15 + 0.01 * ceiling(XenonBase$SkillLv/2))), floor(330 * (0.15 + 0.01 * ceiling(XenonBase$SkillLv/2))), floor(330 * (0.15 + 0.01 * ceiling(XenonBase$SkillLv/2))))
info <- c(900 + 30 * XenonBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 90, 900, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AmaranthGenerator <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(10)
info <- c(25, 50, Delay(3150, 2), F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MeltdownExplosionBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(30)
info <- c(10, 50, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MeltdownExplosionDebuff <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(XenonCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
UsefulHyperBody <- Useful$UsefulHyperBody
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(OverloadModeTime, 180, 720, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMode <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(5 + floor(GetCoreLv(XenonCore, "HologramGrafityFusion")/2))
info <- c(30 + 10, 90, Delay(930, 2), F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HologramGrafityFusionBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(XenonCore, "ReadyToDie")/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(GetCoreLv(XenonCore, "ReadyToDie")/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "SubStat1", "SubStat2", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(XenonCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * XenonBase$MainStatP), 
           floor(((1 + 0.1 * GetCoreLv(XenonCore, "MapleWarriors2")) * MapleSoldier[2, 2]) * XenonBase$AllStatP), 
           floor(((1 + 0.1 * GetCoreLv(XenonCore, "MapleWarriors2")) * MapleSoldier[3, 2]) * XenonBase$AllStatP), 
           5 + floor(GetCoreLv(XenonCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 180, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(XenonCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="EnergySword", 6]))
info <- c(30, 70 - floor(GetCoreLv(XenonCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="EnergySword", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(XenonCore, "OverDrive")/5), T, XenonBase$UnionChrs$CoolReduceP, XenonBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(GetCoreLv(XenonCore, "OverDrive")/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)}

XenonBuff <- list(SurplusSupplyDummy=SurplusSupplyDummy, SurplusSupplyStack=SurplusSupplyStack, OverloadModeFDR=OverloadModeFDR, TriangleFormationStack=TriangleFormationStack, 
                  MegaSmasherCharge=MegaSmasherCharge, PhotonRayStack=PhotonRayStack, 
                  VirtualProjection=VirtualProjection, InclinePower=InclinePower, OOPArtCode=OOPArtCode, MapleSoldier=MapleSoldier, 
                  AmaranthGenerator=AmaranthGenerator, MeltdownExplosionBuff=MeltdownExplosionBuff, MeltdownExplosionDebuff=MeltdownExplosionDebuff, 
                  UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulHyperBody=UsefulHyperBody, 
                  OverloadMode=OverloadMode, HologramGrafityFusionBuff=HologramGrafityFusionBuff, 
                  ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, LuckyDice5=LuckyDice5, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, 
                  Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : MapleSoldier, UsefulSharpEyes, UsefulCombatOrders, UsefulHyperBody, (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  XenonBuff[[length(XenonBuff)+1]] <- UsefulAdvancedBless
  names(XenonBuff)[[length(XenonBuff)]] <- "UsefulAdvancedBless"
}
XenonBuff <- Buff(XenonBuff)
XenonAllTimeBuff <- AllTimeBuff(XenonBuff)


## Xenon - Union & HyperStat & SoulWeapon
XenonSpec <- JobSpec(JobBase=XenonBase, 
                     Passive=XenonPassive, 
                     AllTimeBuff=XenonAllTimeBuff, 
                     MobInfo=get(DPMCalcOption$MobSet),
                     SpecSet=get(DPMCalcOption$XenonSpecSet), 
                     WeaponName="EnergySword", 
                     UnionStance=0,
                     JobConstant=0.875)
XenonSpec2 <- JobSpec(JobBase=XenonBase2, 
                      Passive=XenonPassive, 
                      AllTimeBuff=XenonAllTimeBuff, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$XenonSpecSetAlt), 
                      WeaponName="EnergySword", 
                      UnionStance=0,
                      JobConstant=0.875)

XenonUnionRemained <- XenonSpec$UnionRemained
XenonHyperStatBase <- XenonSpec$HyperStatBase
XenonCoolReduceType <- XenonSpec$CoolReduceType
XenonSpec <- XenonSpec$Spec

XenonUnionRemained2 <- XenonSpec2$UnionRemained
XenonHyperStatBase2 <- XenonSpec2$HyperStatBase
XenonCoolReduceType2 <- XenonSpec2$CoolReduceType
XenonSpec2 <- XenonSpec2$Spec


## Xenon - Spider In Mirror
SIM <- SIMData(GetCoreLv(XenonCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Xenon - Attacks
## Hyper : Fuzzylop Masquerade - Reinforce, Fuzzylop Masquerade - Ignore Guard, Hologram Grafity - Reinforce, Hologram Grafity - Speed, Hologram Grafity - Persist
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(XenonCore, "PinpointRocket")>=40, 20, 0), 2 * GetCoreLv(XenonCore, "PinpointRocket"))
info <- c(50 + 40 + 40 + 100, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PinpointRocket <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + floor(XenonSpec$PSkillLv/3), ifelse(GetCoreLv(XenonCore, "AegisSystem")>=40, 20, 0), 2 * GetCoreLv(XenonCore, "AegisSystem"))
info <- c(120, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AegisSystem <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20 + floor(XenonSpec$PSkillLv/3), ifelse(GetCoreLv(XenonCore, "AegisSystem")>=40, 20, 0), 2 * GetCoreLv(XenonCore, "AegisSystem"))
info <- c(120, 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AegisSystemGrafityFusion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(XenonCore, "TriangleFormation")>=40, 20, 0), 3 * GetCoreLv(XenonCore, "TriangleFormation"))
info <- c(340, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriangleFormation <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(30 + XenonSpec$SkillLv, 10, ifelse(GetCoreLv(XenonCore, "FuzzylopMasquerade")>=40, 20, 0))), 2 * GetCoreLv(XenonCore, "FuzzylopMasquerade"))
info <- c(345 + 2 * XenonSpec$SkillLv, 7, 870, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuzzylopMasquerade <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(XenonCore, "MeltdownExplosion")>=40, 20, 0), 2 * GetCoreLv(XenonCore, "MeltdownExplosion"))
info <- c(1500, 6, 0, NA, 50, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MeltdownExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExtraSupply <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(275 + 10 * GetCoreLv(XenonCore, "MegaSmasher"), 6, 1000, 150, 165, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegaSmasher <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1000, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegaSmasherDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MegaSmasherEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 6840, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OverloadModeATKDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(180 + 7 * GetCoreLv(XenonCore, "OverloadMode"), 6, 0, 30, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OverloadModeATK <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(10)
info <- c(250 + 10 * GetCoreLv(XenonCore, "HologramGrafityFusion"), 5, 0, 285, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HologramGrafityFusion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 0, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PhotonRayPrep <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * GetCoreLv(XenonCore, "PhotonRay"), 4, 0, 0, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PhotonRay <- rbind(data.frame(option, value), info)}

XenonATK <- Attack(list(PinpointRocket=PinpointRocket, AegisSystem=AegisSystem, AegisSystemGrafityFusion=AegisSystemGrafityFusion, TriangleFormation=TriangleFormation, 
                        FuzzylopMasquerade=FuzzylopMasquerade, MeltdownExplosion=MeltdownExplosion, ExtraSupply=ExtraSupply, 
                        MegaSmasher=MegaSmasher, MegaSmasherDummy=MegaSmasherDummy, MegaSmasherEnd=MegaSmasherEnd, OverloadModeATKDummy=OverloadModeATKDummy, OverloadModeATK=OverloadModeATK, 
                        HologramGrafityFusion=HologramGrafityFusion, PhotonRayPrep=PhotonRayPrep, PhotonRay=PhotonRay, 
                        SpiderInMirror=SpiderInMirror))


## Xenon - Summoned
{option <- factor(c("BDR", "IGR", "FDR"), levels=SSkill)
value <- c(10, ifelse(GetCoreLv(XenonCore, "HologramGrafity")>=40, 20, 0), 2 * GetCoreLv(XenonCore, "HologramGrafity"))
info <- c(400 + 5 * XenonSpec$SkillLv, 1, 930, 420, 20 + 10 + floor(XenonSpec$SkillLv/3), 30 - ceiling(XenonSpec$SkillLv/3), F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
HologramGrafity <- rbind(data.frame(option, value), info) ## SubTime Check Needed

option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * GetCoreLv(XenonCore, "ResistanceLineInfantry"), 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)}

XenonSummoned <- Summoned(list(HologramGrafity=HologramGrafity, ResistanceLineInfantry=ResistanceLineInfantry, 
                               SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                               SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Xenon - DealCycle
ATKFinal <- data.frame(XenonATK)
ATKFinal$Delay[c(-8:-10)] <- Delay(ATKFinal$Delay, XenonSpec$ATKSpeed)[c(-8:-10)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, XenonSpec$CoolReduceP, XenonSpec$CoolReduce)

BuffFinal <- data.frame(XenonBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, XenonSpec$CoolReduceP, XenonSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, XenonSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
ATKFinal <- AddATKRateSkills("VirtualProjection", BuffFinal, ATKFinal, c("FuzzylopMasquerade", "MegaSmasher", "OverloadModeATK", "MeltdownExplosion"))

SummonedFinal <- data.frame(XenonSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, XenonSpec$CoolReduceP, XenonSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * XenonSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(XenonBuff))
XenonDealCycle <- t(rep(0, length(DealCycle)))
colnames(XenonDealCycle) <- DealCycle
XenonDealCycle <- data.frame(XenonDealCycle)

XenonCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=c(180), CycleTime=c(360)) {
  BuffSummonedPrior <- c("UsefulSharpEyes", "UsefulCombatOrders", "UsefulHyperBody", "UsefulAdvancedBless", "LuckyDice5", 
                         "AmaranthGenerator", "OOPArtCode", "InclinePower", "OverloadMode")
  Times180 <- c(0, 0, 0, 0, 0, 
                1, 4, 1, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(165 * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce + 21, length(BuffSummonedPrior))
  TotalTime <- (165 * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce + 21) * (CycleTime / Period)
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
  
  XenonStack <- function(DealCycle) {
    ## Surplus Supply
    if(DealCycle$Skills[nrow(DealCycle)]=="OOPArtCode") {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- ifelse(DealCycle$OverloadMode[nrow(DealCycle)] > 0 | DealCycle$AmaranthGenerator[nrow(DealCycle)] > 0, 
                                                              DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)], DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)] - 20)
    } else if(DealCycle$Skills[nrow(DealCycle)]=="InclinePower") {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- ifelse(DealCycle$OverloadMode[nrow(DealCycle)] > 0 | DealCycle$AmaranthGenerator[nrow(DealCycle)] > 0, 
                                                              DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)], DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)] - 20)
    } else if(DealCycle$Skills[nrow(DealCycle)]=="AmaranthGenerator") {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- 20
    } else if(DealCycle$Skills[nrow(DealCycle)]=="ExtraSupply") {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- min(20, DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)] + 10)
    } else {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- DealCycle$SurplusSupplyStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$SurplusSupplyDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SurplusSupplyDummy[nrow(DealCycle)]==0 & DealCycle$OverloadMode[nrow(DealCycle)] == 0) {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- min(20, DealCycle$SurplusSupplyStack[nrow(DealCycle)] + 1)
      DealCycle$SurplusSupplyDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 4000, 4000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SurplusSupplyDummy[nrow(DealCycle)-1]))
      if(DealCycle$SurplusSupplyDummy[nrow(DealCycle)] < 0) {
        DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- min(20, DealCycle$SurplusSupplyStack[nrow(DealCycle)] + 1)
        DealCycle$SurplusSupplyDummy[nrow(DealCycle)] <- DealCycle$SurplusSupplyDummy[nrow(DealCycle)] + 4000
      }
    } else if(DealCycle$SurplusSupplyDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SurplusSupplyDummy[nrow(DealCycle)]==0 & DealCycle$OverloadMode[nrow(DealCycle)] > 0) {
      DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- min(40, DealCycle$SurplusSupplyStack[nrow(DealCycle)] + 1)
      DealCycle$SurplusSupplyDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 2000, 2000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SurplusSupplyDummy[nrow(DealCycle)-1]))
      if(DealCycle$SurplusSupplyDummy[nrow(DealCycle)] < 0) {
        DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- min(40, DealCycle$SurplusSupplyStack[nrow(DealCycle)] + 1)
        DealCycle$SurplusSupplyDummy[nrow(DealCycle)] <- DealCycle$SurplusSupplyDummy[nrow(DealCycle)] + 2000
      }
    }
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$SurplusSupplyStack[nrow(DealCycle)] <- 20
  DealCycle$SurplusSupplyDummy[nrow(DealCycle)] <- 4000
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- XenonStack(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- XenonStack(DealCycle)
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
  HGFCool <- subset(BuffFinal, rownames(BuffFinal)=="HologramGrafityFusionBuff")$CoolTime * 1000
  HGCool <- subset(SummonedFinal, rownames(SummonedFinal)=="HologramGrafity")$CoolTime * 1000
  MECool <- subset(BuffFinal, rownames(BuffFinal)=="MeltdownExplosionBuff")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000
  ODCool <- subset(BuffFinal, rownames(BuffFinal)=="OverDrive")$CoolTime * 1000
  MW2Cool <- subset(BuffFinal, rownames(BuffFinal)=="MapleWarriors2")$CoolTime * 1000
  R4Cool <- subset(BuffFinal, rownames(BuffFinal)=="Restraint4")$CoolTime * 1000
  PRCool <- subset(ATKFinal, rownames(ATKFinal)=="PhotonRayPrep")$CoolTime * 1000
  MSCool <- subset(ATKFinal, rownames(ATKFinal)=="MegaSmasher")$CoolTime * 1000
  RICool <- subset(SummonedFinal, rownames(SummonedFinal)=="ResistanceLineInfantry")$CoolTime * 1000
  
  HGFRemain <- 0 ; HGRemain <- 0 ; MERemain <- 0 ; SCRemain <- 0 ; ODRemain <- 0 ; MW2Remain <- 0 ; R4Remain <- 0 
  PRRemain <- 0 ; MSRemain <- 18500 ; RIRemain <- 0
  
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
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          DealCycle <- XenonStack(DealCycle)
          HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
          HGRemain <- max(0, HGRemain - DealCycle$Time[1])
          MERemain <- max(0, MERemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
          R4Remain <- max(0, R4Remain - DealCycle$Time[1])
          PRRemain <- max(0, PRRemain - DealCycle$Time[1])
          MSRemain <- max(0, MSRemain - DealCycle$Time[1])
          RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        }
      }
      ## Hologram Grafity
      if(HGRemain == 0 & HGFRemain <= 35000 & DealCycle$HologramGrafityFusionBuff[nrow(DealCycle)] - DealCycle$Time[1] < 0 & 
         nrow(subset(DealCycle, DealCycle$Skills=="HologramGrafitySummoned")) < nrow(subset(DealCycle, DealCycle$Skills=="HologramGrafityFusionBuff")) + 1 & 
         nrow(subset(DealCycle, DealCycle$Skills=="HologramGrafitySummoned")) < 4)  {
        DealCycle <- DCSummoned(DealCycle, "HologramGrafity", SummonedFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGCool - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      } 
      ## Hologram Grafity : Fusion
      else if(HGFRemain == 0 & DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= 35 & max(subset(DealCycle, DealCycle$Skills=="HologramGrafitySummoned")$Time) + 30000 <= DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] | 
              HGFRemain == 0 & DealCycle$OverloadMode[nrow(DealCycle)] == 0 & max(subset(DealCycle, DealCycle$Skills=="HologramGrafitySummoned")$Time) + 30000 <= DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) {
        DealCycle <- DCBuff(DealCycle, "HologramGrafityFusionBuff", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFCool - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      } 
      ## Maple Warriors 2
      else if(MW2Remain == 0 & DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= 23 & nrow(subset(DealCycle, DealCycle$Skills=="MapleWarriors2")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode"))) {
        DealCycle <- DCBuff(DealCycle, "MapleWarriors2", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Cool - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Spider In Mirror
      else if(DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= 29 & nrow(subset(DealCycle, DealCycle$Skills=="SpiderInMirror")) == 0) {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Over Drive, Soul Contract, Ready To Die, Meltdown Explosion
      else if(SCRemain <= 540 + 2370 & DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= 36 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode")) * 2) {
        DealCycle <- DCBuff(DealCycle, "OverDrive", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "MeltdownExplosionDebuff", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MECool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "MeltdownExplosionBuff", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "ReadyToDie2Stack", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      else if(SCRemain <= 540 & DealCycle$OverloadMode[nrow(DealCycle)] == 0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode")) * 2) {
        DealCycle <- DCBuff(DealCycle, "OverDrive", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "ReadyToDie2Stack", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      else if(MERemain == 0 & DealCycle$OverloadMode[nrow(DealCycle)] == 0 & nrow(subset(DealCycle, DealCycle$Skills=="MeltdownExplosionBuff")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode")) * 3) {
        DealCycle <- DCBuff(DealCycle, "MeltdownExplosionDebuff", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MECool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "MeltdownExplosionBuff", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Restraint 4
      else if(R4Remain == 0 & DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= 40 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode"))) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Cool - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Photon Ray
      else if(PRRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="PhotonRayPrep")) < ceiling(nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode")) * ifelse(Spec$CoolReduce>=2, 6.5, 6))) {
        DealCycle <- DCATK(DealCycle, "PhotonRayPrep", ATKFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRCool - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "FuzzylopMasquerade", ATKFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Resistance Line Infantry
      else if(RIRemain == 0 & DealCycle$SurplusSupplyStack[nrow(DealCycle)] >= ifelse(Spec$CoolReduce>=2, 28, 27)) {
        DealCycle <- DCSummoned(DealCycle, "ResistanceLineInfantry", SummonedFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RICool - DealCycle$Time[1])
      }
      else if(RIRemain == 0 & DealCycle$OverloadMode[nrow(DealCycle)] == 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="ResistanceLineInfantrySummoned")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode")) * ifelse(Spec$CoolReduce>=2, 8, 7)) {
        DealCycle <- DCSummoned(DealCycle, "ResistanceLineInfantry", SummonedFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RICool - DealCycle$Time[1])
      }
      ## Mega Smasher(Start)
      else if(MSRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="MegaSmasherCharge")) < nrow(subset(DealCycle, DealCycle$Skills=="OverloadMode"))) {
        DealCycle <- DCBuff(DealCycle, "MegaSmasherCharge", BuffFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Mega Smasher(Release)
      else if(DealCycle$MegaSmasherCharge[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$Restraint4[nrow(DealCycle)] > 0 & DealCycle$MegaSmasherCharge[nrow(DealCycle)] - DealCycle$Time[1] < 72000) {
        DealCycle <- DCATK(DealCycle, "MegaSmasher", ATKFinal)
        DealCycle$MegaSmasherCharge[nrow(DealCycle)] <- 0
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSCool - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        
        for(i in 1:11) {
          DealCycle <- DCATK(DealCycle, "MegaSmasherDummy", ATKFinal)
          DealCycle <- XenonStack(DealCycle)
          HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
          HGRemain <- max(0, HGRemain - DealCycle$Time[1])
          MERemain <- max(0, MERemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
          R4Remain <- max(0, R4Remain - DealCycle$Time[1])
          PRRemain <- max(0, PRRemain - DealCycle$Time[1])
          MSRemain <- max(0, MSRemain - DealCycle$Time[1])
          RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "MegaSmasherEnd", ATKFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
      ## Fuzzylop Masquerade
      else {
        DealCycle <- DCATK(DealCycle, "FuzzylopMasquerade", ATKFinal)
        DealCycle <- XenonStack(DealCycle)
        HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
        HGRemain <- max(0, HGRemain - DealCycle$Time[1])
        MERemain <- max(0, MERemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
        R4Remain <- max(0, R4Remain - DealCycle$Time[1])
        PRRemain <- max(0, PRRemain - DealCycle$Time[1])
        MSRemain <- max(0, MSRemain - DealCycle$Time[1])
        RIRemain <- max(0, RIRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- XenonStack(DealCycle)
          HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
          HGRemain <- max(0, HGRemain - DealCycle$Time[1])
          MERemain <- max(0, MERemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
          R4Remain <- max(0, R4Remain - DealCycle$Time[1])
          PRRemain <- max(0, PRRemain - DealCycle$Time[1])
          MSRemain <- max(0, MSRemain - DealCycle$Time[1])
          RIRemain <- max(0, RIRemain - DealCycle$Time[1])
          if(BuffList[[k]][i] == "OOPArtCode" & DealCycle$OverloadMode[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$AmaranthGenerator[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
            DealCycle <- DCATK(DealCycle, "ExtraSupply", ATKFinal)
            DealCycle <- XenonStack(DealCycle)
            HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
            HGRemain <- max(0, HGRemain - DealCycle$Time[1])
            MERemain <- max(0, MERemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
            R4Remain <- max(0, R4Remain - DealCycle$Time[1])
            PRRemain <- max(0, PRRemain - DealCycle$Time[1])
            MSRemain <- max(0, MSRemain - DealCycle$Time[1])
            RIRemain <- max(0, RIRemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- XenonStack(DealCycle)
          HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
          HGRemain <- max(0, HGRemain - DealCycle$Time[1])
          MERemain <- max(0, MERemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
          R4Remain <- max(0, R4Remain - DealCycle$Time[1])
          PRRemain <- max(0, PRRemain - DealCycle$Time[1])
          MSRemain <- max(0, MSRemain - DealCycle$Time[1])
          RIRemain <- max(0, RIRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  while(MSRemain >= 18500) {
    DealCycle <- DCATK(DealCycle, "FuzzylopMasquerade", ATKFinal)
    DealCycle <- XenonStack(DealCycle)
    HGFRemain <- max(0, HGFRemain - DealCycle$Time[1])
    HGRemain <- max(0, HGRemain - DealCycle$Time[1])
    MERemain <- max(0, MERemain - DealCycle$Time[1])
    SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    MW2Remain <- max(0, MW2Remain - DealCycle$Time[1])
    R4Remain <- max(0, R4Remain - DealCycle$Time[1])
    PRRemain <- max(0, PRRemain - DealCycle$Time[1])
    MSRemain <- max(0, MSRemain - DealCycle$Time[1])
    RIRemain <- max(0, RIRemain - DealCycle$Time[1])
  }
  
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
XenonAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, OverloadModeTime) {
  ## Meltdown Explosion (ATK)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MeltdownExplosionDebuff"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "MeltdownExplosion"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Mega Smasher
  DealCycle <- RepATKCycle(DealCycle, "MegaSmasher", 78, 330, ATKFinal)
  
  
  ## Overload Mode
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("OverloadMode"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "OverloadModeATKDummy"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  OverloadATKTimes <- floor(OverloadModeTime * 1000 / ATKFinal[rownames(ATKFinal)=="OverloadModeATKDummy", ]$SubTime)
  DealCycle <- RepATKCycle(DealCycle, "OverloadModeATKDummy", OverloadATKTimes, ATKFinal[rownames(ATKFinal)=="OverloadModeATKDummy", ]$SubTime, ATKFinal)
  
  DealCycle[DealCycle$Skills=="OverloadModeATKDummy", ]$Skills <- "OverloadModeATK"
  DealCycle <- RepATKCycle(DealCycle, "OverloadModeATK", 4, 30, ATKFinal)
  
  
  ## Photon Ray
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PhotonRayPrep"))>=1) {
      DealCycle$PhotonRayStack[i] <- 14
    } else if(sum(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher"))>=1 & DealCycle$PhotonRayStack[i-1] > 0 & DealCycle$PhotonRayStack[i-1] < 30) {
      DealCycle$PhotonRayStack[i] <- min(30, DealCycle$PhotonRayStack[i-1] + 1)
    } else if(sum(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher", "MeltdownExplosion"))>=1 & DealCycle$PhotonRayStack[i-1] == 30) {
      DealCycle$PhotonRayStack[i] <- 0
      for(j in 1:30) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "PhotonRay"
      }
    } else {
      DealCycle$PhotonRayStack[i] <- DealCycle$PhotonRayStack[i-1]
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Triangle Formation
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher", "MeltdownExplosion", "OverloadModeATK", "PhotonRay"))>=1 & DealCycle$TriangleFormationStack[i-1] < 30) {
      DealCycle$TriangleFormationStack[i] <- DealCycle$TriangleFormationStack[i-1] + 3
    } else if(sum(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher", "MeltdownExplosion", "OverloadModeATK", "PhotonRay"))>=1 & DealCycle$TriangleFormationStack[i-1] >= 30) {
      DealCycle$TriangleFormationStack[i] <- DealCycle$TriangleFormationStack[i-1] - 30
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "TriangleFormation"
    } else {
      DealCycle$TriangleFormationStack[i] <- DealCycle$TriangleFormationStack[i-1]
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Hologram Grafity / Hologram Grafity : Fusion
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("HologramGrafityFusionBuff"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "HologramGrafityFusion"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- DCSummonedATKs(DealCycle, "HologramGrafity", SummonedFinal)
  DealCycle <- RepATKCycle(DealCycle, "HologramGrafityFusion", 134, 2000, ATKFinal)
  
  Idx <- c()
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("HologramGrafity"))>=1 & DealCycle$HologramGrafityFusionBuff[i] > 0) {
      Idx <- c(Idx, i)
    }
  }
  if(length(Idx) > 0) {
    DealCycle <- DealCycle[-1 * Idx, ]
  }
  
  
  ## Pinpoint Rocket
  time <- 2001
  for(i in 2:nrow(DealCycle)) {
    if(time > 2000 & max(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- c("PinpointRocket")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Resistance Line Infantry, Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "ResistanceLineInfantry", SummonedFinal)
  
  
  ## Surplus Supply, Overload Mode FDR
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PinpointRocket", "TriangleFormation", "MeltdownExplosion", "MegaSmasher", "OverloadModeATKStart", "OverloadModeATK", 
                                  "HologramGrafityFusion", "PhotonRay", "HologramGrafity", "ResistanceLineInfantry", 
                                  "SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait"))>=1) {
      DealCycle$SurplusSupplyStack[i] <- DealCycle$SurplusSupplyStack[i-1]
    }
    DealCycle$OverloadModeFDR[i] <- max(0, DealCycle$SurplusSupplyStack[i] - 20)
  }
  
  
  ## Virtual Projection
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FuzzylopMasquerade", "MegaSmasher", "OverloadModeATK", "MeltdownExplosion"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "Add", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Meltdown Explosion ATK Debuff Exclusion
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MeltdownExplosion", "MeltdownExplosionAdd"))>=1) {
      DealCycle$MeltdownExplosionDebuff[i] <- 0
    }
  }
  
  
  ## Over Drive Exhaust
  DealCycle <- OverDriveExhaustBuff(DealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
  DealCycle$OverDriveExhaust[2] <- DealCycle$OverDriveExhaust[nrow(DealCycle)]
  p <- 2
  while(DealCycle$OverDriveExhaust[p] > 0) {
    DealCycle$OverDriveExhaust[p+1] <- max(0, DealCycle$OverDriveExhaust[p] - (DealCycle$Time[p+1] - DealCycle$Time[p]))
    p <- p + 1
  }
  
  ## Dummy Reduction
  DealCycle$SurplusSupplyDummy <- 0
  DealCycle$TriangleFormationStack <- 0
  DealCycle$MegaSmasherCharge <- 0
  DealCycle$PhotonRayStack <- 0
  return(DealCycle)
}

XenonDealCycle <- XenonCycle(XenonDealCycle, 
                                 ATKFinal,
                                 BuffFinal, 
                                 SummonedFinal, 
                                 XenonSpec, 
                                 180, 360)
XenonDealCycle <- DealCycleFinal(XenonDealCycle)
XenonDealCycle <- XenonAddATK(XenonDealCycle, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal, 
                              XenonSpec, 
                              OverloadModeTime)
XenonDealCycleReduction <- DealCycleReduction(XenonDealCycle, c("SurplusSupplyStack", "OverloadModeFDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Xenon") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  XenonSpecOpt1 <- XenonOptimization1(XenonDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, XenonSpec, XenonUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- XenonSpecOpt1[1, 1:3]
} else {
  XenonSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
XenonSpecOpt <- OptDataAdd(XenonSpec, XenonSpecOpt1, "Potential", XenonBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  XenonSpecOpt2 <- XenonOptimization2(XenonDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt, XenonHyperStatBase, XenonBase$ChrLv, XenonBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- XenonSpecOpt2[1, ]
} else {
  XenonSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
XenonSpecOpt <- OptDataAdd(XenonSpecOpt, XenonSpecOpt2, "HyperStat", XenonBase$CRROver, DemonAvenger=F)

XenonFinalDPM <- XenonDealCalc(XenonDealCycle, ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt)
XenonFinalDPMwithMax <- XenonDealCalcWithMaxDMR(XenonDealCycle, ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Xenon", sum(na.omit(XenonFinalDPMwithMax)) / (max(XenonDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Xenon", sum(na.omit(XenonFinalDPM)) / (max(XenonDealCycle$Time) / 60000) - sum(na.omit(XenonFinalDPMwithMax)) / (max(XenonDealCycle$Time) / 60000))

XenonDealRatio <- DealRatio(XenonDealCycle, XenonFinalDPMwithMax)

XenonDealData <- data.frame(XenonDealCycle$Skills, XenonDealCycle$Time, XenonDealCycle$Restraint4, XenonFinalDPMwithMax)
colnames(XenonDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Xenon", Deal_RR(XenonDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Xenon", Deal_40s(XenonDealData, F, StartTime=subset(XenonDealData, XenonDealData$Skills=="HologramGrafityFusionBuff")$Time[1]))

XenonSpecMean <- SpecMeanXenon("Xenon", XenonDealCycleReduction, 
                               DealCalcWithMaxDMR(XenonDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt), 
                               ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt)


## Potential - AllStat 9%
XenonSpecOpt_2 <- OptDataAdd(XenonSpec2, XenonSpecOpt1, "Potential", XenonBase$CRROver, DemonAvenger=F)
XenonSpecOpt_2 <- OptDataAdd(XenonSpecOpt_2, XenonSpecOpt2, "HyperStat", XenonBase$CRROver, DemonAvenger=F)

XenonFinalDPM_A9 <- XenonDealCalcWithMaxDMR(XenonDealCycle, ATKFinal, BuffFinal, SummonedFinal, XenonSpecOpt_2)
XenonDPM_A9 <- sum(na.omit(XenonFinalDPM_A9)) / (max(XenonDealCycle$Time)/ 60000)

XenonDealData_A9 <- data.frame(XenonDealCycle$Skills, XenonDealCycle$Time, XenonDealCycle$Restraint4, XenonFinalDPM_A9)
colnames(XenonDealData_A9) <- c("Skills", "Time", "R4", "Deal")

XenonRR_A9 <- Deal_RR(XenonDealData_A9)
Xenon40s_A9 <- Deal_40s(XenonDealData_A9, F, StartTime=subset(XenonDealData_A9, XenonDealData_A9$Skills=="HologramGrafityFusionBuff")$Time[1])

if(DPMCalcOption$XenonSpecSetAlt=="SpecDefaultXenon_A6A3") {
  print(data.frame(XenonDPM_A9=XenonDPM_A9, XenonRR_A9=XenonRR_A9, Xenon40s_A9=Xenon40s_A9))
} else {
  print(data.frame(XenonDPM_A21=XenonDPM_A9, XenonRR_A21=XenonRR_A9, Xenon40s_A21=Xenon40s_A9))
}