"%&%" = function(a,b) paste(a,b,sep="")
database_tissues <- read.table("/home/angela/px_yri_chol/PrediXcan/database_tissues.txt")
database_tissues <- database_tissues$V1
pheno_names <- read.table('/home/angela/px_yri_chol/GWAS/Phenotypes/pheno_names.txt')
pheno_names <- pheno_names$V1
for(h in database_tissues){
  PrediXcan_predict <- "PrediXcan.py --predict --dosages /home/angela/px_yri_chol/PrediXcan/SangerImpOutput/Sanger_dosages/ --samples /home/angela/px_yri_chol/PrediXcan/SangerImpOutput/Sanger_dosages/samples.txt --weights /home/wheelerlab1/Data/PrediXcan_db/GTEx-V6p-HapMap-2016-09-08/"%&% h %&%" --output_dir /home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/"%&% h %&%"/"
  system(PrediXcan_predict)
}
for(i in database_tissues){
for(j in pheno_names){
  PrediXcan_association <- "PrediXcan.py --assoc --pheno /home/angela/px_yri_chol/GWAS/Phenotypes/prunedPheno.txt --pheno_name " %&% j %&% " --pred_exp /home/angela/px_yri_chol/PrediXcan/SangerImpOutput/Sanger_dosages/PX_output/"%&% i %&%"/predicted_expression.txt --linear --output_dir /home/angela/px_yri_chol/PrediXcan/SangerImpOutput/Sanger_dosages/PX_output/"%&% i %&%"/"%&% j %&%"/"
  system(PrediXcan_association)
}
}
