## Mercedes - Data
## Mercedes - VMatrix
MercedesCoreBase <- CoreBuilder(ActSkills=c("ElementalGhost", "BreathofIrkalla", "RoyalKnights",
                                            CommonV("Bowman", "Heroes")), 
                                ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25), 
                                UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                SpecSet=get(DPMCalcOption$SpecSet), 
                                VPassiveList=MercedesVPassive, 
                                VPassivePrior=MercedesVPrior, 
                                SelfBind=F)

MercedesCore <- MatrixSet(PasSkills=MercedesCoreBase$PasSkills$Skills, 
                          PasLvs=MercedesCoreBase$PasSkills$Lv, 
                          PasMP=MercedesCoreBase$PasSkills$MP, 
                          ActSkills=MercedesCoreBase$ActSkills$Skills, 
                          ActLvs=MercedesCoreBase$ActSkills$Lv, 
                          ActMP=MercedesCoreBase$ActSkills$MP, 
                          UsefulSkills=MercedesCoreBase$UsefulSkills, 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          SpecialCore=MercedesCoreBase$SpecialCoreUse)


## Mercedes - Basic Info
MercedesBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=get(DPMCalcOption$MobSet),
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        Job="Mercedes",
                        CoreData=MercedesCore, 
                        BuffDurationNeeded=0, 
                        AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Mercedes"), 
                        LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Mercedes"), 
                        MonsterLife=get(FindJob(MonsterLifePreSet, "Mercedes")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                        Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "DualBowgun", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                        WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                        SubWeapon=SubWeapon[rownames(SubWeapon)=="MagicArrow", ], 
                        Emblem=Emblem[rownames(Emblem)=="Heroes", ], 
                        CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Mercedes")))


## Mercedes - Passive
{option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
ElfQueen <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20)
PotentialPower <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(40)
SharpAiming <- data.frame(option, value)

option <- factor(c("BDR", "CRR"), levels=PSkill)
value <- c(30, 15)
SpiritInfusion <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("FDR", "ATK"), levels=PSkill)
value <- c(15, 40)
IgnisRoar <- data.frame(option, value)

option <- factor(c("CDMR", "ATK", "Mastery"), levels=PSkill)
value <- c(10 + ceiling(MercedesBase$PSkillLv/3), 30 + MercedesBase$PSkillLv, 70 + ceiling(MercedesBase$PSkillLv/2))
DualBowgunExpert <- data.frame(option, value)

