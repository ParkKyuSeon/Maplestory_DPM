## DemonSlayer - VMatrix
DemonSlayerCoreBase <- CoreBuilder(ActSkills=c("DemonAwakening", "Jormungand", "Orthros", "DemonBane",
                                               CommonV("Warrior", "Demon")), 
                                   ActSkillsLv=c(25, 25, 25, 25, 25, 1, 25, 25, 25), 
                                   UsefulSkills=c("SharpEyes", "CombatOrders"), 
                                   SpecSet=get(DPMCalcOption$SpecSet), 
                                   VPassiveList=DemonSlayerVPassive, 
                                   VPassivePrior=DemonSlayerVPrior, 
                                   SelfBind=T)

DemonSlayerCore <- MatrixSet(PasSkills=DemonSlayerCoreBase$PasSkills$Skills, 
                             PasLvs=DemonSlayerCoreBase$PasSkills$Lv, 
                             PasMP=DemonSlayerCoreBase$PasSkills$MP, 
                             ActSkills=DemonSlayerCoreBase$ActSkills$Skills, 
                             ActLvs=DemonSlayerCoreBase$ActSkills$Lv, 
                             ActMP=DemonSlayerCoreBase$ActSkills$MP, 
                             UsefulSkills=DemonSlayerCoreBase$UsefulSkills, 
                             UsefulLvs=20, 
                             UsefulMP=0, 
                             SpecSet=get(DPMCalcOption$SpecSet), 
                             SpecialCore=DemonSlayerCoreBase$SpecialCoreUse)


## DemonSlayer - Basic Info
DemonSlayerBase <- JobBase(ChrInfo=ChrInfo, 
                           MobInfo=get(DPMCalcOption$MobSet),
                           SpecSet=get(DPMCalcOption$SpecSet), 
                           Job="DemonSlayer",
                           CoreData=DemonSlayerCore, 
                           BuffDurationNeeded=0, 
                           AbilList=FindJob(get(paste(DPMCalcOption$SpecSet, "Ability", sep="")), "DemonSlayer"), 
                           LinkList=FindJob(get(paste(DPMCalcOption$SpecSet, "Link", sep="")), "DemonSlayer"), 
                           MonsterLife=get(FindJob(MonsterLifePreSet, "DemonSlayer")[DPMCalcOption$MonsterLifeLevel][1, 1]), 
                           Weapon=WeaponUpgrade(1, DPMCalcOption$WeaponSF, 4, 0, 0, 0, 0, 3, 0, 0, "Hammer", get(DPMCalcOption$SpecSet)$WeaponType)[, 1:16],
                           WeaponType=get(DPMCalcOption$SpecSet)$WeaponType, 
                           SubWeapon=SubWeapon[rownames(SubWeapon)=="DemonSlayerForceShield", ], 
                           Emblem=Emblem[rownames(Emblem)=="Demon", ], 
                           CoolReduceHat=as.logical(FindJob(get(paste(DPMCalcOption$SpecSet, "CoolReduceHat", sep="")), "DemonSlayer")))


## DemonSlayer - Passive
{option <- factor(c("BDR"), levels=PSkill)
value <- c(1)
DeathCurse <- data.frame(option, value)

option <- factor(c("MainStat", "SubStat1"), levels=PSkill)
value <- c(30, 30)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK", "CRR"), levels=PSkill)
value <- c(50, 20)
Outrage <- data.frame(option, value)

option <- factor(c("FDR", "CRR"), levels=PSkill)
value <- c(15, 15)
EvilTorture <- data.frame(option, value)

option <- factor(c("FDR", "ATKSpeed"), levels=PSkill)
value <- c(25, 1)
Concentration <- data.frame(option, value)

option <- factor(c("IGR"), levels=PSkill)
value <- c(30 + DemonSlayerBase$SkillLv)
DarkBindPassive <- data.frame(option, value)

option <- factor(c("Mastery", "ATK", "CDMR"), levels=PSkill)
value <- c(70 + ceiling(DemonSlayerBase$PSkillLv/2), 50 + DemonSlayerBase$PSkillLv, 15 + floor(DemonSlayerBase$PSkillLv/3))
AdvancedWeaponMastery <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(GetCoreLv(DemonSlayerCore, "BodyofSteel"))
BodyofSteelPassive <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(GetCoreLv(DemonSlayerCore, "Blink"))
BlinkPassive <- data.frame(option, value)}

DemonSlayerPassive <- Passive(list(DeathCurse, PhysicalTraining, Outrage, EvilTorture, Concentration, DarkBindPassive, AdvancedWeaponMastery, 
                                   BodyofSteelPassive, BlinkPassive))


