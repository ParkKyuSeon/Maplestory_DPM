## Addoption Function
### Single1 : MainStat, Single2 : SubStat1, Single3 : SubStat2
### Double1 : MainStat+Substat1, Double2 : MainStat+Substat2, Double3 : MainStat+RemainStat
Addoption <- function(ReqLv, AddOption=T, BossItem=T, Allstat=3, Single1=3, Single2=0, Single3=0, Double1=3, Double2=0, Double3=0, ATK=0) {
  if(AddOption==T) {
    if(BossItem==T) {
      Allstat <- ifelse(Allstat==0, Allstat, Allstat+2)
      Single1 <- ifelse(Single1==0, Single1, Single1+2)
      Single2 <- ifelse(Single2==0, Single2, Single2+2)
      Single3 <- ifelse(Single3==0, Single3, Single3+2)
      Double1 <- ifelse(Double1==0, Double1, Double1+2)
      Double2 <- ifelse(Double2==0, Double2, Double2+2)
      Double3 <- ifelse(Double3==0, Double3, Double3+2)
      ATK <- ifelse(ATK==0, ATK, ATK+2)
    }
    stat <- floor(ReqLv/20) + 1
    statdouble <- ceiling(stat/2)
    MainStat <- Single1 * stat + Double1 * statdouble + Double2 * statdouble + Double3 * statdouble
    SubStat1 <- Single2 * stat + Double1 * statdouble
    SubStat2 <- Single3 * stat + Double2 * statdouble
    Result <- as.data.frame(t(c(MainStat, SubStat1, SubStat2, Allstat, ATK)))
    colnames(Result) <- c("MainStat", "SubStat1", "SubStat2", "AllstatP", "ATK")
    return(Result)
  } else {
    Result <- as.data.frame(t(c(0, 0, 0, 0, 0)))
    colnames(Result) <- c("MainStat", "SubStat1", "SubStat2", "AllstatP", "ATK")
    return(Result)
  }
}
### Single : STR, Double1 : STR + Any Stat
AddoptionHP <- function(ReqLv, AddOption=T, BossItem=T, HP=4, Allstat=0, Single=0, Double1=3, ATK=4) {
  if(AddOption==T) {
    if(BossItem==T) {
      HP <- ifelse(HP==0, HP, HP+2)
      Allstat <- ifelse(Allstat==0, Allstat, Allstat+2)
      Single <- ifelse(Single==0, Single, Single+2)
      Double1 <- ifelse(Double1==0, Double1, Double1+2)
      ATK <- ifelse(ATK==0, ATK, ATK+2)
    }
    HPstat <- floor(ReqLv/10) * 30
    stat <- floor(ReqLv/20) + 1
    statdouble <- ceiling(stat/2)
    HP <- HP * HPstat
    SubStat1 <- Single * stat + Double1 * statdouble
    Result <- as.data.frame(t(c(HP, SubStat1, Allstat, ATK)))
    colnames(Result) <- c("HP", "SubStat1", "AllstatP", "ATK")
    return(Result)
  } else {
    Result <- as.data.frame(t(c(0, 0, 0, 0)))
    colnames(Result) <- c("HP", "SubStat1", "AllstatP", "ATK")
    return(Result)
  }
}

## Upgrade Function
### UpgradeOption : "1" : 30%, "2" : Miracle(ATK+2.3), "3" : AccScroll(ATK+2.5), 
### UpgradeOption : "4", PremiumAccScroll(ATK+4.2), "5", Iggdrasil(Stat+10, ReqLv>=120), "6" : Chaos(ATK+6)
Upgrade <- function(ReqLv, ItemType=c("Acc", "Armor", "Gloves"), Upgrade, GoldHammerAvailable=T, UpgradeOption, InitialATK, DA=F, XenonSubStat2=F) {
  Times <- Upgrade + ifelse(GoldHammerAvailable==T, 1, 0)
  Option1s <- ifelse(ReqLv<120, ifelse(ItemType=="Acc", 4, ifelse(ItemType=="Armor", 5, 0)), 
                     ifelse(ItemType=="Acc", 5, ifelse(ItemType=="Armor", 7, 0)))
  Option1h <- ifelse(ReqLv<120, ifelse(ItemType=="Acc", 200, ifelse(ItemType=="Armor", 320, 0)), 
                     ifelse(ItemType=="Acc", 250, ifelse(ItemType=="Armor", 470, 0)))
  Option1a <- ifelse(ItemType=="Gloves", 3, 0)
  Option2 <- ifelse(ItemType=="Acc", NA, 2.3)
  Option3 <- ifelse(ItemType=="Acc", 2.5, NA)
  Option4 <- ifelse(ItemType=="Acc", 4.2, NA)
  Option5 <- ifelse(ReqLv>=120, 10, NA)
  if(length(UpgradeOption)==Times) {
    MainStat <- 0
    SubStat2 <- 0
    HP <- 0
    ATK <- InitialATK
    for(i in 1:Times) {
      Option6 <- ifelse(ATK>0, 6, 0)
      h <- c(Option1h, 0, 0, 0, 0, 0)
      s <- c(Option1s, 0, 0, 0, Option5, 0)
      a <- c(Option1a, Option2, Option3, Option4, 0, Option6)
      HP <- HP + h[UpgradeOption[i]]
      MainStat <- ifelse(XenonSubStat2==F, MainStat + s[UpgradeOption[i]], MainStat)
      SubStat2 <- ifelse(XenonSubStat2==T, SubStat2 + s[UpgradeOption[i]], SubStat2)
      ATK <- ATK + a[UpgradeOption[i]] + ifelse(i==4&ItemType=="Armor"&UpgradeOption[i]==1, 1, 0)
    }
    if(is.na(MainStat)==F & is.na(ATK)==F & DA==F) {
      Result <- as.data.frame(t(c(floor(ATK-InitialATK), 0, MainStat, 0, SubStat2)))
      colnames(Result) <- c("ATK", "ATKSub", "MainStat", "SubStat1", "SubStat2")
      return(Result)
    } else if(is.na(MainStat)==F & is.na(ATK)==F & DA==T) {
      Result <- as.data.frame(t(c(floor(ATK-InitialATK), 0, HP, 0, 0)))
      colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
      return(Result)
    } else {warning("Upgrade Option Incorrect")}
  } else {warning("Upgrade Option Incorrect")}
}


