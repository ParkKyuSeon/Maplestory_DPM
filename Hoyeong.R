## Hoyeong - Data
## Hoyeong - VMatrix
HoyeongCore <- MatrixSet(PasSkills=c("Yeouiseon_Geumgobong", "Toparyu_Jijinswae", "Gwihwabu", "Hojeopjimong", "Heupseongwaryu", "Bunsinbu"), 
                         PasLvs=c(50, 50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 10, 10), 
                         ActSkills=c("Bunsinnanmu", "Sanryeongsohwan", "Goeryeoknansin", "CheonjiinHwanyeong",
                                      CommonV("Thief", "Anima")[c(2, 4, 5)]), 
                         ActLvs=c(25, 25, 25, 25, 25, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 5, 5, 5), 
                         UsefulSkills=c("CombatOrders", "SharpEyes"), 
                         UsefulLvs=c(20, 20), 
                         UsefulMP=c(0, 0), 
                         SpecSet=SpecDefault)


## Hoyeong - Basic Info
HoyeongBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Hoyeong",
                       CoreData=HoyeongCore, 
                       MikhailLink=T, 
                       OtherBuffDuration=0, 
                       AbilList=c("BDR", "BuffDuration"), 
                       LinkList=c("Mikhail", "Hoyeong", "DemonAvenger", "CygnusKnights"), 
                       MonsterLife=MLTypeL22, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Fan", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[40, ], 
                       Emblem=Emblem[12, ])


## Hoyeong - Passive
{option <- factor(c("SummonDuration"), levels=PSkill)
value <- c(10)
SpiritIntimacy <- data.frame(option, value)

option <- factor(c("ATKP", "FDR"), levels=PSkill)
value <- c(10, 10)
GoeiBongin <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(25)
FanMastery <- data.frame(option, value)

option <- factor(c("CRR", "CDMR"), levels=PSkill)
value <- c(30, 10)
Siman <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK", "CRR", "CDMR", "BDR", "IGR"), levels=PSkill)
value <- c(50, 10, 20, 20, 10)
Sura <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "FDR"), levels=PSkill)
value <- c(70 + ceiling(HoyeongBase$PSkillLv / 2), 40 + HoyeongBase$PSkillLv, 35 + HoyeongBase$PSkillLv)
FanExpert <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10 + ceiling(HoyeongBase$PSkillLv / 2))
Deukdo <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "CRR", "CDMR", "IGR"), levels=PSkill)
value <- c(rep(10 + HoyeongBase$PSkillLv, 5))
Jeomjeong <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(HoyeongCore[[2]][5, 2])
ReadyToDie <- data.frame(option, value)}

HoyeongPassive <- Passive(list(SpiritIntimacy=SpiritIntimacy, GoeiBongin=GoeiBongin, FanMastery=FanMastery, Siman=Siman, 
                               PhysicalTraining=PhysicalTraining, Sura=Sura, FanExpert=FanExpert, Deukdo=Deukdo, Jeomjeong=Jeomjeong, ReadyToDie=ReadyToDie))


## Hoyeong - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(200, NA, 900, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunsinbuBuff <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FanBooster <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(20)
info <- c(60, NA, 600, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MisaengGangbyeonDebuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10)
info <- c(100, NA, 600, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HojeopJimongBuff <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((HoyeongBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(HoyeongBase$SkillLv/2))))
info <- c(900 + 30 * HoyeongBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(12, 100, 540, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TaeeulSeondan <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 200, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunsinnanmuBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45 + ceiling(HoyeongCore[[2]][2, 2]/2), 200, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwan <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20 + 2 * HoyeongCore[[2]][3, 2])
info <- c(30, 200, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Goeryeoknansin <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 200, 3780, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinAfter <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 100, 720, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeongBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * HoyeongCore[[3]][2, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * HoyeongCore[[3]][1, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(HoyeongCore[[2]][5, 2]/10))
info <- c(30, 90 - floor(HoyeongCore[[2]][5, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(HoyeongCore[[2]][5, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(HoyeongCore[[2]][5, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10 + HoyeongCore[[2]][6, 2])
info <- c(40, 240, 630, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)}

HoyeongBuff <- Buff(list(BunsinbuBuff=BunsinbuBuff, FanBooster=FanBooster, MisaengGangbyeonDebuff=MisaengGangbyeonDebuff, HojeopJimongBuff=HojeopJimongBuff, 
                         MapleSoldier=MapleSoldier, TaeeulSeondan=TaeeulSeondan, BunsinnanmuBuff=BunsinnanmuBuff, SanryeongSohwan=SanryeongSohwan, 
                         Goeryeoknansin=Goeryeoknansin, GoeryeoknansinAfter=GoeryeoknansinAfter, CheonjiinHwanyeongBuff=CheonjiinHwanyeongBuff, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, 
                         BlessofGrandisGoddess=BlessofGrandisGoddess, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## Petbuff : FanBooster, MapleSoldier
HoyeongAllTimeBuff <- AllTimeBuff(HoyeongBuff)


## Hoyeong - Union & HyperStat & SoulWeapon
HoyeongSpec <- JobSpec(JobBase=HoyeongBase, 
                        Passive=HoyeongPassive, 
                        AllTimeBuff=HoyeongAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="Fan", 
                        UnionStance=0)

HoyeongUnionRemained <- HoyeongSpec$UnionRemained
HoyeongHyperStatBase <- HoyeongSpec$HyperStatBase
HoyeongCoolReduceType <- HoyeongSpec$CoolReduceType
HoyeongSpec <- HoyeongSpec$Spec


## Hoyeong - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * HoyeongCore[[2]][7, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * HoyeongCore[[2]][7, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HoyeongCore[[2]][7, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HoyeongCore[[2]][7, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HoyeongCore[[2]][7, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * HoyeongCore[[2]][7, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Hoyeong - Attacks ## HYPER CHECK NEEDED
option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(385 + 5 * HoyeongSpec$PSkillLv, 8, 690, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Toparyu <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HoyeongCore[[1]][6, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][6, 2])
info <- c(230 + 2 * HoyeongSpec$PSkillLv, 12, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Bunsinbu <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(390 + 5 * HoyeongSpec$PSkillLv, 12, 660, NA, 6, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Jijinswae <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(HoyeongCore[[1]][6, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][6, 2])
info <- c(850 + 4 * HoyeongSpec$SkillLv, 8, 0, 720, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MisaengGangbyeon <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(55, ifelse(HoyeongCore[[1]][1, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][1, 2])
info <- c(260 + 3 * HoyeongSpec$SkillLv, 10, 420, NA, 11, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Geumgobong1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(55, ifelse(HoyeongCore[[1]][1, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][1, 2])
info <- c(420 + 1 * HoyeongSpec$SkillLv, 8, 390, NA, 11, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Geumgobong2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(HoyeongCore[[1]][4, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][4, 2])
info <- c(275 + 3 * HoyeongSpec$SkillLv, 5, 0, 1000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HojeopJimong <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HoyeongCore[[1]][6, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][6, 2])
info <- c(430 + 2 * HoyeongSpec$PSkillLv + 8 * HoyeongCore[[2]][1, 2], 48, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Bunsinnanmu <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 36 * HoyeongCore[[2]][2, 2], 8, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwanGeneral <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * HoyeongCore[[2]][2, 2], 4, 0, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwanWrath <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(850 + 34 * HoyeongCore[[2]][3, 2], 8, 0, 1500, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinAttack <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1000 + 40 * HoyeongCore[[2]][3, 2], 15, 0, 300, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(625 + 25 * HoyeongCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeong <- rbind(data.frame(option, value), info)


## Summoned - Gwihwabu