option <- factor(c("IGR", "FDR", "BDR", "CDMR"), levels=PSkill)
value <- c(25 + MercedesBase$PSkillLv, 20 + MercedesBase$PSkillLv, 20, 20)
DefenceBreak <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20 + ceiling(MercedesBase$PSkillLv/2))
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(MercedesCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(MercedesCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

MercedesPassive <- Passive(list(ElfQueen=ElfQueen, PotentialPower=PotentialPower, SharpAiming=SharpAiming, SpiritInfusion=SpiritInfusion, 
                                PhysicalTraining=PhysicalTraining, IgnisRoar=IgnisRoar, DualBowgunExpert=DualBowgunExpert, DefenceBreak=DefenceBreak, 
                                AdvancedFinalAttack=AdvancedFinalAttack, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## Mercedes - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DualBowgunBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WaterShield <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(15, 16, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IgnisRoarStack <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(30)
info <- c(30, 31, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UnicornSpikeDebuff <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(50 + MercedesBase$SkillLv)
info <- c(30, 31, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LegendrySpearDebuff <- rbind(data.frame(option, value), info)

option <- factor("ATKP", levels=BSkill)
value <- c(30 + MercedesBase$SkillLv)
info <- c(200 + 5 * MercedesBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AncientSpirit <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MercedesBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MercedesBase$SkillLv/2))))
info <- c(900 + 30 * MercedesBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(80)
info <- c(60, 90, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElfishBlessing <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(MercedesCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + GetCoreLv(MercedesCore, "ElementalGhost"), 150, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementalGhost <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 150, 1680, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RoyalKnights <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info) ## Update Needed

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(MercedesCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * MercedesBase$MainStatP), 5 + floor(GetCoreLv(MercedesCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SkipDummy <- rbind(data.frame(option, value), info)}

MercedesBuff <- list(DualBowgunBooster=DualBowgunBooster, WaterShield=WaterShield, IgnisRoarStack=IgnisRoarStack, 
                     UnicornSpikeDebuff=UnicornSpikeDebuff, LegendrySpearDebuff=LegendrySpearDebuff, AncientSpirit=AncientSpirit, MapleSoldier=MapleSoldier, 
                     HeroesOath=HeroesOath, ElfishBlessing=ElfishBlessing, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                     ElementalGhost=ElementalGhost, RoyalKnights=RoyalKnights, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, SkipDummy=SkipDummy,
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## Petbuff : UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), DualBowgunBooster(600ms), WaterShield(990ms), AncientSpirit(1080ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  MercedesBuff[[length(MercedesBuff)+1]] <- UsefulAdvancedBless
  names(MercedesBuff)[[length(MercedesBuff)]] <- "UsefulAdvancedBless"
}
MercedesBuff <- Buff(MercedesBuff)
MercedesAllTimeBuff <- AllTimeBuff(MercedesBuff)


## Mercedes - Union & HyperStat & SoulWeapon
MercedesSpec <- JobSpec(JobBase=MercedesBase, 
                        Passive=MercedesPassive, 
                        AllTimeBuff=MercedesAllTimeBuff, 
                        MobInfo=get(DPMCalcOption$MobSet), 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        WeaponName="DualBowgun", 
                        UnionStance=0)

MercedesUnionRemained <- MercedesSpec$UnionRemained
MercedesHyperStatBase <- MercedesSpec$HyperStatBase
MercedesCoolReduceType <- MercedesSpec$CoolReduceType
MercedesSpec <- MercedesSpec$Spec


## Mercedes - Critical Reinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(MercedesSpec$CRR * (0.2 + 0.01 * GetCoreLv(MercedesCore, "CriticalReinforce")))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}
MercedesBuff <- list(DualBowgunBooster=DualBowgunBooster, WaterShield=WaterShield, IgnisRoarStack=IgnisRoarStack, 
                     UnicornSpikeDebuff=UnicornSpikeDebuff, LegendrySpearDebuff=LegendrySpearDebuff, AncientSpirit=AncientSpirit, MapleSoldier=MapleSoldier, 
                     HeroesOath=HeroesOath, ElfishBlessing=ElfishBlessing, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                     ElementalGhost=ElementalGhost, RoyalKnights=RoyalKnights, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, SkipDummy=SkipDummy,
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  MercedesBuff[[length(MercedesBuff)+1]] <- UsefulAdvancedBless
  names(MercedesBuff)[[length(MercedesBuff)]] <- "UsefulAdvancedBless"
}
MercedesBuff <- Buff(MercedesBuff)


## Mercedes - Spider In Mirror
SIM <- SIMData(GetCoreLv(MercedesCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Mercedes - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "UnicornSpike")>=40, 20, 0), 3 * GetCoreLv(MercedesCore, "UnicornSpike"))
info <- c(345 + 100 + 2 * MercedesSpec$SkillLv, 5, 1290, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnicornSpike <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LeafTornado_GustDive")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "LeafTornado_GustDive"))
info <- c(260 + 130 + 3 * MercedesSpec$SkillLv, 4, 750, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LeafTornado <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LeafTornado_GustDive")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "LeafTornado_GustDive"))
info <- c(260 + 170 + 3 * MercedesSpec$SkillLv, 4, 1080, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GustDive <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LegendrySpear")>=40, 20, 0), 20, 2 * GetCoreLv(MercedesCore, "LegendrySpear"))
info <- c(700 + 10 * MercedesSpec$SkillLv, 3, 870, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LegendrySpear <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "RollingMoonsault")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "RollingMoonsault"))
info <- c(300 + 2 * MercedesSpec$SkillLv, 6, 840, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RollingMoonsault <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "BDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(GetCoreLv(MercedesCore, "RingofIshtar")>=40, 20, 0), 20)), 2 * GetCoreLv(MercedesCore, "RingofIshtar"), 20)
info <- c(220 + 1 * MercedesSpec$SkillLv, 2, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RingofIshtar <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack"))
info <- c(380, 4, 630, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedStrikeDualShot <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "WrathofEnlil")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "WrathofEnlil"))
info <- c(460, 10, 900, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WrathofEnlil <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 15 * GetCoreLv(MercedesCore, "ElementalGhost"), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElementalGhostTree <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 840, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkallaPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(MercedesCore, "BreathofIrkalla"), 8, 7660, 150, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkalla <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 270, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkallaEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(325 + 13 * GetCoreLv(MercedesCore, "RoyalKnights"), 16, 0, 1400, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoyalKnightsKnight <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack")>=40, 20, 0), MercedesBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack"))
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "UnicornSpike")>=40, 20, 0), 3 * GetCoreLv(MercedesCore, "UnicornSpike"))
info <- c((345 + 100 + 2 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 5 * 1.845, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnicornSpikeGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LeafTornado_GustDive")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "LeafTornado_GustDive"))
info <- c((260 + 130 + 3 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 4 * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LeafTornadoGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LeafTornado_GustDive")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "LeafTornado_GustDive"))
info <- c((260 + 170 + 3 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 4 * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GustDiveGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "LegendrySpear")>=40, 20, 0), 20, 2 * GetCoreLv(MercedesCore, "LegendrySpear"))
info <- c((700 + 10 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 3 * 1.845, 0, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LegendrySpearGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "RollingMoonsault")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "RollingMoonsault"))
info <- c((300 + 2 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 6 * 1.845, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RollingMoonsaultGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "BDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(GetCoreLv(MercedesCore, "RingofIshtar")>=40, 20, 0), 20)), 2 * GetCoreLv(MercedesCore, "RingofIshtar"), 20)
info <- c((220 + 1 * MercedesSpec$SkillLv) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 2 * 0.646875, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RingofIshtarGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack"))
info <- c(380 * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 4 * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedStrikeDualShotGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "WrathofEnlil")>=40, 20, 0), 2 * GetCoreLv(MercedesCore, "WrathofEnlil"))
info <- c(460 * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 10 * 1.845, 0, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WrathofEnlilGhost <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((400 + 16 * GetCoreLv(MercedesCore, "BreathofIrkalla")) * (0.3 + 0.01 * GetCoreLv(MercedesCore, "ElementalGhost")), 8 * 0.646875, 0, 150, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkallaGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack")>=40, 20, 0), MercedesBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack"))
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv) * 0.646875, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackIshtarGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack")>=40, 20, 0), MercedesBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(MercedesCore, "AdvancedStrikeDualShot_AdvancedFinalAttack"))
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv) * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackEnlilGhost <- rbind(data.frame(option, value), info)}

MercedesATK <- Attack(list(UnicornSpike=UnicornSpike, LeafTornado=LeafTornado, GustDive=GustDive, 
                           LegendrySpear=LegendrySpear, RingofIshtar=RingofIshtar, AdvancedStrikeDualShot=AdvancedStrikeDualShot, RollingMoonsault=RollingMoonsault, WrathofEnlil=WrathofEnlil, 
                           ElementalGhostTree=ElementalGhostTree, BreathofIrkallaPre=BreathofIrkallaPre, BreathofIrkalla=BreathofIrkalla, BreathofIrkallaEnd=BreathofIrkallaEnd, 
                           RoyalKnightsKnight=RoyalKnightsKnight, AdvancedFinalAttack=AdvancedFinalAttack, 
                           UnicornSpikeGhost=UnicornSpikeGhost, LeafTornadoGhost=LeafTornadoGhost, GustDiveGhost=GustDiveGhost,
                           LegendrySpearGhost=LegendrySpearGhost, RollingMoonsaultGhost=RollingMoonsaultGhost, RingofIshtarGhost=RingofIshtarGhost, AdvancedStrikeDualShotGhost=AdvancedStrikeDualShotGhost, 
                           WrathofEnlilGhost=WrathofEnlilGhost, BreathofIrkallaGhost=BreathofIrkallaGhost, AdvancedFinalAttackIshtarGhost=AdvancedFinalAttackIshtarGhost, AdvancedFinalAttackEnlilGhost=AdvancedFinalAttackEnlilGhost, 
                           SpiderInMirror=SpiderInMirror))


## Mercedes - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * GetCoreLv(MercedesCore, "ElementalKnight"), ifelse(GetCoreLv(MercedesCore, "ElementalKnight")>=40, 20, 0))
info <- c(385, 4/3, 0, 1500, 210, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ElementalKnightIF <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * GetCoreLv(MercedesCore, "ElementalKnight"), ifelse(GetCoreLv(MercedesCore, "ElementalKnight")>=40, 20, 0))
info <- c(485, 2/3, 0, 1500, 210, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ElementalKnightD <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(MercedesCore, "GuidedArrow"), 1, 720, 500, 0.5 * 89 + 0.72 + 0.01, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

MercedesSummoned <- Summoned(list(ElementalKnightIF=ElementalKnightIF, ElementalKnightD=ElementalKnightD, GuidedArrow=GuidedArrow, SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Mercedes - DealCycle & Deal Calculation
ATKFinal <- data.frame(MercedesATK)
ATKFinal$Delay[c(-3, -5, -10, -11, -12)] <- Delay(ATKFinal$Delay, MercedesSpec$ATKSpeed)[c(-3, -5, -10, -11, -12)]
ATKFinal$Delay[3] <- Delay(ATKFinal$Delay[3], 4)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)

BuffFinal <- data.frame(MercedesBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MercedesSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(MercedesSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MercedesSpec$SummonedDuration / 100, 0)


## Mercedes - Delay Skip Structure
MercedesSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
MercedesSkipATK <- data.frame(MercedesSkipATK, row.names=c(rownames(ATKFinal)))
colnames(MercedesSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

MercedesSkipATK$UnicornSpike <- c(F, F, T, F, F, T, F, T, rep(F, 18))
MercedesSkipATK$LeafTornado <- c(F, F, F, T, F, F, T, F, rep(F, 18))
MercedesSkipATK$GustDive <- c(F, T, F, T, F, F, T, F, rep(F, 18))
MercedesSkipATK$LegendrySpear <- c(T, T, T, F, F, T, T, T, rep(F, 18))
MercedesSkipATK$AdvancedStrikeDualShot <- c(T, F, T, F, F, F, F, T, rep(F, 18))
MercedesSkipATK$RollingMoonsault <- c(F, T, F, T, F, F, F, F, rep(F, 18))
MercedesSkipATK$WrathofEnlil <- c(T, T, T, T, F, T, T, F, rep(F, 18))
MercedesSkipATK$SkippedDelay <- c(Delay(600, MercedesSpec$ATKSpeed), Delay(480, MercedesSpec$ATKSpeed), Delay(540, 4), 
                                  Delay(870, MercedesSpec$ATKSpeed), 0, Delay(450, MercedesSpec$ATKSpeed), Delay(630, MercedesSpec$ATKSpeed), Delay(270, MercedesSpec$ATKSpeed), rep(0, 18))
MercedesSkipATK <- subset(MercedesSkipATK, MercedesSkipATK$SkippedDelay>0)


## Mercedes - DealCycle
DealCycle <- c("Skills", "Time", rownames(MercedesBuff))
MercedesDealCycle <- t(rep(0, length(DealCycle)))
colnames(MercedesDealCycle) <- DealCycle
MercedesDealCycle <- data.frame(MercedesDealCycle)

MercedesCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, 
                          Period=c(150, 180), CycleTime, SummonSkillPeriod, CycleType=c("Default", "UseGustDive", "NotUseGustDive")) {
  BuffSummonedPrior <- c("DualBowgunBooster", "WaterShield", "AncientSpirit", "MapleSoldier", "UsefulCombatOrders", "UsefulSharpEyes", "UsefulAdvancedBless", 
                         "HeroesOath", "ElementalKnightIF", "ElementalKnightD", "GuidedArrow",
                         "ElfishBlessing", "MapleWarriors2", "ElementalGhost", "RoyalKnights", "SoulContractLink", "CriticalReinforce", "Restraint4")
  Times150 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2.5, 1, 0.5, 1, 1, 1, 1, 0.5)
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 1, 1, 1, 1, 2, 1, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times150 <- Times150[BuffSummonedPrior!="UsefulAdvancedBless"]
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100), length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100)
  for(i in 1:length(BuffSummonedPrior)) {
    if(Period==150) {
      SubTime[i] <- SubTime[i] / ifelse(Times150[i]==0, Inf, Times150[i])
    } else if(Period==180) {
      SubTime[i] <- SubTime[i] / ifelse(Times180[i]==0, Inf, Times180[i])
    }
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
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
    }
  }
  DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c() ; NoSubTimeSummoned <- c()
  for(i in 1:length(NoSubTime)) {
    if(sum(NoSubTime[i]==SummonSkillPeriod$Skills) > 0) {
      NoSubTimeSummoned <- c(NoSubTimeSummoned, NoSubTime[i])
    } else {
      NoSubTimeBuff <- c(NoSubTimeBuff, NoSubTime[i])
    }
  }
  ColNums <- c()
  for(i in 1:length(NoSubTimeBuff)) {
    for(j in 1:length(colnames(DealCycle))) {
      if(NoSubTimeBuff[i]==colnames(DealCycle)[j]) {
        ColNums[i] <- j
      }
    }
  }
  DebuffDummy <- 0 ; IgnisDummy <- 0
  IrkallaSubTime <- Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
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
          IgnisDummy <- ifelse(IgnisDummy==0, 0, IgnisDummy + DealCycle$Time[1])
          IgnisDummy <- ifelse(IgnisDummy >= 7000 | CycleType == "Default" & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 5500 | 
                                 DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & sum(CycleType==c("UseGustDive", "NotUseGustDive"))==1, 0, IgnisDummy)
        }
      }
      for(i in 1:nrow(SummonSkillPeriod)) {
        if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= 
           max(subset(DealCycle, DealCycle$Skills==paste(SummonSkillPeriod$Skills[i], "Summoned", sep=""))$Time) + SummonSkillPeriod$Period[i] * 1000) {
          DealCycle <- DCSummoned(DealCycle, SummonSkillPeriod$Skills[i], SummonedFinal)
          IgnisDummy <- ifelse(IgnisDummy==0, 0, IgnisDummy + DealCycle$Time[1])
          IgnisDummy <- ifelse(IgnisDummy >= 7000 | CycleType == "Default" & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 5500 | 
                                 DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & sum(CycleType==c("UseGustDive", "NotUseGustDive"))==1, 0, IgnisDummy)
        }
      }
      if(DebuffDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCATKSkip(DealCycle, "UnicornSpike", ATKFinal, SkipStructure)
        DealCycle$UnicornSpikeDebuff[nrow(DealCycle)] <- 30000
        DealCycle <- DCATKSkip(DealCycle, "LegendrySpear", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$LegendrySpearDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DebuffDummy <- 4
        IgnisDummy <- DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1]
      }
      if(IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & sum(BuffList[[k]]=="CriticalReinforce") == 0 | 
         IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & sum(BuffList[[k]]=="CriticalReinforce") > 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffEndTime - 7000) {
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DebuffDummy <- DebuffDummy - 1
        IgnisDummy <- IgnisDummy + DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1]
      }
      if(IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & CycleType == "Default" | 
         IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] > 0 & CycleType == "UseGustDive") {
        DealCycle <- DCATKSkip(DealCycle, "UnicornSpike", ATKFinal, SkipStructure)
        DealCycle$UnicornSpikeDebuff[nrow(DealCycle)] <- 30000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LegendrySpear", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$LegendrySpearDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DebuffDummy <- 3
        IgnisDummy <- IgnisDummy + DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1] + 
          ifelse(DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 3500 & CycleType == "Default", DealCycle$Time[nrow(DealCycle)-1] - DealCycle$Time[nrow(DealCycle)-4], 0)
      }
      if(IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & CycleType == "UseGustDive") {
        if(DealCycle$Skills[nrow(DealCycle)]=="GuidedArrowSummoned") {
          DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        }
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        if(sum(DealCycle$Skills[nrow(DealCycle)-1]==c("AdvancedStrikeDualShot", "LeafTornado", "UnicornSpike", "GustDive", "LegendrySpear", "RollingMoonsault"))==1) {
          DealCycle$SkipDummy[nrow(DealCycle)] <- 1
          DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        }
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "UnicornSpike", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$UnicornSpikeDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LegendrySpear", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$LegendrySpearDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "GustDive", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DebuffDummy <- 3
        IgnisDummy <- ifelse(DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0, 0, IgnisDummy + DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1])
      }
      if(IgnisDummy==0 & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & CycleType == "NotUseGustDive") {
        DealCycle <- DCATKSkip(DealCycle, "UnicornSpike", ATKFinal, SkipStructure)
        if(sum(DealCycle$Skills[nrow(DealCycle)-1]==c("AdvancedStrikeDualShot", "GustDive", "WrathofEnlil"))==1) {
          DealCycle$SkipDummy[nrow(DealCycle)] <- 1
          DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        }
        DealCycle$UnicornSpikeDebuff[nrow(DealCycle)] <- 30000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LegendrySpear", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$LegendrySpearDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LeafTornado", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "RollingMoonsault", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LeafTornado", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "LegendrySpear", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$LegendrySpearDebuff[nrow(DealCycle)] <- 30000
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        DebuffDummy <- 3
        IgnisDummy <- ifelse(DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0, 0, IgnisDummy + DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1])
      }
      if(nrow(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre"))==0) {
        DealCycle <- DCATK(DealCycle, "BreathofIrkallaPre", ATKFinal)
        DealCycle <- DCATK(DealCycle, "BreathofIrkalla", ATKFinal)
        DealCycle <- DCATK(DealCycle, "BreathofIrkallaEnd", ATKFinal)
        DebuffDummy <- DebuffDummy - 1
        IgnisDummy <- 0
      }
      if(nrow(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre")) > 0) {
        if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre")$Time) > IrkallaSubTime * 1000) {
          DealCycle <- DCATK(DealCycle, "BreathofIrkallaPre", ATKFinal)
          DealCycle <- DCATK(DealCycle, "BreathofIrkalla", ATKFinal)
          DealCycle <- DCATK(DealCycle, "BreathofIrkallaEnd", ATKFinal)
          DebuffDummy <- DebuffDummy - 1
          IgnisDummy <- 0
        }
      }
      if(subset(SkipStructure, rownames(SkipStructure)=="UnicornSpike")$SkippedDelay + 
         subset(SkipStructure, rownames(SkipStructure)=="LegendrySpear")$SkippedDelay + IgnisDummy >= 7000 & DebuffDummy == 1 & 
         DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DebuffDummy <- DebuffDummy - 1
      }
      if(DebuffDummy != 0 & IgnisDummy != 0) {
        DealCycle <- DCATK(DealCycle, "RingofIshtar", ATKFinal)
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- DealCycle$IgnisRoarStack[nrow(DealCycle)] + 100
        IgnisDummy <- IgnisDummy + 120
        IgnisDummy <- ifelse(DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & IgnisDummy >= 7000, 0, 
                             ifelse(DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 5500 & CycleType == "Default" | 
                                      DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 7000 & CycleType == "UseGustDive", 0, IgnisDummy))
        IgnisDummy <- ifelse(sum(BuffList[[k]]=="CriticalReinforce") > 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= BuffEndTime - 7000, 7000, IgnisDummy)
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          IgnisDummy <- ifelse(IgnisDummy==0, 0, IgnisDummy + DealCycle$Time[1])
          IgnisDummy <- ifelse(IgnisDummy >= 7000 | CycleType == "Default" & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 5500 | 
                                 DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & sum(CycleType==c("UseGustDive", "NotUseGustDive"))==1, 0, IgnisDummy)
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          IgnisDummy <- ifelse(IgnisDummy==0, 0, IgnisDummy + DealCycle$Time[1])
          IgnisDummy <- ifelse(IgnisDummy >= 7000 | CycleType == "Default" & DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & IgnisDummy >= 5500 | 
                                 DealCycle$ElementalGhost[nrow(DealCycle)] - DealCycle$Time[1] > 0 & sum(CycleType==c("UseGustDive", "NotUseGustDive"))==1, 0, IgnisDummy)
        }
      }
    }
  }
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
MercedesAddATK <- function(DealCycle) {
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ElementalKnightIF", "ElementalKnightD", "GuidedArrow")) > 0 & DealCycle$SkipDummy[i] > 0) {
      DealCycle$SkipDummy[i] <- 0
    }
  }
  
  GhostCoolDown <- 0
  for(i in 1:(nrow(DealCycle)-1)) {
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LeafTornado", "GustDive", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "RollingMoonsault", "WrathofEnlil", 
                                  "BreathofIrkalla", "SpiderInMirror", "GuidedArrow")) > 0 & 
       DealCycle$ElementalGhost[i] > 0 & GhostCoolDown == 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ElementalGhostTree")
      GhostCoolDown <- 10000
    } else {
      if(DealCycle$SkipDummy[i]==1) {
        GhostCoolDown <- max(GhostCoolDown - 1000, 0)
      }
    }
    GhostCoolDown <- max(GhostCoolDown - (DealCycle$Time[i+1] - DealCycle$Time[i]), 0)
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  RoyalKnightsCoolDown <- 0
  for(i in 1:(nrow(DealCycle)-1)) {
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LeafTornado", "GustDive", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "RollingMoonsault", "WrathofEnlil", 
                                  "BreathofIrkalla", "SpiderInMirror", "GuidedArrow")) > 0 & 
       DealCycle$RoyalKnights[i] > 0 & RoyalKnightsCoolDown == 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("RoyalKnightsKnight")
      RoyalKnightsCoolDown <- 1400
    }
    RoyalKnightsCoolDown <- max(RoyalKnightsCoolDown - (DealCycle$Time[i+1] - DealCycle$Time[i]), 0)
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:(nrow(DealCycle)-1)) {
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LeafTornado", "GustDive", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "RollingMoonsault", "WrathofEnlil", "BreathofIrkalla")) > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
      if(DealCycle$ElementalGhost[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "Ghost", sep="")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LeafTornado", "GustDive", "LegendrySpear", "AdvancedStrikeDualShot", "RollingMoonsault", "WrathofEnlil")) > 0) {
          DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttackEnlilGhost")
        } else {
          DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttackIshtarGhost")
        }
      }
    }
  }
    DealCycle <- DealCycle[order(DealCycle$Time), ]
    rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}

  
