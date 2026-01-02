#!/bin/bash

# 功能：Defects4J 缺陷项目快速侦察脚本
# 用法：bash d4j_recon.sh <Project_ID> <Bug_ID>
# 例子：bash d4j_recon.sh Chart 1

# 1. 提取参数
PID=$1
BID=$2

# 检查参数是否存在
if [ -z "$PID" ] || [ -z "$BID" ]; then
    echo "错误: 请输入 Project ID 和 Bug ID。"
    echo "用法: bash $0 <Project_ID> <Bug_ID>"
    exit 1
fi

# 将 PID 转换为小写，用于路径命名 (例如 Chart -> chart)
PID_LOWER=$(echo "$PID" | tr '[:upper:]' '[:lower:]')
RECON_DIR="/tmp/${PID_LOWER}_${BID}_recon"

echo "==========================================="
echo "🚀 正在启动侦察程序: $PID-$BID"
echo "📂 目标目录: $RECON_DIR"
echo "==========================================="

# 第一步：获取情报
echo "📋 [STEP 1/4] 获取项目基本信息..."
defects4j info -p "$PID" -b "$BID"

# 第二步：开辟侦察区
echo "🧹 [STEP 2/4] 清理并创建侦察区..."
rm -rf "$RECON_DIR"

# 第三步：检出 Buggy 版本 (BID + 'b')
echo "🏗️ [STEP 3/4] 检出项目源码 (Checkout $PID ${BID}b)..."
defects4j checkout -p "$PID" -v "${BID}b" -w "$RECON_DIR"

# 第四步：进入目录并获取关键路径情报
echo "🔍 [STEP 4/4] 提取目录结构与失败测试情报..."
cd "$RECON_DIR" || { echo "失败: 无法进入目录 $RECON_DIR"; exit 1; }

echo ""
echo "-------------------------------------------"
echo "📍 源码目录配置 (dir.src.classes):"
defects4j export -p dir.src.classes
echo "-------------------------------------------"

echo "🚫 触发失败的测试 (tests.trigger):"
defects4j export -p tests.trigger
echo "-------------------------------------------"

echo "✅ 侦察任务完成！"