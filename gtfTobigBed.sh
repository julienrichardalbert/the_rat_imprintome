#!/bin/bash
# JRA 2020
# Simplified from Aaron 2019-07-06

source ~/bin/bin.config

# Check the number of command line arguments
if [ $# -ne 2 ]; then
        script_name=$(basename $0)
        echo "Usage: $script_name file.gtf chrom.sizes"
        exit 1
fi

INFILE=$1
CHROM_SIZES=$2
OUTFILE=${INFILE//.gtf/.bb}

printProgress "gtfTobigBed has begun on file $1"
printProgress "Converting GTF to genePred format"
gtfToGenePred $INFILE temp.genePred

printProgress "Converting genePred to bed format"
genePredToBed temp.genePred temp.bed12
sort -k1,1 -k2,2n temp.bed12 > temp.sort.bed12
bedClip temp.sort.bed12 $CHROM_SIZES temp.sort.clip.bed12
bedToBigBed temp.sort.clip.bed12 $CHROM_SIZES $OUTFILE

checkFileExists $OUTFILE
rm temp.genePred temp.bed12 temp.sort.bed12 temp.sort.clip.bed12
printProgress "gtfTobigBed on file $1 complete"

####################
#OLD script by Aaron
#! /bin/bash

# Utilty to convert .gtf files to .bb
# Made by Aaron
# Last updated 2019-07-26
# First argument: GTF File
# Second argument: relevant chrom.sizes file

#gtfToGenePred -genePredExt $1 temp.genePred
#genePredToBigGenePred temp.genePred stdout | sort -k1,1 -k2,2n > temp.txt
#bedClip temp.txt $2 temp2.txt
#bedToBigBed -type=bed12+8 -tab -as=/Users/JRA/bin/reference_genomes/mm10/bigGenePred.as temp2.txt $2 ${1//.gtf/.bb}
#rm temp.genePred
#rm temp.txt
#rm temp2.txt
