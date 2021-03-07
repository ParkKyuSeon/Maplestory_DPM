## Mercedes - Data
## Mercedes - VMatrix
MercedesCore <- MatrixSet(PasSkills=c("RingofIshtar", "AdvancedStrikeDualShot_AdvancedFinalAttack", "ElementalKnight", "WrathofEnlil", "UnicornSpike", "LegendrySpear", "LeafTornado"), 
                          PasLvs=c(50, 50, 50, 50, 50, 50, 50), 
                          PasMP=c(10, 10, 10, 10, 10, 5, 5), 
                          ActSkills=c("ElementalGhost", "BreathofIrkalla", "RoyalKnights",
                                      CommonV("Bowman", "Heroes")), 
                          ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                          ActMP=c(5, 5, 5, 5, 5, 0, 5, 5), 
                          UsefulSkills=c("CombatOrders", "SharpEyes"), 
                          UsefulLvs=c(20, 20), 
                          UsefulMP=c(0, 0), 
                          SpecSet=SpecDefault)


## Mercedes - Basic Info
MercedesBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=MobDefault,
                        SpecSet=SpecDefault, 
                        Job="Mercedes",
                        CoreData=MercedesCore, 
                        MikhailLink=T, 
                        OtherBuffDuration=0, 
                        AbilList=c("BDR", "BuffDuration"), 
                        LinkList=c("Mikhail", "Mercedes", "DemonAvenger", "Phantom"), 
                        MonsterLife=MLTypeD23, 
                        Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "DualBowgun", SpecDefault$WeaponType)[, 1:16],
                        WeaponType=SpecDefault$WeaponType, 
                        SubWeapon=SubWeapon[23, ], 
                        Emblem=Emblem[2, ])


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
AdvancedFinalAttack <- data.frame(option, value)}

MercedesPassive <- Passive(list(ElfQueen=ElfQueen, PotentialPower=PotentialPower, SharpAiming=SharpAiming, SpiritInfusion=SpiritInfusion, 
                                PhysicalTraining=PhysicalTraining, IgnisRoar=IgnisRoar, DualBowgunExpert=DualBowgunExpert, DefenceBreak=DefenceBreak, 
                                AdvancedFinalAttack=AdvancedFinalAttack))


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

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * MercedesCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MercedesCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + MercedesCore[[2]][1, 2], 150, 720, F, T, F, T)
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
value <- c(floor(((1 + 0.1 * MercedesCore[[2]][7, 2]) * MapleSoldier[1, 2]) * MercedesBase$MainStatP), 5 + floor(MercedesCore[[2]][7, 2]/2))
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

