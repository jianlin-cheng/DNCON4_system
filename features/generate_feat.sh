#!/bin/bash -l
##GLOBAL_FALG
global_dir=/data/wuti/DNCON4/test/DNCON4_system
## ENV_FLAG
source $global_dir/env/dncon4_virenv/bin/activate
output_dir=$global_dir/features/T0771/
fasta=$global_dir/example/T0771.fasta
## FEATURE_FLAG
feature_dir=/data/wuti/DNCON4/test/DNCON4_db_tools
printf "$global_dir\n"

#################CV_dir output_dir dataset database_path
python $global_dir/scripts/dncon4.py $feature_dir $fasta $output_dir
