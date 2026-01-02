#!/bin/bash
# -----------------------------------------------------------------------------
# Script: collect_enlightened_results.sh
#
# Purpose:
#   Collects the "Enlightened Fix" artifacts (requirement.feature and
#   enlightened_fix.patch) for bugs that failed the blind fix and were
#   re-run with the Architect -> Engineer -> Fixer pipeline.
#
#   It places these artifacts into the existing inspection directories
#   created by 'prepare_inspection_round5.sh' without re-generating
#   the ground truth files.
# -----------------------------------------------------------------------------

# ================= 配置区 (Config Area) =================
#  *** 关键：在这里填入跑了 Enlightened 流程的 Bug ID ***
#  例如，如果 blind fix 里的 5, 8, 12 失败了，就填 "5 8 12"
# BUGS="5 8 12" # <--- EDIT THIS LIST!
BUGS="90 92 93 97 98 103 28" # <--- EDIT THIS LIST!
PROJ="Math"

# --- 目录定义 (Directory Definitions) ---
# 1. 证物存放的目标根目录 (The Destination)
INSPECTION_ROOT="" # <--- EDIT THIS PATH!

# 2. Enlightened 流程的工作产出根目录 (The Source)
ENLIGHTENED_WORK_ROOT="" # <--- EDIT THIS PATH!
# =========================================================

echo ">>> [Collector] Starting collection of Enlightened evidence..."

# 主循环
for id in $BUGS; do
    echo ">>> Processing ${PROJ}-${id}..."

    # 1. 定位目标案件目录 (Destination)
    CASE_DIR="${INSPECTION_ROOT}/${PROJ}-${id}"

    # 检查案件目录是否存在，如果不存在则跳过
    if [ ! -d "$CASE_DIR" ]; then
        echo "    --> WARNING: Inspection directory not found at '$CASE_DIR'. Skipping."
        echo "    --> Please run 'prepare_inspection_round5.sh' for this bug first."
        continue
    fi

    # 2. 定位源文件路径 (Source)
    DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')

    # Architect 的产出目录 (存放 .feature 文件)
    ARCH_DIR="${ENLIGHTENED_WORK_ROOT}/${DIR_PREFIX}_${id}_architect"
    FEATURE_FILE="${ARCH_DIR}/requirement.feature"

    # Fixer 的产出目录 (存放 .patch 文件)
    FIX_DIR="${ENLIGHTENED_WORK_ROOT}/${DIR_PREFIX}_${id}_fixer"
    ENLIGHTENED_PATCH="${FIX_DIR}/enlightened_fix.patch"

    # 3. 开始收集证物 (The Collection)
    echo "    -> Collecting requirement.feature..."
    if [ -f "$FEATURE_FILE" ]; then
        cp "$FEATURE_FILE" "$CASE_DIR/requirement.feature"
        echo "       ... Done."
    else
        echo "       ... MISSING! File not found at '$FEATURE_FILE'."
    fi

    echo "    -> Collecting enlightened_fix.patch..."
    if [ -f "$ENLIGHTENED_PATCH" ]; then
        # 命名为 qwen_enlightened.patch 以示区分
        cp "$ENLIGHTENED_PATCH" "$CASE_DIR/qwen_enlightened.patch"
        echo "       ... Done."
    else
        echo "       ... MISSING! File not found at '$ENLIGHTENED_PATCH'."
    fi

    echo ">>> Finished ${PROJ}-${id}."
    echo "---------------------------------"
done

echo ">>> [Collector] All tasks complete."