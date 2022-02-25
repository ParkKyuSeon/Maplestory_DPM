## Core Set Build Function
CoreBuilder <- function(ActSkills, 
                        ActSkillsLv, 
                        UsefulSkills, 
                        SpecSet, 
                        VPassiveList, 
                        VPassivePrior, 
                        SelfBind) {
  ## Core Set Build
  ActSkillsList <- ActSkills
  RopeConnectUse <- SpecSet$CommonVSet[rownames(SpecSet$CommonVSet)==c("RopeConnect"), ]$Use
  RopeConnectLv <- SpecSet$CommonVSet[rownames(SpecSet$CommonVSet)==c("RopeConnect"), ]$Lv
  SpecialCoreUse <- SpecSet$CommonVSet[rownames(SpecSet$CommonVSet)==c("SpecialCore"), ]$Use
  UsingCommonV <- subset(SpecSet$CommonVSet, rownames(SpecSet$CommonVSet)!="RopeConnect")
  UsingCommonV <- subset(UsingCommonV, rownames(UsingCommonV)!="SpecialCore")
  if(SelfBind==T) {
    UsingCommonV <- subset(UsingCommonV, rownames(UsingCommonV)!="ErdaNova")
  }
  
  UsingCommonVList <- rownames(subset(UsingCommonV, UsingCommonV$Use==T))
  UsingCommonVLv <- subset(UsingCommonV, UsingCommonV$Use==T)$Lv
  
  ActSkillsList <- c(ActSkillsList, UsingCommonVList)
  ActSkillsLv <- c(ActSkillsLv, UsingCommonVLv)
  
  LeftCores <- floor((SpecSet$Basic$ChrLv  - 200) / 5) + 5 + 2
  LeftCores <- LeftCores - length(ActSkillsList) - length(UsefulSkills) - as.numeric(SpecialCoreUse)
  if(LeftCores < 0) {
    warning("Core Number Exceed")
  } else if(LeftCores >= 8 & is.null(VPassiveList$N8) == F) {
    PasSkillsList <- VPassiveList$N8$Skills
    PasSkillsLv <- VPassiveList$N8$Lv
    Prior <- VPassivePrior$N8
    PassiveCores <- 8
  } else if(LeftCores >= 7 & is.null(VPassiveList$N7) == F) {
    PasSkillsList <- VPassiveList$N7$Skills
    PasSkillsLv <- VPassiveList$N7$Lv
    Prior <- VPassivePrior$N7
    PassiveCores <- 7
  } else if(LeftCores >= 6 & is.null(VPassiveList$N6) == F) {
    PasSkillsList <- VPassiveList$N6$Skills
    PasSkillsLv <- VPassiveList$N6$Lv
    Prior <- VPassivePrior$N6
    PassiveCores <- 6
  } else if(LeftCores >= 5 & is.null(VPassiveList$N5) == F) {
    PasSkillsList <- VPassiveList$N5$Skills
    PasSkillsLv <- VPassiveList$N5$Lv
    Prior <- VPassivePrior$N5
    PassiveCores <- 5
  } else if(LeftCores >= 4 & is.null(VPassiveList$N4) == F) {
    PasSkillsList <- VPassiveList$N4$Skills
    PasSkillsLv <- VPassiveList$N4$Lv
    Prior <- VPassivePrior$N4
    PassiveCores <- 4
  } else if(LeftCores >= 3 & is.null(VPassiveList$N3) == F) {
    PasSkillsList <- VPassiveList$N3$Skills
    PasSkillsLv <- VPassiveList$N3$Lv
    Prior <- VPassivePrior$N3
    PassiveCores <- 3
  } else if(LeftCores >= 2 & is.null(VPassiveList$N2) == F) {
    PasSkillsList <- VPassiveList$N2$Skills
    PasSkillsLv <- VPassiveList$N2$Lv
    Prior <- VPassivePrior$N2
    PassiveCores <- 2
  } else {
    warning("No Available Core Combination")
  }
  LeftCores <- LeftCores - PassiveCores
  if(LeftCores >= 1 & RopeConnectUse==T) {
    ActSkillsList <- c(ActSkillsList, "RopeConnect")
    ActSkillsLv <- c(ActSkillsLv, RopeConnectLv)
    LeftCores <- LeftCores - 1
  }
  if(LeftCores >= 1 & sum(PasSkillsList=="AngelRay") == 0) {
    UsefulSkills <- c(UsefulSkills, "AdvancedBless")
    LeftCores <- LeftCores - 1
  }
  
  ## Matrix Point Build
  PasSkills <- data.frame(Skills=PasSkillsList, 
                          Lv=PasSkillsLv, 
                          MP=rep(0, length(PasSkillsList)))
  ActSkills <- data.frame(Skills=ActSkillsList, 
                          Lv=ActSkillsLv, 
                          MP=rep(0, length(ActSkillsList)))
  if(RopeConnectUse==F) {
    Prior <- Prior[Prior!="RopeConnect"]
  }
  
  MatrixPointLeft <- max(0, SpecSet$Basic$ChrLv - 200)
  t <- 1
  while(MatrixPointLeft > 0 & t <= length(Prior)) {
    if(sum(Prior[t]==ActSkillsList) >= 1) {
      ActSkills[ActSkills$Skills==Prior[t], ]$MP <- min(5, MatrixPointLeft)
    } else if(sum(strsplit(Prior[t], "-")[[1]][1]==PasSkillsList)==1) {
      k <- strsplit(Prior[t], "-")[[1]]
      for(i in 1:length(k)) {
        PasSkills[PasSkills$Skills==k[i], ]$MP <- PasSkills[PasSkills$Skills==k[i], ]$MP + min(5, MatrixPointLeft)
        if(PasSkills[PasSkills$Skills==k[i], ]$Lv + PasSkills[PasSkills$Skills==k[i], ]$MP > 60) {
          PasSkills[PasSkills$Skills==k[i], ]$MP <- 60 - PasSkills[PasSkills$Skills==k[i], ]$Lv
        }
      }
    }
    MatrixPointLeft <- max(0, MatrixPointLeft - 5)
    t <- t + 1
  }
  
  return(list(PasSkills=PasSkills,
              ActSkills=ActSkills, 
              UsefulSkills=UsefulSkills, 
              SpecialCoreUse=SpecialCoreUse))
}

GetCoreLv <- function(CoreData, 
                      SkillName) {
  for(i in 1:length(CoreData)) {
    colnames(CoreData[[i]])[1] <- "Skills"
  }
  CoreDataCollapse <- rbind(CoreData[[1]], CoreData[[2]], CoreData[[3]])
  return(ifelse(length(CoreDataCollapse[CoreDataCollapse$Skills==SkillName, ]$Levels)==0, 0, CoreDataCollapse[CoreDataCollapse$Skills==SkillName, ]$Levels))
}

