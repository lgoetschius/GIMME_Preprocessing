#!/bin/bash

# Purpose: Create a new feat file with the clean data. This script will create the individual design files. 

# Create a list of subjects to use in this analysis and count how many there are.
subject_dir=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects
subjectlist=$(cd ${subject_dir}; ls -d csm*)
#subjectlist="csm14aff10068_01423"
for subject in ${subjectlist} ; do
 #Loops through all runs and replaces "ChangeMe" with run number
	
	# Confirm which subject we're working with.
	echo "${subject}"

	cp /nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/Scripts/GIMME/statsscript.fsf statsscript1.fsf
	#Replaces subj placeholder with variable "ChangeMySub"; this will be swapped later with the appropriate subject number
	#sed -i -e 's/A255/runChangeMySub/' tmpDesign.fsf # I don't think I need this because it seems like it's already changed in the script. 
	
	#copy for each subject - this will create a design file for each subject.
	cp statsscript1.fsf stats_design_${subject}.fsf 
		
	#Swap "ChangeMySubject" with run number
	sed -i -e 's/runChangeMySub/'${subject}'/' stats_design_${subject}.fsf 
		
	#run feat for each subject  		
	feat stats_design_${subject}.fsf 
done
