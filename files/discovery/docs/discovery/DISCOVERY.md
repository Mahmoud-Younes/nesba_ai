---
id: DISC-01
title: Nesba Discovery (problem, competitors, users)
status: draft              # draft | reviewed | approved
last_verified: 2026-10-11
owner: TBD
feeds: [feasibility, requirements, ux]
split_files:
  - docs/discovery/02-COMPETITORS.md      # Section 2
  - docs/discovery/03-USER-RESEARCH.md    # Section 3
  - docs/discovery/03a-SURVEY-AR.md       # Section 3, optional Arabic appendix
  - docs/discovery/A-ASSUMPTIONS.md       # Section A
  - docs/discovery/B-SOURCES.md           # Section B
  - docs/discovery/C-OPEN-ITEMS.md        # Section C
  - docs/discovery/04-FEASIBILITY.md      # Section 4
  - docs/discovery/05-REQUIREMENTS.md     # Section 5
  - docs/discovery/06-DECISIONS.md        # Section 6
  - docs/discovery/07-WORKPLAN.md         # Section 7
  - docs/discovery/NAMING.md              # Section N
  - docs/discovery/AI_CONTEXT.md          # one page for coding assistants
---

> **AI NOTES**
> - What this is: the shared discovery reference for Nesba (نسبة; course-brief title NutriVision), split into 13 files under `docs/discovery/`. This file is the hub and holds Section 1 (problem definition). Coding assistants: read `AI_CONTEXT.md` first.
> - Problem: adults in Egypt find food logging effortful and hard to trust, especially for home dishes in Arabic. Arabic and Egyptian AI loggers already exist, including on Google Play, so the open space is source transparency, tested accuracy and restriction-aware suggestions.
> - Research question: `RQ-01` in §1.3.
> - Name: the team chose **Nesba (نسبة)**. NutriVision is only the course-brief title. Record and open checks: `NAMING.md` §12 and `OPEN-52` to `OPEN-56`.
> - Feasibility: **Conditional Go**, proposed in `04-FEASIBILITY.md` and pending team approval; gates `GT-01` to `GT-05`. Technology decisions (30 ADRs, all proposed) and the dependency register: `06-DECISIONS.md`.
> - Closest competitors: `CMP-07` Kam Calorie and `CMP-08` Sahnain (Arabic/Egyptian AI loggers; Sahnain is on iOS and Google Play), `CMP-01` MyFitnessPal (global incumbent, owns `CMP-05` Cal AI). Positioning: `02-COMPETITORS.md` §2.6.
> - Requirements: `05-REQUIREMENTS.md` (proposed, not approved) holds user stories, functional and non-functional requirements, data and interface requirements, MoSCoW, the capacity check and traceability. `06-DECISIONS.md` section 11 maps each decision to them.
> - Work plan: `07-WORKPLAN.md` (proposed, not approved) holds the method, calendar, sprints, roles, individual deliverables and Git workflow of the team.
> - Must NOT claim: first Arabic AI food tracker; no solution exists; most accurate; only app with per-item sources; any medical advice. Full list: `02-COMPETITORS.md` §2.6.
> - Where to find: objectives §1.4 (`OBJ-`), scope and constraints §1.5 (`SCP-`, `CON-`), personas `03-USER-RESEARCH.md` §3.8 (`PER-`).
> - Evidence tags: [V:S-xxx] a cited source in B-SOURCES.md states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption in A-ASSUMPTIONS.md; [U] could not verify (see C-OPEN-ITEMS.md); [T] to be filled by the team with real data.
> - Treat [U] and [T] items as unknown, never as facts. Every numeric threshold in `HYP-`, `OBJ-` and `DR-` items is a team assumption.

## File map

