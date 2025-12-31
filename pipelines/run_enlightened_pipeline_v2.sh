#!/bin/bash


export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
echo ">>> [Conductor] Magic Proxy Activated!"

# ================= 配置区 (Config Area) =================
PROJ=${1:-"Lang"}          # 参数1: 项目名 (必填)
ID=${2:-"1"}               # 参数2: Bug ID (必填)

# 确保参数存在
if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_pipeline_v2.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=~/workspace/prometheus_workdir
mkdir -p "$WORK_ROOT"

# ================= 核心：项目特性“配置中心” (The Brain) =================
# 根据项目名，自动切换“武器”和“地图”
case "$PROJ" in
    "Time")
        TEMPLATE_FILE="pom.template.time.xml" # Time 专用模版
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE="**Build Note:** This project uses \`Joda-Time\`. Ensure resources (like timezone data) are correctly handled. The provided POM handles \`maven-antrun-plugin\` for this purpose."
        ;;
    "Chart")
        TEMPLATE_FILE="pom.template.chart.xml" # Chart 专用模版
        BUILD_XML_PATH="ant/build.xml"         # !!! Chart 的 build.xml 藏在 ant/ 目录下
        SPECIAL_NOTE="**Structure Note:** This is a legacy project. Source code is in \`source/\` and tests are in \`tests/\`. The build script is located at \`ant/build.xml\`."
        ;;
    "Math")
        TEMPLATE_FILE="pom.template.standard.xml" # Math 用通用的 (暂定)
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE="**Build Note:** The project uses a shared \`pom.xml\` template. You may notice mismatching Artifact IDs (e.g., commons-lang3). Please IGNORE these mismatches."
        ;;
    *)
        # 默认为 Lang 或其他标准结构
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        SPECIAL_NOTE=""
        ;;
esac

TEMPLATE_PATH="${WORK_ROOT}/${TEMPLATE_FILE}"

# 检查模版是否存在
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo ">>> [Error] Template file not found: $TEMPLATE_PATH"
    echo "Please ensure you have created $TEMPLATE_FILE in $WORK_ROOT"
    exit 1
fi

# ================= 目录定义 =================
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
ARCH_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_architect"
ENG_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer"
FIX_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer"

ARCH_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_architect.jsonl"
ENG_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer.jsonl"
FIX_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer.jsonl"

echo ">>> [Conductor] Starting Mission: ${PROJ}-${ID}..."
echo ">>> [Conductor] Strategy Loaded: Template=[$TEMPLATE_FILE], BuildXML=[$BUILD_XML_PATH]"

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

**FINAL INSTRUCTION:**
Once you have generated and saved the \`requirement.feature\` file, **STOP**.
**DO NOT** attempt to create test runners, step definitions, or fix the code yet. Your job in this phase is **ONLY** to define the requirement.

Please proceed.
EOF

# 5. 执行 Architect
echo ">>> [Architect] Gemini is thinking..."
gemini -y --output-format stream-json -p "$(cat architect_prompt.txt)" > "$ARCH_LOG"

if [ ! -f "requirement.feature" ]; then
    echo ">>> [Conductor] Architect Failed! No feature file."
    exit 1
fi

# -----------------------------------------------------------------------------
# 阶段二：工程师 (The Engineer)
# -----------------------------------------------------------------------------
echo ">>> [Conductor] Phase 2: Engineer (Environment & Sandwich Test)..."

rm -rf "$ENG_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ENG_DIR"
cp "$ARCH_DIR/requirement.feature" "$ENG_DIR/"
cp "$TEMPLATE_PATH" "$ENG_DIR/"
cd "$ENG_DIR" || exit

cat <<EOF > engineer_prompt.txt
Hello, Gemini. You are an expert build engineer and QA specialist.

Your mission is to set up a \`Cucumber\` test environment and verify that the living documentation accurately reproduces the **original** bug.

**Context:**
*   \`@{pom.template.xml}\` (This is the specific template for Project ${PROJ})
*   \`@{requirement.feature}\`
*   **Target Package:** \`${TARGET_PACKAGE_NAME}\` (Place your Cucumber runner here)
*   **Legacy Build Script:** \`${BUILD_XML_PATH}\`

${SPECIAL_NOTE}

**Workflow:**

1.  **Environment Setup:** \`export TZ='America/Los_Angeles'\`.

2.  **Establish Baseline:**
    *   Run \`defects4j test\`.
    *   Observe the failure.

3.  **POM Configuration:** Replace \`pom.xml\` with \`pom.template.xml\`.

4.  **File Creation:**
    *   Move \`requirement.feature\` to \`src/test/resources/\`.
    *   Create \`src/test/java/${TARGET_PACKAGE_DIR}/CucumberTest.java\` (JUnit runner).
    *   Create \`src/test/java/${TARGET_PACKAGE_DIR}/steps/StepDefs.java\` (Glue code).
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

echo ">>> [Engineer] Gemini is building..."
gemini -y --output-format stream-json -p "$(cat engineer_prompt.txt)" > "$ENG_LOG"

if [ ! -f "src/test/java/${TARGET_PACKAGE_DIR}/CucumberTest.java" ]; then
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

# 复制测试代码
if [ "$PROJ" == "Chart" ]; then
    cp -r "$ENG_DIR/tests" "$FIX_DIR/"
else
    # Lang, Math, Time (标准结构)
    cp -r "$ENG_DIR/src/test" "$FIX_DIR/src/"
fi

# 复制活文档 (它总是我们在 Engineer 阶段创建的，位置固定)
mkdir -p "$FIX_DIR/src/test/resources"
cp -r "$ENG_DIR/src/test/resources/requirement.feature" "$FIX_DIR/src/test/resources/"
cd "$FIX_DIR" || exit

cat <<EOF > fixer_prompt.txt
Hello, Gemini. You are an expert software engineer.

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

echo ">>> [Fixer] Gemini is repairing..."
gemini -y --output-format stream-json -p "$(cat fixer_prompt.txt)" > "$FIX_LOG"

if [ -f "enlightened_fix.patch" ]; then
    echo ">>> [Conductor] MISSION ACCOMPLISHED!"
else
    echo ">>> [Conductor] Fixer Failed!"
    exit 1
fi