## V Matrix Passive Skill Set, Matrix Point Prior
## Hero
HeroVPassive <- list()
HeroVPassive$N4 <- data.frame(Skills=c("RagingBlow", "RageUprising", "AdvancedFinalAttack", "Incising", "Valhalla", "AuraBlade"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
HeroVPrior <- list()
HeroVPrior$N4 <- c("RagingBlow-Valhalla-AdvancedFinalAttack", "RagingBlow-Valhalla-AdvancedFinalAttack", 
                   "ComboInstinct", "SwordofBurningSoul", "SwordIllusion", "AuraWeapon", "MapleWarriors2", "SpiderInMirror", 
                   "Incising-RageUprising-AuraBlade", "Incising-RageUprising-AuraBlade", 
                   "ComboDeathfault", "Blink", "BodyofSteel", "RopeConnect", "BlitzShield")

## Palladin
PalladinVPassive <- list()
PalladinVPassive$N4 <- data.frame(Skills=c("Blast", "DivineStigma_DivineJudgement", "Sanctuary", "FinalAttack", "DivineCharge", "Smite"), 
                                  Lv=c(50, 50, 50, 50, 50, 50), 
                                  stringsAsFactors=F)
PalladinVPrior <- list()
PalladinVPrior$N4 <- c("Blast-Sanctuary-DivineStigma_DivineJudgement", "Blast-Sanctuary-DivineStigma_DivineJudgement", 
                       "GrandCross", "BlessedHammer", "HolyUnity", "MightyMjolnir", "AuraWeapon", "MapleWarriors2", 
                       "SpiderInMirror", "Blink", 
                       "DivineCharge-FinalAttack-Smite",  "DivineCharge-FinalAttack-Smite", 
                       "BodyofSteel", "RopeConnect", "BlitzShield")

## DarkKnight
DarkKnightVPassive <- list()
DarkKnightVPassive$N3 <- data.frame(Skills=c("GungnirDescent", "Beholder", "FinalAttack", "DarkImpale", "DarkSynthesis"), 
                                    Lv=c(50, 50, 50, 50, 25), 
                                    stringsAsFactors=F)
DarkKnightVPrior <- list()
DarkKnightVPrior$N3 <- c("GungnirDescent-Beholder-FinalAttack", "GungnirDescent-Beholder-DarkImpale", 
                         "DarkSpear", "PierceCyclone", "DarknessAura", "AuraWeapon", "MapleWarriors2", "BeholderImpact", 
                         "FinalAttack-DarkImpale-DarkSynthesis", 
                         "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect", "BlitzShield")


## ArchMageFP
ArchMageFPVPassive <- list()
ArchMageFPVPassive$N4 <- data.frame(Skills=c("FlameSweep", "FlameHaze", "MistEruption", "TeleportMastery_PoisonRegion", "Meteor", "Ignite"), 
                                    Lv=c(50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
ArchMageFPVPassive$N5 <- data.frame(Skills=c("FlameSweep", "FlameHaze", "MistEruption", "TeleportMastery_PoisonRegion", "Meteor", "Ignite", "MegiddoFlame", "Ifrit", "FireAura"), 
                                    Lv=c(50, 50, 50, 50, 50, 50, 25, 25, 25), 
                                    stringsAsFactors=F)
ArchMageFPVPassive$N6 <- data.frame(Skills=c("FlameSweep", "FlameHaze", "MistEruption", "TeleportMastery_PoisonRegion", "Meteor", "Ignite", "MegiddoFlame", "Ifrit", "FireAura"), 
                                    Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
ArchMageFPVPrior <- list()
ArchMageFPVPrior$N4 <- c("FlameSweep-FlameHaze-MistEruption", "FlameSweep-FlameHaze-MistEruption", 
                         "DotPunisher", 
                         "TeleportMastery_PoisonRegion-Meteor-Ignite", "TeleportMastery_PoisonRegion-Meteor-Ignite", 
                         "OverloadMana", "PoisonNova", "PoisonChain", "FuryofIfrit", "MapleWarriors2", "UnstableMemorize", "SpiderInMirror", "Blink", "RopeConnect")
ArchMageFPVPrior$N5 <- c("FlameSweep-FlameHaze-MistEruption", "FlameSweep-FlameHaze-MistEruption", 
                         "DotPunisher", 
                         "TeleportMastery_PoisonRegion-Meteor-Ignite", "TeleportMastery_PoisonRegion-Meteor-Ignite", 
                         "OverloadMana", "PoisonNova", "PoisonChain", "FuryofIfrit", "MapleWarriors2", "UnstableMemorize", "SpiderInMirror", "Blink", 
                         "MegiddoFlame-Ifrit-FireAura", 
                         "RopeConnect")
ArchMageFPVPrior$N6 <- c("FlameSweep-FlameHaze-MistEruption", "FlameSweep-FlameHaze-MistEruption", 
                         "DotPunisher", 
                         "TeleportMastery_PoisonRegion-Meteor-Ignite", "TeleportMastery_PoisonRegion-Meteor-Ignite", 
                         "OverloadMana", "PoisonNova", "PoisonChain", "FuryofIfrit", "MapleWarriors2", "UnstableMemorize", "SpiderInMirror", "Blink", 
                         "MegiddoFlame-Ifrit-FireAura", "MegiddoFlame-Ifrit-FireAura", 
                         "RopeConnect")

## ArchMageTC
ArchMageTCVPassive <- list()
ArchMageTCVPassive$N4 <- data.frame(Skills=c("ChainLightning", "LightningSpear", "FrozenOrb", "Elquines", "Blizard", "ThunderSphere"), 
                                   Lv=c(50, 50, 50, 50, 50, 50), 
                                   stringsAsFactors=F)
ArchMageTCVPrior <- list()
ArchMageTCVPrior$N4 <- c("ChainLightning-LightningSpear-ThunderSphere", "ChainLightning-LightningSpear-ThunderSphere", 
                         "ThunderBreak", "JupiterThunder", "OverloadMana", "SpiritofSnow", "MapleWarriors2", "UnstableMemorize", 
                         "FrozenOrb-Elquines-Blizard", "FrozenOrb-Elquines-Blizard", 
                         "IceAge", "SpiderInMirror", "Blink", "RopeConnect")


## Bishop
BishopVPassive <- list()
BishopVPassive$N4 <- data.frame(Skills=c("AngelRay", "HeavensDoor_FountainforAngel", "Bahamut", "Bigbang", "Genesis_TriumphFeather", "Heal_AngelicTouch"), 
                               Lv=c(50, 50, 50, 50, 50, 50), 
                               stringsAsFactors=F)
BishopVPrior <- list()
BishopVPrior$N4 <- c("AngelRay-HeavensDoor_FountainforAngel-Genesis_TriumphFeather", "AngelRay-HeavensDoor_FountainforAngel-Genesis_TriumphFeather", 
                     "DivinePunishment", "PeaceMaker", "Pray", "OverloadMana", "AngelofLibra", "MapleWarriors2", "UnstableMemorize", "SpiderInMirror", "Blink",
                     "Bahamut-Bigbang-Heal_AngelicTouch", "Bahamut-Bigbang-Heal_AngelicTouch", 
                     "RopeConnect")

## Bowmaster
BowmasterVPassive <- list()
BowmasterVPassive$N4 <- data.frame(Skills=c("HurricaneArrow", "ArrowPlatter_FlashMirage", "AdvancedFinalAttack", "AdvancedQuiver", "Phoenix", "UncountableArrow"), 
                                  Lv=c(50, 50, 50, 50, 50, 50), 
                                  stringsAsFactors=F)
BowmasterVPrior <- list()
BowmasterVPrior$N4 <- c("HurricaneArrow-ArrowPlatter_FlashMirage-AdvancedQuiver", "HurricaneArrow-ArrowPlatter_FlashMirage-AdvancedQuiver", 
                        "QuiverFullBurst", "ArrowRain", "AfterimageArrow", "CriticalReinforce", "MapleWarriors2", "SilhouetteMirage", "GuidedArrow", 
                        "AdvancedFinalAttack-Phoenix-UncountableArrow", "AdvancedFinalAttack-Phoenix-UncountableArrow", 
                        "Evolve", "Blink", "SpiderInMirror", "RopeConnect")

## Marksman
MarksmanVPassive <- list()
MarksmanVPassive$N3 <- data.frame(Skills=c("Snipe", "Piercing", "FinalAttack", "Freezer", "LongRangeTrueShot"), 
                                  Lv=c(50, 50, 50, 50, 25), 
                                  stringsAsFactors=F)
MarksmanVPrior <- list()
MarksmanVPrior$N3 <- c("SplitArrow", 
                       "Snipe-Piercing-FinalAttack", "Snipe-Piercing-Freezer", 
                       "FullbustShot", "TrueSnipe", "CriticalReinforce", "MapleWarriors2", "ChargedArrow", "GuidedArrow", "Evolve", "Blink", "SpiderInMirror",
                       "Freezer-FinalAttack-LongRangeTrueShot", 
                       "RopeConnect")


## PathFinder
PathFinderVPassive <- list()
PathFinderVPassive$N4 <- data.frame(Skills=c("CardinalDischarge", "CardinalBlast", "CradinalTransition", "TripleImpact", "EdgeofResonance", "Raven"), 
                                    Lv=c(50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
PathFinderVPassive$N5 <- data.frame(Skills=c("CardinalDischarge", "CardinalBlast", "CradinalTransition", "TripleImpact", "EdgeofResonance", "Raven", 
                                             "ComboAssault", "SplitMistel"), 
                                    Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                    stringsAsFactors=F)
PathFinderVPrior <- list()
PathFinderVPrior$N4 <- c("CardinalDischarge-CardinalBlast-TripleImpact", "CardinalDischarge-CardinalBlast-TripleImpact", 
                         "RavenTempest",
                         "CradinalTransition-EdgeofResonance-Raven", "CradinalTransition-EdgeofResonance-Raven", 
                         "UltimateBlast", "CriticalReinforce", "MapleWarriors2", "RelicUnbound", "ObisdianBarrier", "GuidedArrow", "Blink", "Evolve", "SpiderInMirror", "RopeConnect")
PathFinderVPrior$N5 <- c("CardinalDischarge-CardinalBlast-TripleImpact", "CardinalDischarge-CardinalBlast-TripleImpact", 
                         "RavenTempest",
                         "CradinalTransition-EdgeofResonance-Raven", "CradinalTransition-EdgeofResonance-ComboAssault", 
                         "UltimateBlast", "CriticalReinforce", "MapleWarriors2", "RelicUnbound", "ObisdianBarrier", "GuidedArrow", "Blink", "Evolve", "SpiderInMirror", "RopeConnect", 
                         "Raven-ComboAssault-SplitMistel")


## NightLord
NightLordVPassive <- list()
NightLordVPassive$N4 <- data.frame(Skills=c("QuadrapleThrow", "SuddenRaid", "MarkofNightLord", "DarkFlare", "Showdown", "FourSeasons"), 
                                   Lv=c(50, 50, 50, 50, 50, 50), 
                                   stringsAsFactors=F)
NightLordVPrior <- list()
NightLordVPrior$N4 <- c("QuadrapleThrow-MarkofNightLord-DarkFlare", "QuadrapleThrow-MarkofNightLord-DarkFlare", 
                        "UltimateDarkSight", "ReadyToDie", "SpreadThrow", "ThrowBlasting", "SecretBook", "ThrowingKnife", "MapleWarriors2", "Blink", "SpiderInMirror", "RopeConnect", 
                        "SuddenRaid-Showdown-FourSeasons", "SuddenRaid-Showdown-FourSeasons")

## Shadower
ShadowerVPassive <- list()
ShadowerVPassive$N4 <- data.frame(Skills=c("Assassination", "MesoExplosion", "CruelStab", "VeilofShadow", "DarkFlare", "SuddenRaid"), 
                                  Lv=c(50, 50, 50, 50, 50, 50), 
                                  stringsAsFactors=F)
ShadowerVPrior <- list()
ShadowerVPrior$N4 <- c("Assassination-MesoExplosion-DarkFlare", "Assassination-MesoExplosion-DarkFlare", 
                       "UltimateDarkSight", "SonicBlow", "Eviscerate", "Myeolgwichamyeongjin", "ReadyToDie", "MapleWarriors2", "Blink", 
                       "CruelStab-VeilofShadow-SuddenRaid", "CruelStab-VeilofShadow-SuddenRaid", 
                       "SpiderInMirror", "RopeConnect", "ShadowAssault")

## DualBlade
DualBladeVPassive <- list()
DualBladeVPassive$N4 <- data.frame(Skills=c("PhantomBlow", "HiddenBlade", "Asura", "BladeFury", "SuddenRaid", "BladeAscension"), 
                                   Lv=c(50, 50, 50, 50, 50, 50), 
                                   stringsAsFactors=F)
DualBladeVPrior <- list()
DualBladeVPrior$N4 <- c("BladeTornado", "BladeStorm", "UltimateDarkSight", 
                        "PhantomBlow-HiddenBlade-Asura", "PhantomBlow-HiddenBlade-Asura", 
                        "KarmaFury", "ReadyToDie", "MapleWarriors2", "HuntedEdge", "Blink", "SpiderInMirror", "RopeConnect", 
                        "BladeFury-SuddenRaid-BladeAscension", "BladeFury-SuddenRaid-BladeAscension")

## Viper
ViperVPassive <- list()
ViperVPassive$N4 <- data.frame(Skills=c("FistEnrage", "SeaSerpentEnrage_SerpentAssaultEnrage", "Nautilus", "SeaSerpentBust_SerpentAssault", "ScrewPunch", "HookBomber"), 
                               Lv=c(50, 50, 50, 50, 50, 50), 
                               stringsAsFactors=F)
ViperVPrior <- list()
ViperVPrior$N4 <- c("SerpentScrew", 
                    "FistEnrage-SeaSerpentEnrage_SerpentAssaultEnrage-Nautilus", "FistEnrage-SeaSerpentEnrage_SerpentAssaultEnrage-Nautilus", 
                    "PirateFlag", "OverDrive", "HawlingFist", "LightningForm", "FuriousCharge", "MapleWarriors2", "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect", 
                    "SeaSerpentBust_SerpentAssault-ScrewPunch-HookBomber", "SeaSerpentBust_SerpentAssault-ScrewPunch-HookBomber")

## Captain
CaptainVPassive <- list()
CaptainVPassive$N4 <- data.frame(Skills=c("RapidFire", "SeizeBomber", "BattleShipBomber", "HeadShot", "CaptainDignity", "Fusilrade"), 
                                 Lv=c(50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
CaptainVPassive$N5 <- data.frame(Skills=c("RapidFire", "SeizeBomber", "BattleShipBomber", "HeadShot", "CaptainDignity", "SummonCrew", "Fusilrade", "StrangeBomb"), 
                                 Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                 stringsAsFactors=F)
CaptainVPrior <- list()
CaptainVPrior$N4 <- c("RapidFire-BattleShipBomber-CaptainDignity", "RapidFire-BattleShipBomber-CaptainDignity", 
                      "PirateFlag", "DeathTrigger", "NautilusAssault", 
                      "SeizeBomber-HeadShot-Fusilrade", "SeizeBomber-HeadShot-Fusilrade", 
                      "DeadEye", "MapleWarriors2", "OverDrive", "LoadedDice", "Blink", "BulletParty", "SpiderInMirror", "RopeConnect")
CaptainVPrior$N5 <- c("RapidFire-BattleShipBomber-CaptainDignity", "RapidFire-BattleShipBomber-CaptainDignity", 
                      "PirateFlag", "DeathTrigger", "NautilusAssault", 
                      "SeizeBomber-HeadShot-SummonCrew", "SeizeBomber-HeadShot-Fusilrade", 
                      "DeadEye", "MapleWarriors2", "OverDrive", 
                      "SummonCrew-Fusilrade-StrangeBomb", 
                      "BulletParty", "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect")

## CannonShooter
CannonShooterVPassive <- list()
CannonShooterVPassive$N4 <- data.frame(Skills=c("CannonBuster", "RollingCannonRainbow", "SupportMonkeyTwins", "MonkeyFurious_MiniCannonball", "BarrelRoulette", "CannonBazuka"), 
                                       Lv=c(50, 50, 50, 50, 50, 50), 
                                       stringsAsFactors=F)
CannonShooterVPassive$N5 <- data.frame(Skills=c("CannonBuster", "RollingCannonRainbow", "SupportMonkeyTwins", "MonkeyFurious_MiniCannonball", "BarrelRoulette", "CannonBazuka", "MagneticAnchor", "Nautilus"), 
                                       Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                       stringsAsFactors=F)
CannonShooterVPrior <- list()
CannonShooterVPrior$N4 <- c("CannonBuster-RollingCannonRainbow-SupportMonkeyTwins", "CannonBuster-RollingCannonRainbow-SupportMonkeyTwins", 
                            "OverDrive", "PirateFlag", "Cocoball", "ICBM", "SpecialMonkeyEscort", "PoolMaker", "MapleWarriors2", 
                            "MonkeyFurious_MiniCannonball-BarrelRoulette-CannonBazuka", "MonkeyFurious_MiniCannonball-BarrelRoulette-CannonBazuka", 
                            "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect")
CannonShooterVPrior$N5 <- c("CannonBuster-RollingCannonRainbow-SupportMonkeyTwins", "CannonBuster-RollingCannonRainbow-SupportMonkeyTwins", 
                            "OverDrive", "PirateFlag", "Cocoball", "ICBM", "SpecialMonkeyEscort", "PoolMaker", "MapleWarriors2",
                            "MonkeyFurious_MiniCannonball-BarrelRoulette-MagneticAnchor", "MonkeyFurious_MiniCannonball-BarrelRoulette-CannonBazuka", 
                            "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect", "MagneticAnchor-CannonBazuka-Nautilus")

## Mikhail
MikhailVPassive <- list()
MikhailVPassive$N4 <- data.frame(Skills=c("SoulAssault", "ShiningCross", "RoyalGuard", "AdvancedFinalAttack", "DeadlyCharge", "ShiningChase"), 
                                 Lv=c(50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
MikhailVPrior <- list()
MikhailVPrior$N4 <- c("SwordofSoulLight", 
                      "SoulAssault-ShiningCross-RoyalGuard", "SoulAssault-ShiningCross-RoyalGuard", 
                      "CygnusPhalanx", "ClaiomhSolais", "RhoAias", "AuraWeapon",
                      "AdvancedFinalAttack-DeadlyCharge-ShiningChase", "AdvancedFinalAttack-DeadlyCharge-ShiningChase", 
                      "BlessofCygnus", "LightofCourage", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")

## SoulMaster
SoulMasterVPassive <- list()
SoulMasterVPassive$N4 <- data.frame(Skills=c("DanceofMoon_SpeedingSunset", "CrosstheStyx", "SolarPierce_CrescentDivide", "SolunarSlash", "SunCross_MoonCross", "MoonShadow_LightFlux"), 
                                   Lv=c(50, 50, 50, 50, 50, 50), 
                                   stringsAsFactors=F)
SoulMasterVPrior <- list()
SoulMasterVPrior$N4 <- c("DanceofMoon_SpeedingSunset-CrosstheStyx-SolunarSlash", "DanceofMoon_SpeedingSunset-CrosstheStyx-SolunarSlash", 
                         "CelestialDance", "FlareSlash", "SoulEclipse", "AuraWeapon", "CygnusPhalanx", "BlessofCygnus", "Elysion", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect", 
                         "SolarPierce_CrescentDivide-SunCross_MoonCross-MoonShadow_LightFlux", "SolarPierce_CrescentDivide-SunCross_MoonCross-MoonShadow_LightFlux")

## FlameWizard
FlameWizardVPassive <- list()
FlameWizardVPassive$N3 <- data.frame(Skills=c("OrbitalFlame", "DragonSlave", "Infernorise", "BlazingExtinction", "Cataclysm"), 
                                     Lv=c(50, 50, 50, 50, 25), 
                                     stringsAsFactors=F)
FlameWizardVPrior <- list()
FlameWizardVPrior$N3 <- c("InfinityFlameCircle", 
                          "OrbitalFlame-BlazingExtinction-DragonSlave", "OrbitalFlame-BlazingExtinction-Infernorise", 
                          "SalamanderMischief", "BlazingOrbitalFlame", "CygnusPhalanx", "OverloadMana", "FlameDischarge", "BlessofCygnus", "Blink", "SpiderInMirror", "RopeConnect", 
                          "Infernorise-DragonSlave-Cataclysm")

## WindBreaker
WindBreakerVPassive <- list()
WindBreakerVPassive$N4 <- data.frame(Skills=c("SongofSky", "TriflingWhim", "StormBringer", "FairyTurn", "PinpointPierce", "Monsoon"), 
                                     Lv=c(50, 50, 50, 50, 50, 50), 
                                     stringsAsFactors=F)
WindBreakerVPrior <- list()
WindBreakerVPrior$N4 <- c("SongofSky-TriflingWhim-StormBringer", "SongofSky-TriflingWhim-StormBringer", 
                          "HowlingGale", "VortexSphere", "CriticalReinforce", "IdleWhim", "CygnusPhalanx", "WindWall", "GuidedArrow", "BlessofCygnus", "Blink", "SpiderInMirror", "RopeConnect", 
                          "FairyTurn-PinpointPierce-Monsoon", "FairyTurn-PinpointPierce-Monsoon")

## NightWalker
NightWalkerVPassive <- list()
NightWalkerVPassive$N2 <- data.frame(Skills=c("QuintupleThrow", "ShadowBat", "Dominion"), 
                                     Lv=c(50, 50, 50), 
                                     stringsAsFactors=F)
NightWalkerVPrior <- list()
NightWalkerVPrior$N2 <- c("QuintupleThrow-ShadowBat-Dominion", "QuintupleThrow-ShadowBat-Dominion", 
                          "ShadowSpear", "RapidThrow", "ShadowBite", "ShadowServantExtend", "CygnusPhalanx", "ReadyToDie", "BlessofCygnus", "Blink", "SpiderInMirror", "RopeConnect")

## Striker
StrikerVPassive <- list()
StrikerVPassive$N4 <- data.frame(Skills=c("Annihilate", "Thunderbolt", "Typhoon", "DeepRising", "TidalCrash", "Ascension", "Thunder"), 
                                 Lv=c(50, 50, 50, 50, 50, 25, 25), 
                                 stringsAsFactors=F)
StrikerVPrior <- list()
StrikerVPrior$N4 <- c("Annihilate-Thunderbolt-DeepRising", "Annihilate-Thunderbolt-DeepRising", 
                      "OverDrive", "SharkTorpedo", "LightningGodSpearStrike", "LightningSpearMultistrike", "LightningCascade", "CygnusPhalanx", "BlessofCygnus", "Blink", "LoadedDice", "SpiderInMirror", 
                      "Typhoon-TidalCrash-Ascension", "Typhoon-TidalCrash-Thunder", 
                      "RopeConnect")

## Blaster
BlasterVPassive <- list()
BlasterVPassive$N4 <- data.frame(Skills=c("MagnumPunch", "DoubleFang", "RevolvingCannon", "ReleasePileBunker", "HammerSmash", "ShockWavePunch"), 
                                 Lv=c(50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
BlasterVPrior <- list()
BlasterVPrior$N4 <- c("MagnumPunch-DoubleFang-RevolvingCannon", "MagnumPunch-DoubleFang-RevolvingCannon", 
                      "BunkerBuster", "VulcanPunch", "BurningBreaker", "AfterimageShock", 
                      "ReleasePileBunker-HammerSmash-ShockWavePunch", "ReleasePileBunker-HammerSmash-ShockWavePunch", 
                      "AuraWeapon", "ResistanceLineInfantry", "MapleWarriors2", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")


## BattleMage
BattleMageVPassive <- list()
BattleMageVPassive$N4 <- data.frame(Skills=c("FinishBlow", "DarkLightning", "DarkGenesis", "Death", "BattleKingBar", "DarkChain"), 
                                    Lv=c(50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
BattleMageVPrior <- list()
BattleMageVPrior$N4 <- c("FinishBlow-DarkLightning-Death", "FinishBlow-DarkLightning-Death", 
                        "UnionAura", "BlackMagicAltar", "AbyssalLightning", "GrimReeper", "OverloadMana", "ResistanceLineInfantry", "MapleWarriors2", 
                        "DarkGenesis-BattleKingBar-DarkChain", "DarkGenesis-BattleKingBar-DarkChain",
                        "Blink", "SpiderInMirror", "RopeConnect")

## WildHunter
WildHunterVPassive <- list()
WildHunterVPassive$N4 <- data.frame(Skills=c("WildVulcan", "AnotherBite_SummonJaguar", "AdvancedFinalAttack", "RampageasOne", "AssistantHuntingUnit", "SonicBoom_JaguarSoul"), 
                                    Lv=c(50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
WildHunterVPassive$N5 <- data.frame(Skills=c("WildVulcan", "AnotherBite_SummonJaguar", "AdvancedFinalAttack", "RampageasOne", "AssistantHuntingUnit", "SonicBoom_JaguarSoul", 
                                             "ClawCut", "DrillContainer"), 
                                    Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                    stringsAsFactors=F)
WildHunterVPassive$N6 <- data.frame(Skills=c("WildVulcan", "AnotherBite_SummonJaguar", "AdvancedFinalAttack", "RampageasOne", "AssistantHuntingUnit", "SonicBoom_JaguarSoul", 
                                             "ClawCut", "DrillContainer", "CrossRoad"), 
                                    Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                                    stringsAsFactors=F)
WildHunterVPrior <- list()
WildHunterVPrior$N4 <- c("JaguarStorm", 
                         "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", 
                         "AdvancedFinalAttack-AssistantHuntingUnit-SonicBoom_JaguarSoul", "AdvancedFinalAttack-AssistantHuntingUnit-SonicBoom_JaguarSoul", 
                         "WildVulcanTypeX", "CriticalReinforce", "MapleWarriors2", "WildGrenade", "JaguarMaximum", "ResistanceLineInfantry", "GuidedArrow",
                         "Blink", "SpiderInMirror", "RopeConnect")
WildHunterVPrior$N5 <- c("JaguarStorm", 
                         "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", 
                         "AdvancedFinalAttack-AssistantHuntingUnit-SonicBoom_JaguarSoul", "AdvancedFinalAttack-ClawCut-SonicBoom_JaguarSoul", "ClawCut-AssistantHuntingUnit-DrillContainer", 
                         "WildVulcanTypeX", "CriticalReinforce", "MapleWarriors2", "WildGrenade", "JaguarMaximum", "ResistanceLineInfantry", "GuidedArrow",
                         "Blink", "SpiderInMirror", "RopeConnect")
WildHunterVPrior$N6 <- c("JaguarStorm", 
                         "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", "WildVulcan-AnotherBite_SummonJaguar-RampageasOne", 
                         "AdvancedFinalAttack-AssistantHuntingUnit-SonicBoom_JaguarSoul", "AdvancedFinalAttack-AssistantHuntingUnit-SonicBoom_JaguarSoul", 
                         "WildVulcanTypeX", "CriticalReinforce", "MapleWarriors2", 
                         "ClawCut-DrillContainer-CrossRoad", "ClawCut-DrillContainer-CrossRoad", 
                         "WildGrenade", "JaguarMaximum", "ResistanceLineInfantry", "GuidedArrow",
                         "Blink", "SpiderInMirror", "RopeConnect")


## Mechanic
MechanicVPassive <- list()
MechanicVPassive$N4 <- data.frame(Skills=c("MassiveFire", "HomingMissile", "DistortionField", "RM7", "RM1", "MagneticField"), 
                                  Lv=c(50, 50, 50, 50, 50, 50), 
                                  stringsAsFactors=F)
MechanicVPrior <- list()
MechanicVPrior$N4 <- c("MassiveFire-HomingMissile-DistortionField", "MassiveFire-HomingMissile-DistortionField", 
                       "MicroMissileContainer", "MechCarrier", "OverDrive", "MetalArmorFullburst", "MultipleOption", "MapleWarriors2", 
                       "RM7-RM1-MagneticField", "RM7-RM1-MagneticField", 
                       "ResistanceLineInfantry", "Blink", "LoadedDice", "SpiderInMirror", "RopeConnect")

## Xenon
XenonVPassive <- list()
XenonVPassive$N4 <- data.frame(Skills=c("FuzzylopMasquerade", "TriangleFormation", "HologramGrafity", "PinpointRocket", "MeltdownExplosion", "AegisSystem"), 
                               Lv=c(50, 50, 50, 50, 50, 50), 
                               stringsAsFactors=F)
XenonVPrior <- list()
XenonVPrior$N4 <- c("MegaSmasher", 
                    "FuzzylopMasquerade-TriangleFormation-HologramGrafity", "FuzzylopMasquerade-TriangleFormation-HologramGrafity", 
                    "HologramGrafityFusion", "PhotonRay", "OverDrive", "ResistanceLineInfantry", "ReadyToDie", "MapleWarriors2", "OverloadMode", 
                    "PinpointRocket-MeltdownExplosion-AegisSystem", "PinpointRocket-MeltdownExplosion-AegisSystem", 
                    "Blink", "LoadedDice", "SpiderInMirror", "RopeConnect")

## DemonSlayer
DemonSlayerVPassive <- list()
DemonSlayerVPassive$N4 <- data.frame(Skills=c("DemonImpact", "DemonSlash", "Cerberus", "DevilCry", "Metamorphosis", "DemonExplosion"), 
                                     Lv=c(50, 50, 50, 50, 50, 50), 
                                     stringsAsFactors=F)
DemonSlayerVPrior <- list()
DemonSlayerVPrior$N4 <- c("DemonImpact-DemonSlash-Metamorphosis", "DemonImpact-DemonSlash-Metamorphosis", 
                          "DemonAwakening", "Orthros", "Jormungand", "DemonBane", "AuraWeapon", "BlessofIsekaiGoddess", 
                          "Cerberus-DevilCry-DemonExplosion", "Cerberus-DevilCry-DemonExplosion",
                          "Blink", "CallMastema", "SpiderInMirror", "BodyofSteel", "RopeConnect")

## DemonAvenger
DemonAvengerVPassive <- list()
DemonAvengerVPassive$N4 <- data.frame(Skills=c("ExceedExecution", "ShieldChasing", "ExceedMoonlightSlash", "EnhancedExceed", "ArmorBreak", "ThousandSword"), 
                                      Lv=c(50, 50, 50, 50, 50, 50), 
                                      stringsAsFactors=F)
DemonAvengerVPrior <- list()
DemonAvengerVPrior$N4 <- c("ExceedExecution-ShieldChasing-EnhancedExceed", "ExceedExecution-ShieldChasing-EnhancedExceed", 
                           "DemonFrenzy", "DimensionSword", "AuraWeapon", "BloodFeast", "BlessofIsekaiGoddess", "Revenant", "CallMastema", "Blink", "SpiderInMirror", 
                           "ExceedMoonlightSlash-ArmorBreak-ThousandSword", "ExceedMoonlightSlash-ArmorBreak-ThousandSword", 
                           "BodyofSteel", "RopeConnect")

## Aran
AranVPassive <- list()
AranVPassive$N4 <- data.frame(Skills=c("Swing", "FinalBlow", "Beyonder", "HuntersTargeting", "FinalAttack", "ZoneofMaha"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
AranVPrior <- list()
AranVPrior$N4 <- c("FinalBlow-Beyonder-HuntersTargeting", "FinalBlow-Beyonder-HuntersTargeting", 
                   "FenrirCrash", "BlizardTempest", 
                   "Swing-FinalAttack-ZoneofMaha", "Swing-FinalAttack-ZoneofMaha",
                   "AuraWeapon", "InstallMaha", "MapleWarriors2", "BrandishMaha", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect", "FreudBlessing")

## Evan
EvanVPassive <- list()
EvanVPassive$N4 <- data.frame(Skills=c("CircleofMana", "CircleofEarth_BrethofEarth_DiveofEarth", "DragonBreath_BreathReturn", 
                                       "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "DragonSparking"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
EvanVPassive$N5 <- data.frame(Skills=c("CircleofMana", "CircleofEarth_BrethofEarth_DiveofEarth", "DragonBreath_BreathReturn", 
                                       "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "DragonSparking", 
                                       "MagicFragment", "SummonOnixDragon"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                              stringsAsFactors=F)
EvanVPassive$N6 <- data.frame(Skills=c("CircleofMana", "CircleofEarth_BrethofEarth_DiveofEarth", "DragonBreath_BreathReturn", 
                                       "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "DragonSparking", 
                                       "MagicFragment", "SummonOnixDragon", "DragonDive"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
EvanVPassive$N7 <- data.frame(Skills=c("CircleofMana", "CircleofEarth_BrethofEarth_DiveofEarth", "DragonBreath_BreathReturn", 
                                       "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "DragonSparking", 
                                       "MagicFragment", "SummonOnixDragon", "DragonDive", 
                                       "DragonSwift", "DarkFog"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 25), 
                              stringsAsFactors=F)
EvanVPassive$N8 <- data.frame(Skills=c("CircleofMana", "CircleofEarth_BrethofEarth_DiveofEarth", "DragonBreath_BreathReturn", 
                                       "CircleofWind_SwiftofWind_BreathofWind", "CircleofThunder_SwiftofThunder_DiveofThunder", "DragonSparking", 
                                       "MagicFragment", "SummonOnixDragon", "DragonDive", 
                                       "DragonSwift", "DarkFog", "DragonMaster"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
EvanVPrior <- list()
EvanVPrior$N4 <- c("CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", "CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", 
                   "JodiacRay", "DragonBreak", "OverloadMana", "MapleWarriors2", "ElementalBlast", "SpiralofMana", 
                   "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", 
                   "Blink", "SpiderInMirror", "RopeConnect", "FreudBlessing")
EvanVPrior$N5 <- c("CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", "CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", 
                   "JodiacRay", "DragonBreak", "OverloadMana", "MapleWarriors2", "ElementalBlast", "SpiralofMana", 
                   "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-MagicFragment", 
                   "DragonSparking-MagicFragment-SummonOnixDragon", 
                   "Blink", "SpiderInMirror", "RopeConnect", "FreudBlessing")
EvanVPrior$N6 <- c("CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", "CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", 
                   "JodiacRay", "DragonBreak", "OverloadMana", "MapleWarriors2", "ElementalBlast", "SpiralofMana", 
                   "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking",
                   "MagicFragment-SummonOnixDragon-DragonDive", "MagicFragment-SummonOnixDragon-DragonDive", 
                   "Blink", 
                   "SpiderInMirror", "RopeConnect", "FreudBlessing")
EvanVPrior$N7 <- c("CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", "CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", 
                   "JodiacRay", "DragonBreak", "OverloadMana", "MapleWarriors2", "ElementalBlast", "SpiralofMana", 
                   "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", 
                   "MagicFragment-SummonOnixDragon-DragonDive", 
                   "Blink", 
                   "MagicFragment-SummonOnixDragon-DarkFog", 
                   "SpiderInMirror", 
                   "DragonDive-DarkFog-DragonSwift", 
                   "RopeConnect", "FreudBlessing")
EvanVPrior$N8 <- c("CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", "CircleofMana-CircleofEarth_BrethofEarth_DiveofEarth-DragonBreath_BreathReturn", 
                   "JodiacRay", "DragonBreak", "OverloadMana", "MapleWarriors2", "ElementalBlast", "SpiralofMana", 
                   "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", "CircleofWind_SwiftofWind_BreathofWind-CircleofThunder_SwiftofThunder_DiveofThunder-DragonSparking", 
                   "MagicFragment-SummonOnixDragon-DragonDive", "MagicFragment-SummonOnixDragon-DragonDive", 
                   "Blink", 
                   "SpiderInMirror", "RopeConnect", 
                   "DragonMaster-DarkFog-DragonSwift", "DragonMaster-DarkFog-DragonSwift", 
                   "FreudBlessing")


## Luminous
LuminousVPassive <- list()
LuminousVPassive$N2 <- data.frame(Skills=c("LightReflection", "Apocalypse", "AbsoluteKill"), 
                                  Lv=c(50, 50, 50), 
                                  stringsAsFactors=F)
LuminousVPrior <- list()
LuminousVPrior$N2 <- c("LightReflection-Apocalypse-AbsoluteKill", "LightReflection-Apocalypse-AbsoluteKill", 
                       "BaptismofLightandDarkness", "PunishingResonator", "OverloadMana", "LiberationOrb", "MapleWarriors2", "DoorofTruth", "Blink", "SpiderInMirror", "RopeConnect", "FreudBlessing")

## Mercedes
MercedesVPassive <- list()
MercedesVPassive$N4 <- data.frame(Skills=c("RingofIshtar", "AdvancedStrikeDualShot_AdvancedFinalAttack", "LeafTornado_GustDive", "ElementalKnight", "WrathofEnlil", "UnicornSpike"), 
                                  Lv=c(50, 50, 50, 50, 50, 50), 
                                  stringsAsFactors=F)
MercedesVPassive$N5 <- data.frame(Skills=c("RingofIshtar", "AdvancedStrikeDualShot_AdvancedFinalAttack", "LeafTornado_GustDive", "ElementalKnight", "WrathofEnlil", "UnicornSpike", "LegendrySpear", "RollingMoonsault"), 
                                  Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                  stringsAsFactors=F)
MercedesVPrior <- list()
MercedesVPrior$N4 <- c("RingofIshtar-AdvancedStrikeDualShot_AdvancedFinalAttack-WrathofEnlil", "RingofIshtar-AdvancedStrikeDualShot_AdvancedFinalAttack-WrathofEnlil", 
                       "ElementalGhost", "BreathofIrkalla", "RoyalKnights", "CriticalReinforce", "MapleWarriors2", "GuidedArrow", 
                       "LeafTornado_GustDive-ElementalKnight-UnicornSpike", "LeafTornado_GustDive-ElementalKnight-UnicornSpike", 
                       "Blink", "Sylvidia", "SpiderInMirror", "RopeConnect", "FreudBlessing")
MercedesVPrior$N5 <- c("RingofIshtar-AdvancedStrikeDualShot_AdvancedFinalAttack-WrathofEnlil", "RingofIshtar-AdvancedStrikeDualShot_AdvancedFinalAttack-WrathofEnlil", 
                       "ElementalGhost", "BreathofIrkalla", "RoyalKnights", "CriticalReinforce", "MapleWarriors2", "GuidedArrow", 
                       "LegendrySpear-ElementalKnight-UnicornSpike", "LeafTornado_GustDive-ElementalKnight-UnicornSpike", 
                       "Blink", "Sylvidia", "SpiderInMirror", 
                       "LegendrySpear-LeafTornado_GustDive-RollingMoonsault", 
                       "RopeConnect", "FreudBlessing")

## Phantom
PhantomVPassive <- list()
PhantomVPassive$N4 <- data.frame(Skills=c("UltimateDrive", "TempestofCard", "NoirCarte", "RoseCarteFinale", "Twilight", "TalentofPhantomThief4"), 
                                 Lv=c(50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
PhantomVPrior <- list()
PhantomVPrior$N4 <- c("UltimateDrive-TempestofCard-NoirCarte", "UltimateDrive-TempestofCard-NoirCarte", 
                      "BlackJack", "Joker", "MarkofPhantom", "LiftBreak", "ReadyToDie", "MapleWarriors2", 
                      "RoseCarteFinale-Twilight-TalentofPhantomThief4", "RoseCarteFinale-Twilight-TalentofPhantomThief4", 
                      "Blink", "SpiderInMirror", "RopeConnect", "FreudBlessing")

## Eunwol
EunwolVPassive <- list()
EunwolVPassive$N4 <- data.frame(Skills=c("Gwicham", "SohonJangmak", "Bulyeouryeong", "JeongryeongeuiHwasin", "PashwaeCheoljoHoe", "Pokryugwon"), 
                                Lv=c(50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
EunwolVPrior <- list()
EunwolVPrior$N4 <- c("Gwicham-SohonJangmak-Bulyeouryeong", "Gwicham-SohonJangmak-Bulyeouryeong", 
                     "OverDrive", "JeongryeongJipsok", "Gwimunjin", "PashwaeYeongwon", "JinGwicham", "MapleWarriors2", "Blink", "LoadedDice", 
                     "JeongryeongeuiHwasin-PashwaeCheoljoHoe-Pokryugwon", "JeongryeongeuiHwasin-PashwaeCheoljoHoe-Pokryugwon", 
                     "SpiderInMirror", "RopeConnect", "FreudBlessing")

## Kaiser
KaiserVPassive <- list()
KaiserVPassive$N4 <- data.frame(Skills=c("GigaSlasher", "WillofSword", "SwordStrike", "Wingbeat", "Prominance", "InfernalBreath"), 
                                Lv=c(50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
KaiserVPassive$N5 <- data.frame(Skills=c("GigaSlasher", "WillofSword", "SwordStrike", "Wingbeat", "Prominance", "InfernalBreath", "Petrified", "BlueStreak"), 
                                Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                stringsAsFactors=F)
KaiserVPrior <- list()
KaiserVPrior$N4 <- c("GigaSlasher-WillofSword-Wingbeat", "GigaSlasher-WillofSword-Wingbeat", 
                     "DracoSlasher", "BlessofGrandisGoddess", "DragonBlaze", "WillofSwordStrike", "GuardianofNova", "AuraWeapon", 
                     "SwordStrike-Prominance-InfernalBreath", "SwordStrike-Prominance-InfernalBreath", 
                     "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")
KaiserVPrior$N5 <- c("GigaSlasher-WillofSword-Wingbeat", "GigaSlasher-WillofSword-Wingbeat", 
                     "DracoSlasher", "BlessofGrandisGoddess", "DragonBlaze", "WillofSwordStrike", "GuardianofNova", "AuraWeapon", 
                     "Petrified-Prominance-InfernalBreath", "SwordStrike-Prominance-InfernalBreath", 
                     "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect", 
                     "Petrified-SwordStrike-BlueStreak")
                     
## Kain
KainVPassive <- list()
KainVPassive$N4 <- data.frame(Skills=c("StrikeArrow_ChasingShot", "DeathBlessing_SneakySniping", "DragonFang_RemainIncense", 
                                       "ShaftBreak", "ScatteringShot", "ChainSickle_PoisonNeedle"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
KainVPassive$N5 <- data.frame(Skills=c("StrikeArrow_ChasingShot", "DeathBlessing_SneakySniping", "DragonFang_RemainIncense", 
                                       "ShaftBreak", "ScatteringShot", "ChainSickle_PoisonNeedle", 
                                       "FallingDust", "PhantomBlade_TearingKnife"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                              stringsAsFactors=F)
KainVPassive$N6 <- data.frame(Skills=c("StrikeArrow_ChasingShot", "DeathBlessing_SneakySniping", "DragonFang_RemainIncense", 
                                       "ShaftBreak", "ScatteringShot", "ChainSickle_PoisonNeedle", 
                                       "FallingDust", "PhantomBlade_TearingKnife"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
KainVPrior <- list()
KainVPrior$N4 <- c("StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", "StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", 
                   "CriticalReinforce", "ThanatosDescent", 
                   "ShaftBreak-ScatteringShot-ChainSickle_PoisonNeedle", "ShaftBreak-ScatteringShot-ChainSickle_PoisonNeedle",
                   "GripofAgony", "DargonBurst", "FatalBlitz", "GuidedArrow", "BlessofGrandisGoddess",
                   "Blink", "SpiderInMirror", "RopeConnect")
KainVPrior$N5 <- c("StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", "StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", 
                   "CriticalReinforce", "ThanatosDescent",
                   "FallingDust-ScatteringShot-ChainSickle_PoisonNeedle", "ShaftBreak-ScatteringShot-ChainSickle_PoisonNeedle",
                   "GripofAgony", "DargonBurst", "FatalBlitz", 
                   "FallingDust-ShaftBreak-PhantomBlade_TearingKnife", 
                   "GuidedArrow", "BlessofGrandisGoddess", "Blink", "SpiderInMirror", "RopeConnect")
KainVPrior$N6 <- c("StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", "StrikeArrow_ChasingShot-DeathBlessing_SneakySniping-DragonFang_RemainIncense", 
                   "CriticalReinforce", "ThanatosDescent",
                   "FallingDust-ScatteringShot-ChainSickle_PoisonNeedle", "ShaftBreak-ScatteringShot-ChainSickle_PoisonNeedle",
                   "GripofAgony", "DargonBurst", "FatalBlitz", 
                   "FallingDust-ShaftBreak-PhantomBlade_TearingKnife", 
                   "GuidedArrow", "BlessofGrandisGoddess", "Blink", "PhantomBlade_TearingKnife-FallingDust-ShaftBreak", "SpiderInMirror", "RopeConnect")

## Cadena
CadenaVPassive <- list()
CadenaVPassive$N4 <- data.frame(Skills=c("ChainArtsStroke_WeaponVariety", "BittingNeedlebat", "ChainArtsCrush_ProfessionalAgent", 
                                         "ShootingShotgun_ReleasingBomb", "SlashingKnife_ThrowingWingdagger", "CuttingScimitar_ScratchingClaw"), 
                                Lv=c(50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
CadenaVPassive$N5 <- data.frame(Skills=c("ChainArtsStroke_WeaponVariety", "BittingNeedlebat", "ChainArtsCrush_ProfessionalAgent", 
                                         "ShootingShotgun_ReleasingBomb", "SlashingKnife_ThrowingWingdagger", "CuttingScimitar_ScratchingClaw", 
                                         "StrikingBrick", "ChainArtsTakedown"), 
                                Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                stringsAsFactors=F)
CadenaVPrior <- list()
CadenaVPrior$N4 <- c("ChainArtsStroke_WeaponVariety-BittingNeedlebat-ChainArtsCrush_ProfessionalAgent", "ChainArtsStroke_WeaponVariety-BittingNeedlebat-ChainArtsCrush_ProfessionalAgent", 
                     "ChainArtsMaelstrom", "ADOrdnance", 
                     "ShootingShotgun_ReleasingBomb-SlashingKnife_ThrowingWingdagger-CuttingScimitar_ScratchingClaw", "ShootingShotgun_ReleasingBomb-SlashingKnife_ThrowingWingdagger-CuttingScimitar_ScratchingClaw", 
                     "ChainArtsFury", "ReadyToDie", "WeaponVarietyFinale", "BlessofGrandisGoddess", "Blink", "SpiderInMirror", "RopeConnect", "VenomBurst", "Pantheon")
CadenaVPrior$N5 <- c("ChainArtsStroke_WeaponVariety-BittingNeedlebat-ChainArtsCrush_ProfessionalAgent", "ChainArtsStroke_WeaponVariety-BittingNeedlebat-ChainArtsCrush_ProfessionalAgent", 
                     "ChainArtsMaelstrom", "ADOrdnance", 
                     "ShootingShotgun_ReleasingBomb-SlashingKnife_ThrowingWingdagger-CuttingScimitar_ScratchingClaw", "ShootingShotgun_ReleasingBomb-SlashingKnife_ThrowingWingdagger-StrikingBrick", 
                     "ChainArtsFury", "ReadyToDie", "WeaponVarietyFinale", 
                     "CuttingScimitar_ScratchingClaw-StrikingBrick-ChainArtsTakedown", 
                     "BlessofGrandisGoddess", "Blink", "SpiderInMirror", "RopeConnect", "VenomBurst", "Pantheon")

## AngelicBuster
AngelicBusterVPassive <- list()
AngelicBusterVPassive$N4 <- data.frame(Skills=c("Trinity", "SoulSeeker", "SuperNova", "PrimalRoar", "FinituraPettuccia", "SoulResonance"), 
                                       Lv=c(50, 50, 50, 50, 50, 50), 
                                       stringsAsFactors=F)
AngelicBusterVPrior <- list()
AngelicBusterVPrior$N4 <- c("Trinity-SoulSeeker-SuperNova", "Trinity-SoulSeeker-SuperNova", 
                            "OverDrive", "Spotlight", "MascotFamiliar", "TrinityFusion", "BlessofGrandisGoddess", "EnergeBust", "Blink", "LoadedDice", "SpiderInMirror", "RopeConnect", 
                            "PrimalRoar-FinituraPettuccia-SoulResonance", "PrimalRoar-FinituraPettuccia-SoulResonance", 
                            "Pantheon")

## Adele
AdeleVPassive <- list()
AdeleVPassive$N4 <- data.frame(Skills=c("Divide", "Order_Grave", "Territory_Tred", "Creation_Gathering", "Blossom", "Shard_Wonder"), 
                               Lv=c(50, 50, 50, 50, 50, 50), 
                               stringsAsFactors=F)
AdeleVPassive$N5 <- data.frame(Skills=c("Divide", "Order_Grave", "Territory_Tred", "Creation_Gathering", "Blossom", "Shard_Wonder", "Impale_Resonance_Marker", "Punto"), 
                               Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                               stringsAsFactors=F)
AdeleVPrior <- list()
AdeleVPrior$N4 <- c("Divide-Order_Grave-Creation_Gathering", "Divide-Order_Grave-Creation_Gathering", 
                    "Infinite", 
                    "Territory_Tred-Blossom-Shard_Wonder", "Territory_Tred-Blossom-Shard_Wonder", 
                    "AuraWeapon", "Restore", "Ruin", "Storm", "BlessofGrandisGoddess", "MagicCircuitFullDrive", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")
AdeleVPrior$N5 <- c("Divide-Order_Grave-Creation_Gathering", "Divide-Order_Grave-Creation_Gathering", 
                    "Infinite", 
                    "Territory_Tred-Blossom-Shard_Wonder", "Territory_Tred-Blossom-Impale_Resonance_Marker", 
                    "AuraWeapon", "Restore", "Ruin", "Storm", "BlessofGrandisGoddess", "MagicCircuitFullDrive", 
                    "Shard_Wonder-Impale_Resonance_Marker-Punto", 
                    "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")

## Illium
IlliumVPassive <- list()
IlliumVPassive$N4 <- data.frame(Skills=c("Javelin_EnhancedJavelin", "Destruction", "Machina_Domination", "Deus_Liyo", "CurseMark", "MotalSwing_MotalWingBeat"), 
                                Lv=c(50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
IlliumVPassive$N5 <- data.frame(Skills=c("Javelin_EnhancedJavelin", "Destruction", "Machina_Domination", "Deus_Liyo", "CurseMark", "MotalSwing_MotalWingBeat", "Longinus", "LonginusZone"), 
                                Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                stringsAsFactors=F)
IlliumVPrior <- list()
IlliumVPrior$N4 <- c("Javelin_EnhancedJavelin-Destruction-Deus_Liyo", "Javelin_EnhancedJavelin-Destruction-Deus_Liyo", 
                     "CrystalIgnition", "SoulofCrystal", "OverloadMana", "CrystalGate", "Gramholder", "BlessofGrandisGoddess", 
                     "Machina_Domination-CurseMark-MotalSwing_MotalWingBeat", "Machina_Domination-CurseMark-MotalSwing_MotalWingBeat", 
                     "MagicCircuitFullDrive", "Blink", "SpiderInMirror", "RopeConnect")
IlliumVPrior$N5 <- c("Javelin_EnhancedJavelin-Destruction-Deus_Liyo", "Javelin_EnhancedJavelin-Destruction-Deus_Liyo", 
                     "CrystalIgnition", "SoulofCrystal", "OverloadMana", "CrystalGate", "Gramholder", "BlessofGrandisGoddess", 
                     "Machina_Domination-CurseMark-MotalSwing_MotalWingBeat", "Longinus-CurseMark-MotalSwing_MotalWingBeat", 
                     "MagicCircuitFullDrive", "Blink", 
                     "Machina_Domination-Longinus-LonginusZone", 
                     "SpiderInMirror", "RopeConnect")

## Ark
ArkVPassive <- list()
ArkVPassive$N4 <- data.frame(Skills=c("PlainChargeDrive", "EndlessNightmare_Dream", "ImpendingDeath_VengefulHate", 
                                      "CreepingTerror_BlissfulRestraint_EndlessAgony", "ScarletChargeDrive_GrievousWound", "AbyssChargeDrive_UnbridledChaos"), 
                             Lv=c(50, 50, 50, 50, 50, 50), 
                             stringsAsFactors=F)
ArkVPassive$N5 <- data.frame(Skills=c("PlainChargeDrive", "EndlessNightmare_Dream", "ImpendingDeath_VengefulHate", 
                                      "CreepingTerror_BlissfulRestraint_EndlessAgony", "ScarletChargeDrive_GrievousWound", "AbyssChargeDrive_UnbridledChaos", 
                                      "GustChargeDrive_InsatiableHunger", "UnstoppableImpulse_TenaciousInstinct"), 
                             Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                             stringsAsFactors=F)
ArkVPassive$N6 <- data.frame(Skills=c("PlainChargeDrive", "EndlessNightmare_Dream", "ImpendingDeath_VengefulHate", 
                                      "CreepingTerror_BlissfulRestraint_EndlessAgony", "ScarletChargeDrive_GrievousWound", "AbyssChargeDrive_UnbridledChaos", 
                                      "GustChargeDrive_InsatiableHunger", "UnstoppableImpulse_TenaciousInstinct"), 
                             Lv=c(50, 50, 50, 50, 50, 50, 50, 50), 
                             stringsAsFactors=F)
ArkVPrior <- list()
ArkVPrior$N4 <- c("PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", "PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", 
                  "OverDrive", "InfinitySpell", "AbyssalRecall", "EndlesslyStarvingBeast", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-ScarletChargeDrive_GrievousWound-AbyssChargeDrive_UnbridledChaos", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-ScarletChargeDrive_GrievousWound-AbyssChargeDrive_UnbridledChaos", 
                  "BlessofGrandisGoddess", "DeviousNightmare_Dream", "MagicCircuitFullDrive", "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect")
ArkVPrior$N5 <- c("PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", "PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", 
                  "OverDrive", "InfinitySpell", "AbyssalRecall", "EndlesslyStarvingBeast", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-ScarletChargeDrive_GrievousWound-AbyssChargeDrive_UnbridledChaos", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-GustChargeDrive_InsatiableHunger-AbyssChargeDrive_UnbridledChaos", 
                  "UnstoppableImpulse_TenaciousInstinct-GustChargeDrive_InsatiableHunger-ScarletChargeDrive_GrievousWound", 
                  "BlessofGrandisGoddess", "DeviousNightmare_Dream", "MagicCircuitFullDrive", "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect")
ArkVPrior$N6 <- c("PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", "PlainChargeDrive-EndlessNightmare_Dream-ImpendingDeath_VengefulHate", 
                  "OverDrive", "InfinitySpell", "AbyssalRecall", "EndlesslyStarvingBeast", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-ScarletChargeDrive_GrievousWound-AbyssChargeDrive_UnbridledChaos", 
                  "CreepingTerror_BlissfulRestraint_EndlessAgony-ScarletChargeDrive_GrievousWound-AbyssChargeDrive_UnbridledChaos", 
                  "BlessofGrandisGoddess", "DeviousNightmare_Dream", 
                  "GustChargeDrive_InsatiableHunger-UnstoppableImpulse_TenaciousInstinct-PlainChargeDrive", "GustChargeDrive_InsatiableHunger-UnstoppableImpulse_TenaciousInstinct-PlainChargeDrive", 
                  "MagicCircuitFullDrive", "LoadedDice", "Blink", "SpiderInMirror", "RopeConnect")

## Lara
LaraVPassive <- list()
LaraVPassive$N4 <- data.frame(Skills=c("SpiritSeeding", "Awakening", "MountainKid", "SeedofMountain", "EarthVeinEruption", "EarthVeinAbsorb"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
LaraVPrior <- list()
LaraVPrior$N4 <- c("SpiritSeeding-EarthVeinEruption-EarthVeinAbsorb", "SpiritSeeding-EarthVeinEruption-EarthVeinAbsorb", 
                   "SunRiverMountWind", "OverloadMana", "HugeStretch", "RidgeZigzag", "SurgingSpirit", 
                   "Awakening-MountainKid-SeedofMountain", "Awakening-MountainKid-SeedofMountain", 
                   "BlessofGrandisGoddess", "Blink", "SpiderInMirror", "RopeConnect")

## Hoyeong
HoyeongVPassive <- list()
HoyeongVPassive$N4 <- data.frame(Skills=c("Yeouiseon_Geumgobong", "Toparyu_Jijinswae", "Bunsinbu", "Gwihwabu", "Hojeopjimong", "Heupseongwaryu"), 
                                Lv=c(50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
HoyeongVPassive$N5 <- data.frame(Skills=c("Yeouiseon_Geumgobong", "Toparyu_Jijinswae", "Bunsinbu", "Gwihwabu", "Hojeopjimong", "Heupseongwaryu", 
                                         "MabongHorobu", "MisaengGangbyeon"), 
                                Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                stringsAsFactors=F)
HoyeongVPassive$N6 <- data.frame(Skills=c("Yeouiseon_Geumgobong", "Toparyu_Jijinswae", "Bunsinbu", "Gwihwabu", "Hojeopjimong", "Heupseongwaryu", 
                                         "MabongHorobu", "MisaengGangbyeon", "Myeolhwayeom_Pachopung"), 
                                Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                                stringsAsFactors=F)
HoyeongVPrior <- list()
HoyeongVPrior$N4 <- c("Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", "Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", 
                      "Bunsinnanmu", "Goeryeoknansin", "CheonjiinHwanyeong", "Sanryeongsohwan", "ReadyToDie", 
                      "Yeouiseon_Geumgobong-Gwihwabu-Hojeopjimong", "Yeouiseon_Geumgobong-Gwihwabu-Hojeopjimong", 
                      "Blink", "SpiderInMirror", "BlessofGrandisGoddess", "RopeConnect")
HoyeongVPrior$N5 <- c("Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", "Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", 
                      "Bunsinnanmu", "Goeryeoknansin", "CheonjiinHwanyeong", "Sanryeongsohwan", "ReadyToDie", 
                      "Yeouiseon_Geumgobong-Gwihwabu-Hojeopjimong", "Yeouiseon_Geumgobong-Gwihwabu-MabongHorobu", "Hojeopjimong-MabongHorobu-MisaengGangbyeon", 
                      "Blink", "SpiderInMirror", "BlessofGrandisGoddess", "RopeConnect")
HoyeongVPrior$N6 <- c("Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", "Toparyu_Jijinswae-Bunsinbu-Heupseongwaryu", 
                      "Bunsinnanmu", "Goeryeoknansin", "CheonjiinHwanyeong", "Sanryeongsohwan", "ReadyToDie", 
                      "Yeouiseon_Geumgobong-Gwihwabu-Hojeopjimong", "Yeouiseon_Geumgobong-Gwihwabu-Hojeopjimong", "MabongHorobu-MisaengGangbyeon-Myeolhwayeom_Pachopung", "MabongHorobu-MisaengGangbyeon-Myeolhwayeom_Pachopung", 
                      "Blink", "SpiderInMirror", "BlessofGrandisGoddess", "RopeConnect")

## Zero
ZeroVPassive <- list()
ZeroVPassive$N4 <- data.frame(Skills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                       "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "StormBreak_EarthBreak"), 
                              Lv=c(50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
ZeroVPassive$N5 <- data.frame(Skills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                       "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "StormBreak_EarthBreak", 
                                       "WindStrike_JumpingCrash", "WindCutter_GigaCrash"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                              stringsAsFactors=F)
ZeroVPassive$N6 <- data.frame(Skills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                       "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "StormBreak_EarthBreak", 
                                       "WindStrike_JumpingCrash", "WindCutter_GigaCrash", "ShadowRain"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
ZeroVPassive$N7 <- data.frame(Skills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                       "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "StormBreak_EarthBreak", 
                                       "WindStrike_JumpingCrash", "WindCutter_GigaCrash", "ShadowRain", "FlashAssaulter_FrontSlash"), 
                              Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50, 50), 
                              stringsAsFactors=F)
ZeroVPrior <- list()
ZeroVPrior$N4 <- c("PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", "PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", 
                   "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", 
                   "LimitBreak", "JointAttack", "EgoWeapon", "ShadowFlash", "AuraWeapon", "BlessofRhinne", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")
ZeroVPrior$N5 <- c("PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", "PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", 
                   "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", "WindStrike_JumpingCrash-RollingCurve_TurningDrive-StormBreak_EarthBreak", 
                   "MoonStrike_ShadowStrike_UpperSlash-WindStrike_JumpingCrash-WindCutter_GigaCrash", 
                   "LimitBreak", "JointAttack", "EgoWeapon", "ShadowFlash", "AuraWeapon", "BlessofRhinne", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")
ZeroVPrior$N6 <- c("PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", "PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", 
                   "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", 
                   "LimitBreak", "JointAttack", "EgoWeapon", "ShadowFlash", 
                   "WindStrike_JumpingCrash-WindCutter_GigaCrash-ShadowRain", "WindStrike_JumpingCrash-WindCutter_GigaCrash-ShadowRain", 
                   "AuraWeapon", "BlessofRhinne", "Blink", "SpiderInMirror", "BodyofSteel", "RopeConnect")
ZeroVPrior$N7 <- c("PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", "PierceThrust_PowerStump-RollingAssaulter_WhirlWind-SpinCutter_ThrowingWeapon", 
                   "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", "MoonStrike_ShadowStrike_UpperSlash-RollingCurve_TurningDrive-StormBreak_EarthBreak", 
                   "LimitBreak", "JointAttack", "EgoWeapon", "ShadowFlash", 
                   "WindStrike_JumpingCrash-WindCutter_GigaCrash-ShadowRain", "WindStrike_JumpingCrash-FlashAssaulter_FrontSlash-ShadowRain", 
                   "AuraWeapon", "BlessofRhinne", "Blink", 
                   "WindCutter_GigaCrash-FlashAssaulter_FrontSlash-ShadowRain", 
                   "SpiderInMirror", "BodyofSteel", "RopeConnect")


## Kinesis
KinesisVPassive <- list()
KinesisVPassive$N4 <- data.frame(Skills=c("PsychicGrab_UltimatePsychicShot", "UltimateMaterial", "UltimateBPM", 
                                          "UltimateTrain", "PsychicDrain", "Telekinesis"), 
                                 Lv=c(50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
KinesisVPassive$N5 <- data.frame(Skills=c("PsychicGrab_UltimatePsychicShot", "UltimateMaterial", "UltimateBPM", 
                                          "UltimateTrain", "PsychicDrain", "Telekinesis", 
                                          "PsychoBreak", "EverPsychic"), 
                                 Lv=c(50, 50, 50, 50, 50, 50, 50, 25), 
                                 stringsAsFactors=F)
KinesisVPassive$N6 <- data.frame(Skills=c("PsychicGrab_UltimatePsychicShot", "UltimateMaterial", "UltimateBPM", 
                                          "UltimateTrain", "PsychicDrain", "Telekinesis", 
                                          "PsychoBreak", "EverPsychic", "PsychicForce"), 
                                 Lv=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                                 stringsAsFactors=F)
KinesisVPrior <- list()
KinesisVPrior$N4 <- c("PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", "PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", 
                      "UltimateMovingMatter", "LawofGravity", 
                      "UltimateTrain-PsychicDrain-Telekinesis", "UltimateTrain-PsychicDrain-Telekinesis", 
                      "OverloadMana", "BlessofMasteriaGoddess", "PsychicTornado", "Blink", "SpiderInMirror", "UltimatePsychicBullet", "RopeConnect")
KinesisVPrior$N5 <- c("PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", "PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", 
                      "UltimateMovingMatter", "LawofGravity", 
                      "UltimateTrain-PsychicDrain-Telekinesis", "UltimateTrain-PsychicDrain-PsychoBreak", 
                      "OverloadMana", "BlessofMasteriaGoddess", "PsychicTornado", 
                      "EverPsychic-PsychoBreak-Telekinesis", 
                      "Blink", "SpiderInMirror", "UltimatePsychicBullet", "RopeConnect")
KinesisVPrior$N6 <- c("PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", "PsychicGrab_UltimatePsychicShot-UltimateMaterial-UltimateBPM", 
                      "UltimateMovingMatter", "LawofGravity", 
                      "UltimateTrain-PsychicDrain-Telekinesis", "UltimateTrain-PsychicDrain-Telekinesis", 
                      "OverloadMana", "BlessofMasteriaGoddess", "PsychicTornado", "Blink", "SpiderInMirror",
                      "PsychoBreak-EverPsychic-PsychicForce", "PsychoBreak-EverPsychic-PsychicForce", 
                      "UltimatePsychicBullet", "RopeConnect")
