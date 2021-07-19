## Luminous - Data
## Luminous - VMatrix
LuminousCore <- MatrixSet(PasSkills=c("LightReflection", "Apocalypse", "AbsoluteKill"), 
                          PasLvs=c(50, 50, 50), 
                          PasMP=c(10, 10, 10), 
                          ActSkills=c("DoorofTruth", "PunishingResonator", "BaptismofLightandDarkness", "LiberationOrb", 
                                      CommonV("Wizard", "Heroes")), 
                          ActLvs=c(25, 25, 25, 25, 25, 1, 1, 25, 25), 
                          ActMP=c(5, 5, 5, 5, 5, 0, 5, 5, 5), 
                          BlinkLv=1, 
                          BlinkMP=5, 
                          UsefulSkills=c("SharpEyes", "CombatOrders"), 
                          UsefulLvs=20, 
                          UsefulMP=0, 
                          SpecSet=SpecDefault, 
                          SelfBind=T)


## Luminous - Basic Info
## Link Check Needed
LuminousBase <- JobBase(ChrInfo=ChrInfo, 
                        MobInfo=MobDefault,
                        SpecSet=SpecDefault, 
                        Job="Luminous",
                        CoreData=LuminousCore, 
                        BuffDurationNeeded=100, 
                        AbilList=c("BuffDuration", "DisorderBDR"), 
                        LinkList=c("Xenon", "Phantom", "DemonAvenger", "Mikhail"), 
                        MonsterLife=MLTypeI21, 
                        Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "ShiningLord", SpecDefault$WeaponType)[, 1:16],
                        WeaponType=SpecDefault$WeaponType, 
                        SubWeapon=SubWeapon[22, ], 
                        Emblem=Emblem[2, ], 
                        CoolReduceHat=F)


## Luminous - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(20)
PowerofLight <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
BlessofDarkness <- data.frame(option, value)

option <- factor(c("ATK", "BDR", "CRR", "ATKSpeed"), levels=PSkill)
value <- c(10, 15, 20, 1)
SpellMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(40)
HighWisdom <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(30 + LuminousBase$SkillLv)
MorningStarfall <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(40)
DarkCrescendo <- data.frame(option, value)

option <- factor(c("FDR", "IGR"), levels=PSkill)
value <- c(40 + LuminousBase$SkillLv, 40 + LuminousBase$SkillLv)
DarknessSorcery <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CRR", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(LuminousBase$PSkillLv / 2), 30 + LuminousBase$PSkillLv, 15, 15)
MagicMastery <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(LuminousCore[[2]][10, 2])
BlinkPassive <- data.frame(option, value)}

LuminousPassive <- Passive(list(PowerofLight=PowerofLight, BlessofDarkness=BlessofDarkness, SpellMastery=SpellMastery, HighWisdom=HighWisdom, 
                                MorningStarfall=MorningStarfall, DarkCrescendo=DarkCrescendo, DarknessSorcery=DarknessSorcery, MagicMastery=MagicMastery, BlinkPassive=BlinkPassive))


## Luminous - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(17, 180, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Equilibrium <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(17, 180, 900, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
EquilibriumMemorize <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 960, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MagicBooster <- rbind(data.frame(option, value), info)

option <- factor("ATK", levels=BSkill)
value <- c(40)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
PhoticMeditation <- rbind(data.frame(option, value), info)

