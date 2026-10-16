---
id: DISC-01-A
title: Nesba Discovery, Section A (assumption and hypothesis register)
parent: DISC-01
status: draft
last_verified: 2026-10-11
owner: TBD
---

> **AI NOTES**
> - What this is: Section A. Assumptions, hypotheses and survey decision rules, each with a way to verify it. Hub: [DISCOVERY.md](DISCOVERY.md).
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U] and [T] as unknown, never as facts. Every numeric threshold here is a team assumption.
> - IDs defined here: ASM-01 to ASM-65 (HYP-01 to HYP-04 and DR-01 to DR-06 are repeated from the other files).
> - Status values: open, testing, confirmed, rejected.

# A. Assumption and hypothesis register

Part of [DISCOVERY.md](DISCOVERY.md). Every [A:ASM-xx] tag in the discovery files points to a row here. Owner is `TBD` until the team assigns roles. Status values: open, testing, confirmed, rejected.

## A.1 Assumptions

| ID | Statement | Why it matters | How to verify | Owner | Status |
|---|---|---|---|---|---|
| ASM-01 | Android is the right first platform for the target users | Drives the whole build | Cross-tab `SQ-03`; compare with `EVD-07`; re-check Statcounter monthly. Latest seen: Sept 2026 Android 83.4% (S-005); Jan–Aug 2026 not retrievable | TBD | open |
| ASM-02 | Target users are Arabic-speaking adults (18+) in Egypt who log or want to log home-cooked dishes | Defines persona, ethics and scope | Screener `SQ-01`, `SQ-02`; interviews `IQ-01` to `IQ-04` | TBD | open |
| ASM-03 | Numeric targets in `HYP-` and `OBJ-` (20% MAPE, 8 s p90, 60% time ratio, SUS 68) are team judgement, not taken from the literature | Thresholds decide success or failure | Supervisor review; pilot run; look up accepted error ranges in nutrition-estimation papers | TBD | open |
| ASM-04 | Free-text logging lowers effort versus database search for Egyptian dishes, and lower effort leads to continued use | Core value claim. Faster does not guarantee adherence [V:S-011] | `HYP-01` timing plus the "would keep using" item; follow-up use after 2 weeks if time allows | TBD | open |
| ASM-05 | Findings from image-based multimodal studies (S-012, S-014) transfer at least partly to text input | Evidence for the grounding design comes from images | Run `HYP-03` on text; read the text-only results in S-012 | TBD | open |
| ASM-06 | A usable, citable source for 100–200 Egyptian dish values exists at zero cost | `OBJ-03` depends on it | Find Egyptian food composition tables or papers; check licence and reuse terms (`OPEN-21`) | TBD | open |
| ASM-07 | An LLM API with free or very low cost access and acceptable data terms exists for the project period | Zero-budget constraint | Read provider terms; test quota and latency (`OPEN-22`) | TBD | open |
| ASM-08 | The Firebase free plan covers development and evaluation load | Zero-budget constraint | Check current Firebase plan limits (`OPEN-23`) | TBD | open |
| ASM-09 | Egypt's data protection rules (Arabic notice, explicit consent, transfer authorisation) apply, or should be followed as good practice. Enforcement may start 1 Nov 2026 | Legal and ethical risk | Ask supervisor or legal adviser; read the regulations and PDPC guidance (`OPEN-20`) | TBD | open |
| ASM-10 | Vendor claims (Egyptian dishes, accuracy, speed) are untested, and competitor feature cells marked `?` are unknown | Competitor matrix accuracy | Run the hands-on test (`02-COMPETITORS.md` §2.7) | TBD | open |
| ASM-11 | Survey and interview samples are convenience samples. Results are indicative only | Avoids over-claiming | Record sampling channels; state limits in the report | TBD | open |
| ASM-12 | The three persona seeds reflect real segments | Personas guide UX | Update procedure in `03-USER-RESEARCH.md` §3.8 | TBD | open |
| ASM-13 | A visible source per item raises understanding and trust | Main differentiator | `HYP-04`; `SQ-15`; `IQ-06` | TBD | open |
| ASM-14 | No competitor offers all three differentiators together (per-item sources, restriction-aware suggestions, published Egyptian accuracy test) | Positioning validity | Hands-on test; re-check listings before final report | TBD | open |
| ASM-15 | Survey decision-rule thresholds (40%, 4 of 5, majority iPhone, medians of 3) are team judgement | Rules trigger design changes | Supervisor review before launch | TBD | open |
| ASM-16 | The Arabic-first AI loggers found are not available on Android | `GAP-01` depends on it | Checked in the revision pass: Sahnain (S-044) and Miran (S-050) are on Android, so the assumption is false for them. Search Google Play for the remaining products (`OPEN-34`) | TBD | rejected (partly; unknown for others) |
| ASM-17 | StatCounter web-traffic share is a fair proxy for Android share among target users | Platform choice | Compare with `SQ-03`; look for device-ownership data. Statcounter shows 83.66% (Oct 2025) and 83.4% (Sept 2026) for Egypt | TBD | open |
| ASM-18 | Team size (5) and the course-brief constraints (Flutter, Dio with interceptors, Firestore, tests, Keystore, runtime permissions) are fixed | Scope and constraints | Confirm with the supervisor | TBD | open |
| ASM-19 | Users declare general restrictions only (not diagnoses). Allergen-safety guarantees stay out of scope | Safety and liability | Scope review; disclaimer wording check | TBD | open |
| ASM-20 | A third-party form tool may store anonymous answers outside Egypt. Whether the law covers anonymous answers is unsettled | Survey ethics | Legal advice; tool settings (`OPEN-24`) | TBD | open |
| ASM-21 | Raw survey responses are deleted 90 days after final grading | Retention rule | Team decision recorded in the consent text | TBD | open |
| ASM-22 | The survey takes about 7 minutes | Respondent burden, consent wording | Time 3–5 pilot respondents | TBD | open |
| ASM-23 | One analysis = one LLM call; 960 input and 350 output tokens | Used in TD-02 cost model | Measure tokens per analysis in SPK-01 and SPK-06 | TBD | open |
| ASM-24 | Thinking mode adds 500 output tokens when enabled | Used in TD-02 cost model | Measure with thinking mode on and off in SPK-01 | TBD | open |
| ASM-25 | Free-tier daily limit L is 250 or 1,000 requests/project; usable share 0.8 | Used in TD-02 free-tier days | Read the real limit for the project in AI Studio (OPEN-38) | TBD | open |
| ASM-26 | Pilot: 50 users x 3 analyses/day x 14 days | Used in TD-02 | Team confirms the pilot size once the schedule is known (OPEN-26) | TBD | open |
| ASM-27 | Dev: 5 developers x 40 calls/day x 20 days; spikes use 450 calls | Used in TD-02 | Compare with real call logs from development | TBD | open |
| ASM-28 | Each student gives 2 productive days per week | Used in TD-06 | Team confirms weekly availability | TBD | open |
| ASM-29 | Effort estimates in the TD-06 table; 0.25 person-days per dish entry | Used in TD-06 | Time the first 10 dish entries and update | TBD | open |
| ASM-30 | Matrix weights and 0-5 scores are team-adjustable judgments | Used in TD-01 to TD-04 | Team and supervisor review the weights before the decisions are adopted | TBD | open |
| ASM-31 | Spike pass thresholds are proposals until the team confirms them | Used in Section 6 | Team confirms thresholds before running the spikes | TBD | open |
| ASM-32 | Pilot limited to consenting adults; no minors; synthetic data or the paid AI tier for real text | Used in TD-05, RSK-01, RSK-02 | Legal read (OPEN-40) and the consent text (GT-04) | TBD | open |
| ASM-33 | Firebase project region will be outside Egypt (exact region not yet chosen) | Used in TD-05 | Check the region when the Firebase project is created | TBD | open |
| ASM-34 | Egyptian dish table is built from team-collected recipes and USDA ingredient values and reviewed by a dietitian | Used in TD-01 | Find a reviewer (GT-03); source for values (OPEN-21) | TBD | open |
| ASM-35 | Android-only; one mid-range and one low-RAM test device are available | Used in SPK-04, SPK-06 | Team lists the devices it owns | TBD | open |
| ASM-36 | Fetching OFF live by barcode and not merging it into the bundled DB avoids ODbL share-alike (needs a legal read) | Used in TD-05, RSK-22 | Legal read of the Open Food Facts terms (OPEN-40) | TBD | open |
| ASM-37 | Pilot Firestore load is about 2,000 reads/day | Used in TD-03, RSK-21 | Measure in the pilot and compare with the free quota | TBD | open |
| ASM-38 | The chosen name Nesba is acceptable despite an exact-name Finance app on the stores (`NS-043` in `NAMING.md`) and an incomplete availability check | Name decision `DEC-01` | Store search for the name (OPEN-54); trademark and domain check before any public release (OPEN-55) | TBD | open |
| ASM-39 | Team machines and CI can run Flutter 3.47.x (Dart 3.13), Java 17 and Node 24.12 or newer | Needed by ADR-03 and ADR-12 | Each member runs the setup; the CI job passes | TBD | open |
| ASM-40 | Bundled reference data stays under about 10 MB and parses in under about 500 ms on the low-RAM device | Used in ADR-13 | SPK-06 measures size and cold parse | TBD | open |
| ASM-41 | The team's lowest-end test device runs Android 7.0 (API 24) or newer | Used in ADR-02 | Team lists device models and Android versions (ASM-35, OPEN-27) | TBD | open |
| ASM-42 | No Google Play release happens during the course; testers get APK or bundle files | Used in ADR-29 | Confirm with the trainer (OPEN-26) | TBD | open |
| ASM-43 | About ten model types exist, so hand-written models without code generation are enough | Used in ADR-05, ADR-08 | Count model types at GT-03 | TBD | open |
| ASM-44 | The team's GitHub plan supports protected branches and required reviews for the repository | Used in ADR-28 | Check the repository settings | TBD | open |
| ASM-45 | Firebase Authentication with email and password stays within the no-cost limits for the pilot | Used in ADR-15 | Read the Authentication quotas (OPEN-59) | TBD | open |
| ASM-46 | A reason screen plus the system permission dialog satisfies the brief's runtime-permission item | Used in ADR-20 | Ask the trainer (OPEN-60) | TBD | open |
| ASM-47 | Effort sizes for requirements: S 0.5, M 1 and L 2 person-days, including the requirement's own tests, for a student with Flutter experience | Capacity check in `05-REQUIREMENTS.md` section 10.4. Against the TD-06 packages the ratios run from 0.33 to 1.88 and the totals are 57.5 against 58 | Time the first 5 requirements of each size and update the sizes | TBD | open |
| ASM-48 | Numeric thresholds in requirements that are not copied from an `OBJ-` or `SPK-` value (500 characters, 12 taps, 3 taps, 16 s timeout, 30 s sync, 30 analyses per day, pages of 20 meals, 2 retries, 7-day chart, 30-day barcode cache, 90% alias match, 50% read quota) and the test sample sizes in acceptance criteria (5 to 100 runs or cases) are team proposals | Acceptance criteria in `05-REQUIREMENTS.md` sections 4 and 5 | Team and supervisor review with `ASM-31` before the build starts | TBD | open |
| ASM-49 | The initial restriction list is the `SQ-18` options vegetarian, lactose-free, gluten-free, low sugar and low salt. "Fasting periods" is kept as a preference and does not filter foods | Restriction filter and tag data (FR-12, DAT-09) | Read the survey results for `UQ-08`; ask the dietitian reviewer (`OPEN-69`) | TBD | open |
| ASM-50 | Interactive elements are at least 48 by 48 dp and screens stay readable at 200% font scale. These are common design values and were not checked against a source in this study [U] | Large-text need of `PER-03`; NFR-15 and NFR-16 | Check the Android accessibility guidance; run golden tests | TBD | open |
| ASM-51 | The original typed meal text is not synced to the cloud; only the parsed items are stored | Data minimisation and privacy by design (DAT-04) | Confirm at `GT-04`; check that no edit flow needs the original text | TBD | open |
| ASM-52 | A lower-energy alternative is an item in the same food group with at least 10% lower energy per serving, and the app never calls it healthy | FR-41 and `OBJ-04` need a measurable meaning of "healthier" | Review with the dietitian (`OPEN-69`); run the 10-fixture test | TBD | open |
| ASM-53 | Barcode scanning with the camera is the feature that carries the brief's runtime-permission requirement (see also `ASM-46`) | The brief needs a runtime permission, while `DISCOVERY.md` section 1.5 lists barcode scanning under "Maybe later" | Ask the trainer; record the answer (`OPEN-60`) | TBD | open |
| ASM-54 | Recipes from any origin, bundled or AI-generated, must pass the same ingredient tag check, and an ingredient without a tag counts as a violation | `OBJ-04` can only be tested if every recipe goes through one check (FR-40) | Unit tests with mocked model output; decide the origin in `OPEN-70` | TBD | open |
| ASM-55 | The brief's "AI-generated nutrition advice" is met by sourced alternatives and recipes, not by free-text tips | Medical-style advice is out of scope (`SCP-OUT-04`) and numbers come from code | Ask the trainer (`OPEN-71`) | TBD | open |
| ASM-56 | Process thresholds of the work plan: first review within 2 working days, pull request of about 400 changed lines or less, work in progress of 2 per member and 3 in review, indicator thresholds in section 8.3, 80% velocity trigger | Used in GIT-04, GIT-13 and section 8 | Review after the first two sprints and change what the team cannot keep | TBD | open |
| ASM-57 | Sprint 0 starts on Monday 2026-10-12, the first Monday after today, and a sprint is 7 days | Calendar in section 2 | The team gives the real start date (OPEN-77) | TBD | open |
| ASM-58 | The final presentation is on 2026-12-01, the project end stated by the team, unless the trainer sets an earlier date | Calendar and freeze dates | Ask the trainer for the presentation date (OPEN-77) | TBD | open |
| ASM-59 | The S plan assumes 2.5 productive days per member per week in SPR-00 to SPR-06 and 0.7 in SPR-07; the four meetings (about 2.5 hours a week) are outside those days. ASM-28 says 2.0 | Whether scenario S fits the stated end date (section 2.3) | Each member checks the real hours for the next 7 weeks (OPEN-78) | TBD | open |
| ASM-60 | Split of existing totals: the spikes of TD-06 (8 in S, 12 in L) across SPK-01 to SPK-06 as 2.0/1.5/1.5/1.0/1.0/1.0 in S and 3.0/2.0/2.0/2.0/1.5/1.5 in L, with SPK-03 shared equally by the AI lead and the Data lead; report and demo (8 in S, 10 in L) shared equally by the five members, with 0.6 in the final sprint; dish entries shared by role in 0.25 steps with at least 10% each | Per-role effort check in section 4.2 | Team confirms or adjusts the split at planning | TBD | open |
| ASM-61 | The Google Play track costs 3.0 person-days in total: build and signing 0.5, listing and privacy policy 1.0, tester recruitment 1.0, release hardening 0.5. It is not in TD-06 or in 05 | Section 2.7 and the S total of 86.5 | Time the track after SPR-04 and update | TBD | open |
| ASM-62 | Between S and L, spikes, report and demo and the dish count grow linearly with the weeks available, on the basis of 2.0 productive days | Section 2.6 | Compare with the real end date if it changes | TBD | open |
| ASM-63 | Roles map to members in the order of the team list: Member A Mahmoud (Mobile lead), B Ahmed Gomaa (AI lead), C Bassam Emad (Data lead), D Kamel Ali (QA/security lead), E Osama Yaser (Product/legal lead) | Section 4.1 | The team confirms or swaps by interest and skill | TBD | open |
| ASM-64 | Skill levels as the group leader stated: one mid level and four junior, with Cubit, Dio, sqflite and Firebase learned in the course; nobody has used Bloc events or Firebase AI Logic yet [U] | Section 4.1; effort sizes assume Flutter experience (ASM-47) | Fill the skills matrix (section 4.5); velocity check after SPR-01 | TBD | open |
| ASM-65 | The trainer assesses each member once a week on a weekday not yet known; the weekly report is due the day before | Section 9.1 | Ask the trainer for the weekday and the assessment file (OPEN-77, OPEN-81) | TBD | open |

