computeMatrix scale-regions \
  -R mm10_NCBI_oocyte_RPKM_atleast1 mm10_NCBI_oocyte_RPKM_under1 \
  -S \
  /Users/jra/Dropbox/rat_imprintome_working_data/working_data/deeptools/bigWigs/mouse/BB_MII_oocyte_H3K4me3_Zhang2016_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  /Users/jra/Dropbox/rat_imprintome_working_data/working_data/deeptools/bigWigs/mouse/BB_MII_oocyte_H3K27me3_Zheng2016_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  /Users/jra/Dropbox/rat_imprintome_working_data/working_data/deeptools/bigWigs/mouse/BB_MII_H3K36me3_Xu2019_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  /Users/jra/Dropbox/rat_imprintome_working_data/working_data/deeptools/bigWigs/mouse/BB_GVO_DNAme_Shirane2013.bw \
  -b 5000 \
  -a 5000 \
  --regionBodyLength 5000 \
  -o mouse_GVO_RPKM.gz \
  --skipZeros \
  --binSize 100 \
  --numberOfProcessors 8


plotHeatmap  \
  -m mouse_GVO_RPKM.gz \
  --colorMap Purples \
  --missingDataColor "#FFF6EB"  \
  --heatmapHeight 15 \
  --heatmapWidth 10  \
  --yMin 0 0 0 0 \
  --zMin 0 0 0 0  \
  --yMax 0.1 0.1 0.1 100  \
  --zMax 0.1 0.1 0.1 100  \
  --interpolationMethod nearest \
  --outFileName mouse_GVO_RPKM.pdf
