## SoulMaster - Data
## SoulMaster - VMatrix
SoulMasterCoreBase <- CoreBuilder(ActSkills=c("CelestialDance", "Elysion", "SoulEclipse", "FlareSlash",
                                              CommonV("Warrior", "CygnusKnights")), 
                                  ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                  UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                  SpecSet=get(DPMCalcOption$SpecSet), 
                                  VPassiveList=SoulMasterVPassive, 
                                  VPassivePrior=SoulMasterVPrior, 
                                  SelfBind=T)

SoulMasterCore <- MatrixSet(PasSkills=SoulMasterCoreBase$PasSkills$Skills, 
                            PasLvs=SoulMasterCoreBase$PasSkills$Lv, 
                            PasMP=SoulMasterCoreBase$PasSkills$MP, 
                            ActSkills=SoulMasterCoreBase$ActSkills$Skills, 
                            ActLvs=SoulMasterCoreBase$ActSkills$Lv, 
                            ActMP=SoulMasterCoreBase$ActSkills$MP, 
                            UsefulSkills=SoulMasterCoreBase$UsefulSkills, 
                            UsefulLvs=20, 
                            UsefulMP=0, 
                            SpecSet=get(DPMCalcOption$SpecSet), 
                            SpecialCore=SoulMasterCoreBase$SpecialCoreUse)


## SoulMaster - Basic Info
SoulMasterBase <- JobBase(ChrInfo=ChrInfo, 
                          MobInfo=get(DPMCalcOption$MobSet),
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          Job="SoulMaster",
                          CoreData=SoulMasterCore, 
                          BuffDurationNeeded=0, 
                          AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "SoulMaster"), 
                          LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "SoulMaster"), 
                          MonsterLife=get(FindJob(MonsterLifePreSet, "SoulMaster")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                          Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandSword", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                          WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                          SubWeapon=SubWeapon[rownames(SubWeapon)=="CygnusKnightsJewel", ], 
                          Emblem=Emblem[rownames(Emblem)=="Cygnus", ], 
                          CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "SoulMaster")))


## SoulMaster - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(SoulMasterBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(10)
ElementSoul <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
SwordofLight <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
InnerTrust <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(40, 20)
BodyandSoul <- data.frame(option, value)

option <- factor(c("ATK", "MainStat"), levels=PSkill)
value <- c(30, 40)
InnerShout <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1", "CRR"), levels=PSkill)
value <- c(30 + SoulMasterBase$PSkillLv, 30 + SoulMasterBase$PSkillLv, 10)
SoulPledge <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(SoulMasterBase$PSkillLv/2), 50 + SoulMasterBase$PSkillLv, 15 + floor(SoulMasterBase$PSkillLv/3))
SwordExpert <- data.frame(option, value)

