#!/bin/bash
# JRA 2018

# this script converts variant-call files (VCF) that carry both SNV and INDEL information into bigwig format
# this was before I discovered bigBed files! 


# Check the number of command line arguments
if [ $# -ne 2 ]; then
	script_name=$(basename $0)
	echo "Usage: $script_name input_vcf chrom.sizes"
	exit 1
fi

# REQUIREMENTS
# bedtools, bedGraphToBigWig


# INPUT vcf and chromosome size (of reference genome) files
INPUT_FILE=$1
SIZES=$2


FILE=$(basename "$INPUT_FILE")
FILE="${FILE%.*}"



#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  C57BL_6NJ
grep -v "#" $FILE > vcf_tmp

# in the case of SNVs
awk '{OFS="\t";FS="\t"}{ if ( length ($4) == length ($5) ) print $1, $2, $2+1, "1"}' vcf_tmp | sort -k1,1 -k2,2n > vcf_tmp_SNVs.bedGraph
mv vcf_tmp_SNVs.bedGraph tmp
bedtools merge -i tmp -c 4 -o mean -d -1 > vcf_tmp_SNVs.bedGraph
rm tmp

# in the case of REF deletions
awk '{OFS="\t";FS="\t"}{ if ( length ($4) < length ($5) ) print $1, $2, $2-length($4)+length($5), "-1"}' vcf_tmp > vcf_tmp_deletions

# in the case of REF insertions
awk '{OFS="\t";FS="\t"}{ if ( length ($4) > length ($5) ) print $1, $2, $2+length($4)-length($5), "1"}' vcf_tmp > vcf_tmp_insertions


cat vcf_tmp_deletions vcf_tmp_insertions | sort -k1,1 -k2,2n > vcf_indels.bedGraph
mv vcf_indels.bedGraph tmp
bedtools merge -i tmp -c 4 -o mean -d -1 > vcf_indels.bedGraph
rm tmp


bedGraphToBigWig vcf_indels.bedGraph $SIZES "$FILE"_INDELs.bw
bedGraphToBigWig vcf_tmp_SNVs.bedGraph $SIZES "$FILE"_SNVs.bw

rm vcf_tmp_SNVs.bedGraph vcf_tmp_deletions vcf_tmp_insertions vcf_tmp vcf_indels.bedGraph
echo "Done"
echo ""
