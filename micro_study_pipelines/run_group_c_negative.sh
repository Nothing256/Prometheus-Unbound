#!/bin/bash
export all_proxy=http://127.0.0.1:12001
export PERL5LIB="/Users/nothing/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export PATH="/Users/nothing/.local/bin:/Users/nothing/repository/defects4j/framework/bin:$PATH"

PROJ=${1:-"Lang"}
ID=${2:-"1"}

if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_group_c_negative.sh <Project> <ID>"
    exit 1
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
WORK_ROOT=${HOME}/prometheus_workdir_microstudy
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')

ARCH_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_c_arch"
ENG_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_c_eng"
FIX_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_c_fix"

mkdir -p "$WORK_ROOT"

# ================= 核心：项目特性“配置中心” =================
case "$PROJ" in
    "JacksonXml")
        TEMPLATE_FILE="pom.template.jackson_xml.xml"
        BUILD_XML_PATH="maven-build.xml" 
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \'JacksonXml\'. It depends on \'JacksonDatabind\' and XML libs (Stax, Woodstox). The provided POM handles these."
        ;;
    "JacksonDatabind")
        TEMPLATE_FILE="pom.template.jackson_databind.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**CRITICAL ENV NOTE:** \n1. **Java 6 Target:** This project targets Java 6. STRICTLY NO diamond operators \'<>\', try-with-resources, or lambdas. Use explicit types."
        ;;
    "Jsoup")
        TEMPLATE_FILE="pom.template.jsoup.xml"
        BUILD_XML_PATH="maven-build.xml" 
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \'Jsoup\'. It depends on \'commons-lang\'."
        ;;
    "Mockito")
        TEMPLATE_FILE="pom.template.mockito.xml"
        BUILD_XML_PATH="build.xml" 
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \'Mockito\'. It has complex dependencies (Objenesis, Hamcrest, ASM)."
        ;;
    "Gson")
        TEMPLATE_FILE="pom.template.standard.xml" 
        BUILD_XML_PATH="gson/maven-build.xml"     
        PROJ_SUBDIR="gson"                        
        SPECIAL_NOTE="**Project Note:** This project has a nested structure. Source code and POM are in the \'gson/\' subdirectory."
        ;;
    "JxPath")
        TEMPLATE_FILE="pom.template.jxpath.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \'Commons JXPath\'. It uses legacy directory structure (\'src/java\')."
        ;;
    "Codec")
        TEMPLATE_FILE="pom.template.codec.xml" 
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Project Note:** This is \'Commons Codec\'."
        ;;
    "Time")
        TEMPLATE_FILE="pom.template.time.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Build Note:** This project uses \'Joda-Time\'. Ensure resources are correctly handled."
        ;;
    "Chart")
        TEMPLATE_FILE="pom.template.chart.xml"
        BUILD_XML_PATH="ant/build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Structure Note:** This is a legacy project. Source code is in \'source/\' and tests are in \'tests/\'."
        ;;
    "Math")
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE="**Build Note:** The project uses a shared \'pom.xml\' template."
        ;;
    *)
        TEMPLATE_FILE="pom.template.standard.xml"
        BUILD_XML_PATH="build.xml"
        PROJ_SUBDIR=""
        SPECIAL_NOTE=""
        ;;
esac

# --- 1. ARCHITECT ---
rm -rf "$ARCH_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ARCH_DIR"
cd "$ARCH_DIR" || exit
TRIGGER_TEST=$(defects4j export -p tests.trigger | tr '\n' ' ')

cat <<PROMPT_EOF > architect_prompt.txt
You are an expert software engineer and a master of Behavior-Driven Development (BDD). A bug currently exists in this project. 

**Context:**
* The system environment for reproduction is set to **'America/Los_Angeles'**.
* The following test case currently triggers the bug and fails: \'$TRIGGER_TEST\'