| Section | Topic | File |
|---|---|---|
| 0 | Front matter, AI NOTES, conventions | this file |
| 1 | Problem definition | this file |
| 2 | Competitor analysis | [02-COMPETITORS.md](02-COMPETITORS.md) |
| 3 | User research (plan, instruments, personas) | [03-USER-RESEARCH.md](03-USER-RESEARCH.md) |
| 3 (appendix) | Survey in Arabic, identical IDs | [03a-SURVEY-AR.md](03a-SURVEY-AR.md) |
| 4 | Feasibility study: claim ledger, work packages, experiments, Go/No-Go, risks | [04-FEASIBILITY.md](04-FEASIBILITY.md) |
| 5 | Requirements analysis: user stories, functional and non-functional requirements, MoSCoW | [05-REQUIREMENTS.md](05-REQUIREMENTS.md) |
| 6 | Platform and technology decisions (ADRs, dependency register) | [06-DECISIONS.md](06-DECISIONS.md) |
| 7 | Methodology and work plan: sprints, task division, Git workflow | [07-WORKPLAN.md](07-WORKPLAN.md) |
| N | Project naming and decision | [NAMING.md](NAMING.md) |
| A | Assumption and hypothesis register | [A-ASSUMPTIONS.md](A-ASSUMPTIONS.md) |
| B | Source log | [B-SOURCES.md](B-SOURCES.md) |
| C | Open items | [C-OPEN-ITEMS.md](C-OPEN-ITEMS.md) |
| AI | One-page context for coding assistants | [AI_CONTEXT.md](AI_CONTEXT.md) |

## ID prefixes

`PRB-` problem causes · `RQ-` research question · `HYP-` hypotheses · `OBJ-` objectives · `SCP-IN-` / `SCP-OUT-` scope · `CON-` constraints · `ASM-` assumptions · `CMP-` competitors and references · `GAP-` gaps · `UQ-` user-research questions · `SQ-` survey questions · `IQ-` interview questions · `PER-` personas · `S-` sources · `OPEN-` open items.

Extra prefixes used here: `EVD-` background evidence rows · `DR-` survey decision rules · `TH-` coding themes.

Feasibility (`04-FEASIBILITY.md`): `CL-` claim ledger · `OPT-` options · `TD-` technical decisions · `SPK-` experiments · `GT-` gates · `RSK-` risks · `KC-` kill criteria. Requirements (`05-REQUIREMENTS.md`): `US-` user stories · `FR-` functional requirements · `NFR-` non-functional requirements · `DAT-` data requirements · `INT-` external interfaces. Work plan (`07-WORKPLAN.md`): `SPR-` sprints · `ROL-` roles · `GIT-` Git rules · `DEL-` individual deliverables (three digits). Naming (`NAMING.md`): `NAME-` candidates · `NC-` criteria · `NS-` naming sources · `NOPEN-` naming open items · `DEC-` decisions · `CNF-` conflicts · `MIT-` mitigations. Technology decisions (`06-DECISIONS.md`): `ADR-` architecture decision records · `DEP-` dependency register.

## Research context

- Research dates: first pass 2026-10-05; revision pass 2026-10-07; feasibility study 2026-10-08; naming decision and integration of the registers 2026-10-09; technology decisions 2026-10-09; requirements analysis 2026-10-09; final review 2026-10-10; work plan 2026-10-11. Web access was available.
- Prepared with an AI assistant using web search. The team must verify the cited sources before presenting.
- Method: official pages and store listings first; papers next; law-firm briefings for law.
- Limits: some pages blocked bots or render by script. Those figures are tagged [U].
- Tier A = official or academic. Tier B = independent review or news. Tier C = competitor or affiliate blog.

---

## 1. Problem definition

### 1.1 Background evidence

