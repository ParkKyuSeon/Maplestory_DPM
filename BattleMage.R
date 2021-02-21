## BattleMage - Data
## BattleMage - VMatrix
BattleMageCore <- MatrixSet(PasSkills=c("FinishBlow", "DarkLightning", "DarkGenesis", "Death", "BattleKingBar", "DarkChain"), 
                            PasLvs=c(50, 50, 50, 50, 50, 50), 
                            PasMP=c(10, 10, 10, 10, 10, 10), 
                            ActSkills=c("UnionAura", "BlackMagicAltar", "GrimReeper", "AbyssalLightning",  
                                        CommonV("Wizard", "Resistance")), 
                            ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                            ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=SpecDefault)


## BattleMage - Basic Info
BattleMageBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="BattleMage",
                       CoreData=BattleMageCore, 
                       MikhailLink=F, 
                       OtherBuffDuration=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("CygnusKnights", "Illium", "DemonAvenger", "Phantom"), 
                       MonsterLife=MLTypeI21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[27, ], 
                       Emblem=Emblem[4, ],
                       CoolReduceHat=F)


## BattleMage - Passive
{option <- factor("ATKSpeed", levels=PSkill)
value <- c(2)
YellowAura <- data.frame(option, value)

option <- factor(c("ATK", "CRR"), levels=PSkill)
value <- c(20, 15)
ArtofStaff <- data.frame(option, value)

option <- factor(c("ATK", "CRR"), levels=PSkill)
value <- c(30, 20)
StaffMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(15, 20)
BattleMastery <- data.frame(option, value)

option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
NerbStimulation <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(15)
DarkAura <- data.frame(option, value)

option <- factor(c("IGR", "FDR", "ImmuneIgnore"), levels=PSkill)
value <- c(20, 10, 10)
DebuffAura <- data.frame(option, value)

option <- factor(c("BDR", "CRR", "CDMR"), levels=PSkill)
value <- c(40 + BattleMageBase$SkillLv, 20 + ceiling(BattleMageBase$SkillLv/3), 8)
BattleRage <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70, 30 + BattleMageBase$SkillLv, + 20 + ceiling(BattleMageBase$SkillLv/2))
StaffExpert <- data.frame(option, value)

option <- factor(c("ATKP", "BDR", "IGR"), levels=PSkill)
value <- c(25 + floor(BattleMageBase$SkillLv/2), 10 + ceiling(BattleMageBase$SkillLv/3), 30 + BattleMageBase$SkillLv)
SpellBoost <- data.frame(option, value)}

BattleMagePassive <- Passive(list(YellowAura=YellowAura, ArtofStaff=ArtofStaff, StaffMastery=StaffMastery, HighWisdom=HighWisdom, BattleMastery=BattleMastery, 
                                  NerbStimulation=NerbStimulation, DarkAura=DarkAura, DebuffAura=DebuffAura, BattleRage=BattleRage, StaffExpert=StaffExpert, SpellBoost=SpellBoost))


