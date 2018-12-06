#!/bin/bash

############################### subject ROI loop script ################################### 

# Purpose: Create mask for individual subjects based on individual brain size and register that mask to individual subject space. 
# Prior to running script, point masks should be created based on desired coordinates using FSL. 

SUBJECTS_DIR=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/GIMME/Subjects
MASKS_DIR=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/GIMME/masks/

sublist=$(cd ${SUBJECTS_DIR}; ls -d csm*)
ROIlist="L_Amygdala L_dACC L_dlPFC L_Insula L_IPL L_MTG L_PCC R_Amygdala R_dACC R_dlPFC R_Insula R_IPL R_MTG R_PCC"

########################### Do Not Edit Below This Line ############################### 

#  Make sure that we load fsl

cd ${SUBJECTS_DIR}

for subject in ${sublist} ; do
	
	# Confirm which subject we're working with.
	echo "${subject}"

	subjsphere=$(awk -v subject="${subject}"  -F, '$1==subject {print $6}' global_size_FSL.csv)

	echo "${subjsphere}"

	mkdir ${SUBJECTS_DIR}/${subject}/masks
	
	for ROI in ${ROIlist} ; do

		echo "${ROI}" 

#create the ROI mask
	
		subsphererad=${subjsphere}/2

		fslmaths ${MASKS_DIR}/${ROI}_point.nii.gz -kernel sphere ${subsphererad} -fmean ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere.nii.gz -odt float

		#fslmaths ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere.nii.gz -bin ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere_bin.nii.gz

# Register.
		flirt -in ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere.nii.gz -ref ${SUBJECTS_DIR}/${subject}/feat_1.feat/reg/example_func.nii.gz -applyxfm -init ${SUBJECTS_DIR}/${subject}/feat_1.feat/reg/standard2example_func.mat -out ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere_reg.nii.gz

		fslmaths ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere_reg.nii.gz -bin ${SUBJECTS_DIR}/${subject}/masks/${ROI}_sphere_bin.nii.gz

	done
done

