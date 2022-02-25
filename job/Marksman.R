## Marksman - Data
## Marksman - VMatrix
MarksmanCoreBase <- CoreBuilder(ActSkills=c("TrueSnipe", "SplitArrow", "ChargedArrow", "FullbustShot",
                                            CommonV("Bowman", "Adventure")), 
                                ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                                UsefulSkills=c("CombatOrders"), 
                                SpecSet=get(DPMCalcOption$SpecSet), 
                                VPassiveList=MarksmanVPassive, 
                                VPassivePrior=MarksmanVPrior, 
                                SelfBind=F)

MarksmanCore <- MatrixSet(PasSkills=MarksmanCoreBase$PasSkills$Skills, 
                          PasLvs=MarksmanCoreBase$PasSkills$Lv, 
                          PasMP=MarksmanCoreBase$PasSkills$MP, 
                          ActSkills=MarksmanCoreBase$ActSkills$Skills, 
                          ActLvs=MarksmanCoreBase$ActSkills$Lv, 
                          ActMP=MarksmanCoreBase$ActSkills$MP, 
                          UsefulSkills=MarksmanCoreBase$UsefulSkills, 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          SpecialCore=MarksmanCoreBase$SpecialCoreUse)



## Marksman - Basic Info
MarksmanBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=get(DPMCalcOption$MobSet),
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        Job="Marksman",
                        CoreData=MarksmanCore, 
                        BuffDurationNeeded=0, 
                        AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Marksman"), 
                        LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Marksman"), 
                        MonsterLife=get(FindJob(MonsterLifePreSet, "Marksman")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                        Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Crossbow", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                        WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                        SubWeapon=SubWeapon[rownames(SubWeapon)=="Thimble", ], 
                        Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                        CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Marksman")))


## Marksman - Passive
{option <- factor("ATK", levels=PSkill)
value <- c(9)
TitaniumArrow <- data.frame(option, value)
  
option <- factor("ATKSpeed", levels=PSkill)
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

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
CrossbowAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
SoulArrow <- data.frame(option, value)

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
value <- c(80 + 2 * MarksmanBase$PSkillLv)
IllusionStep <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(15 + MarksmanBase$PSkillLv)
AdditionalBolt <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30 + MarksmanBase$PSkillLv)
ArrowIllusionPassive <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(8, 20)
AdvancedEnhanceArrowPassive <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(10 + MarksmanBase$PSkillLv)
LastmanStanding <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(MarksmanCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(MarksmanCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

MarksmanPassive <- Passive(list(TitaniumArrow, ArcherMastery, CriticalShot, PhysicalTraining, CrossbowMastery, CrossbowAcceleration, SoulArrow, ExtremeArchery, Marksmanship, 
                                IllusionStep, CrossbowExpert, AdditionalBolt, ArrowIllusionPassive, AdvancedEnhanceArrowPassive, LastmanStanding, BlinkPassive, RopeConnectPassive))


## Marksman - Buff
{option <- factor("MainStat", levels=BSkill)
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

Useful <- UsefulSkills(MarksmanCore)
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

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
info <- c(72, 120, 810, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SplitArrowBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 0, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ChargedArrowCharge <- rbind(data.frame(option, value), info)

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

option <- factor("CDMR", levels=BSkill)
value <- c(20 * (0.2 + 0.01 * GetCoreLv(MarksmanCore, "CriticalReinforce")))
info <- c(0, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Synergy <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(MarksmanCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * MarksmanBase$MainStatP), 5 + floor(GetCoreLv(MarksmanCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EnhanceArrowStack <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(4, 13)
info <- c(15, 20, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FocusOnBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(3, 4, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EnhanceSinpeMark <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(2)
info <- c(1, 180, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MotalBlow <- rbind(data.frame(option, value), info)}

MarksmanBuff <- list(MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, 
                     UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                     SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, ChargedArrowCharge=ChargedArrowCharge, CriticalReinforce=CriticalReinforce, Synergy=Synergy, 
                     MapleWarriors2=MapleWarriors2, EnhanceArrowStack=EnhanceArrowStack, FocusOnBuff=FocusOnBuff, EnhanceSinpeMark=EnhanceSinpeMark, MotalBlow=MotalBlow, 
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
### PetBuff : SharpEyes(900ms), MapleSoldier(0ms), UsefulCombatOrders(1500ms), UsefulAdvancedBless
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  MarksmanBuff[[length(MarksmanBuff)+1]] <- UsefulAdvancedBless
  names(MarksmanBuff)[[length(MarksmanBuff)]] <- "UsefulAdvancedBless"
}
MarksmanBuff <- Buff(MarksmanBuff)
MarksmanAllTimeBuff <- AllTimeBuff(MarksmanBuff)


## Marksman - Union & HyperStat & SoulWeapon
MarksmanSpec <- JobSpec(JobBase=MarksmanBase, 
                        Passive=MarksmanPassive, 
                        AllTimeBuff=MarksmanAllTimeBuff, 
                        MobInfo=get(DPMCalcOption$MobSet), 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        WeaponName="Crossbow", 
                        UnionStance=0)

MarksmanUnionRemained <- MarksmanSpec$UnionRemained
MarksmanHyperStatBase <- MarksmanSpec$HyperStatBase
MarksmanCoolReduceType <- MarksmanSpec$CoolReduceType
MarksmanSpec <- MarksmanSpec$Spec


## Marksman - CriticalReinforce(RE)
{option <- factor("CDMR", levels=BSkill)
value <- c(MarksmanSpec$CRR * (0.2 + 0.01 * GetCoreLv(MarksmanCore, "CriticalReinforce")))
info <- c(30, 120, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CriticalReinforce <- rbind(data.frame(option, value), info)}
MarksmanBuff <- list(MapleSoldier=MapleSoldier, SharpEyes=SharpEyes, 
                     UsefulCombatOrders=UsefulCombatOrders, EpicAdventure=EpicAdventure, Bullseye=Bullseye, 
                     SplitArrowBuff=SplitArrowBuff, FullbustShotBuff=FullbustShotBuff, ChargedArrowCharge=ChargedArrowCharge, CriticalReinforce=CriticalReinforce, Synergy=Synergy, 
                     MapleWarriors2=MapleWarriors2, EnhanceArrowStack=EnhanceArrowStack, FocusOnBuff=FocusOnBuff, EnhanceSinpeMark=EnhanceSinpeMark, MotalBlow=MotalBlow, 
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  MarksmanBuff[[length(MarksmanBuff)+1]] <- UsefulAdvancedBless
  names(MarksmanBuff)[[length(MarksmanBuff)]] <- "UsefulAdvancedBless"
}
MarksmanBuff <- Buff(MarksmanBuff)
MarksmanAllTimeBuff <- AllTimeBuff(MarksmanBuff)


## Marksman - Spider In Mirror
SIM <- SIMData(GetCoreLv(MarksmanCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Marksman - Attacks
{option <- factor(c("IGR", "BDR", "CRR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(25 + ceiling(MarksmanSpec$SkillLv/3)* 2, ifelse(GetCoreLv(MarksmanCore, "Snipe")>=40, 20, 0))), 
           30, 100, 2 * GetCoreLv(MarksmanCore, "Snipe"))
info <- c(480 + MarksmanSpec$SkillLv * 5, 11, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Snipe <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(25 + ceiling(MarksmanSpec$SkillLv/3)* 2, ifelse(GetCoreLv(MarksmanCore, "Snipe")>=40, 20, 0))), 
           30, 100, 2 * GetCoreLv(MarksmanCore, "Snipe"))
info <- c(535 + MarksmanSpec$SkillLv * 7, 11, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnhanceSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "CRR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MarksmanCore, "Snipe")>=40, 20, 0), 30, 100, 2 * GetCoreLv(MarksmanCore, "Snipe"))
info <- c(320 + MarksmanSpec$SkillLv * 5, 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnhanceSnipeAddATK <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * GetCoreLv(MarksmanCore, "SplitArrow"), 6, 0, NA, NA, NA, NA, F)
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
info <- c(750 + 30 * GetCoreLv(MarksmanCore, "ChargedArrow"), 11, 480, NA, 10, T, F, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChargedArrow <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "CRR"), levels=ASkill)
value <- c(50, 100)
info <- c(500 + 20 * GetCoreLv(MarksmanCore, "ChargedArrow"), 11, 480, NA, 10, T, F, T)
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
info <- c(950 + 30 * GetCoreLv(MarksmanCore, "TrueSnipe"), 15, 900, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TrueSnipe <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(25)
info <- c(375 + 15 * GetCoreLv(MarksmanCore, "FullbustShot"), 40, 1080, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FullbustShot <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MarksmanCore, "FinalAttack")>=40, 20, 0), MarksmanBase$MonsterLife$FinalATKDMR, 4 * GetCoreLv(MarksmanCore, "FinalAttack"))
info <- c(140, 0.4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalAttack <- rbind(data.frame(option, value), info)}

MarksmanATK <- Attack(list(Snipe=Snipe, EnhanceSnipe=EnhanceSnipe, EnhanceSnipeAddATK=EnhanceSnipeAddATK, 
                           SplitArrow=SplitArrow, ChargedArrowStart=ChargedArrowStart, ChargedArrow=ChargedArrow, ChargedArrowUncharged=ChargedArrowUncharged, 
                           TrueSnipe=TrueSnipe, TrueSnipeStart=TrueSnipeStart, FullbustShot=FullbustShot, FinalAttack=FinalAttack, 
                           SpiderInMirror=SpiderInMirror))


## Marksman - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 15 * GetCoreLv(MarksmanCore, "Evolve"), 7, 600, 3030, 40, 105, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Evolve <- rbind(data.frame(option, value), info) 

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(3 * GetCoreLv(MarksmanCore, "Freezer"), ifelse(GetCoreLv(MarksmanCore, "Freezer")>=40, 20, 0))
info <- c(390, 1, 0, 1710, 220, 105, T, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Freezer <- rbind(data.frame(option, value), info) 

option <- factor(levels=SSkill)
value <- c()
info <- c(400 + 16 * GetCoreLv(MarksmanCore, "GuidedArrow"), 1, 0, 510, 600, NA, F, F, F, F)
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(MarksmanSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MarksmanSpec$CoolReduceP, MarksmanSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MarksmanSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(MarksmanBuff))
MarksmanDealCycle <- t(rep(0, length(DealCycle)))
colnames(MarksmanDealCycle) <- DealCycle

MarksmanCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                          Period=120, CycleTime=240) {
  BuffSummonedPrior <- c("SharpEyes", "MapleSoldier", "EpicAdventure", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "GuidedArrow", "Evolve", "FullbustShotBuff", "MapleWarriors2", "Bullseye", "SplitArrowBuff", "SoulContractLink", "CriticalReinforce", "Restraint4")
  Times120 <- c(0, 0, 1, 0, 0, 
                0, 1, 1, 0.5, 1, 1, 1, 1, 0.5)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times120 <- Times120[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce * (CycleTime / Period)
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
  
  ChargedArrowLogic <- function(DealCycle, CARemain, CAStatus = c("Auto", "Manual"), ATKForce = F) {
    ## Charged Arrow Cancel
    if(DealCycle$ChargedArrowCharge[nrow(DealCycle)] > 7000 & DealCycle$ChargedArrowCharge[nrow(DealCycle)] - DealCycle$Time[1] < 7000) {
      DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$ChargedArrowCharge[nrow(DealCycle)] - 7000
    } 
    
    ## Charged Arrow ATK (Auto)
    if(DealCycle$ChargedArrowCharge[nrow(DealCycle)] > 0 & DealCycle$ChargedArrowCharge[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$ChargedArrowCharge[nrow(DealCycle)]
      DealCycle <- DCATK(DealCycle, "ChargedArrow", ATKFinal)
      DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
      DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
      DealCycle$ChargedArrowCharge[nrow(DealCycle)] <- 0
    }
    
    ## Charged Arrow ATK (Forced)
    if(ATKForce == T) {
      if(DealCycle$Skills[nrow(DealCycle)] == "FullbustShot") {
        DealCycle[1, 2:ncol(DealCycle)] <- 450
      } else {
        DealCycle[1, 2:ncol(DealCycle)] <- 30
      }
      if(DealCycle$ChargedArrowCharge[nrow(DealCycle)] - DealCycle$Time[1] > 7000) {
        DealCycle <- DCATK(DealCycle, "ChargedArrowUncharged", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
        DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
        DealCycle$ChargedArrowCharge[nrow(DealCycle)] <- 0
      } else {
        DealCycle <- DCATK(DealCycle, "ChargedArrow", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
        DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
        DealCycle$ChargedArrowCharge[nrow(DealCycle)] <- 0
      }
    }
    
    ## Charged Arrow Charging Start (Manual)
    if(CARemain - DealCycle$Time[1] <= 0 & CAStatus == "Manual") {
      DealCycle <- DCATK(DealCycle, "ChargedArrowStart", ATKFinal)
      DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
      DealCycle$ChargedArrowCharge[nrow(DealCycle)] <- 10000
    }
    
    ## Charged Arrow Charging Start (Auto)
    if(CARemain - DealCycle$Time[1] <= 0 & CAStatus == "Auto") {
      RemainedTime <- (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="ChargedArrowStart")$Time)) - 11000
      DealCycle[1, 2:ncol(DealCycle)] <- DealCycle$Time[1] - RemainedTime
      DealCycle <- DCATK(DealCycle, "ChargedArrowStart", ATKFinal)
      DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
      DealCycle$ChargedArrowCharge[nrow(DealCycle)] <- 10000
      DealCycle[1, 2:ncol(DealCycle)] <- RemainedTime
    }
    return(DealCycle)
  }
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
    } else {
      if(BuffList[[1]][i]=="GuidedArrow") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
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
  CACool <- subset(ATKFinal, rownames(ATKFinal)=="ChargedArrowStart")$CoolTime * 1000
  CARemain <- 0 ; CAStatus <- "Manual"
  DealCycle$FocusOnBuff[2:nrow(DealCycle)] <- 10000
  DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
  CARemain <- CACool
  
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
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
          if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
            CAStatus <- "Auto"
            CARemain <- max(0, 11000 - DealCycle$Time[1])
          } else {
            CARemain <- max(0, CARemain - DealCycle$Time[1])
          }
        }
      }
      ## Fullbust Shot
      if(nrow(DealCycle[DealCycle$Skills=="FullbustShotBuff", ]) * 8 > nrow(DealCycle[DealCycle$Skills=="FullbustShot", ])) {
        for(i in 1:7) {
          DealCycle <- DCATK(DealCycle, "FullbustShot", ATKFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
          if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
            CAStatus <- "Auto"
            CARemain <- max(0, 11000 - DealCycle$Time[1])
          } else {
            CARemain <- max(0, CARemain - DealCycle$Time[1])
          }
        }
        
        if(DealCycle$Restraint4[nrow(DealCycle)] > 0) {
          DealCycle <- DCATK(DealCycle, "FullbustShot", ATKFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, T)
          CAStatus <- "Manual"
          CARemain <- max(0, CACool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(DealCycle[DealCycle$Skills=="ChargedArrowStart", ]$Time)))
        } else {
          DealCycle <- DCATK(DealCycle, "FullbustShot", ATKFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
          if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
            CAStatus <- "Auto"
            CARemain <- max(0, 11000 - DealCycle$Time[1])
          } else {
            CARemain <- max(0, CARemain - DealCycle$Time[1])
          }
        }
      }
      ## True Snipe
      else if(nrow(DealCycle[DealCycle$Skills=="Restraint4", ]) > nrow(DealCycle[DealCycle$Skills=="TrueSnipeStart", ])) {
        DealCycle <- DCATK(DealCycle, "TrueSnipeStart", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
        CARemain <- max(0, CARemain - DealCycle$Time[1])
        
        for(i in 1:6) {
          DealCycle <- DCATK(DealCycle, "TrueSnipe", ATKFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
          CARemain <- max(0, CARemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "TrueSnipe", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
        DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
        DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
        if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
          CAStatus <- "Auto"
          CARemain <- max(0, 11000 - DealCycle$Time[1])
        } else {
          CARemain <- max(0, CARemain - DealCycle$Time[1])
        }
      }
      ## Enhance Snipe
      else if(DealCycle$EnhanceArrowStack[nrow(DealCycle)] == 3) {
        DealCycle <- DCATK(DealCycle, "EnhanceSnipe", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- 0
        DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
        DealCycle$EnhanceSinpeMark[nrow(DealCycle)] <- 5000
        DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
        if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
          CAStatus <- "Auto"
          CARemain <- max(0, 11000 - DealCycle$Time[1])
        } else {
          CARemain <- max(0, CARemain - DealCycle$Time[1])
        }
      }
      ## Snipe
      else {
        DealCycle <- DCATK(DealCycle, "Snipe", ATKFinal)
        DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1] + 1
        DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
        if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
          CAStatus <- "Auto"
          CARemain <- max(0, 11000 - DealCycle$Time[1])
        } else {
          CARemain <- max(0, CARemain - DealCycle$Time[1])
        }
      }
    }
    
    if(DealCycle$ChargedArrowCharge[nrow(DealCycle)] > 0) {
      DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, T)
      CAStatus <- "Manual"
      CARemain <- max(0, CACool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(DealCycle[DealCycle$Skills=="ChargedArrowStart", ]$Time)))
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
          if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
            CAStatus <- "Auto"
            CARemain <- max(0, 11000 - DealCycle$Time[1])
          } else {
            CARemain <- max(0, CARemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1]
          DealCycle <- ChargedArrowLogic(DealCycle, CARemain, CAStatus, F)
          if(DealCycle$Skills[nrow(DealCycle)]=="ChargedArrowStart") {
            CAStatus <- "Auto"
            CARemain <- max(0, 11000 - DealCycle$Time[1])
          } else {
            CARemain <- max(0, CARemain - DealCycle$Time[1])
          }
        }
      }
    }
  }
  
  while(DealCycle$EnhanceArrowStack[nrow(DealCycle)] > 0) {
    if(DealCycle$EnhanceArrowStack[nrow(DealCycle)] == 3) {
      DealCycle <- DCATK(DealCycle, "EnhanceSnipe", ATKFinal)
      DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- 0
      DealCycle$FocusOnBuff[nrow(DealCycle)] <- 15000
      DealCycle$EnhanceSinpeMark[nrow(DealCycle)] <- 5000
    }
    ## Snipe
    else {
      DealCycle <- DCATK(DealCycle, "Snipe", ATKFinal)
      DealCycle$EnhanceArrowStack[nrow(DealCycle)] <- DealCycle$EnhanceArrowStack[nrow(DealCycle)-1] + 1
    }
  }
  return(DealCycle)
}
MarksmanAddATK <- function(DealCycle) {
  ## Split Arrow, Final Attack, Enhance Snipe Mark ATK
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Snipe", "EnhanceSnipe")) >= 1 & DealCycle$SplitArrowBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
    } else if (DealCycle$Skills[i]=="FullbustShot" & DealCycle$SplitArrowBuff[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("SplitArrow")
    }
    if(DealCycle$Skills[i]=="FullbustShot" | DealCycle$Skills[i]=="Snipe" | DealCycle$Skills[i]=="EnhanceSnipe") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("FinalAttack")
    }
    if(DealCycle$Skills[i]=="Snipe" & DealCycle$EnhanceSinpeMark[i] > 0 & DealCycle$EnhanceArrowStack[i] == 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("EnhanceSnipeAddATK")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Guided Arrow
  DealCycle <- DCSummonedATKs(DealCycle, "GuidedArrow", SummonedFinal)
  
  
  ## Evolve
  DealCycle <- DCSummonedATKs(DealCycle, "Evolve", SummonedFinal)
  DealCycle <- EvolveCycle(DealCycle)
  
  
  ## Bullseye - Critical Reinforce Synergy
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$CriticalReinforce[i] > 0 & DealCycle$Bullseye[i] > 0) {
      DealCycle$Synergy[i] <- DealCycle$Bullseye[i]
    }
  }
  
  
  ## Motal Blow
  for(i in 1:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("Snipe", "EnhanceSnipe", "EnhanceSnipeAddATK", "SplitArrow", "ChargedArrow", "ChargedArrowUncharged", "TrueSnipe", "FullbustShot", "GuidedArrow", "SpiderInMirror"))==1) {
      DealCycle$MotalBlow[i] <- 1
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$EnhanceSinpeMark <- 0
  DealCycle$EnhanceArrowStack <- 0
  DealCycle$ChargedArrowCharge <- 0
  
  return(DealCycle)
}


MarksmanDealCycle <- MarksmanCycle(PreDealCycle=MarksmanDealCycle, 
                                    ATKFinal=ATKFinal, 
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal, 
                                    Spec=MarksmanSpec, 
                                    Period=120, 
                                    CycleTime=240)
MarksmanDealCycle <- DealCycleFinal(MarksmanDealCycle)
MarksmanDealCycle <- MarksmanAddATK(MarksmanDealCycle)
MarksmanDealCycleReduction <- DealCycleReduction(MarksmanDealCycle)


Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Marksman") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  MarksmanSpecOpt1 <- Optimization1(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpec, MarksmanUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- MarksmanSpecOpt1[1, 1:3]
} else {
  MarksmanSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
MarksmanSpecOpt <- OptDataAdd(MarksmanSpec, MarksmanSpecOpt1, "Potential", MarksmanBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  MarksmanSpecOpt2 <- Optimization2(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt, MarksmanHyperStatBase, MarksmanBase$ChrLv, MarksmanBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- MarksmanSpecOpt2[1, ]
} else {
  MarksmanSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
MarksmanSpecOpt <- OptDataAdd(MarksmanSpecOpt, MarksmanSpecOpt2, "HyperStat", MarksmanBase$CRROver, DemonAvenger=F)
BuffFinal <- CriReinAdj(MarksmanSpec, MarksmanSpecOpt, BuffFinal, GetCoreLv(MarksmanCore, "CriticalReinforce"))

MarksmanFinalDPM <- DealCalc(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt, Collapse=F)
MarksmanFinalDPMwithMax <- DealCalcWithMaxDMR(MarksmanDealCycle, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Marksman", sum(na.omit(MarksmanFinalDPMwithMax)) / (max(MarksmanDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Marksman", sum(na.omit(MarksmanFinalDPM)) / (max(MarksmanDealCycle$Time) / 60000) - sum(na.omit(MarksmanFinalDPMwithMax)) / (max(MarksmanDealCycle$Time) / 60000))

MarksmanDealRatio <- DealRatio(MarksmanDealCycle, MarksmanFinalDPMwithMax)

MarksmanDealData <- data.frame(MarksmanDealCycle$Skills, MarksmanDealCycle$Time, MarksmanDealCycle$Restraint4, MarksmanFinalDPMwithMax)
colnames(MarksmanDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Marksman", Deal_RR(MarksmanDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Marksman", Deal_40s(MarksmanDealData))

MarksmanSpecMean <- SpecMean("Marksman", MarksmanDealCycleReduction, 
                             DealCalcWithMaxDMR(MarksmanDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt), 
                             ATKFinal, BuffFinal, SummonedFinal, MarksmanSpecOpt)