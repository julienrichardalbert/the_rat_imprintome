computeMatrix scale-regions \
  -R rn6_NCBI_oocyte_RPKM_oocyte_RPKM_atleast_1 rn6_NCBI_oocyte_RPKM_oocyte_RPKM_under_1 \
  -S ./bigWigs/rep_merge/rat_GVO_H3K4me3_CnR_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  ./bigWigs/rep_merge/rat_GVO_H3K27me3_CnR_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  ./bigWigs/rep_merge/rat_GVO_H3K36me3_CnR_rep1-2_rmDup_q10_b1_s0_CPM.bw \
  ./bigWigs/rep_merge/rat_MII_oocyte_PBAT_BrindAmour2018_rep1-4_x5.bw \
  -b 5000 \
  -a 5000 \
  --regionBodyLength 5000 \
  -o rn6_by_oocyte_RPKM.gz \
  --skipZeros \
  --binSize 100 \
  --numberOfProcessors 8


plotHeatmap  \
  -m rn6_by_oocyte_RPKM.gz \
  --colorMap Purples \
  --missingDataColor "#FFF6EB"  \
  --heatmapHeight 15 \
  --heatmapWidth 10  \
  --yMin 0 0 0 0 \
  --zMin 0 0 0 0  \
  --yMax 0.2 0.1 0.2 100  \
  --zMax 0.2 0.1 0.2 100  \
  --interpolationMethod nearest \
  --outFileName rn6_by_oocyte_RPKM.pdf



plotHeatmap    -m rn6_by_oocyte_RPKM.gz   --colorMap Purples   --missingDataColor "#FFF6EB"    --heatmapHeight 15   --heatmapWidth 10    --yMin 0 0 0 0   --zMin 0 0 0 0    --yMax 0.2 0.1 0.12 100    --zMax 0.2 0.1 0.12 100    --interpolationMethod nearest   --outFileName rn6_by_oocyte_RPKM.pdf