MercedesBuff <- Buff(list(DualBowgunBooster=DualBowgunBooster, WaterShield=WaterShield, IgnisRoarStack=IgnisRoarStack, 
                          UnicornSpikeDebuff=UnicornSpikeDebuff, LegendrySpearDebuff=LegendrySpearDebuff, AncientSpirit=AncientSpirit, MapleSoldier=MapleSoldier, 
                          HeroesOath=HeroesOath, ElfishBlessing=ElfishBlessing, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                          ElementalGhost=ElementalGhost, RoyalKnights=RoyalKnights, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, SkipDummy=SkipDummy,
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## Petbuff : DualBowgunBooster, WaterShield, AncientSpirit
MercedesAllTimeBuff <- AllTimeBuff(MercedesBuff)


## Mercedes - Union & HyperStat & SoulWeapon
MercedesSpec <- JobSpec(JobBase=MercedesBase, 
                        Passive=MercedesPassive, 
                        AllTimeBuff=MercedesAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="DualBowgun", 
                        UnionStance=0)

MercedesUnionRemained <- MercedesSpec$UnionRemained
MercedesHyperStatBase <- MercedesSpec$HyperStatBase
MercedesCoolReduceType <- MercedesSpec$CoolReduceType
MercedesSpec <- MercedesSpec$Spec


## Mercedes - Critical Reinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(MercedesSpec$CRR * (0.2 + 0.01 * MercedesCore[[2]][5, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}

MercedesBuff <- Buff(list(DualBowgunBooster=DualBowgunBooster, WaterShield=WaterShield, IgnisRoarStack=IgnisRoarStack, 
                          UnicornSpikeDebuff=UnicornSpikeDebuff, LegendrySpearDebuff=LegendrySpearDebuff, AncientSpirit=AncientSpirit, MapleSoldier=MapleSoldier, 
                          HeroesOath=HeroesOath, ElfishBlessing=ElfishBlessing, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                          ElementalGhost=ElementalGhost, RoyalKnights=RoyalKnights, CriticalReinforce=CriticalReinforce, MapleWarriors2=MapleWarriors2, SkipDummy=SkipDummy,
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## Mercedes - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MercedesCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * MercedesCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MercedesCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MercedesCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MercedesCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MercedesCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Mercedes - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][5, 2]>=40, 20, 0), 3 * MercedesCore[[1]][5, 2])
info <- c(445 + 2 * MercedesSpec$SkillLv, 5, 1290, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnicornSpike <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][6, 2]>=40, 20, 0), 2 * MercedesCore[[1]][6, 2])
info <- c(700 + 10 * MercedesSpec$SkillLv, 3, 870, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LegendrySpear <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "BDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(MercedesCore[[1]][1, 2]>=40, 20, 0), 20)), 2 * MercedesCore[[1]][1, 2], 20)
info <- c(220 + 1 * MercedesSpec$SkillLv, 2, 120, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RingofIshtar <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][2, 2]>=40, 20, 0), 2 * MercedesCore[[1]][2, 2])
info <- c(380, 4, 630, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedStrikeDualShot <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][4, 2]>=40, 20, 0), 2 * MercedesCore[[1]][4, 2])
info <- c(460, 10, 900, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WrathofEnlil <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 15 * MercedesCore[[2]][1, 2], 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElementalGhostTree <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 210, NA, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkallaPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * MercedesCore[[2]][2, 2], 8, 8020, 150, 150, T, F, F)
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
info <- c(325 + 13 * MercedesCore[[2]][3, 2], 16, 0, 1400, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoyalKnightsKnight <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][2, 2]>=40, 20, 0), 10, 2 * MercedesCore[[1]][2, 2])
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][5, 2]>=40, 20, 0), 3 * MercedesCore[[1]][5, 2])
info <- c((415 + 2 * MercedesSpec$SkillLv) * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 5 * 1.845, 0, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnicornSpikeGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][6, 2]>=40, 20, 0), 2 * MercedesCore[[1]][6, 2])
info <- c((700 + 10 * MercedesSpec$SkillLv) * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 3 * 1.845, 0, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LegendrySpearGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "BDR"), levels=ASkill)
value <- c(IGRCalc(c(ifelse(MercedesCore[[1]][1, 2]>=40, 20, 0), 20)), 2 * MercedesCore[[1]][1, 2], 20)
info <- c((220 + 1 * MercedesSpec$SkillLv) * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 2 * 0.646875, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RingofIshtarGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][2, 2]>=40, 20, 0), 2 * MercedesCore[[1]][2, 2])
info <- c(380 * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 4 * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedStrikeDualShotGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][4, 2]>=40, 20, 0), 2 * MercedesCore[[1]][4, 2])
info <- c(400 * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 10 * 1.845, 0, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WrathofEnlilGhost <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((400 + 16 * MercedesCore[[2]][2, 2]) * (0.3 + 0.01 * MercedesCore[[2]][1, 2]), 8 * 0.646875, 0, 150, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BreathofIrkallaGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][2, 2]>=40, 20, 0), 10, 2 * MercedesCore[[1]][2, 2])
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv) * 0.646875, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackIshtarGhost <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MercedesCore[[1]][2, 2]>=40, 20, 0), 10, 2 * MercedesCore[[1]][2, 2])
info <- c(120 + 1 * MercedesSpec$SkillLv, 2 * (0.75 + 0.01 * MercedesSpec$SkillLv) * 1.845, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttackEnlilGhost <- rbind(data.frame(option, value), info)}

MercedesATK <- Attack(list(UnicornSpike=UnicornSpike, LegendrySpear=LegendrySpear, RingofIshtar=RingofIshtar, AdvancedStrikeDualShot=AdvancedStrikeDualShot, WrathofEnlil=WrathofEnlil, 
                           ElementalGhostTree=ElementalGhostTree, BreathofIrkallaPre=BreathofIrkallaPre, BreathofIrkalla=BreathofIrkalla, BreathofIrkallaEnd=BreathofIrkallaEnd, 
                           RoyalKnightsKnight=RoyalKnightsKnight, AdvancedFinalAttack=AdvancedFinalAttack, UnicornSpikeGhost=UnicornSpikeGhost, LegendrySpearGhost=LegendrySpearGhost, 
                           RingofIshtarGhost=RingofIshtarGhost, AdvancedStrikeDualShotGhost=AdvancedStrikeDualShotGhost, WrathofEnlilGhost=WrathofEnlilGhost, 
                           BreathofIrkallaGhost=BreathofIrkallaGhost, AdvancedFinalAttackIshtarGhost=AdvancedFinalAttackIshtarGhost, AdvancedFinalAttackEnlilGhost=AdvancedFinalAttackEnlilGhost, 
                           SpiderInMirror=SpiderInMirror))


