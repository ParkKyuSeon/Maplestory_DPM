## Eunwol - Data
## Eunwol - VMatrix
EunwolCore <- MatrixSet(PasSkills=c("Gwicham", "SohonJangmak", "Bulyeouryeong", "JeongryeongeuiHwasin", "PashwaeCheoljoHoe", "Pokryugwon"), 
                        PasLvs=c(50, 50, 50, 50, 50, 50), 
                        PasMP=c(10, 10, 10, 10, 10, 10), 
                        ActSkills=c("JeongryeongJipsok", "Gwimunjin", "JinGwicham", "PashwaeYeongwon", 
                                    CommonV("Pirate", "Heroes")), 
                        ActLvs=c(25, 25, 25, 25, 25, 25, 1, 25, 25), 
                        ActMP=c(5, 5, 5, 5, 0, 5, 0, 5, 5), 
                        UsefulSkills=c("SharpEyes", "CombatOrders", "WindBooster"), 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=SpecDefault)


## Eunwol - Basic Info
## Link Check Needed
EunwolBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=MobDefault,
                      SpecSet=SpecDefault, 
                      Job="Eunwol",
                      CoreData=EunwolCore, 
                      MikhailLink=F, 
                      OtherBuffDuration=0, 
                      AbilList=c("BDR", "DisorderBDR"), 
                      LinkList=c("Eunwol", "DemonAvenger", "Phantom", "AdventureBowman"), 
                      MonsterLife=MLTypeS21, 
                      Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", SpecDefault$WeaponType)[, 1:16],
                      WeaponType=SpecDefault$WeaponType, 
                      SubWeapon=SubWeapon[25, ], 
                      Emblem=Emblem[2, ], 
                      CoolReduceHat=T)


## Eunwol - Passive
{option <- factor(c("SummonDuration"), levels=PSkill)
value <- c(5)
JeongryeongChinhwa <- data.frame(option, value)

option <- factor(c("ATKSpeed"), levels=PSkill)
value <- c(1)
JeongryeongGyeolsok2 <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
GeunryeokDanryeon <- data.frame(option, value)

option <- factor(c("BDR", "ATK"), levels=PSkill)
value <- c(20, 20)
JeongryeongGyeolsok3 <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(20)
Yakhwa <- data.frame(option, value)

option <- factor(c("IGR", "FDR", "BDR"), levels=PSkill)
value <- c(30 + EunwolBase$PSkillLv, 15 + floor(EunwolBase$PSkillLv/3), 30 + EunwolBase$PSkillLv)
JeongryeongGyeolsok4 <- data.frame(option, value)

option <- factor(c("Mastery", "CDMR", "FDR"), levels=PSkill)
value <- c(70 + 2 * floor(EunwolBase$PSkillLv/3), 20 + 2 * ceiling(EunwolBase$PSkillLv/3), 10 + ceiling(EunwolBase$PSkillLv/3))
GogeupKnuckleSukryeon <- data.frame(option, value)

option <- factor(c("CRR"), levels=PSkill)
value <- c(25 + ceiling(EunwolBase$PSkillLv/2))
YakjeomGanpa <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(10 + EunwolCore[[2]][5, 2])
LoadedDicePassive <- data.frame(option, value)}

EunwolPassive <- Passive(list(JeongryeongChinhwa=JeongryeongChinhwa, JeongryeongGyeolsok2=JeongryeongGyeolsok2, GeunryeokDanryeon=GeunryeokDanryeon, 
                              JeongryeongGyeolsok3=JeongryeongGyeolsok3, Yakhwa=Yakhwa, JeongryeongGyeolsok4=JeongryeongGyeolsok4, GogeupKnuckleSukryeon=GogeupKnuckleSukryeon, 
                              YakjeomGanpa=YakjeomGanpa, LoadedDicePassive=LoadedDicePassive))


