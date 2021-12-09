## DemonAvenger - Data
## DemonAvenger - Core
DemonAvengerCoreBase <- CoreBuilder(ActSkills=c("DemonFrenzy", "BloodFeast", "DimensionSword", "Revenant",
                                                CommonV("Warrior", "Demon")), 
                                    ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                    UsefulSkills=c("SharpEyes", "CombatOrders", "HyperBody"), 
                                    SpecSet=get(DPMCalcOption$SpecSet), 
                                    VPassiveList=DemonAvengerVPassive, 
                                    VPassivePrior=DemonAvengerVPrior, 
                                    SelfBind=T)

DemonAvengerCore <- MatrixSet(PasSkills=DemonAvengerCoreBase$PasSkills$Skills, 
                              PasLvs=DemonAvengerCoreBase$PasSkills$Lv, 
                              PasMP=DemonAvengerCoreBase$PasSkills$MP, 
                              ActSkills=DemonAvengerCoreBase$ActSkills$Skills, 
                              ActLvs=DemonAvengerCoreBase$ActSkills$Lv, 
                              ActMP=DemonAvengerCoreBase$ActSkills$MP, 
                              UsefulSkills=DemonAvengerCoreBase$UsefulSkills, 
                              UsefulLvs=20, 
                              UsefulMP=0, 
                              SpecSet=get(DPMCalcOption$SpecSet), 
                              SpecialCore=DemonAvengerCoreBase$SpecialCoreUse)



## DemonAvenger - Basic Info
DemonAvengerBase <- JobBase(ChrInfo=ChrInfo, 
                            MobInfo=get(DPMCalcOption$MobSet),
                            SpecSet=get(DPMCalcOption$DemonAvengerSpecSet), 
                            Job="DemonAvenger",
                            CoreData=DemonAvengerCore, 
                            BuffDurationNeeded=0, 
                            AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "DemonAvenger"), 
                            LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "DemonAvenger"), 
                            MonsterLife=get(FindJob(MonsterLifePreSet, "DemonAvenger")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                            Weapon=DesperadoUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 5, 0, 0, get(DPMCalcOption$DemonAvengerSpecSet)$WeaponType)[, 1:16],
                            WeaponType=get(DPMCalcOption$DemonAvengerSpecSet)$WeaponType, 
                            SubWeapon=SubWeapon[rownames(SubWeapon)=="DemonAvengerForceShield", ], 
                            Emblem=Emblem[rownames(Emblem)=="Demon", ], 
                            CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "DemonAvenger")))


## DemonAvenger - Conversion Starforce
ConversionStarForceHP <- c(rep(35, 15), ## 1 ~ 15
                           rep(60, 20), ## 16 ~ 35
                           rep(80, 25), ## 36 ~ 60
                           rep(100, 30), ## 61 ~ 90
                           rep(120, 35), ## 91 ~ 125
                           rep(135, 25), ## 126 ~ 150
                           rep(138, 25), ## 151 ~ 175
                           rep(140, 25), ## 176 ~ 200
                           rep(142, 25), ## 201 ~ 225
                           rep(144, 25), ## 226 ~ 250
                           rep(146, 20), ## 251 ~ 270
                           rep(148, 20), ## 271 ~ 290
                           rep(150, 20), ## 291 ~ 310
                           rep(152, 10), ## 311 ~ 320
                           rep(154, 10), ## 321 ~ 330
                           rep(156, 10) ## 331 ~ 340
)


## DemonAvenger - Passive
SFHP <- ConversionStarForceHP[DPMCalcOption$DemonAvengerSF] * DPMCalcOption$DemonAvengerSF
{option <- factor(c("MainStat"), levels=PSkill)
  value <- c(SFHP / 17.5)
  ConversionStarForce <- data.frame(option, value)
  
  option <- factor(c("CRR"), levels=PSkill)
  value <- c(20)
  DemonicSharpness <- data.frame(option, value)
  
  option <- factor(c("ATK"), levels=PSkill)
  value <- c(40)
  AbyssalRage <- data.frame(option, value)
  
  option <- factor(c("MainStat"), levels=PSkill)
  value <- c(600 / 17.5)
  InnerStrength <- data.frame(option, value)
  
  option <- factor(c("BDR", "ATKSpeed"), levels=PSkill)
  value <- c(30 + DemonAvengerBase$PSkillLv, 1)
  OverwhelmingPower <- data.frame(option, value)
  
  option <- factor(c("IGR"), levels=PSkill)
  value <- c(30 + DemonAvengerBase$PSkillLv)
  DefenseExpertise <- data.frame(option, value)
  
  option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
  value <- c(70 + ceiling(DemonAvengerBase$PSkillLv/2), 50 + DemonAvengerBase$PSkillLv, 8)
  AdvancedDesperadoMastery <- data.frame(option, value)
  
  option <- factor(c("MainStatP"), levels=PSkill)
  value <- c(15)
  MapleSoldierPassive <- data.frame(option, value)
  
  option <- factor(c("ATK"), levels=PSkill)
  value <- c(GetCoreLv(DemonAvengerCore, "Blink"))
  BlinkPassive <- data.frame(option, value)
  
  option <- factor(c("MainStat"), levels=PSkill)
  value <- c(GetCoreLv(DemonAvengerCore, "BodyofSteel") * 50 / 17.5)
  BodyofSteelPassive <- data.frame(option, value)
  
  option <- factor(c("SubStat1"), levels=PSkill)
  value <- c(GetCoreLv(DemonAvengerCore, "RopeConnect"))
  RopeConnectPassive <- data.frame(option, value)}

DemonAvengerPassive <- Passive(list(ConversionStarForce, DemonicSharpness, AbyssalRage, InnerStrength, OverwhelmingPower, DefenseExpertise, AdvancedDesperadoMastery, MapleSoldierPassive, 
                                    BlinkPassive, BodyofSteelPassive, RopeConnectPassive))


