## item option data
# Set Symbol : "1" : Boss, "2" : Black Boss, "3" : Chaos Root Abyss, "4" : Absolabs, "5" : Arcane Shade, "6" : Meister
# Set Symbol : "0" : None, "7" : MosterPark, "8" : Lucky, "9" : MasterLabel
itemoption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
                "MainStatP", "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "Superior", "IGR", "BDR", "CRR", "CDMR")
{Silver <- c(110, 5, 5, 5, 0, 0, 2, 2, 0, 0, 2, F, F, 1, F, 0, 0, 0, 0)
Ipia <- c(120, 5, 5, 5, 200, 0, 2, 2, 0, 0, 2, F, F, 1, F, 0, 0, 0, 0)
Meister <- c(140, 5, 5, 5, 200, 0, 1, 1, 0, 0, 1, F, F, 6, F, 0, 0, 0, 0)
DeepDark <- c(130, 20, 20, 20, 0, 1000, 20, 20, 0, 0, 0, F, F, 0, F, 0, 0, 15, 5)
Awake <- c(120, 40, 40, 40, 4000, 0, 25, 25, 0, 0, 0, F, F, 0, F, 0, 0, 0, 0)
Scarlet <- c(135, 4, 4, 4, 150, 0, 1, 1, 0, 0, 1, F, F, 8, F, 0, 0, 0, 0)
Seed <- c(110, 4, 4, 4, 0, 0, 4, 4, 0, 0, 0, F, F, 0, F, 0, 0, 0, 0)
Fear <- c(200, 5, 5, 5, 250, 0, 4, 4, 0, 0, 2, F, F, 2, F, 0, 0, 0, 0)
Ring <- rbind(Silver, Ipia, Meister, DeepDark, Awake, Scarlet, Seed, Fear)
colnames(Ring) <- itemoption

Pink <- c(140, 5, 5, 5, 50, 0, 5, 5, 0, 0, 0, T, T, 1, F, 0, 0, 0, 0)
Grimoire <- c(160, 20, 10, 10, 100, 0, 10, 10, 0, 0, 0, T, T, 2, F, 0, 0, 0, 0)
Pocket <- rbind(Pink, Grimoire)
colnames(Pocket) <- itemoption

Dominator <- c(140, 20, 20, 20, 0, 10, 3, 3, 0, 0, 5, T, T, 1, F, 0, 0, 0, 0)
Macanator <- c(120, 10, 10, 10, 250, 0, 1, 1, 0, 0, 2, T, T, 1, F, 0, 0, 0, 0)
Pain <- c(160, 10, 10, 10, 0, 5, 3, 3, 0, 0, 5, T, T, 2, F, 0, 0, 0, 0)
Purple <- c(130, 16, 0, 0, 180, 0, 0, 0, 0, 0, 3, T, F, 0, F, 0, 0, 0, 0)
Pendant <- rbind(Dominator, Macanator, Pain, Purple)
colnames(Pendant) <- itemoption

Zakum <- c(150, 18, 18, 18, 150, 0, 1, 1, 0, 0, 3, T, T, 1, F, 0, 0, 0, 0)
Tyrant <- c(150, 50, 50, 50, 0, 0, 25, 25, 0, 0, 1, T, T, 0, T, 0, 0, 0, 0)
Dream <- c(200, 50, 50, 50, 150, 0, 6, 6, 0, 0, 3, T, T, 2, F, 0, 0, 0, 0)
Belt <- rbind(Zakum, Tyrant, Dream)
colnames(Belt) <- itemoption

Vellum <- c(140, 23, 23, 23, 0, 0, 1, 1, 0, 0, 11, T, F, 8, F, 0, 0, 0, 0)
Fafnir <- c(150, 40, 40, 0, 360, 0, 2, 0, 0, 0, 11, T, T, 3, F, 10, 0, 0, 0)
Absolabs <- c(160, 45, 45, 0, 0, 0, 3, 0, 0, 0, 11, T, T, 4, F, 10, 0, 0, 0)
Arcane <- c(200, 65, 65, 0, 0, 0, 7, 0, 0, 0, 11, T, T, 5, F, 10, 0, 0, 0)
Hat <- rbind(Vellum, Fafnir, Absolabs, Arcane)
colnames(Hat) <- itemoption

Condensed <- c(110, 5, 5, 5, 0, 0, 5, 5, 0, 0, 5, T, T, 1, F, 0, 0, 0, 0)
LCMM <- c(160, 10, 10, 10, 0, 0, 10, 10, 0, 0, 5, T, T, 2, F, 0, 0, 0, 0)
ShinyRed <- c(130, 3, 3, 0, 0, 0, 3, 3, 0, 0, 1, T, F, 0, F, 0, 0, 0, 0)
Forehead <- rbind(Condensed, LCMM, ShinyRed)
colnames(Forehead) <- itemoption

Papulatus <- c(145, 8, 8, 8, 0, 0, 1, 1, 0, 0, 5, T, T, 1, F, 0, 0, 0, 0)
Demian <- c(160, 15, 15, 15, 0, 0, 3, 3, 0, 0, 3, T, T, 2, F, 0, 0, 0, 0)
Eyeacc <- rbind(Papulatus, Demian)
colnames(Eyeacc) <- itemoption

Fafnir <- c(150, 30, 30, 0, 0, 0, 2, 0, 0, 0, 7, T, T, 3, F, 5, 0, 0, 0)
Clothes <- rbind(Fafnir)
colnames(Clothes) <- itemoption
Pants <- rbind(Fafnir)
colnames(Pants) <- itemoption

Absolabs <- c(160, 20, 20, 0, 0, 0, 5, 0, 0, 0, 7, T, T, 4, F, 0, 0, 0, 0)
Arcane <- c(200, 40, 40, 0, 0, 0, 9, 0, 0, 0, 7, T, T, 5, F, 0, 0, 0, 0)
Shoes <- rbind(Absolabs, Arcane)
colnames(Shoes) <- itemoption

Thea <- c(130, 5, 5, 5, 0, 0, 2, 2, 0, 0, 6, T, T, 1, F, 0, 0, 0, 0)
Ocean <- c(150, 7, 7, 7, 750, 0, 5, 5, 0, 0, 7, T, T, 0, F, 0, 0, 0, 0)
Commander <- c(200, 7, 7, 7, 500, 0, 5, 5, 0, 0, 6, T, T, 2, F, 0, 0, 0, 0)
Earings <- rbind(Thea, Ocean, Commander)
colnames(Earings) <- itemoption

Absolabs <- c(160, 14, 14, 14, 0, 0, 10, 10, 0, 0, 1, F, F, 4, F, 0, 0, 0, 0)
Arcane <- c(200, 35, 35, 35, 0, 0, 20, 20, 0, 0, 1, F, F, 5, F, 0, 0, 0, 0)
Shoulder <- rbind(Absolabs, Arcane)
colnames(Shoulder) <- itemoption

Absolabs <- c(160, 20, 20, 0, 0, 0, 5, 0, 0, 0, 7, T, T, 4, F, 0, 0, 0, 0)
Arcane <- c(200, 40, 40, 0, 0, 0, 9, 0, 0, 0, 7, T, T, 5, F, 0, 0, 0, 0)
Gloves <- rbind(Absolabs, Arcane)
colnames(Gloves) <- itemoption

Crystal <- c(130, 10, 10, 10, 0, 0, 5, 5, 0, 0, 0, F, F, 1, F, 0, 0, 0, 0)
MonsterPark <- c(100, 7, 7, 7, 0, 0, 7, 7, 0, 0, 0, F, F, 7, F, 10, 0, 0, 0)
Badge <- rbind(Crystal, MonsterPark)
colnames(Badge) <- itemoption

MonsterPark <- c(100, 7, 7, 7, 0, 0, 7, 7, 0, 0, 0, F, F, 7, F, 10, 0, 0, 0)
Red <- c(0, 7, 7, 7, 0, 0, 7, 7, 0, 0, 0, F, F, 0, F, 0, 5, 0, 0)
VellumKiller <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, F, 0, 5, 0, 0)
Medal <- rbind(MonsterPark, Red, VellumKiller)
colnames(Medal) <- itemoption

