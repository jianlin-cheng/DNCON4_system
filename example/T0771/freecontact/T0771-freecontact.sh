#!/bin/bash
export LD_LIBRARY_PATH=/storage/htc/bdm/zhiye/DNCON4_db_tools/tools/boost_1_55_0/lib/:/storage/htc/bdm/zhiye/DNCON4_db_tools/tools/OpenBLAS:$LD_LIBRARY_PATH

touch freecontact.running
echo "running freecontact .."
/storage/htc/bdm/zhiye/DNCON4_db_tools/tools/freecontact-1.0.21/bin/freecontact < T0771.aln > T0771.freecontact.rr
if [ -s "T0771.freecontact.rr" ]; then
   mv freecontact.running freecontact.done
   echo "freecontact job done."
   exit
fi
echo "freecontact failed!"
mv freecontact.running freecontact.failed
