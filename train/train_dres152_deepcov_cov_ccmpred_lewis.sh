#!/bin/bash -l
#SBATCH -J  DResNet
#SBATCH -o DResNet-%j.out
#SBATCH --partition gpu3,gpu4
#SBATCH --nodes=1
#SBATCH --ntasks=1         # leave at '1' unless using a MPI code
#SBATCH --cpus-per-task=1  # cores per task
#SBATCH --mem-per-cpu=10G  # memory per core (default is 1GB/core)
#SBATCH --time 2-00:00     # days-hours:minutes
#SBATCH --qos=normal
#SBATCH --account=general-gpu  # investors will replace this with their account name
#SBATCH --gres gpu:"Tesla V100-PCIE-32GB":1

module load cuda/cuda-9.0.176
module load cudnn/cudnn-7.1.4-cuda-9.0.176
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
python $global_dir/lib/train_dncon4_tune_net.py 'DNCON4_DIARES' 'DEEPCOV' 'cov_ccmpred' 64 152 3 70 1 $feature_dir $output_dir $acclog_dir 1
