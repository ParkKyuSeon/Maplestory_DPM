## Phantom - Data
## Phantom - VMatrix
PhantomCore <- MatrixSet(PasSkills=c("UltimateDrive", "TempestofCard", "RoseCarteFinale", "NoirCarte", "Twilight", "TalentofPhantomThief4"), 
                         PasLvs=c(50, 50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 10, 10), 
                         ActSkills=c("Joker", "BlackJack", "MarkofPhantom", "LiftBreak", 
                                     CommonV("Thief", "Heroes")), 
                         ActLvs=c(25, 25, 25, 25, 0, 25, 1, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 0, 5, 0, 5, 5), 
                         BlinkLv=1, 
                         BlinkMP=0, 
                         UsefulSkills=c("SharpEyes", "CombatOrders"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault, 
                         SelfBind=F)


## Phantom - Basic Info
PhantomBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Phantom",
                       CoreData=PhantomCore, 
                       BuffDurationNeeded=57, 
                       AbilList=c("BDR", "BuffDuration"), 
                       LinkList=c("Phantom", "DemonAvenger", "Mikhail", "Xenon"), 
                       MonsterLife=MLTypeL21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Cane", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[24, ], 
                       Emblem=Emblem[2, ], 
                       CoolReduceHat=T)


## Phantom - Passive
{option <- factor(c("SubStat1"), levels=PSkill)
value <- c(40)
HighDexterity <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
LuckMonopoly <- data.frame(option, value)

option <- factor(c("ATKSpeed", "MainStat"), levels=PSkill)
value <- c(2, 20)
CaneAcceleration <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
LuckofPhantomThief <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(40)
MoonLight <- data.frame(option, value)

option <- factor(c("FDR", "CRR"), levels=PSkill)
value <- c(30, 35)
AcuteSense <- data.frame(option, value)

option <- factor(c("BDR", "IGR"), levels=PSkill)
value <- c(30 + PhantomBase$PSkillLv, 30 + PhantomBase$PSkillLv)
PrayofAria <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR", "FDR"), levels=PSkill)
value <- c(70 + ceiling(PhantomBase$PSkillLv/2), 40 + PhantomBase$PSkillLv, 15, 25 + floor(PhantomBase$PSkillLv/2))
CaneExpert <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(PhantomCore[[2]][6, 2])
ReadytoDiePassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(PhantomCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

PhantomPassive <- Passive(list(HighDexterity=HighDexterity, LuckMonopoly=LuckMonopoly, CaneAcceleration=CaneAcceleration, LuckofPhantomThief=LuckofPhantomThief, MoonLight=MoonLight, AcuteSense=AcuteSense, 
                               PrayofAria=PrayofAria, CaneExpert=CaneExpert, ReadytoDiePassive=ReadytoDiePassive, BlinkPassive=BlinkPassive))


## Phantom - Buff
{option <- factor("ATK", levels=BSkill)
value <- c(30)
info <- c(180 * (100 + PhantomBase$BuffDurationNeeded + 10) / 100, NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Fury <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(20)
info <- c(200 * (100 + PhantomBase$BuffDurationNeeded + 10) / 100, NA, 720, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CrossOverChain <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(40 + PhantomBase$SkillLv)
info <- c(60 * (100 + PhantomBase$BuffDurationNeeded + 10) / 100, 90, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
FinalCutBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR"), levels=BSkill)
value <- c(20 + floor(PhantomBase$SkillLv/2))
info <- c(15, 240, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
TwilightDebuff <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR", "IGR", "BDR"), levels=BSkill)
value <- c(20, 10, 20, 20)
info <- c(30, 180, 960, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Bullseye <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * PhantomCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * PhantomCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(ceiling(PhantomCore[[2]][1, 2]/5))
info <- c(30, 150, 1620, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JokerBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30, 150, 1620, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
JokerBuffFail <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(PhantomCore[[2]][6, 2]/10))
info <- c(30, 90 - floor(PhantomCore[[2]][6, 2]/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(PhantomCore[[2]][6, 2]/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(PhantomCore[[2]][6, 2]/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * PhantomCore[[2]][8, 2]) * MapleSoldier[1, 2]) * PhantomBase$MainStatP), 5 + floor(PhantomCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
NoirCarteStack <- rbind(data.frame(option, value), info)}

PhantomBuff <- Buff(list(Fury=Fury, CrossOverChain=CrossOverChain, FinalCutBuff=FinalCutBuff, 
                         TwilightDebuff=TwilightDebuff, HeroesOath=HeroesOath, Bullseye=Bullseye, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                         JokerBuff=JokerBuff, JokerBuffFail=JokerBuffFail, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, MapleWarriors2=MapleWarriors2, 
                         NoirCarteStack=NoirCarteStack, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
PhantomAllTimeBuff <- AllTimeBuff(PhantomBuff)
## PetBuff : Fury(1080ms), UsefulCombatOrders(1500ms), UsefulSharpEyes(900ms)


## Phantom - Union & HyperStat & SoulWeapon
PhantomSpec <- JobSpec(JobBase=PhantomBase, 
                       Passive=PhantomPassive, 
                       AllTimeBuff=PhantomAllTimeBuff, 
                       MobInfo=MobDefault, 
                       SpecSet=SpecDefault, 
                       WeaponName="Cane", 
                       UnionStance=0)

PhantomUnionRemained <- PhantomSpec$UnionRemained
PhantomHyperStatBase <- PhantomSpec$HyperStatBase
PhantomCoolReduceType <- PhantomSpec$CoolReduceType
PhantomSpec <- PhantomSpec$Spec


## Phantom - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * PhantomCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * PhantomCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PhantomCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PhantomCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PhantomCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * PhantomCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Phantom - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(20, ifelse(PhantomCore[[1]][1, 2]>=40, 20, 0))), 20, 2 * PhantomCore[[1]][1, 2])
info <- c(140 + PhantomSpec$SkillLv, 3, 150, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
UltimateDrive <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][2, 2]>=40, 20, 0), 20, 2 * PhantomCore[[1]][2, 2])
info <- c(200 + 2 * PhantomSpec$SkillLv, 3, 10000, 180, 10 + Cooldown(18, T, 20 + PhantomSpec$CoolReduceP, PhantomSpec$CoolReduce), F, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
TempestofCard <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][4, 2]>=40, 20, 0), 2 * PhantomCore[[1]][4, 2])
info <- c(270, 1, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NoirCarte <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][4, 2]>=40, 20, 0), 2 * PhantomCore[[1]][4, 2])
info <- c(270, 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
NoirCarteJudgement <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][5, 2]>=40, 20, 0), 2 * PhantomCore[[1]][5, 2])
info <- c(450, 3, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Twilight1 <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 540, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Twilight2 <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][3, 2]>=40, 20, 0), 2 * PhantomCore[[1]][3, 2])
info <- c(700, 6, 1200, NA, 30, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoseCarteFinale <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][3, 2]>=40, 20, 0), 2 * PhantomCore[[1]][3, 2])
info <- c(200, 2, 0, 930, 30, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
RoseCarteFinaleAdd <- rbind(data.frame(option, value), info) ## 12 Hits, FirstATK : 2400

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 1000, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCutPre <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(PhantomCore[[1]][6, 2]>=40, 20, 0), 2 * PhantomCore[[1]][6, 2])
info <- c((2000 + 20 * PhantomSpec$SkillLv)/ 1.3 * 1.2, 1, 180, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
FinalCut <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(240 + 9 * PhantomCore[[2]][1, 2], 3, 6000 + floor(PhantomCore[[2]][1, 2]/25) * 1000, 50, 150, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Joker <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(600 + 24 * PhantomCore[[2]][2, 2], 3, 760, 450, 15, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlackJack <- rbind(data.frame(option, value), info) ## FirstATK : 1200

option <- factor(levels=ASkill)
value <- c()
info <- c(800 + 32 * PhantomCore[[2]][2, 2], 18, 0, 0, 15, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BlackJackLast <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * PhantomCore[[2]][3, 2], 6, 900, 75, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofPhantom <- rbind(data.frame(option, value), info) ## FirstATK : 660

option <- factor(levels=ASkill)
value <- c()
info <- c(485 + 19 * PhantomCore[[2]][3, 2], 15, 0, 30, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MarkofPhantomFinal <- rbind(data.frame(option, value), info) ## FirstATK : 1440

option <- factor(levels=ASkill)
value <- c()
info <- c(400 + 16 * PhantomCore[[2]][4, 2], 7, 990, 0, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LiftBreak <- rbind(data.frame(option, value), info) ## FirstATK : 0, Delays : 270, 270, 1230, 30, 30, 30
}

PhantomATK <- Attack(list(UltimateDrive=UltimateDrive, TempestofCard=TempestofCard, NoirCarte=NoirCarte, NoirCarteJudgement=NoirCarteJudgement, Twilight1=Twilight1, Twilight2=Twilight2,
                          RoseCarteFinale=RoseCarteFinale, RoseCarteFinaleAdd=RoseCarteFinaleAdd, FinalCutPre=FinalCutPre, FinalCut=FinalCut, Joker=Joker, BlackJack=BlackJack, BlackJackLast=BlackJackLast, 
                          MarkofPhantom=MarkofPhantom, MarkofPhantomFinal=MarkofPhantomFinal, LiftBreak=LiftBreak, SpiderInMirror=SpiderInMirror))


## Phantom - Summoned
PhantomSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                 SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Phantom - DealCycle & Deal Calculation
ATKFinal <- data.frame(PhantomATK)
ATKFinal$Delay[c(-1, -2, -9, -11)] <- Delay(ATKFinal$Delay, PhantomSpec$ATKSpeed)[c(-1, -2, -9, -11)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, PhantomSpec$CoolReduceP, PhantomSpec$CoolReduce)

BuffFinal <- data.frame(PhantomBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, PhantomSpec$CoolReduceP, PhantomSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, PhantomSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(PhantomSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, PhantomSpec$CoolReduceP, PhantomSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * PhantomSpec$SummonedDuration / 100, 0)


## Phantom - DealCycle
DealCycle <- c("Skills", "Time", rownames(PhantomBuff))
PhantomDealCycle <- t(rep(0, length(DealCycle)))
colnames(PhantomDealCycle) <- DealCycle
PhantomDealCycle <- data.frame(PhantomDealCycle)

PhantomCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec,
                         Period=180, CycleTime=360) {
  BuffSummonedPrior <- c("Fury", "CrossOverChain", "UsefulSharpEyes", "UsefulCombatOrders", "HeroesOath", 
                         "FinalCutBuff", "MapleWarriors2", "Bullseye", "ReadyToDie2Stack", "SoulContractLink", "Restraint4")
  
  Times180 <- c(0, 1, 0, 0, 0, 
                2, 1, 1, 2, 2, 1)
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
  
  TotalTime <- TotalTime * 1000
  DealCycle <- PreDealCycle
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="FinalCutBuff") {
        DealCycle <- DCATK(DealCycle, "FinalCutPre", ATKFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(DealCycle$Skills[nrow(DealCycle)] == "FinalCutBuff") {
        DealCycle <- DCATK(DealCycle, "FinalCut", ATKFinal)
      } else if(DealCycle$Skills[nrow(DealCycle)] == "HeroesOath") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
    }
  }
  
  SubTimeList <- data.frame(Skills=BuffSummonedPrior, SubTime=SubTime, stringsAsFactors=F)
  NoSubTime <- subset(SubTimeList, SubTimeList$SubTime==0)$Skills
  NoSubTimeBuff <- c()
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
  BuffList[[length(BuffList)+1]] <- BuffList[[1]]
  BuffDelays[[length(BuffDelays)+1]] <- BuffDelays[[1]]
  TimeTypes <- c(0, TimeTypes, TotalTime/1000)
  BJCool <- subset(ATKFinal, rownames(ATKFinal)=="MarkofPhantom")$CoolTime * 1000 / 2
  MPCool <- subset(ATKFinal, rownames(ATKFinal)=="MarkofPhantom")$CoolTime * 1000
  RCCool <- subset(ATKFinal, rownames(ATKFinal)=="RoseCarteFinale")$CoolTime * 1000
  BJRemain <- 0 ; RCRemain <- 0 ; MOPDummy <- 0 ; TOCDummy <- 0
  
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
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        }
      }
      ## BlackJack, Mark of Phantom, Lift Break
      if(BJRemain == 0 & MOPDummy == 0 & k==length(BuffList) & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + MPCool <= BuffStartTime + 8000 | 
         BJRemain == 0 & MOPDummy == 0 & k!=length(BuffList)) {
        DealCycle <- DCATK(DealCycle, "BlackJack", ATKFinal)
        BJRemain <- BJCool - DealCycle$Time[1]
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "TwilightDebuff", BuffFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Twilight1", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Twilight2", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MarkofPhantomFinal", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "MarkofPhantom", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "LiftBreak", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        if(DealCycle$Restraint4[nrow(DealCycle)] >= 7000) {
          DealCycle <- DCATK(DealCycle, "Joker", ATKFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          DealCycle <- DCBuff(DealCycle, "JokerBuffFail", BuffFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          TOCDummy <- 0
        } else if(TOCDummy == 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= BuffStartTime - 10000) {
          DealCycle <- DCATK(DealCycle, "TempestofCard", ATKFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          TOCDummy <- 1
        } else {
          TOCDummy <- 0
        }
        MOPDummy <- 1
      } else if(BJRemain == 0 & MOPDummy == 1 & k==length(BuffList) & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] + BJCool <= BuffStartTime + 8000 | 
                BJRemain == 0 & MOPDummy == 1 & k!=length(BuffList)) {
        DealCycle <- DCATK(DealCycle, "BlackJack", ATKFinal)
        BJRemain <- BJCool - DealCycle$Time[1]
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCBuff(DealCycle, "TwilightDebuff", BuffFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Twilight1", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        DealCycle <- DCATK(DealCycle, "Twilight2", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        if(DealCycle$Restraint4[nrow(DealCycle)] >= 7000) {
          DealCycle <- DCATK(DealCycle, "Joker", ATKFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          DealCycle <- DCBuff(DealCycle, "JokerBuffFail", BuffFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          TOCDummy <- 0
        } else if(TOCDummy == 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= BuffStartTime - 10000) {
          DealCycle <- DCATK(DealCycle, "TempestofCard", ATKFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          TOCDummy <- 1
        } else {
          TOCDummy <- 0
        }
        MOPDummy <- 0
      }
      ## Rose Carte Finale
      else if(RCRemain == 0 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] <= 350000) {
        DealCycle <- DCATK(DealCycle, "RoseCarteFinaleAdd", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- RCCool - DealCycle$Time[1]
        DealCycle <- DCATK(DealCycle, "RoseCarteFinale", ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
      } 
      ## Ultimate Drive
      else {
        DealCycle <- DCATK(DealCycle, c("UltimateDrive"), ATKFinal)
        BJRemain <- max(0, BJRemain - DealCycle$Time[1])
        RCRemain <- max(0, RCRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="FinalCutBuff") {
            DealCycle <- DCATK(DealCycle, "FinalCutPre", ATKFinal)
            BJRemain <- max(0, BJRemain - DealCycle$Time[1])
            RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          if(DealCycle$Skills[nrow(DealCycle)] == "FinalCutBuff") {
            DealCycle <- DCATK(DealCycle, "FinalCut", ATKFinal)
            BJRemain <- max(0, BJRemain - DealCycle$Time[1])
            RCRemain <- max(0, RCRemain - DealCycle$Time[1])
          } 
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          BJRemain <- max(0, BJRemain - DealCycle$Time[1])
          RCRemain <- max(0, RCRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}
PhantomAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Joker
  DealCycle <- RepATKCycle(DealCycle, "Joker", 140, 0, ATKFinal)
  
  ## BlackJack
  DealCycle <- RepATKCycle(DealCycle, "BlackJack", 7, 1200, ATKFinal)
  
  ## BlackJack (Last)
  BJ <- 1
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BlackJack") {
      if(BJ==7) {
        DealCycle$Skills[i] <- "BlackJackLast"
        BJ <- 1
      } else {
        BJ <- BJ + 1
      }
    }
  }
  
  ## Mark of Phantom
  DealCycle <- RepATKCycle(DealCycle, "MarkofPhantom", 7, 660, ATKFinal)
  DealCycle <- RepATKCycle(DealCycle, "MarkofPhantomFinal", 2, 1440, ATKFinal)
  
  ## Lift Break
  LiftBreakTime <- c(0, 270, 540, 1770, 1800, 1830, 1860)
  DC2 <- subset(DealCycle, DealCycle$Skills=="LiftBreak")
  DC2$Skills <- "LiftBreakStart"
  for(i in 1:nrow(DC2)) {
    for(j in 1:length(LiftBreakTime)) {
      DC2 <- rbind(DC2, DC2[i, ])
      DC2$Time[nrow(DC2)] <- DC2$Time[i] + LiftBreakTime[j]
      DC2$Skills[nrow(DC2)] <- "LiftBreak"
    }
  }
  DC2 <- subset(DC2, DC2$Skills=="LiftBreak")
  DC2 <- subset(DC2, DC2$Time <= max(DealCycle$Time))
  DealCycle <- rbind(DealCycle, DC2)
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  for(i in 3:nrow(DealCycle)) {
    if("LiftBreak"==DealCycle[i, 1]) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  
  ## Rose Carte Finale (AddATK)
  DealCycle <- RepATKCycle(DealCycle, "RoseCarteFinaleAdd", 12, 2400, ATKFinal)
  
  ## Tempest of Card
  DealCycle <- RepATKCycle(DealCycle, "TempestofCard", 56, 0, ATKFinal)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Noir Carte
  DealCycle$NoirCarteStack[1] <- 0
  for(i in 2:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("UltimateDrive", "TempestofCard", "Joker", "LiftBreak", "MarkofPhantom", "MarkofPhantomFinal", 
                                  "RoseCarteFinale", "Twilight1", "FinalCut", "SpiderInMirror"))==1) {
      DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i-1] + 1
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      if(DealCycle$NoirCarteStack[i] == 40) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "NoirCarteJudgement"
        DealCycle$NoirCarteStack[i] <- 0
      }
    } else if(DealCycle$Skills[i]=="BlackJack") {
      DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i-1] + 3
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      if(DealCycle$NoirCarteStack[i] >= 40) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "NoirCarteJudgement"
        DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i] - 40
      }
    } else if(DealCycle$Skills[i]=="BlackJackLast") {
      DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i-1] + 3
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "NoirCarte"
      if(DealCycle$NoirCarteStack[i] >= 40) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- "NoirCarteJudgement"
        DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i] - 40
      }
    } else {
      DealCycle$NoirCarteStack[i] <- DealCycle$NoirCarteStack[i-1]
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  DealCycle$NoirCarteStack <- 0
  return(DealCycle)
}

  
PhantomDealCycle <- PhantomCycle(PreDealCycle=PhantomDealCycle, 
                                   ATKFinal=ATKFinal, 
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=PhantomSpec, 
                                   Period=180, 
                                   CycleTime=360)