## DemonSlayer - Buff
{option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DF <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(0, 1, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DFAbsorb <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(4, 0, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DFMaxForce <- rbind(data.frame(option, value), info)

option <- factor("ATKSpeed", levels=BSkill)
value <- c(2)
info <- c(180, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DemonBooster <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(180 + 12 * DemonSlayerBase$SkillLv, NA, 810, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
VampiricTouch <- rbind(data.frame(option, value), info)

option <- factor("MainStat", levels=BSkill)
value <- c(floor((DemonSlayerBase$ChrLv * 5 + 18) * (0.15 + 0.01 * ceiling(DemonSlayerBase$SkillLv/2))))
info <- c(900 + 30 * DemonSlayerBase$SkillLv, NA, 0, T, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
MapleSoldier <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(30 + DemonSlayerBase$SkillLv)
info <- c(180 + 4 * DemonSlayerBase$SkillLv, 90 + 2 * DemonSlayerBase$SkillLv, 1680, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
Metamorphosis <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(50 + 10 * ceiling(DemonSlayerBase$SkillLv/5), 200 - DemonSlayerBase$SkillLv, 990, T, T, T, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfinityForce <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(4, 0, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
InfinityForceCoolReduce <- rbind(data.frame(option, value), info)

option <- factor("IGR", levels=BSkill)
value <- c(15)
info <- c(20, 21, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DevilCryDebuff <- rbind(data.frame(option, value), info)

option <- factor("FDR", levels=BSkill)
value <- c(10)
info <- c(4, 10, 0, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
RemainTimeReinforce <- rbind(data.frame(option, value), info)

option <- factor("AddATKRate", levels=BSkill)
value <- c(90)
info <- c(60, NA, 750, F, NA, NA, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlueBlood <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(120, NA, 0, F, NA, NA, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlueBloodCooldown <- rbind(data.frame(option, value), info)

option <- factor("BDR", levels=BSkill)
value <- c(5)
info <- c(120, 120, 0, F, F, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DemonicFortitude <- rbind(data.frame(option, value), info)

Useful <- UsefulSkills(DemonSlayerCore)
UsefulSharpEyes <- Useful$UsefulSharpEyes
UsefulCombatOrders <- Useful$UsefulCombatOrders
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  UsefulAdvancedBless <- Useful$UsefulAdvancedBless
}

option <- factor(c("CRR"), levels=BSkill)
value <- c(50 + floor(GetCoreLv(DemonSlayerCore, "DemonAwakening")/2))
info <- c(35 + GetCoreLv(DemonSlayerCore, "DemonAwakening"), 120, 870, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
DemonAwakening <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(40, 120, 510, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
OrthrosBuff <- rbind(data.frame(option, value), info)

option <- factor(c("IGR", "FDR"), levels=BSkill)
value <- c(10 + floor(GetCoreLv(DemonSlayerCore, "AuraWeapon")/5), ceiling(GetCoreLv(DemonSlayerCore, "AuraWeapon")/5))
info <- c(80 + 2 * GetCoreLv(DemonSlayerCore, "AuraWeapon"), 180, 720, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
AuraWeaponBuff <- rbind(data.frame(option, value), info)

option <- factor(levels=BSkill)
value <- c()
info <- c(30 + GetCoreLv(DemonSlayerCore, "CallMastema"), 150, 690, F, T, F, F)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
CallMastema <- rbind(data.frame(option, value), info)

option <- factor(c("FDR"), levels=BSkill)
value <- c(5 + ceiling(GetCoreLv(DemonSlayerCore, "BlessofIsekaiGoddess")/5))
info <- c(40, 120, 630, F, T, F, T)
info <- data.frame(BInfo, info)
colnames(info) <- c("option", "value")
BlessofIsekaiGoddess <- rbind(data.frame(option, value), info)}

DemonSlayerBuff <- list(DF=DF, DFAbsorb=DFAbsorb, DFMaxForce=DFMaxForce, DemonBooster=DemonBooster, VampiricTouch=VampiricTouch, MapleSoldier=MapleSoldier, Metamorphosis=Metamorphosis, 
                        InfinityForce=InfinityForce, InfinityForceCoolReduce=InfinityForceCoolReduce, 
                        DevilCryDebuff=DevilCryDebuff, RemainTimeReinforce=RemainTimeReinforce, BlueBlood=BlueBlood, BlueBloodCooldown=BlueBloodCooldown, DemonicFortitude=DemonicFortitude, 
                        UsefulSharpEyes=UsefulSharpEyes, UsefulCombatOrders=UsefulCombatOrders, DemonAwakening=DemonAwakening, OrthrosBuff=OrthrosBuff, AuraWeaponBuff=AuraWeaponBuff, 
                        CallMastema=CallMastema, BlessofIsekaiGoddess=BlessofIsekaiGoddess, SoulContractLink=SoulContractLink, Restraint4=Restraint4)
## Petbuff : DemonBooster(990ms), MapleSoldier(0ms), UsefulSharpEyes(900ms), UsefulCombatOrders(1500ms), (UsefulAdvancedBless)
## Metamorphosis Pet Buff Unavailable
if(sum(names(Useful)=="UsefulAdvancedBless") >= 1) {
  DemonSlayerBuff[[length(DemonSlayerBuff)+1]] <- UsefulAdvancedBless
  names(DemonSlayerBuff)[[length(DemonSlayerBuff)]] <- "UsefulAdvancedBless"
}
DemonSlayerBuff <- Buff(DemonSlayerBuff)
DemonSlayerAllTimeBuff <- AllTimeBuff(DemonSlayerBuff)


## DemonSlayer - Spec
DemonSlayerSpec <- JobSpec(JobBase=DemonSlayerBase, 
                           Passive=DemonSlayerPassive, 
                           AllTimeBuff=DemonSlayerAllTimeBuff, 
                           MobInfo=get(DPMCalcOption$MobSet), 
                           SpecSet=get(DPMCalcOption$SpecSet), 
                           WeaponName="Hammer", 
                           UnionStance=0,
                           NotCRR100=T)

DemonSlayerUnionRemained <- DemonSlayerSpec$UnionRemained
DemonSlayerHyperStatBase <- DemonSlayerSpec$HyperStatBase
DemonSlayerCoolReduceType <- DemonSlayerSpec$CoolReduceType
DemonSlayerSpec <- DemonSlayerSpec$Spec


## DemonSlayer - Spider In Mirror
SIM <- SIMData(GetCoreLv(DemonSlayerCore, "SpiderInMirror"))
SpiderInMirror <- SIM$SpiderInMirror
SpiderInMirrorStart <- SIM$SpiderInMirrorStart
SpiderInMirror1 <- SIM$SpiderInMirror1
SpiderInMirror2 <- SIM$SpiderInMirror2
SpiderInMirror3 <- SIM$SpiderInMirror3
SpiderInMirror4 <- SIM$SpiderInMirror4
SpiderInMirror5 <- SIM$SpiderInMirror5
SpiderInMirrorWait <- SIM$SpiderInMirrorWait


## DemonSlayer - Attacks
## Hyper : Demon Impact - Reinforce / Bonus Attack, Demon Slash - Reduce Force / Reinforce / RemainTime Reinforce
{option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(60, ifelse(GetCoreLv(DemonSlayerCore, "DemonSlash")>=40, 20, 0), FDRCalc(c(30, 10, 2 * GetCoreLv(DemonSlayerCore, "DemonSlash"))))
info <- c(190, 2, 510, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonSlash <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(110, IGRCalc(c(50, ifelse(GetCoreLv(DemonSlayerCore, "DemonSlash")>=40, 20, 0))), FDRCalc(c(30, 10, 2 * GetCoreLv(DemonSlayerCore, "DemonSlash"))))
info <- c(680, 3, 510, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AwakeningSlash1 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(110, IGRCalc(c(50, ifelse(GetCoreLv(DemonSlayerCore, "DemonSlash")>=40, 20, 0))), FDRCalc(c(30, 10, 2 * GetCoreLv(DemonSlayerCore, "DemonSlash"))))
info <- c(680, 3, 510, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AwakeningSlash2 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(110, IGRCalc(c(50, ifelse(GetCoreLv(DemonSlayerCore, "DemonSlash")>=40, 20, 0))), FDRCalc(c(30, 10, 2 * GetCoreLv(DemonSlayerCore, "DemonSlash"))))
info <- c(780, 3, 450, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AwakeningSlash3 <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(110, IGRCalc(c(50, ifelse(GetCoreLv(DemonSlayerCore, "DemonSlash")>=40, 20, 0))), FDRCalc(c(30, 10, 2 * GetCoreLv(DemonSlayerCore, "DemonSlash"))))
info <- c(880, 3, 450, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AwakeningSlash4 <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "BDR", "IGR", "FDR"), levels=ASkill)
value <- c(100, 60 + DemonSlayerSpec$SkillLv, IGRCalc(c(30 + ceiling(DemonSlayerSpec$SkillLv/3), ifelse(GetCoreLv(DemonSlayerCore, "DemonImpact")>=40, 20, 0))), 2 * GetCoreLv(DemonSlayerCore, "DemonImpact"))
info <- c(460 + 4 * DemonSlayerSpec$SkillLv, 7, 870, NA, 0, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonImpact <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR", "FDR"), levels=ASkill)
value <- c(ifelse(GetCoreLv(DemonSlayerCore, "DevilCry")>=20, 5, 0), ifelse(GetCoreLv(DemonSlayerCore, "DevilCry")>=40, 20, 0), 2 * GetCoreLv(DemonSlayerCore, "DevilCry"))
info <- c(515 + 5 * DemonSlayerSpec$SkillLv, 7, 990, NA, 14, T, T, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DevilCry <- rbind(data.frame(option, value), info)

option <- factor(c("BDR", "IGR", "FDR"), levels=ASkill)
value <- c(50, IGRCalc(c(50, ifelse(GetCoreLv(DemonSlayerCore, "Cerberus")>=40, 20, 0))), 2 * GetCoreLv(DemonSlayerCore, "Cerberus"))
info <- c(450, 6, 900, NA, 5, F, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Cerberus <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 50)
info <- c(850 + 34 * GetCoreLv(DemonSlayerCore, "Jormungand"), 12, 810, 1080, 120 - floor(GetCoreLv(DemonSlayerCore, "Jormungand")/2), T, F, F) ## StartATK : 1980ms, Hits : Vary by Level
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
Jormungand <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 50)
info <- c(900 + 36 * GetCoreLv(DemonSlayerCore, "Jormungand"), 15, 0, NA, 120 - floor(GetCoreLv(DemonSlayerCore, "Jormungand")/2), T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
JormungandLast <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 50)
info <- c(400 + 16 * GetCoreLv(DemonSlayerCore, "Orthros"), 12, 0, NA, 0, T, F, F) 
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OrthrosNemea <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(100, 50)
info <- c(900 + 36 * GetCoreLv(DemonSlayerCore, "Orthros"), 10, 0, NA, 0, T, F, F) 
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OrthrosGeryon <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(0, 0, 240, NA, 240, T, F, F) ## StartATK : 240ms, 16 Hits(Check Needed)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBanePre <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(325 + 13 * GetCoreLv(DemonSlayerCore, "DemonBane"), 6, 240, NA, 240, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBaneTick <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(325 + 13 * GetCoreLv(DemonSlayerCore, "DemonBane"), 6, 4000 - 240 * 16, NA, 240, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBaneEnd <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(0, 0, 600, NA, 240, T, F, F) ## StartATK : 600ms, 21 Hits(Check Needed)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBaneLastPre <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(650 + 26 * GetCoreLv(DemonSlayerCore, "DemonBane"), 7, 120, NA, 240, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBaneLastTick <- rbind(data.frame(option, value), info)

option <- factor(c("CRR", "IGR"), levels=ASkill)
value <- c(50, 30)
info <- c(650 + 26 * GetCoreLv(DemonSlayerCore, "DemonBane"), 7, 0, NA, 240, T, F, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
DemonBaneLastEnd <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(DemonSlayerCore, "AuraWeapon"), 6, 0, NA, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
AuraWeapon <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(500 + 20 * GetCoreLv(DemonSlayerCore, "CallMastema"), 8, 0, 5280, NA, NA, NA, F) ## FirstATK : 1080ms, ATK Times : Vary by Level
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
MastemaClaw <- rbind(data.frame(option, value), info)

option <- factor(levels=ASkill)
value <- c()
info <- c(1200 + 48 * GetCoreLv(DemonSlayerCore, "BlessofIsekaiGoddess"), 3, 0, 4000, NA, NA, NA, F)
info <- data.frame(AInfo, info)
colnames(info) <- c("option", "value")
OtherworldEmptiness <- rbind(data.frame(option, value), info)}

DemonSlayerATK <- Attack(list(DemonSlash=DemonSlash, AwakeningSlash1=AwakeningSlash1, AwakeningSlash2=AwakeningSlash2, AwakeningSlash3=AwakeningSlash3, AwakeningSlash4=AwakeningSlash4, 
                              DemonImpact=DemonImpact, DevilCry=DevilCry, Cerberus=Cerberus, Jormungand=Jormungand, JormungandLast=JormungandLast, OrthrosNemea=OrthrosNemea, OrthrosGeryon=OrthrosGeryon, 
                              DemonBanePre=DemonBanePre, DemonBaneTick=DemonBaneTick, DemonBaneEnd=DemonBaneEnd, DemonBaneLastPre=DemonBaneLastPre, DemonBaneLastTick=DemonBaneLastTick, DemonBaneLastEnd=DemonBaneLastEnd,
                              AuraWeapon=AuraWeapon, MastemaClaw=MastemaClaw, OtherworldEmptiness=OtherworldEmptiness, SpiderInMirror=SpiderInMirror))


## DemonSlayer - Summoned
{option <- factor(c("IGR", "FDR"), levels=SSkill)
value <- c(ifelse(GetCoreLv(DemonSlayerCore, "Metamorphosis")>=40, 20, 0), 2 * GetCoreLv(DemonSlayerCore, "Metamorphosis"))
info <- c(250 + 5 * DemonSlayerSpec$SkillLv, 1, 0, 500, (180 + 4 * DemonSlayerBase$SkillLv) * (100 + DemonSlayerSpec$BuffDuration) / 100, 0, F, NA, NA, F)
info <- data.frame(SInfo, info)
colnames(info) <- c("option", "value")
MetamorphosisATK <- rbind(data.frame(option, value), info)}

DemonSlayerSummoned <- Summoned(list(MetamorphosisATK=MetamorphosisATK, SpiderInMirrorStart=SpiderInMirrorStart, SpiderInMirror1=SpiderInMirror1, SpiderInMirror2=SpiderInMirror2, SpiderInMirror3=SpiderInMirror3, 
                                     SpiderInMirror4=SpiderInMirror4, SpiderInMirror5=SpiderInMirror5, SpiderInMirrorWait=SpiderInMirrorWait))


## DemonSlayer - DealCycle & Deal Calculation
ATKFinal <- data.frame(DemonSlayerATK)
ATKFinal$Delay[c(-9, -13:-18)] <- Delay(ATKFinal$Delay, DemonSlayerSpec$ATKSpeed)[c(-9, -13:-18)]
ATKFinal$CoolTime <- Cooldown(ATKFinal$CoolTime, ATKFinal$CoolReduceAvailable, DemonSlayerSpec$CoolReduceP, DemonSlayerSpec$CoolReduce)

BuffFinal <- data.frame(DemonSlayerBuff)
BuffFinal$CoolTime <- Cooldown(BuffFinal$CoolTime, BuffFinal$CoolReduceAvailable, DemonSlayerSpec$CoolReduceP, DemonSlayerSpec$CoolReduce)
BuffFinal$Duration <- BuffFinal$Duration + BuffFinal$Duration * ifelse(BuffFinal$BuffDurationAvailable==T, DemonSlayerSpec$BuffDuration / 100, 0) +
  ifelse(BuffFinal$ServerLag==T, General$General$Serverlag, 0)

SummonedFinal <- data.frame(DemonSlayerSummoned)
SummonedFinal$CoolTime <- Cooldown(SummonedFinal$CoolTime, SummonedFinal$CoolReduceAvailable, DemonSlayerSpec$CoolReduceP, DemonSlayerSpec$CoolReduce)
SummonedFinal$Duration <- SummonedFinal$Duration + ifelse(SummonedFinal$SummonedDurationAvailable==T, SummonedFinal$Duration * DemonSlayerSpec$SummonedDuration / 100, 0)


## DemonSlayer - Delay Skip Structure
DemonSlayerSkipATK <- matrix(rep(F, nrow(ATKFinal) * (nrow(ATKFinal)+1)), nrow=nrow(ATKFinal), ncol=nrow(ATKFinal)+1)
DemonSlayerSkipATK <- data.frame(DemonSlayerSkipATK, row.names=c(rownames(ATKFinal)))
colnames(DemonSlayerSkipATK) <- c(rownames(ATKFinal), "SkippedDelay")

DemonSlayerSkipATK$AwakeningSlash2 <- c(F, T, rep(F, 20))
DemonSlayerSkipATK$AwakeningSlash3 <- c(F, F, T, rep(F, 19))
DemonSlayerSkipATK$SkippedDelay <- c(0, Delay(330, DemonSlayerSpec$ATKSpeed), Delay(330, DemonSlayerSpec$ATKSpeed), rep(0, 19))
DemonSlayerSkipATK <- subset(DemonSlayerSkipATK, DemonSlayerSkipATK$SkippedDelay>0)

ATKFinal <- AddATKRateSkills("BlueBlood", BuffFinal, ATKFinal, c("DemonSlash", "AwakeningSlash1", "AwakeningSlash2", "AwakeningSlash3", "AwakeningSlash4", 
                                                                 "DemonImpact", "DevilCry", "Cerberus", "DemonBaneTick", "DemonBaneEnd", "DemonBaneLastTick", "DemonBaneLastEnd", "AuraWeapon"))
SummonedFinal <- AddATKRateSkills("BlueBlood", BuffFinal, SummonedFinal, c("MetamorphosisATK"))

DealCycle <- c("Skills", "Time", rownames(DemonSlayerBuff))
DemonSlayerDealCycle <- t(rep(0, length(DealCycle)))
colnames(DemonSlayerDealCycle) <- DealCycle
DemonSlayerDealCycle <- data.frame(DemonSlayerDealCycle)

DemonSlayerCycle <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, SkipStructure, 
                             Period=240, CycleTime=240, AwakeningOffSlash=T) {
  BuffSummonedPrior <- c("DemonBooster", "UsefulSharpEyes", "UsefulCombatOrders", "UsefulAdvancedBless", "DemonicFortitude", 
                         "CallMastema", "InfinityForce", "VampiricTouch", "Metamorphosis", "BlueBlood", "AuraWeaponBuff", "BlessofIsekaiGoddess", "DemonAwakening", "OrthrosBuff", "SoulContractLink", "Restraint4")
  Times240 <- c(0, 0, 0, 0, 0, 
                1, 1, 1, 1, 4, 1, 2, 2, 2, 2, 1)
  if(nrow(BuffFinal[rownames(BuffFinal)=="UsefulAdvancedBless", ]) == 0) {
    Times240 <- Times240[BuffSummonedPrior!="UsefulAdvancedBless"]
    BuffSummonedPrior <- BuffSummonedPrior[BuffSummonedPrior!="UsefulAdvancedBless"]
  }
  
  SubTime <- rep(Period * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce, length(BuffSummonedPrior))
  TotalTime <- CycleTime * ((100 - Spec$CoolReduceP) / 100) - Spec$CoolReduce
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
  
  DFAbsorb <- data.frame(Skills=c("DemonSlash", "AwakeningSlash1", "AwakeningSlash2", "AwakeningSlash3", "AwakeningSlash4", "Cerberus", "OrthrosNemea", "OrthrosGeryon"), 
                         Absorb=c(9.25, 9.25, 9.25, 9.25, 9.25, 50, 8, 12))
  DFCost <- data.frame(Skills=c("DemonImpact", "DevilCry", "Jormungand", "DemonBanePre", "VampiricTouch", "Metamorphosis", "InfinityForce", "BlueBlood", "DemonAwakening"), 
                       Cost=c(7, 24, 48, 48, 24, 32, 80, 24, 80))
  DFBBLogic <- function(DealCycle, DFAbsorb, DFCost) {
    if(sum(DealCycle$Skills[nrow(DealCycle)]==DFAbsorb$Skills)==1) {
      Absorb <- subset(DFAbsorb, DFAbsorb$Skills==DealCycle$Skills[nrow(DealCycle)])$Absorb
      DealCycle$DF[nrow(DealCycle)] <- min(170, DealCycle$DF[nrow(DealCycle)-1] + Absorb)
      if(DealCycle$BlueBloodCooldown[nrow(DealCycle)] - DealCycle$Time[1] > 0) {
        DealCycle$DFAbsorb[nrow(DealCycle)] <- DealCycle$DFAbsorb[nrow(DealCycle)-1] + Absorb
        if(DealCycle$DFAbsorb[nrow(DealCycle)]>=50) {
          DealCycle$BlueBloodCooldown[nrow(DealCycle)] <- max(0, DealCycle$BlueBloodCooldown[nrow(DealCycle)] - 3000)
          DealCycle$DFAbsorb[nrow(DealCycle)] <- DealCycle$DFAbsorb[nrow(DealCycle)] - 50
        }
      } else {
        DealCycle$DFAbsorb[nrow(DealCycle)] <- 0
      }
    } else if(sum(DealCycle$Skills[nrow(DealCycle)]==DFCost$Skills)==1) {
      Cost <- ifelse(DealCycle$InfinityForce[nrow(DealCycle)] > 0, 0, subset(DFCost, DFCost$Skills==DealCycle$Skills[nrow(DealCycle)])$Cost)
      Cost <- ifelse(DealCycle$Skills[nrow(DealCycle)]=="InfinityForce", subset(DFCost, DFCost$Skills==DealCycle$Skills[nrow(DealCycle)])$Cost, Cost)
      DealCycle$DF[nrow(DealCycle)] <- DealCycle$DF[nrow(DealCycle)-1] - Cost
      if(DealCycle$DF[nrow(DealCycle)] < 0) {
        print(nrow(DealCycle))
        warning("Unavailable DealCycle")
      }
      DealCycle$DFAbsorb[nrow(DealCycle)] <- DealCycle$DFAbsorb[nrow(DealCycle)-1]
    } else {
      DealCycle$DF[nrow(DealCycle)] <- DealCycle$DF[nrow(DealCycle)-1]
      DealCycle$DFAbsorb[nrow(DealCycle)] <- DealCycle$DFAbsorb[nrow(DealCycle)-1]
    }
    
    if(DealCycle$DFMaxForce[nrow(DealCycle)-1] >= 0 & DealCycle$DFMaxForce[nrow(DealCycle)]==0 & DealCycle$DF[nrow(DealCycle)] < 170) {
      DealCycle$DF[nrow(DealCycle)] <- min(170, DealCycle$DF[nrow(DealCycle)] + 10)
      DealCycle$DFMaxForce[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 4000, 4000 - (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$DFMaxForce[nrow(DealCycle)-1]))
    } else if(DealCycle$DF[nrow(DealCycle)] == 170) {
      DealCycle$DFMaxForce[nrow(DealCycle)] <- 4000
    }
    
    if(DealCycle$InfinityForceCoolReduce[nrow(DealCycle)-1] >= 0 & DealCycle$InfinityForceCoolReduce[nrow(DealCycle)]==0 & DealCycle$InfinityForce[nrow(DealCycle)] > 0 & 
       DealCycle$BlueBloodCooldown[nrow(DealCycle)] - DealCycle$Time[1] > 0 & DealCycle$Skills[nrow(DealCycle)]!="BlueBloodCooldown") {
      DealCycle$BlueBloodCooldown[nrow(DealCycle)] <- max(0, DealCycle$BlueBloodCooldown[nrow(DealCycle)] - 2000)
      DealCycle$InfinityForceCoolReduce[nrow(DealCycle)] <- ifelse(nrow(DealCycle)==2, 4000 + 1000 * General$General$Serverlag, 
                                                                   4000 + 1000 * General$General$Serverlag - 
                                                                     (DealCycle$Time[nrow(DealCycle)] - DealCycle$Time[nrow(DealCycle)-1] - DealCycle$InfinityForceCoolReduce[nrow(DealCycle)-1]))
    } 
    return(DealCycle)
  }
  
  DealCycle <- DCBuff(DealCycle, "MapleSoldier", BuffFinal)
  DealCycle$DF[2] <- 120 ; DealCycle$DFMaxForce[2] <- 4000

  TotalTime <- TotalTime * 1000
  for(i in 1:length(BuffList[[1]])) {
    if(sum(rownames(BuffFinal)==BuffList[[1]][i]) > 0) {
      if(BuffList[[1]][i]=="OrthrosBuff") {
        DealCycle <- DCATK(DealCycle, "Jormungand", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      } else if(BuffList[[1]][i]=="BlueBlood") {
        DealCycle <- DCBuff(DealCycle, "BlueBloodCooldown", BuffFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      } else if(BuffList[[1]][i]=="Metamorphosis") {
        DealCycle <- DCSummoned(DealCycle, "MetamorphosisATK", SummonedFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      } else if(BuffList[[1]][i]=="BlessofIsekaiGoddess") {
        DealCycle <- DCATK(DealCycle, "OtherworldEmptiness", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      } else if(BuffList[[1]][i]=="CallMastema") {
        DealCycle <- DCATK(DealCycle, "MastemaClaw", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      }
      DealCycle <- DCBuff(DealCycle, BuffList[[1]][i], BuffFinal)
      DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      if(BuffList[[1]][i]=="DemonicFortitude") {
        DealCycle <- DCATK(DealCycle, "SpiderInMirror", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
      } 
    } else {
      DealCycle <- DCSummoned(DealCycle, BuffList[[1]][i], SummonedFinal)
      DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
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
  ONCool <- 2000 ; OGCool <- 3000
  CryCool <- 18000
  CBAWCool <- 8000 ; CBCool <- 5000
  
  ONRemain <- max(0, ONCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="OrthrosBuff")$Time))
  OGRemain <- max(0, OGCool - (DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] - subset(DealCycle, DealCycle$Skills=="OrthrosBuff")$Time))
  CryRemain <- 0 ; CBAWRemain <- 0 ; CBRemain <- 0

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
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        }
      }
      ## Devil Cry
      if(CryRemain==0 & DealCycle$DF[nrow(DealCycle)] >= subset(DFCost, DFCost$Skills=="DevilCry")$Cost & k!=5 |
         CryRemain==0 & DealCycle$DF[nrow(DealCycle)] >= subset(DFCost, DFCost$Skills=="DevilCry")$Cost & k==5 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - 5000) {
        DealCycle <- DCBuff(DealCycle, "DevilCryDebuff", BuffFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- CryCool - DealCycle$Time[1]
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        DealCycle <- DCATK(DealCycle, "DevilCry", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- ONCool - DealCycle$Time[1]
        } else {
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        }
        if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          OGRemain <- OGCool - DealCycle$Time[1]
        } else {
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        }
        if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CBAWRemain <- CBAWCool - DealCycle$Time[1]
        } else {
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        }
      }
      ## Demon Bane
      else if(nrow(subset(DealCycle, DealCycle$Skills=="DemonBanePre"))==0) {
        ## Awakening Slash - for RemainTime Reinforce
        DealCycle <- DCATK(DealCycle, "AwakeningSlash1", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- ifelse(DealCycle$RemainTimeReinforce[nrow(DealCycle)] < 3000, 
                                                                 subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000, DealCycle$RemainTimeReinforce[nrow(DealCycle)])
        
        if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- ONCool - DealCycle$Time[1]
        } else {
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        }
        if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          OGRemain <- OGCool - DealCycle$Time[1]
        } else {
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        }
        if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CBAWRemain <- CBAWCool - DealCycle$Time[1]
        } else {
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        }
        
        ## Demon Bane - Pre
        DealCycle <- DCATK(DealCycle, "DemonBanePre", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        ## Demon Bane - Tick
        for(i in 1:15) {
          DealCycle <- DCATK(DealCycle, "DemonBaneTick", ATKFinal)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          
          if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- ONCool - DealCycle$Time[1]
          } else {
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          }
          if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            OGRemain <- OGCool - DealCycle$Time[1]
          } else {
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          }
          if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            CBAWRemain <- CBAWCool - DealCycle$Time[1]
          } else {
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          }
        }
        
        ## Demon Bane - End
        DealCycle <- DCATK(DealCycle, "DemonBaneEnd", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- ONCool - DealCycle$Time[1]
        } else {
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        }
        if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          OGRemain <- OGCool - DealCycle$Time[1]
        } else {
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        }
        if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CBAWRemain <- CBAWCool - DealCycle$Time[1]
        } else {
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        }
        
        ## Demon Bane - Last ATK Pre
        DealCycle <- DCATK(DealCycle, "DemonBaneLastPre", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        ## Demon Bane - Last ATK Tick
        for(i in 1:20) {
          DealCycle <- DCATK(DealCycle, "DemonBaneLastTick", ATKFinal)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          
          if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- ONCool - DealCycle$Time[1]
          } else {
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          }
          if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            OGRemain <- OGCool - DealCycle$Time[1]
          } else {
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          }
          if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            CBAWRemain <- CBAWCool - DealCycle$Time[1]
          } else {
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          }
        }
        
        ## Demon Bane - Last ATK End
        DealCycle <- DCATK(DealCycle, "DemonBaneLastEnd", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        
        if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- ONCool - DealCycle$Time[1]
        } else {
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        }
        if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          OGRemain <- OGCool - DealCycle$Time[1]
        } else {
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        }
        if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CBAWRemain <- CBAWCool - DealCycle$Time[1]
        } else {
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        }
      }
      ## Awakening Slash
      else if(DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
        ## Awakening Slash - 1st Hit
        DealCycle <- DCATK(DealCycle, "AwakeningSlash1", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        CryRemain <- max(0, CryRemain - DealCycle$Time[1] + 120)
        CBRemain <- max(0, CBRemain - DealCycle$Time[1] + 120)
        DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- ifelse(DealCycle$RemainTimeReinforce[nrow(DealCycle)] < 3000, 
                                                                 subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000, DealCycle$RemainTimeReinforce[nrow(DealCycle)])
        
        if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          
          DealCycle$Skills[nrow(DealCycle)-1] <- "OrthrosNemea" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash1"
          ONRemain <- ONCool - DealCycle$Time[1] + 120
        } else {
          ONRemain <- max(0, ONRemain - DealCycle$Time[1] + 120)
        }
        if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          
          DealCycle$Skills[nrow(DealCycle)-1] <- "OrthrosGeryon" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash1"
          OGRemain <- OGCool - DealCycle$Time[1] + 120
        } else {
          OGRemain <- max(0, OGRemain - DealCycle$Time[1] + 120)
        }
        if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
          DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          
          DealCycle$Skills[nrow(DealCycle)-1] <- "Cerberus" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash1"
          CBAWRemain <- CBAWCool - DealCycle$Time[1] + 120
        } else {
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1] + 120)
        }
        
        ## Awakening Slash - 2nd Hit
        if(DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- DCATKSkip(DealCycle, "AwakeningSlash2", ATKFinal, SkipStructure)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CryRemain <- max(0, CryRemain - DealCycle$Time[1] + 120)
          CBRemain <- max(0, CBRemain - DealCycle$Time[1] + 120)
          DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- ifelse(DealCycle$RemainTimeReinforce[nrow(DealCycle)] < 3000, 
                                                                   subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000, DealCycle$RemainTimeReinforce[nrow(DealCycle)])
          
          if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            
            DealCycle$Skills[nrow(DealCycle)-1] <- "OrthrosNemea" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash2"
            ONRemain <- ONCool - DealCycle$Time[1] + 120
          } else {
            ONRemain <- max(0, ONRemain - DealCycle$Time[1] + 120)
          }
          if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            
            DealCycle$Skills[nrow(DealCycle)-1] <- "OrthrosGeryon" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash2"
            OGRemain <- OGCool - DealCycle$Time[1] + 120
          } else {
            OGRemain <- max(0, OGRemain - DealCycle$Time[1] + 120)
          }
          if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            
            DealCycle$Skills[nrow(DealCycle)-1] <- "Cerberus" ; DealCycle$Skills[nrow(DealCycle)] <- "AwakeningSlash2"
            CBAWRemain <- CBAWCool - DealCycle$Time[1] + 120
          } else {
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1] + 120)
          }
        }
        
        ## Awakening Slash - 3rd Hit
        if(DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- DCATKSkip(DealCycle, "AwakeningSlash3", ATKFinal, SkipStructure)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- ifelse(DealCycle$RemainTimeReinforce[nrow(DealCycle)] < 3000, 
                                                                   subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000, DealCycle$RemainTimeReinforce[nrow(DealCycle)])
          
          if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- ONCool - DealCycle$Time[1]
          } else {
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          }
          if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            OGRemain <- OGCool - DealCycle$Time[1]
          } else {
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          }
          if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            CBAWRemain <- CBAWCool - DealCycle$Time[1]
          } else {
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          }
        }
        
        ## Awakening Slash - 4th Hit
        if(DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
          DealCycle <- DCATK(DealCycle, "AwakeningSlash4", ATKFinal)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- ifelse(DealCycle$RemainTimeReinforce[nrow(DealCycle)] < 3000, 
                                                                   subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000, DealCycle$RemainTimeReinforce[nrow(DealCycle)])
          
          if(ONRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosNemea"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- ONCool - DealCycle$Time[1]
          } else {
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          }
          if(OGRemain==0 & DealCycle$OrthrosBuff[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "OrthrosGeryon"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            OGRemain <- OGCool - DealCycle$Time[1]
          } else {
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          }
          if(CBAWRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] > 0) {
            DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
            DealCycle$Skills[nrow(DealCycle)] <- "Cerberus"
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            CBAWRemain <- CBAWCool - DealCycle$Time[1]
          } else {
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          }
        }
      }
      ## Demon Slash
      else if(DealCycle$RemainTimeReinforce[nrow(DealCycle)] <= 1000 & AwakeningOffSlash==T) {
        DealCycle <- DCATK(DealCycle, "DemonSlash", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        DealCycle$RemainTimeReinforce[nrow(DealCycle)] <- subset(BuffFinal, rownames(BuffFinal)=="RemainTimeReinforce")$Duration * 1000
      }
      ## Cerberus
      else if(CBRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] == 0 & k!=3 |
              CBRemain==0 & DealCycle$DemonAwakening[nrow(DealCycle)] == 0 & k==3 & DealCycle$Time[nrow(DealCycle)] + DealCycle$Time[1] < BuffStartTime - 5000) {
        DealCycle <- DCATK(DealCycle, "Cerberus", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- CBCool - DealCycle$Time[1]
      }
      ## Demon Impact
      else {
        DealCycle <- DCATK(DealCycle, "DemonImpact", ATKFinal)
        DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
        ONRemain <- max(0, ONRemain - DealCycle$Time[1])
        OGRemain <- max(0, OGRemain - DealCycle$Time[1])
        CryRemain <- max(0, CryRemain - DealCycle$Time[1])
        CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
        CBRemain <- max(0, CBRemain - DealCycle$Time[1])
      }
    }
    
    if(k != length(BuffList)) {
      for(i in 1:length(BuffList[[k]])) {
        if(sum(rownames(BuffFinal)==BuffList[[k]][i]) > 0) {
          if(BuffList[[k]][i]=="OrthrosBuff") {
            DealCycle <- DCATK(DealCycle, "Jormungand", ATKFinal)
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
            CryRemain <- max(0, CryRemain - DealCycle$Time[1])
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
            CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          } else if(BuffList[[k]][i]=="BlueBlood") {
            DealCycle <- DCBuff(DealCycle, "BlueBloodCooldown", BuffFinal)
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
            CryRemain <- max(0, CryRemain - DealCycle$Time[1])
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
            CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          } else if(BuffList[[k]][i]=="BlessofIsekaiGoddess") {
            DealCycle <- DCATK(DealCycle, "OtherworldEmptiness", ATKFinal)
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
            CryRemain <- max(0, CryRemain - DealCycle$Time[1])
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
            CBRemain <- max(0, CBRemain - DealCycle$Time[1])
          } else if(BuffList[[k]][i]=="DemonAwakening") {
            DealCycle <- DCATK(DealCycle, "Cerberus", ATKFinal)
            DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
            ONRemain <- max(0, ONRemain - DealCycle$Time[1])
            OGRemain <- max(0, OGRemain - DealCycle$Time[1])
            CryRemain <- max(0, CryRemain - DealCycle$Time[1])
            CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
            CBRemain <- CBCool - DealCycle$Time[1]
          }
          DealCycle <- DCBuff(DealCycle, BuffList[[k]][i], BuffFinal)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        } else {
          DealCycle <- DCSummoned(DealCycle, BuffList[[k]][i], SummonedFinal)
          DealCycle <- DFBBLogic(DealCycle, DFAbsorb, DFCost)
          ONRemain <- max(0, ONRemain - DealCycle$Time[1])
          OGRemain <- max(0, OGRemain - DealCycle$Time[1])
          CryRemain <- max(0, CryRemain - DealCycle$Time[1])
          CBAWRemain <- max(0, CBAWRemain - DealCycle$Time[1])
          CBRemain <- max(0, CBRemain - DealCycle$Time[1])
        }
      }
    }
  }
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
DemonSlayerAddATK <- function(DealCycle, ATKFinal, BuffFinal, SummonedFinal, Spec, JormungandLevel, CallMastemaLevel) {
  ## Jormungand
  JormungandATKTimes <- ceiling((10000 + 1000 * floor(JormungandLevel/5) - 1980) / 1080)
  JormungandLastTime <- 10000 + 1000 * floor(JormungandLevel/5)
  
  for(i in 1:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="Jormungand") {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- "JormungandLast"
      DealCycle$Time[nrow(DealCycle)] <- DealCycle$Time[nrow(DealCycle)] + JormungandLastTime
    } 
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 2:nrow(DealCycle)) {
    if(DealCycle$Skills[i]=="JormungandLast") {
      DealCycle[i, 5:ncol(DealCycle)] <- DealCycle[i-1, 5:ncol(DealCycle)] - (DealCycle$Time[i] - DealCycle$Time[i-1])
      for(j in 5:ncol(DealCycle)) {
        DealCycle[i, j] <- max(0, DealCycle[i, j])
      }
    }
  }
  DealCycle <- RepATKCycle(DealCycle, "Jormungand", JormungandATKTimes, 1980, ATKFinal)
  
  
  ## Call Mastema, Otherworld Emptiness
  DealCycle <- RepATKCycle(DealCycle, "OtherworldEmptiness", 10, 0, ATKFinal)
  
  CallMastemaATKTimes <- ceiling((30000 + 1000 * CallMastemaLevel - 1080) / 5280)
  DealCycle <- RepATKCycle(DealCycle, "MastemaClaw", CallMastemaATKTimes, 1080, ATKFinal)
  
  
  ## Aura Weapon
  DealCycle <- AWCycle(DealCycle, c("DemonSlash", "AwakeningSlash1", "AwakeningSlash2", "AwakeningSlash3", "AwakeningSlash4", 
                                    "DemonImpact", "DevilCry", "Cerberus", "DemonBaneTick", "DemonBaneEnd", "DemonBaneLastTick", "DemonBaneLastEnd"))
  
  ## Metamorphosis
  DealCycle <- DCSummonedATKs(DealCycle, "MetamorphosisATK", SummonedFinal)
  
  ## Spider In Mirror
  DealCycle <- DCSpiderInMirror(DealCycle, SummonedFinal)
  
  ## Demon Slash - RemainTime Reinforce
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("DemonSlash", "AwakeningSlash1", "AwakeningSlash2", "AwakeningSlash3", "AwakeningSlash4"))==1) {
      DealCycle$RemainTimeReinforce[i] <- 0
    }
  }
  
  ## Blue Blood
  for(i in 1:nrow(DealCycle)) {
    if(sum(DealCycle$Skills[i]==c("DemonSlash", "AwakeningSlash1", "AwakeningSlash2", "AwakeningSlash3", "AwakeningSlash4", 
                                  "DemonImpact", "DevilCry", "Cerberus", "DemonBaneTick", "DemonBaneEnd", "DemonBaneLastTick", "DemonBaneLastEnd", "AuraWeapon", "MetamorphosisATK"))==1 &
       DealCycle$BlueBlood[i] > 0) {
      DealCycle <- rbind(DealCycle, DealCycle[i, ])
      DealCycle$Skills[nrow(DealCycle)] <- paste(DealCycle$Skills[nrow(DealCycle)], "Add", sep="")
    }
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  ## Dummy Reduction
  DealCycle$DF <- 0
  DealCycle$DFAbsorb <- 0
  
  return(DealCycle)
}

