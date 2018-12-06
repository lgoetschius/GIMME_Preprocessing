#!/bin/bash

##################### Coverage Check Script ################################

# Purpose: This QC script calculates the individual coverage rates for all included masks and writes it out to a csv file.

# Create subject list.
subject_dir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects
sublist=$(cd ${subject_dir}; ls -d csm*)

# Specify mask files
masks="L_Amygdala L_dACC L_dlPFC L_Insula L_IPL L_MTG L_PCC R_Amygdala R_dACC R_dlPFC R_Insula R_IPL R_MTG R_PCC"

for sub in ${sublist} ; do
	echo "${sub}"
	for mask in ${masks} ; do
		echo "${mask}"
		# Calculate the possible number of voxels in the subject specific mask
		mask_vol=$(fslstats ${subject_dir}/${sub}/masks/${mask}_sphere_bin -V | awk '{ print $1 }') 
		echo ${mask_vol}

		# Count the number of non-zero voxels in the subject specific mask given the data
		coverage=$(fslstats ${subject_dir}/${sub}/feat_1.feat/outfinal.feat/mean_func -k ${subject_dir}/${sub}/masks/${mask}_sphere_bin -V | awk '{ print $1 }')
		echo ${coverage}

		# Calculate the coverage percentage
		ratio=$(perl -e "print ${coverage}/${mask_vol}" | cut -c1-4)
		echo ${ratio}

		# Print out the results
		echo "${sub},${mask},${mask_vol},${coverage},${ratio}" >> ${subject_dir}/coverage.csv
	done
done