| ID | Claim | Number | Year | Population / definition | Source | Tag |
|---|---|---|---|---|---|---|
| EVD-01 | Obesity prevalence, women, Egypt | 59.0% | 2022 | Women aged 20+, age-standardised to the WHO Standard Population. The factsheet does not state the BMI cutoff [U] | S-001 | [V:S-001] |
| EVD-02 | Obesity prevalence, men, Egypt | 32.5% | 2022 | Men aged 20+, age-standardised to the WHO Standard Population. Same caveat on the cutoff | S-001 | [V:S-001] |
| EVD-03 | Older modelled obesity estimate, adults 18+: women 44.7%, men 25.9% | 44.7% / 25.9% | Series to 2016, 2019 projection | Age-standardised, modelled, BMI ≥ 30. Do not mix with EVD-01 | S-002 | [V:S-002] |
| EVD-04 | Older modelled diabetes estimate, adults 18+: women 23.4%, men 18.8% | 23.4% / 18.8% | Series to 2014 | Age-standardised, modelled. Outdated, shown for context only | S-002 | [V:S-002] |
| EVD-05 | Egypt Health Issues Survey 2015 measured height and weight of consenting adults aged 15–59 | 9,209 women and 7,462 men interviewed | 2015 | Women and men aged 15–59 (20.0% of women never married). Overweight = BMI 25–29.9 and obesity = BMI above 30 per S-003. BMI tables are Tables 5.6, 5.7.1 and 5.7.2 (pp. 70–72); figures not extracted. S-003's n = 15,602 and its note on ever-married women 15–49 could not be matched to the report and are not used | S-003, S-004 | method [V:S-004]; BMI cutoffs [V:S-003]; figures [U] |
| EVD-06 | Diabetes prevalence, adults 18+, Egypt (model-based estimate) | 27.8% (interval 20.6–35.4) | 2022 | Age-standardised, both sexes. Diabetes = fasting glucose of 7 mmol/L or more, HbA1c of 6.5% or more, or glucose-lowering medication. Read from a data aggregator that repeats a WHO-series estimate; method paper is S-052. The IDF Atlas (S-015) holds its own Egypt figure, not extracted | S-053, S-052, S-015 | [V:S-053] (tier B; official confirmation pending) |
| EVD-07 | Android share of mobile web traffic, Egypt | Sept 2026: Android 83.4%, iOS 16.58%. Oct 2025 (earlier snapshot of the same page): Android 83.66%, iOS 16.09% | 2025–2026 | Share of page views by OS, not device ownership. Jan–Aug 2026 not retrievable (chart is script-rendered). Seed range 88–91% for May–Aug 2026 was not reproduced. Months are not averaged | S-005 | [V:S-005]; seed range [U] |
| EVD-08 | Food journalers report barriers to reliable entry, and some abandon journaling | 141 current and lapsed journalers; 5,526 forum posts | 2015 | Qualitative study: survey plus forum posts for three mobile food journals. The university news page says "more than 5,500" posts | S-006, S-007 | [V:S-006,S-007] |
| EVD-09 | Food databases had inaccuracies, missing common foods and duplicate user listings | qualitative | 2015 | Same study. The paper reports that journalers find categories of food missing (S-006) | S-006, S-008 | [V:S-006,S-008] |
| EVD-10 | Self-monitoring was consistently associated with weight loss, but the level of evidence was weak | 22 studies; 15 on dietary self-monitoring per the PubMed abstract (the PMC full text says 14) | Review 2011 | Behavioural weight-loss studies. Abstract: published 1993–2009; full text: US-based studies reported 1989–2009. Samples were mostly white women | S-009, S-040 | [V:S-009,S-040] |
| EVD-11 | Adherence to calorie tracking is described as low | no measured rate | 2021 | Authors' framing in a feasibility trial. Numeric adherence rates not collected | S-010 | wording [V:S-010]; rates [U] |
| EVD-12 | Lower-burden methods did not build stronger habits than a standard database app | n = 100 | 2021 | Two remotely delivered weight-loss interventions. Likert items at 6 weeks, 1 = completely disagree to 7 = completely agree (for example, remembering to use the device). Means: wearable 5.0 (SD 1.81), photo app 4.0 (SD 2.24), standard database app 2.35 (SD 1.79), p < 0.001. The authors read the higher means as more difficulty remembering | S-011 | [V:S-011] |
| EVD-13 | Multimodal LLMs, including leading proprietary ones, were unreliable for comprehensive micronutrients | 5 model families, 4 benchmarks | 2026 | Preprint, not peer-reviewed. Authors report the gap persists without an image | S-012 | [V:S-012] |
| EVD-14 | LLM carbohydrate estimates from meal descriptions were comparable to those of professional nutritionists, but significantly faster | 11,857 descriptions, 12 LLMs, 3 nutritionists | 2025 | Carbohydrate estimation. Descriptions derive from dietary intake data of 11 countries, not specifically Egyptian dishes. An earlier arXiv version worded the result differently; the final conference wording is used | S-013 | [V:S-013] |
| EVD-15 | A direct multimodal LLM estimate matched or beat a full retrieval pipeline on overall accuracy. Grounding adds an itemised, auditable record | 2 open model families, 3 cuisines | 2026 | Preprint. Meal images, not text | S-014 | [V:S-014] |
| EVD-16 | Several apps state support for Egyptian or Arabic dishes | see `02-COMPETITORS.md` | 2026 | Vendor statements only. Real coverage and accuracy untested | S-021, S-023 | existence [V:S-021,S-023]; coverage [U] |
| EVD-17 | Egypt Personal Data Protection Law No. 151 of 2020 treats health data as sensitive | law text | 2020 | English translation hosted by a law firm | S-016 | [V:S-016] |
| EVD-18 | Executive Regulations issued under Ministerial Decision 816/2025 on 1 Nov 2025, public on 25 Dec 2025. One-year grace period. Enforcement expected from 1 Nov 2026, with some uncertainty | dates | 2025–2026 | Law-firm briefings. S-017 notes that the later public release leaves some uncertainty (the grace period could be read as running to the end of 2026). S-045 also anticipates 1 Nov 2026 | S-017, S-018, S-045 | [V:S-017,S-018,S-045] |
| EVD-19 | Cross-border transfers need regulator authorisation. Privacy notices must be in Arabic. Sensitive data needs written consent | rules | 2026 | Law-firm briefing. Verify against the regulations themselves | S-017 | [V:S-017]; details [U] |
| EVD-20 | In a 6-month pilot RCT, an app group recorded diet on more days than website and paper-diary groups, and self-monitoring declined over time in all groups | 128 randomised; mean recording days 92 (SD 67) app, 35 (SD 44) website, 29 (SD 39) diary; retention at 6 months 93%, 55%, 53% | 2013 | Overweight volunteers recruited through large local employers. Adherence = days of dietary recording | S-051 | [V:S-051] |

