## Adele - Data
## Adele - VMatrix
AdeleCore <- MatrixSet(PasSkills=c("Divide", "Order_Grave", "Territory_Tred", "Creation_Gathering", "Blossom", "Shard_Wonder", "Impale_Resonance_Marker"), 
                        PasLvs=c(50, 50, 50, 50, 50, 50, 50), 
                        PasMP=c(10, 10, 10, 10, 10, 5, 5), 
                        ActSkills=c("Ruin", "Infinite", "Restore", "Storm", 
                                    CommonV("Warrior", "Lef")), 
                        ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                        ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                        UsefulSkills=c("CombatOrders", "SharpEyes"), 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=SpecDefault)



## Adele - Basic Info
AdeleBase <- JobBase(ChrInfo=ChrInfo, 
                     MobInfo=MobDefault,
                     SpecSet=SpecDefault, 
                     Job="Adele",
                     CoreData=AdeleCore, 
                     MikhailLink=F, 
                     OtherBuffDuration=0, 
                     AbilList=c("BDR", "DisorderBDR"), 
                     LinkList=c("Adele", "Phantom", "DemonAvenger", "Xenon"), 
                     MonsterLife=MLTypeS21, 
                     Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Tuner", SpecDefault$WeaponType)[, 1:16],
                     WeaponType=SpecDefault$WeaponType, 
                     SubWeapon=SubWeapon[37, ], 
                     Emblem=Emblem[9, ], 
                     CoolReduceHat=T)



## Adele - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[10, 6] * 0.15), floor(AdeleBase$ItemSet$ATKSub * 0.35)))
MagicCircuit <- data.frame(option, value)

option <- factor(c("CDMR", "ATKP"), levels=PSkill)
value <- c(10, 10)
Pace <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Rudiment <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Mastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
Train <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "CRR"), levels=PSkill)
value <- c(30, 15, 20)
Ascent <- data.frame(option, value)

option <- factor(c("ATK", "Mastery"), levels=PSkill)
value <- c(30 + AdeleBase$PSkillLv, 70 + ceiling(AdeleBase$PSkillLv/2))
Expert <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(30 + AdeleBase$PSkillLv, 20 + AdeleBase$PSkillLv)
Demolition <- data.frame(option, value)

option <- factor(c("ATK", "BDR", "CRR"), levels=PSkill)
value <- c(30 + AdeleBase$PSkillLv, 10 + floor(AdeleBase$PSkillLv/2), 20 + AdeleBase$PSkillLv)
Attain <- data.frame(option, value)

option <- factor(c("BDR", "IGR"), levels=PSkill)
value <- c(20 + floor(AdeleBase$SkillLv/2), 10)
GraveDebuff <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(AdeleCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)}

AdelePassive <- Passive(list(MagicCircuit=MagicCircuit, Pace=Pace, Rudiment=Rudiment, Mastery=Mastery, Train=Train, 
                             Ascent=Ascent, Expert=Expert, Demolition=Demolition, Attain=Attain, GraveDebuff=GraveDebuff, BodyofStealPassive=BodyofStealPassive))


