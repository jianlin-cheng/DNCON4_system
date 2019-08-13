#!/bin/bash -l
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
##GLOBAL_FALG
global_dir=/storage/htc/bdm/zhiye/DNCON4
## ENV_FLAG
source $global_dir/env/dncon4_virenv/bin/activate
## FEATURE_FLAG
feature_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
output_dir=$global_dir/models/custom/
acclog_dir=$global_dir/models/custom/All_Validation_Acc
printf "$global_dir\n"

#################net_name dataset fea_file nb_filters nb_layers filtsize out_epoch in_epoch feature_dir outputdir acclog_dir index
python $global_dir/lib/train_dncon4_tune_net.py 'DNCON4_DIARES' 'DEEPCOV' 'cov_ccmpred' 64 34 3 70 1 $feature_dir $output_dir $acclog_dir 1

