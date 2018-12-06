#!/bin/bash

########################## GIMME Input Prep Script ###########################

### The goal of this script for me is to be able to call different sets of commands based on which step I'd like to run. The purpose will be to extract and format the data used in GIMME analysis.

# At this point, you should have the masks you want to use already created. 

########################## Set the Variables We Want to Work With #########################

# Specify which step you would like to run: 
#		1 = Registration -- creates xfms matrices to transform masks to subject space.
# 		2 = Transform ROI to each subject's functional space.
# 		3 = Binarize the subject specific mask.
#		4 = Extract data using fslmeants.
#		5 = Consolidate all of the ROI time series in one txt file per subject.

# Input for the command below should be one (and at this point only one) of the steps you'd like to run.
step2run=5

# Specify your sublist and mask list.
stanpath=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/Subjects
cd ${stanpath}
#sublist=$(ls -d csm*)
sublist="csm14aff10001_00699 csm14aff10002_00717 csm14aff10004_00747 csm14aff10005_00754 csm14aff10006_00780 csm14aff10007_00784 csm14aff10008_00794 csm14aff10009_00813 csm14aff10011_00817 csm14aff10012_00835 csm14aff10013_00840 csm14aff10014_00841 csm14aff10016_00871 csm14aff10017_00888 csm14aff10018_00902 csm14aff10019_00903 csm14aff10020_00911 csm14aff10021_00928 csm14aff10023_00940 csm14aff10024_00953 csm14aff10025_00968 csm14aff10026_00975 csm14aff10029_00980 csm14aff10030_00998 csm14aff10031_01018 csm14aff10032_01019 csm14aff10034_01048 csm14aff10035_01049 csm14aff10036_01053 csm14aff10037_01054 csm14aff10038_01058 csm14aff10039_01059 csm14aff10040_01066 csm14aff10041_01079 csm14aff10043_01095 csm14aff10047_01129 csm14aff10048_01221 csm14aff10049_01222 csm14aff10050_01224 csm14aff10051_01229 csm14aff10052_01236 csm14aff10053_01240 csm14aff10054_01247 csm14aff10055_01254 csm14aff10056_01259 csm14aff10057_01260 csm14aff10058_01270 csm14aff10059_01283 csm14aff10060_01284 csm14aff10062_01353 csm14aff10063_01357 csm14aff10064_01358 csm14aff10065_01378 csm14aff10066_01391 csm14aff10067_01417 csm14aff10068_01423 csm14aff10069_01430 csm14aff10071_01439 csm14aff10072_01445 csm14aff10075_01454 csm14aff10076_01455 csm14aff10077_01484 csm14aff10078_01487 csm14aff10079_01488 csm14aff10080_01506 csm14aff10082_01513 csm14aff10084_01563 csm14aff10085_01564 csm14aff10086_01596 csm14aff10089_01652 csm14aff10090_01653 csm14aff10091_01658 csm14aff10093_01710 csm14aff10094_01740 csm14aff10095_01750 csm14aff10096_01754 csm14aff10099_01780 csm14aff10101_01808 csm14aff10103_01829 csm14aff10104_01837 csm14aff10105_01848 csm14aff10106_01863 csm14aff10107_01879 csm14aff10108_01880 csm14aff10109_01895 csm14aff10110_01915 csm14aff10112_01921 csm14aff10113_01929 csm14aff10114_01946 csm14aff10115_01956 csm14aff10116_01960 csm14aff10117_01964 csm14aff10118_01979 csm14aff10121_02000 csm14aff10122_02040 csm14aff10124_02045 csm14aff10125_02081 csm14aff10126_02082 csm14aff10127_02113 csm14aff10130_02149 csm14aff10131_02162 csm14aff10132_02203 csm14aff10133_02237 csm14aff10135_02242 csm14aff10136_02277 csm14aff10137_02278 csm14aff10138_02284 csm14aff10139_02285 csm14aff10140_02310 csm14aff10141_02311 csm14aff10143_02407 csm14aff10145_02438 csm14aff10146_02439 csm14aff10147_02477 csm14aff10148_02499 csm14aff10149_02504 csm14aff10150_02510 csm14aff10151_02511 csm14aff10152_02536 csm14aff10154_02541 csm14aff10155_02585 csm14aff10156_02631 csm14aff10157_02632 csm14aff10160_02666 csm14aff10161_02670 csm14aff10163_02717 csm14aff10164_02748 csm14aff10165_02790 csm14aff10166_02791 csm14aff10167_02794 csm14aff10168_02829 csm14aff10169_02874 csm14aff10170_02875 csm14aff10171_02880 csm14aff10172_02881 csm14aff10173_02923 csm14aff10174_02924 csm14aff10175_02944 csm14aff10176_02948 csm14aff10178_03043 csm14aff10179_03050 csm14aff10180_03084 csm14aff10182_03164 csm14aff10183_03250 csm14aff10184_03251 csm14aff10185_3412 csm14aff10188_03453 csm14aff10189_03502 csm14aff10190_03577 csm14aff10192_03637 csm14aff10194_03707 csm14aff10195_03708 csm14aff10196_03712 csm14aff10200_03783 csm14aff10201_03806 csm14aff10202_03834 csm14aff10203_03869 csm14aff10204_03895 csm14aff10205_03896 csm14aff10207_03949 csm14aff10208_03954 csm14aff10209_04045 csm14aff10210_04049 csm14aff10211_04120 csm14aff10212_04121 csm14aff10213_04124 csm14aff10214_04125 csm14aff10215_04253 csm14aff10216_04303 csm14aff10218_04343 csm14aff10219_04446 csm14aff10220_04546 csm14aff10222_04591 csm14aff10223_04673 csm14aff10225_04730 csm14aff10226_04780 csm14aff10227_04803 csm14aff10228_04900 csm14aff10229_04948 csm14aff10232_05147 csm14aff10234_05197 csm14aff10235_05198 csm14aff10236_05205" 
masks="L_Amygdala L_dACC L_dlPFC L_Insula L_IPL L_MTG L_PCC R_Amygdala R_dACC R_dlPFC R_Insula R_IPL R_MTG R_PCC"
masktxt="L_Amygdala.txt L_dACC.txt L_dlPFC.txt L_Insula.txt L_IPL.txt L_MTG.txt L_PCC.txt R_Amygdala.txt R_dACC.txt R_dlPFC.txt R_Insula.txt R_IPL.txt R_MTG.txt R_PCC.txt"
	# Note: the above variable (masktxt) is the name of the txt files that will hold the subject 
	# specific time serires for that ROI, should theoretically be the same as the mask variable 
	# but with .txt added at the end. I'm working on making this more streamlined.