MercedesDealCycle <- MercedesCycle(PreDealCycle = MercedesDealCycle, 
                                   ATKFinal = ATKFinal, 
                                   BuffFinal = BuffFinal, 
                                   SummonedFinal = SummonedFinal, 
                                   SkipStructure = MercedesSkipATK, 
                                   Spec = MercedesSpec, 
                                   Period = 180, 
                                   CycleTime = 360, 
                                   SummonSkillPeriod=data.frame(Skills=c("ElementalKnightIF", "ElementalKnightD"), Period=c(112.8, 112.8)), 
                                   CycleType="Default")
MercedesDealCycle <- DCSummonedATKs(MercedesDealCycle, Skill=c("GuidedArrow", "ElementalKnightIF", "ElementalKnightD"), SummonedFinal)
MercedesDealCycle <- RepATKCycle(MercedesDealCycle, c("BreathofIrkalla"), 52, 0, ATKFinal)
MercedesDealCycle <- MercedesAddATK(MercedesDealCycle)
MercedesDealCycle <- DCSpiderInMirror(MercedesDealCycle, SummonedFinal)
MercedesDealCycleReduction <- DealCycleReduction(MercedesDealCycle)

DealCycle <- c("Skills", "Time", rownames(MercedesBuff))
MercedesDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(MercedesDealCycle2) <- DealCycle
MercedesDealCycle2 <- data.frame(MercedesDealCycle2)

