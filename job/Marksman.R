## Marksman - Data
## Marksman - VMatrix
MarksmanCore <- MatrixSet(PasSkills=c("Snipe", "Piercing", "Freezer", "FinalAttack"), 
                        PasLvs=c(50, 50, 50, 50), 
                        PasMP=c(10, 10, 5, 5), 
                        ActSkills=c("TrueSnipe", "SplitArrow", "ChargedArrow", "FullbustShot",
                                    CommonV("Bowman", "Adventure")), 
                        ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                        ActMP=c(5, 5, 5, 5, 5, 5, 5, 5, 5), 
                        BlinkLv=1, 
                        BlinkMP=0, 
                        UsefulSkills=c("CombatOrders"), 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=SpecDefault,
                        SelfBind=F)



## Marksman - Basic Info
MarksmanBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Marksman",
                       CoreData=MarksmanCore, 
                       BuffDurationNeeded=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("AdventureBowman", "Mikhail", "DemonAvenger", "Phantom"), 
                       MonsterLife=MLTypeD21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[8, ], 
                       Emblem=Emblem[1, ],
                       CoolReduceHat=F)


## Marksman - Passive
{option <- factor("ATKSpeed", levels=PSkill)
value <- c(1)
ArcherMastery <- data.frame(option, value)
  
option <- factor("CRR", levels=PSkill)
value <- c(40)
CriticalShot <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(20)
CrossbowMastery <- data.frame(option, value)

option <- factor("CDMR", levels=PSkill)
value <- c(20)
ExtremeArchery <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(25, 15)
Marksmanship <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(MarksmanBase$PSkillLv/2), 30 + MarksmanBase$PSkillLv, 15)
CrossbowExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40 + MarksmanBase$PSkillLv)
IllusionStep <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(15 + MarksmanBase$PSkillLv)
AdditionalBolt <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(MarksmanCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

MarksmanPassive <- Passive(list(ArcherMastery, CriticalShot, PhysicalTraining, CrossbowMastery, ExtremeArchery, Marksmanship, 
                                IllusionStep, CrossbowExpert, AdditionalBolt, BlinkPassive))


## Marksman - Buff
Distance <- 400
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrossbowBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(300, NA, 840, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulArrow <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MarksmanBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MarksmanBase$SkillLv/2))))
info <- c(900 + 30 * MarksmanBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(MarksmanBase$SkillLv/2), 15 + ceiling(MarksmanBase$SkillLv/2))
info <- c(300 + 3 * MarksmanBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MarksmanCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR", "IGR", "BDR"), levels=BSkill)
value <- c(20, 10, 20, 20)
info <- c(30, 90, 960, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bullseye <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 810, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SplitArrowBuff <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 660, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FullbustShotBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * MarksmanCore[[2]][8, 2]) * MapleSoldier[1, 2]) * MarksmanBase$MainStatP), 5 + floor(MarksmanCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(IGRCalc(c(12, 23)))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Distance0 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(12)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DistanceSenseTrueSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(ifelse(Distance>=200, min(12, floor((Distance-200)/18)*2), 0), 
           ifelse(Distance<200, min(12, floor((200-Distance)/18)*2), 0))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DistancingSense <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(min(23 + floor(Distance/40) * 3, 50 + MarksmanBase$PSkillLv))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaknessFinding <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(10 + MarksmanBase$PSkillLv)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LastmanStanding <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(2)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MotalBlow <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(20 * (0.2 + 0.01 * MarksmanCore[[2]][6, 2]))
info <- c(0, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Synergy <- rbind(data.frame(option, value), info)}

MarksmanBuff <- Buff(list(CrossbowBooster=CrossbowBooster, SoulArrow=SoulArrow, MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, 
                          UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                          SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, CriticalReinforce=CriticalReinforce, Synergy=Synergy, Distance0=Distance0, DistanceSenseTrueSnipe=DistanceSenseTrueSnipe, 
                          DistancingSense=DistancingSense, WeaknessFinding=WeaknessFinding, LastmanStanding=LastmanStanding, MotalBlow=MotalBlow, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))
### PetBuff : CrossbowBooster(990ms), UsefulCombatOrders(1500ms), SharpEyes(900ms)
MarksmanAllTimeBuff <- AllTimeBuff(MarksmanBuff)


## Marksman - Union & HyperStat & SoulWeapon
MarksmanSpec <- JobSpec(JobBase=MarksmanBase, 
                        Passive=MarksmanPassive, 
                        AllTimeBuff=MarksmanAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="Crossbow", 
                        UnionStance=0)

MarksmanUnionRemained <- MarksmanSpec$UnionRemained
MarksmanHyperStatBase <- MarksmanSpec$HyperStatBase
MarksmanCoolReduceType <- MarksmanSpec$CoolReduceType
MarksmanSpec <- MarksmanSpec$Spec


## Marksman - CriticalReinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(MarksmanSpec$CRR * (0.2 + 0.01 * MarksmanCore[[2]][6, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}

MarksmanBuff <- Buff(list(CrossbowBooster=CrossbowBooster, SoulArrow=SoulArrow, MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, 
                          UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                          SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, CriticalReinforce=CriticalReinforce, Synergy=Synergy, Distance0=Distance0, DistanceSenseTrueSnipe=DistanceSenseTrueSnipe, 
                          DistancingSense=DistancingSense, WeaknessFinding=WeaknessFinding, LastmanStanding=LastmanStanding, MotalBlow=MotalBlow, MapleWarriors2=MapleWarriors2, 
                          Restraint4=Restraint4, SoulContractLink=SoulContractLink))


## Marksman - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MarksmanCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MarksmanCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Marksman - Attacks
{option <- factor(c("IGR", "BDR", "CRR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(25 + ceiling(MarksmanSpec$SkillLv/3)*2, ifelse(MarksmanCore[[1]][1, 2]>=40, 20, 0))), 
           30, 100, 2 * MarksmanCore[[1]][1, 2])
info <- c(465 + MarksmanSpec$SkillLv * 5, 10, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Snipe <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * MarksmanCore[[2]][2, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SplitArrow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrowStart <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "CRR"), levels=ASkill)
value <- c(50, 100)
info <- c(750 + 30 * MarksmanCore[[2]][3, 2], 11, 480, NA, 10, T, F, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "CRR"), levels=ASkill)
value <- c(50, 100)
info <- c(500 + 20 * MarksmanCore[[2]][3, 2], 11, 480, NA, 10, T, F, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrowUncharged <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR"), levels=ASkill)
value <- c(100, 100, 100)
info <- c(0, 0, 150, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TrueSnipeStart <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR"), levels=ASkill)
value <- c(100, 100, 100)
info <- c(950 + 30 * MarksmanCore[[2]][1, 2], 15, 900, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TrueSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(25)
info <- c(300 + 12 * MarksmanCore[[2]][4, 2], 40, 1080, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FullbustShot <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MarksmanCore[[1]][4, 2]>=40, 20, 0), 4 * MarksmanCore[[1]][4, 2])
info <- c(140, 0.4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)}

MarksmanATK <- Attack(list(Snipe=Snipe, SplitArrow=SplitArrow, ChargedArrowStart=ChargedArrowStart, ChargedArrow=ChargedArrow, ChargedArrowUncharged=ChargedArrowUncharged, 
                           TrueSnipe=TrueSnipe, TrueSnipeStart=TrueSnipeStart, FullbustShot=FullbustShot, FinalAttack=FinalAttack, 
                           SpiderInMirror=SpiderInMirror))


## Marksman - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 15 * MarksmanCore[[2]][7, 2], 7, 600, 3030, 40, 105, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Evolve <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * MarksmanCore[[1]][3, 2], ifelse(MarksmanCore[[1]][3, 2]>=40, 20, 0))
info <- c(390, 1, 0, 1710, 220, 105, T, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Freezer <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * MarksmanCore[[2]][5, 2], 1, 720, 500, 0.5*89+0.72+0.01, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
GuidedArrow <- rbind(data.frame(option, value), info)}

MarksmanSummoned <- Summoned(list(Evolve=Evolve, Freezer=Freezer, GuidedArrow=GuidedArrow, SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Marksman - DealCycle & Deal Calculation
ATKFinal <- data.frame(MarksmanATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, MarksmanSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)

BuffFinal <- data.frame(MarksmanBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MarksmanSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(MarksmanSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MarksmanSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(MarksmanBuff))
MarksmanDealCycle <- t(rep(0, length(DealCycle)))
colnames(MarksmanDealCycle) <- DealCycle

MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("CrossbowBooster", "SoulArrow", "SharpEyes", "MapleSoldier", "UsefulCombatOrders"), BuffFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("SpiderInMirror"), ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="Evolve", SummonedFinal)
MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("FullbustShotBuff", "MapleWarriors2", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "Restraint4", "EpicAdventure"), BuffFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("FullbustShot", 8)), T, ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("TrueSnipeStart", rep("TrueSnipe", 7)), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 13)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 14)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 7)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="Evolve", SummonedFinal)
MarksmanDealCycle <- DCBuff(MarksmanDealCycle, c("FullbustShotBuff", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "EpicAdventure"), BuffFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("FullbustShot"), ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("FullbustShot"), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("FullbustShot", 6), rep("Snipe", 12)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 9)), T, ATKFinal)
MarksmanDealCycle <- DCSummoned(MarksmanDealCycle, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("Snipe"), ATKFinal)
MarksmanDealCycle <- DCATK(MarksmanDealCycle, c("Snipe"), ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle <- ChargedArrowCycle(MarksmanDealCycle, c(rep("Snipe", 14)), T, ATKFinal)

MarksmanDealCycle <- DealCycleFinal(MarksmanDealCycle)
MarksmanDealCycle <- AddATKsCycle(MarksmanDealCycle)
MarksmanDealCycle <- DCSummonedATKs(MarksmanDealCycle, Skill=c("GuidedArrow", "Evolve"), SummonedFinal)
MarksmanDealCycle <- DCSpiderInMirror(MarksmanDealCycle, SummonedFinal)
MarksmanDealCycle <- EvolveCycle(MarksmanDealCycle)
MarksmanDealCycle <- MarksmanSynergy(MarksmanDealCycle)
MarksmanDealCycle <- MarksmanDistance(MarksmanDealCycle)

MarksmanDealCycleReduction <- DealCycleReduction(MarksmanDealCycle)

DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec)
MarksmanDealData <- data.frame(MarksmanDealCycle$Skills, DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec))
colnames(MarksmanDealData) <- c("Skills", "Deal")


