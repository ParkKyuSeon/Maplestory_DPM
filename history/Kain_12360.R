## Kain - Data
## Kain - Core
KainCoreBase <- CoreBuilder(ActSkills=c("DargonBurst", "FatalBlitz", "ThanatosDescent", "GripofAgony", 
                                        CommonV("Bowman", "Nova")[c(1, 2, 4, 5)]), 
                            ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25), 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            VPassiveList=KainVPassive, 
                            VPassivePrior=KainVPrior, 
                            SelfBind=F)


KainCore <- MatrixSet(PasSkills=KainCoreBase$PasSkills$Skills, 
                      PasLvs=KainCoreBase$PasSkills$Lv, 
                      PasMP=KainCoreBase$PasSkills$MP, 
                      ActSkills=KainCoreBase$ActSkills$Skills, 
                      ActLvs=KainCoreBase$ActSkills$Lv, 
                      ActMP=KainCoreBase$ActSkills$MP, 
                      UsefulSkills=KainCoreBase$UsefulSkills, 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      SpecialCore=KainCoreBase$SpecialCoreUse)


## Kain - Basic Info
## Link Check Needed
KainBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=get(DPMCalcOption$MobSet),
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    Job="Kain",
                    CoreData=KainCore, 
                    BuffDurationNeeded=0, 
                    AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Kain"), 
                    LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Kain"), 
                    MonsterLife=get(FindJob(MonsterLifePreSet, "Kain")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                    Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "BreathShooter", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                    WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="WeaponBelt", ], 
                    Emblem=Emblem[rownames(Emblem)=="Hitman", ], 
                    CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Kain")))


## Kain - Passive
{option <- factor(c("ATK", "CRR"), levels=PSkill)
value <- c(40, 35)
Hitman <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(40)
BreathShooterMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("FDR", "ATK", "CRR", "IGR"), levels=PSkill)
value <- c(20, 40, 20, 10)
NaturalBornInstinct <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + KainBase$PSkillLv)
GrindingII <- data.frame(option, value)

option <- factor(c("FDR", "CDMR", "IGR"), levels=PSkill)
value <- c(20 + floor(KainBase$PSkillLv/2), 20 + KainBase$PSkillLv, 30 + KainBase$PSkillLv)
Dogma <- data.frame(option, value)

