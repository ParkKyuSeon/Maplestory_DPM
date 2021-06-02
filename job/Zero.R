## Zero - Data
## Zero - VMatrix
ZeroCore <- MatrixSet(PasSkills=c("MoonStrike_ShadowStrike_UpperSlash", "PierceThrust_PowerStump", "SpinCutter_ThrowingWeapon", 
                                  "RollingCurve_TurningDrive", "RollingAssaulter_WhirlWind", "WindCutter_GigaCrash", 
                                  "WindStrike_JumpingCrash", "StormBreak_EarthBreak", "ShadowRain"), 
                      PasLvs=c(50, 50, 50, 50, 50, 50, 50, 50, 50), 
                      PasMP=c(10, 10, 10, 10, 10, 10, 10, 10, 10), 
                      ActSkills=c("LimitBreak", "JointAttack", "ShadowFlash", "EgoWeapon", 
                                  na.omit(CommonV("Warrior", "Transcedent"))), 
                      ActLvs=c(25, 25, 25, 25, 25, 1, 25, 25), 
                      ActMP=c(5, 5, 5, 5, 5, 0, 0, 0), 
                      BlinkLv=1, 
                      BlinkMP=0, 
                      UsefulSkills=c("SharpEyes", "WindBooster"), 
                      UsefulLvs=20, 
                      UsefulMP=0, 
                      SpecSet=SpecDefault, 
                      SelfBind=F)