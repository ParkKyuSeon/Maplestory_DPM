## Illium - Data
## Illium - VMatrix
IlliumCoreBase <- CoreBuilder(ActSkills=c("CrystalIgnition", "Gramholder", "SoulofCrystal", "CrystalGate", 
                                          CommonV("Wizard", "Lef")), 
                              ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                              UsefulSkills=c("CombatOrders", "SharpEyes"), 
                              SpecSet=get(DPMCalcOption$SpecSet), 
                              VPassiveList=IlliumVPassive, 
                              VPassivePrior=IlliumVPrior, 
                              SelfBind=F)

IlliumCore <- MatrixSet(PasSkills=IlliumCoreBase$PasSkills$Skills, 
                        PasLvs=IlliumCoreBase$PasSkills$Lv, 
                        PasMP=IlliumCoreBase$PasSkills$MP, 
                        ActSkills=IlliumCoreBase$ActSkills$Skills, 
                        ActLvs=IlliumCoreBase$ActSkills$Lv, 
                        ActMP=IlliumCoreBase$ActSkills$MP, 
                        UsefulSkills=IlliumCoreBase$UsefulSkills, 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        SpecialCore=IlliumCoreBase$SpecialCoreUse)


## Illium - Basic Info
## Link Check Needed
IlliumBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      Job="Illium",
                      CoreData=IlliumCore, 
                      BuffDurationNeeded=0, 
                      AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Illium"), 
                      LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Illium"), 
                      MonsterLife=get(FindJob(MonsterLifePreSet, "Illium")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                      Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "MagicGuntlet", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                      WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                      SubWeapon=SubWeapon[rownames(SubWeapon)=="MagicWing", ], 
                      Emblem=Emblem[rownames(Emblem)=="Crystal", ], 
                      CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Illium")))


## Illium - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[rownames(ArcaneShade)=="MagicGuntlet", 6] * 0.2), floor(IlliumBase$ItemSet$ATKSub * 0.5)))
MagicCircuit <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(20)
MagicGuntletMastery <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
BlessMark <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10)
LefMastery <- data.frame(option, value)

option <- factor(c("MainStat", "ATKP"), levels=PSkill)
value <- c(40, 10)
Tenacity <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(50, 30, 20)
EndlessResearch <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(36)
BlessMarkCompletion <- data.frame(option, value) ## 9 stack

option <- factor(c("IGR"), levels=PSkill)
value <- c(20)
CurseMarkCompletion <- data.frame(option, value)

option <- factor(c("Mastery", "ATKSpeed", "BDR", "IGR", "FDR"), levels=PSkill)
value <- c(70, 1, 30, 25, 35)
WisdomoftheCrystal <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(5 + 2 * GetCoreLv(IlliumCore, "CrystalGate"))
SoulofCrystal <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(IlliumCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(IlliumCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

IlliumPassive <- Passive(list(MagicCircuit=MagicCircuit, MagicGuntletMastery=MagicGuntletMastery, BlessMark=BlessMark, LefMastery=LefMastery, Tenacity=Tenacity, EndlessResearch=EndlessResearch, 
                              BlessMarkCompletion=BlessMarkCompletion, CurseMarkCompletion=CurseMarkCompletion, WisdomoftheCrystal=WisdomoftheCrystal, SoulofCrystal=SoulofCrystal, BlinkPassive=BlinkPassive, 
                              RopeConnectPassive=RopeConnectPassive))


## Illium - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(300, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicGuntletBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(2, 2000, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBuffDummy <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(15)
info <- c(2, 2000, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JavelinBuff <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR"), levels=BSkill)
value <- c(25, 30)
info <- c(20, 60, 30, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GloryWing <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((IlliumBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(IlliumBase$SkillLv/2))))
info <- c(900 + 30 * IlliumBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, 120, 30, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FastCharge <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RaceofGod <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(IlliumCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal1 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal2 <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + GetCoreLv(IlliumCore, "SoulofCrystal"))
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal1Glory <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + GetCoreLv(IlliumCore, "SoulofCrystal"))
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal2Glory <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "ATKSkill"), levels=BSkill)
value <- c(5 + 2 * GetCoreLv(IlliumCore, "CrystalGate"), 1)
info <- c(ceiling((130 + GetCoreLv(IlliumCore, "CrystalGate")) / (25 + General$General$Serverlag)) * (25 + General$General$Serverlag), 180, 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrystalGateBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + GetCoreLv(IlliumCore, "MagicCircuitFullDrive"))
info <- c(30 + GetCoreLv(IlliumCore, "MagicCircuitFullDrive"), 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * GetCoreLv(IlliumCore, "BlessofGrandisGoddess") + 
             (min((0.4 + 0.02 * GetCoreLv(IlliumCore, "BlessofGrandisGoddess")) * IlliumBase$ItemSet$ATKSub, floor(ArcaneShade[rownames(ArcaneShade)=="MagicGuntlet", 6] * 1.5))))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandis <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrystalCharge <- rbind(data.frame(option, value), info)}

