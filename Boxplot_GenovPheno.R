#makes boxplots for genotype dosages vs phenotype
"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
library(readr)

sigSNP <- read.table('/home/angela/px_yri_chol/GEMMA/sigSNP.txt', sep = ",")
sigSNP <- t(sigSNP)
write.table(sigSNP, '/home/angela/px_yri_chol/GEMMA/sigSNP.txt', col.names = F, row.names = F, quote = F)
sigSNP <- read.table('/home/angela/px_yri_chol/GEMMA/sigSNP.txt', header = T)
sigSNP <- sigSNP[-c(1, 2),]
phenoYRIwoIID2 <- read.table('/home/angela/px_yri_chol/GEMMA/phenoYRIwIID2.txt', header = T)
dosage <- cbind(phenoYRIwoIID2, sigSNP)
dosage$rs172315 <- as.character(dosage$rs172315)
dosage$rs172315 <- as.numeric(dosage$rs172315)
dosage$rs58861508 <- as.character(dosage$rs58861508)
dosage$rs58861508 <- as.numeric(dosage$rs58861508)
dosage$rs145792537 <- as.character(dosage$rs145792537)
dosage$rs145792537 <- as.numeric(dosage$rs145792537)
dosage$rs34065661 <- as.character(dosage$rs34065661)
dosage$rs34065661 <- as.numeric(dosage$rs34065661)
dosage$rs7412 <- as.character(dosage$rs7412)
dosage$rs7412 <- as.numeric(dosage$rs7412)
dosage$rs1065853 <- as.character(dosage$rs1065853)
dosage$rs1065853 <- as.numeric(dosage$rs1065853)
dosage2 <- dosage
dosage2$rs172315 <- round(dosage$rs172315)
dosage2$rs34065661 <- round(dosage$rs34065661)
boxplot(dosage2$HDL_rank~dosage2$rs34065661, ylab = "HDL ranked", xlab = "rs34065661 genotype")