Notes:

- EVD-01 to EVD-04 use different years and methods. Quote them separately.
- EVD-13 to EVD-15 are preprints (2026). Say "preprint, not peer-reviewed" whenever you cite them.
- EVD-15 concerns images. Transfer to free-text entry is an assumption [A:ASM-05].

### 1.2 Problem statement

**Statement (≤ 120 words).**

Adults in Egypt who want to manage weight or follow general dietary guidance need to log what they eat. Database-search logging is effortful when a dish has many ingredients, and databases miss common foods [V:S-006]. AI logging cuts typing, but language models alone are unreliable for micronutrients [V:S-012], and users cannot always see where a number came from [U]. Arabic and Egyptian AI loggers already exist, including on Google Play [V:S-044]; what remains open is source transparency, tested accuracy on Egyptian meals and restriction-aware suggestions [A:ASM-14]. Users therefore quit logging or trust numbers they cannot check [A:ASM-04].

**Who has the problem.** Adults (18+) in Egypt, Arabic-speaking, mostly on Android, who eat home-cooked dishes and want to track intake [A:ASM-02].

**What they do today.**

| Alternative | Examples | Limit |
|---|---|---|
| Global database apps | CMP-01 to CMP-04 | Egyptian dish coverage and Arabic UI unverified [U] |
| Arabic/regional AI loggers | CMP-07 to CMP-13 | Sahnain has an Android app [V:S-044]; the Kam Calorie and Kilo sites show the App Store only [V:S-021,S-043]; others unknown [U] |
| Notes, memory, or nothing | — | No computed nutrition [A:ASM-02] |

