## Hero
HeroSkillList <- list(SwordIllusion=c("SwordIllusion", "SwordIllusionExplosion"), 
                      ComboInstinct=c("ScarofSpace"), 
                      Valhalla=c("ValhallaATK"))
HeroDealCycleSimplified <- DealCycleCollapse(HeroDealCycle, HeroSkillList)

## Palladin
PalladinSkillList <- list(GrandCross=c("GrandCrossBig", "GrandCrossSmall"), 
                          MightyMjolnir=c("MightyMjolnir", "MightyMjolnirExplosion"))
PalladinDealCycleSimplified <- DealCycleCollapse(PalladinDealCycle, PalladinSkillList)

## DarkKnight
DarkKnightSkillList <- list(BeholderShock=c("BeholderShock", "BeholderShockSphere"), 
                            DarknessAura=c("DarknessAura", "DarknessAuraEnd"), 
                            PierceCyclone=c("PierceCycloneTick", "PierceCycloneRemain", "PierceCycloneEnd"))
DarkKnightDealCycleSimplified <- DealCycleCollapse(DarkKnightDealCycle, DarkKnightSkillList)

## ArchMageFP
ArchMageFPSkillList <- list(DotPunisher=c("DotPunisher1st", "DotPunisherRemain"), 
                            Ignite=c("Ignite", "IgniteMeteorFinalAttack"), 
                            MegiddoFlame=c("MegiddoFlame", "MegiddoFlameAdd"), 
                            Meteor=c("Meteor", "MeteorFinalAttack"), 
                            PoisonChain=c("PoisonChain1", "PoisonChain2", "PoisonChain3", "PoisonChain4", "PoisonChain5", "PoisonChainMax", "PoisonChainPre"), 
                            PoisonMist=c("PoisonMistUnstable"), 
                            PoisonNova=c("PoisonNova123", "PoisonNovaRemain", "PoisonNovaStart"), 
                            PoisonRegion=c("PoisonRegion", "PoisonRegionAdd"))
ArchMageFPDealCycleSimplified1 <- DealCycleCollapse(ArchMageFPDealCycle1, ArchMageFPSkillList)
ArchMageFPDealCycleSimplified2 <- DealCycleCollapse(ArchMageFPDealCycle2, ArchMageFPSkillList)

## ArchMageTC
ArchMageTCSkillList <- list(Blizard=c("Blizard", "BlizardFA"), 
                            IceAge=c("IceAge", "IceAgeFloor"), 
                            LightningSpear=c("LightningSpearEnd", "LightningSpearLoop"), 
                            ThunderBreak=c("ThunderBreak", "ThunderBreak2", "ThunderBreak3", "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8"))
ArchMageTCDealCycleSimplified1 <- DealCycleCollapse(ArchMageTCDealCycle1, ArchMageTCSkillList)
ArchMageTCDealCycleSimplified2 <- DealCycleCollapse(ArchMageTCDealCycle2, ArchMageTCSkillList)
ArchMageTCDealCycleSimplified3 <- DealCycleCollapse(ArchMageTCDealCycle3, ArchMageTCSkillList)

## Bishop
BishopSkillList <- list(DivinePunishment=c("DivinePunishment", "DivinePunishmentEnd"), 
                        PeaceMaker=c("PeaceMaker", "PeaceMakerExplosion"))
BishopDealCycleSimplified1 <- DealCycleCollapse(BishopDealCycle1, BishopSkillList)
BishopDealCycleSimplified2 <- DealCycleCollapse(BishopDealCycle2, BishopSkillList)
BishopDealCycleSimplified3 <- DealCycleCollapse(BishopDealCycle3, BishopSkillList)

## Bowmaster
BowmasterSkillList <- list(AfterimageArrow=c("AfterimageArrowPassive", "AfterimageArrowActive"), 
                           ArrowRain=c("ArrowRain1", "ArrowRain2"), 
                           AdvancedQuiver=c("QuiverMagic", "QuiverMagicRain"), 
                           QuiverFullBurst=c("QuiverFlame"))
BowmasterDealCycleSimplified <- DealCycleCollapse(BowmasterDealCycle, BowmasterSkillList)

## Marksman
MarksmanSkillList <- list(ChargedArrow=c("ChargedArrow", "ChargedArrowUncharged"), 
                          EnhanceSnipe=c("EnhanceSnipe", "EnhanceSnipeAddATK"))
MarksmanDealCycleSimplified <- DealCycleCollapse(MarksmanDealCycle, MarksmanSkillList)

## PathFinder
PathFinderSkillList <- list(RelicUnbound=c("RelicUnboundDischarge"), 
                            ComboAssault=c("ComboAssaultBlast1", "ComboAssaultBlast2"))
PathFinderDealCycleSimplified <- DealCycleCollapse(PathFinderDealCycle, PathFinderSkillList)

## NightLord
NightLordSkillList <- list(MarkofNightLord=c("MarkofNightLord", "MarkofNightLordSpread"), 
                           QuadrapleThrow=c("QuadrapleThrow", "QuadrapleThrowAdd", "QuadrapleThrowSpread"), 
                           SecretBook=c("SecretBook", "SecretBookExplosion"), 
                           SuddenRaid=c("SuddenRaid", "SuddenRaidAdd"), 
                           ThrowBlasting=c("ThrowBlasting", "ThrowBlastingAdd"), 
                           ThrowingKnife=c("ThrowingKnife", "ThrowingKnifeAdd"))
NightLordDealCycleSimplified <- DealCycleCollapse(NightLordDealCycle, NightLordSkillList)

## Shadower
ShadowerSkillList <- list(Assassination=c("Assassination1", "Assassination1Add", "Assassination2", "Assassination2Add"), 
                          Eviscerate=c("Eviscerate", "EviscerateAdd"), 
                          Myeolgwichamyeongjin=c("Myeolgwichamyeongjin", "MyeolgwichamyeongjinLast"), 
                          SonicBlow=c("SonicBlow", "SonicBlowAdd"), 
                          VeilofShadow=c("VeilofShadow", "VeilofShadowAdd"))
