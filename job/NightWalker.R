## NightWalker - Data
## NightWalker - VMatrix
NightWalkerCoreBase <- CoreBuilder(ActSkills=c("ShadowSpear", "ShadowServantExtend", "ShadowBite", "RapidThrow", 
                                               CommonV("Thief", "CygnusKnights")), 
                                   ActSkillsLv=c(25, 25, 25, 25, 1, 25, 25, 25, 25), 
                                   UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                   SpecSet=get(DPMCalcOption$SpecSet), 
                                   VPassiveList=NightWalkerVPassive, 
                                   VPassivePrior=NightWalkerVPrior, 
                                   SelfBind=F)

NightWalkerCore <- MatrixSet(PasSkills=NightWalkerCoreBase$PasSkills$Skills, 
                             PasLvs=NightWalkerCoreBase$PasSkills$Lv, 
                             PasMP=NightWalkerCoreBase$PasSkills$MP, 
                             ActSkills=NightWalkerCoreBase$ActSkills$Skills, 
                             ActLvs=NightWalkerCoreBase$ActSkills$Lv, 
                             ActMP=NightWalkerCoreBase$ActSkills$MP, 
                             UsefulSkills=NightWalkerCoreBase$UsefulSkills, 
                             UsefulLvs=20, 
                             UsefulMP=0, 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             SpecialCore=NightWalkerCoreBase$SpecialCoreUse)


## NightWalker - Basic Info
## Link Check Needed
NightWalkerBase <- JobBase(ChrInfo=ChrInfo, 
                           MobInfo=get(DPMCalcOption$MobSet),
                           SpecSet=get(DPMCalcOption$SpecSet), 
                           Job="NightWalker",
                           CoreData=NightWalkerCore, 
                           BuffDurationNeeded=0, 
                           AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "NightWalker"), 
                           LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "NightWalker"), 
                           MonsterLife=get(FindJob(MonsterLifePreSet, "NightWalker")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                           Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                           WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                           SubWeapon=SubWeapon[rownames(SubWeapon)=="CygnusKnightsJewel", ], 
                           Emblem=Emblem[rownames(Emblem)=="Cygnus", ], 
                           CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "NightWalker")))


## NightWalker - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(29)
FlameJavelin <- data.frame(option, value)
  
option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(NightWalkerBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(15, 35)
ElementDarkness <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(30)
ThrowingMastery <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(35, 10)
CriticalThrow <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CDMR"), levels=PSkill)
value <- c(10)
Adrenaline <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(NightWalkerBase$PSkillLv/2), 30 + NightWalkerBase$PSkillLv, 10 + ceiling(NightWalkerBase$PSkillLv/3))
ThrowingExpert <- data.frame(option, value)

