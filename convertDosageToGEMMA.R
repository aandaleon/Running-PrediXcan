#so this might work
#jk "Cannot allocate memory"
#also jk it's totally unnecessary
"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
for(i in 1:22){
  path <- "/home/angela/px_cebu_chol/wRelateds/Sanger/Sanger_dosages/chr" %&% i %&% ".maf0.01.info0.8.dosage.txt.gz"
  genotype <- read.table(path)
  genotype$V1 <- NULL
  genotype$V3 <- NULL
  genotype$V6 <- NULL
  filename <- "/home/angela/px_cebu_chol/GEMMA/chr" %&% i %&% ".txt"
  fwrite(genotype, file = filename, row.names = F, quote = F, col.names = F)
  gzip <- "gzip /home/angela/px_cebu_chol/GEMMA/chr" %&% i %&% ".txt"
  system(gzip)
}