MercedesDealCycle2 <- MercedesCycle(PreDealCycle = MercedesDealCycle2, 
                                    ATKFinal = ATKFinal, 
                                    BuffFinal = BuffFinal, 
                                    SummonedFinal = SummonedFinal, 
                                    SkipStructure = MercedesSkipATK, 
                                    Spec = MercedesSpec, 
                                    Period = 180, 
                                    CycleTime = 360, 
                                    SummonSkillPeriod=data.frame(Skills=c("ElementalKnightIF", "ElementalKnightD"), Period=c(112.8, 112.8)), 
                                    CycleType="UseGustDive")
MercedesDealCycle2 <- DCSummonedATKs(MercedesDealCycle2, Skill=c("GuidedArrow", "ElementalKnightIF", "ElementalKnightD"), SummonedFinal)
MercedesDealCycle2 <- RepATKCycle(MercedesDealCycle2, c("BreathofIrkalla"), 52, 0, ATKFinal)
MercedesDealCycle2 <- MercedesAddATK(MercedesDealCycle2)
MercedesDealCycle2 <- DCSpiderInMirror(MercedesDealCycle2, SummonedFinal)

DealCycle <- c("Skills", "Time", rownames(MercedesBuff))
MercedesDealCycle3 <- t(rep(0, length(DealCycle)))
colnames(MercedesDealCycle3) <- DealCycle
MercedesDealCycle3 <- data.frame(MercedesDealCycle3)

