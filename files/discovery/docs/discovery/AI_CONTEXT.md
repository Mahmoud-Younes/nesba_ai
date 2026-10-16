---
id: DISC-01-AI
title: Nesba Discovery, AI context (one page for coding assistants)
parent: DISC-01
status: draft
last_verified: 2026-10-11
owner: TBD
---

> **AI NOTES**
> - Read this file first. Then open only the file named in "Where to look". Do not load all thirteen files at once.
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U] and [T] as unknown, never as facts. Nothing below is approved by the team unless a row says so. Numeric targets are team assumptions.
> - This file only summarises. If it disagrees with a detailed file, the detailed file wins; report the difference.

# AI context: Nesba (نسبة)

Hub: [DISCOVERY.md](DISCOVERY.md). Nesba is the team's chosen name; NutriVision is only the course-brief title (`NAMING.md` §12).

## What the product is

An Android-first Flutter app for Arabic-speaking adults in Egypt. The user describes a meal in their own words (Arabic or English). AI splits it into items. Nutrition is computed in code from reference data. Every number shows its source. Recipes and healthier alternatives respect declared general restrictions. Meals sync across devices. It is an information tool, not a medical device. Team of five students, zero budget.

## Rules for any text or code you generate

1. Never claim: first Arabic AI food tracker; no solution exists; most accurate; only app with per-item sources; any medical benefit. Full list: `02-COMPETITORS.md` §2.6.
2. No diagnosis, treatment or medication-dose advice. No allergen-safety guarantees (`SCP-OUT-04`, `SCP-OUT-06`).
3. Numbers come from code. The AI model returns structured items only and never restates computed totals (`04-FEASIBILITY.md` TD-02).
4. No secret in the APK. AI calls go through a path protected by App Check or a proxy (`SPK-05`).
5. Send no names, emails or other identity to an AI model. Use synthetic data or consented text only until gate `GT-04` is passed (`ASM-32`).
6. Do not mention the app name in survey or consent texts. They are unbranded on purpose.
7. Do not invent data. Survey, interview and test result cells are `[T]` until the team fills them.

## Current plan: proposed in `04-FEASIBILITY.md`, pending team approval

Overall: **Conditional Go**. Model names, prices and quotas change fast; re-check the official pages before coding.

| Layer | Proposed decision | Gate | ADR |
|---|---|---|---|
| Parse | A Gemini Flash-Lite model through Firebase AI Logic with App Check (free tier for development); a larger model as quality fallback | `GT-02` | ADR-16, ADR-17, ADR-18 |
| Resolve | 1) team Egyptian dish table 2) bundled USDA subset (CC0) 3) Open Food Facts by barcode 4) model estimate flagged `AI_ESTIMATE` | `GT-03` | ADR-19, ADR-13 |
| Compute | Dart code, unit-tested | `GT-03` | ADR-05, ADR-09 |
| Sync | Firestore offline persistence. Listen to snapshots. Never `await` an offline write in the UI path | `GT-01` | ADR-11, ADR-12 |
| Networking | Dio with interceptors: User-Agent, App Check token, retry, cache, redacted logs, error mapping | `GT-01` | ADR-21, ADR-22 |
| State and UI | `flutter_bloc` (Bloc and Cubit), `go_router`, `material_ui`; hand-written models, no code generation | `GT-01` | ADR-04, ADR-06, ADR-07, ADR-08 |
| Legal | Restricted pilot until the pilot data policy is approved | `GT-04` | ADR-23, ADR-24 |
| Not used | Edamam, CalorieNinjas/API Ninjas, Spoonacular, DietlyAPI as a dependency | none | `06-DECISIONS.md` §4 |

Decisions are written as `ADR-` records and the packages as `DEP-` rows in `06-DECISIONS.md`; all ADRs are `Proposed` until the team approves them.

Proposed dates for the gates (`GT-01` 2026-10-22 to `GT-05` 2026-11-12) are `[A]` and depend on `OPEN-26`.

## Objectives and scope in one place