IlliumBuff <- list(MagicGuntletBooster=MagicGuntletBooster, JavelinBuffDummy=JavelinBuffDummy, JavelinBuff=JavelinBuff, GloryWing=GloryWing, MapleSoldier=MapleSoldier, FastCharge=FastCharge, 
                   RaceofGod=RaceofGod, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, SoulofCrystal1=SoulofCrystal1, SoulofCrystal2=SoulofCrystal2, 
                   SoulofCrystal1Glory=SoulofCrystal1Glory, SoulofCrystal2Glory=SoulofCrystal2Glory, CrystalGateBuff=CrystalGateBuff, MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, 
                   BlessofGrandis=BlessofGrandis, CrystalCharge=CrystalCharge, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  IlliumBuff[[length(IlliumBuff)+1]] <- UsefulAdvancedBless
  names(IlliumBuff)[[length(IlliumBuff)]] <- "UsefulAdvancedBless"
}
IlliumBuff <- Buff(IlliumBuff)
IlliumAllTimeBuff <- AllTimeBuff(IlliumBuff)
## PetBuff : MagicGuntletBooster, MapleSoldiers, UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)


## Illium - Union & HyperStat & SoulWeapon
IlliumSpec <- JobSpec(JobBase=IlliumBase, 
                      Passive=IlliumPassive, 
                      AllTimeBuff=IlliumAllTimeBuff, 
                      MobInfo=get(DPMCalcOption$MobSet), 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      WeaponName="MagicGuntlet", 
                      UnionStance=0)

IlliumUnionRemained <- IlliumSpec$UnionRemained
IlliumHyperStatBase <- IlliumSpec$HyperStatBase
IlliumCoolReduceType <- IlliumSpec$CoolReduceType
IlliumSpec <- IlliumSpec$Spec


