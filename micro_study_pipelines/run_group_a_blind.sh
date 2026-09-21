#!/bin/bash
export all_proxy=http://127.0.0.1:12001
export PERL5LIB="/Users/nothing/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export PATH="/Users/nothing/.local/bin:/Users/nothing/repository/defects4j/framework/bin:$PATH"

PROJ=${1:-"Lang"}
ID=${2:-"1"}

if [ -z "$PROJ" ] || [ -z "$ID" ]; then
    echo "Usage: bash run_group_a_blind.sh <Project> <ID>"
    exit 1
fi

WORK_ROOT=${HOME}/prometheus_workdir_microstudy
DIR_PREFIX=$(echo "$PROJ" | tr '[:upper:]' '[:lower:]')
FIXER_DIR="${WORK_ROOT}/${DIR_PREFIX}_${ID}_group_a_blind"

rm -rf "$FIXER_DIR"
mkdir -p "$WORK_ROOT"

echo ">>> [Conductor] Group A (Blind): Initializing Buggy Environment..."
defects4j checkout -p "$PROJ" -v "${ID}b" -w "$FIXER_DIR"
cd "$FIXER_DIR" || exit

TRIGGER_TEST=$(defects4j export -p tests.trigger | tr '\n' ' ')

cat <<PROMPT_EOF > blind_prompt.txt
You are an expert software engineer. A bug currently exists in this project.

**Context:**
* The system environment for reproduction is set to **'America/Los_Angeles'**.
* The following test case currently triggers the bug and fails: \'$TRIGGER_TEST\'

**Your Task:**
1. Use your search and file-reading tools to investigate the codebase. Locate the failing test, trace its execution, and find the buggy logic in the source code.
2. Modify the source code to fix the bug so that the failing test passes. You are free to modify multiple files if necessary.
5. Generate a focused patch file containing ONLY your source code modifications. Exclude any test files or build files. Save it as 'blind_fix.patch'. (e.g. 'git diff path/to/File.java > blind_fix.patch')
3. Before running any tests (e.g. via defects4j or maven), you MUST execute 'export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles''. Do not modify the test files.

**Success Condition:**
* You have succeeded when the failing test passes. Stop immediately once verified.
PROMPT_EOF

echo ">>> [Conductor] Group A: Antigravity is fixing blindly..."
agy --output-format stream-json --add-dir "$FIXER_DIR" --dangerously-skip-permissions --print-timeout 45m --print "$(cat blind_prompt.txt)" > agy_blind.jsonl

if [ ! -f "blind_fix.patch" ]; then git diff -- '*.java' ':(exclude)*Test*' > blind_fix.patch; fi

echo ">>> [Conductor] Verifying Final Result..."
defects4j compile
export TZ='America/Los_Angeles'; export _JAVA_OPTIONS='-Duser.language=en -Duser.country=US -Duser.timezone=America/Los_Angeles'; defects4j test
echo ">>> [Conductor] Group A Finished."
