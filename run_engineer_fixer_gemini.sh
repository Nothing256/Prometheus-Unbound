#!/bin/bash

export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890
echo ">>> [Conductor] Magic Proxy Activated!"

# ================= 配置区 (Config Area) =================
PROJ=${1:-"Lang"}          # 参数1: 项目名 (必填)
ID=${2:-"1"}               # 参数2: Bug ID (必填)

# 确保参数存在
if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_engineer_fixer_gemini.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=~/workspace/prometheus_workdir_enlightened
mkdir -p "$WORK_ROOT"

PROJ_SUBDIR=""


# ================= 核心：项目特性“配置中心” (The Brain) =================
case "$PROJ" in
    "JacksonDatabind")
        TEMPLATE_FILE="pom.template.jackson_databind.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**CRITICAL ENV NOTE:** \n1. **Java 6 Target:** This project targets Java 6. STRICTLY NO diamond operators \`<>\`, try-with-resources, or lambdas. Use explicit types.\n2. **Troubleshooting:** If you encounter a 'Duplicate Class' error regarding \`PackageVersion.java\` during compilation, it means the generated source conflicts with the existing source. **ACTION:** Delete the file in \`src/main/java/.../PackageVersion.java\` to resolve it."
        ;;
    "Jsoup")
        TEMPLATE_FILE="pom.template.jsoup.xml"
        BUILD_XML_PATH="maven-build.xml" 
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \`Jsoup\`. It depends on \`commons-lang\`. The provided POM handles this."
        ;;
    "Mockito")
        TEMPLATE_FILE="pom.template.mockito.xml"
        BUILD_XML_PATH="build.xml" 
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \`Mockito\`. It has complex dependencies (Objenesis, Hamcrest, ASM). The provided POM handles them. It also excludes some legacy tests that fail to compile on modern Java."
        ;;
    "Gson")
        TEMPLATE_FILE="pom.template.standard.xml" 
        BUILD_XML_PATH="gson/maven-build.xml"     
        PROJ_SUBDIR="gson"                        
        SPECIAL_NOTE="**Project Note:** This project has a nested structure. Source code and POM are in the \`gson/\` subdirectory. The build script \`gson/maven-build.xml\` controls the classpath."
        ;;
    "JxPath")
        TEMPLATE_FILE="pom.template.jxpath.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \`Commons JXPath\`. It uses legacy directory structure (\`src/java\`) and depends on \`JDOM\` and \`Servlet\` APIs. The provided POM handles these."
        ;;
    "Codec")
        TEMPLATE_FILE="pom.template.codec.xml" 
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \`Commons Codec\`. Note that it relies on \`Commons Lang3\` for some tests. The provided POM already includes this dependency."
        ;;
    "Time")
        TEMPLATE_FILE="pom.template.time.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Build Note:** This project uses \`Joda-Time\`. Ensure resources (like timezone data) are correctly handled. The provided POM handles \`maven-antrun-plugin\` for this purpose."
        ;;
    "Chart")
        TEMPLATE_FILE="pom.template.chart.xml"
        BUILD_XML_PATH="ant/build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Structure Note:** This is a legacy project. Source code is in \`source/\` and tests are in \`tests/\`. The build script is located at \`ant/build.xml\`."
        ;;
    "Math")
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Build Note:** The project uses a shared \`pom.xml\` template. You may notice mismatching Artifact IDs (e.g., commons-lang3). Please IGNORE these mismatches."
        ;;
    *)
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
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
ENG_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer_gemini"
FIX_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer_gemini"

ENG_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_engineer_gemini.jsonl"
FIX_LOG="${WORK_ROOT}/${DIR_PREFIX}_${ID}_fixer_gemini.jsonl"

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
Hello, Gemini. You are an expert build engineer and QA specialist.

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

echo ">>> [Engineer] Gemini is building..."
gemini -y --output-format stream-json -p "$(cat engineer_prompt.txt)" > "$ENG_LOG"

# 检查 Engineer 产出（使用 find，因为聪明的 Agent 可能会为了适配 Maven 而移动目录）
echo ">>> [Conductor] Verifying Engineer output..."
FOUND_RUNNER=$(find "$ENG_DIR/$TEST_ROOT" -name "CucumberTest.java" | head -n 1)

if [ -z "$FOUND_RUNNER" ]; then
    echo ">>> [Conductor] Engineer Failed! No Test Runner found in $ENG_DIR/$TEST_ROOT"
    exit 1
else
    echo ">>> [Conductor] Confirmed: Test Runner found at [${FOUND_RUNNER#$ENG_DIR/}]"
fi

# -----------------------------------------------------------------------------
# 阶段三：修复师 (The Fixer) 准备工作 - 全兼容版 (支持 Gson 嵌套)
# -----------------------------------------------------------------------------
echo ">>> [Conductor] Phase 3: Fixer (The Enlightened Repair)..."

rm -rf "$FIX_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$FIX_DIR"

# 【关键点 1】定义锚点目录
# 如果 PROJ_SUBDIR 有值(如 gson)，则锚点在子目录；否则就在根目录
FIX_ANCHOR="${FIX_DIR}/${PROJ_SUBDIR:-.}"
ENG_ANCHOR="${ENG_DIR}/${PROJ_SUBDIR:-.}"

# 1. 继承核心配置 (pom.xml)
echo ">>> [Conductor] Inheriting POM from ${PROJ_SUBDIR:-root}..."
cp "${ENG_ANCHOR}/pom.xml" "${FIX_ANCHOR}/"

# 2. 同步测试环境 (全路径感知)
echo ">>> [Conductor] Synchronizing test environment..."

# [情况 A] 工程师建立了 src/test/java 结构 (无论是在根部还是嵌套子目录)
if [ -d "${ENG_ANCHOR}/src/test/java" ]; then
    echo "    Detected evolved structure: src/test/java"
    mkdir -p "${FIX_ANCHOR}/src/test"
    rm -rf "${FIX_ANCHOR}/src/test/java"
    cp -r "${ENG_ANCHOR}/src/test/java" "${FIX_ANCHOR}/src/test/"
fi

# [情况 B] 同步测试资源 (requirement.feature)
if [ -d "${ENG_ANCHOR}/src/test/resources" ]; then
    echo "    Syncing test resources..."
    mkdir -p "${FIX_ANCHOR}/src/test"
    rm -rf "${FIX_ANCHOR}/src/test/resources"
    cp -r "${ENG_ANCHOR}/src/test/resources" "${FIX_ANCHOR}/src/test/"
fi

# [情况 C] 兼容性：处理非 java/ 结构的项目 (如 Lang/Math/Chart)
if [ ! -d "${ENG_ANCHOR}/src/test/java" ]; then
    # 注意：这里的 $TEST_ROOT 是 defects4j 导出的路径，已经包含了子目录(如 gson/src/test)
    echo "    Syncing standard TEST_ROOT: $TEST_ROOT"
    # 使用 ./ 指令防止 cp 产生嵌套目录
    mkdir -p "$FIX_DIR/$TEST_ROOT"
    cp -rf "$ENG_DIR/$TEST_ROOT/." "$FIX_DIR/$TEST_ROOT/"
fi

# 3. 活文档保底机制
# 无论如何，我们要确保 requirement.feature 出现在 Fixer 需要的地方
if [ ! -f "${FIX_ANCHOR}/src/test/resources/requirement.feature" ]; then
    echo "    Checking for misplaced requirement.feature..."
    # 递归搜索整个工程目录找这个文件，这招最狠！
    FEAT_LOC=$(find "$ENG_DIR" -name "requirement.feature" | head -n 1)
    if [ -n "$FEAT_LOC" ]; then
        mkdir -p "${FIX_ANCHOR}/src/test/resources"
        cp "$FEAT_LOC" "${FIX_ANCHOR}/src/test/resources/"
    fi
fi

cd "$FIX_DIR" || exit
echo ">>> [Conductor] Fixer environment ready for project: ${PROJ}"

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