#creates SNP annotation file out of dosage files
"%&%" = function(a,b) paste(a,b,sep="")
for(i in 1:22){
  dosage <- "/home/angela/px_yri_chol/wRelateds/ImputedwRelateds/Sanger_dosages/chr" %&% i %&% ".maf0.01.info0.8.dosage.txt.gz"
  getDosage <- read.table(dosage)
  getDosage$V1 <- i
  keepAnno <- getDosage[,c("V2", "V3", "V1")]
  keepAnnoPath <- "/home/angela/px_yri_chol/GEMMA/anno" %&% i %&% ".txt"
  write.table(keepAnno, keepAnnoPath, row.names = F, quote = F, col.names = F)
}