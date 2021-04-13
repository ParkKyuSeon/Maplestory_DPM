## PathFinder - Data
## PathFinder - VMatrix
PathFinderCore <- MatrixSet(PasSkills=c("CardinalDischarge", "CardinalBlast", "CradinalTransition", "TripleImpact", "EdgeofResonance", 
                                        "ComboAssault", "Raven"), 
                            PasLvs=c(50, 50, 50, 50, 50, 50, 50), 
                            PasMP=c(10, 10, 5, 10, 10, 10, 5), 
                            ActSkills=c("UltimateBlast", "RavenTempest", "ObisdianBarrier", "RelicUnbound", 
                                        CommonV("Bowman", "Adventure")), 
                            ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                            ActMP=c(5, 5, 5, 5, 5, 5, 0, 5, 0), 
                            UsefulSkills=c("CombatOrders", "WindBooster"), 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=SpecDefault)


## PathFinder - Basic Info
PathFinderBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=MobDefault,
                          SpecSet=SpecDefault, 
                          Job="PathFinder",
                          CoreData=PathFinderCore, 
                          MikhailLink=T, 
                          OtherBuffDuration=0, 
                          AbilList=c("BDR", "BuffDuration"), 
                          LinkList=c("AdventureBowman", "Phantom", "DemonAvenger", "Mikhail"), 
                          MonsterLife=MLTypeD21, 
                          Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "AncientBow", SpecDefault$WeaponType)[, 1:16],
                          WeaponType=SpecDefault$WeaponType, 
                          SubWeapon=SubWeapon[9, ], 
                          Emblem=Emblem[1, ], 
                          CoolReduceHat=T)


## PathFinder - Passive
{option <- factor(c("CRR"), levels=PSkill)
value <- c(40)
CriticalShot <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
AncientBowMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CRR", "BDR", "IGR"), levels=PSkill)
value <- c(10, 10, 30)
EssenceofArcher <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(20)
AdditionalTransition <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(PathFinderBase$PSkillLv / 2), 60 + 2 * PathFinderBase$PSkillLv, 10 + ceiling(PathFinderBase$PSkillLv / 3))
AncientBowExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(80 + 2 * PathFinderBase$PSkillLv)
IllusionStep <- data.frame(option, value)}

PathFinderPassive <- Passive(list(CriticalShot=CriticalShot, AncientBowMastery=AncientBowMastery, PhysicalTraining=PhysicalTraining, EssenceofArcher=EssenceofArcher, 
                                  AdditionalTransition=AdditionalTransition, AncientBowExpert=AncientBowExpert, IllusionStep=IllusionStep))


## PathFinder - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AncientBowBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CurseTolerance <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(15)
info <- c(24, 240, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AncientGuidance <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(PathFinderBase$SkillLv/2), 15 + ceiling(PathFinderBase$SkillLv/2))
info <- c(300 + 3 * PathFinderBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((PathFinderBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(PathFinderBase$SkillLv/2))))
info <- c(900 + 30 * PathFinderBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(20)
info <- c(15, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CurseTransitionDebuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RelicEvolution <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * PathFinderCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * PathFinderCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(26.99 + 0.72, 120, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RavenTempestBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * PathFinderCore[[2]][8, 2]) * MapleSoldier[1, 2]) * PathFinderBase$MainStatP), 5 + floor(PathFinderCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RelicGauge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GuidanceGauge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RelicChange <- rbind(data.frame(option, value), info)}

