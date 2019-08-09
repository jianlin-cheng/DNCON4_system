#!/bin/bash -l
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
temp_dir=$(pwd)
gloable_dir=${temp_dir%%DNCON4*}'DNCON4'
## ENV_FLAG
source $gloable_dir/env/dncon4_virenv/bin/activate
## FEATURE_FLAG
feature_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
output_dir=$gloable_dir/models/custom/
acclog_dir=$gloable_dir/models/custom/All_Validation_Acc
printf "$gloable_dir\n"

#################net_name dataset fea_file nb_filters nb_layers filtsize out_epoch in_epoch feature_dir outputdir acclog_dir index
python $gloable_dir/lib/train_dncon4_tune_net.py 'DNCON4_DIARES' 'DEEPCOV' 'plm_pearson_pssm' 64 152 3 70 1 $feature_dir $output_dir $acclog_dir 1