## Mercedes - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * MercedesCore[[1]][3, 2], ifelse(MercedesCore[[1]][3, 2]>=40, 20, 0))
info <- c(385, 4/3, 0, 1500, 210, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ElementalKnightIF <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * MercedesCore[[1]][3, 2], ifelse(MercedesCore[[1]][3, 2]>=40, 20, 0))
info <- c(485, 2/3, 0, 1500, 210, 120, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ElementalKnightD <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * MercedesCore[[2]][4, 2], 1, 720, 500, 0.5*89+0.72+0.01, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

MercedesSummoned <- Summoned(list(ElementalKnightIF=ElementalKnightIF, ElementalKnightD=ElementalKnightD, GuidedArrow=GuidedArrow, SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Mercedes - DealCycle & Deal Calculation
ATKFinal <- data.frame(MercedesATK)
ATKFinal$Delay[c(-3, -7, -8,- 9)] <- Delay(ATKFinal$Delay, MercedesSpec$ATKSpeed)[c(-3, -7, -8,- 9)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)

BuffFinal <- data.frame(MercedesBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MercedesSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(MercedesSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MercedesSpec$CoolReduceP, MercedesSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MercedesSpec$SummonedDuration / 100, 0)


## Mercedes - Delay Skip Structure
MercedesSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
MercedesSkipATK <- data.frame(MercedesSkipATK, row.names=c(rownames(ATKFinal)))
colnames(MercedesSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

MercedesSkipATK$UnicornSpike <- c(F, F, F, T, T, rep(F, 15))
MercedesSkipATK$LegendrySpear <- c(T, F, F, T, T, rep(F, 15))
MercedesSkipATK$AdvancedStrikeDualShot <- c(T, F, F, F, T, rep(F, 15))
MercedesSkipATK$WrathofEnlil <- c(T, T, F, T, F, rep(F, 15))
MercedesSkipATK$SkippedDelay <- c(Delay(600, MercedesSpec$ATKSpeed), Delay(870, MercedesSpec$ATKSpeed), 0, Delay(450, MercedesSpec$ATKSpeed), Delay(270, MercedesSpec$ATKSpeed), rep(0, 15))
MercedesSkipATK <- subset(MercedesSkipATK, MercedesSkipATK$SkippedDelay>0)


## Mercedes - DealCycle
DealCycle <- c("Skills", "Time", rownames(MercedesBuff))
MercedesDealCycle <- t(rep(0, length(DealCycle)))
colnames(MercedesDealCycle) <- DealCycle
MercedesDealCycle <- data.frame(MercedesDealCycle)


MercedesCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, 
                          Period=c(150, 180), CycleTime, SummonSkillPeriod) {
  BuffSummonedPrior <- c("DualBowgunBooster", "WaterShield", "AncientSpirit", "MapleSoldier", "UsefulCombatOrders", "UsefulSharpEyes", 
                         "HeroesOath", "ElementalKnightIF", "ElementalKnightD", "GuidedArrow",
                         "ElfishBlessing", "MapleWarriors2", "ElementalGhost", "RoyalKnights", "SoulContractLink", "CriticalReinforce", "Restraint4")
  Times150 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 2.5, 1, 0.5, 1, 1, 1, 1, 0.5)
  Times180 <- c(0, 0, 0, 0, 1, 1, 0, 0, 0, 3, 1, 1, 1, 1, 2, 1, 1)
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
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
      BuffEndTime[i] <- max(a$Time) + subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000 + 
        sum(CycleBuffList$Delay[Idx:nrow(CycleBuffList)])
    }
    BuffEndTime <- max(BuffEndTime)
    BuffStartTime <- BuffEndTime - sum(CycleBuffList$Delay)
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          IgnisDummy <- IgnisDummy + DealCycle$Time[1]
          IgnisDummy <- ifelse(IgnisDummy >= 7000, 0, IgnisDummy)
        }
      }
      for(i in 1:nrow(SummonSkillPeriod)) {
        if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= 
           max(subset(DealCycle, DealCycle$Skills==paste(SummonSkillPeriod$Skills[i], "Summoned", sep=""))$Time) + SummonSkillPeriod$Period[i] * 1000) {
          DealCycle <- DCSummoned(DealCycle, SummonSkillPeriod$Skills[i], SummonedFinal)
          IgnisDummy <- IgnisDummy + DealCycle$Time[1]
          IgnisDummy <- ifelse(IgnisDummy >= 7000, 0, IgnisDummy)
        }
      }
      if(DebuffDummy==0) {
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
        print(DealCycle[(nrow(DealCycle)-3):nrow(DealCycle), ])
        DebuffDummy <- 4
        IgnisDummy <- DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1]
      }
      if(IgnisDummy==0) {
        DealCycle <- DCATKSkip(DealCycle, "WrathofEnlil", ATKFinal, SkipStructure)
        DealCycle <- DCATKSkip(DealCycle, "AdvancedStrikeDualShot", ATKFinal, SkipStructure)
        DealCycle$SkipDummy[nrow(DealCycle)] <- 1
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- 15000
        print(DealCycle[(nrow(DealCycle)-1):nrow(DealCycle), ])
        DebuffDummy <- DebuffDummy - 1
        IgnisDummy <- IgnisDummy + DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] + DealCycle$Time[1]
      }
      if(nrow(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre"))==0) {
        DealCycle <- DCATK(DealCycle, "BreathofIrkallaPre", ATKFinal)
        DealCycle <- DCATK(DealCycle, "BreathofIrkalla", ATKFinal)
        DealCycle <- DCATK(DealCycle, "BreathofIrkallaEnd", ATKFinal)
        print(DealCycle[(nrow(DealCycle)-2):nrow(DealCycle), ])
        DebuffDummy <- DebuffDummy - 1
        IgnisDummy <- 0
      }
      if(nrow(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre")) > 0) {
        if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="BreathofIrkallaPre")$Time) > IrkallaSubTime * 1000) {
          DealCycle <- DCATK(DealCycle, "BreathofIrkallaPre", ATKFinal)
          DealCycle <- DCATK(DealCycle, "BreathofIrkalla", ATKFinal)
          DealCycle <- DCATK(DealCycle, "BreathofIrkallaEnd", ATKFinal)
          print(DealCycle[(nrow(DealCycle)-2):nrow(DealCycle), ])
          DebuffDummy <- DebuffDummy - 1
          IgnisDummy <- 0
        }
      }
      if(subset(SkipStructure, rownames(SkipStructure)=="UnicornSpike")$SkippedDelay + 
         subset(SkipStructure, rownames(SkipStructure)=="LegendrySpear")$SkippedDelay + IgnisDummy >= 7000 & DebuffDummy == 1) {
        DebuffDummy <- DebuffDummy - 1
      }
      if(DebuffDummy != 0 & IgnisDummy != 0) {
        DealCycle <- DCATK(DealCycle, "RingofIshtar", ATKFinal)
        DealCycle$IgnisRoarStack[nrow(DealCycle)] <- DealCycle$IgnisRoarStack[nrow(DealCycle)] + 100
        IgnisDummy <- IgnisDummy + 120
        IgnisDummy <- ifelse(IgnisDummy >= 7000, 0, IgnisDummy)
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          IgnisDummy <- IgnisDummy + DealCycle$Time[1]
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          IgnisDummy <- IgnisDummy + DealCycle$Time[1]
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
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "WrathofEnlil", "BreathofIrkalla", "SpiderInMirror", "GuidedArrow")) > 0 & 
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
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "WrathofEnlil", "BreathofIrkalla", "SpiderInMirror", "GuidedArrow")) > 0 & 
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
    if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LegendrySpear", "RingofIshtar", "AdvancedStrikeDualShot", "WrathofEnlil", "BreathofIrkalla")) > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdvancedFinalAttack")
      if(DealCycle$ElementalGhost[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "Ghost", sep="")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        if(sum(DealCycle$Skills[i]==c("UnicornSpike", "LegendrySpear", "AdvancedStrikeDualShot", "WrathofEnlil")) > 0) {
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
                                   Period = 150, 
                                   CycleTime = 300, 
                                   SummonSkillPeriod=data.frame(Skills=c("ElementalKnightIF", "ElementalKnightD"), Period=c(112.8, 112.8)))
MercedesDealCycle <- DCSummonedATKs(MercedesDealCycle, Skill=c("GuidedArrow", "ElementalKnightIF", "ElementalKnightD"), SummonedFinal)
MercedesDealCycle <- RepATKCycle(MercedesDealCycle, c("BreathofIrkalla"), 52, 0, ATKFinal)
MercedesDealCycle <- MercedesAddATK(MercedesDealCycle)
MercedesDealCycle <- DCSpiderInMirror(MercedesDealCycle, SummonedFinal)
MercedesDealCycleReduction <- DealCycleReduction(MercedesDealCycle)

DealCalc(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec)
MercedesDealData <- data.frame(MercedesDealCycle$Skills, DealCalc(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec))
colnames(MercedesDealData) <- c("Skills", "Deal")

## Damage Optimization
MercedesSpecOpt1 <- Optimization1(MercedesDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec, MercedesUnionRemained)
MercedesSpecOpt <- MercedesSpec
MercedesSpecOpt$ATKP <- MercedesSpecOpt$ATKP + MercedesSpecOpt1$ATKP
MercedesSpecOpt$BDR <- MercedesSpecOpt$BDR + MercedesSpecOpt1$BDR
MercedesSpecOpt$IGR <- IGRCalc(c(MercedesSpecOpt$IGR, MercedesSpecOpt1$IGR))

MercedesSpecOpt2 <- Optimization2(MercedesDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt, MercedesHyperStatBase, MercedesBase$ChrLv, MercedesBase$CRROver)
MercedesFinalDPM <- DealCalc(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt2)
MercedesFinalDPMwithMax <- DealCalcWithMaxDMR(MercedesDealCycle, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt2)




## Mercedes - DealCycle (180s)
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
                                    SummonSkillPeriod=data.frame(Skills=c("ElementalKnightIF", "ElementalKnightD"), Period=c(112.8, 112.8)))