**Your Task:**
1. Use your search and file-reading tools to investigate the codebase. Locate the failing test, trace its execution, and find the buggy logic in the source code.
2. Deduce the *intended, correct* behavior of the buggy logic.
3. Express this intended behavior as a "Living Requirement" in the Gherkin/Cucumber BDD format. Save it to a new file named \'requirement.feature\' in the root directory.

**Constraints:**
* The scenarios must explicitly address the bug and define the correct behavior for the inputs causing the failure.
* Keep it MINIMAL. Do not propose refactoring or structural changes.
* **DO NOT** perform Root Cause Analysis (RCA) or include internal implementation details in the feature file. Describe ONLY the Black-Box Behavior (Given/When/Then).
* **DO NOT** modify any source code to fix the bug. Your job is ONLY to write the specification. Stop immediately after generating \'requirement.feature\'.
PROMPT_EOF

echo ">>> [Conductor] Group C: Architect is writing Gherkin..."
agy --output-format stream-json --add-dir "$ARCH_DIR" --dangerously-skip-permissions --print-timeout 45m --print "$(cat architect_prompt.txt)" > agy_architect.jsonl

if [ ! -f "requirement.feature" ]; then
    echo "Error: Architect failed to generate requirement.feature"
    exit 1
fi

# --- 2. ENGINEER ---
rm -rf "$ENG_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ENG_DIR"
cp "$ARCH_DIR/requirement.feature" "$ENG_DIR/"
cd "$ENG_DIR" || exit

cat <<'EOF_SCRIPT' > verify_negative.sh
#!/bin/bash
defects4j compile > /dev/null 2>&1
export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles'; mvn test -Dtest=CucumberTest
if [ $? -ne 0 ]; then
    echo "VERIFICATION SUCCESS: Cucumber test FAILED on buggy code as expected."
    exit 0
else
    echo "VERIFICATION FAILED: Cucumber test PASSED on buggy code. The specification did not capture the bug."
    exit 1
fi
EOF_SCRIPT
chmod +x verify_negative.sh

cat <<PROMPT_EOF > engineer_prompt.txt
You are an expert QA specialist. We need to execute the BDD specification \'requirement.feature\'.

