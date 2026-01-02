#!/bin/bash
# 批量准备验收材料

# 这里填入 Bug 的 ID
BUGS="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18" # <--- EDIT THIS LIST!

PROJ="Codec" # <--- EDIT THE PROJECT NAME!

INSPECTION_ROOT="" # <--- EDIT THIS PATH!
mkdir -p "$INSPECTION_ROOT"

for id in $BUGS; do
    echo ">>> Preparing Evidence for ${PROJ}-${id}..."
    
    # 1. 创建案件目录
    CASE_DIR="${INSPECTION_ROOT}/${PROJ}-${id}"
    mkdir -p "$CASE_DIR"
    
    # 2. 获取 Qwen 的补丁 (假设 Qwen 跑完的目录叫 lang_id_blind_auto)
    QWEN_DIR=/codec_${id}_blind_auto # <--- EDIT THIS PATH! PLEASE NOTICE THAT THE LOWER CASE NAME SHOULD BE CONSISTANT WITH THE PROJ
    if [ -f "$QWEN_DIR/blind_fix.patch" ]; then
        cp "$QWEN_DIR/blind_fix.patch" "$CASE_DIR/qwen.patch"
    else
        echo "MISSING PATCH" > "$CASE_DIR/qwen_FAILED.txt"
    fi
    
    # 3. 获取 Ground Truth (标准答案)
    # 我们临时 checkout 一个 fixed 版本，把修改过的文件拷出来
    TEMP_GT="/tmp/gt_${PROJ}_${id}"
    rm -rf "$TEMP_GT"
    defects4j checkout -p "$PROJ" -v "${id}f" -w "$TEMP_GT" > /dev/null
    
    # 获取修改过的文件列表
    cd "$TEMP_GT"
    MODIFIED_CLASSES=$(defects4j export -p classes.modified)
    SRC_ROOT=$(defects4j export -p dir.src.classes)
    
    for CLASS in $MODIFIED_CLASSES; do
        CLASS_PATH=$(echo "$CLASS" | tr '.' '/')
        FILE_PATH="${SRC_ROOT}/${CLASS_PATH}.java"
        # 复制标准答案源码到案件目录，重命名为 .java.truth
        cp "$TEMP_GT/$FILE_PATH" "$CASE_DIR/$(basename "$FILE_PATH").truth"
    done
    
    echo "Done."
done