## Heart Upgrade Function
### UpgradeOption : "1" : PartyQuest (ATK+5), "2" : Magical(ATK+9.5, AllStat+3)
HeartUpgrade <- function(Upgrade, UpgradeOption, DA=F) {
  Times <- Upgrade + 1
  ATK <- 0
  MainStat <- 0
  SubStat1 <- 0
  SubStat2 <- 0
  if(Times==length(UpgradeOption)) {
    for(i in 1:Times) {
      ATK <- ifelse(UpgradeOption[i]==1, ATK + 5, ifelse(UpgradeOption[i]==2, ATK + 9.5, NA))
      MainStat <- ifelse(UpgradeOption[i]==1, MainStat, ifelse(UpgradeOption[i]==2, MainStat + 3, NA))
      SubStat1 <- MainStat
      SubStat2 <- MainStat
    } 
  } else {warning("Invalid Input")}
  if(DA==F) {
    Result <- as.data.frame(t(c(floor(ATK), 0, MainStat, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "MainStat", "SubStat1", "SubStat2")
  } else {
    Result <- as.data.frame(t(c(floor(ATK), 0, 0, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
  }
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Invalid Input"))
}


## PetEqip Upgrade Function
### UpgradeOption : "1" : PetEqipScroll(ATK+2.3), "2" : PremiumPetEqipScroll(ATK+4.2)
PetEqipUpgrade <- function(Upgrade, UpgradeOption, DA=F) {
  Times <- Upgrade
  ATK <- 0
  if(Times==length(UpgradeOption)) {
    for(i in 1:Times) {
      ATK <- ifelse(UpgradeOption[i]==1, ATK + 2.3, ifelse(UpgradeOption[i]==2, ATK + 4.2, NA))
    } 
  } else {warning("Invalid Input")}
  if(DA==F) {
    Result <- as.data.frame(t(c(floor(ATK), 0, 0, 0, 0)))
    colnames(Result) <- c("ATK", "ATKSub", "MainStat", "SubStat1", "SubStat2")
  } else {
    Result <- as.data.frame(t(c(floor(ATK), 0, 0, 0, 0)))
    colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
  }
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Invalid Input"))
}


## Dominator Upgrade Function
### UpgradeOption : "1" : Fragments(ATK, ATK(Sub), AllStat + 3, MaxHP + 40), "2" : Chaos(ATK + 6)
DominatorUpgrade <- function(UpgradeOption, DA=F) {
  Times <- 6
  ATK <- 0
  ATKSub <- 0
  HP <- 0
  MainStat <- 0
  SubStat1 <- 0
  SubStat2 <- 0
  if(Times==length(UpgradeOption)) {
    for(i in 1:Times) {
      ATK <- ifelse(UpgradeOption[i]==1, ATK + 3, ifelse(UpgradeOption[i]==2, ATK + 6, NA))
      ATKSub <- ifelse(UpgradeOption[i]==1, ATKSub + 3, ifelse(UpgradeOption[i]==2, ATKSub, NA))
      HP <- ifelse(UpgradeOption[i]==1, HP + 40, ifelse(UpgradeOption[i]==2, HP, NA))
      MainStat <- ifelse(UpgradeOption[i]==1, MainStat + 3, ifelse(UpgradeOption[i]==2, MainStat, NA))
      SubStat1 <- MainStat
      SubStat2 <- MainStat
    } 
  } else {warning("Invalid Input")}
  if(DA==F) {
    Result <- as.data.frame(t(c(ATK, ATKSub, MainStat, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "MainStat", "SubStat1", "SubStat2")
  } else {
    Result <- as.data.frame(t(c(ATK, ATKSub, HP, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
  }
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Invalid Input"))
}


## Chaos Horntail Pendant Upgrade Function
### UpgradeOption : "1" : DragonRock (AllStat + 15, MaxHP + 750), "2" : AccScroll(ATK + 2.5), "3" : PremiumAccScroll(ATK + 4.2)
ChaosHorntailUpgrade <- function(UpgradeOption) {
  Times <- 3
  ATK <- 0
  ATKSub <- 0
  HP <- 0
  SubStat1 <- 0
  SubStat2 <- 0
  if(Times==length(UpgradeOption)) {
    for(i in 1:Times) {
      ATK <- ifelse(UpgradeOption[i]==1, ATK, ifelse(UpgradeOption[i]==2, ATK + 2.5, ifelse(UpgradeOption[i]==3, ATK + 4.2, NA)))
      ATKSub <- ATKSub
      HP <- ifelse(UpgradeOption[i]==1, HP + 750, ifelse(UpgradeOption[i]==2, HP, ifelse(UpgradeOption[i]==3, HP, NA)))
      SubStat1 <- ifelse(UpgradeOption[i]==1, SubStat1 + 15, ifelse(UpgradeOption[i]==2, SubStat1, ifelse(UpgradeOption[i]==3, SubStat1, NA)))
      SubStat2 <- SubStat1
    } 
  } else {warning("Invalid Input")}
  Result <- as.data.frame(t(c(floor(ATK), ATKSub, HP, SubStat1, SubStat2)))
  colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Invalid Input"))
}


## StarForce Function
sfstat <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/starforcestat.csv"
sfstat <- read.csv(sfstat, header=T, row.names=1)
sfatk <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/starforceatk.csv"
sfatk <- read.csv(sfatk, header=T, row.names=1)
sfsup <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/superior.csv"
sfsup <- read.csv(sfsup, header=T, row.names=1)
colnames(sfstat) <- c("100", "110", "120", "130", "140", "150", "160", "200")
colnames(sfatk) <- c("100", "110", "120", "130", "140", "150", "160", "200")
colnames(sfsup) <- c("100", "110", "120", "130", "140", "150")
HPInc <- c(5, 5, 5, 10, 10, 15, 15, 20, 20, 25, 25, 25, 25, 25, 25, rep(0, 10))
Starforce <- function(ReqLv, Superior=F, Stars, ClassOnly=c(T, F), Gloves=c(T, F), InitialSubStat2) {
  if(Superior==F) {
    t <- 1
    for(i in 1:8) {
      ifelse(as.numeric(colnames(sfstat))[i]<=(ReqLv-10), t <- t + 1, t <- t)
    }
    MainStat <- sum(sfstat[1:Stars, t])
    SubStat1 <- sum(sfstat[1:Stars, t])
    SubStat2 <- ifelse(ClassOnly==F, sum(sfstat[1:Stars, t]), 
                       ifelse(InitialSubStat2>0, ifelse(Stars>15, sum(sfstat[16:Stars, t]), 0), 0))
    ATK <- sum(sfatk[1:Stars, t]) + 
      ifelse(Gloves==T&Stars>=5, floor((min(15, Stars)+1)/2-2), 0) + ifelse(Gloves==T&Stars>=14, 1, 0)
    ATKSub <- sum(sfatk[1:Stars, t]) 
    Result <- as.data.frame(t(c(ATK, ATKSub, MainStat, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATK(Sub)", "MainStat", "SubStat1", "SubStat2")
    ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Starforce Maximum Exceed"))
  } else {
    t <- 1
    for(i in 1:6) {
      ifelse(as.numeric(colnames(sfsup))[i]<=(ReqLv-10), t <- t + 1, t <- t)
    }
    MainStat <- ifelse(Stars<=5, sum(sfsup[1:Stars, t]), sum(sfsup[1:5, t]))
    SubStat1 <- ifelse(Stars<=5, sum(sfsup[1:Stars, t]), sum(sfsup[1:5, t]))
    SubStat2 <- ifelse(Stars<=5, sum(sfsup[1:Stars, t]), sum(sfsup[1:5, t]))
    ATK <- ifelse(Stars>5, sum(sfsup[6:Stars, t]), 0)
    ATKSub <- ifelse(Stars>5, sum(sfsup[6:Stars, t]), 0)
    Result <- as.data.frame(t(c(ATK, ATKSub, MainStat, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "MainStat", "SubStat1", "SubStat2")
    ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Starforce Maximum Exceed"))
  }
}
StarforceDA <- function(ReqLv, Superior=F, Stars, ClassOnly=c(T, F), ItemType) {
  if(sum(ItemType==c("Hat", "Clothes", "Pants", "Cape", "Ring1", "Ring2", "Ring3", "Ring4", "Pendant1", "Pendant2", "Belt", "Shoulder"))>=1) {
    Idx <- 1
  } else {
    Idx <- 0
  }
  if(Superior==F) {
    t <- 1
    for(i in 1:8) {
      ifelse(as.numeric(colnames(sfstat))[i]<=(ReqLv-10), t <- t + 1, t <- t)
    }
    HP <- ifelse(Idx==1, sum(HPInc[1:Stars]), 0)
    SubStat1 <- sum(sfstat[1:Stars, t])
    SubStat2 <- 0
    ATK <- sum(sfatk[1:Stars, t]) + 
      ifelse(ItemType=="Gloves"&Stars>=5, floor((min(15, Stars)+1)/2-2), 0) + ifelse(ItemType=="Gloves"&Stars>=14, 1, 0)
    ATKSub <- sum(sfatk[1:Stars, t]) 
    Result <- as.data.frame(t(c(ATK, ATKSub, HP, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATK(Sub)", "HP", "SubStat1", "SubStat2")
    ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Starforce Maximum Exceed"))
  } else {
    t <- 1
    for(i in 1:6) {
      ifelse(as.numeric(colnames(sfsup))[i]<=(ReqLv-10), t <- t + 1, t <- t)
    }
    HP <- 0
    SubStat1 <- ifelse(Stars<=5, sum(sfsup[1:Stars, t]), sum(sfsup[1:5, t]))
    SubStat2 <- 0
    ATK <- ifelse(Stars>5, sum(sfsup[6:Stars, t]), 0)
    ATKSub <- ifelse(Stars>5, sum(sfsup[6:Stars, t]), 0)
    Result <- as.data.frame(t(c(ATK, ATKSub, HP, SubStat1, SubStat2)))
    colnames(Result) <- c("ATK", "ATKSub", "HP", "SubStat1", "SubStat2")
    ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("Starforce Maximum Exceed"))
  }
}


## AmazingReinforce Function
amaze <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/amazingstar.csv"
amaze <- read.csv(amaze, header=T, row.names=1)
colnames(sfsup) <- c("100", "110", "120", "130", "140", "150")
Amazing <- function(ReqLv, Stars, ItemType=c("Acc", "Armor"), ClassOnly=c(T, F), BonusRate, InitialSubStat2) {
  
}


## Potential Function
Potential <- function(grade=c("R", "E", "U", "L"), option=c("M", "A", "HP", "C", "CDR", "O")) {
  p <- matrix(c(3, 6, 9, 12, NA, 3, 6, 9, NA, NA, NA, 2, NA, NA, NA, 8, 0, 0, 0, 0), 5, 4, byrow=T)
  M <- 0
  A <- 0
  HP <- 0
  C <- 0
  CDR <- 0
  for(i in 1:3) {
    M <- M + ifelse(option[i]==as.character("M"), ifelse(grade[i]==as.character("R"), p[1, 1], 
                                                         ifelse(grade[i]==as.character("E"), p[1, 2], ifelse(grade[i]==as.character("U"), p[1, 3], 
                                                                                                             ifelse(grade[i]==as.character("L"), p[1, 4], NA)))), 0)
    A <- A + ifelse(option[i]==as.character("A"), ifelse(grade[i]==as.character("R"), p[2, 1], 
                                                         ifelse(grade[i]==as.character("E"), p[2, 2], ifelse(grade[i]==as.character("U"), p[2, 3], 
                                                                                                             ifelse(grade[i]==as.character("L"), p[2, 4], NA)))), 0)
    HP <- HP + ifelse(option[i]==as.character("HP"), ifelse(grade[i]==as.character("R"), p[1, 1], 
                                                            ifelse(grade[i]==as.character("E"), p[1, 2], ifelse(grade[i]==as.character("U"), p[1, 3], 
                                                                                                                ifelse(grade[i]==as.character("L"), p[1, 4], NA)))), 0)
    C <- C + ifelse(option[i]==as.character("C"), ifelse(grade[i]==as.character("R"), p[3, 1], 
                                                         ifelse(grade[i]==as.character("E"), p[3, 2], ifelse(grade[i]==as.character("U"), p[3, 3], 
                                                                                                             ifelse(grade[i]==as.character("L"), p[3, 4], NA)))), 0)
    CDR <- CDR + ifelse(option[i]==as.character("CDR"), ifelse(grade[i]==as.character("R"), p[4, 1], 
                                                               ifelse(grade[i]==as.character("E"), p[4, 2], ifelse(grade[i]==as.character("U"), p[4, 3], 
                                                                                                                   ifelse(grade[i]==as.character("L"), p[4, 4], NA)))), 0)
  }
  Result <- as.data.frame(t(c(M, A, HP, C, CDR)))
  colnames(Result) <- c("MainStatP", "AllStatP", "MaxHPP", "CoolReduce", "CDR")
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("invalid input"))
}


## AdditionalPotential Function
### Optioncode : MP : Mainstat%, AP : Allstat%, M : MainStat, ATK : Attack(Main), HPP : MaxHP%
### Optioncode : C : CoolReduce, CDR(G) : CriticalDamage(Gloves), "MpL" : MainStat per Level, "O" : Others
### Gradecode RL : Rare 2nd, 3rd option
AddPotential <- function(ReqLv, ChrLv, grade=c("RL", "R", "E", "U", "L"), 
                         option=c("MP", "AP", "M", "ATK", "HPP", "C", "CDR(G)", "MpL", "O")) {
  p <- matrix(c(NA, 2, 4, 5, 7, NA, NA, 2, 4, 5, 6, 10, 14, 16, 18, 3, 10, 11, 12, 14,
                0, 2, 5, 7, 10, NA, NA, NA, NA, 1, NA, NA, NA, NA, 3, NA, NA, NA, 1, 2), 8, 5, byrow=T)
  MP <- 0
  AP <- 0
  M <- 0
  ATK <- 0
  HPP <- 0
  C <- 0
  CDR <- 0
  MpL <- 0
  for(i in 1:3) {
    MP <- MP + ifelse(option[i]==as.character("MP"), ifelse(grade[i]==as.character("R"), p[1, 2], 
                                                            ifelse(grade[i]==as.character("E"), p[1, 3], ifelse(grade[i]==as.character("U"), p[1, 4], 
                                                                                                                ifelse(grade[i]==as.character("L"), p[1, 5], ifelse(grade[i]==as.character("RL"), p[1, 1], NA))))), 0)
    AP <- AP + ifelse(option[i]==as.character("AP"), ifelse(grade[i]==as.character("R"), p[2, 2], 
                                                            ifelse(grade[i]==as.character("E"), p[2, 3], ifelse(grade[i]==as.character("U"), p[2, 4], 
                                                                                                                ifelse(grade[i]==as.character("L"), p[2, 5], ifelse(grade[i]==as.character("RL"), p[2, 1], NA))))), 0)
    M <- M + ifelse(option[i]==as.character("M"), ifelse(grade[i]==as.character("R"), p[3, 2], 
                                                         ifelse(grade[i]==as.character("E"), p[3, 3], ifelse(grade[i]==as.character("U"), p[3, 4], 
                                                                                                             ifelse(grade[i]==as.character("L"), p[3, 5], ifelse(grade[i]==as.character("RL"), p[3, 1], NA))))), 0)    
    ATK <- ATK + ifelse(ReqLv>101, ifelse(option[i]==as.character("ATK"), ifelse(grade[i]==as.character("R"), p[4, 2], 
                                                                                 ifelse(grade[i]==as.character("E"), p[4, 3], ifelse(grade[i]==as.character("U"), p[4, 4], 
                                                                                                                                     ifelse(grade[i]==as.character("L"), p[4, 5], ifelse(grade[i]==as.character("RL"), p[4, 1], NA))))), 0), 
                        ifelse(option[i]==as.character("ATK"), ifelse(grade[i]==as.character("R"), p[4, 2], 
                                                                      ifelse(grade[i]==as.character("E"), p[4, 3], ifelse(grade[i]==as.character("U"), p[4, 4], 
                                                                                                                          ifelse(grade[i]==as.character("L"), p[4, 5], ifelse(grade[i]==as.character("RL"), p[4, 1]-1, NA))))), 0))
    HPP <- HPP + ifelse(option[i]==as.character("HPP"), ifelse(grade[i]==as.character("R"), p[5, 2], 
                                                               ifelse(grade[i]==as.character("E"), p[5, 3], ifelse(grade[i]==as.character("U"), p[5, 4], 
                                                                                                                   ifelse(grade[i]==as.character("L"), p[5, 5], ifelse(grade[i]==as.character("RL"), p[5, 1], NA))))), 0)
    C <- C + ifelse(option[i]==as.character("C"), ifelse(grade[i]==as.character("R"), p[6, 2], 
                                                         ifelse(grade[i]==as.character("E"), p[6, 3], ifelse(grade[i]==as.character("U"), p[6, 4], 
                                                                                                             ifelse(grade[i]==as.character("L"), p[6, 5], ifelse(grade[i]==as.character("RL"), p[6, 1], NA))))), 0) 
    CDR <- CDR + ifelse(option[i]==as.character("CDR"), ifelse(grade[i]==as.character("R"), p[7, 2], 
                                                               ifelse(grade[i]==as.character("E"), p[7, 3], ifelse(grade[i]==as.character("U"), p[7, 4], 
                                                                                                                   ifelse(grade[i]==as.character("L"), p[7, 5], ifelse(grade[i]==as.character("RL"), p[7, 1], NA))))), 0) 
    MpL <- MpL + floor(ifelse(option[i]==as.character("MpL"), ifelse(grade[i]==as.character("R"), p[8, 2], 
                                                                     ifelse(grade[i]==as.character("E"), p[8, 3], ifelse(grade[i]==as.character("U"), p[8, 4], 
                                                                                                                         ifelse(grade[i]==as.character("L"), p[8, 5], ifelse(grade[i]==as.character("RL"), p[8, 1], NA))))), 0) *
                         floor(ChrLv/10))
  }
  Result <- as.data.frame(t(c(MP, AP, M + MpL, ATK, HPP, C, CDR)))
  colnames(Result) <- c("MainStatP", "AllStatP", "MainStat", "ATK", "MaxHPP", "CoolReduce", "CDR")
  ifelse(sum(as.numeric(is.na(Result)))==0, return(Result), warning("invalid input"))  
}


## SetOption Function
SetOption <- function(ItemList, WeaponType=c("F", "AB", "AR")) {
  Set <- data.frame(t(rep(0, 19)))
  colnames(Set) <- itemoption
  rownames(Set) <- c("Set")
  sets <- ItemList[, 14]
  a <- c(1:7, 9)
  s <- rep(0, 9)
  for(i in a) {
    s[i] <- sum(as.numeric(sets==i))
  }
  if(WeaponType=="F") {
    s[3] <- s[3] + 1
  } else {
    if(WeaponType=="AB") {
      s[4] <- s[4] + 1
    } else {
      if(WeaponType=="AR") {
        s[5] <- s[5] + 1
      } else {warning("Invalid Input")}
    }
  }
  if(sum(as.numeric(sets[1:4]==8))>0) {
    if(sum(as.numeric(sets[1:4]==1))<2 & s[1]>=3) {
      s[1] <- s[1] + 1
    } else {
      if(sum(as.numeric(sets[1:4]==2))<1 & s[2]>=3) {
        s[2] <- s[2] + 1
      }
    }
  }
  if(sum(as.numeric(sets[9]==8))>0) {
    for(i in 3:5) {
      if(s[i]>=3) {
        s[i] <- s[i] + 1
      }
    }
  }
  b <- c(1:15, 17:19)
  for(i in a) {
    for(j in b) {
      k <- max(s[i], 1)
      Set[j] <- Set[j] + sum(SetOptions[[i]][1:k, j])
    }
  }
  for(i in a) {
    k <- max(s[i], 1)
    for(j in 1:k) {
      Set[16] <- 1 - (1 - Set[16]) * (100 - SetOptions[[i]][j, 16])/100
    }
  }
  Set[16] <- Set[16] * 100
  return(Set)
}


## PetSetOption Function
PetSetOption <- function(Pets=c("D", "P")) {
  Pet <- c(0, 0)
  for(i in 1:length(Pets)) {
    Pet[1] <- Pet[1] + ifelse(Pets[i]=="D", 1, 0)
    Pet[2] <- Pet[2] + ifelse(Pets[i]=="P", 1, 0)
  }
  
  Sets <- matrix(rep(0, 38), nrow=2)
  for(i in 1:2) {
    if(Pet[i] > 0) {
      Sets[i, ] <- colSums(LunarDreamSet[1:Pet[i], ])
    }
  }
  Sets <- data.frame(Sets)
  colnames(Sets) <- itemoption
  Sets <- data.frame(t(colSums(Sets)))
  rownames(Sets) <- c("PetSets")
  return(Sets)
}


## Item Option Summation Function
ItemSum <- function(ItemSet, SetOption, PetSetOption) {
  Item <- rbind(ItemSet, SetOption, PetSetOption)
  ItemSum <-c()
  for(i in c(2:10, 17:19)) {
    ItemSum[i] <- sum(Item[, i])
  }
  ItemSum[16] <- IGRCalc(Item[, 16])
  ItemSum <- data.frame(t(ItemSum))
  ItemSum[8] <- sum(data.frame(ItemSet)$ATKSub)
  colnames(ItemSum) <- colnames(Item)
  rownames(ItemSum) <- c("Item")
  return(ItemSum)
}


## Weapon Upgrade and Starforce Function
### UpgradeType code : "1" : 15%(ATK+9, MainStat+4), "2": Magical(ATK+10, AllStat+3)
### Item Name code : "F" : Fafnir, "AB" : Absolabs, "AR" : Arcane Shade
ItemTypes <- c("Sword", "Hammer", "TwohandSword", "TwohandAxe", "TwohandHammer", "Polarm", "Spear", "GuntletRevolver", "Desperado", 
               "Tuner", "LongSword", "HeavySword", 
               "Staff", "Wand", "ShiningLord", "MagicGuntlet", "ESPLimiter", 
               "Bow", "Crossbow", "AincientBow", "DualBowgun", "BreathShooter", 
               "Wristband", "Dagger", "Cane", "Chain", "Fan",
               "Gun", "Knuckle", "HandCannon", "EnergySword", "SoulShooter")
wsfstat <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/starforcestat.csv"
wsfstat <- read.csv(wsfstat, header=T, row.names=1)
wsfstat <- wsfstat[, 6:8]
wsfatk <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/weaponsfatk.csv"
wsfatk <- read.csv(wsfatk, header=T, row.names=1)
colnames(wsfstat) <- c(150, 160, 200)
colnames(wsfatk) <- c(150, 160, 200)
WeaponUpgrade <- function(UpgradeType=c(1, 2), Stars, AddoptionTier=c(4, 5), 
                          AddSingle=0, AddDouble1=0, AddDouble2=0, AddDouble3=0, AddBDR=0, AddDMR=0, AddAllstat=0,
                          WeaponType=ItemTypes, ItemName=c("F", "AB", "AR"), XenonSubStat2=F) {
  if(ItemName=="F") {
    w <- Fafnir
    a4 <- AddoptionTier4[, 1]
    a5 <- AddoptionTier5[, 1]
    t <- 1
  } else {if(ItemName=="AB") {
    w <- Absolabs
    a4 <- AddoptionTier4[, 2]
    a5 <- AddoptionTier5[, 2]
    t <- 2
  } else {if(ItemName=="AR") {
    w <- ArcaneShade
    a4 <- AddoptionTier4[, 3]
    a5 <- AddoptionTier5[, 3] 
    t <- 3
  } else {warning("invalid input")}}}
  p <- 0
  i <- 1
  while(p==0) {
    if(rownames(w)[i]==WeaponType) {
      w <- t(as.data.frame(w[i, ]))
      rownames(w) <- WeaponType
      a <- ifelse(AddoptionTier==4, a4[i], ifelse(AddoptionTier==5, a5[i], warning("invalid input")))
      p <- 1
    } 
    i <- i + 1
  }
  Upgrade <- w[1, 9] + 1
  if(UpgradeType==1) {
    w[1, 2] <- w[1, 2] + ifelse(XenonSubStat2==F, 4 * Upgrade, 4 * (Upgrade-1))
    w[1, 4] <- w[1, 4] + ifelse(XenonSubStat2==F, 0, 4)
    w[1, 6] <- w[1, 6] + 9 * Upgrade
  } else {if(UpgradeType==2) {
    w[1, 2:4] <- w[1, 2:4] + 3 * Upgrade
    w[1, 6] <- w[1, 6] + 10 * Upgrade
  } else {warning("invalid input")}}
  for(i in 1:Stars) {
    w[1, 2] <- w[1, 2] + wsfstat[i, t]
    w[1, 3] <- w[1, 3] + wsfstat[i, t]
    w[1, 4] <- ifelse(w[1, 4]>0&i>15, w[1, 4] + wsfstat[i, t], w[1, 4])
    w[1, 6] <- ifelse(i<=15, w[1, 6] + floor(w[1, 6]/50) + 1, w[1, 6] + wsfatk[i, t])
  }
  w[1, 6] <- w[1, 6] + a
  if(w[1, 11]==1) {
    AddAllstat <- ifelse(AddAllstat==0, AddAllstat, AddAllstat+2)
    AddSingle <- ifelse(AddSingle==0, AddSingle, AddSingle+2)
    AddDouble1 <- ifelse(AddDouble1==0, AddDouble1, AddDouble1+2)
    AddDouble2 <- ifelse(AddDouble2==0, AddDouble2, AddDouble2+2)
    AddDouble3 <- ifelse(AddDouble3==0, AddDouble3, AddDouble3+2)
    AddBDR <- ifelse(AddBDR==0, AddBDR, AddBDR+2)
    AddDMR <- ifelse(AddDMR==0, AddDMR, AddDMR+2)
  }
  s <- ifelse(t==1, 8, ifelse(t==2, 9, 11))
  sd <- ceiling(s/2)
  w[1, 2] <- w[1, 2] + AddSingle * s + AddDouble1 * sd + AddDouble2 * sd + AddDouble3 * sd
  w[1, 3] <- w[1, 3] + AddDouble1 * sd
  w[1, 4] <- w[1, 4] + AddDouble2 * sd
  w[1, 8] <- w[1, 8] + AddAllstat
  w[1, 14] <- w[1, 14] + AddBDR * 2 + AddDMR
  return(w)
}
BladeUpgrade <- function(UpgradeType=c(1, 2), Stars, ItemName=c("F", "AB", "AR")) {
  if(ItemName=="F") {
    w <- FafnirBlade
    t <- 1
  } else {if(ItemName=="AB") {
    w <- AbsolabsBlade
    t <- 2
  } else {if(ItemName=="AR") {
    w <- ArcaneShadeBlade
    t <- 3
  } else {warning("invalid input")}}}
  w <- data.frame(t(w))
  colnames(w) <- SubWeaponOption
  rownames(w) <- "Blade"
  
  Upgrade <- w[1, 9] + 1
  if(UpgradeType==1) {
    w[1, 2] <- w[1, 2] + 4 * Upgrade
    w[1, 6] <- w[1, 6] + 9 * Upgrade
  } else {if(UpgradeType==2) {
    w[1, 2:4] <- w[1, 2:4] + 3 * Upgrade
    w[1, 6] <- w[1, 6] + 10 * Upgrade
  } else {warning("invalid input")}}
  for(i in 1:Stars) {
    w[1, 2] <- w[1, 2] + wsfstat[i, t]
    w[1, 3] <- w[1, 3] + wsfstat[i, t]
    w[1, 4] <- ifelse(w[1, 4]>0&i>15, w[1, 4] + wsfstat[i, t], w[1, 4])
    w[1, 6] <- ifelse(i<=15, w[1, 6] + floor(w[1, 6]/50) + 1, w[1, 6] + wsfatk[i, t])
  }
  return(w)
}
DesperadoUpgrade <- function(UpgradeType=c(1, 2), Stars, AddoptionTier=c(4, 5), 
                             AddHP=0, AddSingle=0, AddDouble1=0, AddBDR=0, AddDMR=0, AddAllstat=0, ItemName=c("F", "AB", "AR")) {
  if(ItemName=="F") {
    w <- Fafnir
    a4 <- AddoptionTier4[, 1]
    a5 <- AddoptionTier5[, 1]
    t <- 1
  } else {if(ItemName=="AB") {
    w <- Absolabs
    a4 <- AddoptionTier4[, 2]
    a5 <- AddoptionTier5[, 2]
    t <- 2
  } else {if(ItemName=="AR") {
    w <- ArcaneShade
    a4 <- AddoptionTier4[, 3]
    a5 <- AddoptionTier5[, 3] 
    t <- 3
  } else {warning("invalid input")}}}
  p <- 0
  i <- 1
  while(p==0) {
    if(rownames(w)[i]=="Desperado") {
      w <- t(as.data.frame(w[i, ]))
      rownames(w) <- "Desperado"
      a <- ifelse(AddoptionTier==4, a4[i], ifelse(AddoptionTier==5, a5[i], warning("invalid input")))
      p <- 1
    } 
    i <- i + 1
  }
  Upgrade <- w[1, 9] + 1
  if(UpgradeType==1) {
    w[1, 5] <- w[1, 5] + 200 * Upgrade
    w[1, 6] <- w[1, 6] + 9 * Upgrade
  } else {if(UpgradeType==2) {
    w[1, 2:4] <- w[1, 2:4] + 3 * Upgrade
    w[1, 6] <- w[1, 6] + 10 * Upgrade
  } else {warning("invalid input")}}
  for(i in 1:Stars) {
    w[1, 3] <- w[1, 3] + wsfstat[i, t]
    w[1, 4] <- ifelse(w[1, 4]>0&i>15, w[1, 4] + wsfstat[i, t], w[1, 4])
    w[1, 5] <- w[1, 5] + HPInc[i]
    w[1, 6] <- ifelse(i<=15, w[1, 6] + floor(w[1, 6]/50) + 1, w[1, 6] + wsfatk[i, t])
  }
  w[1, 6] <- w[1, 6] + a
  if(w[1, 11]==1) {
    AddAllstat <- ifelse(AddAllstat==0, AddAllstat, AddAllstat+2)
    AddSingle <- ifelse(AddSingle==0, AddSingle, AddSingle+2)
    AddDouble1 <- ifelse(AddDouble1==0, AddDouble1, AddDouble1+2)
    AddHP <- ifelse(AddHP==0, AddHP, AddHP+2)
    AddBDR <- ifelse(AddBDR==0, AddBDR, AddBDR+2)
    AddDMR <- ifelse(AddDMR==0, AddDMR, AddDMR+2)
  }
  s <- ifelse(t==1, 8, ifelse(t==2, 9, 11))
  sd <- ceiling(s/2)
  h <- ifelse(t==1, 450, ifelse(t==2, 480, 600))
  w[1, 3] <- w[1, 3] + AddSingle * s + AddDouble1 * sd
  w[1, 5] <- w[1, 5] + AddHP * h
  w[1, 8] <- w[1, 8] + AddAllstat
  w[1, 14] <- w[1, 14] + AddBDR * 2 + AddDMR
  return(w)
}


## Weapon AddPotential Function
WeaponAddpotential <- function(Weapons, grade=c("E", "U", "L"), options=c("A", "O")) {
  ATKP <- 0
  ATKP <- ATKP + ifelse(grade[1]==as.character("E")&options[1]==as.character("A"), 6, ifelse(grade[1]==as.character("U")&options[1]==as.character("A"), 9, 
                                                                                             ifelse(grade[1]==as.character("L")&options[1]==as.character("A"), 12, 0)))
  ATKP <- ATKP + ifelse(grade[2]==as.character("E")&options[2]==as.character("A"), 3, ifelse(grade[2]==as.character("U")&options[2]==as.character("A"), 6, 
                                                                                             ifelse(grade[2]==as.character("L")&options[2]==as.character("A"), 9, 0)))
  ATKP <- ATKP + ifelse(grade[3]==as.character("E")&options[3]==as.character("A"), 3, ifelse(grade[3]==as.character("U")&options[3]==as.character("A"), 6, 
                                                                                             ifelse(grade[3]==as.character("L")&options[3]==as.character("A"), 9, 0)))
  
  Weapons$ATKP <- ATKP
  return(Weapons)
}


## Union and CRR Get Function
UnionChr <- function(UnionPreSet, Job, ChrLv) {
  JobIndex <- c()
  for(i in 1:nrow(ChrInfo)) {
    if(ChrInfo$job[i]==Job) {
      JobIndex <- i 
      break
    }
  }
  
  MS <- ifelse(Job=="Xenon", "Xenon", ChrInfo$MainStat[i])
  StatIndex <- c()
  for(i in 1:length(UnionPrior)) {
    if(names(UnionPrior)[i]==MS) {
      StatIndex <- i 
      break
    }
  }
  
  Jobs <- unique(c(Job, UnionPrior[[StatIndex]]))
  Grade <- c(ifelse(ChrLv>=250, "SSS", ifelse(ChrLv>=200, "SS", "S")), rep("SSS", UnionPreSet$SSSChrs), 
             rep("SS", UnionPreSet$SSChrs), rep("S", UnionPreSet$SChrs))
  if(length(Jobs) < 1 + UnionPreSet$Chrs) {
    Grade <- Grade[1:length(Jobs)]
  } else {
    Jobs <- Jobs[1:length(Grade)]
  }
  
  OpIndex <- c()
  for(j in 1:length(Jobs)) {
    for(i in 1:nrow(UnionCharacters)) {
      if(rownames(UnionCharacters)[i]==Jobs[j]) {
        OpIndex[j] <- i
      }
    }
  }
  Option <- c()
  for(i in 1:length(OpIndex)) {
    Option[i] <- UnionCharacters$Options[OpIndex[i]]
  }
  Prior <- data.frame(Job=Jobs, Grade=Grade, Option=Option)
  if(UnionPreSet$MapleM==T) {
    MapleM <- data.frame(Job="MapleM", Grade=UnionPreSet$MapleMGrade, Option="ATK")
    Prior <- rbind(Prior, MapleM)
    for(i in 1:nrow(UnionCharacters)) {
      if(rownames(UnionCharacters)[i]=="MapleM") {
        OpIndex <- c(OpIndex, i)
        break
      }
    }
  }
  
  Value <- c()
  for(i in 1:length(OpIndex)) {
    Value[i] <- ifelse(Prior$Grade[i]=="SSS", UnionCharacters$SSS[OpIndex[i]], 
                       ifelse(Prior$Grade[i]=="SS", UnionCharacters$SS[OpIndex[i]], UnionCharacters$S[OpIndex[i]]))
  }
  Prior$Value <- Value
  
  UnionOptions <- c("STR", "DEX", "INT", "LUK", "HPP", "HP", "STRDEXLUK", "ATK", "IGR", "BDR", "CRR", "CDMR", "SummonedDuration", 
                    "BuffDuration", "CoolReduceP", "Others")
  UnionChrOp <- data.frame(t(rep(0, length(UnionOptions))))
  for(i in 1:length(UnionOptions)) {
    v <- subset(Prior, Prior$Option==UnionOptions[i])
    UnionChrOp[1, i] <- sum(v$Value)
  }
  colnames(UnionChrOp) <- UnionOptions
  UnionChrOp$STR <- UnionChrOp$STR + UnionChrOp$STRDEXLUK
  UnionChrOp$DEX <- UnionChrOp$DEX + UnionChrOp$STRDEXLUK
  UnionChrOp$LUK <- UnionChrOp$LUK + UnionChrOp$STRDEXLUK
  UnionChrOp <- UnionChrOp[, c(-7, -16)]
  return(UnionChrOp)
}
UnionPlace <- function(UnionRemained, UnionBase, UnionBuffDuration, UnionCRR, UnionStance=0) {
  UnionBase$BuffDuration <- UnionBuffDuration
  UnionBase$CRR <- UnionCRR
  UnionBase$Stance <- UnionStance
  UnionRemained <- UnionRemained - UnionStance
  
  if(UnionRemained > 80) {
    UnionBase$MainStat <- UnionBase$MainStat + min(10, UnionRemained - 80)
    UnionRemained <- UnionRemained - (UnionBase$MainStat - 5)
  }
  
  if(UnionRemained > 80) {
    UnionBase$ATK <- UnionBase$ATK + min(10, UnionRemained - 80)
  }
  
  return(UnionBase)
}
CRRGet <- function(UnionRemained, BuffDurationNeededP, BuffDuration, CRR, CRROver, NotCRR100=F, UnionStance=0) {
  UnionBuffDNeeded <- ifelse(BuffDurationNeededP > BuffDuration, min(max(BuffDurationNeededP - BuffDuration, 0), 40), 0)
  UnionR <- max(UnionRemained - UnionBuffDNeeded - UnionStance - 80, 0)
  CRRNeeded <- 100 - CRR
  UnionCRR <- 0
  HyperCRR <- 0
  SoulWeaponCRR <- 0
  if(CRROver==F) {
    UnionCRR <- min(CRRNeeded, UnionR)
    CRRNeeded <- ifelse(NotCRR100==T, 0, 100 - CRR - UnionCRR)
    if(CRRNeeded >= 15) {
      SoulWeaponCRR <- 12
      CRRNeeded <- max(CRRNeeded - SoulWeaponCRR, 0)
    }
    if(CRRNeeded>0) {
      p <- 1
      HyperPts <- 0
      while(CRRNeeded>0 & p <= 7) {
        CRRNeeded <- max(CRRNeeded - HyperStats$CRR[p], 0)
        HyperPts <- HyperPts + HyperStats$pts[p]
        HyperCRR <- HyperCRR + HyperStats$CRR[p]
        p <- p + 1
      }
    }
    if(CRRNeeded>0) {
      while(CRRNeeded>0 & p <= 10) {
        CRRNeeded <- max(CRRNeeded - HyperStats$CRR[p], 0)
        HyperPts <- HyperPts + HyperStats$pts[p]
        HyperCRR <- HyperCRR + HyperStats$CRR[p]
        p <- p + 1
      }
    }
    if(CRRNeeded>0) {
      UnionCRR <- min(UnionCRR + CRRNeeded, 40)
    }
  }
  
  if(CRROver==T) {
    UnionCRR <- UnionR
    CRRNeeded <- max(CRRNeeded - UnionCRR, 0)
    HyperCRR <- sum(HyperStats$CRR[1:7])
    HyperPts <- sum(HyperStats$pts[1:7])
    CRRNeeded <- max(CRRNeeded - HyperCRR, 0)
    
    if(CRRNeeded>0) {
      UnionCRR <- min(UnionCRR + CRRNeeded, 40)
    }
  }
  CRRs <- data.frame(t(c(UnionCRR, HyperCRR, SoulWeaponCRR)))
  colnames(CRRs) <- c("Union", "Hyper", "SoulWeapon")
  return(CRRs)
}


## Ability Function
Abilities <- function(Abilities=AbilityOption, Grade=c("L", "U", "E")) {
  a <- rep(0, 7)
  a <- data.frame(t(a))
  colnames(a) <- AbilityOption
  adata <- Ability
  
  for(i in 1:length(Abilities)) {
    for(j in 1:7) {
      a[j] <- a[j] + ifelse(colnames(a)[j]==Abilities[i], ifelse(Grade[i]=="L", adata[1, j], ifelse(Grade[i]=="U", adata[2, j], 
                                                                                                    ifelse(Grade[i]=="E", adata[3, j], warning("invalid input")))), 0)
    }
  }
  
  return(a)
}


## Skill Specs Functions
PSkill <- c("MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
            "ATKP", "MainStatP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
            "SummonDuration", "Disorder", "ImmuneIgnore", 
            "LvDiffIgnore", "CoolTimeFastReduceSpeed", "CoolTimeReset", "CoolTimeResetTimes", "AddATKRate", "SkillLv")
### "BuffDuration", "CoolTime", "Delay", "BuffDurationAvailable", "CoolReduceAvailable", "CoolResetAvailable", 
### "FinalATKProb", "FinalATKDamage"

Passive <- function(PassiveSkills) {
  a <- rep(0, length(PSkill))
  for(i in 1:length(PassiveSkills)) {
    for(j in 1:nrow(PassiveSkills[[i]])) {
      t <- as.numeric(PassiveSkills[[i]][j, 1])
      a[t] <- ifelse(PSkill[t]!="IGR"&PSkill[t]!="FDR", a[t] + PassiveSkills[[i]][j, 2], 
                     ifelse(PSkill[t]=="IGR", (1 - (100 - a[t]) / 100 * (100 - PassiveSkills[[i]][j, 2]) / 100) * 100, 
                            ((100 + a[t]) / 100 * (100 + PassiveSkills[[i]][j, 2]) / 100) * 100 - 100))
    }
  }
  a <- data.frame(t(a))
  colnames(a) <- PSkill
  return(a)
}

BSkill <- c("MainStat", "SubStat1", "SubStat2", "MaxHP", "MaxHPP", "ATK", "ATKSub", 
            "ATKP", "MainStatP", "IGR", "BDR", "CRR", "CDMR", "FDR", "ATKSpeed", "Mastery", "BuffDuration", 
            "SummonDuration", "Disorder", "ImmuneIgnore", 
            "LvDiffIgnore", "CoolTimeFastReduceSpeed", "CoolTimeReset", "CoolTimeResetTimes", "AddATKRate", "SkillLv", "ATKSkill")
BInfo <- c("Duration", "CoolTime", "Delay", "BuffDurationAvailable", "CoolReduceAvailable", "CoolResetAvailable", "ServerLag") 

Buff <- function(BuffSkills) {
  buffoptions <- c(BSkill, BInfo)
  buffs <- matrix(rep(0, length(buffoptions)*length(BuffSkills)), nrow=length(BuffSkills), ncol=length(buffoptions))
  for(i in 1:(length(BuffSkills))) {
    BuffSkills[[i]][, 1] <- factor(BuffSkills[[i]][, 1], levels=buffoptions)
    for(j in 1:nrow(BuffSkills[[i]])) {
      t <- as.numeric(BuffSkills[[i]][j, 1])
      buffs[i, t] <- BuffSkills[[i]][j, 2]
    }
  }
  b <- c()
  for(i in 1:length(BuffSkills)) {
    b[i] <- names(BuffSkills[i])
  }
  colnames(buffs) <- buffoptions
  rownames(buffs) <- b
  return(buffs)
}

ASkill <- c("ATKP", "ATK", "IGR", "BDR", "CRR", "CDMR", "FDR", "ImmuneIgnore", "Disorder", "DisorderTime", "WhenBuffOnly")
AInfo <- c("Damage", "AttackTimes", "Delay", "SubTime", "CoolTime", "CoolReduceAvailable", "CoolResetAvailable", "Cancellable")

Attack <- function(ATKSkills) {
  ATKoptions <- c(ASkill, AInfo)
  ATKs <- matrix(rep(0, length(ATKoptions)*length(ATKSkills)), nrow=length(ATKSkills), ncol=length(ATKoptions))
  for(i in 1:(length(ATKSkills))) {
    ATKSkills[[i]][, 1] <- factor(ATKSkills[[i]][, 1], levels=ATKoptions)
    for(j in 1:nrow(ATKSkills[[i]])) {
      t <- as.numeric(ATKSkills[[i]][j, 1])
      ATKs[i, t] <- ATKSkills[[i]][j, 2]
    }
  }
  b <- c()
  for(i in 1:length(ATKSkills)) {
    b[i] <- names(ATKSkills[i])
  }
  colnames(ATKs) <- ATKoptions
  rownames(ATKs) <- b
  return(ATKs)
}

SSkill <- c("ATKP", "ATK", "IGR", "BDR", "CRR", "CDMR", "FDR", "ImmuneIgnore", "Disorder", "DisorderTime", "WhenBuffOnly")
SInfo <- c("Damage", "AttackTimes", "Delay", "SubTime", "Duration", "CoolTime", 
           "SummonedDurationAvailable", "CoolReduceAvailable", "CoolResetAvailable", "Cancellable")

Summoned <- function(SummonedSkills) {
  Summonedoptions <- c(SSkill, SInfo)
  Summoned <- matrix(rep(0, length(Summonedoptions)*length(SummonedSkills)), nrow=length(SummonedSkills), ncol=length(Summonedoptions))
  for(i in 1:(length(SummonedSkills))) {
    SummonedSkills[[i]][, 1] <- factor(SummonedSkills[[i]][, 1], levels=Summonedoptions)
    for(j in 1:nrow(SummonedSkills[[i]])) {
      t <- as.numeric(SummonedSkills[[i]][j, 1])
      Summoned[i, t] <- SummonedSkills[[i]][j, 2]
    }
  }
  b <- c()
  for(i in 1:length(SummonedSkills)) {
    b[i] <- names(SummonedSkills[i])
  }
  colnames(Summoned) <- Summonedoptions
  rownames(Summoned) <- b
  return(Summoned)
}


## IGR, FDR, CDMR Calculation Function
IGRCalc <- function(IGRs) {
  IGR <- 0
  for(i in 1:length(IGRs)) {
    IGR <- 1 - (1 - IGR) * (1 - (IGRs[i]/100))
  }
  IGR <- IGR * 100
  return(IGR)
}
FDRCalc <- function(FDRs) {
  FDR <- 1
  for(i in 1:length(FDRs)) {
    FDR <- FDR * (FDRs[i]/100 + 1)
  }
  FDR <- (FDR - 1) * 100
  return(FDR)
}
IGRDam <- function(IGR, MobGuard) {
  k <- (IGR / 100) * MobGuard
  DamR <- k - (MobGuard - 100)
  return(DamR)
}
CRRDam <- function(CRR, CDMR) {
  CRRDam <- 100 + (CDMR + 35) * ifelse(CRR>=100, 1, CRR/100)
  return(CRRDam)
}


## Delay, Cooldown Calculation Function
Delay <- function(Delay, ATKSpeed) {
  a <- (Delay * ((ATKSpeed+10) / 16)) / 30
  for(i in 1:length(Delay)) {
    Delay[i] <- (ceiling(a[i]) * 30)
  }
  return(Delay)
}
Cooldown <- function(CoolTime, CoolReduceAvailable, CoolReduceP, CoolReduce) {
  Cool <- c()
  a <- c()
  for(i in 1:length(CoolTime)) {
    CoolReduceAvailable[i] <- ifelse(is.na(CoolReduceAvailable[i])==T, F, CoolReduceAvailable[i])
    if(CoolReduceAvailable[i]==F) {
      Cool[i] <- ifelse(is.na(CoolTime[i])==T, 0, CoolTime[i])
    } else {
      Cool[i] <- ifelse(CoolTime[i]>=1, max(CoolTime[i] * ((100 - CoolReduceP) / 100), 1), CoolTime[i])
      if(Cool[i]>10) {
        Cool[i] <- Cool[i] - CoolReduce
        a[i] <- ifelse(Cool[i] <= 10, min(CoolTime[i], 10) - Cool[i], 0) * 5
        Cool[i] <- max(10, Cool[i])
      } else if(Cool[i]>5) {
        a[i] <- CoolReduce * 5
      } else {
        a[i] <- 0
      }
      if(Cool[i]<=10) {
        Cool[i] <- ifelse(CoolTime[i]<=5, Cool[i], max(Cool[i] * ((100 - a[i]) / 100), 5))
      }
    }
  }
  return(Cool)
}


## DealCycle Function
AllTimeBuff <- function(BuffList, WillBeAllTimeBuff=c()) {
  BuffList <- data.frame(BuffList)
  BuffList$BuffOpRatio <- ifelse(is.na(BuffList$CoolTime)==T, 1, BuffList$Duration / BuffList$CoolTime)
  AllTimeBuff <- subset(BuffList, BuffList$BuffOpRatio>=1)
  if(length(WillBeAllTimeBuff>=1)) {
    for(i in 1:length(WillBeAllTimeBuff)) {
      AllTimeBuff <- rbind(AllTimeBuff, subset(BuffList, rownames(BuffList)==WillBeAllTimeBuff[i]))
    }
  }
  
  AllTimeBuff <- AllTimeBuff[, 1:26]
  AllTimeBuffs <- AllTimeBuff[1, ]
  AllTimeBuffs[, c(-10, -14, -19, -21)] <- colSums(AllTimeBuff[, c(-10, -14, -19, -21)])
  AllTimeBuffs$IGR <- IGRCalc(AllTimeBuff$IGR)
  AllTimeBuffs$FDR <- FDRCalc(AllTimeBuff$FDR)
  AllTimeBuffs$Disorder <- max(AllTimeBuff$Disorder)
  AllTimeBuffs$LvDiffIgnore <- max(AllTimeBuff$LvDiffIgnore)
  return(AllTimeBuffs)
}
DCBuff <- function(PreDealCycle, Skills, BuffList) {
  Buffs <- colnames(PreDealCycle)[3:length(colnames(PreDealCycle))]
  
  k <- c()
  for(i in 1:length(Skills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(Skills[i]==Buffs[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  a <- rep(0, ncol(PreDealCycle))
  a <- data.frame(t(a))
  colnames(a) <- colnames(PreDealCycle)
  a[1, 1] <- Skills[1]
  a[1, 2] <- PreDealCycle[nrow(PreDealCycle), 2] + PreDealCycle[1, 2]
  for(j in 1:length(Buffs)) {
    a[1, j+2] <- ifelse(Skills[1]==Buffs[j], BuffList$Duration[k[1]] * 1000, max(PreDealCycle[nrow(PreDealCycle), j+2] - PreDealCycle[1, j+2], 0))
  }
  DealCycle <- rbind(PreDealCycle, a)
  
  if(length(Skills)>=2) {
    for(i in 2:length(Skills)) {
      a[1, 1] <- Skills[i]
      a[1, 2] <- DealCycle[nrow(DealCycle), 2] + BuffList$Delay[k[i-1]]
      for(j in 1:length(Buffs)) {
        a[1, j+2] <- ifelse(Skills[i]==Buffs[j], BuffList$Duration[k[i]] * 1000, max(DealCycle[nrow(DealCycle), j+2] - BuffList$Delay[k[i-1]], 0))
      }
      DealCycle <- rbind(DealCycle, a)
    }
  }
  DealCycle[1, 2 : ncol(DealCycle)] <- BuffList$Delay[k[length(k)]]
  return(DealCycle)
}
DCATK <- function(PreDealCycle, Skills, ATKSkillList) {
  ATKs <- rownames(ATKSkillList)
  
  k <- c()
  for(i in 1:length(Skills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(Skills[i]==ATKs[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  a <- rep(0, ncol(PreDealCycle))
  a <- data.frame(t(a))
  colnames(a) <- colnames(PreDealCycle)
  a[1, 1] <- Skills[1]
  a[1, 2] <- PreDealCycle[nrow(PreDealCycle), 2] + PreDealCycle[1, 2]
  for(j in 1:(ncol(PreDealCycle)-2)) {
    a[1, j+2] <- max(PreDealCycle[nrow(PreDealCycle), j+2] - PreDealCycle[1, j+2], 0)
  }
  DealCycle <- rbind(PreDealCycle, a)
  
  if(length(Skills)>=2) {
    for(i in 2:length(Skills)) {
      a[1, 1] <- Skills[i]
      a[1, 2] <- DealCycle[nrow(DealCycle), 2] + ATKSkillList$Delay[k[i-1]]
      for(j in 1:(ncol(PreDealCycle)-2)) {
        a[1, j+2] <- max(DealCycle[nrow(DealCycle), j+2] - ATKSkillList$Delay[k[i-1]], 0)
      }
      DealCycle <- rbind(DealCycle, a)
    }
  }
  DealCycle[1, 2 : ncol(DealCycle)] <- ATKSkillList$Delay[k[length(k)]]
  return(DealCycle)
}
DCATKSkip <- function(PreDealCycle, Skills, ATKSkillList, SkipStructure) {
  ATKs <- rownames(ATKSkillList)
  
  k <- c()
  for(i in 1:length(Skills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(Skills[i]==ATKs[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  if(sum(PreDealCycle$Skills[nrow(PreDealCycle)]==rownames(SkipStructure)) > 0) {
    s <- SkipStructure[rownames(SkipStructure)==PreDealCycle$Skills[nrow(PreDealCycle)], ]
    t <- s[, colnames(s)==Skills[1]]
    Delays <- ifelse(t==T, s$SkippedDelay, PreDealCycle[1, 2])
  } else {Delays <- PreDealCycle[1, 2]}
  
  if(length(Skills) > 1) {
    for(i in 1:(length(Skills)-1)) {
      if(sum(Skills[i]==rownames(SkipStructure)) > 0) {
        s <- SkipStructure[rownames(SkipStructure)==Skills[i], ]
        t <- s[, colnames(s)==Skills[i+1]]
        Delays <- c(Delays, ifelse(t==T, s$SkippedDelay, ATKSkillList$Delay[k[i]]))
      } else {Delays <- c(Delays, ATKSkillList$Delay[k[i]])}
    }
  }
  
  Delays <- c(Delays, ATKSkillList$Delay[k[length(k)]])
  
  a <- rep(0, ncol(PreDealCycle))
  a <- data.frame(t(a))
  colnames(a) <- colnames(PreDealCycle)
  a[1, 1] <- Skills[1]
  a[1, 2] <- PreDealCycle[nrow(PreDealCycle), 2] + Delays[1]
  for(j in 1:(ncol(PreDealCycle)-2)) {
    a[1, j+2] <- max(PreDealCycle[nrow(PreDealCycle), j+2] - Delays[1], 0)
  }
  DealCycle <- rbind(PreDealCycle, a)
  
  if(length(Skills)>=2) {
    for(i in 2:length(Skills)) {
      a[1, 1] <- Skills[i]
      a[1, 2] <- DealCycle[nrow(DealCycle), 2] + Delays[i]
      for(j in 1:(ncol(PreDealCycle)-2)) {
        a[1, j+2] <- max(DealCycle[nrow(DealCycle), j+2] - Delays[i], 0)
      }
      DealCycle <- rbind(DealCycle, a)
    }
  }
  DealCycle[1, 2 : ncol(DealCycle)] <- Delays[length(Delays)]
  return(DealCycle)
}
DCSummoned <- function(PreDealCycle, Skill, SummonedSkillList) {
  Summoned <- rownames(SummonedSkillList)
  k <- 0
  j <- 1
  p <- 1
  while(j==1) {
    k <- ifelse(Skill==Summoned[p], p, 0)
    p <- p + 1
    j <- ifelse(k==0, 1, 0)
  } 
  
  a <- rep(0, ncol(PreDealCycle))
  a <- data.frame(t(a))
  colnames(a) <- colnames(PreDealCycle)
  a[1, 1] <- paste(Skill, "Summoned", sep="")
  a[1, 2] <- PreDealCycle[nrow(PreDealCycle), 2] + PreDealCycle[1, 2]
  for(j in 1:(ncol(PreDealCycle)-2)) {
    a[1, j+2] <- max(PreDealCycle[nrow(PreDealCycle), j+2] - PreDealCycle[1, j+2], 0)
  }
  DealCycle <- rbind(PreDealCycle, a)
  DealCycle[1, 2 : ncol(DealCycle)] <- SummonedSkillList$Delay[k[length(k)]]
  return(DealCycle)
}
DCSummonedATKs <- function(DealCycle, Skills, SummonedSkillList) {
  Summons <- rownames(SummonedSkillList)
  
  k <- c()
  for(i in 1:length(Skills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(Skills[i]==Summons[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  SkillInd <- DealCycle[1, 1] == paste(Skills, "Summoned", sep="")
  
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- rbind(SkillInd, DealCycle[i, 1] == paste(Skills, "Summoned", sep=""))
  }
  
  maxtime <- max(DealCycle$Time)
  DealCycleNew <- DealCycle
  colnames(SkillInd) <- Skills
  rownames(SkillInd) <- 1:nrow(SkillInd)
  for(i in 1:ncol(SkillInd)) {
    DC <- DealCycle[SkillInd[, i], ]
    for(j in 1:nrow(DC)) {
      DC1 <- rbind(DC[j, ], DC[j, ])
      DC1[2, 1] <- Skills[i]
      DC1[2, 2] <- DC1[2, 2] + SummonedSkillList$SubTime[k[i]]
      
      p <- 1
      t <- SummonedSkillList$SubTime[k[i]] * 2
      while(t <= SummonedSkillList$Duration[k[i]]*1000 & t <= ifelse(is.na(DC[j+1, 2])==F, DC[j+1, 2]-DC[j, 2], Inf)) {
        DC1 <- rbind(DC1, DC1[1, ])
        DC1[p+2, 1] <- Skills[i]
        DC1[p+2, 2] <- DC1[p+1, 2] + SummonedSkillList$SubTime[k[i]]
        t <- t + SummonedSkillList$SubTime[k[i]]
        p <- p + 1
      }
      DC1 <- subset(DC1, DC1$Time<=maxtime)
      if(nrow(DC1)>1) {
        DealCycleNew <- rbind(DealCycleNew, DC1[2:nrow(DC1), ])
      }
    }
  }
  DealCycleNew <- DealCycleNew[order(DealCycleNew$Time), ] 
  rownames(DealCycleNew) <- 1:nrow(DealCycleNew)
  
  for(i in 1:nrow(DealCycleNew)) {
    if(sum(Skills==DealCycleNew[i, 1])>=1) {
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- DealCycleNew[i-1, 3:ncol(DealCycleNew)] - (DealCycleNew[i, 2] - DealCycleNew[i-1, 2])
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- ifelse(DealCycleNew[i, 3:ncol(DealCycleNew)]<0, 0, DealCycleNew[i, 3:ncol(DealCycleNew)])
    }
  }
  return(DealCycleNew)
}
DCSpiderInMirror <- function(DealCycle, SummonedSkillList) {
  SkillInd <- DealCycle[1, 1] == "SpiderInMirror"
  
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- c(SkillInd, DealCycle[i, 1] == "SpiderInMirror")
  }
  SIM <- c("SpiderInMirrorStart", "SpiderInMirror1", "SpiderInMirror2", "SpiderInMirror3", "SpiderInMirror4", "SpiderInMirror5", "SpiderInMirrorWait")
  k <- rep(0, 7)
  for(i in 1:7) {
    SIMCall <- rownames(SummonedSkillList)==SIM[i]
    p <- 1
    while(k[i] == 0) {
      k[i] <- ifelse(SIMCall[p]==F, 0, p)
      p <- p + 1
    } 
  }
  
  DC <- DealCycle[SkillInd, ]
  maxtime <- max(DealCycle$Time)
  for(i in 1:nrow(DC)) {
    DC1 <- DC[i, ]
    DC1 <- rbind(DC1, DC1)
    DC1[2, 1] <- c("SpiderInMirrorStart")
    DC1[2, 2] <- DC1[1, 2] + SummonedSkillList$SubTime[k[1]]
    
    t <- SummonedSkillList$SubTime[k[1]]
    p <- 3
    m <- 1
    while(t < 50000) {
      DC1 <- rbind(DC1, DC1[1, ])
      DC1[p, 1] <- SIM[m + 1]
      DC1[p, 2] <- DC1[p-1, 2] + SummonedSkillList$SubTime[k[m + 1]]
      t <- t + SummonedSkillList$SubTime[k[m + 1]]
      m <- ifelse(m==6, 1, m + 1)
      p <- p + 1
    }
    DC1 <- subset(DC1, DC1$Time<=maxtime)
    DealCycle <- rbind(DealCycle, DC1[2:nrow(DC1), ])
  }
  DealCycle <- DealCycle[order(DealCycle$Time), ] 
  rownames(DealCycle) <- 1:nrow(DealCycle)
  
  for(i in 1:nrow(DealCycle)) {
    if(sum(SIM==DealCycle[i, 1])>=1) {
      DealCycle[i, 3:ncol(DealCycle)] <- DealCycle[i-1, 3:ncol(DealCycle)] - (DealCycle[i, 2] - DealCycle[i-1, 2])
      DealCycle[i, 3:ncol(DealCycle)] <- ifelse(DealCycle[i, 3:ncol(DealCycle)]<0, 0, DealCycle[i, 3:ncol(DealCycle)])
    }
  }
  return(DealCycle)
}
RepATKCycle <- function(DealCycle, RepATKSkills, Hits, FirstATKDelays, ATKSkillList) {
  ATKs <- rownames(ATKSkillList)
  
  k <- c()
  for(i in 1:length(RepATKSkills)) {
    j <- 1
    p <- 1
    while(j==1) {
      k[i] <- ifelse(RepATKSkills[i]==ATKs[p], p, 0)
      p <- p + 1
      j <- ifelse(k[i]==0, 1, 0)
    } 
  }
  
  SkillInd <- DealCycle[1, 1] == RepATKSkills
  
  for(i in 2:nrow(DealCycle)) {
    SkillInd <- rbind(SkillInd, DealCycle[i, 1] == RepATKSkills)
  }
  
  maxtime <- max(DealCycle$Time)
  DealCycleNew <- DealCycle
  colnames(SkillInd) <- RepATKSkills
  rownames(SkillInd) <- 1:nrow(SkillInd)
  for(i in 1:ncol(SkillInd)) {
    DC <- DealCycle[SkillInd[, i], ]
    for(j in 1:nrow(DC)) {
      DC1 <- rbind(DC[j, ], DC[j, ])
      DC1[1, 1] <- paste(RepATKSkills, "Start", sep="")
      DC1[2, 1] <- RepATKSkills[i]
      DC1[2, 2] <- DC1[2, 2] + ATKSkillList$SubTime[k[i]]
      
      p <- 1
      t <- 0
      hit <- 2
      while(hit < Hits[i]) {
        DC1 <- rbind(DC1, DC1[1, ])
        DC1[p+2, 1] <- RepATKSkills[i]
        DC1[p+2, 2] <- DC1[p+1, 2] + ATKSkillList$SubTime[k[i]]
        t <- t + ATKSkillList$SubTime[k[i]]
        hit <- hit + 1
        p <- p + 1
      }
      if(nrow(DC1)>1) {
        DealCycleNew <- rbind(DealCycleNew, DC1)
      }
    }
    for(i in 1:nrow(DealCycleNew)) {
      if(sum(RepATKSkills==DealCycleNew[i, 1])>=1) {
        DealCycleNew[i, 2] <- DealCycleNew[i, 2] + FirstATKDelays
      }
    }
  }
  DealCycleNew <- subset(DealCycleNew, DealCycleNew$Time <= maxtime)
  DealCycleNew <- DealCycleNew[order(DealCycleNew$Time), ] 
  rownames(DealCycleNew) <- 1:nrow(DealCycleNew)
  
  for(i in 1:nrow(DealCycleNew)) {
    if(sum(RepATKSkills==DealCycleNew[i, 1])>=1) {
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- DealCycleNew[i-1, 3:ncol(DealCycleNew)] - (DealCycleNew[i, 2] - DealCycleNew[i-1, 2])
      DealCycleNew[i, 3:ncol(DealCycleNew)] <- ifelse(DealCycleNew[i, 3:ncol(DealCycleNew)]<0, 0, DealCycleNew[i, 3:ncol(DealCycleNew)])
    }
  }
  return(DealCycleNew)
}
DealCycleFinal <- function(DealCycle) {
  DealCycle <- rbind(DealCycle, DealCycle[nrow(DealCycle), ])
  DealCycle[nrow(DealCycle), 1] <- "End"
  DealCycle[nrow(DealCycle), 2] <- DealCycle[nrow(DealCycle), 2] + DealCycle[1, 2]
  for(i in 3:ncol(DealCycle)) {
    DealCycle[nrow(DealCycle), i] <- max(DealCycle[nrow(DealCycle), i] - DealCycle[1, i], 0)
  }
  
  DealCycle[1, ] <- 0
  rownames(DealCycle) <- 1:nrow(DealCycle)
  return(DealCycle)
}
DealCycleReduction <- function(DealCycle, NotBuffColNames=c()) {
  DC <- cbind(DealCycle, rep(1, nrow(DealCycle)))
  colnames(DC) <- c(colnames(DealCycle), "Repeats")
  
  DC <- DC[order(DealCycle$Skills), ]
  Ind <- c()
  for(i in 1:ncol(DealCycle)) {
    if(sum(colnames(DealCycle)[i]==c("Skills", "Time", NotBuffColNames))==0) {
      Ind <- c(Ind, i)
    }
  }
  for(i in 1:nrow(DealCycle)) {
    for(j in Ind) {
      DC[i, j] <- ifelse(DC[i, j]>0, 1, 0)
    }
  }
  NewDC <- DC[1, ]
  
  k <- c(1, 3:(ncol(DC)-1))
  for(i in 2:nrow(DealCycle)) {
    if(sum(NewDC[nrow(NewDC), k]==DC[i, k])==(ncol(DC)-2)) {
      NewDC$Repeats[nrow(NewDC)] <- NewDC$Repeats[nrow(NewDC)] + 1
    } else {
      NewDC <- rbind(NewDC, DC[i, ])
    }
  }
  return(NewDC)
}


## Level / ArcaneForce FDR Data / Function
ArcFDR <- c(0.1, 0.3, 0.6, 0.7, 0.8, 1, 1.1, 1.3, 1.5)
ArcRatio <- c(0, 0.3, 0.5, 0.7, 1, 1.1, 1.3, 1.5)

LvDiff <- 5:-40
LvFDRa <- c(0.08, 0.05, 0.03, 0)
LvFDR <- c(seq(1.2, 1.1, -0.02), 1.0584, 1.007, 0.9672, 0.918)
for(i in 8:0) {
  LvFDR <- c(LvFDR, LvFDRa+i/10)
}
LvFDR <- data.frame(LvDiff, LvFDR)

ArcaneForceFDR <- function(ChrArc, MapArc) {
  ArcFD <- NA
  for(i in 1:8) {
    if(ChrArc/MapArc <= ArcRatio[i]) {
      ArcFD <- ArcRatio[i]
    }
  }
  if(is.na(ArcFD)==T) {
    ArcFD <- ArcFDR[9]
  }
  return(ArcFD * 100 - 100)
}
LevelFDR <- function(ChrLv, MobLv) {
  Lvd <- ChrLv - MobLv
  d <- -1 * Lvd + 6
  d <- ifelse(d <= 0, 1, ifelse(d > 46, 46, d))
  return(LvFDR[d, 2] * 100 - 100)
}


## Damage Calculation Function
DealCalc <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
  ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
  ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
  BuffSkills <- rownames(BuffList)
  BuffOpList <- colnames(BuffList)
  SpecList <- colnames(Specs)
  
  BuffList <- data.frame(BuffList)
  BuffList$BuffOpRatio <- ifelse(is.na(BuffList$CoolTime)==T, 1, BuffList$Duration / BuffList$CoolTime)
  NonATimeBuff <- subset(BuffList, BuffList$BuffOpRatio<1)
  
  t <- c()
  ind <- c()
  p <- c()
  for(i in 1:length(SpecList)) {
    ind[i] <- 0
    p[i] <- 1
    t[i] <- 1
    while(ind[i]==0) {
      t[i] <- ifelse(SpecList[i]==BuffOpList[p[i]], t[i], t[i] + 1)
      ind[i] <- ifelse(SpecList[i]==BuffOpList[p[i]] | p[i] >= length(BuffOpList), 1, 0)
      p[i] <- p[i] + 1
    }
  }
  
  for(i in 1:length(SpecList)) {
    t[i] <- ifelse(t[i] > length(BuffOpList), NA, t[i])
  }
  
  k <- rownames(NonATimeBuff)
  b <- c()
  for(i in 1:(ncol(DealCycle)-2)) {
    b[i] <- max(k==colnames(DealCycle)[i+2])
  }
  c <- data.frame(c(1:length(b)), b)
  c <- subset(c, c$b==1)[, 1] + 2
  
  Deal <- c()
  for(i in 2:nrow(DealCycle)) {
    BuffInd <- DealCycle[i, c] > 0
    
    d <- NonATimeBuff[BuffInd, ]
    if(nrow(d) > 0) {
      BuffEach <- c()
      for(j in 1:ncol(d)) {
        if(colnames(d)[j]=="IGR") {
          BuffEach[j] <- IGRCalc(d[, j])
        } else if(colnames(d)[j]=="FDR") {
          BuffEach[j] <- FDRCalc(d[, j])
        } else if(colnames(d)[j]=="Disorder") {
          BuffEach[j] <- max(d[, j])
        } else if(colnames(d)[j]=="LvDiffIgnore") {
          BuffEach[j] <- max(d[, j])
        } else {
          BuffEach[j] <- sum(d[, j])
        }
      }
      BuffEach <- data.frame(t(BuffEach))
      colnames(BuffEach) <- colnames(d)
    } else {
      BuffEach <- data.frame(t(rep(0, ncol(d))))
      colnames(BuffEach) <- colnames(d)
    }
    SpecEach <- c()
    for(j in 1:ncol(Specs)) {
      if(is.na(t[j]==T)) {
        SpecEach[j] <- Specs[1, j]
      } else if(colnames(Specs)[j]=="IGR") {
        SpecEach[j] <- IGRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="FDR") {
        SpecEach[j] <- FDRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="Disorder" | colnames(Specs)[j]=="LvDiffIgnore") {
        SpecEach[j] <- max(c(Specs[1, j], BuffEach[1, t[j]]))
      } else {
        SpecEach[j] <- Specs[1, j] + BuffEach[1, t[j]]
      }
    }
    SpecEach <- data.frame(t(SpecEach))
    colnames(SpecEach) <- colnames(Specs)
    
    SkillInd <- DealCycle[i, 1]==rownames(ATKSkillsList)
    Skills <- ATKSkillsList[SkillInd, ]
    if(nrow(Skills)==0) {
      Deal[i] <- 0
    } else {
      Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobDefault$Basic$Guard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR)) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(MobDefault$Basic$PhysicImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
  }
  return(Deal)
}
pdamdist <- function(Damage, DamageAVG, Mastery, CDMR) {
  a <- Mastery / 100
  b <- CDMR / 100
  avg <- ((a + 1) / 2) * (b + 1.35)
  dr <- Damage / (DamageAVG / avg)
  
  if(dr > (b + 1.5) | dr < a * (b + 1.2)) {
    warning("invalid input")
  }
  
  p <- 0
  d1 <- function(x, a, b) {
    x * (10/3 - 10/3 * log(x / (a * (b + 1.2)))) / (a - 1)
  }
  d2 <- function(x, a, b) {
    x * (log(1 / a) * (1 / ((1 - a) * 0.3)))
  }
  d3 <- function(x, a, b) {
    x * (log((b + 1.5) / (b + 1.2)) * (1 / ((1 - a) * 0.3)))
  }
  d4 <- function(x, a, b) {
    -10/3 * x * (log((b + 1.5) / x) + 1) / (a - 1)
  }
  
  if(a * (b + 1.5) > b + 1.2) {
    if(dr < b + 1.2) {
      p <- p + d1(dr, a, b) - d1(a * (b + 1.2), a, b)
    } else if(dr < a * (b + 1.5)) {
      p <- p + d1(b + 1.2, a, b) - d1(a * (b + 1.2), a, b)
      p <- p + d2(dr, a, b) - d2(b + 1.2, a, b)
    } else {
      p <- p + d1(b + 1.2, a, b) - d1(a * (b + 1.2), a, b)
      p <- p + d2(a * (b + 1.5), a, b) - d2(b + 1.2, a, b)
      p <- p + d4(dr, a, b) - d4(a * (b + 1.5), a, b)
    }
  } else {
    if(dr < a * (b + 1.5)) {
      p <- p + d1(dr, a, b) - d1(a * (b + 1.2), a, b)
    } else if(dr < b + 1.2) {
      p <- p + d1(a * (b + 1.5), a, b) - d1(a * (b + 1.2), a, b)
      p <- p + d3(dr, a, b) - d3(a * (b + 1.5), a, b)
    } else {
      p <- p + d1(a * (b + 1.5), a, b) - d1(a * (b + 1.2), a, b)
      p <- p + d3(b + 1.2, a, b) - d3(a * (b + 1.5), a, b)
      p <- p + d4(dr, a, b) - d4(b + 1.2, a, b)
    }
  }
  return(p)
} ## percentile
CutDam <- function(DamAVG, Mastery, CDMR) {
  a <- Mastery / 100
  b <- CDMR / 100
  avg <- ((a + 1) / 2) * (b + 1.35)
  maxd <- b + 1.5
  mind <- a * (b + 1.2)
  
  e1 <- function(x, a, b) {
    (x^2 * (5/6 - 5/3 * log(x/(a * (b + 1.2))))) / (a - 1)
  }
  e2 <- function(x, a, b) {
    (x^2 * 5/3 * log(1/a)) / (1 - a)
  }
  e3 <- function(x, a, b) {
    (x^2 * 5/3 * log((b+1.5)/(b+1.2))) / (1 - a)
  }
  e4 <- function(x, a, b) {
    (x^2 * (-5/3 * log((b+1.5)/x) - 5/6)) / (a - 1)
  }
  
  DamMax <- DamAVG / avg * maxd
  Dammin <- DamAVG / avg * mind
  dr <- 150000000000 / (DamAVG / avg)
  if(DamMax > 150000000000 & Dammin < 150000000000) {
    p <- 1 - pdamdist(150000000000, DamAVG, Mastery, CDMR)
    e <- 0
    if(a * (b + 1.5) > b + 1.2) {
      if(dr < b + 1.2) {
        e <- e + e1(dr, a, b) - e1(a * (b + 1.2), a, b)
      } else if(dr < a * (b + 1.5)) {
        e <- e + e1(b + 1.2, a, b) - e1(a * (b + 1.2), a, b)
        e <- e + e2(dr, a, b) - e2(b + 1.2, a, b)
      } else {
        e <- e + e1(b + 1.2, a, b) - e1(a * (b + 1.2), a, b)
        e <- e + e2(a * (b + 1.5), a, b) - e2(b + 1.2, a, b)
        e <- e + e4(dr, a, b) - e4(a * (b + 1.5), a, b)
      }
    } else {
      if(dr < a * (b + 1.5)) {
        e <- e + e1(dr, a, b) - e1(a * (b + 1.2), a, b)
      } else if(dr < b + 1.2) {
        e <- e + e1(a * (b + 1.5), a, b) - e1(a * (b + 1.2), a, b)
        e <- e + e3(dr, a, b) - e3(a * (b + 1.5), a, b)
      } else {
        e <- e + e1(a * (b + 1.5), a, b) - e1(a * (b + 1.2), a, b)
        e <- e + e3(b + 1.2, a, b) - e3(a * (b + 1.5), a, b)
        e <- e + e4(dr, a, b) - e4(b + 1.2, a, b)
      }
    }
    NewDMR <- DamAVG / avg * e + 150000000000 * p
  } else if(Dammin > 150000000000) {
    NewDMR <- 150000000000
  } else {
    NewDMR <- DamAVG
  }
  return(NewDMR)
}
DealCalcWithMaxDMR <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs) {
  ATKSkills <- c(rownames(ATKSkillsList), rownames(SummonedSkillsList))
  ATKSkillsList <- rbind(ATKSkillsList, SummonedSkillsList[, c(-16, -18)])
  BuffSkills <- rownames(BuffList)
  BuffOpList <- colnames(BuffList)
  SpecList <- colnames(Specs)
  
  BuffList <- data.frame(BuffList)
  BuffList$BuffOpRatio <- ifelse(is.na(BuffList$CoolTime)==T, 1, BuffList$Duration / BuffList$CoolTime)
  NonATimeBuff <- subset(BuffList, BuffList$BuffOpRatio<1)
  
  t <- c()
  ind <- c()
  p <- c()
  for(i in 1:length(SpecList)) {
    ind[i] <- 0
    p[i] <- 1
    t[i] <- 1
    while(ind[i]==0) {
      t[i] <- ifelse(SpecList[i]==BuffOpList[p[i]], t[i], t[i] + 1)
      ind[i] <- ifelse(SpecList[i]==BuffOpList[p[i]] | p[i] >= length(BuffOpList), 1, 0)
      p[i] <- p[i] + 1
    }
  }
  
  for(i in 1:length(SpecList)) {
    t[i] <- ifelse(t[i] > length(BuffOpList), NA, t[i])
  }
  
  k <- rownames(NonATimeBuff)
  b <- c()
  for(i in 1:(ncol(DealCycle)-2)) {
    b[i] <- max(k==colnames(DealCycle)[i+2])
  }
  c <- data.frame(c(1:length(b)), b)
  c <- subset(c, c$b==1)[, 1] + 2
  
  Deal <- c()
  for(i in 2:nrow(DealCycle)) {
    BuffInd <- DealCycle[i, c] > 0
    
    d <- NonATimeBuff[BuffInd, ]
    if(nrow(d) > 0) {
      BuffEach <- c()
      for(j in 1:ncol(d)) {
        if(colnames(d)[j]=="IGR") {
          BuffEach[j] <- IGRCalc(d[, j])
        } else if(colnames(d)[j]=="FDR") {
          BuffEach[j] <- FDRCalc(d[, j])
        } else if(colnames(d)[j]=="Disorder") {
          BuffEach[j] <- max(d[, j])
        } else if(colnames(d)[j]=="LvDiffIgnore") {
          BuffEach[j] <- max(d[, j])
        } else {
          BuffEach[j] <- sum(d[, j])
        }
      }
      BuffEach <- data.frame(t(BuffEach))
      colnames(BuffEach) <- colnames(d)
    } else {
      BuffEach <- data.frame(t(rep(0, ncol(d))))
      colnames(BuffEach) <- colnames(d)
    }
    SpecEach <- c()
    for(j in 1:ncol(Specs)) {
      if(is.na(t[j]==T)) {
        SpecEach[j] <- Specs[1, j]
      } else if(colnames(Specs)[j]=="IGR") {
        SpecEach[j] <- IGRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="FDR") {
        SpecEach[j] <- FDRCalc(c(Specs[1, j], BuffEach[1, t[j]]))
      } else if(colnames(Specs)[j]=="Disorder" | colnames(Specs)[j]=="LvDiffIgnore") {
        SpecEach[j] <- max(c(Specs[1, j], BuffEach[1, t[j]]))
      } else {
        SpecEach[j] <- Specs[1, j] + BuffEach[1, t[j]]
      }
    }
    SpecEach <- data.frame(t(SpecEach))
    colnames(SpecEach) <- colnames(Specs)
    
    SkillInd <- DealCycle[i, 1]==rownames(ATKSkillsList)
    Skills <- ATKSkillsList[SkillInd, ]
    if(nrow(Skills)==0) {
      Deal[i] <- 0
    } else {
      Deal[i] <- Skills$Damage / 100 * (SpecEach$MainStat * 4 + SpecEach$SubStat1 + ifelse(is.null(SpecEach$SubStat2)==T, 0, SpecEach$SubStat2)) * (SpecEach$ATK + Skills$ATK) / 100 *
        (100 + SpecEach$ATKP + Skills$ATKP) / 100 * IGRDam(IGRCalc(c(SpecEach$IGR, Skills$IGR)), MobDefault$Basic$Guard) / 100 * (100 + SpecEach$BDR + Skills$BDR) / 100 * 
        CRRDam(SpecEach$CRR + Skills$CRR, SpecEach$CDMR + Skills$CDMR) / 100 * (FDRCalc(c(SpecEach$FDR, Skills$FDR)) + 100) / 100 * (SpecEach$Mastery + 100) / 200 * 
        ifelse(MobDefault$Basic$PhysicImmune==T, (50 + SpecEach$ImmuneIgnore/2 + Skills$ImmuneIgnore/2)/100, 1)
      Deal[i] <- CutDam(Deal[i], SpecEach$Mastery, SpecEach$CDMR + Skills$CDMR) * Skills$AttackTimes * ifelse(sum(colnames(DealCycle)=="Repeats")==1, DealCycle$Repeats[i], 1)
    }
  }
  return(Deal)
}
DealRatio <- function(DealCycle, DealData) {
  DealRatio <- data.frame(DealCycle$Skills, DealData)
  colnames(DealRatio) <- c("Skills", "Damage")
  DealRatio <- subset(DealRatio, is.na(DealRatio$Damage)==F)
  
  DealRatio$Skills <- as.factor(DealRatio$Skills)
  SkillList <- levels(DealRatio$Skills)
  a <- list()
  b <- data.frame(t(rep(0, length(SkillList))))
  for(i in 1:length(SkillList)) {
    a[[i]] <- subset(DealRatio, DealRatio$Skills==SkillList[i])
    b[1, i] <- sum(a[[i]]$Damage)
  }
  
  colnames(b) <- SkillList
  b <- rbind(b, b)
  for(i in 1:length(SkillList)) {
    b[2, i] <- b[1, i] / sum(b[1, ])
  }
  rownames(b) <- c("Damage", "Ratio")
  b <- data.frame(t(b))
  b <- subset(b, b$Ratio > 0)
  
  b1 <- subset(b, substr(rownames(b), 1, 14)=="SpiderInMirror")
  b2 <- subset(b, substr(rownames(b), 1, 14)!="SpiderInMirror")
  SIM <- c(sum(b1$Damage), sum(b1$Ratio))
  b3 <- rbind(b2, SIM)
  rownames(b3) <- c(rownames(b2), "SpiderInMirror")
  return(b3)
}


## Damage Optimization Function
PotentialList <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/potentiallist.csv"
PotentialList <- read.csv(PotentialList)

PotentialListZero <- "https://raw.githubusercontent.com/ParkKyuSeon/Maplestory_DPM/master/data/potentiallistzero.csv"
PotentialListZero <- read.csv(PotentialListZero)
PotIGR <- c(0, 30, 40, 58, 64, 74.8, 78.4, 84.88, 89.416, 92.5912)
PotList <- list()
for(i in 1:length(PotIGR)) {
  PotList[[i]] <- subset(PotentialList, PotentialList$IGR==PotIGR[i])
}
ZeroPotList <- list()
for(i in 1:length(PotIGR)) {
  ZeroPotList[[i]] <- subset(PotentialListZero, PotentialListZero$IGR==PotIGR[i])
}

Optimization1 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList,  NewSpecs)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
Optimization2 <- function(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]])))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]])))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]])))
    } else {
      NewDeal[7] <- sum(na.omit(DealCalc(DealCycle, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]])))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(lvs)
  return(Specs)
}


## CoolTime Reset Deal Calc Functions
ResetDealCalc <- function(DealCycles=list(), ATKSkillsList, BuffList, SummonedSkillsList, Specs, times=c(), prob=c()) {
  WeightedTime <- sum(times * prob)
  Weight <- times * prob / WeightedTime
  
  Deals <- c()
  for(i in 1:length(times)) {
    Deals[i] <- sum(na.omit(DealCalc(DealCycles[[i]], ATKSkillsList, BuffList, SummonedSkillsList, Specs))) * Weight[i]
  }
  return(sum(Deals))
}
ResetDealCalcWithMaxDMR <- function(DealCycles=list(), ATKSkillsList, BuffList, SummonedSkillsList, Specs, times=c(), prob=c()) {
  WeightedTime <- sum(times * prob)
  Weight <- times * prob / WeightedTime
  
  Deals <- c()
  for(i in 1:length(times)) {
    Deals[i] <- sum(na.omit(DealCalcWithMaxDMR(DealCycles[[i]], ATKSkillsList, BuffList, SummonedSkillsList, Specs))) * Weight[i]
  }
  return(sum(Deals))
}
ResetOptimization1 <- function(DealCycles=list(), ATKSkillsList, BuffList, SummonedSkillsList, Specs, UnionBDRIGR, times=c(), prob=c()) {
  BDR <- min(40, UnionBDRIGR) : max(0, (UnionBDRIGR - 40))
  IGR <- UnionBDRIGR - BDR
  UnionList <- data.frame(BDR, IGR)
  PotList <- PotList
  
  BaseDeal <- ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, Specs, times, prob)
  
  NewDeal <- c()
  p <- 1
  while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[1]])) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][p, 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][p, 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][p, 2]))
    NewDeal[p] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
    p <- p + 1
  }
  if(length(NewDeal)==2) {
    NewSpecs <- Specs
    NewSpecs$ATKP <- Specs$ATKP + PotList[[1]][nrow(PotList[[1]]), 1]
    NewSpecs$BDR <- Specs$BDR + PotList[[1]][nrow(PotList[[1]]), 3]
    NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[1]][nrow(PotList[[1]]), 2]))
    NewDeal[p] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
    l <- NewDeal==max(NewDeal)
    Deals <- max(NewDeal)
    Combinations <- ifelse(l[1]==T, PotList[[1]][1, ], PotList[[1]][length(PotList[[1]]), ])
  } else {
    Combinations <- PotList[[1]][length(NewDeal), ]
    Deals <- max(NewDeal)
  }
  ind <- c(0, 0)
  
  k <- 2
  while(ind[1]<=ind[2] & k<=length(PotList)) {
    ind[1] <- max(NewDeal)
    NewDeal <- c()
    p <- 1
    while(ifelse(p<=2, 0, NewDeal[p-2])<=ifelse(p==1, 0, NewDeal[p-1]) & p<=nrow(PotList[[k]])) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][p, 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][p, 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][p, 2]))
      NewDeal[p] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
      p <- p + 1
    }
    if(length(NewDeal)==2) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- Specs$ATKP + PotList[[k]][nrow(PotList[[k]]), 1]
      NewSpecs$BDR <- Specs$BDR + PotList[[k]][nrow(PotList[[k]]), 3]
      NewSpecs$IGR <- IGRCalc(c(Specs$IGR, PotList[[k]][nrow(PotList[[k]]), 2]))
      NewDeal[p] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
      l <- NewDeal==max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
      Combinations <- rbind(Combinations, ifelse(l[1]==T, PotList[[k]][1, ], PotList[[k]][length(PotList[[k]]), ]))
      ind[2] <- max(NewDeal)
    } else {
      Combinations <- rbind(Combinations, PotList[[k]][length(NewDeal), ])
      ind[2] <- max(NewDeal)
      Deals <- c(Deals, max(NewDeal))
    }
    k <- k + 1
  }
  DealList <- data.frame(Combinations, Deals)
  DealList <- subset(DealList, DealList$Deals==max(DealList$Deals))
  
  t <- ifelse(DealList$IGR==0, 1, ifelse(DealList$IGR==40 | DealList$IGR==64 | DealList$IGR==78.4, 2, ifelse(DealList$IGR==30, 3, 4)))
  
  if(t==1) {
    AvailablePot <- DealList[, 1:3]
  } else if(t==2) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    if(DealList$BDR<=100) {
      NewCase2 <- c() ## Minus IGR40, Plus BDR40
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase2[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase2)
    }
  } else if(t==3) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR30, Plus ATK9
    NewCase1[1] <- DealList$ATKP + 9
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1) 
    
    if(DealList$BDR<=110) {
      NewCase2 <- c() ## Minus IGR30, Plus BDR30
      NewCase2[1] <- DealList$ATKP
      NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase2[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase2) 
    }
  } else if(t==4) {
    AvailablePot <- DealList[, 1:3]
    NewCase1 <- c() ## Minus IGR40, Plus ATK12
    NewCase1[1] <- DealList$ATKP + 12
    NewCase1[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
    NewCase1[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase1)
    
    NewCase2 <- c() ## Minus IGR30, Plus ATK9
    NewCase2[1] <- DealList$ATKP + 9
    NewCase2[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
    NewCase2[3] <- DealList$BDR
    AvailablePot <- rbind(AvailablePot, NewCase2)
    
    if(DealList$BDR<=100) {
      NewCase3 <- c() ## Minus IGR40, Plus BDR40
      NewCase3[1] <- DealList$ATKP
      NewCase3[2] <- IGRCalc(c(DealList$IGR, -2/3*100))
      NewCase3[3] <- DealList$BDR + 40
      AvailablePot <- rbind(AvailablePot, NewCase3)
    }
    
    if(DealList$BDR<=110) {
      NewCase4 <- c() ## Minus IGR30, Plus BDR30
      NewCase4[1] <- DealList$ATKP
      NewCase4[2] <- IGRCalc(c(DealList$IGR, -3/7*100))
      NewCase4[3] <- DealList$BDR + 30
      AvailablePot <- rbind(AvailablePot, NewCase4)
    }
  }
  
  FinalATKP <- c()
  FinalIGR <- c()
  FinalBDR <- c()
  FinalDeal <- c()
  FinalCombination <- data.frame(FinalATKP, FinalIGR, FinalBDR, FinalDeal)
  for(i in 1:nrow(AvailablePot)) {
    ATKP <- rep(AvailablePot[i, 1], nrow(UnionList))
    BDR <- AvailablePot[i, 3] + UnionList[, 1]
    for(j in 1:nrow(UnionList)) {
      IGR[j] <- IGRCalc(c(AvailablePot[i, 2], UnionList[j, 2]))
    }
    FinalList <- data.frame(ATKP, IGR, BDR)
    
    NewDeal <- c()
    NewSpecs <- Specs
    NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[1]
    NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[1]
    NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[1]))
    NewDeal[1] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
    
    if(nrow(FinalList) > 1) {
      NewSpecs <- Specs
      NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[2]
      NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[2]
      NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[2]))
      NewDeal[2] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
      
      if(NewDeal[1] > NewDeal[2]) {
        NewSpecs <- Specs
        NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[nrow(FinalList)]
        NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[nrow(FinalList)]
        NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[nrow(FinalList)]))
        NewDeal[2] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
        
        FinalCombination[i, 1] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 1], FinalList[nrow(FinalList), 1])
        FinalCombination[i, 2] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 2], FinalList[nrow(FinalList), 2])
        FinalCombination[i, 3] <- ifelse(NewDeal[1] > NewDeal[2], FinalList[1, 3], FinalList[nrow(FinalList), 3])
        FinalCombination[i, 4] <- ifelse(NewDeal[1] > NewDeal[2], NewDeal[1], NewDeal[2])
      } else {
        p <- 1
        while(NewDeal[p+1] <= NewDeal[p] & p + 2 <= nrow(FinalList)) {
          NewSpecs <- Specs
          NewSpecs$ATKP <- NewSpecs$ATKP +  FinalList$ATK[p+2]
          NewSpecs$BDR <- NewSpecs$BDR +  FinalList$BDR[p+2]
          NewSpecs$IGR <- IGRCalc(c(NewSpecs$IGR, FinalList$IGR[p+2]))
          NewDeal[p+2] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs, times, prob)))
          p <- p + 1
        }
        FinalCombination[i, 1] <- FinalList[length(NewDeal), 1]
        FinalCombination[i, 2] <- FinalList[length(NewDeal), 2]
        FinalCombination[i, 3] <- FinalList[length(NewDeal), 3]
        FinalCombination[i, 4] <- max(NewDeal)
      }
    } else {
      FinalCombination[i, 1] <- FinalList[1, 1]
      FinalCombination[i, 2] <- FinalList[1, 2]
      FinalCombination[i, 3] <- FinalList[1, 3]
      FinalCombination[i, 4] <- max(NewDeal)
    }
  }
  colnames(FinalCombination) <- c("ATKP", "IGR", "BDR", "Deal")
  FinalCombination <- subset(FinalCombination, FinalCombination$Deal==max(FinalCombination$Deal))
  return(FinalCombination)
}
ResetOptimization2 <- function(DealCycles=list(), ATKSkillsList, BuffList, SummonedSkillsList, Specs, HyperBase, ChrLv, CRROver, HyperStanceLv=0, times=c(), prob=c()) {
  lvs <- c()
  for(i in 1:9) {
    p <- 0
    while(sum(HyperStats[1:p, i+1])<HyperBase[1, i]) {
      p <- p + 1
    }
    lvs[i] <- p
  }
  
  totalpts <- sum(subset(lvpts, lvpts$lv<=ChrLv)[, 2])
  usedpts <- 0
  for(i in 1:9) {
    usedpts <- usedpts + ifelse(HyperBase[1, i]==0, 0, sum(HyperStats[1:lvs[i], 1]))
  }
  usedpts <- usedpts + ifelse(HyperStanceLv>0, sum(HyperStats[1:HyperStanceLv, 1]), 0)
  remainpts <- totalpts - usedpts
  nextlevelpts <- HyperStats[(lvs + 1), 1]
  
  while(remainpts > min(nextlevelpts)) {
    NewSpecs <- list()
    for(i in 1:10) {
      NewSpecs[[i]] <- Specs
    }
    names(NewSpecs) <- c("Pre", colnames(HyperBase))
    PreDeal <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i]], times, prob)))
    NewSpecs$MainStat$MainStat <- NewSpecs$MainStat$MainStat + ifelse(nextlevelpts[1] > remainpts, 0, HyperStats$MainStat[lvs[1]+1])
    NewSpecs$SubStat1$SubStat1 <- NewSpecs$SubStat1$SubStat1 + ifelse(nextlevelpts[2] > remainpts, 0, HyperStats$SubStat1[lvs[2]+1])
    if(is.null(NewSpecs$SubStat2$SubStat2)==F) {
      NewSpecs$SubStat2$SubStat2 <- NewSpecs$SubStat2$SubStat2 + ifelse(nextlevelpts[3] > remainpts, 0, HyperStats$SubStat2[lvs[3]+1])
    }
    NewSpecs$DMR$BDR <- NewSpecs$DMR$BDR + ifelse(nextlevelpts[4] > remainpts, 0, HyperStats$DMR[lvs[4]+1])
    NewSpecs$BDR$BDR <- NewSpecs$BDR$BDR + ifelse(nextlevelpts[5] > remainpts, 0, HyperStats$BDR[lvs[5]+1])
    NewSpecs$IGR$IGR <- ifelse(nextlevelpts[6] > remainpts, NewSpecs$IGR$IGR, ifelse(lvs[6]==0, IGRCalc(c(NewSpecs$IGR$IGR, sum(HyperStats$IGR[1:lvs[6]+1]))), 
                                                                                     IGRCalc(c((1 - (1 - NewSpecs$IGR$IGR/100) * (1 / (1-(sum(HyperStats$IGR[1:lvs[6]])/100)))) * 100, sum(HyperStats$IGR[1:(lvs[6]+1)])))))
    NewSpecs$CRR$CRR <- ifelse(CRROver==T, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1]), 
                               ifelse(NewSpecs$CRR$CRR + HyperStats$CRR[lvs[7]+1]>=100, 100, NewSpecs$CRR$CRR + ifelse(nextlevelpts[7] > remainpts, 0, HyperStats$CRR[lvs[7]+1])))
    NewSpecs$CDMR$CDMR <- NewSpecs$CDMR$CDMR + ifelse(nextlevelpts[8] > remainpts, 0, HyperStats$CDMR[lvs[8]+1])
    NewSpecs$ATK$ATK <- NewSpecs$ATK$ATK + ifelse(nextlevelpts[9] > remainpts, 0, HyperStats$ATK[lvs[9]+1])
    
    NewDeal <- c()
    for(i in c(1:6, 8:9)) {
      NewDeal[i] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[i+1]], times, prob)))
    }
    if(CRROver==T) {
      BuffListNew <- BuffList
      CRIlv <- BuffList[rownames(BuffList)=="CriticalReinforce", ]$CDMR / NewSpecs$Pre$CRR * 100 - 20
      BuffListNew[rownames(BuffListNew)=="CriticalReinforce", ]$CDMR <- NewSpecs$CRR$CRR * ((CRIlv + 20) / 100)
      NewDeal[7] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffListNew, SummonedSkillsList, NewSpecs[[8]], times, prob)))
    } else {
      NewDeal[7] <- sum(na.omit(ResetDealCalc(DealCycles, ATKSkillsList, BuffList, SummonedSkillsList, NewSpecs[[8]], times, prob)))
    }
    
    Eff <- (NewDeal / PreDeal - 1) / nextlevelpts
    HyperTypes <- colnames(HyperBase)
    StatGrowth <- c()
    for(i in 1:9) {
      StatGrowth[i] <- HyperStats[lvs[i]+1, i+1]
    }
    Effs <- data.frame(HyperTypes, Eff, StatGrowth, nextlevelpts)
    
    if(sum(Effs$Eff>0)>0) {
      maxeff <- subset(Effs, Effs$Eff==max(Effs$Eff))
      remainpts <- remainpts - maxeff[1, 4]
      
      print(paste("Choose", as.character(maxeff[1, 1]), "and Remain Points Are", as.numeric(remainpts)))
      if(maxeff[1, 1]=="CRR") {
        Specs <- NewSpecs$CRR
      } else if(maxeff[1, 1]=="IGR") {
        Specs <- NewSpecs$IGR
      } else if(maxeff[1, 1]=="DMR") {
        Specs <- NewSpecs$DMR
      } else {
        Specs[, colnames(Specs)==maxeff[1, 1]] <- Specs[, colnames(Specs)==maxeff[1, 1]] + maxeff[1, 3]
      }
      lvs[HyperTypes==maxeff[1, 1]] <- lvs[HyperTypes==maxeff[1, 1]] + 1
      nextlevelpts <- HyperStats[(lvs + 1), 1]
    } else {
      remainpts <- 0
    }
  }
  lvs <- data.frame(t(lvs))
  colnames(lvs) <- HyperTypes
  print(lvs)
  return(Specs)
}
ResetDealRatio <- function(DealCycles=list(), DealDatas=list(), times=c(), prob=c()) {
  WeightedTime <- sum(times * prob)
  Weight <- times * prob / WeightedTime
  
  Skills <- as.factor(DealCycles[[1]]$Skills)
  SkillList <- levels(Skills)
  
  DealRatios <- list()
  for(i in 1:length(DealCycles)) {
    DealRatios[[i]] <- DealRatio(DealCycles[[i]], DealDatas[[i]])
  }
  
  DealRatioFinal <- data.frame(t(rep(0, length(SkillList))))
  DealRatioFinal <- rbind(DealRatioFinal, DealRatioFinal)
  colnames(DealRatioFinal) <- SkillList
  rownames(DealRatioFinal) <- c("Damage", "Ratio")
  
  for(i in 1:ncol(DealRatioFinal)) {
    for(j in 1:length(DealRatios)) {
      DealRatioFinal[1, i] <- DealRatioFinal[1, i] + ifelse(sum(rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])>0, subset(DealRatios[[j]], rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])[1, 1], 0) *
        Weight[j]
      DealRatioFinal[2, i] <- DealRatioFinal[2, i] + ifelse(sum(rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])>0, subset(DealRatios[[j]], rownames(DealRatios[[j]])==colnames(DealRatioFinal)[i])[1, 2], 0) *
        Weight[j]
    }
  }
  DealRatioFinal <- data.frame(t(DealRatioFinal))
  DealRatioFinal <- subset(DealRatioFinal, DealRatioFinal$Ratio>0)
  return(DealRatioFinal)
}


