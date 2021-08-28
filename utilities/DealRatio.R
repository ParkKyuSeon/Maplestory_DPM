## Hero
HeroSkillList <- list(SwordIllusion=c("SwordIllusion", "SwordIllusionExplosion"), 
                      ComboInstinct=c("ScarofSpace"))
HeroDealCycleSimplified <- DealCycleCollapse(HeroDealCycle, HeroSkillList)

## Palladin
PalladinSkillList <- list(BlessedHammer=c("BlessedHammerBig", "BlessedHammerSmall"), 
                          GrandCross=c("GrandCrossBig", "GrandCrossSmall"), 
                          MightyMjolnir=c("MightyMjolnir", "MightyMjolnirExplosion"))
PalladinDealCycleSimplified <- DealCycleCollapse(PalladinDealCycle, PalladinSkillList)

## DarkKnight
DarkKnightSkillList <- list(DarknessAura=c("DarknessAura", "DarknessAuraEnd"), 
                            PierceCyclone=c("PierceCycloneTick", "PierceCycloneRemain", "PierceCycloneEnd"))
DarkKnightDealCycleSimplified <- DealCycleCollapse(DarkKnightDealCycle, DarkKnightSkillList)

## ArchMageFP
ArchMageFPSkillList <- list(DotPunisher=c("DotPunisher1st", "DotPunisherRemain"), 
                            EnergyBolt=c("EnergyBoltUnstable"), 
                            Explosion=c("ExplosionUnstable"), 
                            FlameHaze=c("FlameHaze", "FlameHazeUnstable"), 
                            FlameOrb=c("FlameOrbUnstable"), 
                            Ignite=c("Ignite", "IgniteDotPunisher", "IgniteDotPunisherFinalAttack", "IgniteMeteorFinalAttack", "IgnitePoisonNova", "IgniteUnstable", "IgniteUnstableFinalAttack"), 
                            MegiddoFlame=c("MegiddoFlame", "MegiddoFlameUnstable"), 
                            Meteor=c("Meteor", "MeteorFinalAttack", "MeteorFinalAttackDotPunisher", "MeteorFinalAttackPoisonNova", "MeteorFinalAttackUnstable", "MeteorUnstable"), 
                            MistEruption=c("MistEruption", "MistEruptionUnstable"), 
                            Paralyze=c("Paralyze", "ParalyzeUnstable"), 
                            PoisonBreath=c("PoisonBreathUnstable"), 
                            PoisonChain=c("PoisonChain1", "PoisonChain2", "PoisonChain3", "PoisonChain4", "PoisonChain5", "PoisonChainMax", "PoisonChainPre"), 
                            PoisonMist=c("PoisonMistUnstable"), 
                            PoisonNova=c("PoisonNova123", "PoisonNovaRemain", "PoisonNovaStart"))
ArchMageFPDealCycleSimplified <- DealCycleCollapse(ArchMageFPDealCycle, ArchMageFPSkillList)
ArchMageFPDealCycleSimplified2 <- DealCycleCollapse(ArchMageFPDealCycle2, ArchMageFPSkillList)

## ArchMageTC
ArchMageTCSkillList <- list(Blizard=c("Blizard", "BlizardFA", "BlizardUnstable", "UnstableBlizardFA", "UnstableBlizardFAOrb"), 
                            ChainLightning=c("ChainLightning", "ChainLightningUnstable"), 
                            ColdBeam=c("ColdBeamUnstable"), 
                            EnergyBolt=c("EnergyBoltUnstable"), 
                            FrozenOrb=c("FrozenOrb", "FrozenOrbUnstable"), 
                            GlacialChain=c("GlacialChainUnstable"), 
                            IceAge=c("IceAge", "IceAgeFloor"), 
                            IceStrike=c("IceStrikeUnstable"), 
                            LightningSpear=c("LightningSpearEnd", "LightningSpearEndUnstable", "LightningSpearLoop"), 
                            ThunderBolt=c("ThunderBoltUnstable"), 
                            ThunderBreak=c("ThunderBreak", "ThunderBreak2", "ThunderBreak3", "ThunderBreak4", "ThunderBreak5", "ThunderBreak6", "ThunderBreak7", "ThunderBreak8"))
