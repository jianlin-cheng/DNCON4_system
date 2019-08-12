#!/usr/bin/perl -w
use POSIX;

if (@ARGV != 3 ) {
  print "Usage: <input> <output>\n";
  exit;
}

$outputdir = $ARGV[0];
$sbatch_folder = $ARGV[1];
$data_list = $ARGV[2];

open(IN,"$data_list") || die "Failed to open file $data_list\n";

$c=0;
while(<IN>)
{
  
  $line = $_;
  chomp $line;
  print "Loading data $line\n";

   $run_outdir = "$outputdir/$line";
  if(!(-d $run_outdir))
  {
  	`mkdir $run_outdir`;	
  }

  $c++;
  print "\n\n###########  processing $line  ###########\n";

  $runfile="$sbatch_folder/P1_run_sbatch_$c.sh";
  print "Generating $runfile\n";
  open(SH,">$runfile") || die "Failed to write $runfile\n";
  

  print "$line\n";

  print SH "#!/bin/bash -l\n";
  print SH "#SBATCH -J  PRED\n";
  print SH "#SBATCH -o PRED-%j.out\n";
  print SH "#SBATCH --partition gpu3,gpu4\n";
  print SH "#SBATCH --nodes=1\n";
  print SH "#SBATCH --ntasks=1\n";
  print SH "#SBATCH --cpus-per-task=8\n";
  print SH "#SBATCH --mem 15G\n";
  print SH "#SBATCH --time 2-00:00\n";
  print SH "#SBATCH --qos=normal\n";
  print SH "#SBATCH --account=general-gpu\n";
  print SH "#SBATCH --gres gpu:1\n";

  
  print SH "module load cuda/cuda-9.0.176\n";
  print SH "module load cudnn/cudnn-7.1.4-cuda-9.0.176\n";
  print SH "export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=\"\"\n";
  print SH "export HDF5_USE_FILE_LOCKING=FALSE\n";

  print SH "##GLOBAL_FALG\n";
  print SH "global_dir=/storage/htc/bdm/zhiye/DNCON4\n";
  print SH "## ENV_FLAG\n";
  print SH "source \$global_dir/env/dncon4_virenv/bin/activate\n";
  print SH "models_dir[0]=\$global_dir/models/pretrain/1.dres152_deepcov_cov_ccmpred_pearson_pssm/\n";
  print SH "models_dir[1]=\$global_dir/models/pretrain/2.dres152_deepcov_plm_pearson_pssm/\n";
  print SH "models_dir[2]=\$global_dir/models/pretrain/3.res152_deepcov_pre_freecontact/\n";
  print SH "models_dir[3]=\$global_dir/models/pretrain/4.res152_deepcov_other/\n";

  print SH "output_dir=$run_outdir\n";
  print SH "fasta=/storage/htc/bdm/zhiye/DNCON4/example/$line.fasta\n";
  print SH "## DBTOOL_FLAG\n";
  print SH "db_tool_dir=/storage/htc/bdm/zhiye/DNCON4_db_tools\n";


  print SH "python \$global_dir/lib/Model_predict.py \$db_tool_dir \$fasta \${models_dir[@]} \$output_dir\n";

  close SH;

}
