## Kaiser - Data
## Kaiser - VMatrix
## Core Check Needed
KaiserCore <- MatrixSet(PasSkills=c("WillofSword", "Wingbeat", "Petrified", "GigaSlasher", "InfernalBreath", "SwordStrike", "Prominance", "BlueStreak"), 
                        PasLvs=c(50, 50, 50, 50, 50, 50, 50, 25), 
                        PasMP=c(10, 10, 5, 10, 10, 5, 10, 0), 
                        ActSkills=c("GuardianofNova", "WillofSwordStrike", "DracoSlasher", "DragonBlaze", 
                                    CommonV("Warrior", "Nova")[c(1, 2, 4, 5)]), 
                        ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                        ActMP=c(5, 5, 5, 5, 5, 0, 5, 5), 
                        BlinkLv=1, 
                        BlinkMP=0, 
                        UsefulSkills=c("SharpEyes", "CombatOrders", "WindBooster"), 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=SpecDefault, 
                        SelfBind=F)


## Kaiser - Basic Info
## Link Check(Cygnus vs Xenon)
KaiserBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=MobDefault,
                      SpecSet=SpecDefault, 
                      Job="Kaiser",
                      CoreData=KaiserCore, 
                      BuffDurationNeeded=67, 
                      AbilList=c("BDR", "BuffDuration"), 
                      LinkList=c("Kaiser", "Mikhail", "DemonAvenger", "Xenon"), 
                      MonsterLife=MLTypeS21, 
                      Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "TwohandSword", SpecDefault$WeaponType)[, 1:16],
                      WeaponType=SpecDefault$WeaponType, 
                      SubWeapon=SubWeapon[34, ], 
                      Emblem=Emblem[6, ], 
                      CoolReduceHat=T)


## Kaiser - Passive
{option <- factor(c("ATK", "CRR", "BDR"), levels=PSkill)
value <- c(45, 20, 18)
ReshuffleSwitch <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(20)
InnerBlaze <- data.frame(option, value)

option <- factor(c("ATKP", "CRR", "FDR"), levels=PSkill)
value <- c(30, 20, 20)
Catalize <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(30)
AdvancedInnerBlaze <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20 + 2 * ceiling(KaiserBase$SkillLv/3))
AdvancedWillofSwordPassive <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(40 + KaiserBase$SkillLv)
UnpleasingCourage <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(KaiserBase$SkillLv/2), 30 + KaiserBase$SkillLv, 20 + floor(KaiserBase$SkillLv/2), 15 + floor(KaiserBase$SkillLv/3))
AdvancedSwordMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(KaiserCore[[2]][6, 2])
BodyofStealPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(KaiserCore[[2]][9, 2])
BlinkPassive <- data.frame(option, value)}

KaiserPassive <- Passive(list(ReshuffleSwitch, InnerBlaze, Catalize, AdvancedInnerBlaze, AdvancedWillofSwordPassive, UnpleasingCourage, AdvancedSwordMastery, 
                              BodyofStealPassive, BlinkPassive))


## Kaiser - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MorphGauge <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(3)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Transfiguration1 <- rbind(data.frame(option, value), info) ## IronWill

option <- factor(c("BDR"), levels=BSkill)
value <- c(6)
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Transfiguration2 <- rbind(data.frame(option, value), info) ## IronWill

