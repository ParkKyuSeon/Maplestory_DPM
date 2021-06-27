## Hoyeong - Data
## Hoyeong - VMatrix
HoyeongCore <- MatrixSet(PasSkills=c("Yeouiseon_Geumgobong", "Toparyu_Jijinswae", "Gwihwabu", "Hojeopjimong", "Heupseongwaryu", "Bunsinbu", 
                                     "MabongHorobu", "MisaengGangbyeon", "Myeolhwayeom_Pachopung"), 
                         PasLvs=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 10, 10, 10, 10, 10), 
                         ActSkills=c("Bunsinnanmu", "Sanryeongsohwan", "Goeryeoknansin", "CheonjiinHwanyeong",
                                      CommonV("Thief", "Anima")[c(2, 3, 4, 5)]), 
                         ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 5, 0, 0, 0), 
                         BlinkLv=1, 
                         BlinkMP=0, 
                         UsefulSkills=c("CombatOrders", "SharpEyes"), 
                         UsefulLvs=c(20, 20), 
                         UsefulMP=c(0, 0), 
                         SpecSet=SpecDefault, 
                         SelfBind=F)


## Hoyeong - Basic Info
HoyeongBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Hoyeong",
                       CoreData=HoyeongCore, 
                       BuffDurationNeeded=0, 
                       AbilList=c("PassiveLv", "DisorderBDR"), 
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
value <- c(70 + ceiling(HoyeongBase$PSkillLv / 2), 40 + HoyeongBase$PSkillLv, 25 + floor(HoyeongBase$PSkillLv/2))
FanExpert <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(10 + ceiling(HoyeongBase$PSkillLv / 2))
Deukdo <- data.frame(option, value)

option <- factor(c("ATK", "FDR", "CRR", "CDMR", "IGR"), levels=PSkill)
value <- c(rep(10 + HoyeongBase$PSkillLv, 5))
Jeomjeong <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(HoyeongCore[[2]][5, 2])
ReadyToDie <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(HoyeongCore[[2]][8, 2])
BlinkPassive <- data.frame(option, value)}

HoyeongPassive <- Passive(list(SpiritIntimacy=SpiritIntimacy, GoeiBongin=GoeiBongin, FanMastery=FanMastery, Siman=Siman, 
                               PhysicalTraining=PhysicalTraining, Sura=Sura, FanExpert=FanExpert, Deukdo=Deukdo, Jeomjeong=Jeomjeong, ReadyToDie=ReadyToDie, BlinkPassive=BlinkPassive))


## Hoyeong - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BujeokDoryeok <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DurumariDoryeok <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(10, NA, Delay(480, 2), F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Horobu1 <- rbind(data.frame(option, value), info)
  
option <- factor(levels=BSkill)
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
info <- c(0, 1, Delay(720, 2), F, NA, NA, F)
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
info <- c(30, 200, 900, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunsinnanmuBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45 + ceiling(HoyeongCore[[2]][2, 2]/2), 200, 900, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwan <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ElemComplete <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20 + 2 * HoyeongCore[[2]][3, 2])
info <- c(30, 200, 900, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Goeryeoknansin <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(30, 200, 0, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinAfter <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 100, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeongBuff <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * HoyeongCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * HoyeongCore[[3]][1, 2], NA, 0, F, NA, NA, T)
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
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)}

