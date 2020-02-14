#!/bin/bash -l
#SBATCH -J  PRED
#SBATCH -o PRED-%j.out
#SBATCH -p Lewis,hpc4,hpc5
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 2-00:00
#SBATCH --mem 20G

export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE

##GLOBAL_FALG
global_dir=/storage/htc/bdm/zhiye/DNCON4
## ENV_FLAG
source /storage/htc/bdm/zhiye/DeepDist/env/dncon4_virenv_cpu/bin/activate
models_dir[0]=$global_dir/models/pretrain/dncon4_v3rc/1.dres152_deepcov_cov_ccmpred_pearson_pssm/
models_dir[1]=$global_dir/models/pretrain/dncon4_v3rc/2.dres152_deepcov_plm_pearson_pssm/
models_dir[2]=$global_dir/models/pretrain/dncon4_v3rc/3.res152_deepcov_pre_freecontact/
models_dir[3]=$global_dir/models/pretrain/dncon4_v3rc/4.res152_deepcov_other/
output_dir=$global_dir/example/T0990/
fasta=/storage/htc/bdm/zhiye/DNCON4/example/T0990.fasta
## DBTOOL_FLAG
db_tool_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
printf "$global_dir\n"

#################CV_dir output_dir dataset database_path
python $global_dir/lib/Model_predict.py $db_tool_dir $fasta ${models_dir[@]} $output_dir
