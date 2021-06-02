## FlameWizard - Data
## FlameWizard - VMatrix
FlameWizardCore <- MatrixSet(PasSkills=c("OrbitalFlame", "DragonSlave", "Infernorise", "BlazingExtinction"), 
                            PasLvs=c(50, 50, 50, 50), 
                            PasMP=c(10, 10, 10, 10), 
                            ActSkills=c("BlazingOrbitalFlame", "FlameDischarge", "InfnityFlameCircle", "SlamanderMischief",
                                        CommonV("Wizard", "CygnusKnights")), 
                            ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                            ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 5), 
                            BlinkLv=1, 
                            BlinkMP=0, 
                            UsefulSkills=c("SharpEyes", "CombatOrders"), 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=SpecDefault, 
                            SelfBind=F)


## FlameWizard - Basic Info
## Wand - Staff Check Needed
FlameWizardBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=MobDefault,
                          SpecSet=SpecDefault, 
                          Job="FlameWizard",
                          CoreData=FlameWizardCore, 
                          BuffDurationNeeded=0, 
                          AbilList=c("BDR", "BuffDuration"), 
                          LinkList=c("CygnusKnights", "Mikhail", "DemonAvenger", "Phantom"), 
                          MonsterLife=MLTypeI21, 
                          Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", SpecDefault$WeaponType)[, 1:16],
                          WeaponType=SpecDefault$WeaponType, 
                          SubWeapon=SubWeapon[19, ], 
                          Emblem=Emblem[3, ])


## FlameWizard - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(FlameWizardBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(5)
InbornTalent <- data.frame(option, value) ## Wand Only

