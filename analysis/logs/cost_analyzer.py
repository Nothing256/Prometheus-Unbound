import os
import json
import glob
from datetime import datetime
import dateutil.parser

DIRS = [
    "/Users/nothing/workspace/@archive/Logs/workdir_enlightened",
    "/Users/nothing/workspace/@archive/Logs/workdir_qwen"
]

ROLES = ["architect", "engineer", "fixer"]

stats = {
    "architect": {"count": 0, "duration_ms": 0, "turns": 0, "api_ms": 0, "tokens": 0},
    "engineer": {"count": 0, "duration_ms": 0, "turns": 0, "api_ms": 0, "tokens": 0},
    "fixer": {"count": 0, "duration_ms": 0, "turns": 0, "api_ms": 0, "tokens": 0},
}

def parse_timestamp(ts_str):
    try:
        if ts_str:
            return dateutil.parser.isoparse(ts_str)
    except:
        pass
    return None

def process_file(filepath, role):
    try:
        with open(filepath, 'r') as f:
            lines = f.readlines()
    except Exception as e:
        # print(f"Error reading {filepath}: {e}")
        return

    if not lines:
        return

    try:
        last_line = json.loads(lines[-1])
    except:
        if len(lines) > 1:
            try:
                last_line = json.loads(lines[-2])
            except:
                return
        else:
            return

    file_duration = 0
    file_turns = 0
    file_api_ms = 0
    file_tokens = 0

    # Engineer/Fixer format
    if "duration_ms" in last_line:
        file_duration = last_line.get("duration_ms", 0)
        file_turns = last_line.get("num_turns", 0)
        file_api_ms = last_line.get("duration_api_ms", 0)
        if "usage" in last_line:
            file_tokens = last_line["usage"].get("total_tokens", 0)
    
    # Architect format
    elif "stats" in last_line:
        s = last_line["stats"]
        file_duration = s.get("duration_ms", 0)
        file_tokens = s.get("total_tokens", 0)
        
        # Calculate turns and api_ms manually
        curr_turns = 0
        curr_api_ms = 0
        prev_ts = None
        
        for i, line in enumerate(lines):
            try:
                entry = json.loads(line)
            except:
                continue
                
            ts = parse_timestamp(entry.get("timestamp"))
            
            if entry.get("type") == "message" and entry.get("role") == "assistant":
                curr_turns += 1
                if prev_ts and ts:
                    diff = (ts - prev_ts).total_seconds() * 1000
                    if diff > 0:
                         curr_api_ms += diff
            
            if entry.get("type") in ["message", "tool_result", "tool_use", "init"]:
                 if ts:
                     prev_ts = ts
        
        file_turns = curr_turns
        file_api_ms = curr_api_ms
        
    else:
        return

    stats[role]["count"] += 1
    stats[role]["duration_ms"] += file_duration
    stats[role]["turns"] += file_turns
    stats[role]["api_ms"] += file_api_ms
    stats[role]["tokens"] += file_tokens

def main():
    for d in DIRS:
        if not os.path.exists(d):
            continue
        
        files = glob.glob(os.path.join(d, "*.jsonl"))
        for f in files:
            fname = os.path.basename(f)
            role = None
            if "_architect" in fname:
                role = "architect"
            elif "_engineer" in fname:
                role = "engineer"
            elif "_fixer" in fname:
                role = "fixer"
            
            if role:
                process_file(f, role)

    print(f"{'Role':<12} | {'Sessions':<8} | {'Avg Duration(s)':<15} | {'Avg Turns':<10} | {'Avg API(s)':<10} | {'Avg Tokens':<12}")
    print("-" * 80)
    
    markdown_content = "# Agent Performance Report\n\n"
    markdown_content += f"| Role | Sessions | Avg Duration (s) | Avg Turns | Avg API (s) | Avg Tokens |\n"
    markdown_content += f"| :--- | :--- | :--- | :--- | :--- | :--- |\n"

    for role in ROLES:
        s = stats[role]
        count = s["count"]
        if count == 0:
            print(f"{role:<12} | {0:<8} | {0:<15} | {0:<10} | {0:<10} | {0:<12}")
            markdown_content += f"| {role} | 0 | 0 | 0 | 0 | 0 |\n"
            continue
            
        avg_dur = (s["duration_ms"] / count) / 1000
        avg_turns = s["turns"] / count
        avg_api = (s["api_ms"] / count) / 1000
        avg_tok = s["tokens"] / count
        
        print(f"{role:<12} | {count:<8} | {avg_dur:<15.2f} | {avg_turns:<10.2f} | {avg_api:<10.2f} | {avg_tok:<12.0f}")
        markdown_content += f"| **{role.capitalize()}** | {count} | {avg_dur:.2f} | {avg_turns:.2f} | {avg_api:.2f} | {avg_tok:,.0f} |\n"

    # Write to file
    with open("agent_report.md", "w") as f:
        f.write(markdown_content)
    print("\nReport saved to agent_report.md")

if __name__ == "__main__":
    main()
