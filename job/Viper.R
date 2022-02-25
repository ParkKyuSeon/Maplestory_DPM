## Viper - Data
## Viper - VMatrix
ViperCoreBase <- CoreBuilder(ActSkills=c("LightningForm", "SerpentScrew", "FuriousCharge", "HawlingFist",
                                         CommonV("Pirate", "Adventure")), 
                             ActSkillsLv=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                             UsefulSkills=c("SharpEyes", "CombatOrders"), 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             VPassiveList=ViperVPassive, 
                             VPassivePrior=ViperVPrior, 
                             SelfBind=F)

ViperCore <- MatrixSet(PasSkills=ViperCoreBase$PasSkills$Skills, 
                       PasLvs=ViperCoreBase$PasSkills$Lv, 
                       PasMP=ViperCoreBase$PasSkills$MP, 
                       ActSkills=ViperCoreBase$ActSkills$Skills, 
                       ActLvs=ViperCoreBase$ActSkills$Lv, 
                       ActMP=ViperCoreBase$ActSkills$MP, 
                       UsefulSkills=ViperCoreBase$UsefulSkills, 
                       UsefulLvs=20, 
                       UsefulMP=0, 
                       SpecSet=get(DPMCalcOption$SpecSet), 
                       SpecialCore=ViperCoreBase$SpecialCoreUse)


