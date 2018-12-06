#!/bin/bash

######################## QC Average FD Script 	################################

# Purpose: The goal of this script is to calculate the subject-level average of a specific QC metric (e.g. FD) and write it to a txt file for review.


#Note: this errored out on subjects that had numbers in scientific notation -- there weren't enough that it was worth figuring out, I just hand calcuated. 

subdir=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/GIMME/Subjects
output_dir=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/GIMME
output_file=FD_Avg_113018.txt

sublist=$(cd ${subdir} ; ls -d csm*)

for sub in ${sublist} ; do

	echo ${sub}
	count=0;
	total=0; 

	cd /Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/GIMME/Subjects/${sub}/feat_1.feat/outfinal.feat/

	for i in $( awk '{ print $1; }' motion_outliers_metric_fd.txt )
	   do 
	     total=$(echo $total+$i | bc )
	     ((count++))
	   done
	echo "scale=5; $total / $count" | bc >> ${output_dir}/${output_file}

	cd ${subdir}

done