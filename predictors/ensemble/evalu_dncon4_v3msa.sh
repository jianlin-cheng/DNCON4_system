#!/bin/bash -l
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
temp_dir=$(pwd)
##GLOBAL_FALG
global_dir=/mnt/data/zhiye/Python/DNCON4_system
## ENV_FLAG
# source $global_dir/env/dncon4_virenv/bin/activate
models_dir[0]=$global_dir/models/pretrain/dncon4_v3rc_msa/1.dres152_deepcov_cov_ccmpred_pearson_pssm/
models_dir[1]=$global_dir/models/pretrain/dncon4_v3rc_msa/2.dres152_deepcov_plm_pearson_pssm/
models_dir[2]=$global_dir/models/pretrain/dncon4_v3rc_msa/3.res152_deepcov_pre_freecontact/
models_dir[3]=$global_dir/models/pretrain/dncon4_v3rc_msa/4.res152_deepcov_other/
output_dir=$global_dir/predictors/results/CASP13_MSA_dncon4_v3rc_msa1/
## FEATURE_FLAG
feature_dir=/mnt/data/zhiye/Python/DNCON4_db_tools/
printf "$global_dir\n"

#################CV_dir output_dir dataset database_path
python $global_dir/lib/Model_evaluate.py ${models_dir[@]} $output_dir 'CASP13_MSA' $feature_dir
