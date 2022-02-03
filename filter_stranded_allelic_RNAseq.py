# uses python to filter large tabular data, such as those from RNA-seq and WGBS
# also calculates the allelic ratio of an expressed gene (pat/(mat+pat))
# columns have to be in a very specific order (RPKM first, then allelic coverage)

# python ./filter_build_on_me.py > input_file_fileted.txt
# 0 = 1
# x = 24
import sys
import numpy

firstarg = sys.argv[1]
bam_RPKM_filter = float(sys.argv[2])
bigwig_allelic_RPM_filter = float(sys.argv[3])
out = open("%s_filtered_%s_RPKM_%s_allelicCovPM.txt" % (firstarg, bam_RPKM_filter, bigwig_allelic_RPM_filter), "wb")

#print out

first_data_col    = 7 								# number of first data col (usually RPKM) minus one
last_data_col     = 116				# number of total cols minus one
data_col_count    = last_data_col - first_data_col + 1
sample_count      = data_col_count / 5 				# each dataset has 5 numberic values: total RPKM, ref+, ref-, alt+, alt-
first_allelic_col = first_data_col + sample_count
col_indices       = numpy.arange(first_data_col, first_allelic_col, 1)

#print(data_col_count)
#print(sample_count)
#print(col_indices)
#print(allelic_col_indices)

# defaults
bam_RPKM_filter = 1 				# visrseq calculated on q255 rmDup bam
bigwig_allelic_RPM_filter = 50 		# visrseq calculated on allelic RPM normalized bigiwg, where read_length=1


# import file
with open(firstarg, 'rb') as txtfile:
# pop off first line from file and store as variable "header"
	header = txtfile.readline()
	# keep metadata and RPKM values and every 4 cols after that
	newHeader = header.split("	")[0:first_allelic_col]
	for index in col_indices:
		initial_header = header.split("	")[index]
		renamed_header = initial_header.replace(".bam_RPKM", "_pat_ratio")
		newHeader.append(renamed_header)
	# print the list as a tab delimited row of values
#	print('\t'.join(map(str,newHeader))) # sends to stdout
	out.write('\t'.join(map(str,newHeader))) # prints to file
	out.write('\n')
#	print newHeader

	for row in txtfile:
		listToPrint=[]
		# keep metadata
		for first_cols in range(0, first_allelic_col):
			listToPrint.append(row.split("	")[first_cols])
		# set up variables to filter on
		for index in col_indices:
#			print "Index", index
			RPKM = float(row.split("	")[index])
#			print "RPKM:", RPKM
			allelic_set_start = (index - first_data_col + 1) * 4 + sample_count + 3
#			print "allelic set start:", allelic_set_start
			allelic_set_4_indexes = range(allelic_set_start, (allelic_set_start+4))
#			print "allelic set of 4:", allelic_set_4_indexes

			# set variables based on column name
			for allelic_index in allelic_set_4_indexes:
#				print "allelic_index:", allelic_index
				dataset = header.split("	")[allelic_index]
#				print "dataset:", dataset

				if   "BF" in dataset and "_BN_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "BF" in dataset and "_BN_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])
				elif "BF" in dataset and "_F334_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "BF" in dataset and "_F334_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])

				elif "FB" in dataset and "_BN_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "FB" in dataset and "_BN_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])
				elif "FB" in dataset and "_F334_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "FB" in dataset and "_F334_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])



				elif "BW" in dataset and "_BN_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "BW" in dataset and "_BN_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])
				elif "BW" in dataset and "_WKY_NCrl_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "BW" in dataset and "_WKY_NCrl_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])

				elif "WB" in dataset and "_BN_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "WB" in dataset and "_BN_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])
				elif "WB" in dataset and "_WKY_NCrl_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "WB" in dataset and "_WKY_NCrl_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])


				elif "BJ" in dataset and "_C57BL_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "BJ" in dataset and "_C57BL_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])
				elif "BJ" in dataset and "_JF1_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "BJ" in dataset and "_JF1_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])

				elif "JB" in dataset and "_C57BL_" in dataset and "pos" in dataset:
					pat_pos = float(row.split("	")[allelic_index])
				elif "JB" in dataset and "_C57BL_" in dataset and "neg" in dataset:
					pat_neg = float(row.split("	")[allelic_index])
				elif "JB" in dataset and "_JF1_" in dataset and "pos" in dataset:
					mat_pos = float(row.split("	")[allelic_index])
				elif "JB" in dataset and "_JF1_" in dataset and "neg" in dataset:
					mat_neg = float(row.split("	")[allelic_index])




				else:
					mat_neg=pat_neg=mat_pos=mat_neg="FAILHERE"

				# set this to read length
#				if "BL" in dataset:
#					bigwig_allelic_RPM_filter = 50
#					print "bigwig_allelic_RPM_filter:", bigwig_allelic_RPM_filter
#				elif "EPC" in dataset:
#					bigwig_allelic_RPM_filter = 100
#					print "bigwig_allelic_RPM_filter:", bigwig_allelic_RPM_filter
#				else:
#					bigwig_allelic_RPM_filter = bigwig_allelic_RPM_filter


#BF_EB_RNA_rep1_BN_F1540_q255_RPM_neg.bw_Count	BF_EB_RNA_rep1_BN_F1540_q255_RPM_pos.bw_Count	BF_EB_RNA_rep1_F334_N_F1540_q255_RPM_neg.bw_Count	BF_EB_RNA_rep1_F334_N_F1540_q255_RPM_pos.bw_Count
#-38.3318796	711.2168983	-19.2603533	734.4426606

#			print "RPKM:", RPKM
#			print "mat_pos:", mat_pos
#			print "mat_neg:", mat_neg
#			print "pat_pos:", pat_pos
#			print "pat_neg:", pat_neg
##
#			print "allelic total:", mat_pos-mat_neg+pat_pos-pat_neg
#			print "pat ratio:", float((pat_pos-pat_neg)/(mat_pos-mat_neg+pat_pos-pat_neg))

			# actual filtering happens here, also paternal ratios calculated
			if RPKM >= bam_RPKM_filter and mat_pos-mat_neg+pat_pos-pat_neg >= bigwig_allelic_RPM_filter:
				newVal = float((pat_pos-pat_neg)/(mat_pos-mat_neg+pat_pos-pat_neg))
			elif RPKM < bam_RPKM_filter:
				newVal = -1
			elif mat_pos-mat_neg+pat_pos-pat_neg < bigwig_allelic_RPM_filter:
				newVal = -2
			else:
				newVal = "JulienFuckedUp"
#			print "newVal:", newVal
#			print "bam_RPKM_filter:", bam_RPKM_filter
			listToPrint.append(newVal)
#			print "."

		# print the list as a tab delimited row of values
#		print('\t'.join(map(str,listToPrint))) # sends to stdout
		out.write('\t'.join(map(str,listToPrint))) # prints to file
		out.write('\n')
#		print listToPrint
out.close()