option <- factor(c("ATK", "ATKSpeed"), levels=PSkill)
value <- c(10, 1)
SpellTraining <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(30)
LiberatedMagic <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 20)
WeaknessResearch <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
BrilliantEnlightenment <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "Mastery"), levels=PSkill)
value <- c(20 + 2 * FlameWizardBase$PSkillLv, 50 + 3 * FlameWizardBase$PSkillLv, 70 + FlameWizardBase$PSkillLv)
TruthofMagic <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(FlameWizardCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

FlameWizardPassive <- Passive(list(ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, InbornTalent=InbornTalent, SpellTraining=SpellTraining, 
                                   LiberatedMagic=LiberatedMagic, WeaknessResearch=WeaknessResearch, BrilliantEnlightenment=BrilliantEnlightenment, TruthofMagic=TruthofMagic, BlinkPassive=BlinkPassive))


## FlameWizard - Buff
{option <- factor("ATK", levels=BSkill)
value <- c(40 + FlameWizardBase$PSkillLv)
info <- c(8, 9, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElementFlame <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(300, NA, 990, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Ignition <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(10, 11, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IgnitionEffect <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "ATKSpeed"), levels=BSkill)
value <- c(20, 2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BookofFire <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(30 + FlameWizardBase$SkillLv)
info <- c(300 * (100 + FlameWizardBase$MonsterLife$SummonedDuration + FlameWizardBase$UnionChrs$SummonedDuration) / 100, NA, 420, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpiritofFlame <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATKSpeed"), levels=BSkill)
value <- c(60 + FlameWizardBase$SkillLv, 1)
info <- c(30, 45, 1080, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BurningRegion <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((FlameWizardBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(FlameWizardBase$SkillLv/2))))
info <- c(900 + 30 * FlameWizardBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * FlameWizardCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * FlameWizardCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(FlameWizardCore[[2]][5, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfinityFlameCircleStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(60, 90, 750, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SalamanderMischief <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SalamanderMischiefStack <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(45 + 2 * FlameWizardCore[[2]][4, 2])
info <- c(30, 90, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SalamanderMischiefAfter <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

FlameWizardBuff <- Buff(list(ElementFlame=ElementFlame, Ignition=Ignition, IgnitionEffect=IgnitionEffect, BookofFire=BookofFire, SpiritofFlame=SpiritofFlame, BurningRegion=BurningRegion, 
                            MapleSoldier=MapleSoldier, GloryofGardians=GloryofGardians, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                            OverloadMana=OverloadMana, FlameDischargeStack=FlameDischargeStack, InfinityFlameCircleStack=InfinityFlameCircleStack, 
                            SalamanderMischief=SalamanderMischief, SalamanderMischiefStack=SalamanderMischiefStack, SalamanderMischiefAfter=SalamanderMischiefAfter, 
                            BlessofCygnus=BlessofCygnus, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : Ignition(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms)
FlameWizardAllTimeBuff <- AllTimeBuff(FlameWizardBuff, WillBeAllTimeBuff = c("BurningRegion"))


## FlameWizard - Union & HyperStat & SoulWeapon
FlameWizardSpec <- JobSpec(JobBase=FlameWizardBase, 
                          Passive=FlameWizardPassive, 
                          AllTimeBuff=FlameWizardAllTimeBuff, 
                          MobInfo=MobDefault, 
                          SpecSet=SpecDefault, 
                          WeaponName="Wand", 
                          UnionStance=0,
                          JobConstant=1.2)

FlameWizardUnionRemained <- FlameWizardSpec$UnionRemained
FlameWizardHyperStatBase <- FlameWizardSpec$HyperStatBase
FlameWizardCoolReduceType <- FlameWizardSpec$CoolReduceType
FlameWizardSpec <- FlameWizardSpec$Spec


## FlameWizard - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * FlameWizardCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * FlameWizardCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * FlameWizardCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * FlameWizardCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * FlameWizardCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * FlameWizardCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## FlameWizard - Attacks
OrbitalSubTime <- 270

{option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(IGRCalc(c(ifelse(FlameWizardCore[[1]][1, 2]>=40, 20, 0), 20)), 2 * FlameWizardCore[[1]][1, 2])
info <- c(215 + FlameWizardSpec$SkillLv, 3, OrbitalSubTime, 150, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OrbitalFlame <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(FlameWizardCore[[1]][2, 2]>=40, 20, 0), 2 * FlameWizardCore[[1]][2, 2])
info <- c(500, 6, 2000, 300, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonSlave <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(FlameWizardCore[[1]][2, 2]>=40, 20, 0), 2 * FlameWizardCore[[1]][2, 2])
info <- c(500, 10, 810, NA, 90, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DragonSlaveLast <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(FlameWizardCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c((2 * FlameWizardCore[[1]][2, 2]), 90 + FlameWizardSpec$SkillLv)))
info <- c(350 + 3 * FlameWizardSpec$SkillLv, 10, 750, NA, 30, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Infernorise <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(20, ifelse(FlameWizardCore[[1]][4, 2]>=40, 20, 0), 2 * FlameWizardCore[[1]][4, 2])
info <- c(310 + 2 * FlameWizardSpec$SkillLv, 4, 870, 990, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlazingExtinction <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill) 
value <- c(50)
info <- c(330 + 13 * FlameWizardCore[[2]][1, 2], 6, 210, 240, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlazingOrbitalFlame <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(200 + 8 * FlameWizardCore[[2]][2, 2], 12, 840, 30, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeLion2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill) 
value <- c(35)
info <- c(200 + 8 * FlameWizardCore[[2]][2, 2], 12, 840, 30, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeLion3 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill) 
value <- c(FDRCalc(c(35, 35)))
info <- c(200 + 8 * FlameWizardCore[[2]][2, 2], 12, 840, 30, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeLion4 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill) 
value <- c(FDRCalc(c(35, 35, 35)))
info <- c(200 + 8 * FlameWizardCore[[2]][2, 2], 12, 840, 30, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeLion5 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(250 + 10 * FlameWizardCore[[2]][2, 2], 8, 840, 660, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeFox2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(250 + 10 * FlameWizardCore[[2]][2, 2], 8, 840, 660, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeFox3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(250 + 10 * FlameWizardCore[[2]][2, 2], 8, 840, 660, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeFox4 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(250 + 10 * FlameWizardCore[[2]][2, 2], 8, 840, 660, 20, T, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlameDischargeFox5 <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill) 
value <- c(50)
info <- c(0, 0, 240, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
InfinityFlameCirclePrep <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill) 
value <- c(50)
info <- c(500 + 20 * FlameWizardCore[[2]][3, 2], 7, 180, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
InfinityFlameCircleTick <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill) 
value <- c(50)
info <- c(500 + 20 * FlameWizardCore[[2]][3, 2], 7, 90, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
InfinityFlameCircleEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(150 + 6 * FlameWizardCore[[2]][4, 2], 7, 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SalamanderMischiefATK <- rbind(data.frame(option, value), info)}

FlameWizardATK <- Attack(list(OrbitalFlame=OrbitalFlame, DragonSlave=DragonSlave, DragonSlaveLast=DragonSlaveLast, Infernorise=Infernorise, BlazingExtinction=BlazingExtinction, BlazingOrbitalFlame=BlazingOrbitalFlame, 
                              FlameDischargeLion2=FlameDischargeLion2, FlameDischargeLion3=FlameDischargeLion3, FlameDischargeLion4=FlameDischargeLion4, FlameDischargeLion5=FlameDischargeLion5, 
                              FlameDischargeFox2=FlameDischargeFox2, FlameDischargeFox3=FlameDischargeFox3, FlameDischargeFox4=FlameDischargeFox4, FlameDischargeFox5=FlameDischargeFox5,
                              InfinityFlameCirclePrep=InfinityFlameCirclePrep, InfinityFlameCircleTick=InfinityFlameCircleTick, InfinityFlameCircleEnd=InfinityFlameCircleEnd, SalamanderMischiefATK=SalamanderMischiefATK, 
                              SpiderInMirror=SpiderInMirror))


## FlameWizard - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * FlameWizardCore[[2]][7, 2], 1, 780, 240, 0.24*(39 + FlameWizardCore[[2]][7, 2])+0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

FlameWizardSummoned <- Summoned(list(CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, 
                                     SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## FlameWizard - DealCycle & Deal Calculation
ATKFinal <- data.frame(FlameWizardATK)
ATKFinal$Delay[c(-1, -2, -6, -15, -16, -17)] <- Delay(ATKFinal$Delay, FlameWizardSpec$ATKSpeed)[c(-1, -2, -6, -15, -16, -17)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, FlameWizardSpec$CoolReduceP, FlameWizardSpec$CoolReduce)

BuffFinal <- data.frame(FlameWizardBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, FlameWizardSpec$CoolReduceP, FlameWizardSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, FlameWizardSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(FlameWizardSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, FlameWizardSpec$CoolReduceP, FlameWizardSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * FlameWizardSpec$SummonedDuration / 100, 0)


## FlameWizard - Deal Cycle
DealCycle <- c("Skills", "Time", rownames(FlameWizardBuff))
FlameWizardDealCycle <- t(rep(0, length(DealCycle)))
colnames(FlameWizardDealCycle) <- DealCycle
FlameWizardDealCycle <- data.frame(FlameWizardDealCycle)

FlameWizardCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, Period=180, CycleTime=360) {
  BuffSummonedPrior <- c("Ignition", "BookofFire", "SpiritofFlame", "MapleSoldier", "GloryofGardians", "UsefulSharpEyes", "UsefulCombatOrders", 
                         "BurningRegion", "CygnusPhalanx", "SalamanderMischief", "BlessofCygnus", "SoulContractLink")
  
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 4, 6, 2, 0.5, 2)
  
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
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      if(BuffList[[1]][i]=="CygnusPhalanx") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
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
  DragonSlaveCool <- 90000 ; InfernoCool <- subset(ATKFinal, rownames(ATKFinal)=="Infernorise")$CoolTime * 1000
  DischargeCool <- subset(ATKFinal, rownames(ATKFinal)=="FlameDischargeLion2")$CoolTime * 1000 + 3000
  BlazingCool <- subset(ATKFinal, rownames(ATKFinal)=="BlazingOrbitalFlame")$CoolTime * 1000
  ExtinctionCool <- 9500
  DragonSlaveRemain <- 0 ; InfernoRemain <- 0 ; DischargeRemain <- 0 ; BlazingRemain <- 0 ; ExtinctionRemain <- 0
  DealCycle$FlameDischargeStack[nrow(DealCycle)] <- 0 ; DealCycle$InfinityFlameCircleStack[nrow(DealCycle)] <- 15
  DC2 <- data.frame()
  
  DC2Control <- function(DC2) {
    DC2 <- DC2[order(DC2$Time), ] 
    rownames(DC2) <- 1:nrow(DC2)
    DC2$IgnitionEffect[1] <- 10000
    DC2$FlameDischargeStack[1] <- 2
    
    if(nrow(DC2) >=2) {
      for(i in 2:nrow(DC2)) {
        if(max(DC2$Skills[i]==c("BlazingOrbitalFlame", "OrbitalFlame", "InfinityFlameCircleTick", "BlazingExtinction"))==1) {
          if(max(0, DC2$IgnitionEffect[i-1] - (DC2$Time[i] - DC2$Time[i-1]))==0) {
            DC2$IgnitionEffect[i] <- 10000
            DC2$FlameDischargeStack[i] <- min(6, DC2$FlameDischargeStack[i-1] + 1)
          } else {
            DC2$IgnitionEffect[i] <- max(0, DC2$IgnitionEffect[i-1] - (DC2$Time[i] - DC2$Time[i-1]))
            DC2$FlameDischargeStack[i] <- DC2$FlameDischargeStack[i-1]
          }
        } else if(max(DC2$Skills[i]==c("DragonSlaveLast", "Infernorise"))==1) {
          DC2$IgnitionEffect[i] <- 0
          DC2$FlameDischargeStack[i] <- DC2$FlameDischargeStack[i-1]
        } else if(max(DC2$Skills[i]==c("FlameDischargeFox2", "FlameDischargeLion2"))==1) {
          DC2$IgnitionEffect[i] <- max(0, DC2$IgnitionEffect[i-1] - (DC2$Time[i] - DC2$Time[i-1]))
          DC2$FlameDischargeStack[i] <- 0
        }
      }
    }
    return(DC2)
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
      BuffEndTime[i] <- max(a$Time) + subset(SubTimeList, SubTimeList$Skills==BuffList[[k]][i])$SubTime * 1000 + 
        sum(CycleBuffList$Delay[Idx:nrow(CycleBuffList)])
    }
    BuffEndTime <- max(BuffEndTime)
    BuffStartTime <- BuffEndTime - sum(CycleBuffList$Delay)
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      for(i in 1:length(ColNums)) {
        if(DealCycle[nrow(DealCycle), ColNums[i]] - DealCycle$Time[1] < 3000) {
          DealCycle <- DCBuff(DealCycle, colnames(DealCycle)[ColNums[i]], BuffFinal)
          ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
          DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
          InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
          DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
          BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        }
      }
      if(nrow(DC2)==0) {
        DC2SS <- data.frame(IgnitionEffect=0, FlameDischargeStack=0)
      } else {
        DC2SS <- subset(DC2, DC2$Time < (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]))
      }
      ## Dragon Slave + Orbital Flame
      if(DC2SS$IgnitionEffect[nrow(DC2SS)] > 0 & DragonSlaveRemain==0) {
        DealCycle <- DCATK(DealCycle, "DragonSlave", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "DragonSlaveLast", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- DragonSlaveCool - DealCycle$Time[1]
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- DealCycle[nrow(DealCycle), ]
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
        }
        DC2 <- DC2Control(DC2)
        
        DealCycle <- DCATK(DealCycle, "OrbitalFlame", ATKFinal)
        DealCycle$ElementFlame[nrow(DealCycle)] <- 8000
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        }
        DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-1)] + 360
        DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 150
        DC2 <- DC2Control(DC2)
      }  ## Infernorise + Orbital Flame
      else if(DC2SS$IgnitionEffect[nrow(DC2SS)] >= 9800 & InfernoRemain==0) {
        DealCycle <- DCATK(DealCycle, "Infernorise", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        InfernoRemain <- InfernoCool - DealCycle$Time[1]
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- DealCycle[nrow(DealCycle), ]
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
        }
        DC2 <- DC2Control(DC2)
        
        DealCycle <- DCATK(DealCycle, "OrbitalFlame", ATKFinal)
        DealCycle$ElementFlame[nrow(DealCycle)] <- 8000
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        }
        DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-1)] + 360
        DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 150
        DC2 <- DC2Control(DC2)
      }  ## Flame Discharge
      else if(DC2SS$FlameDischargeStack[nrow(DC2SS)] >= 3 & DischargeRemain < 3000) {
        DealCycle <- DCATK(DealCycle, "FlameDischargeFox2", ATKFinal)
        DealCycle$FlameDischargeStack[nrow(DealCycle)] <- DC2SS$FlameDischargeStack[nrow(DC2SS)]
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DischargeRemain <- DischargeCool - DealCycle$Time[1]
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- DealCycle[nrow(DealCycle), ]
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
        }
        DC2 <- DC2Control(DC2)
      }  
      else if(DC2SS$FlameDischargeStack[nrow(DC2SS)] >= 2 & DischargeRemain == 0) {
        DealCycle <- DCATK(DealCycle, "FlameDischargeFox2", ATKFinal)
        DealCycle$FlameDischargeStack[nrow(DealCycle)] <- DC2SS$FlameDischargeStack[nrow(DC2SS)]
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DischargeRemain <- DischargeCool - DealCycle$Time[1]
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- DealCycle[nrow(DealCycle), ]
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
        }
        DC2 <- DC2Control(DC2)
      }  
      ## Infinity Flame Circle
      else if(DealCycle$InfinityFlameCircleStack[nrow(DealCycle)]==0) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "InfinityFlameCirclePrep", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        DealCycle$InfinityFlameCircleStack[nrow(DealCycle)] <- 180000 + 120
        
        for(i in 1:79) {
          DealCycle <- DCATK(DealCycle, "InfinityFlameCircleTick", ATKFinal)
          if(nrow(DC2)==0) {
            DC2 <- DealCycle[nrow(DealCycle), ]
          } else {
            DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
          }
          DC2 <- DC2Control(DC2)
          ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
          DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
          InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
          DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
          BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        }
        
        DealCycle <- DCATK(DealCycle, "InfinityFlameCircleEnd", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
      }  ## Blazing Orbital Flame
      else if(BlazingRemain == 0) {
        DealCycle <- DCATK(DealCycle, "BlazingOrbitalFlame", ATKFinal)
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- BlazingCool - DealCycle$Time[1]
        
        if(nrow(DC2)==0) {
          DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        }
        DC2$Time[(nrow(DC2)-3)] <- DC2$Time[(nrow(DC2)-3)] + 150
        DC2$Time[(nrow(DC2)-2)] <- DC2$Time[(nrow(DC2)-3)] + 240
        DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-2)] + 1590
        DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 240
        DC2 <- DC2Control(DC2)
      } ## Blazing Extinction
      else if(ExtinctionRemain == 0) {
        DealCycle <- DCATK(DealCycle, "BlazingExtinction", ATKFinal)
        ExtinctionRemain <- ExtinctionCool - DealCycle$Time[1]
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- DealCycle[nrow(DealCycle), ]
          DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)] + 1500
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
          DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)] + 1500
        }
        for(i in 1:8) {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ])
          DC2$Time[nrow(DC2)] <- DC2$Time[nrow(DC2)-1] + 990
        }
        DC2 <- DC2Control(DC2)
      } ## Orbital Flame
      else {
        DealCycle <- DCATK(DealCycle, "OrbitalFlame", ATKFinal)
        DealCycle$ElementFlame[nrow(DealCycle)] <- 8000
        ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
        DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
        InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
        DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
        BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        
        if(nrow(DC2)==0) {
          DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        } else {
          DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
        }
        DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-1)] + 360
        DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 150
        DC2 <- DC2Control(DC2)
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
          DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
          InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
          DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
          BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
          DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
          InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
          DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
          BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
        }
      }
    }
  }
  
  while(DC2$FlameDischargeStack[nrow(DC2)] < 2 |
        (DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="DragonSlaveLast")$Time) + 
         min(subset(DealCycle, DealCycle$Skills=="DragonSlave")$Time)) < 90000) {
    if(BlazingRemain == 0) {
      DealCycle <- DCATK(DealCycle, "BlazingOrbitalFlame", ATKFinal)
      ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
      DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
      InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
      DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
      BlazingRemain <- BlazingCool - DealCycle$Time[1]
      
      if(nrow(DC2)==0) {
        DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
      } else {
        DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
      }
      DC2$Time[(nrow(DC2)-3)] <- DC2$Time[(nrow(DC2)-3)] + 150
      DC2$Time[(nrow(DC2)-2)] <- DC2$Time[(nrow(DC2)-3)] + 240
      DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-2)] + 1590
      DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 240
      DC2 <- DC2Control(DC2)
    } 
    else {
      DealCycle <- DCATK(DealCycle, "OrbitalFlame", ATKFinal)
      DealCycle$ElementFlame[nrow(DealCycle)] <- 8000
      ExtinctionRemain <- max(0, ExtinctionRemain - DealCycle$Time[1])
      DragonSlaveRemain <- max(0, DragonSlaveRemain - DealCycle$Time[1])
      InfernoRemain <- max(0, InfernoRemain - DealCycle$Time[1])
      DischargeRemain <- max(0, DischargeRemain - DealCycle$Time[1])
      BlazingRemain <- max(0, BlazingRemain - DealCycle$Time[1])
      
      if(nrow(DC2)==0) {
        DC2 <- rbind(DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
      } else {
        DC2 <- rbind(DC2, DealCycle[nrow(DealCycle), ], DealCycle[nrow(DealCycle), ])
      }
      DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-1)] + 360
      DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 150
      DC2 <- DC2Control(DC2)
    }
  }
  
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
FlameWizardAddATK <- function(DealCycle, ATKFinal, SummonedFinal, FlameWizardCore) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="FlameDischargeFox2") {
      DealCycle$Skills[i] <- paste("FlameDischargeFox", DealCycle$FlameDischargeStack[i], sep="")
    } else if(DealCycle$Skills[i]=="FlameDischargeLion2") {
      DealCycle$Skills[i] <- paste("FlameDischargeLion", DealCycle$FlameDischargeStack[i], sep="")
    }
  }
  
  ## AddATKs
  DealCycle <- RepATKCycle(DealCycle, "DragonSlave", 7, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "OrbitalFlame", 2, 360, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FlameDischargeFox2", 8, 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FlameDischargeFox3", 10, 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FlameDischargeFox4", 12, 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "FlameDischargeFox5", 14, 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BlazingExtinction", 9, 1500, ATKFinal)
  
  ## Blazing Orbital Flame
  DC2 <- data.frame()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BlazingOrbitalFlame") {
      if(nrow(DC2)==0) {
        DC2 <- rbind(DealCycle[i, ], DealCycle[i, ], DealCycle[i, ], DealCycle[i, ])
      } else {
        DC2 <- rbind(DC2, DealCycle[i, ], DealCycle[i, ], DealCycle[i, ], DealCycle[i, ])
      }
      DealCycle$Skills[i] <- "BlazingOrbitalFlameStart"
      DC2$Time[(nrow(DC2)-3)] <- DC2$Time[(nrow(DC2)-3)] + 150
      DC2$Time[(nrow(DC2)-2)] <- DC2$Time[(nrow(DC2)-3)] + 240
      DC2$Time[(nrow(DC2)-1)] <- DC2$Time[(nrow(DC2)-2)] + 1590
      DC2$Time[nrow(DC2)] <- DC2$Time[(nrow(DC2)-1)] + 240
    }
  }
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 1:nrow(DealCycle)) {
    if("BlazingOrbitalFlame"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  ## Salamander Mischief
  DC2 <- data.frame()
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SalamanderMischief") {
      if(nrow(DC2)==0) {
        DC2 <- DealCycle[i, ]
        for(j in 1:95) {
          DC2 <- rbind(DC2, DealCycle[i, ])
        }
      } else {
        for(j in 1:96) {
          DC2 <- rbind(DC2, DealCycle[i, ])
        }
      }
      MischiefStack <- 1
      for(j in 94:0) {
        DC2$Time[(nrow(DC2)-j)] <- DC2$Time[(nrow(DC2)-j-1)] + ifelse(MischiefStack!=0, 600, 1000)
        MischiefStack <- MischiefStack + 1
        MischiefStack <- ifelse(MischiefStack==12, 0, MischiefStack)
      }
    }
  }
  DC2$Skills <- "SalamanderMischiefATK"
  DealCycle <- rbind(DealCycle, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 1:nrow(DealCycle)) {
    if("SalamanderMischiefATK"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- DealCycle[DealCycle$Time <= EndTime, ]
  
  
  ## Mischief AfterBuff
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SalamanderMischiefATK" & DealCycle$SalamanderMischief[i]==200) {
      DealCycle$SalamanderMischiefAfter[i] <- 30200 + General$General$Serverlag * 1000
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$SalamanderMischiefAfter[i-1] > 0) {
      DealCycle$SalamanderMischiefAfter[i] <- DealCycle$SalamanderMischiefAfter[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      DealCycle$SalamanderMischiefAfter[i] <- ifelse(DealCycle$SalamanderMischiefAfter[i]<0, 0, DealCycle$SalamanderMischiefAfter[i])
    }
  }
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$SalamanderMischiefAfter[i] > 30000) {
      DealCycle$SalamanderMischiefAfter[i] <- 0
    }
  }
  
  
  ## Mischief Stack
  SMStack <- 0 ; ATKTimes <- 0
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SalamanderMischiefATK") {
      DealCycle$SalamanderMischiefStack[i] <- SMStack
      SMStack <- SMStack + 1
      SMStack <- min(SMStack, 15 + FlameWizardCore[[2]][4, 2])
      ATKTimes <- ATKTimes + 1
      SMStack <- ifelse(ATKTimes==96, 0, SMStack)
      ATKTimes <- ifelse(ATKTimes==96, 0, ATKTimes)
    }
  }
  
  
  ## Spider In Mirror, Phalanx
  DealCycle <- DCSummonedATKs(DealCycle, Skill=c("CygnusPhalanx"), SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("OrbitalFlame", "DragonSlave", "DragonSlaveLast", "Infernorise", "BlazingOrbitalFlame", 
                                  "FlameDischargeLion2", "FlameDischargeLion3", "FlameDischargeLion4", "FlameDischargeFox2", "FlameDischargeFox3", "FlameDischargeFox4", 
                                  "InfinityFlameCircleTick", "SalamanderMischiefATK", "CygnusPhalanx", "BlazingExtinction"))==1) {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  
  
  ## Ignition Effect
  for(i in 2:nrow(DealCycle)) {
    if(max(DealCycle$Skills[i]==c("BlazingOrbitalFlame", "OrbitalFlame", "InfinityFlameCircleTick", "BlazingExtinction"))==1) {
      if(max(0, DealCycle$IgnitionEffect[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))==0) {
        DealCycle$IgnitionEffect[i] <- 10000
      } else {
        DealCycle$IgnitionEffect[i] <- max(0, DealCycle$IgnitionEffect[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
      }
    } else if(max(DealCycle$Skills[i]==c("DragonSlaveLast", "Infernorise"))==1) {
      DealCycle$IgnitionEffect[i] <- 1
    } else {
      DealCycle$IgnitionEffect[i] <- max(0, DealCycle$IgnitionEffect[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    }
  }
  return(DealCycle)
}


FlameWizardDealCycle <- FlameWizardCycle(PreDealCycle=FlameWizardDealCycle, 
                                         ATKFinal=ATKFinal,
                                         BuffFinal=BuffFinal,
                                         SummonedFinal=SummonedFinal, 
                                         Spec=FlameWizardSpec)
FlameWizardDealCycle <- FlameWizardAddATK(DealCycle=FlameWizardDealCycle, 
                                          ATKFinal=ATKFinal,
                                          SummonedFinal=SummonedFinal, 
                                          FlameWizardCore=FlameWizardCore)
FlameWizardDealCycle <- BlessofCygnusCycle(FlameWizardDealCycle, 6000, General$General$Serverlag, FlameWizardCore[[2]][8, 2])
FlameWizardDealCycleReduction <- DealCycleReduction(FlameWizardDealCycle, c("BlessofCygnusBDR", "SalamanderMischiefStack"))


FlameWizardDealCalc(FlameWizardDealCycle, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpec)
FlameWizardDealData <- data.frame(FlameWizardDealCycle$Skills, DealCalc(FlameWizardDealCycle, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpec))
colnames(FlameWizardDealData) <- c("Skills", "Deal")


## Damage Optimization
FlameWizardSpecOpt1 <- FlameWizardOptimization1(FlameWizardDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpec, FlameWizardUnionRemained)
FlameWizardSpecOpt <- FlameWizardSpec
FlameWizardSpecOpt$ATKP <- FlameWizardSpecOpt$ATKP + FlameWizardSpecOpt1$ATKP
FlameWizardSpecOpt$BDR <- FlameWizardSpecOpt$BDR + FlameWizardSpecOpt1$BDR
FlameWizardSpecOpt$IGR <- IGRCalc(c(FlameWizardSpecOpt$IGR, FlameWizardSpecOpt1$IGR))

FlameWizardSpecOpt2 <- FlameWizardOptimization2(FlameWizardDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpecOpt, FlameWizardHyperStatBase, FlameWizardBase$ChrLv, FlameWizardBase$CRROver)
FlameWizardFinalDPM <- FlameWizardDealCalc(FlameWizardDealCycle, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpecOpt2)
FlameWizardFinalDPMwithMax <- FlameWizardDealCalcWithMaxDMR(FlameWizardDealCycle, ATKFinal, BuffFinal, SummonedFinal, FlameWizardSpecOpt2)

DPM12347$FlameWizard[1] <- sum(na.omit(FlameWizardFinalDPMwithMax)) / (max(FlameWizardDealCycle$Time) / 60000)
DPM12347$FlameWizard[2] <- sum(na.omit(FlameWizardFinalDPM)) / (max(FlameWizardDealCycle$Time) / 60000) - sum(na.omit(FlameWizardFinalDPMwithMax)) / (max(FlameWizardDealCycle$Time) / 60000)

FlameWizardDealRatio <- DealRatio(FlameWizardDealCycle, FlameWizardFinalDPMwithMax)

FlameWizardDealData <- data.frame(FlameWizardDealCycle$Skills, FlameWizardDealCycle$Time, FlameWizardDealCycle$Restraint4, FlameWizardFinalDPMwithMax, FlameWizardFinalDPM-FlameWizardFinalDPMwithMax)
colnames(FlameWizardDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(FlameWizardDealData, FlameWizardDealData$R4>0)

FlameWizardRR <- FlameWizardDealData[89:257, ]
DPM12347$FlameWizard[3] <- sum((FlameWizardRR$Deal))

FlameWizard40s <- FlameWizardDealData[37:581, ]
DPM12347$FlameWizard[4] <- sum((FlameWizard40s$Deal))


## DealCycle - Orbital 1250hits
ATKFinal285 <- ATKFinal
ATKFinal285$Delay[1] <- 285

DealCycle <- c("Skills", "Time", rownames(FlameWizardBuff))
FlameWizardDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(FlameWizardDealCycle2) <- DealCycle
FlameWizardDealCycle2 <- data.frame(FlameWizardDealCycle2)

FlameWizardDealCycle2 <- FlameWizardCycle(PreDealCycle=FlameWizardDealCycle2, 
                                         ATKFinal=ATKFinal285,
                                         BuffFinal=BuffFinal,
                                         SummonedFinal=SummonedFinal, 
                                         Spec=FlameWizardSpec)
FlameWizardDealCycle2 <- FlameWizardAddATK(DealCycle=FlameWizardDealCycle2, 
                                          ATKFinal=ATKFinal285,
                                          SummonedFinal=SummonedFinal, 
                                          FlameWizardCore=FlameWizardCore)
FlameWizardDealCycle2 <- BlessofCygnusCycle(FlameWizardDealCycle2, 6000, General$General$Serverlag, FlameWizardCore[[2]][8, 2])
FlameWizardDealCycleReduction2 <- DealCycleReduction(FlameWizardDealCycle2, c("BlessofCygnusBDR", "SalamanderMischiefStack"))

FlameWizardFinalDPM1250 <- FlameWizardDealCalc(FlameWizardDealCycle2, ATKFinal285, BuffFinal, SummonedFinal, FlameWizardSpecOpt2)
FlameWizardFinalDPMwithMax1250 <- FlameWizardDealCalcWithMaxDMR(FlameWizardDealCycle2, ATKFinal285, BuffFinal, SummonedFinal, FlameWizardSpecOpt2)

FW1250DPM <- sum(na.omit(FlameWizardFinalDPM1250)) / (max(FlameWizardDealCycle2$Time) / 60000)

FlameWizardDealData2 <- data.frame(FlameWizardDealCycle2$Skills, FlameWizardDealCycle2$Time, FlameWizardDealCycle2$Restraint4, FlameWizardFinalDPMwithMax1250)
colnames(FlameWizardDealData2) <- c("Skills", "Time", "R4", "Deal")

subset(FlameWizardDealData2, FlameWizardDealData2$R4>0)

FW1250R4 <- sum(FlameWizardDealData2$Deal[89:257])
FW125040s <- sum(FlameWizardDealData2$Deal[37:575])
