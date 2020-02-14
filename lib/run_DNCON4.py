# -*- coding: utf-8 -*-
"""
Created on Tue Feb 11 15:57:26 2020

@author: Zhiye
"""
import sys
import os,glob,re
import time
import numpy as np
import subprocess
import argparse
import shutil
from multiprocessing import Process
from random import randint

def is_dir(dirname):
	"""Checks if a path is an actual directory"""
	if not os.path.isdir(dirname):
		msg = "{0} is not a directory".format(dirname)
		raise argparse.ArgumentTypeError(msg)
	else:
		return dirname

def is_file(filename):
	"""Checks if a file is an invalid file"""
	if not os.path.exists(filename):
		msg = "{0} doesn't exist".format(filename)
		raise argparse.ArgumentTypeError(msg)
	else:
		return filename

def chkdirs(fn):
	'''create folder if not exists'''
	dn = os.path.dirname(fn)
	if not os.path.exists(dn): os.makedirs(dn)

def run_shell_file(filename):
	outfile = filename.split('.')[0] + '.out'
	if not os.path.exists(filename): 
		print("Shell file not exist: %s, please check!"%filename)
		sys.exit(1)
	os.system('sh %s > %s'%(filename, outfile))
	print("parent %s,child %s,name: %s"%(os.getppid(),os.getpid(),filename))

# def combine_dm_fl():

def ensemble_aln_msa(fasta_name, outdir):
	model_dir = [outdir + '/aln/', outdir + '/msa/']
	ensemble_dir = outdir + '/ensemble/'
	model_num = len(model_dir)
	chkdirs(ensemble_dir)

	sum_map_filename = ensemble_dir + seq_name + '.txt'
	sum_map = 0
	for i in range(model_num):
		cmap_file = model_dir[i] + '/pred_map_ensem/' + seq_name + '.txt'
		cmap = np.loadtxt(cmap_file, dtype=np.float32)
		sum_map += cmap
	sum_map /= model_num
	np.savetxt(sum_map_filename, sum_map, fmt='%.4f')
	return ensemble_dir


def generate_rr_for_contact(fasta_name, outdir, real_dist_dir):
	print("HHHHH")
	print("HHHHH")
	print("HHHHH")