**Consequences.**

- People stop logging when entry is hard [V:S-006].
- Self-monitoring benefits shrink when logging stops [V:S-009].
- Numbers with no visible source cannot be checked [A:ASM-13].
- Food data may leave the country without clear user consent [A:ASM-09].

**Root causes.**

| ID | Cause | Tag |
|---|---|---|
| PRB-01 | Database search is effortful for multi-ingredient dishes | [V:S-006] |
| PRB-02 | Databases miss or duplicate common foods. Egyptian coverage is unverified | general [V:S-008]; Egypt [U] |
| PRB-03 | Many AI loggers may not show a source per item. Not verified for most apps | [A:ASM-10] |
| PRB-04 | LLM nutrient knowledge is unreliable, especially for micronutrients | [V:S-012] |
| PRB-05 | Android reach of Arabic-first AI loggers is uneven: Sahnain is on Google Play; the Kam Calorie and Kilo sites show the App Store only | [V:S-044,S-021,S-043]; others [U] |
| PRB-06 | Recipe and alternative suggestions that respect declared restrictions are not documented in the Arabic loggers found | [A:ASM-14] |
| PRB-07 | Health data handling rules are strict, and cross-border transfer needs authorisation | [V:S-017] |

### 1.3 Research question and hypotheses

**RQ-01.** To what extent can a language model constrained by sourced reference nutrition data turn a free-text meal description (Arabic or English) into a nutrition estimate that is acceptably accurate on Egyptian home meals, faster than manual database entry, and traceable per item?

Sub-questions:

- RQ-01.1 How accurate are calories and macros on 30 reference Egyptian meals?
- RQ-01.2 How long does logging take with free text versus manual search?
- RQ-01.3 Does database grounding change accuracy compared with a direct LLM estimate?
- RQ-01.4 Does a visible source per item change understanding and trust?
- RQ-01.5 Do users intend to keep logging this way? Faster does not guarantee adherence [V:S-011].

**Hypotheses.** All thresholds are team assumptions [A:ASM-03].

| ID | Hypothesis | Metric | Threshold | Measurement | Tag |
|---|---|---|---|---|---|
| HYP-01 | Free-text entry is faster than manual database search | Median seconds to log 10 meals each way | Free text ≤ 60% of manual time | Same 10 meals, same participants, stopwatch. Add a 5-point "would keep using" item | [A:ASM-04] |
| HYP-02 | Calorie error is acceptable | Mean absolute percentage error (MAPE), calories | ≤ 20% on 30 reference meals | Compare app output with sourced reference values per meal | [A:ASM-03] |
| HYP-03 | Database grounding improves traceability without hurting accuracy | MAPE difference, direct LLM minus grounded; share of items with a source | Difference within ±3 points; 100% of items sourced | Same 30 meals through both pipelines | [A:ASM-05] |
| HYP-04 | Showing the source per item raises trust | SUS score; trust item (1–5), with and without labels | SUS ≥ 68; trust ≥ 4.0 with labels and higher than without | 5+ users in a usability test | [A:ASM-13] |

Pre-registered risk: S-014 reports that grounding may not improve overall accuracy for images. HYP-03 may therefore end as "traceability gain, accuracy unchanged". That still counts as support.

### 1.4 Objectives (SMART)

Phase labels are generic. Map them to real dates once the project calendar is known (`OPEN-26`).

