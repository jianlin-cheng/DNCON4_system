#!/bin/bash
export HHLIB=/storage/htc/bdm/zhiye/DNCON4_db_tools/tools//hhsuite-3.0-beta.3-Linux/build
PATH=$PATH:$HHLIB/bin:$HHLIB/scripts
touch hhb-cov50.running
echo "running hhblits job hhb-cov50.."
/storage/htc/bdm/zhiye/DNCON4_db_tools/tools//hhsuite-3.0-beta.3-Linux/bin/hhblits -i T0990.fasta -d /storage/htc/bdm/zhiye/DNCON4_db_tools/databases//uniclust30_2017_10/uniclust30_2017_10 -oa3m T0990.a3m -cpu 8 -n 3 -diff inf -e 0.001 -id 99 -cov 50 > hhb-cov50-hhblits.log
cp T0990.a3m hhb-cov50.a3m
if [ ! -f "T0990.a3m" ]; then
   mv hhb-cov50.running hhb-cov50.failed
   echo "hhblits job hhb-cov50 failed!"
   exit
fi
egrep -v "^>" T0990.a3m | sed 's/[a-z]//g' > hhb-cov50.aln
if [ -f "hhb-cov50.aln" ]; then
   mv hhb-cov50.running hhb-cov50.done
   echo "hhblits hhb-cov50 job done."
   exit
fi
echo "Something went wrong! hhb-cov50.aln file not present!"
mv hhb-cov50.running hhb-cov50.failed
