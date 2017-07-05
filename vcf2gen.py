#converts from filtered vcf to genotype for PLINK
import gzip
import re
import string

infile = '/home/angela/px_cebu_chol/Imputation/Mich/convert2genotype/test.vcf'
genotype = ''

for gen in open(infile):
  g=gen.strip().split()
  rest = g
  rest=str(rest)
  if '0|0' in rest:
    new_rst1=string.replace(rest, '0|0', '1 0 0')
    genotype = genotype + new_rst1
  elif '1|0' in rest:
    new_rst2=string.replace(rest, '1|0', '0 1 0')
    genotype = genotype + new_rst2
  elif '0|1' in rest:
    new_rst3=string.replace(rest, '0|1', '0 1 0')
    genotype = genotype + new_rst3
  elif '1|1' in rest:
    new_rst4=string.replace(rest, '1|1', '0 0 1')
    genotype = genotype + new_rst4
  else:
    genotype = genotype + '\n'+ rest[:5]

genotype = genotype.replace("'", '')
genotype = genotype.replace(",", '')
genotype = genotype.replace("]", '')
genotype = genotype.replace("[", '\n')

outfile = open('/home/angela/px_cebu_chol/Imputation/Mich/convert2genotype/test.gen', 'w')
outfile.write(genotype[1:])
outfile.close()
