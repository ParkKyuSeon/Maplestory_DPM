## Mikhail - Data
## Mikhail - VMatrix
MikhailCoreBase <- CoreBuilder(ActSkills=c("RhoAias", "ClaiomhSolais", "SwordofSoulLight", "LightofCourage", 
                                           CommonV("Warrior", "CygnusKnights")), 
                               ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                               UsefulSkills=c("SharpEyes", "CombatOrders"), 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               VPassiveList=MikhailVPassive, 
                               VPassivePrior=MikhailVPrior, 
                               SelfBind=F)

MikhailCore <- MatrixSet(PasSkills=MikhailCoreBase$PasSkills$Skills, 
                         PasLvs=MikhailCoreBase$PasSkills$Lv, 
                         PasMP=MikhailCoreBase$PasSkills$MP, 
                         ActSkills=MikhailCoreBase$ActSkills$Skills, 
                         ActLvs=MikhailCoreBase$ActSkills$Lv, 
                         ActMP=MikhailCoreBase$ActSkills$MP, 
                         UsefulSkills=MikhailCoreBase$UsefulSkills, 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         SpecialCore=MikhailCoreBase$SpecialCoreUse)

## Mikhail - Basic Info
## Link Check Needed
MikhailBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=get(DPMCalcOption$MobSet),
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       Job="Mikhail",
                       CoreData=MikhailCore, 
                       BuffDurationNeeded=0, 
                       AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Mikhail"), 
                       LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Mikhail"), 
                       MonsterLife=get(FindJob(MonsterLifePreSet, "Mikhail")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                       Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Sword", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                       WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                       SubWeapon=SubWeapon[rownames(SubWeapon)=="SoulShield", ], 
                       Emblem=Emblem[rownames(Emblem)=="Cygnus", ], 
                       CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Mikhail")))


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
value <- c(GetCoreLv(MikhailCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(MikhailCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(MikhailCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

MikhailPassive <- Passive(list(ElementalExpert=ElementalExpert, Encourage=Encourage, SwordMastery=SwordMastery, PhysicalTraining=PhysicalTraining, 
                               SoulLink=SoulLink, AdvancedRoyalGuard=AdvancedRoyalGuard, Intention=Intention, SoulAttack=SoulAttack, ShiningCharge=ShiningCharge, 
                               SoulRage=SoulRage, AdvnacedSwordMastery=AdvnacedSwordMastery, AdvancedFinalAttack=AdvancedFinalAttack, CombatMastery=CombatMastery, 
                               BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## Mikhail- Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwordBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(180, NA, 0, T, NA, NA, T)
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
value <- c(15)
info <- c(25, 180, 90, F, F, F, T)
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
value <- c(21 + floor(GetCoreLv(MikhailCore, "RhoAias")/7) * 3)
info <- c(39 + 2 * GetCoreLv(MikhailCore, "RhoAias"), 180, 1680, F, T, F, T)
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
value <- c(15 + floor(GetCoreLv(MikhailCore, "SwordofSoulLight")/2), 100, 100, 1)
info <- c(35, 180, 1050, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SwordofSoulLight <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(MikhailCore, "LightofCourage")/2))
info <- c(25, 90, 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightofCourageBuff <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(MikhailCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(c("IGR", "FDR", "ATKSkill"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(MikhailCore, "AuraWeapon")/5), ceiling(GetCoreLv(MikhailCore, "AuraWeapon")/5), 1)
info <- c(80 + 2 * GetCoreLv(MikhailCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

MikhailBuff <- list(SwordBooster=SwordBooster, Encourage=Encourage, MapleSoldier=MapleSoldier, MikhailLink=MikhailLink, DeadlyChargeBuff=DeadlyChargeBuff, SacredCube=SacredCube,
                    QueenofTomorrow=QueenofTomorrow, RhoAias=RhoAias, ClaiomhSolaisCool=ClaiomhSolaisCool, SwordofSoulLight=SwordofSoulLight, LightofCourageBuff=LightofCourageBuff, 
                    UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders,
                    AuraWeaponBuff=AuraWeaponBuff, BlessofCygnus=BlessofCygnus, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : SwordBooster(600ms), Encourage(600ms), MapleSoldier(0ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  MikhailBuff[[length(MikhailBuff)+1]] <- UsefulAdvancedBless
  names(MikhailBuff)[[length(MikhailBuff)]] <- "UsefulAdvancedBless"
}
MikhailBuff <- Buff(MikhailBuff)
MikhailAllTimeBuff <- AllTimeBuff(MikhailBuff)


## Mikhail - Union & HyperStat & SoulWeapon
MikhailSpec <- JobSpec(JobBase=MikhailBase, 
                       Passive=MikhailPassive, 
                       AllTimeBuff=MikhailAllTimeBuff, 
                       MobInfo=get(DPMCalcOption$MobSet), 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       WeaponName="Sword", 
                       UnionStance=0)

MikhailUnionRemained <- MikhailSpec$UnionRemained
MikhailHyperStatBase <- MikhailSpec$HyperStatBase
MikhailCoolReduceType <- MikhailSpec$CoolReduceType
MikhailSpec <- MikhailSpec$Spec


## Mikahil - Spider In Mirror
SIM <- SIMData(GetCoreLv(MikhailCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Mikhail - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "SoulAssault")>=40, 20, 0), 20, 2 * GetCoreLv(MikhailCore, "SoulAssault"))
info <- c(210 + 3 * MikhailSpec$SkillLv, 12, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulAssault <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "ShiningCross")>=40, 20, 0), 20, 2 * GetCoreLv(MikhailCore, "ShiningCross"))
info <- c(440 + 3 * MikhailSpec$SkillLv, 5, 720, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ShiningCross <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "RoyalGuard")>=40, 20, 0), 2 * GetCoreLv(MikhailCore, "RoyalGuard"))
info <- c(RoyalGuardDamage[RoyalGuardStack+1] + MikhailBase$ChrLv, RoyalGuardATKCount[RoyalGuardStack+1], 600, NA, 6, T, T, T)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoyalGuard <- rbind(data.frame(option, value), info) ## No ATKSpeed

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "AdvancedFinalAttack")>=40, 20, 0), MikhailBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(MikhailCore, "AdvancedFinalAttack"))
info <- c(95 + MikhailSpec$SkillLv, 4 * (0.75 + 0.01 * MikhailSpec$SkillLv), 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AdvancedFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "DeadlyCharge")>=40, 20, 0), 2 * GetCoreLv(MikhailCore, "DeadlyCharge"))
info <- c(600, 10, 1080, NA, 15, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DeadlyCharge <- rbind(data.frame(option, value), info)

ClaiomhSolaisDamage <- c(350 + 20 * GetCoreLv(MikhailCore, "ClaiomhSolais"), 350 + 20 * GetCoreLv(MikhailCore, "ClaiomhSolais"), 420 + 20 * GetCoreLv(MikhailCore, "ClaiomhSolais"),
                         510 + 20 * GetCoreLv(MikhailCore, "ClaiomhSolais"), 600 + 24 * GetCoreLv(MikhailCore, "ClaiomhSolais"), 700 + 28 * GetCoreLv(MikhailCore, "ClaiomhSolais"))
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
info <- c(400 + 16 * GetCoreLv(MikhailCore, "SwordofSoulLight"), 12, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulLightSlash <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(MikhailCore, "SwordofSoulLight"), 5, 0, 1800, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SwordofSoulLightAfterimage <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(850 + 34 * GetCoreLv(MikhailCore, "SwordofSoulLight"), 12, 930, 66, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightForceRay <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(MikhailCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

MikhailATK <- Attack(list(SoulAssault=SoulAssault, ShiningCross=ShiningCross, RoyalGuard=RoyalGuard, AdvancedFinalAttack=AdvancedFinalAttack, DeadlyCharge=DeadlyCharge, 
                          ClaiomhSolais=ClaiomhSolais, ClaiomhSolaisAuto=ClaiomhSolaisAuto, SoulLightSlash=SoulLightSlash, SwordofSoulLightAfterimage=SwordofSoulLightAfterimage,  
                          LightForceRay=LightForceRay, AuraWeapon=AuraWeapon, SpiderInMirror=SpiderInMirror))


## Mikhail - Summoned
{option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(MikhailCore, "ShiningCross")>=40, 20, 0), 20, 2 * GetCoreLv(MikhailCore, "ShiningCross"))
info <- c(75, 5, 0, 810, 12, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ShiningCrossInstall <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(MikhailCore, "CygnusPhalanx"), 1, 780, 240, 0.24 * (39 + GetCoreLv(MikhailCore, "CygnusPhalanx")) + 0.25, 30, F, T, F, F)
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
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(MikhailSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, MikhailSpec$CoolReduceP, MikhailSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * MikhailSpec$SummonedDuration / 100, 0)


## Mikhail DealCycle
DealCycle <- c("Skills", "Time", rownames(MikhailBuff))
MikhailDealCycle <- t(rep(0, length(DealCycle)))
colnames(MikhailDealCycle) <- DealCycle

MikhailCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(360)) {
  BuffSummonedPrior <- c("SwordBooster", "Encourage", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "QueenofTomorrow", 
                         "AuraWeaponBuff", "RhoAias", "MikhailLink", "CygnusPhalanx", "BlessofCygnus", "LightofCourageBuff", "SwordofSoulLight", 
                         "SoulContractLink", "SacredCube", "Restraint4")
  Times180 <- c(0, 0, 0, 0, 0, 0, 0, 
                1, 1, 1, 6, 0.5, 2, 1,
                2, 0.5, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - CycleTime/Period * Spec$CoolReduce
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
      ## Light Force Ray
      if(ForceRayDummy == 0 & DealCycle$SwordofSoulLight[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] <= 2000) {
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
      else if(DCRemain == 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DCCool - 8000 <= BuffStartTime & k==length(BuffList) | 
              DCRemain == 0 & k!=length(BuffList)) {
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
      else if(CSRemain == 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + CSCool - 8000 <= BuffStartTime & k==length(BuffList) | 
              CSRemain == 0 & k!=length(BuffList)) {
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
                                   CycleTime=360)
MikhailDealCycle <- DealCycleFinal(MikhailDealCycle)
MikhailDealCycle <- MikhailBuffLogic(MikhailDealCycle)
MikhailDealCycle <- RepATKCycle(MikhailDealCycle, "LightForceRay", 6, 180, ATKFinal)
MikhailDealCycle <- RepATKCycle(MikhailDealCycle, "SwordofSoulLightAfterimage", 19, 1800, ATKFinal)
MikhailDealCycle <- DCSummonedATKs(MikhailDealCycle, Skill=c("ShiningCrossInstall", "CygnusPhalanx"), SummonedFinal)
MikhailDealCycle <- AWCSCycleMikhail(MikhailDealCycle)
MikhailDealCycle <- AddATKCycleMikhail(MikhailDealCycle)
MikhailDealCycle <- DCSpiderInMirror(MikhailDealCycle, SummonedFinal)
MikhailDealCycle <- BlessofCygnusCycle(MikhailDealCycle, 4000, General$General$Serverlag, GetCoreLv(MikhailCore, "BlessofCygnus"))
MikhailDealCycleReduction <- DealCycleReduction(MikhailDealCycle, "BlessofCygnusBDR")


Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Mikhail") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  MikhailSpecOpt1 <- Optimization1(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpec, MikhailUnionRemained, 
                                       NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- MikhailSpecOpt1[1, 1:3]
} else {
  MikhailSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
MikhailSpecOpt <- OptDataAdd(MikhailSpec, MikhailSpecOpt1, "Potential", MikhailBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  MikhailSpecOpt2 <- Optimization2(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, MikhailHyperStatBase, MikhailBase$ChrLv, MikhailBase$CRROver, 
                                       NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- MikhailSpecOpt2[1, ]
} else {
  MikhailSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
MikhailSpecOpt <- OptDataAdd(MikhailSpecOpt, MikhailSpecOpt2, "HyperStat", MikhailBase$CRROver, DemonAvenger=F)

MikhailFinalDPM <- DealCalc(MikhailDealCycle, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, Collapse=F, 
                                NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
MikhailFinalDPMwithMax <- DealCalcWithMaxDMR(MikhailDealCycle, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, 
                                                 NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Mikhail", sum(na.omit(MikhailFinalDPMwithMax)) / (max(MikhailDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Mikhail", sum(na.omit(MikhailFinalDPM)) / (max(MikhailDealCycle$Time) / 60000) - sum(na.omit(MikhailFinalDPMwithMax)) / (max(MikhailDealCycle$Time) / 60000))

MikhailDealRatio <- DealRatio(MikhailDealCycle, MikhailFinalDPMwithMax)

MikhailDealData <- data.frame(MikhailDealCycle$Skills, MikhailDealCycle$Time, MikhailDealCycle$Restraint4, MikhailFinalDPMwithMax)
colnames(MikhailDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Mikhail", Deal_RR(MikhailDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Mikhail", Deal_40s(MikhailDealData))

MikhailSpecMean <- SpecMean("Mikhail", MikhailDealCycleReduction, 
                            DealCalcWithMaxDMR(MikhailDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, 
                                               NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR")), 
                            ATKFinal, BuffFinal, SummonedFinal, MikhailSpecOpt, 
                            NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))