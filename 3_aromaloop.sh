#!/bin/bash

############################### ICA-AROMA loop script ################################### 

# Purpose: This script runs the ICA AROMA in a loop for resting state data. 

# Create a list of subjects to use in this analysis and count how many there are.

subject_dir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects

cd ${subject_dir}

subjectlist=$(ls -d csm*)

for subject in ${subjectlist} ; do

# Make sure you're in the correct directory.
	cd ${subject_dir}
	
# Confirm which subject we're working with.
	echo "${subject}"

#new bet 

	bet ${subject_dir}/${subject}/feat_1.feat/reg/example_func.nii.gz ${subject_dir}/${subject}/feat_1.feat/aromam -f 0.3 -n -m -R

#run icaroma
    
	python2.7 /nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/Scripts/AROMA/ICA_AROMA.py -in ${subject_dir}/${subject}/feat_1.feat/filtered_func_data.nii.gz -out ${subject_dir}/${subject}/feat_1.feat/ICA_AROMA -mc ${subject_dir}/${subject}/feat_1.feat/mc/prefiltered_func_data_mcf.par -m ${subject_dir}/${subject}/feat_1.feat/aromam_mask.nii.gz -md ${subject_dir}/${subject}/feat_1.feat/ICA_AROMA/melodic.ica

done