PhantomDealCycle <- DealCycleFinal(PhantomDealCycle)
PhantomDealCycle <- PhantomAddATK(PhantomDealCycle, ATKFinal, BuffFinal, SummonedFinal, PhantomSpec)
PhantomDealCycleReduction1 <- DealCycleReduction(PhantomDealCycle)

PhantomDealData <- data.frame(PhantomDealCycle$Skills, DealCalc(PhantomDealCycle, ATKFinal, BuffFinal, SummonedFinal, PhantomSpec))
colnames(PhantomDealData) <- c("Skills", "Deal")

PhantomDealCycle2 <- PhantomDealCycle
PhantomDealCycle2$JokerBuff <- PhantomDealCycle2$JokerBuffFail
PhantomDealCycle2$JokerBuffFail <- 0
PhantomDealCycleReduction2 <- DealCycleReduction(PhantomDealCycle2)

## Damage Optimization
PhantomSpecOpt1 <- ResetOptimization1(DealCycles=list(PhantomDealCycleReduction1, PhantomDealCycleReduction2), 
                                      ATKFinal, BuffFinal, SummonedFinal, PhantomSpec, PhantomUnionRemained, rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))
PhantomSpecOpt <- PhantomSpec
PhantomSpecOpt$ATKP <- PhantomSpecOpt$ATKP + PhantomSpecOpt1$ATKP
PhantomSpecOpt$BDR <- PhantomSpecOpt$BDR + PhantomSpecOpt1$BDR
PhantomSpecOpt$IGR <- IGRCalc(c(PhantomSpecOpt$IGR, PhantomSpecOpt1$IGR))

