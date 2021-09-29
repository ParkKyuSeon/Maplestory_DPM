## AngelicBuster - Data
## AngelicBuster - VMatrix
AngelicBusterCoreBase <- CoreBuilder(ActSkills=c("EnergeBust", "Spotlight", "MascotFamiliar", "TrinityFusion", 
                                                 CommonV("Pirate", "Nova")), 
                                     ActSkillsLv=c(25, 25, 25, 25, 25, 25, 1, 25, 25), 
                                     UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                     SpecSet=get(DPMCalcOption$SpecSet), 
                                     VPassiveList=AngelicBusterVPassive, 
                                     VPassivePrior=AngelicBusterVPrior, 
                                     SelfBind=F)

AngelicBusterCore <- MatrixSet(PasSkills=AngelicBusterCoreBase$PasSkills$Skills, 
                               PasLvs=AngelicBusterCoreBase$PasSkills$Lv, 
                               PasMP=AngelicBusterCoreBase$PasSkills$MP, 
                               ActSkills=AngelicBusterCoreBase$ActSkills$Skills, 
                               ActLvs=AngelicBusterCoreBase$ActSkills$Lv, 
                               ActMP=AngelicBusterCoreBase$ActSkills$MP, 
                               UsefulSkills=AngelicBusterCoreBase$UsefulSkills, 
                               UsefulLvs=20, 
                               UsefulMP=0, 
                               SpecSet=get(DPMCalcOption$SpecSet), 
                               SpecialCore=AngelicBusterCoreBase$SpecialCoreUse)


## AngelicBuster - Basic Info
AngelicBusterBase <- JobBase(ChrInfo=ChrInfo, 
                             MobInfo=get(DPMCalcOption$MobSet),
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             Job="AngelicBuster",
                             CoreData=AngelicBusterCore, 
                             BuffDurationNeeded=0, 
                             AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "AngelicBuster"), 
                             LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "AngelicBuster"), 
                             MonsterLife=get(FindJob(MonsterLifePreSet, "AngelicBuster")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                             Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "SoulShooter", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                             WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                             SubWeapon=SubWeapon[rownames(SubWeapon)=="SoulRing", ], 
                             Emblem=Emblem[rownames(Emblem)=="Angel", ], 
                             CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "AngelicBuster")))


