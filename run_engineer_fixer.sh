#!/bin/bash

# ================= 配置区 (Config Area) =================
PROJ=${1:-"Lang"}          # 参数1: 项目名 (必填)
ID=${2:-"1"}               # 参数2: Bug ID (必填)

# 确保参数存在
if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_engineer_fixer.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=~/workspace/prometheus_workdir_enlightened
mkdir -p "$WORK_ROOT"

# ================= 核心：项目特性“配置中心” (The Brain) =================
case "$PROJ" in
    "Time")
        TEMPLATE_FILE="pom.template.time.xml"
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE="**Build Note:** This project uses \`Joda-Time\`. Ensure resources (like timezone data) are correctly handled. The provided POM handles \`maven-antrun-plugin\` for this purpose."
        ;;
    "Chart")
        TEMPLATE_FILE="pom.template.chart.xml"
        BUILD_XML_PATH="ant/build.xml"
        SPECIAL_NOTE="**Structure Note:** This is a legacy project. Source code is in \`source/\` and tests are in \`tests/\`. The build script is located at \`ant/build.xml\`."
        ;;
    "Math")
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE="**Build Note:** The project uses a shared \`pom.xml\` template. You may notice mismatching Artifact IDs (e.g., commons-lang3). Please IGNORE these mismatches."
        ;;
    *)
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE=""
        ;;
esac

TEMPLATE_PATH="${WORK_ROOT}/${TEMPLATE_FILE}"

if [ ! -f "$TEMPLATE_PATH" ]; then
    echo ">>> [Error] Template file not found: $TEMPLATE_PATH"
    echo "Please ensure you have created $TEMPLATE_FILE in $WORK_ROOT"
    exit 1
fi

# ================= 目录定义 =================
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
# 注意：这里我们需要引用 Architect 的目录来获取 .feature 文件
ARCH_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_architect"
ENG_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer"
FIX_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer"

ENG_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer.jsonl"
FIX_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer.jsonl"

echo ">>> [Conductor] Starting Mission: ${PROJ}-${ID} (Engineer & Fixer)..."
echo ">>> [Conductor] Strategy Loaded: Template=[$TEMPLATE_FILE], BuildXML=[$BUILD_XML_PATH]"

# 检查 Architect 的产出是否存在
if [ ! -f "$ARCH_DIR/requirement.feature" ]; then
    echo ">>> [CRITICAL ERROR] Architect output not found!"
    echo ">>> Missing: $ARCH_DIR/requirement.feature"
    echo ">>> Please run the Architect script (Gemini) first."
    exit 1
fi

# -----------------------------------------------------------------------------
# 阶段二：工程师 (The Engineer)
# -----------------------------------------------------------------------------
echo ">>> [Conductor] Phase 2: Engineer (Environment & Sandwich Test)..."

rm -rf "$ENG_DIR"
# 1. 先检出代码！
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ENG_DIR"
# 2. 必须进入目录！
cd "$ENG_DIR" || exit

# ==============================================================================
# 关键修复：在进入目录后，才开始情报收集！
# ==============================================================================
echo ">>> [Engineer] Scouting metadata (Inside Project)..."
SRC_ROOT=$(defects4j export -p dir.src.classes)
TEST_ROOT=$(defects4j export -p dir.src.tests)
TRIGGER_TEST=$(defects4j export -p tests.trigger | head -n 1)
MODIFIED_CLASS=$(defects4j export -p classes.modified | head -n 1)

# 智能路径推断
BUGGY_CLASS_PATH=$(echo "$MODIFIED_CLASS" | tr '.' '/')
SOURCE_FILE="${SRC_ROOT}/${BUGGY_CLASS_PATH}.java"

TEST_CLASS_NAME=$(echo "$TRIGGER_TEST" | cut -d ':' -f 1)
TEST_CLASS_FILE_PATH=$(echo "$TEST_CLASS_NAME" | tr '.' '/')
TEST_FILE="${TEST_ROOT}/${TEST_CLASS_FILE_PATH}.java"

