---
id: DISC-01-C
title: Nesba Discovery, Section C (open items)
parent: DISC-01
status: draft
last_verified: 2026-10-11
owner: TBD
---

> **AI NOTES**
> - What this is: Section C. Unverified items, team questions, the re-verification log and the blocked-source log. Hub: [DISCOVERY.md](DISCOVERY.md).
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U] and [T] as unknown, never as facts.
> - IDs defined here: OPEN-01 to OPEN-90 (RV-01 and up are log rows, not open items).
> - Closed items stay in the table with status `done`.

# C. Open items

Part of [DISCOVERY.md](DISCOVERY.md).

**Web access.** Available on 2026-10-05 and 2026-10-07. Limits met: the MyFitnessPal blog blocked automated access, the Statcounter chart and the IDF country page render by script, the Egypt Health Issues Survey PDF could not be read as far as its BMI tables, and most Google Play pages were not reached.

Status values: open, done, blocked. Roles are used because owners are not assigned yet. Closed items are not deleted.

## C.1 Open items and team questions

| ID | Type | Item | Why | How to verify | Who | Status | Result |
|---|---|---|---|---|---|---|---|
| OPEN-01 | Evidence | MyFitnessPal blog pricing page from the brief could not be opened | Site blocked the request | Open it in a browser and compare with S-019 | Researcher | done | Purpose met. Prices read from the company release (S-019) and the US App Store listing (S-047). The blog page itself stayed blocked (2026-10-07) |
| OPEN-02 | Evidence | Egypt Health Issues Survey 2015 adult BMI figures (EVD-05) | BMI tables not reached | Read Tables 5.6, 5.7.1 and 5.7.2 (pp. 70–72) and Figure 5.1 (p. 73) of S-004; note age range and cutoffs | Researcher | blocked | Sample counts, age range and table locations read in S-004. Figures [U]. See C.6 |
| OPEN-03 | Evidence | Diabetes prevalence in Egypt (EVD-06) | IDF page is script-rendered | Read the Egypt row at diabetesatlas.org (11th edition, S-015) | Researcher | done | 27.8% for 2022, model-based, adults 18+, both sexes, from a tier B aggregator (S-053). Official confirmation: OPEN-32 |
| OPEN-04 | Evidence | Seed claim: Android 88–91% in May–Aug 2026 | Monthly series not reachable | Download the monthly series from Statcounter and compare | Researcher | blocked | Seen: Sept 2026 Android 83.4%, iOS 16.58%; Oct 2025 Android 83.66%, iOS 16.09%. Jan–Aug 2026 not reachable. Seed range unsupported |
| OPEN-05 | Evidence | BMI cutoff used in the NCD-RisC factsheet | Factsheet does not restate it (re-confirmed) | Read the Lancet 2024 paper behind S-001 | Researcher | open | |
| OPEN-06 | Evidence | Numeric adherence or retention rates for food-logging apps (EVD-11) | Only authors' wording found in the first pass | Find a primary study with measured logging days or retention | Researcher | done | EVD-20 added from S-051: recording days and 6-month retention by group |
| OPEN-07 | Competitor | Egyptian dish coverage in global apps | No A or B source tested it | Hands-on test (`02-COMPETITORS.md` §2.7) | Tester | open | |
| OPEN-08 | Competitor | Play Store rating, count and last update date for every app | Play pages mostly not reached | Record on test day, with the date | Tester | open | Sahnain page: no rating shown, 500+ downloads, updated 2026-09-24 (S-044). Other cells stay [T] |
| OPEN-09 | Competitor | Android availability of the products (GAP-01) | First pass relied on App Store pages | Vendor site or Google Play listing, with URL and date | Researcher | done | Confirmed: CMP-01, CMP-03, CMP-05, CMP-06, CMP-08. Listing data via tier B: CMP-02, CMP-04. Not confirmed after searches: see OPEN-34. GAP-01 closed |
| OPEN-10 | Competitor | Arabic UI of CMP-01 to CMP-06 | No official language list found | Check store language lists and run each app with the phone in Arabic | Tester | open | YAZIO: 20 languages, no list (S-048). Others: nothing found |
| OPEN-11 | Competitor | YAZIO price and database size (seed said 4M+ items) | Listing shows several USD options with no periods | Open the official pricing page; read the database claim on the site | Researcher | open | Official pricing page not reached; 4M+ claim not found |
| OPEN-12 | Competitor | Lose It! price (USD 39.99 vs 79.99) and features | First pass had only conflicting tier C sources | Read the official membership page | Researcher | done | US listing (S-046): an option named "year of premium features" costs USD 39.99; no USD 79.99 option. Official page not opened |
| OPEN-13 | Competitor | MyFitnessPal monthly prices | First pass had tier C only | Read the official membership page or store listing | Researcher | done | Premium monthly USD 19.99 in S-047. Premium+ monthly stays tier C only [U] |
| OPEN-14 | Competitor | MacroFactor AI photo and voice logging | Tier C sources conflict (S-036, S-037) | Read the official site or install the app | Tester | open | No official source states it. Release notes mention AI custom foods only (S-032) |
| OPEN-15 | Competitor | Cal AI platforms, price, official URL; download and revenue figures | Figures differ across outlets | Read the official site and store listings | Researcher | done | Official site found (S-042): iOS and Android, photo, barcode and typed description, 3-day trial, FAQ says about 80% accurate. Price not shown. Revenue: over USD 40M in the company release (S-054) vs over USD 30M in press coverage (S-020); neither used |
| OPEN-16 | Competitor | Kam Calorie data source and AI provider, meaning of its accuracy and speed figures, privacy policy content | Site gives no method | Read the privacy policy and FAQ; email the vendor if needed | Researcher | open | The site discloses no data source or AI provider |
| OPEN-17 | Competitor | Products not profiled: Mezan (named as a comparison on Kam's site), Zorest Macro, HealthyBytes, Dayra Life (S-038), Miran (S-050) | Out of time, or only aggregator pages | Add rows to `02-COMPETITORS.md` if they pass the same checks | Researcher | open | Kilo official site now opened (S-043) |
| OPEN-18 | Evidence | DietAI24 original paper; any consumer app named DietAI | Only a citation was found | Search the paper by title and read it before using any number; search both stores | Researcher | open | No new find |
| OPEN-19 | Competitor | Whether each app shows a source or confidence per item (matrix row 10) | Listings rarely say | Hands-on test | Tester | open | Kilo restaurant "verified" badge (S-043) and Logma citations in Settings (S-027) found; others unknown |
| OPEN-20 | Legal | Whether anonymous survey answers and a student project fall under the data protection law; exact enforcement date; the Clyde & Co page from the brief was not opened | Law-firm briefings differ on timing and give no view on student projects | Read the Executive Regulations text and PDPC guidance; ask the supervisor or a legal adviser | Supervisor, legal adviser | open | Dates corroborated by S-017, S-018 and S-045 |
| OPEN-21 | Data | Source for 100–200 Egyptian dish values and for the reference values of the 30 test meals (OBJ-03, HYP-02) | No source selected | Find Egyptian food composition tables or papers; check reuse terms; decide how to weigh recipes | Data lead | open | |
| OPEN-22 | Technical | LLM provider, free quota, data terms and data location | Not chosen | Read provider terms; map to the data protection rules | Backend lead | open | |
| OPEN-23 | Technical | Firebase free plan limits for Auth and Firestore | Not checked | Read the current Firebase pricing page | Backend lead | open | |
| OPEN-24 | Technical | Survey tool, storage location, access list, deletion date | Not chosen | Pick a tool; record settings in the consent text | Research lead | open | |
| OPEN-25 | Competitor | Hands-on test not yet run; all `Y` cells are vendor statements | Needs devices and time | Run §2.7 and update both matrices | Tester | open | |
| OPEN-26 | Team question | What is the project end date, and what are the phase dates? | OBJ- due phases are generic labels | Ask the trainer or programme office | Team | open | Partly answered 2026-10-11: the team says the project ends 2026-12-01. Start date, phase dates and the exact presentation date are still open (`OPEN-77`) |
| OPEN-27 | Team question | What is the minimum Android version? | CON-04 and test devices | Team decision | Team | open | |
| OPEN-28 | Team question | Who owns these documents? Who is the trainer or supervisor contact for ethics and legal questions? | `owner: TBD` in every file; consent text needs a trainer name | Team decision | Team | open | Partly answered 2026-10-11: the trainer and team lead is Eng. Ahmed Kachwaa. Document owners are still TBD (role proposal in `07-WORKPLAN.md` section 4.1) |
| OPEN-29 | Team question | Which 5 apps will the hands-on test use, and does the team have an iPhone? | The shortlist in §2.7 assumes Android devices | Team decision | Team | open | |
| OPEN-30 | Team question | Which channels will distribute the survey, and in which language first? | Sample spread and consent language | Team decision | Team | open | |
| OPEN-31 | Legal | Official Arabic text of Law No. 151 of 2020 | S-016 is an English translation hosted by a law firm | Compare with the official gazette text | Legal adviser | open | |
| OPEN-32 | Evidence | Official confirmation of the 27.8% diabetes figure (EVD-06) | S-053 is an aggregator | Read the Egypt entry in the WHO Global Health Observatory or in the NCD-RisC Lancet 2024 paper (S-052) | Researcher | open | |
| OPEN-33 | Competitor | Whether the Sahnain App Store developer and the Google Play developer are the same | Inferred from the shared name and feature text | Check the developer website and support contacts on both pages | Researcher | open | |
| OPEN-34 | Competitor | Android status of CMP-07, CMP-09, CMP-10, CMP-11, CMP-12, CMP-13 | Not found in vendor sites or searches | Search Google Play by name; ask the vendor | Researcher | open | Kam and Kilo sites link to the App Store only |
| OPEN-35 | Evidence | Direct reading of the TechCrunch article on the Cal AI deal (S-020) | Canonical URL was seen only as a citation in the first revision pass | Open the article and note its date | Researcher | done | Opened directly on 2026-10-07: published 2 March 2026; MFP told TechCrunch over USD 30M annual revenue and 15M downloads |
| OPEN-36 | Evidence | Full text of Lawabni et al. (J Nutr 2026;156(9):101712) not opened; PubMed blocked by reCAPTCHA | CL-01 statistics | Open via university access or publisher page | Researcher | open |  |
| OPEN-37 | Technical | flutterfire issues #17643 and #13145 not reachable in three attempts | CL-12 | Open in a browser; record status, versions, by-design or bug | Researcher | open |  |
| OPEN-38 | Technical | Free-tier request limits for the chosen Gemini model are shown only in AI Studio | Cost and quota model | Read in AI Studio; fill `[T]` in SPK-01 | Backend lead | open |  |
| OPEN-39 | Technical | Firebase AI Logic: Flutter SDK name and version, App Check limited-use tokens, processing location | TD-02, TD-05 | Read official docs; prove in SPK-05 | Backend lead | open |  |
| OPEN-40 | Legal | Does PDPL licensing apply to a student prototype? Who is controller? Read OFF legal guide for ODbL | RSK-01, GT-04 | University counsel or lawyer, before 2026-10-30 | Supervisor, legal adviser | open |  |
| OPEN-41 | Technical | Mistral official free-tier limits, data-use terms and region (only tier B/C seen) | TD-02 | Read official pages | Researcher | open |  |
| OPEN-42 | Data | Nutritionix: no official source opened | TD-01 | Read official pricing and terms | Researcher | open |  |
| OPEN-43 | Data | FatSecret: storage and caching terms; Arabic in the 26-language list | TD-01 | Read terms and language list | Researcher | open |  |
| OPEN-44 | Data | Egyptian tables (NNI/INFOODS): reuse terms and machine-readable form | TD-01, `OPEN-21` | Contact FAO/INFOODS or NNI | Data lead | open |  |
| OPEN-45 | Evidence | "Arabic Cuisine Benchmark, 1,597 questions" and the figures 79.02/66.48 not found | CL-04 | Ask the earlier authors for the source | Researcher | open |  |
| OPEN-46 | Technical | pub.dev publisher, licence, last release and popularity of three sync packages | CL-13 | Open the pub.dev pages | Researcher | open |  |
| OPEN-47 | Technical | Jais 2 hosted API: none found | CL-05 | Recheck at GT-02 | Researcher | open |  |
| OPEN-48 | Evidence | Abstract and results of the Multimedia Systems 2026 paper not read | CL-03 | Open DOI 10.1007/s00530-025-02151-3 | Researcher | open |  |
| OPEN-49 | Technical | Are Cloud Functions usable on the free plan (needed for a proxy Plan B)? | TD-02 Plan B | Read Firebase pricing and Functions docs | Backend lead | open |  |
| OPEN-50 | Competitor | Competitor leads seen while searching: Sahnain, Kam Calorie Tracker, BiteRight (all `[U]`) | `02-COMPETITORS.md` | Review and add if relevant | Researcher | done | Sahnain and Kam Calorie are already CMP-08 and CMP-07. BiteRight stays unprofiled [U] (see CL-07 in 04-FEASIBILITY.md) |
| OPEN-51 | Process | Existing registers and script were unavailable in this session; IDs and check script not verified | Whole file | Renumber 9xx rows; run `check_discovery.py` | Researcher | done | IDs renumbered into the registers on 2026-10-09; structural check passed (see revision log) |
| OPEN-52 | Naming | Trainer or initiative approval of renaming the project from the brief title NutriVision to Nesba | Course rules were not checked for renaming | Ask the trainer; record the answer in `NAMING.md` §12 | Team | open | |
| OPEN-53 | Naming | Native-speaker confirmation of the Arabic spelling and meaning of نسبة, and one canonical Latin spelling (Nesba or Nisba) | Meanings are team judgement `[A]`; Latin spelling varies (`NAMING.md` §6.3) | Ask two Egyptian speakers; decide the spelling used in the store listing and on screens | Team, native speakers | open | |
| OPEN-54 | Naming | Store search for the exact-name Finance app "Nesba – Tax & Discount" and similar names (NS-043, NS-044) | An exact-name app exists in another category | Search Nesba and نسبة on Google Play and the App Store; note what ranks first | Tester | open | |
| OPEN-55 | Naming | Trademark, domain and social-handle check before any public release | Not done; registries and registrars were not reachable in the naming research | Use official registries and registrars; ask the supervisor or a lawyer. Not legal advice | Team, legal adviser | open | |
| OPEN-56 | Naming | Run the team test of the name (`NAMING.md` §9) | All result cells are `[T]` | Test with 5–8 people; fill the tables | Team | open | |
| OPEN-57 | Process | URLs were not recorded for 15 sources added by the feasibility study (S-065, S-068, S-071, S-072, S-076, S-077, S-078, S-080, S-081, S-084, S-085, S-088, S-089, S-091, S-092) | Source rows cannot be checked without a URL | Open each official page, paste the URL into `B-SOURCES.md`, and tick the Team check column | Researcher | open | |
| OPEN-58 | Technical | pub.dev pages were not opened for the dependencies in `06-DECISIONS.md` §5. Versions came from official repositories (main-branch `pubspec.yaml`, possibly ahead of the published version); pub.dev publisher, published date and some release dates are [T] | Package pages were not reachable by the tools used | Open each pub.dev page and fill publisher, published date, constraints; compare with the DEP rows | Mobile lead | open |  |
| OPEN-59 | Technical | Firebase Authentication quotas and email/password limits were not read; sign-in methods decision (ADR-15) | ADR-15, ASM-45 | Read the Authentication pricing and quotas pages; decide with the team | Backend lead | open |  |
| OPEN-60 | Team question | Which feature shows a runtime permission if barcode scanning stays out of scope? (ADR-20) | The brief requires runtime permissions | Team and trainer decision (for example a reminder notification) | Team | open |  |
| OPEN-61 | Team question | Which domain does the team own for the application id, and is domain-based naming plus the com.example rule confirmed on developer.android.com? Search Google Play for the chosen id (ADR-29, OPEN-55) | An application id cannot change after publishing | Read developer.android.com; check the team's domain; search the store | Team | open |  |
| OPEN-62 | Technical | Minimum Android versions of the Firebase Android SDK 34.19.0, `mobile_scanner`, `flutter_secure_storage` and `permission_handler` against Flutter's minSdk 24 were not read (ADR-02) | ADR-02 | Read each package's Android requirements; build on the lowest device | Mobile lead | open |  |
| OPEN-63 | Technical | Confirm that OSV-Scanner reads `pubspec.lock`, which obfuscation flags the current Flutter docs give, and how the Flutter licence page behaves (ADR-22, ADR-23) | Stated as [U] or [A] in the ADRs | Read the OSV-Scanner and Flutter docs | QA/security lead | open |  |
| OPEN-64 | Technical | Gemini price and limit pages were not re-read on 2026-10-09; values stay as in `04-FEASIBILITY.md` (S-075, S-077) | Volatile facts | Re-read both pages before GT-02 (2026-10-29) | AI lead | open |  |
| OPEN-65 | Technical | App Check provider for Android, device requirements and quotas were not read (ADR-16) | RSK-23 | Read the Firebase App Check pages; prove it in SPK-05 | QA/security lead | open | Closes part of OPEN-39: the package name `firebase_ai` and the limited-use token option are confirmed (S-093, S-094). Processing location is still unread |
| OPEN-66 | Technical | Does `firebase_ai` expose a response schema (structured output) for the chosen model in Flutter? (ADR-18) | ADR-18 | Read the SDK reference; test in SPK-01 | AI lead | open |  |
| OPEN-67 | Process | `05-REQUIREMENTS.md` was not available when `06-DECISIONS.md` was written, so no `FR-` or `NFR-` IDs were used and the coverage rule for Must requirements is unchecked | Step 5 had not run | Run step 5, then re-check ADR drivers and coverage | Product/legal lead | done | Closed 2026-10-10 by the final review: `05-REQUIREMENTS.md` exists and `06-DECISIONS.md` section 11 maps decisions to `FR-` and `NFR-`. One conflict was fixed (ADR-14 against token storage); gaps are `OPEN-74` to `OPEN-76` |
| OPEN-68 | Data | Source and values of household units (piece, spoon, cup) and default portions | FR-14 and FR-18 need them; `GAP-08` | Take them from the dish recipes and the dietitian review; same work as `OPEN-21` | Data lead | open | |
| OPEN-69 | Data | Initial list of general restrictions, and who reviews the restriction tags of each dish | FR-12 and FR-40; `ASM-49` | Use the survey results for `UQ-08`; find a dietitian or nutrition reviewer (`GT-03`) | Data lead | open | |
| OPEN-70 | Technical | Do recipes come from a bundled set or from the AI model, validated by the tag check? | FR-39 is written to hold for both; `ASM-54` | Decide with the spike results (`SPK-01`) | Team | open | |
| OPEN-71 | Team question | May the AI recipes and healthier alternatives of the brief be reduced in scenario S, and what does "AI-generated nutrition advice" require? | Scenario S demand exceeds the budget by 3.5 person-days, or 11.5 if TD-06 is right for recipes (`05-REQUIREMENTS.md` section 10.4); `ASM-55` | Ask the trainer; record the answer | Team | open | |
| OPEN-72 | Legal | Confirm the split of consent data: version in the cloud profile (ADR-12), full record on the device (ADR-14). Are the time and choices also needed in the cloud as proof of consent? | FR-08 and DAT-03 | Include in the legal read (`OPEN-40`) before `GT-04` | Supervisor, legal adviser | open | |
| OPEN-73 | Process | The item list of scenario S in `04-FEASIBILITY.md` TD-06 adds to 81.5 person-days (50 + 8 + 8 + 8 + 7.5), not "about 79", against a capacity of 80 | `05-REQUIREMENTS.md` section 10.4 uses the listed items | Recompute TD-06, or state which item is smaller | Researcher | done | Recomputed on 2026-10-11: the listed items add to 81.5 pd. `04-FEASIBILITY.md` TD-06 corrected; scenario S does not fit by 1.5 pd as listed (20 dishes would give 79.0). `05-REQUIREMENTS.md` section 10.4 already used the listed items |
| OPEN-74 | Technical | No ADR says how evaluation tools (FR-69 timing log, FR-70 label switch, FR-68 direct-estimate arm) are kept out of release builds | The requirements say test builds only; the mechanism (build flavour or a non-secret build flag) is not decided; `ADR-22` allows no secrets in build flags | Add an ADR or a line in ADR-27 and ADR-29; check with a release-build test | Mobile lead | open | |
| OPEN-75 | Technical | Confirm the Android default for cleartext traffic at the target API and add an explicit network security configuration | NFR-10 has no ADR | Read the Android network security configuration documentation; test with an intercepting proxy | QA/security lead | open | |
| OPEN-76 | Technical | Where is the daily analysis limit enforced: a counter on the device, or a server-side counter? | FR-31 has no ADR; a device-only counter can be bypassed, which is acceptable for quota protection but not for security | Decide with the AI lead; test the 31st request | AI lead | open | |
| OPEN-77 | Team question | Real dates: project start, booklet announcement date, weekday of the weekly assessment, and the exact final presentation date (the end is 2026-12-01) | Calendar and freeze dates (section 2); the 4-week division-of-tasks deadline; `ASM-57`, `ASM-58`, `ASM-65` | Ask the trainer in the first week | Group leader | open | |
| OPEN-78 | Team decision | How many productive days a week can each member give until 2026-12-01: 2.5 as this plan assumes, or 2.0 with the cuts of section 2.3? | At 2.0 days the S scope is short by 6.6 to 13.6 person-days (07 section 2.3); `ASM-59` | Each member lists real hours for 7 weeks; decide in SPR-00 planning | Group leader | open | |
| OPEN-79 | Team question | Is publication on Google Play inside the graded scope and the 2026-12-01 deadline, or after it? Which developer account will publish: one created before 2023-11-13, or a new personal account that needs a closed test with 12 testers for 14 days? | Section 2.7; `ASM-42` (no Play release during the course) no longer matches the team goal; `ADR-29` revisit trigger | Ask the trainer; check the account creation date; update `ASM-42` and `ADR-29` after the answer | Group leader | open | |
| OPEN-80 | Technical | Is the repository public or private, and does the team plan allow protected branches and required reviews? GitHub Free offers them only for public repositories | `ASM-44`, `ADR-28`, `GIT-09`; a public repository must hold no secret and no real-user data | Check the repository settings in SPR-00 | Product/legal lead | open | |
| OPEN-81 | Team question | The trainer's weekly individual assessment form, if it exists | Weekly deliverables and report headings should match what is graded (section 9.1) | Ask the trainer | Product/legal lead | open | |
| OPEN-82 | Team question | The course teaches sqflite, Dio and Cubit. Does the trainer expect local sqflite storage and Cubit-only state, while `ADR-11` uses Firestore offline persistence and `ADR-06` uses Bloc and Cubit? | Course expectations against the brief (Firestore sync) and the proposed stack; `KC-04` | Ask the trainer; record the answer in `ADR-06` and `ADR-11` | Group leader | open | |
| OPEN-83 | Process | How `KC-06` counts progress: 04 does not say what "done" means for the W1 to W5 work (37.5 person-days in the S plan) | In the plan 65%% of it is done by the end of SPR-02 and 72%% by the end of SPR-03, above the 60%% threshold, if "done" means Done by `07-WORKPLAN.md` section 7.1 | Team confirms the definition and the reading date; record it in 04 | Product/legal lead | open | |
| OPEN-84 | Process | The gate dates in `04-FEASIBILITY.md` (2026-10-22 to 2026-11-12) cannot be met at this capacity: `GT-01`, `GT-01b` and `GT-03` move 10 to 17 days later and `SPK-03` and `GT-05` move 17 to 24 days later in the S plan | 07 section 2.4 | Team accepts the plan dates or changes the scope | Group leader | open | |
| OPEN-85 | Process | In `05-REQUIREMENTS.md` the Open Food Facts lookup (FR-20) is a Should, but the brief item "Dio with interceptors for external nutrition APIs" has no other live consumer in scenario S | The Dio chain (FR-56 to FR-60) would be tested only with mocks | Promote the lookup to Must in S (1.0 person-day, Data lead) or accept mock-only tests | Product/legal lead | open | |
| OPEN-86 | Data | `SPK-02` in `04-FEASIBILITY.md` uses the first 60 dishes; the S plan has 17 dishes by the end of SPR-03 and 30 in total | `KC-01` counts 60 entered dishes | Confirm that SPK-02 runs on 16 dishes in S, or enter more dishes earlier | Data lead | open | |
| OPEN-87 | Team decision | The direct-estimate arm of `HYP-03` (FR-68) is a Should and is not in the S plan, so `HYP-03` has no evidence in S | Results rubric; 1.0 person-day of the AI lead | Promote it in S, or report `HYP-03` as not tested | AI lead | open | |
| OPEN-88 | Process | The evaluation sessions (timing for `HYP-01`, SUS for `HYP-04`, any survey analysis) have no line in TD-06 or in 05 section 10.4 | They sit inside the report and demo share (ASM-60) and may not fit | Time one session in SPR-05 and update the share | Product/legal lead | open | |
| OPEN-89 | Technical | The application id must be final before the first Play upload (early in SPR-03): decide it by the end of SPR-02 (2026-11-01) | `ADR-29` has the placeholder `com.team.nesba` for tester builds only; `OPEN-61` | Decide with the team and the account owner | QA/security lead | open | |
| OPEN-90 | Legal | Closed-test users would send real meal text to the AI model, which `ASM-32` and `GT-04` restrict to consenting adults and synthetic text or the paid tier | Section 2.7; `RSK-02`, `RSK-25` | Decide before the closed test: paid tier with a cap, or a restricted mode; record in `GT-04` | Product/legal lead | open | |

## C.5 Re-verification log

Dates are 2026-10-07. "Old" is the first-pass value.

| ID | Item | Old value | Result | New value |
|---|---|---|---|---|
| RV-01 | EVD-01, EVD-02 obesity, women and men | 59.0% and 32.5%, age 20+, age-standardised | Confirmed in S-001 | Unchanged. Cutoff still not stated in the factsheet [U] |
| RV-02 | EVD-08 survey and posts | 141 journalers, 5,500+ posts | Confirmed (S-006, S-007) | 141 current and lapsed journalers; 5,526 posts (S-006); "more than 5,500" on the news page |
| RV-03 | EVD-10 review size | 22 studies, 15 on diet | Partly: abstract says 15, full text says 14 | 22 studies; 15 per abstract, 14 per full text; US-based, mostly white women (S-009, S-040) |
| RV-04 | EVD-12 habit study | n = 100; means 5.0 / 4.0 / 2.35; "hard to remember (1–7)" | Values confirmed; scale wording corrected | Likert 1 = completely disagree to 7 = completely agree; SDs 1.81, 2.24, 1.79; p < 0.001; 6 weeks (S-011) |
| RV-05 | EVD-14 benchmark | 11,857 descriptions, 12 LLMs, comparable to nutritionists | Confirmed; detail added | 3 professional nutritionists; "comparable but significantly faster" in the final version; data from 11 countries (S-013) |
| RV-06 | EVD-18 law dates | Decision 816/2025; issued 1 Nov 2025; public 25 Dec 2025; one-year grace; enforcement expected 1 Nov 2026 | Confirmed (S-017, S-018, S-045); "expected" wording kept | Unchanged. One non-law-firm page says 31 Oct 2026; not used |
| RV-07 | CMP-01 prices | Premium USD 79.99/yr; Premium+ USD 99.99/yr | Confirmed (S-019, dated 2026-02-24); region not stated | Unchanged. Premium monthly USD 19.99 now in S-047 |
| RV-08 | CMP-03 prices and size | Gold USD 10.99/mo, 59.99/yr; 1.1M–1.2M foods | Prices confirmed (S-030, S-031); 1.2M not found | Over 1.1 million verified foods |
| RV-09 | CMP-06 prices | USD 11.99 / 47.99 / 71.99 | Confirmed (S-032, S-041); listing says US customers | USD 11.99/mo, 47.99/half-year, 71.99/yr, US customers |
| RV-10 | CMP-07 limits and price | 10 free AI logs; PRO USD 4.99/mo, 300 logs | Confirmed (S-021) | Unchanged. Site also claims 95% accuracy and a clinical-grade standard, with no method [U] |
| RV-11 | EVD-07 Android share | 83.4% Android, Sept 2026 | Confirmed (S-005) | Added Oct 2025 snapshot: Android 83.66%, iOS 16.09%. Seed range 88–91% not reproduced |
| RV-12 | EVD-05 sample and population | n = 15,602; women ever-married 15–49 | Not supported by the report (S-004) | 9,209 women and 7,462 men interviewed, aged 15–59; 20.0% of women never married. The first-pass note came from a generic DHS note (S-003) |
| RV-13 | CMP-08 platform | iPhone only | Wrong. The App Store badge "Only for iPhone" is a device label | Google Play listing exists (S-044); GAP-01 closed |
| RV-14 | CMP-05 acquisition | Reported by tier B | Confirmed by the company release (S-054) | Announced 2 March 2026; app stays standalone |
| RV-15 | CMP-04 price | USD 39.99 vs 79.99 (tier C conflict) | Listing has a USD 39.99 option named "year of premium features" (S-046); no USD 79.99 option | Period stays [U] except for that option name |
| RV-16 | EVD-06 diabetes | [U] | Number found in an aggregator (S-053) | 27.8%, 2022, model-based, adults 18+, both sexes; confirm officially (OPEN-32) |
| RV-17 | CMP-05 article details (S-020) | Short URL; date not visible | Article opened directly | Published 2 March 2026; MFP gave over USD 30M annual revenue to TechCrunch, against over USD 40M in the company release (S-054); both unused |
| RV-18 | CMP-04 platforms | Android [U] | Aggregator pages show a Google Play listing from the same developer (S-055) | Android listing exists; "Contains Ads" label; database of over 50M foods per vendor listing (S-046) |

## C.6 Blocked-source attempts

| Source | Attempts (routes) | Result |
|---|---|---|
| MyFitnessPal blog pricing page | 1) direct fetch, blocked by bot detection; 2) search for the page; 3) search for the company release | Purpose met through S-019 and S-047; page itself not opened |
| Egypt Health Issues Survey 2015, BMI tables | 1–2) searches of the World Obesity portal (charts without numbers); 3) direct PDF fetch (stopped before chapter 5) | Blocked. Figures stay [U] |
| Statcounter monthly series, Egypt | 1) direct page (latest month only); 2) search snippets (Oct 2025 snapshot); 3) extended search (worldwide and Africa only) | Blocked for Jan–Aug 2026 |
| IDF Atlas, Egypt | 1) country page, script-rendered (first pass); 2) NCD-RisC and WHO search | Number found only through an aggregator (S-053) |
| Kam Calorie on Google Play | Three searches | No listing found; site links to the App Store only |
| YAZIO official pricing and language list | Three searches | Not reached |
| Lose It! official membership page | Two searches | Not reached. Android listing data found through aggregators (S-055) |
| Khatwa, Zadi, Logma, TalkFood on Google Play | One to two searches | No listing found |
| MacroFactor AI features, official source | One search | None found |
