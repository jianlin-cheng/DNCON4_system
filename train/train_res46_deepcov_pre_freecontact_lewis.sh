#!/bin/bash -l
#SBATCH -J  ResNet
#SBATCH -o ResNet-%j.out
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
gloable_dir=${temp_dir%%DNCON4*}'DNCON4'
## ENV_FLAG
source $gloable_dir/env/dncon4_virenv/bin/activate
## FEATURE_FLAG
feature_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools
output_dir=$gloable_dir/models/custom/
acclog_dir=$gloable_dir/models/custom/All_Validation_Acc
printf "$gloable_dir\n"

#################net_name dataset fea_file nb_filters nb_layers filtsize out_epoch in_epoch feature_dir outputdir acclog_dir index
python $gloable_dir/lib/train_dncon4_tune_net.py 'DNCON4_RESPRE' 'DEEPCOV' 'pre_freecontact' 64 46 3 70 1 $feature_dir $output_dir $acclog_dir 1
