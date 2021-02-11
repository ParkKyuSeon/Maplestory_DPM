## Option Settings
options("scipen"=500)
options("max.print"=100000)


## Character Info
job <- c("Hero", "Palladin", "DarkKinght", "ArchMageFP", "ArchMageTC", "Bishop", "Bowmaster", "Marksman", "PathFinder",
         "NightLord", "Shadower", "DualBlader", "Viper", "Captain", "CannonMaster", 
         "Mikhail", "SoulMaster", "FlameWizard", "WindBreaker", "NightWalker", "Striker", 
         "Aran", "Evan", "Luminous", "Mercedes", "Phantom", "Eunwol", 
         "Blaster", "BattleMage", "WildHunter", "Mechanic", "Xenon", "DemonSlayer", "DemonAvenger", 
         "Kaiser", "Cadena", "AngelicBuster", "Adele", "Illium", "Ark", "Hoyeong", "Zero", "Kinesis")
class1 <- c("Warrior", "Warrior", "Warrior", "Wizard", "Wizard", "Wizard", "Bowman", "Bowman", "Bowman",
            "Thief", "Thief", "Thief", "Pirate", "Pirate", "Pirate", 
            "Warrior", "Warrior", "Wizard", "Bowman", "Thief", "Pirate", 
            "Warrior", "Wizard", "Wizard", "Bowman", "Thief", "Pirate", 
            "Warrior", "Wizard", "Bowman", "Pirate", "Hybrid", "Warrior", "Warrior", 
            "Warrior", "Thief", "Pirate", "Warrior", "Wizard", "Pirate", "Thief", "Warrior", "Wizard")
class2 <- c(rep("Adventure", 15), rep("CygnusKnights", 6), rep("Heroes", 6), rep("Resistance", 5), rep("Demon", 2), 
            rep("Nova", 3), rep("Lef", 3), "Anima", "Transcedent", "Supernatural")
MainStat <- c("STR", "STR", "STR", "INT", "INT", "INT", "DEX", "DEX", "DEX", "LUK", "LUK", "LUK", "STR", "DEX", "STR",
              "STR", "STR", "INT", "DEX", "LUK", "STR", "STR", "INT", "INT", "DEX", "LUK", "STR", 
              "STR", "INT", "DEX", "DEX", "LUK", "STR", "HP", 
              "STR", "LUK", "DEX", "STR", "INT", "STR", "LUK", "STR", "INT")
SubStat1 <- c("DEX", "DEX", "DEX", "LUK", "LUK", "LUK", "STR", "STR", "STR", "DEX", "DEX", "DEX", "DEX", "STR", "DEX", 
              "DEX", "DEX", "LUK", "STR", "DEX", "DEX", "DEX", "LUK", "LUK", "STR", "DEX", "DEX", 
              "DEX", "LUK", "STR", "STR", "DEX", "DEX", "STR",
              "DEX", "DEX", "STR", "DEX", "LUK", "DEX", "DEX", "DEX", "LUK")
SubStat2 <- c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "STR", "STR", NA, NA, NA, 
              NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
              NA, NA, NA, NA, "STR", NA, NA,
              NA, "STR", NA, NA, NA, NA, NA, NA, NA)
BaseMastery <- c(20, 20, 20, 25, 25, 25, 15, 15, 15, 15, 20, 20, 20, 15, 15, 20, 20, 25, 15, 15, 20, 20, 25, 25, 15, 20, 20, 
                 20, 25, 15, 15, 20, 20, 20, 20, 20, 15, 20, 20, 20, 20, 20, 25)
ChrInfo <- data.frame(job, class1, class2, MainStat, SubStat1, SubStat2, BaseMastery, stringsAsFactors=F)


## DPMs
DPM <- data.frame(t(rep(0, 43)))
DPM <- rbind(DPM, DPM)
colnames(DPM) <- job
rownames(DPM) <- c("DPM", "DamageLeakage")

DPMTver <- data.frame(t(rep(0, 43)))
DPMTver <- rbind(DPMTver, DPMTver)
colnames(DPMTver) <- job
rownames(DPMTver) <- c("DPM", "DamageLeakage")

DPM12338 <- data.frame(t(rep(0, 43)))
DPM12338 <- rbind(DPM12338, DPM12338, DPM12338, DPM12338)
colnames(DPM12338) <- job
rownames(DPM12338) <- c("DPM", "DamageLeakage", "Restraint", "40s")