## Illium - Spider In Mirror
SIM <- SIMData(GetCoreLv(IlliumCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Illium - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "MotalSwing_MotalWingBeat")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "MotalSwing_MotalWingBeat"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(600 + 2 * IlliumSpec$SkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalSwing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Destruction")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Destruction"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(710 + 2 * IlliumSpec$SkillLv, 8, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Destruction <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Machina_Domination")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Machina_Domination"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(710 + 2 * IlliumSpec$SkillLv, 2, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Domination <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Machina_Domination")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Machina_Domination"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c((710 + 2 * IlliumSpec$SkillLv) * (0.01 * GetCoreLv(IlliumCore, "SoulofCrystal") + 0.5), 2, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DominationSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Destruction")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Destruction"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c((710 + 2 * IlliumSpec$SkillLv) * (0.01 * GetCoreLv(IlliumCore, "SoulofCrystal") + 0.5), 8, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DestructionSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 12, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Javelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 4, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"), 40, floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(465 + 3 * IlliumSpec$SkillLv, 7, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnhancedJavelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin")>=40, 20, 0), 40, 2 * GetCoreLv(IlliumCore, "Javelin_EnhancedJavelin"))
info <- c(250 + 5 * IlliumSpec$SkillLv, 9, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicMissile <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)
info <- c(300 + 4 * IlliumSpec$SkillLv, 1, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Orb <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "MotalSwing_MotalWingBeat")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "MotalSwing_MotalWingBeat"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(1070 + 20 * IlliumSpec$SkillLv, 15, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalWingBeat <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "CurseMark")>=40, 20, 0), 2 * GetCoreLv(IlliumCore, "CurseMark"))
info <- c(200, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CurseMark <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "CurseMark")>=40, 20, 0), 2 * GetCoreLv(IlliumCore, "CurseMark"))
info <- c(200, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CurseMarkJavelin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 660, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnitionPre <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(20, floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)
info <- c(750 + 30 * GetCoreLv(IlliumCore, "CrystalIgnition"), 4, 9340, 150, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnition <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 630, NA, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalIgnitionEnd <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "FDR"), levels=ASkill)
value <- c(20, floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)
info <- c(1000 + 40 * GetCoreLv(IlliumCore, "CrystalIgnition"), 5, 0, 1000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReactionSpectrum <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * GetCoreLv(IlliumCore, "CrystalIgnition"), 5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalGate <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(IlliumCore, "MagicCircuitFullDrive"), 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

IlliumATK <- Attack(list(MotalSwing=MotalSwing, Destruction=Destruction, Domination=Domination, DestructionSoul=DestructionSoul, DominationSoul=DominationSoul, 
                         Javelin=Javelin, JavelinAddATK=JavelinAddATK, JavelinFragment=JavelinFragment, JavelinAddFragment=JavelinAddFragment, EnhancedJavelin=EnhancedJavelin, MagicMissile=MagicMissile, Orb=Orb, 
                         MotalWingBeat=MotalWingBeat, CurseMark=CurseMark, CurseMarkJavelin=CurseMarkJavelin, CrystalIgnitionPre=CrystalIgnitionPre, CrystalIgnition=CrystalIgnition, 
                         CrystalIgnitionEnd=CrystalIgnitionEnd, ReactionSpectrum=ReactionSpectrum, CrystalGate=CrystalGate, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Illium - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(160, 1, 30, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo1Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(200, 1, 0, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(300, 1, 0, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo3Stack <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 1800, 1800, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
LiyoWait <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Machina_Domination")>=40, 20, 0), FDRCalc(c(2 * GetCoreLv(IlliumCore, "Machina_Domination"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(350, 4, 30, 3030, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Machina <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), 20, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(500 + 4 * IlliumSpec$SkillLv, 6, 30, 3030, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Deus <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), 20, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(160, 2, 30, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite1stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), 20, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(200, 2, 0, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite2stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(IlliumCore, "Deus_Liyo")>=40, 20, 0), 20, FDRCalc(c(2 * GetCoreLv(IlliumCore, "Deus_Liyo"), floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)))
info <- c(300, 2, 0, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite3stack <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 1800, 1800, NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSateliteWait <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=SSkill)
value <- c(floor(GetCoreLv(IlliumCore, "OverloadMana") / 10) + 8)
info <- c((500 + 20 * GetCoreLv(IlliumCore, "Gramholder")) * 2, 12, 210, 3030, 40, 180, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Gramholder <- rbind(data.frame(option, value), info)}

IlliumSummoned <- Summoned(list(Liyo1Stack=Liyo1Stack, Liyo2Stack=Liyo2Stack, Liyo3Stack=Liyo3Stack, LiyoWait=LiyoWait, Machina=Machina, Deus=Deus, 
                                DeusSatelite1stack=DeusSatelite1stack, DeusSatelite2stack=DeusSatelite2stack, DeusSatelite3stack=DeusSatelite3stack, DeusSateliteWait=DeusSateliteWait, 
                                Gramholder=Gramholder, SpiderInMirrorStart=SpiderInMirrorStart, 
                                SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Illium - DealCycle & Deal Calculation
ATKFinal <- data.frame(IlliumATK)
ATKFinal$Delay[c(-16, -17, -18)] <- Delay(ATKFinal$Delay, IlliumSpec$ATKSpeed)[c(-16, -17, -18)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)

BuffFinal <- data.frame(IlliumBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, IlliumSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(IlliumSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, IlliumSpec$CoolReduceP, IlliumSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * IlliumSpec$SummonedDuration / 100, 0)


## Illium - Delay Skip Structure
IlliumSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
IlliumSkipATK <- data.frame(IlliumSkipATK, row.names=c(rownames(ATKFinal)))
colnames(IlliumSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

IlliumSkipATK$Javelin <- c(rep(F, 11), T, rep(F, 10))
IlliumSkipATK$Orb <- c(rep(F, 5), T, rep(F, 16))
IlliumSkipATK$SkippedDelay <- c(rep(0, 5), Delay(500, IlliumSpec$ATKSpeed), rep(0, 5), Delay(500, IlliumSpec$ATKSpeed), rep(0, 10))
IlliumSkipATK <- subset(IlliumSkipATK, IlliumSkipATK$SkippedDelay>0)


## Illium - DealCycle
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
IlliumDealCycle <- t(rep(0, length(DealCycle)))
colnames(IlliumDealCycle) <- DealCycle
IlliumDealCycle <- data.frame(IlliumDealCycle)

IlliumCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, FastChargeReset, SoulContractReset) {
  DealCycle <- PreDealCycle
  IGDummy <- 0
  ## First Cycle
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) > 0) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCBuff(DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  DealCycle <- DCSummoned(DealCycle, "Liyo1Stack", SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, "Machina", SummonedFinal)
  while(DealCycle$CrystalCharge[nrow(DealCycle)] < 150) {
    if(DealCycle$CrystalCharge[nrow(DealCycle)] >= 40 & IGDummy == 0) {
      DealCycle <- DCBuff(DealCycle, "SoulofCrystal1", BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      IGDummy <- 1
    }
    DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
    DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
    DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
  }
  DealCycle <- DCATK(DealCycle, c("SpiderInMirror"), ATKFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("BlessofGrandis"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("MagicCircuitFullDriveBuff"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("SoulofCrystal2"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCSummoned(DealCycle, c("Deus"), SummonedFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  
  DealCycle <- DCATKSkip(DealCycle, "MotalSwing", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionPre", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCATKSkip(DealCycle, "ReactionSpectrum", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnition", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionEnd", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCSummoned(DealCycle, "Gramholder", SummonedFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]

  DealCycle <- DCBuff(DealCycle, c("GloryWing"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- 0
  
  DealCycle <- DCATKSkip(DealCycle, "MotalWingBeat", ATKFinal, SkipStructure)
  while(DealCycle$GloryWing[nrow(DealCycle)] - subset(ATKFinal, rownames(ATKFinal)=="EnhancedJavelin")$Delay > 0) {
    DealCycle <- DCATKSkip(DealCycle, "EnhancedJavelin", ATKFinal, SkipStructure)
  }
  CrystalDummy <- 0
  
  ## ith Cycle
  for(i in 2:12) {
    if(sum(i==c(4, 7, 10))==1) {
      if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) > 0) {
        DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
      }
      DealCycle <- DCBuff(DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
      CrystalDummy <- 1
    }
    if(i==7) {
      DealCycle <- DCBuff(DealCycle, c("MagicGuntletBooster"), BuffFinal)
    }
    if(sum(i==c(2, 5, 8, 11))==1 & FastChargeReset==T) {
      DealCycle <- DCBuff(DealCycle, c("FastCharge"), BuffFinal)
      CrystalDummy <- 1
    }
    
    if(sum(i==c(4, 7, 10))==0) {
      DealCycle <- DCBuff(DealCycle, c("SoulofCrystal1"), BuffFinal)
    } else {
      IGDummy <- 0
    }
    while(DealCycle$CrystalCharge[nrow(DealCycle)] < 150) {
      if(DealCycle$RaceofGod[nrow(DealCycle)] < 3000) {
        DealCycle <- DCBuff(DealCycle, "RaceofGod", BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      }
      if(CrystalDummy==0 & sum(i==c(3, 6, 9, 12))==1 & FastChargeReset==T & DealCycle$CrystalCharge[nrow(DealCycle)] >= 60) {
        DealCycle <- DCBuff(DealCycle, "SoulofCrystal2", BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
        CrystalDummy <- 1
      } else if(CrystalDummy==0 & DealCycle$CrystalCharge[nrow(DealCycle)] >= 50) {
        if(sum(i==c(3, 6, 9, 12))==1 & FastChargeReset==T) {
        } else {
        DealCycle <- DCBuff(DealCycle, "SoulofCrystal2", BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
        CrystalDummy <- 1
        }
      }
      if(sum(i==c(3, 6, 9, 12))==1 & FastChargeReset==T & 
         (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000 + 180) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      }
      if(i==9 & 
         (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="BlessofGrandis")$Time) >= 
         subset(BuffFinal, rownames(BuffFinal)=="BlessofGrandis")$CoolTime * 1000 + 180) {
        DealCycle <- DCBuff(DealCycle, c("BlessofGrandis"), BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
        DealCycle <- DCBuff(DealCycle, "MagicCircuitFullDriveBuff", BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      }
      if(sum(i==c(4, 7, 10))==1 & DealCycle$CrystalCharge[nrow(DealCycle)] >= 40 & IGDummy == 0) {
        DealCycle <- DCBuff(DealCycle, c("SoulofCrystal1"), BuffFinal)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
        IGDummy <- 1
      }
      DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
      DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
      DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
      DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
    }
    if(sum(i==c(3))==1 & FastChargeReset==T) {
      for(j in 1:10) {
        DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
        DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
        DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
        DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
      }
    } else if(sum(i==c(6, 9, 12))==1 & FastChargeReset==T) {
      for(j in 1:9) {
        DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
        DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
        DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
        DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
        DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
      }
    }
    
    if(i==7) {
      DealCycle <- DCATK(DealCycle, c("SpiderInMirror"), ATKFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    if(i==5) {
      DealCycle <- DCBuff(DealCycle, c("BlessofGrandis"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCBuff(DealCycle, c("MagicCircuitFullDriveBuff"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    if(sum(i==c(4, 7, 10))==1) {
      DealCycle <- DCBuff(DealCycle, c("SoulContractLink"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    if(DealCycle$SoulofCrystal2[nrow(DealCycle)] > DealCycle$SoulofCrystal1[nrow(DealCycle)]) {
      DealCycle <- DCBuff(DealCycle, c("SoulofCrystal1"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    } else {
      DealCycle <- DCBuff(DealCycle, c("SoulofCrystal2"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    if(sum(i==c(4, 7, 10))==1) {
      DealCycle <- DCBuff(DealCycle, c("Restraint4"), BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    DealCycle <- DCSummoned(DealCycle, c("Deus"), SummonedFinal)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    DealCycle <- DCATKSkip(DealCycle, "MotalSwing", ATKFinal, SkipStructure)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    
    if(sum(i==c(4, 7, 10))==1) {
      DealCycle <- DCATKSkip(DealCycle, "MotalSwing", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionPre", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCATKSkip(DealCycle, "ReactionSpectrum", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCATKSkip(DealCycle, "CrystalIgnition", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionEnd", ATKFinal, SkipStructure)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      DealCycle <- DCSummoned(DealCycle, "Gramholder", SummonedFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    
    if(sum(i==c(2, 5, 8, 11))==1 & SoulContractReset==T) {
      DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
    }
    DealCycle <- DCBuff(DealCycle, c("GloryWing"), BuffFinal)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- 0
    
    DealCycle <- DCATKSkip(DealCycle, "MotalWingBeat", ATKFinal, SkipStructure)
    while(DealCycle$GloryWing[nrow(DealCycle)] - subset(ATKFinal, rownames(ATKFinal)=="EnhancedJavelin")$Delay > 0) {
      DealCycle <- DCATKSkip(DealCycle, "EnhancedJavelin", ATKFinal, SkipStructure)
      if(sum(i==c(2, 5, 8, 11))==1 & SoulContractReset==F & 
         (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]) - max(subset(DealCycle, DealCycle$Skills=="SoulContractLink")$Time) >= subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000 + 180) {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
      }
    }
    CrystalDummy <- 0
  }
  DealCycle$CrystalCharge <- 0
  return(DealCycle)
}

## DealCycle
IlliumDealCycle <- IlliumCycle(PreDealCycle=IlliumDealCycle,
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal,
                                SkipStructure=IlliumSkipATK, 
                                Spec=IlliumSpec,
                                FastChargeReset=F,
                                SoulContractReset=F)
IlliumDealCycle <- DealCycleFinal(IlliumDealCycle)
IlliumDealCycle <- RepATKCycle(IlliumDealCycle, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle <- RepATKCycle(IlliumDealCycle, "ReactionSpectrum", 9, 0, ATKFinal)
IlliumDealCycle <- MCFCycle(IlliumDealCycle, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle <- SoulofCrystalBuffLogic(IlliumDealCycle)
IlliumDealCycle <- AddATKCycleIllium(IlliumDealCycle, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), 
                                     ATKFinal[rownames(ATKFinal)=="Destruction", ]$CoolTime, ATKFinal[rownames(ATKFinal)=="DestructionSoul", ]$CoolTime)
IlliumDealCycle <- JavelinBuffLogic(IlliumDealCycle)
IlliumDealCycle <- DeusExMachinaLogic(IlliumDealCycle, SummonedFinal[rownames(SummonedFinal)=="Deus", ]$Duration, SummonedFinal)
IlliumDealCycle <- DCSummonedATKs(IlliumDealCycle, "Gramholder", SummonedFinal)
IlliumDealCycle <- DCSpiderInMirror(IlliumDealCycle, SummonedFinal)
IlliumDealCycleReduction <- DealCycleReduction(IlliumDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Illium") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  IlliumSpecOpt1 <- Optimization1(IlliumDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, IlliumSpec, IlliumUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- IlliumSpecOpt1[1, 1:3]
} else {
  IlliumSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
IlliumSpecOpt <- OptDataAdd(IlliumSpec, IlliumSpecOpt1, "Potential", IlliumBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  IlliumSpecOpt2 <- Optimization2(IlliumDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt, IlliumHyperStatBase, IlliumBase$ChrLv, IlliumBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- IlliumSpecOpt2[1, ]
} else {
  IlliumSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
IlliumSpecOpt <- OptDataAdd(IlliumSpecOpt, IlliumSpecOpt2, "HyperStat", IlliumBase$CRROver, DemonAvenger=F)

IlliumFinalDPM <- DealCalc(IlliumDealCycle, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt, Collapse=F)
IlliumFinalDPMwithMax <- DealCalcWithMaxDMR(IlliumDealCycle, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Illium", sum(na.omit(IlliumFinalDPMwithMax)) / (max(IlliumDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Illium", sum(na.omit(IlliumFinalDPM)) / (max(IlliumDealCycle$Time) / 60000) - sum(na.omit(IlliumFinalDPMwithMax)) / (max(IlliumDealCycle$Time) / 60000))

IlliumDealRatio <- DealRatio(IlliumDealCycle, IlliumFinalDPMwithMax)

IlliumDealData <- data.frame(IlliumDealCycle$Skills, IlliumDealCycle$Time, IlliumDealCycle$Restraint4, IlliumFinalDPMwithMax)
colnames(IlliumDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Illium", Deal_RR(IlliumDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Illium", Deal_40s(IlliumDealData))

IlliumSpecMean <- SpecMean("Illium", IlliumDealCycleReduction, 
                           DealCalcWithMaxDMR(IlliumDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt), 
                           ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt)


## Glorywing Ignition 
DealCycle <- c("Skills", "Time", rownames(IlliumBuff))
WingnitionDealCycle <- t(rep(0, length(DealCycle)))
colnames(WingnitionDealCycle) <- DealCycle
WingnitionDealCycle <- data.frame(WingnitionDealCycle)

Winggnition40s <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, FastChargeReset, SoulContractReset) {
  DealCycle <- PreDealCycle
  IGDummy <- 0
  ## First Cycle
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) > 0) {
    DealCycle <- DCBuff(DealCycle, c("UsefulAdvancedBless"), BuffFinal)
  }
  DealCycle <- DCBuff(DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "MagicGuntletBooster", "MapleSoldier", "RaceofGod", "CrystalGateBuff", "FastCharge"), BuffFinal)
  DealCycle <- DCSummoned(DealCycle, "Liyo1Stack", SummonedFinal)
  DealCycle <- DCSummoned(DealCycle, "Machina", SummonedFinal)
  while(DealCycle$CrystalCharge[nrow(DealCycle)] < 150) {
    if(DealCycle$CrystalCharge[nrow(DealCycle)] >= 40 & IGDummy == 0) {
      DealCycle <- DCBuff(DealCycle, "SoulofCrystal1", BuffFinal)
      DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
      IGDummy <- 1
    }
    DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
    DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
    DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
  }
  DealCycle <- DCATK(DealCycle, c("SpiderInMirror"), ATKFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("BlessofGrandis"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("MagicCircuitFullDriveBuff"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("SoulofCrystal2"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("SoulContractLink"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCSummoned(DealCycle, "Gramholder", SummonedFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCSummoned(DealCycle, c("Deus"), SummonedFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("Restraint4"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCATKSkip(DealCycle, "MotalSwing", ATKFinal, SkipStructure)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  DealCycle <- DCBuff(DealCycle, c("GloryWing"), BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- 0
  
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionPre", ATKFinal, SkipStructure)
  DealCycle <- DCATKSkip(DealCycle, "ReactionSpectrum", ATKFinal, SkipStructure)
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnition", ATKFinal, SkipStructure)
  DealCycle <- DCATKSkip(DealCycle, "CrystalIgnitionEnd", ATKFinal, SkipStructure)
  DealCycle <- DCATKSkip(DealCycle, "MotalWingBeat", ATKFinal, SkipStructure)
  while(DealCycle$GloryWing[nrow(DealCycle)] - subset(ATKFinal, rownames(ATKFinal)=="EnhancedJavelin")$Delay > 0) {
    DealCycle <- DCATKSkip(DealCycle, "EnhancedJavelin", ATKFinal, SkipStructure)
  }
  
  DealCycle <- DCBuff(DealCycle, "SoulofCrystal1", BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  for(i in 1:3) {
    DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
    DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
    DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
  }
  DealCycle <- DCBuff(DealCycle, "SoulofCrystal2", BuffFinal)
  DealCycle$CrystalCharge[nrow(DealCycle)] <- DealCycle$CrystalCharge[(nrow(DealCycle)-1)]
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < subset(DealCycle, DealCycle$Skills=="Restraint4")$Time + 41000) {
    DealCycle <- DCATKSkip(DealCycle, "Orb", ATKFinal, SkipStructure)
    DealCycle$JavelinBuffDummy[nrow(DealCycle)] <- 2000
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 4, 2))
    DealCycle <- DCATKSkip(DealCycle, "Javelin", ATKFinal, SkipStructure)
    DealCycle$CrystalCharge[nrow(DealCycle)] <- min(150, DealCycle$CrystalCharge[(nrow(DealCycle)-1)] + ifelse(DealCycle$FastCharge[nrow(DealCycle)] > 0, 2, 1))
  }
  return(DealCycle)
}

WinggnitionCycle1 <- Winggnition40s(PreDealCycle=WingnitionDealCycle,
                                    ATKFinal=ATKFinal, 
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal,
                                    SkipStructure=IlliumSkipATK, 
                                    Spec=IlliumSpec,
                                    FastChargeReset=F,
                                    SoulContractReset=F)
WinggnitionCycle1 <- DealCycleFinal(WinggnitionCycle1)
WinggnitionCycle1 <- RepATKCycle(WinggnitionCycle1, "CrystalIgnition", 62, 0, ATKFinal)
WinggnitionCycle1 <- RepATKCycle(WinggnitionCycle1, "ReactionSpectrum", 9, 0, ATKFinal)
WinggnitionCycle1 <- MCFCycle(WinggnitionCycle1, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
WinggnitionCycle1 <- SoulofCrystalBuffLogic(WinggnitionCycle1)
WinggnitionCycle1 <- AddATKCycleIllium(WinggnitionCycle1, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), 
                                       ATKFinal[rownames(ATKFinal)=="Destruction", ]$CoolTime, ATKFinal[rownames(ATKFinal)=="DestructionSoul", ]$CoolTime)
WinggnitionCycle1 <- JavelinBuffLogic(WinggnitionCycle1)
WinggnitionCycle1 <- DeusExMachinaLogic(WinggnitionCycle1, SummonedFinal[rownames(SummonedFinal)=="Deus", ]$Duration, SummonedFinal)
WinggnitionCycle1 <- DCSummonedATKs(WinggnitionCycle1, "Gramholder", SummonedFinal)
WinggnitionCycle1 <- DCSpiderInMirror(WinggnitionCycle1, SummonedFinal)

Winggnition40s <- DealCalcWithMaxDMR(WinggnitionCycle1, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt)
WinggnitionDealData <- data.frame(WinggnitionCycle1$Skills, WinggnitionCycle1$Time, WinggnitionCycle1$Restraint4, Winggnition40s)
colnames(WinggnitionDealData) <- c("Skills", "Time", "R4", "Deal")

WinggitionRR <- Deal_RR(WinggnitionDealData)
Winggition40s <- Deal_40s(WinggnitionDealData)

print(data.frame(WinggitionRR=WinggitionRR, Winggition40s=Winggition40s))