ArchMageTCDealCycleSimplified <- DealCycleCollapse(ArchMageTCDealCycle, ArchMageTCSkillList)
ArchMageTCDealCycleSimplified2 <- DealCycleCollapse(ArchMageTCDealCycle2, ArchMageTCSkillList)

## Bishop
BishopSkillList <- list(AngelRay=c("AngelRay", "AngelRayUnstable"), 
                        Bigbang=c("BigbangUnstable"), 
                        DivinePunishment=c("DivinePunishment", "DivinePunishmentAfterUns1", "DivinePunishmentAfterUns2", "DivinePunishmentEnd"), 
                        EnergyBolt=c("EnergyBoltUnstable"), 
                        Genesis=c("GenesisUnstable"), 
                        HeavensDoor=c("HeavensDoor", "HeavensDoorUnstable"), 
                        HolyArrow=c("HolyArrowUnstable"), 
                        PeaceMaker=c("PeaceMaker", "PeaceMakerAfterUns1", "PeaceMakerAfterUns2", "PeaceMakerExplosion"), 
                        ShiningRay=c("ShiningRayUnstable"))
BishopDealCycleSimplified <- DealCycleCollapse(BishopDealCycle, BishopSkillList)
BishopDealCycleSimplified2 <- DealCycleCollapse(BishopDealCycle2, BishopSkillList)

## Marksman
MarksmanSkillList <- list(ChargedArrow=c("ChargedArrow", "ChargedArrowUncharged"))
MarksmanDealCycleSimplified <- DealCycleCollapse(MarksmanDealCycle, MarksmanSkillList)

## Bowmaster
BowmasterSkillList <- list(AfterimageArrow=c("AfterimageArrowPassive", "AfterimageArrowActive"), 
                           ArrowRain=c("ArrowRain1", "ArrowRain2"), 
                           AdvancedQuiver=c("QuiverMagic", "QuiverMagicRain"), 
                           QuiverFullBurst=c("QuiverFlame"))
BowmasterDealCycleSimplified <- DealCycleCollapse(BowmasterDealCycle, BowmasterSkillList)

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
ViperSkillList <- list(FistEnrage=c("FistEnrage", "FistEnrageFullCharge"), 
                       HawlingFist=c("HawlingFistLast", "HawlingFistStart"), 
                       Nautilus=c("Nautilus", "NautilusFinalATK"), 
                       SerpentScrew=c("SerpentScrewTick"), 
                       Transform=c("TransformOrb"))
ViperDealCycle5Simplified <- DealCycleCollapse(ViperDealCycle5, ViperSkillList)
ViperDealCycle55Simplified <- DealCycleCollapse(ViperDealCycle55, ViperSkillList)
ViperDealCycle57Simplified <- DealCycleCollapse(ViperDealCycle57, ViperSkillList)
ViperDealCycle555Simplified <- DealCycleCollapse(ViperDealCycle555, ViperSkillList)
ViperDealCycle557Simplified <- DealCycleCollapse(ViperDealCycle557, ViperSkillList)
ViperDealCycle577Simplified <- DealCycleCollapse(ViperDealCycle577, ViperSkillList)

## Captain
CaptainSkillList <- list(AssembleCrew=c("AssembleCrewJack", "AssembleCrewMurat", "AssembleCrewStoner", "AssembleCrewValery"), 
                         BattleShipBomber=c("BattleShipBomberBlackbark1", "BattleShipBomberBlackbark2", "BattleShipBomberDauntless1", "BattleShipBomberDauntless2", 
                                            "BattleShipBomberJonathan1", "BattleShipBomberJonathan2", "BattleShipBomberSchultz1", "BattleShipBomberSchultz2"), 
                         NautilusAssault=c("NautilusAssaultLast", "NautilusAssaultPre"))
CaptainDealCycle5Simplified <- DealCycleCollapse(CaptainDealCycle5, CaptainSkillList)
CaptainDealCycle55Simplified <- DealCycleCollapse(CaptainDealCycle55, CaptainSkillList)
CaptainDealCycle555Simplified <- DealCycleCollapse(CaptainDealCycle555, CaptainSkillList)

## CannonShooter
CannonShooterSkillList <- list(ICBM=c("ICBM", "ICBMFloor"), 
                               SpecialMonkeyEscort=c("MonkeyEscortBomb", "MonkeyEscortCannon"))
