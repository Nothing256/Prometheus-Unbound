#!/bin/bash

# Configuration
BUGS=(
    "Math 4"
    "Math 63"
)

PIPELINES=(
    "run_group_a_blind.sh"
    "run_group_b_nl.sh"
    "run_group_c_negative.sh"
    "run_group_d_full.sh"
)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

echo "=========================================================="
echo "Starting Micro-Study Batch Execution"
echo "Bugs to process: ${#BUGS[@]}"
echo "Groups to process: ${#PIPELINES[@]}"
echo "Total executions: $((${#BUGS[@]} * ${#PIPELINES[@]}))"
echo "=========================================================="

for bug in "${BUGS[@]}"; do
    read -r proj id <<< "$bug"
    echo ""
    echo "=========================================================="
    echo ">>> Target: ${proj}-${id}"
    echo "=========================================================="
    
    for pipeline_script in "${PIPELINES[@]}"; do
        echo ""
        echo ">>> Executing: $pipeline_script on ${proj}-${id}"
        echo "----------------------------------------------------------"
        bash "${SCRIPT_DIR}/${pipeline_script}" "$proj" "$id"
        echo "----------------------------------------------------------"
        echo ">>> Finished $pipeline_script on ${proj}-${id}"
    done
done

echo ""
echo "=========================================================="
echo ">>> BATCH EXECUTION COMPLETE"
echo "=========================================================="