| ID | Target (all `[A:ASM-03]`) |
|---|---|
| `OBJ-01` | Analysis p90 ≤ 8 s over 100 test requests |
| `OBJ-02` | Calorie MAPE ≤ 20% on 30 reference Egyptian meals |
| `OBJ-03` | 100–200 sourced Egyptian dishes, ≥ 95% rows sourced |
| `OBJ-04` | 0 restriction violations in 20 recipe tests |
| `OBJ-05` | Firestore rules: all cross-user tests pass (≥ 10 cases) |
| `OBJ-06` | ≥ 80% line coverage of the calculation layer |
| `OBJ-07` | Every merge through a reviewed pull request; README and technical docs |
| `OBJ-08` | Arabic privacy notice, consent screen, delete-account path before any real-user test |

In scope: `SCP-IN-01` to `SCP-IN-07` (Android, free-text entry, per-item source label, recipes and alternatives, history and charts, sign-in and sync, tests and docs). Out: iOS, payments, social, medical advice, photo recognition, allergen guarantees.

## Decisions and inputs the team still owes

| Item | Where |
|---|---|
| Approve or change the proposed stack and the spike thresholds | `04-FEASIBILITY.md` §7, `ASM-31` |
| Project end date and phase dates | `OPEN-26` |
| Minimum Android version | `OPEN-27` |
| Owners of the documents; trainer contact | `OPEN-28` |
| Trainer approval of the rename; name checks | `OPEN-52` to `OPEN-56` |
| Legal read on pilot data and open-data terms | `OPEN-40` |
| Source and reviewer for the Egyptian dish values | `OPEN-21`, `ASM-34` |
| Survey tool, storage, deletion date, team contact in the consent text | `OPEN-24`, `03-USER-RESEARCH.md` §3.3 |

## Where to look

| Need | File and section |
|---|---|
| Problem, objectives, scope, traceability | `DISCOVERY.md` §1 |
| Competitors, gaps, positioning, hands-on test | `02-COMPETITORS.md` |
| Survey, interviews, personas | `03-USER-RESEARCH.md`; Arabic survey `03a-SURVEY-AR.md` |
| Technology choices, experiments, risks, gates | `04-FEASIBILITY.md` |
| Requirements: user stories, `FR-`, `NFR-`, data, interfaces, MoSCoW, traceability | `05-REQUIREMENTS.md` |
| Platform and technology decisions, dependency register | `06-DECISIONS.md` |
| Method, calendar, sprints, roles, deliverables, Git workflow | `07-WORKPLAN.md` |
| Name, taglines, package id | `NAMING.md` §8.2 and §12 |
| Assumptions and hypotheses | `A-ASSUMPTIONS.md` |
| Sources | `B-SOURCES.md` |
| Unverified items and questions | `C-OPEN-ITEMS.md` |

Requirement IDs: `US-` user stories, `FR-` functional, `NFR-` non-functional, `DAT-` data, `INT-` interfaces (`05-REQUIREMENTS.md`). Cite them in branches, commits and pull requests. All priorities and thresholds are proposed, not approved.

Work-plan IDs: `SPR-` sprints, `ROL-` roles, `GIT-` Git rules, `DEL-` deliverables (`07-WORKPLAN.md`). Branches use `type/ID-name`, commits follow Conventional Commits, and every pull request names its requirement IDs and discloses AI assistance (`GIT-02`, `GIT-03`, `GIT-05`).

## Checks

Run `python3 tools/check_discovery.py docs/discovery` after editing any file here. It must end with "no structural problems found".

## Snippet for the repository's agent instruction file (AGENTS.md or CLAUDE.md)

> Before working on requirements, UX or features, read `docs/discovery/AI_CONTEXT.md`. Items tagged `[U]` or `[T]` are unknown. Never claim Nesba is the first Arabic AI food tracker, and never give medical advice. Numbers shown to users come from code, not from model text. Run `python3 tools/check_discovery.py docs/discovery` after editing the discovery files.