CannonShooterDealCyclesSimplified <- list()
for(i in 1:length(CannonShooterDealCycles)) {
  CannonShooterDealCyclesSimplified[[i]] <- DealCycleCollapse(CannonShooterDealCycles[[i]], CannonShooterSkillList)
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
                             InfinityFlameCircle=c("InfinityFlameCircleEnd", "InfinityFlameCircleTick"), 
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
EvanDealCycle_2Simplified <- DealCycleCollapse(EvanDealCycle_2, EvanSkillList)

## Luminous
LuminousSkillList <- list(AbsoluteKill=c("AbsoluteKill", "AbsoluteKillAdd", "AbsoluteKillEq"), 
                          Apocalypse=c("Apocalypse", "ApocalypseAdd"), 
                          LiberationOrb=c("LiberationOrbBalance", "LiberationOrbLight"), 
                          LightReflection=c("LightReflection", "LightReflectionAdd"))
LuminousDealCycleSimplified <- DealCycleCollapse(LuminousDealCycle, LuminousSkillList)

## Mercedes
MercedesSkillList <- list(AdvancedFinalAttack=c("AdvancedFinalAttack", "AdvancedFinalAttackEnlilGhost", "AdvancedFinalAttackIshtarGhost"), 
                          AdvancedStrikeDualShot=c("AdvancedStrikeDualShot", "AdvancedStrikeDualShotGhost"), 
                          BreathofIrkalla=c("BreathofIrkalla", "BreathofIrkallaGhost"), 
                          ElementalGhost=c("ElementalGhostTree"), 
                          ElementalKnight=c("ElementalKnightD", "ElementalKnightIF"), 
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
                        PashwaeCheoljoHoe=c("PashwaeCheoljoHoe", "PashwaeCheoljoHoeJipsok", "PashwaeCheoljoJeonJipsok"), 
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
DemonAvengerSkillList <- list(BloodFeast=c("BloodFeast1", "BloodFeast2", "BloodFeast3"), 
                              DimensionSword=c("DimensionSword", "DimensionSwordFast"), 
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
                      WindCutter=c("WindCutter", "WindCutterVortex", "WindStrike"))
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
ArchMageFPDealRatio <- InfinityDealRatio(ArchMageFPDealCycleSimplified, ArchMageFPDealCycleSimplified2, ArchMageFPDeal1, ArchMageFPDeal2, FPUnsdata)
ArchMageTCDealRatio <- InfinityDealRatio(ArchMageTCDealCycleSimplified, ArchMageTCDealCycleSimplified2, ArchMageTCDeal1, ArchMageTCDeal2, TCUnsdata)
BishopDealRatio <- InfinityDealRatio(BishopDealCycleSimplified, BishopDealCycleSimplified2, BishopDeal1, BishopDeal2, BIUnsdata)
MarksmanDealRatio <- DealRatio(MarksmanDealCycleSimplified, MarksmanFinalDPMwithMax)
BowmasterDealRatio <- DealRatio(BowmasterDealCycleSimplified, BowmasterFinalDPMwithMax)
PathFinderDealRatio <- DealRatio(PathFinderDealCycleSimplified, PathFinderFinalDPMwithMax)
NightLordDealRatio <- DealRatio(NightLordDealCycleSimplified, NightLordFinalDPMwithMax)
ShadowerDealRatio <- DealRatio(ShadowerDealCycleSimplified, ShadowerFinalDPMwithMax)
DualBladerDealRatio <- DealRatio(DualBladeDealCycleSimplified, DualBladeFinalDPMwithMax)
ViperDealRatio <- ResetDealRatio(DealCycles=list(ViperDealCycle5Simplified, 
                                                 ViperDealCycle55Simplified, ViperDealCycle57Simplified, 
                                                 ViperDealCycle555Simplified, ViperDealCycle557Simplified, ViperDealCycle577Simplified), 
                                 DealDatas=ViperDealDatas, rep(max(ViperDealCycle5Simplified$Time), 6), ViperDealCycleProbs)
CaptainDealRatio <- ResetDealRatio(list(CaptainDealCycle5Simplified, CaptainDealCycle55Simplified, CaptainDealCycle555Simplified), 
                                   CaptainDealDatas, rep(max(CaptainDealCycle$Time), 3), CaptainDealCycleProbs)
CannonMasterDealRatio <- ResetDealRatio(DealCycles=list(CannonShooterDealCyclesSimplified[[2]], CannonShooterDealCyclesSimplified[[1]], CannonShooterDealCyclesSimplified[[3]], 
                                                        CannonShooterDealCyclesSimplified[[4]], CannonShooterDealCyclesSimplified[[5]], CannonShooterDealCyclesSimplified[[6]],
                                                        CannonShooterDealCyclesSimplified[[7]], CannonShooterDealCyclesSimplified[[8]], CannonShooterDealCyclesSimplified[[9]]), 
                                        DealDatas=list(CannonShooterDealDatas[[2]], CannonShooterDealDatas[[1]], CannonShooterDealDatas[[3]], 
                                                       CannonShooterDealDatas[[4]], CannonShooterDealDatas[[5]], CannonShooterDealDatas[[6]],
                                                       CannonShooterDealDatas[[7]], CannonShooterDealDatas[[8]], CannonShooterDealDatas[[9]]), 
                                        rep(max(CannonShooterDealCycle$Time), 9), CannonShooterCycleProbs[c(2, 1, 3:9)])
MikhailDealRatio <- DealRatio(MikhailDealCycleSimplified, MikhailFinalDPMwithMax)
SoulMasterDealRatio <- DealRatio(SoulMasterDealCycleSimplified, SoulMasterFinalDPMwithMax)
FlameWizardDealRatio <- DealRatio(FlameWizardDealCycleSimplified, FlameWizardFinalDPMwithMax)
WindBreakerDealRatio <- DealRatio(WindBreakerDealCycleSimplified, WindBreakerFinalDPMwithMax)
NightWalkerDealRatio <- DealRatio(NightWalkerDealCycleSimplified, NightWalkerFinalDPMwithMax)
StrikerDealRatio <- DealRatio(StrikerDealCycleSimplified, StrikerFinalDPMwithMax)
AranDealRatio <- DealRatio(AranDealCycleSimplified, AranFinalDPMwithMax)
EvanDealRatio <- ResetDealRatio(list(EvanDealCycleSimplified, EvanDealCycle_2Simplified), list(EvanDeal1, EvanDeal2), 
                                rep(max(EvanDealCycle$Time), 2), c(0.6518, 0.3482))
LuminousDealRatio <- DealRatio(LuminousDealCycleSimplified, LuminousFinalDPMwithMax)
MercedesDealRatio <- DealRatio(MercedesDealCycleSimplified, MercedesFinalDPMwithMax)
PhantomDealRatio <- ResetDealRatio(DealCycles=list(PhantomDealCycleSimplified, PhantomDealCycle2Simplified), DealDatas=list(PhantomDeal1, PhantomDeal2), 
                                   rep(max(PhantomDealCycle$Time), 2), c(0.6, 0.4))
EunwolDealRatio <- ResetDealRatio(list(EunwolDealCycleFGXSimplified, EunwolDealCycleFGOSimplified), list(EunwolFGXDeal, EunwolFGODeal), rep(max(EunwolDealCycleFGX$Time), 2), c(0.5136, 0.4864))
BlasterDealRatio <- DealRatio(BlasterDealCycleSimplified, BlasterFinalDPMwithMax)
BattleMageDealRatio <- DealRatio(BattleMageDealCycleSimplified, BattleMageFinalDPMwithMax)
WildHunterDealRatio <- DealRatio(WildHunterDealCycleSimplified, WildHunterFinalDPMwithMax)
XenonDealRatio <- DealRatio(XenonDealCycleSimplified, XenonFinalDPMwithMax)
MechanicDealRatio <- ResetDealRatio(list(MechanicDealCycle5Simplified, MechanicDealCycle55Simplified, MechanicDealCycle555Simplified), 
                                    MechanicDealDatas, rep(max(MechanicDealCycle$Time), 3), MechanicDealCycleProbs)
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
Modifier <- "_L"
for(i in 1:nrow(ChrInfo)) {
  DealRatioSave(ChrInfo$job[i], get(paste(ChrInfo$job[i], "DealRatio", sep="")), Modifier)
}