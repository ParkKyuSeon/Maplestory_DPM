## Lara - Data
## Lara - Core
LaraCoreBase <- CoreBuilder(ActSkills=c("HugeStretch", "SunRiverMountWind", "SurgingSpirit", "RidgeZigzag",
                                        CommonV("Wizard", "Anima")), 
                            ActSkillsLv=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                            UsefulSkills=c("SharpEyes", "CombatOrders", "WindBooster"), 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            VPassiveList=LaraVPassive, 
                            VPassivePrior=LaraVPrior, 
                            SelfBind=T)

LaraCore <- MatrixSet(PasSkills=LaraCoreBase$PasSkills$Skills, 
                      PasLvs=LaraCoreBase$PasSkills$Lv, 
                      PasMP=LaraCoreBase$PasSkills$MP, 
                      ActSkills=LaraCoreBase$ActSkills$Skills, 
                      ActLvs=LaraCoreBase$ActSkills$Lv, 
                      ActMP=LaraCoreBase$ActSkills$MP, 
                      UsefulSkills=LaraCoreBase$UsefulSkills, 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      SpecialCore=LaraCoreBase$SpecialCoreUse)


## Lara - Basic Info
## Ability Check Needed
LaraBase <- JobBase(ChrInfo=ChrInfo, 
                    MobInfo=get(DPMCalcOption$MobSet),
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    Job="Lara",
                    CoreData=LaraCore, 
                    BuffDurationNeeded=0, 
                    AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Lara"), 
                    LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Lara"), 
                    MonsterLife=get(FindJob(MonsterLifePreSet, "Lara")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                    Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Wand", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                    WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                    SubWeapon=SubWeapon[rownames(SubWeapon)=="Norigae", ], 
                    Emblem=Emblem[rownames(Emblem)=="Pungsusa", ], 
                    CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Lara")))


## Lara - Passive
{option <- factor(c("SummonDuration"), levels=PSkill)
value <- c(10)
SpiritIntimacy <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(35)
WandMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("BDR", "CRR"), levels=PSkill)
value <- c(30, 20)
Mugu <- data.frame(option, value)

option <- factor(c("Mastery", "FDR", "ATK"), levels=PSkill)
value <- c(70 + ceiling(LaraBase$PSkillLv/2), 30 + floor(LaraBase$PSkillLv/2), 50 + LaraBase$PSkillLv)
WandExpert <- data.frame(option, value)

option <- factor(c("CRR", "CDMR", "FDR", "IGR"), levels=PSkill)
value <- c(20 + LaraBase$PSkillLv, 20 + LaraBase$PSkillLv, 45 + LaraBase$PSkillLv, 40 + LaraBase$PSkillLv)
Hyean <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(50 + 2 * LaraBase$PSkillLv)
Yuyu <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(LaraCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(LaraCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

LaraPassive <- Passive(list(SpiritIntimacy, WandMastery, PhysicalTraining, Mugu, WandExpert, Hyean, Yuyu, BlinkPassive, RopeConnectPassive))


## Lara - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EarthVeinStatus <- rbind(data.frame(option, value), info) ## 0 : None, 1 : River, 2 : Wind, 3 : Sun, 4 : Random

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EarthVeinRegenDummy <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FreeEarthVeinBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FreeEarthVeinStack <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FreeEarthVeinDummy <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountainStack <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountainDummy <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(20 * (100 + LaraBase$UnionChrs$SummonedDuration + LaraBase$MonsterLife$SummonedDuration + LaraPassive$SummonDuration) / 100, 0, Delay(510, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountain1 <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(20 * (100 + LaraBase$UnionChrs$SummonedDuration + LaraBase$MonsterLife$SummonedDuration + LaraPassive$SummonDuration) / 100, 0, Delay(510, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountain2 <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(20 * (100 + LaraBase$UnionChrs$SummonedDuration + LaraBase$MonsterLife$SummonedDuration + + LaraPassive$SummonDuration) / 100, 0, Delay(510, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountain3 <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(20 * (100 + LaraBase$UnionChrs$SummonedDuration + LaraBase$MonsterLife$SummonedDuration + + LaraPassive$SummonDuration) / 100, 0, Delay(510, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SeedofMountain4 <- rbind(data.frame(option, value), info) 

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WandBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((LaraBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(LaraBase$SkillLv/2))))
info <- c(900 + 30 * LaraBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(18, NA, Delay(450, 2), F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeavingRiverBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(18, NA, Delay(450, 2), F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WhirlwindBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(18, NA, Delay(450, 2), F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SunriseWellBuff <- rbind(data.frame(option, value), info) 

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(120, 600, Delay(420, 2), T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WindSwingBuff <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(25)
info <- c(120, 600, Delay(480, 2), T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SunlightSiteBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(60 + 3 * ceiling(LaraBase$PSkillLv/2), 0, Delay(690, 2), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RiverPuddleBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(60 + 3 * ceiling(LaraBase$PSkillLv/2), 0, Delay(690, 2), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ChillyBleakWindBuff <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(60 + 3 * ceiling(LaraBase$PSkillLv/2), 0, Delay(690, 2), F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SunlightSphereBuff <- rbind(data.frame(option, value), info) 

option <- factor("FDR", levels=BSkill)
value <- c(5)
info <- c(20, 200, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EchoofEarthVein <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "CDMR"), levels=BSkill)
value <- c(15, 30, 10)
info <- c(30, 180, Delay(660, 2), F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ArmfulTree <- rbind(data.frame(option, value), info) 

Useful <- UsefulSkills(LaraCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
UsefulWindBooster <- Useful$UsefulWindBooster
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(GetCoreLv(LaraCore, "OverloadMana")/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10 + GetCoreLv(LaraCore, "BlessofGrandisGoddess"))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(((1.06 + floor(GetCoreLv(LaraCore, "BlessofGrandisGoddess") / 6) / 100) / 1.05 - 1) * 100)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddessEcho <- rbind(data.frame(option, value), info)}

LaraBuff <- list(EarthVeinStatus=EarthVeinStatus, EarthVeinRegenDummy=EarthVeinRegenDummy, 
                 FreeEarthVeinBuff=FreeEarthVeinBuff, FreeEarthVeinStack=FreeEarthVeinStack, FreeEarthVeinDummy=FreeEarthVeinDummy, SeedofMountainStack=SeedofMountainStack, SeedofMountainDummy=SeedofMountainDummy, 
                 SeedofMountain1=SeedofMountain1, SeedofMountain2=SeedofMountain2, SeedofMountain3=SeedofMountain3, SeedofMountain4=SeedofMountain4,
                 WandBooster=WandBooster, MapleSoldier=MapleSoldier, 
                 HeavingRiverBuff=HeavingRiverBuff, WhirlwindBuff=WhirlwindBuff, SunriseWellBuff=SunriseWellBuff, 
                 WindSwingBuff=WindSwingBuff, SunlightSiteBuff=SunlightSiteBuff,
                 EchoofEarthVein=EchoofEarthVein, 
                 RiverPuddleBuff=RiverPuddleBuff, ChillyBleakWindBuff=ChillyBleakWindBuff, SunlightSphereBuff=SunlightSphereBuff, ArmfulTree=ArmfulTree, 
                 UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulWindBooster=UsefulWindBooster, 
                 OverloadMana=OverloadMana, BlessofGrandisGoddess=BlessofGrandisGoddess, BlessofGrandisGoddessEcho=BlessofGrandisGoddessEcho, 
                 Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  LaraBuff[[length(LaraBuff)+1]] <- UsefulAdvancedBless
  names(LaraBuff)[[length(LaraBuff)]] <- "UsefulAdvancedBless"
}
LaraBuff <- Buff(LaraBuff)
## PetBuff : WandBooster, MapleSoldier, UsefulWindBooster, UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
LaraAllTimeBuff <- AllTimeBuff(LaraBuff)


## Lara - Union & HyperStat & SoulWeapon
LaraSpec <- JobSpec(JobBase=LaraBase, 
                    Passive=LaraPassive, 
                    AllTimeBuff=LaraAllTimeBuff, 
                    MobInfo=get(DPMCalcOption$MobSet), 
                    SpecSet=get(DPMCalcOption$SpecSet), 
                    WeaponName="Wand", 
                    UnionStance=0,
                    JobConstant=1.2)

LaraUnionRemained <- LaraSpec$UnionRemained
LaraHyperStatBase <- LaraSpec$HyperStatBase
LaraCoolReduceType <- LaraSpec$CoolReduceType
LaraSpec <- LaraSpec$Spec


## Lara - Spider In Mirror
SIM <- SIMData(GetCoreLv(LaraCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Lara - Attacks
## Hyper : Eruption/Absorb - Reinforce, Eruption/Absorb - Boss Killer, Eruption/Absorb - Ignore Guard, Spirit Seeding - Boss Killer, Earth Vein - Enhance
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(15, ifelse(GetCoreLv(LaraCore, "SpiritSeeding")>=40, 20, 0), 2 * GetCoreLv(LaraCore, "SpiritSeeding"))
info <- c(80 + 50 + 175, 4, 660, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpiritSeeding <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(LaraCore, "MountainKid")>=40, 20, 0), 2 * GetCoreLv(LaraCore, "MountainKid"))
info <- c(105 + 45 + 160 + 5 * LaraSpec$PSkillLv, 3 * 0.7, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MountainKid <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(215 + 120 + 128, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavingRiver <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(580, 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavingRiverHuge <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(63 + 35 + 157, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WhirlWind <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(120 + 48 + 247, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunriseWellGiant <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(85 + 48 + 117, 1, 0, 1000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunriseWellFloor <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c(75 + 48 + 157, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunriseWellVolcanicBomb1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25 + floor(LaraSpec$SummonedDuration / 2), IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinEruption")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinEruption"))
info <- c((75 + 48 + 157) * 0.9, 3 * 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunriseWellVolcanicBomb2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(0, ifelse(GetCoreLv(LaraCore, "SeedofMountain")>=40, 20, 0), 2 * GetCoreLv(LaraCore, "SeedofMountain"))
info <- c(55 + 75 + 170 + 5 * LaraSpec$PSkillLv, 1, 510, 2000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SeedofMountain <- rbind(data.frame(option, value), info) ## StartATK : 2720ms

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(LaraCore, "Awakening")>=40, 20, 0), 2 * GetCoreLv(LaraCore, "Awakening"))
info <- c(105 + 45 + LaraSpec$PSkillLv, 4, 720, 90, Cooldown(11, T, LaraSpec$CoolReduceP, LaraSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Awakening1 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(LaraCore, "Awakening")>=40, 20, 0), 2 * GetCoreLv(LaraCore, "Awakening"))
info <- c((105 + 45 + LaraSpec$PSkillLv) * 0.6, 4, 0, 90, Cooldown(11, T, LaraSpec$CoolReduceP, LaraSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Awakening2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 55 + 2 * LaraSpec$PSkillLv, 2, 120, NA, 6, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EarthVeinTrace <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinAbsorb")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinAbsorb"))
info <- c(500 + LaraSpec$PSkillLv, 6, 0, 0, 2.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RiverPuddle <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinAbsorb")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinAbsorb"))
info <- c(215 + 2 * LaraSpec$PSkillLv, 2, 0, 0, 2.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChillyBleakWind <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, IGRCalc(c(15, ifelse(GetCoreLv(LaraCore, "EarthVeinAbsorb")>=40, 20, 0))), 2 * GetCoreLv(LaraCore, "EarthVeinAbsorb"))
info <- c(200 + 5 * LaraSpec$PSkillLv, 5 * 6, 0, 0, 2.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunlightSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 300, 0, Cooldown(3, T, LaraSpec$CoolReduceP, LaraSpec$CoolReduce) + 7, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EarthVeinSwitch <- rbind(data.frame(option, value), info) ## ATKSpeed Not Applied

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 300, 0, 1.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FreeEarthVein <- rbind(data.frame(option, value), info) ## + EarthVeinSwitch Delay, ATKSpeed Applied

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(LaraCore, "HugeStretch"), 5 * 5, 870, 90, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HugeStretch1 <- rbind(data.frame(option, value), info) ## StartATK : 1980ms

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * GetCoreLv(LaraCore, "HugeStretch")) * 0.7, 5 * 5, 0, 90, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HugeStretch2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(700 + 28 * GetCoreLv(LaraCore, "SunRiverMountWind"), 10, 840, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunRiverMountWind1 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(850 + 34 * GetCoreLv(LaraCore, "SunRiverMountWind"), 15, 0, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SunRiverMountWind2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(425 + 17 * GetCoreLv(LaraCore, "SurgingSpirit"), 8, 630, NA, 20, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SurgingSpirit <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(LaraCore, "RidgeZigzag"), 4 * 3, 960, 390, 60, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RidgeZigzag <- rbind(data.frame(option, value), info) ## Minimum Delay 240ms, StartATK 1440ms
}

LaraATK <- Attack(list(SpiritSeeding=SpiritSeeding, MountainKid=MountainKid, 
                       HeavingRiver=HeavingRiver, HeavingRiverHuge=HeavingRiverHuge, WhirlWind=WhirlWind, SunriseWellGiant=SunriseWellGiant, SunriseWellFloor=SunriseWellFloor, 
                       SunriseWellVolcanicBomb1=SunriseWellVolcanicBomb1, SunriseWellVolcanicBomb2=SunriseWellVolcanicBomb2, 
                       SeedofMountain=SeedofMountain, Awakening1=Awakening1, Awakening2=Awakening2, EarthVeinTrace=EarthVeinTrace, 
                       RiverPuddle=RiverPuddle, ChillyBleakWind=ChillyBleakWind, SunlightSphere=SunlightSphere, 
                       EarthVeinSwitch=EarthVeinSwitch, FreeEarthVein=FreeEarthVein, 
                       HugeStretch1=HugeStretch1, HugeStretch2=HugeStretch2, SunRiverMountWind1=SunRiverMountWind1, SunRiverMountWind2=SunRiverMountWind2, SurgingSpirit=SurgingSpirit, RidgeZigzag=RidgeZigzag, 
                       SpiderInMirror=SpiderInMirror))


## Lara - Summoned
LaraSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                              SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Lara - DealCycle
ATKFinal <- data.frame(LaraATK)
ATKFinal$Delay[c(-17)] <- Delay(ATKFinal$Delay, LaraSpec$ATKSpeed)[c(-17)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, LaraSpec$CoolReduceP, LaraSpec$CoolReduce)

BuffFinal <- data.frame(LaraBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, LaraSpec$CoolReduceP, LaraSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, LaraSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
BuffFinal[rownames(BuffFinal)=="WindSwingBuff", ]$Duration <- BuffFinal[rownames(BuffFinal)=="WindSwingBuff", ]$Duration + 20
BuffFinal[rownames(BuffFinal)=="SunlightSiteBuff", ]$Duration <- BuffFinal[rownames(BuffFinal)=="SunlightSiteBuff", ]$Duration + 20

SummonedFinal <- data.frame(LaraSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, LaraSpec$CoolReduceP, LaraSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * LaraSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(LaraBuff))
LaraDealCycle <- t(rep(0, length(DealCycle)))
colnames(LaraDealCycle) <- DealCycle
LaraDealCycle <- data.frame(LaraDealCycle)

## Seed of Mountain Auto
LaraCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                      Period=c(180), CycleTime=c(720)) {
  BuffSummonedPrior <- c("WandBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster", "UsefulAdvancedBless", 
                         "BlessofGrandisGoddess", "ArmfulTree")
  
  Times180 <- c(1, 0, 0, 0, 0, 0, 
                0.75, 1)
  
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
  
  LaraEarthVein <- function(DealCycle) {
    if(DealCycle$Skills[nrow(DealCycle)]=="FreeEarthVein") {
      DealCycle$FreeEarthVeinStack[nrow(DealCycle)] <- DealCycle$FreeEarthVeinStack[(nrow(DealCycle)-1)] - 1
      DealCycle$FreeEarthVeinBuff[nrow(DealCycle)] <- 100000
    } else {
      DealCycle$FreeEarthVeinStack[nrow(DealCycle)] <- DealCycle$FreeEarthVeinStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$FreeEarthVeinDummy[nrow(DealCycle)-1] >= 0 & DealCycle$FreeEarthVeinDummy[nrow(DealCycle)]==0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] < 3) {
      DealCycle$FreeEarthVeinStack[nrow(DealCycle)] <- DealCycle$FreeEarthVeinStack[nrow(DealCycle)] + 1
      DealCycle$FreeEarthVeinDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 10000, 10000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$FreeEarthVeinDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$FreeEarthVeinStack[nrow(DealCycle)] == 3) {
      DealCycle$FreeEarthVeinDummy[nrow(DealCycle)] <- 10000
    }
    
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4")) >= 1) {
      DealCycle$SeedofMountainStack[nrow(DealCycle)] <- DealCycle$SeedofMountainStack[(nrow(DealCycle)-1)] - 1
    } else {
      DealCycle$SeedofMountainStack[nrow(DealCycle)] <- DealCycle$SeedofMountainStack[(nrow(DealCycle)-1)]
    }
    
    if(DealCycle$SeedofMountainDummy[nrow(DealCycle)-1] >= 0 & DealCycle$SeedofMountainDummy[nrow(DealCycle)]==0 & DealCycle$SeedofMountainStack[nrow(DealCycle)] < 4) {
      DealCycle$SeedofMountainStack[nrow(DealCycle)] <- DealCycle$SeedofMountainStack[nrow(DealCycle)] + 1
      DealCycle$SeedofMountainDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 7000, 7000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$SeedofMountainDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$SeedofMountainStack[nrow(DealCycle)] == 4) {
      DealCycle$SeedofMountainDummy[nrow(DealCycle)] <- 7000
    }
    
    if(DealCycle$EarthVeinRegenDummy[nrow(DealCycle)-1] >= 0 & DealCycle$EarthVeinRegenDummy[nrow(DealCycle)]==0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 0) {
      DealCycle$EarthVeinStatus[nrow(DealCycle)] <- 4
      DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 4000, 4000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$EarthVeinRegenDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$EarthVeinStatus[nrow(DealCycle)-1] == 4) {
      DealCycle$EarthVeinStatus[nrow(DealCycle)] <- DealCycle$EarthVeinStatus[nrow(DealCycle)-1]
      DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] <- 4000
    } else {
      DealCycle$EarthVeinStatus[nrow(DealCycle)] <- DealCycle$EarthVeinStatus[nrow(DealCycle)-1]
    }
    
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("HeavingRiverBuff", "WhirlwindBuff", "SunriseWellBuff", 
                                                "WindSwingBuff", "SunlightSiteBuff", 
                                                "SunlightSphereBuff", "RiverPuddleBuff", "ChillyBleakWindBuff", 
                                                "Awakening1", "HugeStretch1")) >= 1) {
      DealCycle$EchoofEarthVein[nrow(DealCycle)] <- BuffFinal[rownames(BuffFinal)=="EchoofEarthVein", ]$Duration * 1000
      if(DealCycle$FreeEarthVeinBuff[nrow(DealCycle)] > 0) {
        DealCycle$FreeEarthVeinBuff[nrow(DealCycle)] <- 0
      } else {
        DealCycle$EarthVeinStatus[nrow(DealCycle)] <- 0
      }
    }
    return(DealCycle)
  }
  SeedofMountain <- function(DealCycle, Cancel=F) {
    if(DealCycle$SeedofMountain1[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$SeedofMountainStack[nrow(DealCycle)] >= 1) {
      DealCycle <- DCBuff(DealCycle, "SeedofMountain1", BuffFinal)
    } else if(DealCycle$SeedofMountain2[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$SeedofMountainStack[nrow(DealCycle)] >= 1) {
      DealCycle <- DCBuff(DealCycle, "SeedofMountain2", BuffFinal)
    } else if(DealCycle$SeedofMountain3[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$SeedofMountainStack[nrow(DealCycle)] >= 1) {
      DealCycle <- DCBuff(DealCycle, "SeedofMountain3", BuffFinal)
    } else if(DealCycle$SeedofMountain4[nrow(DealCycle)] - DealCycle$Time[1] <= 0 & DealCycle$SeedofMountainStack[nrow(DealCycle)] >= 1) {
      DealCycle <- DCBuff(DealCycle, "SeedofMountain4", BuffFinal)
    }
    
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1 & Cancel==T) {
      DealCycle[1, 2:ncol(DealCycle)] <- 0
    }
    return(DealCycle)
  }
  
  DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
  DealCycle$EarthVeinStatus[nrow(DealCycle)] <- 3
  DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] <- 4000
  DealCycle$FreeEarthVeinStack[nrow(DealCycle)] <- 3
  DealCycle$FreeEarthVeinDummy[nrow(DealCycle)] <- 10000
  DealCycle$SeedofMountainStack[nrow(DealCycle)] <- 4
  DealCycle$SeedofMountainDummy[nrow(DealCycle)] <- 7000
  
  DealCycle <- DCBuff(DealCycle, "SunlightSiteBuff", BuffFinal)
  DealCycle <- LaraEarthVein(DealCycle)
  DealCycle$EarthVeinStatus[nrow(DealCycle)] <- 0
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- LaraEarthVein(DealCycle)
      if(BuffList[[1]][i]=="UsefulWindBooster") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- LaraEarthVein(DealCycle)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- LaraEarthVein(DealCycle)
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
  AWCool <- subset(ATKFinal, rownames(ATKFinal)=="Awakening1")$CoolTime * 1000
  RGCool <- subset(ATKFinal, rownames(ATKFinal)=="RidgeZigzag")$CoolTime * 1000
  SSCool <- subset(ATKFinal, rownames(ATKFinal)=="SurgingSpirit")$CoolTime * 1000
  FECool <- subset(ATKFinal, rownames(ATKFinal)=="FreeEarthVein")$CoolTime * 1000
  ESCool <- subset(ATKFinal, rownames(ATKFinal)=="EarthVeinSwitch")$CoolTime * 1000
  SCCool <- subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000

  AWRemain <- 0 ; RGRemain <- 0 ; SSRemain <- 0 ; FERemain <- 0 ; SCRemain <- 0
  ESRemain <- ESCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1])
  
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
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FERemain - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
      }
      ## Revelation : Sunlight Site Buff
      if(DealCycle$SunlightSiteBuff[nrow(DealCycle)] < 2000 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & 
         DealCycle$Time[nrow(DealCycle)] + DealCycle$SunlightSiteBuff[nrow(DealCycle)] < TotalTime | 
         DealCycle$SunlightSiteBuff[nrow(DealCycle)] < 2000 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & 
         DealCycle$Time[nrow(DealCycle)] + DealCycle$SunlightSiteBuff[nrow(DealCycle)] < TotalTime) {
        if(DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0) {
          DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FECool - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
        
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        if(DealCycle$Skills[nrow(DealCycle)-1]=="FreeEarthVein") {
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        } else {
          ESRemain <- max(0, ESCool - DealCycle$Time[1])
        }
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "SunlightSiteBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Absorb : Sunlight Sphere Buff
      else if(DealCycle$SunlightSphereBuff[nrow(DealCycle)] < 5000 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k != length(BuffList) | 
              DealCycle$SunlightSphereBuff[nrow(DealCycle)] < 5000 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k == length(BuffList) &
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESCool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "SunlightSphereBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      else if(DealCycle$SunlightSphereBuff[nrow(DealCycle)] < 5000 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k != length(BuffList) | 
              DealCycle$SunlightSphereBuff[nrow(DealCycle)] < 5000 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k == length(BuffList) & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((3 - DealCycle$FreeEarthVeinStack[nrow(DealCycle)]) * 10000 + DealCycle$FreeEarthVeinDummy[nrow(DealCycle)]) < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FECool - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCBuff(DealCycle, "SunlightSphereBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Eruption : Whirlwind Buff
      else if(DealCycle$WhirlwindBuff[nrow(DealCycle)] == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k != length(BuffList) | 
              DealCycle$WhirlwindBuff[nrow(DealCycle)] == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k == length(BuffList) &
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESCool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        ## if(sum(BuffList[[k]]=="ArmfulTree") == 0 | 
        ##   sum(BuffList[[k]]=="ArmfulTree") > 0 & 
        ##   DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)]) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) < BuffStartTime) {
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
        ## }
        
        DealCycle <- DCBuff(DealCycle, "WhirlwindBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      else if(DealCycle$WhirlwindBuff[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k != length(BuffList) | 
              DealCycle$WhirlwindBuff[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k == length(BuffList) &
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((3 - DealCycle$FreeEarthVeinStack[nrow(DealCycle)]) * 10000 + DealCycle$FreeEarthVeinDummy[nrow(DealCycle)]) < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FECool - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        ## if(sum(BuffList[[k]]=="ArmfulTree") == 0 | 
        ##   sum(BuffList[[k]]=="ArmfulTree") > 0 & 
        ##   DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)]) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) < BuffStartTime) {
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
        ## }
        
        DealCycle <- DCBuff(DealCycle, "WhirlwindBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Eruption : Heaving River Buff
      else if(DealCycle$HeavingRiverBuff[nrow(DealCycle)] == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k != length(BuffList) | 
              DealCycle$HeavingRiverBuff[nrow(DealCycle)] == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & ESRemain == 0 & k == length(BuffList) &
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESCool - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        ## if(sum(BuffList[[k]]=="ArmfulTree") == 0 | 
        ##   sum(BuffList[[k]]=="ArmfulTree") > 0 & 
        ##   DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)]) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) < BuffStartTime) {
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
        ## }
        
        DealCycle <- DCBuff(DealCycle, "HeavingRiverBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      else if(DealCycle$HeavingRiverBuff[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k != length(BuffList) | 
              DealCycle$HeavingRiverBuff[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k == length(BuffList) &
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((3 - DealCycle$FreeEarthVeinStack[nrow(DealCycle)]) * 10000 + DealCycle$FreeEarthVeinDummy[nrow(DealCycle)]) < BuffStartTime) {
        DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FECool - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        DealCycle <- DCATK(DealCycle, "EarthVeinSwitch", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        ## if(sum(BuffList[[k]]=="ArmfulTree") == 0 | 
        ##   sum(BuffList[[k]]=="ArmfulTree") > 0 & 
        ##   DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)]) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) < BuffStartTime) {
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
          
          DealCycle <- SeedofMountain(DealCycle, Cancel=T)
          if(sum(DealCycle$Skills[nrow(DealCycle)]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))==1) {
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
        ## }
        
        DealCycle <- DCBuff(DealCycle, "HeavingRiverBuff", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Seed of Mountain Buff
      ## else if(sum(c(DealCycle$SeedofMountain1[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain2[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain3[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain4[nrow(DealCycle)] - DealCycle$Time[1] <= 0)) >= 1 & DealCycle$SeedofMountainStack[nrow(DealCycle)] > 0 & sum(BuffList[[k]]=="ArmfulTree") == 0 | 
      ##        sum(c(DealCycle$SeedofMountain1[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain2[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain3[nrow(DealCycle)] - DealCycle$Time[1] <= 0, 
      ##              DealCycle$SeedofMountain4[nrow(DealCycle)] - DealCycle$Time[1] <= 0)) >= 1 & DealCycle$SeedofMountainStack[nrow(DealCycle)] > 0 & sum(BuffList[[k]]=="ArmfulTree") > 0 & 
      ##        DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)]) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) < BuffStartTime) {
      ##  DealCycle <- SeedofMountain(DealCycle)
      ##  AWRemain <- max(0, AWRemain - DealCycle$Time[1])
      ##  RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      ##  SSRemain <- max(0, SSRemain - DealCycle$Time[1])
      ##  FERemain <- max(0, FERemain - DealCycle$Time[1])
      ##  ESRemain <- max(0, ESRemain - DealCycle$Time[1])
      ##  SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      ##  DealCycle <- LaraEarthVein(DealCycle)
      ## }
      ## Soul Contract
      else if(SCRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="ArmfulTree")) * 2 > nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink"))) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Ridge Zigzag, Restraint4, Huge Stretch, Sun River Mount Wind
      else if(RGRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="ArmfulTree")) * 3 > nrow(subset(DealCycle, DealCycle$Skills=="RidgeZigzag")) & 
              DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 | 
              RGRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="ArmfulTree")) * 3 > nrow(subset(DealCycle, DealCycle$Skills=="RidgeZigzag")) & 
              DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] <= 720 | 
              RGRemain == 0 & nrow(subset(DealCycle, DealCycle$Skills=="ArmfulTree")) * 3 > nrow(subset(DealCycle, DealCycle$Skills=="RidgeZigzag")) & 
              DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain <= 720) {
        DealCycle <- DCATK(DealCycle, "RidgeZigzag", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGCool - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        if(nrow(subset(DealCycle, DealCycle$Skills=="ArmfulTree")) > nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))) {
          DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FERemain - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
        
        if(DealCycle$EarthVeinStatus[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0) {
          DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FECool - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
        
        DealCycle <- DCATK(DealCycle, "HugeStretch1", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
        
        if(nrow(subset(DealCycle, DealCycle$Skills=="Restraint4")) > nrow(subset(DealCycle, DealCycle$Skills=="SunRiverMountWind1"))) {
          DealCycle <- DCATK(DealCycle, "SunRiverMountWind1", ATKFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FERemain - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
      }
      ## Surging Spirit
      else if(SSRemain == 0 & sum(BuffList[[k]]=="ArmfulTree") == 0 | 
              SSRemain == 0 & sum(BuffList[[k]]=="ArmfulTree") > 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + SSCool < BuffStartTime + 5000) {
        DealCycle <- DCATK(DealCycle, "SurgingSpirit", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSCool - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
      ## Awakening
      ##  else if(AWRemain == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & k != length(BuffList) & 
      ##          DealCycle$WhirlwindBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 & DealCycle$HeavingRiverBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 | 
      ##          AWRemain == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k != length(BuffList) & 
      ##          DealCycle$WhirlwindBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 & DealCycle$HeavingRiverBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 | 
      ##          AWRemain == 0 & DealCycle$EarthVeinStatus[nrow(DealCycle)] == 4 & k == length(BuffList) & 
      ##          DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + DealCycle$EarthVeinRegenDummy[nrow(DealCycle)] < BuffStartTime & 
      ##          DealCycle$WhirlwindBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000  & DealCycle$HeavingRiverBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 | 
      ##          AWRemain == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0 & FERemain == 0 & k==length(BuffList) & 
      ##          DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + ((3 - DealCycle$FreeEarthVeinStack[nrow(DealCycle)]) * 10000 + DealCycle$FreeEarthVeinDummy[nrow(DealCycle)]) < BuffStartTime &
      ##          DealCycle$WhirlwindBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000 & DealCycle$HeavingRiverBuff[nrow(DealCycle)] - DealCycle$Time[1] > 4000) {
      ##    if(DealCycle$EarthVeinStatus[nrow(DealCycle)] == 0 & DealCycle$FreeEarthVeinStack[nrow(DealCycle)] > 0) {
      ##      DealCycle <- DCATK(DealCycle, "FreeEarthVein", ATKFinal)
      ##      AWRemain <- max(0, AWRemain - DealCycle$Time[1])
      ##      RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      ##      SSRemain <- max(0, SSRemain - DealCycle$Time[1])
      ##      FERemain <- max(0, FECool - DealCycle$Time[1])
      ##      ESRemain <- max(0, ESRemain - DealCycle$Time[1])
      ##      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      ##      DealCycle <- LaraEarthVein(DealCycle)
      ##    }
      ##    
      ##    DealCycle <- DCATK(DealCycle, "Awakening1", ATKFinal)
      ##    AWRemain <- max(0, AWCool - DealCycle$Time[1])
      ##    RGRemain <- max(0, RGRemain - DealCycle$Time[1])
      ##    SSRemain <- max(0, SSRemain - DealCycle$Time[1])
      ##    FERemain <- max(0, FERemain - DealCycle$Time[1])
      ##    ESRemain <- max(0, ESRemain - DealCycle$Time[1])
      ##    SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      ##    DealCycle <- LaraEarthVein(DealCycle)
      ##  }
      ## Spirit Seeding
      else {
        DealCycle <- DCATK(DealCycle, "SpiritSeeding", ATKFinal)
        AWRemain <- max(0, AWRemain - DealCycle$Time[1])
        RGRemain <- max(0, RGRemain - DealCycle$Time[1])
        SSRemain <- max(0, SSRemain - DealCycle$Time[1])
        FERemain <- max(0, FERemain - DealCycle$Time[1])
        ESRemain <- max(0, ESRemain - DealCycle$Time[1])
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        DealCycle <- LaraEarthVein(DealCycle)
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FERemain - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
          
          if(BuffList[[k]][i]=="BlessofGrandisGoddess") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            AWRemain <- max(0, AWRemain - DealCycle$Time[1])
            RGRemain <- max(0, RGRemain - DealCycle$Time[1])
            SSRemain <- max(0, SSRemain - DealCycle$Time[1])
            FERemain <- max(0, FERemain - DealCycle$Time[1])
            ESRemain <- max(0, ESRemain - DealCycle$Time[1])
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            DealCycle <- LaraEarthVein(DealCycle)
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          AWRemain <- max(0, AWRemain - DealCycle$Time[1])
          RGRemain <- max(0, RGRemain - DealCycle$Time[1])
          SSRemain <- max(0, SSRemain - DealCycle$Time[1])
          FERemain <- max(0, FERemain - DealCycle$Time[1])
          ESRemain <- max(0, ESRemain - DealCycle$Time[1])
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          DealCycle <- LaraEarthVein(DealCycle)
        }
      }
    }
  }
  while(((4 - DealCycle$SeedofMountainStack[nrow(DealCycle)] - 1) * 7000 + DealCycle$SeedofMountainDummy[nrow(DealCycle)]) - DealCycle$Time[1] >= min(subset(DealCycle, DealCycle$Skills=="SeedofMountain1")$Time)) {
    DealCycle <- DCATK(DealCycle, "SpiritSeeding", ATKFinal)
    AWRemain <- max(0, AWRemain - DealCycle$Time[1])
    RGRemain <- max(0, RGRemain - DealCycle$Time[1])
    SSRemain <- max(0, SSRemain - DealCycle$Time[1])
    FERemain <- max(0, FERemain - DealCycle$Time[1])
    ESRemain <- max(0, ESRemain - DealCycle$Time[1])
    SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    DealCycle <- LaraEarthVein(DealCycle)
  }
  
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
LaraAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Mountain Kid
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SpiritSeeding")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "MountainKid"
    }
  }  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  print("Mountain Kid Done")
  
  
  ## Seed of Mountain
  SeedoMountainATKTimes <- ceiling((BuffFinal[rownames(BuffFinal)=="SeedofMountain1", ]$Duration - 2.72) * 1000 / 2000)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SeedofMountain1", "SeedofMountain2", "SeedofMountain3", "SeedofMountain4"))>=1) {
      DealCycle$Skills[i] <- "SeedofMountain"
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "SeedofMountain", SeedoMountainATKTimes, 2720, ATKFinal)
  print("Seed of Mountain Done")
  
  
  ## Eruption : Whirlwind
  WhirlWindTime <- c(seq(1560, 1560 + 480 * 3, 480))
  for(i in 1:4) {
    WhirlWindTime <- c(WhirlWindTime, WhirlWindTime[1:4] + 3120 * i)
  }
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="WhirlwindBuff") {
      for(j in 1:length(WhirlWindTime)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "WhirlWind"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + WhirlWindTime[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="WhirlWind") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Eruption : Whirlwind Done")
  
  
  ## Eruption : HeavingRiver
  HeavingRiverTime <- c(1170, 3170, 5530, 7530, 9530, 11890, 13890, 15890, 17250)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HeavingRiverBuff") {
      for(j in c(3, 6, 9)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "HeavingRiverHuge"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HeavingRiverTime[j]
      }
      for(k in c(1, 2, 4, 5, 7, 8)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "HeavingRiver"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HeavingRiverTime[k]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("HeavingRiver", "HeavingRiverHuge")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Eruption : Heaving River Done")
  
  
  ## Awakening
  DealCycle$Skills[DealCycle$Skills=="Awakening1"] <- "AwakeningStart"
  AwakeningTime <- c(seq(1500, 1500 + 90 * 6, 90))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="AwakeningStart") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Awakening1"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + AwakeningTime[1]
      for(j in 2:length(AwakeningTime)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "Awakening2"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + AwakeningTime[j]
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Awakening1", "Awakening2")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Awakening Done")
  
  
  ## Huge Stretch
  DealCycle$Skills[DealCycle$Skills=="HugeStretch1"] <- "HugeStretchStart"
  HugeStretchTime <- c(seq(1980, 1980 + 90 * 6, 90))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="HugeStretchStart") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "HugeStretch1"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HugeStretchTime[1]
      for(j in 2:length(HugeStretchTime)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "HugeStretch2"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + HugeStretchTime[j]
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("HugeStretch1", "HugeStretch2")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Huge Stretch Done")
  
  
  ## Sun River Mount Wind
  DealCycle$Skills[DealCycle$Skills=="SunRiverMountWind1"] <- "SunRiverMountWindStart"
  SunRiverMountWindTime <- c(1260, 1260, 1260, 1590, 1620, 1650, 2280, 2310, 2340, 3180, 3210, 3240, 
                             seq(5880, 5880 + 30 * 6, 30))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SunRiverMountWindStart") {
      for(j in 1:12) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "SunRiverMountWind1"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + SunRiverMountWindTime[j]
      }
      for(k in 13:19) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "SunRiverMountWind2"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + SunRiverMountWindTime[k]
      }
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SunRiverMountWind1", "SunRiverMountWind2")) >= 1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Sun River Mount Wind Done")
  
  
  ## Surging Spirit
  DealCycle$Skills[DealCycle$Skills=="SurgingSpirit"] <- "SurgingSpiritStart"
  SurgingSpiritTime <- c(180, 360, 1260, 1380, 1500)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SurgingSpiritStart") {
      for(j in 1:length(SurgingSpiritTime)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "SurgingSpirit"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + SurgingSpiritTime[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SurgingSpirit") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Surging Spirit Done")
  
  
  ## Ridge Zigzag
  DealCycle <- RepATKCycle(DealCycle, "RidgeZigzag", 20, 1440, ATKFinal)
  print("Ridge Zigzag Done")
  
  
  ## Absorb : Sunlight Sphere
  SS <- subset(DealCycle, DealCycle$Skills=="SunlightSphereBuff")
  Ind <- rownames(SS)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 2501
    while(p < Ind[i+1] & DealCycle$SunlightSphereBuff[p] > 0) {
      if(time > 2500 & max(DealCycle$Skills[p]==c("SpiritSeeding"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("SunlightSphere")
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
  print("Absorb : Sunlight Sphere Done")
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  print("Spider In Mirror Done")
  
  
  ## Bless of Grandis Goddess (Echo of Earth Vein)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$BlessofGrandisGoddess[i] > 0 & DealCycle$EchoofEarthVein[i] > 0) {
      DealCycle$BlessofGrandisGoddessEcho[i] <- DealCycle$EchoofEarthVein[i]
    }
  }
  print("Bless of Grandis Goddess Done")
  
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SpiderInMirror", "SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait", "MountainKid")) == 0) {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  print("Overload Mana Done")
  
  
  ## Dummy Reduction
  DealCycle$EarthVeinStatus <- 0
  DealCycle$EarthVeinRegenDummy <- 0
  DealCycle$FreeEarthVeinBuff <- 0
  DealCycle$FreeEarthVeinStack <- 0
  DealCycle$FreeEarthVeinDummy <- 0
  DealCycle$SeedofMountainStack <- 0
  DealCycle$SeedofMountainDummy <- 0
  DealCycle$SeedofMountain1 <- 0
  DealCycle$SeedofMountain2 <- 0
  DealCycle$SeedofMountain3 <- 0
  DealCycle$SeedofMountain4 <- 0
  
  return(DealCycle)
}

LaraDealCycle <- LaraCycle(LaraDealCycle, 
                           ATKFinal, 
                           BuffFinal, 
                           SummonedFinal, 
                           LaraSpec, 
                           Period=180, CycleTime=720)
LaraDealCycle <- DealCycleFinal(LaraDealCycle)
LaraDealCycle <- LaraAddATK(LaraDealCycle, 
                            ATKFinal, 
                            BuffFinal, 
                            SummonedFinal, 
                            LaraSpec)
LaraDealCycleReduction <- DealCycleReduction(LaraDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Lara") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  LaraSpecOpt1 <- Optimization1(LaraDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, LaraSpec, LaraUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- LaraSpecOpt1[1, 1:3]
} else {
  LaraSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
LaraSpecOpt <- OptDataAdd(LaraSpec, LaraSpecOpt1, "Potential", LaraBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  LaraSpecOpt2 <- Optimization2(LaraDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, LaraSpecOpt, LaraHyperStatBase, LaraBase$ChrLv, LaraBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- LaraSpecOpt2[1, ]
} else {
  LaraSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
LaraSpecOpt <- OptDataAdd(LaraSpecOpt, LaraSpecOpt2, "HyperStat", LaraBase$CRROver, DemonAvenger=F)

LaraFinalDPM <- DealCalc(LaraDealCycle, ATKFinal, BuffFinal, SummonedFinal, LaraSpecOpt, Collapse=F)
LaraFinalDPMwithMax <- DealCalcWithMaxDMR(LaraDealCycle, ATKFinal, BuffFinal, SummonedFinal, LaraSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Lara", sum(na.omit(LaraFinalDPMwithMax)) / (max(LaraDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Lara", sum(na.omit(LaraFinalDPM)) / (max(LaraDealCycle$Time) / 60000) - sum(na.omit(LaraFinalDPMwithMax)) / (max(LaraDealCycle$Time) / 60000))

LaraDealRatio <- DealRatio(LaraDealCycle, LaraFinalDPMwithMax)

LaraDealData <- data.frame(LaraDealCycle$Skills, LaraDealCycle$Time, LaraDealCycle$Restraint4, LaraFinalDPMwithMax)
colnames(LaraDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Lara", Deal_RR(LaraDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Lara", Deal_40s(LaraDealData))

LaraSpecMean <- SpecMean("Lara", LaraDealCycleReduction, 
                         DealCalcWithMaxDMR(LaraDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, LaraSpecOpt), 
                         ATKFinal, BuffFinal, SummonedFinal, LaraSpecOpt)