DemonSlayerDealCycle <- DemonSlayerCycle(DealCycle=DemonSlayerDealCycle, 
                                         ATKFinal, 
                                         BuffFinal, 
                                         SummonedFinal, 
                                         Spec=DemonSlayerSpec, 
                                         SkipStructure=DemonSlayerSkipATK,
                                         Period=240, CycleTime=240, AwakeningOffSlash=T)
DemonSlayerDealCycle <- DealCycleFinal(DemonSlayerDealCycle)
DemonSlayerDealCycle <- DemonSlayerAddATK(DealCycle=DemonSlayerDealCycle, 
                                          ATKFinal, 
                                          BuffFinal, 
                                          SummonedFinal, 
                                          Spec=DemonSlayerSpec, 
                                          JormungandLevel=GetCoreLv(DemonSlayerCore, "Jormungand"), 
                                          CallMastemaLevel=GetCoreLv(DemonSlayerCore, "CallMastema"))
DemonSlayerDealCycleReduction <- DealCycleReduction(DemonSlayerDealCycle)

Idx1 <- c() ; Idx2 <- c()
for(i in 1:length(PotentialOpt)) {
  if(names(PotentialOpt)[i]==DPMCalcOption$SpecSet) {
    Idx1 <- i
  }
}
for(i in 1:nrow(PotentialOpt[[Idx1]])) {
  if(rownames(PotentialOpt[[Idx1]])[i]=="DemonSlayer") {
    Idx2 <- i
  }
}
if(DPMCalcOption$Optimization==T) {
  DemonSlayerSpecOpt1 <- Optimization1(DemonSlayerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DemonSlayerSpec, DemonSlayerUnionRemained)
  PotentialOpt[[Idx1]][Idx2, ] <- DemonSlayerSpecOpt1[1, 1:3]
} else {
  DemonSlayerSpecOpt1 <- PotentialOpt[[Idx1]][Idx2, ]
}
DemonSlayerSpecOpt <- OptDataAdd(DemonSlayerSpec, DemonSlayerSpecOpt1, "Potential", DemonSlayerBase$CRROver, DemonAvenger=F)

