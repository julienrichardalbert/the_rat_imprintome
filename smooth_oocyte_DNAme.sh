# smooths 1bp methylation data into 50bp windows smoothed over 1kb. 
# Used for heatmaps displaying the distribution of DNAme levels over promoters in oocytes.

# this script calculates the number of CpG dinucleotides, mean methylation and range of covered CpGs over 1kb windows
# filters for  1kb windows covered  by at least 5 CpGs over a span of 300 bp
# reports the average methylation level for each 50bp step over an average of 1kb 

# rat
~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50w_1000s.bed count
~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50w_1000s.bed mean
~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50w_1000s.bed echo-map-range
awk '{OFS="\t";FS="\t"} { if ($4>=5 && $6>=300 && $3-$2>950) print $1, $2+475, $3-475, $5}' rn6_50w_1000s.bed > tmp
bedGraphToBigWig tmp ~/sra2bw/reference_genomes/rn6/rn6.sizes rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5_50w_1000s.bw

# mouse
~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed count
~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed mean
~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed echo-map-range
awk '{OFS="\t";FS="\t"} { if ($4>=5 && $6>=300 && $3-$2>950) print $1, $2+475, $3-475, $5}' mm10_50w_1000s.bed > tmp
bedGraphToBigWig tmp ~/sra2bw/reference_genomes/mm10/mm10.sizes BB_GVO_Shirane2013_total_methylation_x5_50w_1000s.bw

# methylation bigwigs were first converted to bed5 using the groomToBed5.sh script included in this repository
# bedmapCoverage.sh is anothercustom script included in this repository
