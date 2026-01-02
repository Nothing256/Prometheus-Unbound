# 🌗 Behavioral Analysis: The Twin Stars

This directory documents the comparative analysis between **Gemini** (The Reasoner) and **Qwen** (The Coder).

## 🎭 The Personality Profile (Intent-Behavior Mirroring)

*   **Gemini (The Surgeon):** Infers atomic requirements -> Produces minimal, surgical patches.
*   **Qwen (The Berserker):** Infers broad, systemic requirements -> Produces aggressive, architectural refactorings.

## 📂 Case Studies

### Case 1: The Over-Engineering Trap (Math-2)
*   **Problem:** Integer overflow in `getNumericalMean`.
*   **Qwen:** Inferred a need for "Better Sampling Logic". Result: Rewrote the entire `sample()` method (Missed the bug). [View Patch](./Case_1_Math_2_Overflow/qwen_enlightened_fix.patch)
*   **Gemini:** Inferred a need for "Precision Safety". Result: Simply cast to `(double)`. [View Patch](./Case_1_Math_2_Overflow/gemini_enlightened_fix.patch)

### Case 2: "Be Careful What You Wish For" (Math-70) 
*   **Problem:** NPE due to delegation error (forgot to pass `f`).
*   **Qwen:** Generated a requirement: *"The solver should utilize the initial parameter in its algorithm"*.
*   **Result:** Qwen took this literally and **re-implemented the entire Bisection Solver algorithm** (114 lines of code!) just to "utilize" that parameter.
*   **Gemini:** Generated a requirement: *"Fix delegation to verify `f` is not null"*.
*   **Result:** A one-line fix (`return solve(f, min, max)`). [View Patch](./Case_2_Math_70_NPE/gemini_enlightened_fix.patch)
*   **Insight:** Vague intent leads to massive code churn and regression risk.

### Case 3: Algorithmic Mimicry (Lang-1)
*   **Problem:** Hex string parsing logic.
*   **Gemini's Approach:** Used modern Java `BigInteger` and `try-catch` blocks. Robust, but computationally expensive.
*   **Qwen's Approach:** Replicated the complex manual character counting logic of the original developer *exactly*. [View Patch](./Case_3_Lang_1_Hex/qwen_enlightened_fix.patch)
*   **Insight:** Qwen excels at algorithmic implementation when the goal is clear.