option <- factor(c("IGR", "BDR"), levels=PSkill)
value <- c(30 + 2 * SoulMasterBase$PSkillLv, 15 + SoulMasterBase$PSkillLv)
Unforeseeable <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(SoulMasterCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(SoulMasterCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(SoulMasterCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

SoulMasterPassive <- Passive(list(ElementalHarmony=ElementalHarmony, ElementalExpert=ElementalExpert, ElementSoul=ElementSoul, SwordofLight=SwordofLight, 
                                  InnerTrust=InnerTrust, BodyandSoul=BodyandSoul, InnerShout=InnerShout, SoulPledge=SoulPledge, SwordExpert=SwordExpert, 
                                  Unforeseeable=Unforeseeable, BodyofSteelPassive=BodyofSteelPassive, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## SoulMaster - Buff
{option <- factor(c("ATKSpeed"), levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
NimbleFinger <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR", "ImmuneIgnore"), levels=BSkill)
value <- c(20, 5, 10)
info <- c(1, 5, 30, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TrueSight <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "FDR", "ATKSpeed", "ATK"), levels=BSkill)
value <- c(35 + floor(SoulMasterBase$PSkillLv/2), 25, 2, 30 + SoulMasterBase$PSkillLv + floor(SoulMasterBase$PSkillLv/2))
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SolunarTime <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "FDR"), levels=BSkill)
value <- c(50, 10)
info <- c(180, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulForge <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((SoulMasterBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(SoulMasterBase$SkillLv/2))))
info <- c(900 + 30 * SoulMasterBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 5, 360, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SolunarSlashDummy <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryofGardians <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(SoulMasterCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(40 + GetCoreLv(SoulMasterCore, "CelestialDance"), 150, 570, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CelestialDance <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 180, 750, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Elysion <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 180, 360, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulEclipse <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(SoulMasterCore, "AuraWeapon")/5), ceiling(GetCoreLv(SoulMasterCore, "AuraWeapon")/5))
info <- c(80 + 2 * GetCoreLv(SoulMasterCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofCygnus <- rbind(data.frame(option, value), info)}

SoulMasterBuff <- list(NimbleFinger=NimbleFinger, TrueSight=TrueSight, SolunarTime=SolunarTime, SoulForge=SoulForge, MapleSoldier=MapleSoldier, 
                       SolunarSlashDummy=SolunarSlashDummy, GloryofGardians=GloryofGardians, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, CelestialDance=CelestialDance, 
                       Elysion=Elysion, SoulEclipse=SoulEclipse, AuraWeaponBuff=AuraWeaponBuff, BlessofCygnus=BlessofCygnus, 
                       Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : NimbleFinger(600ms), SoulForge(810ms), MapleSoldier(0ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms), (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  SoulMasterBuff[[length(SoulMasterBuff)+1]] <- UsefulAdvancedBless
  names(SoulMasterBuff)[[length(SoulMasterBuff)]] <- "UsefulAdvancedBless"
}
SoulMasterBuff <- Buff(SoulMasterBuff)
SoulMasterAllTimeBuff <- AllTimeBuff(SoulMasterBuff)


## SoulMaster - Union & HyperStat & SoulWeapon
SoulMasterSpec <- JobSpec(JobBase=SoulMasterBase, 
                          Passive=SoulMasterPassive, 
                          AllTimeBuff=SoulMasterAllTimeBuff, 
                          MobInfo=get(DPMCalcOption$MobSet), 
                          SpecSet=get(DPMCalcOption$SpecSet), 
                          WeaponName="TwohandSword", 
                          UnionStance=0)

SoulMasterUnionRemained <- SoulMasterSpec$UnionRemained
SoulMasterHyperStatBase <- SoulMasterSpec$HyperStatBase
SoulMasterCoolReduceType <- SoulMasterSpec$CoolReduceType
SoulMasterSpec <- SoulMasterSpec$Spec


## SoulMaster - Spider In Mirror
SIM <- SIMData(GetCoreLv(SoulMasterCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## SoulMaster - Attacks
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9, 8, 480, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DanceofMoon <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9, 8, 420, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DanceofMoonAir <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9, 8, 360, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpeedingSunset <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9, 8, 360, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpeedingSunsetAir <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(SoulMasterCore, "SolunarSlash")>=40, 20, 0), 2 * GetCoreLv(SoulMasterCore, "SolunarSlash"))
info <- c((240 + 3 * SoulMasterSpec$SkillLv) * 0.9, 12, 450, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SolunarSlashATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill) 
value <- c(ifelse(GetCoreLv(SoulMasterCore, "CrosstheStyx")>=40, 20, 0), 2 * GetCoreLv(SoulMasterCore, "CrosstheStyx"))
info <- c((287 + 3 * GetCoreLv(SoulMasterCore, "Elysion")) * 0.9, 10, 840, 30, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrosstheStyx <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c((500 + 20 * GetCoreLv(SoulMasterCore, "AuraWeapon")) * 0.9, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(1200 + 40 * GetCoreLv(SoulMasterCore, "CelestialDance"), 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CDAfterimageRS <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(600 + 20 * GetCoreLv(SoulMasterCore, "CelestialDance"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CDAfterimageFM <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9 * (0.3 + 0.01 * GetCoreLv(SoulMasterCore, "CelestialDance")), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DanceofMoonCD <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9 * (0.3 + 0.01 * GetCoreLv(SoulMasterCore, "CelestialDance")), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DanceofMoonAirCD <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9 * (0.3 + 0.01 * GetCoreLv(SoulMasterCore, "CelestialDance")), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpeedingSunsetCD <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill) 
value <- c(40, IGRCalc(c(ifelse(GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset")>=40, 20, 0), 20)), 2 * GetCoreLv(SoulMasterCore, "DanceofMoon_SpeedingSunset"))
info <- c((400 + 4 * SoulMasterSpec$SkillLv) * 0.9 * (0.3 + 0.01 * GetCoreLv(SoulMasterCore, "CelestialDance")), 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SpeedingSunsetAirCD <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(520 + 21 * GetCoreLv(SoulMasterCore, "Elysion"), 6, 0, 125, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElysionCrack <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(150 + 6 * GetCoreLv(SoulMasterCore, "Elysion"), 6, 0, 125, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElysionCrack1 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(225 + 9 * GetCoreLv(SoulMasterCore, "Elysion"), 6, 0, 125, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElysionCrack2 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(350 + 14 * GetCoreLv(SoulMasterCore, "Elysion"), 6, 0, 125, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ElysionCrack3 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(450 + 18 * GetCoreLv(SoulMasterCore, "SoulEclipse"), 7, 0, 1000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulEclipseEC <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c(1250 + 50 * GetCoreLv(SoulMasterCore, "SoulEclipse"), 15, 990, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SoulEclipseSD <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill) 
value <- c()
info <- c((550 + 22 * GetCoreLv(SoulMasterCore, "FlareSlash")) * 0.9, 14, 0, NA, 12, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FlareSlash <- rbind(data.frame(option, value), info)}

SoulMasterATK <- Attack(list(DanceofMoon=DanceofMoon, DanceofMoonAir=DanceofMoonAir, SpeedingSunset=SpeedingSunset, SpeedingSunsetAir=SpeedingSunsetAir, SolunarSlashATK=SolunarSlashATK, CrosstheStyx=CrosstheStyx, 
                             AuraWeapon=AuraWeapon, CDAfterimageRS=CDAfterimageRS, CDAfterimageFM=CDAfterimageFM, DanceofMoonCD=DanceofMoonCD, DanceofMoonAirCD=DanceofMoonAirCD, 
                             SpeedingSunsetCD=SpeedingSunsetCD, SpeedingSunsetAirCD=SpeedingSunsetAirCD, ElysionCrack=ElysionCrack, ElysionCrack1=ElysionCrack1, ElysionCrack2=ElysionCrack2, ElysionCrack3=ElysionCrack3,
                             SoulEclipseEC=SoulEclipseEC, SoulEclipseSD=SoulEclipseSD, 
                             FlareSlash=FlareSlash, SpiderInMirror=SpiderInMirror))


## SoulMaster - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(SoulMasterCore, "CygnusPhalanx"), 1, 780, 240, 0.24 * (39 + GetCoreLv(SoulMasterCore, "CygnusPhalanx")) + 0.25, 30, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
CygnusPhalanx <- rbind(data.frame(option, value), info)}

SoulMasterSummoned <- Summoned(list(CygnusPhalanx=CygnusPhalanx, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, 
                                    SpiderInMirror3=SpiderInMirror3, SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## SoulMaster - DealCycle & Deal Calculation
ATKFinal <- data.frame(SoulMasterATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, SoulMasterSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, SoulMasterSpec$CoolReduceP, SoulMasterSpec$CoolReduce)

BuffFinal <- data.frame(SoulMasterBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, SoulMasterSpec$CoolReduceP, SoulMasterSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, SoulMasterSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(SoulMasterSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, SoulMasterSpec$CoolReduceP, SoulMasterSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * SoulMasterSpec$SummonedDuration / 100, 0)


## SoulMaster - Deal Cycle
DealCycle <- c("Skills", "Time", rownames(SoulMasterBuff))
SoulMasterDealCycle <- t(rep(0, length(DealCycle)))
colnames(SoulMasterDealCycle) <- DealCycle
SoulMasterDealCycle <- data.frame(SoulMasterDealCycle)

SoulMasterCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, CycleTime=360) {
  BuffSummonedPrior <- c("NimbleFinger", "SolunarTime", "SoulForge", "MapleSoldier", "UsefulCombatOrders", "UsefulSharpEyes", 
                         "GloryofGardians", "AuraWeaponBuff", "CygnusPhalanx", "TrueSight", "SolunarSlashDummy", "BlessofCygnus", "SoulEclipse", "Elysion", "CelestialDance",
                         "SoulContractLink", "Restraint4")

  Time0 <- c(0, 180, 240)
  Time0 <- Time0 * ((100 - Spec$CoolReduceP) / 100)
  
  BuffIdx <- list()
  BuffIdx[[1]] <- c(9, 1, 2, 4, 8, 10, 11, 12, 13, 14)
  BuffIdx[[2]] <- c(9, 1, 2, 4, 8, 10, 11, 13, 14)
  BuffIdx[[3]] <- c(9, 10, 11, 15)
  
  BuffList <- list()
  for(i in 1:3) {
    BuffList[[i]] <- BuffSummonedPrior[BuffIdx[[i]]]
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
  
  # PhalanxTime <- sum(BuffDelays[[1]][1:(length(BuffDelays[[1]])-5)])/1000 + 28.5
  PhalanxTime <- 30 * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  # SoulContractTime <- sum(BuffDelays[[1]][1:(length(BuffDelays[[1]])-2)])/1000 + 26
  
  PhalanxSubTime <- 30 * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  # SoulContractSubTime <- 90 * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
  
  Time1 <- c(PhalanxTime)
  while(max(Time1) + PhalanxSubTime < TotalTime) {
    Time1 <- c(Time1, Time1[length(Time1)] + PhalanxSubTime)
  }
  # Time2 <- c(SoulContractTime)
  # while(max(Time2) + SoulContractSubTime < TotalTime) {
  #   Time2 <- c(Time2, Time2[length(Time2)] + SoulContractSubTime)
  # }
  Time3 <- sum(BuffDelays[[1]][1:(length(BuffDelays[[1]])-1)])/1000 + 40 + General$General$Serverlag
  
  TimeTypes <- c(Time0, Time1, Time3)
  TimeTypes <- unique(TimeTypes)
  TimeTypes <- TimeTypes[order(TimeTypes)]
  BuffIdxNew <- list()
  for(i in 1:length(TimeTypes)) {
    for(j in 1:3) {
      if(TimeTypes[i]==Time0[j]) {
        BuffIdxNew[[i]] <- BuffIdx[[j]]
      }
    }
    if(sum(TimeTypes[i]==Time1[c(1, 7)])==1 & sum(TimeTypes[i]==Time0)==0) {
      BuffIdxNew[[i]] <- c(9, 10, 11, 16, 17)
#    } else if(sum(TimeTypes[i]==Time2[c(1, 3)])==1) {
#      BuffIdxNew[[i]] <- c(16, 17)
#    } else if(sum(TimeTypes[i]==Time2[c(2, 4)])==1) {
#      BuffIdxNew[[i]] <- c(16)
    } else if(sum(TimeTypes[i]==Time1[c(4, 10)])==1 & sum(TimeTypes[i]==Time0)==0) {
      BuffIdxNew[[i]] <- c(9, 10, 11, 16)
    } else if(sum(TimeTypes[i]==Time1)==1 & sum(TimeTypes[i]==Time0)==0) {
      BuffIdxNew[[i]] <- c(9, 10, 11)
    } else if(TimeTypes[i]==Time3) {
      BuffIdxNew[[i]] <- c(15)
    }
  }
  
  BuffList <- list()
  for(i in 1:length(BuffIdxNew)) {
    BuffList[[i]] <- BuffSummonedPrior[BuffIdxNew[[i]]]
  }
  
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
  
  Stance1 <- "RS"
  Stance2 <- "Stand"
  
  DealCycle <- PreDealCycle
  DealCycle <- DCBuff(DealCycle, "GloryofGardians", BuffFinal)
  DealCycle <- DCBuff(DealCycle, "SoulForge", BuffFinal)
  DealCycle <- DCBuff(DealCycle, "UsefulCombatOrders", BuffFinal)
  DealCycle <- DCBuff(DealCycle, "UsefulSharpEyes", BuffFinal)
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)]=="TrueSight") {
        DealCycle$TrueSight[nrow(DealCycle)] <- 30000
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < TimeTypes[2] * 1000) {
    if(DealCycle$Elysion[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "CrosstheStyx", ATKFinal)
      Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunset", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Air"
    } else if(Stance1=="FM" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "DanceofMoon", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunsetAir", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Stand"
    } else if(Stance1=="FM" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "DanceofMoonAir", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Air"
    }
  }
  
  for(i in 1:length(BuffList[[2]])) {
    if(sum(rownames(BuffFinal)==BuffList[[2]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[2]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)]=="TrueSight") {
        DealCycle$TrueSight[nrow(DealCycle)] <- 30000
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[2]][i], SummonedFinal)
    }
  }
  Stance2 <- "Stand"
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < TimeTypes[3] * 1000) {
    if(DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] > 750 & DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] < 1500 &
       DealCycle$SoulEclipse[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "SoulEclipseSD", ATKFinal)
      Stance2 <- "Stand"
    }
    if(DealCycle$Elysion[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "CrosstheStyx", ATKFinal)
      Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunset", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Air"
    } else if(Stance1=="FM" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "DanceofMoon", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunsetAir", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Stand"
    } else if(Stance1=="FM" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "DanceofMoonAir", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Air"
    }
  }
  
  for(i in 1:length(BuffList[[3]])) {
    if(sum(rownames(BuffFinal)==BuffList[[3]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[3]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)]=="TrueSight") {
        DealCycle$TrueSight[nrow(DealCycle)] <- 30000
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[3]][i], SummonedFinal)
    }
  }
  Stance2 <- "Stand"
  
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < TimeTypes[4] * 1000) {
    if(DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] > 750 & DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] < 1500 &
       DealCycle$SoulEclipse[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "SoulEclipseSD", ATKFinal)
      Stance2 <- "Stand"
    }
    if(DealCycle$Elysion[nrow(DealCycle)] > 0) {
      DealCycle <- DCATK(DealCycle, "CrosstheStyx", ATKFinal)
      Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunset", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Air"
    } else if(Stance1=="FM" & Stance2=="Stand") {
      DealCycle <- DCATK(DealCycle, "DanceofMoon", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Stand"
    } else if(Stance1=="RS" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "SpeedingSunsetAir", ATKFinal)
      Stance1 <- "FM" ; Stance2 <- "Stand"
    } else if(Stance1=="FM" & Stance2=="Air") {
      DealCycle <- DCATK(DealCycle, "DanceofMoonAir", ATKFinal)
      Stance1 <- "RS" ; Stance2 <- "Air"
    }
  }
  
  for(i in 1:length(BuffList[[4]])) {
    if(sum(rownames(BuffFinal)==BuffList[[4]][i]) > 0) {
      DealCycle <- DCBuff(DealCycle, BuffList[[4]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)]=="TrueSight") {
        DealCycle$TrueSight[nrow(DealCycle)] <- 30000
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[4]][i], SummonedFinal)
    }
  }
  Stance2 <- "Stand"
  
  Cool <- c()
  for(i in 1:length(BuffSummonedPrior)) {
    if(nrow(subset(BuffFinal, rownames(BuffFinal)==BuffSummonedPrior[i]))==0) {
      Cool[i] <- subset(SummonedFinal, rownames(SummonedFinal)==BuffSummonedPrior[i])$CoolTime
    } else {
      Cool[i] <- subset(BuffFinal, rownames(BuffFinal)==BuffSummonedPrior[i])$CoolTime
    }
  }
  CoolList <- data.frame(Skills=BuffSummonedPrior, CoolTime=Cool, stringsAsFactors=F)
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes[length(TimeTypes)+1] <- TotalTime
  
  for(k in 5:length(BuffList)) {
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
      BuffEndTime[i] <- max(a$Time) + subset(CoolList, CoolList$Skills==BuffList[[k]][i])$CoolTime * 1000 + 
        sum(CycleBuffList$Delay[Idx:nrow(CycleBuffList)])
    }
    BuffEndTime <- max(BuffEndTime)
    BuffStartTime <- max(TimeTypes[k] * 1000, BuffEndTime - sum(CycleBuffList$Delay))
    while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime) {
      if(DealCycle$GloryofGardians[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
        DealCycle <- DCBuff(DealCycle, "GloryofGardians", BuffFinal)
      }
      if(DealCycle$SoulForge[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
        DealCycle <- DCBuff(DealCycle, "SoulForge", BuffFinal)
      }
      if(DealCycle$UsefulCombatOrders[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
        DealCycle <- DCBuff(DealCycle, "UsefulCombatOrders", BuffFinal)
      }
      if(DealCycle$UsefulSharpEyes[nrow(DealCycle)] - DealCycle$Time[1] < 3000) {
        DealCycle <- DCBuff(DealCycle, "UsefulSharpEyes", BuffFinal)
      }
      if(DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] > 750 & DealCycle$SoulEclipse[nrow(DealCycle)] - DealCycle$Time[1] < 1500 &
         DealCycle$SoulEclipse[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "SoulEclipseSD", ATKFinal)
        Stance2 <- "Stand"
      }
      if(DealCycle$Elysion[nrow(DealCycle)] > 0) {
        DealCycle <- DCATK(DealCycle, "CrosstheStyx", ATKFinal)
        Stance2 <- "Stand"
      } else if(Stance1=="RS" & Stance2=="Stand") {
        DealCycle <- DCATK(DealCycle, "SpeedingSunset", ATKFinal)
        Stance1 <- "FM" ; Stance2 <- "Air"
      } else if(Stance1=="FM" & Stance2=="Stand") {
        DealCycle <- DCATK(DealCycle, "DanceofMoon", ATKFinal)
        Stance1 <- "RS" ; Stance2 <- "Stand"
      } else if(Stance1=="RS" & Stance2=="Air") {
        DealCycle <- DCATK(DealCycle, "SpeedingSunsetAir", ATKFinal)
        Stance1 <- "FM" ; Stance2 <- "Stand"
      } else if(Stance1=="FM" & Stance2=="Air") {
        DealCycle <- DCATK(DealCycle, "DanceofMoonAir", ATKFinal)
        Stance1 <- "RS" ; Stance2 <- "Air"
      }
    }
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          if(DealCycle$Skills[nrow(DealCycle)]=="TrueSight") {
            DealCycle$TrueSight[nrow(DealCycle)] <- 30000
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
        }
      }
    }
    Stance2 <- "Stand"
    
    if(k == (length(BuffList)-1)) {
      u <- BuffSummonedPrior[BuffSummonedPrior!="GloryofGardians"]
      u1 <- u
      u[u=="CygnusPhalanx"] <- "CygnusPhalanxSummoned"
      for(i in 1:length(u)) {
        MaxTime <- max(subset(DealCycle, DealCycle$Skills==u[i])$Time)
        minTime <- min(subset(DealCycle, DealCycle$Skills==u[i])$Time)
        TimeTypes[length(TimeTypes)] <- max(TimeTypes[length(TimeTypes)], MaxTime / 1000 + subset(CoolList, CoolList$Skills==u1[i])$CoolTime - minTime / 1000)
      }
    }
  }
  DealCycle <- DealCycleFinal(DealCycle)
  return(DealCycle)
}
SoulMasterAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SoulEclipse") {
      DealCycle$Skills[i] <- "SoulEclipseEC"
    } else if(DealCycle$Skills[i]=="SolunarSlashDummy") {
      DealCycle$Skills[i] <- "SolunarSlashATK"
    }
  }
  
  
  ## Elysion Crack
  CrackDummy <- 0 ; CrackCool <- 0
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i]=="Elysion") {
      CrackDummy <- 0
    } else if(DealCycle$Skills[i]=="CrosstheStyx" & CrackDummy==5) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("ElysionCrack")
      CrackDummy <- 0
      CrackCool <- 5000
    } else if(DealCycle$Skills[i]=="CrosstheStyx" & CrackCool==0) {
      CrackDummy <- CrackDummy + 1
    } 
    if(DealCycle$Skills[i]=="CrosstheStyx" & DealCycle$Elysion[i+1]==0 & DealCycle$Elysion[i] > 0) {
      if(CrackDummy==1) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("ElysionCrack1")
      } else if(CrackDummy==2 | CrackDummy==3) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("ElysionCrack2")
      } else if(CrackDummy==4 | CrackDummy==5) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- c("ElysionCrack3")
      }
    }
    CrackCool <- max(0, CrackCool - (DealCycle$Time[i+1] - DealCycle$Time[i]))
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Celestial Dance AddATK
  CD <- subset(DealCycle, DealCycle$Skills=="CelestialDance")
  Ind <- rownames(CD)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$CelestialDance[p] > 0) {
      if(time > 5000 & max(DealCycle$Skills[p]==c("DanceofMoon", "DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir", "SolunarSlashATK", "CrosstheStyx", "SoulEclipseSD"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("CDAfterimageRS")
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
  
  Idx <- as.numeric(rownames(subset(DealCycle, DealCycle$Skills=="CDAfterimageRS")))
  st <- c()
  for(j in 1:length(Idx)) {
    x <- DealCycle[1:(Idx[j]-1), ]
    z <- subset(x, x$Skills=="DanceofMoon")
    StanceSkills <- c("DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir")
    for(i in 1:3) {
      z1 <- subset(x, x$Skills==StanceSkills[i])
      z <- rbind(z, z1)
    }
    z <- subset(z, z$Time==max(z$Time))$Skills
    DealCycle[Idx[j], 1] <- ifelse(max(z==c("SpeedingSunset", "SpeedingSunsetAir"))==1, "CDAfterimageFM", "CDAfterimageRS")
  }
  
  
  ## Celestial Dance Afterimage
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("DanceofMoon", "DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir"))==1 & DealCycle$CelestialDance[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[i], "CD", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Aura Weapon
  AW <- subset(DealCycle, DealCycle$Skills=="AuraWeaponBuff")
  Ind <- rownames(AW)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- DealCycle[p, 2] - DealCycle[p-1, 2]
    while(p < Ind[i+1] & DealCycle$AuraWeaponBuff[p] > 0) {
      if(time > 5000 & max(DealCycle$Skills[p]==c("DanceofMoon", "DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir", "SolunarSlashATK", "CrosstheStyx", "SoulEclipseSD"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("AuraWeapon")
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
  
  
  ## Flare Slash
  FSCool <- 0
  for(i in 1:(nrow(DealCycle)-1)) {
    if(max(DealCycle$Skills[i]==c("DanceofMoon", "DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir"))==1) {
      FSCool <- max(0, FSCool - 300)
    } else if(max(DealCycle$Skills[i]==c("DanceofMoonCD", "DanceofMoonAirCD", "SpeedingSunsetCD", "SpeedingSunsetAirCD"))==1) {
      FSCool <- max(0, FSCool - 900)
    } else if(DealCycle$Skills[i]=="CrosstheStyx") {
      FSCool <- max(0, FSCool - 1200)
    }
    if(max(DealCycle$Skills[i]==c("DanceofMoon", "DanceofMoonAir", "SpeedingSunset", "SpeedingSunsetAir", "SolunarSlashATK", "CrosstheStyx", "SoulEclipseSD"))==1 & FSCool==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- c("FlareSlash")
      FSCool <- 12000
    } 
    FSCool <- max(0, FSCool - (DealCycle$Time[i+1] - DealCycle$Time[i]))
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## RepATKs and Summoned Skills
  DealCycle <- RepATKCycle(DealCycle, "SoulEclipseEC", 39, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "SoulEclipseSD", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "CrosstheStyx", 5, 60, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ElysionCrack", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ElysionCrack1", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ElysionCrack2", 5, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ElysionCrack3", 5, 0, ATKFinal)
  DealCycle <- DCSummonedATKs(DealCycle, Skill=c("CygnusPhalanx"), SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  return(DealCycle)
}


SoulMasterDealCycle <- SoulMasterCycle(PreDealCycle=SoulMasterDealCycle, 
                                       ATKFinal=ATKFinal,
                                       BuffFinal=BuffFinal, 
                                       SummonedFinal=SummonedFinal, 
                                       Spec=SoulMasterSpec)
SoulMasterDealCycle <- SoulMasterAddATK(DealCycle=SoulMasterDealCycle, 
                                        ATKFinal=ATKFinal,
                                        BuffFinal=BuffFinal, 
                                        SummonedFinal=SummonedFinal)
SoulMasterDealCycle <- BlessofCygnusCycle(SoulMasterDealCycle, 4000, General$General$Serverlag, GetCoreLv(SoulMasterCore, "BlessofCygnus"))
SoulMasterDealCycleReduction <- DealCycleReduction(SoulMasterDealCycle, "BlessofCygnusBDR")

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="SoulMaster") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  SoulMasterSpecOpt1 <- Optimization1(SoulMasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpec, SoulMasterUnionRemained, 
                                       NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- SoulMasterSpecOpt1[1, 1:3]
} else {
  SoulMasterSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
SoulMasterSpecOpt <- OptDataAdd(SoulMasterSpec, SoulMasterSpecOpt1, "Potential", SoulMasterBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  SoulMasterSpecOpt2 <- Optimization2(SoulMasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpecOpt, SoulMasterHyperStatBase, SoulMasterBase$ChrLv, SoulMasterBase$CRROver, 
                                       NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- SoulMasterSpecOpt2[1, ]
} else {
  SoulMasterSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
SoulMasterSpecOpt <- OptDataAdd(SoulMasterSpecOpt, SoulMasterSpecOpt2, "HyperStat", SoulMasterBase$CRROver, DemonAvenger=F)

SoulMasterFinalDPM <- DealCalc(SoulMasterDealCycle, ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpecOpt, Collapse=F, 
                                NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))
SoulMasterFinalDPMwithMax <- DealCalcWithMaxDMR(SoulMasterDealCycle, ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpecOpt, 
                                                 NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "SoulMaster", sum(na.omit(SoulMasterFinalDPMwithMax)) / (max(SoulMasterDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "SoulMaster", sum(na.omit(SoulMasterFinalDPM)) / (max(SoulMasterDealCycle$Time) / 60000) - sum(na.omit(SoulMasterFinalDPMwithMax)) / (max(SoulMasterDealCycle$Time) / 60000))

SoulMasterDealRatio <- DealRatio(SoulMasterDealCycle, SoulMasterFinalDPMwithMax)

SoulMasterDealData <- data.frame(SoulMasterDealCycle$Skills, SoulMasterDealCycle$Time, SoulMasterDealCycle$Restraint4, SoulMasterFinalDPMwithMax)
colnames(SoulMasterDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "SoulMaster", Deal_RR(SoulMasterDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "SoulMaster", Deal_40s(SoulMasterDealData, F, NA, FinishTime=subset(SoulMasterDealData, SoulMasterDealData$Skills=="Restraint4")$Time[1] + 15000))

SoulMasterSpecMean <- SpecMean("SoulMaster", SoulMasterDealCycleReduction, 
                               DealCalcWithMaxDMR(SoulMasterDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpecOpt, 
                                                  NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR")), 
                               ATKFinal, BuffFinal, SummonedFinal, SoulMasterSpecOpt, 
                               NotBuffCols=c("BlessofCygnusBDR"), NotBuffColOption=c("BDR"))