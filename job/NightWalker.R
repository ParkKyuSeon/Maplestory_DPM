## NightWalker - Data
## NightWalker - VMatrix
NightWalkerCore <- MatrixSet(PasSkills=c("QuintupleThrow", "ShadowBat", "Dominion"), 
                             PasLvs=c(50, 50, 50), 
                             PasMP=c(10, 10, 10), 
                             ActSkills=c("ShadowSpear", "ShadowServantExtend", "ShadowBite", "RapidThrow", 
                                         CommonV("Thief", "CygnusKnights")), 
                             ActLvs=c(25, 25, 25, 25, 1, 25, 25, 25, 25), 
                             ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 0), 
                             BlinkLv=1, 
                             BlinkMP=5, 
                             UsefulSkills=c("SharpEyes", "CombatOrders"), 
                             UsefulLvs=20, 
                             UsefulMP=0, 
                             SpecSet=SpecDefault,
                             SelfBind=F)


## NightWalker - Basic Info
## Link Check Needed
NightWalkerBase <- JobBase(ChrInfo=ChrInfo, 
                           MobInfo=MobDefault,
                           SpecSet=SpecDefault, 
                           Job="NightWalker",
                           CoreData=NightWalkerCore, 
                           BuffDurationNeeded=0, 
                           AbilList=c("BDR", "DisorderBDR"), 
                           LinkList=c("CygnusKnights", "Mikhail", "DemonAvenger", "Phantom"), 
                           MonsterLife=MLTypeL21, 
                           Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wristband", SpecDefault$WeaponType)[, 1:16],
                           WeaponType=SpecDefault$WeaponType, 
                           SubWeapon=SubWeapon[19, ], 
                           Emblem=Emblem[3, ],
                           CoolReduceHat=F)


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
value <- c(NightWalkerCore[[2]][5, 2])
ReadyToDiePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(NightWalkerCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

NightWalkerPassive <- Passive(list(FlameJavelin=FlameJavelin, ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, ElementDarkness=ElementDarkness, ThrowingMastery=ThrowingMastery, 
                                   CriticalThrow=CriticalThrow, PhysicalTraining=PhysicalTraining, Adrenaline=Adrenaline, ThrowingExpert=ThrowingExpert, DarknessBlessing=DarknessBlessing, 
                                   ReadyToDiePassive=ReadyToDiePassive, BlinkPassive=BlinkPassive))


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
info <- c(180, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritThrowing <- rbind(data.frame(option, value), info)

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

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * NightWalkerCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * NightWalkerCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(50 + NightWalkerCore[[2]][1, 2], 180 - floor(NightWalkerCore[[2]][1, 2]/2), 600, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowSpear <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(25 + NightWalkerCore[[2]][2, 2])
info <- c(30 + floor(NightWalkerCore[[2]][2, 2]/2), 60, 570, F, T, F, T)
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
value <- c(8 + floor(NightWalkerCore[[2]][3, 2]/3))
info <- c(23.42, 40, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowBiteBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(NightWalkerCore[[2]][6, 2]/10))
info <- c(30, 90 - floor(NightWalkerCore[[2]][6, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(NightWalkerCore[[2]][6, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(NightWalkerCore[[2]][6, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

NightWalkerBuff <- Buff(list(ThrowingBooster=ThrowingBooster, ShadowServant=ShadowServant, SpiritThrowing=SpiritThrowing, ShadowBatStack=ShadowBatStack,
                             Bat1=Bat1, Bat2=Bat2, Bat3=Bat3, Bat4=Bat4, Bat5=Bat5, 
                             SiphonVitality=SiphonVitality, DominionBuff=DominionBuff, ShadowIllusion1=ShadowIllusion1, ShadowIllusion2=ShadowIllusion2, GloryofGardians=GloryofGardians, 
                             UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, ShadowSpear=ShadowSpear, ShadowServantExtend=ShadowServantExtend, ShadowBiteBuff=ShadowBiteBuff, 
                             ShadowBiteBuffDummy=ShadowBiteBuffDummy, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, BlessofCygnus=BlessofCygnus, 
                             Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : ThrowingBooster(600ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms) / Heist Not Used
NightWalkerAllTimeBuff <- AllTimeBuff(NightWalkerBuff)


## NightWalker - Union & HyperStat & SoulWeapon
NightWalkerSpec <- JobSpec(JobBase=NightWalkerBase, 
                       Passive=NightWalkerPassive, 
                       AllTimeBuff=NightWalkerAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="Wristband", 
                       UnionStance=0)

NightWalkerUnionRemained <- NightWalkerSpec$UnionRemained
NightWalkerHyperStatBase <- NightWalkerSpec$HyperStatBase
NightWalkerCoolReduceType <- NightWalkerSpec$CoolReduceType
NightWalkerSpec <- NightWalkerSpec$Spec


## NightWalker - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * NightWalkerCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * NightWalkerCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightWalkerCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightWalkerCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightWalkerCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * NightWalkerCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## NightWalker - Attacks
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, ifelse(NightWalkerCore[[1]][1, 2]>=40, 20, 0), 2 * NightWalkerCore[[1]][1, 2])
info <- c(340 + NightWalkerSpec$SkillLv, 4, 450, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuintupleThrow1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, ifelse(NightWalkerCore[[1]][1, 2]>=40, 20, 0), 2 * NightWalkerCore[[1]][1, 2])
info <- c(475 + NightWalkerSpec$SkillLv, 1, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
QuintupleThrow2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(NightWalkerCore[[1]][2, 2]>=40, 20, 0), 2 * NightWalkerCore[[1]][2, 2])
info <- c(620 + 4 * NightWalkerSpec$SkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowBat <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(NightWalkerCore[[1]][3, 2]>=40, 20, 0), 2 * NightWalkerCore[[1]][3, 2])
info <- c(1000, 10, 2490, NA, 180, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Dominion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(100 + 4 * NightWalkerCore[[2]][1, 2], 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowSpearSmall <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(400 + 16 * NightWalkerCore[[2]][1, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowSpearBig <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(600 + 24 * NightWalkerCore[[2]][3, 2], 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShadowBite <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(475 + 19 * NightWalkerCore[[2]][4, 2], 5, 3300, 180, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RapidThrow <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(850 + 34 * NightWalkerCore[[2]][4, 2], 13, 630, NA, NA, NA, NA, F)
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
info <- c(450 + 18 * NightWalkerCore[[2]][7, 2], 1, 780, 240, 0.24*(39 + NightWalkerCore[[2]][7, 2])+0.25, 30, F, T, F, F)
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
  ifelse(BuffFinal$ServerLag==T, 3, 0)

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
  BuffSummonedPrior <- c("ThrowingBooster", "ShadowServant", "SpiritThrowing", "UsefulSharpEyes", "UsefulCombatOrders", "GloryofGardians",
                         "ShadowSpear", "ShadowServantExtend", "BlessofCygnus", "CygnusPhalanx", "ShadowBiteBuffDummy", "DominionBuff", "ShadowIllusion1", "ShadowIllusion2", 
                         "ReadyToDie2Stack", "SoulContractLink", "Restraint4")
  Times180 <- c(0, 1, 1, 0, 0, 0, 1, 3, 0.5, 6, 9, 1, 1, 1, 2, 2, 1)
  
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
      if(DealCycle$Skills[nrow(DealCycle)] == "DominionBuff") {
        DealCycle <- DCATK(DealCycle, "DominionDummy", ATKFinal)
        DealCycle <- DCATK(DealCycle, "Dominion", ATKFinal)
      } else if(DealCycle$Skills[nrow(DealCycle)] == "ShadowBiteBuffDummy") {
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
        }
      }
      
      if(RapidCool == 0) {
        DealCycle <- DCATK(DealCycle, "RapidThrow", ATKFinal)
        RapidCool <- 90000 - DealCycle$Time[1]
        DealCycle <- DCATK(DealCycle, "RapidThrowLast", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
      } else {
        DealCycle <- DCATK(DealCycle, "QuintupleThrow1", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "QuintupleThrow2", ATKFinal)
        RapidCool <- max(0, RapidCool - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)] == "DominionBuff") {
            DealCycle <- DCATK(DealCycle, "DominionDummy", ATKFinal)
            DealCycle <- DCATK(DealCycle, "Dominion", ATKFinal)
          } else if(DealCycle$Skills[nrow(DealCycle)] == "ShadowBiteBuffDummy") {
            DealCycle <- DCBuff(DealCycle, "ShadowBiteBuff", BuffFinal)
            DealCycle <- DCATK(DealCycle, "ShadowBite", ATKFinal)
          }
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          RapidCool <- max(0, RapidCool - DealCycle$Time[1])
        }
      }
    }
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
NightWalkerDealCycle <- BlessofCygnusCycle(NightWalkerDealCycle, 4000, General$General$Serverlag, NightWalkerCore[[2]][8, 2])
NightWalkerDealCycleReduction <- DealCycleReduction(NightWalkerDealCycle, c("BlessofCygnusBDR"))


WindBreakerDealCalc(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpec)
NightWalkerDealData <- data.frame(NightWalkerDealCycle$Skills, DealCalc(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpec))
colnames(NightWalkerDealData) <- c("Skills", "Deal")


## Damage Optimization
NightWalkerSpecOpt1 <-WindBreakerOptimization1(NightWalkerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpec, NightWalkerUnionRemained)
NightWalkerSpecOpt <- NightWalkerSpec
NightWalkerSpecOpt$ATKP <- NightWalkerSpecOpt$ATKP + NightWalkerSpecOpt1$ATKP
NightWalkerSpecOpt$BDR <- NightWalkerSpecOpt$BDR + NightWalkerSpecOpt1$BDR
NightWalkerSpecOpt$IGR <- IGRCalc(c(NightWalkerSpecOpt$IGR, NightWalkerSpecOpt1$IGR))

NightWalkerSpecOpt2 <- WindBreakerOptimization2(NightWalkerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt, NightWalkerHyperStatBase, NightWalkerBase$ChrLv, NightWalkerBase$CRROver)
NightWalkerFinalDPM <- WindBreakerDealCalc(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)
NightWalkerFinalDPMwithMax <- WindBreakerDealCalcWithMaxDMR(NightWalkerDealCycle, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)

DPM12347$NightWalker[1] <- sum(na.omit(NightWalkerFinalDPMwithMax)) / (max(NightWalkerDealCycle$Time) / 60000)
DPM12347$NightWalker[2] <- sum(na.omit(NightWalkerFinalDPM)) / (max(NightWalkerDealCycle$Time) / 60000) - sum(na.omit(NightWalkerFinalDPMwithMax)) / (max(NightWalkerDealCycle$Time) / 60000)

NightWalkerDealRatio <- DealRatio(NightWalkerDealCycle, NightWalkerFinalDPMwithMax)

NightWalkerDealData <- data.frame(NightWalkerDealCycle$Skills, NightWalkerDealCycle$Time, NightWalkerDealCycle$Restraint4, NightWalkerFinalDPMwithMax, NightWalkerFinalDPM-NightWalkerFinalDPMwithMax)
colnames(NightWalkerDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(NightWalkerDealData, NightWalkerDealData$R4>0)

NightWalkerRR <- NightWalkerDealData[58:825, ]
DPM12347$NightWalker[3] <- sum((NightWalkerRR$Deal))

NightWalker40s <- NightWalkerDealData[58:2028, ]
DPM12347$NightWalker[4] <- sum((NightWalker40s$Deal))


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
NightWalkerDealCycle75 <- BlessofCygnusCycle(NightWalkerDealCycle75, 4000, General$General$Serverlag, NightWalkerCore[[2]][8, 2])
NightWalkerDealCycle75Reduction <- DealCycleReduction(NightWalkerDealCycle75, c("BlessofCygnusBDR"))

NightWalkerFinalDPM75 <- WindBreakerDealCalc(NightWalkerDealCycle75, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)
NightWalkerFinalDPMwithMax75 <- WindBreakerDealCalcWithMaxDMR(NightWalkerDealCycle75, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)

NightWalker75 <- sum(na.omit(NightWalkerFinalDPMwithMax75)) / (max(NightWalkerDealCycle75$Time) / 60000)
NightWalkerDealRatio75 <- DealRatio(NightWalkerDealCycle75, NightWalkerFinalDPMwithMax75)

NightWalkerDealData75 <- data.frame(NightWalkerDealCycle75$Skills, NightWalkerDealCycle75$Time, NightWalkerDealCycle75$Restraint4, NightWalkerFinalDPMwithMax75, NightWalkerFinalDPM75-NightWalkerFinalDPMwithMax75)
colnames(NightWalkerDealData75) <- c("Skills", "Time", "R4", "Deal", "Leakage")

NightWalkerRR75 <- NightWalkerDealData75[58:792, ]
NightWalker75RR <- sum((NightWalkerRR75$Deal))

NightWalker40s75 <- NightWalkerDealData75[58:1923, ]
NightWalker7540s <- sum((NightWalker40s75$Deal))


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
NightWalkerDealCycle0 <- BlessofCygnusCycle(NightWalkerDealCycle0, 4000, General$General$Serverlag, NightWalkerCore[[2]][8, 2])
NightWalkerDealCycle0Reduction <- DealCycleReduction(NightWalkerDealCycle0, c("BlessofCygnusBDR"))

NightWalkerFinalDPM0 <- WindBreakerDealCalc(NightWalkerDealCycle0, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)
NightWalkerFinalDPMwithMax0 <- WindBreakerDealCalcWithMaxDMR(NightWalkerDealCycle0, ATKFinal, BuffFinal, SummonedFinal, NightWalkerSpecOpt2)

NightWalker0 <- sum(na.omit(NightWalkerFinalDPMwithMax0)) / (max(NightWalkerDealCycle0$Time) / 60000)
NightWalkerDealRatio0 <- DealRatio(NightWalkerDealCycle0, NightWalkerFinalDPMwithMax0)

NightWalkerDealData0 <- data.frame(NightWalkerDealCycle0$Skills, NightWalkerDealCycle0$Time, NightWalkerDealCycle0$Restraint4, NightWalkerFinalDPMwithMax0, NightWalkerFinalDPM0-NightWalkerFinalDPMwithMax0)
colnames(NightWalkerDealData0) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(NightWalkerDealData0, NightWalkerDealData0$R4>0)

NightWalkerRR0 <- NightWalkerDealData0[58:725, ]
NightWalker0RR <- sum((NightWalkerRR0$Deal))

NightWalker40s0 <- NightWalkerDealData0[58:1709, ]
NightWalker040s <- sum((NightWalker40s0$Deal))
