#!/bin/bash

echo ${1}
DIR=`dirname ${1}`
FILE=`basename ${1}`

/usr/bin/python2.7 /home/slab/users/mangstad/repos/ICA-AROMA/ICA_AROMA.py -in ${DIR}/${FILE} -out ${DIR}/ICA_AROMA -mc ${DIR}/rp*.txt -m /net/parasite/SchizConnect/ROIs/rs_spm12_mni_icbm152_nlin_sym_09b_1xero_s8_thrp35_mask.nii -tr 2 -den both > $DIR/aroma.log