| ID | Objective | Metric | Target | Measurement | Due phase | Links |
|---|---|---|---|---|---|---|
| OBJ-01 | Working Android app analyses a meal description fast | p90 latency, text request to result | ≤ 8 s for 90% of 100 test requests | Logged timings over Wi-Fi and mobile data | Build | HYP-01 |
| OBJ-02 | Calorie accuracy on Egyptian meals | MAPE, calories | ≤ 20% on 30 reference meals | Scripted evaluation against sourced values | Test | HYP-02, GAP-03 |
| OBJ-03 | Sourced Egyptian reference table | Rows with source ID | 100–200 dishes, ≥ 95% rows sourced | Data audit script plus manual spot check of 20 rows | Build | HYP-03, GAP-02 |
| OBJ-04 | Restriction-safe recipes and alternatives | Violations in automated tests | 0 violations in 20 tests | Unit tests on declared restrictions | Build | GAP-04, PRB-06 |
| OBJ-05 | Secure cross-device sync | Passing Firestore rules tests | All cross-user read/write tests pass (≥ 10 cases) | Emulator rules test suite in CI | Build | GAP-05 |
| OBJ-06 | Test coverage of calculation layer | Line coverage | ≥ 80% | Coverage report in CI | Test | — |
| OBJ-07 | Documentation and workflow | Merges via reviewed pull request | 100% of merges; README and technical docs complete | Repository settings and review | Release | — |
| OBJ-08 | Privacy basics before any real-user test | Items present | Arabic privacy notice, consent screen, delete-account path | Checklist review | Test | PRB-07, GAP-07 |

All targets are [A:ASM-03].

### 1.5 Scope and constraints

**In scope.**

| ID | Item |
|---|---|
| SCP-IN-01 | Android app (Flutter) |
| SCP-IN-02 | Free-text meal entry in Arabic and English |
| SCP-IN-03 | Nutrition per item, with a visible source label |
| SCP-IN-04 | Recipe suggestions and healthier alternatives that respect user-declared general restrictions |
| SCP-IN-05 | Meal history (GridView) and nutrition charts |
| SCP-IN-06 | Sign-in and Firestore cross-device sync |
| SCP-IN-07 | Unit and widget tests; README and technical documentation |

**Out of scope.**

| ID | Item |
|---|---|
| SCP-OUT-01 | iOS |
| SCP-OUT-02 | Payments and subscriptions |
| SCP-OUT-03 | Social features |
| SCP-OUT-04 | Medical diagnosis, treatment, or medication-dose advice |
| SCP-OUT-05 | Food-photo recognition |
| SCP-OUT-06 | Guarantees of allergen safety [A:ASM-19] |

**Maybe later.** Voice entry; barcode scanning; photo recognition; iOS; a local-only mode (priority depends on `DR-02`); wearable integration.

**Boundary on advice.** Nesba is an information tool, not a medical device. It gives no diagnosis, no treatment advice, and no medication-dose advice.

**Constraints.**

| ID | Constraint | Tag |
|---|---|---|
| CON-01 | Budget is zero. Free tiers only | [A:ASM-07,ASM-08] |
| CON-02 | Project end date unknown | [U] `OPEN-26` |
| CON-03 | Team of 5 students | [A:ASM-18] |
| CON-04 | Android first. Minimum Android version not set | [U] `OPEN-27` |
| CON-05 | No verified Egyptian dish dataset in hand. Table must be built from sourced values | [A:ASM-06] |
| CON-06 | Health data is sensitive. Cross-border transfer needs authorisation. Notices in Arabic | [V:S-016,S-017] |
| CON-07 | Course brief: Flutter, Dio with interceptors, Firestore sync, tests, Keystore, runtime permissions | [A:ASM-18] |

### 1.6 Success and failure