option <- factor(c("Mastery", "FDR", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(KainBase$PSkillLv/2), 30 + floor(KainBase$PSkillLv/2), 30 + KainBase$PSkillLv, 20 + floor(KainBase$PSkillLv/2))
BreathShooterExpert <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20 + ceiling(KainBase$PSkillLv/2))
AdaptToDeath <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(KainCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(KainCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

KainPassive <- Passive(list(Hitman, BreathShooterMastery, PhysicalTraining, NaturalBornInstinct, GrindingII, Dogma, BreathShooterExpert, AdaptToDeath, 
                            BlinkPassive, RopeConnectPassive))


## Kain - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MaliceGauge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MaliceGaugeDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(15, 16, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Possession <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DeathBlessingStack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + 10 + floor(KainBase$PSkillLv/2))
info <- c(5, 10, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ContributionBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ScatteringShotDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ScatteringShotStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShaftBreakDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShaftBreakStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FallingDustDummy <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FallingDustStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PriorPreperationStack <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(17)
info <- c(20, 40, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PriorPreperation <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AgonyStack <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, 0, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BreathShooterBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((KainBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(KainBase$SkillLv/2))))
info <- c(900 + 30 * KainBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATKP"), levels=BSkill)
value <- c(15, 15)
info <- c(40, 180, 780, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Incanation <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(KainCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + GetCoreLv(KainCore, "BlessofGrandisGoddess"))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(15 + GetCoreLv(KainCore, "ThanatosDescent"))
info <- c(35, 180, Delay(540, 2), F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ThanatosDescent <- rbind(data.frame(option, value), info)}

KainBuff <- list(MaliceGauge=MaliceGauge, MaliceGaugeDummy=MaliceGaugeDummy, Possession=Possession, DeathBlessingStack=DeathBlessingStack, ContributionBuff=ContributionBuff, 
                 ScatteringShotDummy=ScatteringShotDummy, ScatteringShotStack=ScatteringShotStack, ShaftBreakDummy=ShaftBreakDummy, ShaftBreakStack=ShaftBreakStack, 
                 FallingDustDummy=FallingDustDummy, FallingDustStack=FallingDustStack, PriorPreperationStack=PriorPreperationStack, PriorPreperation=PriorPreperation, AgonyStack=AgonyStack, 
                 BreathShooterBooster=BreathShooterBooster, MapleSoldier=MapleSoldier, Incanation=Incanation, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                 CriticalReinforce=CriticalReinforce, BlessofGrandisGoddess=BlessofGrandisGoddess, ThanatosDescent=ThanatosDescent, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  KainBuff[[length(KainBuff)+1]] <- UsefulAdvancedBless
  names(KainBuff)[[length(KainBuff)]] <- "UsefulAdvancedBless"
}
KainBuff <- Buff(KainBuff)
## Petbuff : Breath Shooter Booster, Maple Soldier, Useful Combat Orders, Useful Sharp Eyes, (Useful Advanced Bless)
KainAllTimeBuff <- AllTimeBuff(KainBuff)


## Kain - Union & HyperStat & SoulWeapon
KainSpec <- JobSpec(JobBase=KainBase, 
                    Passive=KainPassive, 
                    AllTimeBuff=KainAllTimeBuff, 
                    MobInfo=get(DPMCalcOption$MobSet), 
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    WeaponName="BreathShooter", 
                    UnionStance=0)

KainUnionRemained <- KainSpec$UnionRemained
KainHyperStatBase <- KainSpec$HyperStatBase
KainCoolReduceType <- KainSpec$CoolReduceType
KainSpec <- KainSpec$Spec


## Kain - Spider In Mirror
SIM <- SIMData(GetCoreLv(KainCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Kain - Attacks
## Hyper : Breath Shooter - Reinforce, Breath Shooter - Boss Killer, Execute - Enhance, Execute - Reinforce, Remain Incense - Reinforce
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "StrikeArrow_ChasingShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "StrikeArrow_ChasingShot"))
info <- c(70 + 89 + 79 + 134 + 1 * KainSpec$PSkillLv, 5, 570, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
StrikeArrow <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "StrikeArrow_ChasingShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "StrikeArrow_ChasingShot"))
info <- c(160 + 79 + 134 + 1 * KainSpec$PSkillLv, 5, 570, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
StrikeArrow2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "StrikeArrow_ChasingShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "StrikeArrow_ChasingShot"))
info <- c(240 + 134 + 1 * KainSpec$PSkillLv, 5, 570, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
StrikeArrow3 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "StrikeArrow_ChasingShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "StrikeArrow_ChasingShot"))
info <- c(200 + 80 + 122 + 1 * KainSpec$PSkillLv, 8, 570, NA, 1, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessStrikeArrow <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ScatteringShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ScatteringShot"))
info <- c(120 + 75 + 102 + 2 * KainSpec$PSkillLv, 4, 630, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScatteringShot <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ScatteringShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ScatteringShot"))
info <- c((120 + 75 + 102 + 2 * KainSpec$PSkillLv) * 0.5, 4 * 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ScatteringShotAfter <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ScatteringShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ScatteringShot"))
info <- c(135 + 80 + 110 + 2 * KainSpec$PSkillLv, 4, 630, NA, 6, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessScatteringShot <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ScatteringShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ScatteringShot"))
info <- c((135 + 80 + 110 + 2 * KainSpec$PSkillLv) * 0.5, 4 * 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessScatteringShotAfter <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ShaftBreak")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ShaftBreak"))
info <- c(184 + 80 + 1 * KainSpec$PSkillLv, 3, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShaftBreak <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ShaftBreak")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ShaftBreak"))
info <- c(140 + 80 + 1 * KainSpec$PSkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShaftBreakExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ShaftBreak")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ShaftBreak"))
info <- c(184 + 117 + 1 * KainSpec$PSkillLv, 3, 660, NA, 11, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessShaftBreak <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ShaftBreak")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ShaftBreak"))
info <- c(224 + 117 + 1 * KainSpec$PSkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessShaftBreakExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "ShaftBreak")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "ShaftBreak"))
info <- c(40 + 21 + floor(KainSpec$PSkillLv/3), 3, 0, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessShaftBreakTornado <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "FallingDust")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "FallingDust"))
info <- c(451 + 5 * KainSpec$SkillLv, 8, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FallingDust <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "FallingDust")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "FallingDust"))
info <- c(462 + 5 * KainSpec$SkillLv, 8, 660, NA, 14, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessFallingDust <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "FallingDust")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "FallingDust"))
info <- c(264 + 5 * KainSpec$SkillLv, 15, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessFallingDustAdd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "StrikeArrow_ChasingShot")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "StrikeArrow_ChasingShot"))
info <- c(352, 6 * 3, Delay(960, 4), NA, 25, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChasingShot <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "DeathBlessing_SneakySniping")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "DeathBlessing_SneakySniping"))
info <- c(193, 10 * 5, 30 + 270, NA, 40, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SneakySniping <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(45, IGRCalc(c(0, ifelse(GetCoreLv(KainCore, "DeathBlessing_SneakySniping")>=40, 20, 0))), 2 * GetCoreLv(KainCore, "DeathBlessing_SneakySniping"))
info <- c(220, 12 * 5, 30 + 270, NA, 60, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessExecuteSneakySniping <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "PhantomBlade_TearingKnife")>=40, 20, 0), 2 * GetCoreLv(KainCore, "PhantomBlade_TearingKnife"))
info <- c(155 + 142 + 1 * KainSpec$PSkillLv, 6, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecutePhantomBlade <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "PhantomBlade_TearingKnife")>=40, 20, 0), 2 * GetCoreLv(KainCore, "PhantomBlade_TearingKnife"))
info <- c(210 + 148 + 1 * KainSpec$PSkillLv, 7, 660, NA, 4.5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteTearingKnife <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "ChainSickle_PoisonNeedle")>=40, 20, 0), 2 * GetCoreLv(KainCore, "ChainSickle_PoisonNeedle"))
info <- c(220 + 2 * KainSpec$SkillLv, 6, 300, NA, 7, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteChainSickle <- rbind(data.frame(option, value), info) ## Original Delay : 300

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "ChainSickle_PoisonNeedle")>=40, 20, 0), 2 * GetCoreLv(KainCore, "ChainSickle_PoisonNeedle"))
info <- c(242 + 2 * KainSpec$SkillLv, 12, 510, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteChainSickleAdd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "ChainSickle_PoisonNeedle")>=40, 20, 0), 2 * GetCoreLv(KainCore, "ChainSickle_PoisonNeedle"))
info <- c(275 + 3 * KainSpec$SkillLv, 8, 330, NA, 15, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecutePoisonNeedlePre <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(KainCore, "ChainSickle_PoisonNeedle")>=40, 20, 0), 2 * GetCoreLv(KainCore, "ChainSickle_PoisonNeedle"))
info <- c(209 + 1 * KainSpec$SkillLv, 8, 390, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecutePoisonNeedleLoop <- rbind(data.frame(option, value), info) ## SubTime Check Needed, ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecutePoisonNeedleEnd <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KainCore, "DragonFang_RemainIncense")>=40, 20, 0), 2 * GetCoreLv(KainCore, "DragonFang_RemainIncense"))
info <- c(100 + 60 + 93 + 2 * KainSpec$PSkillLv, 4 * 3, 0, 1350, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonFang <- rbind(data.frame(option, value), info) ## StartATK : 750ms

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KainCore, "DeathBlessing_SneakySniping")>=40, 20, 0), 2 * GetCoreLv(KainCore, "DeathBlessing_SneakySniping"))
info <- c(140 + 163 + 5 * KainSpec$PSkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathBlessing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(KainCore, "DeathBlessing_SneakySniping")>=40, 20, 0), 2 * GetCoreLv(KainCore, "DeathBlessing_SneakySniping"))
info <- c(140 + 163 + 5 * KainSpec$PSkillLv, 13, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathBlessingIncanation <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(50, ifelse(GetCoreLv(KainCore, "DragonFang_RemainIncense")>=40, 20, 0), 2 * GetCoreLv(KainCore, "DragonFang_RemainIncense"))
info <- c(90 + 75 + 1 * KainSpec$PSkillLv, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RemainIncense <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 300, 180, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessDragonBurstPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(KainCore, "DargonBurst"), 12, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessDragonBurstTick <- rbind(data.frame(option, value), info) ## 15 Times

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PossessDragonBurstEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, 120, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteFatalBlitzPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * GetCoreLv(KainCore, "FatalBlitz"), 12, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteFatalBlitzTick <- rbind(data.frame(option, value), info) ## 14 Times

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 180, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ExecuteFatalBlitzEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(325 + 13 * GetCoreLv(KainCore, "ThanatosDescent"), 3 * 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThanatosDescentAddATK <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 2670, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThanatosDescentEndPre <- rbind(data.frame(option, value), info) ## StartATK : 2670ms

option <- factor(levels=ASkill)
value <- c()
info <- c(650 + 26 * GetCoreLv(KainCore, "ThanatosDescent"), 15, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThanatosDescentEndTick <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, Delay(6510, 2) - 2670 - 180 * 9, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ThanatosDescentEndEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * GetCoreLv(KainCore, "GripofAgony"), 6, 660, 330, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GripofAgony <- rbind(data.frame(option, value), info)}

KainATK <- Attack(list(StrikeArrow=StrikeArrow, StrikeArrow2=StrikeArrow2, StrikeArrow3=StrikeArrow3, PossessStrikeArrow=PossessStrikeArrow, 
                       ScatteringShot=ScatteringShot, ScatteringShotAfter=ScatteringShotAfter, PossessScatteringShot=PossessScatteringShot, PossessScatteringShotAfter=PossessScatteringShotAfter, 
                       ShaftBreak=ShaftBreak, ShaftBreakExplosion=ShaftBreakExplosion, PossessShaftBreak=PossessShaftBreak, PossessShaftBreakExplosion=PossessShaftBreakExplosion, 
                       PossessShaftBreakTornado=PossessShaftBreakTornado, 
                       FallingDust=FallingDust, PossessFallingDust=PossessFallingDust, PossessFallingDustAdd=PossessFallingDustAdd, 
                       ChasingShot=ChasingShot, SneakySniping=SneakySniping, PossessExecuteSneakySniping=PossessExecuteSneakySniping, 
                       ExecutePhantomBlade=ExecutePhantomBlade, ExecuteTearingKnife=ExecuteTearingKnife, 
                       ExecuteChainSickle=ExecuteChainSickle, ExecuteChainSickleAdd=ExecuteChainSickleAdd, 
                       ExecutePoisonNeedlePre=ExecutePoisonNeedlePre, ExecutePoisonNeedleLoop=ExecutePoisonNeedleLoop, ExecutePoisonNeedleEnd=ExecutePoisonNeedleEnd, 
                       DragonFang=DragonFang, DeathBlessing=DeathBlessing, DeathBlessingIncanation=DeathBlessingIncanation, RemainIncense=RemainIncense, 
                       PossessDragonBurstPre=PossessDragonBurstPre, PossessDragonBurstTick=PossessDragonBurstTick, PossessDragonBurstEnd=PossessDragonBurstEnd,
                       ExecuteFatalBlitzPre=ExecuteFatalBlitzPre, ExecuteFatalBlitzTick=ExecuteFatalBlitzTick, ExecuteFatalBlitzEnd=ExecuteFatalBlitzEnd, 
                       ThanatosDescentAddATK=ThanatosDescentAddATK, ThanatosDescentEndPre=ThanatosDescentEndPre, ThanatosDescentEndTick=ThanatosDescentEndTick, ThanatosDescentEndEnd=ThanatosDescentEndEnd, 
                       GripofAgony=GripofAgony, 
                       SpiderInMirror=SpiderInMirror))


## Kain - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(KainCore, "GuidedArrow"), 1, 0, 510, 600, NA, F, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

KainSummoned <- Summoned(list(GuidedArrow=GuidedArrow, 
                              SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Kain - Critical Reinforce (RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(KainSpec$CRR * (0.2 + 0.01 * GetCoreLv(KainCore, "CriticalReinforce")))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}
KainBuff <- list(MaliceGauge=MaliceGauge, MaliceGaugeDummy=MaliceGaugeDummy, Possession=Possession, DeathBlessingStack=DeathBlessingStack, ContributionBuff=ContributionBuff, 
                 ScatteringShotDummy=ScatteringShotDummy, ScatteringShotStack=ScatteringShotStack, ShaftBreakDummy=ShaftBreakDummy, ShaftBreakStack=ShaftBreakStack, 
                 FallingDustDummy=FallingDustDummy, FallingDustStack=FallingDustStack, PriorPreperationStack=PriorPreperationStack, PriorPreperation=PriorPreperation, AgonyStack=AgonyStack, 
                 BreathShooterBooster=BreathShooterBooster, MapleSoldier=MapleSoldier, Incanation=Incanation, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                 CriticalReinforce=CriticalReinforce, BlessofGrandisGoddess=BlessofGrandisGoddess, ThanatosDescent=ThanatosDescent, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  KainBuff[[length(KainBuff)+1]] <- UsefulAdvancedBless
  names(KainBuff)[[length(KainBuff)]] <- "UsefulAdvancedBless"
}
KainBuff <- Buff(KainBuff)


## Kain - DealCycle
ATKFinal <- data.frame(KainATK)
ATKFinal$Delay[c(-17, -18, -19, -24:-26, -31:-36, -38:-40)] <- Delay(ATKFinal$Delay, KainSpec$ATKSpeed)[c(-17, -18, -19, -24:-26, -31:-36, -38:-40)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, KainSpec$CoolReduceP, KainSpec$CoolReduce)

BuffFinal <- data.frame(KainBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, KainSpec$CoolReduceP, KainSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, KainSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(KainSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, KainSpec$CoolReduceP, KainSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * KainSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(KainBuff))
KainDealCycle <- t(rep(0, length(DealCycle)))
colnames(KainDealCycle) <- DealCycle
KainDealCycle <- data.frame(KainDealCycle)

KainCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=c(180), CycleTime=c(360)) {
  BuffSummonedPrior <- c("BreathShooterBooster", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "GuidedArrow", "BlessofGrandisGoddess", "ThanatosDescent", "Incanation", "CriticalReinforce")
  
  Times180 <- c(0, 0, 0, 0, 
                0, 0.5, 1, 1, 1)
  
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
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
  
  KainStack <- function(DealCycle) {
    ## Scattering Shot
    if(DealCycle$Skills[nrow(DealCycle)]=="ScatteringShot") {
      DealCycle$ScatteringShotStack[nrow(DealCycle)] <- DealCycle$ScatteringShotStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$ScatteringShotStack[nrow(DealCycle)] <- DealCycle$ScatteringShotStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$ScatteringShotDummy[nrow(DealCycle)-1] >= 0 & DealCycle$ScatteringShotDummy[nrow(DealCycle)]==0 & DealCycle$ScatteringShotStack[nrow(DealCycle)] < 3) {
      DealCycle$ScatteringShotStack[nrow(DealCycle)] <- DealCycle$ScatteringShotStack[nrow(DealCycle)] + 1
      DealCycle$ScatteringShotDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 6000, 6000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$ScatteringShotDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$ScatteringShotStack[nrow(DealCycle)] == 3) {
      DealCycle$ScatteringShotDummy[nrow(DealCycle)] <- 6000
    }
    
    ## Shaft Break
    if(DealCycle$Skills[nrow(DealCycle)]=="ShaftBreak") {
      DealCycle$ShaftBreakStack[nrow(DealCycle)] <- DealCycle$ShaftBreakStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$ShaftBreakStack[nrow(DealCycle)] <- DealCycle$ShaftBreakStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$ShaftBreakDummy[nrow(DealCycle)-1] >= 0 & DealCycle$ShaftBreakDummy[nrow(DealCycle)]==0 & DealCycle$ShaftBreakStack[nrow(DealCycle)] < 3) {
      DealCycle$ShaftBreakStack[nrow(DealCycle)] <- DealCycle$ShaftBreakStack[nrow(DealCycle)] + 1
      DealCycle$ShaftBreakDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 8000, 8000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$ShaftBreakDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$ShaftBreakStack[nrow(DealCycle)] == 3) {
      DealCycle$ShaftBreakDummy[nrow(DealCycle)] <- 8000
    }
    
    ## Falling Dust
    if(DealCycle$Skills[nrow(DealCycle)]=="FallingDust") {
      DealCycle$FallingDustStack[nrow(DealCycle)] <- DealCycle$FallingDustStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$FallingDustStack[nrow(DealCycle)] <- DealCycle$FallingDustStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$FallingDustDummy[nrow(DealCycle)-1] >= 0 & DealCycle$FallingDustDummy[nrow(DealCycle)]==0 & DealCycle$FallingDustStack[nrow(DealCycle)] < 2) {
      DealCycle$FallingDustStack[nrow(DealCycle)] <- DealCycle$FallingDustStack[nrow(DealCycle)] + 1
      DealCycle$FallingDustDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 10000, 10000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$FallingDustDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$FallingDustStack[nrow(DealCycle)] == 2) {
      DealCycle$FallingDustDummy[nrow(DealCycle)] <- 10000
    }
    
    ## Malice Guage
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("StrikeArrow", "ScatteringShot", "ShaftBreak", "FallingDust", "ChasingShot", "SneakySniping")) >= 1) {
      DealCycle$MaliceGauge[nrow(DealCycle)] <- min(500, DealCycle$MaliceGauge[(nrow(DealCycle)-1)] + ifelse(DealCycle$ThanatosDescent[nrow(DealCycle)] > 0, 35, 18))
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecutePoisonNeedlePre", "ExecuteFatalBlitzTick")) >= 1) {
      DealCycle$MaliceGauge[nrow(DealCycle)] <- min(500, DealCycle$MaliceGauge[(nrow(DealCycle)-1)] + 12)
    } else if(DealCycle$Skills[nrow(DealCycle)]=="Possession") {
      DealCycle$MaliceGauge[nrow(DealCycle)] <- DealCycle$MaliceGauge[(nrow(DealCycle)-1)] - 100
    } else {
      DealCycle$MaliceGauge[nrow(DealCycle)] <- DealCycle$MaliceGauge[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$MaliceGaugeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$MaliceGaugeDummy[nrow(DealCycle)]==0 & DealCycle$MaliceGauge[nrow(DealCycle)] < 500) {
      DealCycle$MaliceGauge[nrow(DealCycle)] <- min(500, DealCycle$MaliceGauge[(nrow(DealCycle)-1)] + ifelse(DealCycle$ThanatosDescent[nrow(DealCycle)] > 0, 40, 30))
      DealCycle$MaliceGaugeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 4000, 4000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$MaliceGaugeDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$MaliceGaugeDummy[nrow(DealCycle)] == 500) {
      DealCycle$MaliceGaugeDummy[nrow(DealCycle)] <- 4000
    }
    
    ## Death Blessing
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PossessStrikeArrow", "PossessScatteringShot", "PossessShaftBreak", "PossessFallingDust", "PossessDragonBurstTick", "ThanatosDescentEndTick")) >= 1) {
      DealCycle$DeathBlessingStack[nrow(DealCycle)] <- min(15, DealCycle$DeathBlessingStack[(nrow(DealCycle)-1)] + 1)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecutePoisonNeedlePre", "ExecuteFatalBlitzTick")) >= 1) {
      DealCycle$DeathBlessingStack[nrow(DealCycle)] <- max(0, DealCycle$DeathBlessingStack[(nrow(DealCycle)-1)] - 1)
      if(DealCycle$DeathBlessingStack[nrow(DealCycle)-1] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- ifelse(DealCycle$Incanation[nrow(DealCycle)] > 0, "DeathBlessingIncanation", "DeathBlessing")
        DealCycle$ContributionBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="ContributionBuff")$Duration * 1000
      }
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("PossessExecuteSneakySniping")) >= 1) {
      DealCycle$DeathBlessingStack[nrow(DealCycle)] <- min(15, DealCycle$DeathBlessingStack[(nrow(DealCycle)-1)] + 1)
      DealCycle$DeathBlessingStack[nrow(DealCycle)] <- max(0, DealCycle$DeathBlessingStack[nrow(DealCycle)] - 1)
      DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
      DealCycle$Skills[nrow(DealCycle)] <- ifelse(DealCycle$Incanation[nrow(DealCycle)] > 0, "DeathBlessingIncanation", "DeathBlessing")
      DealCycle$ContributionBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="ContributionBuff")$Duration * 1000
    } else {
      DealCycle$DeathBlessingStack[nrow(DealCycle)] <- DealCycle$DeathBlessingStack[nrow(DealCycle)-1]
    }
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$MaliceGaugeDummy[nrow(DealCycle)] <- 4000
  DealCycle$ScatteringShotDummy[nrow(DealCycle)] <- 6000
  DealCycle$ShaftBreakDummy[nrow(DealCycle)] <- 8000
  DealCycle$FallingDustDummy[nrow(DealCycle)] <- 10000
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="BlessofGrandisGoddess") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- KainStack(DealCycle)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- KainStack(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- KainStack(DealCycle)
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
  P_SACool <- subset(ATKFinal, rownames(ATKFinal)=="PossessStrikeArrow")$CoolTime * 1000
  P_SSCool <- subset(ATKFinal, rownames(ATKFinal)=="PossessScatteringShot")$CoolTime * 1000
  P_SBCool <- subset(ATKFinal, rownames(ATKFinal)=="PossessShaftBreak")$CoolTime * 1000
  P_FDCool <- subset(ATKFinal, rownames(ATKFinal)=="PossessFallingDust")$CoolTime * 1000
  P_SSNCool <- subset(ATKFinal, rownames(ATKFinal)=="PossessExecuteSneakySniping")$CoolTime * 1000
  E_TNCool <- subset(ATKFinal, rownames(ATKFinal)=="ExecuteTearingKnife")$CoolTime * 1000
  E_CSCool <- subset(ATKFinal, rownames(ATKFinal)=="ExecuteChainSickle")$CoolTime * 1000
  E_PNCool <- subset(ATKFinal, rownames(ATKFinal)=="ExecutePoisonNeedlePre")$CoolTime * 1000
  CSCool <- subset(ATKFinal, rownames(ATKFinal)=="ChasingShot")$CoolTime * 1000
  SSNCool <- subset(ATKFinal, rownames(ATKFinal)=="SneakySniping")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000
  
  P_SARemain <- 0 ; P_SSRemain <- 0 ; P_SBRemain <- 0 ; P_FDRemain <- 0 ; P_SSNRemain <- 0 
  E_TNRemain <- 0 ; E_CSRemain <- 0 ; E_PNRemain <- 0
  CSRemain <- 0 ; SSNRemain <- 0 ; SCRemain <- 0
  
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
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        }
      }
      ## Soul Contract, Restraint 4
      if(SCRemain == 0 & DealCycle$ThanatosDescent[nrow(DealCycle)] > 0 & DealCycle$CriticalReinforce[nrow(DealCycle)] - DealCycle$Time[1] <= 16000)  {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      } 
      else if(SCRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) * 2 > nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink"))) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
      }
      ## Thanatos Descent (End)
      else if(nrow(subset(DealCycle, DealCycle$Skills=="ThanatosDescent")) > nrow(subset(DealCycle, DealCycle$Skills=="ThanatosDescentEndPre")) & 
              DealCycle$CriticalReinforce[nrow(DealCycle)] - DealCycle$Time[1] < 5000) {
        DealCycle <- DCATK(DealCycle, "ThanatosDescentEndPre", ATKFinal)
        DealCycle$ThanatosDescent[nrow(DealCycle)] <- 0
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        for(i in 1:9) {
          DealCycle <- DCATK(DealCycle, "ThanatosDescentEndTick", ATKFinal)
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "ThanatosDescentEndEnd", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Grip of Agony
      else if(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="GripofAgony"))) {
        DealCycle <- DCATK(DealCycle, "GripofAgony", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Execute Skills (Without Phantom Blade)
      ## [Possess / Execute] Sneaky Sniping
      else if(DealCycle$DeathBlessingStack[nrow(DealCycle)] > 0 & P_SSNRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) >= 1) {
        DealCycle <- DCATK(DealCycle, "PossessExecuteSneakySniping", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNCool - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Execute] Fatal Blitz
      else if(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="ExecuteFatalBlitzPre")) & 
              DealCycle$DeathBlessingStack[nrow(DealCycle)] >= 13 & DealCycle$DeathBlessingStack[nrow(DealCycle)] <= 14) {
        DealCycle <- DCATK(DealCycle, "ExecuteFatalBlitzPre", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        for(i in 1:14) {
          DealCycle <- DCATK(DealCycle, "ExecuteFatalBlitzTick", ATKFinal)
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "ExecuteFatalBlitzEnd", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Execute] Poison Needle
      else if(DealCycle$DeathBlessingStack[nrow(DealCycle)] > 0 & E_PNRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + E_PNCool < TotalTime + 5000) {
        DealCycle <- DCATK(DealCycle, "ExecutePoisonNeedlePre", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNCool - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "ExecutePoisonNeedleLoop", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "ExecutePoisonNeedleEnd", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Execute] Chain Sickle
      else if(DealCycle$DeathBlessingStack[nrow(DealCycle)] > 0 & E_CSRemain==0) {
        DealCycle <- DCATK(DealCycle, "ExecuteChainSickle", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSCool - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "ExecuteChainSickleAdd", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Execute] Tearing Knife
      else if(DealCycle$DeathBlessingStack[nrow(DealCycle)] > 0 & E_TNRemain==0) {
        DealCycle <- DCATK(DealCycle, "ExecuteTearingKnife", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNCool - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Sneaky Sniping
      else if(SSNRemain==0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) >= 1) {
        DealCycle <- DCATK(DealCycle, "SneakySniping", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNCool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Possess Skills
      ## [Possess] Dragon Burst
      else if(nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="PossessDragonBurstPre"))) {
        DealCycle <- DCATK(DealCycle, "PossessDragonBurstPre", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        for(i in 1:15) {
          DealCycle <- DCATK(DealCycle, "PossessDragonBurstTick", ATKFinal)
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "PossessDragonBurstEnd", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Possess] Falling Dust
      else if(DealCycle$MaliceGauge[nrow(DealCycle)] >= 100 & P_FDRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + P_FDCool < TotalTime + 5000) {
        DealCycle <- DCBuff(DealCycle, "Possession", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "PossessFallingDust", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDCool - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Possess] Shaft Break
      else if(DealCycle$MaliceGauge[nrow(DealCycle)] >= 100 & P_SBRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + P_SBCool < TotalTime + 5000) {
        DealCycle <- DCBuff(DealCycle, "Possession", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "PossessShaftBreak", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBCool - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Possess] Scattering Shot
      else if(DealCycle$MaliceGauge[nrow(DealCycle)] >= 100 & P_SSRemain==0) {
        DealCycle <- DCBuff(DealCycle, "Possession", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "PossessScatteringShot", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSCool - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Execute] Phantom Blade
      else if(DealCycle$DeathBlessingStack[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "ExecutePhantomBlade", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## [Possess] Strike Arrow
      else if(DealCycle$MaliceGauge[nrow(DealCycle)] >= 100 & P_SARemain==0) {
        DealCycle <- DCBuff(DealCycle, "Possession", BuffFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "PossessStrikeArrow", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SACool - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Normal Skills
      ## Chasing Shot
      else if(CSRemain==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + CSCool < TotalTime + 5000) {
        DealCycle <- DCATK(DealCycle, "ChasingShot", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSCool - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Scattering Shot
      else if(DealCycle$ScatteringShotStack[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "ScatteringShot", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Falling Dust
      else if(DealCycle$FallingDustStack[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "FallingDust", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Shaft Break
      else if(DealCycle$ShaftBreakStack[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "ShaftBreak", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
      ## Strike Arrow
      else {
        DealCycle <- DCATK(DealCycle, "StrikeArrow", ATKFinal)
        DealCycle <- KainStack(DealCycle)
        P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
        P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
        P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
        P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
        P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
        E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
        E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
        E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- KainStack(DealCycle)
          P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
          P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
          P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
          P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
          P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
          E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
          E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
          E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        }
      }
    }
  }
  while(max(P_SSNRemain - min(subset(DealCycle, DealCycle$Skills=="PossessExecuteSneakySniping")$Time), 
            SSNRemain - min(subset(DealCycle, DealCycle$Skills=="SneakySniping")$Time)) > 0) {
    ## Scattering Shot
    if(DealCycle$ScatteringShotStack[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "ScatteringShot", ATKFinal)
      DealCycle <- KainStack(DealCycle)
      P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
      P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
      P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
      P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
      P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
      E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
      E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
      E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
      CSRemain <- max(0, CSRemain - DealCycle$Time[1])
      SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    }
    ## Falling Dust
    else if(DealCycle$FallingDustStack[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "FallingDust", ATKFinal)
      DealCycle <- KainStack(DealCycle)
      P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
      P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
      P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
      P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
      P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
      E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
      E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
      E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
      CSRemain <- max(0, CSRemain - DealCycle$Time[1])
      SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    }
    ## Shaft Break
    else if(DealCycle$ShaftBreakStack[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "ShaftBreak", ATKFinal)
      DealCycle <- KainStack(DealCycle)
      P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
      P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
      P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
      P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
      P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
      E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
      E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
      E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
      CSRemain <- max(0, CSRemain - DealCycle$Time[1])
      SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    }
    ## Strike Arrow
    else {
      DealCycle <- DCATK(DealCycle, "StrikeArrow", ATKFinal)
      DealCycle <- KainStack(DealCycle)
      P_SARemain <- max(0, P_SARemain - DealCycle$Time[1])
      P_SSRemain <- max(0, P_SSRemain - DealCycle$Time[1])
      P_SBRemain <- max(0, P_SBRemain - DealCycle$Time[1])
      P_FDRemain <- max(0, P_FDRemain - DealCycle$Time[1])
      P_SSNRemain <- max(0, P_SSNRemain - DealCycle$Time[1])
      E_TNRemain <- max(0, E_TNRemain - DealCycle$Time[1])
      E_CSRemain <- max(0, E_CSRemain - DealCycle$Time[1])
      E_PNRemain <- max(0, E_PNRemain - DealCycle$Time[1])
      CSRemain <- max(0, CSRemain - DealCycle$Time[1])
      SSNRemain <- max(0, SSNRemain - DealCycle$Time[1])
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    }
  }
  
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
KainAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Scattering Shot, [Possess] Scattering Shot Add ATK
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ScatteringShot", "PossessScatteringShot"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "After", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Shaft Break, [Possess] Shaft Break Add ATK, Tornado
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ShaftBreak"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ShaftBreakExplosion"
    } else if(sum(DealCycle$Skills[i]==c("PossessShaftBreak"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "PossessShaftBreakExplosion"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "PossessShaftBreakTornado"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "PossessShaftBreakTornado", 12, 1500, ATKFinal)
  
  
  ## [Possess] Falling Dust
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("PossessFallingDust"))>=1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "Add", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## [Execute] Poison Needle
  DealCycle <- RepATKCycle(DealCycle, "ExecutePoisonNeedleLoop", 4, 0, ATKFinal)
  
  
  ## Spider In Mirror, Guided Arrow
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "GuidedArrow", SummonedFinal)
  
  
  ## Remain Incense
  IncenseStack <- 0 ; IncenseRemain <- 0
  StackSkills <- c("PossessStrikeArrow", "PossessScatteringShot", "PossessShaftBreak", "PossessFallingDust", "PossessExecuteSneakySniping", 
                   "PossessDragonBurstTick", "ThanatosDescentEndTick")
  Stacks <- c(1, 2, 6, 8, 8, 1, 2)
  RemainIncenseStack <- data.frame(StackSkills=StackSkills, Stacks=Stacks)
  for(i in 2:nrow(DealCycle)) {
    IncenseRemain <- max(0, IncenseRemain - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    if(sum(DealCycle$Skills[i]==c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", 
                                  "FallingDust", "PossessFallingDust", "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                                  "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                                  "ExecuteFatalBlitzTick")) >= 1 & IncenseStack > 0) {
      for(j in 1:IncenseStack) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "RemainIncense"
      }
      IncenseStack <- 0
    }
    if(sum(DealCycle$Skills[i]==c("PossessStrikeArrow", "PossessScatteringShot", "PossessShaftBreak", "PossessFallingDust", "PossessExecuteSneakySniping", 
                                  "PossessDragonBurstTick", "ThanatosDescentEndTick")) >= 1 & IncenseRemain==0) {
      IncenseStack <- IncenseStack + RemainIncenseStack[RemainIncenseStack$StackSkills==DealCycle$Skills[i], ]$Stacks
      IncenseRemain <- 300
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Dragon Fang
  DragonFangSubTime <- 3000 + 750 * 2 + subset(ATKFinal, rownames(ATKFinal)=="DragonFang")$SubTime * 6
  
  time <- DragonFangSubTime + 1
  for(i in 2:nrow(DealCycle)) {
    if(time > DragonFangSubTime & max(DealCycle$Skills[i]==c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", 
                                                             "FallingDust", "PossessFallingDust", "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                                                             "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                                                             "PossessDragonBurstTick", "ExecuteFatalBlitzTick"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle[nrow(DealCycle), 1] <- c("DragonFang")
      time <- DealCycle[i+1, 2] - DealCycle[i, 2]
    } else {
      time <- time + DealCycle[i+1, 2] - DealCycle[i, 2]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "DragonFang", 7, 750, ATKFinal)
  
  
  ## Grip of Agony
  StackSkills <- c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", "FallingDust", "PossessFallingDust", 
                   "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                   "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                   "DragonFang", "DeathBlessing", "DeathBlessingIncanation", "RemainIncense", 
                   "PossessDragonBurstTick", "ExecuteFatalBlitzTick", "ThanatosDescentAddATK", "ThanatosDescentEndTick", "GuidedArrow")
  Stacks <- c(1, 1, 5, 5, 2, 2, 1, 1, 2, 
              3, 5, 5, 
              1, 1, 1, 1, 1, 1, 
              1, 1, 1, 1, 
              1, 1, 1, 1, 1)
  AgonyStack <- data.frame(StackSkills=StackSkills, Stacks=Stacks)
  DealCycle$AgonyStack[2] <- 125
  for(i in 3:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", "FallingDust", "PossessFallingDust", 
                                  "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                                  "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                                  "DragonFang", "DeathBlessing", "DeathBlessingIncanation", "RemainIncense", 
                                  "PossessDragonBurstTick", "ExecuteFatalBlitzTick", "ThanatosDescentAddATK", "ThanatosDescentEndTick", "GuidedArrow")) >= 1) {
      DealCycle$AgonyStack[i] <- min(125, DealCycle$AgonyStack[i-1] + AgonyStack[AgonyStack$StackSkills==DealCycle$Skills[i], ]$Stacks)
    } else {
      DealCycle$AgonyStack[i] <- DealCycle$AgonyStack[i-1]
    }
    if(sum(DealCycle$Skills[i-1]==c("GripofAgony")) >= 1) {
      DealCycle$AgonyStack[i] <- 0
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "GripofAgony", 25, 1080, ATKFinal)
  
  Start <- subset(DealCycle, DealCycle$Skills=="GripofAgonyStart")
  AgonyATK <- subset(DealCycle, DealCycle$Skills=="GripofAgony")
  Others <- subset(DealCycle, DealCycle$Skills!="GripofAgonyStart")
  Others <- subset(Others, Others$Skills!="GripofAgony")
  
  ATKPerStack <- c(12, 15, 18, 21, 25)
  ATKIdx <- c()
  for(i in 1:nrow(Start)) {
    Stack <- floor(Start$AgonyStack[i] / 25)
    ATKIdx <- c(ATKIdx, ((i-1)*25+1):((i-1)*25+ATKPerStack[Stack]))
  }
  AgonyATK <- AgonyATK[ATKIdx, ]
  DealCycle <- rbind(Start, AgonyATK, Others)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Thanatos Descent AddATK
  TD <- subset(DealCycle, DealCycle$Skills=="ThanatosDescent")
  Ind <- rownames(TD)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 3001
    while(p < Ind[i+1] & DealCycle$ThanatosDescent[p] > 0) {
      if(time > 3000 & max(DealCycle$Skills[p]==c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", 
                                                  "FallingDust", "PossessFallingDust", "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                                                  "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                                                  "PossessDragonBurstTick", "ExecuteFatalBlitzTick", 
                                                  "GuidedArrow", "GripofAgony"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("ThanatosDescentAddATK")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Prior Preperation
  StackSkills <- c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", "FallingDust", "PossessFallingDust", 
                   "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                   "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                   "DragonFang", "DeathBlessing", "DeathBlessingIncanation", "RemainIncense", 
                   "PossessDragonBurstTick", "ExecuteFatalBlitzTick", "ThanatosDescentAddATK", "ThanatosDescentEndTick", "GripofAgony", "GuidedArrow")
  Stacks <- c(1, 1, 5, 5, 2, 2, 1, 1, 2, 
              3, 5, 5, 
              1, 1, 1, 1, 1, 1, 
              1, 1, 1, 1, 
              1, 1, 1, 1, 1, 1)
  PPStack <- data.frame(StackSkills=StackSkills, Stacks=Stacks)
  for(i in 3:nrow(DealCycle)) {
    DealCycle$PriorPreperation[i] <- max(0, DealCycle$PriorPreperation[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    if(sum(DealCycle$Skills[i]==c("StrikeArrow", "PossessStrikeArrow", "ScatteringShot", "PossessScatteringShot", "ShaftBreak", "PossessShaftBreak", "PossessShaftBreakTornado", "FallingDust", "PossessFallingDust", 
                                  "ChasingShot", "SneakySniping", "PossessExecuteSneakySniping", 
                                  "ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", 
                                  "DragonFang", "DeathBlessing", "DeathBlessingIncanation", "RemainIncense", 
                                  "PossessDragonBurstTick", "ExecuteFatalBlitzTick", "ThanatosDescentAddATK", "ThanatosDescentEndTick", "GripofAgony", "GuidedArrow")) >= 1 & DealCycle$PriorPreperation[i] == 0) {
      DealCycle$PriorPreperationStack[i] <- min(25, DealCycle$PriorPreperationStack[i-1] + PPStack[PPStack$StackSkills==DealCycle$Skills[i], ]$Stacks)
    } else {
      DealCycle$PriorPreperationStack[i] <- DealCycle$PriorPreperationStack[i-1]
    } 
    if(DealCycle$PriorPreperationStack[i] == 25) {
      DealCycle$PriorPreperationStack[i] <- 0
      DealCycle$PriorPreperation[i] <- BuffFinal[rownames(BuffFinal)=="PriorPreperation", ]$CoolTime * 1000
    }
  }
  for(i in 2:nrow(DealCycle)) {
    DealCycle$PriorPreperation[i] <- max(0, DealCycle$PriorPreperation[i] - (BuffFinal[rownames(BuffFinal)=="PriorPreperation", ]$CoolTime - BuffFinal[rownames(BuffFinal)=="PriorPreperation", ]$Duration) * 1000)
  }
  
  
  ## Contribution Buff
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ExecutePhantomBlade", "ExecuteTearingKnife", "ExecuteChainSickle", "ExecuteChainSickleAdd", "ExecutePoisonNeedlePre", "ExecutePoisonNeedleLoop", "ExecutePoisonNeedleEnd", 
                                  "DeathBlessing", "DeathBlessingIncanation", "ExecuteFatalBlitzPre", "ExecuteFatalBlitzTick", "ExecuteFatalBlitzEnd")) == 0) {
      DealCycle$ContributionBuff[i] <- 0
    }
  }
  
  
  ## Strike Arrow Stack
  StrikeArrowStack <- 1 ; StrikeArrowTime <- 0
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("StrikeArrow", "PossessStrikeArrow")) >= 1) {
      StrikeArrowTime <- StrikeArrowTime + (DealCycle$Time[i] - DealCycle$Time[i-1])
      if(StrikeArrowTime >= 2000) {
        StrikeArrowStack <- 1
        StrikeArrowTime <- 0
      }
      if(StrikeArrowStack > 1 & DealCycle$Skills[i]=="StrikeArrow") {
        DealCycle$Skills[i] <- paste("StrikeArrow", StrikeArrowStack, sep="")
      }
      StrikeArrowStack <- StrikeArrowStack + 1
      StrikeArrowStack <- ifelse(StrikeArrowStack==4, 1, StrikeArrowStack)
      StrikeArrowTime <- 0
    } else {
      StrikeArrowTime <- StrikeArrowTime + (DealCycle$Time[i] - DealCycle$Time[i-1])
      if(StrikeArrowTime >= 2000) {
        StrikeArrowStack <- 1
        StrikeArrowTime <- 0
      }
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$MaliceGauge <- 0
  DealCycle$MaliceGaugeDummy <- 0
  DealCycle$Possession <- 0
  DealCycle$DeathBlessingStack <- 0
  DealCycle$ScatteringShotDummy <- 0
  DealCycle$ScatteringShotStack <- 0
  DealCycle$ShaftBreakDummy <- 0
  DealCycle$ShaftBreakStack <- 0
  DealCycle$FallingDustDummy <- 0
  DealCycle$FallingDustStack <- 0
  DealCycle$PriorPreperationStack <- 0
  DealCycle$AgonyStack <- 0
  
  return(DealCycle)
}

KainDealCycle <- KainCycle(KainDealCycle, 
                           ATKFinal, 
                           BuffFinal, 
                           SummonedFinal, 
                           KainSpec, 
                           180, 360)
KainDealCycle <- DealCycleFinal(KainDealCycle)
KainDealCycle <- KainAddATK(KainDealCycle, 
                            ATKFinal,
                            BuffFinal, 
                            SummonedFinal,
                            KainSpec)
KainDealCycleReduction <- DealCycleReduction(KainDealCycle)


Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Kain") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  KainSpecOpt1 <- Optimization1(KainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KainSpec, KainUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- KainSpecOpt1[1, 1:3]
} else {
  KainSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
KainSpecOpt <- OptDataAdd(KainSpec, KainSpecOpt1, "Potential", KainBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  KainSpecOpt2 <- Optimization2(KainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KainSpecOpt, KainHyperStatBase, KainBase$ChrLv, KainBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- KainSpecOpt2[1, ]
} else {
  KainSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
KainSpecOpt <- OptDataAdd(KainSpecOpt, KainSpecOpt2, "HyperStat", KainBase$CRROver, DemonAvenger=F)
BuffFinal <- CriReinAdj(KainSpec, KainSpecOpt, BuffFinal, GetCoreLv(KainCore, "CriticalReinforce"))

KainFinalDPM <- DealCalc(KainDealCycle, ATKFinal, BuffFinal, SummonedFinal, KainSpecOpt, Collapse=F)
KainFinalDPMwithMax <- DealCalcWithMaxDMR(KainDealCycle, ATKFinal, BuffFinal, SummonedFinal, KainSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Kain", sum(na.omit(KainFinalDPMwithMax)) / (max(KainDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Kain", sum(na.omit(KainFinalDPM)) / (max(KainDealCycle$Time) / 60000) - sum(na.omit(KainFinalDPMwithMax)) / (max(KainDealCycle$Time) / 60000))

KainDealRatio <- DealRatio(KainDealCycle, KainFinalDPMwithMax)

KainDealData <- data.frame(KainDealCycle$Skills, KainDealCycle$Time, KainDealCycle$Restraint4, KainFinalDPMwithMax)
colnames(KainDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Kain", Deal_RR(KainDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Kain", Deal_40s(KainDealData, F, StartTime=subset(KainDealData, KainDealData$Skills=="ChasingShot")$Time[1]))

KainSpecMean <- SpecMean("Kain", KainDealCycleReduction, 
                         DealCalcWithMaxDMR(KainDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, KainSpecOpt), 
                         ATKFinal, BuffFinal, SummonedFinal, KainSpecOpt)