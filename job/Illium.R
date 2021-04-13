## Illium - Data
## Illium - VMatrix
IlliumCore <- MatrixSet(PasSkills=c("Javelin_EnhancedJavelin", "Destruction", "Machina_Domination", "Deus_Liyo", "CurseMark", "MotalSwing_MotalWingBeat"), 
                          PasLvs=c(50, 50, 50, 50, 50, 50), 
                          PasMP=c(10, 10, 10, 10, 10, 10), 
                          ActSkills=c("CrystalIgnition", "Gramholder", "SoulofCrystal", "CrystalGate", 
                                      CommonV("Wizard", "Lef")), 
                          ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                          ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 0), 
                          UsefulSkills=c("CombatOrders", "SharpEyes"), 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=SpecDefault)


## Illium - Basic Info
## Link Check Needed
IlliumBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=MobDefault,
                        SpecSet=SpecDefault, 
                        Job="Illium",
                        CoreData=IlliumCore, 
                        MikhailLink=F, 
                        OtherBuffDuration=0, 
                        AbilList=c("CoolTimeReset", "BuffDuration"), 
                        LinkList=c("Phantom", "DemonAvenger", "Xenon"), 
                        MonsterLife=MLTypeI21, 
                        Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "MagicGuntlet", SpecDefault$WeaponType)[, 1:16],
                        WeaponType=SpecDefault$WeaponType, 
                        SubWeapon=SubWeapon[38, ], 
                        Emblem=Emblem[10, ], 
                        CoolReduceHat=F)


## Illium - Passive
{option <- factor(c("ATK"), levels=PSkill)
value <- c(min(floor(ArcaneShade[16, 6] * 0.2), floor(IlliumBase$ItemSet$ATKSub * 0.5)))
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
value <- c(5 + 2 * IlliumCore[[2]][3, 2])
SoulofCrystal <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(8 + floor(IlliumCore[[2]][5, 2]/10))
OverloadMana <- data.frame(option, value) ## ATK Skills Only
}

