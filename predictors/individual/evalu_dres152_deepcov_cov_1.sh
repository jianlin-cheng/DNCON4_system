#!/bin/bash -l
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
temp_dir=$(pwd)
##GLOBAL_FALG
global_dir=/storage/htc/bdm/zhiye/DNCON4
## ENV_FLAG
source $global_dir/env/dncon4_virenv/bin/activate
models_dir[0]=$global_dir/models/pretrain/1.dres152_deepcov_cov_ccmpred_pearson_pssm/
output_dir=$global_dir/predictors/results/COV/
## FEATURE_FLAG
feature_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
printf "$global_dir\n"

#################CV_dir output_dir dataset database_path
python $global_dir/lib/Model_evaluate.py $models_dir $output_dir 'CASP13' $feature_dir
