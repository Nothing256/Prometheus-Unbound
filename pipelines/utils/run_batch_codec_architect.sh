#!/bin/bash
# run_batch_codec_architect.sh

# 这里的列表就是上面整理出来的
BUGS="2 4 6 8 10 14 16" # <--- EDIT THIS LIST!

for id in $BUGS; do
    echo "----------------------------------------------------------------"
    echo ">>> [Batch Commander] Launching Architect Gemini on Codec-$id ..."
    echo "----------------------------------------------------------------"
    

    bash run_architect.sh Codec "$id"
    
    echo ">>> [Batch Commander] Codec-$id Finished. Cooling down for 2s..."
    sleep 2
done