**Your Task:**
1. Use your tools to find the package path of the original failing test: \'$TRIGGER_TEST\'.
2. Create a JUnit Cucumber runner (\'CucumberTest.java\') and the corresponding glue code (\'StepDefs.java\') in the exact same test package directory as the original failing test.
3. Ensure the project is configured to run Cucumber. Use the absolute path template file \'${PROJECT_ROOT}/templates/${TEMPLATE_FILE}\' as your starting POM configuration. Note: The template may require adjustments for this specific codebase version.
${SPECIAL_NOTE}
4. **The Temporal Bridge:** To ensure the legacy Ant build system (defects4j) can compile your new Cucumber tests, you must bridge the Maven classpath to Ant:
   - Run \'mvn dependency:build-classpath -Dmdep.outputFile=classpath.txt\'
   - Read \'classpath.txt\' and append its content to the \'d4j.tests.extras\' property in \'defects4j.build.properties\'.
   - Add \'<pathelement path="\${d4j.tests.extras}"/>\' inside the test classpath in \'${BUILD_XML_PATH}\'.
5. Verify the BDD environment by running \'./verify_negative.sh\'.

**Exit Conditions (CRITICAL):**
* **Success:** The test FAILS on the buggy code (the verify script outputs SUCCESS). Create an empty file named 'engineer_success.flag' to signal success to the pipeline. Stop immediately and declare success.
* **Failure (Bad Specification):** If you successfully set up the environment, but the \'requirement.feature\' is logically flawed (e.g., it passes on the buggy code, meaning it failed to capture the bug, or asks for impossible behavior), **DO NOT endlessly try to fix the test glue**. Report the specific logical error in the feature file and STOP the task immediately with a failure status.
PROMPT_EOF

echo ">>> [Conductor] Group C: Engineer is setting up negative verification..."
agy --output-format stream-json --add-dir "$ENG_DIR" --add-dir "${PROJECT_ROOT}/templates" --dangerously-skip-permissions --print-timeout 45m --print "$(cat engineer_prompt.txt)" > agy_engineer.jsonl

if [ ! -f "engineer_success.flag" ]; then
    echo ">>> [Conductor] ERROR: Engineer failed to verify the specification (engineer_success.flag not found). Aborting pipeline."
    exit 1
fi

# --- 3. FIXER ---
rm -rf "$FIX_DIR"
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$FIX_DIR"

ENG_ANCHOR="${ENG_DIR}/${PROJ_SUBDIR:-.}"
FIX_ANCHOR="${FIX_DIR}/${PROJ_SUBDIR:-.}"
cp "${ENG_ANCHOR}/pom.xml" "${FIX_ANCHOR}/"
cp "${ENG_ANCHOR}/build.xml" "${FIX_ANCHOR}/" 2>/dev/null || true
cp "${ENG_ANCHOR}/defects4j.build.properties" "${FIX_ANCHOR}/" 2>/dev/null || true
if [ -d "${ENG_ANCHOR}/ant" ]; then
    cp -r "${ENG_ANCHOR}/ant" "${FIX_ANCHOR}/"
fi
if [ -d "${ENG_ANCHOR}/tests" ]; then
    cp -r "${ENG_ANCHOR}/tests"/* "${FIX_ANCHOR}/tests/" 2>/dev/null || true
fi
if [ -d "${ENG_ANCHOR}/src/test" ]; then
    cp -r "${ENG_ANCHOR}/src/test" "${FIX_ANCHOR}/src/"
fi
cp "$ARCH_DIR/requirement.feature" "$FIX_DIR/"

cd "$FIX_DIR" || exit

cat <<PROMPT_EOF > fixer_prompt.txt
You are an expert software engineer. A BDD test environment has been set up to guide you in fixing a bug.

**Context:**
* The requirement you must satisfy is located at: \'requirement.feature\'.
* You can run the verification test using: \'export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles'; mvn test -Dtest=CucumberTest\' (or equivalent build command).

**Your Task:**
1. Read the requirement feature file.
2. Use your tools to search the codebase and locate the source files that violate this requirement. 
3. Modify the source code to fix the bug. You are free to modify multiple files if necessary.
5. Generate a focused patch file containing ONLY your source code modifications. Exclude any test files or build files. Save it as 'negative_fix.patch'. (e.g. 'git diff path/to/File.java > negative_fix.patch')
4. Derive your fix **strictly** from the requirements. Do not modify the test files.

**Success Condition:**
* Run the verification test. You have succeeded when the Cucumber test passes completely. Stop immediately once the test passes.
PROMPT_EOF

echo ">>> [Conductor] Group C: Fixer is repairing based on Gherkin..."
agy --output-format stream-json --add-dir "$FIX_DIR" --dangerously-skip-permissions --print-timeout 45m --print "$(cat fixer_prompt.txt)" > agy_fixer.jsonl

if [ ! -f "negative_fix.patch" ]; then git diff -- '*.java' ':(exclude)*Test*' > negative_fix.patch; fi

echo ">>> [Conductor] Cleaning up BDD test artifacts for final verification..."
cp negative_fix.patch ../negative_fix.patch.bak
git reset --hard > /dev/null 2>&1
TMP_BAK="../log_bak_${PROJ}_${ID}_$$"
mkdir -p "$TMP_BAK"
cp *.jsonl "$TMP_BAK/" 2>/dev/null || true
cp *_prompt.txt "$TMP_BAK/" 2>/dev/null || true
git clean -fd > /dev/null 2>&1
mv "$TMP_BAK"/* ./ 2>/dev/null || true
rm -rf "$TMP_BAK" 
mv ../negative_fix.patch.bak negative_fix.patch
git apply negative_fix.patch > /dev/null 2>&1 || patch -p1 < negative_fix.patch > /dev/null 2>&1

echo ">>> [Conductor] Verifying Final Result..."
defects4j compile
export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles'; defects4j test
echo ">>> [Conductor] Group C Finished."
