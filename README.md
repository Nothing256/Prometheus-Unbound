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
*   **📊 Defects4J-BDD Dataset:** We release a dataset of **600+ reverse-engineered BDD specifications** for the Defects4J benchmark, serving as a new asset for the community.

## 📈 Results

Evaluated on **680 defects** across 17 projects in Defects4J (v1.2 & v2.0):

| Metric             | Result     | Description                                                  |
| :----------------- | :--------- | :----------------------------------------------------------- |
| **Total Fix Rate** | **93.97%** | Successfully repaired 639 out of 680 bugs.                   |
| **Rescue Rate**    | **74.4%**  | Rescued 119 "hard" bugs that failed with a strong blind baseline. |
| **Coverage**       | **100%**   | Achieved 100% fix rate on 6 projects including Mockito, Gson, and Chart. |

> *"What kind of requirement shapes what kind of code."* — Our empirical study reveals that precise intent transforms agents from aggressive refactorers into surgical instruments.

## 📂 Repository Structure

```text
Prometheus-Unbound/
├── assets/                 # Images and diagrams
├── dataset/                # The "Defects4J-BDD" Dataset (.feature files)
│   ├── Lang/               # Gherkin specs for Commons Lang
│   ├── Math/               # Gherkin specs for Commons Math
│   └── ...
├── pipelines/              # Automated Multi-Agent Workflow Scripts
│   ├── run_architect.sh    # Step 1: Reverse Engineering Intent
│   ├── run_engineer_fixer.sh # Step 2 & 3: RQA Verification & Repair
│   └── optional/           # Optional scripts
├── prompts/                # System Prompts (Templates)
│   ├── architect_prompt.txt
│   └── fixer_prompt.txt
├── analysis/               # Experimental Data & Logs
│   ├── agent_report.md     # Cost & Efficiency Analysis
│   └── patches/            # Showcase of "Enlightened" Patches (e.g., Math-69)
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
git clone https://github.com/YOUR_USERNAME/Prometheus-Unbound.git
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

If you use this code or dataset in your research, please cite our paper:

```bibtex
TBD
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  <i>Built with ❤️ by the Prometheus Team. Unbound for the future.</i>
</p>

