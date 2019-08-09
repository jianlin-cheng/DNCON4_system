# DNCON4 V1.0
Deep learning for predicting protein contact map

**(1) Download DNCON4 system package (short path is recommended)**

```
git clone https://github.com/jianlin-cheng/DNCON4_system.git

cd DNCON4_system
```

**(2) Activate system python3 environment (required)**

```
if on lewis: sh installation/activate_python3_in_lewis_server.sh

if on multicom: sh installation/activate_python3_in_multicom_server.sh
```

**(3) Configure DNCON4_system (required)**

```
python setup.py

python configure.py
```

**(4) Training the DNCON4 model**
<h5>There are several different single model, below is a demo commad line to run the training shell.</h5>

```

sh train/train_dres34_deepcov_plm_pearson_pssm.sh  
sh train/train_dres34_deepcov_plm_pearson_pssm_lewis.sh

```

**(5) Predict the DNCON4 model on CASP13 (single target, input fasta (should user change the fasta in shell file), ouput rr file**

<h5>Case 1: run individual model</h5>

```

sh predictors/individual/pred_dres152_deepcov_plm_1.sh
sh predictors/individual/pred_dres152_deepcov_plm_1_lewis.sh

Output directory: example/*fasta name*/pred_map0/rr/

```

<h5>Case 2: run ensemble model</h5>

```

sh predictors/ensemble/pred_dncon4_v1.sh
sh predictors/ensemble/pred_dncon4_v1_lewis.sh

Output directory: example/*fasta name*/pred_map_ensem/rr/

```

**(6) Predict and Evaluate the DNCON4 model on CASP13 37 FM domain**

<h5>Case 1: run individual model</h5>

```

sh predictors/individual/evalu_dres152_deepcov_plm_1.sh
sh predictors/individual/evalu_dres152_deepcov_plm_1_lewis.sh

Output directory: predictors/results/PLM/

```

<h5>Case 2: run ensemble model</h5>

```

sh predictors/ensemble/evalu_dncon4_v1.sh
sh predictors/ensemble/evalu_dncon4_v1_lewis.sh

Output directory: predictors/results/ENSEMBLE/

```