## Damage Optimization
MarksmanSpecOpt1 <- Optimization1(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec, MarksmanUnionRemained)
MarksmanSpecOpt <- MarksmanSpec
MarksmanSpecOpt$ATKP <- MarksmanSpecOpt$ATKP + MarksmanSpecOpt1$ATKP
MarksmanSpecOpt$BDR <- MarksmanSpecOpt$BDR + MarksmanSpecOpt1$BDR
MarksmanSpecOpt$IGR <- IGRCalc(c(MarksmanSpecOpt$IGR, MarksmanSpecOpt1$IGR))

MarksmanSpecOpt2 <- Optimization2(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt, MarksmanHyperStatBase, MarksmanBase$ChrLv, MarksmanBase$CRROver)
MarksmanFinalDPM <- DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)
MarksmanFinalDPMwithMax <- DealCalcWithMaxDMR(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)
sum(na.omit(MarksmanFinalDPM - MarksmanFinalDPMwithMax))

DPM12347$Marksman[1] <- sum(na.omit(MarksmanFinalDPMwithMax))/(max(MarksmanDealCycle$Time)/60000)
DPM12347$Marksman[2] <- sum(na.omit(MarksmanFinalDPM))/(max(MarksmanDealCycle$Time)/60000) - sum(na.omit(MarksmanFinalDPMwithMax))/(max(MarksmanDealCycle$Time)/60000)


