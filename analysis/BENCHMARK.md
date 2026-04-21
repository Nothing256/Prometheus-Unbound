# 📊 Benchmark Coverage: Defects4J v3.0.1

> This document provides a comprehensive, per-bug status for our evaluation on the Defects4J benchmark.  
> It is intended to facilitate comparison with other APR approaches.

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ Blind | Fixed by the **Blind Fixer** (Qwen-3.0-Coder, no BDD guidance) |
| 🔥 Rescued | Failed Blind, then **Rescued** by Enlightened Fixer (with BDD spec) |
| ❌ Open | Not yet fixed — see [CHALLENGES.md](../assets/CHALLENGES.md) for analysis |
| ⊘ Excluded | Project excluded from evaluation (Closure — build incompatibility) |

## Summary

| Project | Total | ✅ Blind | 🔥 Rescued | ❌ Open | Fix Rate |
|---------|------:|--------:|-----------:|-------:|---------:|
| Chart | 26 | 23 | 3 | 0 | 100.0% |
| Cli | 39 | 39 | 0 | 0 | 100.0% |
| Closure | 174 | ⊘ | ⊘ | ⊘ | ⊘ |
| Codec | 18 | 11 | 5 | 2 | 88.9% |
| Collections | 28 | 22 | 5 | 1 | 96.4% |
| Compress | 47 | 29 | 14 | 4 | 91.5% |
| Csv | 16 | 15 | 0 | 1 | 93.8% |
| Gson | 18 | 12 | 6 | 0 | 100.0% |
| JacksonCore | 26 | 26 | 0 | 0 | 100.0% |
| JacksonDatabind | 110 | 103 | 6 | 1 | 99.1% |
| JacksonXml | 6 | 2 | 2 | 2 | 66.7% |
| Jsoup | 93 | 59 | 25 | 9 | 90.3% |
| JxPath | 22 | 20 | 2 | 0 | 100.0% |
| Lang | 61 | 59 | 1 | 1 | 98.4% |
| Math | 106 | 48 | 39 | 19 | 82.1% |
| Mockito | 38 | 32 | 6 | 0 | 100.0% |
| Time | 26 | 20 | 5 | 1 | 96.2% |
| **Total** | **680 (+174⊘)** | **520** | **119** | **41** | **93.97%** |

---

## Per-Bug Status

### Chart (26 bugs) — 100.0%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Chart-1 | ✅ Blind | Chart-10 | ✅ Blind | Chart-19 | ✅ Blind |
| Chart-2 | ✅ Blind | Chart-11 | ✅ Blind | Chart-20 | ✅ Blind |
| Chart-3 | ✅ Blind | Chart-12 | ✅ Blind | Chart-21 | ✅ Blind |
| Chart-4 | ✅ Blind | Chart-13 | 🔥 Rescued | Chart-22 | 🔥 Rescued |
| Chart-5 | ✅ Blind | Chart-14 | ✅ Blind | Chart-23 | ✅ Blind |
| Chart-6 | ✅ Blind | Chart-15 | ✅ Blind | Chart-24 | ✅ Blind |
| Chart-7 | 🔥 Rescued | Chart-16 | ✅ Blind | Chart-25 | ✅ Blind |
| Chart-8 | ✅ Blind | Chart-17 | ✅ Blind | Chart-26 | ✅ Blind |
| Chart-9 | ✅ Blind | Chart-18 | ✅ Blind | | |

---

### Cli (39 bugs) — 100.0%

All 39 bugs (Cli-1 through Cli-5, Cli-7 through Cli-40) fixed by **✅ Blind**.

> Note: Cli-6 is deprecated in Defects4J v3.0.1.

---

### Closure (174 bugs) — ⊘ Excluded

