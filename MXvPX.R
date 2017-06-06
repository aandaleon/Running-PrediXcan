"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
library(readr)

#creates a plot of -log10(p-values) for MetaXcan and PrediXcan results
MX <- fread('/home/angela/MetaXcan-master/GEMMA_YRI/TW_Adipose_Subcutaneous_0.5.db/CHOL_log.csv', header = T)
PX <- fread('/home/angela/px_yri_chol/wRelateds/ImputedwRelateds/TW_Adipose_Subcutaneous_0.5.db/CHOL_log_association.txt', header = T)
PX$gene <- gsub("\\..*","",PX$gene)
MXPX <- inner_join(MX, PX, by = "gene")
PX_p <- -log10(MXPX$p)
MX_p <- -log10(MXPX$pvalue)
plot(PX_p, MX_p)