## A.2 Hypotheses

| ID | Statement | Why it matters | How to verify | Owner | Status |
|---|---|---|---|---|---|
| HYP-01 | Free-text entry is at most 60% of manual search time for 10 meals | Tests the effort claim | Timed within-subject task, same 10 meals | TBD | open |
| HYP-02 | Calorie MAPE is at most 20% on 30 reference meals | Tests accuracy | Scripted evaluation against sourced reference values (`OPEN-21`) | TBD | open |
| HYP-03 | Grounding keeps MAPE within ±3 points of a direct LLM estimate, with 100% of items sourced | Tests whether grounding costs accuracy | Same 30 meals through both pipelines | TBD | open |
| HYP-04 | Source labels raise trust, with SUS at least 68 | Tests the main differentiator | Usability test, 5+ users | TBD | open |

## A.3 Decision rules (survey)

| ID | Rule | Verification |
|---|---|---|
| DR-01 | Under 40% name time or effort as a main reason → revisit framing | `SQ-08`, `ASM-15` |
| DR-02 | Mean concern about foreign servers above 4 of 5 → local-only mode priority | `SQ-16`, `ASM-15` |
| DR-03 | Majority iPhone → revisit platform | `SQ-03`, `ASM-15`, `ASM-17` |
| DR-04 | Median willingness to type below 3 → add pick-lists and voice sooner | `SQ-12`, `ASM-15` |
| DR-05 | Median source-label trust below 3 → lower label prominence | `SQ-15`, `ASM-15` |
| DR-06 | Under 40% find Egyptian dishes hard → reduce dish-table breadth | `SQ-10`, `ASM-15` |
