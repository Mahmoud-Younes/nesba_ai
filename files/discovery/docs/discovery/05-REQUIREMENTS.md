---
id: DISC-01-05
title: Nesba Discovery, Section 5 (requirements)
parent: DISC-01
status: draft
last_verified: 2026-10-10
owner: TBD
---

> **AI NOTES**
> - What this is: Section 5, the requirements specification (SRS, user stories, MoSCoW) for Nesba (نسبة; course-brief title NutriVision). Hub: [DISCOVERY.md](DISCOVERY.md). Read [AI_CONTEXT.md](AI_CONTEXT.md) first.
> - IDs defined here: `US-` US-01 to US-37; `FR-` FR-01 to FR-70; `NFR-` NFR-01 to NFR-29; `DAT-` DAT-01 to DAT-13; `INT-` INT-01 to INT-08. Existing `OBJ-`, `HYP-`, `PRB-`, `PER-`, `RSK-`, `TD-`, `SPK-`, `GT-`, `ADR-` are reused, never redefined.
> - MoSCoW: FR 56 Must, 14 Should, 0 Could; NFR 19 Must, 10 Should; stories 28 Must, 9 Should, 0 Could. Won't items are in section 10.3.
> - Tags: [V:S-xxx] a cited source states it; [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill. A requirement statement is normative text and needs no tag; its Source column holds the IDs it comes from.
> - All of it is proposed, not approved. Priorities, effort sizes and every threshold not copied from an `OBJ-` are team assumptions (`ASM-31`, `ASM-47`, `ASM-48`). Technology named in a requirement is marked "(proposed)" and points to the `ADR-` in `06-DECISIONS.md` that decides it (all ADRs are Proposed).
> - Traceability is in section 11, the capacity check in section 10.4, conditional requirements and target changes in section 12, the self-audit in section 13.

# 5. Requirements

Part of [DISCOVERY.md](DISCOVERY.md). Nothing below has been run or tested; verification columns say how each requirement will be checked.

## 1. Introduction

### 1.1 Purpose

This section states what Nesba shall do, in testable form, so that the build can start from one list; the technology decisions that serve it are in `06-DECISIONS.md`. It serves the rubric criteria *Content and organization*, *Methods* (every requirement has a verification) and *Results* (section 9 lets `HYP-01` to `HYP-04` be measured).

### 1.2 Scope

Nesba is an Android-first Flutter app for Arabic-speaking adults in Egypt. The user types a meal in their own words (Arabic, Egyptian dialect or English); AI splits it into items; nutrition is computed in code from reference data; every number shows its source; recipes and alternatives respect declared general restrictions; meals sync across devices. It is an information tool, not a medical device. Team of 5 students, zero budget. NutriVision is only the course-brief title.

In scope: `SCP-IN-01` to `SCP-IN-07`. Out of scope: `SCP-OUT-01` to `SCP-OUT-06` (section 10.3).

### 1.3 Definitions

| Term | Meaning |
|---|---|
| FR | Functional requirement: one testable behaviour, written "The system shall ..." |
| NFR | Non-functional requirement: a measurable quality, limit or project rule |
| US | User story: "As a ..., I want ..., so that ..." |
| DAT / INT | Data requirement; external interface requirement |
| MoSCoW | Must, Should, Could, Won't (this release); rules in section 10.1 |
| S / M / L | Effort in days of one student, including the requirement's own tests: S 0.5, M 1, L 2 person-days [A:ASM-47] |
| Item | One food entry inside a meal |
| Reference table | The bundled Egyptian dish table and the bundled USDA subset |
| Source layer | Where an item's values came from: dish table, USDA subset, barcode result or AI estimate |
| Grams basis | Whether the grams of an item were stated by the user, typical for the food, or unknown |
| AI estimate | Values proposed by the AI model for an item with no reference match; always labelled and shown with a range |
| Restriction tag | A tag on a reference row meaning the food is compatible with a declared general restriction |
| Test build / release build | A build with evaluation tools switched on / the build given to users |

### 1.4 References

`DISCOVERY.md` (problem, `OBJ-`, `SCP-`, `CON-`), `AI_CONTEXT.md` (rules), `02-COMPETITORS.md` (positioning, claims we must not make), `03-USER-RESEARCH.md` (`UQ-`, `PER-`, `DR-`), `04-FEASIBILITY.md` (`TD-`, `SPK-`, `GT-`, `RSK-`, `KC-`), `06-DECISIONS.md` (`ADR-`, `DEP-`: platform and technology decisions), `A-ASSUMPTIONS.md`, `B-SOURCES.md`, `C-OPEN-ITEMS.md`.

## 2. Overall description

### 2.1 Product perspective

Nesba is a standalone Android app. It depends on the external systems below; behaviour at each boundary is in section 7.

| Kind | Name | Role |
|---|---|---|
| Actor | User (PER-01, PER-02, PER-03) | Logs meals, reviews items, asks for recipes and alternatives, manages the account. |
| Actor | Helper | A relative who types meals on the user's own phone (PER-03). Uses the same screens; no separate role. |
| Actor | Evaluator (team) | Runs the timing, accuracy and usability tests with test builds and scripts (section 9). |
| Actor | Supervisor | Reviews sources, licences, consent text and the legal read (`OPEN-40`). |
| External system | Identity provider | Account creation and sign-in (INT-01). |
| External system | Cloud database (Cloud Firestore, mandated by the brief) | Meal and profile storage and sync (INT-02). |
| External system | AI model service | Parsing, estimation and recipe generation (INT-03); technology is decided in ADR-16 to ADR-18 (proposed). |
| External system | Barcode data service (Open Food Facts) | Packaged-food lookup (INT-04); decided in ADR-19 and ADR-21 (proposed). |
| Local resource | Bundled reference data | Egyptian dish table and USDA subset inside the app (INT-05). |
| Local resource | Device camera and Android Keystore | Barcode scanning with a runtime permission (INT-06); token storage (INT-07). |

### 2.2 User classes

All personas are `PROVISIONAL` (`03-USER-RESEARCH.md` section 3.8).

| Persona | Profile | Needs that drive requirements |
|---|---|---|
| PER-01 Mona | Early 30s, cooks at home, wants gradual weight loss, Android, Arabic first | Free-text entry, visible sources, household units, weekly chart, restriction-aware recipes, offline use |
| PER-02 Karim | About 21, trains at the gym and tracks protein, English apps, Arabic food names | Macros per item, fast repeat, grid history, alternatives, barcode, both languages |
| PER-03 Samir | About 55, follows general guidance, helped by a relative, Arabic only, needs large text | Arabic right-to-left UI, large text, simple flow, restrictions without diagnoses, safety notices |

### 2.3 Operating environment

Android phones, minimum version to be set (`OPEN-27`); tested on one mid-range and one low-RAM device [A:ASM-35]. The app works offline for logging from reference tables, history and charts; AI analysis, barcode lookup and sync need a network.

### 2.4 Constraints

| ID | Constraint | Where it shows up |
|---|---|---|
| CON-01 | Zero budget; free tiers only | NFR-26; FR-31; NFR-27; NFR-28 |
| CON-02 | Project end date unknown | Section 10.4 uses two scenarios; `OPEN-26` |
| CON-03 | Team of 5 students | Effort sizes and capacity check; NFR-23 |
| CON-04 | Android first; minimum version not set | NFR-24; `OPEN-27` |
| CON-05 | No verified Egyptian dish dataset in hand | FR-63; FR-64; `OPEN-21` |
| CON-06 | Health data is sensitive; transfers abroad need authorisation; notices in Arabic | FR-06; FR-07; FR-10; NFR-11 |
| CON-07 | Brief: Flutter, Dio with interceptors, Firestore sync, tests, Keystore, runtime permissions | FR-56; FR-46; NFR-21; FR-03; FR-61 |

### 2.5 Assumptions and dependencies

New assumptions are rows `ASM-47` to `ASM-55` in `A-ASSUMPTIONS.md`.

| Topic | Assumption | Used in |
|---|---|---|
| Effort sizes S, M, L | ASM-47 | Capacity check (section 10.4) |
| Numeric thresholds not taken from an OBJ- or SPK- value (500 characters, 12 taps, 3 taps, 16 s timeout, 30 s sync, 30 analyses per day, pages of 20 meals, 2 retries, 7-day chart, 30-day cache) and test sample sizes in acceptance criteria | ASM-48 | Acceptance criteria; the team confirms or changes them |
| Initial restriction list | ASM-49 | FR-12; DAT-09 |
| Font scale 200% and 48 dp targets | ASM-50 | NFR-15; NFR-16 |
| Typed meal text is not synced to the cloud | ASM-51 | DAT-04 |
| A lower-energy alternative: same food group, at least 10% lower energy per serving | ASM-52 | FR-41 |
| Barcode scanning carries the brief's runtime-permission requirement | ASM-53 | FR-19 |
| Recipes from any origin pass the same tag check | ASM-54 | FR-39; FR-40 |
| The brief's "AI-generated nutrition advice" is met by sourced alternatives and recipes, not by free medical-style tips | ASM-55 | FR-41; FR-39; FR-50 |
| Existing: targets, thresholds, spikes, privacy and data assumptions | ASM-03, ASM-19, ASM-31, ASM-32, ASM-34, ASM-35, ASM-36, ASM-37 | Various |

## 3. User stories

Stories are grouped by epic. Priority follows the rules in section 10.1. "Linked" lists the `FR-` (or `NFR-`) that implement the story. Given/When/Then lines for Must stories are in section 3.8. The INVEST check is summarised in section 13.

### 3.1 E1 Log a meal

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-01 | PER-01 | As Mona, I want to describe a meal in my own words in Arabic or English so that I do not search for each ingredient. | Must | FR-15, FR-17, FR-21, FR-25, FR-32 |
| US-02 | PER-01 | As Mona, I want to change a portion in household units such as piece, spoon or cup so that I fix a wrong portion in a few taps. | Should | FR-14, FR-18, FR-36 |
| US-03 | PER-02 | As Karim, I want to type a meal that mixes English and Arabic food names so that I log quickly without switching language. | Must | FR-15, FR-21, FR-29 |
| US-04 | PER-02 | As Karim, I want to repeat a previous meal with one action so that my usual meals take seconds. | Should | FR-38 |
| US-05 | PER-02 | As Karim, I want to choose among up to three matches for an Egyptian dish so that the right dish is used. | Should | FR-26, FR-29 |
| US-06 | PER-02 | As Karim, I want to scan the barcode of a packaged food so that I log protein bars and drinks without typing. | Should | FR-19, FR-20, FR-61 |
| US-07 | PER-03 | As Samir, I want to let my relative type my meal on my phone in few steps so that I follow my guidance without confusion. | Should | FR-15, FR-17, NFR-15 |
| US-08 | All users | As a user, I want to delete a saved meal so that my log stays correct. | Must | FR-37 |

### 3.2 E2 Trust the numbers

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-09 | PER-01 | As Mona, I want to see each item with its source and a confidence label so that I can check where each number comes from. | Must | FR-27, FR-28 |
| US-10 | PER-01 | As Mona, I want to see when a number is an AI estimate with a range so that I do not trust a guess like a measured value. | Must | FR-18, FR-27 |
| US-11 | PER-02 | As Karim, I want to see protein per item beside its source so that I can hit my daily protein target. | Must | FR-28, FR-32, FR-35 |

### 3.3 E3 Recipes and alternatives

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-12 | PER-01 | As Mona, I want to get recipes that respect my declared restrictions so that I can cook at home without checking every ingredient. | Must | FR-39, FR-40 |
| US-13 | PER-02 | As Karim, I want to find lower-energy alternatives for a snack I name so that I keep my favourite foods and cut energy. | Must | FR-40, FR-41 |
| US-14 | PER-03 | As Samir, I want to declare general restrictions without entering any diagnosis so that suggestions follow my guidance. | Must | FR-12 |
| US-15 | PER-03 | As Samir, I want to get recipes and alternatives that never contain a restricted ingredient so that I avoid mistakes. | Must | FR-39, FR-40, FR-41 |
| US-16 | PER-03 | As Samir, I want to see a warning on a logged item that breaks my declared restriction so that I notice problems early. | Should | FR-54 |

### 3.4 E4 History and charts

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-17 | PER-01 | As Mona, I want to see the total energy and macros of my day so that I can follow my gradual weight-loss plan. | Must | FR-33, FR-42 |
| US-18 | PER-01 | As Mona, I want to see a 7-day energy chart so that I can see my trend. | Must | FR-43, FR-44 |
| US-19 | PER-02 | As Karim, I want to browse my meal history as a grid and open a meal so that I can review what I ate. | Must | FR-36, FR-42 |
| US-20 | PER-02 | As Karim, I want to see the macro split of a selected day so that I can check my protein share. | Should | FR-45 |

### 3.5 E5 Sync, offline and errors

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-21 | All users | As a user, I want to sign in and see my meals on my second device so that my log follows me. | Must | FR-01, FR-04, FR-05, FR-46, FR-49 |
| US-22 | PER-01 | As Mona, I want to log a meal when I have no internet so that I do not lose entries while travelling. | Must | FR-16, FR-47, FR-48 |
| US-23 | All users | As a user, I want to understand what went wrong when a request fails so that I know what to do next. | Must | FR-22, FR-23, FR-60, FR-62 |

### 3.6 E6 Privacy, safety and language

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-24 | All users | As a user, I want to decide on consent before any of my data leaves the phone so that I stay in control of my health-related data. | Must | FR-06, FR-07, FR-08, FR-09 |
| US-25 | All users | As a user, I want to delete my account and all my cloud data so that I can leave at any time. | Must | FR-11 |
| US-26 | All users | As a user, I want to be sure my name, phone number or email never reaches the AI model so that my identity stays separate from my meals. | Must | FR-02, FR-10 |
| US-27 | PER-03 | As Samir, I want to see a clear notice that the app is information only so that I know it does not replace my doctor. | Must | FR-51, FR-52 |
| US-28 | PER-03 | As Samir, I want to get a clear refusal when I ask about medication doses so that I am sent to a professional. | Must | FR-50 |
| US-29 | PER-03 | As Samir, I want to use an Arabic right-to-left interface so that I can use the app without English. | Must | FR-13 |
| US-30 | PER-02 | As Karim, I want to use the English interface with Arabic food names so that I am comfortable in both languages. | Must | FR-13 |
| US-31 | PER-03 | As Samir, I want to read every screen at a large text size so that I can read without help. | Should | NFR-15 |

### 3.7 E7 Evidence, documentation and team checks

| ID | Persona | Story | Priority | Linked |
|---|---|---|---|---|
| US-32 | Team (data lead) | As the data lead, I want to run a script that checks every reference row for a source so that the sourced share is proven. | Must | FR-63, FR-64, FR-65, FR-66 |
| US-33 | Team (QA lead) | As the QA lead, I want to run the 30 reference meals repeatably and get the error per dish so that accuracy is reported per dish. | Must | FR-67, FR-68, NFR-29 |
| US-34 | Team (evaluator) | As the evaluator, I want to get a timing log in test builds so that I can measure analysis time and manual-search time without tracking users. | Must | FR-16, FR-69, NFR-01 |
| US-35 | Team (evaluator) | As the evaluator, I want to hide the source labels in a test build so that I can compare trust with and without labels. | Should | FR-70, NFR-14 |
| US-36 | Supervisor | As the supervisor, I want to see the datasets and their licences inside the app so that I can check that sources are credited. | Must | FR-55, NFR-12 |
| US-37 | Team (product lead) | As the product lead, I want to run a check that no banned claim appears in the texts or the store listing so that we never overclaim. | Must | FR-53 |

### 3.8 Acceptance scenarios for Must stories

| ID | Scenario 1 | Scenario 2 |
|---|---|---|
| US-01 | Given the main screen, when I type "كشري وطبق سلطة" and send it, then I see a list of items with grams within 8 s. | Given the review screen, when I confirm, then the meal is saved and appears first in my history. |
| US-09 | Given a parsed meal, when the review screen opens, then every item shows a source name and a confidence label. | Given an item has no reference match, when it is shown, then it carries the label AI estimate and a range. |
| US-17 | Given three saved meals today, when I open history, then the day total equals the sum of the three meals. | Given I edit one item, when I return to history, then the day total has changed by the same amount. |
| US-18 | Given 7 days of meals, when I open the chart, then I see 7 bars equal to the daily totals. | Given the chart, when I tap a bar, then an overlay shows that day's energy, protein, carbohydrate and fat. |
| US-12 | Given I declared lactose-free, when I ask for recipes, then no listed ingredient carries a dairy tag. | Given a suggestion has an untagged ingredient, when results are built, then that suggestion is not shown. |
| US-10 | Given an item has unknown grams, when I review it, then I am asked for a portion or I see the label default portion. | Given an AI estimate, when it is shown, then it never carries a reference-source label. |
| US-22 | Given airplane mode, when I add a meal from the reference tables, then it appears in history at once. | Given I reconnect, when 30 seconds pass, then the meal is on my other device. |
| US-11 | Given a parsed meal, when I open it, then each item shows grams of protein and its source. | Given any nutrition screen, when I look for micronutrients, then none are shown. |
| US-03 | Given the text "2 ful sandwiches and بروتين شيك", when I send it, then I get 2 items. | Given a name in English and the same dish in Arabic, when both resolve, then they use the same reference row. |
| US-19 | Given 500 saved meals, when I open history, then the first page of 20 meal cards appears. | Given a card, when I tap it, then I see its items and can edit them. |
| US-13 | Given I type a snack name, when I ask for alternatives, then I see up to 3 with the energy difference. | Given an alternative, when it is shown, then its label says lower-energy alternative and not healthy. |
| US-30 | Given English is selected, when I open any screen, then all labels are English and food names stay as typed. | Given I switch to Arabic, when the screen reloads, then the layout is right-to-left. |
| US-29 | Given Arabic is selected, when I open the 5 key screens, then the layout is mirrored and all texts are Arabic. | Given a first launch with an Arabic device, when the app opens, then Arabic is the default. |
| US-14 | Given the restrictions screen, when I open it, then I choose from a list and there is no free-text field. | Given I save my choices, when I restart the app, then they are still set. |
| US-15 | Given I declared a restriction, when recipes are shown, then 0 ingredients carry a violating tag. | Given an ingredient has no tag, when a recipe is built, then the recipe is rejected. |
| US-27 | Given first launch, when the app opens, then the information-only notice is shown. | Given a recipe screen, when it opens, then the notice and the allergen wording are visible. |
| US-28 | Given I type a question about an insulin dose, when I send it, then I see a refusal and a pointer to a professional. | Given the refusal, when I read it, then it contains no dose, treatment step or diet target. |
| US-24 | Given a fresh install, when I open the app, then the Arabic notice and consent screen come first. | Given I have not accepted, when I use the app, then no request carries my data. |
| US-25 | Given the settings screen, when I confirm deletion, then I see a completion message. | Given I sign in again, when history opens, then it is empty. |
| US-21 | Given I save a meal on device A, when 30 seconds pass online, then it appears on device B. | Given another user signs in on device A, when they open history, then they see none of my meals. |
| US-23 | Given the network drops during analysis, when 16 seconds pass, then I see a timeout message and a manual-entry option. | Given an invalid AI answer, when the retry also fails, then I see manual entry and not a raw error. |
| US-26 | Given I analyse a meal, when the request is recorded, then it holds only the meal text. | Given account creation, when I look at the form, then there is no field for name, phone number or national ID. |
| US-08 | Given a saved meal, when I delete it, then it disappears from history and from my other device. | Given it is deleted, when I open the day total, then the total no longer includes it. |
| US-32 | Given a table with one row missing a source ID, when the script runs, then it exits with an error naming the row. | Given the clean tables, when the script runs, then it prints the share of sourced rows. |
| US-33 | Given recorded AI responses, when the run is repeated, then the CSV files are identical. | Given the CSV, when I open it, then I see one row per meal with its energy error. |
| US-34 | Given a test build, when a tester logs a meal, then 3 timestamps are written locally. | Given a release build, when a user logs a meal, then no timing record is written. |
| US-36 | Given the About screen, when I open it, then each dataset shows name, licence, URL and retrieval date. | Given a barcode result is shown, when I look at it, then Open Food Facts is credited. |
| US-37 | Given the app strings and the listing text, when the scan runs, then it finds 0 banned claims. | Given a banned phrase is added to a string, when the scan runs, then it reports the string key. |

## 4. Functional requirements

Effort: S 0.5, M 1, L 2 person-days [A:ASM-47]. Verification: unit, widget, integration (automated), manual, or experiment `SPK-xx`. "Depends on" lists other requirements, interfaces, open items and proposed decisions. Where the Source column holds no `US-` ID, the requirement is marked technical or legal. The word "(proposed)" means the technology is decided by an `ADR-` in `06-DECISIONS.md` that the team has not accepted yet.

### 4.1 Account

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-01 | Account | The system shall let a user create an account and sign in, and shall send no user data to the cloud database before sign-in. | Must | M | SCP-IN-06; OBJ-05; CON-07; US-21 | In an instrumented run of 10 core flows without sign-in, 0 write requests reach the cloud database; after sign-in the same flows write only under the user's own path. | integration | INT-01; INT-02; ADR-15 (proposed) |
| FR-02 | Account | The system shall collect no data at account creation other than the credential its sign-in method needs, and shall offer no field for name, phone number or national ID. | Must | S | OBJ-08; PRB-07; CON-06; legal; US-26 | A widget test lists every input field of the account screens: 0 fields ask for name, phone number or national ID. | widget | ADR-15 (proposed); OPEN-59 |
| FR-03 | Account | The system shall keep the consent record and the local copy of the declared restriction tags only in Android Keystore-backed storage, and shall store no sign-in token and no API key itself. | Must | S | Brief (Keystore); CON-07; OBJ-08; ADR-14; technical | After a consent and a restriction choice, a scan of the app data directory on a test device finds neither value outside the Keystore-backed store, and finds 0 tokens or keys in files written by app code. | integration; manual | ADR-14 (proposed) |
| FR-04 | Account | The system shall let a signed-out user request a password reset for the account email from the sign-in screen, and shall show a confirmation that does not reveal whether the address has an account. | Should | S | ADR-15; PRB-07; technical; US-21 | In 10 runs with a known and an unknown address, 10 of 10 show the same confirmation text; delivery of the reset message is checked by hand once. | widget; manual | ADR-15 (proposed) |
| FR-05 | Account | The system shall delete the local cache of the previous user's meals when a user signs out or another user signs in. | Must | M | OBJ-05; RSK-16; KC-03; US-21 | In 5 scripted account switches on one device, 0 documents of the previous user are readable by the new user, online or offline. | integration | none |

### 4.2 Consent and privacy

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-06 | Consent and privacy | The system shall show a privacy notice in Arabic, with an English version available, and an explicit consent screen on first launch before any other feature is used. | Must | M | OBJ-08; PRB-07; CON-06; legal; S-017; US-24 | On a fresh install the consent screen appears before the log screen in 10 of 10 runs; a string check finds 0 missing keys between the Arabic and English notice. | widget; integration | DAT-03 |
| FR-07 | Consent and privacy | The system shall make no network request that carries user data until the user has accepted the consent screen. | Must | S | OBJ-08; CON-06; legal; US-24 | In runs with consent declined or pending, a mock network layer records 0 requests carrying meal text, account data or analytics events. | unit; integration | none |
| FR-08 | Consent and privacy | The system shall store a consent record with notice version, time and choices, and shall show the consent screen again when the notice version changes. | Must | S | OBJ-08; EVD-19; legal; US-24 | After the notice version is raised in a test build, the consent screen appears at the next launch in 5 of 5 runs. | unit; widget | DAT-03; ADR-14 (proposed); OPEN-72 |
| FR-09 | Consent and privacy | The system shall send no analytics or crash-report data unless the user has opted in. | Must | S | OBJ-08; TD-05; ADR-24; AI_CONTEXT; US-24 | On a fresh install, 0 analytics or crash-report requests occur during 10 core flows; if an opt-in control exists, it is off by default and the first event is sent only after the user turns it on. | integration | ADR-24 (proposed) |
| FR-10 | Consent and privacy | The system shall send to the AI model only the normalised meal text, and for recipe requests the declared restriction tags, with no account identifier, name, email or device identifier. | Must | M | TD-02; TD-05; RSK-01; RSK-02; ASM-32; AI_CONTEXT; US-26 | A scan of 100 recorded AI request payloads finds 0 occurrences of the identity fields listed in DAT-01. | unit; integration | INT-03 |
| FR-11 | Consent and privacy | The system shall let a signed-in user delete the account and all cloud-stored data from the settings screen, and shall confirm when deletion has completed. | Must | M | OBJ-08; PRB-07; GAP-07; legal; US-25 | Deletion needs at most 3 taps after the confirmation prompt; afterwards a read of the user's data path returns 0 documents and signing in again shows an empty history. | integration; manual | INT-02 |

### 4.3 Profile

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-12 | Profile | The system shall let the user declare general dietary restrictions from a fixed list and shall offer no free-text field for diagnoses, conditions or medication. | Must | S | OBJ-04; SCP-OUT-04; ASM-19; ASM-49; US-14 | The restrictions screen offers only the list in DAT-09; a widget test finds 0 free-text fields on it. | widget | ADR-14 (proposed); OPEN-69 |

### 4.4 Localisation

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-13 | Localisation | The system shall provide every user-visible text in Arabic with a right-to-left layout and in English, and shall let the user switch language in settings. | Must | M | SCP-IN-02; SQ-19; PER-03; TH-06; US-30, US-29 | A string check finds 0 missing keys between the two languages; layout checks of the 5 key screens (log, review, history, chart, settings) pass in both directions. | unit; widget | none |
| FR-14 | Localisation | The system shall show a portion in household units (piece, spoon, cup) when the reference row defines one, and in grams otherwise. | Should | M | TH-10; GAP-08; PER-01; US-02 | For 20 fixture items with household units defined, 100% display the unit and its gram equivalent after an edit; items without a unit display grams. | unit; widget | FR-63; OPEN-68 |

### 4.5 Meal entry

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-15 | Meal entry | The system shall provide a text box on the main screen that accepts a meal description of up to 500 characters in Arabic (including Egyptian dialect) or English, with Arabic-Indic or Western digits, and shall show the remaining character count. | Must | S | SCP-IN-02; OBJ-01; PRB-01; ASM-48; US-01, US-03, US-07 | All 30 descriptions of the SPK-01 set (10 dialect, 10 Modern Standard Arabic, 10 English) are accepted; the 501st character is refused. | widget; experiment SPK-01 | none |
| FR-16 | Meal entry | The system shall let the user add a food item by searching the reference tables, using no network and no AI call. | Must | M | PRB-01; TD-01; TD-02; KC-02; US-22, US-34 | In airplane mode, a meal of 3 items is logged from the reference tables in at most 12 taps. | widget; integration | FR-63 |
| FR-17 | Meal entry | The system shall save a reviewed meal with a date and time, defaulting to now and editable, when the user confirms. | Must | S | SCP-IN-05; OBJ-01; US-01, US-07 | After confirmation the meal appears first in history with the chosen time in 10 of 10 runs; without confirmation 0 meals are written. | widget; unit | none |
| FR-18 | Meal entry | When an item's grams basis is unknown, the system shall ask the user to choose a portion before computing the item, or apply a default portion and mark it 'default portion'. | Must | M | RSK-15; TD-02; OBJ-02; US-02, US-10 | For 10 fixture items with unknown grams, 100% show the portion question or the 'default portion' label; 0 items are computed silently. | unit; widget | none |
| FR-19 | Meal entry | The system shall let the user start a barcode scan, shall request the camera permission when the scan starts, and shall show the scanned digits. | Must | M | Brief (runtime permissions); TD-04; ASM-53; US-06 | With permission granted, a test barcode image yields its digits; with permission denied, the scan screen offers manual entry and no crash occurs in 10 of 10 runs. | widget; manual | FR-61; INT-06; ADR-20 (proposed); OPEN-60 |
| FR-20 | Meal entry | The system shall look up a scanned barcode in Open Food Facts, show the product values with Open Food Facts attribution, send at most 15 lookups per minute per device, and offer manual entry when the product is not found. | Should | M | TD-01; TD-05; S-070; CL-11; US-06 | Mock tests: a found product shows the attribution; an unknown code offers manual entry; the 16th lookup within 60 seconds is held back with a message. | unit; widget; integration | ADR-19, ADR-21 (proposed); INT-04; DAT-10 |

### 4.6 Parsing and resolution

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-21 | Parsing and resolution | The system shall send the normalised text to the AI model and accept a list of items, each with name, quantity, unit, grams or unknown, grams basis, packaged flag, confidence from 0 to 1, and flags. | Must | L | OBJ-01; OBJ-02; SCP-IN-02; PRB-01; TD-02; US-01, US-03 | On the SPK-01 set with 3 runs, at least 98% of responses pass schema validation; item recall and precision reach at least 0.90 overall and 0.85 on the dialect subset (proposed thresholds, ASM-31). | experiment SPK-01; unit | ADR-16, ADR-18 (proposed); INT-03 |
| FR-22 | Parsing and resolution | The system shall validate every AI response against the item schema, retry once when it is invalid, and then offer manual entry. | Must | M | TD-02; RSK-05; KC-02; US-23 | With a mock that returns an invalid response, exactly 1 retry occurs and manual entry is offered in 20 of 20 fault-injection cases, with 0 crashes. | unit; integration | FR-16 |
| FR-23 | Parsing and resolution | The system shall stop waiting for an AI response after 16 seconds and offer manual entry. | Must | S | OBJ-01; TD-02; ASM-48; US-23 | A mock that never answers produces the timeout message and the manual-entry option at 16 seconds, give or take 1 second, in 10 of 10 runs. | unit; widget | FR-16 |
| FR-24 | Parsing and resolution | The system shall treat meal text as data: when the text holds no food item or tries to instruct the model, the system shall save no item and show a refusal message with a reason code. | Must | M | TD-02; AI_CONTEXT; RSK-07; technical | In 15 scripted inputs (non-food text and instruction-like text, Arabic and English), 0 items are saved and 15 show a reason code. | unit; experiment SPK-01 | none |
| FR-25 | Parsing and resolution | The system shall resolve each item typed as text against reference data in this order and use the first match: the Egyptian dish table, the bundled USDA subset, then an AI estimate; for a scanned item it shall use the barcode result. | Must | L | OBJ-03; TD-01; GAP-02; GAP-08; US-01 | On the 40-name fixture of SPK-02 the layer chosen equals the expected layer in 100% of cases; dish hit within 3 candidates reaches 0.70 and ingredient hit within 3 reaches 0.90 (proposed, ASM-31). | unit; experiment SPK-02 | ADR-19 (proposed); FR-63; FR-65 |
| FR-26 | Parsing and resolution | When more than one reference match is plausible, the system shall show up to three candidates and let the user choose before saving. | Should | M | PRB-02; GAP-08; SPK-02; US-05 | For 10 ambiguous fixture names, 3 candidates are shown and the chosen one is stored in 10 of 10 runs. | widget; unit | FR-25 |
| FR-27 | Parsing and resolution | The system shall label any item whose values come from an AI estimate as 'AI estimate', show a value range, and never show a reference-source label on it. | Must | M | TD-02; AI_CONTEXT; RSK-07; OBJ-03; US-09, US-10 | For 20 items forced into the estimate layer, 100% show the label and a range and 0 show a reference-source label. | unit; widget | FR-25 |
| FR-28 | Parsing and resolution | The system shall show, beside the numbers of every item on the review screen and in history, the name of the reference source and a confidence label of high, medium or low. | Must | M | OBJ-03; HYP-03; HYP-04; GAP-02; PRB-03; US-09, US-11 | In the 30 reference meals, every displayed item has a source name and a confidence label: 0 missing. | widget; experiment SPK-03 | DAT-05 |
| FR-29 | Parsing and resolution | The system shall resolve Arabic dialect, Modern Standard Arabic and English names of a dish to the same reference row through an alias list. | Should | M | RSK-04; RSK-03; TD-01; TH-06; US-03, US-05 | On 20 dishes entered in the 3 name forms (60 inputs), at least 90% resolve to the same row (proposed, ASM-48). | unit | FR-63 |
| FR-30 | Parsing and resolution | The system shall read the AI model identifier from remote configuration, shall use a built-in identifier when the remote value is not on an allow-list, shall try a fallback identifier when the first fails, and shall offer manual entry when both fail. | Should | S | RSK-05; RSK-20; KC-02; ADR-17 | In a unit test, an unlisted remote value selects the built-in identifier and a failing first identifier selects the fallback in 10 of 10 runs; with both failing, manual entry is offered. | unit | ADR-17 (proposed); FR-16 |
| FR-31 | Parsing and resolution | The system shall limit each user to 30 analyses per day and shall show the remaining count when 5 or fewer remain. | Should | S | RSK-05; RSK-25; ASM-26; ASM-48 | In a test, the 31st analysis of the day is refused with a message and 0 AI requests are sent. | unit; widget | OPEN-76 |

### 4.7 Nutrition calculation

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-32 | Nutrition calculation | The system shall compute each item's energy, protein, carbohydrate and fat in application code as grams times the per-100 g reference values, and shall use no total or nutrient number written by the AI model. | Must | M | OBJ-02; OBJ-06; HYP-02; AI_CONTEXT; RSK-07; US-01, US-11 | All golden test cases match hand-calculated values within 0.5 kcal and 0.1 g; line coverage of the calculation layer is at least 80%. | unit | DAT-05 |
| FR-33 | Nutrition calculation | The system shall sum item values into meal totals and daily totals and recompute them whenever an item changes. | Must | S | SCP-IN-03; SCP-IN-05; US-17 | For 10 fixture days, totals equal the sums of the items; after an item edit, totals change with 0 network requests. | unit | FR-32 |
| FR-34 | Nutrition calculation | The system shall flag an item whose energy density or grams fall outside the limits set in the reference-data configuration. | Should | S | RSK-07; RSK-15; TD-02 | 10 out-of-range fixtures are flagged in 10 of 10 cases; 10 in-range fixtures are not flagged. | unit | ASM-48 |
| FR-35 | Nutrition calculation | The system shall show energy, protein, carbohydrate and fat only, and shall show no micronutrient value taken from an AI estimate. | Must | S | EVD-13; PRB-04; S-012; US-11 | A widget test finds no micronutrient field on any nutrition screen. | widget | none |

### 4.8 Correction

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-36 | Correction | The system shall let the user rename the matched food, change quantity, unit and grams, remove an item or add an item on the review screen and in a saved meal, and shall recompute the totals at once. | Must | M | PRB-04; RSK-04; HYP-04; OBJ-02; US-02, US-19 | After each of 4 edit types (rename, quantity, remove, add), totals update with 0 network requests and an edited item carries an 'edited' flag. | widget; unit | FR-33 |
| FR-37 | Correction | The system shall let the user delete a saved meal and shall remove it from history and from the cloud database. | Must | S | OBJ-05; legal; US-08 | After deletion on device A, the meal is gone from history on devices A and B within 30 seconds. | integration | FR-46 |
| FR-38 | Correction | The system shall let the user copy a saved meal to the current time with one action. | Should | S | PER-02; US-04 | The copy has the same items and a new time in 10 of 10 runs; the original stays unchanged. | widget | none |

### 4.9 Recipes and alternatives

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-39 | Recipes and alternatives | The system shall, on request, suggest recipes whose every ingredient passes the user's declared restrictions, and shall show for each recipe the ingredients and the per-serving energy and macronutrients computed by the nutrition calculation. | Must | L | SCP-IN-04; OBJ-04; GAP-04; Brief (AI recipes); US-12, US-15 | In 20 test cases covering each declared restriction, 0 recipes contain a violating ingredient (OBJ-04). | unit | OPEN-70; ADR-16, ADR-18 (proposed); DAT-08 |
| FR-40 | Recipes and alternatives | The system shall check every ingredient of a recipe or alternative against the restriction tags in the reference data and shall reject any suggestion with an ingredient that has a violating tag or no tag. | Must | M | OBJ-04; RSK-08; TD-02; US-12, US-13, US-15 | In 20 violating fixtures and 10 untagged-ingredient fixtures, 30 of 30 suggestions are rejected. | unit | DAT-09 |
| FR-41 | Recipes and alternatives | The system shall offer, for a logged item or a food name the user types, up to three alternatives from the same food group in the reference tables with at least 10% lower energy per serving, labelled 'lower-energy alternative', and shall show the numeric difference. | Must | M | SCP-IN-04; OBJ-04; Brief (healthier alternatives); ASM-52; US-13, US-15 | For 10 fixture items, each alternative is in the same group, is at least 10% lower in energy and passes the tag check; no label uses the word healthy. | unit; widget | FR-40; DAT-06 |

### 4.10 History and charts

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-42 | History and charts | The system shall show meal history as a grid of cards (GridView), newest first, each card showing date, time, meal energy and item count, loaded in pages of 20 meals. | Must | M | Brief (GridView); SCP-IN-05; RSK-21; US-17, US-19 | With 500 fixture meals, the first screen loads 20 meals (counted reads) and scrolling loads the next 20; a widget test finds the grid with its cards. | widget; integration | FR-46 |
| FR-43 | History and charts | The system shall show a bar chart of daily energy for the last 7 days. | Must | M | Brief (nutrition charts); SCP-IN-05; US-18 | For a 7-day fixture, each of the 7 bar values equals the daily total within rounding. | widget; unit | FR-33 |
| FR-44 | History and charts | The system shall show, when the user taps a day on the chart, an overlay layered over the chart (Stack) with that day's energy, protein, carbohydrate and fat. | Must | S | Brief (Stack); SCP-IN-05; US-18 | A widget test taps each of the 7 bars and finds the overlay with 4 values equal to that day's totals. | widget | FR-43 |
| FR-45 | History and charts | The system shall show the macronutrient split of the selected day. | Should | M | PER-02; SQ-17; US-20 | For 3 fixture days, the shares sum to 100% within 1 point and match the totals. | widget; unit | FR-43 |

### 4.11 Sync and offline

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-46 | Sync and offline | The system shall store each signed-in user's meals in Cloud Firestore so that a meal saved on one device appears on the user's other device within 30 seconds when both are online, and shall keep one meal holding the last edit when both devices edit it. | Must | L | Brief (Firestore sync); OBJ-05; SCP-IN-06; GAP-05; ASM-48; US-21 | In 20 runs on 2 devices, 100% of saved meals appear within 30 seconds; in 10 simultaneous edits, 10 of 10 end with one meal holding the last edit. | integration; experiment SPK-04 | INT-02; ADR-11, ADR-12 (proposed) |
| FR-47 | Sync and offline | The system shall let the user add, edit and delete meals while offline, show the changes in history at once, and send them when connectivity returns. | Must | L | OBJ-05; SPK-04; TD-03; KC-03; US-22 | In each SPK-04 scenario, 20 runs show 0 lost writes and the UI is never blocked for more than 300 ms by a write. | integration; experiment SPK-04 | FR-46 |
| FR-48 | Sync and offline | When the device is offline, the system shall state that analysis is unavailable and offer manual entry. | Must | S | OBJ-01; PRB-01; TD-02; US-22 | In airplane mode, sending a description shows the message and the manual-entry option in 10 of 10 runs, with 0 AI requests. | widget; integration | FR-16 |
| FR-49 | Sync and offline | The cloud database shall let a signed-in user read and write only the documents under that user's own path, and shall reject writes that do not match the meal schema. | Must | L | OBJ-05; RSK-16; SPK-05; technical; US-21 | At least 10 emulator cases pass in CI: other-user read, other-user write, no-sign-in read, no-sign-in write, wrong type, unknown field, oversize text, own read, own write, own delete. | integration | INT-02 |

### 4.12 Safety

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-50 | Safety | The system shall refuse requests for diagnosis, treatment, medication-dose advice or extreme diets, return a refusal reason code, and tell the user to consult a qualified professional. | Must | M | SCP-OUT-04; AI_CONTEXT; TD-02; RSK-08; US-28 | In 20 scripted prompts (10 Arabic, 10 English), 20 are refused and 0 replies contain a dose, a treatment instruction or a diet target; any failure blocks release. | unit; experiment SPK-01 | none |
| FR-51 | Safety | The system shall show an 'information only, not medical advice' notice on first launch, on every recipe and alternative screen, and on the About screen, in Arabic and English. | Must | S | SCP-OUT-04; AI_CONTEXT; RSK-08; US-27 | A widget test finds the notice in the 3 places in 2 languages (6 of 6). | widget | none |
| FR-52 | Safety | The system shall show the wording 'may contain allergens; check the label' near restriction-based results and shall use none of the banned terms in section 8.3. | Must | S | SCP-OUT-06; ASM-19; RSK-08; US-27 | A string scan of the app texts finds 0 banned terms; the allergen wording is present on the recipe and alternative screens. | unit; widget | none |
| FR-53 | Safety | The app texts, the store listing text and the demo script shall contain none of the claims listed in section 8.4. | Must | S | AI_CONTEXT; 02-COMPETITORS; US-37 | A script scans the app strings and a text copy of the store listing: 0 matches; the demo script is read against the section 8.4 checklist. | unit; manual | none |
| FR-54 | Safety | The system shall show a warning on a logged item whose reference tags violate a declared restriction. | Should | M | TD-02; RSK-08; PER-03; US-16 | For 20 fixture items, all violating items show the warning and 0 non-violating items show it. | unit; widget | DAT-09 |

### 4.13 Settings and about

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-55 | Settings and about | The system shall provide an About screen that lists each dataset used with name, licence, URL and retrieval date, and shows the Open Food Facts attribution. | Must | S | TD-05; OBJ-07; legal; US-36 | The About screen lists every dataset named in THIRD_PARTY_NOTICES; a test compares the two lists: 0 differences. | widget; unit | ADR-23 (proposed); NFR-12 |

### 4.14 Networking and device

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-56 | Networking and device | The system shall send every external HTTP request through one network client built with Dio and Interceptors. | Must | M | Brief (Dio, Interceptors); CON-07; TD-04; technical | A CI check finds 0 HTTP calls outside the client; each interceptor has at least 1 unit test with a mock adapter. | unit | ADR-21 (proposed) |
| FR-57 | Networking and device | The system shall send a custom User-Agent with app name, version and contact on every request to Open Food Facts. | Must | S | TD-01; CL-11; S-070; technical | A mock adapter sees the header on 100% of 20 recorded requests. | unit | ADR-21 (proposed); FR-56 |
| FR-58 | Networking and device | The system shall retry a failed GET request up to 2 times with exponential backoff and jitter on timeout, 429 and 5xx responses, and shall not retry other 4xx responses or any non-GET request. | Must | S | TD-04; RSK-05; ADR-21; technical | Mock sequences: timeout then success gives 1 retry; 429 twice then success gives 2 retries; 404 gives 0 retries; a failed POST gives 0 retries. | unit | FR-56 |
| FR-59 | Networking and device | The system shall write no token, key or meal text to logs. | Must | S | TD-04; SPK-05; OBJ-08; Brief (secure handling); technical | A scan of the logs of 50 requests finds 0 tokens, keys or meal-text strings. | unit; integration | FR-56 |
| FR-60 | Networking and device | The system shall map errors to messages in Arabic and English for these classes: offline, timeout, rate limit or quota exhausted, sign-in failure, attestation failure, invalid response and server error, and shall show no raw error text. | Must | S | TD-04; RSK-05; ADR-09; US-23 | 7 of 7 classes show their message in both languages; a widget test finds 0 raw exception strings. | unit; widget | FR-56; ADR-09 (proposed) |
| FR-61 | Networking and device | The system shall request a runtime permission only at the point of use, explain why before the request, and keep the app working when the permission is denied. | Must | S | Brief (runtime permissions); CON-07; TD-04; US-06 | On first launch 0 permission requests occur; with the camera denied, the log, history and chart flows work in 10 of 10 runs. | widget; integration | INT-06 |

### 4.15 States

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-62 | States | The system shall provide a loading state, an error state and an empty state on each of the log, review, history, chart and recipe screens. | Must | M | Brief (widget tests); SCP-IN-07; US-23 | 15 widget tests (5 screens times 3 states) pass; each error state offers a retry or manual-entry action. | widget | none |

### 4.16 Reference data

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-63 | Reference data | The system shall bundle an Egyptian dish table of at least 30 dishes, each row with ingredients and grams, per-100 g or per-serving values, household units with gram weights where known, restriction tags, a source ID, an edit date and a reviewer status. | Must | M | OBJ-03; TD-01; CON-05; 04-FEASIBILITY section 10; US-32 | The audit script reports at least 30 rows with 0 rows missing a source ID, tags or values. | unit; manual | OPEN-21; ASM-34 |
| FR-64 | Reference data | The system shall bundle an Egyptian dish table of 100 to 200 dishes, with at least 95% of rows carrying a source ID. | Should | S | OBJ-03; HYP-03; US-32 | The audit script reports 100 to 200 rows and at least 95% sourced; a manual spot check of 20 rows finds every value traceable to its source. | unit; manual | OPEN-21; FR-63 |
| FR-65 | Reference data | The system shall bundle per-100 g energy and macronutrient values from USDA FoodData Central for every ingredient used by a bundled dish. | Must | M | TD-01; OBJ-03; US-32 | The audit script finds 0 dish ingredients without a USDA row or a marked team value. | unit | ADR-13, ADR-19 (proposed); DAT-07 |
| FR-66 | Reference data | The repository shall include a script that checks the reference tables for missing source IDs, missing or out-of-range values and missing tags, prints the share of sourced rows, and exits with an error when a check fails. | Must | M | OBJ-03; US-32 | The script exits with an error on 5 seeded faulty files and succeeds on the clean files; CI runs it on every pull request. | unit | FR-63 |

### 4.17 Evaluation tooling

| ID | Module | Requirement | Priority | Effort | Source | Acceptance criterion | Verification | Depends on |
|---|---|---|---|---|---|---|---|---|
| FR-67 | Evaluation tooling | The repository shall include a repeatable run of the 30 reference meals through the pipeline that writes per-meal energy error, the mean absolute percentage error and the source layer of each item to a CSV file. | Must | M | OBJ-02; HYP-02; SPK-03; US-33 | Two runs with the same recorded AI responses produce byte-identical CSV files; the CSV has one row per meal and per item. | unit; integration | OPEN-21; DAT-12 |
| FR-68 | Evaluation tooling | The evaluation run shall also produce a direct AI estimate of the same 30 meals, in the evaluation tool only, and report the error difference between the two arms. | Should | M | HYP-03; SPK-03; US-33 | The second-arm CSV exists and the report states the difference in error points; the release build contains no direct-estimate code path. | unit; manual | FR-67; OPEN-74 |
| FR-69 | Evaluation tooling | Test builds shall write a local timing log of start of entry, start of analysis and result display for each meal, and release builds shall write none. | Must | S | OBJ-01; HYP-01; SPK-06; US-34 | A test build writes 3 timestamps per meal in 10 of 10 runs; a release build writes 0 records. | unit; manual | OPEN-74 |
| FR-70 | Evaluation tooling | Test builds shall let the tester hide the source labels, and release builds shall not offer this switch. | Should | S | HYP-04; US-35 | In a test build the labels are hidden when the switch is on; a widget test finds no switch in a release build. | widget | FR-28; OPEN-74 |

## 5. Non-functional requirements

Categories: performance, reliability and offline, security, privacy and legal, usability and accessibility, maintainability and testing, compatibility, cost and quotas, quality of results. Localisation is covered by the functional requirement for language (FR-13), because its tests are functional. Every threshold is copied from an `OBJ-` or `SPK-` pass value, or is a team proposal under `ASM-31` or `ASM-48`.

| ID | Category | Requirement | Priority | Source | Measurement method |
|---|---|---|---|---|---|
| NFR-01 | Performance | The system shall return the analysis result, from sending the text to showing the items, within 8 seconds for 90% of 100 test requests. | Must | OBJ-01; HYP-01; PRB-01 | Logged timings over Wi-Fi and mobile data on the mid-range device (SPK-06). |
| NFR-02 | Performance | The AI parse step shall take at most 4 seconds at the 90th percentile of the same 100 requests. | Should | TD-02; SPK-01; ASM-31 | Latency log of the parse step (SPK-01, SPK-06). |
| NFR-03 | Performance | Local actions (adding a manual item, editing an item, recomputing totals, opening a cached history page) shall respond within 300 ms on the mid-range test device. | Must | TD-03; SPK-04; KC-03 | Frame and handler timing in integration tests; 20 runs per action. |
| NFR-04 | Performance | With the device offline, a cold start shall show the last 7 days of meals within 1 second. | Should | SPK-04; TD-03 | Stopwatch or profiler on the low-RAM and mid-range devices; 20 runs. |
| NFR-05 | Reliability and offline | The system shall lose no write in 20 runs of each offline scenario of SPK-04. | Must | OBJ-05; SPK-04; KC-03; RSK-12 | SPK-04 result table: scenarios add, edit, delete, restart, reconnect, account switch, low RAM, cache eviction. |
| NFR-06 | Reliability and offline | Fifty queued writes shall reach the cloud database within 30 seconds after the device reconnects. | Must | SPK-04; KC-03; ASM-31 | Timed reconnect test, 20 runs. |
| NFR-07 | Reliability and offline | The app shall not crash in any of 20 fault-injection cases: timeout, invalid response, 429, quota exhausted and no network. | Must | RSK-05; RSK-12; TD-04 | Automated fault-injection suite with a mock network layer; crash count equals 0. |
| NFR-08 | Security | A release APK shall contain no secret (key, token or password). | Must | SPK-05; RSK-11; AI_CONTEXT; Brief (Android security basics) | Decompile the release APK and search for key patterns and URLs; secret count equals 0 (SPK-05). |
| NFR-09 | Security | A call to the AI endpoint without a valid attestation token shall be rejected. | Must | SPK-05; RSK-11; AI_CONTEXT | Replay a recorded request with curl and without the token (SPK-05); the endpoint rejects it. |
| NFR-10 | Security | All network traffic shall use encrypted connections, and cleartext traffic shall be disabled in the release build. | Must | Brief (Android security basics); CON-07; technical; OPEN-75 | Manifest and network-configuration check; intercepting proxy test shows 0 cleartext requests. |
| NFR-11 | Privacy and legal | Before any real-user test, the Arabic privacy notice, the consent screen and the delete-account path shall all be present, and the notice shall state the cloud region and AI processing location once they are known. | Must | OBJ-08; PRB-07; GT-04; OPEN-39 | OBJ-08 checklist review by two team members and the supervisor. |
| NFR-12 | Privacy and legal | A THIRD_PARTY_NOTICES file at the repository root shall list every dataset with licence and retrieval date, and CI shall fail when the file is missing. | Must | TD-05; RSK-18; RSK-22 | CI check for the file; manual comparison with the About screen. |
| NFR-13 | Usability | The System Usability Scale score shall be at least 68 with at least 5 users. | Should | HYP-04; ASM-03 | Usability test with the SUS questionnaire after a working prototype. |
| NFR-14 | Usability | The trust item (1 to 5) shall be at least 4.0 with source labels and higher than without them. | Should | HYP-04; ASM-13 | Same usability test, with and without labels (FR-70). |
| NFR-15 | Usability and accessibility | All screens shall stay readable at 200% system font scale, with no clipped text on the 5 key screens. | Should | PER-03; ASM-50 | Golden tests at text scale 2.0 for the log, review, history, chart and settings screens. |
| NFR-16 | Usability and accessibility | Interactive elements shall be at least 48 by 48 dp. | Should | PER-03; ASM-50 | Widget test of tap-target sizes on the 5 key screens. |
| NFR-17 | Maintainability and testing | Line coverage of the calculation layer shall be at least 80%. | Must | OBJ-06 | Coverage report in CI. |
| NFR-18 | Maintainability and testing | Every merge to the main branch shall come through a pull request with at least 1 review. | Must | OBJ-07; Brief (Git and GitHub) | Repository settings (branch protection) and the pull-request history. |
| NFR-19 | Maintainability and testing | The README and technical documentation shall cover how to build and run, architecture, data sources and licences, test commands, security notes and the task division. | Must | OBJ-07; Brief (documentation) | Checklist review against the 6 topics before release. |
| NFR-20 | Maintainability and testing | CI shall run analysis, formatting, tests with the coverage gate, the audit script, the rules tests, a secret scan and a dependency scan on every pull request, and a failing run shall block the merge. | Must | OBJ-05; OBJ-06; TD-04; ADR-27 | CI configuration review and a deliberately failing pull request that is blocked. |
| NFR-21 | Maintainability and testing | The repository shall hold unit tests for calculation, unit conversion and parsing validators, and widget tests for the log screen and the source labels, all passing in CI. | Must | Brief (unit and widget tests); SCP-IN-07; OBJ-06 | CI test report lists the 5 test groups with 0 failures. |
| NFR-22 | Maintainability and testing | The documentation shall contain the three personas, marked provisional or validated, and wireframes for the log, review, history, chart, recipe, settings and consent screens before each screen is built. | Must | Brief (design thinking, personas, wireframes); PER-01; PER-02; PER-03 | Document review: 3 personas and 7 wireframes present; wireframe dates precede the first commit of each screen. |
| NFR-23 | Maintainability and testing | Each pull request shall name the FR, NFR or US it implements, and each team member shall have merged work in each build phase. | Should | OBJ-07; CON-03; rubric (task division) | Pull-request template check and a per-member merge count per phase. |
| NFR-24 | Compatibility | The app shall run the core flows (enter, review, save, history) without a crash on the minimum Android version set in ADR-02 (default API 24) and on one mid-range and one low-RAM test device. | Must | CON-04; ASM-35; ADR-02; OPEN-27 | Scripted run of the 4 core flows, 10 runs per device. |
| NFR-25 | Compatibility | The release APK size and the memory in use at idle and during analysis shall be measured and reported. | Should | SPK-06; 04-FEASIBILITY section 10 | Build output and profiler readings recorded in the SPK-06 table; ADR-13 treats about 10 MB of bundled data and about 500 ms cold parse as its decision thresholds. |
| NFR-26 | Cost and quotas | Development and evaluation shall run at zero cloud spend, and any paid AI tier shall need a team decision with a budget alert. | Must | CON-01; RSK-25; TD-02 | Billing console shows 0 charges; decision recorded in the change log. |
| NFR-27 | Cost and quotas | Daily Firestore reads in the pilot shall stay at or below 50% of the free daily quota. | Should | RSK-21; ASM-37; TD-03 | Firebase console usage during the pilot. |
| NFR-28 | Cost and quotas | Peak daily AI requests shall stay at or below 80% of the free daily limit read from the AI provider's console. | Should | RSK-05; ASM-25; OPEN-38 | Request counts from the AI provider's console compared with the recorded limit. |
| NFR-29 | Quality of results | Calorie mean absolute percentage error shall be at most 20% on the 30 reference meals. | Must | OBJ-02; HYP-02; ASM-03 | The evaluation run (FR-67) against sourced reference values; report per-dish errors, not only the mean. |

## 6. Data requirements

Privacy by design: no field below holds a name, phone number, national ID, diagnosis, medication, age, weight or height. What stays on the device is listed in DAT-13. Real-user data goes to the AI model only after gate `GT-04` (`ASM-32`).

| ID | Entity | Fields that matter | Storage and sync | Retention and deletion |
|---|---|---|---|---|
| DAT-01 | User account | Pseudonymous user ID; sign-in credential held by the identity provider. Identity field list used by scans: name, phone number, national ID, email, device identifier. | Identity provider; the user ID is also the cloud path key. | Removed when the account is deleted (FR-11). |
| DAT-02 | Profile | Language; units; restriction tags; consent version. No age, weight, height, diagnosis or medication field. | Cloud, under the user's path; synced (ADR-12). A local copy of the restriction tags sits in Keystore-backed storage (ADR-14). | Removed with the account. |
| DAT-03 | Consent record | Notice version; time; choices for data processing, AI use and analytics. | Device, in Keystore-backed storage (ADR-14); the consent version also sits in the cloud profile (ADR-12). Whether time and choices are also kept in the cloud is part of the legal read (OPEN-72). | Kept until account deletion; a new record is written when the notice version changes. |
| DAT-04 | Meal | Client-generated meal ID; time; list of items; derived totals; created and updated times. The original typed text is not synced (ASM-51). | Cloud, under the user's path; synced; offline writes queued. | Kept until the user deletes the meal or the account; deletion also removes it from other devices. |
| DAT-05 | Meal item | Display name; quantity; unit; grams; grams basis; source layer; source ID and name; confidence label; flags; the per-100 g energy, protein, carbohydrate and fat used at save time; edited flag; default-portion flag. | Stored inside the meal. | As the meal. The stored per-100 g snapshot keeps old meals stable when a reference row changes. |
| DAT-06 | Reference dish | Dish ID; Arabic, Modern Standard Arabic and English names and aliases; food group; ingredients with grams; per-100 g or per-serving values; household units with grams; restriction tags; source ID; edit date; reviewer status (reviewed or unreviewed). | Bundled with the app; read-only at run time. | Changes only by a new release; the audit script runs on every change. |
| DAT-07 | Reference ingredient | USDA FoodData Central ID; names; per-100 g energy, protein, carbohydrate and fat; restriction tags; source ID; retrieval date. | Bundled; read-only. | As the dish table. |
| DAT-08 | Recipe | Recipe ID; title; ingredients as reference-ingredient IDs with grams; steps as text; servings; derived per-serving values; origin (bundled or AI-generated, OPEN-70); tag-check result. | Generated on request; not synced unless the user saves it (not in scope for this release). | Not stored in the cloud. |
| DAT-09 | Restriction tags | A tag on a row means the food is compatible with that restriction; a missing tag means unknown and counts as a violation. Initial list: vegetarian, lactose-free, gluten-free, low sugar, low salt (ASM-49, OPEN-69). The choice 'fasting periods' is kept as a preference and does not filter foods. | Bundled vocabulary; the user's choices live in the profile. | Vocabulary changes by release; choices removed with the profile. |
| DAT-10 | Barcode product result | Barcode digits; product name; per-100 g values; product page URL; retrieval date. No product images. | Device cache only; never synced; never merged into the bundled tables (ASM-36). | Cache entries expire after 30 days (ASM-48); cleared on sign-out. |
| DAT-11 | Sync state | Pending-write flag; last-update time; cache size setting. | Device (Firestore offline persistence). | Cache size is set explicitly; eviction must not remove unsynced writes (NFR-05). |
| DAT-12 | Evaluation fixtures | The 30 reference meals with description, items, portions, reference energy and macros and source; the 40-name set of SPK-02; the 20 restriction cases; the 15 injection inputs; the 20 refusal prompts. All synthetic; no user data. | Repository test folder. | Kept for the report; contains no personal data. |
| DAT-13 | Stays on the device | Consent record and restriction-tag copy (Keystore-backed); the Firebase session, which the app does not store itself (ADR-14); typed meal text before saving; timing logs of test builds; barcode cache; debug logs of test builds. | Never sent to the cloud, the AI model or a third party. | Tokens removed on sign-out; timing logs deleted after the evaluation; release builds keep no debug logs. |

## 7. External interfaces

Behaviour and failure handling only. Technology names appear where the brief mandates them or with the dependency shown in the last column.

| ID | Interface | Behaviour | Failure handling | Depends on |
|---|---|---|---|---|
| INT-01 | Identity provider | Creates accounts, signs users in, resets passwords and refreshes sessions. Returns a pseudonymous user ID. Needs no name, phone number or national ID. ADR-15 proposes email and password only; the provider keeps its own session (OPEN-59). | Offline: a signed-in user stays signed in with cached credentials. Expired credentials: the app asks the user to sign in again and keeps local data. Provider error: message from the error map; no data loss. | ADR-15 (proposed); OPEN-59 |
| INT-02 | Cloud database and sync (Cloud Firestore) | Stores meals and the profile under the user's path, with owner-only rules and schema checks; offline persistence queues writes and listeners update the UI. | Offline: writes queue and the UI never waits for the server. Quota exhausted: the app keeps working on the device and shows a banner. Rules denial: the write is dropped with a message and logged without data. | ADR-11, ADR-12 (proposed) |
| INT-03 | AI access | One request for parsing a meal text, one for an AI estimate of an unmatched item and one for recipe suggestions. Requests hold only the allowed fields (FR-10) and carry an attestation token. Responses are validated against a schema. | Invalid response: one retry, then manual entry. 429 or quota: message and manual entry. Timeout: after 16 seconds, manual entry. Missing or rejected token: message; no unauthenticated call. | ADR-16, ADR-17, ADR-18 (proposed) |
| INT-04 | Barcode data (Open Food Facts) | Looks up one product by barcode with a custom User-Agent, at most 15 lookups per minute per device, and shows attribution. Results are cached on the device and never merged into the bundled tables. | Not found: manual entry. Rate limit or error: message from the error map. Slow response: the retry rule applies. | ADR-19, ADR-21 (proposed) |
| INT-05 | Bundled reference data | The Egyptian dish table and the USDA subset ship inside the app and are read-only. The audit script runs before each release. | Corrupt or missing asset: the app shows an error state and offers no estimate-only fallback; the build fails the audit before release. | ADR-13, ADR-19 (proposed) |
| INT-06 | Device camera and runtime permission | The camera is used only for barcode scanning. The permission is requested when the scan starts, with a short explanation. | Denied: manual entry is offered. Denied with do-not-ask-again: a link to system settings is shown. No other feature depends on the camera. | ADR-20 (proposed); OPEN-60 |
| INT-07 | Android Keystore storage | Holds the consent record and the local copy of restriction tags (ADR-14). Holds no sign-in token and no API key. | Storage unavailable: the consent screen is shown again and nothing is written elsewhere. | ADR-14 (proposed) |
| INT-08 | Analytics and crash reporting (optional) | Not present in the MVP (ADR-24). If added later: off by default, and data is sent only after opt-in (TD-05 flow F5). | Opt-out: the sending stops at once and queued events are dropped. | ADR-24 (proposed); GT-04 |

## 8. Safety and content rules

These are testable requirements in table form. They apply `AI_CONTEXT.md` rules 1 to 3 and `SCP-OUT-04`, `SCP-OUT-06`. Nesba is an information tool and not a medical device.

### 8.1 Refusal behaviour

| Category | Trigger (examples) | Required behaviour | Requirement |
|---|---|---|---|
| Diagnosis | asks what condition the user has, or whether a food causes a disease | Refuse; give reason code DIAGNOSIS; point to a doctor or dietitian. | FR-50 |
| Treatment | asks how to treat a condition with food or supplements | Refuse; reason code TREATMENT; point to a professional. | FR-50 |
| Medication dose | asks about an insulin or other medicine dose, or about changing a dose | Refuse; reason code DOSE; no number in the reply. | FR-50 |
| Extreme diet | asks for a diet with a very low energy target or for fasting plans beyond general information | Refuse; reason code EXTREME_DIET; no target in the reply. | FR-50 |
| Allergen guarantee | asks whether a food is safe for an allergy | Do not guarantee; show 'may contain allergens; check the label'. | FR-52 |
| Non-food or instruction text | text without a food item, or text that tries to change the model's rules | Save no item; reason code NOT_FOOD or INSTRUCTION. | FR-24 |

A refusal always shows the reason code, a short explanation and a pointer to a qualified professional. Any failure in the 20-prompt test of FR-50 blocks release.

### 8.2 Disclaimers

| Where | English text | Requirement |
|---|---|---|
| First launch and About | Nesba gives general information about food. It is not medical advice and does not replace a doctor or dietitian. (Arabic wording: [T], written by the team) | FR-51 |
| Recipe and alternative screens | General information only. Ingredients may contain allergens; check the label. (Arabic wording: [T], written by the team) | FR-51; FR-52 |
| AI estimate item | AI estimate: values are a guess shown with a range, not taken from a table. (Arabic wording: [T], written by the team) | FR-27 |
| Barcode result | Product data from Open Food Facts (ODbL). Check the package. (Arabic wording: [T], written by the team) | FR-20; FR-55 |

### 8.3 Banned terms in app texts

The string scan of FR-52 fails on any of these terms (Arabic equivalents are added by the team): safe for allergy, allergy-safe, allergen-free guaranteed, cure, treat (a disease), diagnose, prescribe, clinical-grade, most accurate, medically proven.

### 8.4 Claims policy

The scan of FR-53 covers app strings, the store listing text and the demo script. The claims below must not appear (`02-COMPETITORS.md` section 2.6).

| Claim we must not make | Why |
|---|---|
| First Arabic or Egyptian AI food tracker | Competitors already use 'first' about themselves (S-021, S-026). |
| No solution exists for Arabic or Egyptian food logging | Arabic and Egyptian AI loggers exist, including on Google Play (S-044). |
| The only Arabic-first Android app | Sahnain and Miran are on Android (S-044, S-050). |
| Only app with Egyptian dishes, or only app with sources | Logma mentions citations and Kilo shows verified badges (S-027, S-043). |
| Most accurate, clinical-grade, or any accuracy number | Allowed only after OBJ-02 is measured, and then only with the method and the 30 meals. |
| Faster than competitors, or better than MyFitnessPal | Needs the timing test and a comparative test; none exists yet. |
| Any diagnosis, treatment, dose or allergen-safety claim | SCP-OUT-04 and SCP-OUT-06. |
| Any competitor price or feature that conflicts across sources | See 02-COMPETITORS.md section 2.6. |

### 8.5 Restriction filter rules

| Rule | Statement | Requirement |
|---|---|---|
| Rule 1 | A recipe or alternative is shown only if every ingredient has a tag for every restriction the user declared. | FR-40 |
| Rule 2 | An ingredient with no tag counts as unknown and rejects the suggestion. | FR-40 |
| Rule 3 | Tags come from the reference data, never from AI model opinion. | FR-40; DAT-09 |
| Rule 4 | An alternative must be in the same food group and at least 10% lower in energy per serving (ASM-52). | FR-41 |
| Rule 5 | A logged item that violates a declared restriction shows a warning; the warning never says the food is unsafe. | FR-54 |
| Rule 6 | The restriction list is fixed; free text for conditions or medication is not accepted. | FR-12 |

## 9. Evaluation requirements

What the product or the test tooling must provide so that `HYP-01` to `HYP-04` and the measurable `OBJ-` targets can be tested without tracking users.

| Target | What must be provided | Protocol | Requirements |
|---|---|---|---|
| HYP-01 | Same 10 meals logged by the same participants in free text and in manual search, timed; plus the 5-point would-keep-using item. | The test build writes the timing log; manual search (FR-16) is the baseline; stopwatch is the fallback. Participants are recruited and consented outside the app; no hidden tracking. | FR-69; FR-16; FR-15 |
| HYP-02 | The 30 reference meals through the grounded pipeline with a per-meal error table. | A repeatable run with recorded AI responses; reference values and portions from the source chosen in OPEN-21; report per-dish errors. | FR-67; NFR-29 |
| HYP-03 | The same 30 meals through a direct AI estimate (arm A) and the grounded pipeline (arm B); share of items with a source. | Evaluation tool only; three runs per arm; the release build has no direct-estimate path. | FR-68; FR-28 |
| HYP-04 | A test build that can hide the source labels; SUS and trust questions on paper or an outside form. | At least 5 users; with-labels and without-labels runs; no identity data stored with answers. | FR-70; NFR-13; NFR-14 |
| OBJ-01 | The same timing log and a set of 100 scripted analyses. | Wi-Fi and mobile data; p90 computed from the log. | FR-69; NFR-01 |
| OBJ-03 | The audit script output. | Run in CI and before the report; spot check of 20 rows. | FR-66; FR-63; FR-64 |
| OBJ-04 | The 20 restriction cases. | Unit tests with mocked AI output and the tag data. | FR-39; FR-40; FR-41 |
| OBJ-05 | The emulator rules suite of at least 10 cases. | Runs in CI on every pull request. | FR-49; NFR-20 |
| OBJ-06 | The coverage report for the calculation layer. | Runs in CI. | FR-32; NFR-17 |

### 9.1 Rules for every experiment

- No hidden tracking: timing and label experiments run in a test protocol with consenting participants, using test builds or a stopwatch; release builds write no timing log (FR-69).
- Test data is synthetic or consented. Real-user meal text goes to the AI model only after gate `GT-04` (`ASM-32`).
- Report per-dish errors and counts, not only means (`DISCOVERY.md` section 1.6). The sample is a convenience sample [A:ASM-11].
- `HYP-03` may end as "traceability gain, accuracy unchanged"; that still counts as support (`DISCOVERY.md` section 1.3).
- Every pass value that came from `04-FEASIBILITY.md` is a proposal until the team confirms it (`ASM-31`).

## 10. MoSCoW summary

### 10.1 Rules

| Priority | Rule |
|---|---|
| Must | Needed for a brief item, an `OBJ-`, or a legal or safety rule. Without it the demo fails or is unsafe or unlawful |
| Should | Important for a persona or for the differentiator (per-item source, restriction-aware suggestions, Egyptian dishes). Cut after Could |
| Could | Useful but first to cut |
| Won't (this release) | Out of scope; reuse `SCP-OUT-` and give a reason |

### 10.2 Counts

| Kind | Must | Should | Could | Total |
|---|---|---|---|---|
| Functional (FR) | 56 | 14 | 0 | 70 |
| Non-functional (NFR) | 19 | 10 | 0 | 29 |
| User stories (US) | 28 | 9 | 0 | 37 |

Functional effort (person-days, [A:ASM-47]): Must 50.0, Should 10.5, Could 0.0, total 60.5.

### 10.3 Lists

- **Must functional (56):** FR-01, FR-02, FR-03, FR-05, FR-06, FR-07, FR-08, FR-09, FR-10, FR-11, FR-12, FR-13, FR-15, FR-16, FR-17, FR-18, FR-19, FR-21, FR-22, FR-23, FR-24, FR-25, FR-27, FR-28, FR-32, FR-33, FR-35, FR-36, FR-37, FR-39, FR-40, FR-41, FR-42, FR-43, FR-44, FR-46, FR-47, FR-48, FR-49, FR-50, FR-51, FR-52, FR-53, FR-55, FR-56, FR-57, FR-58, FR-59, FR-60, FR-61, FR-62, FR-63, FR-65, FR-66, FR-67, FR-69.
- **Should functional (14):** FR-04, FR-14, FR-20, FR-26, FR-29, FR-30, FR-31, FR-34, FR-38, FR-45, FR-54, FR-64, FR-68, FR-70.
- **Could functional (0):** .
- **Must non-functional (19):** NFR-01, NFR-03, NFR-05, NFR-06, NFR-07, NFR-08, NFR-09, NFR-10, NFR-11, NFR-12, NFR-17, NFR-18, NFR-19, NFR-20, NFR-21, NFR-22, NFR-24, NFR-26, NFR-29.
- **Should non-functional (10):** NFR-02, NFR-04, NFR-13, NFR-14, NFR-15, NFR-16, NFR-23, NFR-25, NFR-27, NFR-28.
- **Must stories (28):** US-01, US-03, US-08, US-09, US-10, US-11, US-12, US-13, US-14, US-15, US-17, US-18, US-19, US-21, US-22, US-23, US-24, US-25, US-26, US-27, US-28, US-29, US-30, US-32, US-33, US-34, US-36, US-37.

**Won't (this release).**

| Item | Source | Reason |
|---|---|---|
| iOS | SCP-OUT-01 | Android first (`ASM-01`); `DR-03` cannot change this alone |
| Payments and subscriptions | SCP-OUT-02 | Zero budget; not needed for any `OBJ-` |
| Social features | SCP-OUT-03 | Not needed for any `OBJ-`; adds privacy risk |
| Diagnosis, treatment or dose advice | SCP-OUT-04 | Safety and law; refused by FR-50 |
| Food-photo recognition | SCP-OUT-05 | Out of scope; not needed for any `OBJ-`; text entry is the studied input |
| Allergen-safety guarantees | SCP-OUT-06 | Liability; wording rule in FR-52 |
| Voice entry | Maybe later (`DISCOVERY.md` section 1.5) | Becomes a candidate if `DR-04` fires |
| Local-only mode (no cloud sync) | Maybe later | Becomes a candidate if `DR-02` fires; it would not remove the AI transfer for parsing |
| Wearable integration | Maybe later | Not needed for any `OBJ-` |
| Storing product images from barcode results | TD-05 | Images are CC BY-SA; the app links and does not store them (DAT-10) |
| Optional daily energy number with a goal line, saved or favourite recipes, history date filter, 30-day chart | none (dropped for size) | Cut to stay within 70 functional requirements; first to add back if capacity allows |
| Free-text AI tips about a meal | ASM-55 | Medical-style advice risk; alternatives and recipes carry the brief item |
| Meal reminders by notification | ASM-53 | Only needed if barcode scanning is not the runtime-permission feature (`OPEN-60`) |

### 10.4 Capacity check

Capacity comes from `04-FEASIBILITY.md` TD-06: 5 people, 2 productive days per person per week [A:ASM-28], two scenarios because the end date is unknown (`OPEN-26`). Effort per requirement is S 0.5, M 1, L 2 person-days including its own tests [A:ASM-47].

**Calibration of the effort sizes.** Summing the functional efforts per work package and comparing with the TD-06 estimate:

| TD-06 work package | TD-06 days | Sum of FR effort here | Ratio |
|---|---|---|---|
| W2 Auth, Firestore model, rules and tests | 8 | 9.5 | 1.19 |
| W3 Core UI (GridView and Stack) | 10 | 13.0 | 1.30 |
| W4 AI pipeline and unit tests | 12 | 14.0 | 1.17 |
| W5 USDA subset bundle (and reference data code) | 3 | 3.5 | 1.17 |
| W7 Dio and interceptors | 4 | 3.0 | 0.75 |
| W8 Security (Keystore, permissions, App Check) | 5 | 3.0 | 0.60 |
| W11 Recipes and healthier alternatives | 12 | 4.0 | 0.33 |
| W12 Legal, consent, notices | 4 | 7.5 | 1.88 |

The totals agree (57.5 against 58), but the packages do not: recipes and alternatives (W11) cost 4.0 person-days here against 12 in TD-06, and consent, safety and notices (W12) cost more here than in TD-06. The recipe figure is the main uncertainty; the result below shows both cases.

**Work implied by non-functional requirements** (not inside any `FR-`, [A:ASM-47]):

| Work item | Person-days | Requirement |
|---|---|---|
| Repository setup and CI (W1 in TD-06) | 4.0 | NFR-20; NFR-18 |
| README and technical documentation | 2.0 | NFR-19 |
| Personas and wireframes for 7 screens | 2.0 | NFR-22 |
| THIRD_PARTY_NOTICES and CI check | 0.5 | NFR-12 |
| Encrypted-traffic configuration and check | 0.5 | NFR-10 |
| Device runs on the minimum Android version and 2 test devices | 1.0 | NFR-24 |

Total 10.0 person-days.

**Demand against the build budget.** Build budget = capacity minus spikes minus report and demo, using the sizes in TD-06 (reduced in scenario S).

|  | Scenario S (8 weeks) | Scenario L (14 weeks) |
|---|---|---|
| Capacity (person-days) | 80 | 140 |
| Spikes SPK-01 to SPK-06 | 8 | 12 |
| Report and demo | 8 | 10 |
| Build budget | 64 | 118 |
| Demand: Must functional | 50.0 | 50.0 |
| Demand: Should functional | 0 (none planned) | 10.5 |
| Demand: non-functional work | 10.0 | 10.0 |
| Demand: dish entries at 0.25 per dish | 30 dishes: 7.5 | 100 dishes: 25.0 |
| Total demand | 67.5 | 95.5 |
| Margin (budget minus demand) | -3.5 | 22.5 |

**Result.**

- **Scenario S does not fit.** (The budget here is capacity minus spikes minus report and demo, because the item list of scenario S in TD-06 adds to 81.5 person-days and not to "about 79"; see `OPEN-73`.) The Must set needs 67.5 person-days against a budget of 64, a shortfall of 3.5. If recipes and alternatives cost what TD-06 says (12 person-days instead of 4.0), the Must demand is 75.5, a shortfall of 11.5.
- **Scenario L fits.** Must plus Should needs 95.5 against 118, a margin of 22.5. If recipes cost 12 person-days, the margin is 14.5. Dishes beyond 100 cost 0.25 person-days each, so 150 dishes add 12.5.
- **What moves down in scenario S.** Moving FR-39, FR-40, FR-41 (recipes, tag check, alternatives) to Should frees 4.0 person-days and leaves demand at 63.5, a margin of 0.5. This follows the first two items of the TD-06 cut order. These three requirements trace to a brief item (AI-generated recipes and healthier alternatives), to `OBJ-04` and to differentiator 2 in `02-COMPETITORS.md` section 2.6. The change is therefore a decision for the team and the trainer (`OPEN-71`), not something this file does silently. Cutting other Must items frees little (each is 0.5 to 1 person-day) and removes safety, privacy or robustness cover tied to `RSK-15`, `RSK-16` and `RSK-01`.

### 10.5 Proposed cut order and MVP

Cut first to last. Items 1 to 14 are Should requirements; if more is needed, move FR-39, FR-40, FR-41 down as above; the brief-mandated chart, grid, sync, Dio, Keystore and runtime-permission requirements stay.

| Order | Requirement | Priority | Effort | Note |
|---|---|---|---|---|
| 1 | FR-45 (chart macro) | Should | M | Should |
| 2 | FR-38 (repeat meal) | Should | S | Should |
| 3 | FR-20 (barcode lookup) | Should | M | Should |
| 4 | FR-54 (item warning) | Should | M | Should |
| 5 | FR-34 (sanity) | Should | S | Should |
| 6 | FR-31 (ai cap) | Should | S | Should |
| 7 | FR-68 (eval direct) | Should | M | Should |
| 8 | FR-70 (label switch) | Should | S | Should |
| 9 | FR-26 (candidates) | Should | M | Should |
| 10 | FR-14 (units display) | Should | M | Should |
| 11 | FR-04 (password reset) | Should | S | Should |
| 12 | FR-29 (aliases) | Should | M | Should |
| 13 | FR-30 (model config) | Should | S | Should |
| 14 | FR-64 (dish target) | Should | S | Should |

**MVP** = all Must requirements (scenario L), or all Must minus FR-39, FR-40, FR-41 (scenario S, pending `OPEN-71`). **Later** = Should, Could and the Won't list.

## 11. Traceability

### 11.1 Brief item to requirements

| Brief item | Requirements | Priority |
|---|---|---|
| Flutter UI with GridView and Stack for meal history and nutrition charts | FR-42, FR-43, FR-44 | Must |
| Design-thinking process with personas and wireframes | NFR-22 | Must |
| Dio with Interceptors for external nutrition APIs, handled securely | FR-56, FR-57, FR-58, FR-59, FR-60, NFR-10, NFR-08, NFR-09 | Must |
| Cloud Firestore sync of meal logs across devices | FR-46, FR-47, FR-49, NFR-05, NFR-06 | Must |
| Unit and widget tests | NFR-21, NFR-17, NFR-20, FR-62 | Must |
| Git and GitHub with branches and pull requests | NFR-18, NFR-23 | Must and Should |
| Technical documentation and a detailed README | NFR-19 | Must |
| Android security basics (Keystore, runtime permissions) | FR-03, FR-61, FR-19, NFR-08 | Must |
| AI-generated nutrition advice, recipes and healthier alternatives | FR-39, FR-41, FR-40, FR-21 (advice read as in ASM-55, `OPEN-71`) | Must |
| Prompt-engineering integration: customised recipes by restriction, discovery of healthier snack alternatives | FR-39, FR-41, FR-12 | Must |

### 11.2 Objective to requirements

| Objective | Requirements citing it |
|---|---|
| OBJ-01 | FR-15, FR-17, FR-21, FR-23, FR-48, FR-69, NFR-01 |
| OBJ-02 | FR-18, FR-21, FR-32, FR-36, FR-67, NFR-29 |
| OBJ-03 | FR-25, FR-27, FR-28, FR-63, FR-64, FR-65, FR-66 |
| OBJ-04 | FR-12, FR-39, FR-40, FR-41 |
| OBJ-05 | FR-01, FR-05, FR-37, FR-46, FR-47, FR-49, NFR-05, NFR-20 |
| OBJ-06 | FR-32, NFR-17, NFR-20, NFR-21 |
| OBJ-07 | FR-55, NFR-18, NFR-19, NFR-23 |
| OBJ-08 | FR-02, FR-03, FR-06, FR-07, FR-08, FR-09, FR-11, FR-59, NFR-11 |

### 11.3 Problem cause to requirements

| Problem | Requirements |
|---|---|
| PRB-01 | FR-15, FR-21, FR-16, NFR-01 |
| PRB-02 | FR-25, FR-63, FR-29, FR-26, FR-16 |
| PRB-03 | FR-28, FR-27 |
| PRB-04 | FR-32, FR-35, FR-36, FR-27 |
| PRB-05 | NFR-24 (Android only; `SCP-OUT-01`; `DR-03`) |
| PRB-06 | FR-39, FR-40, FR-41, FR-12 |
| PRB-07 | FR-06, FR-07, FR-10, FR-11, NFR-11 |

### 11.4 Persona to stories

| Persona | Stories | IDs |
|---|---|---|
| PER-01 | 8 | US-01, US-02, US-09, US-10, US-12, US-17, US-18, US-22 |
| PER-02 | 9 | US-03, US-04, US-05, US-06, US-11, US-13, US-19, US-20, US-30 |
| PER-03 | 8 | US-07, US-14, US-15, US-16, US-27, US-28, US-29, US-31 |

### 11.5 High-scoring risks (score 15 or more) to mitigating requirements

| Risk | Score | Cause | Mitigating requirements |
|---|---|---|---|
| RSK-01 | 20 | PDPL cross-border transfer | FR-06, FR-07, FR-10, FR-11, NFR-11; the pilot data policy itself is gate `GT-04`, not a product requirement |
| RSK-02 | 16 | Free tier lets the provider use inputs | FR-10, FR-02, NFR-11; synthetic text rule in section 9.1 |
| RSK-03 | 16 | No verified Egyptian reference data | FR-63, FR-64, FR-66, FR-27, FR-67; reviewer status in DAT-06 |
| RSK-04 | 16 | AI misreads dishes or dialect | FR-21, FR-29, FR-26, FR-36, FR-18, FR-22 |
| RSK-05 | 16 | Quota cut, price rise or model retired | FR-22, FR-23, FR-16, FR-48, FR-31, FR-58, NFR-28 |
| RSK-06 | 16 | End date unknown, scope above capacity | No product requirement can mitigate it. Section 10.4 and 10.5 are the mitigation: MoSCoW, capacity check, cut order |
| RSK-07 | 15 | AI restates or invents numbers | FR-32, FR-27, FR-34, FR-35, FR-24 |
| RSK-08 | 15 | Unsafe suggestion for an allergy or condition | FR-40, FR-41, FR-54, FR-51, FR-52, FR-50 |

### 11.6 Rubric criterion to sections

| Criterion | Where |
|---|---|
| Content and organization (20) | Sections 1 to 13; stable IDs; AI NOTES; section 3 stories, section 11 traceability |
| Methods (20) | Verification column of sections 4 and 5; section 9 evaluation requirements; section 10.4 capacity check |
| Results (20) | Section 9 (how `HYP-01` to `HYP-04` are measured); section 12 (what changes if a decision rule fires); the `OBJ-` table in 11.2 |
| Task division (each member visible) | NFR-23 and NFR-18; section 10.4 effort sizes by module |
| Q&A | Section 13.3 lists requirements rejected and why; section 12.3 lists open decisions |

## 12. Conditional requirements and proposed target changes

### 12.1 What changes if a decision rule fires

Rules are from `03-USER-RESEARCH.md` section 3.6; results are not collected yet (`RT-05` is empty).

| Rule | Trigger | Effect on requirements |
|---|---|---|
| DR-01 | Fewer than 40% name time or effort as a main reason | No requirement is removed. Stories US-01 and US-03 are re-examined; FR-16 and FR-26 are candidates for earlier priority; the NFR-01 threshold may be revisited. |
| DR-02 | Mean concern about foreign servers above 4 of 5 | A local-only mode (now Won't) becomes a priority: a new requirement must be drafted and the capacity check redone. FR-01, FR-46 and FR-47 would become optional. The AI transfer for parsing would remain unless manual entry is the only path; FR-06 text changes. |
| DR-03 | Most respondents use iPhone | No requirement changes by itself: the sample is a convenience sample and `EVD-07` must be compared first (`03-USER-RESEARCH.md` section 3.6). `SCP-OUT-01` stays until the team decides. |
| DR-04 | Median willingness to type below 3 | FR-26 moves to Must; pick-list entry and voice entry (now Won't) are drafted; FR-16 gets a more prominent place in FR-15 flows. FR-15 stays. |
| DR-05 | Median source-label trust below 3 | The acceptance criterion of FR-28 changes from "shown beside the numbers" to "available with one tap on every item"; the label stays present. NFR-14 and `HYP-04` are re-read. |
| DR-06 | Fewer than 40% find Egyptian dishes hard | FR-64 moves to Could or is deleted and `OBJ-03` is lowered by the team; FR-63 may fall below 30 only with a team decision. |

### 12.2 Proposed target changes

Existing `OBJ-` and `HYP-` values are used in the requirements until the team decides. The table repeats `04-FEASIBILITY.md` section 10.

| Item | Existing | Proposed (04-FEASIBILITY) | Used in this file |
|---|---|---|---|
| Analysis time | `OBJ-01`: 8 s p90 | Keep 8 s; add parse p90 at most 4 s [A] | Existing value in NFR-01; proposal in NFR-02 (Should) |
| Accuracy | `HYP-02`: MAPE at most 20% | Keep; add "80% of meals within 25%" only after the SPK-03 baseline | Existing value only in NFR-29 |
| Dish count | `OBJ-03`: 100 to 200 dishes | Keep as Should or Could; floor of 30 dishes in scenario S | FR-63 (Must, 30) and FR-64 (Should, 100 to 200) |
| Test set | 30 reference meals | Keep 30; SPK-02 uses 40 names | FR-67 (30 meals); FR-25 (40 names) |
| App size | none | Candidate under 50 MB; measure first | NFR-25 reports the figure; no threshold |
| Memory | none | Candidate under 200 MB; measure first | NFR-25 reports the figure; no threshold |

### 12.3 Decisions requested from the team

| Decision | Why it matters | Open item | Default used here |
|---|---|---|---|
| Which feature carries the brief's runtime-permission item | `DISCOVERY.md` section 1.5 lists barcode scanning under "Maybe later", and ADR-20 is conditional on it; the brief still needs a runtime permission | OPEN-60 | FR-19 is Must (permission flow), FR-20 is Should; alternative: another feature that needs a permission |
| Brief items versus the TD-06 cut order | The brief requires AI recipes, healthier alternatives and charts; the TD-06 cut list drops recipes, alternatives and analytics screens first | OPEN-71 | Recipes, alternatives and one chart are Must; section 10.4 shows the scenario S shortfall |
| Meaning of "AI-generated nutrition advice" | Medical-style advice is out of scope (`SCP-OUT-04`) and numbers come from code | OPEN-71 | Read as sourced alternatives and recipes (`ASM-55`) |
| Where recipes come from | Bundled recipes or AI-generated recipes; both must pass the same tag check | OPEN-70 | FR-39 is written to hold for both (`ASM-54`) |
| Sign-in method and its quotas | ADR-15 proposes email and password only; Authentication quotas were not read | OPEN-59 | Email and password (ADR-15); FR-04 added because of it |
| Household units and default portions: source and values | Needed for FR-14 and FR-18 | OPEN-68 | Units come from the dish table where known |
| Initial restriction list and who reviews the tags | Needed for FR-12 and DAT-09 | OPEN-69 | List from `SQ-18` options (`ASM-49`) |
| Consent record: what sits in the cloud | ADR-12 keeps the consent version in the cloud profile and ADR-14 keeps the record on the device; the legal read confirms this split | OPEN-72 | Version in the cloud profile, full record on the device |
| Arithmetic of scenario S in TD-06 | The listed items add to 81.5 person-days, not "about 79", against a capacity of 80 | OPEN-73 | This file uses the listed items |
| Test builds versus release builds | No ADR says how evaluation tools (FR-69, FR-70, FR-68) are kept out of release builds | OPEN-74 | Written as test-build-only requirements; mechanism open |
| Cleartext traffic block | The encrypted-traffic requirement (NFR-10) has no ADR; the Android default for the target API was not read | OPEN-75 | Explicit network-security configuration in the build |
| Where the daily analysis limit is enforced | FR-31 needs a counter on the device or on a server; no ADR decides | OPEN-76 | Device-side counter |
| State-management library | ADR-06 chooses Bloc (`flutter_bloc`) at the project author's request; no requirement names a library | ADR-06 | Not named in any requirement |

## 13. Quality audit

### 13.1 Self-check results

| Check | Result | Status |
|---|---|---|
| Size limits | FR 70 of 70; NFR 29 of 30; US 37 of 45 | Pass |
| Every FR has source, priority, acceptance criterion and verification | 70 of 70 complete | Pass |
| Every brief item has a Must requirement | 10 of 10 rows in section 11.1 | Pass |
| Every OBJ- has a requirement | OBJ-01: 7, OBJ-02: 6, OBJ-03: 7, OBJ-04: 4, OBJ-05: 8, OBJ-06: 4, OBJ-07: 4, OBJ-08: 9 | Pass |
| Every persona has at least 6 stories | PER-01: 8, PER-02: 9, PER-03: 8 | Pass |
| Every Must FR has a story or is marked technical or legal | 0 Must FR without either | Pass |
| Every RSK- with score 15 or more has a mitigating requirement or a stated reason | 8 risks in section 11.5 (RSK-06 has a stated reason) | Pass |
| Every PRB- is addressed | 7 of 7 rows in section 11.3 | Pass |
| At least 80% of Must FR verifiable by automated tests | 56 of 56 (100%) | Pass |
| No vague words in FR or NFR text | 0 hits | Pass |
| No library or vendor names except where the brief mandates them | 0 hits | Pass |
| Nothing contradicts SCP-OUT- or AI_CONTEXT rules | Read against rules 1 to 7 and SCP-OUT-01 to SCP-OUT-06. One tension with the "Maybe later" list (barcode scanning) is raised in section 12.3 | Pass |

### 13.2 INVEST check of the stories

| Criterion | Finding |
|---|---|
| Independent | Some stories depend on others: US-18 on US-17, US-13 and US-15 on the tag check, US-21 on sign-in. Kept as an ordered backlog. |
| Negotiable | Stories state the need; acceptance detail sits in the requirements. |
| Valuable | Team-tooling stories (US-32, US-33, US-34, US-35, US-37) serve the evaluator, not an end user. Kept because they carry the evidence for `OBJ-02`, `OBJ-03`, `OBJ-01`, `HYP-04` and the claims policy. |
| Estimable | Each story links to requirements with S, M or L sizes. US-12 is the least certain (section 10.4). |
| Small | US-21, US-23, US-24 and US-22 span several requirements; split them by requirement at sprint planning. |
| Testable | Every Must story has 2 Given/When/Then lines (section 3.8). |

### 13.3 Requirements rejected as vague, duplicate or out of scope

| Candidate requirement | Why rejected |
|---|---|
| The app shall be fast | Vague; replaced by NFR-01 and NFR-03 |
| The interface shall be intuitive and user-friendly | Vague; replaced by NFR-13, NFR-15 and NFR-16 |
| The system shall offer voice entry | Maybe later; becomes a candidate only if `DR-04` fires |
| The system shall calculate a personal calorie target | Conflicts with `SCP-OUT-04` and `AI_CONTEXT` rule 2; no requirement lets the app compute or suggest a target |
| The system shall guarantee that a food is safe for an allergy | Conflicts with `SCP-OUT-06`; replaced by FR-52 |
| The system shall show the AI model's own calorie total | Conflicts with `AI_CONTEXT` rule 3; FR-32 computes in code |
| The system shall store the original meal text in the cloud | Data minimisation (`ASM-51`); only items are synced |
| The system shall support iOS | `SCP-OUT-01` |
| The system shall cache AI results of identical text | Design detail and an optimisation of FR-31; revisit in step 6 |
| The system shall normalise digits and diacritics before analysis | Design detail of the `TD-02` chain; FR-15 already accepts both digit forms |
| The system shall let the user withdraw consent in settings | Duplicate in effect of FR-11; add if `OPEN-20` says the law applies |
| The system shall show a sync status on each meal | Nice to have; dropped to stay within 70 functional requirements |
| The system shall filter history by date and show a 30-day chart | Dropped for size; listed as Won't |