Absolabs <- c(160, 15, 15, 15, 0, 0, 2, 2, 0, 0, 7, T, T, 4, F, 0, 0, 0, 0)
Arcane <- c(200, 35, 35, 35, 0, 0, 6, 6, 0, 0, 7, T, T, 5, F, 0, 0, 0, 0)
Cape <- rbind(Absolabs, Arcane)
colnames(Cape) <- itemoption

Titanium <- c(100, 3, 3, 3, 50, 0, 0, 0, 0, 0, 9, F, F, 0, F, 0, 0, 0, 0)
LiquidMetal <- c(130, 3, 3, 3, 50, 0, 0, 0, 0, 0, 9, F, F, 0, F, 0, 0, 0, 0)
Heart <- rbind(Titanium, LiquidMetal)
colnames(Heart) <- itemoption

CrystalKey <- c(0, 0, 0, 0, 0, 0, 10, 10, 0, 0, 8, F, F, 0, F, 0, 0, 0, 0) 
Dream <- c(0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 9, F, F, 0, F, 0, 0, 0, 0)
PetEqip <- rbind(CrystalKey, Dream)
colnames(PetEqip) <- itemoption ## GoldenHammer Unavailable

RootAbyss <- c(0, 8, 8, 8, 300, 0, 3, 3, 0, 0, 0, F, F, 0, F, 5, 5, 0, 0)
PinkBean <- c(0, 10, 10, 10, 0, 0, 5, 5, 0, 0, 0, F, F, 0, F, 0, 10, 0, 0)
MapleExpert <- c(0, 10, 10, 10, 0, 0, 5, 5, 0, 0, 0, F, F, 0, F, 10, 0, 0, 0)
Title <- rbind(MapleExpert, RootAbyss, PinkBean)
colnames(Title) <- itemoption

MasterLabelWeapon <- c(0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, F, F, 9, F, 0, 0, 0, 0)
MasterLabelClothes <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 9, F, 0, 0, 0, 0)
MasterLabelCape <- c(0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 9, F, 0, 0, 0, 0)
MasterLabelShoes <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 9, F, 0, 0, 0, 0)
MasterLabelHat <- c(0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 9, F, 0, 0, 0, 0)
MasterLabel <- rbind(MasterLabelWeapon, MasterLabelClothes, MasterLabelCape, MasterLabelShoes, MasterLabelHat)
colnames(MasterLabel) <- itemoption}

item <- list(Ring, Pocket, Pendant, Belt, Hat, Forehead, Eyeacc, Clothes, Pants, 
             Shoes, Earings, Shoulder, Gloves, Badge, Medal, Cape, Heart, PetEqip, Title, MasterLabel)


