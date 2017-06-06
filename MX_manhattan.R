#creates a manhattan for MetaXcan results
"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
library(readr)

source("~/px_yri_chol/GWAS/qqman.r")
CNGB1 <- read_csv("~/MetaXcan-master/GEMMA_YRI/TW_Brain_Hippocampus_0.5.db/HDL_log.csv")
BP_Chrome <- read.table("/home/angela/px_yri_chol/PrediXcan/BP_Chrome.txt", header = T)
BP_Chrome <- transform(BP_Chrome, CHR=as.numeric(CHR))
BP_Chrome <- transform(BP_Chrome, BP=as.numeric(BP))
BP_Chrome$gene <- gsub("\\..*","",BP_Chrome$gene)
CNGB1 <- na.omit(CNGB1)
CNGB1 <- left_join(CNGB1,BP_Chrome, by='gene')
threshold <- -log10(0.05/dim(CNGB1)[1])
names(CNGB1)[names(CNGB1) == 'pvalue'] <- 'P'
manhattan(CNGB1, suggestiveline = 0, genomewideline = threshold)