option <- factor(c("ATK", "IGR"), levels=PSkill)
value <- c(30 + NightWalkerBase$PSkillLv, 15 + ceiling(NightWalkerBase$PSkillLv/2))
DarknessBlessing <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(NightWalkerCore, "ReadyToDie"))
ReadyToDiePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(NightWalkerCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(NightWalkerCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

NightWalkerPassive <- Passive(list(FlameJavelin=FlameJavelin, ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, ElementDarkness=ElementDarkness, ThrowingMastery=ThrowingMastery, 
                                   CriticalThrow=CriticalThrow, PhysicalTraining=PhysicalTraining, Adrenaline=Adrenaline, ThrowingExpert=ThrowingExpert, DarknessBlessing=DarknessBlessing, 
                                   ReadyToDiePassive=ReadyToDiePassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## NightWalker - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ThrowingBooster <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70)
info <- c(180, NA, 690, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowServant <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritThrowing <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((NightWalkerBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(NightWalkerBase$SkillLv/2))))
info <- c(900 + 30 * NightWalkerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowBatStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bat1 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bat2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bat3 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bat4 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bat5 <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(60)
info <- c(15, 16, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SiphonVitality <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(30, 180, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DominionBuff <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(50)
info <- c(30, 180, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowIllusion1 <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(30)
info <- c(30, 180, 690, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowIllusion2 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(NightWalkerCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(50 + GetCoreLv(NightWalkerCore, "ShadowSpear"), 180 - floor(GetCoreLv(NightWalkerCore, "ShadowSpear")/2), 600, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowSpear <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(25 + GetCoreLv(NightWalkerCore, "ShadowServantExtend"))
info <- c(30 + floor(GetCoreLv(NightWalkerCore, "ShadowServantExtend")/2), 60, 570, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowServantExtend <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(3.42, 15, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowBiteBuffDummy <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(NightWalkerCore, "ShadowBite")/3))
info <- c(23.42, 40, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowBiteBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(GetCoreLv(NightWalkerCore, "ReadyToDie")/10))
info <- c(30, 90 - floor(GetCoreLv(NightWalkerCore, "ReadyToDie")/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(NightWalkerCore, "ReadyToDie")/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(GetCoreLv(NightWalkerCore, "ReadyToDie")/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

NightWalkerBuff <- list(ThrowingBooster=ThrowingBooster, ShadowServant=ShadowServant, SpiritThrowing=SpiritThrowing, ShadowBatStack=ShadowBatStack, MapleSoldier=MapleSoldier, 
                        Bat1=Bat1, Bat2=Bat2, Bat3=Bat3, Bat4=Bat4, Bat5=Bat5, 
                        SiphonVitality=SiphonVitality, DominionBuff=DominionBuff, ShadowIllusion1=ShadowIllusion1, ShadowIllusion2=ShadowIllusion2, GloryofGardians=GloryofGardians, 
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, ShadowSpear=ShadowSpear, ShadowServantExtend=ShadowServantExtend, ShadowBiteBuff=ShadowBiteBuff, 
                        ShadowBiteBuffDummy=ShadowBiteBuffDummy, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, BlessofCygnus=BlessofCygnus, 
                        Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  NightWalkerBuff[[length(NightWalkerBuff)+1]] <- UsefulAdvancedBless
  names(NightWalkerBuff)[[length(NightWalkerBuff)]] <- "UsefulAdvancedBless"
}
NightWalkerBuff <- Buff(NightWalkerBuff)
## PetBuff : ThrowingBooster(600ms), SpiritThrowing(600ms), MapleSoldier(0ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless) / Heist Not Used
NightWalkerAllTimeBuff <- AllTimeBuff(NightWalkerBuff)


## NightWalker - Union & HyperStat & SoulWeapon
NightWalkerSpec <- JobSpec(JobBase=NightWalkerBase, 
                       Passive=NightWalkerPassive, 
                       AllTimeBuff=NightWalkerAllTimeBuff, 
                       MobInfo=get(DPMCalcOption$MobSet), 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       WeaponName="Wristband", 
                       UnionStance=0)

NightWalkerUnionRemained <- NightWalkerSpec$UnionRemained
NightWalkerHyperStatBase <- NightWalkerSpec$HyperStatBase
NightWalkerCoolReduceType <- NightWalkerSpec$CoolReduceType
NightWalkerSpec <- NightWalkerSpec$Spec


## NightWalker - Spider In Mirror
SIM <- SIMData(GetCoreLv(NightWalkerCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## NightWalker - Attacks
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, ifelse(GetCoreLv(NightWalkerCore, "QuintupleThrow")>=40, 20, 0), 2 * GetCoreLv(NightWalkerCore, "QuintupleThrow"))
info <- c(340 + NightWalkerSpec$SkillLv, 4, 450, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuintupleThrow1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, ifelse(GetCoreLv(NightWalkerCore, "QuintupleThrow")>=40, 20, 0), 2 * GetCoreLv(NightWalkerCore, "QuintupleThrow"))
info <- c(475 + NightWalkerSpec$SkillLv, 1, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuintupleThrow2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(NightWalkerCore, "ShadowBat")>=40, 20, 0), 2 * GetCoreLv(NightWalkerCore, "ShadowBat"))
info <- c(620 + 4 * NightWalkerSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowBat <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(NightWalkerCore, "Dominion")>=40, 20, 0), 2 * GetCoreLv(NightWalkerCore, "Dominion"))
info <- c(1000, 10, 2490, NA, 180, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Dominion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(100 + 4 * GetCoreLv(NightWalkerCore, "ShadowSpear"), 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowSpearSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(400 + 16 * GetCoreLv(NightWalkerCore, "ShadowSpear"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowSpearBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(600 + 24 * GetCoreLv(NightWalkerCore, "ShadowBite"), 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowBite <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(475 + 19 * GetCoreLv(NightWalkerCore, "RapidThrow"), 5, 3300, 180, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidThrow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(850 + 34 * GetCoreLv(NightWalkerCore, "RapidThrow"), 13, 630, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidThrowLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(0, 0, 0, 700, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DominionDummy <- rbind(data.frame(option, value), info)}

NightWalkerATK <- Attack(list(QuintupleThrow1=QuintupleThrow1, QuintupleThrow2=QuintupleThrow2, ShadowBat=ShadowBat, Dominion=Dominion, ShadowSpearSmall=ShadowSpearSmall, ShadowSpearBig=ShadowSpearBig, 
                              ShadowBite=ShadowBite, RapidThrow=RapidThrow, RapidThrowLast=RapidThrowLast, DominionDummy=DominionDummy, SpiderInMirror=SpiderInMirror))


## NightWalker - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(NightWalkerCore, "CygnusPhalanx"), 1, 780, 240, 0.24 * (39 + GetCoreLv(NightWalkerCore, "CygnusPhalanx")) + 0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

NightWalkerSummoned <- Summoned(list(CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, 
                                     SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## NightWalker - Deal Cycle and Deal Calculation
ATKFinal <- data.frame(NightWalkerATK)
ATKFinal$Delay[c(-8)] <- Delay(ATKFinal$Delay, NightWalkerSpec$ATKSpeed)[c(-8)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, NightWalkerSpec$CoolReduceP, NightWalkerSpec$CoolReduce)

BuffFinal <- data.frame(NightWalkerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, NightWalkerSpec$CoolReduceP, NightWalkerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, NightWalkerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(NightWalkerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, NightWalkerSpec$CoolReduceP, NightWalkerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * NightWalkerSpec$SummonedDuration / 100, 0)


## NightWalker - DealCycle
DealCycle <- c("Skills", "Time", rownames(NightWalkerBuff))
NightWalkerDealCycle <- t(rep(0, length(DealCycle)))
colnames(NightWalkerDealCycle) <- DealCycle
NightWalkerDealCycle <- data.frame(NightWalkerDealCycle)

NightWalkerCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                             Period=c(180), CycleTime=c(360), JumpShotDelay=0) {
  BuffSummonedPrior <- c("ThrowingBooster", "ShadowServant", "SpiritThrowing", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "GloryofGardians",
                         "CygnusPhalanx", "ShadowBiteBuffDummy", "ShadowSpear", "ShadowServantExtend", "BlessofCygnus")
  Times180 <- c(0, 1, 0, 0, 0, 0, 0, 
                6, 9, 1, 3, 0.5)
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
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)] == "ShadowBiteBuffDummy") {
        DealCycle <- DCBuff(DealCycle, "ShadowBiteBuff", BuffFinal)
        DealCycle <- DCATK(DealCycle, "ShadowBite", ATKFinal)
      }
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
  RapidCool <- 0
  DominionCool <- 0
  SCCool <- 0
  ATKFinal$Delay[rownames(ATKFinal)=="QuintupleThrow2"] <- JumpShotDelay + 30
  
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
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
          DominionCool <- max(0, DominionCool - DealCycle$Time[1])
          SCCool <- max(0, SCCool - DealCycle$Time[1])
        }
      }
      
      ## Dominion, Shadow Illusion
      if(DominionCool == 0 & DealCycle$BlessofCygnus[nrow(DealCycle)] - DealCycle$Time[1] <= 35000 | 
         DominionCool == 0 & nrow(subset(DealCycle, DealCycle$Skills=="Dominion")) == 1) {
        DealCycle <- DCBuff(DealCycle, "DominionBuff", BuffFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, 180000 - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "DominionDummy", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Dominion", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "ShadowIllusion1", BuffFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "ShadowIllusion2", BuffFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
      }
      ## Soul Contract, Ready To Die, Restraint4 
      else if(SCCool == 0 & DealCycle$BlessofCygnus[nrow(DealCycle)] - DealCycle$Time[1] <= 20000 | 
              SCCool == 0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) >= 1 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) < 4) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, 90000 - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "ReadyToDie2Stack", BuffFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        if(nrow(subset(DealCycle, DealCycle$Skills=="Dominion")) > nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))) {
          DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
          DominionCool <- max(0, DominionCool - DealCycle$Time[1])
          SCCool <- max(0, SCCool - DealCycle$Time[1])
        }
      }
      ## Rapid Throw
      else if(RapidCool == 0 & nrow(subset(DealCycle, DealCycle$Skills=="RapidThrow")) == 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] <= 6000 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] > 0 |
              RapidCool == 0 & nrow(subset(DealCycle, DealCycle$Skills=="RapidThrow")) >= 1 & nrow(subset(DealCycle, DealCycle$Skills=="RapidThrow")) < 4) {
        DealCycle <- DCATK(DealCycle, "RapidThrow", ATKFinal)
        RapidCool <- 90000 - DealCycle$Time[1]
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "RapidThrowLast", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
      } 
      else {
        DealCycle <- DCATK(DealCycle, "QuintupleThrow1", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "QuintupleThrow2", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DominionCool <- max(0, DominionCool - DealCycle$Time[1])
        SCCool <- max(0, SCCool - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)] == "ShadowBiteBuffDummy") {
            DealCycle <- DCBuff(DealCycle, "ShadowBiteBuff", BuffFinal)
            DealCycle <- DCATK(DealCycle, "ShadowBite", ATKFinal)
          }
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
          DominionCool <- max(0, DominionCool - DealCycle$Time[1])
          SCCool <- max(0, SCCool - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
          DominionCool <- max(0, DominionCool - DealCycle$Time[1])
          SCCool <- max(0, SCCool - DealCycle$Time[1])
        }
      }
    }
  }
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Dominion")$Time) + min(subset(DealCycle, DealCycle$Skills=="Dominion")$Time) < 180000) {
    DealCycle <- DCATK(DealCycle, "QuintupleThrow1", ATKFinal)
    RapidCool <- max(0, RapidCool - DealCycle$Time[1])
    DominionCool <- max(0, DominionCool - DealCycle$Time[1])
    SCCool <- max(0, SCCool - DealCycle$Time[1])
    DealCycle <- DCATK(DealCycle, "QuintupleThrow2", ATKFinal)
    RapidCool <- max(0, RapidCool - DealCycle$Time[1])
    DominionCool <- max(0, DominionCool - DealCycle$Time[1])
    SCCool <- max(0, SCCool - DealCycle$Time[1])
  }
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
AddATKRateSkillsNW <- function(AddATKSkillName, BuffSkills, AttackSkills, AddATKAppliedSkills) {
  for(j in 1:length(AddATKSkillName)) {
    AddATKRateSkill <- BuffSkills[rownames(BuffSkills)==AddATKSkillName[j], ]
    AddATKRate <- AddATKRateSkill$AddATKRate
    
    for(i in 1:length(AddATKAppliedSkills)) {
      AttackSkills <- rbind(AttackSkills, AttackSkills[AddATKAppliedSkills[i]==rownames(AttackSkills), ])
      rownames(AttackSkills)[nrow(AttackSkills)] <- paste(AddATKAppliedSkills[i], "Add", j, sep="")
      AttackSkills$Damage[nrow(AttackSkills)] <- AttackSkills$Damage[nrow(AttackSkills)] * subset(BuffFinal, rownames(BuffFinal)==AddATKSkillName[j])$AddATKRate / 100
    }
  }
  return(AttackSkills)
}
NightWalkerAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  ## Rapid Throw
  DealCycle <- RepATKCycle(DealCycle, "RapidThrow", 18, 240, ATKFinal)
  
  
  ## Shadow Bite
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ShadowBite") {
      DealCycle$Time[i] <- DealCycle$Time[i] + 1680
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("ShadowBite")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))] < 0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$ShadowBiteBuffDummy[i] > 0) {
      DealCycle$ShadowBiteBuff[i] <- DealCycle$ShadowBiteBuff[i-1] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle$ShadowBiteBuff[i] <- ifelse(DealCycle$ShadowBiteBuff[i] < 0, 0, DealCycle$ShadowBiteBuff[i])
    }
  }
  
  
  ## AddATKs
  DC2 <- DealCycle[1, ]
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("QuintupleThrow1", "QuintupleThrow2", "RapidThrow", "RapidThrowLast"))==1) {
      DC2 <- rbind(DC2, DealCycle[i, ])
      DC2$Skills[nrow(DC2)] <- paste(DealCycle$Skills[i], "Add1", sep="")
      DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)] + 420
      if(DealCycle$ShadowIllusion1[i] > 0) {
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- paste(DealCycle$Skills[i], "Add2", sep="")
        DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)] + 810
      }
      if(DealCycle$ShadowIllusion2[i] > 0) {
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- paste(DealCycle$Skills[i], "Add3", sep="")
        DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)] + 1200
      }
      if(DealCycle$ShadowServantExtend[i] > 0) {
        DC2 <- rbind(DC2, DealCycle[i, ])
        DC2$Skills[nrow(DC2)] <- paste(DealCycle$Skills[i], "Add4", sep="")
      }
    }
  }
  DC2 <- DC2[-1, ]
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("QuintupleThrow1Add1", "QuintupleThrow1Add2", "QuintupleThrow1Add3", 
             "QuintupleThrow2Add1", "QuintupleThrow2Add2", "QuintupleThrow2Add3", 
             "RapidThrowAdd1", "RapidThrowAdd2", "RapidThrowAdd3", "RapidThrowLastAdd1", "RapidThrowLastAdd2", "RapidThrowLastAdd3")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))] < 0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## ShadowBat
  DominionTimes <- floor(subset(BuffFinal, rownames(BuffFinal)=="DominionBuff")$Duration / 0.7) + 1
  DealCycle <- RepATKCycle(DealCycle, "DominionDummy", DominionTimes, 0, ATKFinal)
  
  DC2 <- DealCycle[1, ]
  for(i in 2:nrow(DealCycle)) {
    if(sum(c("QuintupleThrow1", "QuintupleThrow1Add1", "QuintupleThrow1Add2", "QuintupleThrow1Add3", "QuintupleThrow1Add4",
             "QuintupleThrow2", "QuintupleThrow2Add1", "QuintupleThrow2Add2", "QuintupleThrow2Add3", "QuintupleThrow2Add4", 
             "RapidThrow", "RapidThrowAdd1", "RapidThrowAdd2", "RapidThrowAdd3", "RapidThrowAdd4", 
             "RapidThrowLast", "RapidThrowLastAdd1", "RapidThrowLastAdd2", "RapidThrowLastAdd3", "RapidThrowLastAdd4")==DealCycle[i, 1])==1) {
      DealCycle$ShadowBatStack[i] <- ifelse(DealCycle$ShadowBatStack[i-1] == 3, 1, DealCycle$ShadowBatStack[i-1] + 1)
    } else {
      DealCycle$ShadowBatStack[i] <- DealCycle$ShadowBatStack[i-1]
    }
    
    DealCycle$Bat1[i] <- max(0, DealCycle$Bat1[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    DealCycle$Bat2[i] <- max(0, DealCycle$Bat2[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    DealCycle$Bat3[i] <- max(0, DealCycle$Bat3[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    DealCycle$Bat4[i] <- max(0, DealCycle$Bat4[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    DealCycle$Bat5[i] <- max(0, DealCycle$Bat5[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    
    if(DealCycle$ShadowBatStack[i] == 3 | DealCycle$Skills[i]=="DominionDummy" | DealCycle$Skills[i]=="ShadowBite") {
      if(sum(c(DealCycle$Bat1[i], DealCycle$Bat2[i], DealCycle$Bat3[i], DealCycle$Bat4[i], DealCycle$Bat5[i])==0) > 0) {
        if(DealCycle$Bat1[i]==0) {
          DealCycle$Bat1[i] <- 60000
        } else if(DealCycle$Bat2[i]==0) {
          DealCycle$Bat2[i] <- 60000
        } else if(DealCycle$Bat3[i]==0) {
          DealCycle$Bat3[i] <- 60000
        } else if(DealCycle$Bat4[i]==0) {
          DealCycle$Bat4[i] <- 60000
        } else {
          DealCycle$Bat5[i] <- 60000
        } 
      }
    }
    if(sum(c("QuintupleThrow1", "QuintupleThrow1Add1", "QuintupleThrow1Add2", "QuintupleThrow1Add3", 
             "QuintupleThrow2", "QuintupleThrow2Add1", "QuintupleThrow2Add2", "QuintupleThrow2Add3", 
             "RapidThrow", "RapidThrowAdd1", "RapidThrowAdd2", "RapidThrowAdd3", 
             "RapidThrowLast", "RapidThrowLastAdd1", "RapidThrowLastAdd2", "RapidThrowLastAdd3")==DealCycle[i, 1])==1) {
      if(sum(c(DealCycle$Bat1[i] <= 59040 & DealCycle$Bat1[i] > 990, 
               DealCycle$Bat2[i] <= 59040 & DealCycle$Bat2[i] > 990,
               DealCycle$Bat3[i] <= 59040 & DealCycle$Bat3[i] > 990,
               DealCycle$Bat4[i] <= 59040 & DealCycle$Bat4[i] > 990,
               DealCycle$Bat5[i] <= 59040 & DealCycle$Bat5[i] > 990)) > 0) {
        k <- c(DealCycle$Bat1[i] <= 59040 & DealCycle$Bat1[i] > 990, 
               DealCycle$Bat2[i] <= 59040 & DealCycle$Bat2[i] > 990,
               DealCycle$Bat3[i] <= 59040 & DealCycle$Bat3[i] > 990,
               DealCycle$Bat4[i] <= 59040 & DealCycle$Bat4[i] > 990,
               DealCycle$Bat5[i] <= 59040 & DealCycle$Bat5[i] > 990)
        for(j in 1:sum(k)) {
          DC2 <- rbind(DC2, DealCycle[i, ])
        }
        DealCycle$Bat1[i] <- ifelse(k[1]==T, 990, DealCycle$Bat1[i])
        DealCycle$Bat2[i] <- ifelse(k[2]==T, 990, DealCycle$Bat2[i])
        DealCycle$Bat3[i] <- ifelse(k[3]==T, 990, DealCycle$Bat3[i])
        DealCycle$Bat4[i] <- ifelse(k[4]==T, 990, DealCycle$Bat4[i])
        DealCycle$Bat5[i] <- ifelse(k[5]==T, 990, DealCycle$Bat5[i])
      }
    } 
  }
  DC2 <- DC2[-1, ]
  DC2$Skills <- "ShadowBat"
  DC2$Time <- DC2$Time + 990
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("ShadowBat")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))] < 0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## Shadow Spear (Small)
  DC2 <- DealCycle[1, ]
  for(i in 2:nrow(DealCycle)) {
    if(sum(c("QuintupleThrow1Add1", "QuintupleThrow1Add2", "QuintupleThrow1Add3", "QuintupleThrow1Add4",
             "QuintupleThrow2", "QuintupleThrow2Add1", "QuintupleThrow2Add2", "QuintupleThrow2Add3", "QuintupleThrow2Add4", 
             "RapidThrow", "RapidThrowAdd1", "RapidThrowAdd2", "RapidThrowAdd3", "RapidThrowAdd4", 
             "RapidThrowLast", "RapidThrowLastAdd1", "RapidThrowLastAdd2", "RapidThrowLastAdd3", "RapidThrowLastAdd4", 
             "Dominion", "ShadowBite", "ShadowBat")==DealCycle[i, 1])==1 & DealCycle$ShadowSpear[i] > 0) {
      DC2 <- rbind(DC2, DealCycle[i, ])
    }
  }
  DC2 <- DC2[-1, ]
  DC2$Skills <- "ShadowSpearSmall"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Shadow Spear (Big)
  SS <- subset(DealCycle, DealCycle$Skills=="ShadowSpear")
  Ind <- rownames(SS)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$ShadowSpear[p] > 0) {
      if(time > 3000 & max(DealCycle$Skills[p]==c("ShadowSpearSmall"))==1) {
        DealCycle$Skills[p] <- "ShadowSpearBig"
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("ShadowSpearSmall", "ShadowSpearBig")==DealCycle[i, 1])==1) {
      DealCycle$Time[i] <- DealCycle$Time[i] + 1050
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("ShadowSpearSmall", "ShadowSpearBig")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:ncol(DealCycle))] <- DealCycle[i-1, c(3:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:ncol(DealCycle))] < 0, 0, DealCycle[i, c(3:ncol(DealCycle))])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## Cygnus Phalanx, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, "CygnusPhalanx", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Siphon Vitality
  DealCycle$SiphonVitality <- 1
  
  
  ## Dummy Delete
  DealCycle$ShadowBatStack <- 0
  DealCycle$Bat1 <- 0
  DealCycle$Bat2 <- 0
  DealCycle$Bat3 <- 0
  DealCycle$Bat4 <- 0
  DealCycle$Bat5 <- 0
  DealCycle$ShadowBiteBuffDummy <- 0
  
  return(DealCycle)
}


ATKFinal <- AddATKRateSkillsNW(c("ShadowServant", "ShadowIllusion1", "ShadowIllusion2", "ShadowServantExtend"), 
                               BuffFinal, ATKFinal, c("QuintupleThrow1", "QuintupleThrow2", "RapidThrow", "RapidThrowLast"))
NightWalkerDealCycle <- NightWalkerCycle(PreDealCycle=NightWalkerDealCycle, 
                                         ATKFinal=ATKFinal, 
                                         BuffFinal=BuffFinal, 
                                         SummonedFinal=SummonedFinal, 
                                         Spec=NightWalkerSpec, 
                                         Period=180, 
                                         CycleTime=360, 
                                         JumpShotDelay=0)
NightWalkerDealCycle <- NightWalkerAddATK(DealCycle=NightWalkerDealCycle, 
                                          ATKFinal=ATKFinal, 
                                          BuffFinal=BuffFinal, 
                                          SummonedFinal=SummonedFinal)
NightWalkerDealCycle <- BlessofCygnusCycle(NightWalkerDealCycle, 4000, General$General$Serverlag, GetCoreLv(NightWalkerCore, "BlessofCygnus"))
NightWalkerDealCycleReduction <- DealCycleReduction(NightWalkerDealCycle, c("BlessofCygnusBDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="NightWalker") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  NightWalkerSpecOpt1 <- Optimization1(NightWalkerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpec, NightWalkerUnionRemained, 
                                      NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- NightWalkerSpecOpt1[1, 1:3]
} else {
  NightWalkerSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
NightWalkerSpecOpt <- OptDataAdd(NightWalkerSpec, NightWalkerSpecOpt1, "Potential", NightWalkerBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  NightWalkerSpecOpt2 <- Optimization2(NightWalkerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, NightWalkerHyperStatBase, NightWalkerBase$ChrLv, NightWalkerBase$CRROver, 
                                      NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- NightWalkerSpecOpt2[1, ]
} else {
  NightWalkerSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
NightWalkerSpecOpt <- OptDataAdd(NightWalkerSpecOpt, NightWalkerSpecOpt2, "HyperStat", NightWalkerBase$CRROver, DemonAvenger=F)

NightWalkerFinalDPM <- DealCalc(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, Collapse=F, 
                               NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
NightWalkerFinalDPMwithMax <- DealCalcWithMaxDMR(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, 
                                                NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "NightWalker", sum(na.omit(NightWalkerFinalDPMwithMax)) / (max(NightWalkerDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "NightWalker", sum(na.omit(NightWalkerFinalDPM)) / (max(NightWalkerDealCycle$Time) / 60000) - sum(na.omit(NightWalkerFinalDPMwithMax)) / (max(NightWalkerDealCycle$Time) / 60000))

NightWalkerDealRatio <- DealRatio(NightWalkerDealCycle, NightWalkerFinalDPMwithMax)

NightWalkerDealData <- data.frame(NightWalkerDealCycle$Skills, NightWalkerDealCycle$Time, NightWalkerDealCycle$Restraint4, NightWalkerFinalDPMwithMax)
colnames(NightWalkerDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "NightWalker", Deal_RR(NightWalkerDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "NightWalker", Deal_40s(NightWalkerDealData, F, NA, FinishTime=subset(NightWalkerDealData, NightWalkerDealData$Skills=="Restraint4")$Time[1] + 15000))

NightWalkerSpecMean <- SpecMean("NightWalker", NightWalkerDealCycleReduction, 
                                DealCalcWithMaxDMR(NightWalkerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, 
                                                   NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR")), 
                                ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, 
                                NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))


## Jumpshot Rate (75%)
DealCycle <- c("Skills", "Time", rownames(NightWalkerBuff))
NightWalkerDealCycle75 <- t(rep(0, length(DealCycle)))
colnames(NightWalkerDealCycle75) <- DealCycle
NightWalkerDealCycle75 <- data.frame(NightWalkerDealCycle75)

NightWalkerDealCycle75 <- NightWalkerCycle(PreDealCycle=NightWalkerDealCycle75, 
                                           ATKFinal=ATKFinal, 
                                           BuffFinal=BuffFinal, 
                                           SummonedFinal=SummonedFinal, 
                                           Spec=NightWalkerSpec, 
                                           Period=180, 
                                           CycleTime=360, 
                                           JumpShotDelay=30)
NightWalkerDealCycle75 <- NightWalkerAddATK(DealCycle=NightWalkerDealCycle75, 
                                            ATKFinal=ATKFinal, 
                                            BuffFinal=BuffFinal, 
                                            SummonedFinal=SummonedFinal)
NightWalkerDealCycle75 <- BlessofCygnusCycle(NightWalkerDealCycle75, 4000, General$General$Serverlag,GetCoreLv(NightWalkerCore, "BlessofCygnus"))

NightWalkerFinalDPMwithMax75 <- DealCalcWithMaxDMR(NightWalkerDealCycle75, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, 
                                                   NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))

NightWalker75 <- sum(na.omit(NightWalkerFinalDPMwithMax75)) / (max(NightWalkerDealCycle75$Time) / 60000)
NightWalkerDealRatio75 <- DealRatio(NightWalkerDealCycle75, NightWalkerFinalDPMwithMax75)

NightWalkerDealData75 <- data.frame(NightWalkerDealCycle75$Skills, NightWalkerDealCycle75$Time, NightWalkerDealCycle75$Restraint4, NightWalkerFinalDPMwithMax75)
colnames(NightWalkerDealData75) <- c("Skills", "Time", "R4", "Deal")

NightWalker75RR <- Deal_RR(NightWalkerDealData75)
NightWalker7540s <- Deal_40s(NightWalkerDealData75, F, NA, FinishTime=subset(NightWalkerDealData75, NightWalkerDealData75$Skills=="Restraint4")$Time[1] + 15000)


## Jumpshot Rate (0%)
DealCycle <- c("Skills", "Time", rownames(NightWalkerBuff))
NightWalkerDealCycle0 <- t(rep(0, length(DealCycle)))
colnames(NightWalkerDealCycle0) <- DealCycle
NightWalkerDealCycle0 <- data.frame(NightWalkerDealCycle0)

NightWalkerDealCycle0 <- NightWalkerCycle(PreDealCycle=NightWalkerDealCycle0, 
                                          ATKFinal=ATKFinal, 
                                          BuffFinal=BuffFinal, 
                                          SummonedFinal=SummonedFinal, 
                                          Spec=NightWalkerSpec, 
                                          Period=180, 
                                          CycleTime=360, 
                                          JumpShotDelay=120)
NightWalkerDealCycle0 <- NightWalkerAddATK(DealCycle=NightWalkerDealCycle0, 
                                           ATKFinal=ATKFinal, 
                                           BuffFinal=BuffFinal, 
                                           SummonedFinal=SummonedFinal)
NightWalkerDealCycle0 <- BlessofCygnusCycle(NightWalkerDealCycle0, 4000, General$General$Serverlag, GetCoreLv(NightWalkerCore, "BlessofCygnus"))

NightWalkerFinalDPMwithMax0 <- DealCalcWithMaxDMR(NightWalkerDealCycle0, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, 
                                                  NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))

NightWalker0 <- sum(na.omit(NightWalkerFinalDPMwithMax0)) / (max(NightWalkerDealCycle0$Time) / 60000)
NightWalkerDealRatio0 <- DealRatio(NightWalkerDealCycle0, NightWalkerFinalDPMwithMax0)

NightWalkerDealData0 <- data.frame(NightWalkerDealCycle0$Skills, NightWalkerDealCycle0$Time, NightWalkerDealCycle0$Restraint4, NightWalkerFinalDPMwithMax0)
colnames(NightWalkerDealData0) <- c("Skills", "Time", "R4", "Deal")

NightWalker0RR <- Deal_RR(NightWalkerDealData0)
NightWalker040s <- Deal_40s(NightWalkerDealData0, F, NA, FinishTime=subset(NightWalkerDealData0, NightWalkerDealData0$Skills=="Restraint4")$Time[1] + 15000)

print(list(NW75=data.frame(NightWalker75PDPM=NightWalker75, NightWalker75PRR=NightWalker75RR, NightWalker75P40s=NightWalker7540s), 
           NW0=data.frame(NightWalker0PDPM=NightWalker0, NightWalker0PRR=NightWalker0RR, NightWalker0P40s=NightWalker040s)))