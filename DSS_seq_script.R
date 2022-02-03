#################################################################################
# RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!

Sys.time()

library(DSS)
library(bsseq)

path = file.path("/home/teamgreenberg/Dropbox/greenberg05_julien_share/dmr_identification/")

# EPIBLAST
# mat
# dat1 = read.table(file.path(path, "rat_epiblast_maternal_rep1-3.txt_merge_for_DRRseq.gz"), header=TRUE)

# pat
# dat2 = read.table(file.path(path, "rat_epiblast_paternal_rep1-3.txt_merge_for_DRRseq.gz"), header=TRUE)


# EPC
# mat
dat1 = read.table(file.path(path, "rat_epiblast_maternal_rep1-3.txt_merge_for_DRRseq.gz"), header=TRUE)

# pat
dat2 = read.table(file.path(path, "rat_epiblast_paternal_rep1-3.txt_merge_for_DRRseq.gz"), header=TRUE)

Sys.time()
print("Loading data")

BSobj = makeBSseqData( list(dat1, dat2),
                       c("mat", "pat") )

Sys.time()
print("Done loading data")

#BSobj_DSS <- BSobj[0:20000,]
BSobj_DSS <- BSobj
BSobj_DSS

Sys.time()
print("dml test begins")
dmlTest.sm = DMLtest(BSobj_DSS, group1=c("mat"), group2=c("pat"), 
                     smoothing=TRUE)
head(dmlTest.sm)

Sys.time()
print("calling significant dmls")
dmls2 = callDML(dmlTest.sm, delta=0.1, p.threshold=0.001)
head(dmls2)

Sys.time()
print("calling significant DMRs")
dmrs = callDMR(dmlTest.sm, p.threshold=0.01)
head(dmrs)

Sys.time()
print("writing to file")
write.csv(as.data.frame(dmrs), 
          file="/home/teamgreenberg/Dropbox/greenberg05_julien_share/dmr_identification/rat_epi_dmrs_DSS_d0.1_p0.001.csv")



#RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!RATS DMR!
#################################################################################