MercedesDealCycle3 <- MercedesCycle(PreDealCycle = MercedesDealCycle3, 
                                    ATKFinal = ATKFinal, 
                                    BuffFinal = BuffFinal, 
                                    SummonedFinal = SummonedFinal, 
                                    SkipStructure = MercedesSkipATK, 
                                    Spec = MercedesSpec, 
                                    Period = 180, 
                                    CycleTime = 360, 
                                    SummonSkillPeriod=data.frame(Skills=c("ElementalKnightIF", "ElementalKnightD"), Period=c(112.8, 112.8)), 
                                    CycleType="NotUseGustDive")
MercedesDealCycle3 <- DCSummonedATKs(MercedesDealCycle3, Skill=c("GuidedArrow", "ElementalKnightIF", "ElementalKnightD"), SummonedFinal)
MercedesDealCycle3 <- RepATKCycle(MercedesDealCycle3, c("BreathofIrkalla"), 52, 0, ATKFinal)
MercedesDealCycle3 <- MercedesAddATK(MercedesDealCycle3)
MercedesDealCycle3 <- DCSpiderInMirror(MercedesDealCycle3, SummonedFinal)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Mercedes") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  MercedesSpecOpt1 <- Optimization1(MercedesDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec, MercedesUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- MercedesSpecOpt1[1, 1:3]
} else {
  MercedesSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
MercedesSpecOpt <- OptDataAdd(MercedesSpec, MercedesSpecOpt1, "Potential", MercedesBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  MercedesSpecOpt2 <- Optimization2(MercedesDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt, MercedesHyperStatBase, MercedesBase$ChrLv, MercedesBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- MercedesSpecOpt2[1, ]
} else {
  MercedesSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
MercedesSpecOpt <- OptDataAdd(MercedesSpecOpt, MercedesSpecOpt2, "HyperStat", MercedesBase$CRROver, DemonAvenger=F)
BuffFinal <- CriReinAdj(MercedesSpec, MercedesSpecOpt, BuffFinal, GetCoreLv(MercedesCore, "CriticalReinforce"))

MercedesFinalDPM <- DealCalc(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt, Collapse=F)
MercedesFinalDPMwithMax <- DealCalcWithMaxDMR(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Mercedes", sum(na.omit(MercedesFinalDPMwithMax)) / (max(MercedesDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Mercedes", sum(na.omit(MercedesFinalDPM)) / (max(MercedesDealCycle$Time) / 60000) - sum(na.omit(MercedesFinalDPMwithMax)) / (max(MercedesDealCycle$Time) / 60000))

MercedesDealRatio <- DealRatio(MercedesDealCycle, MercedesFinalDPMwithMax)

MercedesDealData <- data.frame(MercedesDealCycle$Skills, MercedesDealCycle$Time, MercedesDealCycle$Restraint4, MercedesFinalDPMwithMax)
colnames(MercedesDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Mercedes", Deal_RR(MercedesDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Mercedes", Deal_40s(MercedesDealData))

MercedesGust <- DealCalcWithMaxDMR(MercedesDealCycle2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt)
MercedesGustDPM <- sum(na.omit(MercedesGust)) / (max(MercedesDealCycle2$Time) / 60000)

MercedesDealDataGust <- data.frame(MercedesDealCycle2$Skills, MercedesDealCycle2$Time, MercedesDealCycle2$Restraint4, MercedesGust)
colnames(MercedesDealDataGust) <- c("Skills", "Time", "R4", "Deal")

MercedesGustRR <- Deal_RR(MercedesDealDataGust)
MercedesGust40s <- Deal_40s(MercedesDealDataGust)

MercedesMoonsault <- DealCalcWithMaxDMR(MercedesDealCycle3, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt)
MercedesMoonsaultDPM <- sum(na.omit(MercedesMoonsault)) / (max(MercedesDealCycle3$Time) / 60000)

MercedesDealDataMoonsault <- data.frame(MercedesDealCycle3$Skills, MercedesDealCycle3$Time, MercedesDealCycle3$Restraint4, MercedesMoonsault)
colnames(MercedesDealDataMoonsault) <- c("Skills", "Time", "R4", "Deal")

MercedesMoonsaultRR <- Deal_RR(MercedesDealDataMoonsault)
MercedesMoonsault40s <- Deal_40s(MercedesDealDataMoonsault)

MercedesGustDealRatio <- DealRatio(MercedesDealCycle2, MercedesGust)
MercedesMoonsaultDealRatio <- DealRatio(MercedesDealCycle3, MercedesMoonsault)
print(list(GustCycle=data.frame(MercedesGustDPM=MercedesGustDPM, MercedesGustRR=MercedesGustRR, MercedesGust40s=MercedesGust40s), 
           MoonsaultCycle=data.frame(MercedesMoonsaultDPM=MercedesMoonsaultDPM, MercedesMoonsaultRR=MercedesMoonsaultRR, MercedesMoonsault40s=MercedesMoonsault40s)))

MercedesSpecMean <- SpecMean("Mercedes", MercedesDealCycleReduction, 
                             DealCalcWithMaxDMR(MercedesDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt), 
                             ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt)