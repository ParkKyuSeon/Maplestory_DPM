## Ver 1.2.344
DPM12344Ratio <- DPM12344
DPM12344Standard <- c(DPM12344$Bishop[1], NA, DPM12344$Bishop[3:4])
DPM12344Ratio[1, ] <- DPM12344[1, ] / DPM12344Standard[1] * 100
DPM12344Ratio[2, ] <- DPM12344[2, ] / max(DPM12344[1, ], 1) * 100
DPM12344Ratio[3, ] <- DPM12344[3, ] / DPM12344Standard[3] * 100
DPM12344Ratio[4, ] <- DPM12344[4, ] / DPM12344Standard[4] * 100
DPM12344Ratio <- round(DPM12344Ratio, 4)
rownames(DPM12344Ratio) <- c("DPMRatio", "LeakageRatio", "RestraintRatio", "40sRatio")

DPM12344 <- round(DPM12344)
DPM12344Final <- rbind(DPM12344, DPM12344Ratio)
rownames(DPM12344Final) <- c("DPM", "DPMRatio", "DamageLeakage", "LeakageRatio", "Restraint", "RestraintRatio", "40s", "40sRatio")
for(i in 1:nrow(DPM12344)) {
  DPM12344Final[i*2 - 1, ] <- DPM12344[i, ]
  DPM12344Final[i*2, ] <- DPM12344Ratio[i, ]
}
DPM12344Final <- data.frame(t(DPM12344Final))
DPM12344Final <- DPM12344Final[order(DPM12344Final$DPMRatio, decreasing=T), ]
write.csv(DPM12344Final, "DPM_12344.csv")

## Need to be made to Function