option <- factor(c("FDR", "BDR"), levels=BSkill)
value <- c(15, 19)
info <- c(60, 600, 0, T, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalFiguration <- rbind(data.frame(option, value), info) ## Final Figuration, IronWill, ReshuffleSwitch

option <- factor(c("ATKSpeed", "ATK"), levels=BSkill)
value <- c(2, 20)
info <- c(240, 0, 1080, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlazeUp <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(15)
info <- c(240, 0, 720, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RegainStrength <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((KaiserBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(KaiserBase$SkillLv/2))))
info <- c(900 + 30 * KaiserBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(60, 300, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalTrans <- rbind(data.frame(option, value), info)

option <- factor(c("ATK"), levels=BSkill)
value <- c(30)
info <- c(30, 90, 900, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MajestyofKaiser <- rbind(data.frame(option, value), info) ## CoolTime Reset

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + floor(KaiserCore[[2]][1, 2]/2), 120, 600, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GuardianofNovaBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(20, 120, 900, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DragonBlazeBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(Cooldown(120, T, KaiserBase$UnionChrs$CoolReduceP, KaiserBase$CoolReduce) - 20 - General$General$Serverlag, 120, 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DragonBlazeCooldown <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(KaiserCore[[2]][5, 2] / 5), ceiling(KaiserCore[[2]][5, 2] / 5))
info <- c(80 + 2 * KaiserCore[[2]][5, 2], 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(5 + KaiserCore[[2]][[7, 2]])
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(5 + floor(KaiserCore[[2]][[7, 2]]/5))
info <- c(40, 240, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(10 + 2 * floor(KaiserCore[[2]][[7, 2]]/5))
info <- c(40, 240, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=BSkill)
value <- c(15 + 3 * floor(KaiserCore[[2]][[7, 2]]/5))
info <- c(40, 240, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess3 <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * KaiserCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * KaiserCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * KaiserCore[[3]][3, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)}

KaiserBuff <- Buff(list(MorphGauge=MorphGauge, Transfiguration1=Transfiguration1, Transfiguration2=Transfiguration2, FinalFiguration=FinalFiguration, 
                        BlazeUp=BlazeUp, RegainStrength=RegainStrength, MapleSoldier=MapleSoldier, 
                        FinalTrans=FinalTrans, MajestyofKaiser=MajestyofKaiser, 
                        GuardianofNovaBuff=GuardianofNovaBuff, DragonBlazeBuff=DragonBlazeBuff, DragonBlazeCooldown=DragonBlazeCooldown, AuraWeaponBuff=AuraWeaponBuff, 
                        BlessofGrandisGoddess=BlessofGrandisGoddess, BlessofGrandisGoddess1=BlessofGrandisGoddess1, BlessofGrandisGoddess2=BlessofGrandisGoddess2, 
                        BlessofGrandisGoddess3=BlessofGrandisGoddess3, 
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulWindBooster=UsefulWindBooster, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), UsefulWindBooster(900ms)
KaiserAllTimeBuff <- AllTimeBuff(KaiserBuff)


## Kaiser - Union & HyperStat & SoulWeapon
KaiserSpec <- JobSpec(JobBase=KaiserBase, 
                      Passive=KaiserPassive, 
                      AllTimeBuff=KaiserAllTimeBuff, 
                      MobInfo=MobDefault, 
                      SpecSet=SpecDefault, 
                      WeaponName="TwohandSword", 
                      UnionStance=0)

KaiserUnionRemained <- KaiserSpec$UnionRemained
KaiserHyperStatBase <- KaiserSpec$HyperStatBase
KaiserCoolReduceType <- KaiserSpec$CoolReduceType
KaiserSpec <- KaiserSpec$Spec


## Kaiser - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * KaiserCore[[2]][8, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * KaiserCore[[2]][8, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KaiserCore[[2]][8, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KaiserCore[[2]][8, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KaiserCore[[2]][8, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * KaiserCore[[2]][8, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Kaiser - Attacks
## Infernal Breath - Reinforce vs Infernal Breath - Tile Reinforce
## Hyper : Giga Slasher - Reinforce, Bonus ATK / WingBeat - Reinforce, Persist, Extra ATK
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(KaiserCore[[1]][4, 2]>=40, 20, 0), 2 * KaiserCore[[1]][4, 2]) 
info <- c(330 + 2 * KaiserSpec$SkillLv, 10, 720, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GigaSlasher <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(KaiserCore[[1]][4, 2]>=40, 20, 0), 2 * KaiserCore[[1]][4, 2]) 
info <- c(330 + 2 * KaiserSpec$SkillLv, 12, 720, NA, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GigaSlasherFF <- rbind(data.frame(option, value), info) 

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(50, ifelse(KaiserCore[[1]][4, 2]>=40, 20, 0))), 2 * KaiserCore[[1]][4, 2]) 
info <- c(500 + 5 * KaiserCore[[2]][3, 2], 18, 720, NA, 5, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DracoSlasher <- rbind(data.frame(option, value), info) ## 11 Hits + 7 Hits

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, IGRCalc(c(50, ifelse(KaiserCore[[1]][4, 2]>=40, 20, 0))), 2 * KaiserCore[[1]][4, 2]) 
info <- c(500 + 5 * KaiserCore[[2]][3, 2], 22, 720, NA, 5, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DracoSlasherFF <- rbind(data.frame(option, value), info) ## 13 Hits + 9 Hits

option <- factor(levels=ASkill)
value <- c() 
info <- c(0, 0, 210, NA, 10, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordSummon <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KaiserCore[[1]][1, 2]>=40, 20, 0), 2 * KaiserCore[[1]][1, 2]) 
info <- c(400 + 3 * KaiserSpec$SkillLv, 20, 30, NA, 10, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSword <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KaiserCore[[1]][1, 2]>=40, 20, 0), 2 * KaiserCore[[1]][1, 2]) 
info <- c(400 + 3 * KaiserSpec$SkillLv, 25, 30, NA, 10, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordFF <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(500 + 20 * KaiserCore[[2]][2, 2], 20, 30, NA, 30, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordStrike <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(500 + 20 * KaiserCore[[2]][2, 2], 25, 30, NA, 30, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordStrikeFF <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(1000 + 40 * KaiserCore[[2]][2, 2], 30, 0, NA, 30, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordStrikeBlaze <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(1000 + 40 * KaiserCore[[2]][2, 2], 35, 0, NA, 30, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WillofSwordStrikeBlazeFF <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(200) 
info <- c(70, 3, 270, NA, 0, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DragonSlash1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR"), levels=ASkill)
value <- c(200) 
info <- c(160, 6, 270, NA, 0, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DragonSlash1FF <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(0, 0, 480, 330, 0, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WingBeat1 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(0, 0, 480, 330, 0, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WingBeat2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(KaiserCore[[1]][2, 2]>=40, 20, 0), 3 * KaiserCore[[1]][2, 2]) 
info <- c(200, 1, 330, 0, NA, NA, NA, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
WingBeatTick <- rbind(data.frame(option, value), info) ## 48 Hits (if Persist Not Used, 45 Hits)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KaiserCore[[1]][5, 2]>=40, 20, 0), 2 * KaiserCore[[1]][5, 2]) 
info <- c(300 + 4 * KaiserSpec$SkillLv, 8, 1020, NA, 20, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
InfernalBreath <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KaiserCore[[1]][5, 2]>=40, 20, 0), 2 * KaiserCore[[1]][5, 2]) 
info <- c(200 + 3 * KaiserSpec$SkillLv, 2, 0, 1200, 20, T, T, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
InfernalBreathTile <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(KaiserCore[[1]][7, 2]>=40, 20, 0), 2 * KaiserCore[[1]][7, 2]) 
info <- c(1000, 15, 2940, NA, 60, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
Prominance <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(450 + 15 * KaiserCore[[2]][1, 2], 4, 0, 990, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GuardianofNova6th <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(250 + 10 * KaiserCore[[2]][1, 2], 6, 0, 1260, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GuardianofNova15th <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(900 + 35 * KaiserCore[[2]][1, 2], 2, 0, 1680, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
GuardianofNova27th <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(250 + 10 * KaiserCore[[2]][4, 2], 6, 0, 270, 120, T, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DragonBlazeBlaze <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c() 
info <- c(375 + 15 * KaiserCore[[2]][4, 2], 5, 0, NA, 3.6, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DragonBlazeExp <- rbind(data.frame(option, value), info) 

option <- factor(levels=ASkill)
value <- c() 
info <- c(350 + 14 * KaiserCore[[2]][4, 2], 18, 0, NA, 10, F, F, F) 
info <- data.frame(AInfo, info) 
colnames(info) <- c("option", "value")
DragonBlazeSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * KaiserCore[[2]][5, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)}

KaiserATK <- Attack(list(GigaSlasher=GigaSlasher, GigaSlasherFF=GigaSlasherFF, DracoSlasher=DracoSlasher, DracoSlasherFF=DracoSlasherFF, 
                         WillofSwordSummon=WillofSwordSummon, WillofSword=WillofSword, WillofSwordFF=WillofSwordFF, WillofSwordStrike=WillofSwordStrike, WillofSwordStrikeFF=WillofSwordStrikeFF, 
                         WillofSwordStrikeBlaze=WillofSwordStrikeBlaze, WillofSwordStrikeBlazeFF=WillofSwordStrikeBlazeFF, 
                         DragonSlash1=DragonSlash1, DragonSlash1FF=DragonSlash1FF, WingBeat1=WingBeat1, WingBeat2=WingBeat2, WingBeatTick=WingBeatTick, 
                         InfernalBreath=InfernalBreath, InfernalBreathTile=InfernalBreathTile, Prominance=Prominance, GuardianofNova6th=GuardianofNova6th, GuardianofNova15th=GuardianofNova15th, 
                         GuardianofNova27th=GuardianofNova27th, DragonBlazeBlaze=DragonBlazeBlaze, DragonBlazeExp=DragonBlazeExp, DragonBlazeSphere=DragonBlazeSphere, AuraWeapon=AuraWeapon, 
                         SpiderInMirror=SpiderInMirror))


## Kaiser - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(KaiserCore[[1]][3, 2]>=40, 20, 0), 3 * KaiserCore[[1]][3, 2])
info <- c(400, 1, 450, 3030, 60, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Petrified <- rbind(data.frame(option, value), info)}

KaiserSummoned <- Summoned(list(Petrified=Petrified,
                                SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Kaiser - DealCycle & Deal Calculation
ATKFinal <- data.frame(KaiserATK)
ATKFinal$Delay[c(-5, -6, -7, -8, -9, -16)] <- Delay(ATKFinal$Delay, KaiserSpec$ATKSpeed)[c(-5, -6, -7, -8, -9, -16)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, KaiserSpec$CoolReduceP, KaiserSpec$CoolReduce)

BuffFinal <- data.frame(KaiserBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, KaiserSpec$CoolReduceP, KaiserSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, KaiserSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(KaiserSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, KaiserSpec$CoolReduceP, KaiserSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * KaiserSpec$SummonedDuration / 100, 0)


## Kaiser - DealCycle and Deal Calc
DealCycle <- c("Skills", "Time", rownames(KaiserBuff))
KaiserDealCycle <- t(rep(0, length(DealCycle)))
colnames(KaiserDealCycle) <- DealCycle
KaiserDealCycle <- data.frame(KaiserDealCycle)

KaiserCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                        Period=c(120), CycleTime=c(720), WillofSwordReset=0) {
  BuffSummonedPrior <- c("BlazeUp", "RegainStrength", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulWindBooster", 
                         "AuraWeaponBuff", "Petrified", "GuardianofNovaBuff", "BlessofGrandisGoddess", "SoulContractLink", "MajestyofKaiser", "FinalTrans", "DragonBlazeBuff", "Restraint4")
  
  Times120 <- c(1/3, 1/3, 0, 0, 0, 
                0.5, 2, 1, 0.5, 1, 1, 1/3, 1, 1/6)
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- SubTime[1] * 6
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
  
  ## Gauge : Will of Sword - 60, Wingbeat - 1, Giga Slasher - 5, Draco Slasher - 5, Infernal Breath - 40, Prominance - 50
  MorphGaugeLogic <- function(DealCycle, DSRemain, DSStack) {
    DealCycle$MorphGauge[nrow(DealCycle)] <- DealCycle$MorphGauge[nrow(DealCycle)-1]
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("GigaSlasher", "DracoSlasher")) >= 1 & DealCycle$FinalFiguration[nrow(DealCycle)] == 0) {
      DealCycle$MorphGauge[nrow(DealCycle)] <- min(700, DealCycle$MorphGauge[nrow(DealCycle)] + 5)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("InfernalBreath")) >= 1 & DealCycle$FinalFiguration[nrow(DealCycle)] == 0) {
      DealCycle$MorphGauge[nrow(DealCycle)] <- min(700, DealCycle$MorphGauge[nrow(DealCycle)] + 40)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("Prominance")) >= 1 & DealCycle$FinalFiguration[nrow(DealCycle)] == 0) {
      DealCycle$MorphGauge[nrow(DealCycle)] <- min(700, DealCycle$MorphGauge[nrow(DealCycle)] + 50)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("FinalFiguration", "FinalTrans")) >= 1) {
      DealCycle$MorphGauge[nrow(DealCycle)] <- 0
    }
    
    if(DealCycle$MorphGauge[nrow(DealCycle)-1] < 100 & DealCycle$MorphGauge[nrow(DealCycle)] >= 100) {
      DealCycle$Transfiguration1[nrow(DealCycle)] <- 1000000
    } else if(DealCycle$MorphGauge[nrow(DealCycle)-1] < 300 & DealCycle$MorphGauge[nrow(DealCycle)] >= 300) {
      DealCycle$Transfiguration1[nrow(DealCycle)] <- 0
      DealCycle$Transfiguration2[nrow(DealCycle)] <- 1000000
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("FinalFiguration", "FinalTrans")) >= 1) {
      DealCycle$Transfiguration2[nrow(DealCycle)] <- 0
    }
    
    WingBeatTime <- c(subset(DealCycle, DealCycle$Skills=="WingBeat1")$Time, subset(DealCycle, DealCycle$Skills=="WingBeat2")$Time)
    WingBeatTime <- WingBeatTime[WingBeatTime >= DealCycle$Time[nrow(DealCycle)] - 16500]
    if(length(WingBeatTime) > 0) {
      WingBeatTime <- WingBeatTime[order(WingBeatTime)]
      WingBeatStartTime <- WingBeatTime + 600
      WingBeatSubTime <- c()
      for(i in 1:length(WingBeatStartTime)) {
        WingBeatSubTime <- c(WingBeatSubTime, seq(WingBeatStartTime[i], WingBeatStartTime[i] + 330 * 47, 330))
      }
      WingBeatSubTime <- WingBeatSubTime[WingBeatSubTime < DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]]
      WingBeatSubTime <- WingBeatSubTime[WingBeatSubTime >= DealCycle$Time[nrow(DealCycle)]]
    } else {
      WingBeatSubTime <- c()
    }
    
    WOSTime <- subset(DealCycle, DealCycle$Skills=="WillofSword")$Time
    WOSTime <- WOSTime + 1500
    WOSTime <- WOSTime[WOSTime < DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]]
    WOSTime <- WOSTime[WOSTime >= DealCycle$Time[nrow(DealCycle)]]
    
    WOSSTime <- subset(DealCycle, DealCycle$Skills=="WillofSwordStrike")$Time
    WOSSTime <- WOSSTime + 1500 + 2160
    WOSSTime <- WOSSTime[WOSSTime < DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]]
    WOSSTime <- WOSSTime[WOSSTime >= DealCycle$Time[nrow(DealCycle)]]
    
    BWSkills <- data.frame(Time=c(WingBeatSubTime, WOSTime, WOSSTime), 
                           Skills=c(rep("WingBeatTick", length(WingBeatSubTime)), rep("WillofSword", length(WOSTime)), rep("WillofSwordStrikeBlaze", length(WOSSTime))), 
                           stringsAsFactors=F)
    if(nrow(BWSkills) > 0) {
      BWSkills <- BWSkills[order(BWSkills$Time), ]
      OriginalTime <- DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]
      for(i in 1:nrow(BWSkills)) {
        DealCycle[1, 2:ncol(DealCycle)] <- BWSkills$Time[i] - DealCycle$Time[nrow(DealCycle)]
        DealCycle <- DCATK(DealCycle, BWSkills$Skills[i], ATKFinal)
        if(DealCycle$Skills[nrow(DealCycle)] == "WillofSword") {
          DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "Dummy", sep="")
        } else if(DealCycle$Skills[nrow(DealCycle)] == "WillofSwordStrikeBlaze") {
          DSStack <- 4
          DSRemain <- 0
        }
        if(i==nrow(BWSkills)) {
          DealCycle[1, 2:ncol(DealCycle)] <- OriginalTime - DealCycle$Time[nrow(DealCycle)]
        }
        if(DealCycle$Skills[nrow(DealCycle)] == "WingBeatTick" & DealCycle$FinalFiguration[nrow(DealCycle)] == 0) {
          DealCycle$MorphGauge[nrow(DealCycle)] <- min(700, DealCycle$MorphGauge[nrow(DealCycle)-1] + 1)
        } else if(DealCycle$Skills[nrow(DealCycle)] == "WillofSwordDummy" & DealCycle$FinalFiguration[nrow(DealCycle)] == 0) {
          DealCycle$MorphGauge[nrow(DealCycle)] <- min(700, DealCycle$MorphGauge[nrow(DealCycle)-1] + 60)
        } else {
          DealCycle$MorphGauge[nrow(DealCycle)] <- DealCycle$MorphGauge[nrow(DealCycle)-1]
        }
        if(DealCycle$MorphGauge[nrow(DealCycle)-1] < 100 & DealCycle$MorphGauge[nrow(DealCycle)] >= 100) {
          DealCycle$Transfiguration1[nrow(DealCycle)] <- 1000000
        } else if(DealCycle$MorphGauge[nrow(DealCycle)-1] < 300 & DealCycle$MorphGauge[nrow(DealCycle)] >= 300) {
          DealCycle$Transfiguration1[nrow(DealCycle)] <- 0
          DealCycle$Transfiguration2[nrow(DealCycle)] <- 1000000
        }
      }
    }
    return(list(DealCycle=DealCycle, DSRemain=DSRemain, DSStack=DSStack))
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DSRemain <- 0 ; DSStack <- 0
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="AuraWeaponBuff") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)$DealCycle
      } 
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="FinalTrans") {
        DealCycle$FinalFiguration[nrow(DealCycle)] <- DealCycle$FinalTrans[nrow(DealCycle)]
      } else if(BuffList[[1]][i]=="BlessofGrandisGoddess") {
        WOSStack <- WillofSwordReset
      }
      DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)$DealCycle
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)$DealCycle
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
  DSCool <- subset(ATKFinal, rownames(ATKFinal)=="DracoSlasher")$CoolTime * 1000
  WSCool <- subset(ATKFinal, rownames(ATKFinal)=="WillofSword")$CoolTime * 1000
  WSSCool <- subset(ATKFinal, rownames(ATKFinal)=="WillofSwordStrike")$CoolTime * 1000
  WBCool <- 600 + 47 * 330
  IBCool <- 20400
  PMCool <- subset(ATKFinal, rownames(ATKFinal)=="Prominance")$CoolTime * 1000
  
  WSRemain <- 0 ; WSSRemain <- 0 ; WBRemain <- 0 ; IBRemain <- 0 ; PMRemain <- 0 ; DSStack <- 0
  
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
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
      }
      ## Final Figuration
      if(DealCycle$MorphGauge[nrow(DealCycle)] >= 700) {
        DealCycle <- DCBuff(DealCycle, "FinalFiguration", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      ## Soul Contract
      else if(DealCycle$SoulContractLink[nrow(DealCycle)] < 2000 & nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink")) < nrow(subset(DealCycle, DealCycle$Skills=="MajestyofKaiser")) * 2)  {
        DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      ## Will of Sword Strike & Prominance & Restraint4
      else if(k==6 & DealCycle$FinalFiguration[nrow(DealCycle)] > 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))==1 & WSSRemain > WSSCool - 3000) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      } 
      else if(k==10 & DealCycle$FinalFiguration[nrow(DealCycle)] > 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))==2 & WSSRemain > WSSCool - 3000) {
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      else if(PMRemain <= 210 + 540 & WSRemain == 0 & WSSRemain <= 210 + 540 + 30 & k!=length(BuffList)) {
        if(k==6 & DealCycle$FinalFiguration[nrow(DealCycle)] > 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))==1) {
          DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        } else if(k==10 & DealCycle$FinalFiguration[nrow(DealCycle)] > 0 & nrow(subset(DealCycle, DealCycle$Skills=="Restraint4"))==2) {
          DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        DealCycle <- DCATK(DealCycle, "WillofSwordSummon", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        if(WOSStack > 0) {
          WSRemain <- 0
          WOSStack <- WOSStack - 1
        } else {
          WSRemain <- max(0, WSCool - DealCycle$Time[1])
        }
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        DealCycle <- DCATK(DealCycle, "Prominance", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 30
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMCool - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        DealCycle <- DCATK(DealCycle, "WillofSwordStrike", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSCool - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      else if(WSRemain == 0 & WSSRemain <= 210 + 540 + 30 & k!=length(BuffList) | 
              WSRemain == 0 & WSSRemain <= 210 + 540 + 30 & k==length(BuffList) & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + 210 + 540 + 30 + WSSCool <= BuffStartTime + 8000) {
        DealCycle <- DCATK(DealCycle, "WillofSwordSummon", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        if(WOSStack > 0) {
          WSRemain <- 0
          WOSStack <- WOSStack - 1
        } else {
          WSRemain <- max(0, WSCool - DealCycle$Time[1])
        }
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DealCycle[1, 2:ncol(DealCycle)] <- 30
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DealCycle[1, 2:ncol(DealCycle)] <- 30
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        DealCycle <- DCATK(DealCycle, "WillofSwordStrike", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSCool - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      } 
      ## Draco Slasher
      else if(DSRemain == 0 | DSStack > 0) {
        DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
        DSRemain <- max(0, DSCool - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- max(0, DealCycle$DSStack - 1)
        DealCycle <- DealCycle$DealCycle
      }
      ## WingBeat
      else if(WBRemain == 0 & DealCycle$FinalFiguration[nrow(DealCycle)]==0) {
        DealCycle <- DCATK(DealCycle, "DragonSlash1", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        DealCycle <- DCATK(DealCycle, "WingBeat1", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBCool - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        DealCycle <- DCATK(DealCycle, "WingBeat2", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      } 
      else if(WBRemain == 0 & DealCycle$FinalFiguration[nrow(DealCycle)] - DealCycle$Time[1] >= 480 + 540*2 + 480) {
        DealCycle <- DCATK(DealCycle, "WingBeat1", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 480
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        DealCycle <- DCATK(DealCycle, "WingBeat2", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 480
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBCool - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      ## Will of Sword
      else if(WSRemain == 0 & WSSRemain >= 6000) {
        DealCycle <- DCATK(DealCycle, "WillofSwordSummon", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        if(WOSStack > 0) {
          WSRemain <- 0
          WOSStack <- WOSStack - 1
        } else {
          WSRemain <- max(0, WSCool - DealCycle$Time[1])
        }
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        if(DSRemain==0 | DSStack > 0) {
          DealCycle <- DCATK(DealCycle, "DracoSlasher", ATKFinal)
          DSRemain <- max(0, DSCool - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- max(0, DealCycle$DSStack - 1)
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
        
        DealCycle <- DCATK(DealCycle, "WillofSword", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      ## Infernal Breath
      else if(IBRemain == 0 & WOSStack==0) {
        DealCycle <- DCATK(DealCycle, "InfernalBreathTile", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBCool - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
        
        DealCycle <- DCATK(DealCycle, "InfernalBreath", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
      ## Giga Slasher
      else {
        DealCycle <- DCATK(DealCycle, "GigaSlasher", ATKFinal)
        DSRemain <- max(0, DSRemain - DealCycle$Time[1])
        WSRemain <- max(0, WSRemain - DealCycle$Time[1])
        WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
        WBRemain <- max(0, WBRemain - DealCycle$Time[1])
        IBRemain <- max(0, IBRemain - DealCycle$Time[1])
        PMRemain <- max(0, PMRemain - DealCycle$Time[1])
        DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
        DSRemain <- DealCycle$DSRemain
        DSStack <- DealCycle$DSStack
        DealCycle <- DealCycle$DealCycle
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="FinalTrans") {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            DSRemain <- max(0, DSRemain - DealCycle$Time[1])
            WSRemain <- max(0, WSRemain - DealCycle$Time[1])
            WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
            WBRemain <- max(0, WBRemain - DealCycle$Time[1])
            IBRemain <- max(0, IBRemain - DealCycle$Time[1])
            PMRemain <- max(0, PMRemain - DealCycle$Time[1])
            DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
            DSRemain <- DealCycle$DSRemain
            DSStack <- DealCycle$DSStack
            DealCycle <- DealCycle$DealCycle
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="FinalTrans") {
            DealCycle$FinalFiguration[nrow(DealCycle)] <- DealCycle$FinalTrans[nrow(DealCycle)]
          } else if(BuffList[[k]][i]=="BlessofGrandisGoddess") {
            WOSStack <- WillofSwordReset
          }
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DSRemain <- max(0, DSRemain - DealCycle$Time[1])
          WSRemain <- max(0, WSRemain - DealCycle$Time[1])
          WSSRemain <- max(0, WSSRemain - DealCycle$Time[1])
          WBRemain <- max(0, WBRemain - DealCycle$Time[1])
          IBRemain <- max(0, IBRemain - DealCycle$Time[1])
          PMRemain <- max(0, PMRemain - DealCycle$Time[1])
          DealCycle <- MorphGaugeLogic(DealCycle, DSRemain, DSStack)
          DSRemain <- DealCycle$DSRemain
          DSStack <- DealCycle$DSStack
          DealCycle <- DealCycle$DealCycle
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
KaiserAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Infernal Breath Tile
  DealCycle <- RepATKCycle(DealCycle, "InfernalBreathTile", 16, 2400, ATKFinal)
  print("Infernal Breath Tile Done")
  
  
  ## Will of Sword
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="WillofSword") {
      DealCycle$Skills[i] <- "WillofSwordStart"
    } else if(DealCycle$Skills[i]=="WillofSwordDummy") {
      DealCycle$Skills[i] <- "WillofSword"
    }
  }
  
  DealCycle$Skills[DealCycle$Skills=="WillofSwordStrike"] <- "WillofSwordStrikeStart"
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="WillofSwordStrikeStart") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "WillofSwordStrike"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[i] + 1500
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  EndTime <- subset(DealCycle, DealCycle$Skills=="End")$Time
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="WillofSwordStrike") {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 3:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Will of Sword Done")
  
  
  ## Guardian of Nova
  GOV6th <- ceiling((subset(BuffFinal, rownames(BuffFinal)=="GuardianofNovaBuff")$Duration * 1000 - 1320) / 990)
  GOV15th <- ceiling((subset(BuffFinal, rownames(BuffFinal)=="GuardianofNovaBuff")$Duration * 1000 - 1320) / 1260)
  GOV27th <- ceiling((subset(BuffFinal, rownames(BuffFinal)=="GuardianofNovaBuff")$Duration * 1000 - 1320) / 1680)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GuardianofNovaBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "GuardianofNova6th"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "GuardianofNova15th"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "GuardianofNova27th"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "GuardianofNova6th", GOV6th, 1320, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "GuardianofNova15th", GOV15th, 1320, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "GuardianofNova27th", GOV27th, 1320, ATKFinal)
  print("Guardian of Nova Done")
  
  
  ## Petrified
  DealCycle <- DCSummonedATKs(DealCycle, "Petrified", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  print("Petrified, Spider In Mirror Done")
  
  
  ## Dragon Blaze (Blaze)
  BlazeATKTimes <- ceiling((subset(BuffFinal, rownames(BuffFinal)=="DragonBlazeBuff")$Duration * 1000 - 270) / 270)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DragonBlazeBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "DragonBlazeBlaze"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  DealCycle <- RepATKCycle(DealCycle, "DragonBlazeBlaze", BlazeATKTimes, 270, ATKFinal)
  
  
  ## Dragon Blaze (Explosion)
  BZE <- subset(DealCycle, DealCycle$Skills=="DragonBlazeBuff")
  Ind <- rownames(BZE)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 3601
    while(p < Ind[i+1] & DealCycle$DragonBlazeBuff[p] > 0) {
      if(time > 3600 & max(DealCycle$Skills[p]==c("GigaSlasher", "DracoSlasher", "InfernalBreath", "DragonSlash1", "WillofSword", "WillofSwordStrike", "WillofSwordBlaze"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DragonBlazeExp")
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
  
  
  ## Dragon Blaze (Sphere) 
  DBCool <- subset(BuffFinal, rownames(BuffFinal)=="DragonBlazeBuff")$CoolTime
  DBDur <- subset(BuffFinal, rownames(BuffFinal)=="DragonBlazeBuff")$Duration
  
  DB <- subset(DealCycle, DealCycle$Skills=="DragonBlazeBuff")
  ExhaustD <- DBCool - DBDur
  DB$Skills <- c("DragonBlazeCooldown")
  DB$DragonBlazeBuff <- 0
  DB$DragonBlazeCooldown <- ExhaustD * 1000
  DB$Time <- DB$Time + DBDur * 1000
  DB <- subset(DB, DB$Time < max(DealCycle$Time))
  
  DealCycle <- rbind(DealCycle, DB)
  DealCycle <- DealCycle[order(DealCycle$Time), ]
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DragonBlaze") {
      for(j in 1:ncol(DealCycle)) {
        if(sum(colnames(DealCycle)[j]==c("Skills", "Time", "DragonBlazeBuff","DragonBlazeCooldown"))==0) {
          DealCycle[i, j] <- ifelse(DealCycle[i-1, j]>0, max(DealCycle[i-1, j] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
        }
      }
    }
  }
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]!="DragonBlazeCooldown") {
      DealCycle$DragonBlazeCooldown[i] <- ifelse(DealCycle$DragonBlazeCooldown[i-1]>0, max(DealCycle$DragonBlazeCooldown[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]), 0), 0)
    }
  }
  
  BZC <- DealCycle[1, ]
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$DragonBlazeCooldown[i] > 0 & DealCycle$DragonBlazeCooldown[i-1] == 0) {
      BZC <- rbind(BZC, DealCycle[i, ])
    }
  }
  BZC <- BZC[-1, ]
  Ind <- rownames(BZC)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 10001
    while(p < Ind[i+1] & DealCycle$DragonBlazeCooldown[p] > 0) {
      if(time > 10000 & max(DealCycle$Skills[p]==c("GigaSlasher", "DracoSlasher", "InfernalBreath", "DragonSlash1", "WillofSword", "WillofSwordStrike", "WillofSwordBlaze", "Prominance"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("DragonBlazeSphere")
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
  print("Dragon Blaze Done")
  
  
  ## Aura Weapon
  DealCycle <- AWCycle(DealCycle, c("GigaSlasher", "DracoSlasher", "DragonSlash1", "Prominance"))
  print("Aura Weapon Done")
  
  
  ## Morph Gauge (Bless of Grandis Goddess) 
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$BlessofGrandisGoddess[i] > 0) {
      if(DealCycle$Transfiguration1[i] > 0) {
        DealCycle$BlessofGrandisGoddess1[i] <- DealCycle$BlessofGrandisGoddess[i]
      } else if(DealCycle$Transfiguration2[i] > 0) {
        DealCycle$BlessofGrandisGoddess2[i] <- DealCycle$BlessofGrandisGoddess[i]
      } else if(DealCycle$FinalFiguration[i] > 0) {
        DealCycle$BlessofGrandisGoddess3[i] <- DealCycle$FinalFiguration[i]
      }
    }
  }
  print("Bless of Grandis Done")
  
  
  ## Final Figuration Skills
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$FinalFiguration[i] > 0 & sum(DealCycle$Skills[i]==c("GigaSlasher", "DracoSlasher", "WillofSword", "WillofSwordStrike", "WillofSwordStrikeBlaze", "DragonSlash1")) >= 1) {
      DealCycle$Skills[i] <- paste(DealCycle$Skills[i], "FF", sep="")
    }
  }
  print("Final Figuration Done")
  
  
  ## Dummy Reduction
  DealCycle$MorphGauge <- 0
  DealCycle$FinalTrans <- 0
  
  return(DealCycle)
}

KaiserDealCycle0 <- KaiserCycle(DealCycle=KaiserDealCycle, 
                                ATKFinal=ATKFinal, 
                                BuffFinal=BuffFinal, 
                                SummonedFinal=SummonedFinal, 
                                Spec=KaiserSpec, 
                                Period=120, 
                                CycleTime=720, 
                                WillofSwordReset=0)
KaiserDealCycle0 <- DealCycleFinal(KaiserDealCycle0)
KaiserDealCycle0 <- KaiserAddATK(DealCycle=KaiserDealCycle0, 
                                 ATKFinal=ATKFinal, 
                                 BuffFinal=BuffFinal, 
                                 SummonedFinal=SummonedFinal, 
                                 Spec=KaiserSpec)
KaiserDealCycleReduction0 <- DealCycleReduction(KaiserDealCycle0)

for(i in 1:6) {
   rm(KADealCycle)
  KADealCycle <- KaiserCycle(DealCycle=KaiserDealCycle, 
                             ATKFinal=ATKFinal, 
                             BuffFinal=BuffFinal, 
                             SummonedFinal=SummonedFinal, 
                             Spec=KaiserSpec, 
                             Period=120, 
                             CycleTime=720, 
                             WillofSwordReset=i)
  KADealCycle <- DealCycleFinal(KADealCycle)
  KADealCycle <- KaiserAddATK(DealCycle=KADealCycle, 
                              ATKFinal=ATKFinal, 
                              BuffFinal=BuffFinal, 
                              SummonedFinal=SummonedFinal, 
                              Spec=KaiserSpec)
  KADealCycleReduction <- DealCycleReduction(KADealCycle)
  
  assign(paste("KaiserDealCycle", i, sep=""), KADealCycle)
  assign(paste("KaiserDealCycleReduction", i, sep=""), KADealCycleReduction)
  print(paste("i=", i, " done", sep=""))
}

KaiserSpecOpt1 <- Optimization1(KaiserDealCycleReduction0, ATKFinal, BuffFinal, SummonedFinal, KaiserSpec, KaiserUnionRemained)
print(KaiserSpecOpt1)
KaiserSpecOpt <- KaiserSpec
KaiserSpecOpt$ATKP <- KaiserSpecOpt$ATKP + KaiserSpecOpt1$ATKP
KaiserSpecOpt$BDR <- KaiserSpecOpt$BDR + KaiserSpecOpt1$BDR
KaiserSpecOpt$IGR <- IGRCalc(c(KaiserSpecOpt$IGR, KaiserSpecOpt1$IGR))

KaiserSpecOpt2 <- Optimization2(KaiserDealCycleReduction0, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt, KaiserHyperStatBase, KaiserBase$ChrLv, KaiserBase$CRROver)

KaiserDealCycles <- list(KaiserDealCycle0, KaiserDealCycle1, KaiserDealCycle2, KaiserDealCycle3, KaiserDealCycle4, KaiserDealCycle5, KaiserDealCycle6)
KaiserDealCycleProbs <- c(0.45, 0.55*0.45, 0.55^2*0.45, 0.55^3*0.45, 0.55^4*0.45, 0.55^6 + 0.55^5*0.45^2, 0.55^6*0.45)
KaiserDealCycleTimes <- c(max(KaiserDealCycle0$Time), max(KaiserDealCycle1$Time), max(KaiserDealCycle2$Time), 
                          max(KaiserDealCycle3$Time), max(KaiserDealCycle4$Time), max(KaiserDealCycle5$Time), 
                          max(KaiserDealCycle6$Time))
KaiserDealCycleTime <- sum(KaiserDealCycleTimes * KaiserDealCycleProbs)

KaiserFinalDPM <- ResetDealCalc(DealCycles=KaiserDealCycles, 
                                ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2, KaiserDealCycleTimes, KaiserDealCycleProbs)
KaiserFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=KaiserDealCycles, 
                                                ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2, KaiserDealCycleTimes, KaiserDealCycleProbs)

KaiserDealDatas <- list(DealCalcWithMaxDMR(KaiserDealCycle0, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle1, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle2, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle3, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle4, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle5, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2), 
                        DealCalcWithMaxDMR(KaiserDealCycle6, ATKFinal, BuffFinal, SummonedFinal, KaiserSpecOpt2))

KaiserDealRatio <- ResetDealRatio(DealCycles=KaiserDealCycles, 
                                  DealDatas=KaiserDealDatas, 
                                  KaiserDealCycleTimes, KaiserDealCycleProbs)

DPM12347$Kaiser[1] <- sum(na.omit(KaiserFinalDPMwithMax)) / (KaiserDealCycleTime / 60000)
DPM12347$Kaiser[2] <- sum(na.omit(KaiserFinalDPM)) / (KaiserDealCycleTime / 60000) - sum(na.omit(KaiserFinalDPMwithMax)) / (KaiserDealCycleTime / 60000)
KaiserDealData <- data.frame(KaiserDealCycle0$Skills, KaiserDealCycle0$Time, KaiserDealCycle0$Restraint4, KaiserDealDatas[[1]])

colnames(KaiserDealData) <- c("Skills", "Time", "R4", "Deal")
subset(KaiserDealData, KaiserDealData$R4>0)

KaiserRR <- KaiserDealData[39:274, ]
DPM12347$Kaiser[3] <- sum((KaiserRR$Deal))

Kaiser40s <- KaiserDealData[39:597, ]
DPM12347$Kaiser[4] <- sum((Kaiser40s$Deal))