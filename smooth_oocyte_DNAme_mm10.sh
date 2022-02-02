~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed count
~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed mean
~/bin/bedmapCoverage.sh BB_GVO_Shirane2013_total_methylation_x5.bed5 mm10_50w_1000s.bed echo-map-range
awk '{OFS="\t";FS="\t"} { if ($4>=5 && $6>=300 && $3-$2>950) print $1, $2+475, $3-475, $5}' mm10_50w_1000s.bed > tmp
bedGraphToBigWig tmp ~/sra2bw/reference_genomes/mm10/mm10.sizes tmp.bw