## Item List
Items <- c("Ring1", "Ring2", "Ring3", "Ring4", "Pocket", "Pendant1", "Pendant2", "Belt",
           "Hat", "Forehead", "Eyeacc", "Clothes", "Pants", "Shoes", "Earings", "Shoulder", 
           "Gloves", "Badge", "Medal", "Cape", "Heart", "PetEqip1", "PetEqip2", "PetEqip3", "Title", 
           "MasterLabel1", "MasterLabel2", "MasterLabel3", "MasterLabel4", "MasterLabel5")
{StandardSpecs <- rbind(item[[1]][1, ], item[[1]][3, ], item[[1]][5, ], item[[1]][7, ],
                       item[[2]][1, ], item[[3]][1, ], item[[3]][2, ], item[[4]][1, ], 
                       item[[5]][3, ], item[[6]][1, ], item[[7]][1, ], item[[8]][1, ], 
                       item[[9]][1, ], item[[10]][1, ], item[[11]][1, ], item[[12]][1, ],
                       item[[13]][1, ], item[[14]][1, ], item[[15]][1, ], item[[16]][1, ],
                       item[[17]][1, ], item[[18]][2, ], item[[18]][2, ], item[[18]][2, ],
                       item[[19]][3, ], item[[20]][1, ], item[[20]][2, ], item[[20]][3, ],
                       item[[20]][4, ], item[[20]][5, ])
StandardSpecZero <- rbind(item[[1]][1, ], item[[1]][3, ], item[[1]][5, ], item[[1]][7, ],
                          item[[2]][1, ], item[[3]][1, ], item[[3]][2, ], item[[4]][1, ], 
                          item[[5]][1, ], item[[6]][1, ], item[[7]][1, ], item[[8]][1, ], 
                          item[[9]][1, ], item[[10]][1, ], item[[11]][1, ], item[[12]][1, ],
                          item[[13]][1, ], item[[14]][1, ], item[[15]][1, ], item[[16]][1, ],
                          item[[17]][1, ], item[[18]][2, ], item[[18]][2, ], item[[18]][2, ],
                          item[[19]][3, ], item[[20]][1, ], item[[20]][2, ], item[[20]][3, ],
                          item[[20]][4, ], item[[20]][5, ])
EndSpecs <- rbind(item[[1]][3, ], item[[1]][6, ], item[[1]][8, ], item[[1]][7, ],
                  item[[2]][2, ], item[[3]][1, ], item[[3]][3, ], item[[4]][3, ],
                  item[[5]][4, ], item[[6]][2, ], item[[7]][2, ], item[[8]][1, ], 
                  item[[9]][1, ], item[[10]][2, ], item[[11]][3, ], item[[12]][2, ],
                  item[[13]][2, ], item[[14]][2, ], item[[15]][1, ], item[[16]][2, ],
                  item[[17]][2, ], item[[18]][1, ], item[[18]][1, ], item[[18]][1, ],
                  item[[19]][3, ], item[[20]][1, ], item[[20]][2, ], item[[20]][3, ],
                  item[[20]][4, ], item[[20]][5, ])}
rownames(StandardSpecs) <- Items
rownames(StandardSpecZero) <- Items
rownames(EndSpecs) <- Items


