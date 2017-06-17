#creates a manhattan for MetaXcan results
"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
library(readr)

source("~/px_yri_chol/GWAS/qqman.r")
sigGene <- read_csv("~/MetaXcan-master/GEMMA_YRI/TW_Brain_Hippocampus_0.5.db/HDL_rank.csv") #path to tissue/pheno combo w/ sig. gene
BP_Chrome <- read.table("/home/angela/px_yri_chol/PrediXcan/BP_Chrome.txt", header = T) #list that has columns of chromosomes, base pair starting positions, ESNG ids, and gene names
BP_Chrome <- transform(BP_Chrome, CHR=as.numeric(CHR))
BP_Chrome <- transform(BP_Chrome, BP=as.numeric(BP))
BP_Chrome$gene <- gsub("\\..*","",BP_Chrome$gene) #removes all characters including and past "." so it matches w/ MX results 
sigGene <- na.omit(sigGene)
sigGene <- left_join(sigGene,BP_Chrome, by='gene')
threshold <- -log10(0.05/dim(sigGene)[1]) #Bonferroni correction. May change
names(sigGene)[names(sigGene) == 'pvalue'] <- 'P'
manhattan(sigGene, suggestiveline = 0, genomewideline = threshold)
qq(sigGene$P)
