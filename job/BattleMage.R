## BattleMage - Data
## BattleMage - VMatrix
BattleMageCoreBase <- CoreBuilder(ActSkills=c("UnionAura", "BlackMagicAltar", "GrimReeper", "AbyssalLightning", CommonV("Wizard", "Resistance")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                  UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=BattleMageVPassive, 
                                  VPassivePrior=BattleMageVPrior, 
                                  SelfBind=F)

BattleMageCore <- MatrixSet(PasSkills=BattleMageCoreBase$PasSkills$Skills, 
                            PasLvs=BattleMageCoreBase$PasSkills$Lv, 
                            PasMP=BattleMageCoreBase$PasSkills$MP, 
                            ActSkills=BattleMageCoreBase$ActSkills$Skills, 
                            ActLvs=BattleMageCoreBase$ActSkills$Lv, 
                            ActMP=BattleMageCoreBase$ActSkills$MP, 
                            UsefulSkills=BattleMageCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=BattleMageCoreBase$SpecialCoreUse)


## BattleMage - Basic Info
BattleMageBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="BattleMage",
                          CoreData=BattleMageCore, 
                          BuffDurationNeeded=0, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "BattleMage"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "BattleMage"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "BattleMage")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="MagicBead", ],
                          Emblem=Emblem[rownames(Emblem)=="Resistance", ],
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "BattleMage")))


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
value <- c(25, 20)
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
value <- c(40 + BattleMageBase$SkillLv, 20 + ceiling(BattleMageBase$SkillLv/3), 10)
BattleRage <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(BattleMageBase$SkillLv/2), 30 + BattleMageBase$SkillLv, 20 + ceiling(BattleMageBase$SkillLv/2))
StaffExpert <- data.frame(option, value)