ShadowerDealCycleSimplified <- DealCycleCollapse(ShadowerDealCycle, ShadowerSkillList)

## DualBlade
DualBladeSkillList <- list(Asura=c("Asura", "AsuraAdd"), 
                           BladeStorm=c("BladeStorm", "BladeStormAdd", "BladeStormPre", "BladeStormPreAdd"), 
                           BladeTornado=c("BladeTornado", "BladeTornadoAdd", "BladeTornadoPre", "BladeTornadoPreAdd"), 
                           FinalCut=c("FinalCut", "FinalCutAdd"), 
                           HuntedEdge=c("HuntedEdge", "HuntedEdgeAdd"), 
                           KarmaFury=c("KarmaFury", "KarmaFuryAdd"), 
                           PhantomBlow=c("PhantomBlow", "PhantomBlowAdd"), 
                           SuddenRaid=c("SuddenRaid", "SuddenRaidAdd"))
DualBladeDealCycleSimplified <- DealCycleCollapse(DualBladeDealCycle, DualBladeSkillList)

## Viper
ViperSkillList <- list(HawlingFist=c("HawlingFistLast", "HawlingFistStart"), 
                       Nautilus=c("NautilusFinalATK"), 
                       LightningForm=c("LightningFormOrb"))
ViperSimplifiedCycleNames <- c()
for(i in 1:length(ViperCycleNames)) {
  ViperDealCycleSimplified <- DealCycleCollapse(get(ViperCycleNames[i]), ViperSkillList)
  assign(paste(ViperCycleNames[i], "Simplified", sep=""), ViperDealCycleSimplified)
  ViperSimplifiedCycleNames <- c(ViperSimplifiedCycleNames, paste(ViperCycleNames[i], "Simplified", sep=""))
  rm(ViperDealCycleSimplified)
}

## Captain
CaptainSkillList <- list(AssembleCrew=c("AssembleCrewDualPistol", "AssembleCrewDualPistolNectar", 
                                        "AssembleCrewMarksman", "AssembleCrewMarksmanNectar"), 
                         BattleShipBomber=c("BattleShipBomber1", "BattleShipBomber1Nectar", 
                                            "BattleShipBomber2", "BattleShipBomber2Nectar"), 
                         NautilusAssault=c("NautilusAssaultLast", "NautilusAssaultPre"), 
                         SeizeBomber=c("SeizeBomber", "SeizeBomberNectar"))
CaptainDealCycle5Simplified <- DealCycleCollapse(CaptainDealCycle5, CaptainSkillList)
CaptainDealCycle55Simplified <- DealCycleCollapse(CaptainDealCycle55, CaptainSkillList)
CaptainDealCycle555Simplified <- DealCycleCollapse(CaptainDealCycle555, CaptainSkillList)
CaptainDealCycle53Simplified <- DealCycleCollapse(CaptainDealCycle53, CaptainSkillList)
CaptainDealCycle533Simplified <- DealCycleCollapse(CaptainDealCycle533, CaptainSkillList)
CaptainDealCycle553Simplified <- DealCycleCollapse(CaptainDealCycle553, CaptainSkillList)

## CannonShooter
CannonShooterSkillList <- list(ICBM=c("ICBM", "ICBMFloor"), 
                               SpecialMonkeyEscort=c("MonkeyEscortBomb", "MonkeyEscortCannon"))
CannonShooterSimplifiedCycleNames <- c()
for(i in 1:length(CSList$CycleNames)) {
  CannonShooterDealCycleSimplified <- DealCycleCollapse(get(CSList$CycleNames[i]), CannonShooterSkillList)
  assign(paste(CSList$CycleNames[i], "Simplified", sep=""), CannonShooterDealCycleSimplified)
  CannonShooterSimplifiedCycleNames <- c(CannonShooterSimplifiedCycleNames, paste(CSList$CycleNames[i], "Simplified", sep=""))
  rm(CannonShooterDealCycleSimplified)
}

## Mikhail
MikhailSkillList <- list(ClaiomhSolais=c("ClaiomhSolais", "ClaiomhSolaisAuto"), 
                         ShiningCross=c("ShiningCross", "ShiningCrossInstall"), 
                         SwordofSoulLight=c("SwordofSoulLightAfterimage"))
MikhailDealCycleSimplified <- DealCycleCollapse(MikhailDealCycle, MikhailSkillList)

## SoulMaster
SoulMasterSkillList <- list(CelestialDance=c("CDAfterimageFM", "CDAfterimageRS"), 
                            DanceofMoon=c("DanceofMoon", "DanceofMoonAir", "DanceofMoonAirCD", "DanceofMoonCD"), 
                            Elysion=c("ElysionCrack"), 
                            SolunarSlash=c("SolunarSlashATK"), 
                            SoulEclipse=c("SoulEclipseEC"), 
                            SolunarDivide=c("SoulEclipseSD"), 
                            SpeedingSunset=c("SpeedingSunset", "SpeedingSunsetAir", "SpeedingSunsetAirCD", "SpeedingSunsetCD"))
SoulMasterDealCycleSimplified <- DealCycleCollapse(SoulMasterDealCycle, SoulMasterSkillList)

## FlameWizard
FlameWizardSkillList <- list(DragonSlave=c("DragonSlave", "DragonSlaveLast"), 
                             FlameDischarge=c("FlameDischargeFox2", "FlameDischargeFox3", "FlameDischargeFox4", "FlameDischargeFox5", 
                                              "FlameDischargeLion2", "FlameDischargeLion3", "FlameDischargeLion4", "FlameDischargeLion5"), 
                             InfinityFlameCircle=c("InfinityFlameCircleEnd1", "InfinityFlameCircleEnd2", "InfinityFlameCircleTick"), 
                             OrbitalFlameIV=c("OrbitalFlame"), 
                             SalamanderMischief=c("SalamanderMischiefATK"))
FlameWizardDealCycleSimplified <- DealCycleCollapse(FlameWizardDealCycle, FlameWizardSkillList)

