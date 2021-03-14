## Striker - Data
## Striker - VMatrix
StrikerCore <- MatrixSet(PasSkills=c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "TidalCrash"), 
                         PasLvs=c(50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 5), 
                         ActSkills=c("LightningCascade", "SharkTorpedo", "LightningGodSpearStrike", "LightningSpearMultistrike", 
                                     CommonV("Pirate", "CygnusKnights")), 
                         ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 5), 
                         UsefulSkills=c("SharpEyes", "CombatOrders"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault)


## Striker - Basic Info
StrikerBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Striker",
                       CoreData=StrikerCore, 
                       MikhailLink=F, 
                       OtherBuffDuration=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("CygnusKnights", "Xenon", "DemonAvenger", "Phantom"), 
                       MonsterLife=MLTypeS21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[19, ], 
                       Emblem=Emblem[3, ],
                       CoolReduceHat=T)


## Striker - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(StrikerBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
Noebaek <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(5)
Geukgap <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Noeje <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(StrikerBase$PSkillLv/2), 30 + StrikerBase$PSkillLv, 20 + floor(StrikerBase$PSkillLv/2))
KnuckleExpert <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 25)
Noesin <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(20)
PrimalBolt <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + StrikerCore[[2]][5, 2])
LoadedDicePassive <- data.frame(option, value)}

StrikerPassive <- Passive(list(ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, PhysicalTraining=PhysicalTraining, Noebaek=Noebaek, 
                               Geukgap=Geukgap, Noeje=Noeje, KnuckleExpert=KnuckleExpert, Noesin=Noesin, PrimalBolt=PrimalBolt, LoadedDicePassive=LoadedDicePassive))


