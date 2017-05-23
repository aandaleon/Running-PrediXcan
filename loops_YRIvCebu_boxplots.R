#goal: make boxplots for a tissue and a gene, with adjacent "YRI" and "Cebu"
"%&%" = function(a,b) paste(a,b,sep="")
library(dplyr)
sigGenes <- read.table('/home/angela/compare/sigGenes.txt')
sigGenes <- sigGenes$V1
sigTiss <- read.table("/home/angela/compare/sigTiss.txt")
sigTiss <- sigTiss$V1

for(i in sigTiss){
  for(j in sigGenes){
    tryCatch({
      x <- read.table("/home/angela/px_cebu_chol/PrediXcan/" %&% i %&% "/predicted_expression.txt", header=T)
      keep <- c("IID", j)
      x <- x[keep]
      x <- transform(x, IID=as.character(IID))
      phenoCebu <- read.table("/home/angela/px_cebu_chol/GWAS/new_pheno.txt",header=T)
      phenoCebu <- transform(phenoCebu, IID=as.character(IID))
      x=left_join(x,phenoCebu,by='IID')
      x=na.omit(x)
      colnames(x)[2] <- "gene"

      y <- read.table("/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/" %&% i %&% "/predicted_expression.txt",header=T)
      y <- y[keep]
      y <- transform(y, IID=as.character(IID))
      phenoYRI <- read.table("/home/angela/px_yri_chol/GWAS/Phenotypes/prunedPheno.txt", header = T)
      phenoYRI <- transform(phenoYRI, IID=as.character(IID))
      y <- left_join(y, phenoYRI, by = "IID")
      y <- na.omit(y)
      colnames(y)[2] <- "gene"

      png(file = "/home/angela/compare/boxplots/" %&% i %&% "/" %&% j %&% ".png")
      title <- paste(j, "in", i)
      boxplot(x$gene, y$gene, ylim = range(x$gene, y$gene), names = c("Cebu", "YRI"), main = title, xlab = "Population", ylab = "Expression Level")
      dev.off()
    }, error = function(e){})
  }
}