| Item | Success | Partial | Failure | Action on failure |
|---|---|---|---|---|
| HYP-01 | Free text ≤ 60% of manual time | 60–90% | > 90% | Add search and pick-list shortcuts |
| HYP-02 | MAPE ≤ 20% | 20–30% | > 30% | Narrow dish scope; improve reference table |
| HYP-03 | Within ±3 points and 100% sourced | Within ±3 points, < 100% sourced | Grounded worse by more than 3 points | Revisit retrieval design |
| HYP-04 | SUS ≥ 68 and trust gain | One of two | Neither | Redesign source display |
| Survey | No decision rule fires, or rules fire and are acted on | — | — | Follow `DR-` actions |

Expected outcome [A:ASM-03]: grounded estimates within 20% on common dishes, larger error on mixed or restaurant-style dishes. Report errors per dish, not only the mean.

### 1.7 Rubric mapping

| Rubric criterion | Points | Where answered |
|---|---|---|
| Problem definition | 10 | §1.1–§1.2, `PRB-`, `GAP-` in `02-COMPETITORS.md` |
| Methods | 20 | §1.3 measurement column, `03-USER-RESEARCH.md` §3.2–§3.6, hands-on test in `02-COMPETITORS.md` §2.7 |
| Results / outcomes | 20 | `HYP-`, `OBJ-`, §1.6, `DR-` decision rules |
| Content and organisation | 20 | File map, stable IDs, AI NOTES, `A-`, `B-`, `C-` registers |

### 1.8 Traceability

Problems to questions, gaps, objectives and hypotheses.

| Problem | User-research questions | Gaps | Objectives | Hypotheses |
|---|---|---|---|---|
| PRB-01 | UQ-01, UQ-03 | GAP-06 | OBJ-01 | HYP-01 |
| PRB-02 | UQ-02 | GAP-08 | OBJ-03 | HYP-03 |
| PRB-03 | UQ-04 | GAP-02 | OBJ-03 | HYP-03, HYP-04 |
| PRB-04 | UQ-04 | GAP-03 | OBJ-02 | HYP-02, HYP-03 |
| PRB-05 | UQ-07 | GAP-01 | OBJ-01 | none (platform choice, DR-03) |
| PRB-06 | UQ-06, UQ-08 | GAP-04 | OBJ-04 | none |
| PRB-07 | UQ-05 | GAP-07 | OBJ-05, OBJ-08 | none |

Objectives to hypotheses, gaps and in-scope items.

| Objective | Hypotheses | Gaps | In scope |
|---|---|---|---|
| OBJ-01 | HYP-01 | GAP-01 | SCP-IN-01, SCP-IN-02 |
| OBJ-02 | HYP-02 | GAP-03 | SCP-IN-02, SCP-IN-03 |
| OBJ-03 | HYP-03, HYP-04 | GAP-02, GAP-08 | SCP-IN-03 |
| OBJ-04 | none | GAP-04 | SCP-IN-04 |
| OBJ-05 | none | GAP-05 | SCP-IN-06 |
| OBJ-06 | HYP-02 (supports calculation checks) | none | SCP-IN-07 |
| OBJ-07 | none | none | SCP-IN-07 |
| OBJ-08 | none | GAP-07 | SCP-IN-06 |

## Revision log