## Striker - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementLightning <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
KnuckleBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((StrikerBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(StrikerBase$SkillLv/2))))
info <- c(900 + 30 * StrikerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(70 + StrikerBase$SkillLv)
info <- c(180, NA, 900, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ArcCharger <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindBooster <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(35)
info <- c(90 + StrikerBase$PSkillLv, 900, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TyphoonBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 930, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PrimalBolt <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, NA, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightningStack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LinkMastery <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * SoulMasterCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * SoulMasterCore[[3]][2, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(5 + floor(StrikerCore[[2]][1, 2]/6))
info <- c(30 + floor(StrikerCore[[2]][1, 2]/2), 120 - floor(StrikerCore[[2]][1, 2]/2), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightningCascadeBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(60, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightningSpearMultistrikeBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * StrikerCore[[2]][7, 2]) * 221))
info <- c(30, 70 - floor(StrikerCore[[2]][7, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * 221))
info <- c(Cooldown(70 - floor(StrikerCore[[2]][7, 2]/5), T, StrikerBase$UnionChrs$CoolReduceP, StrikerBase$CoolReduce) - 30 - General$General$Serverlag, 70 - floor(StrikerCore[[2]][7, 2]/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 180, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}


StrikerBuff <- Buff(list(ElementLightning=ElementLightning, KnuckleBooster=KnuckleBooster, MapleSoldier=MapleSoldier, ArcCharger=ArcCharger, WindBooster=WindBooster, TyphoonBuff=TyphoonBuff, 
                         GloryofGardians=GloryofGardians, PrimalBolt=PrimalBolt, LightningStack=LightningStack, LinkMastery=LinkMastery, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, LightningCascadeBuff=LightningCascadeBuff, 
                         LightningSpearMultistrikeBuff=LightningSpearMultistrikeBuff, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, LuckyDice5=LuckyDice5, 
                         BlessofCygnus=BlessofCygnus, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : ElementLightning, KnuckleBooster, WindBooster
StrikerAllTimeBuff <- AllTimeBuff(StrikerBuff)


## Striker - Union & HyperStat & SoulWeapon
StrikerSpec <- JobSpec(JobBase=StrikerBase, 
                       Passive=StrikerPassive, 
                       AllTimeBuff=StrikerAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="Knuckle", 
                       UnionStance=0)

StrikerUnionRemained <- StrikerSpec$UnionRemained
StrikerHyperStatBase <- StrikerSpec$HyperStatBase
StrikerCoolReduceType <- StrikerSpec$CoolReduceType
StrikerSpec <- StrikerSpec$Spec


## Striker - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * StrikerCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * StrikerCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * StrikerCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * StrikerCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * StrikerCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * StrikerCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Striker - Attacks
## Hyper Setting : Typhoon - Bonus ATK, Thunderbolt - Reinforce / Bonus ATK, Annihilate - Reinforce / Boss Killer
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, ifelse(StrikerCore[[1]][1, 2]>=40, 20, 0), 2 * StrikerCore[[1]][1, 2])
info <- c(350 + 4 * StrikerSpec$SkillLv, 7, 1170, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Annihilate <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(StrikerCore[[1]][2, 2]>=40, 20, 0), 2 * StrikerCore[[1]][2, 2])
info <- c(320 + 4 * StrikerSpec$SkillLv, 6, 1050, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Thunderbolt <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(StrikerCore[[1]][3, 2]>=40, 20, 0), 2 * StrikerCore[[1]][3, 2])
info <- c(390 + 3 * StrikerSpec$SkillLv, 6, 1200, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Typhoon <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(StrikerCore[[1]][4, 2]>=40, 20, 0), 2 * StrikerCore[[1]][4, 2])
info <- c(860, 7, 2130, NA, 45, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeepRising <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(400 + 16 * StrikerCore[[2]][1, 2], 7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningCascade <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(1000 + 40 * StrikerCore[[2]][2, 2], 7, 630, NA, 8, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SharkTorpedo <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(150 + 6 * StrikerCore[[2]][3, 2], 6, 0, NA, 7, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningGodSpearStrike <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(208 + 8 * StrikerCore[[2]][3, 2], 7, 0, 202.5, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningGodSpearStrikeShock <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(375 + 15 * StrikerCore[[2]][4, 2], 5, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearMultistrike <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(600 + 24 * StrikerCore[[2]][4, 2], 7, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearMultistrikeLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(500 + 20 * StrikerCore[[2]][4, 2], 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearMultistrikeLightning <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(725 + 29 * StrikerCore[[2]][4, 2], 6, 0, 180, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningSpearMultistrikeLastLightning <- rbind(data.frame(option, value), info)}

StrikerATK <- Attack(list(Annihilate=Annihilate, Thunderbolt=Thunderbolt, Typhoon=Typhoon, DeepRising=DeepRising, LightningCascade=LightningCascade, 
                          SharkTorpedo=SharkTorpedo, LightningGodSpearStrike=LightningGodSpearStrike, LightningGodSpearStrikeShock=LightningGodSpearStrikeShock, LightningSpearMultistrike=LightningSpearMultistrike, 
                          LightningSpearMultistrikeLast=LightningSpearMultistrikeLast, LightningSpearMultistrikeLightning=LightningSpearMultistrikeLightning, 
                          LightningSpearMultistrikeLastLightning=LightningSpearMultistrikeLastLightning, SpiderInMirror=SpiderInMirror))


## Striker - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * StrikerCore[[2]][7, 2], 1, 780, 240, 0.24*(39 + StrikerCore[[2]][7, 2])+0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

StrikerSummoned <- Summoned(list(CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, 
                                 SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Striker - Deal Cycle and Deal Calculation
ATKFinal <- data.frame(StrikerATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, StrikerSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, StrikerSpec$CoolReduceP, StrikerSpec$CoolReduce)

BuffFinal <- data.frame(StrikerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, StrikerSpec$CoolReduceP, StrikerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, StrikerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(StrikerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, StrikerSpec$CoolReduceP, StrikerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * StrikerSpec$SummonedDuration / 100, 0)


## Striker - Delay Skip Structure
StrikerSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
StrikerSkipATK <- data.frame(StrikerSkipATK, row.names=c(rownames(ATKFinal)))
colnames(StrikerSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

StrikerSkipATK$Annihilate <- c(F, T, T, T, F, T, F, F, T, T, F, F, F)
StrikerSkipATK$Thunderbolt <- c(T, F, T, T, F, T, F, F, T, T, F, F, F)
StrikerSkipATK$Typhoon <- c(T, T, F, T, F, T, F, F, T, T, F, F, F)
StrikerSkipATK$DeepRising <- c(T, T, T, F, F, T, F, F, T, T, F, F, F)
StrikerSkipATK$SharkTorpedo <- c(T, T, T, T, F, F, F, F, T, T, F, F, F)
StrikerSkipATK$LightningSpearMultistrike <- c(T, T, T, T, F, T, F, F, T, T, F, F, F)
StrikerSkipATK$LightningSpearMultistrikeLast <- c(T, T, T, T, F, T, F, F, T, F, F, F, F)
StrikerSkipATK$SkippedDelay <- c(Delay(630, StrikerSpec$ATKSpeed), Delay(690, StrikerSpec$ATKSpeed), Delay(540, StrikerSpec$ATKSpeed), Delay(540, StrikerSpec$ATKSpeed), 0, 
                                 Delay(480, StrikerSpec$ATKSpeed), 0, 0, Delay(300, StrikerSpec$ATKSpeed), Delay(600, StrikerSpec$ATKSpeed), 0, 0, 0)
StrikerSkipATK <- subset(StrikerSkipATK, StrikerSkipATK$SkippedDelay>0)

## Striker - DealCycle
DealCycle <- c("Skills", "Time", rownames(StrikerBuff))
StrikerDealCycle <- t(rep(0, length(DealCycle)))
colnames(StrikerDealCycle) <- DealCycle
StrikerDealCycle <- data.frame(StrikerDealCycle)

StrikerCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, 
                          Period=c(120), CycleTime=c(240)) {
  BuffSummonedPrior <- c("ElementLightning", "KnuckleBooster", "ArcCharger", "WindBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "LuckyDice5",
                         "GloryofGardians", "CygnusPhalanx", "BlessofCygnus", "LightningCascadeBuff", "PrimalBolt", "OverDrive", "SoulContractLink", "Restraint4")
  Times120 <- c(0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0, 0, 4, 0.5, 1, 1, 2, 1, 0.5)
  
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
  DealCycle$LightningStack <- 5
  Link <- 0
  
  CoolControl <- function(Cool, DealCycle, ATKFinal, BuffFinal, Link) {
    Cool$LGSS <- max(Cool$LGSS - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)]), 0)
    Cool$LGSSTimes <- ifelse(Link==1, min(9, Cool$LGSSTimes + 1), Cool$LGSSTimes)
    Cool$SharkTorpedo <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="SharkTorpedo", subset(ATKFinal, rownames(ATKFinal)=="SharkTorpedo")$CoolTime * 1000, 
                                max(Cool$SharkTorpedo - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)]), 0))
    Cool$DeepRising <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="DeepRising", subset(ATKFinal, rownames(ATKFinal)=="DeepRising")$CoolTime * 1000, 
                              max(Cool$DeepRising - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)]), 0))
    Cool$DeepRisingTimes <- nrow(subset(DealCycle, DealCycle$Skills=="DeepRising"))
    Cool$LSMS <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="LightningSpearMultistrikeBuff", 120000, max(Cool$LSMS - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[(nrow(DealCycle)-1)]), 0))
    return(Cool)
  }
  Cool <- data.frame(LGSS=0, LGSSTimes=0, SharkTorpedo=0, LSMS=0, DeepRising=0, DeepRisingTimes=0)
  
  LinkDelay <- function(DealCycle, SkipStructure) {
    if(sum(DealCycle$Skills[nrow(DealCycle)]==rownames(SkipStructure))==1) {
      d <- subset(SkipStructure, rownames(SkipStructure)==DealCycle$Skills[nrow(DealCycle)])$SkippedDelay
    } else {
      d <- DealCycle$Time[1]
    }
    return(d)
  }
  
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
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          Link <- 0
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        }
      }
      ## Typhoon (Taepung) for Buff
      if(DealCycle$TyphoonBuff[nrow(DealCycle)] == 0 & DealCycle$LightningStack[nrow(DealCycle)] == 5) {
        DealCycle <- DCATKSkip(DealCycle, "Typhoon", ATKFinal, SkipStructure)
        DealCycle$TyphoonBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="TyphoonBuff")$Duration * 1000
        DealCycle$LightningStack[nrow(DealCycle)] <- ifelse(DealCycle$PrimalBolt[nrow(DealCycle)] > 0, DealCycle$LightningStack[(nrow(DealCycle)-1)], 0)
        DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
        Link <- 1
        Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
          Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
          Cool$LGSSTimes <- 0
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
          rownames(DealCycle) <- 1:nrow(DealCycle)
        }
      }
      ## Shark Torpedo (Gyoatan)
      else if(Cool$SharkTorpedo - LinkDelay(DealCycle, SkipStructure) <= 0 & DealCycle$LightningStack[nrow(DealCycle)] >= 2) {
        DealCycle <- DCATKSkip(DealCycle, "SharkTorpedo", ATKFinal, SkipStructure)
        DealCycle$LightningStack[nrow(DealCycle)] <- ifelse(DealCycle$PrimalBolt[nrow(DealCycle)] > 0, DealCycle$LightningStack[(nrow(DealCycle)-1)], DealCycle$LightningStack[(nrow(DealCycle)-1)]-2)
        DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
        Link <- 1
        Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
          Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
          Cool$LGSSTimes <- 0
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
          rownames(DealCycle) <- 1:nrow(DealCycle)
        }
      }
      ## Deep Rising (Haesingangrim)
      else if(Cool$DeepRising - LinkDelay(DealCycle, SkipStructure) <= 0 & Cool$DeepRisingTimes < 5) {
        DealCycle <- DCATKSkip(DealCycle, "DeepRising", ATKFinal, SkipStructure)
        DealCycle$LightningStack[nrow(DealCycle)] <- min(DealCycle$LightningStack[(nrow(DealCycle)-1)] + 1, 5)
        DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
        Link <- 1
        Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
          Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
          Cool$LGSSTimes <- 0
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
          rownames(DealCycle) <- 1:nrow(DealCycle)
        }
      }
      ## Lightning Spear Multistrike (Changnoeyeongyeok)
      else if(Cool$LSMS - LinkDelay(DealCycle, SkipStructure) <= 0) {
        DealCycle <- DCBuff(DealCycle, "LightningSpearMultistrikeBuff", BuffFinal)
        DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
        Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        for(i in 1:11) {
          DealCycle <- DCATKSkip(DealCycle, "LightningSpearMultistrike", ATKFinal, SkipStructure)
          DealCycle$LightningStack[nrow(DealCycle)] <- min(DealCycle$LightningStack[(nrow(DealCycle)-1)] + 1, 5)
          DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
          Link <- 1
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
          if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
            Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
            Cool$LGSSTimes <- 0
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
            rownames(DealCycle) <- 1:nrow(DealCycle)
          }
        }
        DealCycle <- DCATKSkip(DealCycle, "LightningSpearMultistrikeLast", ATKFinal, SkipStructure)
        DealCycle$LightningStack[nrow(DealCycle)] <- min(DealCycle$LightningStack[(nrow(DealCycle)-1)] + 1, 5)
        DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
        Link <- 1
        Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
          Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
          Cool$LGSSTimes <- 0
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
          rownames(DealCycle) <- 1:nrow(DealCycle)
        }
      }
      ## Primal Bolt (Cheonjigaebyeok) : Typhoon (Taepung) - Annihilate (Seommyeol) 
      else if(DealCycle$PrimalBolt[nrow(DealCycle)] > 0) {
        if(DealCycle$Skills[nrow(DealCycle)]!="Typhoon") {
          DealCycle <- DCATKSkip(DealCycle, "Typhoon", ATKFinal, SkipStructure)
          DealCycle$TyphoonBuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="TyphoonBuff")$Duration * 1000
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
          Link <- 1
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
          if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
            Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
            Cool$LGSSTimes <- 0
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
            rownames(DealCycle) <- 1:nrow(DealCycle)
          }
        } else {
          DealCycle <- DCATKSkip(DealCycle, "Annihilate", ATKFinal, SkipStructure)
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
          Link <- 1
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
          if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
            Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
            Cool$LGSSTimes <- 0
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
            rownames(DealCycle) <- 1:nrow(DealCycle)
          }
        }
      }
      ## Annihilate (Seommyeol) - Thunderbolt (Byeokryeok)
      else {
        if(DealCycle$Skills[nrow(DealCycle)]!="Annihilate") {
          DealCycle <- DCATKSkip(DealCycle, "Annihilate", ATKFinal, SkipStructure)
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
          Link <- 1
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
          if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
            Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
            Cool$LGSSTimes <- 0
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
            rownames(DealCycle) <- 1:nrow(DealCycle)
          }
        } else {
          DealCycle <- DCATKSkip(DealCycle, "Thunderbolt", ATKFinal, SkipStructure)
          DealCycle$LightningStack[nrow(DealCycle)] <- min(DealCycle$LightningStack[(nrow(DealCycle)-1)] + 1, 5)
          DealCycle$LinkMastery[nrow(DealCycle)] <- ifelse(Link==1, 1, 0)
          Link <- 1
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
          if(Cool$LGSS == 0 & Cool$LGSSTimes==9) {
            Cool$LGSS <- subset(ATKFinal, rownames(ATKFinal)=="LightningGodSpearStrike")$CoolTime * 1000
            Cool$LGSSTimes <- 0
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[(nrow(DealCycle)-1)] <- "LightningGodSpearStrikeShock"
            rownames(DealCycle) <- 1:nrow(DealCycle)
          }
        }
      }
    }
      
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          Link <- 0
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle$LightningStack[nrow(DealCycle)] <- DealCycle$LightningStack[(nrow(DealCycle)-1)]
          Link <- 0
          Cool <- CoolControl(Cool, DealCycle, ATKFinal, BuffFinal, Link)
        }
      }
    }
  }
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
StrikerAddATK <- function(DealCycle, ATKFinal, SummonedFinal) {
  ## Lightning God Spear Strike (Noesinchanggyeok) 
  DealCycle <- RepATKCycle(DealCycle, "LightningGodSpearStrikeShock", 4, 1350, ATKFinal)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="LightningGodSpearStrikeShockStart") {
      DealCycle$Skills[i] <- "LightningGodSpearStrike"
    }
  }
  
  ## Lightning Spear Multistrike (Changnoeyeongyeok) - Lightning
  DC2 <- subset(DealCycle, DealCycle$Skills=="LightningSpearMultistrike")
  DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills=="LightningSpearMultistrikeLast"))
  for(i in 1:nrow(DC2)) {
    DC2$Skills[i] <- paste(DC2$Skills[i], "Lightning", sep="")
    DC2$Time[i] <- DC2$Time[i] + 180
  }
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 1:nrow(DealCycle)) {
    if(sum(c("LightningSpearMultistrikeLightning", "LightningSpearMultistrikeLastLightning")==DealCycle[i, 1])==1) {
      DealCycle[i, c(3:10, 13:ncol(DealCycle))] <- DealCycle[i-1, c(3:10, 13:ncol(DealCycle))] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, c(3:10, 13:ncol(DealCycle))] <- ifelse(DealCycle[i, c(3:10, 13:ncol(DealCycle))]<0, 0, DealCycle[i, c(3:10, 13:ncol(DealCycle))])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  DealCycle <- RepATKCycle(DealCycle, "LightningSpearMultistrikeLastLightning", 3, 0, ATKFinal)
  
  ## Lightning Cascade (Sinnoehapil) - Lightning
  LC <- subset(DealCycle, DealCycle$Skills=="LightningCascadeBuff")
  Ind <- rownames(LC)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 3001
    while(p < Ind[i+1] & DealCycle$LightningCascadeBuff[p] > 0) {
      if(time > 3000 & max(DealCycle$Skills[p]==c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "SharkTorpedo", "LightningSpearMultistrike", "LightningSpearMultistrikeLast"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("LightningCascade")
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
  
  ## Cygnus Phalanx, Spider In Mirror
  DealCycle <- DCSummonedATKs(DealCycle, Skill=c("CygnusPhalanx"), SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Lightning Stack
  for(i in 3:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("LightningCascade", "LightningGodSpearStrike", "LightningGodSpearStrikeShock", "CygnusPhalanx"))==1) {
      DealCycle$LightningStack[i] <- min(5, DealCycle$LightningStack[i-1] + 1)
    } else if(sum(DealCycle$Skills[i]==c("Thunderbolt", "LightningSpearMultistrike", "LightningSpearMultistrikeLast", "DeepRising"))==1 & 
              DealCycle$LightningStack[i-1]==DealCycle$LightningStack[i]) {
      DealCycle$LightningStack[i] <- min(5, DealCycle$LightningStack[i-1] + 1)
    } else if(sum(DealCycle$Skills[i]!=c("SharkTorpedo", "Typhoon"))==2 & DealCycle$LightningStack[i-1] > DealCycle$LightningStack[i]) {
      DealCycle$LightningStack[i] <- DealCycle$LightningStack[i-1]
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SharkTorpedo") {
      DealCycle$LightningStack[i] <- min(5, DealCycle$LightningStack[i-1] + 2)
    } else if(DealCycle$Skills[i]=="Typhoon") {
      DealCycle$LightningStack[i] <- 5
    }
  }
  
  ## Arc Charger (Chukroe)
  SkillList <- c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "LightningCascade", "SharkTorpedo", 
                 "LightningGodSpearStrike", "LightningGodSpearStrikeShock", "LightningSpearMultistrike", "LightningSpearMultistrikeLast", 
                 "LightningSpearMultistrikeLightning", "LightningSpearMultistrikeLastLightning")
  DC2 <- subset(DealCycle, DealCycle$Skills==SkillList[1])
  for(i in 2:length(SkillList)) {
    DC2 <- rbind(DC2, subset(DealCycle, DealCycle$Skills==SkillList[i]))
  }
  for(i in 1:nrow(DC2)) {
    DC2$Skills[i] <- paste(DC2$Skills[i], "Add", sep="")
  }
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Link Mastery
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("LightningCascade", "LightningCascadeAdd", 
                                  "LightningGodSpearStrike", "LightningGodSpearStrikeAdd", "LightningGodSpearStrikeShock", "LightningGodSpearStrikeShockAdd", 
                                  "SpiderInMirror", "CygnusPhalanx", "SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", 
                                  "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait"))==1) {
      DealCycle$LinkMastery[i] <- 0
    }
  }
  return(DealCycle)
}
AddATKRateSkillsST <- function(AddATKSKillName, BuffSkills, AttackSkills, AddATKAppliedSkills) {
  AddATKRateSkill <- BuffSkills[rownames(BuffSkills)==AddATKSKillName, ]
  AddATKRate <- AddATKRateSkill$AddATKRate
  
  for(i in 1:length(AddATKAppliedSkills)) {
    AttackSkills <- rbind(AttackSkills, AttackSkills[AddATKAppliedSkills[i]==rownames(AttackSkills), ])
    rownames(AttackSkills)[nrow(AttackSkills)] <- paste(AddATKAppliedSkills[i], "Add", sep="")
    AttackSkills$Damage[nrow(AttackSkills)] <- AttackSkills$Damage[nrow(AttackSkills)] * subset(BuffFinal, rownames(BuffFinal)=="ArcCharger")$AddATKRate / 100
  }
  return(AttackSkills)
}
  
