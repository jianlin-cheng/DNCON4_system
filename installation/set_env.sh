#!/bin/bash -e
# module load python/python-3.5.2
temp_dir=$(pwd)
gloable_dir=${temp_dir%%DNCON4*}'DNCON4'
env_dir=$gloable_dir/env/
echo install virtual environment to $env_dir
cd $env_dir
rm -rf dncon4_virenv
pyvenv dncon4_virenv
source $env_dir/dncon4_virenv/bin/activate
pip install --upgrade pip
pip install keras==2.1.6
pip install numpy==1.15.2
pip install matplotlib
pip install scipy
pip install numba
pip install --upgrade h5py
## on multicom use tf1.5, on lewis use tf1.9
sysOS=`uname -n`
str1="lewis"
str2="multicom"
if [[ $sysOS == $str1* ]];then
        echo "On lewis"
        pip install tensorflow-gpu==1.9.0
elif [[ $sysOS == $str2* ]];then
        echo "On multicom"
        pip install tensorflow-gpu==1.5.0
else
        echo "Other Platform: $sysOS"
        pip install tensorflow-gpu==1.5.0
fi
pip install --upgrade pillow
mkdir -p ~/.keras
cp ~/.keras/keras.json ~/.keras/keras.json.bk
cp $gloable_dir/installation/keras.json.dncon4 ~/.keras/keras.json
echo "installed" > $env_dir/dncon4_env_install.done
echo virtual environment installed succesful!