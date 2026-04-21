<div align="center">
  <img src="assets/prometheus_banner.png" alt="Project Prometheus Banner" width="100%">
</div>


# Project Prometheus: Unbound

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Benchmark](https://img.shields.io/badge/Benchmark-Defects4J%20v3.0.1-blue)](https://github.com/rjust/defects4j)
[![Model](https://img.shields.io/badge/Model-Gemini%20%7C%20Qwen-green)](https://deepmind.google/technologies/gemini/)

> **"From Guessing to Obeying: Bridging the Intent Gap in Automated Program Repair with Reverse-Engineered Executable Specifications."**


---

## 🔥 Overview

**Project Prometheus** represents a paradigm shift in Automated Program Repair (APR). Moving beyond the traditional "generate-and-validate" approach, we introduce a framework that prioritizes **Specification Inference** over code generation.

Current SOTA agents often suffer from the **"Intent Gap"**—they are skilled at writing code but struggle to understand *what* the code is supposed to do. This leads to hallucinations, overfitting, and "Berserker-style" refactoring.

Prometheus bridges this gap by deploying a multi-agent system to:

1.  **Reverse-Engineer** missing requirements into formal **Gherkin (BDD)** specifications.
2.  **Verify** these specifications using a rigorous **Requirement Quality Assurance (RQA) Loop**.
3.  **Repair** the bug using an "Enlightened" agent guided by verified executable intent.

## 🚀 Key Features

*   **🧠 The Architect (Intent Inference):** Uses Chain-of-Thought reasoning to transform vague issue reports into precise, executable `.feature` files (Gherkin).
*   **🛡️ The Engineer (RQA Loop):** A novel "Sandwich Verification" mechanism. It uses the ground truth (fixed code) as a proxy oracle to validate the generated specification, ensuring the agent is solving the *correct* problem.
*   **🛠️ The Fixer (Enlightened Repair):** A coding agent that operates under strict BDD constraints. It supports an **"Unbound"** strategy, capable of performing multi-file, system-level refactoring (e.g., fixing `Gson-4` across Reader and Writer).
*   **📊 Defects4J-BDD Dataset:** We release a dataset of **160+ reverse-engineered BDD specifications** for the Defects4J benchmark, serving as a new asset for the community.

## 📈 Results

Evaluated on **680 defects** across 16 projects in Defects4J (v3.0.1):

| Metric             | Result     | Description                                                  |
| :----------------- | :--------- | :----------------------------------------------------------- |
| **Total Fix Rate** | **93.97%** | Successfully repaired 639 out of 680 bugs.                   |
| **Rescue Rate**    | **74.4%**  | Rescued 119 "hard" bugs that failed with a strong blind baseline. |
| **Coverage**       | **100%**   | Achieved 100% fix rate on 6 projects including Mockito, Gson, and Chart. |

> *"What kind of requirement shapes what kind of code."* — Our empirical study reveals that precise intent transforms agents from aggressive refactorers into surgical instruments.

## 📂 Repository Structure

```text
Prometheus-Unbound/
├── assets/                 # Images, diagrams, and CHALLENGES.md
├── dataset/                # The "Defects4J-BDD" Dataset (.feature files)
│   ├── Lang/               # Gherkin specs for Commons Lang
│   ├── Math/               # Gherkin specs for Commons Math
│   └── ...
├── pipelines/              # Automated Multi-Agent Workflow Scripts
│   ├── run_architect.sh    # Step 1: Reverse Engineering Intent
│   ├── run_engineer_fixer.sh # Step 2 & 3: RQA Verification & Repair
│   ├── optional/           # Optional scripts
│   └── utils/              # Batch processing scripts
├── prompts/                # System Prompts (Templates)
│   ├── blind_prompt.txt
│   ├── architect_prompt.txt
│   ├── engineer_prompt.txt
│   └── fixer_prompt.txt
├── analysis/               # Experimental Data & Logs
│   ├── agent_report.md     # Cost & Efficiency Analysis
│   ├── cost_analyzer.py    # Scripts to generate agent_report.md
│   ├── BENCHMARK.md        # ⭐ Per-bug status for all 854 D4J bugs
│   ├── benchmark_status.csv # Machine-readable CSV of all results
│   ├── case_studies/       # Case studies of Gson-4, Lang-30...
│   ├── behavioral_analysis/ # Behavioral Analysis: The Twin Stars
│   └── patches/            # All patches (blind and enlightened)
└── README.md
```

## ⚡ Getting Started

### Prerequisites

*   **OS:** macOS / Linux (Tested on macOS Apple Silicon)
*   **Defects4J:** v3.0.1 installed and configured in `PATH`.
*   **Python:** 3.8+ (for analysis scripts).
*   **CLI Tools:**
    *   `gemini-cli` (Access to Gemini-3.0-Pro)
    *   `qwen-code-cli` (Access to Qwen-3.0-Coder)

### Installation

```bash
git clone https://github.com/Nothing256/Prometheus-Unbound.git
cd Prometheus-Unbound
```

### Usage (Reproducing the Pipeline)

**1. Run the Architect (Generate Spec)**

```bash
# Usage: bash pipelines/run_architect.sh <Project> <BugID>
bash pipelines/run_architect.sh Math 69
```

**2. Run the Engineer & Fixer (Verify & Repair)**

```bash
# Usage: bash pipelines/run_engineer_fixer.sh <Project> <BugID>
bash pipelines/run_engineer_fixer.sh Math 69
```

## 📝 Citation

If you find our work useful in your research, we would be grateful if you could cite our paper:

```bibtex
@misc{wang2026prometheus,
  title={Project Prometheus: Bridging the Intent Gap in Agentic Program
         Repair via Reverse-Engineered Executable Specifications},
  author={Yongchao Wang and Zhiqiu Huang},
  year={2026},
  eprint={2604.17464},
  archivePrefix={arXiv},
  primaryClass={cs.SE},
  url={https://arxiv.org/abs/2604.17464}
}
```

## 🙏 Acknowledgments

Project Prometheus stands on the shoulders of giants. We extend our deepest gratitude to:

**The Theoretical Foundations:**
*   **Dan North**, for the seminal work on [Behavior-Driven Development](https://dl.acm.org/doi/10.5555/1126767.1126780).
*   **Zhang Gang (张刚)**, for his invaluable book *《软件设计：从专业到卓越》 (Software Design: From Professional to Excellent)*, which first illuminated the power of "Living Documentation" for us.

**The Battlefield:**
*   **René Just et al.**, for **[Defects4J](https://github.com/rjust/defects4j)**, the gold standard benchmark that made this research possible.

**The Crew (Our AI Agents):**
*   **[Gemini](https://github.com/google-gemini/gemini-cli)** (Google DeepMind): Our brilliant *Architect* and *Engineer*.
*   **[Qwen](https://github.com/QwenLM/qwen-code)** (Alibaba Cloud): Our tireless and powerful *Fixer*.
*   **[Jules](https://jules.google.com/)** (Google): The first AI agent we encountered, whose spark ignited the Phoenix Universe.

**The Intelligence Support:**
*   **[NotebookLM](http://notebooklm.google.com/)** & **[Antigravity](https://antigravity.google/)**: For providing deep research capabilities and forensic log analysis.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <i>Built with ❤️ by the Prometheus Team of <b>Phoenix Universe</b>. Unbound for the future.</i>
</p>