## AngelicBuster - Passive
{option <- factor(c("Mastery"), levels=PSkill)
value <- c(10)
TrueSuccesser <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
SoulShooterMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
InnerFire <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(40)
CallofAincient <- data.frame(option, value)

option <- factor(c("MainStat", "BDR"), levels=PSkill)
value <- c(40, 20)
AffinityIII <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(10 + ceiling(AngelicBusterBase$SkillLv/3), 15 + ceiling(AngelicBusterBase$SkillLv/2))
TrinityPassive <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(AngelicBusterBase$SkillLv/2), 30 + AngelicBusterBase$SkillLv, 30 + AngelicBusterBase$SkillLv, 15 + ceiling(AngelicBusterBase$SkillLv/2))
SoulShooterExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(10 + GetCoreLv(AngelicBusterCore, "TrinityFusion"))
TrinityFusionPassive <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + GetCoreLv(AngelicBusterCore, "LoadedDice"))
LoadedDice <- data.frame(option, value) 

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(AngelicBusterCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(AngelicBusterCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

AngelicBusterPassive <- Passive(list(TrueSuccesser, SoulShooterMastery, InnerFire, CallofAincient, AffinityIII, TrinityPassive, SoulShooterExpert,
                                     TrinityFusionPassive, LoadedDice, BlinkPassive, RopeConnectPassive))


## AngelicBuster - Buff
{option <- factor("BDR", levels=BSkill)
value <- c(90)
info <- c(10, 90, 900, T, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulContract <- rbind(data.frame(option, value), info)

option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LyricalCross <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PowerTransfer <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
IronRotus <- rbind(data.frame(option, value), info) 

option <- factor(c("CDMR"), levels=BSkill)
value <- c(45 + AngelicBusterBase$SkillLv)
info <- c(180 + 5 * AngelicBusterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulGaze <- rbind(data.frame(option, value), info) 

option <- factor("MainStat", levels=BSkill)
value <- c(floor((AngelicBusterBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(AngelicBusterBase$SkillLv/2))))
info <- c(900 + 30 * AngelicBusterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(25 + 2 * floor(AngelicBusterBase$SkillLv/3))
info <- c(20, Cooldown(40 - AngelicBusterBase$SkillLv, T, 25 + AngelicBusterBase$UnionChrs$CoolReduceP, AngelicBusterBase$CoolReduce), Delay(1350, 2), F, F, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinituraFettucciaBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(0)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AffinityIVBuff <- rbind(data.frame(option, value), info)  ## Simulation Needed

option <- factor(c("IGR", "BDR"), levels=BSkill)
value <- c(30, 20)
info <- c(30, 120, 1020, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulExalt <- rbind(data.frame(option, value), info) 

option <- factor(c("ATK"), levels=BSkill)
value <- c(50)
info <- c(30, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalContract <- rbind(data.frame(option, value), info) 

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EnergyBustBuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(3 + floor(GetCoreLv(AngelicBusterCore, "Spotlight")/10))
info <- c(30, 120, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpotLightBuff1 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(((3 * 2 + floor(GetCoreLv(AngelicBusterCore, "Spotlight")/10) * 2 + 100) / (100 + 3 + floor(GetCoreLv(AngelicBusterCore, "Spotlight")/10)) - 1) * 100)
info <- c(30, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpotLightBuff2 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(((3 * 3 + floor(GetCoreLv(AngelicBusterCore, "Spotlight")/10) * 3 + 100) / (100 + 3 * 2 + floor(GetCoreLv(AngelicBusterCore, "Spotlight")/10) * 2) - 1) * 100)
info <- c(30, 120, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SpotLightBuff3 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + floor(GetCoreLv(AngelicBusterCore, "MascotFamiliar")/5), 120, Delay(1080, 2), F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MascotFamiliarBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MascotFamiliarStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MascotFamiliarDummy <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 180, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * GetCoreLv(AngelicBusterCore, "OverDrive")) * ArcaneShade[rownames(ArcaneShade)=="SoulShooter", 6]))
info <- c(30, 70 - floor(GetCoreLv(AngelicBusterCore, "OverDrive")/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info) 

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * ArcaneShade[rownames(ArcaneShade)=="SoulShooter", 6]))
info <- c(Cooldown(70 - floor(GetCoreLv(AngelicBusterCore, "OverDrive")/5), T, AngelicBusterBase$UnionChrs$CoolReduceP, AngelicBusterBase$CoolReduce) - 30 - General$General$Serverlag, 
          70 - floor(GetCoreLv(AngelicBusterCore, "OverDrive")/5), 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info) 

option <- factor("BDR", levels=BSkill)
value <- c(5 + GetCoreLv(AngelicBusterCore, "BlessofGrandisGoddess"))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info) 

Useful <- UsefulSkills(AngelicBusterCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}
}

AngelicBusterBuff <- Buff(list(LyricalCross=LyricalCross, PowerTransfer=PowerTransfer, IronRotus=IronRotus, SoulGaze=SoulGaze, MapleSoldier=MapleSoldier, 
                               FinituraFettucciaBuff=FinituraFettucciaBuff, AffinityIVBuff=AffinityIVBuff, SoulExalt=SoulExalt, FinalContract=FinalContract, 
                               EnergyBustBuff=EnergyBustBuff, SpotLightBuff1=SpotLightBuff1, SpotLightBuff2=SpotLightBuff2, SpotLightBuff3=SpotLightBuff3, 
                               MascotFamiliarBuff=MascotFamiliarBuff, MascotFamiliarStack=MascotFamiliarStack, MascotFamiliarDummy=MascotFamiliarDummy, 
                               LuckyDice5=LuckyDice5, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, BlessofGrandisGoddess=BlessofGrandisGoddess, 
                               UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, Restraint4=Restraint4, SoulContract=SoulContract))
## PetBuff : UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), SoulGaze(1080ms), LyricalCross(990ms), PowerTransfer(990ms), IronRotus(1080ms) -> Not Use Useful Advanced Bless
AngelicBusterAllTimeBuff <- AllTimeBuff(AngelicBusterBuff)


## AngelicBuster - Union & HyperStat & SoulWeapon
AngelicBusterSpec <- JobSpec(JobBase=AngelicBusterBase, 
                             Passive=AngelicBusterPassive, 
                             AllTimeBuff=AngelicBusterAllTimeBuff, 
                             MobInfo=get(DPMCalcOption$MobSet), 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             WeaponName="SoulShooter", 
                             UnionStance=10)

AngelicBusterUnionRemained <- AngelicBusterSpec$UnionRemained
AngelicBusterHyperStatBase <- AngelicBusterSpec$HyperStatBase
AngelicBusterCoolReduceType <- AngelicBusterSpec$CoolReduceType
AngelicBusterSpec <- AngelicBusterSpec$Spec


## AngelicBuster - Spider In Mirror
SIM <- SIMData(GetCoreLv(AngelicBusterCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## AngelicBuster - Attacks
## Hyper : Trinity - Reinforce / Split Attack, Soul Seeker - Reinforce / Make Up,  Finitura Fettuccia - CoolTime Reduce
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(30, ifelse(GetCoreLv(AngelicBusterCore, "Trinity")>=40, 20, 0))), 50, 2 * GetCoreLv(AngelicBusterCore, "Trinity")) 
info <- c(720 + 12 * AngelicBusterSpec$SkillLv - 70, 3, 660, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
Trinity1 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(30, ifelse(GetCoreLv(AngelicBusterCore, "Trinity")>=40, 20, 0))), 50, 2 * GetCoreLv(AngelicBusterCore, "Trinity")) 
info <- c(720 + 12 * AngelicBusterSpec$SkillLv - 70, 4, 720, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
Trinity2 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(30, ifelse(GetCoreLv(AngelicBusterCore, "Trinity")>=40, 20, 0))), 50, 2 * GetCoreLv(AngelicBusterCore, "Trinity")) 
info <- c(720 + 12 * AngelicBusterSpec$SkillLv - 70, 5, 480, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
Trinity3 <- rbind(data.frame(option, value), info) 

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AngelicBusterCore, "SoulSeeker")>=40, 20, 0), 20, 2 * GetCoreLv(AngelicBusterCore, "SoulSeeker")) 
info <- c(320 * 0.75, 2, 0, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
SoulSeeker <- rbind(data.frame(option, value), info) ## ATKTime Vary -> Prob : (0.35 + 0.01 * AngerlicBusterSpec$PSkillLv(+ 0.15 when Soul Exalt)) / Re-Make : 95%

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AngelicBusterCore, "FinituraPettuccia")>=40, 20, 0), 2 * GetCoreLv(AngelicBusterCore, "FinituraPettuccia")) 
info <- c(400 + 7 * AngelicBusterBase$SkillLv, 10, 0, NA, Cooldown(40 - AngelicBusterBase$SkillLv, T, 25 + AngelicBusterBase$UnionChrs$CoolReduceP, AngelicBusterBase$CoolReduce), F, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
FinituraFettuccia <- rbind(data.frame(option, value), info) ## Delay on Buff

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(AngelicBusterCore, "SuperNova")>=40, 20, 0), 2 * GetCoreLv(AngelicBusterCore, "SuperNova")) 
info <- c(600, 3, 600, 840, 60, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
SuperNova <- rbind(data.frame(option, value), info)  ## ATKSpeed, SubTime Check Needed

option <- factor(c("FDR"), levels=ASkill)
value <- c(200) 
info <- c(450 + 18 * GetCoreLv(AngelicBusterCore, "EnergeBust"), 15, 900, NA, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
EnergyBust <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(400 + 16 * GetCoreLv(AngelicBusterCore, "Spotlight"), 3, 0, 720, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
SpotLight <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(600 + 24 * GetCoreLv(AngelicBusterCore, "MascotFamiliar"), 5, 0, 0, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
TwinkleStar <- rbind(data.frame(option, value), info) ## Magical Bulloon : Same

option <- factor(levels=ASkill)
value <- c() 
info <- c(250 + 10 * GetCoreLv(AngelicBusterCore, "MascotFamiliar"), 8, 0, 210, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
ShinyBubbleBreath <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(30, ifelse(GetCoreLv(AngelicBusterCore, "Trinity")>=40, 20, 0))), 50, 2 * GetCoreLv(AngelicBusterCore, "Trinity")) 
info <- c(330 + GetCoreLv(AngelicBusterCore, "TrinityFusion"), 3, 870, NA, 16 - floor(GetCoreLv(AngelicBusterCore, "TrinityFusion")/10), T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
TrinityFusion <- rbind(data.frame(option, value), info)  ## 900ms(1), 90ms(2), 90ms(3), 90ms(4), 90ms(5), 90ms(6), 180ms(7), 90ms(8), 90ms(9)
## Can Calcel Trinity after 210ms
}

AngelicBusterATK <- Attack(list(Trinity1=Trinity1, Trinity2=Trinity2, Trinity3=Trinity3, SoulSeeker=SoulSeeker, FinituraFettuccia=FinituraFettuccia, SuperNova=SuperNova, 
                                EnergyBust=EnergyBust, SpotLight=SpotLight, TwinkleStar=TwinkleStar, ShinyBubbleBreath=ShinyBubbleBreath, TrinityFusion=TrinityFusion, 
                                SpiderInMirror=SpiderInMirror))


## AngelicBuster - Summoned
AngelicBusterSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, 
                                       SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                       SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## AngelicBuster - DealCycle & Deal Calculation
ATKFinal <- data.frame(AngelicBusterATK)
ATKFinal$Delay[c(-6, -7)] <- Delay(ATKFinal$Delay, AngelicBusterSpec$ATKSpeed)[c(-6, -7)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, AngelicBusterSpec$CoolReduceP, AngelicBusterSpec$CoolReduce)

BuffFinal <- data.frame(AngelicBusterBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, AngelicBusterSpec$CoolReduceP, AngelicBusterSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, AngelicBusterSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)
BuffFinal[rownames(BuffFinal)=="AffinityIVBuff", ]$BDR <- 30 * 0.992 ## Affinity IV Buff 99.2%

SummonedFinal <- data.frame(AngelicBusterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, AngelicBusterSpec$CoolReduceP, AngelicBusterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * AngelicBusterSpec$SummonedDuration / 100, 0)


## AngelicBuster - Delay Skip Structure
AngelicBusterSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
AngelicBusterSkipATK <- data.frame(AngelicBusterSkipATK, row.names=c(rownames(ATKFinal)))
colnames(AngelicBusterSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

AngelicBusterSkipATK$Trinity2 <- c(T, rep(F, 11))
AngelicBusterSkipATK$Trinity3 <- c(F, T, rep(F, 10))

AngelicBusterSkipATK$SkippedDelay <- c(Delay(480, AngelicBusterSpec$ATKSpeed), Delay(480, AngelicBusterSpec$ATKSpeed), rep(F, 10))
AngelicBusterSkipATK <- subset(AngelicBusterSkipATK, AngelicBusterSkipATK$SkippedDelay>0)
## Trinity Fusion : Other Logic(Set Time 240 when Making Dealcycle)


## AngelicBuster - DealCycle and Deal Calc
DealCycle <- c("Skills", "Time", rownames(AngelicBusterBuff))
AngelicBusterDealCycle <- t(rep(0, length(DealCycle)))
colnames(AngelicBusterDealCycle) <- DealCycle
AngelicBusterDealCycle <- data.frame(AngelicBusterDealCycle)

AngelicBusterCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure, 
                               Period=c(122), CycleTime=c(244), SoulContractReset=0, FinituraFettucciaReset=0) {
  BuffSummonedPrior <- c("MapleSoldier", "LyricalCross", "PowerTransfer", "IronRotus", "SoulGaze", "UsefulSharpEyes", "UsefulCombatOrders", "LuckyDice5", 
                         "MascotFamiliarBuff", "EnergyBustBuff", "BlessofGrandisGoddess", "OverDrive", "SoulExalt", "FinalContract", "SpotLightBuff1", "SoulContract", "FinituraFettucciaBuff")
  
  Times122 <- c(0, 0, 0, 0, 0, 0, 0, 0, 
                1, 1, 0.5, 2, 1, 1, 1, 1, 0.5)
  SubTime <- rep(Period - min(2, Spec$CoolReduce), length(BuffSummonedPrior))
  TotalTime <- CycleTime - min(2, Spec$CoolReduce) * (CycleTime/Period)
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times122[i]==0, Inf, Times122[i])
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
  
  MFStackLogic <- function(DealCycle) {
    if(DealCycle$Skills[nrow(DealCycle)]=="MascotFamiliarBuff") {
      DealCycle$MascotFamiliarStack[nrow(DealCycle)] <- 0
    } else if(DealCycle$Skills[nrow(DealCycle)]=="TwinkleStar") {
      DealCycle$MascotFamiliarStack[nrow(DealCycle)] <- min(8, DealCycle$MascotFamiliarStack[nrow(DealCycle)-1] + 1)
    } else if(DealCycle$Skills[nrow(DealCycle)]=="ShinyBubbleBreath") {
      DealCycle$MascotFamiliarStack[nrow(DealCycle)] <- 0
    } else {
      DealCycle$MascotFamiliarStack[nrow(DealCycle)] <- DealCycle$MascotFamiliarStack[nrow(DealCycle)-1]
    }
    
    if(DealCycle$MascotFamiliarDummy[nrow(DealCycle)-1] >= 0 & DealCycle$MascotFamiliarDummy[nrow(DealCycle)]==0 & DealCycle$MascotFamiliarStack[nrow(DealCycle)] < 8 & 
       DealCycle$MascotFamiliarBuff[nrow(DealCycle)] > 0 & DealCycle$Skills[nrow(DealCycle)]!="MascotFamiliarBuff") {
      DealCycle$MascotFamiliarStack[nrow(DealCycle)] <- min(8, DealCycle$MascotFamiliarStack[nrow(DealCycle)] + 1)
      DealCycle$MascotFamiliarDummy[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 8000 + General$General$Serverlag * 1000, 
                                                               8000 + General$General$Serverlag * 1000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - 
                                                                                                           DealCycle$MascotFamiliarDummy[nrow(DealCycle)-1]))
    } else if(DealCycle$Skills[nrow(DealCycle)]=="MascotFamiliarBuff") {
      DealCycle$MascotFamiliarDummy[nrow(DealCycle)] <- 8000 + General$General$Serverlag * 1000
    } else if(DealCycle$MascotFamiliarStack[nrow(DealCycle)] == 8) {
      DealCycle$MascotFamiliarDummy[nrow(DealCycle)] <- 8000 + General$General$Serverlag * 1000
    }
    return(DealCycle)
  }
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="MascotFamiliarBuff") {
        DealCycle <- DCATKSkip(DealCycle, "SpiderInMirror", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
      } else if(BuffList[[1]][i]=="SpotLightBuff1") {
        DealCycle <- DCATKSkip(DealCycle, "SpotLight", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
      } else if(BuffList[[1]][i]=="FinituraFettucciaBuff") {
        DealCycle <- DCATKSkip(DealCycle, "FinituraFettuccia", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        ## Mascot Familiar 
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- "TwinkleStar"
        DealCycle <- MFStackLogic(DealCycle)
      } 
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- MFStackLogic(DealCycle)
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- MFStackLogic(DealCycle)
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
  TFCool <- subset(ATKFinal, rownames(ATKFinal)=="TrinityFusion")$CoolTime * 1000
  FFCool <- subset(ATKFinal, rownames(ATKFinal)=="FinituraFettuccia")$CoolTime * 1000
  MFATKCool <- 1980
  SNCool <- 60000
  
  FFRemain <- max(0, FFCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="FinituraFettuccia")$Time))
  MFATKRemain <- max(0, MFATKCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="TwinkleStar")$Time)) ## 6200 when Shiny Bubble Breath
  TFRemain <- 0 ; SNRemain <- 0
  
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
          DealCycle <- MFStackLogic(DealCycle)
          TFRemain <- TFRemain - DealCycle$Time[1]
          FFRemain <- FFRemain - DealCycle$Time[1]
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
          SNRemain <- SNRemain - DealCycle$Time[1]
        }
      }
      ## Soul Contract(Reset), Finitura Pettuccia(Reset), Restraint Ring
      if(k==2 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContract")) < SoulContractReset + 1 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContract"))==1 & 
         DealCycle$SoulContract[nrow(DealCycle)] - DealCycle$Time[1] < 3000 | 
         k==2 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContract")) < SoulContractReset + 1 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContract"))==2 & 
         DealCycle$SoulContract[nrow(DealCycle)] - DealCycle$Time[1] < 3000 & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
        DealCycle <- DCBuff(DealCycle, "SoulContract", BuffFinal)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      }
      else if(k==2 & nrow(subset(DealCycle, DealCycle$Skills=="FinituraFettuccia")) < FinituraFettucciaReset + 1 & 
              DealCycle$FinituraFettucciaBuff[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
        DealCycle <- DCATKSkip(DealCycle, "FinituraFettuccia", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFCool - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
        
        if(MFATKRemain <= 0 & DealCycle$MascotFamiliarBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle, )])
          DealCycle$Skills[nrow(DealCycle)] <- "TwinkleStar"
          DealCycle <- MFStackLogic(DealCycle)
          MFATKRemain <- MFATKCool - DealCycle$Time[1]
        } else {
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        }
        
        DealCycle <- DCBuff(DealCycle, "FinituraFettucciaBuff", BuffFinal)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      }
      else if(nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))==0 & DealCycle$OverDrive[nrow(DealCycle)] - DealCycle$Time[1] < 16000) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      }
      ## Mascot Familiar(Shiny Bubble Breath)
      else if(DealCycle$MascotFamiliarStack[nrow(DealCycle)]==8 & nrow(subset(DealCycle, DealCycle$Skills=="ShinyBubbleBreath"))==0 & DealCycle$Restraint4[nrow(DealCycle)] > 0 & 
              nrow(subset(DealCycle, DealCycle$Skills=="ShinyBubbleBreath")) < nrow(subset(DealCycle, DealCycle$Skills=="MascotFamiliarBuff")) | 
              DealCycle$MascotFamiliarStack[nrow(DealCycle)]==8 & nrow(subset(DealCycle, DealCycle$Skills=="ShinyBubbleBreath"))==1 & 
              nrow(subset(DealCycle, DealCycle$Skills=="ShinyBubbleBreath")) < nrow(subset(DealCycle, DealCycle$Skills=="MascotFamiliarBuff"))) {
        DealCycle <- DCATKSkip(DealCycle, "ShinyBubbleBreath", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- 6200 - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      } 
      ## Super Nova
      else if(SNRemain <= 0 & nrow(subset(DealCycle, DealCycle$Skills=="SuperNova"))==0 & DealCycle$Restraint4[nrow(DealCycle)] > 0 | 
              SNRemain <= 0 & nrow(subset(DealCycle, DealCycle$Skills=="SuperNova")) > 0) {
        DealCycle <- DCATKSkip(DealCycle, "SuperNova", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNCool - DealCycle$Time[1]
      }
      ## Energy Bust(Explosion)
      else if(nrow(subset(DealCycle, DealCycle$Skills=="EnergyBust"))==0 & DealCycle$EnergyBustBuff[nrow(DealCycle)] > 0 & DealCycle$Restraint4[nrow(DealCycle)] > 0 &
              nrow(subset(DealCycle, DealCycle$Skills=="EnergyBust")) < nrow(subset(DealCycle, DealCycle$Skills=="EnergyBustBuff")) | 
              nrow(subset(DealCycle, DealCycle$Skills=="EnergyBust"))==1 & DealCycle$EnergyBustBuff[nrow(DealCycle)] > 0 & DealCycle$EnergyBustBuff[nrow(DealCycle)] < 23000 &
              nrow(subset(DealCycle, DealCycle$Skills=="EnergyBust")) < nrow(subset(DealCycle, DealCycle$Skills=="EnergyBustBuff"))) {
        BeforeCancelDelay <- DealCycle$Time[1]
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        TFRemain <- TFRemain + (BeforeCancelDelay - 30)
        FFRemain <- FFRemain + (BeforeCancelDelay - 30)
        MFATKRemain <- MFATKRemain + (BeforeCancelDelay - 30)
        SNRemain <- SNRemain + (BeforeCancelDelay - 30)
        
        DealCycle <- DCATKSkip(DealCycle, "EnergyBust", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      }
      ## Finitura Pettuccia
      else if(k!=5 & FFRemain <= 0 | 
              k==5 & FFRemain <= 0 & BuffStartTime + min(subset(DealCycle, DealCycle$Skills=="FinituraFettuccia")$Time) - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) >= 
              FFCool - ifelse(Spec$CoolReduce > 0, 1080, 0)) {
        DealCycle <- DCATKSkip(DealCycle, "FinituraFettuccia", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFCool - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
        
        if(MFATKRemain <= 0 & DealCycle$MascotFamiliarBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "TwinkleStar"
          DealCycle <- MFStackLogic(DealCycle)
          MFATKRemain <- MFATKCool - DealCycle$Time[1]
        } else {
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        }
        
        DealCycle <- DCBuff(DealCycle, "FinituraFettucciaBuff", BuffFinal)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - DealCycle$Time[1]
        FFRemain <- FFRemain - DealCycle$Time[1]
        MFATKRemain <- MFATKRemain - DealCycle$Time[1]
        SNRemain <- SNRemain - DealCycle$Time[1]
      }
      ## Trinity, Trinity Fusion
      else {
        DealCycle <- DCATKSkip(DealCycle, "Trinity1", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - 360
        FFRemain <- FFRemain - 360
        MFATKRemain <- MFATKRemain - 360
        SNRemain <- SNRemain - 360
        
        DealCycle <- DCATKSkip(DealCycle, "Trinity2", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - 360
        FFRemain <- FFRemain - 360
        MFATKRemain <- MFATKRemain - 360
        SNRemain <- SNRemain - 360
        
        DealCycle <- DCATKSkip(DealCycle, "Trinity3", ATKFinal, SkipStructure)
        DealCycle <- MFStackLogic(DealCycle)
        TFRemain <- TFRemain - 360
        FFRemain <- FFRemain - 360
        SNRemain <- SNRemain - 360
        
        if(MFATKRemain <= 0 & DealCycle$MascotFamiliarBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "TwinkleStar"
          DealCycle <- MFStackLogic(DealCycle)
          MFATKRemain <- MFATKCool - 360
        } else {
          MFATKRemain <- MFATKRemain - 360
        }
        
        if(TFRemain <= -120) {
          BeforeCancelDelay <- DealCycle$Time[1]
          DealCycle[1, 2:ncol(DealCycle)] <- 240
          FFRemain <- FFRemain + (BeforeCancelDelay - 240)
          MFATKRemain <- MFATKRemain + (BeforeCancelDelay - 240)
          SNRemain <- SNRemain + (BeforeCancelDelay - 240)
          
          DealCycle <- DCATKSkip(DealCycle, "TrinityFusion", ATKFinal, SkipStructure)
          DealCycle <- MFStackLogic(DealCycle)
          TFRemain <- TFCool - DealCycle$Time[1]
          FFRemain <- FFRemain - DealCycle$Time[1]
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
          SNRemain <- SNRemain - DealCycle$Time[1]
        } 
      }
    }
      
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="SpotLightBuff1") {
            DealCycle <- DCATKSkip(DealCycle, "SpotLight", ATKFinal, SkipStructure)
            DealCycle <- MFStackLogic(DealCycle)
            TFRemain <- TFRemain - DealCycle$Time[1]
            FFRemain <- FFRemain - DealCycle$Time[1]
            MFATKRemain <- MFATKRemain - DealCycle$Time[1]
            SNRemain <- SNRemain - DealCycle$Time[1]
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- MFStackLogic(DealCycle)
          TFRemain <- TFRemain - DealCycle$Time[1]
          FFRemain <- FFRemain - DealCycle$Time[1]
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
          SNRemain <- SNRemain - DealCycle$Time[1]
          if(DealCycle$Skills[nrow(DealCycle)]=="MascotFamiliarBuff") {
            MFATKRemain <- 3240 - DealCycle$Time[1]
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- MFStackLogic(DealCycle)
          TFRemain <- TFRemain - DealCycle$Time[1]
          FFRemain <- FFRemain - DealCycle$Time[1]
          MFATKRemain <- MFATKRemain - DealCycle$Time[1]
          SNRemain <- SNRemain - DealCycle$Time[1]
        }
      }
    }
  }
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SuperNova")$Time) + min(subset(DealCycle, DealCycle$Skills=="SuperNova")$Time) < SNCool) {
    DealCycle <- DCATKSkip(DealCycle, "Trinity1", ATKFinal, SkipStructure)
    DealCycle <- DCATKSkip(DealCycle, "Trinity2", ATKFinal, SkipStructure)
    DealCycle <- DCATKSkip(DealCycle, "Trinity3", ATKFinal, SkipStructure)
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
ATKFinalSoulSeeker <- function(ATKFinal, SoulSeekerProb) {
  SS <- subset(ATKFinal, rownames(ATKFinal)=="SoulSeeker")
  
  for(i in 1:7) {
    SS <- rbind(SS, SS[nrow(SS), ])
    rownames(SS)[nrow(SS)] <- paste("SoulSeeker", i, sep="")
    
    SS$AttackTimes[nrow(SS)] <- ifelse(i==1, 2 * SoulSeekerProb, SS$AttackTimes[nrow(SS)-1] * 0.95)
  }
  
  for(i in 1:7) {
    SS <- rbind(SS, SS[nrow(SS), ])
    rownames(SS)[nrow(SS)] <- paste("SoulSeekerSE", i, sep="")
    
    SS$AttackTimes[nrow(SS)] <- ifelse(i==1, 2 * (SoulSeekerProb + 0.15), SS$AttackTimes[nrow(SS)-1] * 0.95)
  }
  SS <- SS[-1, ]
  return(rbind(ATKFinal, SS))
}
AngelicBusterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SpotLightHits=3) {
  ## SpotLight
  DealCycle <- RepATKCycle(DealCycle, "SpotLight", 38, 1500, ATKFinal)
  
  if(SpotLightHits==2) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$Skills[i]=="SpotLight") {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
      }
    }
  } else if(SpotLightHits==3) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$Skills[i]=="SpotLight") {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## SpotLight Buff
  if(SpotLightHits==2) {
    DealCycle$SpotLightBuff2 <- DealCycle$SpotLightBuff1
  } else if(SpotLightHits==3) {
    DealCycle$SpotLightBuff2 <- DealCycle$SpotLightBuff1
    DealCycle$SpotLightBuff3 <- DealCycle$SpotLightBuff1
  }
  
  
  ## Super Nova, Shiny Bubble Breath
  DealCycle <- RepATKCycle(DealCycle, "SuperNova", 14, 1020, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ShinyBubbleBreath", 26, 840, ATKFinal)
  
  
  ## Trinity Fusion
  DealCycle$Skills[DealCycle$Skills=="TrinityFusion"] <- "TrinityFusionStart"
  TrinityFusionDelay <- c(900, 990, 1080, 1170, 1260, 1350, 1530, 1420, 1510)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="TrinityFusionStart") {
      for(j in 1:length(TrinityFusionDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "TrinityFusion"
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + TrinityFusionDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="TrinityFusion") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## Soul Seeker
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Trinity1", "Trinity2", "Trinity3", "FinituraFettuccia", "SuperNova", "TrinityFusion"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "SoulSeekerStart"
    }
  }
  
  SoulSeekerDelay <- c(seq(510, 510 + 240*6, 240))
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SoulSeekerStart" & DealCycle$SoulExalt[i] > 0) {
      for(j in 1:length(SoulSeekerDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("SoulSeekerSE", j, sep="")
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + SoulSeekerDelay[j]
      }
    } else if(DealCycle$Skills[i]=="SoulSeekerStart") {
      for(j in 1:length(SoulSeekerDelay)) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("SoulSeeker", j, sep="")
        DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + SoulSeekerDelay[j]
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SoulSeeker1", "SoulSeeker2", "SoulSeeker3", "SoulSeeker4", "SoulSeeker5", "SoulSeeker6", "SoulSeeker7", 
                                  "SoulSeekerSE1", "SoulSeekerSE2", "SoulSeekerSE3", "SoulSeekerSE4", "SoulSeekerSE5", "SoulSeekerSE6", "SoulSeekerSE7"))==1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Affinity IV Buff
  DealCycle$AffinityIVBuff <- 1
  
  
  ## Dummy Reduction
  DealCycle$MascotFamiliarStack <- 0
  DealCycle$MascotFamiliarDummy <- 0
  
  return(DealCycle)
}