## Restraint Deal and 40s Damage
MRestraint <- data.frame(MarksmanDealCycle$Skills, MarksmanFinalDPMwithMax, MarksmanDealCycle$Time, MarksmanDealCycle$Restraint4)
colnames(MRestraint) <- c("Skills", "Damage", "Time", "R4")
MRestraint <- subset(MRestraint, MRestraint$R4>0)
DPM12347$Marksman[3] <- sum(MRestraint$Damage)

Marksman40s <- data.frame(MarksmanDealCycle$Skills, MarksmanFinalDPMwithMax, MarksmanDealCycle$Time, MarksmanDealCycle$Restraint4)
colnames(Marksman40s) <- c("Skills", "Damage", "Time", "R4")
Marksman40s <- Marksman40s[35:356, ]
DPM12347$Marksman[4] <- sum((Marksman40s$Damage))


## Marksman Deal Ratio
MarksmanDealRatio <- DealRatio(MarksmanDealCycle, MarksmanFinalDPMwithMax)


## Distance 0
Distance <- 100
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrossbowBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(300, NA, 840, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulArrow <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MarksmanBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MarksmanBase$SkillLv/2))))
info <- c(900 + 30 * MarksmanBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(20 + ceiling(MarksmanBase$SkillLv/2), 15 + ceiling(MarksmanBase$SkillLv/2))
info <- c(300 + 3 * MarksmanBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MarksmanCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR", "IGR", "BDR"), levels=BSkill)
value <- c(20, 10, 20, 20)
info <- c(30, 90, 960, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bullseye <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 810, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SplitArrowBuff <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(T)
info <- c(60, 120, 660, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FullbustShotBuff <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(MarksmanSpec$CRR * (0.2 + 0.01 * MarksmanCore[[2]][6, 2]))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * MarksmanCore[[2]][8, 2]) * MapleSoldier[1, 2]) * MarksmanBase$MainStatP), 5 + floor(MarksmanCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(IGRCalc(c(12, 23)))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Distance0 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(12)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DistanceSenseTrueSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(ifelse(Distance>=200, min(12, floor((Distance-200)/18)*2), 0), 
           ifelse(Distance<200, min(12, floor((200-Distance)/18)*2), 0))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DistancingSense <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(min(23 + floor(Distance/40) * 3, 50 + MarksmanBase$PSkillLv))
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaknessFinding <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(10 + MarksmanBase$PSkillLv)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LastmanStanding <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(2)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MotalBlow <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(20 * (0.2 + 0.01 * MarksmanCore[[2]][6, 2]))
info <- c(0, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Synergy <- rbind(data.frame(option, value), info)}
MarksmanBuff2 <- Buff(list(CrossbowBooster=CrossbowBooster, SoulArrow=SoulArrow, MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, 
                           UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                           SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, CriticalReinforce=CriticalReinforce, Synergy=Synergy, Distance0=Distance0, DistanceSenseTrueSnipe=DistanceSenseTrueSnipe, 
                           DistancingSense=DistancingSense, WeaknessFinding=WeaknessFinding, LastmanStanding=LastmanStanding, MotalBlow=MotalBlow, MapleWarriors2=MapleWarriors2, 
                           Restraint4=Restraint4, SoulContractLink=SoulContractLink))

BuffFinal <- data.frame(MarksmanBuff2)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MarksmanSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

DealCycle <- c("Skills", "Time", rownames(MarksmanBuff))
MarksmanDealCycle0 <- t(rep(0, length(DealCycle)))
colnames(MarksmanDealCycle0) <- DealCycle

{MarksmanDealCycle0 <- DCBuff(MarksmanDealCycle0, c("CrossbowBooster", "SoulArrow", "SharpEyes", "MapleSoldier", "UsefulCombatOrders"), BuffFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("SpiderInMirror"), ATKFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="Evolve", SummonedFinal)
MarksmanDealCycle0 <- DCBuff(MarksmanDealCycle0, c("FullbustShotBuff", "MapleWarriors2", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "Restraint4", "EpicAdventure"), BuffFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("FullbustShot", 8)), T, ATKFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("TrueSnipeStart", rep("TrueSnipe", 7)), ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 13)), T, ATKFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 14)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 7)), T, ATKFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="Evolve", SummonedFinal)
MarksmanDealCycle0 <- DCBuff(MarksmanDealCycle0, c("FullbustShotBuff", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "EpicAdventure"), BuffFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("FullbustShot"), ATKFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("FullbustShot"), ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("FullbustShot", 6), rep("Snipe", 12)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 9)), T, ATKFinal)
MarksmanDealCycle0 <- DCSummoned(MarksmanDealCycle0, Skill="GuidedArrow", SummonedFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("Snipe"), ATKFinal)
MarksmanDealCycle0 <- DCATK(MarksmanDealCycle0, c("Snipe"), ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 18)), T, ATKFinal)
MarksmanDealCycle0 <- ChargedArrowCycle(MarksmanDealCycle0, c(rep("Snipe", 14)), T, ATKFinal)