## WindBreaker
WindBreakerSkillList <- list(HowlingGale=c("HowlingGaleBig", "HowlingGaleSmall"), 
                             IdleWhim=c("IdleWhimFirst", "IdleWhimRemain"), 
                             TriflingWhim=c("TriflingWhim", "TriflingWhimEnhanced"), 
                             VortexSphere=c("VortexSphere", "VortexSphereGust"))
WindBreakerDealCycleSimplified <- DealCycleCollapse(WindBreakerDealCycle, WindBreakerSkillList)

## NightWalker
NightWalkerSkillList <- list(QuintupleThrow=c("QuintupleThrow1", "QuintupleThrow1Add1", "QuintupleThrow1Add2", "QuintupleThrow1Add3", "QuintupleThrow1Add4", 
                                              "QuintupleThrow2", "QuintupleThrow2Add1", "QuintupleThrow2Add2", "QuintupleThrow2Add3", "QuintupleThrow2Add4"), 
                             RapidThrow=c("RapidThrow", "RapidThrowAdd1", "RapidThrowAdd2", "RapidThrowAdd3", "RapidThrowAdd4", 
                                          "RapidThrowLast", "RapidThrowLastAdd1", "RapidThrowLastAdd2", "RapidThrowLastAdd3", "RapidThrowLastAdd4"), 
                             ShadowSpear=c("ShadowSpearBig", "ShadowSpearSmall"))
NightWalkerDealCycleSimplified <- DealCycleCollapse(NightWalkerDealCycle, NightWalkerSkillList)

## Striker
StrikerSkillList <- list(Annihilate=c("Annihilate", "AnnihilateAdd"), 
                         DeepRising=c("DeepRising", "DeepRisingAdd"), 
                         LightningCascade=c("LightningCascade", "LightningCascadeAdd"), 
                         LightningGodSpearStrike=c("LightningGodSpearStrike", "LightningGodSpearStrikeAdd", "LightningGodSpearStrikeShock", "LightningGodSpearStrikeShockAdd"), 
                         LightningSpearMultistrike=c("LightningSpearMultistrike", "LightningSpearMultistrikeAdd", "LightningSpearMultistrikeLast", "LightningSpearMultistrikeLastAdd", 
                                                     "LightningSpearMultistrikeLastLightning", "LightningSpearMultistrikeLastLightningAdd", "LightningSpearMultistrikeLightning", "LightningSpearMultistrikeLightningAdd"), 
                         SharkTorpedo=c("SharkTorpedo", "SharkTorpedoAdd"), 
                         Thunderbolt=c("Thunderbolt", "ThunderboltAdd"), 
                         Typhoon=c("Typhoon", "TyphoonAdd"))
StrikerDealCycleSimplified <- DealCycleCollapse(StrikerDealCycle, StrikerSkillList)

## Aran
AranSkillList <- list(AdvancedFinalAttack=c("AdvancedFinalAttack", "AdvancedFinalAttackAdrenaline"), 
                      Beyonder=c("Beyonder1", "Beyonder1Adrenaline", "Beyonder2", "Beyonder2Adrenaline", "Beyonder3", "Beyonder3Adrenaline", "BeyonderWave"), 
                      BlizardTempest=c("BlizardTempest", "BlizardTempestIce"), 
                      BrandishMaha=c("BrandishMahaCommand"), 
                      FenrirCrash=c("FenrirCrash", "FenrirCrashAdrenaline", "FenrirCrashIceberg"), 
                      FinalBlow=c("FinalBlowCommand", "FinalBlowCommandAdrenaline", "FinalBlowWave"), 
                      GatheringCatcher=c("GatheringCatcherCommand"), 
                      AeroSwing=c("Swing", "SwingAdrenaline"), 
                      SwingAfterimage=c("SwingAfterimage", "SwingAfterimageAdrenaline"), 
                      ZoneofMaha=c("ZoneofMaha", "ZoneofMahaAdrenaline", "ZoneofMahaZone", "ZoneofMahaZoneAdrenaline"))
AranDealCycleSimplified <- DealCycleCollapse(AranDealCycle, AranSkillList)

## Evan
EvanSkillList <- list(BreathofWind=c("BreathofWind", "BreathofWindBonus"), 
                      CircleofManaIV=c("CircleofMana1", "CircleofMana2"), 
                      MagicFragment=c("MagicFragment1", "MagicFragment2", "MagicFragment3", "MagicFragment4"), 
                      SpiralofMana=c("SpiralofMana", "SpiralofManaRed"))
EvanDealCycleSimplified <- DealCycleCollapse(EvanDealCycle, EvanSkillList)
EvanDealCycleHPSimplified <- DealCycleCollapse(EvanDealCycleHP, EvanSkillList)

## Luminous
LuminousSkillList <- list(AbsoluteKill=c("AbsoluteKill", "AbsoluteKillAdd", "AbsoluteKillEq"), 
                          Apocalypse=c("Apocalypse", "ApocalypseAdd"), 
                          LiberationOrb=c("LiberationOrbBalance", "LiberationOrbLight"), 
                          LightReflection=c("LightReflection", "LightReflectionAdd"))
LuminousDealCycleSimplified <- DealCycleCollapse(LuminousDealCycle, LuminousSkillList)

## Mercedes
MercedesSkillList <- list(AdvancedFinalAttack=c("AdvancedFinalAttack", "AdvancedFinalAttackEnlilGhost", "AdvancedFinalAttackGustGhost", "AdvancedFinalAttackIshtarGhost"), 
                          AdvancedStrikeDualShot=c("AdvancedStrikeDualShot", "AdvancedStrikeDualShotGhost"), 
                          BreathofIrkalla=c("BreathofIrkalla", "BreathofIrkallaGhost", "BreathofIrkallaSylvidia"), 
                          ElementalGhost=c("ElementalGhostTree"), 
                          ElementalKnight=c("ElementalKnightD", "ElementalKnightIF"), 
                          GustDive=c("GustDive", "GustDiveGhost"),
                          LegendrySpear=c("LegendrySpear", "LegendrySpearGhost"), 
                          RingofIshtar=c("RingofIshtar", "RingofIshtarGhost"), 
                          RoyalKnights=c("RoyalKnightsKnight"), 
                          UnicornSpike=c("UnicornSpike", "UnicornSpikeGhost"), 
                          WrathofEnlil=c("WrathofEnlil", "WrathofEnlilGhost"))