ATKFinal <- ATKFinalSoulSeeker(ATKFinal, 0.35 + 0.01 * AngelicBusterSpec$SkillLv)
AngelicBusterDealCycle00 <- AngelicBusterCycle(DealCycle=AngelicBusterDealCycle, 
                                               ATKFinal=ATKFinal, 
                                               BuffFinal=BuffFinal, 
                                               SummonedFinal=SummonedFinal, 
                                               Spec=AngelicBusterSpec, 
                                               SkipStructure=AngelicBusterSkipATK, 
                                               Period=122, 
                                               CycleTime=244, 
                                               SoulContractReset=0, 
                                               FinituraFettucciaReset=0)
AngelicBusterDealCycle00 <- DealCycleFinal(AngelicBusterDealCycle00)
AngelicBusterDealCycle00 <- AngelicBusterAddATK(AngelicBusterDealCycle00, 
                                                ATKFinal, 
                                                BuffFinal, 
                                                SummonedFinal, 
                                                Spec=AngelicBusterSpec, 
                                                SpotLightHits=3)
AngelicBusterDealCycle00 <- OverDriveExhaustBuff(AngelicBusterDealCycle00, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
AngelicBusterDealCycleReduction <- DealCycleReduction(AngelicBusterDealCycle00)

for(i in 0:2) {
  for(j in 0:2) {
    ABDealCycle <- data.frame()
    ABDealCycle <- AngelicBusterCycle(DealCycle=AngelicBusterDealCycle, 
                                      ATKFinal=ATKFinal, 
                                      BuffFinal=BuffFinal, 
                                      SummonedFinal=SummonedFinal, 
                                      Spec=AngelicBusterSpec, 
                                      SkipStructure=AngelicBusterSkipATK, 
                                      Period=122, 
                                      CycleTime=244, 
                                      SoulContractReset=i, 
                                      FinituraFettucciaReset=j)
    ABDealCycle <- DealCycleFinal(ABDealCycle)
    ABDealCycle <- AngelicBusterAddATK(ABDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       Spec=AngelicBusterSpec, 
                                       SpotLightHits=3)
    ABDealCycle <- OverDriveExhaustBuff(ABDealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
    
    assign(paste("AngelicBusterDealCycle", i, j, sep=""), ABDealCycle)
    assign(paste("AngelicBusterDealCycleReduction", i, j, sep=""), ABDealCycleReduction)
    print(paste("i=", i, " done, j=", j, " done", sep=""))
  }
}

AngelicBusterDealCycles <- list(AngelicBusterDealCycle00, AngelicBusterDealCycle10, AngelicBusterDealCycle20, 
                                AngelicBusterDealCycle01, AngelicBusterDealCycle11, AngelicBusterDealCycle21, 
                                AngelicBusterDealCycle02, AngelicBusterDealCycle12, AngelicBusterDealCycle22)
AngelicBusterDealCycleTimes <- c(max(AngelicBusterDealCycle00$Time), max(AngelicBusterDealCycle10$Time), max(AngelicBusterDealCycle20$Time), 
                                 max(AngelicBusterDealCycle01$Time), max(AngelicBusterDealCycle11$Time), max(AngelicBusterDealCycle21$Time), 
                                 max(AngelicBusterDealCycle02$Time), max(AngelicBusterDealCycle12$Time), max(AngelicBusterDealCycle22$Time))
AngelicBusterDealCycleProbs <- c(0.45 * 0.45,        0.55 * 0.45 * 0.45,        0.55 * 0.55 * 0.45, 
                                 0.45 * 0.55 * 0.45, 0.55 * 0.45 * 0.55 * 0.45, 0.55 * 0.55 * 0.55 * 0.45, 
                                 0.45 * 0.55 * 0.55, 0.55 * 0.55 * 0.55 * 0.45, 0.55 * 0.55 * 0.55 * 0.55)
AngelicBusterDealCycleTime <- sum(AngelicBusterDealCycleTimes * AngelicBusterDealCycleProbs)

for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="AngelicBuster") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  AngelicBusterSpecOpt1 <- Optimization1(AngelicBusterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpec, AngelicBusterUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- AngelicBusterSpecOpt1[1, 1:3]
} else {
  AngelicBusterSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
AngelicBusterSpecOpt <- OptDataAdd(AngelicBusterSpec, AngelicBusterSpecOpt1, "Potential", AngelicBusterBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  AngelicBusterSpecOpt2 <- Optimization2(AngelicBusterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterHyperStatBase, AngelicBusterBase$ChrLv, AngelicBusterBase$CRROver, 
                                         HyperStanceLv=5)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- AngelicBusterSpecOpt2[1, ]
} else {
  AngelicBusterSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
AngelicBusterSpecOpt <- OptDataAdd(AngelicBusterSpecOpt, AngelicBusterSpecOpt2, "HyperStat", AngelicBusterBase$CRROver, DemonAvenger=F)

AngelicBusterFinalDPM <- ResetDealCalc(AngelicBusterDealCycles, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)
AngelicBusterFinalDPMwithMax <- ResetDealCalcWithMaxDMR(AngelicBusterDealCycles, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)

set(get(DPMCalcOption$DataName), as.integer(1), "AngelicBuster", sum(na.omit(AngelicBusterFinalDPMwithMax)) / (AngelicBusterDealCycleTime / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "AngelicBuster", sum(na.omit(AngelicBusterFinalDPM)) / (AngelicBusterDealCycleTime / 60000) - sum(na.omit(AngelicBusterFinalDPMwithMax)) / (AngelicBusterDealCycleTime / 60000))

AngelicBusterDealDatas <- list(DealCalcWithMaxDMR(AngelicBusterDealCycle00, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle10, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle20, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle01, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle11, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle21, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle02, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt),
                               DealCalcWithMaxDMR(AngelicBusterDealCycle12, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt), 
                               DealCalcWithMaxDMR(AngelicBusterDealCycle22, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
AngelicBusterDealRatio <- ResetDealRatio(DealCycles=AngelicBusterDealCycles, 
                                         DealDatas=AngelicBusterDealDatas, 
                                         AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)

AngelicBusterDealDataRR <- data.frame(AngelicBusterDealCycle11$Skills, AngelicBusterDealCycle11$Time, AngelicBusterDealCycle11$Restraint4, 
                                      DealCalcWithMaxDMR(AngelicBusterDealCycle11, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealDataRR) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "AngelicBuster", Deal_RR(AngelicBusterDealDataRR))

AngelicBusterDealData <- data.frame(AngelicBusterDealCycle00$Skills, AngelicBusterDealCycle00$Time, AngelicBusterDealCycle00$Restraint4, 
                                    DealCalcWithMaxDMR(AngelicBusterDealCycle00, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(4), "AngelicBuster", Deal_40s(AngelicBusterDealData, F, StartTime=subset(AngelicBusterDealData, AngelicBusterDealData$Skills=="FinituraFettuccia")$Time[1]))

AngelicBusterSpecMean <- ResetSpecMean("AngelicBuster", 
                                       AngelicBusterDealCycles, 
                                       AngelicBusterDealDatas, 
                                       ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)


## SpotLight 2 Hits
for(i in 0:2) {
  for(j in 0:2) {
    ABDealCycle <- data.frame()
    ABDealCycle <- AngelicBusterCycle(DealCycle=AngelicBusterDealCycle, 
                                      ATKFinal=ATKFinal, 
                                      BuffFinal=BuffFinal, 
                                      SummonedFinal=SummonedFinal, 
                                      Spec=AngelicBusterSpec, 
                                      SkipStructure=AngelicBusterSkipATK, 
                                      Period=120, 
                                      CycleTime=240, 
                                      SoulContractReset=i, 
                                      FinituraFettucciaReset=j)
    ABDealCycle <- DealCycleFinal(ABDealCycle)
    ABDealCycle <- AngelicBusterAddATK(ABDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       Spec=AngelicBusterSpec, 
                                       SpotLightHits=2)
    ABDealCycle <- OverDriveExhaustBuff(ABDealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
    
    assign(paste("AngelicBusterDealCycle2Hits", i, j, sep=""), ABDealCycle)
    print(paste("i=", i, " done, j=", j, " done", sep=""))
  }
}

AngelicBusterDealCycles2Hits <- list(AngelicBusterDealCycle2Hits00, AngelicBusterDealCycle2Hits10, AngelicBusterDealCycle2Hits20, 
                                     AngelicBusterDealCycle2Hits01, AngelicBusterDealCycle2Hits11, AngelicBusterDealCycle2Hits21, 
                                     AngelicBusterDealCycle2Hits02, AngelicBusterDealCycle2Hits12, AngelicBusterDealCycle2Hits22)

AngelicBusterDPM2Hits <- ResetDealCalcWithMaxDMR(DealCycles=AngelicBusterDealCycles2Hits, 
                                                 ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)
SpotLight2HitsDPM <- sum(na.omit(AngelicBusterDPM2Hits)) / (AngelicBusterDealCycleTime / 60000)

AngelicBusterDealData2Hits <- data.frame(AngelicBusterDealCycle2Hits11$Skills, AngelicBusterDealCycle2Hits11$Time, AngelicBusterDealCycle2Hits11$Restraint4, 
                                         DealCalcWithMaxDMR(AngelicBusterDealCycle2Hits11, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealData2Hits) <- c("Skills", "Time", "R4", "Deal")
AngelicBusterRR2Hits <- Deal_RR(AngelicBusterDealData2Hits)

AngelicBusterDealData22Hits <- data.frame(AngelicBusterDealCycle2Hits00$Skills, AngelicBusterDealCycle2Hits00$Time, AngelicBusterDealCycle2Hits00$Restraint4, 
                                          DealCalcWithMaxDMR(AngelicBusterDealCycle2Hits00, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealData22Hits) <- c("Skills", "Time", "R4", "Deal")
AngelicBuster40s2Hits <- Deal_40s(AngelicBusterDealData22Hits, F, StartTime=subset(AngelicBusterDealData22Hits, AngelicBusterDealData22Hits$Skills=="FinituraFettuccia")$Time[1])


## SpotLight 1 Hit
for(i in 0:2) {
  for(j in 0:2) {
    ABDealCycle <- data.frame()
    ABDealCycle <- AngelicBusterCycle(DealCycle=AngelicBusterDealCycle, 
                                      ATKFinal=ATKFinal, 
                                      BuffFinal=BuffFinal, 
                                      SummonedFinal=SummonedFinal, 
                                      Spec=AngelicBusterSpec, 
                                      SkipStructure=AngelicBusterSkipATK, 
                                      Period=120, 
                                      CycleTime=240, 
                                      SoulContractReset=i, 
                                      FinituraFettucciaReset=j)
    ABDealCycle <- DealCycleFinal(ABDealCycle)
    ABDealCycle <- AngelicBusterAddATK(ABDealCycle, 
                                       ATKFinal, 
                                       BuffFinal, 
                                       SummonedFinal, 
                                       Spec=AngelicBusterSpec, 
                                       SpotLightHits=1)
    ABDealCycle <- OverDriveExhaustBuff(ABDealCycle, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$Duration, BuffFinal[rownames(BuffFinal)=="OverDrive", ]$CoolTime)
    
    assign(paste("AngelicBusterDealCycle1Hit", i, j, sep=""), ABDealCycle)
    print(paste("i=", i, " done, j=", j, " done", sep=""))
  }
}

AngelicBusterDealCycles1Hit <- list(AngelicBusterDealCycle1Hit00, AngelicBusterDealCycle1Hit10, AngelicBusterDealCycle1Hit20, 
                                    AngelicBusterDealCycle1Hit01, AngelicBusterDealCycle1Hit11, AngelicBusterDealCycle1Hit21, 
                                    AngelicBusterDealCycle1Hit02, AngelicBusterDealCycle1Hit12, AngelicBusterDealCycle1Hit22)

AngelicBusterDPM1Hit <- ResetDealCalcWithMaxDMR(DealCycles=AngelicBusterDealCycles1Hit, 
                                                ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt, AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)
SpotLight1HitDPM <- sum(na.omit(AngelicBusterDPM1Hit)) / (AngelicBusterDealCycleTime / 60000)

AngelicBusterDealData1Hit <- data.frame(AngelicBusterDealCycle1Hit11$Skills, AngelicBusterDealCycle1Hit11$Time, AngelicBusterDealCycle1Hit11$Restraint4, 
                                        DealCalcWithMaxDMR(AngelicBusterDealCycle1Hit11, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealData1Hit) <- c("Skills", "Time", "R4", "Deal")
AngelicBusterRR1Hit <- Deal_RR(AngelicBusterDealData1Hit)

AngelicBusterDealData21Hit <- data.frame(AngelicBusterDealCycle1Hit00$Skills, AngelicBusterDealCycle1Hit00$Time, AngelicBusterDealCycle1Hit00$Restraint4, 
                                         DealCalcWithMaxDMR(AngelicBusterDealCycle1Hit00, ATKFinal, BuffFinal, SummonedFinal, AngelicBusterSpecOpt))
colnames(AngelicBusterDealData21Hit) <- c("Skills", "Time", "R4", "Deal")
AngelicBuster40s1Hit <- Deal_40s(AngelicBusterDealData21Hit, F, StartTime=subset(AngelicBusterDealData21Hit, AngelicBusterDealData21Hit$Skills=="FinituraFettuccia")$Time[1])

print(list(ABSpotlight2Hits=data.frame(SpotLight2HitsDPM=SpotLight2HitsDPM, AngelicBusterRR2Hits=AngelicBusterRR2Hits, AngelicBuster40s2Hits=AngelicBuster40s2Hits), 
           ABSpotlight1Hit=data.frame(SpotLight1HitDPM=SpotLight1HitDPM, AngelicBusterRR1Hit=AngelicBusterRR1Hit, AngelicBuster40s1Hit=AngelicBuster40s1Hit)))