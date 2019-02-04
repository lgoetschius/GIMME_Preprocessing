#!/bin/bash

FILE=`basename $1`
DIR=`dirname $1`

cd ${DIR}
export FSLOUTPUTTYPE=NIFTI
echo ${1}

fsl_regfilt --in=${FILE} --design=ICA_AROMA/melodic.ica/melodic_mix --filter="`cat ICA_AROMA/classified_motion_ICs.txt`" --out=ICA_AROMA/unsmoothed_denoised_func_data_nonaggr.nii
