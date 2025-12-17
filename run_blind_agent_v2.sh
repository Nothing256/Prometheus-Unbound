#!/bin/bash


export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
echo ">>> [Conductor] Magic Proxy Activated!"

# ================= 配置区 (Config Area) =================
PROJ=${1:-"Lang"}          # 参数1: 项目名
ID=${2:-"1"}               # 参数2: Bug ID

if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_blind_agent_v2.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=~/workspace/prometheus_workdir
mkdir -p "$WORK_ROOT"

# ================= 核心：项目特性“情报中心” (The Intelligence Hub) =================
# 虽然盲测不需要 pom 模版，但它需要知道“环境特性”
case "$PROJ" in
    "Time")
        SPECIAL_NOTE="**Project Context:** This is the \`Joda-Time\` project. It deals heavily with dates, times, and timezones. Be aware of time-related logic."
        ;;
    "Chart")
        SPECIAL_NOTE="**Project Context:** This is \`JFreeChart\`. Note that the source code is located in \`source/\` (not src/main/java) and tests are in \`tests/\`. The build system is Ant-based."
        ;;
    "Math")
        SPECIAL_NOTE="**Project Context:** This is \`Commons Math\`. It involves complex numerical algorithms."
        ;;
    *)
        SPECIAL_NOTE=""
        ;;
esac

# ================= 目录定义 =================
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
WORK_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_blind_auto"
LOG_FILE="${WORK_ROOT}/${DIR_PREFIX}_${ID}_blind.jsonl"

echo ">>> [Conductor] Starting BLIND Mission: ${PROJ}-${ID}..."

# 1. 准备环境
rm -rf "$WORK_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$WORK_DIR"
cd "$WORK_DIR" || exit

# 2. 自动情报收集 (Auto-Reconnaissance)
echo ">>> [Conductor] Extracting Metadata..."
SRC_ROOT=$(defects4j export -p dir.src.classes)
TEST_ROOT=$(defects4j export -p dir.src.tests)
TRIGGER_TEST=$(defects4j export -p tests.trigger | head -n 1)
MODIFIED_CLASS=$(defects4j export -p classes.modified | head -n 1)

# 3. 路径推断
BUGGY_CLASS_PATH=$(echo "$MODIFIED_CLASS" | tr '.' '/')
BUGGY_FILE="${SRC_ROOT}/${BUGGY_CLASS_PATH}.java"

TEST_CLASS_NAME=$(echo "$TRIGGER_TEST" | cut -d ':' -f 1)
TEST_CLASS_PATH=$(echo "$TEST_CLASS_NAME" | tr '.' '/')
TEST_FILE="${TEST_ROOT}/${TEST_CLASS_PATH}.java"

echo "    Target File: $BUGGY_FILE"
echo "    Test File:   $TEST_FILE"

# 4. 生成 Prompt (V2.0 - Context Aware)
cat <<EOF > blind_prompt.txt
Hello, Gemini. You are an expert software engineer performing a bug fix task in a \`Defects4J\` environment.

**Environment & Tools:**
*   **Build System:** You are in a legacy environment. You **must** use \`defects4j\` commands.
    *   Compile: \`defects4j compile\`
    *   Test: \`defects4j test -t <test_class>::<test_method>\`
*   **System Timezone:** The environment is set to **'America/Los_Angeles'**.

${SPECIAL_NOTE}

**Your Goal:**
Provide a patch in the standard \`diff\` format that fixes the bug exposed by the triggering test.

**Context:**
1.  **Buggy File:** \`@{$BUGGY_FILE}\`
2.  **Triggering Test:** \`$TRIGGER_TEST\` (Located at \`@{$TEST_FILE}\`)

**Recommended Workflow:**
1.  **Setup:** Execute \`export TZ='America/Los_Angeles'\`.
2.  **Verify:** Run the triggering test to confirm the failure.
3.  **Analyze:** Read the provided code to understand the root cause.
4.  **Fix:** Apply your fix to the buggy file.
5.  **Test:** Run the triggering test again to verify your fix.
6.  **Deliver:** Output the patch in standard \`diff\` format to \`blind_fix.patch\`.

Please proceed.
EOF

# 5. 执行 Agent
echo ">>> [Blind Agent] Gemini is working..."
gemini -y --output-format stream-json -p "$(cat blind_prompt.txt)" > "$LOG_FILE"

# 6. 结果验收
if [ -f "blind_fix.patch" ]; then
    echo ">>> [Conductor] SUCCESS! Blind patch generated."
    echo ">>> Patch location: $WORK_DIR/blind_fix.patch"
else
    echo ">>> [Conductor] FAILURE! No patch found."
    exit 1
fi