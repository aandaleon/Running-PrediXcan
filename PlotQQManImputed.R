#Creates a manhattan and QQ for imputed genotypes
source("/home/angela/px_yri_chol/GWAS/qqman.r")

CHOL_log <- read.table('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/CHOL.assoc.dosage', header = T)
HDL <- read.table('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/HDL.assoc.dosage', header = T)
TRIG_log <- read.table('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/TRIG_log.assoc.dosage', header = T)
LDL <- read.table('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/LDL.assoc.dosage', header = T)

CHOL_log_0.01 <- subset(CHOL_log, CHOL_log$P <= 0.01)
HDL_log_0.01 <- subset(HDL, HDL$P <= 0.01)
LDL_log_0.01 <- subset(LDL, LDL$P <= 0.01)
TRIG_log_0.01 <- subset(TRIG_log, TRIG_log$P <= 0.01)

#replace x w/ phenotype_0.01
x <- LDL_log_0.01
x <- rename(x, c("SNP" = "CHR", "A2" = "BP"))
x$CHR <- as.character(x$CHR)
x$CHR[x$CHR == 'chr1'] <- '1'
x$CHR[x$CHR == 'chr2'] <- '2'
x$CHR[x$CHR == 'chr3'] <- '3'
x$CHR[x$CHR == 'chr4'] <- '4'
x$CHR[x$CHR == 'chr5'] <- '5'
x$CHR[x$CHR == 'chr6'] <- '6'
x$CHR[x$CHR == 'chr7'] <- '7'
x$CHR[x$CHR == 'chr8'] <- '8'
x$CHR[x$CHR == 'chr9'] <- '9'
x$CHR[x$CHR == 'chr10'] <- '10'
x$CHR[x$CHR == 'chr11'] <- '11'
x$CHR[x$CHR == 'chr12'] <- '12'
x$CHR[x$CHR == 'chr13'] <- '13'
x$CHR[x$CHR == 'chr14'] <- '14'
x$CHR[x$CHR == 'chr15'] <- '15'
x$CHR[x$CHR == 'chr16'] <- '16'
x$CHR[x$CHR == 'chr17'] <- '17'
x$CHR[x$CHR == 'chr18'] <- '18'
x$CHR[x$CHR == 'chr19'] <- '19'
x$CHR[x$CHR == 'chr20'] <- '20'
x$CHR[x$CHR == 'chr21'] <- '21'
x$CHR[x$CHR == 'chr22'] <- '22'
x$CHR <- as.numeric(x$CHR)
manhattan(x)

#replace y w/ a phenotype
y <- LDL
ind <- seq(1, nrow(y), by = 25)
cut_y <- y[ind,]
y_e7 <- subset(y, P < 10^-7)
y_qq <- rbind(y_e7, cut_y)
qq(y_qq$P)
#plots every 25th SNP and all SNPs w/ P < 10^-7