IlliumPassive <- Passive(list(MagicCircuit=MagicCircuit, MagicGuntletMastery=MagicGuntletMastery, BlessMark=BlessMark, LefMastery=LefMastery, Tenacity=Tenacity, EndlessResearch=EndlessResearch, 
                              BlessMarkCompletion=BlessMarkCompletion, CurseMarkCompletion=CurseMarkCompletion, WisdomoftheCrystal=WisdomoftheCrystal, SoulofCrystal=SoulofCrystal))


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

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * IlliumCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * IlliumCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

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
value <- c(5 + IlliumCore[[2]][3, 2])
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal1Glory <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + IlliumCore[[2]][3, 2])
info <- c(30, 40, 660, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SoulofCrystal2Glory <- rbind(data.frame(option, value), info)

option <- factor(c("ATK", "ATKSkill"), levels=BSkill)
value <- c(5 + 2 * IlliumCore[[2]][4, 2], 1)
info <- c(ceiling((130 + IlliumCore[[2]][4, 2]) / (25 + General$General$Serverlag)) * (25 + General$General$Serverlag), 180, 540, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrystalGateBuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(19 + IlliumCore[[2]][7, 2])
info <- c(30 + IlliumCore[[2]][7, 2], 200, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDriveBuff <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(10 + 3 * IlliumCore[[2]][8, 2] + (min((0.4 + 0.02 * IlliumCore[[2]][8, 2]) * IlliumBase$ItemSet$ATKSub, floor(ArcaneShade[16, 6] * 1.5))))
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

IlliumBuff <- Buff(list(MagicGuntletBooster=MagicGuntletBooster, JavelinBuffDummy=JavelinBuffDummy, JavelinBuff=JavelinBuff, GloryWing=GloryWing, MapleSoldier=MapleSoldier, FastCharge=FastCharge, 
                        RaceofGod=RaceofGod, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, SoulofCrystal1=SoulofCrystal1, SoulofCrystal2=SoulofCrystal2, 
                        SoulofCrystal1Glory=SoulofCrystal1Glory, SoulofCrystal2Glory=SoulofCrystal2Glory, CrystalGateBuff=CrystalGateBuff, MagicCircuitFullDriveBuff=MagicCircuitFullDriveBuff, 
                        BlessofGrandis=BlessofGrandis, CrystalCharge=CrystalCharge, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
IlliumAllTimeBuff <- AllTimeBuff(IlliumBuff)
## PetBuff : MagicGuntletBooster, MapleSoldier


## Illium - Union & HyperStat & SoulWeapon
IlliumSpec <- JobSpec(JobBase=IlliumBase, 
                        Passive=IlliumPassive, 
                        AllTimeBuff=IlliumAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="MagicGuntlet", 
                        UnionStance=0)

IlliumUnionRemained <- IlliumSpec$UnionRemained
IlliumHyperStatBase <- IlliumSpec$HyperStatBase
IlliumCoolReduceType <- IlliumSpec$CoolReduceType
IlliumSpec <- IlliumSpec$Spec


## Illium - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * IlliumCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * IlliumCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Illium - Attacks
{option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][6, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(600 + 2 * IlliumSpec$SkillLv, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalSwing <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][2, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][2, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(650 + 2 * IlliumSpec$SkillLv, 8 * (1 / ((100 - IlliumSpec$CoolTimeReset)/100)), 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Destruction <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(650 + 2 * IlliumSpec$SkillLv, 2 * (1 / ((100 - IlliumSpec$CoolTimeReset)/100)), 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Domination <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c((650 + 2 * IlliumSpec$SkillLv) * (0.01 * IlliumCore[[2]][3, 2] + 0.5), 2, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DominationSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][2, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][2, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c((650 + 2 * IlliumSpec$SkillLv) * (0.01 * IlliumCore[[2]][3, 2] + 0.5), 8, 0, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DestructionSoul <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 12, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Javelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(375 + 2 * IlliumSpec$SkillLv, 4, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddATK <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(130 + 2 * IlliumSpec$SkillLv, 2, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JavelinAddFragment <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, FDRCalc(c(2 * IlliumCore[[1]][1, 2], 40, floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(465 + 3 * IlliumSpec$SkillLv, 7, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
EnhancedJavelin <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][1, 2]>=40, 20, 0), 40, 2 * IlliumCore[[1]][1, 2])
info <- c(250 + 5 * IlliumSpec$SkillLv, 9, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicMissile <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=ASkill)
value <- c(floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(300 + 4 * IlliumSpec$SkillLv, 1, 730, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Orb <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][6, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][6, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(1070 + 20 * IlliumSpec$SkillLv, 15, 840, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MotalWingBeat <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][5, 2]>=40, 20, 0), 2 * IlliumCore[[1]][5, 2])
info <- c(200, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CurseMark <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(IlliumCore[[1]][5, 2]>=40, 20, 0), 2 * IlliumCore[[1]][5, 2])
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
value <- c(20, floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(750 + 30 * IlliumCore[[2]][1, 2], 4, 9340, 150, 180, T, F, F)
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
value <- c(20, floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c(1000 + 40 * IlliumCore[[2]][1, 2], 5, 0, 1000, 180, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ReactionSpectrum <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * IlliumCore[[2]][4, 2], 5, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CrystalGate <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * IlliumCore[[2]][7, 2], 3, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MagicCircuitFullDrive <- rbind(data.frame(option, value), info)}

IlliumATK <- Attack(list(MotalSwing=MotalSwing, Destruction=Destruction, Domination=Domination, DestructionSoul=DestructionSoul, DominationSoul=DominationSoul, 
                         Javelin=Javelin, JavelinAddATK=JavelinAddATK, JavelinFragment=JavelinFragment, JavelinAddFragment=JavelinAddFragment, EnhancedJavelin=EnhancedJavelin, MagicMissile=MagicMissile, Orb=Orb, 
                         MotalWingBeat=MotalWingBeat, CurseMark=CurseMark, CurseMarkJavelin=CurseMarkJavelin, CrystalIgnitionPre=CrystalIgnitionPre, CrystalIgnition=CrystalIgnition, 
                         CrystalIgnitionEnd=CrystalIgnitionEnd, ReactionSpectrum=ReactionSpectrum, CrystalGate=CrystalGate, MagicCircuitFullDrive=MagicCircuitFullDrive, SpiderInMirror=SpiderInMirror))


## Illium - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(160, 1, 30, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo1Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(200, 1, 0, 480, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Liyo2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
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
value <- c(ifelse(IlliumCore[[1]][3, 2]>=40, 20, 0), FDRCalc(c(2 * IlliumCore[[1]][3, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(350, 4, 30, 3030, 180, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Machina <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(500 + 4 * IlliumSpec$SkillLv, 6, 30, 3030, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Deus <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(160, 2, 30, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite1stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
info <- c(200, 2, 0, 480, 30, 180, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DeusSatelite2stack <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=SSkill)
value <- c(ifelse(IlliumCore[[1]][4, 2]>=40, 20, 0), 20, FDRCalc(c(2 * IlliumCore[[1]][4, 2], floor(IlliumCore[[2]][5, 2] / 10) + 8)))
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
value <- c(floor(IlliumCore[[2]][5, 2] / 10) + 8)
info <- c((500 + 20 * IlliumCore[[2]][2, 2]) * 2, 12, 210, 3030, 40, 180, F, T, F, F)
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
  ifelse(BuffFinal$ServerLag==T, 3, 0)

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

## DealCycle 1 - Fast Charge Reset OFF, Soul Contract Reset OFF
IlliumDealCycle1 <- IlliumCycle(PreDealCycle=IlliumDealCycle,
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal,
                                SkipStructure=IlliumSkipATK, 
                                Spec=IlliumSpec,
                                FastChargeReset=F,
                                SoulContractReset=F)
IlliumDealCycle1 <- DealCycleFinal(IlliumDealCycle1)
IlliumDealCycle1 <- RepATKCycle(IlliumDealCycle1, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle1 <- RepATKCycle(IlliumDealCycle1, "ReactionSpectrum", 9, 0, ATKFinal)
IlliumDealCycle1 <- MCFCycle(IlliumDealCycle1, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle1 <- SoulofCrystalBuffLogic(IlliumDealCycle1)
IlliumDealCycle1 <- AddATKCycleIllium(IlliumDealCycle1, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2], ATKFinal$CoolTime[4])
IlliumDealCycle1 <- JavelinBuffLogic(IlliumDealCycle1)
IlliumDealCycle1 <- DeusExMachinaLogic(IlliumDealCycle1, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle1 <- DCSummonedATKs(IlliumDealCycle1, "Gramholder", SummonedFinal)
IlliumDealCycle1 <- DCSpiderInMirror(IlliumDealCycle1, SummonedFinal)
IlliumDealCycleReduction1 <- DealCycleReduction(IlliumDealCycle1)

## DealCycle 2 - Fast Charge Reset ON, Soul Contract Reset OFF
IlliumDealCycle2 <- IlliumCycle(PreDealCycle=IlliumDealCycle,
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal,
                                SkipStructure=IlliumSkipATK, 
                                Spec=IlliumSpec,
                                FastChargeReset=T,
                                SoulContractReset=F)
IlliumDealCycle2 <- DealCycleFinal(IlliumDealCycle2)
IlliumDealCycle2 <- RepATKCycle(IlliumDealCycle2, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle2 <- RepATKCycle(IlliumDealCycle2, "ReactionSpectrum", 9, 0, ATKFinal)
IlliumDealCycle2 <- MCFCycle(IlliumDealCycle2, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle2 <- SoulofCrystalBuffLogic(IlliumDealCycle2)
IlliumDealCycle2 <- AddATKCycleIllium(IlliumDealCycle2, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2], ATKFinal$CoolTime[4])
IlliumDealCycle2 <- JavelinBuffLogic(IlliumDealCycle2)
IlliumDealCycle2 <- DeusExMachinaLogic(IlliumDealCycle2, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle2 <- DCSummonedATKs(IlliumDealCycle2, "Gramholder", SummonedFinal)
IlliumDealCycle2 <- DCSpiderInMirror(IlliumDealCycle2, SummonedFinal)
IlliumDealCycleReduction2 <- DealCycleReduction(IlliumDealCycle2)

## DealCycle 3 - Fast Charge Reset OFF, Soul Contract Reset ON
IlliumDealCycle3 <- IlliumCycle(PreDealCycle=IlliumDealCycle,
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal,
                                SkipStructure=IlliumSkipATK, 
                                Spec=IlliumSpec,
                                FastChargeReset=F,
                                SoulContractReset=T)
IlliumDealCycle3 <- DealCycleFinal(IlliumDealCycle3)
IlliumDealCycle3 <- RepATKCycle(IlliumDealCycle3, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle3 <- RepATKCycle(IlliumDealCycle3, "ReactionSpectrum", 9, 0, ATKFinal)
IlliumDealCycle3 <- MCFCycle(IlliumDealCycle3, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle3 <- SoulofCrystalBuffLogic(IlliumDealCycle3)
IlliumDealCycle3 <- AddATKCycleIllium(IlliumDealCycle3, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2], ATKFinal$CoolTime[4])
IlliumDealCycle3 <- JavelinBuffLogic(IlliumDealCycle3)
IlliumDealCycle3 <- DeusExMachinaLogic(IlliumDealCycle3, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle3 <- DCSummonedATKs(IlliumDealCycle3, "Gramholder", SummonedFinal)
IlliumDealCycle3 <- DCSpiderInMirror(IlliumDealCycle3, SummonedFinal)
IlliumDealCycleReduction3 <- DealCycleReduction(IlliumDealCycle3)

## DealCycle 4 - Fast Charge Reset ON, Soul Contract Reset ON
IlliumDealCycle4 <- IlliumCycle(PreDealCycle=IlliumDealCycle,
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal,
                                SkipStructure=IlliumSkipATK, 
                                Spec=IlliumSpec,
                                FastChargeReset=T,
                                SoulContractReset=T)
IlliumDealCycle4 <- DealCycleFinal(IlliumDealCycle4)
IlliumDealCycle4 <- RepATKCycle(IlliumDealCycle4, "CrystalIgnition", 62, 0, ATKFinal)
IlliumDealCycle4 <- RepATKCycle(IlliumDealCycle4, "ReactionSpectrum", 9, 0, ATKFinal)
IlliumDealCycle4 <- MCFCycle(IlliumDealCycle4, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"))
IlliumDealCycle4 <- SoulofCrystalBuffLogic(IlliumDealCycle4)
IlliumDealCycle4 <- AddATKCycleIllium(IlliumDealCycle4, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2], ATKFinal$CoolTime[4])
IlliumDealCycle4 <- JavelinBuffLogic(IlliumDealCycle4)
IlliumDealCycle4 <- DeusExMachinaLogic(IlliumDealCycle4, SummonedFinal$Duration[6], SummonedFinal)
IlliumDealCycle4 <- DCSummonedATKs(IlliumDealCycle4, "Gramholder", SummonedFinal)
IlliumDealCycle4 <- DCSpiderInMirror(IlliumDealCycle4, SummonedFinal)
IlliumDealCycleReduction4 <- DealCycleReduction(IlliumDealCycle4)

IlliumDealCycleTimes <- c(max(IlliumDealCycle1$Time), max(IlliumDealCycle2$Time), max(IlliumDealCycle3$Time), max(IlliumDealCycle4$Time))
IlliumDealCycleProbs <- c(0.8 * 0.8, 0.8 * 0.2, 0.2 * 0.8, 0.2 * 0.2)
IlliumDealCycleTimeAVG <- sum(IlliumDealCycleTimes * IlliumDealCycleProbs)

ResetDealCalc(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4), ATKFinal, BuffFinal, SummonedFinal, IlliumSpec,
              IlliumDealCycleTimes, IlliumDealCycleProbs)
ResetDealCalcWithMaxDMR(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4), ATKFinal, BuffFinal, SummonedFinal, IlliumSpec,
                        IlliumDealCycleTimes, IlliumDealCycleProbs)

IlliumSpecOpt1 <- ResetOptimization1(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4), 
                                     ATKFinal, BuffFinal, SummonedFinal, IlliumSpec, IlliumUnionRemained, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumSpecOpt <- IlliumSpec
IlliumSpecOpt$ATKP <- IlliumSpecOpt$ATKP + IlliumSpecOpt1$ATKP
IlliumSpecOpt$BDR <- IlliumSpecOpt$BDR + IlliumSpecOpt1$BDR
IlliumSpecOpt$IGR <- IGRCalc(c(IlliumSpecOpt$IGR, IlliumSpecOpt1$IGR))

IlliumSpecOpt2 <- ResetOptimization2(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4),
                                     ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt, IlliumHyperStatBase, IlliumBase$ChrLv, IlliumBase$CRROver, 0, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumFinalDPM <- ResetDealCalc(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4), 
                                ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2, IlliumDealCycleTimes, IlliumDealCycleProbs)
IlliumFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=list(IlliumDealCycleReduction1, IlliumDealCycleReduction2, IlliumDealCycleReduction3, IlliumDealCycleReduction4), 
                                                 ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2, IlliumDealCycleTimes, IlliumDealCycleProbs)

DPM12344$Illium[1] <- sum(na.omit(IlliumFinalDPMwithMax)) / (723482.8 / 60000)
DPM12344$Illium[2] <- sum(na.omit(IlliumFinalDPM)) / (723482.8 / 60000) - sum(na.omit(IlliumFinalDPMwithMax)) / (723482.8 / 60000)

IlliumDeal1 <- DealCalcWithMaxDMR(IlliumDealCycle1, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal2 <- DealCalcWithMaxDMR(IlliumDealCycle2, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal3 <- DealCalcWithMaxDMR(IlliumDealCycle3, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDeal4 <- DealCalcWithMaxDMR(IlliumDealCycle4, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
IlliumDealWithoutMax <- DealCalc(IlliumDealCycle1, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)

ResetDealRatio(DealCycles=list(IlliumDealCycle1, IlliumDealCycle2, IlliumDealCycle3, IlliumDealCycle4), DealDatas=list(IlliumDeal1, IlliumDeal2, IlliumDeal3, IlliumDeal4), 
               IlliumDealCycleTimes, IlliumDealCycleProbs)

IlliumDealData <- data.frame(IlliumDealCycle1$Skills, IlliumDealCycle1$Time, IlliumDealCycle1$Restraint4, IlliumDeal1, IlliumDealWithoutMax-IlliumDeal1)
colnames(IlliumDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")
subset(IlliumDealData, IlliumDealData$R4 > 0)

IlliumRR <- IlliumDealData[220:405, ]
DPM12344$Illium[3] <- sum((IlliumRR$Deal))

Illium40s <- IlliumDealData[220:676, ]
DPM12344$Illium[4] <- sum((Illium40s$Deal))


## Glorywing Ignition 
Winggnition <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, SkipStructure, Spec, FastChargeReset, SoulContractReset) {
  DealCycle <- PreDealCycle
  IGDummy <- 0
  ## First Cycle
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
  return(DealCycle)
}

WinggnitionCycle1 <- Winggnition(PreDealCycle=IlliumDealCycle,
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
WinggnitionCycle1 <- AddATKCycleIllium(WinggnitionCycle1, c("Javelin", "EnhancedJavelin", "Orb", "CrystalIgnition"), ATKFinal$CoolTime[2], ATKFinal$CoolTime[4])
WinggnitionCycle1 <- JavelinBuffLogic(WinggnitionCycle1)
WinggnitionCycle1 <- DeusExMachinaLogic(WinggnitionCycle1, SummonedFinal$Duration[6], SummonedFinal)
WinggnitionCycle1 <- DCSummonedATKs(WinggnitionCycle1, "Gramholder", SummonedFinal)
WinggnitionCycle1 <- DCSpiderInMirror(WinggnitionCycle1, SummonedFinal)

WinggnitionDPM <- DealCalcWithMaxDMR(WinggnitionCycle1, ATKFinal, BuffFinal, SummonedFinal, IlliumSpecOpt2)
WinggnitionDealData <- data.frame(WinggnitionCycle1$Skills, WinggnitionCycle1$Time, WinggnitionCycle1$Restraint4, WinggnitionDPM)
colnames(WinggnitionDealData) <- c("Skills", "Time", "R4", "Deal")
subset(WinggnitionDealData, WinggnitionDealData$R4 > 0)

WinggitionR4 <- sum(WinggnitionDealData$Deal[220:423])