ATKFinal <- AddATKRateSkillsST("ArcCharger", BuffFinal, ATKFinal, c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "LightningCascade", "SharkTorpedo", 
                                                                    "LightningGodSpearStrike", "LightningGodSpearStrikeShock", "LightningSpearMultistrike", "LightningSpearMultistrikeLast", 
                                                                    "LightningSpearMultistrikeLightning", "LightningSpearMultistrikeLastLightning"))
StrikerDealCycle <- StrikerCycle(PreDealCycle=StrikerDealCycle, 
                                 ATKFinal=ATKFinal,
                                 BuffFinal=BuffFinal,
                                 SummonedFinal=SummonedFinal, 
                                 SkipStructure=StrikerSkipATK,
                                 Spec=StrikerSpec)
StrikerDealCycle <- StrikerAddATK(DealCycle=StrikerDealCycle, 
                                  ATKFinal=ATKFinal, 
                                  SummonedFinal=SummonedFinal)
StrikerDealCycle <- OverDriveExhaustBuff(StrikerDealCycle, BuffFinal$Duration[15], BuffFinal$CoolTime[15])
StrikerDealCycle <- BlessofCygnusCycle(StrikerDealCycle, 6000, General$General$Serverlag, StrikerCore[[2]][8, 2])
StrikerDealCycleReduction <- DealCycleReduction(StrikerDealCycle, c("BlessofCygnusBDR", "LightningStack"))