MercedesDealCycle2 <- DCSummonedATKs(MercedesDealCycle2, Skill=c("GuidedArrow", "ElementalKnightIF", "ElementalKnightD"), SummonedFinal)
MercedesDealCycle2 <- RepATKCycle(MercedesDealCycle2, c("BreathofIrkalla"), 52, 0, ATKFinal)
MercedesDealCycle2 <- MercedesAddATK(MercedesDealCycle2)
MercedesDealCycle2 <- DCSpiderInMirror(MercedesDealCycle2, SummonedFinal)
MercedesDealCycleReduction2 <- DealCycleReduction(MercedesDealCycle2)

DealCalc(MercedesDealCycle2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec)
MercedesDealData2 <- data.frame(MercedesDealCycle2$Skills, DealCalc(MercedesDealCycle2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec))
colnames(MercedesDealData2) <- c("Skills", "Deal")

## Damage Optimization
MercedesSpecOpt1_2 <- Optimization1(MercedesDealCycleReduction2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpec, MercedesUnionRemained)
MercedesSpecOpt2 <- MercedesSpec
MercedesSpecOpt2$ATKP <- MercedesSpecOpt2$ATKP + MercedesSpecOpt1_2$ATKP
MercedesSpecOpt2$BDR <- MercedesSpecOpt2$BDR + MercedesSpecOpt1_2$BDR
MercedesSpecOpt2$IGR <- IGRCalc(c(MercedesSpecOpt2$IGR, MercedesSpecOpt1_2$IGR))

