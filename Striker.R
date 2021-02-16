## Striker - Data
## Striker - VMatrix
StrikerCore <- MatrixSet(PasSkills=c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "TidalCrash"), 
                         PasLvs=c(50, 50, 50, 50, 50), 
                         PasMP=c(10, 10, 10, 10, 5), 
                         ActSkills=c("LightningCascade", "SharkTorpedo", "LightningGodSpearStrike", "LightningSpearMultistrike", 
                                     CommonV("Pirate", "CygnusKnights")), 
                         ActLvs=c(25, 25, 25, 25, 25, 25, 25, 25, 25), 
                         ActMP=c(5, 5, 5, 5, 0, 5, 5, 5, 5), 
                         UsefulSkills=c("SharpEyes", "CombatOrders"), 
                         UsefulLvs=20, 
                         UsefulMP=0, 
                         SpecSet=SpecDefault)


## Striker - Basic Info
## Link Check Needed
StrikerBase <- JobBase(ChrInfo=ChrInfo, 
                       MobInfo=MobDefault,
                       SpecSet=SpecDefault, 
                       Job="Striker",
                       CoreData=StrikerCore, 
                       MikhailLink=F, 
                       OtherBuffDuration=0, 
                       AbilList=c("BDR", "DisorderBDR"), 
                       LinkList=c("CygnusKnights", "Zero", "DemonAvenger", "Phantom"), 
                       MonsterLife=MLTypeS21, 
                       Weapon=WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, "Knuckle", SpecDefault$WeaponType)[, 1:16],
                       WeaponType=SpecDefault$WeaponType, 
                       SubWeapon=SubWeapon[19, ], 
                       Emblem=Emblem[3, ])


## Striker - Passive
option <- factor(c("MainStat"), levels=PSkill)
value <- c(floor(SoulMasterBase$ChrLv/2))
ElementalHarmony <- data.frame(option, value)

option <- factor(c("ATKP"), levels=PSkill)
value <- c(10)
ElementalExpert <- data.frame(option, value)

option <- factor(c("MainStat"), levels=PSkill)
value <- c(60)
PhysicalTraining <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(20)
Noebaek <- data.frame(option, value)

option <- factor(c("BDR"), levels=PSkill)
value <- c(5)
Geukgap <- data.frame(option, value)

option <- factor(c("ATK"), levels=PSkill)
value <- c(30)
Noeje <- data.frame(option, value)

option <- factor(c("Mastery", "ATK"), levels=PSkill)
value <- c(30)
KnuckleExpert <- data.frame(option, value)


