## Bishop - Data
## Bishop - VMatrix
BishopCoreBase <- CoreBuilder(ActSkills=c("Pray", "AngelofLibra", "PeaceMaker", "DivinePunishment", 
                                          CommonV("Wizard", "Adventure")), 
                              ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                              UsefulSkills=c("CombatOrders", "SharpEyes"), 
                              SpecSet=get(DPMCalcOption$SpecSet), 
                              VPassiveList=BishopVPassive, 
                              VPassivePrior=BishopVPrior, 
                              SelfBind=F)

BishopCore <- MatrixSet(PasSkills=BishopCoreBase$PasSkills$Skills, 
                        PasLvs=BishopCoreBase$PasSkills$Lv, 
                        PasMP=BishopCoreBase$PasSkills$MP, 
                        ActSkills=BishopCoreBase$ActSkills$Skills, 
                        ActLvs=BishopCoreBase$ActSkills$Lv, 
                        ActMP=BishopCoreBase$ActSkills$MP, 
                        UsefulSkills=BishopCoreBase$UsefulSkills, 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        SpecialCore=BishopCoreBase$SpecialCoreUse)


## Bishop - Basic Info
BishopBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      Job="Bishop",
                      CoreData=BishopCore, 
                      BuffDurationNeeded=310, 
                      AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Bishop"), 
                      LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Bishop"), 
                      MonsterLife=get(FindJob(MonsterLifePreSet, "Bishop")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                      Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                      WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                      SubWeapon=SubWeapon[rownames(SubWeapon)=="BishopGrimoire", ], 
                      Emblem=Emblem[rownames(Emblem)=="MapleLeaf", ], 
                      CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Bishop")))

## Bishop - Passive
{option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
MPIncrease <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
MagicAcceleration <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 13)
MagicCritical <- data.frame(option, value)

option <- factor(c("CRR", "Mastery"), levels=PSkill)
value <- c(40, 70)
HolyFocus <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(10)
AngelRayDebuff <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(3 * General$General$PartyMembers)
BlessingHarmony <- data.frame(option, value)

option <- factor(c("ATK", "BuffDuration"), levels=PSkill)
value <- c(30 + 3 * BishopBase$SkillLv, 50 + 5 * BishopBase$SkillLv)
MasterMagic <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(20 + ceiling(BishopBase$SkillLv/2), 40)
ArcaneAim <- data.frame(option, value)

option <- factor(c("ATK", "IGR", "FDR", "ImmuneIgnore"), levels=PSkill)
value <- c(50, 20, 30, 10)
VengenceofAngel <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(BishopCore, "UnstableMemorize"))
UnstableMemorizePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(BishopCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(BishopCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

BishopPassive <- Passive(list(MPIncrease=MPIncrease, MagicAcceleration=MagicAcceleration, SpellMastery=SpellMastery, HighWisdom=HighWisdom, MagicCritical=MagicCritical, HolyFocus=HolyFocus, AngelRayDebuff=AngelRayDebuff, 
                              BlessingHarmony=BlessingHarmony, MasterMagic=MasterMagic, ArcaneAim=ArcaneAim, VengenceofAngel=VengenceofAngel, UnstableMemorizePassive=UnstableMemorizePassive, BlinkPassive=BlinkPassive, 
                              RopeConnectPassive=RopeConnectPassive))


## Bishop - Buff
{option <- factor(c("IGR"), levels=BSkill)
value <- c(44)
info <- c(60, 61, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelicTouchDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(120, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TriumphFeatherBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + BishopBase$SkillLv, 180, 600, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Infinity <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "BDR"), levels=BSkill)
value <- c(50 + BishopBase$SkillLv, 10)
info <- c(240, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AdvancedBless <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((BishopBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(BishopBase$SkillLv/2))))
info <- c(900 + 30 * BishopBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 300, 270, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HolyBlood <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EpicAdventure <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(BishopCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + floor(GetCoreLv(BishopCore, "Pray")/2), 180, 360, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Pray <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(14 + floor(GetCoreLv(BishopCore, "PeaceMaker")/5))
info <- c(8, 20, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerBuff <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * GetCoreLv(BishopCore, "MapleWarriors2")) * MapleSoldier[1, 2]) * BishopBase$MainStatP), 5 + floor(GetCoreLv(BishopCore, "MapleWarriors2")/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(25)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BahamutDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(4, 0, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10)
info <- c(1, 3.03, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Stat <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HolyBloodFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PrayFDR <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraBDR <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor(WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Staff", get(DPMCalcOption$SpecSet)$WeaponType)[6] * 4 * BishopBase$MainStatP))
info <- c(15, 180, 30, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponPuff4 <- rbind(data.frame(option, value), info)}

BishopBuff <- Buff(list(AngelicTouchDebuff=AngelicTouchDebuff, TriumphFeatherBuff=TriumphFeatherBuff, Infinity=Infinity, AdvancedBless=AdvancedBless, MapleSoldier=MapleSoldier, 
                        HolyBlood=HolyBlood, EpicAdventure=EpicAdventure,
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Pray=Pray, PeaceMakerBuff=PeaceMakerBuff, 
                        BahamutDebuff=BahamutDebuff, AngelofLibraBuff=AngelofLibraBuff, AngelofLibraDebuff=AngelofLibraDebuff, MapleWarriors2=MapleWarriors2, 
                        Stat=Stat, HolyBloodFDR=HolyBloodFDR, PrayFDR=PrayFDR, AngelofLibraBDR=AngelofLibraBDR, 
                        Restraint4=Restraint4, WeaponPuff4=WeaponPuff4, SoulContractLink=SoulContractLink))
## PetBuff : TriumphFeather(900ms), AdvancedBless(600ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms)
BishopAllTimeBuff <- AllTimeBuff(BishopBuff)


## Bishop - Union & HyperStat & SoulWeapon
BishopSpec <- JobSpec(JobBase=BishopBase, 
                      Passive=BishopPassive, 
                      AllTimeBuff=BishopAllTimeBuff, 
                      MobInfo=get(DPMCalcOption$MobSet), 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      WeaponName="Staff", 
                      UnionStance=0, 
                      JobConstant=1.2)

BishopUnionRemained <- BishopSpec$UnionRemained
BishopHyperStatBase <- BishopSpec$HyperStatBase
BishopCoolReduceType <- BishopSpec$CoolReduceType
BishopSpec <- BishopSpec$Spec


## Bishop - Spider In Mirror
SIM <- SIMData(GetCoreLv(BishopCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Bishop - Attacks
{option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(4 * GetCoreLv(BishopCore, "Heal_AngelicTouch"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "Heal_AngelicTouch")>=40, 20, 0))
info <- c(350, 5, 780, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelicTouch <- rbind(data.frame(option, value), info)
  
option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "Genesis_TriumphFeather"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "Genesis_TriumphFeather")>=40, 20, 0))
info <- c(200, 4 * 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TriumphFeather <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "AngelRay"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "AngelRay")>=40, 20, 0))
info <- c(225 + 5 * BishopSpec$SkillLv, 14, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelRay <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "Genesis_TriumphFeather"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "Genesis_TriumphFeather")>=40, 20, 0))
info <- c(405 + 5 * BishopSpec$SkillLv, 12, 810, NA, 45, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Genesis <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(FDRCalc(c(2 * GetCoreLv(BishopCore, "HeavensDoor_FountainforAngel"), floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)), ifelse(GetCoreLv(BishopCore, "HeavensDoor_FountainforAngel")>=40, 20, 0))
info <- c(1000, 8, 360, NA, 90, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HeavensDoor <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(350 + 14 * GetCoreLv(BishopCore, "PeaceMaker"), 4, 750, 350, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMaker <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(500 + 20 * GetCoreLv(BishopCore, "PeaceMaker"), 8, 0, NA, 10, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PeaceMakerExplosion <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentPre <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10, 240, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishment <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(225 + 9 * GetCoreLv(BishopCore, "DivinePunishment"), 10, 120, NA, 8.5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DivinePunishmentEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 870, NA, 435 - 3 * GetCoreLv(BishopCore, "UnstableMemorize"), F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UnstableMemorize <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 5000, F, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AngelofLibraBuffDummy <- rbind(data.frame(option, value), info)}

BishopATK <- Attack(list(AngelicTouch=AngelicTouch, TriumphFeather=TriumphFeather, AngelRay=AngelRay, Genesis=Genesis, HeavensDoor=HeavensDoor,
                         PeaceMaker=PeaceMaker, PeaceMakerExplosion=PeaceMakerExplosion, DivinePunishmentPre=DivinePunishmentPre, DivinePunishment=DivinePunishment, DivinePunishmentEnd=DivinePunishmentEnd,
                         UnstableMemorize=UnstableMemorize, AngelofLibraBuffDummy=AngelofLibraBuffDummy, SpiderInMirror=SpiderInMirror))


## Bishop - Summoned
{option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * GetCoreLv(BishopCore, "HeavensDoor_FountainforAngel"), ifelse(GetCoreLv(BishopCore, "HeavensDoor_FountainforAngel")>=40, 20, 0))
info <- c(160, 5, 960, 2010, 60, 30, T, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
FountainforAngel <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=SSkill)
value <- c(2 * GetCoreLv(BishopCore, "Bahamut"), ifelse(GetCoreLv(BishopCore, "Bahamut")>=40, 20, 0))
info <- c(170 + 2 * BishopSpec$SkillLv, 3, 0, 3030, 260, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Bahamut <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=SSkill)
value <- c(floor(GetCoreLv(BishopCore, "OverloadMana") / 10) + 8)
info <- c(500 + 20 * GetCoreLv(BishopCore, "AngelofLibra"), 10, 540, 3030, 30, 180, F, T, T, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
AngelofLibra <- rbind(data.frame(option, value), info)}

BishopSummoned <- Summoned(list(FountainforAngel=FountainforAngel, Bahamut=Bahamut, AngelofLibra=AngelofLibra, SpiderInMirrorStart=SpiderInMirrorStart,
                                SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Bishop - DealCycle
ATKFinal <- data.frame(BishopATK)
ATKFinal$Delay[c(-5, -8, -9, -10, -11)] <- Delay(ATKFinal$Delay, BishopSpec$ATKSpeed)[c(-5, -8, -9, -10, -11)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)

BuffFinal <- data.frame(BishopBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, BishopSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(BishopSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, BishopSpec$CoolReduceP, BishopSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * BishopSpec$SummonedDuration / 100, 0)


## Unstable Memorize Data
UnstableCoolReduceProb <- c(1, 5, 10, 35, 15, 10, 5, 5, 5, 5, 3, 1)
UnstableCoolReduceP <- c(20, 25, 30, 35, 40, 45, 50, 55, 60, 70, 75, 80)

UnstableCool <- c()
for(i in 1:length(UnstableCoolReduceP)) {
  UnstableCool <- c(UnstableCool, ATKFinal[rownames(ATKFinal)=="UnstableMemorize", ]$CoolTime * ((100 - UnstableCoolReduceP[i]) / 100) * ((100 - BishopSpec$CoolReduceP) / 100) - BishopSpec$CoolReduce)
}
UnstableCool <- UnstableCool[UnstableCool > BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2]
UnstableCool <- c(UnstableCool, BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 2)
UnstableProb <- UnstableCoolReduceProb[1:(length(UnstableCool)-1)] / 100
UnstableProb <- c(UnstableProb, 1 - sum(UnstableProb))
UnstableCycleNames <- c()
UnstableDealDataNames <- c()
for(i in 1:length(UnstableCool)) {
  UnstableCycleNames <- c(UnstableCycleNames, paste("BishopDealCycle", i, sep=""))
  UnstableDealDataNames <- c(UnstableDealDataNames, paste("BishopDealData", i, sep=""))
}
UnstableCycles <- data.frame(Cool = UnstableCool, 
                             Prob = UnstableProb, 
                             CycleNames = UnstableCycleNames, 
                             DealDatas = UnstableDealDataNames, 
                             CycleTimes = rep(0, length(UnstableCool)), 
                             stringsAsFactors = F)


BishopCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, UnstableCool) {
  DealCycle <- DCBuff(DealCycle, c("AdvancedBless", "TriumphFeatherBuff", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure"), BuffFinal)
  BuffList <- c("AdvancedBless", "TriumphFeatherBuff", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "EpicAdventure")
  DealCycle <- DCSummoned(DealCycle, c("Bahamut"), SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, c("FountainforAngel"), SummonedFinal)
  DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
  DealCycle <- DCATK(DealCycle, c("AngelicTouch"), ATKFinal)
  DealCycle$AngelicTouchDebuff[nrow(DealCycle)] <- 60000
  
  ## 1st Infinity 
  WeaponPuff4 <- c(18)
  HolyBlood <- c(16)
  DivinePunishmentPre <- c(12, 81, 102)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    HeavensDoor <- c(1)
  } else {
    HeavensDoor <- c(1, 92)
  }
  MapleWarriors2 <- c(60)
  SoulContractLink <- c(30, 120)
  AngelofLibra <- c(30)
  SpiderInMirror <- c(50)
  Pray <- c(45)
  skills1 <- list(WeaponPuff4=WeaponPuff4, HolyBlood=HolyBlood, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, SpiderInMirror=SpiderInMirror, Pray=Pray)
  
  ## 2nd Infinity 
  DivinePunishmentPre <- c(21, 42, 111)
  HeavensDoor <- c(31)
  SoulContractLink <- c(60)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    skills2 <- list(DivinePunishmentPre=DivinePunishmentPre, SoulContractLink=SoulContractLink)
  } else {
    skills2 <- list(DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, SoulContractLink=SoulContractLink)
  }
  
  ## 3rd Infinity
  WeaponPuff4 <- c(78)
  HolyBlood <- c(76)
  DivinePunishmentPre <- c(51, 72)
  HeavensDoor <- c(61)
  MapleWarriors2 <- c(120)
  SoulContractLink <- c(90)
  AngelofLibra <- c(90)
  SpiderInMirror <- c(50)
  Pray <- c(105)
  skills3 <- list(WeaponPuff4=WeaponPuff4, HolyBlood=HolyBlood, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, SpiderInMirror=SpiderInMirror, Pray=Pray)
  
  ## 4th Infinity
  WeaponPuff4 <- c(18)
  HolyBlood <- c(16)
  DivinePunishmentPre <- c(12, 81, 102)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    HeavensDoor <- c(1)
  } else {
    HeavensDoor <- c(1, 92)
  }
  MapleWarriors2 <- c(60)
  SoulContractLink <- c(30, 120)
  AngelofLibra <- c(30)
  Pray <- c(45)
  skills4 <- list(WeaponPuff4=WeaponPuff4, HolyBlood=HolyBlood, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, Pray=Pray)
  
  ## 5th Infinity
  DivinePunishmentPre <- c(21, 42, 111)
  HeavensDoor <- c(31)
  SoulContractLink <- c(60)
  SpiderInMirror <- c(50)
  if(BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration < 121) {
    skills5 <- list(DivinePunishmentPre=DivinePunishmentPre, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror)
  } else {
    skills5 <- list(DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, SoulContractLink=SoulContractLink, SpiderInMirror=SpiderInMirror)
  }
  
  ## 6th Infinity
  WeaponPuff4 <- c(78)
  HolyBlood <- c(76)
  DivinePunishmentPre <- c(51, 72)
  HeavensDoor <- c(61)
  MapleWarriors2 <- c(120)
  SoulContractLink <- c(90)
  AngelofLibra <- c(90)
  Pray <- c(105)
  skills6 <- list(WeaponPuff4=WeaponPuff4, HolyBlood=HolyBlood, DivinePunishmentPre=DivinePunishmentPre, HeavensDoor=HeavensDoor, MapleWarriors2=MapleWarriors2, 
                  SoulContractLink=SoulContractLink, AngelofLibra=AngelofLibra, Pray=Pray)
  
  for(k in 1:6) {
    if(sum(k==c(1)) >= 1) {
      skills <- skills1
    } else if(sum(k==c(2)) >= 1) {
      skills <- skills2
    } else if(sum(k==c(3)) >= 1) {
      skills <- skills3
    } else if(sum(k==c(4)) >= 1) {
      skills <- skills4
    } else if(sum(k==c(5)) >= 1) {
      skills <- skills5
    } else if(sum(k==c(6)) >= 1) {
      skills <- skills6
    }
    
    times <- c()
    for(i in 1:length(skills)) {
      times <- c(times, skills[[i]])
    }
    times <- unique(times)
    times <- times[order(times, decreasing=T)]
    
    skilllist <- list()
    for(i in 1:length(times)) {
      skilllist[[i]] <- 1
      for(j in 1:length(skills)) {
        if(sum(skills[[j]]==times[[i]])==1) {
          skilllist[[i]] <- c(skilllist[[i]], names(skills)[[j]])
        }
      }
      skilllist[[i]] <- skilllist[[i]][-1]
    }
    names(skilllist) <- times
    times <- times * 1000
    PMCool <- subset(ATKFinal, rownames(ATKFinal)=="PeaceMaker")$CoolTime * 1000
    GNCool <- subset(ATKFinal, rownames(ATKFinal)=="Genesis")$CoolTime * 1000
    FACool <- subset(SummonedFinal, rownames(SummonedFinal)=="FountainforAngel")$Duration * 1000
    if(k==1) {
      PMRemain <- 6000 ; GNRemain <- 0 ; FARemain <- FACool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(DealCycle[DealCycle$Skills=="FountainforAngelSummoned", ]$Time))
    } else {
      PMRemain <- max(8000, PMCool - ((DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(DealCycle[DealCycle$Skills=="PeaceMaker", ]$Time)))
    }
    
    p <- 1
    while(DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
      if(p <= length(times) & DealCycle$Infinity[nrow(DealCycle)] - DealCycle$Time[1] < times[p] + 500) {
        for(j in 1:length(skilllist[[p]])) {
          if(sum(rownames(ATKFinal)==skilllist[[p]][j])==1) {
            DealCycle <- DCATK(DealCycle, skilllist[[p]][j], ATKFinal)
            PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            GNRemain <- max(0, GNRemain - DealCycle$Time[1])
            FARemain <- max(0, FARemain - DealCycle$Time[1])
            if(DealCycle$Skills[nrow(DealCycle)]=="DivinePunishmentPre") {
              if(sum(times[p]==c(81000, 21000, 111000, 3000)) >= 1) {
                for(t in 1:10) {
                  DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                  PMRemain <- max(0, PMRemain - DealCycle$Time[1])
                  GNRemain <- max(0, GNRemain - DealCycle$Time[1])
                  FARemain <- max(0, FARemain - DealCycle$Time[1])
                }
                DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
                GNRemain <- max(0, GNRemain - DealCycle$Time[1])
                FARemain <- max(0, FARemain - DealCycle$Time[1])
              } else {
                for(t in 1:40) {
                  DealCycle <- DCATK(DealCycle, "DivinePunishment", ATKFinal)
                  PMRemain <- max(0, PMRemain - DealCycle$Time[1])
                  GNRemain <- max(0, GNRemain - DealCycle$Time[1])
                  FARemain <- max(0, FARemain - DealCycle$Time[1])
                }
                DealCycle <- DCATK(DealCycle, rep("DivinePunishmentEnd", 1), ATKFinal)
                PMRemain <- max(0, PMRemain - DealCycle$Time[1])
                GNRemain <- max(0, GNRemain - DealCycle$Time[1])
                FARemain <- max(0, FARemain - DealCycle$Time[1])
              }
            }
          } else if(sum(rownames(BuffFinal)==skilllist[[p]][j])==1) {
            DealCycle <- DCBuff(DealCycle, skilllist[[p]][j], BuffFinal)
            PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            GNRemain <- max(0, GNRemain - DealCycle$Time[1])
            FARemain <- max(0, FARemain - DealCycle$Time[1])
          } else {
            if(skilllist[[p]][j]=="AngelofLibra") {
              DealCycle <- DCATK(DealCycle, "AngelofLibraBuffDummy", ATKFinal)
            }
            DealCycle <- DCSummoned(DealCycle, skilllist[[p]][j], SummonedFinal)
            PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            GNRemain <- max(0, GNRemain - DealCycle$Time[1])
            FARemain <- max(0, FARemain - DealCycle$Time[1])
          }
        }
        p <- p + 1
      }
      if(PMRemain==0) {
        DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
        PMRemain <- max(0, PMCool - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
      } else if(GNRemain==0 & nrow(DealCycle[DealCycle$Skills=="Genesis", ]) < 2 * k) {
        DealCycle <- DCATK(DealCycle, c("Genesis"), ATKFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNCool - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
      } else if(FARemain==0) {
        DealCycle <- DCSummoned(DealCycle, c("FountainforAngel"), SummonedFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FACool - DealCycle$Time[1])
      } else if(DealCycle$AngelicTouchDebuff[nrow(DealCycle)] - DealCycle$Time[1] < 15000) {
        DealCycle <- DCATK(DealCycle, c("AngelicTouch"), ATKFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
        DealCycle$AngelicTouchDebuff[nrow(DealCycle)] <- 60000
      } else {
        DealCycle <- DCATK(DealCycle, "AngelRay", ATKFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
      }
    }
    
    if(sum(k==c(1, 3, 5)) >= 1) {
      DealCycle <- DCBuff(DealCycle, c("EpicAdventure"), BuffFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      GNRemain <- max(0, GNRemain - DealCycle$Time[1])
      FARemain <- max(0, FARemain - DealCycle$Time[1])
      
      DealCycle <- DCSummoned(DealCycle, "FountainforAngel", SummonedFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      GNRemain <- max(0, GNRemain - DealCycle$Time[1])
      FARemain <- max(0, FACool - DealCycle$Time[1])
      
      DealCycle <- DCATK(DealCycle, c("UnstableMemorize"), ATKFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      GNRemain <- max(0, GNRemain - DealCycle$Time[1])
      FARemain <- max(0, FARemain - DealCycle$Time[1])
      
      DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      GNRemain <- max(0, GNRemain - DealCycle$Time[1])
      FARemain <- max(0, FARemain - DealCycle$Time[1])
      
      DealCycle <- DCATK(DealCycle, c("AngelicTouch"), ATKFinal)
      PMRemain <- max(0, PMRemain - DealCycle$Time[1])
      GNRemain <- max(0, GNRemain - DealCycle$Time[1])
      FARemain <- max(0, FARemain - DealCycle$Time[1])
      DealCycle$AngelicTouchDebuff[nrow(DealCycle)] <- 60000
    } else if(sum(k==c(2, 4, 6)) >= 1) {
      while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - 
            (UnstableCool * 1000 - BuffFinal[rownames(BuffFinal)=="Infinity", ]$Duration * 1000 + max(DealCycle[DealCycle$Skills=="UnstableMemorize", ]$Time) - min(DealCycle[DealCycle$Skills=="Infinity", ]$Time)) < 0) {
        if(PMRemain==0) {
          DealCycle <- DCATK(DealCycle, "PeaceMaker", ATKFinal)
          PMRemain <- max(0, PMCool - DealCycle$Time[1])
          GNRemain <- max(0, GNRemain - DealCycle$Time[1])
          FARemain <- max(0, FARemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "AngelRay", ATKFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          GNRemain <- max(0, GNRemain - DealCycle$Time[1])
          FARemain <- max(0, FARemain - DealCycle$Time[1])
        }
      }
      
      if(k != 6) {
        for(i in 1:length(BuffList)) {
          DealCycle <- DCBuff(DealCycle, BuffList[i], BuffFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          GNRemain <- max(0, GNRemain - DealCycle$Time[1])
          FARemain <- max(0, FARemain - DealCycle$Time[1])
        }
        
        if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) >= 1) {
          DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          GNRemain <- max(0, GNRemain - DealCycle$Time[1])
          FARemain <- max(0, FARemain - DealCycle$Time[1])
        }
        DealCycle <- DCSummoned(DealCycle, "FountainforAngel", SummonedFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FACool - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, c("Infinity"), BuffFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, c("AngelicTouch"), ATKFinal)
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        GNRemain <- max(0, GNRemain - DealCycle$Time[1])
        FARemain <- max(0, FARemain - DealCycle$Time[1])
        DealCycle$AngelicTouchDebuff[nrow(DealCycle)] <- 60000
      }
    }
  }
  return(DealCycle)
}
BishopAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, PeaceMakerHits, Spec) {
  ## Peace Maker
  DealCycle <- RepATKCycle(DealCycle, "PeaceMaker", PeaceMakerHits, 780, ATKFinal)
  
  subsets <- DealCycle[DealCycle$Skills=="PeaceMaker", ]
  n <- floor(nrow(subsets) / PeaceMakerHits)
  n <- 1:n * PeaceMakerHits
  for(i in n) {
    DealCycle <- rbind(DealCycle, subsets[i, ], subsets[i, ])
    DealCycle[(nrow(DealCycle)-1), 1] <- "PeaceMakerExplosion"
    DealCycle[nrow(DealCycle), 1] <- "PeaceMakerBuff"
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    DealCycle$PeaceMakerBuff[i] <- ifelse(DealCycle$Skills[i]=="PeaceMakerBuff", 
                                          BuffFinal[rownames(BuffFinal)=="PeaceMakerBuff", ]$Duration * 1000, max(DealCycle$PeaceMakerBuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0))
  }
  
  
  ## Spider In Mirror, Fountain for Angel
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "FountainforAngel", SummonedFinal)
  
  
  ## Triumph Feather
  TF <- subset(DealCycle, DealCycle$Skills=="TriumphFeatherBuff")
  Ind <- rownames(TF)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 2001
    while(p < Ind[i+1] & DealCycle$TriumphFeatherBuff[p] > 0) {
      if(time > 2000 & max(DealCycle$Skills[p]==c("AngelRay", "AngelicTouch", "PeaceMaker", "Genesis", "HeavensDoor", "DivinePunishment", "DivinePunishmentEnd"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("TriumphFeather")
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
  
  
  ## Angel of Libra, Bahamut (ATK)
  maxtime <- max(DealCycle[, 2])
  Ind1 <- DealCycle[, 1] == "AngelofLibraSummoned"
  Libras <- DealCycle[Ind1, ]
  Libras$Time <- Libras$Time + 30000
  Libras$Skills <- "BahamutSummoned"
  
  DealCycle <- rbind(DealCycle, Libras)
  DealCycle <- subset(DealCycle, DealCycle$Time <= maxtime)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  for(i in 1:nrow(DealCycle)) {
    if("BahamutSummoned"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  SkillInd <- DealCycle[, 1] == "AngelofLibraSummoned" | DealCycle[, 1] == "BahamutSummoned"
  Summons <- DealCycle[SkillInd, ]
  for(i in 1:nrow(Summons)) {
    DC <- Summons[i, ]
    DC <- rbind(DC, DC)
    DC[2, 1] <- ifelse(DC[1, 1]=="AngelofLibraSummoned", "AngelofLibra", "Bahamut")
    DC[2, 2] <- DC[1, 2] + 3030
    
    p <- 3
    t <- 3030 * 2
    interval <- min(ifelse(is.na(Summons[i+1, 2])==T, maxtime - Summons[i, 2], Summons[i+1, 2] - Summons[i, 2]), ifelse(DC[1, 1]=="AngelofLibraSummoned", 30000, 286000))
    while(t < interval) {
      DC <- rbind(DC, DC[p-1, ])
      DC[p, 2] <- DC[p-1, 2] + 3030
      p <- p + 1
      t <- t + 3030
    }
    
    DC <- rbind(DC, DC[2:nrow(DC), ])
    DC[(nrow(DC)/2+1.5):nrow(DC), 1] <- ifelse(DC[1, 1]=="AngelofLibraSummoned", "AngelofLibraDebuff", "BahamutDebuff")
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if("AngelofLibra"==DealCycle[i, 1] | "Bahamut"==DealCycle[i, 1] | "AngelofLibraDebuff"==DealCycle[i, 1] | "BahamutDebuff"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  SkillInd <- DealCycle[, 1] == "AngelofLibraDebuff" | DealCycle[, 1] == "BahamutDebuff"
  Debuffs <- DealCycle[SkillInd, ]
  rowInd <- c(as.numeric(rownames(Debuffs)), nrow(DealCycle))
  for(i in 1:nrow(Debuffs)) {
    k <- 0
    t <- rowInd[i] + 1
    while(k==0 & t < rowInd[i+1]) {
      if(DealCycle$Skills[t]=="AngelRay" | DealCycle$Skills[t]=="PeaceMaker" | DealCycle$Skills[t]=="PeaceMakerExplosion" | DealCycle$Skills[t]=="DivinePunishment") {
        DealCycle$AngelofLibraDebuff[t] <- ifelse(DealCycle$Skills[rowInd[i]]=="AngelofLibraDebuff", 1, 0)
        DealCycle$BahamutDebuff[t] <- ifelse(DealCycle$Skills[rowInd[i]]=="BahamutDebuff", 1, 0)
        t <- t + 1
        k <- 1
      } else {
        t <- t + 1
      }
    }
  }
  
  
  ## Angel of Libra (Buff)
  DealCycle <- RepATKCycle(DealCycle, "AngelofLibraBuffDummy", 6, 1440, ATKFinal)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "AngelofLibraBuffDummy") {
      DealCycle$AngelofLibraBuff[i] <- BuffFinal[rownames(BuffFinal)=="AngelofLibraBuff", ]$Duration * 1000
      DealCycle$AngelofLibraBuff[i]
    } else {
      DealCycle$AngelofLibraBuff[i] <- max(0, DealCycle$AngelofLibraBuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    }
  }
  return(DealCycle)
}
BishopStats <- function(DealCycle, BuffFinal, Spec) {
  for(i in 1:nrow(DealCycle)) {
    DealCycle$Stat[i] <- Spec$MainStat + ifelse(DealCycle$MapleWarriors2[i] > 0, BuffFinal[rownames(BuffFinal)=="MapleWarriors2", ]$MainStat, 0) + 
      ifelse(DealCycle$WeaponPuff4[i] > 0, BuffFinal[rownames(BuffFinal)=="WeaponPuff4", ]$MainStat, 0)
  }
  
  for(i in 1:nrow(DealCycle)) {
    DealCycle$PrayFDR[i] <- ifelse(DealCycle$Pray[i] > 0, floor(DealCycle$Stat[i] / 2500) + 5, 0)
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "AngelofLibraBuffDummy") {
      DealCycle$AngelofLibraBDR[i] <- floor(DealCycle$Stat[i] / 1250) + 5
    } else if(DealCycle$AngelofLibraBuff[i] > 0) {
      DealCycle$AngelofLibraBDR[i] <- DealCycle$AngelofLibraBDR[i-1]
    }
  }
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i] == "HolyBlood") {
      DealCycle$HolyBloodFDR[i] <- floor(DealCycle$Stat[i] / 5000) + 1
    } else if(DealCycle$HolyBlood[i] > 0) {
      DealCycle$HolyBloodFDR[i] <- DealCycle$HolyBloodFDR[i-1]
    }
  }
  return(DealCycle)
}

for(i in 1:nrow(UnstableCycles)) {
  DealCycle <- c("Skills", "Time", rownames(BishopBuff))
  BishopDealCycleDummy <- t(rep(0, length(DealCycle)))
  colnames(BishopDealCycleDummy) <- DealCycle
  
  BishopDealCycleDummy <- BishopCycle(BishopDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, UnstableCool = UnstableCool[3])
  BishopDealCycleDummy <- DealCycleFinal(BishopDealCycleDummy)
  
  BishopDealCycleDummy <- BishopAddATK(BishopDealCycleDummy, ATKFinal, BuffFinal, SummonedFinal, 3, BishopSpec)
  BishopDealCycleDummy <- BishopStats(BishopDealCycleDummy, BuffFinal, BishopSpec)
  BishopDealCycleDummy <- BishopInfinity(BishopDealCycleDummy, 6000, 70 + BishopSpec$SkillLv, General$General$Serverlag)
  
  UnstableCycles$CycleTimes[i] <- max(BishopDealCycleDummy$Time)
  assign(paste("BishopDealCycle", i, sep=""), BishopDealCycleDummy)
  rm(BishopDealCycleDummy)
}

BishopDealCycleReduction <- DealCycleReduction(get(UnstableCycles$CycleNames[nrow(UnstableCycles)]), NotBuffColNames=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Bishop") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  BishopSpecOpt1 <- Optimization1(BishopDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BishopSpec, BishopUnionRemained, 
                                  NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- BishopSpecOpt1[1, 1:3]
} else {
  BishopSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
BishopSpecOpt <- OptDataAdd(BishopSpec, BishopSpecOpt1, "Potential", BishopBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  BishopSpecOpt2 <- Optimization2(BishopDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, BishopHyperStatBase, BishopBase$ChrLv, BishopBase$CRROver, 
                                  NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- BishopSpecOpt2[1, ]
} else {
  BishopSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
BishopSpecOpt <- OptDataAdd(BishopSpecOpt, BishopSpecOpt2, "HyperStat", BishopBase$CRROver, DemonAvenger=F)

BishopFinalDPM <- ResetDealCalc(DealCycles=GetList(UnstableCycles$CycleNames), 
                                ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, UnstableCycles$CycleTimes, UnstableCycles$Prob, 
                                NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR"))
BishopFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=GetList(UnstableCycles$CycleNames), 
                                                 ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, UnstableCycles$CycleTimes, UnstableCycles$Prob, 
                                                 NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "Bishop", sum(na.omit(BishopFinalDPMwithMax)) / (sum(UnstableCycles$Prob * UnstableCycles$CycleTimes) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Bishop", sum(na.omit(BishopFinalDPM)) / (sum(UnstableCycles$Prob * UnstableCycles$CycleTimes) / 60000) - 
      sum(na.omit(BishopFinalDPMwithMax)) / (sum(UnstableCycles$Prob * UnstableCycles$CycleTimes) / 60000))

BishopDealData <- data.frame(BishopDealCycle1$Skills, BishopDealCycle1$Time, BishopDealCycle1$WeaponPuff, BishopDealCycle1$HolyBlood, 
                             DealCalcWithMaxDMR(BishopDealCycle1, ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, 
                                                NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR")), 
                             stringsAsFactors = F)
colnames(BishopDealData) <- c("Skills", "Time", "W4", "HB", "Deal")
BishopDealData$R4 <- BishopDealData$HB
for(i in 2:nrow(BishopDealData)) {
  if(BishopDealData$Skills[i]=="HolyBlood") {
    BishopDealData$R4[i] <- 15000
    BishopDealData$Skills[i] <- "Restraint4"
  } else {
    BishopDealData$R4[i] <- max(0, BishopDealData$R4[i-1] - (BishopDealData$Time[i] - BishopDealData$Time[i-1]))
  }
}

for(i in 1:nrow(UnstableCycles)) {
  BishopDealDummy <- DealCalcWithMaxDMR(get(UnstableCycles$CycleNames[i]), ATKFinal, BuffFinal, SummonedFinal, BishopSpecOpt, 
                                        NotBuffCols=c("InfinityFDR", "HolyBloodFDR", "PrayFDR", "AngelofLibraBDR"), NotBuffColOption=c("FDR", "FDR", "FDR", "BDR"))
  assign(paste("BishopDealData", i, sep=""), BishopDealDummy)
  rm(BishopDealDummy)
}
BishopDealRatio <- ResetDealRatio(DealCycles=GetList(UnstableCycles$CycleNames), 
                                  DealDatas=GetList(UnstableCycles$DealDatas), 
                                  times=UnstableCycles$CycleTimes, 
                                  prob=UnstableCycles$Prob)

set(get(DPMCalcOption$DataName), as.integer(3), "Bishop", Deal_BishopRR(BishopDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Bishop", Deal_40s(BishopDealData, F, NA, FinishTime=subset(BishopDealData, BishopDealData$Skills=="WeaponPuff4")$Time[1] + 18000))