## Eunwol - Buff
{option <- factor("MainStat", levels=BSkill)
value <- c(floor((EunwolBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(EunwolBase$SkillLv/2))))
info <- c(900 + 30 * EunwolBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + 2 * EunwolBase$SkillLv, 60 - 12 * EunwolBase$SkillLv, 720, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
SohonGyeolgye <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10)
info <- c(10, 11, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PashwaeCheoljoBan <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(11.32, 210, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunhonGyeokchamDebuffFixed <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(20)
info <- c(11.32, 210, 0, F, T, T, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BunhonGyeokchamDebuffMoving <- rbind(data.frame(option, value), info)

option <- factor("CDMR", levels=BSkill)
value <- c(25 + floor(EunwolBase$PSkillLv/2))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
YakjeomGanpaAdd <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "ATK", "BDR", "ATKSpeed", "IGR"), levels=BSkill)
value <- c(35, 20, 20, 1, 20)
info <- c(300, 2400, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JeongryeongGyeolsokMax <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * EunwolCore[[3]][1, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * EunwolCore[[3]][2, 2], NA, 1500, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * EunwolCore[[3]][3, 2], NA, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulWindBooster <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(5 + floor(EunwolCore[[2]][1, 2])/2)
info <- c(30 + EunwolCore[[2]][1, 2], 120, 900, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JeongryeongJipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 120 - EunwolCore[[2]][2, 2], 990, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GwimunjinBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(8, 9, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GwimunjinDebuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
GwimunjinStack <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(floor((0.2 + 0.02 * EunwolCore[[2]][6, 2]) * 221))
info <- c(30, 70 - floor(EunwolCore[[2]][6, 2]/5), 540, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDrive <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(-1 * floor(0.15 * 221))
info <- c(Cooldown(70 - floor(EunwolCore[[2]][6, 2]/5), T, EunwolBase$UnionChrs$CoolReduceP, EunwolBase$CoolReduce) - 30 - General$General$Serverlag, 70 - floor(EunwolCore[[2]][6, 2]/5), 0, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverDriveExhaust <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(20)
info <- c(180, 180, 990, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LuckyDice5 <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * EunwolCore[[2]][8, 2]) * MapleSoldier[1, 2]) * EunwolBase$MainStatP), 5 + floor(EunwolCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

EunwolBuff <- Buff(list(MapleSoldier=MapleSoldier, SohonGyeolgye=SohonGyeolgye, PashwaeCheoljoBan=PashwaeCheoljoBan, 
                        BunhonGyeokchamDebuffFixed=BunhonGyeokchamDebuffFixed, BunhonGyeokchamDebuffMoving=BunhonGyeokchamDebuffMoving,
                        YakjeomGanpaAdd=YakjeomGanpaAdd, HeroesOath=HeroesOath, JeongryeongGyeolsokMax=JeongryeongGyeolsokMax, 
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulWindBooster=UsefulWindBooster, 
                        JeongryeongJipsok=JeongryeongJipsok, GwimunjinBuff=GwimunjinBuff, GwimunjinDebuff=GwimunjinDebuff, GwimunjinStack=GwimunjinStack, OverDrive=OverDrive, OverDriveExhaust=OverDriveExhaust, 
                        LuckyDice5=LuckyDice5, MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
## PetBuff : MapleSoldier
EunwolAllTimeBuff <- AllTimeBuff(EunwolBuff)


## Eunwol - Union & HyperStat & SoulWeapon
EunwolSpec <- JobSpec(JobBase=EunwolBase, 
                      Passive=EunwolPassive, 
                      AllTimeBuff=EunwolAllTimeBuff, 
                      MobInfo=MobDefault, 
                      SpecSet=SpecDefault, 
                      WeaponName="Knuckle", 
                      UnionStance=0)

EunwolUnionRemained <- EunwolSpec$UnionRemained
EunwolHyperStatBase <- EunwolSpec$HyperStatBase
EunwolCoolReduceType <- EunwolSpec$CoolReduceType
EunwolSpec <- EunwolSpec$Spec


## Eunwol - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * EunwolCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * EunwolCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EunwolCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EunwolCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EunwolCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * EunwolCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## JeongryeongJipsok Data
JipsokSkills <- c("PashwaeCheoljoHa", "PashwaeCheoljoJeon", "PashwaeCheoljoHoe", "Gwicham", "SahonGakin", "SohonJangmak", 
                  "JeongryeongeuiHwasin", "Paryeokgwon", "Tongbaekgwon", "Pokryugwon")
JipsokInd <- c(5, 5, 5, 25, 10, 25, 
               25, 5, 10, 25)
JipsokProb <- JipsokInd/sum(JipsokInd)
JipsokData <- data.frame(Skills=JipsokSkills, Ind=JipsokInd, Prob=JipsokProb)


## Eunwol - Attacks
## Bunhon Add ATK Needed, Yeouryeong(Jipsok1(Ind5), Jipsok2(Ind10), Jipsok3(Ind25), Jipsok3(Ind25 + Cancelled)) Needed
{option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], 40, ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(265 + 5 * EunwolSpec$SkillLv, 13, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Gwicham <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], 40, IGRCalc(c(ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0), 50)))
info <- c(540 + 6 * EunwolCore[[2]][3, 2], 13, 720, NA, 6, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JinGwicham <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * EunwolCore[[1]][2, 2], ifelse(EunwolCore[[1]][2, 2]>=40, 20, 0))
info <- c(45 * 8, 5, 10000, 180, 10 + Cooldown(10, T, EunwolSpec$CoolReduceP, EunwolSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SohonJangmak <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, 0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2), 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Bulyeouryeong <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, 1, 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulyeouryeongPashwaeYeongwon <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)) * (5 / sum(JipsokData$Ind)), 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulyeouryeongJipsok1 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)) * (10 / sum(JipsokData$Ind)), 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulyeouryeongJipsok2 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)) * (25 / sum(JipsokData$Ind)), 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulyeouryeongJipsok3 <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][3, 2], ifelse(EunwolCore[[1]][3, 2]>=40, 20, 0))
info <- c(200 + 5 * EunwolSpec$PSkillLv, (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)) * (25 / sum(JipsokData$Ind) - (25 / sum(JipsokData$Ind))^2), 0, 600, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BulyeouryeongJipsok3Cancelled <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * EunwolCore[[1]][5, 2], ifelse(EunwolCore[[1]][5, 2]>=40, 20, 0))
info <- c(160, 4, 630, NA, 1, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeCheoljoHoe <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(2000 + 40 * EunwolSpec$SkillLv, 1, 1065, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BunhonGyeokchamATK <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(100, 4 * JipsokData$Prob[1], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeCheoljoHaJipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(110, 4 * JipsokData$Prob[2], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeCheoljoJeonJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * EunwolCore[[1]][5, 2], ifelse(EunwolCore[[1]][5, 2]>=40, 20, 0))
info <- c(160, 4 * JipsokData$Prob[3], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeCheoljoHoeJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "BDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], 40, ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(265 + 5 * EunwolSpec$SkillLv, 13 * JipsokData$Prob[4], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GwichamJipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(700 + 15 * EunwolSpec$SkillLv, 3 * JipsokData$Prob[5], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SahonGakinJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * EunwolCore[[1]][2, 2], ifelse(EunwolCore[[1]][2, 2]>=40, 20, 0))
info <- c(45, 5 * JipsokData$Prob[6], 0, 270, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SohonJangmakJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(3 * EunwolCore[[1]][2, 2], ifelse(EunwolCore[[1]][2, 2]>=40, 20, 0))
info <- c(45, 5 * (JipsokData$Prob[6] - JipsokData$Prob[6]^2), 0, 270, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SohonJangmakJipsokCancelled <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][4, 2], ifelse(EunwolCore[[1]][4, 2]>=40, 20, 0))
info <- c(700, JipsokData$Prob[7], 0, 360, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JeongryeongeuiHwasinJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][4, 2], ifelse(EunwolCore[[1]][4, 2]>=40, 20, 0))
info <- c(700, JipsokData$Prob[7] - JipsokData$Prob[7]^2, 0, 360, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JeongryeongeuiHwasinJipsokCancelled <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(360, 2 * JipsokData$Prob[8], 0, 720, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ParyeokgownJipsok <- rbind(data.frame(option, value), info) # After 0ms

option <- factor(levels=ASkill)
value <- c()
info <- c(250, 2 * JipsokData$Prob[9], 0, 345, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Tongbaekgwon1Jipsok <- rbind(data.frame(option, value), info) # After 0ms

option <- factor(levels=ASkill)
value <- c()
info <- c(260, 2 * JipsokData$Prob[9], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Tongbaekgwon2Jipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300, 3 * JipsokData$Prob[9], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Tongbaekgwon3Jipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(320, JipsokData$Prob[9], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TongbaekgwonFAJipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(300 + 4 * EunwolSpec$SkillLv, 3 * JipsokData$Prob[10], 0, 360, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Pokryugwon1Jipsok <- rbind(data.frame(option, value), info) # After 0ms

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(310 + 4 * EunwolSpec$SkillLv, 3 * JipsokData$Prob[10], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Pokryugwon2Jipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(320 + 4 * EunwolSpec$SkillLv, 3 * JipsokData$Prob[10], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Pokryugwon3Jipsok <- rbind(data.frame(option, value), info)

option <- factor(c("FDR", "IGR"), levels=ASkill)
value <- c(2 * EunwolCore[[1]][1, 2], ifelse(EunwolCore[[1]][1, 2]>=40, 20, 0))
info <- c(350 + 4 * EunwolSpec$SkillLv, 3 * JipsokData$Prob[10], 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Pokryugwon4Jipsok <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * EunwolCore[[2]][2, 2], 12, 990, 1230, 120 - EunwolCore[[2]][2, 2], T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Gwimunjin <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * EunwolCore[[2]][4, 2], 5, 1320, 150, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeYeongwon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(950 + 38 * EunwolCore[[2]][4, 2], 15, 1080, 30, 90, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PashwaeYeongwonLast <- rbind(data.frame(option, value), info) # After 270ms, Yeouryeong, Gan 1 Time

option <- factor(levels=ASkill)
value <- c()
info <- c(275, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
GanganSuwolrae <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(150, 1, 0, 120, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RanghonJangmak <- rbind(data.frame(option, value), info)}

EunwolATK <- Attack(list(Gwicham=Gwicham, JinGwicham=JinGwicham, SohonJangmak=SohonJangmak, Bulyeouryeong=Bulyeouryeong, 
                         BulyeouryeongPashwaeYeongwon=BulyeouryeongPashwaeYeongwon, BulyeouryeongJipsok1=BulyeouryeongJipsok1, BulyeouryeongJipsok2=BulyeouryeongJipsok2, BulyeouryeongJipsok3=BulyeouryeongJipsok3, 
                         BulyeouryeongJipsok3Cancelled=BulyeouryeongJipsok3Cancelled, PashwaeCheoljoHoe=PashwaeCheoljoHoe, BunhonGyeokchamATK=BunhonGyeokchamATK, 
                         PashwaeCheoljoHaJipsok=PashwaeCheoljoHaJipsok, PashwaeCheoljoJeonJipsok=PashwaeCheoljoJeonJipsok, PashwaeCheoljoHoeJipsok=PashwaeCheoljoHoeJipsok, GwichamJipsok=GwichamJipsok, 
                         SahonGakinJipsok=SahonGakinJipsok, SohonJangmakJipsok=SohonJangmakJipsok, SohonJangmakJipsokCancelled=SohonJangmakJipsokCancelled, JeongryeongeuiHwasinJipsok=JeongryeongeuiHwasinJipsok, 
                         JeongryeongeuiHwasinJipsokCancelled=JeongryeongeuiHwasinJipsokCancelled, ParyeokgownJipsok=ParyeokgownJipsok, Tongbaekgwon1Jipsok=Tongbaekgwon1Jipsok, 
                         Tongbaekgwon2Jipsok=Tongbaekgwon2Jipsok, Tongbaekgwon3Jipsok=Tongbaekgwon3Jipsok, TongbaekgwonFAJipsok=TongbaekgwonFAJipsok, Pokryugwon1Jipsok=Pokryugwon1Jipsok, 
                         Pokryugwon2Jipsok=Pokryugwon2Jipsok, Pokryugwon3Jipsok=Pokryugwon3Jipsok, Pokryugwon4Jipsok=Pokryugwon4Jipsok, Gwimunjin=Gwimunjin, PashwaeYeongwon=PashwaeYeongwon, 
                         PashwaeYeongwonLast=PashwaeYeongwonLast, GanganSuwolrae=GanganSuwolrae, RanghonJangmak=RanghonJangmak, SpiderInMirror=SpiderInMirror))


## Eunwol - Summoned
EunwolSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Eunwol - DealCycle & Deal Calculation
ATKFinal <- data.frame(EunwolATK)
ATKFinal$Delay[c(-3, -31)] <- Delay(ATKFinal$Delay, EunwolSpec$ATKSpeed)[c(-3, -31)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, EunwolSpec$CoolReduceP, EunwolSpec$CoolReduce)

BuffFinal <- data.frame(EunwolBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, EunwolSpec$CoolReduceP, EunwolSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, EunwolSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)
ATKFinal <- AddATKRateSkills("BunhonGyeokchamDebuffMoving", BuffFinal, ATKFinal, rownames(ATKFinal)[c(-11, -30)])

SummonedFinal <- data.frame(EunwolSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, EunwolSpec$CoolReduceP, EunwolSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * EunwolSpec$SummonedDuration / 100, 0)


## Eunwol - DealCycle
DealCycle <- c("Skills", "Time", rownames(EunwolBuff))
EunwolDealCycle <- t(rep(0, length(DealCycle)))
colnames(EunwolDealCycle) <- DealCycle

EunwolCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  DealCycle <- PreDealCycle
  RangDealCycle <- PreDealCycle
  Remains <- data.frame(GyeolgyeRemain=0, RanghonRemain=0, GanganRemain=0)
  ## Rang Cycle
  RangCycle <- function(RangCycle, EunwolDealCycle, BuffFinal, Remains) {
    GyeolgyeRemain <- Remains$GyeolgyeRemain ; RanghonRemain <- Remains$RanghonRemain ; GanganRemain <- Remains$GanganRemain
    if(nrow(subset(EunwolDealCycle, EunwolDealCycle$Skills=="JeongryeongGyeolsokMax"))>=1) {
      if(EunwolDealCycle$Skills[nrow(EunwolDealCycle)]=="JeongryeongGyeolsokMax") {
        RangCycle <- rbind(RangCycle, EunwolDealCycle[nrow(EunwolDealCycle), ])
        RangCycle$Skills[nrow(RangCycle)] <- "RangSummoned"
        RangCycle[1, 2:ncol(RangCycle)] <- 1260
        GyeolgyeRemain <- 0 ; RanghonRemain <- 0 ; GanganRemain <- 0
      }
      while(RangCycle$Time[nrow(RangCycle)] + RangCycle$Time[1] <= EunwolDealCycle$Time[nrow(EunwolDealCycle)]) {
        if(GyeolgyeRemain==0 & RangCycle$SohonGyeolgye[nrow(RangCycle)]==0) {
          RangCycle <- rbind(RangCycle, RangCycle[nrow(RangCycle), ])
          RangCycle$Skills[nrow(RangCycle)] <- "SohonGyeolgye"
          RangCycle$Time[nrow(RangCycle)] <- RangCycle$Time[nrow(RangCycle)] + RangCycle$Time[1]
          RangCycle$SohonGyeolgye[nrow(RangCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="SohonGyeolgye")$Duration * 1000
          RangCycle[1, 2:ncol(RangCycle)] <- 1320
          GyeolgyeRemain <- 100000 - 1320 ; RanghonRemain <- max(0, RanghonRemain - 1320) ; GanganRemain <- max(0, GanganRemain - 1320)
        } else if(RanghonRemain == 0) {
          RangCycle <- rbind(RangCycle, RangCycle[nrow(RangCycle), ])
          RangCycle$Skills[nrow(RangCycle)] <- "RanghonJangmak"
          RangCycle$Time[nrow(RangCycle)] <- RangCycle$Time[nrow(RangCycle)] + RangCycle$Time[1]
          RangCycle$SohonGyeolgye[nrow(RangCycle)] <- max(0, RangCycle$SohonGyeolgye[nrow(RangCycle)] - RangCycle$Time[1])
          RangCycle[1, 2:ncol(RangCycle)] <- 7200
          GyeolgyeRemain <- max(0, GyeolgyeRemain - 7200) ; RanghonRemain <- 60000 - 7200 ; GanganRemain <- max(0, GanganRemain - 7200)
        } else if(GanganRemain == 0) {
          RangCycle <- rbind(RangCycle, RangCycle[nrow(RangCycle), ])
          RangCycle$Skills[nrow(RangCycle)] <- "GanganSuwolrae"
          RangCycle$Time[nrow(RangCycle)] <- RangCycle$Time[nrow(RangCycle)] + RangCycle$Time[1]
          RangCycle$SohonGyeolgye[nrow(RangCycle)] <- max(0, RangCycle$SohonGyeolgye[nrow(RangCycle)] - RangCycle$Time[1])
          RangCycle[1, 2:ncol(RangCycle)] <- 2520
          GyeolgyeRemain <- max(0, GyeolgyeRemain - 2520) ; RanghonRemain <- max(0, RanghonRemain - 2520) ; GanganRemain <- 3000 - 2520
        } else {
          RangCycle <- rbind(RangCycle, RangCycle[nrow(RangCycle), ])
          RangCycle$Skills[nrow(RangCycle)] <- "RangWait"
          RangCycle$Time[nrow(RangCycle)] <- RangCycle$Time[nrow(RangCycle)] + RangCycle$Time[1]
          RangCycle$SohonGyeolgye[nrow(RangCycle)] <- max(0, RangCycle$SohonGyeolgye[nrow(RangCycle)] - RangCycle$Time[1])
          RangCycle[1, 2:ncol(RangCycle)] <- 1440
          GyeolgyeRemain <- max(0, GyeolgyeRemain - 1440) ; RanghonRemain <- max(0, RanghonRemain - 1440) ; GanganRemain <- max(0, GanganRemain - 1440)
        }
      }
    }
    rownames(RangCycle) <- 1:nrow(RangCycle)
    Remains <- data.frame(GyeolgyeRemain=GyeolgyeRemain, RanghonRemain=RanghonRemain, GanganRemain=GanganRemain)
    return(list(RangCycle=RangCycle, Remains=Remains))
  }
  ## Rang DealCycle Attach
  CycleAttach <- function(RangCycle, EunwolDealCycle) {
    RangCycle <- subset(RangCycle, RangCycle$Time >= EunwolDealCycle$Time[(nrow(EunwolDealCycle)-1)])
    EunwolDealCycle <- rbind(EunwolDealCycle, RangCycle)
    EunwolDealCycle <- unique(EunwolDealCycle)
    DC1 <- EunwolDealCycle[1, ]
    DC2 <- EunwolDealCycle[2:nrow(EunwolDealCycle), ]
    DC2 <- DC2[order(DC2$Time), ]
    EunwolDealCycle <- rbind(DC1, DC2)
    rownames(EunwolDealCycle) <- 1:nrow(EunwolDealCycle)
    for(i in 3:nrow(EunwolDealCycle)) {
      if(sum(EunwolDealCycle$Skills[i]==c("RangSummoned", "SohonGyeolgye", "GanganSuwolrae", "RanghonJangmak", "RangWait"))==1) {
        for(j in 3:ncol(EunwolDealCycle)) {
          if(colnames(EunwolDealCycle)[j]!="SohonGyeolgye") {
            EunwolDealCycle[i, j] <- max(0, EunwolDealCycle[i-1, j] - (EunwolDealCycle$Time[i] -  EunwolDealCycle$Time[i-1]))
          }
        }
      }
    }
    for(i in 3:nrow(EunwolDealCycle)) {
      if(EunwolDealCycle$Skills[i]!="SohonGyeolgye") {
        EunwolDealCycle$SohonGyeolgye[i] <- max(0, EunwolDealCycle$SohonGyeolgye[i-1] - (EunwolDealCycle$Time[i] -  EunwolDealCycle$Time[i-1]))
      }
    }
    return(EunwolDealCycle)
  }
  
  ## First Cycle
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle <- DCBuff(DealCycle, c("UsefulSharpEyes", "UsefulCombatOrders", "LuckyDice5", "HeroesOath"), BuffFinal)
  DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
  DealCycle <- DCBuff(DealCycle, c("MapleWarriors2", "GwimunjinBuff", "JeongryeongJipsok", "OverDrive", "SoulContractLink", "JeongryeongGyeolsokMax"), BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle, DealCycle, BuffFinal, Remains)
  DealCycle <- CycleAttach(RangDealCycle, DealCycle)
  
  DealCycle <- DCBuff(DealCycle, "BunhonGyeokchamDebuffMoving", BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "BunhonGyeokchamATK", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "JinGwicham", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "PashwaeYeongwon", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "PashwaeYeongwonLast", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  
  DealCycle <- DCATK(DealCycle, "SohonJangmak", ATKFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  SohonCount <- 1
  
  while(SohonCount < 4) {
    ## Lucky Dice
    if(DealCycle$LuckyDice5[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "LuckyDice5", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Heroes Oath
    if(DealCycle$HeroesOath[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "HeroesOath", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Second Restraint(Sohon Jangmak / Pashwae Yeongwon / Gwimunjin / Soul Contract / Bunhon Gyeokcham)
    if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 6750 &
       DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 630 &
       SohonCount==3) {
      DealCycle <- DCBuff(DealCycle, "MapleWarriors2", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "GwimunjinBuff", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "OverDrive", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "BunhonGyeokchamDebuffMoving", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "BunhonGyeokchamATK", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)

      DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "SohonJangmak", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "JinGwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwon", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwonLast", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "UsefulSharpEyes", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "UsefulCombatOrders", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      SohonCount <- 4
    }
    ## Sohon Jangmak
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 6750 &
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 630 &
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JinGwicham")$Time) <= 4000) {
      if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 9000) {
        DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
        
        DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      }
      DealCycle <- DCATK(DealCycle, "SohonJangmak", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      SohonCount <- SohonCount + 1
    }
    ## Jin Gwicham
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JinGwicham")$Time) >=
            subset(ATKFinal, rownames(ATKFinal)=="JinGwicham")$CoolTime * 1000) {
      DealCycle <- DCATK(DealCycle, "JinGwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Pashwae Yeongwon, Soul Contract, Gwimunjin, Over Drive
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="PashwaeYeongwon")$Time) >=
            subset(ATKFinal, rownames(ATKFinal)=="PashwaeYeongwon")$CoolTime * 1000 &
            nrow(subset(DealCycle, DealCycle$Skills=="PashwaeYeongwon"))==1) {
      DealCycle <- DCBuff(DealCycle, "GwimunjinBuff", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "OverDrive", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
        DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
        
        DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      }
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwon", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwonLast", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Jeongryeong Jipsok
    else if(SohonCount==3 & nrow(subset(DealCycle, DealCycle$Skills=="JeongryeongJipsok"))==1 & 
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) >= 16000) {
      DealCycle <- DCBuff(DealCycle, "JeongryeongJipsok", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Pashwae Cheoljo - Hoe
    else if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 1000) {
      DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Gwicham
    else {
      DealCycle <- DCATK(DealCycle, "Gwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
  }
  
  
  ## Second Cycle
  DealCycle <- DCBuff(DealCycle, "JeongryeongGyeolsokMax", BuffFinal)
  RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
  DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
  SohonCount <- 0
  
  while(SohonCount < 3) {
    ## Lucky Dice
    if(DealCycle$LuckyDice5[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "LuckyDice5", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Heroes Oath
    if(DealCycle$HeroesOath[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "HeroesOath", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Sohon Jangmak
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 6750 &
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] >= max(subset(DealCycle, DealCycle$Skills=="RanghonJangmak")$Time) + 630 &
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JinGwicham")$Time) <= 4000 & 
            DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="SohonJangmak")$Time) >= 
            subset(ATKFinal, rownames(ATKFinal)=="SohonJangmak")$CoolTime * 1000) {
      if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 9000) {
        DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
        
        DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      }
      DealCycle <- DCATK(DealCycle, "SohonJangmak", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      SohonCount <- SohonCount + 1
    }
    ## Jin Gwicham
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JinGwicham")$Time) >=
            subset(ATKFinal, rownames(ATKFinal)=="JinGwicham")$CoolTime * 1000) {
      DealCycle <- DCATK(DealCycle, "JinGwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Pashwae Yeongwon, Soul Contract, Gwimunjin, Over Drive
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="PashwaeYeongwon")$Time) >=
            subset(ATKFinal, rownames(ATKFinal)=="PashwaeYeongwon")$CoolTime * 1000 &
            nrow(subset(DealCycle, DealCycle$Skills=="PashwaeYeongwon"))==3) {
      DealCycle <- DCBuff(DealCycle, "GwimunjinBuff", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "OverDrive", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
        DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
        
        DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
        RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
        DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      }
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwon", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeYeongwonLast", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Jeongryeong Jipsok
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JeongryeongJipsok")$Time) >= 
            subset(BuffFinal, rownames(BuffFinal)=="JeongryeongJipsok")$CoolTime * 1000) {
      DealCycle <- DCBuff(DealCycle, "JeongryeongJipsok", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Pashwae Cheoljo - Hoe
    else if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 1000) {
      DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Gwicham
    else {
      DealCycle <- DCATK(DealCycle, "Gwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
  }
  
  
  ## CoolTime Adjust
  FinTimeGM <- max(subset(DealCycle, DealCycle$Skills=="GwimunjinBuff")$Time) + subset(BuffFinal, rownames(BuffFinal)=="GwimunjinBuff")$CoolTime * 1000 -
    subset(DealCycle, DealCycle$Skills=="GwimunjinBuff")$Time[1]
  FinTimeJJ <- max(subset(DealCycle, DealCycle$Skills=="JeongryeongJipsok")$Time) + subset(BuffFinal, rownames(BuffFinal)=="JeongryeongJipsok")$CoolTime * 1000 -
    subset(DealCycle, DealCycle$Skills=="JeongryeongJipsok")$Time[1]
  FinTimeMW2 <- max(subset(DealCycle, DealCycle$Skills=="MapleWarriors2")$Time) + subset(BuffFinal, rownames(BuffFinal)=="MapleWarriors2")$CoolTime * 1000 -
    subset(DealCycle, DealCycle$Skills=="MapleWarriors2")$Time[1]
  FinTime <- max(FinTimeGM, FinTimeJJ, FinTimeMW2)
  while(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= FinTime) {
    ## Lucky Dice
    if(DealCycle$LuckyDice5[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "LuckyDice5", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Heroes Oath
    if(DealCycle$HeroesOath[nrow(DealCycle)] - DealCycle$Time[1] <= 3000) {
      DealCycle <- DCBuff(DealCycle, "HeroesOath", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Jin Gwicham
    else if(DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - max(subset(DealCycle, DealCycle$Skills=="JinGwicham")$Time) >=
            subset(ATKFinal, rownames(ATKFinal)=="JinGwicham")$CoolTime * 1000) {
      DealCycle <- DCATK(DealCycle, "JinGwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Pashwae Cheoljo - Hoe
    else if(DealCycle$PashwaeCheoljoBan[nrow(DealCycle)] - DealCycle$Time[1] <= 1000) {
      DealCycle <- DCBuff(DealCycle, "PashwaeCheoljoBan", BuffFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
      
      DealCycle <- DCATK(DealCycle, "PashwaeCheoljoHoe", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
    ## Gwicham
    else {
      DealCycle <- DCATK(DealCycle, "Gwicham", ATKFinal)
      RangDealCycle <- RangCycle(RangDealCycle$RangCycle, DealCycle, BuffFinal, RangDealCycle$Remains)
      DealCycle <- CycleAttach(RangDealCycle$RangCycle, DealCycle)
    }
  }
  return(DealCycle)
}
EunwolAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, BunhonFixed=T) {
  ## GanganSuwolrae
  EndTime <- DealCycle$Time[nrow(DealCycle)]
  DC1 <- subset(DealCycle, DealCycle$Skills=="GanganSuwolrae")
  DC2 <- subset(DealCycle, DealCycle$Skills!="GanganSuwolrae")
  DC1$Time <- DC1$Time + 630
  DealCycle <- rbind(DC1, DC2)
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 3:nrow(DealCycle)) {
    if("GanganSuwolrae"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  DealCycle <- subset(DealCycle, DealCycle$Time <= EndTime)
  
  
  ## Pashwae Yeongwon
  DealCycle <- RepATKCycle(DealCycle, "PashwaeYeongwon", 8, 180, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "PashwaeYeongwonLast", 3, 270, ATKFinal)
  
  
  ## Sohon Jangmak, Ranghon Jangmak
  DealCycle <- RepATKCycle(DealCycle, "SohonJangmak", 56, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "RanghonJangmak", 35, 720 + 630, ATKFinal)
  
  
  ## Bulyeouryeong (PashwaeYeongwon)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PashwaeYeongwon") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongPashwaeYeongwon"
    } else if(DealCycle$Skills[i]=="PashwaeYeongwonLastStart") {
      for(j in 1:16) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongPashwaeYeongwon"
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle <- RepATKCycle(DealCycle, "BulyeouryeongPashwaeYeongwon", 4, 1350, ATKFinal)
  
  
  ## Jeongryeong Jipsok
  JJSkills <- c("PashwaeCheoljoHaJipsok", "PashwaeCheoljoJeonJipsok", "PashwaeCheoljoHoeJipsok", "GwichamJipsok", "SahonGakinJipsok", 
                "SohonJangmakJipsok", "JeongryeongeuiHwasinJipsok", "ParyeokgownJipsok", "Tongbaekgwon1Jipsok", "Pokryugwon1Jipsok")
  
  JJ <- subset(DealCycle, DealCycle$Skills=="JeongryeongJipsok")
  Ind <- rownames(JJ)
  Ind[length(Ind)+1] <- nrow(DealCycle)
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    
    time <- 2001
    while(p < Ind[i+1] & DealCycle$JeongryeongJipsok[p] > 0) {
      if(time > 2000 & max(DealCycle$Skills[p]==c("BunhonGyeokchamATK", "SohonJangmak", "Gwicham", "PashwaeCheoljoHoe", "BulyeouryeongPashwaeYeongwon"))==1) {
        for(j in 1:length(JJSkills)) {
          DC <- rbind(DC, DealCycle[p, ])
          DC[nrow(DC), 1] <- JJSkills[j]
        }
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
  
  
  ## Jeongryeong Jipsok AddATKs
  DealCycle <- RepATKCycle(DealCycle, "SohonJangmakJipsok", 11, 720 + 450, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "JeongryeongeuiHwasinJipsok", 8, 120, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "ParyeokgownJipsok", 2, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "Tongbaekgwon1Jipsok", 4, 0, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "Pokryugwon1Jipsok", 4, 0, ATKFinal)
  
  TBGCount <- 1 ; PRGCount <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="SohonJangmakJipsok") {
      if(round((DealCycle$Time[i] - max(subset(DealCycle, DealCycle$Skills=="SohonJangmakJipsokStart" & DealCycle$Time <= DealCycle$Time[i])$Time) - 720 - 450) / 270) != 
         (DealCycle$Time[i] - max(subset(DealCycle, DealCycle$Skills=="SohonJangmakJipsokStart" & DealCycle$Time <= DealCycle$Time[i])$Time) - 720 - 450) / 270 |
         nrow(subset(DealCycle, DealCycle$Skills=="SohonJangmakJipsok" & DealCycle$Time == DealCycle$Time[i])) >= 2) {
        DealCycle$Skills[i] <- "SohonJangmakJipsokCancelled"
      }
    } else if(DealCycle$Skills[i]=="JeongryeongeuiHwasinJipsok") {
      if(round((DealCycle$Time[i] - max(subset(DealCycle, DealCycle$Skills=="JeongryeongeuiHwasinJipsokStart" & DealCycle$Time <= DealCycle$Time[i])$Time) - 120) / 360) != 
         (DealCycle$Time[i] - max(subset(DealCycle, DealCycle$Skills=="JeongryeongeuiHwasinJipsokStart" & DealCycle$Time <= DealCycle$Time[i])$Time) - 120) / 360 |
         nrow(subset(DealCycle, DealCycle$Skills=="JeongryeongeuiHwasinJipsok" & DealCycle$Time == DealCycle$Time[i])) >= 2) {
        DealCycle$Skills[i] <- "JeongryeongeuiHwasinJipsokCancelled"
      }
    } else if(DealCycle$Skills[i]=="Tongbaekgwon1Jipsok") {
      if(TBGCount==1) {
        TBGCount <- 2
      } else if(TBGCount==2) {
        DealCycle$Skills[i] <- "Tongbaekgwon2Jipsok"
        TBGCount <- 3
      } else if(TBGCount==3) {
        DealCycle$Skills[i] <- "Tongbaekgwon3Jipsok"
        TBGCount <- 4
      } else if(TBGCount==4) {
        DealCycle$Skills[i] <- "TongbaekgwonFAJipsok"
        TBGCount <- 1
      }
    } else if(DealCycle$Skills[i]=="Pokryugwon1Jipsok") {
      if(PRGCount==1) {
        PRGCount <- 2
      } else if(PRGCount==2) {
        DealCycle$Skills[i] <- "Pokryugwon2Jipsok"
        PRGCount <- 3
      } else if(PRGCount==3) {
        DealCycle$Skills[i] <- "Pokryugwon3Jipsok"
        PRGCount <- 4
      } else if(PRGCount==4) {
        DealCycle$Skills[i] <- "Pokryugwon4Jipsok"
        PRGCount <- 1
      }
    }
  }
  
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  
  ## Gwimunjin
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="GwimunjinBuff") {
      DealCycle$Skills[i] <- "Gwimunjin"
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "Gwimunjin", 32, 990 + 1440, ATKFinal)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Gwimunjin") {
      DealCycle$GwimunjinDebuff[i] <- 8000
    } else {
      DealCycle$GwimunjinDebuff[i] <- max(0, DealCycle$GwimunjinDebuff[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    }
  }
  
  
  ## Bulyeouryeong
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("Gwicham", "JinGwicham", "SohonJangmak", "PashwaeCheoljoHoe", "BunhonGyeokchamATK"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Bulyeouryeong"
    } else if(DealCycle$Skills[i]=="Gwimunjin") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Bulyeouryeong"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "Bulyeouryeong"
    } else if(sum(DealCycle$Skills[i]==c("PashwaeCheoljoHaJipsok", "PashwaeCheoljoJeonJipsok", "PashwaeCheoljoHoeJipsok", "ParyeokgwonJipsok"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongJipsok1"
    } else if(sum(DealCycle$Skills[i]==c("SahonGakinJipsok", "Tongbaekgwon1Jipsok", "Tongbaekgwon2Jipsok", "Tongbaekgwon3Jipsok", "TongbaekgwonFAJipsok"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongJipsok2"
    } else if(sum(DealCycle$Skills[i]==c("GwichamJipsok", "SohonJangmakJipsok", "JeongryeongeuiHwasinJipsok", "Pokryugwon1Jipsok", "Pokryugwon2Jipsok", "Pokryugwon3Jipsok", "Pokryugwon4Jipsok"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongJipsok3"
    } else if(sum(DealCycle$Skills[i]==c("SohonJangmakJipsokCancelled", "JeongryeongeuiHwasinJipsokCancelled"))==1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "BulyeouryeongJipsok3Cancelled"
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "Bulyeouryeong", 4, 1350, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BulyeouryeongJipsok1", 4, 1350, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BulyeouryeongJipsok2", 4, 1350, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BulyeouryeongJipsok3", 4, 1350, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "BulyeouryeongJipsok3Cancelled", 4, 1350, ATKFinal)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Gwimunjin") {
      DealCycle$GwimunjinStack[i] <- min(DealCycle$GwimunjinStack[i-1] + 2, 10)
    } else if(DealCycle$GwimunjinDebuff[i] > 0) {
      DealCycle$GwimunjinStack[i] <- DealCycle$GwimunjinStack[i-1]
    }
  }
  
  ## PashwaeCheoljo - Ban Buff Logic
  for(i in 3:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PashwaeCheoljoHoe") {
      if(DealCycle$PashwaeCheoljoBan[i-2] - (DealCycle$Time[i-1] - DealCycle$Time[i-2]) <= 0) {
        DealCycle$PashwaeCheoljoBan[i] <- 0
      }
    }
  }
  
  ## Bunhon Gyeokcham
  d <- 0 ; dp <- 0 ; d1 <- 0 ; d2 <- 0 ; d3 <- 0 ; d3c <- 0
  if(BunhonFixed==F) {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & sum(DealCycle$Skills[i]==c("Gwicham", "JinGwicham", "SohonJangmak", "PashwaeCheoljoHoe", "PashwaeYeongwon", "PashwaeYeongwonLast", 
                                                                                   "GanganSuwolrae", "RanghonJangmak", "SpiderInMirror", 
                                                                                   "PashwaeCheoljoHaJipsok", "PashwaeCheoljoJeonJipsok", "PashwaeCheoljoHoeJipsok", "GwichamJipsok", "SahonGakinJipsok", 
                                                                                   "SohonJangmakJipsok", "SohonJangmakJipsokCancelled", "JeongryeongeuiHwasinJipsok", "JeongryeongeuiHwasinJipsokCancelled", 
                                                                                   "ParyeokgownJipsok", "Tongbaekgwon1Jipsok", "Tongbaekgwon2Jipsok", "Tongbaekgwon3Jipsok", "TongbaekgwonFAJipsok", 
                                                                                   "Pokryugwon1Jipsok", "Pokryugwon2Jipsok", "Pokryugwon3Jipsok", "Pokryugwon4Jipsok"))==1) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "Add", sep="")
        DealCycle$GwimunjinStack[nrow(DealCycle)] <- 0
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="Bulyeouryeong") {
        if(d == 0) {
          d <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongAdd"
          DealCycle$GwimunjinStack[i] <- 0
          d <- 0
        }
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="BulyeouryeongPashwaeYeongwon") {
        if(dp == 0) {
          dp <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongPashwaeYeongwonAdd"
          DealCycle$GwimunjinStack[i] <- 0
          dp <- 0
        }
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="BulyeouryeongJipsok1") {
        if(d1 == 0) {
          d1 <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongJipsok1Add"
          DealCycle$GwimunjinStack[i] <- 0
          d1 <- 0
        }
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="BulyeouryeongJipsok2") {
        if(d2 == 0) {
          d2 <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongJipsok2Add"
          DealCycle$GwimunjinStack[i] <- 0
          d2 <- 0
        }
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="BulyeouryeongJipsok3") {
        if(d3 == 0) {
          d3 <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongJipsok3Add"
          DealCycle$GwimunjinStack[i] <- 0
          d3 <- 0
        }
      } else if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]=="BulyeouryeongJipsok3Cancelled") {
        if(d3c == 0) {
          d3c <- 1
        } else {
          DealCycle$Skills[i] <- "BulyeouryeongJipsok3CancelledAdd"
          DealCycle$GwimunjinStack[i] <- 0
          d3c <- 0
        }
      }
    }
  } else {
    for(i in 1:nrow(DealCycle)) {
      if(DealCycle$BunhonGyeokchamDebuffMoving[i] > 0 & DealCycle$Skills[i]!="BunhonGyeokchamATK") {
        DealCycle$BunhonGyeokchamDebuffFixed[i] <- 1
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  return(DealCycle)
}
EunwolGyeolsokMax <- function(DealCycle, JipsokData) {
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="JeongryeongGyeolsokMax") {
      DealCycle$JeongryeongGyeolsokMax[i] <- 30000
    } else if(sum(DealCycle$Skills[i]==c("Gwicham", "JinGwicham", "SohonJangmak", "PashwaeCheoljoHoe", "BunhonGyeokchamATK", "PashwaeYeongwon", "PashwaeYeongwonLastStart", "BulyeouryeongPashwaeYeongwon",
                                         "GwichamAdd", "JinGwichamAdd", "SohonJangmakAdd", "PashwaeCheoljoHoeAdd", "PashwaeYeongwonAdd", "BulyeouryeongPashwaeYeongwonAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400)
    } else if(sum(DealCycle$Skills[i]==c("PashwaeYeongwonLastAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 / 3)
    } else if(sum(DealCycle$Skills[i]==c("Bulyeouryeong", "BulyeouryeongAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)))
    } else if(sum(DealCycle$Skills[i]==c("PashwaeCheoljoHaJipsok", "PashwaeCheoljoJeonJipsok", "PashwaeCheoljoHoeJipsok", "ParyeokgownJipsok", 
                                         "PashwaeCheoljoHaJipsokAdd", "PashwaeCheoljoJeonJipsokAdd", "PashwaeCheoljoHoeJipsokAdd", "ParyeokgownJipsokAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (5 / sum(JipsokData$Ind)))
    } else if(sum(DealCycle$Skills[i]==c("SahonGakinJipsok", "Tongbaekgwon1Jipsok", "Tongbaekgwon2Jipsok", "Tongbaekgwon3Jipsok", "TongbaekgwonFAJipsok", 
                                         "SahonGakinJipsokAdd", "Tongbaekgwon1JipsokAdd", "Tongbaekgwon2JipsokAdd", "Tongbaekgwon3JipsokAdd", "TongbaekgwonFAJipsokAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (10 / sum(JipsokData$Ind)))
    } else if(sum(DealCycle$Skills[i]==c("GwichamJipsok", "SohonJangmakJipsok", "JeongryeongeuiHwasinJipsok", "Pokryugwon1Jipsok", "Pokryugwon2Jipsok", "Pokryugwon3Jipsok", "Pokryugwon4Jipsok", 
                                         "GwichamJipsokAdd", "SohonJangmakJipsokAdd", "JeongryeongeuiHwasinJipsokAdd", "Pokryugwon1JipsokAdd", "Pokryugwon2JipsokAdd", "Pokryugwon3JipsokAdd", 
                                         "Pokryugwon4JipsokAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (25 / sum(JipsokData$Ind)))
    } else if(sum(DealCycle$Skills[i]==c("SohonJangmakJipsokCancelled", "JeongryeongeuiHwasinJipsokCancelled", 
                                         "SohonJangmakJipsokCancelledAdd", "JeongryeongeuiHwasinJipsokCancelledAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (25 / sum(JipsokData$Ind) - (25 / sum(JipsokData$Ind))^2))
    } else if(sum(DealCycle$Skills[i]==c("BulyeouryeongJipsok1", "BulyeouryeongJipsok1Add"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (5 / sum(JipsokData$Ind)) * (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)))
    } else if(sum(DealCycle$Skills[i]==c("BulyeouryeongJipsok2", "BulyeouryeongJipsok2Add"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (10 / sum(JipsokData$Ind)) * (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)))
    } else if(sum(DealCycle$Skills[i]==c("BulyeouryeongJipsok3", "BulyeouryeongJipsok3Add"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * (25 / sum(JipsokData$Ind)) * (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)))
    } else if(sum(DealCycle$Skills[i]==c("BulyeouryeongJipsok3Cancelled", "BulyeouryeongJipsok3CancelledAdd"))==1) {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]) + 400 * 
        (25 / sum(JipsokData$Ind) - (25 / sum(JipsokData$Ind))^2) * (0.35 + 0.01 * floor(EunwolSpec$PSkillLv/2)))
    } else {
      DealCycle$JeongryeongGyeolsokMax[i] <- max(0, DealCycle$JeongryeongGyeolsokMax[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1]))
    }
  }
  return(DealCycle)
}
EunwolDummyReduction <- function(DealCycle) {
  Dummy <- c("PashwaeYeongwonStart", "PashwaeYeongwonLastStart", "SohonJangmakStart", "RanghonJangmakStart", "BulyeouryeongPashwaeYeongwonStart", 
              "SohonJangmakJipsokStart", "JeongryeongeuiHwasinJipsokStart", "ParyeokgownJipsokStart", "Tongbaekgwon1JipsokStart", "Pokryugwon1JipsokStart", 
              "GwimunjinStart", "BulyeouryeongStart", "BulyeouryeongJipsok1Start", "BulyeouryeongJipsok2Start", "BulyeouryeongJipsok3Start", "BulyeouryeongJipsok3CancelledStart")
  for(i in 1:length(Dummy)) {
    DealCycle <- subset(DealCycle, DealCycle$Skills!=Dummy[i])
  }
  
  DealCycle$SohonGyeolgye <- 0
  DealCycle$GwimunjinBuff <- 0
  return(DealCycle)
}

EunwolDealCycle <- EunwolCycle(EunwolDealCycle, ATKFinal, BuffFinal, SummonedFinal)
EunwolDealCycle <- DealCycleFinal(EunwolDealCycle)
EunwolDealCycle <- EunwolAddATK(EunwolDealCycle, ATKFinal, BuffFinal, SummonedFinal, BunhonFixed = F)
EunwolDealCycle <- EunwolGyeolsokMax(EunwolDealCycle, JipsokData)
EunwolDealCycle <- EunwolDummyReduction(EunwolDealCycle)
EunwolDealCycle <- OverDriveExhaustBuff(EunwolDealCycle, BuffFinal$Duration[16], BuffFinal$CoolTime[16])
EunwolDealCycleReduction <- DealCycleReduction(EunwolDealCycle, NotBuffColNames=c("GwimunjinStack"))


EunwolYakjeomGanpa(EunwolDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, EunwolSpec)

## Damage Optimization
EunwolSpecOpt1 <- EunwolOptimization1(EunwolDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, EunwolSpec, EunwolUnionRemained)
EunwolSpecOpt <- EunwolSpec
EunwolSpecOpt$ATKP <- EunwolSpecOpt$ATKP + EunwolSpecOpt1$ATKP
EunwolSpecOpt$BDR <- EunwolSpecOpt$BDR + EunwolSpecOpt1$BDR
EunwolSpecOpt$IGR <- IGRCalc(c(EunwolSpecOpt$IGR, EunwolSpecOpt1$IGR))

EunwolSpecOpt2 <- EunwolOptimization2(EunwolDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt, EunwolHyperStatBase, EunwolBase$ChrLv, EunwolBase$CRROver)
EunwolFinalDPMwithMax <- EunwolYakjeomGanpa(EunwolDealCycle, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)
MovingDPM <- sum(na.omit(EunwolFinalDPMwithMax)) / (max(EunwolDealCycle$Time) / 60000)

EunwolDealCycleGanpaon <- EunwolDealCycle
EunwolDealCycleGanpaon$YakjeomGanpaAdd <- 1
EunwolOffDeal <- EunwolDealCalc(EunwolDealCycle, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)
EunwolOnDeal <- EunwolDealCalc(EunwolDealCycleGanpaon, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)

EunwolDealData <- data.frame(EunwolDealCycle$Skills, EunwolDealCycle$Time, EunwolDealCycle$Restraint4, EunwolOffDeal, EunwolOnDeal)
colnames(EunwolDealData) <- c("Skills", "Time", "R4", "Deal", "DealGanpa")

EunwolRR <- EunwolDealData[72:1825, ]
MovingRR <- sum((EunwolRR$Deal))

Eunwol40s <- EunwolDealData[72:3843, ]
Moving40s <- sum((Eunwol40s$Deal))

MovingGanpaRR <- sum((EunwolRR$DealGanpa))
MovingGanpa40s <- sum((Eunwol40s$DealGanpa))



## Eunwol DPM(Fixed Boss)
DealCycle <- c("Skills", "Time", rownames(EunwolBuff))
EunwolDealCycleFixed <- t(rep(0, length(DealCycle)))
colnames(EunwolDealCycleFixed) <- DealCycle

EunwolDealCycleFixed <- EunwolCycle(EunwolDealCycleFixed, ATKFinal, BuffFinal, SummonedFinal)
EunwolDealCycleFixed <- DealCycleFinal(EunwolDealCycleFixed)
EunwolDealCycleFixed <- EunwolAddATK(EunwolDealCycleFixed, ATKFinal, BuffFinal, SummonedFinal, BunhonFixed = T)
EunwolDealCycleFixed <- EunwolGyeolsokMax(EunwolDealCycleFixed, JipsokData)
EunwolDealCycleFixed <- EunwolDummyReduction(EunwolDealCycleFixed)
EunwolDealCycleFixed <- OverDriveExhaustBuff(EunwolDealCycleFixed, BuffFinal$Duration[16], BuffFinal$CoolTime[16])

EunwolFinalDPMFixed <- EunwolYakjeomGanpa(EunwolDealCycleFixed, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)
DPM12344$Eunwol[1] <- sum(na.omit(EunwolFinalDPMFixed)) / (max(EunwolDealCycle$Time) / 60000)

EunwolDealCycleFixedGanpaon <- EunwolDealCycleFixed
EunwolDealCycleFixedGanpaon$YakjeomGanpaAdd <- 1
EunwolOffDealFixed <- EunwolDealCalc(EunwolDealCycleFixed, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)
EunwolOnDealFixed <- EunwolDealCalc(EunwolDealCycleFixedGanpaon, ATKFinal, BuffFinal, SummonedFinal, EunwolSpecOpt2)
EunwolDealRatio <- ResetDealRatio(list(EunwolDealCycleFixed, EunwolDealCycleFixedGanpaon), list(EunwolOffDealFixed, EunwolOnDealFixed), rep(max(EunwolDealCycleFixed$Time), 2), c(0.5137, 0.4863))

EunwolDealDataFixed <- data.frame(EunwolDealCycleFixed$Skills, EunwolDealCycleFixed$Time, EunwolDealCycleFixed$Restraint4, EunwolOffDealFixed, EunwolOnDealFixed)
colnames(EunwolDealDataFixed) <- c("Skills", "Time", "R4", "Deal", "DealGanpa")

EunwolRRFixed <- EunwolDealDataFixed[51:1579, ]
DPM12344$Eunwol[3] <- sum((EunwolRRFixed$Deal))

Eunwol40sFixed <- EunwolDealDataFixed[51:3597, ]
DPM12344$Eunwol[4] <- sum((Eunwol40sFixed$Deal))

FixedGanpaRR <- sum((EunwolRRFixed$DealGanpa))
FixedGanpa40s <- sum((Eunwol40sFixed$DealGanpa))
