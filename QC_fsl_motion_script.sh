#!/bin/bash

################# Loop for Motion Outliers Script #################

# Purpose: The purpose of this script is to use the fsl_motion_outliers script to record the dvars and/or FD values for the clean data. 

###################################################################

# Create subject list
subjectdir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/
sublist=$(cd ${subjectdir}; ls -d csm*)

for sub in ${sublist} ; do

	echo ${sub}

	savedir=${subjectdir}/${sub}/feat_1.feat/outfinal.feat

	fsl_motion_outliers -i ${savedir}/filtered_func_data.nii.gz -o ${savedir}/motion_outliers_output -s ${savedir}/motion_outliers_metric_fd.txt --fd

done