MercedesDealCycleSimplified <- DealCycleCollapse(MercedesDealCycle, MercedesSkillList)

## Phantom
PhantomSkillList <- list(BlackJack=c("BlackJack", "BlackJackLast"), 
                         MarkofPhantom=c("MarkofPhantom", "MarkofPhantomFinal"), 
                         NoirCarte=c("NoirCarte", "NoirCarteJudgement"), 
                         RoseCarteFinale=c("RoseCarteFinale", "RoseCarteFinaleAdd"), 
                         Twilight=c("Twilight1"))
PhantomDealCycleSimplified <- DealCycleCollapse(PhantomDealCycle, PhantomSkillList)
PhantomDealCycle2Simplified <- DealCycleCollapse(PhantomDealCycle2, PhantomSkillList)

## Eunwol
EunwolSkillList <- list(Bulyeouryeong=c("Bulyeouryeong", "BulyeouryeongJipsok1", "BulyeouryeongJipsok2", "BulyeouryeongJipsok3", "BulyeouryeongJipsok3Cancelled", "BulyeouryeongPashwaeYeongwon"), 
                        BunhonGyeokcham=c("BunhonGyeokchamATK"), 
                        Gwicham=c("Gwicham", "GwichamJipsok"), 
                        JeongryeongeuiHwasin=c("JeongryeongeuiHwasinJipsok", "JeongryeongeuiHwasinJipsokCancelled"), 
                        Paryeokgown=c("ParyeokgownJipsok"), 
                        PashwaeCheoljoHa=c("PashwaeCheoljoHaJipsok"), 
                        PashwaeCheoljoHoe=c("PashwaeCheoljoHoe", "PashwaeCheoljoHoeJipsok"), 
                        PashwaeCheoljoJeon=c("PashwaeCheoljoJeonJipsok"), 
                        PashwaeYeongwon=c("PashwaeYeongwon", "PashwaeYeongwonLast"), 
                        Pokryugwon=c("Pokryugwon1Jipsok", "Pokryugwon2Jipsok", "Pokryugwon3Jipsok", "Pokryugwon4Jipsok"), 
                        SahonGakin=c("SahonGakinJipsok"), 
                        SohonJangmak=c("SohonJangmak", "SohonJangmakJipsok", "SohonJangmakJipsokCancelled"), 
                        Tongbaekgwon=c("Tongbaekgwon1Jipsok", "Tongbaekgwon2Jipsok", "Tongbaekgwon3Jipsok", "TongbaekgwonFAJipsok"))
EunwolDealCycleFGXSimplified <- DealCycleCollapse(EunwolDealCycleFGX, EunwolSkillList)
EunwolDealCycleFGOSimplified <- DealCycleCollapse(EunwolDealCycleFGO, EunwolSkillList)

## Blaster
BlasterSkillList <- list(BurningBreaker=c("BurningBreaker", "BurningBreakerEnd"), 
                         HammerSmash=c("HammerSmash", "HammerSmashShockwave"), 
                         ReleasePileBunker=c("ReleasePileBunker", "ReleasePileBunkerShockwaveA", "ReleasePileBunkerShockwaveB", "ReleasePileBunkerShockwaveC", "ReleasePileBunkerShockwaveD"), 
                         VulcanPunch=c("VulcanPunch", "VulcanPunchPre"))
BlasterDealCycleSimplified <- DealCycleCollapse(BlasterDealCycle, BlasterSkillList)

## BattleMage
BattleMageSkillList <- list(BattleKingBar=c("BattleKingBar1", "BattleKingBar2", "BattleKingBar2DL"), 
                            DarkGenesis=c("DarkGenesis", "DarkGenesisDL", "DarkGenesisFA"), 
                            DarkLightning=c("DarkLightning", "DarkLightningMark", "DarkLightningMark38", "DarkLightningMarkDGFA"), 
                            AbyssalLightning=c("DarkLightningAL"), 
                            Death=c("Death", "DeathMOD"), 
                            FinishBlow=c("FinishBlow", "FinishBlowDL"), 
                            UnionAura=c("FinishBlowUA", "FinishBlowUADL", "FinishBlowUAMOD"))
BattleMageDealCycleSimplified <- DealCycleCollapse(BattleMageDealCycle, BattleMageSkillList)

## WildHunter
WildHunterSkillList <- list(AdvancedFinalAttack=c("AdvancedFinalAttack", "AdvancedFinalAttackRampage"), 
                            ClawCut=c("ClawCut", "ClawCutAdd"), 
                            CrossRoad=c("CrossRoad", "CrossRoadAdd"), 
                            JaguarMaximum=c("JaguarMaximum", "JaguarMaximumEnd"), 
                            JaguarSoul=c("JaguarSoul", "JaguarSoulAdd"), 
                            RampageasOne=c("RampageasOne", "RampageasOneAdd"), 
                            SonicBoom=c("SonicBoom", "SonicBoomAdd"), 
                            SummonJaguar=c("SummonJaguar", "SummonJaguarAdd"), 
                            WildVulcanTypeX=c("WildVulcanTypeXLoop"))
WildHunterDealCycleSimplified <- DealCycleCollapse(WildHunterDealCycle, WildHunterSkillList)

## Xenon
XenonSkillList <- list(FuzzylopMasquerade=c("FuzzylopMasquerade", "FuzzylopMasqueradeAdd"), 
                       MegaSmasher=c("MegaSmasher", "MegaSmasherAdd"), 
                       MeltdownExplosion=c("MeltdownExplosion", "MeltdownExplosionAdd"), 
                       OverloadMode=c("OverloadModeATK", "OverloadModeATKAdd"))
XenonDealCycleSimplified <- DealCycleCollapse(XenonDealCycle, XenonSkillList)

