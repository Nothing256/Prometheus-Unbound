# 🚩 The Unconquered: 41 Challenges for the Future

> "Every failure is just a future success waiting for the right intent."

While Project Prometheus successfully repaired 93.97% (639/680) of the defects in our benchmark, **41 bugs** remain standing. These are not just failures; they are the **frontier**. They represent deep architectural mismatches, implicit protocol changes, or the limits of static fault localization.

We publish this list as an open challenge to the community (and our own V2.0).

## 🧩 The List

### Time (The Localization Paradox)
- [ ] `Time-1` (Requires modifying caller `Partial.java`, but locked to `UnsupportedDurationField.java`)

### Codec (Implicit Constraints)
- [ ] `Codec-14`
- [ ] `Codec-16`

### Csv (Hardcoding Traps)
- [ ] `Csv-3` (Agent hardcoded values instead of using generic logic)

### Compress (Complex Binary Formats)
- [ ] `Compress-13`, `Compress-22`, `Compress-35`, `Compress-43`

### Collections (Protocol & Deserialization)
- [ ] `Collections-8` (Binary wire format change invisible to BDD)

### Jackson Family (Architectural Complexity)
- [ ] `JacksonXml-5`, `JacksonXml-6` (Performance/Caching regressions)
- [ ] `JacksonDatabind-15`

### Jsoup (The Edge Case Jungle)
- [ ] `Jsoup-21`, `Jsoup-28`, `Jsoup-44` (Foster Parenting logic)
- [ ] `Jsoup-53`, `Jsoup-67`, `Jsoup-82`
- [ ] `Jsoup-84`, `Jsoup-88`, `Jsoup-91` (Binary detection heuristics)

### Lang (API Confusion)
- [ ] `Lang-17` (Surrogate pair API misuse)

### Math (The Final Boss of Logic)
- [ ] `Math-4`, `Math-10`, `Math-13`, `Math-17`, `Math-31`
- [ ] `Math-45`, `Math-52`, `Math-62`, `Math-63` (NaN regression)
- [ ] `Math-64`, `Math-66`, `Math-67`, `Math-68`
- [ ] `Math-76`, `Math-78`, `Math-81`, `Math-83`, `Math-84`, `Math-96`

---
*If you solve any of these using an Intent-Driven approach, please submit a PR!*