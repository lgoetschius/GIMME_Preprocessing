#!/bin/bash

############################### Nuissance Regressors & High Pass Filter  ################################### 

# Purpose: This script calculates the nuisance regressors (wm and csf), removes those from the data, and then highpass filters the data

# Create a list of subjects to use in this analysis and count how many there are.

subject_dir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects
subjectlist=$(cd ${subject_dir}; ls -d csm*)

for subject in ${subjectlist} ; do
	
# Confirm which subject we're working with.
	echo "${subject}"
#cd into directory
	cd ${subject_dir}/${subject}/feat_1.feat

#regress WM and CSF
	
	# First step will be to erode and binarize the wm and csf masks.
	fslmaths ${subject_dir}/${subject}/anat_pve_2.nii.gz -sub 0.333 -bin -ero -ero ${subject_dir}/${subject}/wm_ero.nii 

	fslmaths ${subject_dir}/${subject}/anat_pve_0.nii.gz -bin -ero ${subject_dir}/${subject}/csf_ero.nii

	# Next, we'll convert these eroded wm and csf masks to functional space from structural
	flirt -in ${subject_dir}/${subject}/wm_ero.nii \
	-applyxfm \
	-init reg/highres2example_func.mat \
	-ref filtered_func_data.nii.gz \
	-out ${subject_dir}/${subject}/wm_ero_func

	flirt -in ${subject_dir}/${subject}/csf_ero.nii \
        -applyxfm \
        -init reg/highres2example_func.mat \
        -ref filtered_func_data.nii.gz \
        -out ${subject_dir}/${subject}/csf_ero_func

	# Then, we'll extract the time series for each of those masks (this will be post AROMA)
	fslmeants -i ICA_AROMA/denoised_func_data_nonaggr.nii.gz -m ${subject_dir}/${subject}/wm_ero_func.nii \
	--no_bin -o WM_ero_func_timeseries
	
	fslmeants -i ICA_AROMA/denoised_func_data_nonaggr.nii.gz -m ${subject_dir}/${subject}/csf_ero_func.nii \
        --no_bin -o csf_ero_func_timeseries

	# Lastly, we'll combine those two regressors and extract them and put them as a single reressor file.
	paste WM_ero_func_timeseries csf_ero_func_timeseries > nuisance_timeseries
	
	fslmaths ICA_AROMA/denoised_func_data_nonaggr -Tmean tempMean
	
	fsl_glm -i ICA_AROMA/denoised_func_data_nonaggr -d nuisance_timeseries --demean --out_res=residual


# HPF the data

	fslmaths residual  -bptf 27.778 0 -add tempMean denoised_func_data_nonaggr_filt

	## I chose 27.78 because that should be a 0.009Hz high pass filter in sigmas/volumes. The formula I used was 1/(2*f*TR)

done