PhantomSpecOpt2 <- ResetOptimization2(DealCycles=list(PhantomDealCycleReduction1, PhantomDealCycleReduction2),
                                      ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt, PhantomHyperStatBase, PhantomBase$ChrLv, PhantomBase$CRROver, 0, rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))
PhantomFinalDPM <- ResetDealCalc(DealCycles=list(PhantomDealCycleReduction1, PhantomDealCycleReduction2), 
                                 ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt2, rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))
PhantomFinalDPMwithMax <- ResetDealCalcWithMaxDMR(DealCycles=list(PhantomDealCycleReduction1, PhantomDealCycleReduction2), 
                                                  ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt2, rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))

PhantomDeal1 <- DealCalcWithMaxDMR(PhantomDealCycle, ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt2)
PhantomDeal2 <- DealCalcWithMaxDMR(PhantomDealCycle2, ATKFinal, BuffFinal, SummonedFinal, PhantomSpecOpt2)

DPM12349$Phantom[1] <- sum(na.omit(PhantomFinalDPMwithMax)) / (max(PhantomDealCycle$Time) / 60000)
DPM12349$Phantom[2] <- sum(na.omit(PhantomFinalDPM)) / (max(PhantomDealCycle$Time) / 60000) - sum(na.omit(PhantomFinalDPMwithMax)) / (max(PhantomDealCycle$Time) / 60000)

PhantomDealRatio <- ResetDealRatio(DealCycles=list(PhantomDealCycle, PhantomDealCycle2), DealDatas=list(PhantomDeal1, PhantomDeal2), 
                                   rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))

PhantomDealData <- data.frame(PhantomDealCycle$Skills, PhantomDealCycle$Time, PhantomDealCycle$Restraint4, PhantomDeal1)
colnames(PhantomDealData) <- c("Skills", "Time", "R4", "Deal")

subset(PhantomDealData, PhantomDealData$R4>0)

PhantomRR <- PhantomDealData[23:429, ]
DPM12349$Phantom[3] <- sum((PhantomRR$Deal))

Phantom40s <- PhantomDealData[23:827, ]
DPM12349$Phantom[4] <- sum((Phantom40s$Deal))