## Mechanic
MechanicSkillList <- list(HomingMissile=c("HomingMissile", "HomingMissileBomberTime", "HomingMissileMetalArmor", "HomingMissileMetalArmorAdd", "HomingMissileMetalArmorBomber"), 
                          MagneticField=c("MagneticField", "MagneticFieldExplosion"), 
                          MassiveFire=c("MassiveFire", "MassiveFireExplosion"), 
                          MultipleOption=c("MultipleOptionGetling", "MultipleOptionMissile"), 
                          RM1=c("RM1", "RM1Explosion"))
MechanicDealCycle5Simplified <- DealCycleCollapse(MechanicDealCycle5, MechanicSkillList)
MechanicDealCycle55Simplified <- DealCycleCollapse(MechanicDealCycle55, MechanicSkillList)
MechanicDealCycle555Simplified <- DealCycleCollapse(MechanicDealCycle555, MechanicSkillList)
MechanicDealCycle53Simplified <- DealCycleCollapse(MechanicDealCycle53, MechanicSkillList)
MechanicDealCycle553Simplified <- DealCycleCollapse(MechanicDealCycle553, MechanicSkillList)
MechanicDealCycle533Simplified <- DealCycleCollapse(MechanicDealCycle533, MechanicSkillList)

## DemonSlayer
DemonSlayerSkillList <- list(AuraWeapon=c("AuraWeapon", "AuraWeaponAdd"), 
                             AwakeningSlash=c("AwakeningSlash1", "AwakeningSlash1Add", "AwakeningSlash2", "AwakeningSlash2Add", "AwakeningSlash3", "AwakeningSlash3Add", "AwakeningSlash4", "AwakeningSlash4Add"), 
                             CallMastema=c("MastemaClaw"),
                             Cerberus=c("Cerberus", "CerberusAdd"), 
                             DemonBane=c("DemonBaneEnd", "DemonBaneEndAdd", "DemonBaneLastEnd", "DemonBaneLastEndAdd", "DemonBaneLastTick", "DemonBaneLastTickAdd", "DemonBaneTick", "DemonBaneTickAdd"), 
                             DemonImpact=c("DemonImpact", "DemonImpactAdd"), 
                             DemonSlash=c("DemonSlash", "DemonSlashAdd"), 
                             DevilCry=c("DevilCry", "DevilCryAdd"), 
                             Jormungand=c("Jormungand", "JormungandLast"), 
                             Metamorphosis=c("MetamorphosisATK", "MetamorphosisATKAdd"), 
                             Orthros=c("OrthrosGeryon", "OrthrosNemea"), 
                             BlessofMasteriaGoddess=c("OtherworldEmptiness"))
DemonSlayerDealCycleSimplified <- DealCycleCollapse(DemonSlayerDealCycle, DemonSlayerSkillList)

## DemonAvenger
DemonAvengerSkillList <- list(DimensionSword=c("DimensionSword", "DimensionSwordFast"), 
                              ExceedExecution=c("ExceedExecution1", "ExceedExecution2", "ExceedExecution3", "ExceedExecution4", "ExceedExecution5"), 
                              CallMastema=c("MastemaClaw"), 
                              BlessofMasteriaGoddess=c("OtherworldEmptiness"), 
                              Revenant=c("RevenantAddATK"))
DemonAvengerDealCycleSimplified <- DealCycleCollapse(DemonAvengerDealCycle, DemonAvengerSkillList)

## Kaiser
KaiserSkillList <- list(DracoSlasher=c("DracoSlasher", "DracoSlasherFF"), 
                        DragonBlaze=c("DragonBlazeBlaze", "DragonBlazeExp", "DragonBlazeSphere"), 
                        DragonSlash=c("DragonSlash1", "DragonSlash1FF"), 
                        GigaSlasher=c("GigaSlasher", "GigaSlasherFF"), 
                        GuardianofNova=c("GuardianofNova15th", "GuardianofNova27th", "GuardianofNova6th"), 
                        InfernalBreath=c("InfernalBreath", "InfernalBreathTile"), 
                        AdvancedWillofSword=c("WillofSword", "WillofSwordFF"), 
                        WillofSwordStrike=c("WillofSwordStrike", "WillofSwordStrikeBlaze", "WillofSwordStrikeBlazeFF", "WillofSwordStrikeFF"), 
                        WingBeat=c("WingBeatTick"))
KaiserDealCyclesSimplified <- list()
for(i in 1:length(KaiserDealCycles)) {
  KaiserDealCyclesSimplified[[i]] <- DealCycleCollapse(KaiserDealCycles[[i]], KaiserSkillList)
}

## Kain
KainSkillList <- list(DeathBlessing=c("DeathBlessing", "DeathBlessingIncanation"), 
                      ExecuteChainSickle=c("ExecuteChainSickle", "ExecuteChainSickleAdd"), 
                      ExecuteFatalBlitz=c("ExecuteFatalBlitzTick"), 
                      ExecutePoisonNeedle=c("ExecutePoisonNeedleLoop", "ExecutePoisonNeedlePre"), 
                      PossessDragonBurst=c("PossessDragonBurstTick"), 
                      PossessFallingDust=c("PossessFallingDust", "PossessFallingDustAdd"), 
                      PossessScatteringShot=c("PossessScatteringShot", "PossessScatteringShotAfter"), 
                      PossessShaftBreak=c("PossessShaftBreak", "PossessShaftBreakExplosion", "PossessShaftBreakTornado"), 
                      ScatteringShot=c("ScatteringShot", "ScatteringShotAfter"), 
                      ShaftBreak=c("ShaftBreak", "ShaftBreakExplosion"), 
                      StrikeArrowII=c("StrikeArrow2"), 
                      StrikeArrowIII=c("StrikeArrow3"), 
                      ThanatosDescent=c("ThanatosDescentAddATK"), 
                      ThanatosDescentEnd=c("ThanatosDescentEndTick"))
KainDealCycleSimplified <- DealCycleCollapse(KainDealCycle, KainSkillList)

