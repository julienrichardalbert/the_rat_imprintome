# history of converting variant call file (VCF) coordinates from rn5 to rn6
# rn5-based VCF files  were taken from:
# Atanur, Santosh S, et al. (2013), ‘Genome sequencing reveals loci under artificial selection that underlie disease phenotypes in the laboratory rat.’, Cell, 154 (3), 691-703.
# and
# Hermsen, Roel, et al. (2015), ‘Genomic landscape of rat strain and substrain variation.’, BMC Genomics, 16 (1), 357.

# uses PicardTools and the "rn5torn6" chain file found here:
# https://hgdownload.soe.ucsc.edu/goldenPath/rn5/database/


grep -e "#" F334_INDELs_rn5_4.1.vcf > INDELs_header_rn5
grep -e "#" F334_SNPs_rn5_4.1.vcf > SNPs_header_rn5
grep -v "#" F334_INDELs_rn5_4.1.vcf | awk '{OFS="\t";FS="\t"}{print "chr"$0}' - | cat INDELs_header_rn5 - > F334_INDELs_rn5_4.1_chr.vcf 
grep -v "#" F334_SNPs_rn5_4.1.vcf | awk '{OFS="\t";FS="\t"}{print "chr"$0}' - | cat SNPs_header_rn5 - > F334_SNPs_rn5_4.1_chr.vcf 
java -jar -Xms4G -Xmx6G ~/bin/picard/build/libs/picard.jar LiftoverVcf I=F334_INDELs_rn5_4.1_chr.vcf O=F334_INDELs_rn6_4.1.vcf  CHAIN=rn5ToRn6.over.chain.gz REJECT=trash.vcf R=rn6.fa