HoyeongBuff <- Buff(list(BujeokDoryeok=BujeokDoryeok, DurumariDoryeok=DurumariDoryeok, Horobu1=Horobu1, BunsinbuBuff=BunsinbuBuff, FanBooster=FanBooster, MisaengGangbyeonDebuff=MisaengGangbyeonDebuff, 
                         HojeopJimongBuff=HojeopJimongBuff, MapleSoldier=MapleSoldier, TaeeulSeondan=TaeeulSeondan, BunsinnanmuBuff=BunsinnanmuBuff, SanryeongSohwan=SanryeongSohwan, ElemComplete=ElemComplete, 
                         Goeryeoknansin=Goeryeoknansin, GoeryeoknansinAfter=GoeryeoknansinAfter, GoeryeoknansinStack=GoeryeoknansinStack, CheonjiinHwanyeongBuff=CheonjiinHwanyeongBuff, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, 
                         BlessofGrandisGoddess=BlessofGrandisGoddess, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## Petbuff : FanBooster, UsefulSharpEyes, UsefulCombatOrders
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


## Hoyeong - Attacks
## Hyper : Cheonjiin - Reinforce / Boss Killer, Hyeupseongwaryu - Heist / Gwihwabu - Heist / Bunsinbu - Ignore Guard
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(385 + 5 * HoyeongSpec$PSkillLv, 4, 570, NA, NA, NA, NA, F) ## ATKSpeed Not Applied
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Toparyu <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(385 + 5 * HoyeongSpec$PSkillLv, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ToparyuHeo <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(HoyeongCore[[1]][7, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][7, 2])
info <- c(1000 + 10 * HoyeongSpec$PSkillLv, 6, 270, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Horobu2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(25, ifelse(HoyeongCore[[1]][6, 2]>=40, 20, 0))), 2 * HoyeongCore[[1]][6, 2])
info <- c(230 + 2 * HoyeongSpec$PSkillLv, 12, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Bunsinbu <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(390 + 5 * HoyeongSpec$PSkillLv, 6, 540, NA, 6, T, T, F) ## ATKSpeed Not Applied
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Jijinswae <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(25, ifelse(HoyeongCore[[1]][2, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][2, 2])
info <- c(390 + 5 * HoyeongSpec$PSkillLv, 6, 0, NA, 6, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JijinswaeHeo <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(HoyeongCore[[1]][8, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][8, 2])
info <- c(850 + 4 * HoyeongSpec$SkillLv, 8, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MisaengGangbyeon <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(55, ifelse(HoyeongCore[[1]][1, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][1, 2])
info <- c(260 + 3 * HoyeongSpec$SkillLv, 10, 360, NA, 11, T, T, F) ## ATKSpeed Not Applied
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Geumgobong1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(55, ifelse(HoyeongCore[[1]][1, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][1, 2])
info <- c(420 + 1 * HoyeongSpec$SkillLv, 8, 330, NA, 11, T, T, F) ## ATKSpeed Not Applied
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Geumgobong2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(HoyeongCore[[1]][4, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][4, 2])
info <- c(275 + 3 * HoyeongSpec$SkillLv, 5, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
HojeopJimong <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(25, ifelse(HoyeongCore[[1]][6, 2]>=40, 20, 0))), 2 * HoyeongCore[[1]][6, 2])
info <- c(430 + 2 * HoyeongSpec$PSkillLv + 8 * HoyeongCore[[2]][1, 2], 40, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Bunsinnanmu <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(900 + 36 * HoyeongCore[[2]][2, 2], 8, 0, 3000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwanGeneral <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(350 + 14 * HoyeongCore[[2]][2, 2], 4, 0, 120, NA, NA, NA, F) ## 7 Hits
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SanryeongSohwanWrath <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(850 + 34 * HoyeongCore[[2]][3, 2], 8, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinAttack <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1000 + 40 * HoyeongCore[[2]][3, 2], 15, 3780, 300, NA, NA, NA, F) ## ATKSpeed Not Applied, 6 hits, StartDelay : 0
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GoeryeoknansinFinalAttack <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(625 + 25 * HoyeongCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeongCheon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(625 + 25 * HoyeongCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeongJi <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(625 + 25 * HoyeongCore[[2]][4, 2], 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CheonjiinHwanyeongIn <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 1000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TaeeulSeondanDummy <- rbind(data.frame(option, value), info)}

HoyeongATK <- Attack(list(Toparyu=Toparyu, ToparyuHeo=ToparyuHeo, Horobu2=Horobu2, Bunsinbu=Bunsinbu, Jijinswae=Jijinswae, JijinswaeHeo=JijinswaeHeo, MisaengGangbyeon=MisaengGangbyeon, 
                          Geumgobong1=Geumgobong1, Geumgobong2=Geumgobong2, HojeopJimong=HojeopJimong, Bunsinnanmu=Bunsinnanmu, 
                          SanryeongSohwanGeneral=SanryeongSohwanGeneral,SanryeongSohwanWrath=SanryeongSohwanWrath, GoeryeoknansinAttack=GoeryeoknansinAttack, GoeryeoknansinFinalAttack=GoeryeoknansinFinalAttack, 
                          CheonjiinHwanyeongCheon=CheonjiinHwanyeongCheon, CheonjiinHwanyeongJi=CheonjiinHwanyeongJi, CheonjiinHwanyeongIn=CheonjiinHwanyeongIn,
                          TaeeulSeondanDummy=TaeeulSeondanDummy, SpiderInMirror=SpiderInMirror))


## Summoned - Gwihwabu, Waryu
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(HoyeongCore[[1]][3, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][3, 2])
info <- c(390 + 5 * HoyeongSpec$PSkillLv, 5, 630, 1350, 40, NA, T, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Gwihwabu <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(HoyeongCore[[1]][5, 2]>=40, 20, 0), 2 * HoyeongCore[[1]][5, 2])
info <- c(240 + 4 * HoyeongSpec$SkillLv, 6, 990, 800, 40, 47.5, T, F, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
Heupseongwaryu <- rbind(data.frame(option, value), info)}

HoyeongSummoned <- Summoned(list(Gwihwabu=Gwihwabu, Heupseongwaryu=Heupseongwaryu, SpiderInMirrorStart=SpiderInMirrorStart, 
                                 SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Hoyeong - DealCycle & Deal Calculation
ATKFinal <- data.frame(HoyeongATK)
ATKFinal$Delay[c(-1, -5, -8, -9, -15)] <- Delay(ATKFinal$Delay, HoyeongSpec$ATKSpeed)[c(-1, -5, -8, -9, -15)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, HoyeongSpec$CoolReduceP, HoyeongSpec$CoolReduce)

BuffFinal <- data.frame(HoyeongBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, HoyeongSpec$CoolReduceP, HoyeongSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, HoyeongSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(HoyeongSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, HoyeongSpec$CoolReduceP, HoyeongSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * HoyeongSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(HoyeongBuff))
HoyeongDealCycle <- t(rep(0, length(DealCycle)))
colnames(HoyeongDealCycle) <- DealCycle

HoyeongCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, BlessofGrandisLv=25, 
                         Period=c(100, 190), CycleTime=c(400, 380)) {
  BuffSummonedPrior <- c("FanBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders",
                         "TaeeulSeondan", "BlessofGrandisGoddess", "Heupseongwaryu", "BunsinbuBuff", "SanryeongSohwan", "CheonjiinHwanyeongBuff", "Gwihwabu", "HojeopJimongBuff", 
                         "MisaengGangbyeonDebuff", "SoulContractLink", "BunsinnanmuBuff", "ReadyToDie2Stack", "Goeryeoknansin", "Restraint4")
  Times190 <- c(0, 0, 0, 0, 
                1, 0.5, 4, 1, 1, 2, 4, 2, 
                4, 2, 1, 2, 1, 1)
  
  SubTime <- rep(Period, length(BuffSummonedPrior))
  TotalTime <- CycleTime
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times190[i]==0, Inf, Times190[i])
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
  BuffList[[3]] <- c("Heupseongwaryu", "CheonjiinHwanyeongBuff", "Gwihwabu", "SoulContractLink", "ReadyToDie2Stack", 
                     "HojeopJimongBuff", "MisaengGangbyeonDebuff")
  BuffList[[7]] <- c("Heupseongwaryu", "CheonjiinHwanyeongBuff", "Gwihwabu", "SoulContractLink", "ReadyToDie2Stack", 
                     "HojeopJimongBuff", "MisaengGangbyeonDebuff")
  
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
  
  TaeeulSeondanLogic <- function(DealCycle) {
    TS <- subset(DealCycle, DealCycle$Skills=="TaeeulSeondan") 
    if(nrow(TS)==0) {
      return(DealCycle)
    } else {
      t1 <- DealCycle$Time[nrow(DealCycle)]
      t2 <- DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1]
      
      if(t2 - 12000 > max(TS$Time)) {
        return(DealCycle)
      } else {
        if(ceiling((t1 - max(TS$Time))/1000)!=0 & ceiling((t1 - max(TS$Time))/1000) < ceiling((t2 - max(TS$Time))/1000)) {
          for(i in (ceiling((t1 - max(TS$Time))/1000) + 1) : (ceiling((t2 - max(TS$Time))/1000))) {
            DealCycle <- rbind(DealCycle, TS[nrow(TS), ])
            DealCycle$Skills[nrow(DealCycle)] <- "TaeeulSeondanDummy"
            DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + (i-1) * 1000
          }
          DC2 <- DealCycle[1, ]
          DealCycle <- DealCycle[2:nrow(DealCycle), ]
          DealCycle <- DealCycle[order(DealCycle$Time), ] 
          DealCycle <- rbind(DC2, DealCycle)
          rownames(DealCycle) <- 1:nrow(DealCycle)
          
          for(i in 3:nrow(DealCycle)) {
            if(DealCycle$Skills[i]=="TaeeulSeondanDummy") {
              DealCycle[i, 5:ncol(DealCycle)] <- DealCycle[i-1, 5:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
              for(j in 5:ncol(DealCycle)) {
                DealCycle[i, j] <- max(0, DealCycle[i, j])
              }
            }
          }
          
          DC2 <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
          DealCycle[1, 2:ncol(DealCycle)] <- DealCycle[1, 2:ncol(DealCycle)] - (DealCycle$Time[nrow(DealCycle)] - DC2$Time[nrow(DC2)])
        }
      }
      return(DealCycle)
    }
  }
  CheonjiinLogic <- function(DealCycle, CheonjiinStatus) {
    CheonjiinStatus[1, 4:5] <- 0
    CheonjiinStatus$ElemComp <- 0
    if(sum(CheonjiinStatus[1, 1:3])==3) {
      CheonjiinStatus[1, 1:3] <- 0
      CheonjiinStatus$ElemComp <- 1
    }
    DealCycle <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
    Skills1 <- sum(CheonjiinStatus[1, 1:3])
    if(DealCycle$Skills[nrow(DealCycle)]=="Jijinswae" | DealCycle$Skills[nrow(DealCycle)]=="Toparyu" | DealCycle$Skills[nrow(DealCycle)]=="CheonjiinHwanyeongJi") {
      CheonjiinStatus$Ji <- min(1, CheonjiinStatus$Ji + 1)
      Skills2 <- sum(CheonjiinStatus[1, 1:3])
      if(Skills1==Skills2) {
        CheonjiinStatus$BujeokDoryeok <- 10
      } else {
        CheonjiinStatus$BujeokDoryeok <- 5 + Skills2 * 5
      }
      CheonjiinStatus$DurumariDoryeok <- 15
    } else if(DealCycle$Skills[nrow(DealCycle)]=="Geumgobong1" | DealCycle$Skills[nrow(DealCycle)]=="CheonjiinHwanyeongIn") {
      CheonjiinStatus$In <- min(1, CheonjiinStatus$In + 1)
      Skills2 <- sum(CheonjiinStatus[1, 1:3])
      if(Skills1==Skills2) {
        CheonjiinStatus$BujeokDoryeok <- 10
      } else {
        CheonjiinStatus$BujeokDoryeok <- 5 + Skills2 * 5
      }
      CheonjiinStatus$DurumariDoryeok <- 15
    } else if(DealCycle$Skills[nrow(DealCycle)]=="CheonjiinHwanyeongCheon") {
      CheonjiinStatus$Cheon <- min(1, CheonjiinStatus$Cheon + 1)
      Skills2 <- sum(CheonjiinStatus[1, 1:3])
      if(Skills1==Skills2) {
        CheonjiinStatus$BujeokDoryeok <- 10
      } else {
        CheonjiinStatus$BujeokDoryeok <- 5 + Skills2 * 5
      }
      CheonjiinStatus$DurumariDoryeok <- 15
    } else if(DealCycle$Skills[nrow(DealCycle)]=="BunsinbuBuff" | DealCycle$Skills[nrow(DealCycle)]=="GwihwabuSummoned" | DealCycle$Skills[nrow(DealCycle)]=="Horobu1") {
      CheonjiinStatus$DurumariDoryeok <- 200
    }
    return(CheonjiinStatus)
  }
  DoryeokLogic <- function(DealCycle, CheonjiinStatus, BlessofGrandisLv) {
    if(DealCycle$Skills[nrow(DealCycle)] == "TaeeulSeondanDummy") {
      if(DealCycle$Skills[nrow(DealCycle)-1] == "TaeeulSeondanDummy") {
        DC2 <- DealCycle[(nrow(DealCycle)-1):nrow(DealCycle), ]
        DealCycle <- DealCycle[1:(nrow(DealCycle)-2), ]
      } else {
        DC2 <- DealCycle[nrow(DealCycle), ]
        DealCycle <- DealCycle[1:(nrow(DealCycle)-1), ]
      }
    } else {
      DC2 <- DealCycle[nrow(DealCycle), ]
      DC2 <- DC2[-1, ]
    }
    
    if(DealCycle$BlessofGrandisGoddess[nrow(DealCycle)] > 0) {
      CheonjiinStatus$BujeokDoryeok <- floor((145 + BlessofGrandisLv) / 100 * CheonjiinStatus$BujeokDoryeok)
      CheonjiinStatus$DurumariDoryeok <- floor((145 + BlessofGrandisLv) / 100 * CheonjiinStatus$DurumariDoryeok)
    }
    
    DealCycle$BujeokDoryeok[nrow(DealCycle)] <- min(100, DealCycle$BujeokDoryeok[nrow(DealCycle)-1] + CheonjiinStatus$BujeokDoryeok)
    DealCycle$DurumariDoryeok[nrow(DealCycle)] <- min(900, DealCycle$DurumariDoryeok[nrow(DealCycle)-1] + CheonjiinStatus$DurumariDoryeok)
    DealCycle$ElemComplete[nrow(DealCycle)] <- CheonjiinStatus$ElemComp
    
    if(sum(DealCycle$Skills[nrow(DealCycle)]==c("Horobu1", "BunsinbuBuff", "GwihwabuSummoned"))>=1) {
      if(DealCycle$BujeokDoryeok[nrow(DealCycle)]!=100) {
        print(nrow(DealCycle))
        warning("Unavailable DealCycle")
      } else {
        DealCycle$BujeokDoryeok[nrow(DealCycle)] <- 0
      }
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("MisaengGangbyeonDebuff", "HojeopJimongBuff", "SanryeongSohwan", "HeupseongwaryuSummoned"))>=1) {
      if(DealCycle$DurumariDoryeok[nrow(DealCycle)]!=900) {
        print(nrow(DealCycle))
        warning("Unavailable DealCycle")
      } else {
        DealCycle$DurumariDoryeok[nrow(DealCycle)] <- 0
      }
    }
    
    if(nrow(DC2) > 0) {
      DealCycle <- rbind(DealCycle, DC2)
      for(i in 1:nrow(DC2)) {
        DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i)] <- DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + 
          ifelse(DealCycle$BlessofGrandisGoddess[nrow(DealCycle) - (nrow(DC2) - i)] > 0, 
                 DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + floor((145 + BlessofGrandisLv) / 100 * 35), 
                 DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + 35)
        DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i)] <- min(100, DealCycle$BujeokDoryeok[nrow(DealCycle) - (nrow(DC2) - i)])
        DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i)] <- DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + 
          ifelse(DealCycle$BlessofGrandisGoddess[nrow(DealCycle) - (nrow(DC2) - i)] > 0, 
                 DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + floor((145 + BlessofGrandisLv) / 100 * 350), 
                 DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i + 1)] + 350)
        DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i)] <- min(900, DealCycle$DurumariDoryeok[nrow(DealCycle) - (nrow(DC2) - i)])
      }
    }
    return(DealCycle)
  }
  HwanyeongType <- function(CheonjiinStatus, CHType) {
    if(CHType=="Ji") {
      if(sum(CheonjiinStatus[1, 1:3])==3 | CheonjiinStatus$Ji==0) {
        return("Ji")
      } else if(CheonjiinStatus$Cheon==0) {
        return("Cheon")
      } else {
        return("In")
      }
    } else if(CHType=="Cheon") {
      if(sum(CheonjiinStatus[1, 1:3])==3 | CheonjiinStatus$Cheon==0) {
        return("Cheon")
      } else if(CheonjiinStatus$In==0) {
        return("In")
      } else {
        return("Ji")
      }
    } else {
      if(sum(CheonjiinStatus[1, 1:3])==3 | CheonjiinStatus$In==0) {
        return("In")
      } else if(CheonjiinStatus$Ji==0) {
        return("Ji")
      } else {
        return("Cheon")
      }
    }
  }
  DoryeokType <- function(SkillName) {
    if(sum(SkillName==c("Horobu1", "BunsinbuBuff", "Gwihwabu"))>=1) {
      return("BujeokDoryeok")
    } else if(sum(SkillName==c("MisaengGangbyeonDebuff", "HojeopJimongBuff", "SanryeongSohwan", "Heupseongwaryu"))>=1) {
      return("DurumariDoryeok")
    } else {
      return("None")
    }
  }
  
  CheonjiinStatus <- data.frame(Cheon = 0, Ji = 0, In = 0, BujeokDoryeok = 0, DurumariDoryeok = 0, ElemComp = 0)  
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="MisaengGangbyeonDebuff") {
        DealCycle <- DCBuff(DealCycle, "Horobu1", BuffFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        DealCycle <- DCATK(DealCycle, "MisaengGangbyeon", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- TaeeulSeondanLogic(DealCycle)
      CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
      DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      if(BuffList[[1]][i]=="UsefulCombatOrders") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      } else if(BuffList[[1]][i]=="BlessofGrandisGoddess") {
        DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        DealCycle <- DCATK(DealCycle, "Jijinswae", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      } else if(BuffList[[1]][i]=="MisaengGangbyeonDebuff") {
        DealCycle$MisaengGangbyeonDebuff[nrow(DealCycle)] <- 60000
      } else if(BuffList[[1]][i]=="Restraint4") {
        DealCycle <- DCATK(DealCycle, "Horobu2", ATKFinal)
        DealCycle <- TaeeulSeondanLogic(DealCycle)
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- TaeeulSeondanLogic(DealCycle)
      CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
      DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
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
  MGDummy <- 0
  GBCool <- subset(ATKFinal, rownames(ATKFinal)=="Geumgobong1")$CoolTime * 1000
  JSCool <- subset(ATKFinal, rownames(ATKFinal)=="Jijinswae")$CoolTime * 1000
  
  GBRemain <- GBCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="Geumgobong1")$Time)
  JSRemain <- JSCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="Jijinswae")$Time)
  CHActiveStack <- 1 ; CHActiveRemain <- 0 ; CHPassiveRemain <- 0 ; CHType <- "Ji"
    
  ## HwangyeongOrder -> Ji, Cheon, In
  
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
          GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
          CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
          CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
          DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        }
      }
      ## Goeryeoknansin Last
      if(DealCycle$Goeryeoknansin[nrow(DealCycle)] > 0 & DealCycle$Goeryeoknansin[nrow(DealCycle)] < 1000) {
        DealCycle <- DCBuff(DealCycle, "GoeryeoknansinAfter", BuffFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        DealCycle$Goeryeoknansin[nrow(DealCycle)] <- 0
        
        DealCycle <- DCATK(DealCycle, "GoeryeoknansinFinalAttack", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      } 
      ## Horobu
      else if(DealCycle$BujeokDoryeok[nrow(DealCycle)] == 100 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - 7000) {
        DealCycle <- DCBuff(DealCycle, "Horobu1", BuffFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        DealCycle <- DCATK(DealCycle, "Horobu2", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      } 
      ## MisaengGangbyeon
      else if(sum(k==c(3, 7))==1 & MGDummy==0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] > BuffStartTime - 30000 & 
              DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - 20000 & DealCycle$DurumariDoryeok[nrow(DealCycle)] == 900) {
        DealCycle <- DCATK(DealCycle, "MisaengGangbyeon", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        DealCycle <- DCBuff(DealCycle, "MisaengGangbyeonDebuff", BuffFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        DealCycle$MisaengGangbyeonDebuff[nrow(DealCycle)] <- 60000
      }
      ## Geumgobong
      else if(GBRemain == 0 & k!=9 | GBRemain == 0 & k==9 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - GBCool) {
        DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
        GBRemain <- GBCool - DealCycle$Time[1] ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
          GBRemain <- 0
        }
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        ## Cheonjiin Hwanyeong - Active
        if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
          if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
            CHType <- HwanyeongType(CheonjiinStatus, CHType)
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
            
            DC2 <- DealCycle[1, ]
            DealCycle <- DealCycle[2:nrow(DealCycle), ]
            DealCycle <- DealCycle[order(DealCycle$Time), ] 
            DealCycle <- rbind(DC2, DealCycle)
            rownames(DealCycle) <- 1:nrow(DealCycle)
            
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
            CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - DealCycle$Time[1])
            CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
            
            CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
            if(CheonjiinStatus$ElemComp==1) {
              GBRemain <- 0
            }
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          } else {
            CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) 
          }
        }
        ## Cheonjiin Hwanyeong - Passive
        else {
          if(CHPassiveRemain==0) {
            CHType <- HwanyeongType(CheonjiinStatus, CHType)
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
            
            DC2 <- DealCycle[1, ]
            DealCycle <- DealCycle[2:nrow(DealCycle), ]
            DealCycle <- DealCycle[order(DealCycle$Time), ] 
            DealCycle <- rbind(DC2, DealCycle)
            rownames(DealCycle) <- 1:nrow(DealCycle)
            
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
            CHPassiveRemain <- 5000 - DealCycle$Time[1]
            
            CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          } else {
            CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
          }
        }
        
        DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
      }
      ## Jijinswae
      else if(JSRemain == 0 & DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] == 0 & k!=9 | 
              JSRemain == 0 & DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] == 0 & k==9 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - JSCool) {
        DealCycle <- DCATK(DealCycle, "Jijinswae", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- JSCool - DealCycle$Time[1]
        CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        ## Cheonjiin Hwanyeong - Passive
        if(CHPassiveRemain==0) {
          CHType <- HwanyeongType(CheonjiinStatus, CHType)
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
          
          DC2 <- DealCycle[1, ]
          DealCycle <- DealCycle[2:nrow(DealCycle), ]
          DealCycle <- DealCycle[order(DealCycle$Time), ] 
          DealCycle <- rbind(DC2, DealCycle)
          rownames(DealCycle) <- 1:nrow(DealCycle)
          
          DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          CHPassiveRemain <- 5000 - DealCycle$Time[1]
          
          CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
          DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        } else {
          CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
        }
      }
      ## Toparyu
      else {
        DealCycle <- DCATK(DealCycle, "Toparyu", ATKFinal)
        GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
        CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
        if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
          GBRemain <- 0
        }
        DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        
        ## Cheonjiin Hwanyeong - Active
        if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
          if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
            CHType <- HwanyeongType(CheonjiinStatus, CHType)
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
            
            DC2 <- DealCycle[1, ]
            DealCycle <- DealCycle[2:nrow(DealCycle), ]
            DealCycle <- DealCycle[order(DealCycle$Time), ] 
            DealCycle <- rbind(DC2, DealCycle)
            rownames(DealCycle) <- 1:nrow(DealCycle)
            
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
            CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - DealCycle$Time[1])
            CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
            
            CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
            if(CheonjiinStatus$ElemComp==1) {
              GBRemain <- 0
            }
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          } else {
            CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) 
          }
        }
        ## Cheonjiin Hwanyeong - Passive
        else {
          if(CHPassiveRemain==0) {
            CHType <- HwanyeongType(CheonjiinStatus, CHType)
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
            
            DC2 <- DealCycle[1, ]
            DealCycle <- DealCycle[2:nrow(DealCycle), ]
            DealCycle <- DealCycle[order(DealCycle$Time), ] 
            DealCycle <- rbind(DC2, DealCycle)
            rownames(DealCycle) <- 1:nrow(DealCycle)
            
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
            CHPassiveRemain <- 5000 - DealCycle$Time[1]
            
            CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          } else {
            CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
          }
        }
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(DoryeokType(BuffList[[k]][i])=="BujeokDoryeok" & DealCycle$BujeokDoryeok[nrow(DealCycle)] < 100) {
            while(DealCycle$BujeokDoryeok[nrow(DealCycle)] < 100) {
              ## Geumgobong
              if(GBRemain == 0) {
                DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
                GBRemain <- GBCool - DealCycle$Time[1] ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                
                DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              }
              ## Toparyu
              else {
                DealCycle <- DCATK(DealCycle, "Toparyu", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
              }
            }
          } else if(DoryeokType(BuffList[[k]][i])=="DurumariDoryeok" & DealCycle$BujeokDoryeok[nrow(DealCycle)] < 900) {
            while(DealCycle$DurumariDoryeok[nrow(DealCycle)] < 900) {
              ## Horobu
              if(DealCycle$BujeokDoryeok[nrow(DealCycle)] == 100) {
                DealCycle <- DCBuff(DealCycle, "Horobu1", BuffFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                DealCycle <- DCATK(DealCycle, "Horobu2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              } 
              ## Geumgobong
              else if(GBRemain == 0) {
                DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
                GBRemain <- GBCool - DealCycle$Time[1] ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                
                DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              }
              ## Toparyu
              else {
                DealCycle <- DCATK(DealCycle, "Toparyu", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                DealCycle <- TaeeulSeondanLogic(DealCycle)
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
              }
            }
          }
          if(BuffList[[k]][i]=="MisaengGangbyeonDebuff") {
            DealCycle <- DCATK(DealCycle, "MisaengGangbyeon", ATKFinal)
            GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
            CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
            DealCycle <- TaeeulSeondanLogic(DealCycle)
            CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
            DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
          CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
          DealCycle <- TaeeulSeondanLogic(DealCycle)
          CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
          DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
          if(BuffList[[k]][i]=="MisaengGangbyeonDebuff") {
            DealCycle$MisaengGangbyeonDebuff[nrow(DealCycle)] <- 60000
          } 
        } else {
          if(DoryeokType(BuffList[[k]][i])=="BujeokDoryeok" & DealCycle$BujeokDoryeok[nrow(DealCycle)] < 100) {
            while(DealCycle$BujeokDoryeok[nrow(DealCycle)] < 100) {
              ## Geumgobong
              if(GBRemain == 0) {
                DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
                GBRemain <- GBCool - DealCycle$Time[1] ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                
                DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              }
              ## Toparyu
              else {
                DealCycle <- DCATK(DealCycle, "Toparyu", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
              }
            }
          } else if(DoryeokType(BuffList[[k]][i])=="DurumariDoryeok" & DealCycle$DurumariDoryeok[nrow(DealCycle)] < 900) {
            while(DealCycle$DurumariDoryeok[nrow(DealCycle)] < 900) {
              ## Horobu
              if(DealCycle$BujeokDoryeok[nrow(DealCycle)] == 100) {
                DealCycle <- DCBuff(DealCycle, "Horobu1", BuffFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                DealCycle <- DCATK(DealCycle, "Horobu2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              } 
              ## Geumgobong
              else if(GBRemain == 0) {
                DealCycle <- DCATK(DealCycle, "Geumgobong1", ATKFinal)
                GBRemain <- GBCool - DealCycle$Time[1] ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                
                DealCycle <- DCATK(DealCycle, "Geumgobong2", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
              }
              ## Toparyu
              else {
                DealCycle <- DCATK(DealCycle, "Toparyu", ATKFinal)
                GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
                CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0 & CheonjiinStatus$ElemComp==1) {
                  GBRemain <- 0
                }
                DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                
                ## Cheonjiin Hwanyeong - Active
                if(DealCycle$CheonjiinHwanyeongBuff[nrow(DealCycle)] > 0) {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHActiveStack==1 & CHActiveRemain==0 | CHActiveStack==2) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHActiveRemain <- ifelse(CHActiveStack==1, 0, 2000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                    CHActiveStack <- ifelse(CHActiveStack==1, 2, 1)
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    if(CheonjiinStatus$ElemComp==1) {
                      GBRemain <- 0
                    }
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHActiveRemain <- max(0, CHActiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
                ## Cheonjiin Hwanyeong - Passive
                else {
                  SS <- subset(DealCycle, DealCycle$Skills!="TaeeulSeondanDummy")
                  if(CHPassiveRemain==0) {
                    CHType <- HwanyeongType(CheonjiinStatus, CHType)
                    DealCycle <- rbind(DealCycle, SS[nrow(SS), ])
                    DealCycle$Skills[nrow(DealCycle)] <- paste("CheonjiinHwanyeong", CHType, sep="")
                    
                    DC2 <- DealCycle[1, ]
                    DealCycle <- DealCycle[2:nrow(DealCycle), ]
                    DealCycle <- DealCycle[order(DealCycle$Time), ] 
                    DealCycle <- rbind(DC2, DealCycle)
                    rownames(DealCycle) <- 1:nrow(DealCycle)
                    
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                    CHPassiveRemain <- 5000 - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)])
                    
                    CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
                    DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
                  } else {
                    CHPassiveRemain <- max(0, CHPassiveRemain - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - SS$Time[nrow(SS)]))
                  }
                }
              }
            }
          }
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          GBRemain <- max(0, GBRemain - DealCycle$Time[1]) ; JSRemain <- max(0, JSRemain - DealCycle$Time[1])
          CHActiveRemain <- max(0, CHActiveRemain - DealCycle$Time[1]) ; CHPassiveRemain <- max(0, CHPassiveRemain - DealCycle$Time[1])
          DealCycle <- TaeeulSeondanLogic(DealCycle)
          CheonjiinStatus <- CheonjiinLogic(DealCycle, CheonjiinStatus)
          DealCycle <- DoryeokLogic(DealCycle, CheonjiinStatus, BlessofGrandisLv)
        }
      }
    }
    if(k==3 | k==7) {
      MGDummy <- 0
    }
  }
  return(DealCycle)
}
HoyeongAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Toparyu, Jijinswae - Heo
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Toparyu") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ToparyuHeo"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + 360
    } else if(DealCycle$Skills[i]=="Jijinswae") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "JijinswaeHeo"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + 1020
    }
  }
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("ToparyuHeo", "JijinswaeHeo"))>=1) {
      DealCycle[i, 5:ncol(DealCycle)] <- DealCycle[i-1, 5:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 5:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## SanryeongSohwan
  DealCycle$Skills[DealCycle$Skills=="SanryeongSohwan"] <- "SanryeongSohwanGeneral"
  DealCycle <- RepATKCycle(DealCycle, "SanryeongSohwanGeneral", 21, 2790, ATKFinal)
  
  Time <- c()
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SanryeongSohwanGeneralStart", "SanryeongSohwanGeneral"))==1) {
      Time <- c(Time, DealCycle$Time[i])
    }
  }
  
  Time1 <- Time[1:22]
  Time2 <- Time[23:44]
  Wrath1 <- c()
  Wrath2 <- c()
  
  for(i in 1:21) {
    DC1 <- subset(DealCycle, DealCycle$Time < Time1[i+1])
    DC1 <- subset(DC1, DC1$Time >= Time1[i])
    
    Wrath1[i] <- sum(DC1$ElemComplete)
    Wrath1[i] <- min(1, Wrath1[i])
    
    DC2 <- subset(DealCycle, DealCycle$Time < Time2[i+1])
    DC2 <- subset(DC2, DC2$Time >= Time2[i])
    
    Wrath2[i] <- sum(DC2$ElemComplete)
    Wrath2[i] <- min(1, Wrath2[i])
  }
  
  Wrath <- c(Wrath1, Wrath2)
  DC1 <- subset(DealCycle, DealCycle$Skills=="SanryeongSohwanGeneral")
  DC2 <- subset(DealCycle, DealCycle$Skills!="SanryeongSohwanGeneral")
  
  for(i in 1:length(Wrath)) {
    DC1$Skills[i] <- ifelse(Wrath[i]==0, "SanryeongSohwanGeneral", "SanryeongSohwanWrath")
  }
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Bunsinbu
  BS <- subset(DealCycle, DealCycle$Skills=="BunsinbuBuff")
  Ind <- rownames(BS)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 1501
    while(p < Ind[i+1] & DealCycle$BunsinbuBuff[p] > 0) {
      if(time > 1500 & max(DealCycle$Skills[p]==c("Toparyu", "ToparyuHeo", "Horobu2", "Jijinswae", "JijinswaeHeo", "MisaengGangbyeon", 
                                                  "Geumgobong1", "Geumgobong2"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("Bunsinbu")
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
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Bunsinbu" & DealCycle$BunsinnanmuBuff[i] > 0) {
      DealCycle$Skills[i] <- "Bunsinnanmu"
    }
  }
  
  
  ## Hojeopjimong
  HJ <- subset(DealCycle, DealCycle$Skills=="HojeopJimongBuff")
  Ind <- rownames(HJ)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 1001
    while(p < Ind[i+1] & DealCycle$BunsinbuBuff[p] > 0) {
      if(time > 1000 & max(DealCycle$Skills[p]==c("Toparyu", "ToparyuHeo", "Horobu2", "Jijinswae", "JijinswaeHeo", "MisaengGangbyeon", 
                                                  "Geumgobong1", "Geumgobong2"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("HojeopJimong")
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
  
  
  ## Goeryeoknansin
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Goeryeoknansin[i] > 0 & sum(DealCycle$Skills[i]==c("Toparyu", "ToparyuHeo", "Horobu2", "Jijinswae", "JijinswaeHeo", "MisaengGangbyeon", 
                                                                    "Geumgobong1", "Geumgobong2", "CheonjiinHwanyeongCheon", "CheonjiinHwanyeongJi", "CheonjiinHwanyeongIn"))==1) {
      DealCycle$GoeryeoknansinStack[i] <- min(12, DealCycle$GoeryeoknansinStack[i-1] + 1)
    } else if(DealCycle$Goeryeoknansin[i] > 0 & sum(DealCycle$Skills[i]==c("HojeopJimong"))==1) {
      DealCycle$GoeryeoknansinStack[i] <- min(12, DealCycle$GoeryeoknansinStack[i-1] + 5)
    } else if(DealCycle$Goeryeoknansin[i] > 0 & sum(DealCycle$Skills[i]==c("Bunsinbu"))==1) {
      DealCycle$GoeryeoknansinStack[i] <- min(12, DealCycle$GoeryeoknansinStack[i-1] + 3)
    } else if(DealCycle$Goeryeoknansin[i] > 0 & sum(DealCycle$Skills[i]==c("Bunsinnanmu"))==1) {
      DealCycle$GoeryeoknansinStack[i] <- min(12, DealCycle$GoeryeoknansinStack[i-1] + 10)
    } else if(DealCycle$Goeryeoknansin[i] > 0) {
      DealCycle$GoeryeoknansinStack[i] <- DealCycle$GoeryeoknansinStack[i-1]
    } else {
      DealCycle$GoeryeoknansinStack[i] <- 0
    }
    
    SS1 <- subset(DealCycle, DealCycle$Skills=="Goeryeoknansin")
    SS2 <- subset(DealCycle, DealCycle$Skills=="GoeryeoknansinAttack")
    SS <- rbind(SS1, SS2)
    SS <- SS[order(SS$Time), ] 
    rownames(SS) <- 1:nrow(SS)
    SS <- subset(SS, SS$Time < DealCycle$Time[i])
    
    if(nrow(SS) > 0) {
      if(DealCycle$GoeryeoknansinStack[i]==12 & DealCycle$Time[i] != DealCycle$Time[i+1] & DealCycle$Time[i+1] > max(SS$Time) + 1500) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "GoeryeoknansinAttack"
        DealCycle$Time[nrow(DealCycle)] <- max(max(SS$Time) + 1500, DealCycle$Time[i])
        DealCycle$GoeryeoknansinStack[i] <- 0
      }
    }
  }
  
  DealCycle 
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GoeryeoknansinAttack") {
      DealCycle[i, 5:ncol(DealCycle)] <- DealCycle[i-1, 5:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 5:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  
  
  ## Rep ATKs, Summoned Skills
  DealCycle <- RepATKCycle(DealCycle, "SanryeongSohwanWrath", 7, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "GoeryeoknansinFinalAttack", 6, 0, ATKFinal)
  
  DealCycle <- DCSummonedATKs(DealCycle, "Gwihwabu", SummonedFinal)
  DealCycle <- DCSummonedATKs(DealCycle, "Heupseongwaryu", SummonedFinal)
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Goeryeoknansin After Buff
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$GoeryeoknansinAfter[i] > 0 & sum(DealCycle$Skills[i]==c("Toparyu", "ToparyuHeo", "Jijinswae", "JijinswaeHeo", "Geumgobong1", "Geumgobong2"))==1) {
      DealCycle$GoeryeoknansinAfter[i] <- 1
    } else {
      DealCycle$GoeryeoknansinAfter[i] <- 0
    }
  }
  
  
  ## Dummy Reduction
  DealCycle$GoeryeoknansinStack <- 0
  DealCycle$BujeokDoryeok <- 0
  DealCycle$DurumariDoryeok <- 0
  DealCycle$Horobu1 <- 0
  DealCycle$ElemComplete <- 0
  
  return(DealCycle)
}
  
HoyeongDealCycle <- HoyeongCycle(HoyeongDealCycle, 
                                 ATKFinal, 
                                 BuffFinal, 
                                 SummonedFinal, 
                                 Spec=HoyeongSpec, 
                                 BlessofGrandisLv=HoyeongCore[[2]][6, 2],
                                 Period=190, 
                                 CycleTime=380)
HoyeongDealCycle <- DealCycleFinal(HoyeongDealCycle)
HoyeongDealCycle <- HoyeongAddATK(HoyeongDealCycle, 
                                  ATKFinal, 
                                  BuffFinal, 
                                  SummonedFinal, 
                                  Spec=HoyeongSpec)
HoyeongDealCycleReduction <- DealCycleReduction(HoyeongDealCycle)


HoyeongSpecOpt1 <- Optimization1(HoyeongDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HoyeongSpec, HoyeongUnionRemained)
HoyeongSpecOpt <- HoyeongSpec
HoyeongSpecOpt$ATKP <- HoyeongSpecOpt$ATKP + HoyeongSpecOpt1$ATKP
HoyeongSpecOpt$BDR <- HoyeongSpecOpt$BDR + HoyeongSpecOpt1$BDR
HoyeongSpecOpt$IGR <- IGRCalc(c(HoyeongSpecOpt$IGR, HoyeongSpecOpt1$IGR))

HoyeongSpecOpt2 <- Optimization2(HoyeongDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, HoyeongSpecOpt, HoyeongHyperStatBase, HoyeongBase$ChrLv, HoyeongBase$CRROver)
HoyeongFinalDPM <- DealCalc(HoyeongDealCycle, ATKFinal, BuffFinal, SummonedFinal, HoyeongSpecOpt2)
HoyeongFinalDPMwithMax <- DealCalcWithMaxDMR(HoyeongDealCycle, ATKFinal, BuffFinal, SummonedFinal, HoyeongSpecOpt2)

DPM12347$Hoyeong[1] <- sum(na.omit(HoyeongFinalDPMwithMax)) / (max(HoyeongDealCycle$Time)/ 60000)
DPM12347$Hoyeong[2] <- sum(na.omit(HoyeongFinalDPM)) / (max(HoyeongDealCycle$Time) / 60000) - sum(na.omit(HoyeongFinalDPMwithMax)) / (max(HoyeongDealCycle$Time) / 60000)

HoyeongDealData <- data.frame(HoyeongDealCycle$Skills, HoyeongDealCycle$Time, HoyeongDealCycle$Restraint4, HoyeongFinalDPMwithMax)
colnames(HoyeongDealData) <- c("Skills", "Time", "R4", "Deal")
subset(HoyeongDealData, HoyeongDealData$R4>0)

HoyeongRR <- HoyeongDealData[67:232, ]
DPM12347$Hoyeong[3] <- sum((HoyeongRR$Deal))

Hoyeong40s <- HoyeongDealData[67:476, ]
DPM12347$Hoyeong[4] <- sum((Hoyeong40s$Deal))

HoyeongDealRatio <- DealRatio(HoyeongDealCycle, HoyeongFinalDPMwithMax)