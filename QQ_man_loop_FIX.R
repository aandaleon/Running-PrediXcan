#(very) slightly edited script from https://github.com/dbaghdan/Lung-Breast-Cancer-Association/blob/master/R-Code/Plot%20Loop.R
library(dplyr)
library(ggplot2)
library(tidyr)
source("/home/angela/px_yri_chol/GWAS/qqman.r")
"%&%" = function(a,b) paste(a,b,sep="")

Chrome=read.table("/home/angela/px_yri_chol/PrediXcan/ChrENGene.txt")
colnames(Chrome)<-c('CHR','gene','gene_name')
Chrome<-transform(Chrome, CHR=as.numeric(CHR))
pheno_names <- read.table('/home/angela/px_yri_chol/GWAS/Phenotypes/pheno_names.txt')
pheno_names <- pheno_names$V1
database_tissues <- read.table("/home/angela/px_yri_chol/PrediXcan/database_tissues.txt")
database_tissues <- database_tissues$V1
for(y in pheno_names)
for(x in database_tissues){
  s1="/home/angela/px_yri_chol/PrediXcan/MichImpOutput/PX_output/"
  s2=x
  s3=y
  s4="/association.txt"
  path=paste(s1,s2,"/",s3,s4,sep="")
  Tiss=read.table(path,header=T)
  Tissu=na.omit(Tiss)
  Tissue<-left_join(Tissu,Chrome, by='gene')
  s1="/home/angela/px_yri_chol/PrediXcan/MichImpOutput/PX_output/"
  s4="_qqplot.jpg"
  path=paste(s1,s2,"/",s3,s4,sep="")
  jpeg(file = path)
  qq(Tissue$p, main='QQplot of ' %&% y %&% ', ' %&% x %&% '', psh=18)
  dev.off()
  s4="_manplot.jpg"
  path=paste(s1,s2,"/",s3,s4,sep="")
  jpeg(filename = path)
  print(ggplot(Tissue, aes(x=CHR, y=-log10(p),color=CHR)) +geom_point(aes(size = 10,)) + geom_text(aes(label=ifelse(-log10(p)>4.7,as.character(gene_name),'')),hjust= 1.2, vjust=0) + ggtitle('Manhattan Plot of ' %&% y %&% ', ' %&% x %&% '') + xlab("Chromosome") + ylab("-log10(p)") + theme_set(theme_gray(base_size = 18))+ theme(legend.position="none") + scale_x_continuous(breaks=seq(1,25,1)))
  dev.off()
}
