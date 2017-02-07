##Write script that reads the association.txt for all PrediXcan outputs and determines which are significant

"%&%" = function(a,b) paste(a,b,sep="")
database_tissues <- read.table("/home/angela/px_yri_chol/PrediXcan/database_tissues.txt")
database_tissues <- database_tissues$V1
pheno_names <- read.table('/home/angela/px_yri_chol/GWAS/Phenotypes/pheno_names.txt')
pheno_names <- pheno_names$V1
significant <- read.table('/home/angela/px_yri_chol/PrediXcan/significant_genes.txt', header = T)

for(i in database_tissues){
for(j in pheno_names){
  tissue <- read.table('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/PX_output/'%&% i %&%'/'%&% j %&%'/association.txt', header = T)
  tissue$tissue <- i
  tissue$pheno <- j
  threshold <- 0.05/dim(tissue)[1]
  tissue <- subset(tissue, p <= threshold)
  significant <- rbind(significant, tissue)
}
}
  
write.table(significant, '/home/angela/px_yri_chol/PrediXcan/significant_genes.txt', row.names = F, quote = F)