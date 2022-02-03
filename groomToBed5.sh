#!/bin/bash
# JRA 2018

# this script converts bigwig, bedgraph or bed files to "bed5" format
# which is simply: 
# chr	start	end	name	score
# this is my special little format used by bamCoverage_simplified.sh


# Check the number of command line arguments
if [ $# -ne 1 ]; then
	script_name=$(basename $0)
	echo "Usage: $script_name input_coverage_track"
	exit 1
fi


INPUT_FILE=$1
FILE=$(basename "$INPUT_FILE")
FILE="${FILE%.*}"

echo "converting $INPUT_FILE --> $FILE.bed5"
if [[ $INPUT_FILE == *.*raph ]] ; then
	awk -v name="$FILE" '{OFS="\t";FS="\t"}{print $1, $2, $3, name, $4}' "$INPUT_FILE" > "$FILE"_unsort.bed5

elif [[ $INPUT_FILE == *.bed ]] ; then
	awk -v name="$FILE" '{OFS="\t";FS="\t"}{print $1, $2, $3, name, 1}' "$INPUT_FILE" > "$FILE"_unsort.bed5

elif [[ $INPUT_FILE == *.bw ]] ; then
	bigWigToBedGraph "$INPUT_FILE" "$FILE".bedGraph
	awk -v name="$FILE" '{OFS="\t";FS="\t"}{print $1, $2, $3, name, $4}' "$FILE".bedGraph > "$FILE"_unsort.bed5
	rm "$FILE".bedGraph

elif [[ $INPUT_FILE == *.bed5 ]] ; then
	echo "file $INPUT_FILE already in bed5 format, sorting just in-case!"
	mv $INPUT_FILE "$FILE"_unsort.bed5

else
	echo "file $INPUT_FILE format not recognized"
fi

sort-bed "$FILE"_unsort.bed5 > "$FILE".bed5
rm "$FILE"_unsort.bed5
echo "the bed5 table should have columns:"
echo "#chr	start	end	name	score"
echo "your file has columns:"
head -n 3 "$FILE".bed5

echo "$(basename $0) done!"
echo ""
echo ""