## BattleMage - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
StaffBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((BattleMageBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(BattleMageBase$SkillLv/2))))
info <- c(900 + 30 * BattleMageBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(30, T, BattleMageBase$UnionChrs$CoolReduceP, BattleMageBase$CoolReduce), 30, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkGenesisCoolDown <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WillofLiberty <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 200, 1020, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MasterofDeath <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * BattleMageCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * BattleMageCore[[3]][2, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(BattleMageCore[[2]][5, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * BattleMageCore[[2]][8, 2]) * MapleSoldier[1, 2]) * BattleMageBase$MainStatP), 5 + floor(BattleMageCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(30, 2 * BattleMageCore[[2]][1, 2])
info <- c(30 + floor(BattleMageCore[[2]][1, 2]/3), 100, 810, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UnionAura <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 100, 720, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GrimReeperBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(35, 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AbyssalLightningBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(5, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkLightningDebuff <- rbind(data.frame(option, value), info)}

BattleMageBuff <- Buff(list(StaffBooster=StaffBooster, MapleSoldier=MapleSoldier, DarkGenesisCoolDown=DarkGenesisCoolDown, WillofLiberty=WillofLiberty, MasterofDeath=MasterofDeath, 
                            UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, UnionAura=UnionAura, 
                            GrimReeperBuff=GrimReeperBuff, AbyssalLightningBuff=AbyssalLightningBuff, DarkLightningDebuff=DarkLightningDebuff, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : StaffBooster, MapleSoldier
BattleMageAllTimeBuff <- AllTimeBuff(BattleMageBuff)


## BattleMage - Union & HyperStat & SoulWeapon
BattleMageSpec <- JobSpec(JobBase=BattleMageBase, 
                       Passive=BattleMagePassive, 
                       AllTimeBuff=BattleMageAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="Staff", 
                       UnionStance=0)

BattleMageUnionRemained <- BattleMageSpec$UnionRemained
BattleMageHyperStatBase <- BattleMageSpec$HyperStatBase
BattleMageCoolReduceType <- BattleMageSpec$CoolReduceType
BattleMageSpec <- BattleMageSpec$Spec


## BattleMage - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * BattleMageCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * BattleMageCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BattleMageCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BattleMageCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BattleMageCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * BattleMageCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## BattleMage - Attacks
## Hyper Setting : Dark Aura - Boss Killer / Debuff Aura - Elemental Reset / Shelter - CoolTime Reduce, Persist / Dark Genesis - Additional Reinforce
{option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(20 + 2 * ceiling(BattleMageSpec$SkillLv/3), ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0))), 2 * BattleMageCore[[1]][1, 2])
info <- c(330 + 3 * BattleMageSpec$SkillLv, 6, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(50, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0))), 2 * BattleMageCore[[1]][1, 2])
info <- c(300, 12, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlowUA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(50, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0))), 2 * BattleMageCore[[1]][1, 2])
info <- c(300, 13, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlowUAMOD <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(60 + BattleMageSpec$SkillLv, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][2, 2])
info <- c(225, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightning <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill) 
value <- c(20)
info <- c((500 + 20 * BattleMageCore[[2]][4, 2]) * 0.8, 5, 0, 150, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningAL <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(80 + BattleMageSpec$SkillLv, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][2, 2])
info <- c(350, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningMark <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(80 + BattleMageSpec$SkillLv, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][2, 2])
info <- c(350, 4 * (0.6 + 0.02 * BattleMageSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningMarkDGFA <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(80 + BattleMageSpec$SkillLv, ifelse(BattleMageCore[[1]][1, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][2, 2])
info <- c(350, 4 - (4 * (0.6 + 0.02 * BattleMageSpec$SkillLv)), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningMarkRemain <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(BattleMageCore[[1]][3, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][3, 2])
info <- c(220 + 4 * BattleMageSpec$SkillLv, 0.6 + 0.02 * BattleMageSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkGenesisFA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(BattleMageCore[[1]][3, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][3, 2])
info <- c(520 + 10 * BattleMageSpec$SkillLv, 8, 780, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkGenesis <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(BattleMageCore[[1]][4, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][4, 2])
info <- c(200 + BattleMageBase$ChrLv, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Death <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(BattleMageCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(50, 2 * BattleMageCore[[1]][4, 2])))
info <- c(200 + BattleMageBase$ChrLv, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathMOD <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(BattleMageCore[[1]][4, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][4, 2])
info <- c(650, 2, 180, NA, 13, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BattleKingBar1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(BattleMageCore[[1]][4, 2]>=40, 20, 0), 2 * BattleMageCore[[1]][4, 2])
info <- c(650, 5, 330, NA, 13, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BattleKingBar2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(800 + 32 * BattleMageCore[[2]][3, 2], 12, 0, 4000, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrimReeper <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(800 + 32 * BattleMageCore[[2]][3, 2], 12, 0, 2000, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrimReeperMOD <- rbind(data.frame(option, value), info)}

BattleMageATK <- Attack(list(FinishBlow=FinishBlow, FinishBlowUA=FinishBlowUA, FinishBlowUAMOD=FinishBlowUAMOD, DarkLightning=DarkLightning, DarkLightningAL=DarkLightningAL, 
                             DarkLightningMark=DarkLightningMark, DarkLightningMarkDGFA=DarkLightningMarkDGFA, DarkLightningMarkRemain=DarkLightningMarkRemain, DarkGenesisFA=DarkGenesisFA, DarkGenesis=DarkGenesis, 
                             Death=Death, DeathMOD=DeathMOD, BattleKingBar1=BattleKingBar1, BattleKingBar2=BattleKingBar2, GrimReeper=GrimReeper, GrimReeperMOD=GrimReeperMOD, 
                             SpiderInMirror=SpiderInMirror))


## BattleMage - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(800 + 32 * BattleMageCore[[2]][2, 2], 4, 690, 1125, 40, F, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlackMagicAltar <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * BattleMageCore[[2]][7, 2], 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)}

BattleMageSummoned <- Summoned(list(BlackMagicAltar=BlackMagicAltar, ResistanceLineInfantry=ResistanceLineInfantry, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, 
                                    SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## BattleMage - Deal Cycle and Deal Calculation
ATKFinal <- data.frame(BattleMageATK)
ATKFinal$Delay[c(-1, -2, -3, -10, -13, -14)] <- Delay(ATKFinal$Delay, BattleMageSpec$ATKSpeed)[c(-1, -2, -3, -10, -13, -14)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)

BuffFinal <- data.frame(BattleMageBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BattleMageSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(BattleMageSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BattleMageSpec$SummonedDuration / 100, 0)


## BattleMage - DealCycle
DealCycle <- c("Skills", "Time", rownames(BattleMageBuff))
BattleMageDealCycle <- t(rep(0, length(DealCycle)))
colnames(BattleMageDealCycle) <- DealCycle
BattleMageDealCycle <- data.frame(BattleMageDealCycle)


BattleMageCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(100), CycleTime=c(400)) {
  BuffSummonedPrior <- c("StaffBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", 
                         "WillofLiberty", "MapleWarriors2", "AbyssalLightningBuff", "UnionAura", "MasterofDeath", "GrimReeperBuff",
                         "ResistanceLineInfantry", "BlackMagicAltar", "SoulContractLink", "Restraint4")
  Times100 <- c(0.5, 0.5, 0.5, 0.5, 0, 0.5, 0.5, 1, 0.5, 1, 4, 2, 1, 0.5)
  
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times100[i]==0, Inf, Times100[i])
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
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c()
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
  KingbarCool <- 13000
  KingbarRemain <- 0
  GenesisCool <- subset(ATKFinal, rownames(ATKFinal)=="DarkGenesis")$CoolTime * 1000
  GenesisRemain <- 0
  
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
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      }
      ## Dark Genesis
      if(GenesisRemain == 0) {
        DealCycle <- DCATK(DealCycle, "DarkGenesis", ATKFinal)
        DealCycle$DarkGenesisCoolDown[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="DarkGenesisCoolDown")$Duration * 1000
        GenesisRemain <- GenesisCool - DealCycle$Time[1]
        KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
      } ## BattleKing Bar
      else if(KingbarRemain == 0) {
        DealCycle <- DCATK(DealCycle, "BattleKingBar1", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- KingbarCool - DealCycle$Time[1]
        DealCycle <- DCATK(DealCycle, "BattleKingBar2", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
      } ## Finish Blow (Union Aura & Master of Death)
      else if(DealCycle$UnionAura[nrow(DealCycle)] > 0 & DealCycle$MasterofDeath[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "FinishBlowUAMOD", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
      } ## Finish Blow (Union Aura)
      else if(DealCycle$UnionAura[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "FinishBlowUA", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
      } ## Finish Blow
      else {
        DealCycle <- DCATK(DealCycle, "FinishBlow", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
      }
    }
  
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      }
    }
  }
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
BattleMageAddATK <- function(DealCycle, ATKFinal, SummonedFinal, Spec) {
  ## Dark Lightning and Abyssal Lightning
  DC2 <- subset(DealCycle, DealCycle$Skills=="FinishBlow")
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUA"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUAMOD"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="DarkGenesis"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="BattleKingBar2"))
  DC2$Skills <- "DarkLightning"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$AbyssalLightningBuff[i] > 0 & DealCycle$Skills[i] == "DarkLightning") {
      DealCycle$Skills[i] <- "DarkLightningAL"
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "DarkLightning") {
      DealCycle$Time[i] <- DealCycle$Time[i] + 270
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("DarkLightning")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))]<0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "DarkLightningAL", 3, 270, ATKFinal)
  DealCycle <- subset(DealCycle, DealCycle$Skills!="DarkLightningALStart")
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## Black Magic Altar
  DealCycle <- DCSummonedATKs(DealCycle, "BlackMagicAltar", SummonedFinal)

  
  ## Dark Genesis Add ATK
  DC2 <- subset(DealCycle, DealCycle$Skills=="FinishBlow" & DealCycle$DarkGenesisCoolDown > 0)
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUA" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUAMOD" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="BattleKingBar2" & DealCycle$DarkGenesisCoolDown > 0))
  
  DC2$Skills <- "DarkGenesisFA"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "DarkGenesisFA") {
      DealCycle$Time[i] <- DealCycle$Time[i] + 570
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("DarkGenesisFA")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))]<0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]

  
  ## Dark Lightning Mark
  DC2 <- DealCycle[1, ]
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("BlackMagicAltar", "DarkLightningAL", "DarkLightning"))==1) {
      DealCycle$DarkLightningDebuff[i] <- 1
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesis", "BattleKingBar1", "BattleKingBar2", "FinishBlow", "FinishBlowUA", "FinishBlowUAMOD"))==1) {
      if(DealCycle$DarkLightningDebuff[i-1] == 1) {
        DealCycle$DarkLightningDebuff[i] <- 0
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMark"
      } else if(DealCycle$DarkLightningDebuff[i-1] == 0.4) {
        DealCycle$DarkLightningDebuff[i] <- 0
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMarkRemain"
      }
    } else if(DealCycle$Skills[i]=="DarkGenesisFA") {
      if(DealCycle$DarkLightningDebuff[i-1] == 1) {
        DealCycle$DarkLightningDebuff[i] <- 0.4
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMarkDGFA"
      } else if(DealCycle$DarkLightningDebuff[i-1] == 0.4) {
        DealCycle$DarkLightningDebuff[i] <- 0
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMarkRemain"
      }
    } else {
      DealCycle$DarkLightningDebuff[i] <- DealCycle$DarkLightningDebuff[i-1]
    }
  }
  DC2 <- DC2[-1, ]
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Grim Reeper
  DC2 <- subset(DealCycle, DealCycle$Skills=="GrimReeperBuff")
  DC2$Skills <- "GrimReeperDummy"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "GrimReeperDummy") {
      DealCycle$Time[i] <- ifelse(DealCycle$MasterofDeath[i] > 0, DealCycle$Time[i] + 2000, DealCycle$Time[i] + 4000)
      DealCycle$GrimReeperBuff[i] <- ifelse(DealCycle$MasterofDeath[i] > 0, DealCycle$GrimReeperBuff[i] - 2000, DealCycle$GrimReeperBuff[i] - 4000)
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("GrimReeperDummy")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:12, 14:ncol(DealCycle))] <- DealCycle[i-1, c(3:12, 14:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:12, 14:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:12, 14:ncol(DealCycle))]<0, 0, DealCycle[i, c(3:12, 14:ncol(DealCycle))])
      if(DealCycle$GrimReeperBuff[i] > 0 & DealCycle$MasterofDeath[i] == 0) {
        DealCycle$GrimReeperBuff[i] <- DealCycle$GrimReeperBuff[i] + 2000
      }
    }
  }
  
  for(j in 1:14) {
    DC2 <- subset(DealCycle, DealCycle$Skills=="GrimReeperDummy")
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$Skills[i]=="GrimReeperDummy") {
        DealCycle$Skills[i] <- "GrimReeper"
      }
    }
    DealCycle <- rbind(DealCycle, DC2)
    DealCycle <- DealCycle[order(DealCycle$Time), ] 
    rownames(DealCycle) <- 1:nrow(DealCycle)
    
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$Skills[i] == "GrimReeperDummy") {
        DealCycle$Time[i] <- ifelse(DealCycle$MasterofDeath[i] > 0, DealCycle$Time[i] + 2000, DealCycle$Time[i] + 4000)
        DealCycle$GrimReeperBuff[i] <- ifelse(DealCycle$MasterofDeath[i] > 0, DealCycle$GrimReeperBuff[i] - 2000, DealCycle$GrimReeperBuff[i] - 4000)
      }
    }
    DealCycle <- DealCycle[order(DealCycle$Time), ] 
    rownames(DealCycle) <- 1:nrow(DealCycle)
    
    for(i in 1:nrow(DealCycle)) {
      if(sum(c("GrimReeperDummy")==DealCycle[i, 1])==1) {
        DealCycle[i, c(3:12, 14:ncol(DealCycle))] <- DealCycle[i-1, c(3:12, 14:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
        DealCycle[i, c(3:12, 14:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:12, 14:ncol(DealCycle))]<0, 0, DealCycle[i, c(3:12, 14:ncol(DealCycle))])
        if(DealCycle$GrimReeperBuff[i] > 0 & DealCycle$MasterofDeath[i] == 0) {
          DealCycle$GrimReeperBuff[i] <- DealCycle$GrimReeperBuff[i] + 2000
        }
      }
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GrimReeperDummy") {
      DealCycle$Skills[i] <- "GrimReeper"
    }
  }
  Idx <- c()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GrimReeper" & DealCycle$GrimReeperBuff[i] <= 0) {
      Idx <- c(Idx, i)
    }
  }
  DealCycle <- DealCycle[-Idx, ]
  
  
  ## Death
  DeathCool <- Cooldown(5, T, Spec$CoolReduceP, Spec$CoolReduce) * 1000
  DeathRemain <- 0
  DeathStack <- 12
  DC2 <- DealCycle[1, ]
  for(i in 1:(nrow(DealCycle)-1)) {
    if(sum(DealCycle$Skills[i]==c("FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "DarkLightning", "DarkLightningAL", 
                                  "DarkLightningMark", "Death", "DeathMOD", "BlackMagicAltar"))==1 & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500)
      DeathStack <- max(0, DeathStack - 1)
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesisFA", "DarkLightningMarkDGFA"))==1 & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500 * (0.6 + 0.02 * BattleMageSpec$SkillLv))
      DeathStack <- max(0, DeathStack - (0.6 + 0.02 * BattleMageSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("DarkLightningMarkRemain"))==1 & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500 * (1 - (0.6 + 0.02 * BattleMageSpec$SkillLv)))
      DeathStack <- max(0, DeathStack - (1 - (0.6 + 0.02 * BattleMageSpec$SkillLv)))
    } else if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "DarkLightning", "DarkLightningAL", 
                                         "DarkLightningMark", "Death", "DeathMOD", "BattleKingBar1", "BattleKingBar2", "GrimReeper", "GrimReeperMOD", "BlackMagicAltar"))==1) {
      DeathStack <- max(0, DeathStack - 1)
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesisFA", "DarkLightningMarkDGFA"))==1) {
      DeathStack <- max(0, DeathStack - (0.6 + 0.02 * BattleMageSpec$SkillLv))
    } else if(sum(DealCycle$Skills[i]==c("DarkLightningMarkRemain"))==1) {
      DeathStack <- max(0, DeathStack - (1 - (0.6 + 0.02 * BattleMageSpec$SkillLv)))
    }
    if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "BattleKingBar1", "BattleKingBar2"))==1 & 
       DeathRemain == 0 & DeathStack == 0) {
      DC2 <- rbind(DC2, DealCycle[i, ])
      DeathRemain <- DeathCool
      DeathStack <- ifelse(DealCycle$MasterofDeath[i] > 0, 2, 12)
    }
    DeathRemain <- max(0, DeathRemain - (DealCycle$Time[i+1] - DealCycle$Time[i]))
  }
  for(i in 1:nrow(DC2)) {
    if(DC2$MasterofDeath[i] > 0) {
      DC2$Skills[i] <- "DeathMOD"
    } else {
      DC2$Skills[i] <- "Death"
    }
  }
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Resistance Line Infantry, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, c("ResistanceLineInfantry"), SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkLightning", "DarkLightningAL", "DarkLightningMark", "DarkLightningMarkDGFA",
                                  "DarkLightningMarkRemain", "DarkGenesis", "BattleKingBar1", "BattleKingBar2", "ResistanceLineInfantry", "BlackMagicAltar"))==1) {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  return(DealCycle)
}


