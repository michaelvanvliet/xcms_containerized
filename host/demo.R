# R script to demo XCMS
library(xcms) # include xcms

# read data files ########################################
cdfpath <- system.file("cdf", package = "faahKO")
cdffiles <- list.files(cdfpath, recursive = TRUE, full.names = TRUE)
xset <- xcmsSet(cdffiles)
xset <- group(xset)
xset2 <- retcor(xset, family = "symmetric", plottype = "mdevden")
xset2 <- group(xset2, bw = 10)
xset3 <- fillPeaks(xset2)
reporttab <- diffreport(xset3, "WT", "KO", "example", 10, metlin = 0.15)
reporttab[1:4, ]
gt <- groups(xset3)
colnames(gt)
groupidx1 <- which(gt[, "rtmed"] > 2600 & gt[, "rtmed"] < 2700 & gt[, "npeaks"] == 12)[1]
groupidx2 <- which(gt[, "rtmed"] > 3600 & gt[, "rtmed"] < 3700 & gt[, "npeaks"] == 12)[1]
eiccor <- getEIC(xset3, groupidx = c(groupidx1, groupidx2))
eicraw <- getEIC(xset3, groupidx = c(groupidx1, groupidx2), rt = "raw")
plot(eicraw, xset3, groupidx = 1)
plot(eicraw, xset3, groupidx = 2)
plot(eiccor, xset3, groupidx = 1)
plot(eiccor, xset3, groupidx = 2)

library(xcms)
cdfpath <- system.file("cdf", package = "faahKO")
cdffiles <- list.files(cdfpath, recursive = TRUE, full=T) # input files (step 1)
xset <- xcmsSet(cdffiles)  # peak picking (step 2)
xsg <- group(xset)    # peak alignment (step 3.1)
xsg <- retcor(xsg)     # retention time correction (step 3.2)
xsg <- group(xsg)     # re-align (step 3.3)
xsg <- fillPeaks(xsg)  # filling in missing peak data (step 4)
dat <- groupval(xsg, "medret", "into")  # get peak intensity matrix (step 5)
dat <- rbind(group = as.character(phenoData(xsg)$class), dat)  # add group label
write.csv(dat, file='MyPeakTable.csv')  # save the data to CSV file