## Adele - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Booster <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=BSkill)
value <- c(10, 10)
info <- c(30, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ResonanceBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(10)
info <- c(30, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GatheringDebuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((AdeleBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(AdeleBase$SkillLv/2))))
info <- c(900 + 30 * AdeleBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15)
info <- c(20, 180, 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Nobility <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RaceofGod <- rbind(data.frame(option, value), info)

option <- factor("ATKSkill", levels=BSkill)
value <- c(1)
info <- c(30, 180, 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfiniteBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15 + AdeleCore[[2]][3, 2])
info <- c(30, 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RestoreBuff <- rbind(data.frame(option, value), info) ## EtherPlus

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * AdeleCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * AdeleCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(AdeleCore[[2]][5, 2]/5), ceiling(AdeleCore[[2]][5, 2]/5))
info <- c(80 + 2 * AdeleCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + AdeleCore[[2]][7, 2])
info <- c(30 + AdeleCore[[2]][7, 2], 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * AdeleCore[[2]][8, 2] + (min((0.4 + 0.02 * AdeleCore[[2]][8, 2]) * AdeleBase$ItemSet$ATKSub, floor(ArcaneShade[16, 6] * 1.5))))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandis <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EtherRecovery <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order1 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Order3 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OrderRestore <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Ether <- rbind(data.frame(option, value), info)}

AdeleBuff <- Buff(list(Booster=Booster, ResonanceBuff=ResonanceBuff, GatheringDebuff=GatheringDebuff, MapleSoldier=MapleSoldier, Nobility=Nobility, RaceofGod=RaceofGod,
                       InfiniteBuff=InfiniteBuff, RestoreBuff=RestoreBuff, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, AuraWeaponBuff=AuraWeaponBuff, 
                       MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, BlessofGrandis=BlessofGrandis, Restraint4=Restraint4, SoulContractLink=SoulContractLink, EtherRecovery=EtherRecovery,
                       Order1=Order1, Order2=Order2, Order3=Order3, OrderRestore=OrderRestore, Ether=Ether))
## PetBuff : Booster, MapleSoldier
AdeleAllTimeBuff <- AllTimeBuff(AdeleBuff)


## Adele - Union & HyperStat & SoulWeapon
AdeleSpec <- JobSpec(JobBase=AdeleBase, 
                     Passive=AdelePassive, 
                     AllTimeBuff=AdeleAllTimeBuff, 
                     MobInfo=MobDefault, 
                     SpecSet=SpecDefault, 
                     WeaponName="Tuner", 
                     UnionStance=0)

AdeleUnionRemained <- AdeleSpec$UnionRemained
AdeleHyperStatBase <- AdeleSpec$HyperStatBase
AdeleCoolReduceType <- AdeleSpec$CoolReduceType
AdeleSpec <- AdeleSpec$Spec


## Adele - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * AdeleCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * AdeleCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Adele - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][6, 2]>=40, 20, 0), 2 * AdeleCore[[1]][6, 2])
info <- c(450 + 3 * AdeleSpec$SkillLv, 15, 0, NA, 8, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Wonder <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][4, 2]>=40, 20, 0), 2 * AdeleCore[[1]][4, 2])
info <- c(710 + 3 * AdeleSpec$SkillLv, 2, 0, NA, 1.5, F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Creation <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][7, 2]>=40, 20, 0), FDRCalc(c(2 * AdeleCore[[1]][7, 2], 75)))
info <- c(510 + 3 * AdeleSpec$SkillLv, 6, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Resonance <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ResonanceMove <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][4, 2]>=40, 20, 0), 2 * AdeleCore[[1]][4, 2])
info <- c(560 + 3 * AdeleSpec$SkillLv, 4, 0, 0, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Gathering <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][3, 2]>=40, 20, 0), 2 * AdeleCore[[1]][3, 2])
info <- c(400 + 5 * AdeleSpec$SkillLv, 4, 540, 360, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Territory <- rbind(data.frame(option, value), info) ## ATKSpeed Uneffected

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][3, 2]>=40, 20, 0), 2 * AdeleCore[[1]][3, 2])
info <- c(850 + 5 * AdeleSpec$SkillLv, 12, 0, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TerritoryExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][1, 2]>=40, 20, 0), 20, 2 * AdeleCore[[1]][1, 2])
info <- c(375 + 3 * AdeleSpec$SkillLv, 6, 780, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Divide <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][5, 2]>=40, 20, 0), 2 * AdeleCore[[1]][5, 2])
info <- c(650 + 6 * AdeleSpec$SkillLv, 8, 420, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Blossom1st <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][5, 2]>=40, 20, 0), 2 * AdeleCore[[1]][5, 2])
info <- c((650 + 6 * AdeleSpec$SkillLv) * 0.75, 8, 0, NA, Cooldown(20, T, 25 + AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlossomRemain <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][2, 2]>=40, 20, 0), 2 * AdeleCore[[1]][2, 2])
info <- c(800 + 20 * AdeleSpec$SkillLv, 10, 840, NA, 90, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Grave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(AdeleCore[[1]][7, 2]>=40, 20, 0), 2 * AdeleCore[[1]][7, 2])
info <- c(2000, 6, 900, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Marker <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * AdeleCore[[2]][1, 2], 6, 780, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ruin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * AdeleCore[[2]][1, 2], 9, 0, 300, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RuinExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * AdeleCore[[2]][2, 2], 36, 0, 1050, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Infinite <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 36 * AdeleCore[[2]][3, 2], 3, 0, 3000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Restore <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * AdeleCore[[2]][4, 2], 2, 780, 300, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Storm <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * AdeleCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * AdeleCore[[2]][7, 2], 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

AdeleATK <- Attack(list(Wonder=Wonder, Creation=Creation, Resonance=Resonance, ResonanceMove=ResonanceMove, Gathering=Gathering, Territory=Territory, TerritoryExplosion=TerritoryExplosion,
                        Divide=Divide, Blossom1st=Blossom1st, BlossomRemain=BlossomRemain, Grave=Grave, Marker=Marker, Ruin=Ruin, RuinExplosion=RuinExplosion, Infinite=Infinite, 
                        Restore=Restore, Storm=Storm, AuraWeapon=AuraWeapon, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Adele - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(AdeleCore[[1]][2, 2]>=40, 20, 0), 2 * AdeleCore[[1]][2, 2])
info <- c(360 + 3 * AdeleSpec$SkillLv, 4, 0, 1050, 1000, 0.5, F, F, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Order <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 0, 40, 0.5, F, F, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
OrderDummy <- rbind(data.frame(option, value), info)}

AdeleSummoned <- Summoned(list(Order=Order, OrderDummy=OrderDummy, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                               SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Adele - DealCycle & Deal Calculation
ATKFinal <- data.frame(AdeleATK)
ATKFinal$Delay[c(-6)] <- Delay(ATKFinal$Delay, AdeleSpec$ATKSpeed)[c(-6)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)

BuffFinal <- data.frame(AdeleBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, AdeleSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(AdeleSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, AdeleSpec$CoolReduceP, AdeleSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * AdeleSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(AdeleBuff))
AdeleDealCycle <- t(rep(0, length(DealCycle)))
colnames(AdeleDealCycle) <- DealCycle
AdeleDealCycle <- data.frame(AdeleDealCycle)
AdeleDealCycle$Ether <- 400

AdeleCycle <-  function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, Period=180) {
  DealCycle <- PreDealCycle
  Period <- Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  ## First Cycle
  ## Start Buff
  DealCycle <- AdeleBuffCycle(DealCycle, c("Booster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "AuraWeaponBuff"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("SpiderInMirror"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("MagicCircuitFullDriveBuff", "BlessofGrandis"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("Restore"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("RestoreBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Infinite"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("InfiniteBuff"), BuffFinal)
  
  GBCool <- subset(ATKFinal, rownames(ATKFinal)=="BlossomRemain")$CoolTime * 1000
  TECool <- subset(ATKFinal, rownames(ATKFinal)=="Territory")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000
  GRCool <- subset(ATKFinal, rownames(ATKFinal)=="Grave")$CoolTime * 1000
  RUCool <- subset(ATKFinal, rownames(ATKFinal)=="Ruin")$CoolTime * 1000 
  
  ## Order Summon 
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("Order"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  
  ## Ether 400 & Storm
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Nobility"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
  DealCycle <- StormATKCycle(DealCycle, ATKFinal)
  
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Grave"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Marker"), ATKFinal)
  
  ## Repeats
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= Period * 1000 + 2100) {
    if(DealCycle$RaceofGod[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "RaceofGod", BuffFinal)
    }
    ## Order Summon
    if(DealCycle$Ether[nrow(DealCycle)] == 400 & (Period * 1000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > 10000) {
      if(DealCycle$Order1[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order2[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order3[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      }
    }
    ## Gathering - Blossom
    if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="GatheringDebuff")$Time) >= GBCool & 
       (Period * 1000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > (GBCool - 6000)) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
    }
    ## Territory - Resonance
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Territory")$Time) >= TECool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
      DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
    }
    ## Ruin
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Ruin")$Time) >= RUCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
    }
    ## Soul Contract
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= SCCool) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
    }
    ## Grave - Marker
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Grave")$Time) >= GRCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Grave", "Marker"), ATKFinal)
    }
    ## Divide
    else {
      DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
    }
  }
  
  
  ## Second Cycle
  ## Start Buff
  DealCycle <- AdeleBuffCycle(DealCycle, c("Booster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "AuraWeaponBuff"), BuffFinal) 
  DealCycle <- AdeleATKCycle(DealCycle, c("Restore"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("RestoreBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Infinite"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("InfiniteBuff"), BuffFinal)
  
  ## Order Summon 
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("Order"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c(rep("Divide", 1)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  
  ## Ether 400 & Storm
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st", rep("Divide", 14)), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Nobility"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
  DealCycle <- StormATKCycle(DealCycle, ATKFinal)
  
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Grave"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("OrderRestore"), BuffFinal)
  DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
  DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
  DealCycle <- AdeleATKCycle(DealCycle, c("Marker"), ATKFinal)
  
  ## Repeats
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= Period * 2000 + 2100) {
    if(DealCycle$RaceofGod[nrow(DealCycle)] < 3000) {
      DealCycle <- AdeleBuffCycle(DealCycle, "RaceofGod", BuffFinal)
    }
    ## Order Summon
    if(DealCycle$Ether[nrow(DealCycle)] == 400 & (Period * 2000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > 10000) {
      if(DealCycle$Order1[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order1"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order2[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order2"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      } else if(DealCycle$Order3[nrow(DealCycle)] - DealCycle$Time[1] <= 10000) {
        DealCycle <- AdeleBuffCycle(DealCycle, c("Order3"), BuffFinal)
        DealCycle <- AdeleSummonedCycle(DealCycle, c("OrderDummy"), SummonedFinal)
      }
    }
    ## Gathering - Blossom
    if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="GatheringDebuff")$Time) >= GBCool & 
       (Period * 2000 + 2100) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > (GBCool - 6000)) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("GatheringDebuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Gathering", "Blossom1st"), ATKFinal)
    }
    ## Territory - Resonance
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Territory")$Time) >= TECool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Territory"), ATKFinal)
      DealCycle <- AdeleBuffCycle(DealCycle, c("ResonanceBuff"), BuffFinal)
      DealCycle <- AdeleATKCycle(DealCycle, c("Resonance", "ResonanceMove"), ATKFinal)
    }
    ## Ruin
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Ruin")$Time) >= RUCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Ruin"), ATKFinal)
    }
    ## Soul Contract
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= SCCool) {
      DealCycle <- AdeleBuffCycle(DealCycle, c("SoulContractLink"), BuffFinal)
    }
    ## Grave - Marker
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="Grave")$Time) >= GRCool) {
      DealCycle <- AdeleATKCycle(DealCycle, c("Grave", "Marker"), ATKFinal)
    }
    ## Divide
    else {
      DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
    }
  }
  
  ## Divide
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - Period * 1000 <= max(subset(DealCycle, DealCycle$Skills=="UsefulSharpEyes")$Time)) {
    DealCycle <- AdeleATKCycle(DealCycle, c("Divide"), ATKFinal)
  }
  return(DealCycle)
}