PathFinderBuff <- Buff(list(AncientBowBooster=AncientBowBooster, CurseTolerance=CurseTolerance, AncientGuidance=AncientGuidance, SharpEyes=SharpEyes, MapleSoldier=MapleSoldier,
                         CurseTransitionDebuff=CurseTransitionDebuff, EpicAdventure=EpicAdventure, RelicEvolution=RelicEvolution, UsefulWindBooster=UsefulWindBooster, UsefulCombatOrders=UsefulCombatOrders, 
                         CriticalReinforce=CriticalReinforce, RavenTempestBuff=RavenTempestBuff, MapleWarriors2=MapleWarriors2, 
                         RelicGauge=RelicGauge, GuidanceGauge=GuidanceGauge, RelicChange=RelicChange, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
PathFinderAllTimeBuff <- AllTimeBuff(PathFinderBuff)
## PetBuff : AincientBowBooster, SharpEyes, CurseTolerance


## PathFinder - Union & HyperStat & SoulWeapon
PathFinderSpec <- JobSpec(JobBase=PathFinderBase, 
                          Passive=PathFinderPassive, 
                          AllTimeBuff=PathFinderAllTimeBuff, 
                          MobInfo=MobDefault, 
                          SpecSet=SpecDefault, 
                          WeaponName="AncientBow", 
                          UnionStance=0)

PathFinderUnionRemained <- PathFinderSpec$UnionRemained
PathFinderHyperStatBase <- PathFinderSpec$HyperStatBase
PathFinderCoolReduceType <- PathFinderSpec$CoolReduceType
PathFinderSpec <- PathFinderSpec$Spec


## PathFinder - Critical Reinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(PathFinderSpec$CRR * (0.2 + 0.01 * PathFinderCore[[2]][6, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}
PathFinderBuff <- Buff(list(AncientBowBooster=AncientBowBooster, CurseTolerance=CurseTolerance, AncientGuidance=AncientGuidance, SharpEyes=SharpEyes, MapleSoldier=MapleSoldier,
                            CurseTransitionDebuff=CurseTransitionDebuff, EpicAdventure=EpicAdventure, RelicEvolution=RelicEvolution, UsefulWindBooster=UsefulWindBooster, UsefulCombatOrders=UsefulCombatOrders, 
                            CriticalReinforce=CriticalReinforce, RavenTempestBuff=RavenTempestBuff, MapleWarriors2=MapleWarriors2, 
                            RelicGauge=RelicGauge, GuidanceGauge=GuidanceGauge, RelicChange=RelicChange, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
PathFinderAllTimeBuff <- AllTimeBuff(PathFinderBuff)


## PathFinder - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * PathFinderCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * PathFinderCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PathFinderCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PathFinderCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PathFinderCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PathFinderCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## PathFinder - Attacks
## HyperSkill Check Needed - Ancient Force Enchant Enhance(NOW) vs. Ancient Force Ignore Quard
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PathFinderCore[[1]][1, 2]>=40, 20, 0), 20, 2 * PathFinderCore[[1]][1, 2])
info <- c(300 + 5 * PathFinderSpec$PSkillLv, 10, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CardinalDischarge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PathFinderCore[[1]][2, 2]>=40, 20, 0), 20, FDRCalc(c(2 * PathFinderCore[[1]][2, 2], 50)))
info <- c(400 + 5 * PathFinderSpec$PSkillLv, 5, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CardinalBlast <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PathFinderCore[[1]][3, 2]>=40, 20, 0), 20, 2 * PathFinderCore[[1]][3, 2])
info <- c(540 + 7 * PathFinderSpec$PSkillLv, 6, 420, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CardinalTransition <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PathFinderCore[[1]][1, 2]>=40, 20, 0), 2 * PathFinderCore[[1]][1, 2])
info <- c(150 + PathFinderSpec$PSkillLv, 3 * 0.5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdditionalDischarge <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PathFinderCore[[1]][2, 2]>=40, 20, 0), 2 * PathFinderCore[[1]][2, 2])
info <- c(200 + 1 * PathFinderSpec$PSkillLv, 3 * 0.5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdditionalBlast <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(PathFinderCore[[1]][4, 2]>=40, 20, 0))), 70 + PathFinderSpec$PSkillLv, FDRCalc(c(2 * PathFinderCore[[1]][4, 2], 10)))
info <- c(600 + 5 * PathFinderSpec$PSkillLv, 15, 540, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TripleImpact <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(PathFinderCore[[1]][5, 2]>=40, 20, 0))), 70 + PathFinderSpec$PSkillLv, FDRCalc(c(2 * PathFinderCore[[1]][5, 2], 10, 50))) ## Debuff FDR Check Needed
info <- c(800 + 15 * PathFinderSpec$SkillLv, 6, 0, NA, 15, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EdgeofResonance <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(PathFinderCore[[1]][6, 2]>=40, 20, 0))), 70 + PathFinderSpec$PSkillLv, FDRCalc(c(2 * PathFinderCore[[1]][6, 2], 10)))
info <- c(600 + 10 * PathFinderSpec$SkillLv, 8, 780, NA, 20, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ComboAssaultBlast1 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(PathFinderCore[[1]][6, 2]>=40, 20, 0))), 70 + PathFinderSpec$PSkillLv, FDRCalc(c(2 * PathFinderCore[[1]][6, 2], 10)))
info <- c(600 + 10 * PathFinderSpec$SkillLv, 5, 180, NA, 20, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ComboAssaultBlast2 <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR", "BDR"), levels=ASkill)
value <- c(FDRCalc(c(10, 100)), 100, 70 + PathFinderSpec$PSkillLv)
info <- c(400 + 20 * PathFinderCore[[2]][1, 2], 15, 1800, 60, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UltimateBlast <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR", "BDR"), levels=ASkill)
value <- c(10, 20, 70 + PathFinderSpec$PSkillLv)
info <- c(400 + 20 * PathFinderCore[[2]][2, 2], 5, 720, 270, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RavenTempest <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(10, 70 + PathFinderSpec$PSkillLv, 20)
info <- c(500 + 18 * PathFinderCore[[2]][3, 2], 4, 60, 510, 120, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ObsidianBarrier <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(10, 70 + PathFinderSpec$PSkillLv, 20)
info <- c(500 + 20 * PathFinderCore[[2]][4, 2], 3, 720, 360, 120, T, F, F) ## Logic
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RelicUnboundDischarge <- rbind(data.frame(option, value), info)}

PathFinderATK <- Attack(list(CardinalDischarge=CardinalDischarge, CardinalBlast=CardinalBlast, CardinalTransition=CardinalTransition, AdditionalDischarge=AdditionalDischarge, AdditionalBlast=AdditionalBlast, 
                             TripleImpact=TripleImpact, EdgeofResonance=EdgeofResonance, ComboAssaultBlast1=ComboAssaultBlast1, ComboAssaultBlast2=ComboAssaultBlast2, 
                             UltimateBlast=UltimateBlast, RavenTempest=RavenTempest, ObsidianBarrier=ObsidianBarrier, RelicUnboundDischarge=RelicUnboundDischarge, SpiderInMirror=SpiderInMirror))


## PathFinder - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 15 * PathFinderCore[[2]][7, 2], 7, 600, 3030, 40, 105, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Evolve <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * PathFinderCore[[1]][7, 2], ifelse(PathFinderCore[[1]][7, 2]>=40, 20, 0))
info <- c(390, 1, 0, 1800, 220, 105, T, T, F, F) 
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Raven <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * PathFinderCore[[2]][5, 2], 1, 720, 500, 0.5 * 89 + 0.72 + 0.01, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

PathFinderSummoned <- Summoned(list(Evolve=Evolve, Raven=Raven, GuidedArrow=GuidedArrow, SpiderInMirrorStart=SpiderInMirrorStart, 
                                    SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                    SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## PathFinder - DealCycle & Deal Calculation
ATKFinal <- data.frame(PathFinderATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, PathFinderSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, PathFinderSpec$CoolReduceP, PathFinderSpec$CoolReduce)

BuffFinal <- data.frame(PathFinderBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, PathFinderSpec$CoolReduceP, PathFinderSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, PathFinderSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(PathFinderSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, PathFinderSpec$CoolReduceP, PathFinderSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * PathFinderSpec$SummonedDuration / 100, 0)


## PathFinder - Delay Skip Structure
PathFinderSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
PathFinderSkipATK <- data.frame(PathFinderSkipATK, row.names=c(rownames(ATKFinal)))
colnames(PathFinderSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

PathFinderSkipATK$CardinalDischarge <- c(F, T, T, rep(F, 11))
PathFinderSkipATK$CardinalBlast <- c(T, F, T, rep(F, 11))
PathFinderSkipATK$CardinalTransition <- c(T, T, F, rep(F, 11))
PathFinderSkipATK$TripleImpact <- c(T, T, T, rep(F, 11))
PathFinderSkipATK$ComboAssaultBlast1 <- c(F, T, T, rep(F, 11))
PathFinderSkipATK$UltimateBlast <- c(T, T, T, rep(F, 11))
PathFinderSkipATK$RavenTempest <- c(T, T, T, rep(F, 11))
PathFinderSkipATK$ObsidianBarrier <- c(T, T, T, rep(F, 11))
PathFinderSkipATK$RelicUnboundDischarge <- c(T, F, T, rep(F, 11))
PathFinderSkipATK$SkippedDelay <- c(210, 210, 60, rep(0, 11))
PathFinderSkipATK <- subset(PathFinderSkipATK, PathFinderSkipATK$SkippedDelay>0)


## PathFinder - DealCycle Function
DealCycle <- c("Skills", "Time", rownames(PathFinderBuff))
PathFinderDealCycle <- t(rep(0, length(DealCycle)))
colnames(PathFinderDealCycle) <- DealCycle
PathFinderDealCycle <- data.frame(PathFinderDealCycle)


PathFinderCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure,
                            Period=120, CycleTime=240, SkipAddDelay=30) {
  SkipStructure$SkippedDelay <- SkipStructure$SkippedDelay + SkipAddDelay
  BuffSummonedPrior <- c("AncientBowBooster", "CurseTolerance", "SharpEyes", "MapleSoldier", "UsefulWindBooster", "UsefulCombatOrders", "EpicAdventure", 
                         "GuidedArrow", "MapleWarriors2", "CriticalReinforce", "SoulContractLink", "RavenTempestBuff", "Restraint4", "RelicEvolution")
  
  Times120 <- c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0, 
                2, 0.5, 1, 1, 1, 0.5, 1)
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times120[i]==0, Inf, Times120[i])
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
  
  RelicGauge <- function(DealCycle, BuffFinal) {
    ## Raven Tempest Gauge
    if(DealCycle$RavenTempestBuff[nrow(DealCycle)-1] > 0) {
      RTATKTimes <- floor((subset(BuffFinal, rownames(BuffFinal)=="RavenTempestBuff")$Duration * 1000 - DealCycle$RavenTempestBuff[nrow(DealCycle)-1] - 721) / 270) + 1
      RTATKTimes2 <- floor((subset(BuffFinal, rownames(BuffFinal)=="RavenTempestBuff")$Duration * 1000 - DealCycle$RavenTempestBuff[nrow(DealCycle)] - 721) / 270) + 1
      if(RTATKTimes >= 0 & RTATKTimes2 > 0 & RTATKTimes2 - RTATKTimes > 0) {
        RavenDummy <- c((RTATKTimes+1):RTATKTimes2)
        print(RavenDummy)
        for(i in 1:length(RavenDummy)) {
          DC2 <- DealCycle[nrow(DealCycle), ]
          DC2$Time <- max(subset(DealCycle, DealCycle$Skills=="RavenTempest")$Time) + 720 + 270 * (RavenDummy[i] - 1)
          DC2$Skills <- "RavenTempestDummy"
          DealCycle <- rbind(DealCycle[1:(nrow(DealCycle)-1), ], DC2, DealCycle[nrow(DealCycle), ])
          
          DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] <- DealCycle[nrow(DealCycle)-2, 3:ncol(DealCycle)] - (DealCycle[nrow(DealCycle)-1, 2] - DealCycle[nrow(DealCycle)-2, 2])
          DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] <- ifelse(DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] < 0, 0, DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)])
          DealCycle$RavenTempestBuff[nrow(DealCycle)-1] <- subset(BuffFinal, rownames(BuffFinal)=="RavenTempestBuff")$Duration * 1000 - 720 - 270 * (RavenDummy[i] - 1)
          
          DealCycle$GuidanceGauge[nrow(DealCycle)-1] <- min(1000, DealCycle$GuidanceGauge[nrow(DealCycle)-2] + min(1000, DealCycle$RelicGauge[nrow(DealCycle)-2] + 20) - DealCycle$RelicGauge[nrow(DealCycle)-2])
          DealCycle$RelicGauge[nrow(DealCycle)-1] <- min(1000, DealCycle$RelicGauge[nrow(DealCycle)-2] + 20)
          
          if(DealCycle$GuidanceGauge[nrow(DealCycle)-1] == 1000) {
            DealCycle$AncientGuidance[nrow(DealCycle)-1] <- subset(BuffFinal, rownames(BuffFinal)=="AncientGuidance")$Duration * 1000
            DealCycle$GuidanceGauge[nrow(DealCycle)-1] <- 0
          }
        }
      }
    }
    ## Raven Gauge
    else if(DealCycle$Skills[nrow(DealCycle)] != "RavenTempestBuff" & nrow(subset(DealCycle, DealCycle$Skills=="EvolveSummoned")) >= 1) {
      if(max(0, DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="EvolveSummoned")$Time)) >= 41800) {
        RavenPersist <- max(0, DealCycle$Time[nrow(DealCycle)-1] - max(subset(DealCycle, DealCycle$Skills=="EvolveSummoned")$Time))
        RavenPersist2 <- max(0, DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="EvolveSummoned")$Time))
        RavenATKTimes <- floor((RavenPersist - 41801) / 1800) + 1
        RavenATKTimes2 <- floor((RavenPersist2 - 41801) / 1800) + 1
        if(RavenATKTimes >= 0 & RavenATKTimes2 > 0 & RavenATKTimes2 - RavenATKTimes > 0) {
          RavenDummy <- c((RavenATKTimes+1):RavenATKTimes2)
          print(RavenDummy)
          for(i in 1:length(RavenDummy)) {
            DC2 <- DealCycle[nrow(DealCycle), ]
            DC2$Time <- max(subset(DealCycle, DealCycle$Skills=="EvolveSummoned")$Time) + 41800 + 1800 * (RavenDummy[i] - 1)
            DC2$Skills <- "RavenDummy"
            DealCycle <- rbind(DealCycle[1:(nrow(DealCycle)-1), ], DC2, DealCycle[nrow(DealCycle), ])
            
            DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] <- DealCycle[nrow(DealCycle)-2, 3:ncol(DealCycle)] - (DealCycle[nrow(DealCycle)-1, 2] - DealCycle[nrow(DealCycle)-2, 2])
            DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] <- ifelse(DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)] < 0, 0, DealCycle[nrow(DealCycle)-1, 3:ncol(DealCycle)])
            
            DealCycle$GuidanceGauge[nrow(DealCycle)-1] <- min(1000, DealCycle$GuidanceGauge[nrow(DealCycle)-2] + min(1000, DealCycle$RelicGauge[nrow(DealCycle)-2] + 10) - DealCycle$RelicGauge[nrow(DealCycle)-2])
            DealCycle$RelicGauge[nrow(DealCycle)-1] <- min(1000, DealCycle$RelicGauge[nrow(DealCycle)-2] + 10)
            
            if(DealCycle$GuidanceGauge[nrow(DealCycle)-1] == 1000) {
              DealCycle$AncientGuidance[nrow(DealCycle)-1] <- subset(BuffFinal, rownames(BuffFinal)=="AncientGuidance")$Duration * 1000
              DealCycle$GuidanceGauge[nrow(DealCycle)-1] <- 0
            }
          }
        }
      }
    }
    
    ## Cardinal Discharge, Cardinal Blast
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("CardinalDischarge", "CardinalBlast", "CardinalTransition"))==1) {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- min(1000, DealCycle$GuidanceGauge[nrow(DealCycle)-1] + min(1000, DealCycle$RelicGauge[nrow(DealCycle)-1] + 20) - DealCycle$RelicGauge[nrow(DealCycle)-1])
      DealCycle$RelicGauge[nrow(DealCycle)] <- min(1000, DealCycle$RelicGauge[nrow(DealCycle)-1] + 20)
    }
    ## Triple Impact
    else if(DealCycle$Skills[nrow(DealCycle)]=="TripleImpact") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 50)
    }
    ## Combo Assault
    else if(DealCycle$Skills[nrow(DealCycle)]=="ComboAssaultBlast1") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 150)
    }
    ## Edge of Resonance
    else if(DealCycle$Skills[nrow(DealCycle)]=="EdgeofResonance") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 100)
    }
    ## Ultimate Blast
    else if(DealCycle$Skills[nrow(DealCycle)]=="UltimateBlast") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 1000)
    }
    ## Obsidian Barrier
    else if(DealCycle$Skills[nrow(DealCycle)]=="ObsidianBarrier") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 500)
    }
    ## Relic Unbound
    else if(DealCycle$Skills[nrow(DealCycle)]=="RelicUnboundDischarge") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 350)
    }
    ## Raven Tempest
    else if(DealCycle$Skills[nrow(DealCycle)]=="RavenTempest") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
      DealCycle$RelicGauge[nrow(DealCycle)] <- max(0, DealCycle$RelicGauge[nrow(DealCycle)-1] - 300)
    } 
    ## Relic Evolution
    else if(DealCycle$Skills[nrow(DealCycle)]=="RelicEvolution") {
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- min(1000, DealCycle$GuidanceGauge[nrow(DealCycle)-1] + min(1000, DealCycle$RelicGauge[nrow(DealCycle)-1] + 1000) - DealCycle$RelicGauge[nrow(DealCycle)-1])
      DealCycle$RelicGauge[nrow(DealCycle)] <- min(1000, DealCycle$RelicGauge[nrow(DealCycle)-1] + 1000)
    } else {
      DealCycle$RelicGauge[nrow(DealCycle)] <- DealCycle$RelicGauge[nrow(DealCycle)-1]
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- DealCycle$GuidanceGauge[nrow(DealCycle)-1]
    }
    if(DealCycle$GuidanceGauge[nrow(DealCycle)] == 1000) {
      DealCycle$AncientGuidance[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="AncientGuidance")$Duration * 1000
      DealCycle$GuidanceGauge[nrow(DealCycle)] <- 0
    }
    return(DealCycle)
  }
  RelicShape <- function(DealCycle, Shape) {
    if(DealCycle$Skills[nrow(DealCycle)] == "CardinalDischarge" & Shape == "Blast") {
      DealCycle$RelicChange[nrow(DealCycle)] <- 1
    } else if(DealCycle$Skills[nrow(DealCycle)] == "CardinalBlast" & Shape == "Discharge") {
      DealCycle$RelicChange[nrow(DealCycle)] <- 1
    }
    return(DealCycle)
  }
  BDATK <- function(DealCycle, Skills=c("CardinalDischarge", "CardinalBlast"), ATKFinal, SkipStructure) {
    if(DealCycle$Skills[nrow(DealCycle)]=="CardinalDischarge" & Skills=="CardinalBlast") {
      DealCycle[1, 2:ncol(DealCycle)] <- 240
      DealCycle <- DCATK(DealCycle, "CardinalBlast", ATKFinal)
    } else if(DealCycle$Skills[nrow(DealCycle)]=="CardinalBlast" & Skills=="CardinalDischarge") {
      DealCycle[1, 2:ncol(DealCycle)] <- 210
      DealCycle <- DCATK(DealCycle, "CardinalDischarge", ATKFinal)
    } else {
      DealCycle <- DCATKSkip(DealCycle, Skills, ATKFinal, SkipStructure)
    }
    return(DealCycle)
  }
  ## Relic Gauge Function -> Relic Shape Function -> Shape Change
  Shape <- "Discharge"

  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="EpicAdventure") {
        DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
      } else if(BuffList[[1]][i]=="RavenTempestBuff") {
        DealCycle <- DCBuff(DealCycle, "RavenTempestBuff", BuffFinal)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "RavenTempest", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "RelicUnboundDischarge", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "None"
        
        DealCycle <- BDATK(DealCycle, "CardinalBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Blast"
        
        DealCycle <- BDATK(DealCycle, "CardinalDischarge", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Discharge"
        
        DealCycle <- BDATK(DealCycle, "CardinalBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Blast"
        
        DealCycle <- BDATK(DealCycle, "CardinalDischarge", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Discharge"

        DealCycle <- BDATK(DealCycle, "CardinalBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Blast"
        
        DealCycle <- DCATKSkip(DealCycle, "ObsidianBarrier", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "None"
      } else if(BuffList[[1]][i]=="RelicEvolution") {
        DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "UltimateBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
      } else if(BuffList[[1]][i]=="AncientBowBooster") {
        DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
        DealCycle$RelicGauge[nrow(DealCycle)] <- 1000
        DealCycle$GuidanceGauge[nrow(DealCycle)] <- 1000
        DealCycle$CurseTransitionDebuff[nrow(DealCycle)] <- 15000
      } else {
        DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- RelicGauge(DealCycle, BuffFinal)
      DealCycle <- RelicShape(DealCycle, Shape)
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
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]  
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  EvolveCount <- 0
  CACool <- subset(ATKFinal, rownames(ATKFinal)=="ComboAssaultBlast1")$CoolTime * 1000
  ERCool <- subset(ATKFinal, rownames(ATKFinal)=="EdgeofResonance")$CoolTime * 1000
  CAStack <- 3
  
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
    print(BuffStartTime)
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          DealCycle <- RelicGauge(DealCycle, BuffFinal)
          DealCycle <- RelicShape(DealCycle, Shape)
        }
      }
      LastComboAssault <- ifelse(nrow(subset(DealCycle, DealCycle$Skills=="ComboAssaultBlast1"))==0, 0, max(subset(DealCycle, DealCycle$Skills=="ComboAssaultBlast1")$Time))
      LastTripleImpact <- ifelse(nrow(subset(DealCycle, DealCycle$Skills=="TripleImpact"))==0, 0, max(subset(DealCycle, DealCycle$Skills=="TripleImpact")$Time))
      NotUseGauge <- ifelse(k==length(BuffList) & DealCycle$Time[nrow(DealCycle)] + 4000 >= BuffStartTime, 1, 0)
      ## Evolve
      if(EvolveCount==0 & DealCycle$RavenTempestBuff[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCSummoned(DealCycle, "Evolve", SummonedFinal)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        EvolveCount <- 1 ## Reset Logic Needed
      }
      ## Triple Impact - Edge of Resonance - Combo Assault
      else if(ifelse(DealCycle$Skills[nrow(DealCycle)]=="CardinalDischarge", DealCycle$Time[nrow(DealCycle)] + subset(SkipStructure, rownames(SkipStructure)=="CardinalDischarge")$SkippedDelay, 
                     DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - LastTripleImpact >= ERCool - sum(subset(DealCycle, DealCycle$Time >= LastTripleImpact)$RelicChange) * 1000 & 
              CAStack==3 & DealCycle$RelicGauge[nrow(DealCycle)] >= 280 & NotUseGauge==0) {
        DealCycle <- DCATKSkip(DealCycle, "TripleImpact", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "EdgeofResonance", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- BDATK(DealCycle, "CardinalBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Blast"
        
        DealCycle <- DCATKSkip(DealCycle, "ComboAssaultBlast1", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        DealCycle$CurseTransitionDebuff[nrow(DealCycle)] <- 15000
        
        DealCycle <- DCATKSkip(DealCycle, "ComboAssaultBlast2", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "None"
        
        CAStack <- 1
      }
      else if(ifelse(DealCycle$Skills[nrow(DealCycle)]=="CardinalDischarge", DealCycle$Time[nrow(DealCycle)] + subset(SkipStructure, rownames(SkipStructure)=="CardinalDischarge")$SkippedDelay, 
                     DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - LastTripleImpact >= ERCool - sum(subset(DealCycle, DealCycle$Time >= LastTripleImpact)$RelicChange) * 1000 & 
              CAStack!=3 & DealCycle$RelicGauge[nrow(DealCycle)] >= 150 & NotUseGauge==0) {
        DealCycle <- DCATKSkip(DealCycle, "TripleImpact", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        DealCycle <- DCATKSkip(DealCycle, "EdgeofResonance", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        
        CAStack <- CAStack + 1
      }
      ## Cardinal Blast - Cardinal Discharge
      else {
        DealCycle <- BDATK(DealCycle, "CardinalBlast", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Blast"
        
        DealCycle <- BDATK(DealCycle, "CardinalDischarge", ATKFinal, SkipStructure)
        DealCycle <- RelicGauge(DealCycle, BuffFinal)
        DealCycle <- RelicShape(DealCycle, Shape)
        Shape <- "Discharge"
      }
      print(c(DealCycle$Time[nrow(DealCycle)], DealCycle$Skills[nrow(DealCycle)]))
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="RavenTempestBuff") {
            DealCycle <- DCBuff(DealCycle, "RavenTempestBuff", BuffFinal)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
            
            DealCycle <- DCATKSkip(DealCycle, "RavenTempest", ATKFinal, SkipStructure)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
            EvolveCount <- 0
            
            if(Shape!="Discharge") {
              DealCycle <- BDATK(DealCycle, "CardinalDischarge", ATKFinal, SkipStructure)
              DealCycle <- RelicGauge(DealCycle, BuffFinal)
              DealCycle <- RelicShape(DealCycle, Shape)
              Shape <- "Discharge"
            }
            
            DealCycle <- DCATKSkip(DealCycle, "RelicUnboundDischarge", ATKFinal, SkipStructure)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
            Shape <- "None"
          } else if(BuffList[[k]][i]=="RelicEvolution") {
            DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
            
            DealCycle <- DCATKSkip(DealCycle, "UltimateBlast", ATKFinal, SkipStructure)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
          } else {
            DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
            DealCycle <- RelicGauge(DealCycle, BuffFinal)
            DealCycle <- RelicShape(DealCycle, Shape)
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- RelicGauge(DealCycle, BuffFinal)
          DealCycle <- RelicShape(DealCycle, Shape)
        }
      }
    }
  }
  DealCycle <- DCATKSkip(DealCycle, "CardinalTransition", ATKFinal, SkipStructure)
  DealCycle$CurseTransitionDebuff[nrow(DealCycle)] <- 15000
  DealCycle <- RelicGauge(DealCycle, BuffFinal)
  DealCycle <- DCATKSkip(DealCycle, "CardinalDischarge", ATKFinal, SkipStructure)
  DealCycle <- RelicGauge(DealCycle, BuffFinal)
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
PathFinderAddATK <- function(DealCycle, ATKFinal, SummonedFinal, BarrierDuration) {
  ## Raven Tempest & Raven
  DealCycle$Skills[DealCycle$Skills=="RavenTempest"] <- "RavenTempestStart"
  DealCycle$Skills[DealCycle$Skills=="RavenTempestDummy"] <- "RavenTempest"
  DealCycle$Skills[DealCycle$Skills=="RavenDummy"] <- "Raven"
  
  ## Relic Unbound, Ultimate Blast, Obsidian Barrier
  DealCycle <- RepATKCycle(DealCycle, "RelicUnboundDischarge", 61, 360, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "UltimateBlast", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ObsidianBarrier", ceiling((BarrierDuration * 1000 - 510)/510), 510, ATKFinal)
  
  ## Guided Arrow, Evolve
  DealCycle <- DCSummonedATKs(DealCycle, c("GuidedArrow", "Evolve"), SummonedFinal)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Additional Discharge, Additional Blast
  for(i in 1:(nrow(DealCycle))) {
    if(DealCycle$Skills[i]=="CardinalDischarge" & DealCycle$RelicChange[i]==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalBlast")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalBlast")
      if(DealCycle$RelicEvolution[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalBlast")
      }
    } else if(DealCycle$Skills[i]=="CardinalBlast" & DealCycle$RelicChange[i]==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalDischarge")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalDischarge")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalDischarge")
      if(DealCycle$RelicEvolution[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("AdditionalDischarge")
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}


PathFinderDealCycle <- PathFinderCycle(PreDealCycle=PathFinderDealCycle, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal,
                                       SummonedFinal=SummonedFinal, 
                                       Spec=PathFinderSpec,
                                       SkipStructure=PathFinderSkipATK,
                                       Period=120, CycleTime=240, SkipAddDelay=30)
PathFinderDealCycle <- PathFinderAddATK(DealCycle=PathFinderDealCycle, 
                                        ATKFinal=ATKFinal,
                                        SummonedFinal=SummonedFinal,
                                        BarrierDuration=10 + floor(PathFinderCore[[2]][3, 2])/5)
PathFinderDealCycleReduction <- DealCycleReduction(PathFinderDealCycle)

DealCalc(PathFinderDealCycle, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpec)
PathFinderDealData <- data.frame(PathFinderDealCycle$Skills, DealCalc(PathFinderDealCycle, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpec))
colnames(PathFinderDealData) <- c("Skills", "Deal")

## Damage Optimization
PathFinderSpecOpt1 <- Optimization1(PathFinderDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpec, PathFinderUnionRemained)
PathFinderSpecOpt <- PathFinderSpec
PathFinderSpecOpt$ATKP <- PathFinderSpecOpt$ATKP + PathFinderSpecOpt1$ATKP
PathFinderSpecOpt$BDR <- PathFinderSpecOpt$BDR + PathFinderSpecOpt1$BDR
PathFinderSpecOpt$IGR <- IGRCalc(c(PathFinderSpecOpt$IGR, PathFinderSpecOpt1$IGR))

PathFinderSpecOpt2 <- Optimization2(PathFinderDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpecOpt, PathFinderHyperStatBase, PathFinderBase$ChrLv, PathFinderBase$CRROver)
PathFinderFinalDPM <- DealCalc(PathFinderDealCycle, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpecOpt2)
PathFinderFinalDPMwithMax <- DealCalcWithMaxDMR(PathFinderDealCycle, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpecOpt2)

DPM12344$PathFinder[1] <- sum(na.omit(PathFinderFinalDPMwithMax)) / (244830 / 60000)
DPM12344$PathFinder[2] <- sum(na.omit(PathFinderFinalDPM)) / (244830 / 60000) - sum(na.omit(PathFinderFinalDPMwithMax)) / (244830 / 60000)

PathFinderDealRatio <- DealRatio(PathFinderDealCycle, PathFinderFinalDPMwithMax)

PathFinderDealData <- data.frame(PathFinderDealCycle$Skills, PathFinderDealCycle$Time, PathFinderDealCycle$Restraint4, PathFinderFinalDPMwithMax, PathFinderFinalDPM-PathFinderFinalDPMwithMax)
colnames(PathFinderDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(PathFinderDealData, PathFinderDealData$R4>0)

PathFinderRR <- PathFinderDealData[59:445, ]
DPM12344$PathFinder[3] <- sum((PathFinderRR$Deal))

PathFinder40s <- PathFinderDealData[27:912, ]
DPM12344$PathFinder[4] <- sum((PathFinder40s$Deal))



## Skip Add Delay 60ms
DealCycle <- c("Skills", "Time", rownames(PathFinderBuff))
PathFinderDealCycle60 <- t(rep(0, length(DealCycle)))
colnames(PathFinderDealCycle60) <- DealCycle
PathFinderDealCycle60 <- data.frame(PathFinderDealCycle60)

PathFinderDealCycle60 <- PathFinderCycle(PreDealCycle=PathFinderDealCycle60, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal,
                                       SummonedFinal=SummonedFinal, 
                                       Spec=PathFinderSpec,
                                       SkipStructure=PathFinderSkipATK,
                                       Period=120, CycleTime=240, SkipAddDelay=60)
PathFinderDealCycle60 <- PathFinderAddATK(DealCycle=PathFinderDealCycle60, 
                                        ATKFinal=ATKFinal,
                                        SummonedFinal=SummonedFinal,
                                        BarrierDuration=10 + floor(PathFinderCore[[2]][3, 2])/5)
PathFinderDealCycle60Reduction <- DealCycleReduction(PathFinderDealCycle60)

PathFinder60ms <- DealCalc(PathFinderDealCycle60, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpecOpt2)
PathFinder60ms <- DealCalcWithMaxDMR(PathFinderDealCycle60, ATKFinal, BuffFinal, SummonedFinal, PathFinderSpecOpt2)

PathFinder60msDPM <- sum(na.omit(PathFinder60ms)) / (245070 / 60000)

PathFinderDealData60ms <- data.frame(PathFinderDealCycle60$Skills, PathFinderDealCycle60$Time, PathFinderDealCycle60$Restraint4, PathFinder60ms)
colnames(PathFinderDealData60ms) <- c("Skills", "Time", "R4", "Deal")

subset(PathFinderDealData60ms, PathFinderDealData60ms$R4>0)

PathFinder60msRR <- PathFinderDealData60ms[59:440, ]
PathFinder60msRR <- sum((PathFinder60msRR$Deal))

PathFinder60ms40s <- PathFinderDealData60ms[27:903, ]
PathFinder60ms40s <- sum((PathFinder60ms40s$Deal))
