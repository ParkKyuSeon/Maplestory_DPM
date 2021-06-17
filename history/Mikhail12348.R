## Mikhail - Data
## Mikhail - VMatrix
MikhailCore <- MatrixSet(PasSkills=c("SoulAssault", "ShiningCross", "RoyalGuard", "AdvancedFinalAttack", "DeadlyCharge"), 
                         PasLvs=c(50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 10), 
                         ActSkills=c("RhoAias", "ClaiomhSolais", "SwordofSoulLight", "LightofCourage", 
                                     CommonV("Warrior", "CygnusKnights")), 
                         ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                         BlinkLv=1, 
                         BlinkMP=0, 
                         UsefulSkills=c("CombatOrders", "SharpEyes"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault, 
                         SelfBind=F)


## Mikhail - Basic Info
## Link Check Needed
MikhailBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=MobDefault,
                        SpecSet=SpecDefault, 
                        Job="Mikhail",
                        CoreData=MikhailCore, 
                        BuffDurationNeeded=0, 
                        AbilList=c("BDR", "DisorderBDR"), 
                        LinkList=c("Mikhail", "Xenon", "DemonAvenger", "CygnusKnights"), 
                        MonsterLife=MLTypeS22, 
                        Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Sword", SpecDefault$WeaponType)[, 1:16],
                        WeaponType=SpecDefault$WeaponType, 
                        SubWeapon=SubWeapon[18, ], 
                        Emblem=Emblem[13, ], 
                        CoolReduceHat=F)


## Mikhail - Passive
RoyalGuardStack <- 5
RoyalGuardATK <- c(0, 10, 15, 20, 30, 45)
RoyalGuardDamage <- c(0, 275, 340, 440, 480, 565)
RoyalGuardATKCount <- c(0, 4, 5, 6, 7, 9)