option <- factor("ImmuneIgnore", levels=BSkill)
value <- c(10)
info <- c(180 + 5 * LuminousBase$SkillLv, NA, 270, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DarknessSorcery <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((LuminousBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(LuminousBase$SkillLv/2))))
info <- c(900 + 30 * LuminousBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
HeroesOath <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "CDMR"), levels=BSkill)
value <- c(10, 8)
info <- c(180 + 3 * LuminousCore[[3]][1, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulSharpEyes <- rbind(data.frame(option, value), info)

option <- factor("SkillLv", levels=BSkill)
value <- c(1)
info <- c(180 + 3 * LuminousCore[[3]][2, 2], NA, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
UsefulCombatOrders <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BaptismStack <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(45, 180, 900, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LiberationOrb <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LiberationLightSTK <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
LiberationDarknessSTK <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(8 + floor(LuminousCore[[2]][5, 2]/10))
info <- c(0, 1, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OverloadMana <- rbind(data.frame(option, value), info)

option <- factor(c("MainStat", "BDR"), levels=BSkill)
value <- c(floor(((1 + 0.1 * LuminousCore[[2]][8, 2]) * MapleSoldier[1, 2]) * LuminousBase$MainStatP), 5 + floor(LuminousCore[[2]][8, 2]/2))
info <- c(60, 180, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleWarriors2 <- rbind(data.frame(option, value), info)}

LuminousBuff <- Buff(list(Equilibrium=Equilibrium, EquilibriumMemorize=EquilibriumMemorize, MagicBooster=MagicBooster, PhoticMeditation=PhoticMeditation, DarknessSorcery=DarknessSorcery, 
                          MapleSoldier=MapleSoldier, HeroesOath=HeroesOath, UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, 
                          BaptismStack=BaptismStack, LiberationOrb=LiberationOrb, LiberationLightSTK=LiberationLightSTK, LiberationDarknessSTK=LiberationDarknessSTK, OverloadMana=OverloadMana, 
                          MapleWarriors2=MapleWarriors2, Restraint4=Restraint4, SoulContractLink=SoulContractLink))
LuminousAllTimeBuff <- AllTimeBuff(LuminousBuff)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, PhoticMeditation(600ms)


## Luminous - Union & HyperStat & SoulWeapon
LuminousSpec <- JobSpec(JobBase=LuminousBase, 
                        Passive=LuminousPassive, 
                        AllTimeBuff=LuminousAllTimeBuff, 
                        MobInfo=MobDefault, 
                        SpecSet=SpecDefault, 
                        WeaponName="ShiningLord", 
                        UnionStance=0)

LuminousUnionRemained <- LuminousSpec$UnionRemained
LuminousHyperStatBase <- LuminousSpec$HyperStatBase
LuminousCoolReduceType <- LuminousSpec$CoolReduceType
LuminousSpec <- LuminousSpec$Spec


## Luminous - Spider In Mirror
{option <- factor(levels=ASkill)
value <- c()
info <- c(450 + 18 * LuminousCore[[2]][9, 2], 15, 960, NA, 250, T, F, F)
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
info <- c(175 + 7 * LuminousCore[[2]][9, 2], 8, 0, 0, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror1 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * LuminousCore[[2]][9, 2], 8, 0, 900, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror2 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * LuminousCore[[2]][9, 2], 8, 0, 850, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror3 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * LuminousCore[[2]][9, 2], 8, 0, 750, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror4 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(175 + 7 * LuminousCore[[2]][9, 2], 8, 0, 650, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirror5 <- rbind(data.frame(option, value), info)

option <- factor(levels=SSkill)
value <- c()
info <- c(0, 0, 0, 5700, 50, 250, F, T, F, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
SpiderInMirrorWait <- rbind(data.frame(option, value), info)}


## Luminous - Attacks
{option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(LuminousCore[[1]][1, 2]>=40, 20, 0), 20, 2 * LuminousCore[[1]][1, 2])
info <- c(400 + 5 * LuminousSpec$SkillLv, 4, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightReflection <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(LuminousCore[[1]][1, 2]>=40, 20, 0), 20, 2 * LuminousCore[[1]][1, 2])
info <- c((400 + 5 * LuminousSpec$SkillLv) * 0.5, 4, 900, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LightReflectionAdd <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(LuminousCore[[1]][2, 2]>=40, 20, 0), 20, FDRCalc(c(2 * LuminousCore[[1]][2, 2], 5)))
info <- c(340 + 4 * LuminousSpec$SkillLv, 7, 960, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Apocalypse <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(ifelse(LuminousCore[[1]][2, 2]>=40, 20, 0), 20, FDRCalc(c(2 * LuminousCore[[1]][2, 2], 5)))
info <- c((340 + 4 * LuminousSpec$SkillLv) * 0.5, 7, 960, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ApocalypseAdd <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(40 + LuminousSpec$SkillLv, ifelse(LuminousCore[[1]][3, 2]>=40, 20, 0))), 20, FDRCalc(c(2 * LuminousCore[[1]][3, 2], 5)))
info <- c(385 + 3 * LuminousSpec$SkillLv, 7, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AbsoluteKill <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(40 + LuminousSpec$SkillLv, ifelse(LuminousCore[[1]][3, 2]>=40, 20, 0))), 20, FDRCalc(c(2 * LuminousCore[[1]][3, 2], 5)))
info <- c(385 + 3 * LuminousSpec$SkillLv, 7, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AbsoluteKillEq <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
value <- c(IGRCalc(c(40 + LuminousSpec$SkillLv, ifelse(LuminousCore[[1]][3, 2]>=40, 20, 0))), 20, FDRCalc(c(2 * LuminousCore[[1]][3, 2], 5)))
info <- c((385 + 3 * LuminousSpec$SkillLv) * 0.5, 7, 810, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AbsoluteKillAdd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(340 + 13 * LuminousCore[[2]][2, 2], 6, 990, 180, 30, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
PunishingResonator <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=ASkill)
value <- c(100)
info <- c(375 + 15 * LuminousCore[[2]][3, 2], 7, 840, 185, 45, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
BaptismofLightandDarkness <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(375 + 15 * LuminousCore[[2]][4, 2], 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LiberationOrbLight <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * LuminousCore[[2]][4, 2] + 7 * (25 + LuminousCore[[2]][4, 2]), 10, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
LiberationOrbBalance <- rbind(data.frame(option, value), info)}

LuminousATK <- Attack(list(LightReflection=LightReflection, LightReflectionAdd=LightReflectionAdd, Apocalypse=Apocalypse, ApocalypseAdd=ApocalypseAdd, 
                           AbsoluteKill=AbsoluteKill, AbsoluteKillEq=AbsoluteKillEq, AbsoluteKillAdd=AbsoluteKillAdd, PunishingResonator=PunishingResonator, 
                           BaptismofLightandDarkness=BaptismofLightandDarkness, LiberationOrbLight=LiberationOrbLight, LiberationOrbBalance=LiberationOrbBalance, 
                           SpiderInMirror=SpiderInMirror))


## Luminous - Summoned
{option <- factor(levels=SSkill)
value <- c()
info <- c(375 + 15 * LuminousCore[[2]][1, 2], 10, 870, 4000, 25 + floor(LuminousCore[[2]][1, 2]/2), NA, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
DoorofTruth <- rbind(data.frame(option, value), info)}

LuminousSummoned <- Summoned(list(DoorofTruth=DoorofTruth, SpiderInMirrorStart=SpiderInMirrorStart, 
                                  SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                  SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Luminous - DealCycle & Deal Calculation
ATKFinal <- data.frame(LuminousATK)
ATKFinal$Delay <- Delay(ATKFinal$Delay, LuminousSpec$ATKSpeed)
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, LuminousSpec$CoolReduceP, LuminousSpec$CoolReduce)

BuffFinal <- data.frame(LuminousBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, LuminousSpec$CoolReduceP, LuminousSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, LuminousSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, 3, 0)

SummonedFinal <- data.frame(LuminousSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, LuminousSpec$CoolReduceP, LuminousSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * LuminousSpec$SummonedDuration / 100, 0)


## Luminous DealCycle
DealCycle <- c("Skills", "Time", rownames(LuminousBuff))
LuminousDealCycle <- t(rep(0, length(DealCycle)))
colnames(LuminousDealCycle) <- DealCycle
LuminousDealCycle <- data.frame(LuminousDealCycle)

## Ec - Eq - Sf - Eq - Ec - Eq(LiberationOrb) - Eq(Memorize)

LuminousCycle <- function(PreDealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  DealCycle <- PreDealCycle
  states <- c("EC", "EQ", "SF", "EQ", "EC", "EQ", "EQM")
  ECGauge <- 22 ; SFGauge <- 25
  
  PunishingCool <- subset(ATKFinal, rownames(ATKFinal)=="PunishingResonator")$CoolTime * 1000
  PunishingRemain <- 0
  BaptismCool <- 2220
  
  for(i in 1:length(states)) {
    if(states[i]=="EC") {
      LiberationDarkness <- 0
      for(j in 1:(ECGauge-1)) {
        DealCycle <- DCATK(DealCycle, "Apocalypse", ATKFinal)
        if(nrow(DealCycle)==2) {
          DealCycle$BaptismStack[nrow(DealCycle)] <- 23
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- 1
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- 0
          LiberationDarkness <- 6000 - DealCycle$Time[1]
          
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "LiberationOrbLight"
        } else {
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          if(LiberationDarkness == 0) {
            DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- min(4, DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1] + 1)
            DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
            LiberationDarkness <- 6000 - DealCycle$Time[1]
            
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "LiberationOrbLight"
          } else {
            DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
            DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
            LiberationDarkness <- max(0, LiberationDarkness - DealCycle$Time[1])
          }
        }
      }
      
      if(i==5) {
        BuffList <- c("MapleWarriors2", "SoulContractLink")
        for(j in 1:length(BuffList)) {
          DealCycle <- DCBuff(DealCycle, BuffList[j], BuffFinal)
          LiberationLight <- max(0, LiberationLight - DealCycle$Time[1])
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        }
        if(nrow(subset(DealCycle, DealCycle$Skills=="SpiderInMirror"))==0) {
          DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
          LiberationLight <- max(0, LiberationLight - DealCycle$Time[1])
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        }
      }
      
      DealCycle <- DCATK(DealCycle, "Apocalypse", ATKFinal)
      DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
      PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
      if(LiberationDarkness == 0) {
        DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- min(4, DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1] + 1)
        DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
        LiberationDarkness <- 6000 - DealCycle$Time[1]
        DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
        DealCycle$Skills[nrow(DealCycle)] <- "LiberationOrbLight"
      } else {
        DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
        DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
        LiberationDarkness <- max(0, LiberationDarkness - DealCycle$Time[1])
      }
    } else if(states[i]=="SF") {
      DealCycle <- DCATK(DealCycle, "LightReflection", ATKFinal)
      LiberationLight <- 6000 - DealCycle$Time[1]
      DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
      DealCycle$LiberationLightSTK[nrow(DealCycle)] <- min(4, DealCycle$LiberationLightSTK[nrow(DealCycle)-1] + 1)
      DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
      PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
      DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
      DealCycle$Skills[nrow(DealCycle)] <- "LiberationOrbLight"
      
      ABKillCool <- Cooldown(12 - Spec$SkillLv, T, Spec$CoolReduceP, Spec$CoolReduce) * 1000
      ABKillRemain <- 0
      DealCycle <- DCATK(DealCycle, "AbsoluteKill", ATKFinal)
      LiberationLight <- 6000 - DealCycle$Time[1]
      DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
      DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
      DealCycle$BaptismStack[nrow(DealCycle)] <- min(23, DealCycle$BaptismStack[nrow(DealCycle)-1] + 1)
      PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
      ABKillRemain <- ABKillCool - DealCycle$Time[1]
      
      BuffList <- c("MagicBooster", "PhoticMeditation", "DarknessSorcery", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders")
      for(j in 1:length(BuffList)) {
        DealCycle <- DCBuff(DealCycle, BuffList[j], BuffFinal)
        LiberationLight <- max(0, LiberationLight - DealCycle$Time[1])
        DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
        DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
        DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
        PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        ABKillRemain <- max(0, ABKillRemain - DealCycle$Time[1])
      }
      
      for(j in 2:SFGauge) {
        if(ABKillRemain == 0) {
          DealCycle <- DCATK(DealCycle, "AbsoluteKill", ATKFinal)
          LiberationLight <- max(0, LiberationLight - DealCycle$Time[1])
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- min(23, DealCycle$BaptismStack[nrow(DealCycle)-1] + 1)
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          ABKillRemain <- ABKillCool - DealCycle$Time[1]
        }
        DealCycle <- DCATK(DealCycle, "LightReflection", ATKFinal)
        DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
        PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        if(LiberationLight == 0) {
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- min(4, DealCycle$LiberationLightSTK[nrow(DealCycle)-1] + 1)
          LiberationLight <- 6000 - DealCycle$Time[1]
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "LiberationOrbLight"
        } else {
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          LiberationLight <- max(0, LiberationLight - DealCycle$Time[1])
        }
        ABKillRemain <- max(0, ABKillRemain - DealCycle$Time[1])
      }
    } else if(states[i]=="EQ") {
      DealCycle <- DCBuff(DealCycle, "Equilibrium", BuffFinal)
      DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
      DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
      DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
      PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
      DTDummy <- 0 ; SCDummy <- 0
      BaptismRemain <- 0
      
      if(i==6) {
        DealCycle <- DCBuff(DealCycle, "LiberationOrb", BuffFinal)
        DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- 0
        DealCycle$LiberationLightSTK[nrow(DealCycle)] <- 0
        DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
        PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
        
        DealCycle <- DCBuff(DealCycle, "Restraint4", BuffFinal)
        DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
        DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
        DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
        PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
        BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
      }
      
      while(DealCycle$Equilibrium[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        if(PunishingRemain==0 & DealCycle$Equilibrium[nrow(DealCycle)] - DealCycle$Time[1] > 6000) {
          DealCycle <- DCATK(DealCycle, "PunishingResonator", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- PunishingCool - DealCycle$Time[1]
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
        } else if(DealCycle$BaptismStack[nrow(DealCycle)]>=12 & BaptismRemain==0 & DealCycle$Equilibrium[nrow(DealCycle)] - DealCycle$Time[1] > 10000 & i!=6) {
          DealCycle <- DCATK(DealCycle, "BaptismofLightandDarkness", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1] - 12
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- BaptismCool - DealCycle$Time[1]
        } else if(DealCycle$BaptismStack[nrow(DealCycle)]>=12 & BaptismRemain==0 & i==6) {
          DealCycle <- DCATK(DealCycle, "BaptismofLightandDarkness", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1] - 12
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- BaptismCool - DealCycle$Time[1]
        } else if(i==2 & SCDummy==0 &
                  subset(BuffFinal, rownames(BuffFinal)=="Equilibrium")$Duration * 1000 - (DealCycle$Equilibrium[nrow(DealCycle)] - DealCycle$Time[1]) >= 
                  subset(BuffFinal, rownames(BuffFinal)=="SoulContractLink")$CoolTime * 1000 - 72840) {
          DealCycle <- DCBuff(DealCycle, "SoulContractLink", BuffFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
          SCDummy <- 1
        } else if(DTDummy==0) {
          DealCycle <- DCSummoned(DealCycle, "DoorofTruth", SummonedFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
          DTDummy <- 1
        } else {
          DealCycle <- DCATK(DealCycle, "AbsoluteKill", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- min(23, DealCycle$BaptismStack[nrow(DealCycle)-1] + 1)
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
        }
      }
    } else if(states[i]=="EQM") {
      DealCycle <- DCBuff(DealCycle, "EquilibriumMemorize", BuffFinal)
      DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
      DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
      DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
      PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
      DTDummy <- 0
      
      while(DealCycle$EquilibriumMemorize[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        if(PunishingRemain==0 & DealCycle$EquilibriumMemorize[nrow(DealCycle)] - DealCycle$Time[1] > 6000) {
          DealCycle <- DCATK(DealCycle, "PunishingResonator", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- PunishingCool - DealCycle$Time[1]
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
        } else if(DealCycle$BaptismStack[nrow(DealCycle)]>=12 & BaptismRemain==0 & DealCycle$EquilibriumMemorize[nrow(DealCycle)] - DealCycle$Time[1] > 10000) {
          DealCycle <- DCATK(DealCycle, "BaptismofLightandDarkness", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1] - 12
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- BaptismCool - DealCycle$Time[1]
        } else if(DTDummy==0) {
          DealCycle <- DCSummoned(DealCycle, "DoorofTruth", SummonedFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- DealCycle$BaptismStack[nrow(DealCycle)-1]
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
          DTDummy <- 1
        } else {
          DealCycle <- DCATK(DealCycle, "AbsoluteKill", ATKFinal)
          DealCycle$LiberationDarknessSTK[nrow(DealCycle)] <- DealCycle$LiberationDarknessSTK[nrow(DealCycle)-1]
          DealCycle$LiberationLightSTK[nrow(DealCycle)] <- DealCycle$LiberationLightSTK[nrow(DealCycle)-1]
          DealCycle$BaptismStack[nrow(DealCycle)] <- min(23, DealCycle$BaptismStack[nrow(DealCycle)-1] + 1)
          PunishingRemain <- max(0, PunishingRemain - DealCycle$Time[1])
          BaptismRemain <- max(0, BaptismRemain - DealCycle$Time[1])
        }
      }
    }
  }
  return(DealCycle)
}
LuminousAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec) {
  ## Liberation Orb(Active)
  LO <- subset(DealCycle, DealCycle$Skills=="LiberationOrb")
  Ind <- rownames(LO)
  Ind[length(Ind)+1] <- nrow(DealCycle)-1
  Ind <- as.numeric(Ind)
  
  for(i in 1:(length(Ind)-1)) {
    DC <- data.frame(t(rep(0, ncol(DealCycle))))
    colnames(DC) <- colnames(DealCycle)
    p <- Ind[i] + 1
    n <- 0
    
    time <- 1001
    while(p < Ind[i+1] & DealCycle$LiberationOrb[p] > 0 & n < 20) {
      if(time > 1000 & max(DealCycle$Skills[p]==c("AbsoluteKill"))==1) {
        DC <- rbind(DC, DealCycle[p, ])
        DC[nrow(DC), 1] <- c("LiberationOrbBalance")
        time <- DealCycle[p+1, 2] - DealCycle[p, 2]
        n <- n + 1
      } else {
        time <- time + DealCycle[p+1, 2] - DealCycle[p, 2]
      }
      p <- p + 1
    }
    DealCycle <- rbind(DealCycle, DC[2:nrow(DC), ])  
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Sunfire, Eclipse, Equilibrium
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="LightReflection") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "LightReflectionAdd"
    } else if(DealCycle$Skills[i]=="Apocalypse") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ApocalypseAdd"
    } else if(DealCycle$Skills[i]=="AbsoluteKill" & DealCycle$Equilibrium[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AbsoluteKillEq"
    } else if(DealCycle$Skills[i]=="AbsoluteKill" & DealCycle$EquilibriumMemorize[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AbsoluteKillEq"
    } else if(DealCycle$Skills[i]=="AbsoluteKill" & DealCycle$Equilibrium[i]==0 & DealCycle$EquilibriumMemorize[i]==0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "AbsoluteKillAdd"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Punishing Resonator, Baptism of Light and Darkness
  DealCycle <- RepATKCycle(DealCycle, "PunishingResonator", 28, 990, ATKFinal)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="PunishingResonator") {
      DealCycle$DarkCrescendoBDR[i] <- DealCycle$DarkCrescendoBDR[i-1]
    }
  }
  
  DealCycle <- RepATKCycle(DealCycle, "BaptismofLightandDarkness", 13, 0, ATKFinal)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="BaptismofLightandDarkness") {
      DealCycle$DarkCrescendoBDR[i] <- DealCycle$DarkCrescendoBDR[i-1]
    }
  }
  
  ## Door of Truth
  DealCycle <- DCSummonedATKs(DealCycle, "DoorofTruth", SummonedFinal)
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="DoorofTruth") {
      DealCycle$DarkCrescendoBDR[i] <- DealCycle$DarkCrescendoBDR[i-1]
    }
  }
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("SpiderInMirror", "SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait"))==1) {
      DealCycle$DarkCrescendoBDR[i] <- DealCycle$DarkCrescendoBDR[i-1]
    }
  }
  
  ## Dummy Reduction
  DealCycle$BaptismStack <- 0
  DealCycle$LiberationLightSTK <- 0
  DealCycle$LiberationDarknessSTK <- 0
  
  ## Overload Mana
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("LightReflection", "LightReflectionAdd", "Apocalypse", "ApocalypseAdd", "AbsoluteKill", "AbsoluteKillEq", "AbsoluteKillAdd", 
                                  "PunishingResonator", "BaptismofLightandDarkness", "LiberationOrbBalance", "DoorofTruth"))==1) {
      DealCycle$OverloadMana[i] <- 1
    } else if(substr(DealCycle$Skills[i], 1, 17)=="DarkLightningMark") {
      DealCycle$OverloadMana[i] <- 1
    }
  }
  return(DealCycle)
}

LuminousDealCycle <- LuminousCycle(PreDealCycle=LuminousDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=LuminousSpec)
LuminousDealCycle <- LuminousCycle(PreDealCycle=LuminousDealCycle, 
                                   ATKFinal=ATKFinal,
                                   BuffFinal=BuffFinal, 
                                   SummonedFinal=SummonedFinal, 
                                   Spec=LuminousSpec)
LuminousDealCycle <- DealCycleFinal(LuminousDealCycle)
LuminousDealCycle <- LuminousAddATK(DealCycle=LuminousDealCycle, 
                                    ATKFinal=ATKFinal, 
                                    BuffFinal=BuffFinal, 
                                    SummonedFinal=SummonedFinal, 
                                    Spec=LuminousSpec)
LuminousDealCycleReduction <- DealCycleReduction(LuminousDealCycle, c("DarkCrescendoBDR"))

LuminousDealData <- data.frame(LuminousDealCycle$Skills, DealCalc(LuminousDealCycle, ATKFinal, BuffFinal, SummonedFinal, LuminousSpec))
colnames(LuminousDealData) <- c("Skills", "Deal")

## Damage Optimization
LuminousSpecOpt1 <- Optimization1(LuminousDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, LuminousSpec, LuminousUnionRemained)
LuminousSpecOpt <- LuminousSpec
LuminousSpecOpt$ATKP <- LuminousSpecOpt$ATKP + LuminousSpecOpt1$ATKP
LuminousSpecOpt$BDR <- LuminousSpecOpt$BDR + LuminousSpecOpt1$BDR
LuminousSpecOpt$IGR <- IGRCalc(c(LuminousSpecOpt$IGR, LuminousSpecOpt1$IGR))

LuminousSpecOpt2 <- Optimization2(LuminousDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, LuminousSpecOpt, LuminousHyperStatBase, LuminousBase$ChrLv, LuminousBase$CRROver)
LuminousFinalDPM <- DealCalc(LuminousDealCycle, ATKFinal, BuffFinal, SummonedFinal, LuminousSpecOpt2)
LuminousFinalDPMwithMax <- DealCalcWithMaxDMR(LuminousDealCycle, ATKFinal, BuffFinal, SummonedFinal, LuminousSpecOpt2)

DPM12349$Luminous[1] <- sum(na.omit(LuminousFinalDPMwithMax)) / (max(LuminousDealCycle$Time) / 60000)
DPM12349$Luminous[2] <- sum(na.omit(LuminousFinalDPM)) / (max(LuminousDealCycle$Time) / 60000) - sum(na.omit(LuminousFinalDPMwithMax)) / (max(LuminousDealCycle$Time) / 60000)

LuminousDealRatio <- DealRatio(LuminousDealCycle, LuminousFinalDPMwithMax)

LuminousDealData <- data.frame(LuminousDealCycle$Skills, LuminousDealCycle$Time, LuminousDealCycle$Restraint4, LuminousFinalDPMwithMax, LuminousFinalDPM-LuminousFinalDPMwithMax)
colnames(LuminousDealData) <- c("Skills", "Time", "R4", "Deal", "Leakage")

subset(LuminousDealData, LuminousDealData$R4>0)

LuminousRR <- LuminousDealData[622:755, ]
DPM12349$Luminous[3] <- sum((LuminousRR$Deal))

Luminous40s <- LuminousDealData[622:909, ]
DPM12349$Luminous[4] <- sum((Luminous40s$Deal))