## Common V Skill Functions
CommonV <- function(class1, class2) {
  cls1 <- c("Warrior", "Wizard", "Bowman", "Thief", "Pirate")
  cmm1 <- c("AuraWeapon", "OverloadMana", "GuidedArrow", "VenomBurst", "LoadedDice")
  cmm3 <- c("BodyofSteel", "EtherealForm", "CriticalReinforce", "ReadyToDie", "OverDrive")
  
  cls2 <- c("AdventureWarrior", "AdventureWizard", "AdventureBowman", "AdventureThief", "AdventurePirate", 
            "CygnusKnights", "Heroes", "Resistance", "Demon", "Nova", "Lef", "Anima", "Transcedent", "Supernatural")
  cmm2 <- c("BlitzShield", "UnstableMemorize", "Evolve", "UltimateDarkSight", "PirateFlag", 
            "CygnusPhalanx", "FreudBlessing", "ResistanceLineInfantry", "CallMastema", "Pantheon", "MagicCircuitFullDrive", "Hwajunggunja", NA, NA)
  cmm4 <- c("MapleWarriors2", "MapleWarriors2", "MapleWarriors2", "MapleWarriors2", "MapleWarriors2", 
            "BlessofCygnus", "MapleWarriors2", "MapleWarriors2", "BlessofIsekaiGoddess", "BlessofGrandisGoddess", "BlessofGrandisGoddess", "BlessofGrandisGoddess", 
            "BlessofRhinne", "BlessofMasteriaGoddess")
  
  cls1skill <- data.frame(cls1, cmm1, cmm3, stringsAsFactors=F)
  cls2skill <- data.frame(cls2, cmm2, cmm4, stringsAsFactors=F)
  if(class2=="Adventure") {
    class2 <- paste(class2, class1, sep="")
  }

  commonskills <- c()
  for(i in 1:5) {
    if(class1==cls1skill$cls1[i]) {
      commonskills <- c(commonskills, cls1skill$cmm1[i], cls1skill$cmm3[i])
    }
  }
  for(i in 1:nrow(cls2skill)) {
    if(class2==cls2skill$cls2[i]) {
      commonskills <- c(commonskills, cls2skill$cmm2[i], cls2skill$cmm4[i], "SpiderInMirror")
    }
  }
  return(commonskills)
}


