#!/bin/bash
# run_batch_jxpath.sh

BUGS="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22"

for id in $BUGS; do
    echo "----------------------------------------------------------------"
    echo ">>> [Batch Commander] Launching Qwen on JxPath-$id ..."
    echo "----------------------------------------------------------------"
    

    bash qwen_run_blind_agent_v2.sh JxPath "$id"
    
    echo ">>> [Batch Commander] JxPath-$id Finished. Cooling down for 2s..."
    sleep 2
done