## Cadena
CadenaATKCollapse <- function(DealCycle_Cadena, ATKSkillsData) {
  ATKSkillsData <- rownames(ATKSkillsData)
  SkillList <- list()
  for(i in 1:length(ATKSkillsData)) {
    k <- nchar(ATKSkillsData[i])
    SkillList_Sub <- c()
    for(j in 1:nrow(DealCycle_Cadena)) {
      if(substr(DealCycle_Cadena$Skills[j], 1, k)==ATKSkillsData[i] & nchar(DealCycle_Cadena$Skills[j]) < k + 5 | 
         substr(DealCycle_Cadena$Skills[j], 1, k)==ATKSkillsData[i] & substr(DealCycle_Cadena$Skills[j], 1, k)=="WeaponVarietyFinale") {
        SkillList_Sub <- c(SkillList_Sub, DealCycle_Cadena$Skills[j])
        SkillList_Sub <- unique(SkillList_Sub)
      }
    }
    if(length(SkillList_Sub) > 0) {
      SkillList[[i]] <- SkillList_Sub
    } else {
      SkillList[[i]] <- 1
    }
    names(SkillList)[i] <- ATKSkillsData[i]
  }
  return(SkillList)
}
CadenaSkillList <- CadenaATKCollapse(CadenaDealCycle, CadenaATK)
CadenaDealCycleSimplified <- DealCycleCollapse(CadenaDealCycle, CadenaSkillList)
CadenaSkillList2 <- list(ADOrdnance=c("ADOrdnance", "ADOrdnanceSphere"), 
                         SummonThrowingWingdagger=c("SummonThrowingWingdaggerFDR", "SummonThrowingWingdagger", "SummonThrowingWingdaggerExplosion"), 
                         SummonBittingNeedlebat=c("SummonBittingNeedlebat1", "SummonBittingNeedlebat2", "SummonBittingNeedlebat3"))
CadenaDealCycleSimplified <- DealCycleCollapse(CadenaDealCycleSimplified, CadenaSkillList2)

## AngelicBuster
AngelicBusterSkillList <- list(MascotFamiliar=c("ShinyBubbleBreath", "TwinkleStar"), 
                               SoulSeeker=c("SoulSeeker1", "SoulSeeker2", "SoulSeeker3", "SoulSeeker4", "SoulSeeker5", "SoulSeeker6", "SoulSeeker7", 
                                            "SoulSeekerSE1", "SoulSeekerSE2", "SoulSeekerSE3", "SoulSeekerSE4", "SoulSeekerSE5", "SoulSeekerSE6", "SoulSeekerSE7"), 
                               Trinity=c("Trinity1", "Trinity2", "Trinity3"))
AngelicBusterDealCyclesSimplified <- list()
for(i in 1:length(AngelicBusterDealCycles)) {
  AngelicBusterDealCyclesSimplified[[i]] <- DealCycleCollapse(AngelicBusterDealCycles[[i]], AngelicBusterSkillList)
}

## Adele
AdeleSkillList <- list(Blossom=c("Blossom1st", "BlossomRemain"), 
                       Ruin=c("Ruin", "RuinExplosion"), 
                       Territory=c("Territory", "TerritoryExplosion"))
AdeleDealCycleSimplified <- DealCycleCollapse(AdeleDealCycleTrigger, AdeleSkillList)

## Illium
IlliumSkillList <- list(CurseMark=c("CurseMark", "CurseMarkJavelin"), 
                        ReactionDestruction=c("Destruction", "DestructionSoul"), 
                        CrystalSkillDeus=c("Deus", "DeusSatelite1stack", "DeusSatelite2stack", "DeusSatelite3stack"), 
                        ReactionDomination=c("Domination", "DominationSoul"), 
                        GlorywingEnhancedJavelin=c("EnhancedJavelin", "MagicMissile"), 
                        CraftJavelinII=c("Javelin", "JavelinAddATK", "JavelinAddFragment", "JavelinFragment"), 
                        CraftLonginus=c("Longinus"), 
                        Liyo=c("Liyo1Stack", "Liyo2Stack", "Liyo3Stack"), 
                        CrystalSkillMotalSwing=c("MotalSwing"), 
                        GlorywingMotalWingBeat=c("MotalWingBeat"), 
                        CraftOrbII=c("Orb"))
IlliumDealCycleSimplified <- DealCycleCollapse(IlliumDealCycle, IlliumSkillList)

## Ark
ArkSkillList <- list(AbyssalRecall=c("AbyssalRecall", "AbyssalRecallExplosion"), 
                     AbyssChargeDrive=c("AbyssChargeDrive1", "AbyssChargeDrive2"), 
                     AbyssSpell=c("AbyssSpell", "AbyssSpellInfinitySpell"), 
                     BlissfulRestraint=c("BlissfulRestraint", "BlissfulRestraintContinuousATK", "BlissfulRestraintLastATK"), 
                     EndlessAgony=c("EndlessAgony", "EndlessAgonyLast"), 
                     GustSpell=c("GustSpell", "GustSpellInfinitySpell"), 
                     PlainSpell=c("PlainSpell", "PlainSpellInfinitySpell"), 
                     ScarletSpell=c("ScarletSpell", "ScarletSpellInfinitySpell"))
ArkDealCycleSimplified <- DealCycleCollapse(ArkDealCycle, ArkSkillList)

## Lara
LaraSkillList <- list(HeavingRiver=c("HeavingRiver", "HeavingRiverHuge"), 
                      HugeStretch=c("HugeStretch1", "HugeStretch2"), 
                      SunRiverMountWind=c("SunRiverMountWind1", "SunRiverMountWind2"))
LaraDealCycleSimplified <- DealCycleCollapse(LaraDealCycle, LaraSkillList)

## Hoyeong
HoyeongSkillList <- list(CheonjiinHwanyeong=c("CheonjiinHwanyeongCheon", "CheonjiinHwanyeongIn", "CheonjiinHwanyeongJi"), 
                         Geumgobong=c("Geumgobong1", "Geumgobong2"), 
                         Goeryeoknansin=c("GoeryeoknansinAttack", "GoeryeoknansinFinalAttack"), 
                         Horobu=c("Horobu2"), 
                         SanryeongSohwan=c("SanryeongSohwanGeneral", "SanryeongSohwanWrath"))
