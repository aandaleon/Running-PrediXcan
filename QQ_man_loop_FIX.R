#Edited script from https://github.com/dbaghdan/Lung-Breast-Cancer-Association/blob/master/R-Code/Plot%20Loop.R
library(tidyr)
library(dplyr)
source("/px_yri_chol/GWAS/qqman.r")
"%&%" = function(a,b) paste(a,b,sep="")

BP_Chrome <- read.table("/px_yri_chol/PrediXcan/BP_Chrome.txt", header = T)
BP_Chrome <- transform(BP_Chrome, CHR=as.numeric(CHR))
BP_Chrome <- transform(BP_Chrome, BP=as.numeric(BP))
#Input file (association.txt) must come right from PrediXcan w/ no edits

pheno_names <- read.table('/px_cebu_chol/pheno_name.txt')
pheno_names <- pheno_names$V1
database_tissues <- read.table("/px_yri_chol/PrediXcan/database_tissues.txt")
database_tissues <- database_tissues$V1

for(y in database_tissues)
for(x in pheno_names){
  s1="/px_cebu_chol/PrediXcan/"
  s2=y
  s3=x
  s4="/association.txt"
  path=paste(s1,s2,"/",s3,s4,sep="")
  Tiss=read.table(path,header=T)
  Tissu=na.omit(Tiss)
  Tissue<-left_join(Tissu,BP_Chrome, by='gene')
  s1="/px_cebu_chol/PrediXcan/"
  s4="_qqplot.jpg"
  path=paste(s1,s2,"/",s3,s4,sep="")
  jpeg(file = path)
  qq(Tissue$p, main='QQplot of ' %&% y %&% ', ' %&% x %&% '', psh=18)
  dev.off()
  
  s4="/association.txt"
  path=paste(s1,s2,"/",s3,s4,sep="")
  Tiss=read.table(path, header=T)
  Tissu=na.omit(Tiss)
  Tissue<-left_join(Tissu, BP_Chrome, by = 'gene')
  colnames(Tissue)[colnames(Tissue) == 'p'] <- 'P'
  #If your association.txt already has gene names or such you're gonna have to finangle with this a bit
  
  s1="/px_cebu_chol/PrediXcan/"
  s4="_manplot.jpg"
  path=paste(s1,s2,"/",s3,s4,sep="")
  jpeg(file = path)
  Tissue <- transform(Tissue, CHR=as.numeric(CHR))
  threshold <- -log10(0.05/dim(Tiss)[1])
  manhattan(Tissue, suggestiveline = 0, genomewideline = threshold)
  ##NOTE: ADD GENE NAMES
  
  dev.off()
}
