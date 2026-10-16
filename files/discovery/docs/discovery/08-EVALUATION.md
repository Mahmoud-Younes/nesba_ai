---
id: DISC-01-08
title: Nesba Discovery, Section 8 (evaluation plan)
parent: DISC-01
status: draft
last_verified: 2026-10-12
owner: TBD
---

> **AI NOTES**
> - What this is: the pre-specified evaluation plan for Nesba (نسبة; course-brief title NutriVision). It turns `HYP-01` to `HYP-04` and `OBJ-01` to `OBJ-08` into experiments, KPIs, tests and outcome bands. Hub: [DISCOVERY.md](DISCOVERY.md). Read [AI_CONTEXT.md](AI_CONTEXT.md) first.
> - Hypotheses: `HYP-01` time, `HYP-02` calorie error, `HYP-03` grounded against direct estimate, `HYP-04` source labels and trust. Wording is in `DISCOVERY.md` §1.3 and is not changed here.
> - IDs defined here: `EXP-01` to `EXP-06`, `KPI-01` to `KPI-38`, `TST-01` to `TST-16`, `RES-01` to `RES-18`.
> - All results are [T]. No experiment has run. Never write a result into this file by guessing.
> - Every threshold is an existing `OBJ-`, `SPK-` or requirement value, or a team assumption registered as `ASM-56` to `ASM-66`. Thresholds, sample sizes and dates are not approved.
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team. Treat [U] and [T] as unknown, never as facts.

# 8. Evaluation plan and success criteria

## 1 Principles and scope

**What is evaluated.**

| Area | Question | Where |
|---|---|---|
| Accuracy | Are calories close to sourced reference values on Egyptian meals? | EXP-02, EXP-03, EXP-05 |
| Speed | Is free text faster than manual search, and is analysis fast enough? | EXP-01, TST-11 |
| Usability and trust | Do users find the app usable, and do source labels raise trust? | EXP-04 |
| Source completeness | Does every shown number carry a source and a confidence label? | EXP-03, TST-05 |
| Restriction safety | Do recipes and alternatives ever break a declared restriction? | TST-03 |
| Offline and sync | Are writes kept and the UI never blocked? | TST-08, TST-09 |
| Security and privacy | Is the key protected, and is the consent flow in place? | TST-07, TST-10 |
| Engineering quality | Are tests, coverage, reviews and documentation in place? | TST-13, TST-16 |

