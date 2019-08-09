#!/bin/bash
touch ccmpred.running
echo "running ccmpred .."
/storage/htc/bdm/zhiye/DNCON4_db_tools/tools/CCMpred_plm/bin/ccmpred -t 8 T0771.aln T0771.ccmpred T0771.plm > T0771.ccmpred.log
if [ -s "T0771.ccmpred" ]; then
   mv ccmpred.running ccmpred.done
   echo "ccmpred job done."
   exit
fi
echo "ccmpred failed!"
mv ccmpred.running ccmpred.failed
