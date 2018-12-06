#!/bin/bash

############################### FAST loop script ################################### 
# Purpose: Runs FAST

# Create a list of subjects to use in this analysis and count how many there are.

subject_dir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/
subjectlist=$(cd ${subject_dir}; ls -d csm*)

#subjectlist= ${'A790', 'A792', 'A794', 'A796', 'A797', 'A802', 'A803', 'A804', 'A806', 'A807', 'A808', 'A812', 'A813', 'A814', 'A815', 'A816', 'A819', 'A820', 'A821', 'A824', 'A825', 'A826', 'A827', 'A828', 'A830', 'A831', 'A832', 'A833', 'A834', 'A837', 'A838', 'A841', 'A844'}

########################### Do Not Edit Below This Line ############################### 

#  Make sure that we load fsl

for subject in ${subjectlist} ; do
	
	# Confirm which subject we're working with.
	echo "${subject}"

	# Copy the anatomicals to the Working Files
#	scp /nfs/turbo/lsa-csmonk/FF_Data/Read_Only/${subject}/anatomy/t1spgr_110sl/eht1spgr_110sl.nii /nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/${subject}/eht1spgr_110sl.nii

	
	# Move into their directory.
	cd /nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/${subject}/
	
	# Run the FAST command.
	fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o anat eht1spgr_110sl_bet.nii.gz


	# Move back out into the folder.
	cd ..
	
done