def generate_pred_shell(shell_file, outdir, fasta, option, model_select = 'mul_lable_AGR'):
	chkdirs(shell_file)
	# every will remove the old shell file
	if os.path.exists(shell_file): 
		os.remove(shell_file)
	with open(shell_file, "a") as myfile:
		myfile.write('\nprintf \"TEST\"\n')
		# myfile.write('#!/bin/bash -l\n')
		# myfile.write('#SBATCH -J  %s\n'%fasta)
		# myfile.write('#SBATCH -o %s-%%j.out\n'%fasta)
		# myfile.write('#SBATCH -p Lewis,hpc4,hpc5\n')
		# myfile.write('#SBATCH -N 1\n')
		# myfile.write('#SBATCH -n 8\n')
		# myfile.write('#SBATCH -t 2-00:00\n')
		# myfile.write('#SBATCH --mem 20G\n')
		# myfile.write('module load cuda/cuda-9.0.176\n')
		# myfile.write('module load cudnn/cudnn-7.1.4-cuda-9.0.176\n')
		# myfile.write('export GPUARRAY_FORCE_CUDA_DRIVER_LOAD=\"\"\n')
		# myfile.write('export HDF5_USE_FILE_LOCKING=FALSE\n')
		# myfile.write('\n##GLOBAL_FALG\n')
		# myfile.write('global_dir=/mnt/data/zhiye/Python/DeepDist')
		# myfile.write('\n## ENV_FLAG\n')
		# myfile.write('source $global_dir/env/dncon4_virenv/bin/activate\n')
		# if option == 'ALN':
		# 	myfile.write('models_dir[0]=$global_dir/models/pretrain/dncon4_v3rc_AG/1.dres152_deepcov_cov_ccmpred_pearson_pssm/\n')
		# 	myfile.write('models_dir[1]=$global_dir/models/pretrain/dncon4_v3rc_AG/2.dres152_deepcov_plm_pearson_pssm/\n')
		# 	myfile.write('models_dir[2]=$global_dir/models/pretrain/dncon4_v3rc_AG/3.res152_deepcov_pre_freecontact/\n')
		# 	myfile.write('models_dir[3]=$global_dir/models/pretrain/dncon4_v3rc_AG/4.res152_deepcov_other/\n')
		# 	myfile.write('output_dir=%s/aln/\n'%(outdir))
		# elif option == 'MSA':
		# 	myfile.write('models_dir[0]=$global_dir/models/pretrain/dncon4_v3rc_msa_AG/1.dres152_deepcov_cov_ccmpred_pearson_pssm/\n')
		# 	myfile.write('models_dir[1]=$global_dir/models/pretrain/dncon4_v3rc_msa_AG/2.dres152_deepcov_plm_pearson_pssm/\n')
		# 	myfile.write('models_dir[2]=$global_dir/models/pretrain/dncon4_v3rc_msa_AG/3.res152_deepcov_pre_freecontact/\n')
		# 	myfile.write('models_dir[3]=$global_dir/models/pretrain/dncon4_v3rc_msa_AG/4.res152_deepcov_other/\n')
		# 	myfile.write('output_dir=%s/msa/\n'%(outdir))
		# myfile.write('fasta=%s/%s.fasta\n'%(outdir, fasta))
		# myfile.write('\n## DBTOOL_FLAG\n')
		# myfile.write('db_tool_dir=/mnt/data/zhiye/Python/DNCON4_db_tools/')
		# myfile.write('\nprintf \"$global_dir\"\n')
		# myfile.write('#################CV_dir output_dir dataset database_path\n')
		# if option == 'ALN':
		# 	myfile.write('python $global_dir/lib/Model_predict.py $db_tool_dir $fasta ${models_dir[@]} $output_dir \'ALN\'\n')
		# elif option == 'MSA':
		# 	myfile.write('python $global_dir/lib/Model_predict.py $db_tool_dir $fasta ${models_dir[@]} $output_dir \'MSA\'\n')

		
if __name__=="__main__":
	parser = argparse.ArgumentParser()
	parser.description="DNCON4 - The best protein contact predictor in the world."
	parser.add_argument("-f", "--fasta", help="input fasta file",type=is_file,required=True)
	parser.add_argument("-o", "--outdir", help="output folder",type=str,required=True)
	parser.add_argument("-dm", "--domain", help="combine with domain(True/False)",type=bool, default=False, required=False)


	args = parser.parse_args()
	fasta = args.fasta
	outdir = args.outdir
	DM_FLAG = args.domain

	chkdirs(outdir)
	#copy fasta to outdir
	os.system('cp %s %s'%(fasta, outdir))
	fasta_file = fasta.split('/')[-1]
	fasta_name = fasta_file.split('.')[0]
	fasta = os.path.join(outdir, fasta_file) # is the full path of fasta

	#generate shell file
	aln_shell_file =  outdir + '/shell/DNCON4_aln.sh'
	msa_shell_file =  outdir + '/shell/DNCON4_msa.sh'
	generate_pred_shell(aln_shell_file, outdir, fasta_name, 'ALN')
	generate_pred_shell(msa_shell_file, outdir, fasta_name, 'MSA')

	#run for distance prediction need run domain here

	print('Subprocess the deepaln and deepmsa pipline!')
	aln_proc = Process(target=run_shell_file, args=(aln_shell_file,))
	msa_proc = Process(target=run_shell_file, args=(msa_shell_file,))
	aln_proc.start()
	msa_proc.start()
	aln_proc.join()
	msa_proc.join()
	#ensemble
	cmap_dir = ensemble_aln_msa(fasta_name, outdir)
	#combine with domain
	# if DM_FLAG:
		# combine_dm_fl()