if(DPMCalcOption$Optimization==T) {
  DemonSlayerSpecOpt2 <- Optimization2(DemonSlayerDealCycleReduction, ATKFinal, BuffFinal, SummonedFinal, DemonSlayerSpecOpt, DemonSlayerHyperStatBase, DemonSlayerBase$ChrLv, DemonSlayerBase$CRROver, HyperStanceLv=5)
  HyperStatOpt[[Idx1]][Idx2, c(1, 3:10)] <- DemonSlayerSpecOpt2[1, ]
} else {
  DemonSlayerSpecOpt2 <- HyperStatOpt[[Idx1]][Idx2, ]
}
DemonSlayerSpecOpt <- OptDataAdd(DemonSlayerSpecOpt, DemonSlayerSpecOpt2, "HyperStat", DemonSlayerBase$CRROver, DemonAvenger=F)

DemonSlayerFinalDPM <- DealCalc(DemonSlayerDealCycle, ATKFinal, BuffFinal, SummonedFinal, DemonSlayerSpecOpt, Collapse=F)
DemonSlayerFinalDPMwithMax <- DealCalcWithMaxDMR(DemonSlayerDealCycle, ATKFinal, BuffFinal, SummonedFinal, DemonSlayerSpecOpt)

set(get(DPMCalcOption$DataName), as.integer(1), "DemonSlayer", sum(na.omit(DemonSlayerFinalDPMwithMax)) / (max(DemonSlayerDealCycle$Time) / 60000))
set(get(DPMCalcOption$DataName), as.integer(2), "DemonSlayer", sum(na.omit(DemonSlayerFinalDPM)) / (max(DemonSlayerDealCycle$Time) / 60000) - sum(na.omit(DemonSlayerFinalDPMwithMax)) / (max(DemonSlayerDealCycle$Time) / 60000))