# Specify the filepaths for your data and output files. 

funcpath=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects
funcfilename=feat_1.feat/outfinal.feat/filtered_func_data


strucpath=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/Subjects/${sub}/anatomy/CoReg
strucfilename=wmcht1spgr_110sl

stanpath=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/Subjects
stanfilename=MNI152_T1_2mm_brain

regpath=/Volumes/lsa-csmonk/bbox/FF_Data/Working_Files/Resting/Subjects/${sub}/anatomy
	# Note: the filepath above should point to a place where you will save the registration matrices. 
	# In this location, an xfms folder will be created in this script which is where the registration 
	# matrices will be kept.

maskpath=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/Resting/GIMME/masks

subjectmask=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/Subjects/${sub}/masks

suboutput=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/extracted_data
	# Note: make sure that the equivalent of the extraced_data folder here is already created. 
	# The script will create the subject specific folder within that folder.

finalout=/nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/GIMME/data




########################################################################################################### 
# You should not need to edit below this line - but review to make sure it will work for your computer/data 
###########################################################################################################

for sub in ${sublist} ; do
	echo ${sub}
	

	if [ ${step2run} -eq 1 ]; then
		
		echo " Now running registration. "

		flirt -in ${funcpath}/${filename}.nii -ref ${strucpath}/${strucfilename}.nii -omat ${regpath}/xfms/func2str.mat -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 6 -cost corratio;  
		convert_xfm -omat ${regpath}/xfms/str2func.mat -inverse ${regpath}/xfms/func2str.mat;  
		flirt -in ${strucpath}/${strucfilename}.nii -ref ${stanpath}/${stanfilename}.nii.gz -omat ${regpath}/xfms/str2standard.mat -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12 -cost corratio;  
		convert_xfm -omat ${regpath}/xfms/standard2str.mat -inverse ${regpath}/xfms/str2standard.mat;  
		convert_xfm -omat ${regpath}/xfms/func2standard.mat -concat ${regpath}/xfms/str2standard.mat ${regpath}/xfms/func2str.mat;  
		convert_xfm -omat ${regpath}/xfms/standard2func.mat -inverse ${regpath}/xfms/func2standard.mat;
	
	elif [ ${step2run} -eq 2 ]; then 
			
		echo " Now transforming mask to subject functional space. "
		mkdir ${subjectmask}

		for mask in ${masks} ; do

			echo ${mask}

			flirt -in ${maskpath}/${mask}.nii.gz -ref ${funcpath}/${funcfilename}.nii -applyxfm -init ${regpath}/xfms/standard2func.mat -out ${subjectmask}/${mask}_sub;

		done

	
	elif [ ${step2run} -eq 3 ]; then
		
		echo " Now binarizing your subject specific masks. "	

		for mask in ${masks} ; do

			echo ${mask}

			##calculate the lower 15 percentile of an image, store as variable
			thresh_it=`fslstats ${subjectmask}/${mask}_sub.nii.gz -P 15`
			
			##threshold your image at this threshold to create a binary mask
			fslmaths ${subjectmask}/${mask}_sub.nii.gz -thr ${thresh_it} -bin ${subjectmask}/${mask}_sub_bin.nii.gz

		done
	
	elif [ ${step2run} -eq 4 ]; then
		
		echo " Now extracting data using fslmeants. "

		mkdir ${suboutput}/${sub}

		for mask in ${masks} ; do
			
			echo ${mask}

			fslmeants -i ${funcpath}/${sub}/${funcfilename}.nii.gz -o ${suboutput}/${sub}/${mask}.txt -m ${funcpath}/${sub}/masks/${mask}_sphere_bin

		done

	elif [ ${step2run} -eq 5 ]; then
		
		echo " Now consolidating all of your extracted ROIs into one subject specific txt file. "

		cd ${suboutput}/${sub}

		paste ${masktxt} > ${finalout}/${sub}.txt  

	else
		
		echo " Invalid input for step2fun variable - ensure you have entered a possible value. "

	fi

done
