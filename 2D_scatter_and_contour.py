# make beautiful scatterplots using a combination of matplot (2D scatter) and seaborn (contour plot)
# input file is a tab-delimited table of DNAme and RPKM data
# change the "subset_count" variable to display a specified number of dots.
# 10000 dots was a healthy number for my laptop

import sys
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
from matplotlib import rc
import seaborn as sns

matplotlib.rcParams['svg.fonttype'] = 'none'  # saves fonts as a text object instead of a vector path
plt.rcParams['font.size'] = 8

userInputFile   = sys.argv[1]
inputFile       = pd.read_csv(userInputFile, sep='\t')

x = 'DNAme_delta_rat-mouse'
y = 'H3K27me3_delta_rat-mouse'
z = 'H3K36me3_delta_rat-mouse'
RPKM_MAX = 4          # Determine what is the best max in your dataset
subset_count = 10000  # JRA arbitrarily set this to 10K. Illustrator can edit 10K points fine on his 16'MBP2020


df = inputFile[[x, y, z]]                                                            # Only take columns to plot
df_no_NaN    = df.dropna(how='any')
# df_filtered  = df_no_NaN.loc[(df_no_NaN[x] < RPKM_MAX) & (df_no_NaN[y] < RPKM_MAX)]  # Removes rows with RPKM > filter
df_filtered  = df_no_NaN.loc[ ( abs(df_no_NaN[y]) < RPKM_MAX ) & (abs(df_no_NaN[z]) < RPKM_MAX)]  # Removes rows with delta RPKM > filter, absolute values
df_subset    = df_filtered.sample(n = subset_count)                                  # Too many points will drag you down, man. Subset randomly

fig = df_subset.plot(kind="scatter", x = x, y = y, c = z, colormap="coolwarm", alpha=1, s=1, vmin=-3.5, vmax=3.5, ylim=[-3.5, 3.5])
#fig = df_subset.plot(kind="scatter", x = x, y = y, c = z, colormap="coolwarm", alpha=1, s=4)    # Scatterplot of subset
sns.kdeplot(df_filtered[x], df_filtered[y], cut=0, color="Black")                               # Make contour plot for all datapoints, not just subset shown


datapoint_count = len(df_filtered)
outFigure = "%s_2D_scatter_contour_noNaN_%s_RPKMmax_%s_datapoints_%s_subsetShown.svg" % (userInputFile, RPKM_MAX, datapoint_count, subset_count)
fig.figure.savefig(outFigure)  # Open in Illustrator and select contour -> select -> same stroke width -> 1.5 to 1.0 or 0.5
