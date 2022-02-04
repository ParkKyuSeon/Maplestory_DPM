## Blaster - Data
## Blaster - VMatrix
BlasterCoreBase <- CoreBuilder(ActSkills=c("BunkerBuster", "VulcanPunch", "BurningBreaker", "AfterimageShock",  
                                           CommonV("Warrior", "Resistance")), 
                               ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                               UsefulSkills=c("SharpEyes", "CombatOrders"), 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               VPassiveList=BlasterVPassive, 
                               VPassivePrior=BlasterVPrior, 
                               SelfBind=F)

BlasterCore <- MatrixSet(PasSkills=BlasterCoreBase$PasSkills$Skills, 
                         PasLvs=BlasterCoreBase$PasSkills$Lv, 
                         PasMP=BlasterCoreBase$PasSkills$MP, 
                         ActSkills=BlasterCoreBase$ActSkills$Skills, 
                         ActLvs=BlasterCoreBase$ActSkills$Lv, 
                         ActMP=BlasterCoreBase$ActSkills$MP, 
                         UsefulSkills=BlasterCoreBase$UsefulSkills, 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=get(DPMCalcOption$SpecSet), 
                         SpecialCore=BlasterCoreBase$SpecialCoreUse)


## Blaster - Basic Info
## Link Check Needed
BlasterBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=get(DPMCalcOption$MobSet),
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       Job="Blaster",
                       CoreData=BlasterCore, 
                       BuffDurationNeeded=0, 
                       AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Blaster"), 
                       LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Blaster"), 
                       MonsterLife=get(FindJob(MonsterLifePreSet, "Blaster")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                       Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "GuntletRevolver", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                       WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                       SubWeapon=SubWeapon[rownames(SubWeapon)=="BlasterGunpowder", ],
                       Emblem=Emblem[rownames(Emblem)=="Resistance", ],
                       CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Blaster")))


## Blaster - Passive
{option <- factor(c("CRR", "ATK"), levels=PSkill)
value <- c(30, 20)
GuntletMastery <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20)
ChargeMastery <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(15)
CombinationTraining <- data.frame(option, value)

option <- factor(c("Mastery", "CDMR", "BDR"), levels=PSkill)
value <- c(70 + ceiling(BlasterBase$PSkillLv/2), 20 + ceiling(BlasterBase$PSkillLv/2), 20 + ceiling(BlasterBase$PSkillLv/2))
GuntletExpert <- data.frame(option, value)
  
option <- factor(c("IGR"), levels=PSkill)
value <- c(35 + 3 * BlasterBase$PSkillLv)
AdvancedChargeMastery <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "CRR", "ATKSpeed"), levels=PSkill)
value <- c(40 + 2 * BlasterBase$PSkillLv, 10 * (6 + ceiling(BlasterBase$PSkillLv / 10)), 10 * (ceiling((BlasterBase$PSkillLv + 20) / 7)), 1)
CombinationTrainingII <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(BlasterCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(BlasterCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(BlasterCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

BlasterPassive <- Passive(list(GuntletMastery=GuntletMastery, PhysicalTraining=PhysicalTraining, ChargeMastery=ChargeMastery, CombinationTraining=CombinationTraining, 
                               GuntletExpert=GuntletExpert, AdvancedChargeMastery=AdvancedChargeMastery, CombinationTrainingII=CombinationTrainingII, 
                               BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## Blaster - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GuntletBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((BlasterBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(BlasterBase$SkillLv/2))))
info <- c(900 + 30 * BlasterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CylinderGauge <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(7, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CylinderOverload <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(10)
info <- c(10, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HammerSmashDebuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WillofLiberty <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(35, 240, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MaximizeCannon <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(50)
info <- c(35, 240, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MaximizeCannonRevolvingBunkerBDR <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(BlasterCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 120, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunkerBusterBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180, 240, 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AfterimageShockBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(BlasterCore, "AuraWeapon")/5), ceiling(GetCoreLv(BlasterCore, "AuraWeapon")/5))
info <- c(80 + 2 * GetCoreLv(BlasterCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(BlasterCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * BlasterBase$MainStatP), 5 + floor(GetCoreLv(BlasterCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

BlasterBuff <- list(GuntletBooster=GuntletBooster, MapleSoldier=MapleSoldier, CylinderGauge=CylinderGauge, CylinderOverload=CylinderOverload, HammerSmashDebuff=HammerSmashDebuff, 
                     WillofLiberty=WillofLiberty, MaximizeCannon=MaximizeCannon, MaximizeCannonRevolvingBunkerBDR=MaximizeCannonRevolvingBunkerBDR, UsefulSharpEyes=UsefulSharpEyes, 
                     UsefulCombatOrders=UsefulCombatOrders, BunkerBusterBuff=BunkerBusterBuff, AfterimageShockBuff=AfterimageShockBuff, AuraWeaponBuff=AuraWeaponBuff, MapleWarriors2=MapleWarriors2, 
                     Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  BlasterBuff[[length(BlasterBuff)+1]] <- UsefulAdvancedBless
  names(BlasterBuff)[[length(BlasterBuff)]] <- "UsefulAdvancedBless"
}
BlasterBuff <- Buff(BlasterBuff)
BlasterAllTimeBuff <- AllTimeBuff(BlasterBuff)
## PetBuff : GuntleBooster, MapleSoldier, UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)


## Blaster - Union & HyperStat & SoulWeapon
BlasterSpec <- JobSpec(JobBase=BlasterBase, 
                       Passive=BlasterPassive, 
                       AllTimeBuff=BlasterAllTimeBuff, 
                       MobInfo=get(DPMCalcOption$MobSet), 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       WeaponName="GuntletRevolver", 
                       UnionStance=0)

BlasterUnionRemained <- BlasterSpec$UnionRemained
BlasterHyperStatBase <- BlasterSpec$HyperStatBase
BlasterCoolReduceType <- BlasterSpec$CoolReduceType
BlasterSpec <- BlasterSpec$Spec


## Blaster - Spider In Mirror
SIM <- SIMData(GetCoreLv(BlasterCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Blaster - Attacks
{option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "MagnumPunch"), 10, IGRCalc(c(20, ifelse(GetCoreLv(BlasterCore, "MagnumPunch")>=40, 20, 0))))
info <- c(475 + 3 * BlasterSpec$SkillLv, 3, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagnumPunch <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "DoubleFang"), 10, IGRCalc(c(20, ifelse(GetCoreLv(BlasterCore, "DoubleFang")>=40, 20, 0))))
info <- c(400 + 2 * BlasterSpec$SkillLv, 4, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DoubleFang <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 150, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Ducking <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "RevolvingCannon"), ifelse(GetCoreLv(BlasterCore, "RevolvingCannon")>=40, 20, 0))
info <- c(180 + BlasterSpec$PSkillLv, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RevolvingCannon <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "ReleasePileBunker"), 20, IGRCalc(c(80, ifelse(GetCoreLv(BlasterCore, "ReleasePileBunker")>=40, 20, 0))))
info <- c(370 + BlasterSpec$PSkillLv, 8, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReleasePileBunker <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "ReleasePileBunker"), 15, ifelse(GetCoreLv(BlasterCore, "ReleasePileBunker")>=40, 20, 0))
info <- c(220 + BlasterSpec$PSkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReleasePileBunkerShockwaveA <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "ReleasePileBunker"), 15, ifelse(GetCoreLv(BlasterCore, "ReleasePileBunker")>=40, 20, 0))
info <- c(230 + BlasterSpec$PSkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReleasePileBunkerShockwaveB <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "ReleasePileBunker"), 15, ifelse(GetCoreLv(BlasterCore, "ReleasePileBunker")>=40, 20, 0))
info <- c(270 + BlasterSpec$PSkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReleasePileBunkerShockwaveC <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "ReleasePileBunker"), 15, ifelse(GetCoreLv(BlasterCore, "ReleasePileBunker")>=40, 20, 0))
info <- c(320 + BlasterSpec$PSkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReleasePileBunkerShockwaveD <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "HammerSmash"), 10, IGRCalc(c(20, ifelse(GetCoreLv(BlasterCore, "HammerSmash")>=40, 20, 0))))
info <- c(390 + 2 * BlasterSpec$PSkillLv, 6, 270, NA, NA, NA, NA, F) ## Skip Type Check Needed
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HammerSmash <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * GetCoreLv(BlasterCore, "HammerSmash"), IGRCalc(c(20, ifelse(GetCoreLv(BlasterCore, "HammerSmash")>=40, 20, 0))))
info <- c(150, 4, 0, 1000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HammerSmashShockwave <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=ASkill)
value <- c(BlasterBase$MonsterLife$FinalATKDMR)
info <- c(215 + BlasterSpec$PSkillLv, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RevolvingCannonMastery <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(180 + 7 * GetCoreLv(BlasterCore, "BunkerBuster"), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BunkerBuster <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(BlasterCore, "VulcanPunch"), 12, 1080, NA, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VulcanPunchPre <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(425 + 17 * GetCoreLv(BlasterCore, "VulcanPunch"), 8, 2920, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VulcanPunch <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 360, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
VulcanPunchEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 210 * 5, NA, 100, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BurningBreakerPre <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(1500 + 60 * GetCoreLv(BlasterCore, "BurningBreaker"), 15, 2940, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BurningBreaker <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(1200 + 48 * GetCoreLv(BlasterCore, "BurningBreaker"), 90, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BurningBreakerEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(BlasterCore, "AfterimageShock"), 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AfterimageShock <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(BlasterCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

BlasterATK <- Attack(list(MagnumPunch=MagnumPunch, DoubleFang=DoubleFang, Ducking=Ducking, RevolvingCannon=RevolvingCannon, ReleasePileBunker=ReleasePileBunker, 
                          ReleasePileBunkerShockwaveA=ReleasePileBunkerShockwaveA, ReleasePileBunkerShockwaveB=ReleasePileBunkerShockwaveB, ReleasePileBunkerShockwaveC=ReleasePileBunkerShockwaveC, 
                          ReleasePileBunkerShockwaveD=ReleasePileBunkerShockwaveD, HammerSmash=HammerSmash, HammerSmashShockwave=HammerSmashShockwave, RevolvingCannonMastery=RevolvingCannonMastery, 
                          BunkerBuster=BunkerBuster, VulcanPunchPre=VulcanPunchPre, VulcanPunch=VulcanPunch, VulcanPunchEnd=VulcanPunchEnd, BurningBreakerPre=BurningBreakerPre, 
                          BurningBreaker=BurningBreaker, BurningBreakerEnd=BurningBreakerEnd, AfterimageShock=AfterimageShock, AuraWeapon=AuraWeapon, SpiderInMirror=SpiderInMirror))


## Blaster - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(215 + 8 * GetCoreLv(BlasterCore, "ResistanceLineInfantry"), 9, 360, 990, 10, 25, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
ResistanceLineInfantry <- rbind(data.frame(option, value), info)}

BlasterSummoned <- Summoned(list(ResistanceLineInfantry=ResistanceLineInfantry, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, 
                                 SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Blaster - DealCycle & Deal Calculation
ATKFinal <- data.frame(BlasterATK)
ATKFinal$Delay[c(-1, -2, -3, -5, -10, -14, -15, -16, -17)] <- Delay(ATKFinal$Delay, BlasterSpec$ATKSpeed)[c(-1, -2, -3, -5, -10, -14, -15, -16, -17)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BlasterSpec$CoolReduceP, BlasterSpec$CoolReduce)

BuffFinal <- data.frame(BlasterBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BlasterSpec$CoolReduceP, BlasterSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BlasterSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(BlasterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BlasterSpec$CoolReduceP, BlasterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BlasterSpec$SummonedDuration / 100, 0)


## Blaster - DealCycle
DealCycle <- c("Skills", "Time", rownames(BlasterBuff))
BlasterDealCycle <- t(rep(0, length(DealCycle)))
colnames(BlasterDealCycle) <- DealCycle

BlasterCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure,
                         Period=120, CycleTime=720, MagFangDelay=510) {
  if(MagFangDelay!=510) {
    for(i in 1:nrow(ATKFinal)) {
      if(rownames(ATKFinal)[i]=="MagnumPunch") {
        ATKFinal$Delay[i] <- MagFangDelay - 180 - 150
      } else if(rownames(ATKFinal)[i]=="ReleasePileBunker") {
        ATKFinal$Delay[i] <- MagFangDelay - 180 - 150
      }
    }
  }
  
  BuffSummonedPrior <- c("GuntletBooster", "MapleSoldier", "WillofLiberty", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "AfterimageShockBuff", "AuraWeaponBuff", "MaximizeCannon", "MapleWarriors2", "BunkerBusterBuff", "SoulContractLink", "Restraint4")
  Times120 <- c(0.5, 0.5, 0, 0, 0, 0, 
                0.5, 2/3, 0.5, 0.5, 1, 1, 0.5)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times120 <- Times120[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
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
      if(BuffList[[1]][i]=="WillofLiberty") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c() ; NoSubTimeSummoned <- c()
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
  
  VPCool <- subset(ATKFinal, rownames(ATKFinal)=="VulcanPunchPre")$CoolTime * 1000
  RLCool <- subset(SummonedFinal, rownames(SummonedFinal)=="ResistanceLineInfantry")$CoolTime * 1000
  VPRemain <- 0 ; RLRemain <- 0
  DealCycle$CylinderGauge[nrow(DealCycle)] <- 6
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  
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
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        }
      }
      ## Resistance Line Infantry
      if(RLRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="ResistanceLineInfantrySummoned")) < 9 * nrow(subset(DealCycle, DealCycle$Skills=="AfterimageShockBuff"))) {
        DealCycle <- DCSummoned(DealCycle, "ResistanceLineInfantry", SummonedFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- RLCool - DealCycle$Time[1]
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
      }
      ## Vulcan Punch
      else if(VPRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="VulcanPunch")) < 4 * nrow(subset(DealCycle, DealCycle$Skills=="AfterimageShockBuff")) & 
              DealCycle$CylinderGauge[nrow(DealCycle)] >= 2 & DealCycle$MaximizeCannon[nrow(DealCycle)] - DealCycle$Time[1] > 0 & k!=length(BuffList) | 
              VPRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="VulcanPunch")) < 4 * nrow(subset(DealCycle, DealCycle$Skills=="AfterimageShockBuff")) & 
              DealCycle$CylinderGauge[nrow(DealCycle)] >= 2 & DealCycle$MaximizeCannon[nrow(DealCycle)] - DealCycle$Time[1] > 0 & k==length(BuffList) & 
              BuffStartTime - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > VPCool - 4000) {
        DealCycle <- DCATK(DealCycle, "VulcanPunchPre", ATKFinal)
        VPRemain <- VPCool - DealCycle$Time[1]
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "VulcanPunch", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "VulcanPunchEnd", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
      }
      else if(VPRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="VulcanPunch")) < 4 * nrow(subset(DealCycle, DealCycle$Skills=="AfterimageShockBuff")) & 
              DealCycle$CylinderOverload[nrow(DealCycle)] - DealCycle$Time[1] >= 4000 & k!=length(BuffList) | 
              VPRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="VulcanPunch")) < 4 * nrow(subset(DealCycle, DealCycle$Skills=="AfterimageShockBuff")) & 
              DealCycle$CylinderOverload[nrow(DealCycle)] - DealCycle$Time[1] >= 4000 & k==length(BuffList) & 
              BuffStartTime - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) > VPCool - 4000) {
        DealCycle <- DCATK(DealCycle, "VulcanPunchPre", ATKFinal)
        VPRemain <- VPCool - DealCycle$Time[1]
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "VulcanPunch", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "VulcanPunchEnd", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
      }
      ## Release File Bunker - Hammer Smash
      else if(DealCycle$CylinderGauge[nrow(DealCycle)] >= 6 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= 713000) {
        DealCycle <- DCATK(DealCycle, "ReleasePileBunker", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- 0
        DealCycle$CylinderOverload[nrow(DealCycle)] <- ifelse(DealCycle$MaximizeCannon[nrow(DealCycle)] > 0, 1000, 7000)
        if(DealCycle$MaximizeCannon[nrow(DealCycle)] > 0 & DealCycle$HammerSmashDebuff[nrow(DealCycle)] - DealCycle$Time[1] > 3000) {
          DealCycle <- DCATK(DealCycle, "Ducking", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        } else {
          DealCycle <- DCATK(DealCycle, "HammerSmashShockwave", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
          DealCycle <- DCATK(DealCycle, "HammerSmash", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
          DealCycle$HammerSmashDebuff[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="HammerSmashDebuff")$Duration * 1000
          DealCycle <- DCATK(DealCycle, "MagnumPunch", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- ifelse(DealCycle$CylinderOverload[nrow(DealCycle)] == 0, DealCycle$CylinderGauge[nrow(DealCycle)-1] + 1, DealCycle$CylinderGauge[nrow(DealCycle)-1])
          DealCycle <- DCATK(DealCycle, "DoubleFang", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- ifelse(DealCycle$CylinderOverload[nrow(DealCycle)] == 0, DealCycle$CylinderGauge[nrow(DealCycle)-1] + 1, DealCycle$CylinderGauge[nrow(DealCycle)-1])
          DealCycle <- DCATK(DealCycle, "Ducking", ATKFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        }
      }
      ## Burning Breaker
      else if(DealCycle$SoulContractLink[nrow(DealCycle)] > 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="BurningBreaker")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink"))) {
        DealCycle <- DCATK(DealCycle, "BurningBreakerPre", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "BurningBreaker", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        DealCycle <- DCATK(DealCycle, "BurningBreakerEnd", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
      }
      ## Magnum Punch - Double Fang
      else {
        DealCycle <- DCATK(DealCycle, "MagnumPunch", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- ifelse(DealCycle$CylinderOverload[nrow(DealCycle)] == 0, DealCycle$CylinderGauge[nrow(DealCycle)-1] + 1, DealCycle$CylinderGauge[nrow(DealCycle)-1])
        DealCycle <- DCATK(DealCycle, "DoubleFang", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- ifelse(DealCycle$CylinderOverload[nrow(DealCycle)] == 0, DealCycle$CylinderGauge[nrow(DealCycle)-1] + 1, DealCycle$CylinderGauge[nrow(DealCycle)-1])
        DealCycle <- DCATK(DealCycle, "Ducking", ATKFinal)
        VPRemain <- max(0, VPRemain - DealCycle$Time[1])
        RLRemain <- max(0, RLRemain - DealCycle$Time[1])
        DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="AfterimageShockBuff") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            VPRemain <- max(0, VPRemain - DealCycle$Time[1])
            RLRemain <- max(0, RLRemain - DealCycle$Time[1])
            DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          VPRemain <- max(0, VPRemain - DealCycle$Time[1])
          RLRemain <- max(0, RLRemain - DealCycle$Time[1])
          DealCycle$CylinderGauge[nrow(DealCycle)] <- DealCycle$CylinderGauge[nrow(DealCycle)-1]
        }
      }
    }
  }
  return(DealCycle)
}
BlasterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  ## Revolving Cannon / Revolving Cannon (Bunker Buster)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MagnumPunch", "DoubleFang"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RevolvingCannon"
      if(DealCycle$MaximizeCannon[nrow(DealCycle)] > 0) {
        DealCycle$MaximizeCannonRevolvingBunkerBDR[nrow(DealCycle)] <- 1
      }
      if(DealCycle$BunkerBusterBuff[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "BunkerBuster"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Release Pile Bunker
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ReleasePileBunker") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ReleasePileBunkerShockwaveA"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ReleasePileBunkerShockwaveB"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ReleasePileBunkerShockwaveC"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ReleasePileBunkerShockwaveD"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Hammer Smash Shockwave / Vulcan Punch
  DealCycle <- RepATKCycle(DealCycle, "HammerSmashShockwave", 4, 1000, ATKFinal)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HammerSmashShockwave") {
      DealCycle$CylinderGauge[i] <- DealCycle$CylinderGauge[i-1]
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "VulcanPunch", 24, 0, ATKFinal)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="VulcanPunch") {
      DealCycle$CylinderGauge[i] <- ifelse(DealCycle$CylinderGauge[i-1] > 0, min(7, DealCycle$CylinderGauge[i-1] + 1), DealCycle$CylinderGauge[i-1])
    }
  }
  
  ## Revolving Cannon Mastery
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("MagnumPunch", "DoubleFang", "HammerSmash", "BurningBreaker", "VulcanPunchPre", "VulcanPunch"))==1 & DealCycle$CylinderGauge[i] > 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RevolvingCannonMastery"
    } else if(sum(DealCycle$Skills[i]==c("MagnumPunch", "DoubleFang", "HammerSmash", "BurningBreaker", "VulcanPunchPre", "VulcanPunch"))==1 & DealCycle$CylinderOverload[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "RevolvingCannonMastery"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Afterimage Shock
  ASRemain <- 0 ; ASCount <- 0
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i]=="AfterimageShockBuff") {
      ASCount <- 0 ; ASRemain <- 0
    }
    if(sum(DealCycle$Skills[i]==c("MagnumPunch", "DoubleFang", "HammerSmash", "BurningBreaker", "ReleasePileBunker", "VulcanPunchPre", "VulcanPunch"))==1 & ASRemain == 0 & ASCount < 99 & 
       DealCycle$AfterimageShock[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AfterimageShock"
      ASRemain <- max(0, 100 - (DealCycle$Time[i+1] - DealCycle$Time[i]))
      ASCount <- ASCount + 1
    } else {
      ASRemain <- max(0, 100 - (DealCycle$Time[i+1] - DealCycle$Time[i]))
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Aura Weapon
  DealCycle <- AWCycle(DealCycle, c("MagnumPunch", "DoubleFang", "HammerSmash", "BurningBreaker", "BurningBreakerEnd", "ReleasePileBunker", "VulcanPunchPre", "VulcanPunch"))
  
  ## Resistance Line Infantry
  DealCycle <- DCSummonedATKs(DealCycle, "ResistanceLineInfantry", SummonedFinal)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Dummy Reduction
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]!="RevolvingCannonMastery") {
      DealCycle$CylinderGauge[i] <- 0
    } else if(DealCycle$Skills[i]=="RevolvingCannonMastery" & DealCycle$CylinderGauge[i] > 0) {
      DealCycle$CylinderGauge[i] <- max(0, min(5, DealCycle$CylinderGauge[i] - 2))
    } else if(DealCycle$Skills[i]=="RevolvingCannonMastery" & DealCycle$CylinderOverload[i] > 0) {
      DealCycle$CylinderGauge[i] <- 5
    }
  }
  DealCycle$CylinderGauge <- ((1.1 ^ DealCycle$CylinderGauge) - 1) * 100
  return(DealCycle)
}

BlasterDealCycle <- BlasterCycle(PreDealCycle=BlasterDealCycle, 
                                 ATKFinal=ATKFinal,
                                 BuffFinal=BuffFinal, 
                                 SummonedFinal=SummonedFinal, 
                                 Spec=BlasterSpec,
                                 Period=120, 
                                 CycleTime=720, 
                                 MagFangDelay=510)
BlasterDealCycle <- DealCycleFinal(BlasterDealCycle)
BlasterDealCycle <- BlasterAddATK(BlasterDealCycle, ATKFinal, BuffFinal, SummonedFinal)
BlasterDealCycleReduction <- DealCycleReduction(BlasterDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Blaster") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  BlasterSpecOpt1 <- Optimization1(BlasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BlasterSpec, BlasterUnionRemained, 
                                   NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- BlasterSpecOpt1[1, 1:3]
} else {
  BlasterSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
BlasterSpecOpt <- OptDataAdd(BlasterSpec, BlasterSpecOpt1, "Potential", BlasterBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  BlasterSpecOpt2 <- Optimization2(BlasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, BlasterHyperStatBase, BlasterBase$ChrLv, BlasterBase$CRROver, 
                                   NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- BlasterSpecOpt2[1, ]
} else {
  BlasterSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
BlasterSpecOpt <- OptDataAdd(BlasterSpecOpt, BlasterSpecOpt2, "HyperStat", BlasterBase$CRROver, DemonAvenger=F)

BlasterFinalDPM <- DealCalc(BlasterDealCycle, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, Collapse=F, 
                            NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))
BlasterFinalDPMwithMax <- DealCalcWithMaxDMR(BlasterDealCycle, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, 
                                             NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Blaster", sum(na.omit(BlasterFinalDPMwithMax)) / (max(BlasterDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Blaster", sum(na.omit(BlasterFinalDPM)) / (max(BlasterDealCycle$Time) / 60000) - sum(na.omit(BlasterFinalDPMwithMax)) / (max(BlasterDealCycle$Time) / 60000))

BlasterDealRatio <- DealRatio(BlasterDealCycle, BlasterFinalDPMwithMax)

BlasterDealData <- data.frame(BlasterDealCycle$Skills, BlasterDealCycle$Time, BlasterDealCycle$Restraint4, BlasterFinalDPMwithMax)
colnames(BlasterDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Blaster", Deal_RR(BlasterDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Blaster", Deal_40s(BlasterDealData))

BlasterSpecMean <- SpecMean("Blaster", BlasterDealCycleReduction, 
                            DealCalcWithMaxDMR(BlasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, 
                                               NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR")), 
                            ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, 
                            NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))


## Mag - Fang 540ms
DealCycle <- c("Skills", "Time", rownames(BlasterBuff))
BlasterDealCycle540 <- t(rep(0, length(DealCycle)))
colnames(BlasterDealCycle540) <- DealCycle

BlasterDealCycle540 <- BlasterCycle(PreDealCycle=BlasterDealCycle540, 
                                    ATKFinal=ATKFinal,
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal, 
                                    Spec=BlasterSpec,
                                    Period=120, 
                                    CycleTime=720, 
                                    MagFangDelay=540)
BlasterDealCycle540 <- DealCycleFinal(BlasterDealCycle540)
BlasterDealCycle540 <- BlasterAddATK(BlasterDealCycle540, ATKFinal, BuffFinal, SummonedFinal)

Blaster540 <- DealCalcWithMaxDMR(BlasterDealCycle540, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, 
                                 NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))
BlasterDPM540 <- sum(na.omit(Blaster540)) / (max(BlasterDealCycle540$Time) / 60000)

BlasterDealData540 <- data.frame(BlasterDealCycle540$Skills, BlasterDealCycle540$Time, BlasterDealCycle540$Restraint4, Blaster540)
colnames(BlasterDealData540) <- c("Skills", "Time", "R4", "Deal")

BlasterRR540 <- Deal_RR(BlasterDealData540)
Blaster40s540 <- Deal_40s(BlasterDealData540)


## Mag - Fang 480ms
DealCycle <- c("Skills", "Time", rownames(BlasterBuff))
BlasterDealCycle480 <- t(rep(0, length(DealCycle)))
colnames(BlasterDealCycle480) <- DealCycle

BlasterDealCycle480 <- BlasterCycle(PreDealCycle=BlasterDealCycle480, 
                                    ATKFinal=ATKFinal,
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal, 
                                    Spec=BlasterSpec,
                                    Period=120, 
                                    CycleTime=720, 
                                    MagFangDelay=480)
BlasterDealCycle480 <- DealCycleFinal(BlasterDealCycle480)
BlasterDealCycle480 <- BlasterAddATK(BlasterDealCycle480, ATKFinal, BuffFinal, SummonedFinal)

Blaster480 <- DealCalcWithMaxDMR(BlasterDealCycle480, ATKFinal, BuffFinal, SummonedFinal, BlasterSpecOpt, 
                                 NotBuffCols=c("CylinderGauge"), NotBuffColOption=c("FDR"))
BlasterDPM480 <- sum(na.omit(Blaster480)) / (max(BlasterDealCycle480$Time) / 60000)

BlasterDealData480 <- data.frame(BlasterDealCycle480$Skills, BlasterDealCycle480$Time, BlasterDealCycle480$Restraint4, Blaster480)
colnames(BlasterDealData480) <- c("Skills", "Time", "R4", "Deal")

BlasterRR480 <- Deal_RR(BlasterDealData480)
Blaster40s480 <- Deal_40s(BlasterDealData480)

print(list(BL540=data.frame(BlasterDPM540=BlasterDPM540, BlasterRR540=BlasterRR540, Blaster40s540=Blaster40s540), 
           BL480=data.frame(BlasterDPM480=BlasterDPM480, BlasterRR480=BlasterRR480, Blaster40s480=Blaster40s480)))