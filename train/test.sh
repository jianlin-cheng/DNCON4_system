#!/bin/bash -l
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
##GLOBAL_FALG
global_dir=/mnt/data/zhiye/Python/DNCON4_system
## ENV_FLAG
# source $global_dir/env/dncon4_virenv/bin/activate
## FEATURE_FLAG
feature_dir=/mnt/data/zhiye/Python/DNCON4/data/deepcov/feats/
output_dir=$global_dir/models/custom/test/
acclog_dir=$global_dir/models/custom/All_Validation_Acc
printf "$global_dir\n"

#################net_name dataset fea_file nb_filters nb_layers filtsize out_epoch in_epoch feature_dir outputdir acclog_dir index
python $global_dir/lib/train_dncon4_tune_net.py 'DNCON4_DIARES' 'DEEPCOV' 'plm' 64 34 3 70 1 $feature_dir $output_dir $acclog_dir 6

#2 change lr l2 casp64.5
#3 change network 
#4 use other to test casp 58.34
#5 chaneg model training other  casp 60.34
#6 change model training plm 