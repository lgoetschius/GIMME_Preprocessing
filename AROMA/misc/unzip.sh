
cd /nfs/turbo/lsa-csmonk/FF_Data/Working_Files/Resting/Subjects/

for sub in *
do
    echo $sub
     gunzip $sub/func/run_01/ICA_AROMA/denoised_func_data_nonaggr.nii.gz;
     mv $sub/func/run_01/ICA_AROMA/denoised_func_data_nonaggr.nii $sub/func/run_01/ICA_AROMA/sdenoised_func_data_nonaggr.nii
    done
    