## DemonAvenger - Buff
{option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  HP <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  FrenzyCostDummy <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  DiabolicRecoveryDummy <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  RevenantRage <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  RevenantRageDummy <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ExceedStack <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(60, 0, 0, T, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ReleaseOverloadBuff <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ReleaseOverloadFDR <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  DemonFrenzyFDR <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecutionStack <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(0, 1, 0, F, F, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  BloodFeastCharge <- rbind(data.frame(option, value), info)
  
  option <- factor(c("ATKSpeed"), levels=BSkill)
  value <- c(2)
  info <- c(180, 0, 0, T, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  DemonBooster <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(180, 0, 0, T, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  RefractEvil <- rbind(data.frame(option, value), info)
  
  option <- factor(c("MainStatP"), levels=BSkill)
  value <- c(25)
  info <- c(180, 0, 0, T, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  DiabolicRecovery <- rbind(data.frame(option, value), info)
  
  option <- factor(c("IGR"), levels=BSkill)
  value <- c(30 + DemonAvengerBase$SkillLv)
  info <- c(30 + DemonAvengerBase$SkillLv, 0, Delay(870, 2), F, T, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ArmorBreakBuff <- rbind(data.frame(option, value), info)
  
  option <- factor("BDR", levels=BSkill)
  value <- c(5)
  info <- c(120, 120, 0, F, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  DemonicFortitude <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR"), levels=BSkill)
  value <- c(10)
  info <- c(30, 75, 1020, F, F, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  ForbiddenContract <- rbind(data.frame(option, value), info)
  
  Useful <- UsefulSkills(DemonAvengerCore, DemonAvenger=T)
  UsefulSharpEyes <- Useful$UsefulSharpEyes
  UsefulCombatOrders <- Useful$UsefulCombatOrders
  UsefulHyperBody <- Useful$UsefulHyperBody
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(30, 240, 1530, F, T, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  Revenant <- rbind(data.frame(option, value), info)
  
  option <- factor(c("IGR", "FDR"), levels=BSkill)
  value <- c(10 + floor(GetCoreLv(DemonAvengerCore, "AuraWeapon") / 5), ceiling(GetCoreLv(DemonAvengerCore, "AuraWeapon") / 5))
  info <- c(80 + 2 * GetCoreLv(DemonAvengerCore, "AuraWeapon"), 180, 720, F, T, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  AuraWeaponBuff <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=BSkill)
  value <- c()
  info <- c(30 + GetCoreLv(DemonAvengerCore, "CallMastema"), 150, 690, F, T, F, F)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  CallMastema <- rbind(data.frame(option, value), info)
  
  option <- factor(c("FDR"), levels=BSkill)
  value <- c(5 + ceiling(GetCoreLv(DemonAvengerCore, "BlessofIsekaiGoddess")/5))
  info <- c(40, 120, 630, F, T, F, T)
  info <- data.frame(BInfo, info)
  colnames(info) <- c("option", "value")
  BlessofIsekaiGoddess <- rbind(data.frame(option, value), info)}

DemonAvengerBuff <- list(HP=HP, FrenzyCostDummy=FrenzyCostDummy, DiabolicRecoveryDummy=DiabolicRecoveryDummy, RevenantRage=RevenantRage, RevenantRageDummy=RevenantRageDummy, 
                         ExceedStack=ExceedStack, ReleaseOverloadBuff=ReleaseOverloadBuff, ReleaseOverloadFDR=ReleaseOverloadFDR, DemonFrenzyFDR=DemonFrenzyFDR, ExceedExecutionStack=ExceedExecutionStack, 
                         BloodFeastCharge=BloodFeastCharge, 
                         DemonBooster=DemonBooster, RefractEvil=RefractEvil, DiabolicRecovery=DiabolicRecovery, ArmorBreakBuff=ArmorBreakBuff, 
                         DemonicFortitude=DemonicFortitude, ForbiddenContract=ForbiddenContract, 
                         UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, UsefulHyperBody=UsefulHyperBody, 
                         Revenant=Revenant, AuraWeaponBuff=AuraWeaponBuff, CallMastema=CallMastema, BlessofIsekaiGoddess=BlessofIsekaiGoddess, 
                         Restraint4=Restraint4, SoulContractLink=SoulContractLink)
## PetBuff : UsefulSharpEyes, UsefulCombatOrders, UsefulHyperBody, DemonBooster(990ms), RefractEvil(990ms), DiabolicRecovery(990ms) -> Cannot Use Useful Advanced Bless
DemonAvengerBuff <- Buff(DemonAvengerBuff)
DemonAvengerAllTimeBuff <- AllTimeBuff(DemonAvengerBuff)


## DemonAvenger - Union & HyperStat & SoulWeapon
DemonAvengerSpec <- JobSpec(JobBase=DemonAvengerBase, 
                            Passive=DemonAvengerPassive, 
                            AllTimeBuff=DemonAvengerAllTimeBuff, 
                            MobInfo=get(DPMCalcOption$MobSet),
                            SpecSet=get(DPMCalcOption$DemonAvengerSpecSet), 
                            WeaponName="Desperado", 
                            UnionStance=0)

DemonAvengerUnionRemained <- DemonAvengerSpec$UnionRemained
DemonAvengerHyperStatBase <- DemonAvengerSpec$HyperStatBase
DemonAvengerCoolReduceType <- DemonAvengerSpec$CoolReduceType
DemonAvengerSpec <- DemonAvengerSpec$Spec


## DemonAvenger - Spider In Mirror
SIM <- SIMData(GetCoreLv(DemonAvengerCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## DemonAvenger - Attacks
## Hyper : Exceed - Reinforce / Exceed - Reduce Overload / Exceed - Bonus Chance / Shield Chasing - Reinforce / Shield Chasing - Extra Target
{option <- factor(levels=ASkill)
  value <- c()
  info <- c(200, 1, 840, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  BatsSwarm <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$SkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ExceedExecution")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ExceedExecution"))
  info <- c(540 + 8 * DemonAvengerSpec$SkillLv, 4, 900, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecution1 <- rbind(data.frame(option, value), info) ## BDR : Ease Exceed Pain, Exceed - Reinforce
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$SkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ExceedExecution")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ExceedExecution"))
  info <- c(540 + 8 * DemonAvengerSpec$SkillLv, 4, 900, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecution2 <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$SkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ExceedExecution")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ExceedExecution"))
  info <- c(540 + 8 * DemonAvengerSpec$SkillLv, 4, 840, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecution3 <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$SkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ExceedExecution")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ExceedExecution"))
  info <- c(540 + 8 * DemonAvengerSpec$SkillLv, 4, 780, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecution4 <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$SkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ExceedExecution")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ExceedExecution"))
  info <- c(540 + 8 * DemonAvengerSpec$SkillLv, 6, 720, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ExceedExecution5 <- rbind(data.frame(option, value), info)
  
  option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
  value <- c(40, IGRCalc(c(30 + DemonAvengerSpec$PSkillLv, ifelse(GetCoreLv(DemonAvengerCore, "ShieldChasing")>=40, 20, 0))), 2 * GetCoreLv(DemonAvengerCore, "ShieldChasing"))
  info <- c(500 + 10 * DemonAvengerSpec$SkillLv, 2 * 2, 720, 500, 6, T, T, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ShieldChasing <- rbind(data.frame(option, value), info) ## BDR : Defense Expertise, Shield Chasing - Reinforce, ATKSpeed Not Applied
  
  option <- factor(c("IGR", "FDR"), levels=ASkill)
  value <- c(ifelse(GetCoreLv(DemonAvengerCore, "ArmorBreak")>=40, 20, 0), 2 * GetCoreLv(DemonAvengerCore, "ArmorBreak"))
  info <- c(350 + 5 * DemonAvengerSpec$SkillLv, 4, 870, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ArmorBreak <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR", "BDR", "FDR"), levels=ASkill)
  value <- c(ifelse(GetCoreLv(DemonAvengerCore, "EnhancedExceed")>=40, 20, 0), DemonAvengerBase$MonsterLife$FinalATKDMR, 2 * GetCoreLv(DemonAvengerCore, "EnhancedExceed"))
  info <- c(200 + 4 * DemonAvengerSpec$SkillLv, 2 * (0.8 + 0.04 * DemonAvengerSpec$PSkillLv), 0, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  EnhancedExceed <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR", "FDR"), levels=ASkill)
  value <- c(ifelse(GetCoreLv(DemonAvengerCore, "ThousandSword")>=40, 20, 0), 2 * GetCoreLv(DemonAvengerCore, "ThousandSword"))
  info <- c(500, 8, 1800, NA, 8, F, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  ThousandSword <- rbind(data.frame(option, value), info) 
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(0, 0, 0, 2040, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DemonFrenzyDummy <- rbind(data.frame(option, value), info) 
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(300 + 8 * GetCoreLv(DemonAvengerCore, "DemonFrenzy"), 2, 0, 360, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DemonFrenzy <- rbind(data.frame(option, value), info) 
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(500 + 20 * GetCoreLv(DemonAvengerCore, "BloodFeast"), 7, 420, NA, 10, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  BloodFeast1 <- rbind(data.frame(option, value), info) 
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(650 + 26 * GetCoreLv(DemonAvengerCore, "BloodFeast"), 9, 420, NA, 10, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  BloodFeast2 <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR"), levels=ASkill)
  value <- c(100)
  info <- c(800 + 32 * GetCoreLv(DemonAvengerCore, "BloodFeast"), 12, 420, NA, 10, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  BloodFeast3 <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR"), levels=ASkill)
  value <- c(100)
  info <- c(850 + 34 * GetCoreLv(DemonAvengerCore, "DimensionSword"), 8, 660, 3000, 120, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DimensionSword <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR"), levels=ASkill)
  value <- c(100)
  info <- c(300 + 12 * GetCoreLv(DemonAvengerCore, "DimensionSword"), 6, 660, 210, 120, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DimensionSwordFast <- rbind(data.frame(option, value), info) 
  
  option <- factor(c("IGR"), levels=ASkill)
  value <- c(30)
  info <- c(300 + 12 * GetCoreLv(DemonAvengerCore, "Revenant"), 9, 0, NA, 240, T, F, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  RevenantAddATK <- rbind(data.frame(option, value), info) 
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(500 + 20 * GetCoreLv(DemonAvengerCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  AuraWeapon <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(500 + 20 * GetCoreLv(DemonAvengerCore, "CallMastema"), 8, 0, 5280, NA, NA, NA, F) ## FirstATK : 1080ms, ATK Times : Vary by Level
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  MastemaClaw <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(1200 + 48 * GetCoreLv(DemonAvengerCore, "BlessofIsekaiGoddess"), 3, 0, 4000, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  OtherworldEmptiness <- rbind(data.frame(option, value), info)
  
  option <- factor(levels=ASkill)
  value <- c()
  info <- c(0, 0, 0, 1000, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DamageDummy <- rbind(data.frame(option, value), info)}

DemonAvengerATK <- Attack(list(BatsSwarm=BatsSwarm, 
                               ExceedExecution1=ExceedExecution1, ExceedExecution2=ExceedExecution2, ExceedExecution3=ExceedExecution3, ExceedExecution4=ExceedExecution4, ExceedExecution5=ExceedExecution5, 
                               ShieldChasing=ShieldChasing, ArmorBreak=ArmorBreak, EnhancedExceed=EnhancedExceed, ThousandSword=ThousandSword, 
                               DemonFrenzyDummy=DemonFrenzyDummy, DemonFrenzy=DemonFrenzy, BloodFeast1=BloodFeast1, BloodFeast2=BloodFeast2, BloodFeast3=BloodFeast3, 
                               DimensionSword=DimensionSword, DimensionSwordFast=DimensionSwordFast, 
                               RevenantAddATK=RevenantAddATK, AuraWeapon=AuraWeapon, MastemaClaw=MastemaClaw, OtherworldEmptiness=OtherworldEmptiness, DamageDummy=DamageDummy, 
                               SpiderInMirror=SpiderInMirror))


## DemonAvenger - Summoned
DemonAvengerSummoned <- Summoned(list(SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                      SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## DemonAvenger - DealCycle
ATKFinal <- data.frame(DemonAvengerATK)
ATKFinal$Delay[c(-7)] <- Delay(ATKFinal$Delay, DemonAvengerSpec$ATKSpeed)[c(-7)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, DemonAvengerSpec$CoolReduceP, DemonAvengerSpec$CoolReduce)

BuffFinal <- data.frame(DemonAvengerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, DemonAvengerSpec$CoolReduceP, DemonAvengerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, DemonAvengerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(DemonAvengerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, DemonAvengerSpec$CoolReduceP, DemonAvengerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * DemonAvengerSpec$SummonedDuration / 100, 0)


DealCycle <- c("Skills", "Time", rownames(DemonAvengerBuff))
DemonAvengerDealCycle <- t(rep(0, length(DealCycle)))
colnames(DemonAvengerDealCycle) <- DealCycle
DemonAvengerDealCycle <- data.frame(DemonAvengerDealCycle)

DemonAvengerCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                              Period=c(240), CycleTime=c(720), DimensionSwordType=c("Normal", "Fast", "Fusion"), FrenzyStack=c(0, 1, 2), ForbiddenContractUse=c(T, F), 
                              BloodFeastUse=c(T, F), BloodFeastATKUse=c(T, F), Damage=c(T, F)) {
  if(FrenzyStack != 0) {
    BuffSummonedPrior <- c("DemonBooster", "RefractEvil", "DiabolicRecovery", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulHyperBody", "DemonicFortitude", 
                           "ArmorBreakBuff", "CallMastema", "AuraWeaponBuff", "BlessofIsekaiGoddess", "Revenant", "SoulContractLink", "Restraint4")
    Times240 <- c(1, 1, 1, 0, 0, 0, 0, 
                  0, 1, 4/3, 2, 1, 2, 1)
  } else {
    BuffSummonedPrior <- c("DemonBooster", "RefractEvil", "DiabolicRecovery", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulHyperBody", "DemonicFortitude", 
                           "ArmorBreakBuff", "CallMastema", "AuraWeaponBuff", "BlessofIsekaiGoddess", "Revenant", "SoulContractLink", "Restraint4")
    Times240 <- c(1, 1, 1, 0, 0, 0, 0, 
                  0, 1, 4/3, 2, 1, 2, 1)
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100)  - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce * (CycleTime / Period)
  for(i in 1:length(BuffSummonedPrior)) {
    SubTime[i] <- SubTime[i] / ifelse(Times240[i]==0, Inf, Times240[i])
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
  
  if(Damage==T) {
    DealCycle <- DCATK(DealCycle, "DemonFrenzyDummy", ATKFinal)
    DealCycle <- DCATK(DealCycle, "DamageDummy", ATKFinal)
    DealCycle$ExceedStack[2:3] <- 18
    DealCycle$ExceedExecutionStack[2:3] <- 5
  } else {
    DealCycle <- DCATK(DealCycle, "DemonFrenzyDummy", ATKFinal)
    DealCycle$ExceedStack[2] <- 18
    DealCycle$ExceedExecutionStack[2] <- 5
  }
  
  ExecutionATK <- function(DealCycle, ATKFinal) {
    SkillName <- paste("ExceedExecution", DealCycle$ExceedExecutionStack[nrow(DealCycle)], sep="")
    DealCycle <- DCATK(DealCycle, SkillName, ATKFinal)
    return(DealCycle)
  }
  DAStack <- function(DealCycle) {
    ## Exceed Stack
    if(DealCycle$Skills[nrow(DealCycle)]=="ReleaseOverloadBuff") {
      DealCycle$ReleaseOverloadFDR[nrow(DealCycle)] <- floor(25 / 18 * DealCycle$ExceedStack[nrow(DealCycle)-1])
      DealCycle$ExceedStack[nrow(DealCycle)] <- 0
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5")) >= 1) {
      DealCycle$ExceedStack[nrow(DealCycle)] <- min(18, DealCycle$ExceedStack[(nrow(DealCycle)-1)] + 1)
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ThousandSword")) >= 1) {
      DealCycle$ExceedStack[nrow(DealCycle)] <- min(18, DealCycle$ExceedStack[(nrow(DealCycle)-1)] + 5)
    } else {
      DealCycle$ExceedStack[nrow(DealCycle)] <- DealCycle$ExceedStack[nrow(DealCycle)-1]
    }
    
    ## Exceed Execution Stack
    if(DealCycle$Skills[nrow(DealCycle)]=="ReleaseOverloadBuff") {
      DealCycle$ExceedExecutionStack[nrow(DealCycle)] <- floor((DealCycle$ExceedExecutionStack[nrow(DealCycle)-1] - 1) / 2) + 1
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5")) >= 1) {
      DealCycle$ExceedExecutionStack[nrow(DealCycle)] <- min(5, DealCycle$ExceedExecutionStack[nrow(DealCycle)-1] + 1)
    } else {
      DealCycle$ExceedExecutionStack[nrow(DealCycle)] <- DealCycle$ExceedExecutionStack[nrow(DealCycle)-1]
    }
    return(DealCycle)
  }
  
  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="DemonicFortitude") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DAStack(DealCycle)
      } else if(BuffList[[1]][i]=="SoulContractLink") {
        DealCycle <- ExecutionATK(DealCycle, ATKFinal)
        DealCycle <- DAStack(DealCycle)
        DealCycle <- ExecutionATK(DealCycle, ATKFinal)
        DealCycle <- DAStack(DealCycle)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- DAStack(DealCycle)
      if(BuffList[[1]][i]=="ArmorBreakBuff") {
        DealCycle <- DCBuff(DealCycle, "ReleaseOverloadBuff", BuffFinal)
        DealCycle <- DAStack(DealCycle)
      }
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- DAStack(DealCycle)
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
  
  SCCool <- subset(ATKFinal, rownames(ATKFinal)=="ShieldChasing")$CoolTime * 1000
  BFCool <- subset(ATKFinal, rownames(ATKFinal)=="BloodFeast1")$CoolTime * 1000
  FCCool <- subset(BuffFinal, rownames(BuffFinal)=="ForbiddenContract")$CoolTime * 1000
  
  SCRemain <- 0 ; BFRemain <- 0 ; FCRemain <- 0
  
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
          DealCycle <- DAStack(DealCycle)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          BFRemain <- max(0, BFRemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        }
      }
      ## Forbidden Contract
      ## if(FCRemain == 0 & ForbiddenContractUse == T & nrow(subset(DealCycle, DealCycle$Skills=="ForbiddenContract")) < 2 & DealCycle$Revenant[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
      ##  DealCycle <- DCBuff(DealCycle, "ForbiddenContract", BuffFinal)
      ##  DealCycle <- DAStack(DealCycle)
      ##  SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      ##  BFRemain <- max(0, BFRemain - DealCycle$Time[1])
      ##  FCRemain <- max(0, FCCool - DealCycle$Time[1])
      ## }
      ## Release Overload Buff
      if(DealCycle$ReleaseOverloadBuff[nrow(DealCycle)] - DealCycle$Time[1] < 3000 & DealCycle$ExceedStack[nrow(DealCycle)] == 18) {
        DealCycle <- DCBuff(DealCycle, "ReleaseOverloadBuff", BuffFinal)
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        BFRemain <- max(0, BFRemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
      }
      ## Dimension Sword
      else if(nrow(subset(DealCycle, DealCycle$Skills=="DimensionSword")) + nrow(subset(DealCycle, DealCycle$Skills=="DimensionSwordFast")) < nrow(subset(DealCycle, DealCycle$Skills=="SoulContractLink"))) {
        if(DimensionSwordType=="Normal" | DimensionSwordType=="Fusion" & DealCycle$Restraint4[nrow(DealCycle)] - DealCycle$Time[1] <= 0) {
          DealCycle <- DCATK(DealCycle, "DimensionSword", ATKFinal)
          DealCycle <- DAStack(DealCycle)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          BFRemain <- max(0, BFRemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCATK(DealCycle, "DimensionSwordFast", ATKFinal)
          DealCycle <- DAStack(DealCycle)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          BFRemain <- max(0, BFRemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        }
      }
      ## Blood Feast (Start)
      else if(BloodFeastUse==T & BFRemain==0) {
        DealCycle <- DCBuff(DealCycle, "BloodFeastCharge", BuffFinal)
        DealCycle$BloodFeastCharge[nrow(DealCycle)] <- 30000
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        BFRemain <- max(0, 30000 - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
      }
      ## Blood Feast (ATK)
      else if(BloodFeastATKUse==T & DealCycle$BloodFeastCharge[nrow(DealCycle)] - DealCycle$Time[1] < 23000 & DealCycle$BloodFeastCharge[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle <- DCATK(DealCycle, "ThousandSword", ATKFinal)
        DealCycle[1, 2:ncol(DealCycle)] <- 30  ## Cancel
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        BFRemain <- max(0, BFRemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "BloodFeast3", ATKFinal)
        DealCycle$BloodFeastCharge[nrow(DealCycle)] <- 0
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        BFRemain <- max(0, BFCool - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
      }
      ## Shield Chasing 
      else if(SCRemain==0) {
        DealCycle <- DCATK(DealCycle, "ShieldChasing", ATKFinal)
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCCool - DealCycle$Time[1])
        BFRemain <- max(0, BFRemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
      }
      ## Exceed : Execution
      else {
        DealCycle <- ExecutionATK(DealCycle, ATKFinal)
        DealCycle <- DAStack(DealCycle)
        SCRemain <- max(0, SCRemain - DealCycle$Time[1])
        BFRemain <- max(0, BFRemain - DealCycle$Time[1])
        FCRemain <- max(0, FCRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- DAStack(DealCycle)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          BFRemain <- max(0, BFRemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          if(BuffList[[k]][i]=="AuraWeaponBuff" & k==5) {
            DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
            DealCycle <- DAStack(DealCycle)
            SCRemain <- max(0, SCRemain - DealCycle$Time[1])
            BFRemain <- max(0, BFRemain - DealCycle$Time[1])
            FCRemain <- max(0, FCRemain - DealCycle$Time[1])
          }
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- DAStack(DealCycle)
          SCRemain <- max(0, SCRemain - DealCycle$Time[1])
          BFRemain <- max(0, BFRemain - DealCycle$Time[1])
          FCRemain <- max(0, FCRemain - DealCycle$Time[1])
        }
      }
    }
  }
  if(DealCycle$BloodFeastCharge[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
    DealCycle <- DCATK(DealCycle, "ThousandSword", ATKFinal)
    DealCycle[1, 2:ncol(DealCycle)] <- 30  ## Cancel
    DealCycle <- DAStack(DealCycle)
    SCRemain <- max(0, SCRemain - DealCycle$Time[1])
    BFRemain <- max(0, BFRemain - DealCycle$Time[1])
    FCRemain <- max(0, FCRemain - DealCycle$Time[1])
    
    if(DealCycle$BloodFeastCharge[nrow(DealCycle)] - DealCycle$Time[1] > 27000) {
      DealCycle <- DCATK(DealCycle, "BloodFeast1", ATKFinal)
      DealCycle$BloodFeastCharge[nrow(DealCycle)] <- 0
      DealCycle <- DAStack(DealCycle)
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      BFRemain <- max(0, BFCool - DealCycle$Time[1])
      FCRemain <- max(0, FCRemain - DealCycle$Time[1])
    } else if(DealCycle$BloodFeastCharge[nrow(DealCycle)] - DealCycle$Time[1] > 23000) {
      DealCycle <- DCATK(DealCycle, "BloodFeast2", ATKFinal)
      DealCycle$BloodFeastCharge[nrow(DealCycle)] <- 0
      DealCycle <- DAStack(DealCycle)
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      BFRemain <- max(0, BFCool - DealCycle$Time[1])
      FCRemain <- max(0, FCRemain - DealCycle$Time[1])
    } else {
      DealCycle <- DCATK(DealCycle, "BloodFeast3", ATKFinal)
      DealCycle$BloodFeastCharge[nrow(DealCycle)] <- 0
      DealCycle <- DAStack(DealCycle)
      SCRemain <- max(0, SCRemain - DealCycle$Time[1])
      BFRemain <- max(0, BFCool - DealCycle$Time[1])
      FCRemain <- max(0, FCRemain - DealCycle$Time[1])
    }
  }
  
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
DemonAvengerAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, 
                               DimensionSwordType=c("Normal", "Fast", "Fusion"), FrenzyStack=c(0, 1, 2), CallMastemaLevel, FrenzyLevel, BlessofIsekaiGoddessLevel, 
                               Damage=c(T, F), DamageRatio=.21, DamageSubTime=4000, DamageATKTimes=1000) {
  ## Armor Break ATK & Enhanced Exceed & Otherworld Emptiness ATK & Call Mastema ATK
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="ArmorBreakBuff") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "ArmorBreak"
    } else if(sum(DealCycle$Skills[i]==c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5")) >= 1) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "EnhancedExceed"
    } else if(DealCycle$Skills[i]=="BlessofIsekaiGoddess") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "OtherworldEmptiness"
    } else if(DealCycle$Skills[i]=="CallMastema") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "MastemaClaw"
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  
  ## Shield Chasing, Call Mastema, Otherworld Emptiness
  DealCycle <- RepATKCycle(DealCycle, "ShieldChasing", 10, 1000, ATKFinal)
  print("Shield Chasing Done")
  
  DealCycle <- RepATKCycle(DealCycle, "OtherworldEmptiness", 10, 0, ATKFinal)
  print("Otherworld Emptiness Done")
  
  CallMastemaATKTimes <- ceiling((30000 + 1000 * CallMastemaLevel - 1080) / 5280)
  DealCycle <- RepATKCycle(DealCycle, "MastemaClaw", CallMastemaATKTimes, 1080, ATKFinal)
  print("Mastema Claw Done")
  
  
  ## Demension Sword
  if(DimensionSwordType=="Normal" | DimensionSwordType=="Fusion") {
    DealCycle <- RepATKCycle(DealCycle, "DimensionSword", 13, 3000, ATKFinal)
  } 
  if(DimensionSwordType=="Fast" | DimensionSwordType=="Fusion") {
    DealCycle <- RepATKCycle(DealCycle, "DimensionSwordFast", 37, 600, ATKFinal)
  }
  print("Dimension Sword Done")
  
  
  ## Demon Frenzy
  if(FrenzyStack!=0) {
    FrenzyTimes <- ceiling(DealCycle$Time[nrow(DealCycle)] / ATKFinal[rownames(ATKFinal)=="DemonFrenzyDummy", ]$SubTime)
    DealCycle <- RepATKCycle(DealCycle, "DemonFrenzyDummy", FrenzyTimes, 0, ATKFinal)
    
    if(FrenzyStack==2) {
      for(i in 1:nrow(DealCycle)) {
        if(DealCycle$Skills[i]=="DemonFrenzyDummy") {
          DealCycle <- rbind(DealCycle, DealCycle[i, ])
        } 
      }
      DealCycle <- DealCycle[order(DealCycle$Time), ] 
      rownames(DealCycle) <- 1:nrow(DealCycle)
    }
    
    DealCycle[DealCycle$Skills=="DemonFrenzyDummy", ]$Skills <- "DemonFrenzy"
    DealCycle <- RepATKCycle(DealCycle, "DemonFrenzy", 11, 660, ATKFinal)
  }
  print("Demon Frenzy Done")
  
  
  ## Damage Dummy
  if(Damage==T) {
    ATKFinal[rownames(ATKFinal)=="DamageDummy", ]$SubTime <- DamageSubTime
    DealCycle <- RepATKCycle(DealCycle, "DamageDummy", DamageATKTimes, 0, ATKFinal)
  }
  print("Damage Dummy Done")
  
  ## Aura Weapon
  DealCycle <- AWCycle(DealCycle, c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5", 
                                    "ArmorBreak", "ThousandSword", "BloodFeast1", "BloodFeast2", "BloodFeast3"))
  
  print("Aura Weapon Done")
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  print("Spider In Mirror Done")
  
  
  ## HP Control, Revenant Rage
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("OtherworldEmptiness", "MastemaClaw", "ShieldChasing", "DimensionSword", "DimensionSwordFast", "DemonFrenzy", "DemonFrenzyStart", "AuraWeapon", 
                                  "SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait"))>=1) {
      DealCycle$ExceedStack[i] <- DealCycle$ExceedStack[i-1]
    }
  }
  
  FrenzyRestrict <- ifelse(FrenzyLevel == 30, 500000 * 0.02, 500000 * 0.01)
  DealCycle$HP[2] <- 500000
  DealCycle$FrenzyCostDummy[2] <- 1000
  DealCycle$DiabolicRecoveryDummy[2] <- 4000
  HPCostSkills <- c("BloodFeastCharge", "DemonBooster", "RefractEvil", "DiabolicRecovery", "ArmorBreakBuff", "DemonicFortitude", "ForbiddenContract", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulHyperBody", 
                    "Revenant", "AuraWeaponBuff", "CallMastema", "BlessofIsekaiGoddess", "Restraint4", 
                    "BatsSwarmStart", "ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5", "ShieldChasingStart", "ThousandSword", 
                    "DimensionSwordStart", "DimensionSwordFastStart", "SpiderInMirror", "CrestoftheSolar", "DamageDummy")
  HPCost <- c(500000 * 0.01, 200, 900, 900, 1000 + 20 * Spec$SkillLv, 100, 5000, 500000 * 0.05, 500000 * 0.05, 500000 * 0.05, 
              500000 * 0.25, 500000 * 0.1, 500000 * 0.05, 500000 * 0.05, 600, 
              500000 * 0.01, 500000 * 0.04, 500000 * 0.04, 500000 * 0.05, 500000 * 0.05, 500000 * 0.06, 500000 * 0.08, 500000 * 0.15, 
              500000 * 0.2, 500000 * 0.2, 500000 * 0.15, 500000 * 0.15, 500000 * DamageRatio)
  HPCostSkills <- data.frame(Skills=HPCostSkills, Cost=HPCost)
  HPRecoverySkills <- c("BatsSwarm", "ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5", "ShieldChasing", "ArmorBreak", "EnhancedExceed", 
                        "DemonFrenzy", "BloodFeast1", "BloodFeast2", "BloodFeast3", "DimensionSwordFast", "SpiderInMirror") ## Enhanced Exceed : * Prob
  HPRecoverySkills2 <- c("BloodFeast1", "BloodFeast2", "BloodFeast3", "OtherworldEmptiness")
  HPRecovery <- c(500000 * 0.1, 500000 * 0.15, 500000 * 0.25, 500000 * (floor(BlessofIsekaiGoddessLevel/2) + 15) / 100 / 4)
  HPRecoverySkills2 <- data.frame(Skills=HPRecoverySkills2, Recovery=HPRecovery)
  for(i in 3:nrow(DealCycle)) {
    ## HP Cost By Skill
    if(sum(DealCycle$Skills[i]==HPCostSkills$Skills) >= 1 & DealCycle$ForbiddenContract[i] == 0 & DealCycle$Skills[i]!="DamageDummy") {
      DealCycle$HP[i] <- max(1, DealCycle$HP[i-1] - subset(HPCostSkills, HPCostSkills$Skills==DealCycle$Skills[i])$Cost)
    } else if(sum(DealCycle$Skills[i]==HPCostSkills$Skills) >= 1 & DealCycle$ForbiddenContract[i] == 0 & DealCycle$Skills[i]=="DamageDummy") {
      DealCycle$HP[i] <- DealCycle$HP[i-1] - subset(HPCostSkills, HPCostSkills$Skills==DealCycle$Skills[i])$Cost
    } else {
      DealCycle$HP[i] <- DealCycle$HP[i-1]
    }
    
    ## HP Cost By Blood Feast Charge 
    if(DealCycle$Skills[i]=="BloodFeastCharge" & DealCycle$ForbiddenContract[i] == 0 | 
       DealCycle$BloodFeastCharge[i-1] > 0 & DealCycle$BloodFeastCharge[i] > 0 & ceiling(DealCycle$BloodFeastCharge[i-1] / 1000) - ceiling(DealCycle$BloodFeastCharge[i] / 1000) > 0 & DealCycle$ForbiddenContract[i] == 0 & 
       DealCycle$HP[i] > 0) {
      DealCycle$HP[i] <- max(1, DealCycle$HP[i] * 0.97)
    }
    
    ## HP Cost By Demon Frenzy
    DealCycle$FrenzyCostDummy[i] <- DealCycle$FrenzyCostDummy[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1])
    if(DealCycle$FrenzyCostDummy[i] <= 0 & DealCycle$ForbiddenContract[i] == 0) {
      DealCycle$HP[i] <- ifelse(DealCycle$HP[i] >= 150000, max(150000, DealCycle$HP[i] - 6000), DealCycle$HP[i])
      DealCycle$FrenzyCostDummy[i] <- DealCycle$FrenzyCostDummy[i] + 1000
    } else if(DealCycle$FrenzyCostDummy[i] <= 0) {
      DealCycle$FrenzyCostDummy[i] <- DealCycle$FrenzyCostDummy[i] + 1000
    }
    
    ## Revenant Rage
    if(DealCycle$Revenant[i] > 0) {
      DealCycle$RevenantRage[i] <- min(1000000, DealCycle$RevenantRage[i-1] + (DealCycle$HP[i-1] - DealCycle$HP[i]))
    } else if(DealCycle$Revenant[i] > 0) {
      DealCycle$RevenantRage[i] <- DealCycle$RevenantRage[i-1]
    }
    
    if(DealCycle$HP[i] < 1) {
      DealCycle$HP[i] <- 1
    }
    
    ## Revenant Rage Decrease
    if(DealCycle$Skills[i]=="Revenant") {
      DealCycle$RevenantRageDummy[i] <- 1800
    } else if(DealCycle$Revenant[i] > 0) {
      DealCycle$RevenantRageDummy[i] <- DealCycle$RevenantRageDummy[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      if(DealCycle$RevenantRageDummy[i] <= 0) {
        DealCycle$RevenantRage[i] <- DealCycle$RevenantRage[i] * 0.93
        DealCycle$RevenantRageDummy[i] <- DealCycle$RevenantRageDummy[i] + 1800
      }
    }
    
    ## HP Cost By Revenant
    if(DealCycle$Revenant[i-1] > 0 & DealCycle$Revenant[i] == 0) {
      DealCycle$RevenantRageDummy[i] <- 1500 - DealCycle$Revenant[i-1]
      RevenantHPCost <- floor((DealCycle$RevenantRage[i-1] + 5000) / 25)
      print(paste("Revenant HP Cost is", RevenantHPCost * 25))
      DealCycle$RevenantRage[i] <- 25
    } else if(DealCycle$RevenantRage[i-1] > 0 & DealCycle$Revenant[i] == 0) {
      DealCycle$RevenantRageDummy[i] <- DealCycle$RevenantRageDummy[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      if(DealCycle$RevenantRageDummy[i] <= 0) {
        DealCycle$RevenantRage[i] <- DealCycle$RevenantRage[i-1] - 1
        DealCycle$RevenantRageDummy[i] <- DealCycle$RevenantRageDummy[i] + 1500
        DealCycle$HP[i] <- max(1, DealCycle$HP[i] - RevenantHPCost)
      } else {
        DealCycle$RevenantRage[i] <- DealCycle$RevenantRage[i-1]
      }
    } else if(DealCycle$Revenant[i] == 0) {
      DealCycle$RevenantRage[i] <- DealCycle$RevenantRage[i-1]
    }
    
    ## HP Recovery By Absolve Life
    if(sum(DealCycle$Skills[i]==HPRecoverySkills) >= 1) {
      if(DealCycle$HP[i] <= 150000) {
        DealCycle$HP[i] <- min(150000 + FrenzyRestrict, DealCycle$HP[i] + ifelse(DealCycle$Skills[i]=="EnhancedExceed", 
                                                                                 (ceiling((20 - DealCycle$ExceedStack[i]) / 2) + 2) / 100 * 500000 * (0.8 + 0.04 * Spec$PSkillLv), 
                                                                                 ifelse(DealCycle$Skills[i]=="ShieldChasing", 
                                                                                        (ceiling((20 - DealCycle$ExceedStack[i]) / 2) + 2) / 100 * 500000 * 2,
                                                                                        (ceiling((20 - DealCycle$ExceedStack[i]) / 2) + 2) / 100 * 500000)))
      } else {
        DealCycle$HP[i] <- min(500000, DealCycle$HP[i] + ifelse(DealCycle$Skills[i]=="EnhancedExceed", FrenzyRestrict * (0.8 + 0.04 * Spec$PSkillLv), 
                                                                ifelse(DealCycle$Skills[i]=="ShieldChasing", FrenzyRestrict * 2, FrenzyRestrict)))
      }
    } else {
      DealCycle$HP[i] <- DealCycle$HP[i]
    }
    
    ## HP Recovery By Special Skills
    if(sum(DealCycle$Skills[i]==HPRecoverySkills2$Skills) >= 1) {
      if(DealCycle$Skills[i]=="OtherworldEmptiness") {
        if(DealCycle$HP[i] <= 150000) {
          DealCycle$HP[i] <- min(150000 + FrenzyRestrict, DealCycle$HP[i] + subset(HPRecoverySkills2, HPRecoverySkills2$Skills==DealCycle$Skills[i])$Recovery)
        } else {
          DealCycle$HP[i] <- min(500000, DealCycle$HP[i] + min(FrenzyRestrict, subset(HPRecoverySkills2, HPRecoverySkills2$Skills==DealCycle$Skills[i])$Recovery))
        }
      } else {
        DealCycle$HP[i] <- min(500000, DealCycle$HP[i] + subset(HPRecoverySkills2, HPRecoverySkills2$Skills==DealCycle$Skills[i])$Recovery)
      }
    } else {
      DealCycle$HP[i] <- DealCycle$HP[i]
    }
    
    ## HP Recovery By Diabolic Recovery 
    ## SubTime : 6 Sec (Same as Infinity)
    DealCycle$DiabolicRecoveryDummy[i] <- DealCycle$DiabolicRecoveryDummy[i-1] - (DealCycle$Time[i] - DealCycle$Time[i-1])
    if(DealCycle$DiabolicRecoveryDummy[i] <= 0) {
      if(DealCycle$HP[i] <= 150000) {
        DealCycle$HP[i] <- min(150000 + FrenzyRestrict, DealCycle$HP[i] + 25000)
      } else {
        DealCycle$HP[i] <- min(500000, DealCycle$HP[i] + FrenzyRestrict)
      }
      DealCycle$DiabolicRecoveryDummy[i] <- DealCycle$DiabolicRecoveryDummy[i] + 6000
    }
    
    ## HP Recovery By Release Overload
    if(DealCycle$Skills[i] == "ReleaseOverloadBuff") {
      if(DealCycle$HP[i] <= 150000) {
        DealCycle$HP[i] <- min(150000 + FrenzyRestrict, DealCycle$HP[i] + floor(DealCycle$ExceedStack[i-1] / 18 * 500000))
      } else {
        DealCycle$HP[i] <- min(500000, DealCycle$HP[i] + FrenzyRestrict)
      }
    }
  }
  print("HP Control Done")
  
  
  ## Revenant ATK
  RevenantTime <- c(min(subset(DealCycle, DealCycle$Skills=="Revenant")$Time))
  ExecutionStatus <- 0
  RevenantSubTime <- 4020
  BeforeSubTime <- 4020
  SubTimeChanged <- 0
  for(i in 2:(nrow(DealCycle)-1)) {
    if(sum(DealCycle$Skills[i]==c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5"))==1) {
      ExecutionStatus <- 1
    } else if(sum(DealCycle$Skills[i]==c("BatsSwarmStart", "ShieldChasingStart", "ArmorBreak", "ThousandSword", "BloodFeast1", "BloodFeast2", "BloodFeast3", 
                                         "DimensionSwordStart", "DimensionSwordFastStart", "MastemaClawStart", "OtherworldEmptinessStart", "SpiderInMirror",
                                         "ReleaseOverloadBuff", "BloodFeastCharge", "DemonBooster", "RefractEvil", "DiabolicRecovery", "ArmorBreakBuff", "DemonicFortitude", "ForbiddenContract", 
                                         "Revenant", "AuraWeaponBuff", "CallMastema", "BlessofIsekaiGoddess", "SoulContractLink", "Restraint4", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulHyperBody"))==1) {
      ExecutionStatus <- 0
    }
    
    if(DealCycle$Revenant[i] > 0) {
      RevenantSubTime <- 4020 - floor(DealCycle$RevenantRage[i] / 100000) * 360
      SubTimeChanged <- BeforeSubTime != RevenantSubTime
    }
    
    if(DealCycle$Skills[i]=="Revenant") {
      RevenantTime <- c(RevenantTime, DealCycle$Time[i])
      RevenantTime <- unique(RevenantTime)
    } else if(DealCycle$Revenant[i] > 0 & sum(DealCycle$Skills[i]==c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5"))==1 & 
              DealCycle$Time[i] - max(RevenantTime) > RevenantSubTime) {
      RevenantTime <- c(RevenantTime, DealCycle$Time[i])
      BeforeSubTime <- RevenantSubTime
    } else if(DealCycle$Revenant[i] > 0 & DealCycle$Revenant[i+1] > 0 & ExecutionStatus==1 & DealCycle$Time[i+1] - max(RevenantTime) > RevenantSubTime & SubTimeChanged==T) {
      RevenantTime <- c(RevenantTime, max(RevenantTime) + RevenantSubTime)
      ExecutionStatus <- 0
    }
  }
  RevenantStartTime <- subset(DealCycle, DealCycle$Skills=="Revenant")$Time
  DC1 <- DealCycle[1, ]
  for(i in 1:length(RevenantTime)) {
    if(sum(RevenantTime[i]==RevenantStartTime)==0) {
      DC1 <- rbind(DC1, DC1[1, ])
      DC1$Skills[nrow(DC1)] <- "RevenantAddATK"
      DC1$Time[nrow(DC1)] <- RevenantTime[i]
    } 
  }
  DC1 <- DC1[2:nrow(DC1), ]
  DealCycle <- rbind(DealCycle, DC1)
  
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="RevenantAddATK") {
      DealCycle[i, 4:ncol(DealCycle)] <- DealCycle[i-1, 4:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      DealCycle[i, 3] <- DealCycle[i-1, 3]
      for(j in 4:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  print("Revenant ATK Done")
  
  ## Frenzy FDR, Release Overload FDR
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]!="ReleaseOverloadBuff") {
      DealCycle$ReleaseOverloadFDR[i] <- DealCycle$ReleaseOverloadFDR[i-1]
    }
    DealCycle$DemonFrenzyFDR[i] <- min(35, floor((500000 - DealCycle$HP[i]) / 5000 / ifelse(FrenzyLevel < 25, 3, 2)))
  }
  
  ## Dummy Reduction
  ## DealCycle$HP <- 0
  DealCycle$FrenzyCostDummy <- 0
  DealCycle$DiabolicRecoveryDummy <- 0
  ## DealCycle$RevenantRage <- 0
  DealCycle$RevenantRageDummy <- 0
  DealCycle$ExceedStack <- 0
  DealCycle$ExceedExecutionStack <- 0
  DealCycle$BloodFeastCharge <- 0
  
  return(DealCycle)
}

DemonAvengerDealCycle <- DemonAvengerCycle(DemonAvengerDealCycle, 
                                           ATKFinal, 
                                           BuffFinal, 
                                           SummonedFinal, 
                                           DemonAvengerSpec,
                                           240, 720, "Fusion", 1, T, T, T, T)
DemonAvengerDealCycle <- DealCycleFinal(DemonAvengerDealCycle)
DemonAvengerDealCycle <- DemonAvengerAddATK(DemonAvengerDealCycle, 
                                            ATKFinal, 
                                            BuffFinal, 
                                            SummonedFinal, 
                                            DemonAvengerSpec, 
                                            "Fusion", 1, GetCoreLv(DemonAvengerCore, "CallMastema"), GetCoreLv(DemonAvengerCore, "DemonFrenzy"), GetCoreLv(DemonAvengerCore, "BlessofIsekaiGoddess"), 
                                            T, .49, 1000, 35)
DemonAvengerDealCycleReduction <- DealCycleReduction(DemonAvengerDealCycle, c("ReleaseOverloadFDR", "DemonFrenzyFDR"))

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="DemonAvenger") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  DemonAvengerSpecOpt1 <- Optimization1(DemonAvengerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpec, DemonAvengerUnionRemained, 
                                        NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
  PotentialOpt[[Idx1]][Idx2, ] <- DemonAvengerSpecOpt1[1, 1:3]
} else {
  DemonAvengerSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
DemonAvengerSpecOpt <- OptDataAdd(DemonAvengerSpec, DemonAvengerSpecOpt1, "Potential", DemonAvengerBase$CRROver, DemonAvenger=T)

if(DPMCalcOption$Optimization==T) {
  DemonAvengerSpecOpt2 <- DemonAvengerOptimization2(DemonAvengerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, DemonAvengerHyperStatBase, DemonAvengerBase$ChrLv, DemonAvengerBase$CRROver, 
                                                    NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
  HyperStatOpt[[Idx1]][Idx2, c(2:10)] <- DemonAvengerSpecOpt2[1, ]
} else {
  DemonAvengerSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
DemonAvengerSpecOpt <- OptDataAdd(DemonAvengerSpecOpt, DemonAvengerSpecOpt2, "HyperStat", DemonAvengerBase$CRROver, DemonAvenger=T)

DemonAvengerFinalDPM <- DealCalc(DemonAvengerDealCycle, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, Collapse=F, 
                                 NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
DemonAvengerFinalDPMwithMax <- DealCalcWithMaxDMR(DemonAvengerDealCycle, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                                  NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))

set(get(DPMCalcOption$DataName), as.integer(1), "DemonAvenger", sum(na.omit(DemonAvengerFinalDPMwithMax)) / (max(DemonAvengerDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "DemonAvenger", sum(na.omit(DemonAvengerFinalDPM)) / (max(DemonAvengerDealCycle$Time) / 60000) - 
      sum(na.omit(DemonAvengerFinalDPMwithMax)) / (max(DemonAvengerDealCycle$Time) / 60000))

DemonAvengerDealRatio <- DealRatio(DemonAvengerDealCycle, DemonAvengerFinalDPMwithMax)

DemonAvengerDealData <- data.frame(DemonAvengerDealCycle$Skills, DemonAvengerDealCycle$Time, DemonAvengerDealCycle$Restraint4, DemonAvengerFinalDPMwithMax)
colnames(DemonAvengerDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "DemonAvenger", Deal_RR(DemonAvengerDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "DemonAvenger", Deal_40s(DemonAvengerDealData))

DemonAvengerSpecMean <- SpecMean("DemonAvenger", DemonAvengerDealCycleReduction, 
                                 DealCalcWithMaxDMR(DemonAvengerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                                    NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR")), 
                                 ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                 NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))


## Demon Frenzy - 2 Stacks
DealCycle <- c("Skills", "Time", rownames(DemonAvengerBuff))
DemonAvengerDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(DemonAvengerDealCycle2) <- DealCycle
DemonAvengerDealCycle2 <- data.frame(DemonAvengerDealCycle2)

DemonAvengerDealCycle2 <- DemonAvengerCycle(DemonAvengerDealCycle2, 
                                            ATKFinal, 
                                            BuffFinal, 
                                            SummonedFinal, 
                                            DemonAvengerSpec,
                                            240, 720, "Fusion", 2, T, T, T, T)
DemonAvengerDealCycle2 <- DealCycleFinal(DemonAvengerDealCycle2)
DemonAvengerDealCycle2 <- DemonAvengerAddATK(DemonAvengerDealCycle2, 
                                             ATKFinal, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             DemonAvengerSpec, 
                                             "Fusion", 2, GetCoreLv(DemonAvengerCore, "CallMastema"), GetCoreLv(DemonAvengerCore, "DemonFrenzy"), GetCoreLv(DemonAvengerCore, "BlessofIsekaiGoddess"), 
                                             T, .49, 1000, 35)

DemonAvengerFinalDPM2Stack <- DealCalcWithMaxDMR(DemonAvengerDealCycle2, ATKFinal, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                                 NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
Frenzy2StackDPM <- sum(na.omit(DemonAvengerFinalDPM2Stack)) / (max(DemonAvengerDealCycle2$Time)/ 60000)

DemonAvengerDealData2 <- data.frame(DemonAvengerDealCycle2$Skills, DemonAvengerDealCycle2$Time, DemonAvengerDealCycle2$Restraint4, DemonAvengerFinalDPM2Stack)
colnames(DemonAvengerDealData2) <- c("Skills", "Time", "R4", "Deal")

Frenzy2StackRR <- Deal_RR(DemonAvengerDealData2)
Frenzy2Stack40s <- Deal_40s(DemonAvengerDealData2)


## Demon Frenzy - 0 Stacks (+29lv)
DemonAvengerCore2 <- DemonAvengerCore
DemonAvengerCore2[[2]][DemonAvengerCore2[[2]]$Active=="DemonFrenzy", ]$Levels <- 29

{option <- factor(levels=ASkill)
  value <- c()
  info <- c(300 + 8 * GetCoreLv(DemonAvengerCore2, "DemonFrenzy"), 2, 0, 360, NA, NA, NA, F)
  info <- data.frame(AInfo, info)
  colnames(info) <- c("option", "value")
  DemonFrenzy2 <- rbind(data.frame(option, value), info)}
DemonAvengerATK2 <- Attack(list(BatsSwarm=BatsSwarm, 
                                ExceedExecution1=ExceedExecution1, ExceedExecution2=ExceedExecution2, ExceedExecution3=ExceedExecution3, ExceedExecution4=ExceedExecution4, ExceedExecution5=ExceedExecution5, 
                                ShieldChasing=ShieldChasing, ArmorBreak=ArmorBreak, EnhancedExceed=EnhancedExceed, ThousandSword=ThousandSword, 
                                DemonFrenzyDummy=DemonFrenzyDummy, DemonFrenzy=DemonFrenzy2, BloodFeast1=BloodFeast1, BloodFeast2=BloodFeast2, BloodFeast3=BloodFeast3, 
                                DimensionSword=DimensionSword, DimensionSwordFast=DimensionSwordFast, 
                                RevenantAddATK=RevenantAddATK, AuraWeapon=AuraWeapon, MastemaClaw=MastemaClaw, OtherworldEmptiness=OtherworldEmptiness, DamageDummy=DamageDummy, 
                                SpiderInMirror=SpiderInMirror))

ATKFinal2 <- data.frame(DemonAvengerATK2)
ATKFinal2$Delay[c(-7)] <- Delay(ATKFinal2$Delay, DemonAvengerSpec$ATKSpeed)[c(-7)]
ATKFinal2$CoolTime <- Cooldown(ATKFinal2$CoolTime, ATKFinal2$CoolReduceAvailable, DemonAvengerSpec$CoolReduceP, DemonAvengerSpec$CoolReduce)

DealCycle <- c("Skills", "Time", rownames(DemonAvengerBuff))
DemonAvengerDealCycle0 <- t(rep(0, length(DealCycle)))
colnames(DemonAvengerDealCycle0) <- DealCycle
DemonAvengerDealCycle0 <- data.frame(DemonAvengerDealCycle0)

DemonAvengerDealCycle0 <- DemonAvengerCycle(DemonAvengerDealCycle0, 
                                            ATKFinal2, 
                                            BuffFinal, 
                                            SummonedFinal, 
                                            DemonAvengerSpec,
                                            240, 720, "Fusion", 0, T, T, T, T)
DemonAvengerDealCycle0 <- DealCycleFinal(DemonAvengerDealCycle0)
DemonAvengerDealCycle0 <- DemonAvengerAddATK(DemonAvengerDealCycle0, 
                                             ATKFinal2, 
                                             BuffFinal, 
                                             SummonedFinal, 
                                             DemonAvengerSpec, 
                                             "Fusion", 0, GetCoreLv(DemonAvengerCore2, "CallMastema"), GetCoreLv(DemonAvengerCore2, "DemonFrenzy"), GetCoreLv(DemonAvengerCore2, "BlessofIsekaiGoddess"), 
                                             T, .49, 1000, 35)

DemonAvengerFinalDPM0Stack <- DealCalcWithMaxDMR(DemonAvengerDealCycle0, ATKFinal2, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                                 NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
Frenzy0StackDPM <- sum(na.omit(DemonAvengerFinalDPM0Stack)) / (max(DemonAvengerDealCycle0$Time)/ 60000)

DemonAvengerDealData0 <- data.frame(DemonAvengerDealCycle0$Skills, DemonAvengerDealCycle0$Time, DemonAvengerDealCycle0$Restraint4, DemonAvengerFinalDPM0Stack)
colnames(DemonAvengerDealData0) <- c("Skills", "Time", "R4", "Deal")

Frenzy0StackRR <- Deal_RR(DemonAvengerDealData0)
Frenzy0Stack40s <- Deal_40s(DemonAvengerDealData0)


## Demon Frenzy - 1 Stack without Blood Feast (+29lv)
DealCycle <- c("Skills", "Time", rownames(DemonAvengerBuff))
DemonAvengerDealCycle1_off <- t(rep(0, length(DealCycle)))
colnames(DemonAvengerDealCycle1_off) <- DealCycle
DemonAvengerDealCycle1_off <- data.frame(DemonAvengerDealCycle1_off)

DemonAvengerDealCycle1_off <- DemonAvengerCycle(DemonAvengerDealCycle1_off, 
                                                ATKFinal2, 
                                                BuffFinal, 
                                                SummonedFinal, 
                                                DemonAvengerSpec,
                                                240, 720, "Normal", 1, T, T, T, T)
DemonAvengerDealCycle1_off <- DealCycleFinal(DemonAvengerDealCycle1_off)
DemonAvengerDealCycle1_off <- DemonAvengerAddATK(DemonAvengerDealCycle1_off, 
                                                 ATKFinal2, 
                                                 BuffFinal, 
                                                 SummonedFinal, 
                                                 DemonAvengerSpec, 
                                                 "Normal", 1, GetCoreLv(DemonAvengerCore2, "CallMastema"), GetCoreLv(DemonAvengerCore2, "DemonFrenzy"), GetCoreLv(DemonAvengerCore2, "BlessofIsekaiGoddess"), 
                                                 T, .49, 1000, 35)

DemonAvengerFinalDPM1_off <- DealCalcWithMaxDMR(DemonAvengerDealCycle1_off, ATKFinal2, BuffFinal, SummonedFinal, DemonAvengerSpecOpt, 
                                                NotBuffCols=c("ReleaseOverloadFDR", "DemonFrenzyFDR"), NotBuffColOption=c("FDR", "FDR"))
Frenzy1_offDPM <- sum(na.omit(DemonAvengerFinalDPM1_off)) / (max(DemonAvengerDealCycle1_off$Time)/ 60000)

DemonAvengerDealData1_off <- data.frame(DemonAvengerDealCycle1_off$Skills, DemonAvengerDealCycle1_off$Time, DemonAvengerDealCycle1_off$Restraint4, DemonAvengerFinalDPM1_off)
colnames(DemonAvengerDealData1_off) <- c("Skills", "Time", "R4", "Deal")

Frenzy1_offRR <- Deal_RR(DemonAvengerDealData1_off)
Frenzy1_off40s <- Deal_40s(DemonAvengerDealData1_off)


print(list(Frenzy2Stack=data.frame(Frenzy2StackDPM=Frenzy2StackDPM, Frenzy2StackRR=Frenzy2StackRR, Frenzy2Stack40s=Frenzy2Stack40s), 
           Frenzy0Stack=data.frame(Frenzy0StackDPM=Frenzy0StackDPM, Frenzy0StackRR=Frenzy0StackRR, Frenzy0Stack40s=Frenzy0Stack40s), 
           Frenzy1Stack29Lv=data.frame(Frenzy1_offDPM=Frenzy1_offDPM, Frenzy1_offRR=Frenzy1_offRR, Frenzy1_off40s=Frenzy1_off40s)))