| Date | Task IDs | Files | Summary |
|---|---|---|---|
| 2026-10-05 | first pass | all | Initial discovery set written |
| 2026-10-07 | T-01 to T-16 | all | Revision pass. See `C-OPEN-ITEMS.md` section C.5 for the re-verification log and C.6 for blocked-source attempts. Key corrections: Sahnain is on Google Play (GAP-01 closed); EHIS sample description fixed; sources S‑022 and S‑039 withdrawn |
| 2026-10-07 | T-06, T-08 (follow-up) | `02-COMPETITORS.md`, `B-SOURCES.md`, `C-OPEN-ITEMS.md` | S-020 opened directly (published 2 March 2026). Lose It! Android listing found through an aggregator (S-055), so OPEN-34 no longer lists CMP-04 |
| 2026-10-08 | step 4 | `04-FEASIBILITY.md` | Feasibility study added: claim ledger for two earlier individual documents, six work packages, six experiments (designed, not run), Go/No-Go with gates, risk register. Provisional IDs 9xx |
| 2026-10-09 | integration | all | Project name set to Nesba (decision `DEC-01`, `NAMING.md` §12). 9xx IDs renumbered: `S-056` to `S-092`, `ASM-23` to `ASM-37`, `OPEN-36` to `OPEN-51`. Added `ASM-38`, `OPEN-52` to `OPEN-57`, `AI_CONTEXT.md` and the extended check script. Titles and product references updated; NutriVision kept only as the course-brief title and in the naming history |
| 2026-10-09 | step 6 | `06-DECISIONS.md`, `A-ASSUMPTIONS.md`, `B-SOURCES.md`, `C-OPEN-ITEMS.md`, `AI_CONTEXT.md`, `DISCOVERY.md`, check script | Platform and technology decisions added: 30 ADRs (all Proposed) and 39 dependency rows. Appended `ASM-39` to `ASM-46`, `OPEN-58` to `OPEN-67`, `S-093` to `S-115`. Check script now requires `ADR-` and `DEP-` definitions. `05-REQUIREMENTS.md` was not available (`OPEN-67`) |
| 2026-10-09 | step 5 | `05-REQUIREMENTS.md` | Requirements added: 37 user stories, 70 functional, 29 non-functional, 13 data and 8 interface requirements. No `OBJ-` or `HYP-` changed; proposed target changes are in section 12 of the file. Its ASM and OPEN rows were first numbered `ASM-39` to `ASM-47` and `OPEN-58` to `OPEN-65`, which collided with step 6 |
| 2026-10-10 | final review | all files | Steps 5 and 6 merged. Step 5 rows renumbered: `ASM-47` to `ASM-55`, `OPEN-68` to `OPEN-76`; two step 5 items merged into `OPEN-59` and `OPEN-60`. `S-116` and `S-117` added. Bloc replaces Riverpod (`ADR-06`, `DEP-04`; notes in `04-FEASIBILITY.md` TD-04 and KC-04). `05-REQUIREMENTS.md` aligned with the ADRs (secure storage, analytics, retry, error classes, model identifier, password reset). `06-DECISIONS.md` section 11 added; `OPEN-67` closed. Dependency register now has 42 rows. Check script requires `FR-`, `NFR-`, `US-`, `INT-` and `DAT-` definitions |
| 2026-10-11 | review | `04-FEASIBILITY.md`, `C-OPEN-ITEMS.md`, tools | Review of steps 5 and 6: structural check passed with the new prefixes (`FR-`, `NFR-`, `US-`, `INT-`, `DAT-`, `ADR-`, `DEP-`). Scenario S arithmetic in TD-06 corrected (81.5, not about 79) and `OPEN-73` closed. Claims on Flutter 3.47, Dart 3.13 and the `material_ui` split were re-checked against public pages. Check script extended |
| 2026-10-11 | step 7 | `07-WORKPLAN.md`, `A-ASSUMPTIONS.md`, `B-SOURCES.md`, `C-OPEN-ITEMS.md`, `AI_CONTEXT.md`, `tools/check_discovery.py` | Work plan added: light Scrum-inspired method with one-week sprints, calendar from the stated end date 2026-12-01 (7.29 weeks from 2026-10-12), 22 plan sprints in two scenarios, 5 roles, 24 Git rules, 110 individual deliverables. Rows `ASM-56` to `ASM-65`, `OPEN-77` to `OPEN-90` and `S-118` to `S-123` appended; `OPEN-26` and `OPEN-28` answered in part. Team data from the group leader added (names, trainer, skills, Google Play goal). No `OBJ-` or `HYP-` changed |
