# 14. Deliverable-to-Source Traceability Matrix

> Required by GitHub issue #2: *"Add a deliverable-to-source/unknown mapping for every item in the Phase 4 brief, noting older-PDF conflicts where applicable."*
> Source labels S1–S6 are defined in `00-README.md`.

---

## 14.1 Coverage of the trainer's brief

Every one of the 17 line items in §4 of the *Project Documentation Guidelines* (S4), with where its content came from and what is unresolved.

### §4.1 — Problem Statement & Objectives

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 1 | Problem Statement & Objectives | `01` §1.1–1.2 | S1 §1 (overview, objectives, scope) | OI-03 cross-platform wording |
| 2 | Use Case Diagram & Descriptions | `02` §2.2–2.3 | S3 §3 (UC-01…UC-03) `[E]`; UC-04…UC-09 `[P]` derived from FRs and S5 | OI-04 (UC-08), OI-06 |
| 3 | Functional & Non-Functional Requirements | `03` §3.3–3.4 | S3 §4 (FR-01…FR-15) `[E]`; S3 §5 NFRs `[E]` with `[P]` identifiers | FR-16…FR-19 and NFR-13 are `[P]`; OI-07 |
| 4 | Software Architecture | `04` | Team decision (Bloc/Cubit, MVVM); NFR-10, NFR-11, NFR-12; S5 module split | Entirely `[P]` |

### §4.2 — Database Design & Data Modeling

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 5 | ER Diagram | `05` §5.3 | Derived from FR-01…FR-10, US-01…US-07, S5 module descriptions | **Entirely `[P]`** — no entity is defined in any source |
| 6 | Logical & Physical Schema | `05` §5.4–5.6 | Same derivation; Firestore mandated by S1 OBJ-07, S3 FR-10 | `[P]`; OI-04 removes `FOOD_REFERENCE`; **C-04 rubric conflict** |

### §4.3 — Data Flow & System Behaviour

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 7 | DFD — context and detailed | `06` §6.1–6.2 | Derived from UC-01…UC-03 and the integration set | `[P]`; USDA flows `[U]` |
| 8 | Sequence Diagrams | `06` §6.3 | UC-01, UC-02, UC-03 main flows `[E: S3]`; layer names from `04` `[P]` | Depends on P-01 |
| 9 | Activity Diagram | `06` §6.4 | UC-01 flow plus decision points from FR-11, FR-14, FR-15 | `[P]` |
| 10 | State Diagram | `06` §6.5 | **No state model exists in any source.** Every state derived from a cited requirement | **Entirely `[P]`** — table in `06` §6.5 |
| 11 | Class Diagram | `07` | Entities from `05`; layer classes from `04`; grounding table `07` §7.5 | `[P]`; depends on P-05 |

### §4.4 — UI/UX Design & Prototyping

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 12 | Wireframes & Mockups | `08` §8.4 | Screen names and features from S5 `[E]`; four more screens from team decision | Layouts `[P]`; OI-09, OI-10 |
| 13 | UI/UX Guidelines | `08` §8.5 | Material 3 per issue #1; dark/light tokens from S5; NFR-06, NFR-07, NFR-13 | Palette and typography `[P]`; OI-09 |

### §4.5 — System Deployment & Integration

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 14 | Technology Stack | `09` §9.1 | Flutter, Dio, Firestore `[E: S1, S2, S3]`; Gemini and Auth from team decision | Package versions `[P]`; USDA `[U]` |
| 15 | Deployment Diagram | `09` §9.3 | Android target from team decision; services from §9.1 | `[P]`; region A-03 **irreversible** |
| 16 | Component Diagram | `09` §9.2 | Architecture from `04`; module split from S5 | `[P]` |

### §4.6 — Additional Deliverables

| # | Brief item | Delivered in | Grounded in | Unknowns |
|---|-----------|--------------|-------------|----------|
| 17a | API Documentation | `10` | Gemini endpoint verified against vendor docs 2026-11-04; USDA `[U]` | OI-04; model identifier `10` §10.6 |
| 17b | Testing & Validation | `11` | OBJ-10 `[E: S1]`; S5 Bassam's QA role; KPI-04 | Coverage targets `[P]` |
| 17c | Deployment Strategy | `12` | Trainer brief §5.2 (version control, branching, CI/CD) | `[P]`; OI-07 changes §12.2 |

**All 17 items are addressed. None is marked N/A.**

---

## 14.2 Requirement coverage audit