## V Matrix Functions
MatrixSet <- function(PasSkills, 
                      PasLvs, 
                      PasMP, 
                      ActSkills, 
                      ActLvs, 
                      ActMP, 
                      BlinkLv=1, 
                      BlinkMP=0, 
                      UsefulSkills, 
                      UsefulLvs, 
                      UsefulMP, 
                      SpecSet=SpecDefault, 
                      SelfWill=T,
                      SelfBind=F) {
  Cores <- floor((SpecSet$Basic$ChrLv - 200) / 5) + 5 + 2
  MatrixPoints <- SpecSet$Basic$ChrLv - 200
  
  CoreNumbers <- ceiling(sum(PasLvs) / 75) + length(ActSkills) + 1 + ifelse(SelfWill==F, 1, 0) + ifelse(SelfBind==F, 1, 0) + length(UsefulSkills)
  if(CoreNumbers > Cores) {warning("Invalid Input : Cores Exceeded") 
    stop()}
  
  MPs <- ceiling(sum(PasMP) / 15) * 5 + sum(ActMP) + BlinkMP
  if(MPs > MatrixPoints) {warning("Invalid Input : Matrix Points Exceeded") 
    stop()}
  
  PassiveCore <- data.frame(PasSkills, PasLvs + PasMP)
  colnames(PassiveCore) <- c("Passive", "Levels")
  
  ActiveCore <- data.frame(ActSkills, ActLvs + ActMP)
  colnames(ActiveCore) <- c("Active", "Levels")
  
  Blink <- data.frame(Active="Blink", Levels=BlinkLv + BlinkMP)
  ErdaNova <- data.frame(Active="ErdaNova", Levels=1)
  ErdaWill <- data.frame(Active="ErdaWill", Levels=1)
  if(SelfBind==F) {
    ActiveCore <- rbind(ActiveCore, Blink, ErdaNova)
  } else {
    ActiveCore <- rbind(ActiveCore, Blink)
  }
  
  if(SelfWill==F) {
    ActiveCore <- rbind(ActiveCore, ErdaWill)
  }
  
  UsefulCore <- data.frame(UsefulSkills, UsefulLvs + UsefulMP)
  colnames(UsefulCore) <- c("Useful", "Levels")
  Cores <- list(PassiveCore, ActiveCore, UsefulCore)
  print("Valid Input")
  return(Cores)
}