{option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
Encourage <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(15)
SwordMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(5 * PartyMembers)
SoulLink <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(RoyalGuardATK[RoyalGuardStack+1])
AdvancedRoyalGuard <- data.frame(option, value)

option <- factor(c("MainStat", "CRR", "FDR", "ATKSpeed"), levels=PSkill)
value <- c(60, 20, 10, 1)
Intention <- data.frame(option, value)

option <- factor(c("FDR", "CRR"), levels=PSkill)
value <- c(25, 20)
SoulAttack <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(60)
ShiningCharge <- data.frame(option, value)

option <- factor(c("FDR", "CDMR"), levels=PSkill)
value <- c(30 + MikhailBase$SkillLv, 10)
SoulRage <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(MikhailBase$SkillLv/2), 30 + MikhailBase$SkillLv, 15 + floor(MikhailBase$SkillLv/2), 10)
AdvnacedSwordMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30 + MikhailBase$SkillLv)
AdvancedFinalAttack <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(40 + 2 * MikhailBase$SkillLv)
CombatMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(MikhailCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(MikhailCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

MikhailPassive <- Passive(list(ElementalExpert=ElementalExpert, Encourage=Encourage, SwordMastery=SwordMastery, PhysicalTraining=PhysicalTraining, 
                               SoulLink=SoulLink, AdvancedRoyalGuard=AdvancedRoyalGuard, Intention=Intention, SoulAttack=SoulAttack, ShiningCharge=ShiningCharge, 
                               SoulRage=SoulRage, AdvnacedSwordMastery=AdvnacedSwordMastery, AdvancedFinalAttack=AdvancedFinalAttack, CombatMastery=CombatMastery, 
                               BodyofStealPassive=BodyofStealPassive, BlinkPassive=BlinkPassive))


## Mikhail- Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwordBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(180, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Encourage <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((MikhailBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(MikhailBase$SkillLv/2))))
info <- c(900 + 30 * MikhailBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(30, 180, 900, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MikhailLink <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(10, 15, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DeadlyChargeBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(30, 210, 90, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SacredCube <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
QueenofTomorrow <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(5 + floor(((10 + floor(MikhailCore[[2]][1, 2] / 4)) * 3 + 5)/2))
info <- c(75 + 3 * MikhailCore[[2]][1, 2], 300, 1680, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RhoAias <- rbind(data.frame(option, value), info) ## FDR Buff Delay?

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(12, T, MikhailBase$UnionChrs$CoolReduceP, MikhailBase$CoolReduce), 12, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ClaiomhSolaisCool <- rbind(data.frame(option, value), info)

option <- factor(c("ATKP", "IGR", "CRR", "ATKSkill"), levels=BSkill)
value <- c(15 + floor(MikhailCore[[2]][3, 2]/2), 100, 100, 1)
info <- c(35, 180, 1050, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwordofSoulLight <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(10 + floor(MikhailCore[[2]][4, 2]/2))
info <- c(25, 90, 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightofCourageBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * MikhailCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * MikhailCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(MikhailCore[[2]][5, 2]/5), ceiling(MikhailCore[[2]][5, 2]/5), 1)
info <- c(80 + 2 * MikhailCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

MikhailBuff <- Buff(list(SwordBooster=SwordBooster, Encourage=Encourage, MapleSoldier=MapleSoldier, MikhailLink=MikhailLink, DeadlyChargeBuff=DeadlyChargeBuff, SacredCube=SacredCube,
                         QueenofTomorrow=QueenofTomorrow, RhoAias=RhoAias, ClaiomhSolaisCool=ClaiomhSolaisCool, SwordofSoulLight=SwordofSoulLight, LightofCourageBuff=LightofCourageBuff, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders,
                         AuraWeaponBuff=AuraWeaponBuff, BlessofCygnus=BlessofCygnus, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
MikhailAllTimeBuff <- AllTimeBuff(MikhailBuff)
## PetBuff : SwordBooster(600ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms)


## Mikhail - Union & HyperStat & SoulWeapon
MikhailSpec <- JobSpec(JobBase=MikhailBase, 
                        Passive=MikhailPassive, 
                        AllTimeBuff=MikhailAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="Sword", 
                        UnionStance=0)

MikhailUnionRemained <- MikhailSpec$UnionRemained
MikhailHyperStatBase <- MikhailSpec$HyperStatBase
MikhailCoolReduceType <- MikhailSpec$CoolReduceType
MikhailSpec <- MikhailSpec$Spec


## Mikahil - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MikhailCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * MikhailCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MikhailCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MikhailCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MikhailCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * MikhailCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Mikhail - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MikhailCore[[1]][1, 2]>=40, 20, 0), 20, 2 * MikhailCore[[1]][1, 2])
info <- c(210 + 3 * MikhailSpec$SkillLv, 12, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulAssault <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MikhailCore[[1]][2, 2]>=40, 20, 0), 20, 2 * MikhailCore[[1]][2, 2])
info <- c(440 + 3 * MikhailSpec$SkillLv, 5, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShiningCross <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MikhailCore[[1]][3, 2]>=40, 20, 0), 2 * MikhailCore[[1]][3, 2])
info <- c(RoyalGuardDamage[RoyalGuardStack+1] + MikhailBase$ChrLv, RoyalGuardATKCount[RoyalGuardStack+1], 600, NA, 6, T, T, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoyalGuard <- rbind(data.frame(option, value), info) ## No ATKSpeed

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(MikhailCore[[1]][4, 2]>=40, 20, 0), 10, 2 * MikhailCore[[1]][4, 2])
info <- c(95 + MikhailSpec$SkillLv, 4 * (0.75 + 0.01 * MikhailSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(MikhailCore[[1]][5, 2]>=40, 20, 0), 2 * MikhailCore[[1]][5, 2])
info <- c(600, 10, 1080, NA, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeadlyCharge <- rbind(data.frame(option, value), info)

ClaiomhSolaisDamage <- c(350 + 20 * MikhailCore[[2]][2, 2], 350 + 20 * MikhailCore[[2]][2, 2], 420 + 20 * MikhailCore[[2]][2, 2],
                         510 + 20 * MikhailCore[[2]][2, 2], 600 + 24 * MikhailCore[[2]][2, 2], 700 + 28 * MikhailCore[[2]][2, 2])
option <- factor(levels=ASkill)
value <- c()
info <- c(ClaiomhSolaisDamage[RoyalGuardStack+1], 7, 900, NA, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ClaiomhSolais <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(ClaiomhSolaisDamage[1], 7, 0, NA, 12, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ClaiomhSolaisAuto <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * MikhailCore[[2]][3, 2], 12, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulLightSlash <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * MikhailCore[[2]][3, 2], 5, 0, 1800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordofSoulLightAfterimage <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(850 + 34 * MikhailCore[[2]][3, 2], 12, 930, 66, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightForceRay <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * MikhailCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

MikhailATK <- Attack(list(SoulAssault=SoulAssault, ShiningCross=ShiningCross, RoyalGuard=RoyalGuard, AdvancedFinalAttack=AdvancedFinalAttack, DeadlyCharge=DeadlyCharge, 
                          ClaiomhSolais=ClaiomhSolais, ClaiomhSolaisAuto=ClaiomhSolaisAuto, SoulLightSlash=SoulLightSlash, SwordofSoulLightAfterimage=SwordofSoulLightAfterimage,  
                          LightForceRay=LightForceRay, AuraWeapon=AuraWeapon, SpiderInMirror=SpiderInMirror))


## Mikhail - Summoned
{option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(MikhailCore[[1]][2, 2]>=40, 20, 0), 20, 2 * MikhailCore[[1]][2, 2])
info <- c(75, 5, 0, 810, 12, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ShiningCrossInstall <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * MikhailCore[[2]][7, 2], 1, 780, 240, 0.24*(39 + MikhailCore[[2]][7, 2])+0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

MikhailSummoned <- Summoned(list(ShiningCrossInstall=ShiningCrossInstall, CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, 
                                 SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Mikhail - DealCycle & Deal Calculation
ATKFinal <- data.frame(MikhailATK)
ATKFinal$Delay[c(-3)] <- Delay(ATKFinal$Delay, MikhailSpec$ATKSpeed)[c(-3)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, MikhailSpec$CoolReduceP, MikhailSpec$CoolReduce)

BuffFinal <- data.frame(MikhailBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, MikhailSpec$CoolReduceP, MikhailSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, MikhailSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(MikhailSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MikhailSpec$CoolReduceP, MikhailSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MikhailSpec$SummonedDuration / 100, 0)


## Mikhail DealCycle
DealCycle <- c("Skills", "Time", rownames(MikhailBuff))
MikhailDealCycle <- t(rep(0, length(DealCycle)))
colnames(MikhailDealCycle) <- DealCycle

MikhailCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(900)) {
  BuffSummonedPrior <- c("SwordBooster", "Encourage", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "QueenofTomorrow", 
                         "AuraWeaponBuff", "RhoAias", "MikhailLink", "CygnusPhalanx", "LightofCourageBuff", "SwordofSoulLight", 
                         "SoulContractLink", "Restraint4")
  Times180 <- c(0, 0, 0, 0, 0, 0, 
                1, 0.6, 1, 6, 2, 1,
                2, 1)
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
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
      if(BuffList[[1]][i]=="SwordofSoulLight") {
        DealCycle <- DCATK(DealCycle, "SwordofSoulLightAfterimage", ATKFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)]=="MikhailLink") {
        DealCycle <- DCBuff(DealCycle, "SacredCube", BuffFinal)
        DealCycle <- DCBuff(DealCycle, "BlessofCygnus", BuffFinal)
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DCSummoned(DealCycle, "ShiningCrossInstall", SummonedFinal)
        DealCycle <- DCATK(DealCycle, "ShiningCross", ATKFinal)
      }
    } else {
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
  
  SCSubTime <- 12000
  SCRemain <- SCSubTime - (DealCycle$Time[nrow(DealCycle)] - subset(DealCycle, DealCycle$Skills=="ShiningCross")$Time) - DealCycle$Time[1]
  CSCool <- subset(ATKFinal, rownames(ATKFinal)=="ClaiomhSolais")$CoolTime * 1000
  DCCool <- subset(ATKFinal, rownames(ATKFinal)=="DeadlyCharge")$CoolTime * 1000
  RGCool <- subset(ATKFinal, rownames(ATKFinal)=="RoyalGuard")$CoolTime * 1000
  CSRemain <- 0 ; DCRemain <- 0 ; RGRemain <- 0
  BlessofCygnusDummy <- 0
  ForceRayDummy <- 0
  
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
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        }
      }
      ## Bless of Cygnus, Spider In Mirror, Sacred Cube
      if(DealCycle$Time[nrow(DealCycle)] >= 340000 & BlessofCygnusDummy == 0) {
        DealCycle <- DCBuff(DealCycle, "BlessofCygnus", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        BlessofCygnusDummy <- 1
      } else if(DealCycle$Time[nrow(DealCycle)] >= 355000 & BlessofCygnusDummy == 1) {
        DealCycle <- DCBuff(DealCycle, "SacredCube", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        BlessofCygnusDummy <- 2
      } else if(DealCycle$Time[nrow(DealCycle)] >= 580000 & BlessofCygnusDummy == 2) {
        DealCycle <- DCBuff(DealCycle, "SacredCube", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "BlessofCygnus", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        BlessofCygnusDummy <- 3
      }
      ## Light Force Ray
      else if(ForceRayDummy == 0 & DealCycle$SwordofSoulLight[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "LightForceRay", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        ForceRayDummy <- 1
      }
      ## Royal Guard
      else if(sum(DealCycle$Skills[nrow(DealCycle)]==rownames(ATKFinal)) == 1 & RGRemain == 0) {
        SCRemain <- SCRemain + DealCycle$Time[1]
        CSRemain <- CSRemain + DealCycle$Time[1]
        DCRemain <- DCRemain + DealCycle$Time[1]
        DealCycle <- RoyalGuardCycle(DealCycle, ATKFinal, ATKFinal$CoolTime[3])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1] - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        CSRemain <- max(0, CSRemain - DealCycle$Time[1] - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        DCRemain <- max(0, DCRemain - DealCycle$Time[1] - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1]))
        RGRemain <- RGCool - DealCycle$Time[1]
      }
      ## Deadly Charge
      else if(DCRemain == 0) {
        DealCycle <- DCBuff(DealCycle, "DeadlyChargeBuff", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- DCCool - DealCycle$Time[1]
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "DeadlyCharge", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      }
      ## Claiomh Solais
      else if(CSRemain == 0) {
        DealCycle <- DCBuff(DealCycle, "ClaiomhSolaisCool", BuffFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- CSCool - DealCycle$Time[1]
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "ClaiomhSolais", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      }
      ## Shining Cross
      else if(SCRemain == 0) {
        DealCycle <- DCSummoned(DealCycle, "ShiningCrossInstall", SummonedFinal)
        SCRemain <- SCSubTime - DealCycle$Time[1]
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "ShiningCross", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      }
      ## Soul Light Slash 
      else if(DealCycle$SwordofSoulLight[nrow(DealCycle)] - DealCycle$Time[1] >= 0) {
        DealCycle <- DCATK(DealCycle, "SoulLightSlash", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      } 
      ## Soul Assault
      else {
        DealCycle <- DCATK(DealCycle, "SoulAssault", ATKFinal)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        CSRemain <- max(0, CSRemain - DealCycle$Time[1])
        DCRemain <- max(0, DCRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      } 
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="SwordofSoulLight") {
            DealCycle <- DCATK(DealCycle, "SwordofSoulLightAfterimage", ATKFinal)
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            CSRemain <- max(0, CSRemain - DealCycle$Time[1])
            DCRemain <- max(0, DCRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)]=="SwordofSoulLight") {
            ForceRayDummy <- 0
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          CSRemain <- max(0, CSRemain - DealCycle$Time[1])
          DCRemain <- max(0, DCRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}

MikhailDealCycle <- MikhailCycle(PreDealCycle=MikhailDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=MikhailSpec,
                                   Period=180, 
                                   CycleTime=900)
MikhailDealCycle <- DealCycleFinal(MikhailDealCycle)
MikhailDealCycle <- MikhailBuffLogic(MikhailDealCycle)
MikhailDealCycle <- RepATKCycle(MikhailDealCycle, "LightForceRay", 6, 180, ATKFinal)
MikhailDealCycle <- RepATKCycle(MikhailDealCycle, "SwordofSoulLightAfterimage", 19, 1800, ATKFinal)
MikhailDealCycle <- DCSummonedATKs(MikhailDealCycle, Skill=c("ShiningCrossInstall", "CygnusPhalanx"), SummonedFinal)
MikhailDealCycle <- AWCSCycleMikhail(MikhailDealCycle)
MikhailDealCycle <- AddATKCycleMikhail(MikhailDealCycle)
MikhailDealCycle <- DCSpiderInMirror(MikhailDealCycle, SummonedFinal)
MikhailDealCycle <- BlessofCygnusCycle(MikhailDealCycle, 6000, ServerLag, MikhailCore[[2]][8, 2])
MikhailDealCycleReduction <- DealCycleReduction(MikhailDealCycle, "BlessofCygnusBDR")


sum(na.omit(WindBreakerDealCalc(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpec)))

MikhailSpecOpt1 <- WindBreakerOptimization1(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpec, MikhailUnionRemained)
MikhailSpecOpt <- MikhailSpec
MikhailSpecOpt$ATKP <- MikhailSpecOpt$ATKP + MikhailSpecOpt1$ATKP
MikhailSpecOpt$BDR <- MikhailSpecOpt$BDR + MikhailSpecOpt1$BDR
MikhailSpecOpt$IGR <- IGRCalc(c(MikhailSpecOpt$IGR, MikhailSpecOpt1$IGR))

MikhailSpecOpt2 <- WindBreakerOptimization2(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, MikhailHyperStatBase, MikhailBase$ChrLv, MikhailBase$CRROver)
MikhailFinalDPM <- WindBreakerDealCalc(MikhailDealCycle, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt2)
MikhailFinalDPMwithMax <- WindBreakerDealCalcWithMaxDMR(MikhailDealCycle, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt2)

DPM12347$Mikhail[1] <- sum(na.omit(MikhailFinalDPMwithMax)) / (max(MikhailDealCycle$Time) / 60000)
DPM12347$Mikhail[2] <- sum(na.omit(MikhailFinalDPM)) / (max(MikhailDealCycle$Time) / 60000) - sum(na.omit(MikhailFinalDPMwithMax)) / (max(MikhailDealCycle$Time) / 60000)

MikhailDealData <- data.frame(MikhailDealCycle$Skills, MikhailDealCycle$Time, MikhailDealCycle$Restraint4, MikhailFinalDPMwithMax, MikhailFinalDPM-MikhailFinalDPMwithMax)
colnames(MikhailDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(MikhailDealData, MikhailDealData$R4 > 0)

MikhailRR <- MikhailDealData[46:203, ]
DPM12347$Mikhail[3] <- sum((MikhailRR$Deal))

Mikhail40s <-  MikhailDealData[46:416, ]
DPM12347$Mikhail[4] <- sum((Mikhail40s$Deal))

DealRatio(MikhailDealCycle, MikhailFinalDPMwithMax)