option <- factor(c("ATKP", "BDR", "IGR"), levels=PSkill)
value <- c(25 + floor(BattleMageBase$SkillLv/2), 10 + ceiling(BattleMageBase$SkillLv/3), 30 + BattleMageBase$SkillLv)
SpellBoost <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(BattleMageCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(BattleMageCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

BattleMagePassive <- Passive(list(YellowAura=YellowAura, ArtofStaff=ArtofStaff, StaffMastery=StaffMastery, HighWisdom=HighWisdom, BattleMastery=BattleMastery, 
                                  NerbStimulation=NerbStimulation, DarkAura=DarkAura, DebuffAura=DebuffAura, BattleRage=BattleRage, StaffExpert=StaffExpert, SpellBoost=SpellBoost, BlinkPassive=BlinkPassive, 
                                  RopeConnectPassive=RopeConnectPassive))


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

Useful <- UsefulSkills(BattleMageCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(BattleMageCore, "OverloadMana")/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(BattleMageCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * BattleMageBase$MainStatP), 5 + floor(GetCoreLv(BattleMageCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(30, 2 * GetCoreLv(BattleMageCore, "UnionAura"))
info <- c(30 + floor(GetCoreLv(BattleMageCore, "UnionAura")/3), 100, 810, F, T, F, T)
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
info <- c(40, 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AbyssalLightningBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(5, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarkLightningDebuff <- rbind(data.frame(option, value), info)}


BattleMageBuff <- list(StaffBooster=StaffBooster, MapleSoldier=MapleSoldier, DarkGenesisCoolDown=DarkGenesisCoolDown, WillofLiberty=WillofLiberty, MasterofDeath=MasterofDeath, 
                       UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                       OverloadMana=OverloadMana, MapleWarriors2=MapleWarriors2, UnionAura=UnionAura, 
                       GrimReeperBuff=GrimReeperBuff, AbyssalLightningBuff=AbyssalLightningBuff, DarkLightningDebuff=DarkLightningDebuff, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  BattleMageBuff[[length(BattleMageBuff)+1]] <- UsefulAdvancedBless
  names(BattleMageBuff)[[length(BattleMageBuff)]] <- "UsefulAdvancedBless"
}
BattleMageBuff <- Buff(BattleMageBuff)
## PetBuff : StaffBooster, MapleSoldier, UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
BattleMageAllTimeBuff <- AllTimeBuff(BattleMageBuff)


## BattleMage - Union & HyperStat & SoulWeapon
BattleMageSpec <- JobSpec(JobBase=BattleMageBase, 
                          Passive=BattleMagePassive, 
                          AllTimeBuff=BattleMageAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="Staff", 
                          UnionStance=0,
                          JobConstant=1.2)

BattleMageUnionRemained <- BattleMageSpec$UnionRemained
BattleMageHyperStatBase <- BattleMageSpec$HyperStatBase
BattleMageCoolReduceType <- BattleMageSpec$CoolReduceType
BattleMageSpec <- BattleMageSpec$Spec


## BattleMage - Spider In Mirror
SIM <- SIMData(GetCoreLv(BattleMageCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## BattleMage - Attacks
## Hyper Setting : Dark Aura - Boss Killer / Debuff Aura - Elemental Reset / Shelter - CoolTime Reduce, Persist / Dark Genesis - Additional Reinforce
{option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(20 + 2 * ceiling(BattleMageSpec$SkillLv/3), ifelse(GetCoreLv(BattleMageCore, "FinishBlow")>=40, 20, 0))), 2 * GetCoreLv(BattleMageCore, "FinishBlow"))
info <- c(330 + 3 * BattleMageSpec$SkillLv, 6, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(50, ifelse(GetCoreLv(BattleMageCore, "FinishBlow")>=40, 20, 0))), 2 * GetCoreLv(BattleMageCore, "FinishBlow"))
info <- c(300, 12, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlowUA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(50, ifelse(GetCoreLv(BattleMageCore, "FinishBlow")>=40, 20, 0))), 2 * GetCoreLv(BattleMageCore, "FinishBlow"))
info <- c(300, 13, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinishBlowUAMOD <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(60 + BattleMageSpec$SkillLv, ifelse(GetCoreLv(BattleMageCore, "DarkLightning")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "DarkLightning"))
info <- c(225, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightning <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill) 
value <- c(20)
info <- c(800 + 32 * GetCoreLv(BattleMageCore, "AbyssalLightning"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningAL <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(80 + BattleMageSpec$SkillLv, ifelse(GetCoreLv(BattleMageCore, "DarkLightning")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "DarkLightning"))
info <- c(350, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningMark <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(80 + BattleMageSpec$SkillLv, ifelse(GetCoreLv(BattleMageCore, "DarkLightning")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "DarkLightning"))
info <- c(350, 4 * (0.6 + 0.02 * BattleMageSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkLightningMarkDGFA <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(GetCoreLv(BattleMageCore, "DarkGenesis")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "DarkGenesis"))
info <- c(220 + 4 * BattleMageSpec$SkillLv, 0.6 + 0.02 * BattleMageSpec$SkillLv, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkGenesisFA <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(BattleMageCore, "DarkGenesis")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "DarkGenesis"))
info <- c(520 + 10 * BattleMageSpec$SkillLv, 8, 900, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DarkGenesis <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(BattleMageCore, "Death")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "Death"))
info <- c(200 + BattleMageBase$ChrLv, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Death <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(BattleMageCore, "Death")>=40, 20, 0), FDRCalc(c(50, 2 * GetCoreLv(BattleMageCore, "Death"))))
info <- c(200 + BattleMageBase$ChrLv, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeathMOD <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(BattleMageCore, "BattleKingBar")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "BattleKingBar"))
info <- c(650, 2, 240, NA, 13, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BattleKingBar1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(BattleMageCore, "BattleKingBar")>=40, 20, 0), 2 * GetCoreLv(BattleMageCore, "BattleKingBar"))
info <- c(650, 5, 300, NA, 13, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BattleKingBar2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(800 + 32 * GetCoreLv(BattleMageCore, "GrimReeper"), 12, 0, 4000, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrimReeper <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(800 + 32 * GetCoreLv(BattleMageCore, "GrimReeper"), 12, 0, 2000, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GrimReeperMOD <- rbind(data.frame(option, value), info)}

BattleMageATK <- Attack(list(FinishBlow=FinishBlow, FinishBlowUA=FinishBlowUA, FinishBlowUAMOD=FinishBlowUAMOD, DarkLightning=DarkLightning, DarkLightningAL=DarkLightningAL, 
                             DarkLightningMark=DarkLightningMark, DarkLightningMarkDGFA=DarkLightningMarkDGFA, DarkGenesisFA=DarkGenesisFA, DarkGenesis=DarkGenesis, 
                             Death=Death, DeathMOD=DeathMOD, BattleKingBar1=BattleKingBar1, BattleKingBar2=BattleKingBar2, GrimReeper=GrimReeper, GrimReeperMOD=GrimReeperMOD, 
                             SpiderInMirror=SpiderInMirror))


## BattleMage - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(800 + 32 * GetCoreLv(BattleMageCore, "BlackMagicAltar"), 4, 690, 1140, 40, 50, F, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
BlackMagicAltar <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * GetCoreLv(BattleMageCore, "ResistanceLineInfantry"), 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)}

BattleMageSummoned <- Summoned(list(BlackMagicAltar=BlackMagicAltar, ResistanceLineInfantry=ResistanceLineInfantry, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, 
                                    SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## BattleMage - Deal Cycle and Deal Calculation
ATKFinal <- data.frame(BattleMageATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, BattleMageSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)

BuffFinal <- data.frame(BattleMageBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BattleMageSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(BattleMageSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BattleMageSpec$CoolReduceP, BattleMageSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BattleMageSpec$SummonedDuration / 100, 0)

BattleMageDL <- function(ATKFinal, TeleportDelay=90) {
  TelshotSkills <- c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "BattleKingBar2")
  ATKFinal2 <- ATKFinal[1, ]
  ATKFinal2 <- ATKFinal2[-1, ]
  for(i in 1:nrow(ATKFinal)) {
    if(sum(rownames(ATKFinal)[i]==TelshotSkills)==1) {
      ATKFinal2 <- rbind(ATKFinal2, ATKFinal[i, ])
      rownames(ATKFinal2)[nrow(ATKFinal2)] <- paste(rownames(ATKFinal2)[nrow(ATKFinal2)], "DL", sep="")
      ATKFinal2$Delay[nrow(ATKFinal2)] <- ATKFinal2$Delay[nrow(ATKFinal2)] + TeleportDelay
    }
  }
  ATKFinal <- rbind(ATKFinal, ATKFinal2)
  return(ATKFinal)
}
ATKFinal_Delay0 <- BattleMageDL(ATKFinal, 0)
ATKFinal_Delay180 <- BattleMageDL(ATKFinal, 180)
ATKFinal <- BattleMageDL(ATKFinal, 90)

## BattleMage - DealCycle
DealCycle <- c("Skills", "Time", rownames(BattleMageBuff))
BattleMageDealCycle <- t(rep(0, length(DealCycle)))
colnames(BattleMageDealCycle) <- DealCycle
BattleMageDealCycle <- data.frame(BattleMageDealCycle)


BattleMageCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                            Period=c(100), CycleTime=c(400)) {
  BuffSummonedPrior <- c("StaffBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "WillofLiberty", "MapleWarriors2", "AbyssalLightningBuff", "UnionAura", "MasterofDeath", "GrimReeperBuff",
                         "ResistanceLineInfantry", "BlackMagicAltar", "SoulContractLink", "Restraint4")
  Times100 <- c(0.5, 0.5, 0, 0, 0, 0, 0.5, 0.5, 1, 0.5, 1, 4, 2, 1, 0.5)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times100 <- Times100[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
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
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
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
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      }
      ## Dark Genesis
      if(GenesisRemain == 0) {
        if(DealCycle$AbyssalLightning[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCATK(DealCycle, "DarkGenesis", ATKFinal)
          DealCycle$DarkGenesisCoolDown[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="DarkGenesisCoolDown")$Duration * 1000
          GenesisRemain <- GenesisCool - DealCycle$Time[1]
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "DarkGenesisDL", ATKFinal)
          DealCycle$DarkGenesisCoolDown[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="DarkGenesisCoolDown")$Duration * 1000
          GenesisRemain <- GenesisCool - DealCycle$Time[1]
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      } ## BattleKing Bar
      else if(KingbarRemain == 0) {
        DealCycle <- DCATK(DealCycle, "BattleKingBar1", ATKFinal)
        GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
        KingbarRemain <- KingbarCool - DealCycle$Time[1]
        if(DealCycle$AbyssalLightning[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCATK(DealCycle, "BattleKingBar2", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "BattleKingBar2DL", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      } ## Finish Blow (Union Aura & Master of Death)
      else if(DealCycle$UnionAura[nrow(DealCycle)] > 0 & DealCycle$MasterofDeath[nrow(DealCycle)] > 0) {
        if(DealCycle$AbyssalLightning[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCATK(DealCycle, "FinishBlowUAMOD", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "FinishBlowUAMODDL", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      } ## Finish Blow (Union Aura)
      else if(DealCycle$UnionAura[nrow(DealCycle)] > 0) {
        if(DealCycle$AbyssalLightning[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCATK(DealCycle, "FinishBlowUA", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "FinishBlowUADL", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
      } ## Finish Blow
      else {
        if(DealCycle$AbyssalLightning[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
          DealCycle <- DCATK(DealCycle, "FinishBlow", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "FinishBlowDL", ATKFinal)
          GenesisRemain <- max(0, GenesisRemain - DealCycle$Time[1])
          KingbarRemain <- max(0, KingbarRemain - DealCycle$Time[1])
        }
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
  ## Dark Lightning
  DC2 <- subset(DealCycle, DealCycle$Skills=="FinishBlowDL")
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUADL"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUAMODDL"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="DarkGenesisDL"))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="BattleKingBar2DL"))
  DC2$Skills <- "DarkLightning"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
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
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## Black Magic Altar
  DealCycle <- DCSummonedATKs(DealCycle, "BlackMagicAltar", SummonedFinal)
  
  
  ## Dark Genesis Add ATK
  DC2 <- subset(DealCycle, DealCycle$Skills=="FinishBlow" & DealCycle$DarkGenesisCoolDown > 0)
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUA" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUAMOD" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="BattleKingBar2" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowDL" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUADL" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="FinishBlowUAMODDL" & DealCycle$DarkGenesisCoolDown > 0))
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="BattleKingBar2DL" & DealCycle$DarkGenesisCoolDown > 0))
  
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
    if(sum(DealCycle$Skills[i]==c("BlackMagicAltar", "DarkLightning"))==1) {
      DealCycle$DarkLightningDebuff[i] <- ifelse(DealCycle$AbyssalLightning[i] > 0, 30, 15)
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesis", "BattleKingBar1", "BattleKingBar2", "FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", 
                                         "DarkGenesisDL", "BattleKingBar2DL", "FinishBlowDL", "FinishBlowUADL", "FinishBlowUAMODDL"))==1) {
      if(DealCycle$DarkLightningDebuff[i-1] >= 1) {
        DealCycle$DarkLightningDebuff[i] <- DealCycle$DarkLightningDebuff[i-1] - 1
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMark"
      } else if(DealCycle$DarkLightningDebuff[i-1] < 1 & DealCycle$DarkLightningDebuff[i-1] > 0) {
        DealCycle$DarkLightningDebuff[i] <- 0
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- paste("DarkLightningMark", DealCycle$DarkLightningDebuff[i-1]*100, sep="")
      }
    } else if(DealCycle$Skills[i]=="DarkGenesisFA") {
      if(DealCycle$DarkLightningDebuff[i-1] >= (0.6 + 0.02 * Spec$SkillLv)) {
        DealCycle$DarkLightningDebuff[i] <- DealCycle$DarkLightningDebuff[i-1] - (0.6 + 0.02 * Spec$SkillLv)
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- "DarkLightningMarkDGFA"
      } else if(DealCycle$DarkLightningDebuff[i-1] < (0.6 + 0.02 * Spec$SkillLv) & DealCycle$DarkLightningDebuff[i-1] > 0) {
        DealCycle$DarkLightningDebuff[i] <- 0
        DC2 <- rbind(DC2, DealCycle[i, ])
        if(DealCycle$DarkLightningDebuff[i-1] < 0.1) {
          DC2$Skills[nrow(DC2)] <- paste("DarkLightningMark", "0", DealCycle$DarkLightningDebuff[i-1] * 100, sep="")
        } else {
          DC2$Skills[nrow(DC2)] <- paste("DarkLightningMark", DealCycle$DarkLightningDebuff[i-1] * 100, sep="")
        }
      }
    } else {
      DealCycle$DarkLightningDebuff[i] <- DealCycle$DarkLightningDebuff[i-1]
    }
  }
  DC2 <- DC2[-1, ]
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Abyssal Lightning
  DC2 <- DealCycle[1, ]
  AbyssalRemain <- 0
  AbyssalStack <- 1
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$AbyssalLightningBuff[i] > 0) {
      if(sum(DealCycle$Skills[i]==c("AbyssalLightningBuff"))==1) {
        AbyssalRemain <- 0
        AbyssalStack <- 1
      } else if(sum(DealCycle$Skills[i]==c("DarkLightning", "DarkLightningMark"))==1 & AbyssalRemain == 0) {
        DC2 <- rbind(DC2, DealCycle[i, ])
        AbyssalRemain <- 600
        AbyssalStack <- 0
      } else if(sum(DealCycle$Skills[i]==c("DarkLightningMarkDGFA"))==1 & AbyssalRemain == 0 & AbyssalStack + (0.6 + 0.02 * Spec$SkillLv) >= 1) {
        DC2 <- rbind(DC2, DealCycle[i, ])
        AbyssalRemain <- 600
        AbyssalStack <- 0
      } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark" & AbyssalRemain == 0) {
        if(AbyssalStack + as.numeric(substr(DealCycle$Skills[i], 18, 19)) / 100 >= 1) {
          DC2 <- rbind(DC2, DealCycle[i, ])
          AbyssalRemain <- 600
          AbyssalStack <- 0
        }
      } else if(sum(DealCycle$Skills[i]==c("DarkLightning", "DarkLightningMark"))==1 & AbyssalStack < 1) {
        AbyssalStack <- AbyssalStack + 1
      } else if(sum(DealCycle$Skills[i]==c("DarkLightningMarkDGFA"))==1 & AbyssalStack < 1) {
        AbyssalStack <- AbyssalStack + (0.6 + 0.02 * Spec$SkillLv)
      } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark" & AbyssalStack < 1) {
        AbyssalStack <- AbyssalStack + as.numeric(substr(DealCycle$Skills[i], 18, 19)) / 100
      }
      AbyssalRemain <- max(0, AbyssalRemain - (DealCycle$Time[i+1] - DealCycle$Time[i]))
    }
  }
  DC2 <- DC2[-1, ]
  DC2$Skills <- "DarkLightningAL"
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
                                  "DarkLightningMark", "Death", "DeathMOD", "BlackMagicAltar", 
                                  "FinishBlowUADL", "FinishBlowUAMODDL", "DarkGenesisDL"))==1 & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500)
      DeathStack <- max(0, DeathStack - 1)
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesisFA", "DarkLightningMarkDGFA"))==1 & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500 * (0.6 + 0.02 * Spec$SkillLv))
      DeathStack <- max(0, DeathStack - (0.6 + 0.02 * Spec$SkillLv))
    } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark" & DealCycle$MasterofDeath[i] > 0) {
      DeathRemain <- max(0, DeathRemain - 500 * (1 - as.numeric(substr(DealCycle$Skills[i], 18, 19)) / 100))
      DeathStack <- max(0, DeathStack - (1 - as.numeric(substr(DealCycle$Skills[i], 18, 19)) / 100))
    } else if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "DarkLightning", "DarkLightningAL", 
                                         "DarkLightningMark", "Death", "DeathMOD", "BattleKingBar1", "BattleKingBar2", "GrimReeper", "GrimReeperMOD", "BlackMagicAltar", 
                                         "FinishBlowDL", "FinishBlowUADL", "FinishBlowUAMODDL", "DarkGenesisDL", "BattleKingBar2DL"))==1) {
      DeathStack <- max(0, DeathStack - 1)
    } else if(sum(DealCycle$Skills[i]==c("DarkGenesisFA", "DarkLightningMarkDGFA"))==1) {
      DeathStack <- max(0, DeathStack - (0.6 + 0.02 * Spec$SkillLv))
    } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark") {
      DeathStack <- max(0, DeathStack - (1 - as.numeric(substr(DealCycle$Skills[i], 18, 19)) / 100))
    }
    if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkGenesis", "BattleKingBar1", "BattleKingBar2", 
                                  "FinishBlowDL", "FinishBlowUADL", "FinishBlowUAMODDL", "DarkGenesisDL", "BattleKingBar2DL"))==1 & 
       DeathRemain == 0 & DeathStack == 0 & DealCycle$Time[i] - DC2$Time[nrow(DC2)] >= 1830) {
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
  DC2 <- DC2[-1, ]
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Resistance Line Infantry, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, c("ResistanceLineInfantry"), SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FinishBlow", "FinishBlowUA", "FinishBlowUAMOD", "DarkLightning", "DarkLightningAL", "DarkLightningMark", "DarkLightningMarkDGFA",
                                  "DarkGenesis", "BattleKingBar1", "BattleKingBar2", "ResistanceLineInfantry", "BlackMagicAltar", 
                                  "FinishBlowDL", "FinishBlowUADL", "FinishBlowUAMODDL", "DarkGenesisDL", "BattleKingBar2DL"))==1) {
      DealCycle$OverloadMana[i] <- 1
    } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark") {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  return(DealCycle)
}
DLRemain <- function(DealCycle, ATKFinal) {
  a <- unique(subset(DealCycle, substr(DealCycle$Skills, 1, 17)=="DarkLightningMark")$Skills)
  b <- c()
  for(i in 1:length(a)) {
    if(sum(a[i]!=c("DarkLightningMark", "DarkLightningMarkDGFA"))==2) {
      b <- c(b, a[i])
    }
  }
  ATKFinal2 <- ATKFinal
  if(length(b) > 0) {
    for(i in 1:length(b)) {
      ATKFinal2 <- rbind(ATKFinal2, subset(ATKFinal, rownames(ATKFinal)=="DarkLightningMark"))
      rownames(ATKFinal2)[nrow(ATKFinal2)] <- b[i]
      ATKFinal2$AttackTimes[nrow(ATKFinal2)] <- as.numeric(substr(b[i], 18, 19)) / 100 * ATKFinal2$AttackTimes[nrow(ATKFinal2)]
    }
  }
  return(ATKFinal2)
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
ATKFinal <- DLRemain(BattleMageDealCycle, ATKFinal)
BattleMageDealCycleReduction <- DealCycleReduction(BattleMageDealCycle)


## Damage Optimization
Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="BattleMage") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  BattleMageSpecOpt1 <- Optimization1(BattleMageDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpec, BattleMageUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- BattleMageSpecOpt1[1, 1:3]
} else {
  BattleMageSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
BattleMageSpecOpt <- OptDataAdd(BattleMageSpec, BattleMageSpecOpt1, "Potential", BattleMageBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  BattleMageSpecOpt2 <- Optimization2(BattleMageDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt, BattleMageHyperStatBase, BattleMageBase$ChrLv, BattleMageBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- BattleMageSpecOpt2[1, ]
} else {
  BattleMageSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
BattleMageSpecOpt <- OptDataAdd(BattleMageSpecOpt, BattleMageSpecOpt2, "HyperStat", BattleMageBase$CRROver, DemonAvenger=F)

BattleMageFinalDPM <- DealCalc(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt, Collapse=F)
BattleMageFinalDPMwithMax <- DealCalcWithMaxDMR(BattleMageDealCycle, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "BattleMage", sum(na.omit(BattleMageFinalDPMwithMax)) / (max(BattleMageDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "BattleMage", sum(na.omit(BattleMageFinalDPM)) / (max(BattleMageDealCycle$Time) / 60000) - sum(na.omit(BattleMageFinalDPMwithMax)) / (max(BattleMageDealCycle$Time) / 60000))

BattleMageDealRatio <- DealRatio(BattleMageDealCycle, BattleMageFinalDPMwithMax)

BattleMageDealData <- data.frame(BattleMageDealCycle$Skills, BattleMageDealCycle$Time, BattleMageDealCycle$Restraint4, BattleMageFinalDPMwithMax)
colnames(BattleMageDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "BattleMage", Deal_RR(BattleMageDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "BattleMage", Deal_40s(BattleMageDealData))

BattleMageSpecMean <- SpecMean("BattleMage", BattleMageDealCycleReduction, 
                               DealCalcWithMaxDMR(BattleMageDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt), 
                               ATKFinal, BuffFinal, SummonedFinal, BattleMageSpecOpt)


## Teleport Delay 0ms
DealCycle <- c("Skills", "Time", rownames(BattleMageBuff))
BattleMageDealCycle0 <- t(rep(0, length(DealCycle)))
colnames(BattleMageDealCycle0) <- DealCycle
BattleMageDealCycle0 <- data.frame(BattleMageDealCycle0)

BattleMageDealCycle0 <- BattleMageCycle(PreDealCycle=BattleMageDealCycle0, 
                                        ATKFinal=ATKFinal_Delay0,
                                        BuffFinal=BuffFinal,
                                        SummonedFinal=SummonedFinal, 
                                        Spec=BattleMageSpec)
BattleMageDealCycle0 <- BattleMageAddATK(DealCycle=BattleMageDealCycle0, 
                                         ATKFinal=ATKFinal_Delay0, 
                                         SummonedFinal=SummonedFinal,
                                         Spec=BattleMageSpec)
ATKFinal_Delay0 <- DLRemain(BattleMageDealCycle0, ATKFinal_Delay0)


BattleMageFinalDPM0 <- DealCalcWithMaxDMR(BattleMageDealCycle0, ATKFinal_Delay0, BuffFinal, SummonedFinal, BattleMageSpecOpt)
BattleMage0DPM <- sum(na.omit(BattleMageFinalDPM0)) / (max(BattleMageDealCycle0$Time)/ 60000)

BattleMageDealData0 <- data.frame(BattleMageDealCycle0$Skills, BattleMageDealCycle0$Time, BattleMageDealCycle0$Restraint4, BattleMageFinalDPM0)
colnames(BattleMageDealData0) <- c("Skills", "Time", "R4", "Deal")

BattleMage0RR <- Deal_RR(BattleMageDealData0)
BattleMage040s <- Deal_40s(BattleMageDealData0)


## Teleport Delay 180ms
DealCycle <- c("Skills", "Time", rownames(BattleMageBuff))
BattleMageDealCycle180 <- t(rep(0, length(DealCycle)))
colnames(BattleMageDealCycle180) <- DealCycle
BattleMageDealCycle180 <- data.frame(BattleMageDealCycle180)

BattleMageDealCycle180 <- BattleMageCycle(PreDealCycle=BattleMageDealCycle180, 
                                          ATKFinal=ATKFinal_Delay180,
                                          BuffFinal=BuffFinal,
                                          SummonedFinal=SummonedFinal, 
                                          Spec=BattleMageSpec)
BattleMageDealCycle180 <- BattleMageAddATK(DealCycle=BattleMageDealCycle180, 
                                           ATKFinal=ATKFinal_Delay180, 
                                           SummonedFinal=SummonedFinal,
                                           Spec=BattleMageSpec)
ATKFinal_Delay180 <- DLRemain(BattleMageDealCycle180, ATKFinal_Delay180)


BattleMageFinalDPM180 <- DealCalcWithMaxDMR(BattleMageDealCycle180, ATKFinal_Delay180, BuffFinal, SummonedFinal, BattleMageSpecOpt)
BattleMage180DPM <- sum(na.omit(BattleMageFinalDPM180)) / (max(BattleMageDealCycle180$Time)/ 60000)

BattleMageDealData180 <- data.frame(BattleMageDealCycle180$Skills, BattleMageDealCycle180$Time, BattleMageDealCycle180$Restraint4, BattleMageFinalDPM180)
colnames(BattleMageDealData180) <- c("Skills", "Time", "R4", "Deal")

BattleMage180RR <- Deal_RR(BattleMageDealData180)
BattleMage18040s <- Deal_40s(BattleMageDealData180)

print(list(BattleMage0ms=data.frame(BattleMage0DPM=BattleMage0DPM, BattleMage0RR=BattleMage0RR, BattleMage040s=BattleMage040s), 
           BattleMage180ms=data.frame(BattleMage180DPM=BattleMage180DPM, BattleMage180RR=BattleMage180RR, BattleMage18040s=BattleMage18040s)))