AdeleDealCycle <- AdeleCycle(PreDealCycle=AdeleDealCycle, 
                             ATKFinal=ATKFinal, 
                             BuffFinal=BuffFinal, 
                             SummonedFinal=SummonedFinal, 
                             Spec=AdeleSpec)
AdeleDealCycle <- DealCycleFinal(AdeleDealCycle)
AdeleDealCycle <- RuinTerritoryCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- GatheringBlossomWonderCreationCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- StormRepATKCycle(AdeleDealCycle, ATKFinal)
AdeleDealCycle <- AdeleOrderCycle(AdeleDealCycle, SummonedFinal)
AdeleDealCycle <- RepATKCycle(AdeleDealCycle, "Infinite", 29, 0, ATKFinal)
AdeleDealCycle <- RepATKCycle(AdeleDealCycle, "Restore", 10, 3000, ATKFinal)
AdeleDealCycle <- AdeleMCFAWCycle(AdeleDealCycle, c("Resonance", "Gathering", "Divide", "Blossom1st", "Marker", "RuinStart", "InfiniteStart", "Infinite", "StormStart", "Storm", "Order"), ("Divide"))
AdeleDealCycle <- DCSpiderInMirror(AdeleDealCycle, SummonedFinal)
AdeleDealCycleReduction <- DealCycleReduction(AdeleDealCycle)