## Viper - Basic Info
ViperBase <- JobBase(ChrInfo=ChrInfo, 
                     MobInfo=get(DPMCalcOption$MobSet),
                     SpecSet=get(DPMCalcOption$SpecSet), 
                     Job="Viper",
                     CoreData=ViperCore, 
                     BuffDurationNeeded=0, 
                     AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Viper"), 
                     LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Viper"), 
                     MonsterLife=get(FindJob(MonsterLifePreSet, "Viper")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                     Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                     WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                     SubWeapon=SubWeapon[rownames(SubWeapon)=="ViperWristband", ], 
                     Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                     CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Viper")))


## Viper - Passive
{option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(20, 5)
CriticalRoar <- data.frame(option, value) 

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
KnuckleAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
MentalClearity <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("CRR", "CDMR", "ATK"), levels=PSkill)
value <- c(35, 10, 30)
CriticalRage <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(60, 15)
GroggyMastery <- data.frame(option, value)

option <- factor(c("Mastery"), levels=PSkill)
value <- c(70 + ceiling(ViperBase$SkillLv/2))
VipersitionPassive <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(25 + 2 * ViperBase$SkillLv)
OffenseForm <- data.frame(option, value)

option <- factor(c("IGR", "FDR", "ATK"), levels=PSkill)
value <- c(40 + 4 * ViperBase$SkillLv, 10 + floor(ViperBase$SkillLv/2), 30 + 2 * ViperBase$SkillLv)
GuardCrush <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20)
StimulatePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + GetCoreLv(ViperCore, "LoadedDice"))
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(ViperCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(ViperCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

ViperPassive <- Passive(list(CriticalRoar, KnuckleAcceleration, MentalClearity, PhysicalTraining, CriticalRage, GroggyMastery, VipersitionPassive, OffenseForm, GuardCrush, StimulatePassive,
                             LoadedDice, BlinkPassive, RopeConnectPassive))


## Viper - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SerpentStoneStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FuriousChargeStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FuriousChargeDummy <- rbind(data.frame(option, value), info)

option <- factor(c("ATKP"), levels=BSkill)
value <- c(30 + ViperBase$SkillLv)
info <- c(180 + 4 * ViperBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Vipersition <- rbind(data.frame(option, value), info) 

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180 + 4 * ViperBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindBooster <- rbind(data.frame(option, value), info) 

option <- factor("MainStat", levels=BSkill)
value <- c(floor((ViperBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(ViperBase$SkillLv/2))))
info <- c(900 + 30 * ViperBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(20)
info <- c(15, 16, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeaSerpentEnrageDebuff <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(30)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice55 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(20, 20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice57 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(40)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice555 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(30, 20)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice557 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR"), levels=BSkill)
value <- c(20, 30)
info <- c(180, 1800, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice577 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(20, 15)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice53 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(20, 25)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice533 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK"), levels=BSkill)
value <- c(30, 15)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice553 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK", "IGR"), levels=BSkill)
value <- c(20, 15, 20)
info <- c(180, 1800, 1500, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice537 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(90, 180, 930, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Stimulate <- rbind(data.frame(option, value), info)

option <- factor(c("CDMR"), levels=BSkill)
value <- c(15)
info <- c(90, 60, Delay(900, 2), F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SerpentSpirit <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(ViperCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(20 + floor(GetCoreLv(ViperCore, "LightningForm")/5))
info <- c(50 + GetCoreLv(ViperCore, "LightningForm"), 180, 450, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LightningForm <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(ViperCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6]))
info <- c(30, 70 - floor(GetCoreLv(ViperCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="Knuckle", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(ViperCore, "OverDrive")/5), T, ViperBase$UnionChrs$CoolReduceP, ViperBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(GetCoreLv(ViperCore, "OverDrive")/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "IGR"), levels=BSkill)
value <- c(floor((ViperBase$ChrLv * 5 + 18) * (0.1 + 0.01 * floor(GetCoreLv(ViperCore, "PirateFlag")/2)) * ViperBase$MainStatP), 10 + floor(GetCoreLv(ViperCore, "PirateFlag")/2))
info <- c(30, 31, 990, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PirateFlag <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(ViperCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * ViperBase$MainStatP), 5 + floor(GetCoreLv(ViperCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

ViperBuff <- list(SerpentStoneStack=SerpentStoneStack, FuriousChargeStack=FuriousChargeStack, FuriousChargeDummy=FuriousChargeDummy, 
                  Vipersition=Vipersition, WindBooster=WindBooster, MapleSoldier=MapleSoldier, SeaSerpentEnrageDebuff=SeaSerpentEnrageDebuff, 
                  LuckyDice5=LuckyDice5, LuckyDice55=LuckyDice55, LuckyDice57=LuckyDice57, LuckyDice555=LuckyDice555, LuckyDice557=LuckyDice557, LuckyDice577=LuckyDice577, 
                  LuckyDice53=LuckyDice53, LuckyDice533=LuckyDice533, LuckyDice553=LuckyDice553, LuckyDice537=LuckyDice537,
                  Stimulate=Stimulate, SerpentSpirit=SerpentSpirit, EpicAdventure=EpicAdventure, 
                  UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                  LightningForm=LightningForm, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, PirateFlag=PirateFlag, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, Restraint4=Restraint4)
## Petbuff : WindBooster(900ms), Vipersition(990ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  ViperBuff[[length(ViperBuff)+1]] <- UsefulAdvancedBless
  names(ViperBuff)[[length(ViperBuff)]] <- "UsefulAdvancedBless"
}
ViperBuff <- Buff(ViperBuff)
ViperAllTimeBuff <- AllTimeBuff(ViperBuff)


## Viper - Union & HyperStat & SoulWeapon
ViperSpec <- JobSpec(JobBase=ViperBase, 
                     Passive=ViperPassive, 
                     AllTimeBuff=ViperAllTimeBuff, 
                     MobInfo=get(DPMCalcOption$MobSet), 
                     SpecSet=get(DPMCalcOption$SpecSet), 
                     WeaponName="Knuckle", 
                     UnionStance=0)

ViperUnionRemained <- ViperSpec$UnionRemained
ViperHyperStatBase <- ViperSpec$HyperStatBase
ViperCoolReduceType <- ViperSpec$CoolReduceType
ViperSpec <- ViperSpec$Spec


## Viper - Spider In Mirror
SIM <- SIMData(GetCoreLv(ViperCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Viper - ATK
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(ViperCore, "FistEnrage")>=40, 20, 0), 2 * GetCoreLv(ViperCore, "FistEnrage"))
info <- c(320 + 4 * ViperSpec$SkillLv, 11, 780, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FistEnrage <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ViperCore, "SeaSerpentEnrage_SerpentAssaultEnrage")>=40, 20, 0), 2 * GetCoreLv(ViperCore, "SeaSerpentEnrage_SerpentAssaultEnrage"))
info <- c(430 + 5 * ViperSpec$SkillLv, 6, 0, NA, 4, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SeaSerpentEnrage <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ViperCore, "SeaSerpentEnrage_SerpentAssaultEnrage")>=40, 20, 0), 2 * GetCoreLv(ViperCore, "SeaSerpentEnrage_SerpentAssaultEnrage"))
info <- c(240 + 2 * ViperSpec$SkillLv, 4, 0, 240, NA, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SerpentAssaultEnrage <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(ViperCore, "Nautilus")>=40, 20, 0), ViperBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(ViperCore, "Nautilus"))
info <- c(165 + 2 * ViperSpec$SkillLv, 2, 0, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NautilusFinalATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=ASkill)
value <- c(50)
info <- c(360 + 14 * GetCoreLv(ViperCore, "LightningForm"), 5, 1080, 150, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightningFormOrb <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR"), levels=ASkill)
value <- c(30)
info <- c(600 + 24 * GetCoreLv(ViperCore, "FuriousCharge"), 10, 540, NA, 0.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FuriousCharge <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(425 + 17 * GetCoreLv(ViperCore, "HawlingFist"), 6, 2100, 240, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HawlingFistStart <- rbind(data.frame(option, value), info) ## Energy Cost : 1250

option <- factor(levels=ASkill)
value <- c()
info <- c(695 + 27 * GetCoreLv(ViperCore, "HawlingFist"), 14, 2580, NA, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HawlingFistLast <- rbind(data.frame(option, value), info) 
## 120ms(1), 840ms(2), 1080ms(3), 1260ms(4), 1350ms(5), 1440ms(6), 1530ms(7), 1620ms(8), 1710ms(9), 1800ms(10), 1890ms(11), 1980ms(12), 2070ms(13), 2160ms(14)
}

ViperATK <- Attack(list(FistEnrage=FistEnrage, SeaSerpentEnrage=SeaSerpentEnrage, SerpentAssaultEnrage=SerpentAssaultEnrage, NautilusFinalATK=NautilusFinalATK, 
                        LightningFormOrb=LightningFormOrb, FuriousCharge=FuriousCharge, HawlingFistStart=HawlingFistStart, HawlingFistLast=HawlingFistLast, 
                        SpiderInMirror=SpiderInMirror))


## Viper - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(360 + 14 * GetCoreLv(ViperCore, "SerpentScrew"), 3, 0, 270, 900, 60, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SerpentScrew <- rbind(data.frame(option, value), info)}

ViperSummoned <- Summoned(list(SerpentScrew=SerpentScrew, SpiderInMirrorStart=SpiderInMirrorStart, 
                               SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                               SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Viper - DealCycle & Deal Calculation
ATKFinal <- data.frame(ViperATK)
ATKFinal$Delay[c(-7)] <- Delay(ATKFinal$Delay, ViperSpec$ATKSpeed)[c(-7)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)

BuffFinal <- data.frame(ViperBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, ViperSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(ViperSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, ViperSpec$CoolReduceP, ViperSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * ViperSpec$SummonedDuration / 100, 0)


## Viper - DealCycle and Deal Calc
DealCycle <- c("Skills", "Time", rownames(ViperBuff))
ViperDealCycle <- t(rep(0, length(DealCycle)))
colnames(ViperDealCycle) <- DealCycle
ViperDealCycle <- data.frame(ViperDealCycle)

ViperCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                       Period=c(182.4), CycleTime=c(729.6)) {
  BuffSummonedPrior <- c("Vipersition", "WindBooster", "LuckyDice5", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "EpicAdventure", 
                         "SerpentScrew", "SerpentSpirit", "Stimulate", "LightningForm", "MapleWarriors2", "OverDrive", "PirateFlag", "SoulContractLink", "Restraint4")
  Times180 <- c(0, 0, 1, 0, 0, 0, 0, 
                0, 3, 1, 1, 1, 3, 6, 2, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period - min(2.4, Spec$CoolReduce), length(BuffSummonedPrior)) * 10
  TotalTime <- (CycleTime - min(2.4, Spec$CoolReduce) * (CycleTime/Period)) * 10
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
  
  ViperStacks <- function(DealCycle) {
    ## Furious Charge
    DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)-1]
    if(DealCycle$FuriousChargeDummy[nrow(DealCycle)-1] >= 0 & DealCycle$FuriousChargeDummy[nrow(DealCycle)]==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] < 6) {
      DealCycle$FuriousChargeStack[nrow(DealCycle)] <- min(6, DealCycle$FuriousChargeStack[nrow(DealCycle)] + 1)
      DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 8000, 
                                                              8000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$FuriousChargeDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$Skills[nrow(DealCycle)]=="FuriousCharge") {
      DealCycle$FuriousChargeStack[nrow(DealCycle)] <- DealCycle$FuriousChargeStack[nrow(DealCycle)] - 1
    } else if(DealCycle$FuriousChargeStack[nrow(DealCycle)] == 6) {
      DealCycle$FuriousChargeDummy[nrow(DealCycle)] <- 8000
    }
    
    ## Sea Serpent Enrage Debuff
    if(DealCycle$Skills[nrow(DealCycle)] == "SeaSerpentEnrage") {
      DealCycle$SeaSerpentEnrageDebuff[nrow(DealCycle)] <- 15000
    }
    
    ## Serpent Stone
    if(DealCycle$Skills[nrow(DealCycle)] == "SeaSerpentEnrage") {
      DealCycle$SerpentStoneStack[nrow(DealCycle)] <- min(5, DealCycle$SerpentStoneStack[nrow(DealCycle)-1] + 1)
    } else if(DealCycle$Skills[nrow(DealCycle)] == "SerpentAssaultEnrage") {
      DealCycle$SerpentStoneStack[nrow(DealCycle)] <- 0
    } else {
      DealCycle$SerpentStoneStack[nrow(DealCycle)] <- DealCycle$SerpentStoneStack[nrow(DealCycle)-1]
    }
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$FuriousChargeStack[nrow(DealCycle)] <- 6
  DealCycle$SerpentStoneStack[nrow(DealCycle)] <- 4
  DealCycle$SeaSerpentEnrageDebuff[nrow(DealCycle)] <- 14000
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="Stimulate") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- ViperStacks(DealCycle)
      } 
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- ViperStacks(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- ViperStacks(DealCycle)
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
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime/10, stringsAsFactors=F)
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
  FCCool <- subset(ATKFinal, rownames(ATKFinal)=="FuriousCharge")$CoolTime * 1000
  SSCool <- subset(ATKFinal, rownames(ATKFinal)=="SeaSerpentEnrage")$CoolTime * 1000
  FCRemain <- 0 ; SSRemain <- 0
  
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes/10, TotalTime/10000)
  
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
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        }
      }
      ## Hawling Fist
      if(SSRemain > 0 & DealCycle$SerpentStoneStack[nrow(DealCycle)] != 5 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="HawlingFistStart")) | 
              DealCycle$Restraint4[nrow(DealCycle)] == 0 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) > nrow(subset(DealCycle, DealCycle$Skills=="HawlingFistStart"))) {
        DealCycle <- DCATK(DealCycle, "HawlingFistStart", ATKFinal)
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "HawlingFistLast", ATKFinal)
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Lightning Form Orb
      else if(SSRemain > 0 & DealCycle$SerpentStoneStack[nrow(DealCycle)] != 5 & nrow(subset(DealCycle, DealCycle$Skills=="LightningForm")) * 3 > nrow(subset(DealCycle, DealCycle$Skills=="LightningFormOrb"))) {
        DealCycle <- DCATK(DealCycle, "LightningFormOrb", ATKFinal)
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Furious Charge
      else if(k < length(BuffList) - 1 & SSRemain > 0 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & DealCycle$OverDrive[nrow(DealCycle)] - DealCycle$Time[1] > 0 & 
              DealCycle$SerpentStoneStack[nrow(DealCycle)] != 5 | 
              k < length(BuffList) - 1 & SSRemain > 0 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & DealCycle$SoulContractLink[nrow(DealCycle)] - DealCycle$Time[1] > 0 & 
              DealCycle$SerpentStoneStack[nrow(DealCycle)] != 5) {
        DealCycle <- DCATK(DealCycle, "FuriousCharge", ATKFinal)
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FCRemain <- FCCool - DealCycle$Time[1]
        DealCycle <- ViperStacks(DealCycle)
      } else if(k == length(BuffList) - 1 & SSRemain > 0 & FCRemain==0 & DealCycle$FuriousChargeStack[nrow(DealCycle)] > 0 & 
                DealCycle$Time[nrow(DealCycle)] + (6 - DealCycle$FuriousChargeStack[nrow(DealCycle)] + 1) * 8000 - (8000 - DealCycle$FuriousChargeDummy[nrow(DealCycle)]) < BuffStartTime + 30400 & 
                DealCycle$SerpentStoneStack[nrow(DealCycle)] != 5) {
        DealCycle <- DCATK(DealCycle, "FuriousCharge", ATKFinal)
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FCRemain <- FCCool - DealCycle$Time[1]
        DealCycle <- ViperStacks(DealCycle)
      }
      ## Fist Enrage
      else {
        DealCycle <- DCATK(DealCycle, "FistEnrage", ATKFinal)
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        SSRemain <- SSRemain
        DealCycle <- ViperStacks(DealCycle)
        
        if(DealCycle$SerpentStoneStack[nrow(DealCycle)] == 5) {
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          DealCycle[1, 2:ncol(DealCycle)] <- 1
          DealCycle <- DCATK(DealCycle, "SerpentAssaultEnrage", ATKFinal)
          DealCycle[1, 2:ncol(DealCycle)] <- ATKFinal[rownames(ATKFinal)=="FistEnrage", ]$Delay - 1
          DealCycle <- ViperStacks(DealCycle)
        } else if(SSRemain == 0) {
          DealCycle[1, 2:ncol(DealCycle)] <- 240
          DealCycle <- DCATK(DealCycle, "SeaSerpentEnrage", ATKFinal)
          DealCycle[1, 2:ncol(DealCycle)] <- ATKFinal[rownames(ATKFinal)=="FistEnrage", ]$Delay - 240
          SSRemain <- max(0, ifelse(DealCycle$Stimulate[nrow(DealCycle)] > 0, SSCool/2, SSCool) - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        } else {
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        }
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="Stimulate" & DealCycle$Time[nrow(DealCycle)] - max(subset(DealCycle, DealCycle$Skills=="SpiderInMirror")$Time) > 240000) {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            FCRemain <- max(0, FCRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            DealCycle <- ViperStacks(DealCycle)
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          DealCycle <- ViperStacks(DealCycle)
        }
      }
    }
  }
  
  while(DealCycle$SerpentStoneStack[nrow(DealCycle)] < 4) {
    DealCycle <- DCATK(DealCycle, "FistEnrage", ATKFinal)
    FCRemain <- max(0, FCRemain - DealCycle$Time[1])
    SSRemain <- SSRemain
    DealCycle <- ViperStacks(DealCycle)
    
    if(SSRemain == 0) {
      DealCycle[1, 2:ncol(DealCycle)] <- 240
      DealCycle <- DCATK(DealCycle, "SeaSerpentEnrage", ATKFinal)
      DealCycle[1, 2:ncol(DealCycle)] <- ATKFinal[rownames(ATKFinal)=="FistEnrage", ]$Delay - 240
      SSRemain <- max(0, ifelse(DealCycle$Stimulate[nrow(DealCycle)] > 0, SSCool/2, SSCool) - DealCycle$Time[1])
      DealCycle <- ViperStacks(DealCycle)
    } else {
      SSRemain <- max(0, SSRemain - DealCycle$Time[1])
    }
  }
  return(DealCycle)
}
ViperAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Lightning Form Orb
  DealCycle <- RepATKCycle(DealCycle, "LightningFormOrb", 12, 1350, ATKFinal)
  
  ## Serpent Assault Enrage
  DealCycle <- RepATKCycle(DealCycle, "SerpentAssaultEnrage", 15, 1260 - 1, ATKFinal)
  
  ## Hawling Fist
  DealCycle <- RepATKCycle(DealCycle, "HawlingFistStart", 8, 240, ATKFinal)
  
  DealCycle$Skills[DealCycle$Skills=="HawlingFistLast"] <- "HawlingFistLastStart"
  HawlingFistLastDelay <- c(120, 840, 1080, 1260, 1350, 1440, 1530, 1620, 1710, 1800, 1890, 1980, 2070, 2160)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HawlingFistLastStart") {
      for(j in 1:length(HawlingFistLastDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "HawlingFistLast"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HawlingFistLastDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HawlingFistLast") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  ## Nautilus Add ATK
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("FistEnrage", "FistEnrageFullCharge", "FuriousCharge", "HawlingFistStart", "HawlingFistLast")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NautilusFinalATK"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Serpent Screw
  DealCycle <- DCSummonedATKs(DealCycle, "SerpentScrew", SummonedFinal)
  
  ## Dummy Reduction
  DealCycle$SerpentStoneStack <- 0
  DealCycle$FuriousChargeStack <- 0
  DealCycle$FuriousChargeDummy <- 0
  
  return(DealCycle)
}
ViperLuckyDice <- function(DealCycle, 
                           LuckyDice=c(5, 55, 57, 555, 557, 577, 53, 533, 553, 537)) {
  ## Lucky Dice
  if(LuckyDice==55) {
    DealCycle$LuckyDice55 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==57) {
    DealCycle$LuckyDice57 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==555) {
    DealCycle$LuckyDice555 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==557) {
    DealCycle$LuckyDice557 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==577) {
    DealCycle$LuckyDice577 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==53) {
    DealCycle$LuckyDice533 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==533) {
    DealCycle$LuckyDice533 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==553) {
    DealCycle$LuckyDice553 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  } else if(LuckyDice==537) {
    DealCycle$LuckyDice537 <- DealCycle$LuckyDice5
    DealCycle$LuckyDice5 <- 0
  }
  
  return(DealCycle)
}

ViperDealCycle <- ViperCycle(DealCycle=ViperDealCycle, 
                             ATKFinal, 
                             BuffFinal, 
                             SummonedFinal, 
                             Spec=ViperSpec, 
                             Period=182.4, 
                             CycleTime=729.6)
ViperDealCycle <- DealCycleFinal(ViperDealCycle)
ViperDealCycle <- ViperAddATK(DealCycle=ViperDealCycle, 
                              ATKFinal, 
                              BuffFinal, 
                              SummonedFinal, 
                              Spec=ViperSpec)

VILuckyDiceList <- c(5, 55, 57, 555, 557, 577, 53, 533, 553, 537)
for(i in 1:length(VILuckyDiceList)) {
  ViperDealCycleDummy <- ViperLuckyDice(ViperDealCycle, VILuckyDiceList[i])
  ViperDealCycleDummy <- OverDriveExhaustBuff(ViperDealCycleDummy, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
  assign(paste("ViperDealCycle", VILuckyDiceList[i], sep=""), ViperDealCycleDummy)
  rm(ViperDealCycleDummy)
}
ViperDealCycleReduction <- DealCycleReduction(ViperDealCycle5)
ViperDealCycleProbs <- c(0.520968, 
                         0.207808, 0.082414, 
                         0.010363, 0.016205, 0.003160, 
                         0.105255, 
                         0.011277, 0.030609, 0.011941)
ViperCycleNames <- c()
for(i in 1:length(VILuckyDiceList)) {
  ViperCycleNames <- c(ViperCycleNames, paste("ViperDealCycle", VILuckyDiceList[i], sep=""))
}

for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Viper") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  ViperSpecOpt1 <- Optimization1(ViperDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ViperSpec, ViperUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- ViperSpecOpt1[1, 1:3]
} else {
  ViperSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
ViperSpecOpt <- OptDataAdd(ViperSpec, ViperSpecOpt1, "Potential", ViperBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  ViperSpecOpt2 <- Optimization2(ViperDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt, ViperHyperStatBase, ViperBase$ChrLv, ViperBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- ViperSpecOpt2[1, ]
} else {
  ViperSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
ViperSpecOpt <- OptDataAdd(ViperSpecOpt, ViperSpecOpt2, "HyperStat", ViperBase$CRROver, DemonAvenger=F)

ViperFinalDPM <- ResetDealCalc(DealCycles=GetList(ViperCycleNames), 
                               ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt, rep(max(ViperDealCycle5$Time), 10), ViperDealCycleProbs)
ViperFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=GetList(ViperCycleNames), 
                                                ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt, rep(max(ViperDealCycle5$Time), 10), ViperDealCycleProbs)

set(get(DPMCalcOption$DataName), as.integer(1), "Viper", sum(na.omit(ViperFinalDPMwithMax)) / (max(ViperDealCycle5$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Viper", sum(na.omit(ViperFinalDPM)) / (max(ViperDealCycle5$Time) / 60000) - sum(na.omit(ViperFinalDPMwithMax)) / (max(ViperDealCycle5$Time) / 60000))

ViperDealDatas <- list()
for(i in 1:length(ViperCycleNames)) {
  ViperDealDatas[[i]] <- DealCalcWithMaxDMR(get(ViperCycleNames[i]), ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt)
}
ViperDealRatio <- ResetDealRatio(DealCycles=GetList(ViperCycleNames), 
                                 DealDatas=ViperDealDatas, rep(max(ViperDealCycle5$Time), 10), ViperDealCycleProbs)

ViperDealData <- data.frame(ViperDealCycle5$Skills, ViperDealCycle5$Time, ViperDealCycle5$Restraint4, ViperDealDatas[[1]])
colnames(ViperDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Viper", Deal_RR(ViperDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Viper", Deal_40s(ViperDealData))

ViperSpecMean <- ResetSpecMean("Viper", 
                               GetList(ViperCycleNames), 
                               ViperDealDatas, 
                               ATKFinal, BuffFinal, SummonedFinal, ViperSpecOpt, rep(max(ViperDealCycle5$Time), 10), ViperDealCycleProbs)