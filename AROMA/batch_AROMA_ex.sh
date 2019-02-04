#!/bin/bash

FILE=${1}
MAXPROCS=${2}
if [ "x$MAXPROCS" == "x" ]; then
    MAXPROCS=1
fi

#parallel implementation
cat ${FILE} | xargs -n 1 -P ${MAXPROCS} -I sub /net/parasite/SchizConnect/Scripts/AROMA/AROMA.sh /net/parasite/SchizConnect/Sites/COBRE/sub/func/s6w3rtrest.nii