HoyeongDealCycleSimplified <- DealCycleCollapse(HoyeongDealCycle, HoyeongSkillList)

## Zero
ZeroSkillList <- list(AdvancedEarthBreak=c("EarthBreak", "EarthBreakFloor", "EarthBreakShockwave"), 
                      EgoWeapon=c("EgoWeaponAlpha", "EgoWeaponBeta"), 
                      JointAttack=c("JointAttack1", "JointAttack2", "JointAttack3", "JointAttackLast"), 
                      JumpingCrash=c("JumpingCrash", "JumpingCrashShockwave"), 
                      LimitBreak=c("LimitBreak", "LimitBreakLast"), 
                      AdvancedPowerStump=c("PowerStump", "PowerStumpShockwave"), 
                      AdvancedRollingAssaulter=c("RollingAssaulter", "RollingAssaulterAura"), 
                      AdvancedRollingCurve=c("RollingCurve", "RollingCurveAura", "RollingCurveAura2"), 
                      ShadowFlash=c("ShadowFlashAlphaExp", "ShadowFlashAlphaInstall", "ShadowFlashBetaExp", "ShadowFlashBetaInstall"), 
                      ShadowRain=c("ShadowRainAlpha", "ShadowRainBeta"), 
                      ShadowStrike=c("ShadowStrike", "ShadowStrikeAura"), 
                      AdvancedSpinCutter=c("SpinCutter", "SpinCutterAura"), 
                      AdvancedStormBreak=c("StormBreak", "StormBreakFloor", "StormBreakVortex"), 
                      AdvancedThrowingWeapon=c("ThrowingWeapon"), 
                      AdvancedWhirlWind=c("WhirlWind"), 
                      WindCutter=c("WindCutter", "WindCutterVortex"))
ZeroDealCycleSimplified <- DealCycleCollapse(ZeroDealCycle, ZeroSkillList)

## Kinesis
KinesisSkillList <- list(EverPsychic=c("EverPsychic", "EverPsychicLast"), 
                         LawofGravity=c("LawofGravity", "LawofGravityExp", "LawofGravityPull"), 
                         BlessofMasteriaGoddess=c("OtherworldEmptiness"), 
                         PsychicDrain=c("PsychicDrainATK"), 
                         PsychicTornado=c("PsychicTornado", "PsychicTornadoExp", "PsychicTornadoObject"), 
                         UltimateMovingMatter=c("UltimateMovingMatter", "UltimateMovingMatterExp"), 
                         UltimateTrain=c("UltimateTrain", "UltimateTrain2", "UltimateTrain3", "UltimateTrain4", "UltimateTrain5", "UltimateTrain6", "UltimateTrain7", "UltimateTrain8", "UltimateTrain9", "UltimateTrain10", 
                                         "UltimateTrain11", "UltimateTrain12", "UltimateTrain13", "UltimateTrain14", "UltimateTrain15", "UltimateTrain16", "UltimateTrain17"))
KinesisDealCycleSimplified <- DealCycleCollapse(KinesisDealCycle, KinesisSkillList)


HeroDealRatio <- DealRatio(HeroDealCycleSimplified, HeroFinalDPMwithMax)
PalladinDealRatio <- DealRatio(PalladinDealCycleSimplified, PalladinFinalDPMwithMax)
DarkKnightDealRatio <- DealRatio(DarkKnightDealCycleSimplified, DarkKnightFinalDPMwithMax)
ArchMageFPDealRatio <- ResetDealRatio(list(ArchMageFPDealCycleSimplified1, ArchMageFPDealCycleSimplified2), 
                                      list(ArchMageFPDealData1, ArchMageFPDealData2), 
                                      c(max(ArchMageFPDealCycleSimplified1$Time), max(ArchMageFPDealCycleSimplified2$Time)),
                                      c(0.01, 0.99))
ArchMageTCDealRatio <- ResetDealRatio(list(ArchMageTCDealCycleSimplified1, ArchMageTCDealCycleSimplified2, ArchMageTCDealCycleSimplified3), 
                                      list(ArchMageTCDealData1, ArchMageTCDealData2, ArchMageTCDealData3), 
                                      c(max(ArchMageTCDealCycleSimplified1$Time), max(ArchMageTCDealCycleSimplified2$Time), max(ArchMageTCDealCycleSimplified3$Time)),
                                      c(0.01, 0.05, 0.94))
BishopDealRatio <- ResetDealRatio(list(BishopDealCycleSimplified1, BishopDealCycleSimplified2, BishopDealCycleSimplified3), 
                                  list(BishopDealData1, BishopDealData2, BishopDealData3), 
                                  c(max(BishopDealCycleSimplified1$Time), max(BishopDealCycleSimplified2$Time), max(BishopDealCycleSimplified3$Time)),
                                  c(0.01, 0.05, 0.94))
BowmasterDealRatio <- DealRatio(BowmasterDealCycleSimplified, BowmasterFinalDPMwithMax)
MarksmanDealRatio <- DealRatio(MarksmanDealCycleSimplified, MarksmanFinalDPMwithMax)
PathFinderDealRatio <- DealRatio(PathFinderDealCycleSimplified, PathFinderFinalDPMwithMax)
NightLordDealRatio <- DealRatio(NightLordDealCycleSimplified, NightLordFinalDPMwithMax)
ShadowerDealRatio <- DealRatio(ShadowerDealCycleSimplified, ShadowerFinalDPMwithMax)
DualBladerDealRatio <- DealRatio(DualBladeDealCycleSimplified, DualBladeFinalDPMwithMax)
ViperDealRatio <- ResetDealRatio(DealCycles=GetList(ViperSimplifiedCycleNames), 
                                 DealDatas=ViperDealDatas, rep(max(ViperDealCycle5Simplified$Time), length(ViperSimplifiedCycleNames)), ViperDealCycleProbs)
