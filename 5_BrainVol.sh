#!/bin/bash

###################### Calculate Brain Volume ########################
# Purpose: This script calculates total brain volume and saves it to a csv file. 



# Specify the template brain
T_brain=${FSL_DIR}/data/standard/MNI152_T1_1mm_brain

# Create your subject list
SUBJECTS_DIR=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/
sublist=$(cd ${SUBJECTS_DIR}; ls -d csm*)

# Create the column headings of csv
echo "subj_id,eTIV_FLIRT,FASTvol_noCSF" > global_size_FSL.csv


for subj_id in ${sublist} ; do

	echo ${subj_id}

	eTIV=`./mat2det.txt ${subj_id}/feat_1.feat/reg/highres2standard.mat | awk '{ print $2 }' `

	volGM=`fslstats ${subj_id}/anat_pve_1.nii.gz -V -M | awk '{ vol = $2 * $3 ; print vol }'`

	volWM=`fslstats ${subj_id}/anat_pve_2.nii.gz -V -M | awk '{ vol = $2 * $3 ; print vol }'`

	voltissue=`expr ${volGM} + ${volWM}`

	# Write the brain volumes to csv.
	echo "${subj_id},${eTIV},${voltissue}" >> global_size_FSL.csv

done