MarksmanDealCycle0 <- DealCycleFinal(MarksmanDealCycle0)
MarksmanDealCycle0 <- AddATKsCycle(MarksmanDealCycle0)
MarksmanDealCycle0 <- DCSummonedATKs(MarksmanDealCycle0, Skill=c("GuidedArrow", "Evolve"), SummonedFinal)
MarksmanDealCycle0 <- DCSpiderInMirror(MarksmanDealCycle0, SummonedFinal)
MarksmanDealCycle0 <- EvolveCycle(MarksmanDealCycle0)
MarksmanDealCycle0 <- MarksmanSynergy(MarksmanDealCycle0)
MarksmanDealCycle0 <- MarksmanDistance(MarksmanDealCycle0)

MarksmanDealCycle0Reduction <- DealCycleReduction(MarksmanDealCycle0)}

MarksmanFinalDPM0 <- DealCalc(MarksmanDealCycle0, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)
MarksmanFinalDPMwithMax0 <- DealCalcWithMaxDMR(MarksmanDealCycle0, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt2)

Marksman0 <- sum(na.omit(MarksmanFinalDPMwithMax0))/(max(MarksmanDealCycle0$Time)/60000)

MRestraint0 <- data.frame(MarksmanDealCycle0$Skills, MarksmanFinalDPMwithMax0, MarksmanDealCycle0$Time, MarksmanDealCycle0$Restraint4)
colnames(MRestraint0) <- c("Skills", "Damage", "Time", "R4")
MRestraint0 <- subset(MRestraint0, MRestraint0$R4>0)
MarksmanR40 <- sum(MRestraint0$Damage)

Marksman40s0 <- data.frame(MarksmanDealCycle0$Skills, MarksmanFinalDPMwithMax0, MarksmanDealCycle0$Time, MarksmanDealCycle0$Restraint4)
colnames(Marksman40s0) <- c("Skills", "Damage", "Time", "R4")
Marksman40s0 <- Marksman40s0[35:356, ]
Marksman40s0 <- sum(Marksman40s0$Damage)