**What is not evaluated.** Long-term adherence over weeks; any health outcome; accuracy on dishes outside the 30 reference meals; speed or accuracy compared with other apps (the baseline for `HYP-01` is the app's own manual search, `FR-16`); iOS; voice or photo entry; representativeness of the sample [A:ASM-11].

**Link to `RQ-01`.**

| Sub-question | Experiment | Hypothesis |
|---|---|---|
| RQ-01.1 accuracy | EXP-02 | HYP-02 |
| RQ-01.2 speed | EXP-01 | HYP-01 |
| RQ-01.3 grounding | EXP-03 | HYP-03 |
| RQ-01.4 source labels | EXP-04 | HYP-04 |
| RQ-01.5 intention to keep using | EXP-01 (the would-keep-using item) | HYP-01 |

**Pre-specification and freeze dates.** Everything in this file is written before any data are collected. Changes after a freeze are logged in the deviations table (`RES-17`) with a reason. Dates are proposals and depend on `OPEN-26` [A:ASM-65].

| Freeze | Date | What is frozen |
|---|---|---|
| F1 Protocol | 2026-10-19 | This file: thresholds, sample sizes, exclusion rules, analysis steps |
| F2 Reference values | 2026-10-29 | The 30 reference meals, their reference values and the reviewer's sign-off |
| F3 Pipeline | 2026-11-04 | Prompt, model id, schema, reference tables and code for the test run |
| F4 Data | 2026-11-18 | Raw data of all experiments; analysis starts only after this |

**Method sources.** Method choices that rest on literature are cited in §5 and §9 or tagged [U].

## 2 Success definition

### 2.1 Three levels

| Level | Meaning | The demo must show |
|---|---|---|
| Minimum | All `Must` requirements work and nothing unsafe or unlawful ships | The demo script `TST-15` passes every step; 0 critical defects open; no secret in the release APK (`KPI-31`); privacy notice, consent and delete-account present (`KPI-17`); the four hypotheses are reported honestly, whatever the band |
| Target | The `OBJ-` values are met | `KPI-01`, `KPI-03`, `KPI-06`, `KPI-09`, `KPI-10`, `KPI-14`, `KPI-15` and `KPI-17` are green |
| Stretch | The differentiators are shown with evidence | All four hypotheses in the Supported band; grounded estimate at least 5 points better than direct (the `SPK-03` pass value); `OBJ-03` in its full range of 100 to 200 dishes; "80% of meals within ±25%" reported after the `SPK-03` baseline (`04-FEASIBILITY.md` §10) |

### 2.2 Outcome bands per hypothesis

Bands for `HYP-01` to `HYP-04` repeat the numbers of `DISCOVERY.md` §1.6. "Inconclusive" is added: it applies when the data cannot answer the question, and it never counts as support.

| Hypothesis | Supported | Partly supported | Not supported | Inconclusive |
|---|---|---|---|---|
| HYP-01 | Median participant time ratio at most 0.60 (`KPI-18`) | Above 0.60 and at most 0.90 | Above 0.90 | Fewer than 8 valid participants, or the free-text arm failed for more than 20% of meals [A:ASM-57] |
| HYP-02 | MAPE at most 20% (`KPI-03`) | Above 20% and at most 30% | Above 30% | Reference values not reviewed or not sourced, or fewer than 30 valid meals |
| HYP-03 | Grounded is not worse than direct by more than 3 points and 100% of items are sourced (`KPI-20`, `KPI-21`) | Not worse by more than 3 points, but under 100% sourced | Grounded worse than direct by more than 3 points | Arm A not run on all 30 meals, or runs differ by more than the pre-set tolerance (§3, EXP-03) |
| HYP-04 | SUS at least 68 and a trust gain (`KPI-22`, `KPI-23`) | One of the two | Neither | Fewer than 5 usable participants |

**Actions per band.**

| Hypothesis | Band | What we change | What we may claim | What we say in the presentation |
|---|---|---|---|---|
| HYP-01 | Supported | Nothing | Free text was faster than manual search in the app for scripted meals in this sample | Show the ratio per participant and the range |
| HYP-01 | Partly | Add search and pick-list shortcuts; show the slowest meals | Faster for some participants or meals | Explain which meals were slow and why |
| HYP-01 | Not supported | Rework the flow; move `DR-04` actions earlier | No speed claim | Report it as a negative result with the cause |
| HYP-02 | Supported | Nothing; extend the dish table | Error within 20% on these 30 meals | Show per-dish errors, including the worst five |
| HYP-02 | Partly | Narrow the dish scope; fix the worst dishes | Error within 30%; list dishes above 20% | State which dishes fail |
| HYP-02 | Not supported | Improve the reference table; limit claims to dishes in the table | No accuracy claim | Report as a negative result |
| HYP-03 | Supported | Nothing | Sources added without worse accuracy, and every item sourced | Show both arms on the same meals |
| HYP-03 | Partly | Fix items without a source | Traceability gain, not complete | List the unsourced items |
| HYP-03 | Not supported | Revisit retrieval design (`DISCOVERY.md` §1.6) | No claim that grounding preserves accuracy | Report the loss |
| HYP-04 | Supported | Nothing | Users in this sample rated usability at or above the usual benchmark and trusted labelled numbers more | Show SUS per participant |
| HYP-04 | Partly | Redesign the weaker half (usability or label display) | One of the two | Say which half failed |
| HYP-04 | Not supported | Redesign the source display | No trust claim | Report it |

Reading of `HYP-03`: "within ±3 points" is applied as "grounded is not worse than direct by more than 3 points". A grounded result better than direct counts as support, and a margin of at least 5 points is the stretch level. `SPK-03` in `04-FEASIBILITY.md` states a pass value "at least 5 points better than Arm A", which is stricter than `HYP-03`; this plan keeps `HYP-03` as the band and uses the 5 points as stretch [A:ASM-56] (`OPEN-84`).

### 2.3 Outcome bands per objective

Bands for objectives: **Met** (green), **Partly met** (amber), **Not met** (red), **Inconclusive**. The amber range is within 10% of the target on the wrong side unless a source file gives another rule [A:ASM-59]. The KPI table in §6 holds the exact numbers.

| Objective | Met | Not met | Action when not met |
|---|---|---|---|
| OBJ-01 | At least 90 of 100 requests within 8.0 s | Fewer than 81 | Cache repeated text; reduce prompt size; tell the team before `GT-05` |
| OBJ-02 | MAPE at most 20% | Above 30% | As `HYP-02` |
| OBJ-03 | At least 95% of rows sourced and 20 of 20 spot-checked rows correct | Under 86% sourced or under 18 of 20 correct | Lower the dish count (`KC-01`); flag estimates |
| OBJ-04 | 0 violations in 20 tests and 30 of 30 fixtures rejected | Any violation | Block the release of recipes until fixed |
| OBJ-05 | At least 10 rules cases, all pass | Any case fails | Fix rules; no sharing of builds |
| OBJ-06 | Coverage of the calculation layer at least 80% | Under 72% | Add tests before `GT-05` |
| OBJ-07 | 100% of merges through a reviewed pull request; the 6 documentation topics present | Any merge without review, or under 5 topics | Fix settings; write missing docs |
| OBJ-08 | Notice, consent and delete-account all present before any real-user test | Any missing | No real-user test until fixed |

## 3 Hypotheses operationalised

Roles: Data lead, AI lead, Mobile lead, QA/security lead, Product/legal lead (as in `04-FEASIBILITY.md` §6). Sprint and gate dates are proposals [A:ASM-65].

**How the spikes of `04-FEASIBILITY.md` are reused.**

| Spike | Reused by |
|---|---|
| SPK-01 LLM parsing | EXP-05 |
| SPK-02 Data coverage | EXP-06 |
| SPK-03 Accuracy against reference values | EXP-02 (arm B) and EXP-03 (both arms) |
| SPK-04 Firestore offline | TST-09 |
| SPK-05 Key protection | TST-10, with the rules suite in TST-08 |
| SPK-06 Latency and size | TST-11, with the timing log of EXP-01 |

### EXP-01 Free text against manual search (HYP-01)

| Field | Content |
|---|---|
| Purpose | Test `HYP-01` (time) and record the intention to keep using (`RQ-01.5`). Faster does not guarantee sustained use [V:S-011], so the intention item is reported, not scored. |
| Design | Within-subject. Two conditions: free-text entry (`FR-15`) and manual search of the reference tables (`FR-16`, no AI call). Each participant logs the same 10 scripted meals in both conditions. Half of the participants start with free text, half with manual search. The second pass uses the same meals in a different order [A:ASM-57]. |
| Participants | Target 10, at least 8 valid. Adults (18+) with an Android phone, recruited by the channels of `03-USER-RESEARCH.md` §3.2. At least 3 who cook home dishes. No team member; one person per household [A:ASM-66]. Excluded: protocol deviation, device failure, or more than 30 minutes of earlier use of the app. |
| Materials | 10 meal cards in Arabic (dialect and Modern Standard Arabic mixed) and 2 practice cards. The 10 cards are a timing set, apart from the development set (§4). A test build with the timing log (`FR-69`); a mid-range Android device; one Wi-Fi network; a stopwatch as backup. |
| Procedure | Consent. Two practice meals, one per condition, untimed. Condition 1 (10 meals), 5-minute break, condition 2 (10 meals). After each condition: "I would keep logging my meals this way" (1 to 5). The timing runs from the first tap on the input or search field to the review screen showing all items and totals. A free-text analysis that fails or times out (`FR-23`) is recorded as a failure and its time includes the fallback. |
| Measures | Time per meal (s); participant ratio; failures; edits after analysis; the would-keep-using item. |
| Analysis | Per participant: r = sum of 10 free-text times divided by sum of 10 manual times. Report the median r, the range, and the number of participants with r at most 0.60. Per-meal median times by condition and paired per-meal differences. Descriptive statistics only. An interval method is optional and is [U] until a source is cited (`OPEN-81`). |
| Thresholds | Supported: median r at most 0.60. Partly: above 0.60 and at most 0.90. Not supported: above 0.90. Inconclusive: fewer than 8 valid participants, or failures in more than 20% of free-text meals. |
| Expected outcomes | **Best:** median r at most 0.60; claim speed inside the app for scripted meals. **Likely:** free text is faster for meals with several items and slower for single items, because the model wait and the review step cost time; consequence: add search and pick-list shortcuts. **Worst:** r above 0.90 because analysis wait outweighs typing savings; consequence: rework the flow and report a negative result. |
| Threats to validity | Order and learning effects (counterbalancing, practice, shuffled second pass). The manual baseline uses small local tables, so it can be faster than search in a large database app; the claim is limited to this app. Scripted meals are not the participants' own. Network variation (one Wi-Fi network; latency logged). Small sample. Social desirability on the intention item. |
| Ethics | Adults, informed consent consistent with `03-USER-RESEARCH.md` §3.3. Scripted meals only. No participant identity, name or phone goes into the app or to an AI model. |
| Data handling | Timing CSV on a team device, participant codes P01, P02, …; no account for participants; raw data deleted as `ASM-21` says. |
| Owner, gate, sprint | Mobile lead runs it; Product/legal lead owns consent. After `GT-05`, window 2026-11-13 to 2026-11-17. |

### EXP-02 Calorie accuracy on 30 reference meals (HYP-02)

| Field | Content |
|---|---|
| Purpose | Test `HYP-02` and `OBJ-02`; this is arm B of `SPK-03`. |
| Design | Offline replay of the 30 test meals through the grounded pipeline, 3 runs, with recorded AI responses so that two replays give identical files (`FR-67`). The pipeline is frozen at F3. |
| Participants | None. Reference reviewers: the dietitian reviewer (`OPEN-69`) and two team members. |
| Materials | A reference file: for each meal the description, a stated or weighed portion in grams, the ingredient list, reference energy and macronutrients, source IDs and the reviewer's sign-off (§4). |
| Procedure | F2 freeze of the reference file. F3 freeze of the pipeline. Three live runs record the AI responses; replays produce the CSV (`FR-67`). A second member recomputes 5 randomly chosen reference meals as a check of the reference itself. |
| Measures | Per-meal absolute percentage error of energy; MAPE; median error; share within ±20% and ±30%; signed bias; macro MAE; errors per phrasing set (dialect, Modern Standard Arabic, English) and per source layer (`KPI-03` to `KPI-05`). |
| Analysis | MAPE per run, then the mean of the 3 runs and the run range. A per-dish table with the worst five. Sensitivity: recompute with each reference moved by ±5% [A:ASM-61] and without meals whose reference is flagged low-confidence. Metric edge cases are in §5. |
| Thresholds | Supported: MAPE at most 20%. Partly: above 20% and at most 30%. Not supported: above 30%. Inconclusive: reference values unreviewed or unsourced, or fewer than 30 valid meals. |
| Expected outcomes | **Best:** at most 20%, driven by dishes found in the team table. **Likely:** larger errors on mixed plates and portion words; one study reports a mean error of 13.4% per 100 g on single foods, and meals with portions are harder [V:S-056]. **Worst:** above 30% because portions are mis-estimated; consequence: limit claims to dishes in the table and fix the worst dishes. |
| Threats to validity | Reference error and circularity: if the reference uses the same ingredient source as the app, the test measures pipeline fidelity, not nutritional truth, so the independence rule of §4 applies. Selection bias in the meal list (selection rules in §4). Tuning on the test set (a separate development set; no change after F3). Model drift between runs (pinned model id; recorded responses). Portion ambiguity. Only 30 meals. |
| Ethics | No human data. The meal texts are synthetic. |
| Data handling | CSV files and the reference file in the repository (no personal data). |
| Owner, gate, sprint | AI lead with Data lead. `GT-03`; `SPK-03` due 2026-11-05. |

### EXP-03 Grounded pipeline against direct estimate (HYP-03)

| Field | Content |
|---|---|
| Purpose | Test `HYP-03`: grounding adds traceability without hurting accuracy. |
| Design | Paired design on the same 30 test meals. Arm A: a direct model estimate with no reference data, in the evaluation tool only (`FR-68`). Arm B: the grounded pipeline. 3 runs per arm. |
| Participants | None. |
| Materials | The EXP-02 reference file; the frozen arm A prompt (same model and meal text, asks for energy and macronutrients per meal); the arm B pipeline. |
| Procedure | Same freeze rules as EXP-02. Each arm gets the same prompt effort on the development set (§4). Arm A runs on the same days as arm B to limit drift. |
| Measures | Per-meal absolute percentage error in both arms; D = MAPE of arm A minus MAPE of arm B, in percentage points; share of meals where B is better; source completeness of arm B (share of shown items with a source name and a confidence label, `FR-28`) (`KPI-20`, `KPI-21`). |
| Analysis | D from the mean of the 3 runs; per-meal paired differences and their median; run-to-run range per arm. Descriptive statistics only. Arm A has no source by design. |
| Thresholds | Supported: D is at least −3 and source completeness is 100%. Partly: D is at least −3 and completeness is under 100%. Not supported: D is below −3. Inconclusive: arm A missing for some meals, or the run range of an arm above 3 points [A:ASM-56]. Stretch: D at least 5. |
| Expected outcomes | **Best:** B at least 5 points better. **Likely:** about equal, which still counts as support; a 2026 preprint reports that a direct estimate can match a retrieval pipeline on overall accuracy for meal images, while grounding gives an auditable record [V:S-014], and the transfer to text is an assumption [A:ASM-05]. **Worst:** B worse than A by more than 3 points because of matching errors; consequence: revisit retrieval design and report it. |
| Threats to validity | Asymmetric tuning (equal effort rule). The grounded table and the reference built from the same recipes would favour B (independence rule, §4). Model drift. The direct arm may know dishes better than the table. Only 30 meals. |
| Ethics | No human data. |
| Data handling | As EXP-02. |
| Owner, gate, sprint | AI lead with Data lead. `GT-03`; due 2026-11-05. |

### EXP-04 Source labels, trust and usability (HYP-04)

| Field | Content |
|---|---|
| Purpose | Test `HYP-04`: source labels raise trust, with SUS at least 68. |
| Design | A small usability test. Each participant does two blocks of scripted tasks: one with source labels visible and one with them hidden (`FR-70`, test build only). Block order and the task set of each block are counterbalanced [A:ASM-58]. |
| Participants | Target 6, at least 5. Adults (18+) with an Android phone: 2 each from the three persona types `PER-01`, `PER-02` and `PER-03`, recruited as for EXP-01. For distinct user groups, Nielsen advises at least 3 per group and 5 or fewer in total per test [V:S-121]; with 3 groups this plan is below that, so findings are indicative. |
| Materials | Two equivalent task sets, three tasks each: log a scripted meal of three items; find or judge the source of one item; correct a quantity and save. A common final task: find yesterday's meal in the history. The 10 standard SUS items and two trust items (§5). A test build; paper or an outside form for the answers; no identity stored with answers. |
| Procedure | Consent; short briefing; block 1; trust items; block 2; trust items; the SUS about the version with labels ("rate the version that showed sources"); a question on which version the participant prefers and why. The moderator reads a fixed script and gives no hints. |
| Measures | Task success; time per task; errors and hesitations (observer count); SUS per participant; trust items per block; preference; observer notes (`KPI-22`, `KPI-23`). |
| Analysis | SUS per participant: sum of (score − 1) for odd items plus (5 − score) for even items, times 2.5 [V:S-118,S-120]. Report the mean, median and range against 68. Trust: with-labels median, and the paired difference (with minus without) per participant. Notes coded with the themes of `03-USER-RESEARCH.md` §3.6. |
| Thresholds | Supported: SUS at least 68 and a trust gain. A trust gain means the with-labels median of the main trust item is at least 4.0, the median paired difference is above 0, and it is positive for more than half of the participants [A:ASM-58]. Partly: one of the two. Not supported: neither. Inconclusive: fewer than 5 usable participants. |
| Expected outcomes | **Best:** both met. **Likely:** trust gain clear for some persona types and weaker for others; SUS near the benchmark with a wide range, as small samples give imprecise SUS estimates [V:S-120]. **Worst:** labels read as clutter and SUS under 68; consequence: redesign the source display. |
| Threats to validity | Very small sample, so five users reveal many but not all problems and a fresh test is needed after a redesign [V:S-121]. Demand effects: participants may guess that labels are the feature. The Arabic SUS is a team translation; no validated Arabic version was retrieved [U] (`OPEN-80`). Order and learning effects (counterbalanced). Trust is self-reported, not behaviour. Prototype maturity. Moderator bias (script). |
| Ethics | Adults, consent consistent with `03-USER-RESEARCH.md` §3.3; scripted meals; no recording unless the participant agrees. |
| Data handling | Paper or an outside form, participant codes only; deleted as `ASM-21` says. |
| Owner, gate, sprint | Product/legal lead with Mobile lead. After `GT-05`, window 2026-11-13 to 2026-11-17. |

### EXP-05 Parse quality and dialect (SPK-01) — proposed extra

| Field | Content |
|---|---|
| Purpose | Choose the parse model and test the Egyptian dialect set. It supports every claim about parsing in `RQ-01`; it is not one of the four hypotheses. |
| Design | As `SPK-01`: 3 candidate models, same prompt and schema, 3 runs each, fixed low temperature. |
| Participants | None; two team members label the gold items independently and report agreement. |
| Materials | The 30 development descriptions of `SPK-01` (10 dialect, 10 Modern Standard Arabic, 10 English). |
| Procedure, measures | As `SPK-01`: item recall and precision, quantity and unit accuracy, JSON validity, latency, tokens, cost (`KPI-24` to `KPI-27`, `KPI-33`). |
| Thresholds | The `SPK-01` pass values: recall and precision at least 0.90 overall and at least 0.85 on dialect; quantity and unit at least 0.80; JSON valid at least 0.98; parse p90 at most 4 s; cost at most $5 per 1,000 (all [A:ASM-31]). |
| Expected outcomes | **Best:** one model passes all. **Likely:** dialect recall is the weak point (`RSK-04`). **Worst:** no model passes; consequence: Plan B model or manual entry (`KC-02`). |
| Threats, ethics | Model drift (pinned id; regression set, `RSK-20`); free-tier terms let the provider use inputs, so only synthetic text is sent (`ASM-32`). |
| Owner, gate, sprint | AI lead. `GT-02`, 2026-10-29. |

### EXP-06 Reference-data coverage (SPK-02) — proposed extra

| Field | Content |
|---|---|
| Purpose | Decide the order and content of the resolve layers; it feeds `OBJ-03` and `KC-01`. |
| Design | As `SPK-02`: 40 names (20 dishes, 20 ingredients) in Arabic and English, each with a hand-picked correct target. |
| Participants, materials | None. Local dish table (first 60 dishes), bundled USDA subset, Open Food Facts name search. |
| Procedure, measures | As `SPK-02`: top-1 and top-3 hit rates, and kcal per 100 g against the reference (`KPI-28`, `KPI-29`). |
| Thresholds | The `SPK-02` pass values: local dish hit@3 at least 0.70, ingredient hit@3 at least 0.90, and kcal per 100 g within ±15% for at least 80% of hits [A:ASM-31]. |
| Expected outcomes | **Best:** both local layers pass. **Likely:** dish hit rate is the weak point because the table is small. **Worst:** fewer than 70% of dishes resolve after 60 entries; consequence: `KC-01`. |
| Threats, ethics | Names are chosen by the team, so selection bias is possible. No human data. |
| Owner, gate, sprint | Data lead. `GT-03`, 2026-10-29. |

## 4 Reference data and test sets

### 4.1 Sets and the freeze rule

| Set | Size | Used for | Tuning allowed | Frozen at |
|---|---|---|---|---|
| DEV-1 parse set | 30 descriptions of `SPK-01` | EXP-05; model and prompt choice | Yes, until F3 | F3 |
| DEV-2 name set | 40 names of `SPK-02` | EXP-06; layer order | Yes, until F3 | F3 |
| DEV-3 pipeline meals | 20 meals with reference values [A:ASM-60] | Tuning of the full pipeline, rules and arm A prompt | Yes, until F3 | F3 |
| TS timing set | 10 meal cards | EXP-01 | No | F1 |
| TEST-30 | 30 reference meals | EXP-02, EXP-03 | **Never** | F2 |
| RS recipe tests | 20 tests plus the fixtures of `FR-40` and `FR-41` | TST-03 | Fixtures may be added, never removed | F3 |
| LS latency set | 100 distinct requests | TST-11 | No | F3 |
| Rules cases | at least 10 (14 listed in §4.4) | TST-08 | Cases may be added | F3 |

**Freeze rule.** Any text, meal or name used to tune a prompt, a rule or a table is development data and may not be in TEST-30. A meal found in both is removed from TEST-30 and replaced before F2. After F3 nobody changes the prompt, model id, schema, reference tables or matching code until the test run is finished. A change after F3 needs a deviation row (`RES-17`) and a new run [A:ASM-60].

### 4.2 The 30 reference meals

| Rule | Content |
|---|---|
| Composition | 10 single-dish home meals; 10 mixed plates of 2 to 4 items; 5 sandwiches or street food; 5 breakfast items, drinks or desserts |
| Brief meals | The six meals of `02-COMPETITORS.md` §2.7 are included: koshari plate, ful medames with baladi bread, taameya sandwich of 4 pieces, molokhia with rice and chicken, mahshi of 5 pieces, feteer meshaltet with honey |
| Phrasing | 10 Egyptian dialect, 10 Modern Standard Arabic, 10 English |
| Difficulty | 10 easy (one item, quantity stated), 10 medium (2 to 3 items, household units), 10 hard (4 or more items, or no quantity stated) |
| Table coverage | At least 20 dishes are in the team dish table and at least 5 are deliberately absent, so that the fallback layers are tested; the share is reported |
| Energy floor | No meal with a reference energy under 50 kcal |
| Process | Two team members and the reviewer choose the list before any model output is seen; it is signed before F2 |

Selection rules are team proposals [A:ASM-62].

### 4.3 Reference values

- **Method.** Each meal has a recipe with weighed or documented standard grams per ingredient. Energy and macronutrients are computed from the ingredient source decided in `OPEN-21`, by a member who has not seen any app output.
- **Review.** The dietitian reviewer (`OPEN-69`) reviews and signs each meal. A second member recomputes 5 meals. If two computations differ by more than 5% in energy, the reviewer decides and the file records the reason.
- **Independence rule.** A reference value is never copied from a row of the app's dish table. If the app and the reference use the same ingredient source (for example the USDA subset), the report says so, because then EXP-02 and EXP-03 measure the pipeline (parsing, portions, matching) and not nutritional truth [A:ASM-61].
- **Uncertainty.** Each reference is moved by ±5% in the sensitivity analysis; meals with unknown weights are flagged low-confidence [A:ASM-61].
- **Open.** The source of the reference values and the reviewer are not chosen (`OPEN-21`, `OPEN-78`). EXP-02 and EXP-03 cannot run until they are.

### 4.4 Meal cards, recipe tests and rules cases

**Timing set TS (EXP-01).** Ten cards: 4 single-item, 4 with two or three items, 2 with four items; mixed dialect and Modern Standard Arabic; wording separate from the development sets.

| Card | Type | Language | Items |
|---|---|---|---|
| TS-01 to TS-10 | [T] | [T] | [T] |

**Recipe tests for `OBJ-04`.** Five restrictions (vegetarian, lactose-free, gluten-free, low sugar, low salt; `ASM-49`) with four tests each, 20 in total: two requests that must return only compliant recipes, and two cases with mocked model output that contain a violating or untagged ingredient and must be rejected. The 30 fixtures of `FR-40` (20 violating, 10 untagged) and the 10 fixtures of `FR-41` run in the same suite [A:ASM-64].

**Rules cases for `OBJ-05`.** 14 cases, of which at least 10 are required:

| # | Case | Expected |
|---|---|---|
| 1 | Owner reads own meal | Allowed |
| 2 | Owner writes a valid meal | Allowed |
| 3 | Owner deletes own meal | Allowed |
| 4 | Another signed-in user reads the meal | Denied |
| 5 | Another signed-in user writes into the owner's path | Denied |
| 6 | Another signed-in user deletes the meal | Denied |
| 7 | Signed-out read | Denied |
| 8 | Signed-out write | Denied |
| 9 | Write with a wrong field type | Denied |
| 10 | Write with an extra field | Denied |
| 11 | Write with an oversized document | Denied |
| 12 | Write of another user's profile document | Denied |
| 13 | Document that claims another user's id | Denied |
| 14 | Query across all users' meals | Denied |

## 5 Metric definitions

| Metric | Formula and rule | Edge cases |
|---|---|---|
| Absolute percentage error (APE) of a meal | 100 × \|app energy − reference energy\| ÷ reference energy | Percentage errors are undefined at a reference of zero and unstable near zero [V:S-122,S-123]. TEST-30 has no reference under 50 kcal; if one slips in, report its absolute error and leave it out of MAPE [A:ASM-61] |
| MAPE | Mean of the APE over the valid meals, N = 30; mean of the 3 run values; also report the run range | A meal with no result counts as a failure and is listed; more than 3 failures make the run inconclusive |
| Median APE, share within ±20% and ±30% | Median of APE; count of meals with APE at most 20 or 30, divided by N | none |
| Signed bias | Mean of 100 × (app − reference) ÷ reference | Positive means over-estimation |
| MAE of protein, carbohydrate, fat | Mean of \|app grams − reference grams\| per macronutrient, in grams | No percentage: small denominators |
| D (HYP-03) | MAPE of arm A minus MAPE of arm B, in percentage points | Positive means grounded is better |
| Item recall | Gold items found ÷ gold items | Two labellers; disagreements settled by discussion; agreement is reported |
| Item precision | Matched predicted items ÷ predicted items | A predicted item matches when its normalised food id equals a gold item's |
| Quantity and unit accuracy | Matched items whose count is exact (counted items) or whose grams are within ±25% of gold grams, ÷ matched items | The tolerance is a team proposal [A:ASM-61] |
| JSON validity rate | Responses that parse and pass the schema ÷ responses | Retries count as separate responses |
| Source completeness | Shown items with a source name and a confidence label ÷ shown items (`FR-28`) | Arm A has no source by design |
| Restriction violations | Suggestions with at least one ingredient that fails the tag check or has no tag ÷ suggestions tested | Any violation fails `OBJ-04` |
| Hit at k | Queries whose target is among the top k results ÷ queries | k = 1 and 3 |
| Latency | Time from sending the text to the item list shown. With N = 100 requests sorted ascending, the p90 is the 90th value (nearest-rank); the pass test is "at least 90 of 100 requests at most 8.0 s" | A failed or timed-out request counts as slower than 8 s [A:ASM-63] |
| Time ratio (HYP-01) | Per participant: sum of free-text times ÷ sum of manual-search times over the 10 meals | Failures keep their measured time |
| Cost per analysis | (input tokens × input price + output tokens × output price) ÷ analyses, shown per 1,000 analyses | Prices are read on the run day; they change often [U] |
| SUS score | Per participant: sum over odd items of (score − 1) plus sum over even items of (5 − score), times 2.5; the system score is the mean of participants [V:S-118,S-120] | All 10 items are needed; changing item wording can invalidate the scoring, so wording changes are recorded [U] |
| Trust items | TR-1 "I trust the numbers shown for this meal" and TR-2 "I understand where each number comes from", each 1 (strongly disagree) to 5 (strongly agree); Arabic wording [T] | TR-1 is the main item [A:ASM-58] |
| Line coverage | Covered lines ÷ instrumentable lines of `lib/**/domain/**` from the coverage report (ADR-25) | Generated code is excluded |
| Must requirements covered by automated tests | Must requirements with at least one automated test ÷ Must requirements (§7.3) | none |
| Review rate | Merged pull requests with at least one approving review ÷ merged pull requests | Direct pushes to `main` count as failures |

**Method sources.** The SUS formula and the benchmark of 68 as the usual average: [V:S-118,S-120]; the original scale and its large-sample evaluation: [V:S-119]. The cautions on percentage errors: [V:S-122,S-123]. No source was retrieved for bootstrap intervals, so they are optional and [U] (`OPEN-81`).

## 6 KPI table

Bands: amber means within 10% of the target on the wrong side unless the source file gives another rule [A:ASM-59]. Results are [T] in §10.

| ID | Name | Definition and formula | Data source and method | Target | Green / amber / red | Owner | When | Links |
|---|---|---|---|---|---|---|---|---|
| KPI-01 | Analysis latency | Requests within 8.0 s out of 100 (§5) | Timing log (`FR-69`), TST-11 | At least 90 of 100 | 90+ / 81–89 / 80 or fewer | Mobile lead | `GT-05`, 2026-11-12 | OBJ-01, NFR-01 |
| KPI-02 | Parse-step latency p90 | 90th value of parse times (SPK-01, SPK-06) | Latency log | At most 4 s | 4.0 or less / 4.1–4.4 / over 4.4 | AI lead | `GT-02`, `GT-05` | NFR-02 (Should), SPK-01 |
| KPI-03 | Calorie MAPE | Mean APE over 30 meals (§5) | EXP-02 CSV (`FR-67`) | At most 20% | 20 or less / 20–30 / over 30 | AI lead | 2026-11-05 | OBJ-02, HYP-02, NFR-29 |
| KPI-04 | Meals within ±20% | Share with APE at most 20 | EXP-02 CSV | Report only | n/a | AI lead | 2026-11-05 | HYP-02 |
| KPI-05 | Macro MAE | MAE protein, carbohydrate, fat (g) | EXP-02 CSV | Report only | n/a | AI lead | 2026-11-05 | SPK-03 |
| KPI-06 | Sourced rows | Reference rows with a source ID ÷ rows | Audit script (`FR-66`), CI | At least 95% | 95+ / 86–94 / 85 or fewer | Data lead | CI; before the report | OBJ-03, FR-66 |
| KPI-07 | Dish count | Dishes in the table | Audit script | At least 30 (floor); 100 to 200 (target) | 100+ / 30–99 / under 30 | Data lead | `GT-03` and final | OBJ-03, FR-63, FR-64 |
| KPI-08 | Spot-check | Correct rows among 20 checked by hand | Reviewer's check | 20 of 20 | 20 / 18–19 / 17 or fewer [A:ASM-64] | Data lead | Before the report | OBJ-03 |
| KPI-09 | Restriction violations | Violations in the 20 tests; fixtures rejected of 30 | TST-03 | 0 violations; 30 of 30 rejected | 0 / none / 1 or more | Mobile lead | CI | OBJ-04, FR-40 |
| KPI-10 | Rules tests | Cases passing of the §4.4 cases | Emulator suite, TST-08 | All pass, at least 10 cases | All / none / any fails | QA/security lead | CI, `GT-01b` | OBJ-05, FR-49 |
| KPI-11 | Lost writes | Writes lost in 20 runs per scenario | TST-09 (SPK-04) | 0 | 0 / none / 1 or more | Mobile lead | `GT-01`, 2026-10-22 | NFR-05, KC-03 |
| KPI-12 | Reconnect sync time | Seconds for 50 queued writes to reach the cloud | TST-09 | At most 30 s | 30 or less / 31–33 / over 33 | Mobile lead | `GT-01` | NFR-06 |
| KPI-13 | Local action time | Time of the local actions of `NFR-03` | TST-09, integration tests | At most 300 ms | 300 or less / 301–330 / over 330 | Mobile lead | `GT-01` | NFR-03, NFR-04 |
| KPI-14 | Domain line coverage | Section 5 | CI coverage report | At least 80% | 80+ / 72–79 / under 72 | Mobile lead | CI; `GT-05` | OBJ-06, NFR-17 |
| KPI-15 | Reviewed merges | Review rate (§5) | Repository settings and history | 100% | 100 / none / under 100 | Product/legal lead | Weekly; final | OBJ-07, NFR-18 |
| KPI-16 | Documentation topics | Topics present of the 6 of `NFR-19` | Checklist review | 6 of 6 | 6 / 5 / 4 or fewer | Product/legal lead | Before release | OBJ-07, NFR-19 |
| KPI-17 | Privacy items | Notice, consent screen, delete-account path present, and the region stated | Checklist by two members and the supervisor | All present | All / none / any missing | Product/legal lead | Before any real-user test | OBJ-08, NFR-11 |
| KPI-18 | Time ratio | Median participant ratio (§5) | EXP-01 | At most 0.60 | 0.60 or less / 0.61–0.90 / over 0.90 | Mobile lead | 2026-11-13 to 2026-11-17 | HYP-01 |
| KPI-19 | Would-keep-using | Median of the 1 to 5 item per condition | EXP-01 | Report only | n/a | Mobile lead | as KPI-18 | RQ-01.5 |
| KPI-20 | MAPE difference | D (§5) | EXP-03 | At least −3 points | −3 or more / none / below −3 | AI lead | 2026-11-05 | HYP-03 |
| KPI-21 | Source completeness | Section 5 | EXP-03, TST-05 | 100% | 100 / 95–99.9 / under 95 | Data lead | 2026-11-05 | HYP-03, FR-28 |
| KPI-22 | SUS | Mean and median SUS | EXP-04 | At least 68 | 68+ / 61–67.9 / under 61 | Product/legal lead | 2026-11-13 to 2026-11-17 | HYP-04, NFR-13 |
| KPI-23 | Trust gain | Section 2.2 and EXP-04 definition | EXP-04 | Gain present | Both parts / one part / neither | Product/legal lead | as KPI-22 | HYP-04, NFR-14 |
| KPI-24 | Item recall | Section 5 | EXP-05 | At least 0.90 overall; 0.85 on dialect | At target / within 10% / below | AI lead | `GT-02` | SPK-01 |
| KPI-25 | Item precision | Section 5 | EXP-05 | At least 0.90 overall; 0.85 on dialect | At target / within 10% / below | AI lead | `GT-02` | SPK-01 |
| KPI-26 | Quantity and unit accuracy | Section 5 | EXP-05 | At least 0.80 | 0.80+ / 0.72–0.79 / under 0.72 | AI lead | `GT-02` | SPK-01, RSK-15 |
| KPI-27 | JSON validity | Section 5 | EXP-05 | At least 0.98 | 0.98+ / 0.88–0.97 / under 0.88 | AI lead | `GT-02` | SPK-01, FR-22 |
| KPI-28 | Dish hit@3 | Section 5 | EXP-06 | At least 0.70 | 0.70+ / 0.63–0.69 / under 0.63 | Data lead | `GT-03`, 2026-10-29 | SPK-02, KC-01 |
| KPI-29 | Ingredient hit@3 | Section 5 | EXP-06 | At least 0.90 | 0.90+ / 0.81–0.89 / under 0.81 | Data lead | `GT-03` | SPK-02 |
| KPI-30 | Fault-injection crashes | Crashes in the 20 cases (timeout, invalid response, 429, quota exhausted, no network) | TST-06 | 0 | 0 / none / 1 or more | Mobile lead | CI | NFR-07 |
| KPI-31 | Secrets in release APK | Secrets found by decompile and search | TST-10 (SPK-05) | 0 | 0 / none / 1 or more | QA/security lead | `GT-01b`, 2026-10-22 | NFR-08 |
| KPI-32 | Call without token | Whether the AI endpoint rejects a replayed request without a token | TST-10 | Rejected | Rejected / none / accepted | QA/security lead | `GT-01b` | NFR-09 |
| KPI-33 | Cost per 1,000 analyses | Section 5 (paid-tier equivalent) | Token and price log | At most $5 | 5 or less / 5.01–5.50 / over 5.50 | AI lead | `GT-02` | SPK-01, NFR-26 |
| KPI-34 | Daily AI quota use | Peak daily requests ÷ the free daily limit read from the console | Provider console | At most 80% | 80 or less / 81–88 / over 88 | AI lead | During evaluation | NFR-28, RSK-05 |
| KPI-35 | Daily Firestore reads | Reads ÷ the free daily quota | Firebase console | At most 50% | 50 or less / 51–55 / over 55 | Mobile lead | During the pilot | NFR-27, RSK-21 |
| KPI-36 | Automated Must coverage | Section 7.3 | Matrix in §7.3 | At least 80% | 80+ / 72–79 / under 72 | QA/security lead | `GT-05` | OBJ-06 |
| KPI-37 | Demo script pass rate | Steps of `TST-15` passed ÷ steps | Demo rehearsal | 100% | 100 / 90–99 / under 90 | Product/legal lead | Before the final demo | Minimum level |
| KPI-38 | Size and memory | Release APK size; memory at idle and during analysis; bundled data size | Build output; profiler | Report only (`NFR-25`) | n/a | Mobile lead | `GT-05` | NFR-25, SPK-06 |

**Survey decision rules.** `DR-01` to `DR-06` are evaluated with the survey analysis plan in `03-USER-RESEARCH.md` §3.6 (not rewritten here). Results go to its table `RT-05`.

| Rule | Analysis step (see `03-USER-RESEARCH.md` §3.6) | Question |
|---|---|---|
| DR-01 | Share naming time or effort as a main reason among people who track or quit | SQ-08 |
| DR-02 | Mean concern about foreign servers | SQ-16 |
| DR-03 | Share using iPhone, with the Statcounter caveat | SQ-03 |
| DR-04 | Median willingness to type | SQ-12 |
| DR-05 | Median source-label trust | SQ-15 |
| DR-06 | Share rating Egyptian-dish finding as hard | SQ-10 |

## 7 Test plan

### 7.1 Levels, tools and suites

Tools follow `06-DECISIONS.md`: `flutter_test` for unit and widget tests, `integration_test` on devices, `mocktail` for fakes, `bloc_test` for Bloc and Cubit tests (ADR-25); the Firebase emulator with `@firebase/rules-unit-testing` (ADR-12); a coverage script filtered to `domain/` (ADR-25); GitHub Actions on every pull request (ADR-27); secret scan and dependency scan (ADR-22, ADR-23). The experiments EXP-01 to EXP-06 cover the rest.

| ID | Suite | Level and tool | Scope | Must requirements covered | Gate |
|---|---|---|---|---|---|
| TST-01 | Domain unit tests | Unit; `flutter_test`, `mocktail` | Nutrient maths, unit conversion, grams basis, parse validators, timeout, text-as-data rules | FR-18, FR-21, FR-22, FR-23, FR-24, FR-32, FR-33 | `GT-03` |
| TST-02 | Reference data and resolution tests | Unit; audit script in CI | Dish and USDA tables, alias matching, per-100 g values, the audit script | FR-25, FR-63, FR-65, FR-66 | `GT-03` |
| TST-03 | Restriction and alternatives tests | Unit; `flutter_test` | 20 recipe tests, 30 plus 10 fixtures, tag check, lower-energy alternatives | FR-39, FR-40, FR-41 | `GT-03` |
| TST-04 | Safety and refusal tests | Unit and widget | Refusal of diagnosis and dose requests, disclaimers, allergen wording | FR-50, FR-51, FR-52 | `GT-04` |
| TST-05 | Screens and Bloc tests | Widget; `flutter_test`, `bloc_test`, `mocktail` | Log, review, source labels, history, charts, settings, states, permission flow, 200% font scale, 48 dp targets | FR-02, FR-12, FR-13, FR-15, FR-16, FR-17, FR-19, FR-27, FR-28, FR-35, FR-36, FR-42, FR-43, FR-44, FR-48, FR-55, FR-61, FR-62 | `GT-05` |
| TST-06 | Networking and fault-injection tests | Unit with a mock adapter | Dio chain, User-Agent, retry, error mapping, redacted logs, 20 fault cases | FR-56, FR-57, FR-58, FR-59, FR-60, NFR-07 | `GT-01` |
| TST-07 | Account, consent and privacy tests | Integration; widget; checklist | Sign-in, consent record, no data before consent, delete account, notice and region statement | FR-01, FR-03, FR-05, FR-06, FR-07, FR-08, FR-09, FR-10, FR-11, NFR-11 | `GT-04` |
| TST-08 | Firestore rules suite | Emulator; `@firebase/rules-unit-testing` | The 14 cases of §4.4, run on every pull request | FR-49 | `GT-01b` |
| TST-09 | Offline and sync scenarios | Integration on devices (SPK-04) | Nine offline scenarios, 20 runs each; reconnect with 50 queued writes; local action timing | FR-37, FR-46, FR-47, NFR-03, NFR-05, NFR-06 | `GT-01` |
| TST-10 | Security checks | Scripted checks (SPK-05) | Decompile search, token replay, emulator call, logs, cleartext traffic, network inspection | NFR-08, NFR-09, NFR-10 | `GT-01b` |
| TST-11 | Performance protocol | Scripted run on a device (SPK-06) | 100 requests on Wi-Fi and mobile data; parse step; size and memory | NFR-01 | `GT-05` |
| TST-12 | Evaluation tooling tests | Unit; integration | Byte-identical CSV on replay; timing log in test builds only; no direct-estimate path in release | FR-67, FR-69, NFR-29 | `GT-03` |
| TST-13 | CI and repository checks | CI; settings review | Analysis, format, coverage gate, notices file, secret and dependency scans, protected branch | NFR-12, NFR-17, NFR-18, NFR-20, NFR-21, NFR-26 | `GT-01` |
| TST-14 | Device compatibility run | Scripted run on devices | Four core flows, 10 runs per device | NFR-24 | `GT-05` |
| TST-15 | Demo acceptance script | Rehearsed manual run | The end-to-end demo of §7.9 | see §7.9 | Final |
| TST-16 | Documentation and claims review | Review | README topics, personas and wireframes, banned terms in app texts and store text | FR-53, NFR-19, NFR-22 | `GT-05` |

### 7.2 Environments and device matrix

Device models are not known (`OPEN-27`, `OPEN-82`, `ASM-35`); cells stay [T].

| ID | Device | Android version | RAM | Role | Used for |
|---|---|---|---|---|---|
| D1 | [T] mid-range phone | [T] | [T] | Main test device | TST-09, TST-11, TST-14, EXP-01, EXP-04 |
| D2 | [T] low-RAM phone | [T] | [T] | Stress device | TST-09, TST-11, TST-14 |
| D3 | [T] oldest phone, at least the minimum of ADR-02 (default API 24) | [T] | [T] | Compatibility | TST-14 |
| E1 | CI emulator | [T] | [T] | Automated runs | TST-05, TST-08, TST-13 |

Network conditions: Wi-Fi on one fixed network; mobile data on a named operator [T] (`OPEN-82`).

### 7.3 Matrix: every Must requirement to a level and a suite

A requirement is counted as covered by an automated test when its verification in `05-REQUIREMENTS.md` includes a unit, widget or integration test, or when it is checked by a script or CI job without human judgement (marked `Y`). The plan covers 66 of 75 Must requirements by automated tests (88.0%); the target is at least 80% (`KPI-36`) [A:ASM-64].

| Requirement | Module or category | Verification (from `05-REQUIREMENTS.md`) | Suite or experiment | Automated |
|---|---|---|---|---|
| FR-01 | Account | integration | TST-07 | Y |
| FR-02 | Account | widget | TST-05 | Y |
| FR-03 | Account | integration; manual | TST-07 | Y |
| FR-05 | Account | integration | TST-07 | Y |
| FR-06 | Consent and privacy | widget; integration | TST-07 | Y |
| FR-07 | Consent and privacy | unit; integration | TST-07 | Y |
| FR-08 | Consent and privacy | unit; widget | TST-07 | Y |
| FR-09 | Consent and privacy | integration | TST-07 | Y |
| FR-10 | Consent and privacy | unit; integration | TST-07 | Y |
| FR-11 | Consent and privacy | integration; manual | TST-07 | Y |
| FR-12 | Profile | widget | TST-05 | Y |
| FR-13 | Localisation | unit; widget | TST-05 | Y |
| FR-15 | Meal entry | widget; experiment SPK-01 | TST-05; EXP-05 | Y |
| FR-16 | Meal entry | widget; integration | TST-05 | Y |
| FR-17 | Meal entry | widget; unit | TST-05 | Y |
| FR-18 | Meal entry | unit; widget | TST-01 | Y |
| FR-19 | Meal entry | widget; manual | TST-05 | Y |
| FR-21 | Parsing and resolution | experiment SPK-01; unit | TST-01; EXP-05 | Y |
| FR-22 | Parsing and resolution | unit; integration | TST-01 | Y |
| FR-23 | Parsing and resolution | unit; widget | TST-01 | Y |
| FR-24 | Parsing and resolution | unit; experiment SPK-01 | TST-01; EXP-05 | Y |
| FR-25 | Parsing and resolution | unit; experiment SPK-02 | TST-02; EXP-06 | Y |
| FR-27 | Parsing and resolution | unit; widget | TST-05 | Y |
| FR-28 | Parsing and resolution | widget; experiment SPK-03 | TST-05; EXP-03 | Y |
| FR-32 | Nutrition calculation | unit | TST-01 | Y |
| FR-33 | Nutrition calculation | unit | TST-01 | Y |
| FR-35 | Nutrition calculation | widget | TST-05 | Y |
| FR-36 | Correction | widget; unit | TST-05 | Y |
| FR-37 | Correction | integration | TST-09 | Y |
| FR-39 | Recipes and alternatives | unit | TST-03 | Y |
| FR-40 | Recipes and alternatives | unit | TST-03 | Y |
| FR-41 | Recipes and alternatives | unit; widget | TST-03 | Y |
| FR-42 | History and charts | widget; integration | TST-05 | Y |
| FR-43 | History and charts | widget; unit | TST-05 | Y |
| FR-44 | History and charts | widget | TST-05 | Y |
| FR-46 | Sync and offline | integration; experiment SPK-04 | TST-09 | Y |
| FR-47 | Sync and offline | integration; experiment SPK-04 | TST-09 | Y |
| FR-48 | Sync and offline | widget; integration | TST-05 | Y |
| FR-49 | Sync and offline | integration | TST-08 | Y |
| FR-50 | Safety | unit; experiment SPK-01 | TST-04; EXP-05 | Y |
| FR-51 | Safety | widget | TST-04 | Y |
| FR-52 | Safety | unit; widget | TST-04 | Y |
| FR-53 | Safety | unit; manual | TST-16 | Y |
| FR-55 | Settings and about | widget; unit | TST-05 | Y |
| FR-56 | Networking and device | unit | TST-06 | Y |
| FR-57 | Networking and device | unit | TST-06 | Y |
| FR-58 | Networking and device | unit | TST-06 | Y |
| FR-59 | Networking and device | unit; integration | TST-06 | Y |
| FR-60 | Networking and device | unit; widget | TST-06 | Y |
| FR-61 | Networking and device | widget; integration | TST-05 | Y |
| FR-62 | States | widget | TST-05 | Y |
| FR-63 | Reference data | unit; manual | TST-02 | Y |
| FR-65 | Reference data | unit | TST-02 | Y |
| FR-66 | Reference data | unit | TST-02 | Y |
| FR-67 | Evaluation tooling | unit; integration | TST-12 | Y |
| FR-69 | Evaluation tooling | unit; manual | TST-12 | Y |
| NFR-01 | Performance | performance run | TST-11 | Y |
| NFR-03 | Performance | integration | TST-09 | Y |
| NFR-05 | Reliability and offline | integration | TST-09 | Y |
| NFR-06 | Reliability and offline | integration | TST-09 | Y |
| NFR-07 | Reliability and offline | integration | TST-06 | Y |
| NFR-08 | Security | security check | TST-10 | N |
| NFR-09 | Security | security check | TST-10 | N |
| NFR-10 | Security | security check | TST-10 | N |
| NFR-11 | Privacy and legal | checklist review | TST-07 | N |
| NFR-12 | Privacy and legal | CI check | TST-13 | Y |
| NFR-17 | Maintainability and testing | CI check | TST-13 | Y |
| NFR-18 | Maintainability and testing | repository review | TST-13 | N |
| NFR-19 | Maintainability and testing | document review | TST-16 | N |
| NFR-20 | Maintainability and testing | CI review | TST-13 | N |
| NFR-21 | Maintainability and testing | CI check | TST-13 | Y |
| NFR-22 | Maintainability and testing | document review | TST-16 | N |
| NFR-24 | Compatibility | device run | TST-14 | Y |
| NFR-26 | Cost and quotas | console review | TST-13 | N |
| NFR-29 | Quality of results | experiment | EXP-02; TST-12 | Y |

Summary: functional 56 of 56 automated; non-functional 10 of 19 automated; total 66 of 75 (88.0%).

### 7.4 Entry and exit criteria per gate

Gate dates come from `04-FEASIBILITY.md` §7 and are proposals [A:ASM-65].

| Gate | Date | Entry criteria | Exit criteria (pass) | Evidence |
|---|---|---|---|---|
| GT-01 | 2026-10-22 | The app builds and runs on D1 and D2; offline persistence and the Dio chain are implemented | TST-09 passes: `KPI-11` is 0, `KPI-12` and `KPI-13` are green; TST-06 passes | RES-11, RES-10 |
| GT-01b | 2026-10-22 | A release APK is built; App Check is set up | `KPI-31` is 0, `KPI-32` is "rejected", `KPI-10` is all pass | RES-12, RES-10 |
| GT-02 | 2026-10-29 | DEV-1 is labelled by two members; the free-tier limit is recorded | EXP-05 meets its pass values for at least one model; the model is chosen | RES-07 |
| GT-03 | 2026-10-29 (EXP-02 and EXP-03 by 2026-11-05) | A dish table with at least 30 entries and a reviewer; DEV-2 prepared | EXP-06 meets `KPI-28` and `KPI-29`; the reference file is signed (F2); `KPI-06` and `KPI-07` audited | RES-08, RES-03, RES-04 |
| GT-04 | 2026-10-30 | Consent text and pilot data policy drafted | `KPI-17` all present; the legal read is done (`OPEN-40`) | Checklist, RES-10 |
| GT-05 | 2026-11-12 | A build with all Must features | `KPI-01` measured, `KPI-14` and `KPI-36` at least 80%, `KPI-38` recorded | RES-13, RES-09 |
| Final | [T] | All gates passed or logged as deviations | `KPI-37` is 100%; hypothesis outcomes in RES-16 | RES-16 |

### 7.5 Defects, triage and regression

| Severity | Meaning | Rule |
|---|---|---|
| S1 critical | Data loss; crash in a core flow; a secret or personal data leaves the device; a recipe or alternative breaks a declared restriction; a medical claim in app text | Stop sharing builds; fix before the next build [A:ASM-64] |
| S2 major | A Must requirement fails with a workaround | Fix before the next gate |
| S3 minor | A Should requirement or a cosmetic issue with a workaround | Fix when capacity allows |
| S4 trivial | Wording, spacing | Backlog |

- **Triage.** The QA/security lead runs a weekly 20-minute triage; each defect gets a severity, a priority (P1 now, P2 this sprint, P3 later) and an owner.
- **Regression.** Every fixed S1 or S2 defect gets an automated test in the same pull request. CI runs the full suite on every pull request. A change to the prompt, model id, schema, reference tables or matching code after F3 requires re-running EXP-02 and EXP-03 in full; a model change also re-runs the EXP-05 regression set (`RSK-20`).
- **Defect log.** `RES-15`.

### 7.6 Performance protocol for `OBJ-01`

1. Use the frozen build on D1 (mid-range) with the timing log on (`FR-69`).
2. Prepare the LS set: 100 distinct scripted meal texts built from development material, none repeated, so that caching cannot help; none from TEST-30 [A:ASM-63].
3. Run 50 requests on the fixed Wi-Fi network and 50 on mobile data, alternating in blocks of 10.
4. Run 3 warm-up requests first; they are not counted. Include 10 cold starts (app killed before the request) and mark them.
5. Record for each request the time to the item list and the parse-step time; a failed or timed-out request is recorded as a failure and counts as slower than 8 s.
6. Compute `KPI-01` (requests within 8.0 s), the p50 and p90 (nearest-rank) for the whole set and for each network, and `KPI-02`.
7. Record the release APK size, memory at idle and during analysis, and the bundled data size (`KPI-38`).
8. Repeat the Wi-Fi block on D2 as a stress check; D2 does not change the `KPI-01` verdict.

### 7.7 Offline and sync scenarios (SPK-04)

Run each scenario 20 times on D1 and D2, following the coding rules of `04-FEASIBILITY.md` TD-03 and `06-DECISIONS.md` ADR-11.

| Scenario | Pass criterion |
|---|---|
| Add meal offline | No lost write; UI action at most 300 ms |
| Edit meal offline | No lost write; no duplicate |
| Delete meal offline | The meal is gone locally and in the cloud after reconnect |
| Restart the app offline | The last 7 days show within 1 s on a cold start |
| Reconnect with 50 queued writes | All 50 reach the cloud within 30 s |
| Account switch on one device | The previous user's meals are not visible (`FR-05`) |
| Low-RAM device | No crash; no lost write |
| Cache size setting (eviction with unsynced writes) | No unsynced write is evicted |
| Deliberate `await` of an offline write | Recorded as the control run to show the freeze the rule prevents |

### 7.8 Security and privacy checks

| Check | Method | Pass | Suite |
|---|---|---|---|
| No secret in the release APK | Decompile and search for key patterns and URLs | 0 secrets | TST-10 |
| AI call without an App Check token | Replay a recorded request with curl | Rejected | TST-10 |
| AI call from an emulator or rooted device | Run on an emulator | Rejected or limited as designed | TST-10 |
| Firestore rules | The 14 cases of §4.4 | All as expected | TST-08 |
| Logs | Inspect the Dio and app logs | No token, key or meal text | TST-06, TST-10 |
| Limited-use tokens in the Flutter SDK | Read the official docs and run a call | Works (closes `OPEN-39`) | TST-10 |
| Nothing identifying goes to the AI model | Intercepting proxy on a test device; capture 10 analysis requests | Each body holds only what `FR-10` allows | TST-10 |
| Cleartext traffic | Same proxy; manifest and network-configuration check | 0 cleartext requests | TST-10 |
| No data before consent | Run the app with the consent screen open and capture traffic | 0 requests carrying user data (`FR-07`) | TST-07 |
| Delete account | Delete a test account in the emulator | No document of that user remains (`FR-11`) | TST-07 |
| No analytics or crash data without consent | Capture traffic on a fresh install | None (`FR-09`) | TST-07 |

### 7.9 Demo acceptance script (`TST-15`)

Run on D1 with a test account and scripted meals. Each step passes or fails; `KPI-37` is passes divided by steps.

| Step | Action | Pass criterion | Requirements |
|---|---|---|---|
| 1 | Fresh install; open the app | Arabic privacy notice and consent screen show; no request before consent | FR-06, FR-07 |
| 2 | Accept; create an account; declare one restriction | Account created; restriction saved | FR-01, FR-12 |
| 3 | Type a dialect meal of three items | Items with grams, energy and macronutrients appear | FR-15, FR-21, FR-32 |
| 4 | Open one item | Source name and a confidence label show; an estimate is labelled with a range | FR-27, FR-28 |
| 5 | Change a quantity; save | Totals update; the meal is saved | FR-36, FR-17 |
| 6 | Add one item by searching the tables | Works with no network call | FR-16 |
| 7 | Open history and the chart | Grid of cards; 7-day bar chart; a day tap shows detail | FR-42, FR-43, FR-44 |
| 8 | Ask for recipes | Every ingredient passes the restriction | FR-39, FR-40 |
| 9 | Ask for a lower-energy alternative | Same group, at least 10% lower, labelled | FR-41 |
| 10 | Type a diagnosis request | Refusal with the information-only notice | FR-50, FR-51 |
| 11 | Go offline; add a meal; reconnect | The meal syncs; no freeze | FR-47, FR-46 |
| 12 | Sign in on a second device | The meals appear | FR-46 |
| 13 | Open About | Datasets with licence and retrieval date | FR-55, NFR-12 |
| 14 | Delete the account | Local and cloud data removed | FR-11 |

### 7.10 Usability-test script (EXP-04)

| Item | Content |
|---|---|
| Setup | A test build with the label switch (`FR-70`); a mid-range device; a fixed moderator script; two observers |
| Tasks | T1 log a scripted meal of three items. T2 find, or judge, the source of one item. T3 correct a quantity and save. T4 (once, at the end) find yesterday's meal in the history. Each block uses one of two equivalent task sets |
| Scoring | Task success: yes (no help), partly (one hint after 60 s), no. Time per task by stopwatch. Errors: wrong taps and backtracks counted by the observer |
| After each block | The two trust items, 1 to 5 |
| After the with-labels block | The 10 SUS items |
| End | Preference between the two versions, with a reason; one open question: "what would you change first?" |

**Observer notes.**

| Participant code | Persona type | Block order | Task | Success | Time (s) | Errors | Quote or observation | Theme (`TH-`) |
|---|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

## 8 Schedule and ownership

No `07-WORKPLAN.md` was available, so the proposed gate dates of `04-FEASIBILITY.md` are used. The project end date is unknown (`OPEN-26`); all dates are proposals [A:ASM-65].

| Activity | Date or window | Owner | Backup |
|---|---|---|---|
| F1 protocol freeze | 2026-10-19 | Product/legal lead | Mobile lead |
| TST-08, TST-09, TST-10 at `GT-01` and `GT-01b` | by 2026-10-22 | Mobile lead; QA/security lead | AI lead |
| EXP-05 at `GT-02` | by 2026-10-29 | AI lead | Data lead |
| EXP-06 at `GT-03`; F2 reference freeze | by 2026-10-29 | Data lead | AI lead |
| `GT-04` privacy checklist | by 2026-10-30 | Product/legal lead | QA/security lead |
| F3 pipeline freeze | 2026-11-04 | AI lead | Data lead |
| EXP-02 and EXP-03 test run | 2026-11-05 | AI lead; Data lead | Mobile lead |
| TST-11 and `GT-05` | by 2026-11-12 | Mobile lead | QA/security lead |
| EXP-01 and EXP-04 sessions | 2026-11-13 to 2026-11-17 | Mobile lead; Product/legal lead | Data lead |
| F4 data freeze, then analysis | 2026-11-18 | Product/legal lead | AI lead |
| Final report and presentation material | [T] (after `OPEN-26`) | Product/legal lead | All |

**Quota budget for live model calls** (excluding development; free-tier limit not yet read, `OPEN-38`, `OPEN-83`).

| Activity | Calls |
|---|---|
| EXP-05: 3 models × 30 descriptions × 3 runs | 270 |
| EXP-02 and EXP-03: 30 meals × 3 runs × 2 arms (replays make no calls) | 180 |
| TST-11: 100 requests plus 3 warm-ups | 103 |
| EXP-01: 10 participants × (10 meals + 2 practice) | 120 |
| EXP-04: about 6 participants × 6 analyses [A] | 36 |
| Total | 709 |

With a daily limit of 250 or 1,000 and a usable share of 0.8 (`ASM-25`), the runs are spread over several days so that no day exceeds 80% of the limit (`KPI-34`).

## 9 Reporting and claims policy

### 9.1 Outcome band to wording

| Band | Allowed wording | Forbidden wording |
|---|---|---|
| Supported | "In this sample of [n] and these [30] meals, [result]." | "Proves", "always", "better than other apps", "most accurate", "first" |
| Partly supported | "[Result] for [part]; not for [part]." | Any wording that hides the failing part |
| Not supported | "We expected [x]; we found [y]; we changed [z]." | Silence, or moving the threshold after the data |
| Inconclusive | "The data cannot answer this because [reason]." | Counting it as support |

Hypothesis-specific limits:

| Hypothesis | Never write |
|---|---|
| HYP-01 | "Faster than other apps" or "users will keep using it" |
| HYP-02 | "Accurate for Egyptian food" (only for these 30 meals) or any health or clinical claim |
| HYP-03 | "Grounding improves accuracy" unless D is at least 5; "No hallucination" |
| HYP-04 | "Users trust the app" for anything beyond this small sample; "validated" |

The wording rules of `05-REQUIREMENTS.md` §8.4 and `AI_CONTEXT.md` also apply.

### 9.2 Results part of the final presentation

Each result slide has five parts: **claim**, **method** (one line), **evidence** (the table or chart), **finding** (the band) and **limitation**. Negative and inconclusive results get the same space as positive ones, with what was changed because of them.

| Slide | Content |
|---|---|
| 1 | Research question and the four hypotheses |
| 2 | Method in one picture: sets, freezes, reference values |
| 3 | HYP-02: per-dish errors, the worst five |
| 4 | HYP-03: both arms on the same meals; source completeness |
| 5 | HYP-01: ratio per participant and the range |
| 6 | HYP-04: SUS per participant; trust with and without labels |
| 7 | Engineering evidence: tests, coverage, security checks, offline sync, latency |
| 8 | Limitations and what we would do next |

## 10 Results templates

All cells are [T]. Do not write example values.

### RES-01 EXP-01 per participant

| Participant code | Order | Free-text total (s) | Manual total (s) | Ratio r | Failures | Would-keep-using (free text) | Would-keep-using (manual) | Valid? |
|---|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-02 EXP-01 per meal

| Card | Median free-text time (s) | Median manual time (s) | Free-text failures | Notes |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

### RES-03 EXP-02 per-meal errors

| Meal | Phrasing | Difficulty | In dish table? | Reference kcal | App kcal run 1 / 2 / 3 | APE | Source layer | Reference flag |
|---|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-04 EXP-03 arms

| Arm | MAPE run 1 / 2 / 3 | Mean MAPE | Run range | Within ±20% | D | Source completeness | Band |
|---|---|---|---|---|---|---|---|
| A direct | [T] | [T] | [T] | [T] | [T] | not applicable | [T] |
| B grounded | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-05 EXP-04 per participant

| Participant code | Persona type | Block order | SUS | TR-1 with labels | TR-1 without | TR-2 with | TR-2 without | Preferred version |
|---|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-06 EXP-04 tasks

| Task | Success (yes / partly / no) per participant | Median time (s) | Errors | Notes |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

### RES-07 EXP-05 parse model table

| Model | Set | Recall | Precision | Quantity and unit | JSON valid | p50 s | p90 s | Tokens in / out | $ per 1,000 | Pass |
|---|---|---|---|---|---|---|---|---|---|---|
| [T] | EG / MSA / EN | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-08 EXP-06 coverage table

| Source | Dish hit@1 | Dish hit@3 | Ingredient hit@1 | Ingredient hit@3 | kcal within ±15% | Latency | Notes |
|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-09 KPI summary

| KPI | Value | Band | Date | Evidence |
|---|---|---|---|---|
| KPI-01 to KPI-38 | [T] | [T] | [T] | [T] |

### RES-10 Suite results

| Suite | Tests | Passed | Failed | Build | Date |
|---|---|---|---|---|---|
| TST-01 to TST-16 | [T] | [T] | [T] | [T] | [T] |

### RES-11 Offline scenarios

| Scenario | Device | Runs | Lost writes | Longest UI block (ms) | Sync time (s) | Pass |
|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-12 Security checks

| Check | Method | Result | Pass |
|---|---|---|---|
| [T] | [T] | [T] | [T] |

### RES-13 Latency

| Network | Device | Requests | Within 8.0 s | p50 (s) | p90 (s) | Parse p90 (s) | Failures |
|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-14 Device runs

| Device | Flow | Runs | Crashes | Notes |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

### RES-15 Defect log

| Defect | Suite | Severity | Priority | Owner | Status | Regression test |
|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### RES-16 Hypothesis outcomes

| Hypothesis | Value | Band | Date | Evidence |
|---|---|---|---|---|
| HYP-01 to HYP-04 | [T] | [T] | [T] | [T] |

### RES-17 Deviations

| Date | What changed | Reason | Effect on the result | Approved by |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

### RES-18 Limitations

| Limitation | Effect on claims | Mitigation |
|---|---|---|
| [T] | [T] | [T] |

## 11 Risks to the evaluation

| Risk | Effect | Mitigation | Links |
|---|---|---|---|
| Small and convenience samples | Results indicative only | Descriptive statistics; state limits; no p-values as proof [A:ASM-11] | HYP-01, HYP-04 |
| Reference-value error or circularity | HYP-02 and HYP-03 measure the wrong thing | Independence rule, reviewer, second recomputation, ±5% sensitivity (§4.3) | RSK-03, RSK-09 |
| Model drift or retirement | Results differ between runs or become stale | Pinned model id, recorded responses, freeze F3, regression set | RSK-05, RSK-20 |
| Free-tier quota limits | Runs cannot finish on time | Quota budget in §8; spread runs over days; paid-tier decision with a budget alert | RSK-05, RSK-25 |
| Learning and order effects | EXP-01 and EXP-04 are biased | Counterbalancing, practice items, shuffled order | HYP-01, HYP-04 |
| Team members testing their own app | Bias | Participants are outside the team; scripted tasks; two observers | HYP-04 |
| Development and test leakage | Over-optimistic accuracy | Separate sets and the freeze rule (§4.1) | HYP-02 |
| Devices not available | Device matrix incomplete | Borrow devices; record the gap as a limitation | RSK-19 |
| Time slip | Sessions run after the project end | Priority order: EXP-02, EXP-03, EXP-01, EXP-04 | RSK-06 |
| Unvalidated Arabic SUS | Scores not comparable with the benchmark | Report as indicative; `OPEN-80` | HYP-04 |
| No reviewer for reference values | EXP-02 inconclusive | Ask the university or a clinic early (`OPEN-78`) | RSK-09 |

## 12 Open items and assumptions added

Defined in `A-ASSUMPTIONS.md` and `C-OPEN-ITEMS.md`.

| ID | Summary |
|---|---|
| ASM-56 | `HYP-03` is applied as "grounded not worse than direct by more than 3 points"; a run range above 3 points makes it inconclusive; at least 5 points better is the stretch level |
| ASM-57 | `HYP-01` design: 10 participants (at least 8), 10 scripted meals plus 2 practice, counterbalanced order, time from the first tap to the review screen, and the participant ratio as the statistic |
| ASM-58 | `HYP-04` design: 6 participants (at least 5), two counterbalanced task blocks, SUS after the with-labels block, a team translation of SUS, and the definition of a trust gain |
| ASM-59 | The amber range is within 10% of the target on the wrong side unless a source file gives another rule |
| ASM-60 | Development and test sets are separate; DEV-3 has 20 meals; nothing changes after F3 |
| ASM-61 | Reference-value method, independence rule, ±5% sensitivity, the 50 kcal floor, item matching and the ±25% quantity tolerance |
| ASM-62 | Selection rules for the 30 reference meals |
| ASM-63 | Latency protocol: 100 distinct requests, 50 on Wi-Fi and 50 on mobile data, 3 warm-ups, failures count as slow |
| ASM-64 | Test-suite quantities and rules: 20 recipe tests, 14 rules cases, spot-check rule, automated share of at least 80%, defect severities |
| ASM-65 | Freeze and run dates depend on `OPEN-26` |
| ASM-66 | Participant rules for EXP-01 and EXP-04 |

| ID | Summary |
|---|---|
| OPEN-77 | Approve this plan, its thresholds and freeze dates; assign owners |
| OPEN-78 | Reviewer and independent source for the reference values |
| OPEN-79 | Recruit participants and settle consent and storage |
| OPEN-80 | Arabic SUS and trust-item wording |
| OPEN-81 | Source for interval methods such as the bootstrap |
| OPEN-82 | Test devices and the mobile-data operator |
| OPEN-83 | Quota budget of about 709 live calls against the free limit |
| OPEN-84 | Reconcile the `SPK-03` pass value with `HYP-03` |

The mechanism that keeps the test-only tools (timing log, label switch, direct-estimate arm) out of release builds is the existing `OPEN-74`; EXP-01, EXP-03 and EXP-04 depend on it.
