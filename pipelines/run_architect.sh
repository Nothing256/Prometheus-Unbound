#!/bin/bash


export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
echo ">>> [Conductor] Magic Proxy Activated!"

# ================= 配置区 (Config Area) =================
PROJ=${1:-"Lang"}          # 参数1: 项目名 (必填)
ID=${2:-"1"}               # 参数2: Bug ID (必填)

# 确保参数存在
if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_architect.sh <Project> <ID>"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")" 

WORK_ROOT=${HOME}/prometheus_workdir_enlightened
mkdir -p "$WORK_ROOT"



# ================= 目录定义 =================
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
ARCH_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_architect"


ARCH_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_architect.jsonl"

echo ">>> [Conductor] Starting Mission: ${PROJ}-${ID}..."

# -----------------------------------------------------------------------------
# 阶段一：架构师 (The Architect)
# -----------------------------------------------------------------------------
echo ">>> [Conductor] Phase 1: Architect (Reverse Engineering)..."

# 1. 准备环境
rm -rf "$ARCH_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ARCH_DIR"
cd "$ARCH_DIR" || exit

# 2. 自动情报收集 (Auto-Reconnaissance)
echo ">>> [Architect] Scouting metadata..."
SRC_ROOT=$(defects4j export -p dir.src.classes)  # e.g., src/main/java OR source
TEST_ROOT=$(defects4j export -p dir.src.tests)   # e.g., src/test/java OR tests
TRIGGER_TEST=$(defects4j export -p tests.trigger | head -n 1) # e.g., org.apache...TestLang747
MODIFIED_CLASS=$(defects4j export -p classes.modified | head -n 1) # e.g., org.apache...NumberUtils

# 3. 智能路径推断 (The Smart Inference)
# 将包名转为路径: org.apache.commons -> org/apache/commons
BUGGY_CLASS_PATH=$(echo "$MODIFIED_CLASS" | tr '.' '/')
SOURCE_FILE="${SRC_ROOT}/${BUGGY_CLASS_PATH}.java"

# 推断测试文件 (简单截取 :: 前的部分)
TEST_CLASS_NAME=$(echo "$TRIGGER_TEST" | cut -d ':' -f 1)
TEST_CLASS_FILE_PATH=$(echo "$TEST_CLASS_NAME" | tr '.' '/')
TEST_FILE="${TEST_ROOT}/${TEST_CLASS_FILE_PATH}.java"

# *** 关键：自动提取包名路径 (用于生成测试代码) ***
# 我们直接提取 Buggy Class 所在的包路径
# 例如: org.apache.commons.lang3.math.NumberUtils -> org/apache/commons/lang3/math
TARGET_PACKAGE_DIR=$(dirname "$BUGGY_CLASS_PATH")
# 将 / 转换为 . (用于 Java package 声明)
TARGET_PACKAGE_NAME=$(echo "$TARGET_PACKAGE_DIR" | tr '/' '.')

echo "    Target Package: $TARGET_PACKAGE_NAME"
echo "    Source File:    $SOURCE_FILE"

# 4. 生成 Architect Prompt
cat <<EOF > architect_prompt.txt
Hello, Gemini. You are an expert software engineer and a master of Behavior-Driven Development (BDD). Your task is to reverse-engineer the core requirements for a specific buggy functionality within this project.

**Context:**
1.  **The complete source file:** \`@{$SOURCE_FILE}\`
2.  **The complete test suite:** \`@{$TEST_FILE}\`
3.  **Environment Note:** The system environment for reproduction is set to **'America/Los_Angeles'**. (Keep this in mind when analyzing date/time related failures).

Your first step is to analyze the failing test case \`$TRIGGER_TEST\` to identify the specific method or logic in the source file that is causing the failure.

Once you have identified the problematic logic, your main mission is to deduce the *intended, correct* behavior and express it as a “Living Requirement” in the Gherkin/Cucumber BDD format.

This requirement document should be saved to a new file named \`requirement.feature\`.

The generated requirement file must:
1.  **Be focused.** It should only contain \`Feature:\` and \`Scenario:\` blocks related to the buggy functionality.
2.  **Incorporate evidence.** The scenarios should be inspired by the failing test cases.
3.  **Explicitly address the bug.** One scenario must clearly define the correct behavior for the input that is currently causing the failure.
4.  **Keep it MINIMAL.** Focus **ONLY** on the specific logic needed to fix the bug. **DO NOT** describe or imply general refactoring, code cleanup, or stylistic changes.

**FINAL INSTRUCTION (CRITICAL):**
1.  Generate the \`requirement.feature\` file.
2.  **STOP IMMEDIATELY.**
3.  **DO NOT** propose a fix.
4.  Your job is **ONLY** to be the Architect, not the Engineer.

Please proceed.
EOF

# 5. 执行 Architect
echo ">>> [Architect] Gemini is thinking..."
gemini -y --output-format stream-json -p "$(cat architect_prompt.txt)" > "$ARCH_LOG"

if [ ! -f "requirement.feature" ]; then
    echo ">>> [Conductor] Architect Failed! No feature file."
    exit 1
fi