BattleMageDealCycle <- BattleMageCycle(PreDealCycle=BattleMageDealCycle, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal,
                                       SummonedFinal=SummonedFinal, 
                                       Spec=BattleMageSpec)
BattleMageDealCycle <- BattleMageAddATK(DealCycle=BattleMageDealCycle, 
                                         ATKFinal=ATKFinal, 
                                         SummonedFinal=SummonedFinal,
                                         Spec=BattleMageSpec)
BattleMageDealCycleReduction <- DealCycleReduction(BattleMageDealCycle)

DealCalc(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpec)
BattleMageDealData <- data.frame(BattleMageDealCycle$Skills, DealCalc(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpec))
colnames(BattleMageDealData) <- c("Skills", "Deal")

## Damage Optimization
BattleMageSpecOpt1 <- Optimization1(BattleMageDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpec, BattleMageUnionRemained)
BattleMageSpecOpt <- BattleMageSpec
BattleMageSpecOpt$ATKP <- BattleMageSpecOpt$ATKP + BattleMageSpecOpt1$ATKP
BattleMageSpecOpt$BDR <- BattleMageSpecOpt$BDR + BattleMageSpecOpt1$BDR
BattleMageSpecOpt$IGR <- IGRCalc(c(BattleMageSpecOpt$IGR, BattleMageSpecOpt1$IGR))

