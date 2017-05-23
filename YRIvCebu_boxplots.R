#goal: make boxplots for a tissue and a gene, with adjacent "YRI" and "Cebu"
"%&%" = function(a,b) paste(a,b,sep="")
#genes <- read.table('/home/angela/compare/chr_bp_gene.txt')
#genes <- genes$V3
#database_tissues <- read.table("/home/angela/px_yri_chol/PrediXcan/database_tissues.txt")
#database_tissues <- database_tissues$V1
library(dplyr)
library(ggplot2)
genes <- "ENSG00000186318.12"
database_tissues <- "TW_Esophagus_Mucosa_0.5.db"

x <- read.table("/home/angela/px_cebu_chol/PrediXcan/" %&% database_tissues %&% "/predicted_expression.txt",header=T)
keep <- c("IID", genes)
x <- x[keep]
x <- transform(x, IID=as.character(IID))
phenoCebu <- read.table("/home/angela/px_cebu_chol/GWAS/new_pheno.txt",header=T)
phenoCebu <- transform(phenoCebu, IID=as.character(IID))
x=left_join(x,phenoCebu,by='IID')
x=na.omit(x)
colnames(x)[2] <- "gene"

y <- read.table("/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/" %&% database_tissues %&% "/predicted_expression.txt",header=T)
y <- y[keep]
y <- transform(y, IID=as.character(IID))
phenoYRI <- read.table("/home/angela/px_yri_chol/GWAS/Phenotypes/prunedPheno.txt", header = T)
phenoYRI <- transform(phenoYRI, IID=as.character(IID))
y <- left_join(y, phenoYRI, by = "IID")
y <- na.omit(y)
colnames(y)[2] <- "gene"

png(file = "/home/angela/compare/boxplots/" %&% database_tissues %&% "/CHOL_log." %&% genes %&% ".png")
boxplot(x$gene, y$gene, ylim = range(x$gene, y$gene), names = c("Cebu", "YRI"), main = genes, xlab = "Population", ylab = "log(mg/dL)")
dev.off()