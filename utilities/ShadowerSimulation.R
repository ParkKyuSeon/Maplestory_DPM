## Front Side
KP <- c()
front <- c(0, 1, 2)

for(i in 1:10000) {
  ## Set Seed Number
  set.seed(i)
  ## Determine Count of Meso
  meso <- min(20, rbinom(1, 24, 0.4))
  if(meso >= 3) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso - sample(front, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else {
    KP <- c(KP, 0)
  }
}

sum(KP==3)


## Rear Side (Original Model)
KP <- c()
rear_even_over11 <- c(rep(1, 42), rep(0, 58))
rear_odd_over11 <- c(rep(0.5, 92), rep(-0.5, 8))
rear_even_8to10 <- c(-1, 0, 1)
rear_odd_8to10 <- c(-0.5, 0.5)
rear_even_lower7 <- c(rep(-1, 42), rep(0, 58))
rear_odd_lower7 <- c(rep(-0.5, 92), rep(0.5, 8))

for(i in 1:10000) {
  ## Set Seed Number
  set.seed(i)
  ## Determine Count of Meso
  meso <- min(20, rbinom(1, 24, 0.4))
  if(meso >= 11 & meso / 2 == floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_even_over11, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso >= 11 & meso / 2 != floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_odd_over11, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso >= 8 & meso <= 10 & meso / 2 == floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_even_8to10, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso >= 8 & meso <= 10 & meso / 2 != floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_odd_8to10, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso <= 7 & meso / 2 == floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_even_lower7, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso <= 7 & meso / 2 != floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_odd_lower7, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else {
    KP <- c(KP, 0)
  }
}

sum(KP==3)


## Rear Side (Simplified)
KP <- c()
rear_even <- c(1, 0, -1)
rear_odd <- c(0.5, -0.5)

for(i in 1:10000) {
  ## Set Seed Number
  set.seed(i)
  ## Determine Count of Meso
  meso <- min(20, rbinom(1, 24, 0.4))
  if(meso / 2 == floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_even, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  } else if(meso / 2 != floor(meso / 2)) {
    ## Determine Count of Delayed Meso
    delayedmeso <- meso / 2 - sample(rear_odd, 1)
    ## Simultate Meso Delay
    if(delayedmeso > 0) {
      mesodelay <- round(rnorm(delayedmeso, 495, 55) / 30) * 30
    } else {
      mesodelay <- c()
    }
    ## Check KP is been 3
    KP <- c(KP, min(3, length(unique(mesodelay))))
  }  else {
    KP <- c(KP, 0)
  }
}

sum(KP==3)