BattleMageSpecOpt2 <- Optimization2(BattleMageDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt, BattleMageHyperStatBase, BattleMageBase$ChrLv, BattleMageBase$CRROver)
BattleMageFinalDPM <- DealCalc(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt2)
BattleMageFinalDPMwithMax <- DealCalcWithMaxDMR(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt2)

DPM12338$BattleMage[1] <- sum(na.omit(BattleMageFinalDPMwithMax)) / (405300 / 60000)
DPM12338$BattleMage[2] <- sum(na.omit(BattleMageFinalDPM)) / (405300 / 60000) - sum(na.omit(BattleMageFinalDPMwithMax)) / (405300 / 60000)

BattleMageDealRatio <- DealRatio(BattleMageDealCycle, BattleMageFinalDPMwithMax)

BattleMageDealData <- data.frame(BattleMageDealCycle$Skills, BattleMageDealCycle$Time, BattleMageDealCycle$Restraint4, BattleMageFinalDPMwithMax, BattleMageFinalDPM-BattleMageFinalDPMwithMax)
colnames(BattleMageDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(BattleMageDealData, BattleMageDealData$R4>0)

BattleMageRR <- BattleMageDealData[19:210, ]
DPM12338$BattleMage[3] <- sum((BattleMageRR$Deal))

BattleMage40s <-  BattleMageDealData[19:501, ]
DPM12338$BattleMage[4] <- sum((BattleMage40s$Deal))