DemonSlayerDealRatio <- DealRatio(DemonSlayerDealCycle, DemonSlayerFinalDPMwithMax)

DemonSlayerDealData <- data.frame(DemonSlayerDealCycle$Skills, DemonSlayerDealCycle$Time, DemonSlayerDealCycle$Restraint4, DemonSlayerFinalDPMwithMax)
colnames(DemonSlayerDealData) <- c("Skills", "Time", "R4", "Deal")
set(get(DPMCalcOption$DataName), as.integer(3), "DemonSlayer", Deal_RR(DemonSlayerDealData))
set(get(DPMCalcOption$DataName), as.integer(4), "DemonSlayer", Deal_40s(DemonSlayerDealData))


## DemonSlayer - Demon Slash Not Used When Demon Awakening is off
DealCycle <- c("Skills", "Time", rownames(DemonSlayerBuff))
DemonSlayerDealCycle2 <- t(rep(0, length(DealCycle)))
colnames(DemonSlayerDealCycle2) <- DealCycle
DemonSlayerDealCycle2 <- data.frame(DemonSlayerDealCycle2)

DemonSlayerDealCycle2 <- DemonSlayerCycle(DealCycle=DemonSlayerDealCycle2, 
                                          ATKFinal, 
                                          BuffFinal, 
                                          SummonedFinal, 
                                          Spec=DemonSlayerSpec, 
                                          SkipStructure=DemonSlayerSkipATK,
                                          Period=240, CycleTime=240, AwakeningOffSlash=F)
DemonSlayerDealCycle2 <- DealCycleFinal(DemonSlayerDealCycle2)
DemonSlayerDealCycle2 <- DemonSlayerAddATK(DealCycle=DemonSlayerDealCycle2, 
                                           ATKFinal, 
                                           BuffFinal, 
                                           SummonedFinal, 
                                           Spec=DemonSlayerSpec, 
                                           JormungandLevel=GetCoreLv(DemonSlayerCore, "Jormungand"), 
                                           CallMastemaLevel=GetCoreLv(DemonSlayerCore, "CallMastema"))

DemonSlayerFinalDPMwithMax2 <- DealCalcWithMaxDMR(DemonSlayerDealCycle2, ATKFinal, BuffFinal, SummonedFinal, DemonSlayerSpecOpt)
NonAwakeningSlashoffDPM <- sum(na.omit(DemonSlayerFinalDPMwithMax2)) / (max(DemonSlayerDealCycle2$Time)/ 60000)