## Job Basic Info Function
JobBase <- function(ChrInfo=ChrInfo,
                    MobInfo=MobDefault,
                    SpecSet=SpecDefault, 
                    Job,
                    CoreData,
                    BuffDurationNeeded, 
                    AbilList, 
                    LinkList, 
                    MonsterLife, 
                    Weapon,
                    WeaponType, 
                    SubWeapon, 
                    Emblem, 
                    CoolReduceHat=F) {
  JobIndex <- c()
  for(i in 1:nrow(ChrInfo)) {
    if(Job==ChrInfo$job[i]) {
      JobIndex <- i
    }
  }
  InfoList <- c("Class1", "Class2", "MainStat", "SubStat1", "SubStat2", "BaseMastery")
  JobData <- list()
  JobData$Job <- Job
  for(i in 1:length(InfoList)) {
    JobData[[i+1]] <- ChrInfo[JobIndex, i+1]
    names(JobData)[[i+1]] <- InfoList[i]
  }
  JobData$CRROver <- ifelse(JobData$Class1=="Bowman", T, F)
  
  UnionIndex <- c()
  for(i in 1:length(UnionPreSet)) {
    if(paste("Union", SpecSet$Basic$UnionLv, sep="")==names(UnionPreSet)[[i]]) {
      UnionIndex <- i
      break
    }
  }
  CoolReduceP <- UnionChr(UnionPreSet[[i]], Job, SpecSet$Basic$ChrLv)$CoolReduceP
  JobData$BuffDurationNeeded <- BuffDurationNeeded
  
  InfoList2 <- c("ChrLv", "UnionLv", "ArcaneForce", "ArcaneForceStat", "AuthenticForce", "Charisma", "Insight", "Sensibility", "Will")
  t <- length(JobData)
  for(i in 1:length(InfoList2)) {
    JobData[[i+t]] <- SpecSet$Basic[1, i]
    names(JobData)[[i+t]] <- InfoList2[i]
  }
  
  JobData$Ability <- Abilities(AbilList, SpecSet$AbilityGrade)
  
  MobLvFactor <- JobData$ChrLv > MobInfo$Basic$Lv
  CadenaLinkIndex <- c()
  for(i in 1:nrow(LinkBase)) {
    if("Cadena"==ChrInfo$job[i]) {
      CadenaLinkIndex <- i
    }
  }
  Links <- LinkBase
  Links$BDR[CadenaLinkIndex] <- ifelse(MobLvFactor==T, 12, 6)
  LinkIndex <- c()
  for(j in 1:length(LinkList)) {
    for(i in 1:nrow(LinkSkill)) {
      if(LinkList[j]==rownames(LinkSkill)[i]) {
        LinkIndex <- c(LinkIndex, i)
      }
    }
  }
  Links <- rbind(LinkBase, LinkSkill[LinkIndex, ])
  Links <- data.frame(Links)
  LinkSet <- c()
  for(i in c(1:9, 11:13)) {
    LinkSet[i] <- sum(Links[, i]) 
  }
  LinkSet[10] <- IGRCalc(Links[, 10])
  LinkSet <- data.frame(t(LinkSet))
  colnames(LinkSet) <- colnames(Links)[1:13]
  rownames(LinkSet) <- c("Links")
  JobData$Links <- LinkSet
  
  ML <- colSums(MonsterLife) ## IGR Logic Needed
  JobData$MonsterLife <- data.frame(t(ML))
  JobData$CommonSkillSet <- data.frame(t(colSums(CommonSkills)))
  JobData$Dopings <- data.frame(t(colSums(DopingSet))) ## IGR Logic Needed
  
  Weapon <- rbind(Weapon, SubWeapon, Emblem)
  rownames(Weapon) <- c("Weapon", "SubWeapon", "Emblem")
  Weapon <- data.frame(Weapon)
  Weapon <- WeaponAddpotential(Weapon, c(SpecSet$WeaponAddPGrade), c(SpecSet$WeaponAddPOp))
  JobData$Weapon <- Weapon
  JobData$ItemSet <- SpecSet$ItemSet
  
  UnionIndex <- c()
  for(i in 1:length(UnionPreSet)) {
    if(paste("Union", SpecSet$Basic$UnionLv, sep="")==names(UnionPreSet)[[i]]) {
      UnionIndex <- i
      break
    }
  }
  JobData$UnionChrs <- UnionChr(UnionPreSet[[i]], Job, SpecSet$Basic$ChrLv)
  
  JobData$SkillLv <- sum(CoreData[[3]][, 1]=="CombatOrders")
  JobData$PSkillLv <- sum(CoreData[[3]][, 1]=="CombatOrders") + JobData$Ability$PassiveLv
  
  if(Job=="Palladin") {
    JobData$SkillLv <- 2
    JobData$PSkillLv <- 2 + JobData$Ability$PassiveLv
  }
  
  if(Job!="Xenon") {
    if(CoolReduceHat==T) {
      JobData$ItemSet$MainStatP <- JobData$ItemSet$MainStatP + SpecSet$CoolReduceInfo$MainStatP[2]
      JobData$CoolReduce <- SpecSet$CoolReduceInfo$CoolReduce[2]
    } else {
      JobData$CoolReduce <- 0
    }
  } else {
    if(CoolReduceHat==T) {
      JobData$ItemSet$AllstatP <- JobData$ItemSet$AllstatP + SpecSet$CoolReduceInfo$AllStatP[2]
      JobData$CoolReduce <- SpecSet$CoolReduceInfo$CoolReduce[2]
    } else {
      JobData$CoolReduce <- 0
    }
  }
  
  MainStatP <- 1
  for(i in 1:length(JobData)) {
    if(is.data.frame(JobData[[i]])==T) {
    MainStatP <- MainStatP + sum(JobData[[i]]$AllstatP)/100 + sum(JobData[[i]]$MainStatP)/100
    }
  }
  JobData$MainStatP <- MainStatP
  
  if(Job=="Xenon") {
    AllStatP <- 1
    for(i in 1:length(JobData)) {
      if(is.data.frame(JobData[[i]])==T) {
        AllStatP <- AllStatP + sum(JobData[[i]]$AllstatP)/100
      }
    }
    JobData$AllStatP <- AllStatP
  }
  return(JobData)
}


