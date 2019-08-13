import sys,os,glob,re

#configure_file(filepath, filetype, 'feature_dir', db_dir)
def configure_file(filepath, filetype, flag, keyword, db_dir):
    os.chdir(filepath)
    for filename in glob.glob(filepath + '/*.' + filetype):
        temp_in = filename
        print(temp_in)
        temp_out = temp_in+'.tmp'
        f = open(temp_in, 'r')
        tar_flag = False
        change_flag = False
        line_old = None
        line_new = None
        for line in f.readlines():
            if flag in line:
                tar_flag = True
            if keyword in line and tar_flag == True:
                tar_flag = False
                change_flag = True
                line_old = line.strip('\n')
                fix_str = line.strip('\n').split('=')[0]
                line_new = fix_str + '=' + db_dir
                # print(line_old)
                # print(line_new)
        f.close()
        #replace target line
        if change_flag:
            change_flag = False
            f1 = open(temp_in)
            con = f1.read()
            f1.close()
            con_new = con.replace(line_old, line_new)
            f2 = open(temp_out, 'w')
            f2.write(con_new)
            f2.close()
            os.system('mv ' + temp_out + ' ' + temp_in)
            os.system('chmod -R 777 ' + temp_in)

temp_path = sys.path[0]
DNCON4_path = ''
if sys.version_info[0] < 3:
    intall_flag = raw_input("Intall DNCON4 to "+ temp_path +" ? (Yes)")
    if 'Y' in intall_flag or 'y' in intall_flag:
    	DNCON4_path = temp_path
    else:
        sys.exit(1)
    	custom_path = raw_input("Please input the path you want to install...")
    	print("The DNCON4 will be installed to %s, please wait...\n"%custom_path)
    	DNCON4_path = custom_path
else:
    intall_flag = input("Intall DNCON4 to "+ temp_path +" ? (Yes)")
    if 'Y' in intall_flag or 'y' in intall_flag:
        DNCON4_path = temp_path
    else:
        sys.exit(1)
        custom_path = input("Please input the path you want to install...")
        print("The DNCON4 will be installed to %s, please wait...\n"%custom_path)
        DNCON4_path = custom_path
	## copy all file to the custom path, then need to change all shell gloable_dir

install_info_file = DNCON4_path+'/installation/path.inf'
dncon4_db_dir =''
dncon4_train_script=''
dncon4_evalu_ensemble=''
dncon4_evalu_individual=''
dncon4_pred_ensemble=''
dncon4_pred_individual=''
dncon4_feature_generate= ''
if not os.path.exists(install_info_file):
    print("Can't find %s, please check!"%install_info_file)
    sys.exit(1)
else:
    f = open(install_info_file, 'r')
    for line in f.readlines():
        if line.startswith('#'):
            continue
        else:
            if 'db_dir' in line:
                dncon4_db_dir = line.strip('\n').split('=')[1]
                if ' ' in dncon4_db_dir:dncon4_db_dir.replace(' ','')
                if 'none' in dncon4_db_dir:
                	print("Database path hasn't set, please run setup.py!")
                	sys.exit(1)
            elif 'train_script' in line:
                dncon4_train_script = line.strip('\n').split('=')[1]
                if ' ' in dncon4_train_script:dncon4_train_script.replace(' ','')
                dncon4_train_script = DNCON4_path +'/' + dncon4_train_script
            elif 'evalu_ensemble' in line:
                dncon4_evalu_ensemble = line.strip('\n').split('=')[1]
                if ' ' in dncon4_evalu_ensemble:dncon4_evalu_ensemble.replace(' ','')
                dncon4_evalu_ensemble = DNCON4_path +'/' + dncon4_evalu_ensemble
            elif 'evalu_individual' in line:
                dncon4_evalu_individual = line.strip('\n').split('=')[1]
                if ' ' in dncon4_evalu_individual:dncon4_evalu_individual.replace(' ','')
                dncon4_evalu_individual = DNCON4_path +'/' + dncon4_evalu_individual
            elif 'pred_ensemble' in line:
                dncon4_pred_ensemble = line.strip('\n').split('=')[1]
                if ' ' in dncon4_pred_ensemble:dncon4_pred_ensemble.replace(' ','')
                dncon4_pred_ensemble = DNCON4_path +'/' + dncon4_pred_ensemble
            elif 'pred_individual' in line:
                dncon4_pred_individual = line.strip('\n').split('=')[1]
                if ' ' in dncon4_pred_individual:dncon4_pred_individual.replace(' ','')
                dncon4_pred_individual = DNCON4_path +'/' + dncon4_pred_individual
            elif 'feature_generate' in line:
                dncon4_feature_generate = line.strip('\n').split('=')[1]
                if ' ' in dncon4_feature_generate:dncon4_feature_generate.replace(' ','')
                dncon4_feature_generate = DNCON4_path +'/' + dncon4_feature_generate

print("### Find database folder %s"%dncon4_db_dir)
print("configure training script...")
configure_file(dncon4_train_script, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_train_script, 'sh', 'FEATURE_FLAG', 'feature_dir', dncon4_db_dir)
print("configure evaluate ensemble script...")
configure_file(dncon4_evalu_ensemble, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_evalu_ensemble, 'sh', 'FEATURE_FLAG', 'feature_dir', dncon4_db_dir)
print("configure evaluate individual script...")
configure_file(dncon4_evalu_individual, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_evalu_individual, 'sh', 'FEATURE_FLAG', 'feature_dir', dncon4_db_dir)
print("configure predict ensemble script...")
configure_file(dncon4_pred_ensemble, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_pred_ensemble, 'sh', 'DBTOOL_FLAG', 'db_tool_dir', dncon4_db_dir)
print("configure predict individual script...")
configure_file(dncon4_pred_individual, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_pred_individual, 'sh', 'DBTOOL_FLAG', 'db_tool_dir', dncon4_db_dir)
print("configure feature generate script...")
configure_file(dncon4_feature_generate, 'sh', 'GLOBAL_FALG', 'global_dir', DNCON4_path)
configure_file(dncon4_feature_generate, 'sh', 'FEATURE_FLAG', 'feature_dir', dncon4_db_dir)