> **Exclusion Criteria:** Closure relies on a custom legacy build infrastructure incompatible with our automated Engineer agent, and its massive test suite imposes excessive overhead on the RQA Loop. See Section 4.1 of [our paper](https://arxiv.org/abs/2604.17464) for details.

---

### Codec (18 bugs) — 88.9%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Codec-1 | ✅ Blind | Codec-7 | ✅ Blind | Codec-13 | ✅ Blind |
| Codec-2 | 🔥 Rescued | Codec-8 | 🔥 Rescued | Codec-14 | ❌ Open |
| Codec-3 | ✅ Blind | Codec-9 | ✅ Blind | Codec-15 | ✅ Blind |
| Codec-4 | 🔥 Rescued | Codec-10 | 🔥 Rescued | Codec-16 | ❌ Open |
| Codec-5 | ✅ Blind | Codec-11 | ✅ Blind | Codec-17 | ✅ Blind |
| Codec-6 | 🔥 Rescued | Codec-12 | ✅ Blind | Codec-18 | ✅ Blind |

---

### Collections (28 bugs) — 96.4%

| Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|
| Collections-1 | ✅ Blind | Collections-15 | 🔥 Rescued |
| Collections-2 | ✅ Blind | Collections-16 | ✅ Blind |
| Collections-3 | ✅ Blind | Collections-17 | ✅ Blind |
| Collections-4 | 🔥 Rescued | Collections-18 | ✅ Blind |
| Collections-5 | ✅ Blind | Collections-19 | ✅ Blind |
| Collections-6 | ✅ Blind | Collections-20 | 🔥 Rescued |
| Collections-7 | ✅ Blind | Collections-21 | ✅ Blind |
| Collections-8 | ❌ Open | Collections-22 | ✅ Blind |
| Collections-9 | ✅ Blind | Collections-23 | ✅ Blind |
| Collections-10 | ✅ Blind | Collections-24 | ✅ Blind |
| Collections-11 | 🔥 Rescued | Collections-25 | ✅ Blind |
| Collections-12 | ✅ Blind | Collections-26 | ✅ Blind |
| Collections-13 | ✅ Blind | Collections-27 | 🔥 Rescued |
| Collections-14 | ✅ Blind | Collections-28 | ✅ Blind |

---

### Compress (47 bugs) — 91.5%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Compress-1 | ✅ Blind | Compress-17 | ✅ Blind | Compress-33 | ✅ Blind |
| Compress-2 | 🔥 Rescued | Compress-18 | 🔥 Rescued | Compress-34 | ✅ Blind |
| Compress-3 | ✅ Blind | Compress-19 | ✅ Blind | Compress-35 | ❌ Open |
| Compress-4 | 🔥 Rescued | Compress-20 | 🔥 Rescued | Compress-36 | ✅ Blind |
| Compress-5 | 🔥 Rescued | Compress-21 | ✅ Blind | Compress-37 | 🔥 Rescued |
| Compress-6 | ✅ Blind | Compress-22 | ❌ Open | Compress-38 | 🔥 Rescued |
| Compress-7 | ✅ Blind | Compress-23 | ✅ Blind | Compress-39 | ✅ Blind |
| Compress-8 | ✅ Blind | Compress-24 | 🔥 Rescued | Compress-40 | ✅ Blind |
| Compress-9 | 🔥 Rescued | Compress-25 | ✅ Blind | Compress-41 | 🔥 Rescued |
| Compress-10 | ✅ Blind | Compress-26 | ✅ Blind | Compress-42 | 🔥 Rescued |
| Compress-11 | ✅ Blind | Compress-27 | ✅ Blind | Compress-43 | ❌ Open |
| Compress-12 | ✅ Blind | Compress-28 | ✅ Blind | Compress-44 | ✅ Blind |
| Compress-13 | ❌ Open | Compress-29 | ✅ Blind | Compress-45 | ✅ Blind |
| Compress-14 | ✅ Blind | Compress-30 | ✅ Blind | Compress-46 | 🔥 Rescued |
| Compress-15 | ✅ Blind | Compress-31 | ✅ Blind | Compress-47 | 🔥 Rescued |
| Compress-16 | 🔥 Rescued | Compress-32 | ✅ Blind | | |

---

### Csv (16 bugs) — 93.8%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Csv-1 | ✅ Blind | Csv-7 | ✅ Blind | Csv-13 | ✅ Blind |
| Csv-2 | ✅ Blind | Csv-8 | ✅ Blind | Csv-14 | ✅ Blind |
| Csv-3 | ❌ Open | Csv-9 | ✅ Blind | Csv-15 | ✅ Blind |
| Csv-4 | ✅ Blind | Csv-10 | ✅ Blind | Csv-16 | ✅ Blind |
| Csv-5 | ✅ Blind | Csv-11 | ✅ Blind | | |
| Csv-6 | ✅ Blind | Csv-12 | ✅ Blind | | |

---

### Gson (18 bugs) — 100.0%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Gson-1 | 🔥 Rescued | Gson-7 | 🔥 Rescued | Gson-13 | ✅ Blind |
| Gson-2 | ✅ Blind | Gson-8 | ✅ Blind | Gson-14 | 🔥 Rescued |
| Gson-3 | ✅ Blind | Gson-9 | ✅ Blind | Gson-15 | ✅ Blind |
| Gson-4 | 🔥 Rescued | Gson-10 | ✅ Blind | Gson-16 | ✅ Blind |
| Gson-5 | ✅ Blind | Gson-11 | ✅ Blind | Gson-17 | ✅ Blind |
| Gson-6 | ✅ Blind | Gson-12 | 🔥 Rescued | Gson-18 | 🔥 Rescued |

---

### JacksonCore (26 bugs) — 100.0%

All 26 bugs (JacksonCore-1 through JacksonCore-26) fixed by **✅ Blind**.

---

### JacksonDatabind (110 bugs) — 99.1%

> Note: JacksonDatabind-65 and JacksonDatabind-89 are deprecated in D4J v3.0.1.

<details>
<summary>Click to expand full list (110 bugs)</summary>

| Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|
| JacksonDatabind-1 | ✅ Blind | JacksonDatabind-56 | ✅ Blind |
| JacksonDatabind-2 | ✅ Blind | JacksonDatabind-57 | ✅ Blind |
| JacksonDatabind-3 | ✅ Blind | JacksonDatabind-58 | ✅ Blind |
| JacksonDatabind-4 | ✅ Blind | JacksonDatabind-59 | ✅ Blind |
| JacksonDatabind-5 | ✅ Blind | JacksonDatabind-60 | ✅ Blind |
| JacksonDatabind-6 | ✅ Blind | JacksonDatabind-61 | ✅ Blind |
| JacksonDatabind-7 | ✅ Blind | JacksonDatabind-62 | ✅ Blind |
| JacksonDatabind-8 | ✅ Blind | JacksonDatabind-63 | ✅ Blind |
| JacksonDatabind-9 | ✅ Blind | JacksonDatabind-64 | ✅ Blind |
| JacksonDatabind-10 | ✅ Blind | JacksonDatabind-66 | ✅ Blind |
| JacksonDatabind-11 | ✅ Blind | JacksonDatabind-67 | ✅ Blind |
| JacksonDatabind-12 | ✅ Blind | JacksonDatabind-68 | ✅ Blind |
| JacksonDatabind-13 | 🔥 Rescued | JacksonDatabind-69 | ✅ Blind |
| JacksonDatabind-14 | ✅ Blind | JacksonDatabind-70 | ✅ Blind |
| JacksonDatabind-15 | ❌ Open | JacksonDatabind-71 | ✅ Blind |
| JacksonDatabind-16 | ✅ Blind | JacksonDatabind-72 | ✅ Blind |
| JacksonDatabind-17 | ✅ Blind | JacksonDatabind-73 | ✅ Blind |
| JacksonDatabind-18 | 🔥 Rescued | JacksonDatabind-74 | ✅ Blind |
| JacksonDatabind-19 | 🔥 Rescued | JacksonDatabind-75 | ✅ Blind |
| JacksonDatabind-20 | ✅ Blind | JacksonDatabind-76 | ✅ Blind |
| JacksonDatabind-21 | ✅ Blind | JacksonDatabind-77 | ✅ Blind |
| JacksonDatabind-22 | ✅ Blind | JacksonDatabind-78 | ✅ Blind |
| JacksonDatabind-23 | ✅ Blind | JacksonDatabind-79 | 🔥 Rescued |
| JacksonDatabind-24 | ✅ Blind | JacksonDatabind-80 | ✅ Blind |
| JacksonDatabind-25 | ✅ Blind | JacksonDatabind-81 | ✅ Blind |
| JacksonDatabind-26 | ✅ Blind | JacksonDatabind-82 | ✅ Blind |
| JacksonDatabind-27 | ✅ Blind | JacksonDatabind-83 | ✅ Blind |
| JacksonDatabind-28 | ✅ Blind | JacksonDatabind-84 | ✅ Blind |
| JacksonDatabind-29 | ✅ Blind | JacksonDatabind-85 | ✅ Blind |
| JacksonDatabind-30 | ✅ Blind | JacksonDatabind-86 | ✅ Blind |
| JacksonDatabind-31 | ✅ Blind | JacksonDatabind-87 | ✅ Blind |
| JacksonDatabind-32 | ✅ Blind | JacksonDatabind-88 | ✅ Blind |
| JacksonDatabind-33 | ✅ Blind | JacksonDatabind-90 | ✅ Blind |
| JacksonDatabind-34 | ✅ Blind | JacksonDatabind-91 | ✅ Blind |
| JacksonDatabind-35 | ✅ Blind | JacksonDatabind-92 | ✅ Blind |
| JacksonDatabind-36 | ✅ Blind | JacksonDatabind-93 | ✅ Blind |
| JacksonDatabind-37 | ✅ Blind | JacksonDatabind-94 | ✅ Blind |
| JacksonDatabind-38 | ✅ Blind | JacksonDatabind-95 | 🔥 Rescued |
| JacksonDatabind-39 | ✅ Blind | JacksonDatabind-96 | ✅ Blind |
| JacksonDatabind-40 | ✅ Blind | JacksonDatabind-97 | ✅ Blind |
| JacksonDatabind-41 | ✅ Blind | JacksonDatabind-98 | ✅ Blind |
| JacksonDatabind-42 | ✅ Blind | JacksonDatabind-99 | ✅ Blind |
| JacksonDatabind-43 | ✅ Blind | JacksonDatabind-100 | ✅ Blind |
| JacksonDatabind-44 | ✅ Blind | JacksonDatabind-101 | ✅ Blind |
| JacksonDatabind-45 | ✅ Blind | JacksonDatabind-102 | ✅ Blind |
| JacksonDatabind-46 | ✅ Blind | JacksonDatabind-103 | 🔥 Rescued |
| JacksonDatabind-47 | ✅ Blind | JacksonDatabind-104 | ✅ Blind |
| JacksonDatabind-48 | ✅ Blind | JacksonDatabind-105 | ✅ Blind |
| JacksonDatabind-49 | ✅ Blind | JacksonDatabind-106 | ✅ Blind |
| JacksonDatabind-50 | ✅ Blind | JacksonDatabind-107 | ✅ Blind |
| JacksonDatabind-51 | ✅ Blind | JacksonDatabind-108 | ✅ Blind |
| JacksonDatabind-52 | ✅ Blind | JacksonDatabind-109 | ✅ Blind |
| JacksonDatabind-53 | ✅ Blind | JacksonDatabind-110 | ✅ Blind |
| JacksonDatabind-54 | ✅ Blind | JacksonDatabind-111 | ✅ Blind |
| JacksonDatabind-55 | ✅ Blind | JacksonDatabind-112 | ✅ Blind |

</details>

---

### JacksonXml (6 bugs) — 66.7%

| Bug ID | Status |
|--------|--------|
| JacksonXml-1 | 🔥 Rescued |
| JacksonXml-2 | 🔥 Rescued |
| JacksonXml-3 | ✅ Blind |
| JacksonXml-4 | ✅ Blind |
| JacksonXml-5 | ❌ Open |
| JacksonXml-6 | ❌ Open |

---

### Jsoup (93 bugs) — 90.3%

<details>
<summary>Click to expand full list (93 bugs)</summary>

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Jsoup-1 | ✅ Blind | Jsoup-32 | ✅ Blind | Jsoup-63 | ✅ Blind |
| Jsoup-2 | 🔥 Rescued | Jsoup-33 | ✅ Blind | Jsoup-64 | ✅ Blind |
| Jsoup-3 | ✅ Blind | Jsoup-34 | ✅ Blind | Jsoup-65 | 🔥 Rescued |
| Jsoup-4 | ✅ Blind | Jsoup-35 | ✅ Blind | Jsoup-66 | ✅ Blind |
| Jsoup-5 | ✅ Blind | Jsoup-36 | ✅ Blind | Jsoup-67 | ❌ Open |
| Jsoup-6 | ✅ Blind | Jsoup-37 | ✅ Blind | Jsoup-68 | ✅ Blind |
| Jsoup-7 | ✅ Blind | Jsoup-38 | ✅ Blind | Jsoup-69 | 🔥 Rescued |
| Jsoup-8 | ✅ Blind | Jsoup-39 | ✅ Blind | Jsoup-70 | ✅ Blind |
| Jsoup-9 | ✅ Blind | Jsoup-40 | ✅ Blind | Jsoup-71 | ✅ Blind |
| Jsoup-10 | ✅ Blind | Jsoup-41 | ✅ Blind | Jsoup-72 | 🔥 Rescued |
| Jsoup-11 | ✅ Blind | Jsoup-42 | ✅ Blind | Jsoup-73 | ✅ Blind |
| Jsoup-12 | ✅ Blind | Jsoup-43 | ✅ Blind | Jsoup-74 | ✅ Blind |
| Jsoup-13 | ✅ Blind | Jsoup-44 | ❌ Open | Jsoup-75 | ✅ Blind |
| Jsoup-14 | 🔥 Rescued | Jsoup-45 | ✅ Blind | Jsoup-76 | 🔥 Rescued |
| Jsoup-15 | ✅ Blind | Jsoup-46 | 🔥 Rescued | Jsoup-77 | 🔥 Rescued |
| Jsoup-16 | ✅ Blind | Jsoup-47 | ✅ Blind | Jsoup-78 | ✅ Blind |
| Jsoup-17 | 🔥 Rescued | Jsoup-48 | ✅ Blind | Jsoup-79 | ✅ Blind |
| Jsoup-18 | ✅ Blind | Jsoup-49 | 🔥 Rescued | Jsoup-80 | ✅ Blind |
| Jsoup-19 | ✅ Blind | Jsoup-50 | 🔥 Rescued | Jsoup-81 | 🔥 Rescued |
| Jsoup-20 | ✅ Blind | Jsoup-51 | 🔥 Rescued | Jsoup-82 | ❌ Open |
| Jsoup-21 | ❌ Open | Jsoup-52 | 🔥 Rescued | Jsoup-83 | 🔥 Rescued |
| Jsoup-22 | ✅ Blind | Jsoup-53 | ❌ Open | Jsoup-84 | ❌ Open |
| Jsoup-23 | ✅ Blind | Jsoup-54 | 🔥 Rescued | Jsoup-85 | ✅ Blind |
| Jsoup-24 | ✅ Blind | Jsoup-55 | 🔥 Rescued | Jsoup-86 | 🔥 Rescued |
| Jsoup-25 | ✅ Blind | Jsoup-56 | ✅ Blind | Jsoup-87 | ✅ Blind |
| Jsoup-26 | 🔥 Rescued | Jsoup-57 | ✅ Blind | Jsoup-88 | ❌ Open |
| Jsoup-27 | 🔥 Rescued | Jsoup-58 | 🔥 Rescued | Jsoup-89 | ✅ Blind |
| Jsoup-28 | ❌ Open | Jsoup-59 | 🔥 Rescued | Jsoup-90 | ✅ Blind |
| Jsoup-29 | ✅ Blind | Jsoup-60 | ✅ Blind | Jsoup-91 | ❌ Open |
| Jsoup-30 | ✅ Blind | Jsoup-61 | ✅ Blind | Jsoup-92 | 🔥 Rescued |
| Jsoup-31 | 🔥 Rescued | Jsoup-62 | 🔥 Rescued | Jsoup-93 | ✅ Blind |

</details>

---

### JxPath (22 bugs) — 100.0%

| Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|
| JxPath-1 | ✅ Blind | JxPath-12 | ✅ Blind |
| JxPath-2 | ✅ Blind | JxPath-13 | ✅ Blind |
| JxPath-3 | ✅ Blind | JxPath-14 | ✅ Blind |
| JxPath-4 | ✅ Blind | JxPath-15 | ✅ Blind |
| JxPath-5 | ✅ Blind | JxPath-16 | ✅ Blind |
| JxPath-6 | ✅ Blind | JxPath-17 | 🔥 Rescued |
| JxPath-7 | ✅ Blind | JxPath-18 | ✅ Blind |
| JxPath-8 | ✅ Blind | JxPath-19 | 🔥 Rescued |
| JxPath-9 | ✅ Blind | JxPath-20 | ✅ Blind |
| JxPath-10 | ✅ Blind | JxPath-21 | ✅ Blind |
| JxPath-11 | ✅ Blind | JxPath-22 | ✅ Blind |

---

### Lang (61 bugs) — 98.4%

> Note: Lang-2, Lang-18, Lang-25, Lang-48 are deprecated in D4J v3.0.1.

<details>
<summary>Click to expand full list (61 bugs)</summary>

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Lang-1 | ✅ Blind | Lang-23 | ✅ Blind | Lang-44 | ✅ Blind |
| Lang-3 | ✅ Blind | Lang-24 | ✅ Blind | Lang-45 | ✅ Blind |
| Lang-4 | ✅ Blind | Lang-26 | ✅ Blind | Lang-46 | ✅ Blind |
| Lang-5 | ✅ Blind | Lang-27 | ✅ Blind | Lang-47 | ✅ Blind |
| Lang-6 | ✅ Blind | Lang-28 | ✅ Blind | Lang-49 | ✅ Blind |
| Lang-7 | ✅ Blind | Lang-29 | ✅ Blind | Lang-50 | ✅ Blind |
| Lang-8 | ✅ Blind | Lang-30 | ✅ Blind | Lang-51 | ✅ Blind |
| Lang-9 | ✅ Blind | Lang-31 | ✅ Blind | Lang-52 | ✅ Blind |
| Lang-10 | ✅ Blind | Lang-32 | ✅ Blind | Lang-53 | ✅ Blind |
| Lang-11 | ✅ Blind | Lang-33 | ✅ Blind | Lang-54 | ✅ Blind |
| Lang-12 | ✅ Blind | Lang-34 | 🔥 Rescued | Lang-55 | ✅ Blind |
| Lang-13 | ✅ Blind | Lang-35 | ✅ Blind | Lang-56 | ✅ Blind |
| Lang-14 | ✅ Blind | Lang-36 | ✅ Blind | Lang-57 | ✅ Blind |
| Lang-15 | ✅ Blind | Lang-37 | ✅ Blind | Lang-58 | ✅ Blind |
| Lang-16 | ✅ Blind | Lang-38 | ✅ Blind | Lang-59 | ✅ Blind |
| Lang-17 | ❌ Open | Lang-39 | ✅ Blind | Lang-60 | ✅ Blind |
| Lang-19 | ✅ Blind | Lang-40 | ✅ Blind | Lang-61 | ✅ Blind |
| Lang-20 | ✅ Blind | Lang-41 | ✅ Blind | Lang-62 | ✅ Blind |
| Lang-21 | ✅ Blind | Lang-42 | ✅ Blind | Lang-63 | ✅ Blind |
| Lang-22 | ✅ Blind | Lang-43 | ✅ Blind | Lang-64 | ✅ Blind |
| | | | | Lang-65 | ✅ Blind |

</details>

---

### Math (106 bugs) — 82.1%

<details>
<summary>Click to expand full list (106 bugs)</summary>

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Math-1 | ✅ Blind | Math-36 | ✅ Blind | Math-71 | ✅ Blind |
| Math-2 | 🔥 Rescued | Math-37 | 🔥 Rescued | Math-72 | ✅ Blind |
| Math-3 | ✅ Blind | Math-38 | ✅ Blind | Math-73 | ✅ Blind |
| Math-4 | ❌ Open | Math-39 | ✅ Blind | Math-74 | 🔥 Rescued |
| Math-5 | ✅ Blind | Math-40 | ✅ Blind | Math-75 | ✅ Blind |
| Math-6 | ✅ Blind | Math-41 | ✅ Blind | Math-76 | ❌ Open |
| Math-7 | ✅ Blind | Math-42 | 🔥 Rescued | Math-77 | ✅ Blind |
| Math-8 | 🔥 Rescued | Math-43 | ✅ Blind | Math-78 | ❌ Open |
| Math-9 | ✅ Blind | Math-44 | 🔥 Rescued | Math-79 | ✅ Blind |
| Math-10 | ❌ Open | Math-45 | ❌ Open | Math-80 | 🔥 Rescued |
| Math-11 | ✅ Blind | Math-46 | ✅ Blind | Math-81 | ❌ Open |
| Math-12 | ✅ Blind | Math-47 | 🔥 Rescued | Math-82 | ✅ Blind |
| Math-13 | ❌ Open | Math-48 | 🔥 Rescued | Math-83 | ❌ Open |
| Math-14 | 🔥 Rescued | Math-49 | 🔥 Rescued | Math-84 | ❌ Open |
| Math-15 | 🔥 Rescued | Math-50 | 🔥 Rescued | Math-85 | ✅ Blind |
| Math-16 | 🔥 Rescued | Math-51 | 🔥 Rescued | Math-86 | ✅ Blind |
| Math-17 | ❌ Open | Math-52 | ❌ Open | Math-87 | ✅ Blind |
| Math-18 | 🔥 Rescued | Math-53 | ✅ Blind | Math-88 | ✅ Blind |
| Math-19 | 🔥 Rescued | Math-54 | 🔥 Rescued | Math-89 | ✅ Blind |
| Math-20 | 🔥 Rescued | Math-55 | 🔥 Rescued | Math-90 | 🔥 Rescued |
| Math-21 | 🔥 Rescued | Math-56 | ✅ Blind | Math-91 | ✅ Blind |
| Math-22 | ✅ Blind | Math-57 | ✅ Blind | Math-92 | 🔥 Rescued |
| Math-23 | 🔥 Rescued | Math-58 | 🔥 Rescued | Math-93 | 🔥 Rescued |
| Math-24 | 🔥 Rescued | Math-59 | ✅ Blind | Math-94 | ✅ Blind |
| Math-25 | ✅ Blind | Math-60 | 🔥 Rescued | Math-95 | ✅ Blind |
| Math-26 | ✅ Blind | Math-61 | 🔥 Rescued | Math-96 | ❌ Open |
| Math-27 | ✅ Blind | Math-62 | ❌ Open | Math-97 | 🔥 Rescued |
| Math-28 | 🔥 Rescued | Math-63 | ❌ Open | Math-98 | 🔥 Rescued |
| Math-29 | 🔥 Rescued | Math-64 | ❌ Open | Math-99 | ✅ Blind |
| Math-30 | ✅ Blind | Math-65 | 🔥 Rescued | Math-100 | ✅ Blind |
| Math-31 | ❌ Open | Math-66 | ❌ Open | Math-101 | ✅ Blind |
| Math-32 | ✅ Blind | Math-67 | ❌ Open | Math-102 | ✅ Blind |
| Math-33 | 🔥 Rescued | Math-68 | ❌ Open | Math-103 | 🔥 Rescued |
| Math-34 | ✅ Blind | Math-69 | 🔥 Rescued | Math-104 | 🔥 Rescued |
| Math-35 | 🔥 Rescued | Math-70 | ✅ Blind | Math-105 | ✅ Blind |
| | | | | Math-106 | ✅ Blind |

</details>

---

### Mockito (38 bugs) — 100.0%

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Mockito-1 | ✅ Blind | Mockito-14 | ✅ Blind | Mockito-27 | ✅ Blind |
| Mockito-2 | 🔥 Rescued | Mockito-15 | ✅ Blind | Mockito-28 | ✅ Blind |
| Mockito-3 | ✅ Blind | Mockito-16 | ✅ Blind | Mockito-29 | ✅ Blind |
| Mockito-4 | ✅ Blind | Mockito-17 | ✅ Blind | Mockito-30 | ✅ Blind |
| Mockito-5 | 🔥 Rescued | Mockito-18 | ✅ Blind | Mockito-31 | ✅ Blind |
| Mockito-6 | ✅ Blind | Mockito-19 | ✅ Blind | Mockito-32 | ✅ Blind |
| Mockito-7 | ✅ Blind | Mockito-20 | ✅ Blind | Mockito-33 | ✅ Blind |
| Mockito-8 | ✅ Blind | Mockito-21 | ✅ Blind | Mockito-34 | ✅ Blind |
| Mockito-9 | ✅ Blind | Mockito-22 | ✅ Blind | Mockito-35 | ✅ Blind |
| Mockito-10 | 🔥 Rescued | Mockito-23 | ✅ Blind | Mockito-36 | ✅ Blind |
| Mockito-11 | 🔥 Rescued | Mockito-24 | 🔥 Rescued | Mockito-37 | 🔥 Rescued |
| Mockito-12 | ✅ Blind | Mockito-25 | ✅ Blind | Mockito-38 | ✅ Blind |
| Mockito-13 | ✅ Blind | Mockito-26 | ✅ Blind | | |

---

### Time (26 bugs) — 96.2%

> Note: Time-21 is deprecated in D4J v3.0.1.

| Bug ID | Status | Bug ID | Status | Bug ID | Status |
|--------|--------|--------|--------|--------|--------|
| Time-1 | ❌ Open | Time-10 | ✅ Blind | Time-19 | 🔥 Rescued |
| Time-2 | ✅ Blind | Time-11 | ✅ Blind | Time-20 | ✅ Blind |
| Time-3 | ✅ Blind | Time-12 | ✅ Blind | Time-22 | ✅ Blind |
| Time-4 | 🔥 Rescued | Time-13 | ✅ Blind | Time-23 | ✅ Blind |
| Time-5 | ✅ Blind | Time-14 | ✅ Blind | Time-24 | 🔥 Rescued |
| Time-6 | ✅ Blind | Time-15 | ✅ Blind | Time-25 | ✅ Blind |
| Time-7 | ✅ Blind | Time-16 | ✅ Blind | Time-26 | ✅ Blind |
| Time-8 | ✅ Blind | Time-17 | 🔥 Rescued | Time-27 | ✅ Blind |
| Time-9 | 🔥 Rescued | Time-18 | ✅ Blind | | |

---

## Machine-Readable Format

For automated comparison, the full per-bug status is available as a CSV:

```
Project,BugID,Status
Chart,1,blind
Chart,7,rescued
...
Math,4,open
```

See [`benchmark_status.csv`](benchmark_status.csv) for the complete CSV file.

---

## How to Compare

If you are comparing your APR tool against Prometheus, we recommend:

1. **Same subset**: Use our 680-bug subset (all D4J v3.0.1 except Closure) for fair comparison.
2. **Per-bug matching**: Use this document to identify which specific bugs overlap with your evaluation.
3. **Hard-bug focus**: The 160 bugs that failed Blind repair (`dataset_samples_summary.md`) represent a particularly challenging subset for comparison.

---

*Last updated: April 2026*