TARGET_PACKAGE_DIR=$(dirname "$BUGGY_CLASS_PATH")
TARGET_PACKAGE_NAME=$(echo "$TARGET_PACKAGE_DIR" | tr '/' '.')

echo "    Target Package: $TARGET_PACKAGE_NAME"
echo "    Source File:    $SOURCE_FILE"
# ==============================================================================

# 复制 Architect 的遗产
cp "$ARCH_DIR/requirement.feature" "$ENG_DIR/"
cp "$TEMPLATE_PATH" "$ENG_DIR/"

# 生成 Engineer Prompt
cat <<EOF > engineer_prompt.txt
Hello, Qwen. You are an expert build engineer and QA specialist.

Your mission is to set up a \`Cucumber\` test environment and verify that the living documentation accurately reproduces the **original** bug.

**Context:**
*   \`@{$TEMPLATE_FILE}\` (This is the specific template for Project ${PROJ})
*   \`@{requirement.feature}\`
*   **Target Package:** \`${TARGET_PACKAGE_NAME}\` (Place your Cucumber runner here)
*   **Legacy Build Script:** \`${BUILD_XML_PATH}\`

${SPECIAL_NOTE}

**Workflow:**

1.  **Environment Setup:** \`export TZ='America/Los_Angeles'\`.

2.  **Establish Baseline:**
    *   Run \`defects4j test\`.
    *   Observe the failure.

3.  **POM Configuration:** Replace \`pom.xml\` with \`@{$TEMPLATE_FILE}\`.

4.  **File Creation:**
    *   Move \`requirement.feature\` to \`src/test/resources/\`.
    *   Create \`${TEST_ROOT}/${TARGET_PACKAGE_DIR}/CucumberTest.java\` (JUnit runner).
    *   Create \`${TEST_ROOT}/${TARGET_PACKAGE_DIR}/steps/StepDefs.java\` (Glue code).
    *   **CRITICAL:** Ensure the package declaration matches \`${TARGET_PACKAGE_NAME}\`. Use \`try-catch\` for exception testing.

5.  **The Temporal Bridge:**
    *   Run \`mvn dependency:build-classpath -Dmdep.outputFile=classpath.txt\`.
    *   Read \`classpath.txt\` and append its content to the \`d4j.tests.extras\` property in \`defects4j.build.properties\`.
    *   **Patch Target:** \`${BUILD_XML_PATH}\`
    *   **Action:** Add \`<pathelement path="\${d4j.tests.extras}"/>\` inside the test classpath in \`${BUILD_XML_PATH}\`.

6.  **Verification Phase 1 (The Trap):**
    *   Run \`defects4j compile\`.
    *   Run \`mvn test -Dtest=CucumberTest\`.
    *   **Success Condition 1:** The test run completes, and the scenarios related to the bug **FAIL**.

7.  **Verification Phase 2 (The Proof - The Sandwich):**
    *   **CRITICAL STEP:** Switch to the FIXED version to prove the requirement is correct.
    *   Execute: \`defects4j checkout -p ${PROJ} -v ${ID}f -w /tmp/${DIR_PREFIX}_${ID}_fixed_verification\`.
    *   Copy your \`pom.xml\`, \`src/test/resources\`, and \`${TEST_ROOT}\` to \`/tmp/${DIR_PREFIX}_${ID}_fixed_verification\`.
    *   Navigate to \`/tmp/${DIR_PREFIX}_${ID}_fixed_verification\`.
    *   **Re-apply The Temporal Bridge:**
        *   **IMPORTANT:** Since this directory is outside your workspace, **DO NOT use the \`write_file\` or \`replace\` tools.** They will fail.
        *   **MUST USE:** Use \`run_shell_command\` with \`sed\` or \`echo\` to modify \`${BUILD_XML_PATH}\` and \`defects4j.build.properties\`.
    *   Run \`defects4j compile\` and \`mvn test -Dtest=CucumberTest\`.
    *   **Success Condition 2:** The test run completes, and **ALL scenarios PASS**.

8.  **Final Report:**
    *   If Phase 1 fails (as expected) and Phase 2 passes, Report **SUCCESS**.
    *   **STOP HERE.**

Please proceed.
EOF

echo ">>> [Engineer] Qwen is building..."
qwen -y --output-format stream-json -p "$(cat engineer_prompt.txt)" > "$ENG_LOG"

# 检查 Engineer 产出
if [ ! -f "${TEST_ROOT}/${TARGET_PACKAGE_DIR}/CucumberTest.java" ]; then
    echo ">>> [Conductor] Engineer Failed! No Test Runner found."
    exit 1
fi

# -----------------------------------------------------------------------------
# 阶段三：修复师 (The Fixer)
# -----------------------------------------------------------------------------
echo ">>> [Conductor] Phase 3: Fixer (The Enlightened Repair)..."

rm -rf "$FIX_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$FIX_DIR"
cp "$ENG_DIR/pom.xml" "$FIX_DIR/"

# 动态复制测试代码 (Chart/Lang 兼容)
# 注意：TEST_ROOT 可能是 src/test/java 或 tests
# 为了保持结构，我们先创建父目录
FIX_TEST_PARENT=$(dirname "$FIX_DIR/$TEST_ROOT")
mkdir -p "$FIX_TEST_PARENT"
# 直接把 Engineer 里的 TEST_ROOT 目录整个拷过来
cp -r "$ENG_DIR/$TEST_ROOT" "$FIX_TEST_PARENT/"

# 复制活文档
mkdir -p "$FIX_DIR/src/test/resources"
cp -r "$ENG_DIR/src/test/resources/requirement.feature" "$FIX_DIR/src/test/resources/"

cd "$FIX_DIR" || exit

cat <<EOF > fixer_prompt.txt
Hello, Qwen. You are an expert software engineer.

You are working on the \`${PROJ}-${ID}\` project.
We have set up a BDD test environment.

**Context:**
*   **Target File:** \`@{$SOURCE_FILE}\`
*   **Requirement:** \`@{src/test/resources/requirement.feature}\`
*   **Build Script:** \`${BUILD_XML_PATH}\`

${SPECIAL_NOTE}

**Workflow:**

1.  **Environment & State Check (CRITICAL):**
    *   Execute: \`export TZ='America/Los_Angeles'\`.
    *   **Bridge Check:** Ensure \`${BUILD_XML_PATH}\` has the classpath bridge. If not, re-apply it.
    *   **State Check:** Run \`mvn test -Dtest=CucumberTest\`.
    *   **Branching Logic:**
        *   **If FAILS:** Good. Proceed to Step 2.
        *   **If PASSES:** You are on the FIXED version. **REVERT** source code to buggy state:
            *   Execute: \`defects4j checkout -p ${PROJ} -v ${ID}b -w /tmp/raw_buggy_source\`
            *   Execute: \`cp -rf /tmp/raw_buggy_source/${SRC_ROOT}/* ${SRC_ROOT}/\` (Overwrite current source with buggy source).
            *   Run \`mvn test -Dtest=CucumberTest\` again. It **MUST** now fail.

2.  **The Enlightened Repair:**
    *   **Fix:** Modify \`Target File\` to satisfy the Requirement.
    *   **Constraint:** Derive fix **strictly** from the requirements.

3.  **Final Verification:**
    *   Run \`mvn test -Dtest=CucumberTest\`.
    *   **Success Condition:** All scenarios must **PASS**.

4.  **Deliver:**
    *   Once the tests pass, generate a focused patch file.
    *   Execute: \`git diff @{$SOURCE_FILE} > enlightened_fix.patch\`
    *   **Verify:** Ensure the patch does NOT contain changes to \`pom.xml\` or \`build.xml\`.

Please proceed.
EOF

echo ">>> [Fixer] Qwen is repairing..."
qwen -y --output-format stream-json -p "$(cat fixer_prompt.txt)" > "$FIX_LOG"

if [ -f "enlightened_fix.patch" ]; then
    echo ">>> [Conductor] MISSION ACCOMPLISHED!"
else
    echo ">>> [Conductor] Fixer Failed!"
    exit 1
fi