## Job Spec Function
JobSpec <- function(JobBase, 
                    Passive, 
                    AllTimeBuff, 
                    MobInfo=MobDefault, 
                    SpecSet=SpecDefault, 
                    WeaponName, 
                    UnionStance, 
                    JobConstant=1, 
                    NotCRR100=F) {
  ## If Job is DemonAvenger, Remove MainStat
  if(JobBase$Job=="DemonAvenger") {
    for(i in 1:length(JobBase)) {
      if(is.data.frame(JobBase[[i]])==T & sum(colnames(JobBase[[i]])=="MainStat") >= 1) {
        JobBase[[i]]$MainStat <- 0
      }
    }
  }
  JobBase$MainStatP <- Passive
  names(JobBase)[length(JobBase)] <- "Passive"
  JobBase$AllTimeBuff <- AllTimeBuff
  CRR <- 5 ; BuffDuration <- floor(JobBase$Sensibility/10)
  for(i in 1:length(JobBase)) {
    if(is.data.frame(JobBase[[i]])==T) {
      CRR <- CRR + sum(JobBase[[i]]$CRR)
      BuffDuration <- BuffDuration + sum(JobBase[[i]]$BuffDuration)
    }
  }
  CRR <- ifelse(JobBase$CRROver==T, CRR, min(CRR, 100))
  
  UnionFieldOption <- c("CDMR", "CRR", "BDR", "IGR", "BuffDuration", "MainStat", "SubStat1", "SubStat2", "ATK", "Stance")
  UnionBase <- data.frame(t(c(40, 0, 0, 0, 0,5, 1, 1, 5, 0)))
  colnames(UnionBase) <- UnionFieldOption
  UnionIndex <- c()
  for(i in 1:length(UnionPreSet)) {
    if(paste("Union", JobBase$UnionLv, sep="")==names(UnionPreSet)[[i]]) {
      UnionIndex <- i
      break
    }
  }
  UnionFields <- UnionPreSet[[i]]$SSSChrs * 5 + UnionPreSet[[i]]$SSChrs * 4 + UnionPreSet[[i]]$SChrs * 3 + 
                 ifelse(JobBase$ChrLv>=250, 5, ifelse(JobBase$ChrLv>=200, 4, 3)) + 
                 ifelse(UnionPreSet[[i]]$MapleM==F, 0, ifelse(UnionPreSet[[i]]$MapleMGrade=="SS", 4, 3)) - sum(UnionBase)
  CRRs <- CRRGet(UnionFields, JobBase$BuffDurationNeeded, BuffDuration, CRR, JobBase$CRROver, NotCRR100, UnionStance)
  UnionBase <- UnionPlace(UnionFields - max(0, JobBase$BuffDurationNeeded - BuffDuration) - CRRs$Union, UnionBase, 
                          max(0, min(40, JobBase$BuffDurationNeeded - BuffDuration)), CRRs$Union, UnionStance)
  UnionBase$CDMR <- UnionBase$CDMR/2
  UnionBase$MainStat <- UnionBase$MainStat*5
  UnionBase$SubStat1 <- UnionBase$SubStat1*5
  UnionBase$SubStat2 <- UnionBase$SubStat2*5
  UnionRemained <- UnionPreSet[[i]]$SSSChrs * 5 + UnionPreSet[[i]]$SSChrs * 4 + UnionPreSet[[i]]$SChrs * 3 + 
                   ifelse(JobBase$ChrLv>=250, 5, ifelse(JobBase$ChrLv>=200, 4, 3)) + 
                   ifelse(UnionPreSet[[i]]$MapleM==F, 0, ifelse(UnionPreSet[[i]]$MapleMGrade=="SS", 4, 3)) - 
                   UnionBase$CDMR * 2 - UnionBase$CRR - UnionBase$BuffDuration - UnionBase$MainStat / 5 - UnionBase$SubStat1 / 5 - 
                   UnionBase$SubStat2 / 5 - UnionBase$ATK - UnionBase$Stance
  ## DemonAvenger Union Place HP : MainStat * 250 
  if(JobBase$Job=="DemonAvenger") {
    UnionBase$MainStat <- UnionBase$MainStat / 5 * 250 / 17.5
    JobBase$UnionBase <- UnionBase
  } else {
    JobBase$UnionBase <- UnionBase
  }
  print(UnionBase)
  
  HyperStatBase <- data.frame(t(c(0, 0, 0, 10, 10, 10, ifelse(CRRs$Hyper<=5, CRRs$Hyper, 5+(CRRs$Hyper-5)/2), 10, 0)))
  for(i in 1:ncol(HyperStatBase)) {
    colnames(HyperStatBase)[i] <- ifelse(JobBase$Job!="DemonAvenger", colnames(HyperStats)[i+1], colnames(HyperStatsDA)[i+1])  ## DemonAvenger : has HP% and no HP in Hyper Stats
  }
  HyperSP <- 0
  for(i in 1:9) {
    lvs <- HyperStatBase[1, i]
    HyperStatBase[1, i] <- ifelse(lvs==0, 0, sum(HyperStats[1:lvs, i+1]))
    HyperSP <- HyperSP + ifelse(lvs==0, 0, sum(HyperStats[1:lvs, 1]))
  }
  JobBase$HyperStatBase <- HyperStatBase
  
  SoulWeaponOptions <- c("ATK", "ATKP", "CRR")
  SoulWeapon <- data.frame(t(c(20, ifelse(CRRs[1, 3]==0, 3, 0), ifelse(CRRs[1, 3]==12, 12, 0))))
  colnames(SoulWeapon) <- SoulWeaponOptions
  JobBase$SoulWeapon <- SoulWeapon
  
  for(i in 1:6) {
    colnames(JobBase$UnionChrs)[i] <- ifelse(colnames(JobBase$UnionChrs)[i]==JobBase$MainStat, "MainStat", 
                                             ifelse(colnames(JobBase$UnionChrs)[i]==JobBase$SubStat1, "SubStat1", 
                                             ifelse(colnames(JobBase$UnionChrs)[i]=="HPP", "MaxHPP", 
                                             ifelse(colnames(JobBase$UnionChrs)[i]==JobBase$SubStat2, "SubStat2", 
                                             colnames(JobBase$UnionChrs)[i]))))
    colnames(JobBase$MonsterLife)[i+8] <- ifelse(colnames(JobBase$MonsterLife)[i+8]==JobBase$MainStat, "MainStat", 
                                                 ifelse(colnames(JobBase$MonsterLife)[i+8]==JobBase$SubStat1, "SubStat1", 
                                                 ifelse(colnames(JobBase$MonsterLife)[i+8]=="HPP", "MaxHPP", 
                                                 ifelse(colnames(JobBase$MonsterLife)[i+8]==JobBase$SubStat2, "SubStat2", 
                                                 colnames(JobBase$MonsterLife)[i+8]))))
  }
  ## DemonAvenger : Main Stat Conversion, HPP Effected
  if(JobBase$Job=="DemonAvenger") {
    UneffMainStat <- JobBase$UnionChrs$MainStat / 17.5
    UneffSubStat1 <- JobBase$UnionChrs$SubStat1 + JobBase$HyperStatBase$SubStat1
    UneffSubStat2 <- JobBase$UnionChrs$SubStat2 + JobBase$HyperStatBase$SubStat2
    JobBase$MonsterLife$MainStat <- JobBase$MonsterLife$MainStat / 17.5
    JobBase$UnionChrs$MainStat <- 0 ; JobBase$UnionChrs$MaxHP <- 0
    JobBase$UnionChrs$SubStat1 <- 0 ; JobBase$HyperStatBase$SubStat1 <- 0
    JobBase$UnionChrs$SubStat2 <- 0 ; JobBase$HyperStatBase$SubStat2 <- 0
  } else {
    UneffMainStat <- JobBase$UnionChrs$MainStat + JobBase$HyperStatBase$MainStat
    UneffSubStat1 <- JobBase$UnionChrs$SubStat1 + JobBase$HyperStatBase$SubStat1
    UneffSubStat2 <- JobBase$UnionChrs$SubStat2 + JobBase$HyperStatBase$SubStat2
    JobBase$UnionChrs$MainStat <- 0 ; JobBase$HyperStatBase$MainStat <- 0
    JobBase$UnionChrs$SubStat1 <- 0 ; JobBase$HyperStatBase$SubStat1 <- 0
    JobBase$UnionChrs$SubStat2 <- 0 ; JobBase$HyperStatBase$SubStat2 <- 0
  }
  
  ## DemonAvenger MainStat : 629 + 90 * Lv, Xenon MainStat : 26 + 5 * Lv - 660, Xenon SubStat 1 : 330, Xenon SubStat 2 : 330
  MainStat <- ifelse(JobBase$Job!="DemonAvenger", 18 + 5 * JobBase$ChrLv + ifelse(JobBase$Job!="Xenon", 0, 8 - 660), (629 + 90 * JobBase$ChrLv + floor(JobBase$Will/5)*100)/17.5)
  if(JobBase$Job=="DemonAvenger") {
    DAMainStatBonus <- (629 + 90 * JobBase$ChrLv)/14 - (629 + 90 * JobBase$ChrLv)/17.5
    UneffMainStat <- UneffMainStat + DAMainStatBonus
  }
  SubStat1 <- ifelse(JobBase$Job!="Xenon", 4, 330)
  SubStat2 <- ifelse(JobBase$Job!="Xenon", 4, 330)
  ATK <- 0 ; ATKSub <- JobBase$ItemSet$ATKSub
  ATKP <- 0 ; IGR <- floor(JobBase$Charisma/5)/2 ; BDR <- 0 ; CRR <- 5 ; CDMR <- 0 ; FDR <- 0
  ATKSpeed <- WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, WeaponName, SpecSet$WeaponType)[17]
  Mastery <- JobBase$BaseMastery
  BuffDuration <- floor(JobBase$Sensibility/10) ; SummonedDuration <- 0
  ImmuneIgnore <- floor(JobBase$Insight/10)/2
  CoolTimeReset <- 0 ; SkillLv <- JobBase$SkillLv ; PSkillLv <- JobBase$PSkillLv ; CoolReduceP <- 0 ; 
  CoolReduce <- JobBase$CoolReduce
  Disorder <- 1
  AllstatP <- 1 ; MainStatP <- 1
  ## DemonAvenger : Convert HP to MainStat / Item HP -> * 0.5
  JobBase$ItemSet$MaxHP <- ifelse(JobBase$Job!="DemonAvenger", JobBase$ItemSet$MaxHP, JobBase$ItemSet$MaxHP/2)
  for(i in 1:nrow(JobBase$Weapon)) {
    JobBase$Weapon$MaxHP[i] <- ifelse(JobBase$Job!="DemonAvenger", JobBase$Weapon$MaxHP[i], JobBase$Weapon$MaxHP[i]/2)
  }
  for(i in 1:length(JobBase)) {
    if(is.data.frame(JobBase[[i]])==T) {
      MainStat <- MainStat + ifelse(JobBase$Job!="DemonAvenger", sum(JobBase[[i]]$MainStat), sum(JobBase[[i]]$MainStat) + (sum(JobBase[[i]]$HP) +  sum(JobBase[[i]]$MaxHP))/17.5)
      SubStat1 <- SubStat1 + sum(JobBase[[i]]$SubStat1)
      SubStat2 <- SubStat2 + sum(JobBase[[i]]$SubStat2)
      ATK <- ATK + sum(JobBase[[i]]$ATK)
      ATKP <- ATKP + sum(JobBase[[i]]$ATKP)
      IGR <- IGRCalc(c(IGR, IGRCalc(c(JobBase[[i]]$IGR))))
      FDR <- FDRCalc(c(FDR, FDRCalc(c(JobBase[[i]]$FDR))))
      BDR <- BDR + sum(JobBase[[i]]$BDR) + sum(JobBase[[i]]$DisorderBDR) + sum(JobBase[[i]]$DMR)
      CRR <- CRR + sum(JobBase[[i]]$CRR)
      CDMR <- CDMR + sum(JobBase[[i]]$CDMR)
      ATKSpeed <- ATKSpeed - sum(JobBase[[i]]$ATKSpeed)
      Mastery <- Mastery + sum(JobBase[[i]]$Mastery)
      BuffDuration <- BuffDuration + sum(JobBase[[i]]$BuffDuration)
      SummonedDuration <- SummonedDuration + sum(JobBase[[i]]$SummonedDuration) + sum(JobBase[[i]]$SummonDuration)
      ImmuneIgnore <- ImmuneIgnore + sum(JobBase[[i]]$ImmuneIgnore)
      CoolTimeReset <- CoolTimeReset + sum(JobBase[[i]]$CoolTimeReset)
      CoolReduceP <- CoolReduceP + sum(JobBase[[i]]$CoolReduceP)
      AllstatP <- AllstatP + sum(JobBase[[i]]$AllstatP)/100
      MainStatP <- MainStatP + ifelse(JobBase$Job!="DemonAvenger", sum(JobBase[[i]]$AllstatP)/100 + sum(JobBase[[i]]$MainStatP)/100, sum(JobBase[[i]]$MainStatP)/100 + sum(JobBase[[i]]$MaxHPP)/100)
    }
  }
  if(JobBase$Job=="Xenon") {
    MainStatWithoutStatP <- MainStat
    SubStat1WithoutStatP <- SubStat1
    SubStat2WithoutStatP <- SubStat2
  } else if(JobBase$Job=="DemonAvenger") {
    MainStatWithoutStatP <- MainStat
  }
  MainStat <- floor(MainStat * MainStatP) + floor(UneffMainStat) + ifelse(JobBase$Job!="Xenon", JobBase$ArcaneForceStat, JobBase$ArcaneForceStat / 100 * 39)
  SubStat1 <- floor(SubStat1 * AllstatP) + UneffSubStat1 + ifelse(JobBase$Job!="Xenon", 0, JobBase$ArcaneForceStat / 100 * 39)
  SubStat2 <- floor(SubStat2 * AllstatP) + UneffSubStat2 + ifelse(JobBase$Job!="Xenon", 0, JobBase$ArcaneForceStat / 100 * 39)
  SubStat2 <- ifelse(is.na(JobBase$SubStat2)==T, 0, SubStat2)
  CRR <- ifelse(JobBase$CRROver==T, CRR, min(100, CRR))
  FDR <- FDRCalc(c(FDR, ArcaneForceFDR(JobBase$ArcaneForce, MobInfo$Basic$Arc), LevelFDR(JobBase$ChrLv, MobInfo$Basic$Lv), 
                   (WeaponUpgrade(1, 17, 4, 0, 0, 0, 0, 3, 0, 0, WeaponName, SpecSet$WeaponType)[19]*100-100), (JobConstant-1)*100))
  ATKSpeed <- max(ATKSpeed, 2)
  Mastery <- min(Mastery, 99)
  if(SubStat2==0) {
    Spec <- data.frame(MainStat=MainStat, SubStat1=SubStat1, ATK=ATK, ATKSub=ATKSub,
                       ATKP=ATKP, IGR=IGR, BDR=BDR, CRR=CRR, CDMR=CDMR, FDR=FDR, 
                       ATKSpeed=ATKSpeed, Mastery=Mastery, BuffDuration=BuffDuration, SummonedDuration=SummonedDuration, ImmuneIgnore=ImmuneIgnore, 
                       CoolTimeReset=CoolTimeReset, SkillLv=SkillLv, PSkillLv=PSkillLv, CoolReduceP=CoolReduceP, CoolReduce=CoolReduce, Disorder=Disorder, 
                       MainStatP=MainStatP)
  } else {
    Spec <- data.frame(MainStat=MainStat, SubStat1=SubStat1, SubStat2=SubStat2, ATK=ATK, ATKSub=ATKSub,
                       ATKP=ATKP, IGR=IGR, BDR=BDR, CRR=CRR, CDMR=CDMR, FDR=FDR, 
                       ATKSpeed=ATKSpeed, Mastery=Mastery, BuffDuration=BuffDuration, SummonedDuration=SummonedDuration, ImmuneIgnore=ImmuneIgnore, 
                       CoolTimeReset=CoolTimeReset, SkillLv=SkillLv, PSkillLv=PSkillLv, CoolReduceP=CoolReduceP, CoolReduce=CoolReduce, Disorder=Disorder, 
                       MainStatP=MainStatP)
  }
  
  if(JobBase$Job=="Xenon") {
    Spec$AllStatP <- AllstatP
    Spec$MainStatWithoutStatP <- MainStatWithoutStatP
    Spec$SubStat1WithoutStatP <- SubStat1WithoutStatP    
    Spec$SubStat2WithoutStatP <- SubStat2WithoutStatP
  } else if(JobBase$Job=="DemonAvenger") {
    Spec$MainStatWithoutStatP <- MainStatWithoutStatP
  }
  Spec <- list(Spec=Spec, UnionRemained=UnionRemained, HyperStatBase=HyperStatBase, CoolReduceType=SpecSet$CoolReduceInfo)
  print(CRRs)
  return(Spec)
}