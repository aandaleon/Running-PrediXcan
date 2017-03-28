#makes supertables of SNPs effect sizes across the two Yoruba and the Cebu SNPs post-imputation for export to Excel
library(data.table)
library(dplyr)

YRI_M_CHOL_log <- fread('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/CHOL_log.assoc.dosage', header = T)
YRI_M_HDL_log <- fread('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/HDL_log.assoc.dosage', header = T)
YRI_M_LDL_log <- fread('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/LDL_log.assoc.dosage', header = T)
YRI_M_TRIG_log <- fread('/home/angela/px_yri_chol/PrediXcan/MichImpOutput/GWAS/TRIG_log.assoc.dosage', header = T)

YRI_S_CHOL_log <- fread('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/GWAS/CHOL_log.assoc.dosage', header = T)
YRI_S_HDL_log <- fread('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/GWAS/HDL_log.assoc.dosage', header = T)
YRI_S_LDL_log <- fread('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/GWAS/LDL_log.assoc.dosage', header = T)
YRI_S_TRIG_log <- fread('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/GWAS/TRIG_log.assoc.dosage', header = T)

CEBU_CHOL_log <- fread('/home/angela/px_cebu_chol/PrediXcan/GWAS/log_CHOL.assoc.dosage', header = T)
CEBU_HDL_log <- fread('/home/angela/px_cebu_chol/PrediXcan/GWAS/log_HDL.assoc.dosage', header = T)
CEBU_LDL_log <- fread('/home/angela/px_cebu_chol/PrediXcan/GWAS/log_LDL.assoc.dosage', header = T)
CEBU_TRIG_log <- fread('/home/angela/px_cebu_chol/PrediXcan/GWAS/log_TRIG.assoc.dosage', header = T)

GLGC_CHOL <- fread('/home/angela/compare/jointGwasMc_TC.txt', header = T)
GLGC_HDL <- fread('/home/angela/compare/jointGwasMc_HDL.txt', header = T)
GLGC_LDL <- fread('/home/angela/compare/jointGwasMc_LDL.txt', header = T)
GLGC_TRIG <- fread('/home/angela/compare/jointGwasMc_TG.txt', header = T)

YRI_M_CHOL_log$PHENO <- "CHOL_log"
supertable <- YRI_M_CHOL_log
YRI_S_CHOL_log$PHENO <- "CHOL_log"
supertable <- full_join(supertable, YRI_S_CHOL_log, by="A1")
CEBU_CHOL_log$PHENO <- "CHOL_log"
supertable <- full_join(supertable, CEBU_CHOL_log, by="A1")
supertable <- rename(supertable, c("A1" = "rsid"))
GLGC_CHOL$PHENO <- "CHOL"
supertable <- full_join(supertable, GLGC_CHOL, by="rsid")
pruned_supertable_CHOL <- subset(supertable, P.x <= 1e-04 | P.y <= 1e-04 | P <= 1e-04)
write.csv(supertable, file = '/home/angela/compare/supertable/CHOL.csv', quote = F)
write.csv(pruned_supertable_CHOL, file = '/home/angela/compare/supertable/CHOL_pruned.csv', quote = F)

YRI_M_HDL_log$PHENO <- "HDL_log"
supertable <- YRI_M_HDL_log
YRI_S_HDL_log$PHENO <- "HDL_log"
supertable <- full_join(supertable, YRI_S_HDL_log, by="A1")
CEBU_HDL_log$PHENO <- "HDL_log"
supertable <- full_join(supertable, CEBU_HDL_log, by="A1")
supertable <- rename(supertable, c("A1" = "rsid"))
GLGC_HDL$PHENO <- "HDL"
supertable <- full_join(supertable, GLGC_HDL, by="rsid")
pruned_supertable_HDL <- subset(supertable, P.x <= 1e-04 | P.y <= 1e-04 | P <= 1e-04)
write.csv(supertable, file = '/home/angela/compare/supertable/HDL.csv', quote = F)
write.csv(pruned_supertable_HDL, file = '/home/angela/compare/supertable/HDL_pruned.csv', quote = F)

YRI_M_LDL_log$PHENO <- "LDL_log"
supertable <- YRI_M_LDL_log
YRI_S_LDL_log$PHENO <- "LDL_log"
supertable <- full_join(supertable, YRI_S_LDL_log, by="A1")
CEBU_LDL_log$PHENO <- "LDL_log"
supertable <- full_join(supertable, CEBU_LDL_log, by="A1")
supertable <- rename(supertable, c("A1" = "rsid"))
GLGC_LDL$PHENO <- "LDL"
supertable <- full_join(supertable, GLGC_LDL, by="rsid")
pruned_supertable_LDL <- subset(supertable, P.x <= 1e-04 | P.y <= 1e-04 | P <= 1e-04)
write.csv(supertable, file = '/home/angela/compare/supertable/LDL.csv', quote = F)
write.csv(pruned_supertable_LDL, file = '/home/angela/compare/supertable/LDL_pruned.csv', quote = F)

YRI_M_TRIG_log$PHENO <- "TRIG_log"
supertable <- YRI_M_TRIG_log
YRI_S_TRIG_log$PHENO <- "TRIG_log"
supertable <- full_join(supertable, YRI_S_TRIG_log, by="A1")
CEBU_TRIG_log$PHENO <- "TRIG_log"
supertable <- full_join(supertable, CEBU_TRIG_log, by="A1")
supertable <- rename(supertable, c("A1" = "rsid"))
GLGC_TRIG$PHENO <- "TRIG"
supertable <- full_join(supertable, GLGC_TRIG, by="rsid")
pruned_supertable_TRIG <- subset(supertable, P.x <= 1e-04 | P.y <= 1e-04 | P <= 1e-04)
write.csv(supertable, file = '/home/angela/compare/supertable/TRIG.csv', quote = F)
write.csv(pruned_supertable_TRIG, file = '/home/angela/compare/supertable/TRIG_pruned.csv', quote = F)