MercedesSpecOpt2_2 <- Optimization2(MercedesDealCycleReduction2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt2, MercedesHyperStatBase, MercedesBase$ChrLv, MercedesBase$CRROver)
MercedesFinalDPM2 <- DealCalc(MercedesDealCycle2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt2_2)
MercedesFinalDPMwithMax2 <- DealCalcWithMaxDMR(MercedesDealCycle2, ATKFinal, BuffFinal, SummonedFinal, MercedesSpecOpt2_2)

DPM12344$Mercedes[1] <- sum(na.omit(MercedesFinalDPMwithMax2)) / (338660 / 60000)
DPM12344$Mercedes[2] <- sum(na.omit(MercedesFinalDPM2)) / (338660 / 60000) - sum(na.omit(MercedesFinalDPMwithMax2)) / (338660 / 60000)

MercedesDealRatio <- DealRatio(MercedesDealCycle2, MercedesFinalDPMwithMax2)

MercedesDealData <- data.frame(MercedesDealCycle2$Skills, MercedesDealCycle2$Time, MercedesDealCycle2$Restraint4, MercedesFinalDPMwithMax2, MercedesFinalDPM2-MercedesFinalDPMwithMax2)
colnames(MercedesDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(MercedesDealData, MercedesDealData$R4>0)

MercedesRR <- MercedesDealData[42:464, ]
DPM12344$Mercedes[3] <- sum((MercedesRR$Deal))

Mercedes40s <-  MercedesDealData[42:1318, ]
DPM12344$Mercedes[4] <- sum((Mercedes40s$Deal))