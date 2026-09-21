#!/bin/bash
export all_proxy=http://127.0.0.1:12001
export PERL5LIB="/Users/nothing/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export PATH="/Users/nothing/.local/bin:/Users/nothing/repository/defects4j/framework/bin:$PATH"

PROJ=${1:-"Lang"}
ID=${2:-"1"}

if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_group_b_nl.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=${HOME}/prometheus_workdir_microstudy
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
ARCH_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_b_arch"
FIX_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_b_fix"

mkdir -p "$WORK_ROOT"

# --- 1. ARCHITECT ---
rm -rf "$ARCH_DIR"
echo ">>> [Conductor] Group B (NL): Initializing Architect Environment..."
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$ARCH_DIR"
cd "$ARCH_DIR" || exit

TRIGGER_TEST=$(defects4j export -p tests.trigger | tr '\n' ' ')

cat <<PROMPT_EOF > architect_prompt.txt
You are an expert software engineer. A bug currently exists in this project. 

**Context:**
* The system environment for reproduction is set to **'America/Los_Angeles'**.
* The following test case currently triggers the bug and fails: \'$TRIGGER_TEST\'

**Your Task:**
1. Use your search and file-reading tools to investigate the codebase. Locate the failing test, trace its execution, and find the buggy logic in the source code.
2. Deduce the *intended, correct* behavior of the buggy logic.
3. Express this intended behavior as a detailed Natural Language requirement document. Save it to a new file named \'summary.txt\' in the root directory.

**Constraints:**
* The summary must explicitly describe the correct behavior for the inputs causing the failure.
* **DO NOT** use Gherkin/Cucumber. Use standard plain English prose.
* **DO NOT** perform Root Cause Analysis (RCA). Do NOT explain why the current code fails, do NOT reference specific lines of code or variables, and do NOT mention the internal implementation details of the buggy method.
* **Describe ONLY the Black-Box Behavior.** Your summary must read like a strict product requirement document (e.g., "When given input X, the system must return Y"), matching the abstraction level of a BDD feature file without providing the solution.
* **DO NOT** modify any source code to fix the bug. Your job is ONLY to write the summary. Stop immediately after generating \'summary.txt\'.
PROMPT_EOF

echo ">>> [Conductor] Group B: Architect NL is inferring intent..."
agy --output-format stream-json --add-dir "$ARCH_DIR" --dangerously-skip-permissions --print-timeout 45m --print "$(cat architect_prompt.txt)" > agy_architect.jsonl

if [ ! -f "summary.txt" ]; then
    echo "Error: Architect failed to generate summary.txt"
    exit 1
fi

# --- 2. FIXER ---
rm -rf "$FIX_DIR"
echo ">>> [Conductor] Group B (NL): Initializing Fixer Environment..."
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$FIX_DIR"
cp "$ARCH_DIR/summary.txt" "$FIX_DIR/"
cd "$FIX_DIR" || exit

cat <<PROMPT_EOF > fixer_prompt.txt
You are an expert software engineer. You are tasked with fixing a bug based on a Natural Language requirement summary.

**Context:**
* The requirements summary you must satisfy is located at: \'summary.txt\'.

**Your Task:**
1. Read the requirement summary.
2. Use your tools to search the codebase and locate the source files that violate these requirements. 
3. Modify the source code to satisfy the requirements. You are free to modify multiple files if necessary.
5. Generate a focused patch file containing ONLY your source code modifications. Exclude any test files or build files. Save it as 'nl_fix.patch'. (e.g. 'git diff path/to/File.java > nl_fix.patch')
4. You may run the original failing test (\'$TRIGGER_TEST\') to verify your fix. Do not modify the test files.

**Success Condition:**
* You have succeeded when the original failing test passes. Stop immediately once verified.
PROMPT_EOF

echo ">>> [Conductor] Group B: Fixer NL is repairing..."
agy --output-format stream-json --add-dir "$FIX_DIR" --dangerously-skip-permissions --print-timeout 45m --print "$(cat fixer_prompt.txt)" > agy_fixer.jsonl

if [ ! -f "nl_fix.patch" ]; then git diff -- '*.java' ':(exclude)*Test*' > nl_fix.patch; fi

echo ">>> [Conductor] Verifying Final Result..."
defects4j compile
export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles'; defects4j test
echo ">>> [Conductor] Group B Finished."