## Fafnir
weaponoption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "ATK", "ATKSub", 
                  "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "IGR", "BDR", "CRR", "CDMR", 
                  "ATKSpeed", "Hand", "WeaponConstant")
{Sword <- c(150, 40, 40, 0, 0, 164, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 1, 1.2)
Hammer <- c(150, 40, 40, 0, 0, 164, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 1, 1.2)
TwohandSword <- c(150, 40, 40, 0, 0, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.34)
TwohandAxe <- c(150, 40, 40, 0, 0, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.34)
TwohandHammer <- c(150, 40, 40, 0, 0, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.34)
Polarm <- c(150, 40, 40, 0, 0, 153, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 2, 1.49)
Spear <- c(150, 40, 40, 0, 0, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.49)
GuntletRevolver <- c(150, 40, 40, 0, 0, 128, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 2, 1.7)
Desperado <- c(150, 0, 40, 0, 2000, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1.3)
Tuner <- c(150, 40, 40, 0, 0, 171, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 4, 1, 1.3) # WeaponConstant Need to be Checked
LongSword <- c(170, 40, 40, 0, 0, 169, 0, 0, 8, T, F, 8, 10, 30, 0, 0, 6, 2, 1.34) # ZeroWeapon
HeavySword <- c(170, 40, 40, 0, 0, 173, 0, 0, 8, T, F, 8, 10, 30, 0, 0, 8, 2, 1.49) # ZeroWeapon
Staff <- c(150, 40, 40, 0, 0, 204, 126, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1)
Wand <- c(150, 40, 40, 0, 0, 201, 119, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1)
ShiningLord <- c(150, 40, 40, 0, 0, 201, 119, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1.2)
MagicGuntlet <- c(150, 40, 40, 0, 0, 201, 119, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1.2)
ESPLimiter <- c(150, 40, 40, 0, 0, 201, 119, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 1, 1.2)
Bow <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.3)
Crossbow <- c(150, 40, 40, 0, 0, 164, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.35)
AncientBow <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.3)
DualBowgun <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.3)
BreathShooter <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 6, 2, 1.3)
Wristband <- c(150, 40, 40, 0, 0, 86, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 4, 2, 1.75)
Dagger <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 4, 1, 1.3)
Cane <- c(150, 40, 40, 0, 0, 164, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 1, 1.3)
Chain <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 4, 1, 1.3)
Fan <- c(150, 40, 40, 0, 0, 160, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 4, 1, 1.3)
Gun <- c(150, 40, 40, 0, 0, 125, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 2, 1.5)
Knuckle <- c(150, 40, 40, 0, 0, 128, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 2, 1.7)
HandCannon <- c(150, 40, 40, 0, 0, 175, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 8, 2, 1.5)
EnergySword <- c(150, 40, 40, 0, 0, 128, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 1, 1.5)
SoulShooter <- c(150, 40, 40, 0, 0, 128, 0, 0, 8, T, T, 3, 10, 30, 0, 0, 5, 1, 1.7)}
Fafnir <- rbind(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
                Tuner, LongSword, HeavySword, 
                Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
                Bow, Crossbow, AncientBow, DualBowgun, BreathShooter, 
                Wristband, Dagger, Cane, Chain, Fan,
                Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
colnames(Fafnir) <- weaponoption


## Absolabs
{Sword <- c(160, 60, 60, 0, 0, 197, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 1, 1.2)
Hammer <- c(160, 60, 60, 0, 0, 197, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 1, 1.2)
TwohandSword <- c(160, 60, 60, 0, 0, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.34)
TwohandAxe <- c(160, 60, 60, 0, 0, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.34)
TwohandHammer <- c(160, 60, 60, 0, 0, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.34)
Polarm <- c(160, 60, 60, 0, 0, 184, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 2, 1.49)
Spear <- c(160, 60, 60, 0, 0, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.49)
GuntletRevolver <- c(160, 60, 60, 0, 0, 154, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 2, 1.70)
Desperado <- c(160, 0, 60, 0, 2250, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1.3)
Tuner <- c(160, 60, 60, 0, 0, 205, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 4, 1, 1.3) # WeaponConstant Need to be Checked
LongSword <- c(180, 60, 60, 0, 0, 203, 0, 0, 8, T, F, 8, 10, 30, 0, 0, 6, 2, 1.34) # ZeroWeapon
HeavySword <- c(180, 60, 60, 0, 0, 207, 0, 0, 8, T, F, 8, 10, 30, 0, 0, 8, 2, 1.49) # ZeroWeapon
Staff <- c(160, 60, 60, 0, 0, 245, 151, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1)
Wand <- c(160, 60, 60, 0, 0, 241, 143, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1)
ShiningLord <- c(160, 60, 60, 0, 0, 241, 143, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1.2)
MagicGuntlet <- c(160, 60, 60, 0, 0, 241, 143, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1.2)
ESPLimiter <- c(160, 60, 60, 0, 0, 241, 143, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 1, 1.2)
Bow <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.3)
Crossbow <- c(160, 60, 60, 0, 0, 197, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.35)
AncientBow <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.3)
DualBowgun <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.3)
BreathShooter <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 6, 2, 1.3)
Wristband <- c(160, 60, 60, 0, 0, 103, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 4, 2, 1.75)
Dagger <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 4, 1, 1.3)
Cane <- c(160, 60, 60, 0, 0, 197, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 1, 1.3)
Chain <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 4, 1, 1.3)
Fan <- c(160, 60, 60, 0, 0, 192, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 4, 1, 1.3)
Gun <- c(160, 60, 60, 0, 0, 150, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 2, 1.5)
Knuckle <- c(160, 60, 60, 0, 0, 154, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 2, 1.7)
HandCannon <- c(160, 60, 60, 0, 0, 210, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 8, 2, 1.5)
EnergySword <- c(160, 60, 60, 0, 0, 154, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 1, 1.5)
SoulShooter <- c(160, 60, 60, 0, 0, 154, 0, 0, 8, T, T, 4, 10, 30, 0, 0, 5, 1, 1.7)}
Absolabs <- rbind(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
                  Tuner, LongSword, HeavySword, 
                  Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
                  Bow, Crossbow, AncientBow, DualBowgun, BreathShooter, 
                  Wristband, Dagger, Cane, Chain, Fan,
                  Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
colnames(Absolabs) <- weaponoption


## ArcaneShade
{Sword <- c(200, 100, 100, 0, 0, 283, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 1, 1.2)
Hammer <- c(200, 100, 100, 0, 0, 283, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 1, 1.2)
TwohandSword <- c(200, 100, 100, 0, 0, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.34)
TwohandAxe <- c(200, 100, 100, 0, 0, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.34)
TwohandHammer <- c(200, 100, 100, 0, 0, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.34)
Polarm <- c(200, 100, 100, 0, 0, 264, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 2, 1.49)
Spear <- c(200, 100, 100, 0, 0, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.49)
GuntletRevolver <- c(200, 100, 100, 0, 0, 221, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 2, 1.7)
Desperado <- c(200, 0, 100, 0, 2500, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1.3)
Tuner <- c(200, 100, 100, 0, 0, 295, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 4, 1, 1.3) # WeaponConstant Need to be Checked
LongSword <- c(200, 100, 100, 0, 0, 293, 0, 0, 8, T, F, 8, 20, 30, 0, 0, 6, 2, 1.34) # ZeroWeapon
HeavySword <- c(200, 100, 100, 0, 0, 297, 0, 0, 8, T, F, 8, 20, 30, 0, 0, 8, 2, 1.49) # ZeroWeapon
Staff <- c(200, 100, 100, 0, 0, 353, 218, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1)
Wand <- c(200, 100, 100, 0, 0, 347, 206, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1)
ShiningLord <- c(200, 100, 100, 0, 0, 347, 206, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1.2)
MagicGuntlet <- c(200, 100, 100, 0, 0, 347, 206, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1.2)
ESPLimiter <- c(200, 100, 100, 0, 0, 347, 206, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 1, 1.2)
Bow <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.3)
Crossbow <- c(200, 100, 100, 0, 0, 283, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.35)
AncientBow <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.3)
DualBowgun <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.3)
BreathShooter <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 6, 2, 1.3)
Wristband <-c(200, 100, 100, 0, 0, 149, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 4, 2, 1.75)
Dagger <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 4, 1, 1.3)
Cane <- c(200, 100, 100, 0, 0, 283, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 1, 1.3)
Chain <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 4, 1, 1.3)
Fan <- c(200, 100, 100, 0, 0, 276, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 4, 1, 1.3)
Gun <- c(200, 100, 100, 0, 0, 216, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 2, 1.5)
Knuckle <- c(200, 100, 100, 0, 0, 221, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 2, 1.7)
HandCannon <- c(200, 100, 100, 0, 0, 302, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 8, 2, 1.5)
EnergySword <- c(200, 100, 100, 0, 0, 221, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 1, 1.5)
SoulShooter <- c(200, 100, 100, 0, 0, 221, 0, 0, 8, T, T, 5, 20, 30, 0, 0, 5, 1, 1.7)}
ArcaneShade <- rbind(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
                     Tuner, LongSword, HeavySword, 
                     Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
                     Bow, Crossbow, AncientBow, DualBowgun, BreathShooter, 
                     Wristband, Dagger, Cane, Chain, Fan,
                     Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
colnames(ArcaneShade) <- weaponoption


## Weapon Addoption
### Tier 4
{rm(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
   Tuner, LongSword, HeavySword, 
   Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
   Bow, Crossbow, AincientBow, DualBowgun, BreathShooter, 
   Wristband, Dagger, Cane, Chain, Fan,
   Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
Sword <- c(53, 79, 136)
Hammer <- c(53, 79, 136)
TwohandSword <- c(55, 82, 142)
TwohandAxe <- c(55, 82, 142)
TwohandHammer <- c(55, 82, 142)
Polarm <- c(49, 74, 127)
Spear <- c(55, 82, 142)
GuntletRevolver <- c(41, 62, 106)
Desperado <- c(55, 82, 142)
Tuner <- c(55, 82, 142)
LongSword <- c(47, 56, 95)
HeavySword <- c(47, 56, 95)
Staff <- c(66, 98, 170)
Wand <- c(65, 97, 167)
ShiningLord <- c(65, 97, 167)
MagicGuntlet <- c(65, 97, 167)
ESPLimiter <- c(65, 97, 167)
Bow <- c(52, 77, 133)
Crossbow <- c(53, 79, 136)
AincientBow <- c(52, 77, 133)
DualBowgun <- c(52, 77, 133)
BreathShooter <- c(52, 77, 133)
Wristband <- c(28, 42, 72)
Dagger <- c(52, 77, 133)
Cane <- c(53, 79, 136)
Chain <- c(52, 77, 133)
Fan <- c(52, 77, 133)
Gun <- c(40, 60, 104)
Knuckle <- c(41, 62, 106)
HandCannon <- c(56, 84, 145)
EnergySword <- c(41, 62, 106)
SoulShooter <- c(41, 62, 106)}
AddoptionTier4 <- rbind(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
                        Tuner, LongSword, HeavySword, 
                        Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
                        Bow, Crossbow, AincientBow, DualBowgun, BreathShooter,
                        Wristband, Dagger, Cane, Chain, Fan,
                        Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
colnames(AddoptionTier4) <- c("Fafnir", "Absolabs", "ArcaneShade")


### Tier 5
{Sword <- c(68, 101, 175)
Hammer <- c(68, 101, 175)
TwohandSword <- c(71, 106, 182)
TwohandAxe <- c(71, 106, 182)
TwohandHammer <- c(71, 106, 182)
Polarm <- c(63, 95, 163)
Spear <- c(71, 106, 182)
GuntletRevolver <- c(53, 79, 136)
Desperado <- c(71, 106, 182)
Tuner <- c(71, 106, 182)
LongSword <- c(64, 76, 131)
HeavySword <- c(64, 76, 131)
Staff <- c(84, 126, 218)
Wand <- c(83, 124, 214)
ShiningLord <- c(83, 124, 214)
MagicGuntlet <- c(83, 124, 214)
ESPLimiter <- c(83, 124, 214)
Bow <- c(66, 99, 170)
Crossbow <- c(68, 101, 175)
AincientBow <- c(66, 99, 170)
DualBowgun <- c(66, 99, 170)
BreathShooter <- c(66, 99, 170)
Wristband <- c(36, 53, 92)
Dagger <- c(66, 99, 170)
Cane <- c(68, 101, 175)
Chain <- c(66, 99, 170)
Fan <- c(66, 99, 170)
Gun <- c(52, 77, 133)
Knuckle <- c(53, 79, 136)
HandCannon <- c(72, 108, 186)
EnergySword <- c(53, 79, 136)
SoulShooter <- c(53, 79, 136)}
AddoptionTier5 <- rbind(Sword, Hammer, TwohandSword, TwohandAxe, TwohandHammer, Polarm, Spear, GuntletRevolver, Desperado, 
                        Tuner, LongSword, HeavySword, 
                        Staff, Wand, ShiningLord, MagicGuntlet, ESPLimiter, 
                        Bow, Crossbow, AincientBow, DualBowgun, BreathShooter, 
                        Wristband, Dagger, Cane, Chain, Fan,
                        Gun, Knuckle, HandCannon, EnergySword, SoulShooter)
colnames(AddoptionTier5) <- c("Fafnir", "Absolabs", "ArcaneShade")


## SubWeapon
SubWeaponOption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "ATK", "ATKSub", 
                     "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "IGR", "BDR", "CRR", "CDMR")
{HeroMedal <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Rosario <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
DarkKnightChain <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
FPGrimoire <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
TCGrimoire <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
BishopGrimoire <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
ArrowFeather <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Thimble <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Relic <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
DaggerSheath <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Talisman <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
FafnirBlade <- c(150, 30, 0, 0, 0, 81, 0, 0, 7, F, F, 0, 0, 0, 0, 0)
AbsolabsBlade <- c(160, 40, 0, 0, 0, 97, 0, 0, 8, F, F, 0, 0, 0, 0, 0)
ArcaneShadeBlade <- c(200, 65, 0, 0, 0, 140, 0, 0, 8, F, F, 0, 0, 0, 0, 0)
ViperWristband <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Sight <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
PowderKeg <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
SoulShield <- c(100, 21, 21, 0, 800, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
CygnusKnightsJewel <- c(100, 10, 10, 10, 0, 3, 3, 0, 0, F, F, 0, 0, 0, 0, 0)
AranWeight <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
EvanDocument <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Orb <- c(100, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
MagicArrow <- c(100, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Card <- c(100, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
FoxBead <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
BlasterGunpowder <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
MagicBead <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Arrowhead <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Magnum <- c(100, 10, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Controller <- c(100, 2, 2, 2, 900, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
DemonSlayerForceShield <- c(100, 21, 21, 0, 800, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
DemonAvengerForceShield <- c(100, 21, 0, 0, 900, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
RuinForceShield <- c(100, 10, 10, 0, 560, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
DragonEssence <- c(100, 10, 10, 10, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
WeaponBelt <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Transmitter <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
SoulRing <- c(100, 10, 10, 10, 0, 0, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Bracelet <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
MagicWing <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
PathofAbyss <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Norigae <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
Seonchu <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)
FafnirZeroSubWeapon <- c(170, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 10, 30, 0, 0)
AbsolabsZeroSubWeapon <- c(180, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 10, 30, 0, 0)
ArcaneShadeZeroSubWeapon <- c(200, 0, 0, 0, 0, 0, 0, 0, 0, F, F, 0, 20, 30, 0, 0)
ChessPiece <- c(100, 10, 10, 0, 0, 3, 0, 0, 0, F, F, 0, 0, 0, 0, 0)}
SubWeapon <- rbind(HeroMedal, Rosario, DarkKnightChain, FPGrimoire, TCGrimoire, BishopGrimoire, ArrowFeather, Thimble, Relic, 
                   DaggerSheath, Talisman, FafnirBlade, AbsolabsBlade, ArcaneShadeBlade, ViperWristband, Sight, PowderKeg, 
                   SoulShield, CygnusKnightsJewel, AranWeight, EvanDocument, Orb, MagicArrow, Card, FoxBead, 
                   BlasterGunpowder, MagicBead, Arrowhead, Magnum, Controller, DemonSlayerForceShield, DemonAvengerForceShield, 
                   RuinForceShield, DragonEssence, Transmitter, SoulRing, Bracelet, MagicWing, PathofAbyss, Seonchu, 
                   FafnirZeroSubWeapon, AbsolabsZeroSubWeapon, ArcaneShadeZeroSubWeapon, ChessPiece, Norigae, WeaponBelt)
colnames(SubWeapon) <- SubWeaponOption
SubWeapon <- data.frame(SubWeapon)


## Emblem
SubWeaponOption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "ATK", "ATKSub", 
                     "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "IGR", "BDR", "CRR", "CDMR")
{MapleLeaf <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Heroes <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Cygnus <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Resistance <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Demon <- c(100, 10, 10, 10, 500, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Dragon <- c(100, 10, 10, 0, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Hitman <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Angel <- c(100, 10, 10, 0, 400, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Agent <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Knight <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Crystal <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Abyss <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Pungsusa <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Cheonjiin <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Time <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)
Kinesis <- c(100, 10, 10, 10, 0, 2, 2, 0, 0, F, F, 0, 0, 0, 0, 0)}
Emblem <- rbind(MapleLeaf, Heroes, Cygnus, Resistance, Demon, Dragon, Angel, Agent, Knight, Crystal, Abyss, Cheonjiin, Time, Kinesis, Hitman, Pungsusa)
colnames(Emblem) <- SubWeaponOption
Emblem <- data.frame(Emblem)


## Set Option
{itemoption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
                 "MainStatP", "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "Superior", "IGR", "BDR", "CRR", "CDMR")
  B1 <- rep(0, 19)
  B2 <- rep(0, 19)
  B3 <- c(0, 10, 10, 10, 0, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  B4 <- rep(0, 19)
  B5 <- c(0, 10, 10, 10, 0, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  B6 <- rep(0, 19)
  B7 <- c(0, 10, 10, 10, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  B8 <- rep(0, 19)
  B9 <- c(0, 15, 15, 15, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0)
  BossAccSet <- data.frame(rbind(B1, B2, B3, B4, B5, B6, B7, B8, B9))
  
  BB1 <- rep(0, 19)
  BB2 <- c(0, 10, 10, 10, 250, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0)
  BB3 <- c(0, 10, 10, 10, 250, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  BB4 <- c(0, 15, 15, 15, 375, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5)
  BB5 <- c(0, 15, 15, 15, 375, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0)
  BB6 <- c(0, 15, 15, 15, 375, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  BB7 <- c(0, 15, 15, 15, 375, 0, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5)
  BlackBossAccSet <- data.frame(rbind(BB1, BB2, BB3, BB4, BB5, BB6, BB7))
  
  C1 <- rep(0, 19)
  C2 <- c(0, 20, 20, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  C3 <- c(0, 0, 0, 0, 0, 10, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  C4 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0)
  ChaosRootAbyssSet <- data.frame(rbind(C1, C2, C3, C4))
  
  AB1 <- rep(0, 19)
  AB2 <- c(0, 0, 0, 0, 1500, 0, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AB3 <- c(0, 30, 30, 30, 0, 0, 25, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AB4 <- c(0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  AB5 <- c(0, 0, 0, 0, 0, 0, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0)
  AB6 <- c(0, 0, 0, 0, 0, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AB7 <- c(0, 0, 0, 0, 0, 0, 20, 20, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  AbsolabsSet <- data.frame(rbind(AB1, AB2, AB3, AB4, AB5, AB6, AB7))
  
  AR1 <- rep(0, 19)
  AR2 <- c(0, 0, 0, 0, 2000, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AR3 <- c(0, 50, 50, 50, 0, 0, 35, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AR4 <- c(0, 0, 0, 0, 0, 0, 40, 40, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  AR5 <- c(0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 0)
  AR6 <- c(0, 0, 0, 0, 0, 30, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  AR7 <- c(0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  ArcaneShadeSet <- data.frame(rbind(AR1, AR2, AR3, AR4, AR5, AR6, AR7))
  
  M1 <- rep(0, 19)
  M2 <- c(0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  M3 <- c(0, 0, 0, 0, 0, 0, 40, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  M4 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 0, 0)
  MeisterSet <- data.frame(rbind(M1, M2, M3, M4))
  
  MP1 <- rep(0, 19)
  MP2 <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0)
  MonsterParkSet <- data.frame(rbind(MP1, MP2))
  
  ML1 <- rep(0, 19)
  ML2 <- rep(0, 19)
  ML3 <- c(0, 5, 5, 5, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  ML4 <- rep(0, 19)
  ML5 <- c(0, 10, 10, 10, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
  MasterLabelSet <- data.frame(rbind(ML1, ML2, ML3, ML4, ML5))}
SetOptions <- list(BossAccSet, BlackBossAccSet, ChaosRootAbyssSet, AbsolabsSet, ArcaneShadeSet, 
                   MeisterSet, MonsterParkSet, NA, MasterLabelSet)


## Pet Set Option Function
{itemoption <- c("reqlv", "MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
                 "MainStatP", "AllstatP", "Upgrade", "AddOption", "BossItem", "Set", "Superior", "IGR", "BDR", "CRR", "CDMR")
  D1 <- c(rep(0, 6), 7, rep(0, 12))
  D2 <- c(rep(0, 6), 9, rep(0, 12))
  D3 <- c(rep(0, 6), 11, rep(0, 12))
  LunarDreamSet <- data.frame(rbind(D1, D2, D3))
  
  P1 <- c(rep(0, 6), 8, rep(0, 12))
  P2 <- c(rep(0, 6), 10, rep(0, 12))
  P3 <- c(rep(0, 6), 12, rep(0, 12))
  LunarPetitSet <- data.frame(rbind(P1, P2, P3))}
PetSetOptions <- list(LunarDreamSet, LunarPetitSet)


## Final Item Specs (Standard)
{SpecSet1 <- StandardSpecs
Up <- data.frame()
Up <- rbind(Up, Upgrade(SpecSet1[1, 1], "Acc", SpecSet1[1, 11], T, c(3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSet1[2, 1], "Acc", SpecSet1[2, 11], T, c(3, 3), 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, DominatorUpgrade(rep(1, 6)))
Up <- rbind(Up, Upgrade(SpecSet1[7, 1], "Acc", SpecSet1[7, 11], T, c(3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSet1[8, 1], "Acc", SpecSet1[8, 11], T, c(3, 3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSet1[9, 1], "Armor", SpecSet1[9, 11], T, c(rep(1, 12)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[10, 1], "Acc", SpecSet1[10, 11], T, c(rep(3, 6)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[11, 1], "Acc", SpecSet1[11, 11], T, c(rep(3, 6)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[12, 1], "Armor", SpecSet1[12, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[13, 1], "Armor", SpecSet1[13, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[14, 1], "Armor", SpecSet1[14, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[15, 1], "Acc", SpecSet1[15, 11], T, c(rep(3, 7)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[16, 1], "Armor", SpecSet1[16, 11], T, c(rep(1, 2)), 0))
Up <- rbind(Up, Upgrade(SpecSet1[17, 1], "Gloves", SpecSet1[17, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, Upgrade(SpecSet1[20, 1], "Armor", SpecSet1[20, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, HeartUpgrade(SpecSet1[21, 11], rep(1, 10)))
Up <- rbind(Up, PetEqipUpgrade(SpecSet1[22, 11], rep(1, 9)))
Up <- rbind(Up, PetEqipUpgrade(SpecSet1[23, 11], rep(1, 9)))
Up <- rbind(Up, PetEqipUpgrade(SpecSet1[24, 11], rep(1, 9)))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
for(i in 1:30) {
  SpecSet1[i, 2] <- SpecSet1[i, 2] + Up[i, 3]
  SpecSet1[i, 3] <- SpecSet1[i, 3] + Up[i, 4]
  SpecSet1[i, 4] <- SpecSet1[i, 4] + Up[i, 5]
  SpecSet1[i, 7] <- SpecSet1[i, 7] + Up[i, 1]
  SpecSet1[i, 8] <- SpecSet1[i, 8] + Up[i, 2]
}

Sf <- data.frame()
Sf <- rbind(Sf, Starforce(SpecSet1[1, 1], F, 10, F, F, SpecSet1[1, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[2, 1], F, 17, F, F, SpecSet1[2, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, Starforce(SpecSet1[6, 1], F, 17, F, F, SpecSet1[6, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[7, 1], F, 15, F, F, SpecSet1[7, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[8, 1], F, 17, F, F, SpecSet1[8, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[9, 1], F, 17, T, F, SpecSet1[9, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[10, 1], F, 10, F, F, SpecSet1[10, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[11, 1], F, 17, F, F, SpecSet1[11, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[12, 1], F, 17, T, F, SpecSet1[12, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[13, 1], F, 17, T, F, SpecSet1[13, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[14, 1], F, 17, T, F, SpecSet1[14, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[15, 1], F, 17, F, F, SpecSet1[15, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[16, 1], F, 17, T, F, SpecSet1[16, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[17, 1], F, 17, T, T, SpecSet1[17, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, Starforce(SpecSet1[20, 1], F, 17, T, F, SpecSet1[20, 4]))
Sf <- rbind(Sf, Starforce(SpecSet1[21, 1], F, 8, F, F, SpecSet1[21, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
for(i in 1:30) {
  SpecSet1[i, 2] <- SpecSet1[i, 2] + Sf[i, 3]
  SpecSet1[i, 3] <- SpecSet1[i, 3] + Sf[i, 4]
  SpecSet1[i, 4] <- SpecSet1[i, 4] + Sf[i, 5]
  SpecSet1[i, 7] <- SpecSet1[i, 7] + Sf[i, 1]
  SpecSet1[i, 8] <- SpecSet1[i, 8] + Sf[i, 2]
}

Addop <- data.frame()
for(i in 1:30) {
  Addop <- rbind(Addop, Addoption(SpecSet1[i, 1], SpecSet1[i, 12], SpecSet1[i, 13], 3, 3, 3, 0, 0, 0))
  SpecSet1[i, 2] <- SpecSet1[i, 2] + Addop[i, 1]
  SpecSet1[i, 3] <- SpecSet1[i, 3] + Addop[i, 2]
  SpecSet1[i, 4] <- SpecSet1[i, 4] + Addop[i, 3]
  SpecSet1[i, 10] <- SpecSet1[i, 10] + Addop[i, 4]
  SpecSet1[i, 7] <- SpecSet1[i, 7] + Addop[i, 5]
}

PoYes <- c(1:3, 6:17, 20:21)
for(i in PoYes) {
  if(i!=17 & i!=9) {
    Po <- Potential(c("U", "E", "E"), c("M", "M", "O"))
  } else if(i==9) {
    Po <- Potential(c("L", "U", "U"), c("M", "M", "M"))
  } else {Po <- Potential(c("L", "U", "U"), c("CDR", "M", "O"))}
  APo <- AddPotential(SpecSet1[i, 1], ChrInfo[1, 7], c("E", "R", "R"), c("MP", "ATK", "O"))
  SpecSet1[i, 9] <- SpecSet1[i, 9] + Po[1, 1] + APo[1, 1]
  SpecSet1[i, 10] <- SpecSet1[i, 10] + Po[1, 2] + APo[1, 2]
  SpecSet1[i, 6] <- SpecSet1[i, 6] + Po[1, 3] + APo[1, 5]
  SpecSet1[i, 19] <- SpecSet1[i, 19] + Po[1, 5] + APo[1, 7]
  SpecSet1[i, 2] <- SpecSet1[i, 2] + APo[1, 3]
  SpecSet1[i, 7] <- SpecSet1[i, 7] + APo[1, 4]
}
}

## Final Item Specs (Standard / Zero)
{SpecSetZero1 <- StandardSpecZero
Up <- data.frame()
Up <- rbind(Up, Upgrade(SpecSetZero1[1, 1], "Acc", SpecSetZero1[1, 11], T, c(3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[2, 1], "Acc", SpecSetZero1[2, 11], T, c(3, 3), 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, DominatorUpgrade(rep(1, 6)))
Up <- rbind(Up, Upgrade(SpecSetZero1[7, 1], "Acc", SpecSetZero1[7, 11], T, c(3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[8, 1], "Acc", SpecSetZero1[8, 11], T, c(3, 3, 3, 3), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[9, 1], "Armor", SpecSetZero1[9, 11], T, c(rep(1, 12)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[10, 1], "Acc", SpecSetZero1[10, 11], T, c(rep(3, 6)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[11, 1], "Acc", SpecSetZero1[11, 11], T, c(rep(3, 6)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[12, 1], "Armor", SpecSetZero1[12, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[13, 1], "Armor", SpecSetZero1[13, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[14, 1], "Armor", SpecSetZero1[14, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[15, 1], "Acc", SpecSetZero1[15, 11], T, c(rep(3, 7)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[16, 1], "Armor", SpecSetZero1[16, 11], T, c(rep(1, 2)), 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[17, 1], "Gloves", SpecSetZero1[17, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, Upgrade(SpecSetZero1[20, 1], "Armor", SpecSetZero1[20, 11], T, c(rep(1, 8)), 0))
Up <- rbind(Up, HeartUpgrade(SpecSetZero1[21, 11], rep(1, 10)))
Up <- rbind(Up, PetEqipUpgrade(SpecSetZero1[22, 11], rep(1, 9)))
Up <- rbind(Up, PetEqipUpgrade(SpecSetZero1[23, 11], rep(1, 9)))
Up <- rbind(Up, PetEqipUpgrade(SpecSetZero1[24, 11], rep(1, 9)))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
Up <- rbind(Up, c(0, 0, 0, 0, 0))
for(i in 1:30) {
  SpecSetZero1[i, 2] <- SpecSetZero1[i, 2] + Up[i, 3]
  SpecSetZero1[i, 3] <- SpecSetZero1[i, 3] + Up[i, 4]
  SpecSetZero1[i, 4] <- SpecSetZero1[i, 4] + Up[i, 5]
  SpecSetZero1[i, 7] <- SpecSetZero1[i, 7] + Up[i, 1]
  SpecSetZero1[i, 8] <- SpecSetZero1[i, 8] + Up[i, 2]
}

Sf <- data.frame()
Sf <- rbind(Sf, Starforce(SpecSetZero1[1, 1], F, 10, F, F, SpecSetZero1[1, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[2, 1], F, 17, F, F, SpecSetZero1[2, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, Starforce(SpecSetZero1[6, 1], F, 17, F, F, SpecSetZero1[6, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[7, 1], F, 15, F, F, SpecSetZero1[7, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[8, 1], F, 17, F, F, SpecSetZero1[8, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[9, 1], F, 17, T, F, SpecSetZero1[9, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[10, 1], F, 10, F, F, SpecSetZero1[10, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[11, 1], F, 17, F, F, SpecSetZero1[11, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[12, 1], F, 17, T, F, SpecSetZero1[12, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[13, 1], F, 17, T, F, SpecSetZero1[13, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[14, 1], F, 17, T, F, SpecSetZero1[14, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[15, 1], F, 17, F, F, SpecSetZero1[15, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[16, 1], F, 17, T, F, SpecSetZero1[16, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[17, 1], F, 17, T, T, SpecSetZero1[17, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, Starforce(SpecSetZero1[20, 1], F, 17, T, F, SpecSetZero1[20, 4]))
Sf <- rbind(Sf, Starforce(SpecSetZero1[21, 1], F, 8, F, F, SpecSetZero1[21, 4]))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
Sf <- rbind(Sf, c(0, 0, 0, 0, 0))
for(i in 1:30) {
  SpecSetZero1[i, 2] <- SpecSetZero1[i, 2] + Sf[i, 3]
  SpecSetZero1[i, 3] <- SpecSetZero1[i, 3] + Sf[i, 4]
  SpecSetZero1[i, 4] <- SpecSetZero1[i, 4] + Sf[i, 5]
  SpecSetZero1[i, 7] <- SpecSetZero1[i, 7] + Sf[i, 1]
  SpecSetZero1[i, 8] <- SpecSetZero1[i, 8] + Sf[i, 2]
}

Addop <- data.frame()
for(i in 1:30) {
  if(i==9) {
    Addop <- rbind(Addop, Addoption(SpecSetZero1[i, 1], SpecSetZero1[i, 12], SpecSetZero1[i, 13], 4, 3, 0, 0, 0, 0))
  } else {
    Addop <- rbind(Addop, Addoption(SpecSetZero1[i, 1], SpecSetZero1[i, 12], SpecSetZero1[i, 13], 3, 3, 3, 0, 0, 0))
  }
  SpecSetZero1[i, 2] <- SpecSetZero1[i, 2] + Addop[i, 1]
  SpecSetZero1[i, 3] <- SpecSetZero1[i, 3] + Addop[i, 2]
  SpecSetZero1[i, 4] <- SpecSetZero1[i, 4] + Addop[i, 3]
  SpecSetZero1[i, 10] <- SpecSetZero1[i, 10] + Addop[i, 4]
  SpecSetZero1[i, 7] <- SpecSetZero1[i, 7] + Addop[i, 5]
}

PoYes <- c(1:3, 6:17, 20:21)
for(i in PoYes) {
  if(i!=17 & i!=9) {
    Po <- Potential(c("U", "E", "E"), c("M", "M", "O"))
  } else if(i==9) {
    Po <- Potential(c("L", "U", "U"), c("M", "M", "M"))
  } else {Po <- Potential(c("L", "U", "U"), c("CDR", "M", "O"))}
  APo <- AddPotential(SpecSetZero1[i, 1], ChrInfo[1, 7], c("E", "R", "R"), c("MP", "ATK", "O"))
  SpecSetZero1[i, 9] <- SpecSetZero1[i, 9] + Po[1, 1] + APo[1, 1]
  SpecSetZero1[i, 10] <- SpecSetZero1[i, 10] + Po[1, 2] + APo[1, 2]
  SpecSetZero1[i, 6] <- SpecSetZero1[i, 6] + Po[1, 3] + APo[1, 5]
  SpecSetZero1[i, 19] <- SpecSetZero1[i, 19] + Po[1, 5] + APo[1, 7]
  SpecSetZero1[i, 2] <- SpecSetZero1[i, 2] + APo[1, 3]
  SpecSetZero1[i, 7] <- SpecSetZero1[i, 7] + APo[1, 4]
}
}