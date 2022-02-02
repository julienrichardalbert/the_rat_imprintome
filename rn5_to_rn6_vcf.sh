808030  20190918-11:14:01 grep -e "#" F334_INDELs_rn5_4.1.vcf > INDELs_header_rn5
808031  20190918-11:14:11 grep -e "#" F334_SNPs_rn5_4.1.vcf > SNPs_header_rn5
808035  20190918-11:15:58 grep -v "#" F334_INDELs_rn5_4.1.vcf | awk '{OFS="\t";FS="\t"}{print "chr"$0}' - | cat INDELs_header_rn5 - > F334_INDELs_rn5_4.1_chr.vcf 
808036  20190918-11:16:37 grep -v "#" F334_SNPs_rn5_4.1.vcf | awk '{OFS="\t";FS="\t"}{print "chr"$0}' - | cat SNPs_header_rn5 - > F334_SNPs_rn5_4.1_chr.vcf 
808037  20190918-11:18:10 java -jar -Xms4G -Xmx6G ~/bin/picard/build/libs/picard.jar LiftoverVcf I=F334_INDELs_rn5_4.1_chr.vcf O=F334_INDELs_rn6_4.1.vcf  CHAIN=rn5ToRn6.over.chain.gz REJECT=trash.vcf R=rn6.fa

