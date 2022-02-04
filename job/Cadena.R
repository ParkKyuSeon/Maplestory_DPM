## Cadena - Core
CadenaCoreBase <- CoreBuilder(ActSkills=c("ADOrdnance", "ChainArtsFury", "ChainArtsMaelstrom", "WeaponVarietyFinale",
                                          CommonV("Thief", "Nova")), 
                              ActSkillsLv=c(25, 25, 25, 25, 25, 25, 1, 25, 25), 
                              UsefulSkills=c("SharpEyes", "CombatOrders"), 
                              SpecSet=get(DPMCalcOption$SpecSet), 
                              VPassiveList=CadenaVPassive, 
                              VPassivePrior=CadenaVPrior, 
                              SelfBind=F)

CadenaCore <- MatrixSet(PasSkills=CadenaCoreBase$PasSkills$Skills, 
                        PasLvs=CadenaCoreBase$PasSkills$Lv, 
                        PasMP=CadenaCoreBase$PasSkills$MP, 
                        ActSkills=CadenaCoreBase$ActSkills$Skills, 
                        ActLvs=CadenaCoreBase$ActSkills$Lv, 
                        ActMP=CadenaCoreBase$ActSkills$MP, 
                        UsefulSkills=CadenaCoreBase$UsefulSkills, 
                        UsefulLvs=20, 
                        UsefulMP=0, 
                        SpecSet=get(DPMCalcOption$SpecSet), 
                        SpecialCore=CadenaCoreBase$SpecialCoreUse)


## Cadena - Basic Info
CadenaBase <- JobBase(ChrInfo=ChrInfo, 
                      MobInfo=get(DPMCalcOption$MobSet),
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      Job="Cadena",
                      CoreData=CadenaCore, 
                      BuffDurationNeeded=0, 
                      AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "Cadena"), 
                      LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "Cadena"), 
                      MonsterLife=get(FindJob(MonsterLifePreSet, "Cadena")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                      Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Chain", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                      WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                      SubWeapon=SubWeapon[rownames(SubWeapon)=="Transmitter", ], 
                      Emblem=Emblem[rownames(Emblem)=="Agent", ], 
                      CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "Cadena")))


## Cadena - Passive
{option <- factor(c("MainStat"), levels=PSkill)
value <- c(50)
CollectingFourleaf <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(10, 5, 10)
QuickServiceMind1 <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(20)
BasicDetection <- data.frame(option, value)

option <- factor(c("FDR"), levels=PSkill)
value <- c(88)
WeaponVarietyBuff <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30)
SummonSlashingKnifeDebuff <- data.frame(option, value)

option <- factor(c("CDMR", "CRR"), levels=PSkill)
value <- c(6 * (10 + ceiling(CadenaBase$PSkillLv/4)), 6 * 2)
WeakpointConvergingAttack <- data.frame(option, value) 
## Adventure Wizard Link (Emprical Knowledge Weakpoint), Venom Bust (Dot), ChainArts : Stroke I (Slow), ChainArts : Stroke II / ChainArts : Chase (Slow) [Not In CRR], ChainArts : Maelstrom (Slow)
## Summon Slashing Knife (Fear), Summon Bitting Needlebat (Confusion), Weakpoint Conversing Attack (Bleeding)

option <- factor(c("CDMR", "CRR", "Mastery", "ATK"), levels=PSkill)
value <- c(15 + ceiling(CadenaBase$PSkillLv/2), 30 + CadenaBase$PSkillLv, 70 + ceiling(CadenaBase$PSkillLv/2), 30 + CadenaBase$PSkillLv)
WeaponExpert <- data.frame(option, value)

option <- factor(c("ATK", "CDMR", "CRR"), levels=PSkill)
value <- c(30 + CadenaBase$PSkillLv, 5 + ceiling(CadenaBase$PSkillLv/6), 10 + ceiling(CadenaBase$PSkillLv/3))
QuickServiceMind2 <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(CadenaCore, "ReadyToDie"))
ReadyToDie <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(CadenaCore, "Blink"))
BlinkPassive <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(rep(GetCoreLv(CadenaCore, "RopeConnect"), 2))
RopeConnectPassive <- data.frame(option, value)}

