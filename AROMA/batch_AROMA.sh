#!/bin/bash

FILE=${1}
MAXPROCS=${2}
if [ "x$MAXPROCS" == "x" ]; then
    MAXPROCS=1
fi

#parallel implementation
cat ${FILE} | xargs -n 1 -P ${MAXPROCS} -I FILE /nfs/csmonk-lab/FF_Data/Working_Files/Resting/Scripts/AROMA/AROMA.sh /nfs/csmonk-lab/FF_Data/Working_Files/Resting/Subjects/FILE/func/run_01/s6w3rtprun_01.nii
