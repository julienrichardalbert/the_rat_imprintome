~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50s_1000w.bed count
~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50s_1000w.bed mean
~/bin/bedmapCoverage.sh rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bed5 rn6_50s_1000w.bed echo-map-range
awk '{OFS="\t";FS="\t"} { if ($4>=5 && $6>=300 && $3-$2>950) print $1, $2+475, $3-475, $5}' rn6_50w_1000s.bed > tmp
bedGraphToBigWig tmp ~/sra2bw/reference_genomes/rn6/rn6.sizes ${x//.bw/_50s_1000w.bw}