CadenaPassive <- Passive(list(CollectingFourleaf=CollectingFourleaf, PhysicalTraining=PhysicalTraining, QuickServiceMind1=QuickServiceMind1, BasicDetection=BasicDetection, WeaponVarietyBuff=WeaponVarietyBuff, 
                              SummonSlashingKnifeDebuff=SummonSlashingKnifeDebuff, WeakpointConvergingAttack=WeakpointConvergingAttack, WeaponExpert=WeaponExpert, QuickServiceMind2=QuickServiceMind2, 
                              ReadyToDie=ReadyToDie, BlinkPassive=BlinkPassive, RopeConnectPassive=RopeConnectPassive))


## Cadena - Buff
{option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(200, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
WeaponBooster <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((CadenaBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(CadenaBase$SkillLv/2))))
info <- c(900 + 30 * CadenaBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(10)
info <- c(60, 120, 570, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ShadowdealersElixir <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c((2.76 / 1.88 - 1) * 100)
info <- c(30, 180, 720, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ProfessionalAgentBuff <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(CadenaCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(levels=BSkill)
value <- c()
info <- c(35 + GetCoreLv(CadenaCore, "ChainArtsFury"), 180 - GetCoreLv(CadenaCore, "ChainArtsFury"), Delay(540, 2), F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ChainArtsFuryBuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10 + floor(GetCoreLv(CadenaCore, "ReadyToDie")/10))
info <- c(30, 90 - floor(GetCoreLv(CadenaCore, "ReadyToDie")/2), 780, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie1Stack <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(30 + floor(GetCoreLv(CadenaCore, "ReadyToDie")/5))
info <- c((30 - 0.78)/2 + 0.78, 90 - floor(GetCoreLv(CadenaCore, "ReadyToDie")/2), 1560, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
ReadyToDie2Stack <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5 + GetCoreLv(CadenaCore, "BlessofGrandisGoddess"))
info <- c(40, 240, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofGrandisGoddess <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 240, 0, F, F, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Deal40s <- rbind(data.frame(option, value), info)}

CadenaBuff <- list(WeaponBooster=WeaponBooster, MapleSoldier=MapleSoldier, ShadowdealersElixir=ShadowdealersElixir, ProfessionalAgentBuff=ProfessionalAgentBuff, 
                   UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, ChainArtsFuryBuff=ChainArtsFuryBuff, ReadyToDie1Stack=ReadyToDie1Stack, ReadyToDie2Stack=ReadyToDie2Stack, 
                   BlessofGrandisGoddess=BlessofGrandisGoddess, Deal40s=Deal40s, Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## Petbuff : WeaponBooster(600ms), MapleSoldier(0ms), UsefulSharpEyes, UsefulCombatOrders, (UsefulAdvancedBless)
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  CadenaBuff[[length(CadenaBuff)+1]] <- UsefulAdvancedBless
  names(CadenaBuff)[[length(CadenaBuff)]] <- "UsefulAdvancedBless"
}
CadenaBuff <- Buff(CadenaBuff)
CadenaAllTimeBuff <- AllTimeBuff(CadenaBuff)


## Cadena - Union & HyperStat & SoulWeapon
CadenaSpec <- JobSpec(JobBase=CadenaBase, 
                      Passive=CadenaPassive, 
                      AllTimeBuff=CadenaAllTimeBuff, 
                      MobInfo=get(DPMCalcOption$MobSet), 
                      SpecSet=get(DPMCalcOption$SpecSet), 
                      WeaponName="Chain", 
                      UnionStance=0)

CadenaUnionRemained <- CadenaSpec$UnionRemained
CadenaHyperStatBase <- CadenaSpec$HyperStatBase
CadenaCoolReduceType <- CadenaSpec$CoolReduceType
CadenaSpec <- CadenaSpec$Spec


## Cadena - Spider In Mirror
SIM <- SIMData(GetCoreLv(CadenaCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## Cadena - Attacks
## Hyper : NonChainArts - Reinforce / Boss Killer, ChainArtsStroke - Reinforce / NextATK Reinforce, ChainArtsTakedown - CoolTime Reduce
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety"))
info <- c(150, 2, 330, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsStroke1 <- rbind(data.frame(option, value), info) ## CancellableDelay : 150 / 180

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(20, ifelse(GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety"))
info <- c(400, 5, 510, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsStroke2 <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(levels=ASkill)
value <- c()
info <- c(100, 1, 660, NA, 0.2, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsChase <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "CuttingScimitar_ScratchingClaw")>=40, 20, 0), FDRCalc(c(15, 2 * GetCoreLv(CadenaCore, "CuttingScimitar_ScratchingClaw"))))
info <- c(475 + 7 * CadenaSpec$PSkillLv, 5, 780, NA, 4, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonCuttingScimitar <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "CuttingScimitar_ScratchingClaw")>=40, 20, 0), FDRCalc(c(15, 2 *GetCoreLv(CadenaCore, "CuttingScimitar_ScratchingClaw"))))
info <- c(505 + 7 * CadenaSpec$PSkillLv, 4, 600, NA, 3, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonScratchingClaw <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger")>=40, 20, 0), FDRCalc(c(15, 2 * GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger"))))
info <- c(475 + 7 * CadenaSpec$PSkillLv, 1, 780, 330, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonThrowingWingdaggerFDR <- rbind(data.frame(option, value), info) ## Non Cancelled

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger"))
info <- c(475 + 7 * CadenaSpec$PSkillLv, 1, 0, 0, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonThrowingWingdagger <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger"))
info <- c(620 + 7 * CadenaSpec$PSkillLv, 3, 0, 0, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonThrowingWingdaggerExplosion <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "ShootingShotgun_ReleasingBomb")>=40, 20, 0), FDRCalc(c(15, 2 * GetCoreLv(CadenaCore, "ShootingShotgun_ReleasingBomb"))))
info <- c(560 + 7 * CadenaSpec$PSkillLv, 7, 840, NA, 5, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonShootingShotgun <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger")>=40, 20, 0), FDRCalc(c(15, 2 * GetCoreLv(CadenaCore, "SlashingKnife_ThrowingWingdagger"))))
info <- c(485 + 7 * CadenaSpec$PSkillLv, 8, 750, NA, 10, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonSlashingKnife <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "ShootingShotgun_ReleasingBomb")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ShootingShotgun_ReleasingBomb"))
info <- c(585 + 7 * CadenaSpec$PSkillLv, 6, 540, NA, 8, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonReleasingBomb <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "StrikingBrick")>=40, 20, 0), FDRCalc(c(15, 2 * GetCoreLv(CadenaCore, "StrikingBrick"))))
info <- c(535 + 8 * CadenaSpec$SkillLv, 7, 960, NA, 8, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonStrikingBrick <- rbind(data.frame(option, value), info) ## CancellableDelay : 240

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "BittingNeedlebat")>=40, 20, 0), FDRCalc(c(15, 35, 2 * GetCoreLv(CadenaCore, "BittingNeedlebat"))))
info <- c(490 + 10 * CadenaSpec$SkillLv, 6, 480, NA, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonBittingNeedlebat1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "BittingNeedlebat")>=40, 20, 0), FDRCalc(c(35, 2 * GetCoreLv(CadenaCore, "BittingNeedlebat"))))
info <- c(610 + 10 * CadenaSpec$SkillLv, 7, 570, NA, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonBittingNeedlebat2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(40, ifelse(GetCoreLv(CadenaCore, "BittingNeedlebat")>=40, 20, 0), FDRCalc(c(45, 2 * GetCoreLv(CadenaCore, "BittingNeedlebat"))))
info <- c(790 + 10 * CadenaSpec$SkillLv, 8, 810, NA, 12, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
SummonBittingNeedlebat3 <- rbind(data.frame(option, value), info) ## CancellableDelay : 180 / 210

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ChainArtsStroke_WeaponVariety"))
info <- c(350 + 15 * CadenaSpec$PSkillLv, 4, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WeaponVariety <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CadenaCore, "ChainArtsCrush_ProfessionalAgent")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ChainArtsCrush_ProfessionalAgent"))
info <- c(255, 3, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ProfessionalAgent <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(CadenaCore, "ChainArtsCrush_ProfessionalAgent")>=40, 20, 0), 2 * GetCoreLv(CadenaCore, "ChainArtsCrush_ProfessionalAgent"))
info <- c(510, 15, 990, NA, 30, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsCrush <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(225 + 9 * GetCoreLv(CadenaCore, "ADOrdnance"), 5, 450, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ADOrdnance <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(750 + 30 * GetCoreLv(CadenaCore, "ADOrdnance"), 8, 0, NA, 25, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ADOrdnanceSphere <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(CadenaCore, "ChainArtsFury"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsFury <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(300 + 12 * GetCoreLv(CadenaCore, "ChainArtsMaelstrom"), 4, 720, 90, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
ChainArtsMaelstrom <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(250 + 10 * GetCoreLv(CadenaCore, "WeaponVarietyFinale"), 7 * 4, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
WeaponVarietyFinale <- rbind(data.frame(option, value), info) ## StartATK : 1050ms

option <- factor(levels=ASkill)
value <- c()
info <- c(0, 0, 0, 0, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
CoolResetATKDummy <- rbind(data.frame(option, value), info)
}

CadenaATK <- Attack(list(ChainArtsStroke1=ChainArtsStroke1, ChainArtsStroke2=ChainArtsStroke2, ChainArtsChase=ChainArtsChase, 
                         SummonCuttingScimitar=SummonCuttingScimitar, SummonScratchingClaw=SummonScratchingClaw, SummonThrowingWingdaggerFDR=SummonThrowingWingdaggerFDR, SummonThrowingWingdagger=SummonThrowingWingdagger, 
                         SummonThrowingWingdaggerExplosion=SummonThrowingWingdaggerExplosion, SummonShootingShotgun=SummonShootingShotgun, SummonSlashingKnife=SummonSlashingKnife, SummonReleasingBomb=SummonReleasingBomb, 
                         SummonStrikingBrick=SummonStrikingBrick, SummonBittingNeedlebat1=SummonBittingNeedlebat1, SummonBittingNeedlebat2=SummonBittingNeedlebat2, SummonBittingNeedlebat3=SummonBittingNeedlebat3, 
                         WeaponVariety=WeaponVariety, ProfessionalAgent=ProfessionalAgent, ChainArtsCrush=ChainArtsCrush, 
                         ADOrdnance=ADOrdnance, ADOrdnanceSphere=ADOrdnanceSphere, ChainArtsFury=ChainArtsFury, ChainArtsMaelstrom=ChainArtsMaelstrom, WeaponVarietyFinale=WeaponVarietyFinale, 
                         SpiderInMirror=SpiderInMirror, CoolResetATKDummy=CoolResetATKDummy))


## Cadena - Summoned
CadenaSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## Cadena - DealCycle
ATKFinal <- data.frame(CadenaATK)
ATKFinal$Delay[c(-18)] <- Delay(ATKFinal$Delay, CadenaSpec$ATKSpeed)[c(-18)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, CadenaSpec$CoolReduceP, CadenaSpec$CoolReduce)

BuffFinal <- data.frame(CadenaBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, CadenaSpec$CoolReduceP, CadenaSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, CadenaSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(CadenaSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, CadenaSpec$CoolReduceP, CadenaSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * CadenaSpec$SummonedDuration / 100, 0)

DealCycle <- c("Skills", "Time", rownames(CadenaBuff))
CadenaDealCycle <- t(rep(0, length(DealCycle)))
colnames(CadenaDealCycle) <- DealCycle
CadenaDealCycle <- data.frame(CadenaDealCycle)

if(CadenaSpec$CoolTimeReset==24) {
  CadenaTimes <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/cadenatimes.csv"
} else if(CadenaSpec$CoolTimeReset==26) {
  CadenaTimes <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/cadenatimesml.csv"
}
CadenaTimes <- read.csv(CadenaTimes, header=T, row.names=1)

CadenaCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                         Period=c(180), CycleTime=c(360)) {
  BuffSummonedPrior <- c("WeaponBooster", "MapleSoldier", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", 
                         "ShadowdealersElixir", "BlessofGrandisGoddess", "ChainArtsFuryBuff", "SoulContractLink", "ReadyToDie2Stack", "ProfessionalAgentBuff", "Restraint4")
  Times180 <- c(0, 0, 0, 0, 0, 
                1, 0.5, 1, 2, 2, 1, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times180 <- Times180[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
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
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="Restraint4") {
        DealCycle <- DCBuff(DealCycle, "Deal40s", BuffFinal)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      if(BuffList[[1]][i]=="UsefulCombatOrders") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
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
        }
      }
      ## ATKSkills
      DealCycle <- DCATK(DealCycle, "CoolResetATKDummy", ATKFinal)
      EndTime <- c()
      for(i in 3:ncol(DealCycle)) {
        EndTime[i-2] <- DealCycle[nrow(DealCycle), i] - DealCycle[1, i]
      }
      EndTime <- EndTime[EndTime > 0]
      DummyTime <- min((floor((DealCycle$Time[1] + DealCycle$Time[nrow(DealCycle)])/5000) + 1) * 5000 - (DealCycle$Time[1] + DealCycle$Time[nrow(DealCycle)]), 
                       
                       EndTime, 
                       BuffStartTime - (DealCycle$Time[1] + DealCycle$Time[nrow(DealCycle)]))
      DealCycle[1, 2:ncol(DealCycle)] <- DummyTime
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
} 
CadenaATKCollapse <- function(ATKFinal, DealCycle, TimesPerMin, FinaleTimesWithoutFury) {
  TimeList <- c()
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i]=="CoolResetATKDummy") {
      DealCycle$Skills[i] <- paste("CoolResetATKDummy", DealCycle$Time[i+1] - DealCycle$Time[i], sep=" ")
      TimeList <- c(TimeList, DealCycle$Time[i+1] - DealCycle$Time[i])
    }
  }
  TimeList <- unique(TimeList)
  TimeList <- TimeList[order(TimeList)]
  
  for(i in 1:length(TimeList)) {
    Timesdata <- TimesPerMin$TimesPerMin / 60000 * TimeList[i]
    for(j in 1:nrow(TimesPerMin)) {
      for(k in 1:nrow(ATKFinal)) {
        if(rownames(TimesPerMin)[j]==rownames(ATKFinal)[k]) {
          ATKFinal <- rbind(ATKFinal, ATKFinal[k, ])
          rownames(ATKFinal)[nrow(ATKFinal)] <- paste(rownames(ATKFinal)[k], TimeList[i], sep="")
          ATKFinal$AttackTimes[nrow(ATKFinal)] <- ATKFinal$AttackTimes[nrow(ATKFinal)] * Timesdata[j]
        }
      }
    }
    ATKFinal <- rbind(ATKFinal, ATKFinal[rownames(ATKFinal)=="WeaponVarietyFinale", ])
    rownames(ATKFinal)[nrow(ATKFinal)] <- paste("WeaponVarietyFinaleWithoutFury", TimeList[i], sep="")
    ATKFinal$AttackTimes[nrow(ATKFinal)] <- ATKFinal$AttackTimes[rownames(ATKFinal)=="WeaponVarietyFinale"] * (FinaleTimesWithoutFury / 60000 * TimeList[i])
  }
  return(ATKFinal)
}
CadenaAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal) {
  ## ATK Skills (Stroke, Chase, Scimitar, Claw, Wingdagger, WingdaggerExp, Shotgun, Knife, Bomb, Brick, Needlebat, Maelstrom, Crush, Ordnance, OrdnanceSphere, Variety)
  ## ATK Skills (Fury)
  ## ATK Skills (VarietyFinale) 
  ## ATK Skills (Agent)
  for(i in 1:(nrow(DealCycle)-1)) {
    if(DealCycle$Skills[i]=="CoolResetATKDummy") {
      TimeDiff <- DealCycle$Time[i+1] - DealCycle$Time[i]
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsStroke1", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsStroke2", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsChase", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonCuttingScimitar", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonScratchingClaw", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonThrowingWingdagger", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonThrowingWingdaggerExplosion", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonShootingShotgun", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonSlashingKnife", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonReleasingBomb", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonStrikingBrick", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonBittingNeedlebat1", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonBittingNeedlebat2", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("SummonBittingNeedlebat3", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("WeaponVariety", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsCrush", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ADOrdnance", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ADOrdnanceSphere", TimeDiff, sep="")
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsMaelstrom", TimeDiff, sep="")
      if(DealCycle$ChainArtsFuryBuff[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("ChainArtsFury", TimeDiff, sep="")
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("WeaponVarietyFinale", TimeDiff, sep="")
      } else {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("WeaponVarietyFinaleWithoutFury", TimeDiff, sep="")
      }
      if(DealCycle$ProfessionalAgentBuff[i] > 0) {
        DealCycle <- rbind(DealCycle, DealCycle[i, ])
        DealCycle$Skills[nrow(DealCycle)] <- paste("ProfessionalAgent", TimeDiff, sep="")
      }
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  return(DealCycle)
}
      
CadenaDealCycle <- CadenaCycle(CadenaDealCycle, 
                               ATKFinal, 
                               BuffFinal, 
                               SummonedFinal, 
                               CadenaSpec, 
                               180, 360)
CadenaDealCycle <- DealCycleFinal(CadenaDealCycle)
ATKFinal <- CadenaATKCollapse(ATKFinal, CadenaDealCycle, CadenaTimes, CadenaTimes$TimesPerMin2[rownames(CadenaTimes)=="WeaponVarietyFinale"])
CadenaDealCycle <- CadenaAddATK(CadenaDealCycle, ATKFinal, BuffFinal, SummonedFinal)
CadenaDealCycleReduction <- DealCycleReduction(CadenaDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="Cadena") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  CadenaSpecOpt1 <- Optimization1(CadenaDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CadenaSpec, CadenaUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- CadenaSpecOpt1[1, 1:3]
} else {
  CadenaSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
CadenaSpecOpt <- OptDataAdd(CadenaSpec, CadenaSpecOpt1, "Potential", CadenaBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  CadenaSpecOpt2 <- Optimization2(CadenaDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CadenaSpecOpt, CadenaHyperStatBase, CadenaBase$ChrLv, CadenaBase$CRROver)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- CadenaSpecOpt2[1, ]
} else {
  CadenaSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
CadenaSpecOpt <- OptDataAdd(CadenaSpecOpt, CadenaSpecOpt2, "HyperStat", CadenaBase$CRROver, DemonAvenger=F)

CadenaFinalDPM <- DealCalc(CadenaDealCycle, ATKFinal, BuffFinal, SummonedFinal, CadenaSpecOpt, Collapse=F)
CadenaFinalDPMwithMax <- DealCalcWithMaxDMR(CadenaDealCycle, ATKFinal, BuffFinal, SummonedFinal, CadenaSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "Cadena", sum(na.omit(CadenaFinalDPMwithMax)) / (max(CadenaDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "Cadena", sum(na.omit(CadenaFinalDPM)) / (max(CadenaDealCycle$Time) / 60000) - sum(na.omit(CadenaFinalDPMwithMax)) / (max(CadenaDealCycle$Time) / 60000))

CadenaDealRatio <- DealRatio(CadenaDealCycle, CadenaFinalDPMwithMax)

CadenaDealData <- data.frame(CadenaDealCycle$Skills, CadenaDealCycle$Time, CadenaDealCycle$Restraint4, CadenaFinalDPMwithMax)
colnames(CadenaDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "Cadena", Deal_RR(CadenaDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "Cadena", Deal_40s(CadenaDealData))

CadenaSpecMean <- SpecMean("Cadena", CadenaDealCycleReduction, 
                           DealCalcWithMaxDMR(CadenaDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, CadenaSpecOpt), 
                           ATKFinal, BuffFinal, SummonedFinal, CadenaSpecOpt)


## Cadena Without Cool Reset Ability
CadenaSpecOptBDRAB <- CadenaSpecOpt
CadenaSpecOptBDRAB$BDR <- CadenaSpecOptBDRAB$BDR + 20

ATKFinal2 <- data.frame(CadenaATK)
ATKFinal2$Delay[c(-18)] <- Delay(ATKFinal2$Delay, CadenaSpec$ATKSpeed)[c(-18)]
ATKFinal2$CoolTime <- Cooldown(ATKFinal2$CoolTime, ATKFinal2$CoolReduceAvailable, CadenaSpec$CoolReduceP, CadenaSpec$CoolReduce)

CadenaTimes2 <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/cadenatimesabbdr.csv"
CadenaTimes2 <- read.csv(CadenaTimes2, header=T, row.names=1)

DealCycle <- c("Skills", "Time", rownames(CadenaBuff))
CadenaDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(CadenaDealCycle2) <- DealCycle
CadenaDealCycle2 <- data.frame(CadenaDealCycle2)

CadenaDealCycle2 <- CadenaCycle(CadenaDealCycle2, 
                               ATKFinal2, 
                               BuffFinal, 
                               SummonedFinal, 
                               CadenaSpec, 
                               180, 360)
CadenaDealCycle2 <- DealCycleFinal(CadenaDealCycle2)
ATKFinal2 <- CadenaATKCollapse(ATKFinal2, CadenaDealCycle2, CadenaTimes2, CadenaTimes2$TimesPerMin2[rownames(CadenaTimes2)=="WeaponVarietyFinale"])
CadenaDealCycle2 <- CadenaAddATK(CadenaDealCycle2, ATKFinal2, BuffFinal, SummonedFinal)

CadenaABBDR <- DealCalcWithMaxDMR(CadenaDealCycle2, ATKFinal2, BuffFinal, SummonedFinal, CadenaSpecOptBDRAB)
CadenaABBDRDPM <- sum(na.omit(CadenaABBDR)) / (max(CadenaDealCycle2$Time)/ 60000)

print(data.frame(CadenaABBDRDPM=CadenaABBDRDPM))