CaptainDealRatio <- ResetDealRatio(list(CaptainDealCycle5Simplified, CaptainDealCycle55Simplified, CaptainDealCycle555Simplified, 
                                        CaptainDealCycle53Simplified, CaptainDealCycle533Simplified, CaptainDealCycle553Simplified), 
                                   CaptainDealDatas, rep(max(CaptainDealCycle$Time), 6), CaptainDealCycleProbs)
CannonMasterDealRatio <- ResetDealRatio(DealCycles=GetList(CannonShooterSimplifiedCycleNames), 
                                        DealDatas=CannonShooterDealDatas, 
                                        rep(max(CannonShooterDealCycle_5Lightning$Time), length(CannonShooterSimplifiedCycleNames)), CSList$CycleProbs)
MikhailDealRatio <- DealRatio(MikhailDealCycleSimplified, MikhailFinalDPMwithMax)
SoulMasterDealRatio <- DealRatio(SoulMasterDealCycleSimplified, SoulMasterFinalDPMwithMax)
FlameWizardDealRatio <- DealRatio(FlameWizardDealCycleSimplified, FlameWizardFinalDPMwithMax)
WindBreakerDealRatio <- DealRatio(WindBreakerDealCycleSimplified, WindBreakerFinalDPMwithMax)
NightWalkerDealRatio <- DealRatio(NightWalkerDealCycleSimplified, NightWalkerFinalDPMwithMax)
StrikerDealRatio <- DealRatio(StrikerDealCycleSimplified, StrikerFinalDPMwithMax)
AranDealRatio <- DealRatio(AranDealCycleSimplified, AranFinalDPMwithMax)
EvanDealRatio <- ResetDealRatio(list(EvanDealCycleSimplified, EvanDealCycleHPSimplified), list(EvanDeal1, EvanDeal2), 
                                rep(max(EvanDealCycle$Time), 2), c(0.6592, 0.3408))
LuminousDealRatio <- DealRatio(LuminousDealCycleSimplified, LuminousFinalDPMwithMax)
MercedesDealRatio <- DealRatio(MercedesDealCycleSimplified, MercedesFinalDPMwithMax)
PhantomDealRatio <- ResetDealRatio(DealCycles=list(PhantomDealCycleSimplified, PhantomDealCycle2Simplified), DealDatas=list(PhantomDeal1, PhantomDeal2), 
                                   rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))
EunwolDealRatio <- ResetDealRatio(list(EunwolDealCycleFGXSimplified, EunwolDealCycleFGOSimplified), list(EunwolFGXDeal, EunwolFGODeal), rep(max(EunwolDealCycleFGX$Time), 2), c(0.5136, 0.4864))
BlasterDealRatio <- DealRatio(BlasterDealCycleSimplified, BlasterFinalDPMwithMax)
BattleMageDealRatio <- DealRatio(BattleMageDealCycleSimplified, BattleMageFinalDPMwithMax)
WildHunterDealRatio <- DealRatio(WildHunterDealCycleSimplified, WildHunterFinalDPMwithMax)
XenonDealRatio <- DealRatio(XenonDealCycleSimplified, XenonFinalDPMwithMax)
MechanicDealRatio <- ResetDealRatio(list(MechanicDealCycle5Simplified, MechanicDealCycle55Simplified, MechanicDealCycle555Simplified, 
                                         MechanicDealCycle53Simplified, MechanicDealCycle533Simplified, MechanicDealCycle553Simplified), 
                                    MechanicDealDatas, rep(max(MechanicDealCycle$Time), 6), MechanicDealCycleProbs)
DemonSlayerDealRatio <- DealRatio(DemonSlayerDealCycleSimplified, DemonSlayerFinalDPMwithMax)
DemonAvengerDealRatio <- DealRatio(DemonAvengerDealCycleSimplified, DemonAvengerFinalDPMwithMax)
KaiserDealRatio <- ResetDealRatio(DealCycles=KaiserDealCyclesSimplified, 
                                  DealDatas=KaiserDealDatas, 
                                  KaiserDealCycleTimes, KaiserDealCycleProbs)
KainDealRatio <- DealRatio(KainDealCycleSimplified, KainFinalDPMwithMax)
CadenaDealRatio <- DealRatio(CadenaDealCycleSimplified, CadenaFinalDPMwithMax)
AngelicBusterDealRatio <- ResetDealRatio(DealCycles=AngelicBusterDealCyclesSimplified, 
                                         DealDatas=AngelicBusterDealDatas, 
                                         AngelicBusterDealCycleTimes, AngelicBusterDealCycleProbs)
AdeleDealRatio <- DealRatio(AdeleDealCycleSimplified, AdeleFinalDPMwithMax)
IlliumDealRatio <- DealRatio(IlliumDealCycleSimplified, IlliumFinalDPMwithMax)
ArkDealRatio <- DealRatio(ArkDealCycleSimplified, ArkFinalDPMwithMax)
LaraDealRatio <- DealRatio(LaraDealCycleSimplified, LaraFinalDPMwithMax)
HoyeongDealRatio <- DealRatio(HoyeongDealCycleSimplified, HoyeongFinalDPMwithMax)
ZeroDealRatio <- DealRatio(ZeroDealCycleSimplified, ZeroFinalDPMwithMax)
KinesisDealRatio <- DealRatio(KinesisDealCycleSimplified, KinesisFinalDPMwithMax)


DealRatioSave <- function(JobName, DealRatioData, Modifier) {
  DealRatioData <- DealRatioData[order(DealRatioData$Ratio, decreasing=T), ]
  DealRatioData$Damage <- round(DealRatioData$Damage)
  DealRatioData$Ratio <- round(DealRatioData$Ratio, 4)
  write.csv(DealRatioData, paste("jobdata/", JobName, "/", JobName, "DealRatio", Modifier, ".csv", sep=""))
}
Modifier <- CSVExportOption$Modifier
for(i in 1:nrow(ChrInfo)) {
  DealRatioSave(ChrInfo$job[i], get(paste(ChrInfo$job[i], "DealRatio", sep="")), Modifier)
}