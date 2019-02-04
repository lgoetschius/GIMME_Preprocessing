#!/bin/bash

cd /net/parasite/SchizConnect/Sites/COBRE/

#resample each WM and CSF segment into functional space
for i in $(cat havesmooth.txt)
do
    cd ${i}/coReg/
    3dresample -master ../func/s6w3*.nii -infile mwp2*.nii -prefix r3wm.nii -rmode NN
    3dresample -master ../func/s6w3*.nii -infile mwp3*.nii -prefix r3csf.nii -rmode NN
    cd ../../
done

#threshold, binarize, and erode WM and CSF images to create masks
export FSLOUTPUTTYPE=NIFTI

for i in $(cat havesmooth.txt)
do
	cd ${i}/coReg/
    fslmaths r3wm.nii -sub 0.333 -bin -ero -ero WM_mask.nii
    fslmaths r3csf.nii -sub 0.333 -bin -ero CSF_mask.nii
	cd ../../
done

#check to make sure we have more than 5 voxels in each WM and CSF mask
for i in $(cat havesmooth.txt)
do
    fslstats ${i}/coReg/WM_mask.nii -V
done

for i in $(cat havesmooth.txt)
do
    fslstats ${i}/coReg/CSF_mask.nii -V
done