DealCalc(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpec)

AdeleSpecOpt1 <- Optimization1(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpec, AdeleUnionRemained)
AdeleSpecOpt <- AdeleSpec
AdeleSpecOpt$ATKP <- AdeleSpecOpt$ATKP + AdeleSpecOpt1$ATKP
AdeleSpecOpt$BDR <- AdeleSpecOpt$BDR + AdeleSpecOpt1$BDR
AdeleSpecOpt$IGR <- IGRCalc(c(AdeleSpecOpt$IGR, AdeleSpecOpt1$IGR))

AdeleSpecOpt2 <- Optimization2(AdeleDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt, AdeleHyperStatBase, AdeleBase$ChrLv, AdeleBase$CRROver)
AdeleFinalDPM <- DealCalc(AdeleDealCycle, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt2)
AdeleFinalDPMwithMax <- DealCalcWithMaxDMR(AdeleDealCycle, ATKFinal, BuffFinal, SummonedFinal, AdeleSpecOpt2)

DPM12344$Adele[1] <- sum(na.omit(AdeleFinalDPMwithMax)) / (341070 / 60000)
DPM12344$Adele[2] <- sum(na.omit(AdeleFinalDPM)) / (341070 / 60000) - sum(na.omit(AdeleFinalDPMwithMax)) / (341070 / 60000)

AdeleDealRatio <- DealRatio(AdeleDealCycle, AdeleFinalDPMwithMax)

AdeleDealData <- data.frame(AdeleDealCycle$Skills, AdeleDealCycle$Time, AdeleDealCycle$Restraint4, AdeleFinalDPMwithMax, AdeleFinalDPM-AdeleFinalDPMwithMax)
colnames(AdeleDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(AdeleDealData, AdeleDealData$R4 > 0)

AdeleRR <- AdeleDealData[165:577, ]
DPM12344$Adele[3] <- sum((AdeleRR$Deal))

Adele40s <-  AdeleDealData[17:668, ]
DPM12344$Adele[4] <- sum((Adele40s$Deal))