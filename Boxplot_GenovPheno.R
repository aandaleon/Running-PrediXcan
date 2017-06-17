#makes boxplots for genotype dosages vs phenotype

sigSNP <- read.table('/home/angela/px_yri_chol/GEMMA/sigSNP.txt', sep = ",") #extracted rows w/ wanted sigSNPs using grep
sigSNP <- t(sigSNP) #switches columns and rows
sigSNP <- sigSNP[-c(1, 2),] #removes first two rows
phenoYRIwIID2 <- read.table('/home/angela/px_yri_chol/GEMMA/phenoYRIwIID2.txt', header = T)
dosage <- cbind(phenoYRIwIID2, sigSNP)
dosage$rs34065661 <- as.character(dosage$rs34065661)
dosage$rs34065661 <- as.numeric(dosage$rs34065661)
dosage$rs1065853 <- as.character(dosage$rs1065853)
dosage$rs1065853 <- as.numeric(dosage$rs1065853)
dosage$rs34065661 <- round(dosage$rs34065661) #rounds genotypes to 0, 1, or 2 to condense number of plots
dosage$rs1065853 <- round(dosage$rs1065853)
boxplot(dosage$HDL_rank~dosage$rs34065661, ylab = "HDL rank normalized", xlab = "rs34065661 genotype")
