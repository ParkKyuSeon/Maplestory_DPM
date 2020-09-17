## Ver 1.2.338
DPM12338Ratio <- DPM12338
DPM12338Standard <- c(DPM12338$Bishop[1], NA, DPM12338$Bishop[3:4])
DPM12338Ratio[1, ] <- DPM12338[1, ] / DPM12338Standard[1] * 100
DPM12338Ratio[2, ] <- DPM12338[2, ] / max(DPM12338[1, ], 1) * 100
DPM12338Ratio[3, ] <- DPM12338[3, ] / DPM12338Standard[3] * 100
DPM12338Ratio[4, ] <- DPM12338[4, ] / DPM12338Standard[4] * 100
DPM12338Ratio <- round(DPM12338Ratio, 4)
rownames(DPM12338Ratio) <- c("DPMRatio", "LeakageRatio", "RestraintRatio", "40sRatio")

DPM12338 <- round(DPM12338)
DPM12338Final <- rbind(DPM12338, DPM12338Ratio)
rownames(DPM12338Final) <- c("DPM", "DPMRatio", "DamageLeakage", "LeakageRatio", "Restraint", "RestraintRatio", "40s", "40sRatio")
for(i in 1:nrow(DPM12338)) {
  DPM12338Final[i*2 - 1, ] <- DPM12338[i, ]
  DPM12338Final[i*2, ] <- DPM12338Ratio[i, ]
}
DPM12338Final <- data.frame(t(DPM12338Final))
DPM12338Final <- DPM12338Final[order(DPM12338Final$DPMRatio, decreasing=T), ]
write.csv(DPM12338Final, "DPM_12338.csv")

## Need to be made to Function