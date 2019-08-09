#!/bin/bash -l
#SBATCH -J  EVALU
#SBATCH -o EVALU-%j.out
#SBATCH --partition gpu3
#SBATCH --nodes=1
#SBATCH --ntasks=1         # leave at '1' unless using a MPI code
#SBATCH --cpus-per-task=1  # cores per task
#SBATCH --mem-per-cpu=10G  # memory per core (default is 1GB/core)
#SBATCH --time 2-00:00     # days-hours:minutes
#SBATCH --qos=normal
#SBATCH --account=general-gpu  # investors will replace this with their account name
#SBATCH --gres gpu:"GeForce GTX 1080 Ti":1

module load cuda/cuda-9.0.176
module load cudnn/cudnn-7.1.4-cuda-9.0.176
export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=""
export HDF5_USE_FILE_LOCKING=FALSE
temp_dir=$(pwd)
##GLOBAL_FALG
global_dir=/storage/htc/bdm/zhiye/DNCON4
## ENV_FLAG
source $global_dir/env/dncon4_virenv/bin/activate
models_dir[0]=$global_dir/models/pretrain/3.res152_deepcov_pre_freecontact/
output_dir=$global_dir/predictors/results/PRE/
fasta=/storage/htc/bdm/zhiye/DNCON4/example/T0771.fasta
## DBTOOL_FLAG
db_tool_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
printf "$global_dir\n"

#################CV_dir output_dir dataset database_path
python $global_dir/lib/Model_predict.py $db_tool_dir $fasta ${models_dir[@]} $output_dir