StrikerDealCalc(StrikerDealCycle, ATKFinal, BuffFinal, SummonedFinal, StrikerSpec)
StrikerDealData <- data.frame(StrikerDealCycle$Skills, DealCalc(StrikerDealCycle, ATKFinal, BuffFinal, SummonedFinal, StrikerSpec))
colnames(StrikerDealData) <- c("Skills", "Deal")


## Damage Optimization
StrikerSpecOpt1 <- StrikerOptimization1(StrikerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, StrikerSpec, StrikerUnionRemained)
StrikerSpecOpt <- StrikerSpec
StrikerSpecOpt$ATKP <- StrikerSpecOpt$ATKP + StrikerSpecOpt1$ATKP
StrikerSpecOpt$BDR <- StrikerSpecOpt$BDR + StrikerSpecOpt1$BDR
StrikerSpecOpt$IGR <- IGRCalc(c(StrikerSpecOpt$IGR, StrikerSpecOpt1$IGR))

StrikerSpecOpt2 <- StrikerOptimization2(StrikerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, StrikerSpecOpt, StrikerHyperStatBase, StrikerBase$ChrLv, StrikerBase$CRROver)
StrikerFinalDPM <- StrikerDealCalc(StrikerDealCycle, ATKFinal, BuffFinal, SummonedFinal, StrikerSpecOpt2)
StrikerFinalDPMwithMax <- StrikerDealCalcWithMaxDMR(StrikerDealCycle, ATKFinal, BuffFinal, SummonedFinal, StrikerSpecOpt2)

DPM12344$Striker[1] <- sum(na.omit(StrikerFinalDPMwithMax)) / (240480 / 60000)
DPM12344$Striker[2] <- sum(na.omit(StrikerFinalDPM)) / (240480 / 60000) - sum(na.omit(StrikerFinalDPMwithMax)) / (240480 / 60000)

StrikerDealRatio <- DealRatio(StrikerDealCycle, StrikerFinalDPMwithMax)

StrikerDealData <- data.frame(StrikerDealCycle$Skills, StrikerDealCycle$Time, StrikerDealCycle$Restraint4, StrikerFinalDPMwithMax, StrikerFinalDPM-StrikerFinalDPMwithMax)
colnames(StrikerDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(StrikerDealData, StrikerDealData$R4>0)

StrikerRR <- StrikerDealData[34:230, ]
DPM12344$Striker[3] <- sum((StrikerRR$Deal))

Striker40s <- StrikerDealData[34:479, ]
DPM12344$Striker[4] <- sum((Striker40s$Deal))