| Requirement | Use case | Data model | Behaviour | Class | UI | Test |
|-------------|:--------:|:----------:|:---------:|:-----:|:--:|:----:|
| FR-01 | UC-01 | `MEAL` | DFD, Seq, Act | `Meal` | §8.4.2 | ✓ |
| FR-02 | UC-01 | `MEAL_ANALYSIS` | Seq 6.3.1, State | `GeminiDataSource` | §8.4.2 | ✓ |
| FR-03 | UC-01 | `MEAL_ANALYSIS` | Seq 6.3.1 | `MealAnalysis` | §8.4.3 | ✓ |
| FR-04 | UC-02 | `SAVED_RECIPE` | Seq 6.3.2 | `Recipe` | §8.4.4 | ✓ |
| FR-05 | UC-02, 05, 06 | `DIETARY_PROFILE` | Seq 6.3.2 | `PromptBuilder` | §8.4.4 | ✓ |
| FR-06 | UC-02, UC-06 | `SAVED_ALTERNATIVE` | DFD 6.2 | `SavedAlternative` | §8.4.5 | ✓ |
| FR-07 | UC-09, UC-03 | `MEAL` | Seq 6.3.3, State | `MealRepository` | §8.4.3 | ✓ |
| FR-08 | UC-03 | `MEAL` | Seq 6.3.3 | `HistoryCubit` | §8.4.6 | ✓ |
| FR-09 | UC-07 | `DAILY_SUMMARY` | DFD 6.2 | `NutritionCalculator` | §8.4.1 | ✓ |
| FR-10 | UC-03 | all collections | Seq 6.3.3, State | `FirestoreDataSource` | §8.4.6 | ✓ |
| FR-11 | UC-01, 02, 08 | — | Act 6.4 | `Failure` | all error states | ✓ |
| FR-12 | cross-cutting | — | Seq 6.3.1 | `DioClient` | — | ✓ |
| FR-13 | cross-cutting | — | — | design system | §8.5.3 | ✓ |
| FR-14 | UC-01 | — | Act 6.4, State | `MealAnalysisCubit` | §8.4.2 | ✓ |
| FR-15 | cross-cutting | — | Act 6.4 | `*State` | §8.5.6 | ✓ |
| FR-16…19 `[P]` | UC-04 | `USER` | DFD 6.2 | `AuthDataSource` | §8.4.7 | ✓ |
| NFR-01 | — | — | — | `equatable` states | §8.5.3 | ✓ |
| NFR-02 | — | — | — | `DioClient` | §8.5.6 | ✓ |
| NFR-03 | — | — | — | `AuthInterceptor` | — | ⚠ **OI-07** |
| NFR-04 | — | — | — | `DioClient` | — | ✓ |
| NFR-05 | — | §5.5.5 rules | — | — | — | ✓ |
| NFR-06 | — | — | — | — | §8.5 | UAT |
| NFR-07 | — | — | — | — | §8.4.1 | UAT |
| NFR-08 | UC-03 A1 | `sync_status` | State 6.5 | `Failure` | §8.5.6 | ✓ |
| NFR-09 | UC-03 | `sync_status` | Seq 6.3.3 | `SyncFailure` | §8.4.6 | ✓ |
| NFR-10 | — | — | — | `04` §4.2 | — | review |
| NFR-11 | — | — | — | `04` §4.3 | — | lint |
| NFR-12 | — | — | — | repository pattern | — | review |
| NFR-13 `[P]` | — | `User.locale` | — | — | §8.5.4 | ✓ |

**Every requirement appears in at least one design artefact and has a verification method.** NFR-03 is the single partial, and the reason is documented rather than concealed.

---

## 14.3 Issue coverage

| Issue | Title | Delivered in | Status |
|-------|-------|--------------|--------|
| #2 | Problem, objectives, scope, evidence baseline | `01`, `13`, `14` | Draft complete — awaiting cross-review |
| #3 | Requirements, actors, use cases | `02`, `03` | Draft complete |
| #4 | Architecture, stack, deployment boundaries | `04`, `09` | Draft complete |
| #5 | Conceptual data model and Firestore schema | `05` | Draft complete |
| #6 | Data flows and key interactions | `06` | Draft complete |
| #7 | Requirement-grounded class diagram | `07` | Draft complete |
| #8 | UI/UX guidelines, wireframes, prototype handoff | `08` | Draft complete |
| #9 | APIs, validation plan, deployment strategy | `10`, `11`, `12` | Draft complete |
| #10 | Integrate and quality-check the package | `00`, `13`, `14` | Cross-review outstanding |

---

## 14.4 Issue #2 acceptance criteria

| Criterion | Where satisfied |
|-----------|-----------------|
| Concise problem/objectives/scope section grounded in discovery IDs and linked sources | `01` — every claim cites S1–S6 and uses US/UC/FR/NFR identifiers |
| Identify unverified assumptions, proposed decisions and open items as such; do not convert them into facts | `13` §13.1–13.3 — 11 open items, 5 assumptions, 20 proposed decisions; `[E]`/`[P]`/`[U]`/`[O]` tags throughout |
| Deliverable-to-source/unknown mapping for every item in the Phase 4 brief, noting older-PDF conflicts | `14` §14.1 — all 17 items; conflicts in `13` §13.4 |
| Confirm boundary: mobile app plus documented external dependencies; no admin portal or unapproved platform expansion | `00` "System boundary"; `01` §1.3.2; `09` §9.3 |
| Obtain cross-review from BassamEmad39 and record corrections | `13` §13.6 — log table ready, **review not yet performed** |

**Four of five criteria are met by this draft. The fifth requires Bassam.**

---

## 14.5 Package statistics

| Metric | Count |
|--------|-------|
| Documents | 15 |
| Brief items covered | 17 of 17 |
| Mermaid diagrams | 20 (all render-verified) |
| Wireframes | 9 screens |
| Requirements traced | FR-01…FR-19, NFR-01…NFR-13 |
| Use cases | 9 (3 evidence-based, 6 proposed) |
| Open items | 11 |
| Unverified assumptions | 5 |
| Proposed decisions | 20 |
| Source conflicts recorded | 8 |
