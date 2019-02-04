#!/bin/bash

echo ${1}
DIR=`dirname ${1}`
FILE=`basename ${1}` 

/usr/bin/python2.7 /nfs/csmonk-lab/FF_Data/Working_Files/Resting/Scripts/AROMA/ICA_AROMA.py -in ${DIR}/${FILE} -out ${DIR}/ICA_AROMA -mc ${DIR}/rp*.txt -m /nfs/csmonk-lab/FF_Data/Working_Files/Resting/Scripts/AROMA/ROIs/rs_spm12_mni_icbm152_nlin_sym_09b_1xero_s8_thrp35_mask.nii -tr 2 -den both > $DIR/aroma.log

