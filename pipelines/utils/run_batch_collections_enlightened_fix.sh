#!/bin/bash
# run_batch_collections_enlightened_fix.sh

BUGS="4 8 11 15 20 27"

for id in $BUGS; do
    echo "----------------------------------------------------------------"
    echo ">>> [Batch Commander] Launching Engineer Fixer on Collections-$id ..."
    echo "----------------------------------------------------------------"
    

    bash run_engineer_fixer.sh Collections "$id"
    
    echo ">>> [Batch Commander] Collections-$id Finished. Cooling down for 2s..."
    sleep 2
done