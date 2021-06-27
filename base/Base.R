## Option Settings
options("scipen"=500)
options("max.print"=100000)


## Character Info
job <- c("Hero", "Palladin", "DarkKnight", "ArchMageFP", "ArchMageTC", "Bishop", "Bowmaster", "Marksman", "PathFinder",
         "NightLord", "Shadower", "DualBlader", "Viper", "Captain", "CannonMaster", 
         "Mikhail", "SoulMaster", "FlameWizard", "WindBreaker", "NightWalker", "Striker", 
         "Aran", "Evan", "Luminous", "Mercedes", "Phantom", "Eunwol", 
         "Blaster", "BattleMage", "WildHunter", "Mechanic", "Xenon", "DemonSlayer", "DemonAvenger", 
         "Kaiser", "Kain", "Cadena", "AngelicBuster", "Adele", "Illium", "Ark", "Lara", "Hoyeong", "Zero", "Kinesis")
class1 <- c("Warrior", "Warrior", "Warrior", "Wizard", "Wizard", "Wizard", "Bowman", "Bowman", "Bowman",
            "Thief", "Thief", "Thief", "Pirate", "Pirate", "Pirate", 
            "Warrior", "Warrior", "Wizard", "Bowman", "Thief", "Pirate", 
            "Warrior", "Wizard", "Wizard", "Bowman", "Thief", "Pirate", 
            "Warrior", "Wizard", "Bowman", "Pirate", "Hybrid", "Warrior", "Warrior", 
            "Warrior", "Bowman", "Thief", "Pirate", "Warrior", "Wizard", "Pirate", "Wizard", "Thief", "Warrior", "Wizard")
class2 <- c(rep("Adventure", 15), rep("CygnusKnights", 6), rep("Heroes", 6), rep("Resistance", 5), rep("Demon", 2), 
            rep("Nova", 4), rep("Lef", 3), rep("Anima", 2), "Transcedent", "Supernatural")
MainStat <- c("STR", "STR", "STR", "INT", "INT", "INT", "DEX", "DEX", "DEX", "LUK", "LUK", "LUK", "STR", "DEX", "STR",
              "STR", "STR", "INT", "DEX", "LUK", "STR", "STR", "INT", "INT", "DEX", "LUK", "STR", 
              "STR", "INT", "DEX", "DEX", "LUK", "STR", "HP", 
              "STR", "DEX", "LUK", "DEX", "STR", "INT", "STR", "INT", "LUK", "STR", "INT")
SubStat1 <- c("DEX", "DEX", "DEX", "LUK", "LUK", "LUK", "STR", "STR", "STR", "DEX", "DEX", "DEX", "DEX", "STR", "DEX", 
              "DEX", "DEX", "LUK", "STR", "DEX", "DEX", "DEX", "LUK", "LUK", "STR", "DEX", "DEX", 
              "DEX", "LUK", "STR", "STR", "DEX", "DEX", "STR",
              "DEX", "STR", "DEX", "STR", "DEX", "LUK", "DEX", "LUK", "DEX", "DEX", "LUK")
SubStat2 <- c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "STR", "STR", NA, NA, NA, 
              NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
              NA, NA, NA, NA, "STR", NA, NA,
              NA, NA, "STR", NA, NA, NA, NA, NA, NA, NA, NA)
BaseMastery <- c(20, 20, 20, 25, 25, 25, 15, 15, 15, 
                 15, 20, 20, 20, 15, 15, 
                 20, 20, 25, 15, 15, 20, 
                 20, 25, 25, 15, 20, 20, 
                 20, 25, 15, 15, 20, 20, 20, 
                 20, 15, 20, 15, 20, 20, 20, 25, 20, 20, 20)
ChrInfo <- data.frame(job, class1, class2, MainStat, SubStat1, SubStat2, BaseMastery, stringsAsFactors=F)


## DPMs
# DPM12344 <- data.frame(t(rep(0, 43)))
# DPM12344 <- rbind(DPM12344, DPM12344, DPM12344, DPM12344)
# colnames(DPM12344) <- job
# rownames(DPM12344) <- c("DPM", "DamageLeakage", "Restraint", "40s")

# DPM12347 <- data.frame(t(rep(0, 43)))
# DPM12347 <- rbind(DPM12347, DPM12347, DPM12347, DPM12347)
# colnames(DPM12347) <- job
# rownames(DPM12347) <- c("DPM", "DamageLeakage", "Restraint", "40s")

DPM12349 <- data.frame(t(rep(0, 45)))
DPM12349 <- rbind(DPM12349, DPM12349, DPM12349, DPM12349)
colnames(DPM12349) <- job
rownames(DPM12349) <- c("DPM", "DamageLeakage", "Restraint", "40s")
