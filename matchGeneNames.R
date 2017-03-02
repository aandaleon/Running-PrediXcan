#matches ESNG codes to common gene names in association.txt files
library(ggplot2)
library(tidyr)
library(dplyr)
"%&%" = function(a,b) paste(a,b,sep="")

database_tissues <- read.table("/home/angela/px_yri_chol/PrediXcan/database_tissues.txt")
database_tissues <- database_tissues$V1
pheno_names <- read.table('/home/angela/px_yri_chol/GWAS/Phenotypes/pheno_names.txt')
pheno_names <- pheno_names$V1

for(i in database_tissues){
for(j in pheno_names){
name_gene <- read.table('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/' %&% i %&% '/' %&% j %&% '/association.txt', header = T)
ChrENGene <- read.table('/home/angela/px_yri_chol/PrediXcan/ChrENGene_forRenaming.txt', header = T)
addGeneName <- subset(ChrENGene, gene %in% name_gene$gene)
name_gene <- left_join(name_gene, addGeneName, by = 'gene')
write.table(name_gene, '/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/' %&% i %&% '/' %&% j %&% '/association.txt', row.names = F, quote = F)
}
}
