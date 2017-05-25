#Plots a cholestrol trait against gene expression, with overlapping populations
"%&%" = function(a,b) paste(a,b,sep="")
library(data.table)
library(ggplot2)
library(dplyr)

xYRI <- fread('/home/angela/px_yri_chol/GWAS/Phenotypes/data.txt', header = T)
yYRI <- fread('/home/angela/px_yri_chol/PrediXcan/SangerImpOutput/PX_output/TW_Vagina_0.5.db/predicted_expression.txt', header = T)
xCebu <- fread('/home/angela/px_cebu_chol/GWAS/new_pheno.txt', header = T)
yCebu <- fread('/home/angela/px_cebu_chol/PrediXcan/TW_Vagina_0.5.db/predicted_expression.txt', header = T)

xyYRI <- inner_join(xYRI, yYRI, by = "IID")
xyCebu <- inner_join(xCebu, yCebu, by = "IID")
xy <- rbind(xyYRI, xyCebu)
ggplot(xyYRI, aes(x = ENSG00000162631.14, y = TRIG_log)) + 
  geom_jitter(size = 0.75, color = "purple") + 
  stat_smooth(method="lm", se = FALSE, color = "purple", fullrange = TRUE) + 
  geom_jitter(data = xyCebu, aes(x = ENSG00000162631.14, y = TRIG_log), size = 0.75, color = "dark green") + 
  geom_smooth(data = xyCebu, method="lm", se = FALSE, color = "dark green", fullrange = TRUE) + 
  scale_x_continuous(name = "Predicted gene expression") + 
  scale_y_continuous(name = "log(TRIG) (mg/dL)") + 
  ggtitle("NTNG1 in VAGINA") + 
  theme(plot.title = element_text(hjust = 0.5))