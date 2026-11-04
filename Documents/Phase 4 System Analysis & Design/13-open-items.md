# 13. Assumptions, Open Items & Conflicts

> Required by GitHub issue #2: *"Identify unverified assumptions, proposed decisions, and open items as such; do not convert them into facts."*
> This is the register the cross-reviewer and the team leader should read first.

---

## 13.1 Open items

Ordered by impact. Each names what breaks if it is answered differently.

| ID | Item | Severity | Blocks | Owner |
|----|------|----------|--------|-------|
| **OI-04** | Is **USDA FoodData Central** the nutrition data source, or does all nutrition come from Gemini? | 🔴 High | UC-08, `FOOD_REFERENCE`, `foodCache`, `NutritionDataSource`, `10` §10.3 | Mahmoud |
| **OI-05** | **Kamel's module has no owner.** Issue #1 records KamelAli545 as unavailable; S5 assigns him the entire Firestore sync and meal history module. | 🔴 High | FR-07, FR-08, FR-10, US-05, US-06, UC-03, UC-04, the whole data layer, 3 of 9 screens | Mahmoud |
| **OI-07** | **API key exposure.** NFR-03 cannot be fully satisfied by a client-only architecture. Option A (accept, document) or Option B (Cloud Functions proxy). | 🔴 High | NFR-03 verification, `12` §12.2, possibly a Blaze upgrade | Team + trainer |
| **OI-02** | Do `DISCOVERY.md`, `05-REQUIREMENTS.md`, `06-DECISIONS.md`, `files/ui-ux/README.md` exist? Issue #1 says to prefer them; they are not in the repository. | 🟠 Medium | The evidence baseline of this entire package | Mahmoud |
| **OI-01** | **NutriVision or Nesba?** Every document says one, the repository and all issues say the other. | 🟠 Medium | Document titles, app name, package identifier, store listing | Mahmoud |
| **OI-09** | No **brand palette, logo or typography** defined. `08` §8.5.1 proposes a seed color. | 🟠 Medium | UI implementation, app icon, presentation slides | Bassam |
| **OI-03** | "Cross-platform" (OBJ-01) vs Android-only commitment. Read here as a technology property, not a shipping commitment. | 🟡 Low | Wording in the problem statement; scope claims in the presentation | Mahmoud |
| **OI-06** | No **password reset** flow documented. | 🟡 Low | UC-04, login screen | Kamel's module — unassigned |
| **OI-08** | No **data retention or account deletion** requirement. Firestore has no cascade delete (`05` §5.6). | 🟡 Low | Account deletion; stakeholder expectation of "privacy and secure storage" (S3 §1) | Team |
| **OI-10** | No **wireframes, Figma files or sketches** existed before this package. | 🟡 Low | Prototype handoff route (`08` §8.6) | Bassam |
| **OI-11** | Which **submission date** applies — DEPI 6 Nov, or DEPI Industry 9 Oct? | 🔴 High | Everything | Mahmoud |

---

## 13.2 Unverified assumptions `[U]`

Stated by a team member or inferred, with no documentary source.

| ID | Assumption | Basis | If wrong |
|----|-----------|-------|----------|
| A-01 | USDA FoodData Central is the nutrition API | Team member recollection, 2026-11-04 | See OI-04 |
| A-02 | `NutritionalLookupScreen`'s "live suggestion lists" (S5) query a food database rather than Gemini | Inference from the phrase "real-time search" | UC-08 is re-pointed at Gemini or deleted |
| A-03 | Firestore region `europe-west` is acceptable | Proximity to Egypt | **Irreversible after creation** — must confirm first |
| A-04 | Gemini free-tier quota suffices for development and demonstration | Typical free-tier limits | Rate limiting during the final presentation |
| A-05 | The team has or can create a Google Cloud / Firebase account with billing available | Required for any Blaze-tier feature | OI-07 Option B becomes impossible |

---

## 13.3 Proposed decisions `[P]`

**None of these are approved.** They are the author's recommendations, made so that design work could proceed. Each needs an explicit yes.

| ID | Decision | Document |
|----|----------|----------|
| P-01 | MVVM realised with Bloc/Cubit over three-layer Clean Architecture | `04` §4.1 |
| P-02 | Feature-first folder structure mapped to module owners | `04` §4.3 |
| P-03 | `get_it` + `injectable`, `go_router`, `freezed`, `fl_chart` | `04` §4.6 |
| P-04 | `Result<T, Failure>` return type; no exceptions cross the repository boundary | `04` §4.5 |
| P-05 | The entire entity and attribute model | `05` §5.3–5.4 |
| P-06 | User-scoped Firestore layout `users/{uid}/…` | `05` §5.5.1 |
| P-07 | Three denormalizations (embedded analysis, embedded profile, stored daily summary) | `05` §5.5.3 |
| P-08 | Security rules with recursive owner wildcard | `05` §5.5.5 |
| P-09 | Six additional use cases UC-04…UC-09 | `02` §2.3 |
| P-10 | FR-16…FR-19 (authentication) and US-08 | `03` §3.3.2 |
| P-11 | NFR identifiers NFR-01…NFR-12, and NFR-13 (localization) | `03` §3.4 |
| P-12 | The `Meal` state model | `06` §6.5 |
| P-13 | Material 3, seed color `#2E7D32`, Cairo/Tajawal for Arabic | `08` §8.5 |
| P-14 | Five-tab bottom navigation mapped to module owners | `08` §8.3 |
| P-15 | Western numerals in both locales | `08` §8.5.4 |
| P-16 | Gemini request/response schemas for the three AI operations | `10` §10.2 |
| P-17 | Timeouts (10 s connect, 45 s receive) and retry policy | `10` §10.2.6 |
| P-18 | Coverage targets and the CI merge gate | `11` §11.6, `12` §12.3 |
| P-19 | Two Firebase environments; trunk-based branching; Conventional Commits | `12` §12.1, §12.3 |
| P-20 | Mermaid as the diagram source format | `00` |

---

## 13.4 Conflicts between sources

Required by issue #2: *"noting older-PDF conflicts where applicable."*

| ID | Conflict | Sources | Resolution taken here |
|----|----------|---------|----------------------|
| C-01 | Baseline documents named in issue #1 do not exist | Issue #1 vs repository | S1–S3 treated as the operative baseline, stated openly (OI-02) |
| C-02 | Project name | S1–S3 (*NutriVision*) vs repository and issues (*Nesba*) | *NutriVision* used, because it is the name in every evidence document (OI-01) |
| C-03 | "Cross-platform" vs no-iOS | S1 OBJ-01 and trainer brief vs issue #1 and team decision | Read as a technology property; Android is the only commitment (OI-03) |
| C-04 | Relational rubric vs document database | S4 §4.2 ("tables, keys, normalization") vs Firestore | Both delivered: 3NF logical model **and** physical Firestore mapping, with the translation explained (`05` §5.2, §5.6) — per issue #1's instruction |
| C-05 | Kamel assigned a module while recorded as unavailable | S5 vs issue #1 | Design assumes the module is built; ownership flagged as a delivery risk (OI-05) |
| C-06 | NFR-03 vs client-side API key | S3 NFR-03 vs S5 "API key encryption" interceptor | Cannot be fully satisfied client-side; written up honestly with two options (OI-07) |
| C-07 | Authentication absent from requirements but present in module descriptions | S1–S3 (no auth FR/US/UC) vs S5 "Configures Firebase Authentication" | FR-16…FR-19 and UC-04 proposed to close the gap (`03` §3.3.2) |
| C-08 | Two submission dates | S4 table: DEPI Industry 9 Oct vs DEPI 6 Nov | Unresolved (OI-11) |

### Resolved non-conflicts

Recorded so they are not re-raised in review:

| Apparent conflict | Why it is not one |
|-------------------|-------------------|
| "NutriVision" implies image recognition, but issue #1 excludes photo recognition | S2 §3 places image recognition in *Suggested Improvements* (future). NFR-12 requires only that the architecture permit it later. Consistent. |
| Repository contains `ios/`, `web/`, `windows/`, `macos/`, `linux/` folders | Generated by `flutter create`. Scaffolding is not a platform commitment. |

---

## 13.5 Risks inherited from S1 §4

Carried forward with their design-stage mitigation.

| Risk | Probability | Impact | Mitigation in this package |
|------|-------------|--------|---------------------------|
| Inaccurate AI nutritional output | Medium | High | Schema-constrained output (`10` §10.2), prompt rules forbidding medical advice, UI disclaimer (`08` §8.4.8) |
| External API unavailable | Medium | High | Timeouts, retry policy, graceful degradation (`09` §9.4) |
| Internet connection failure | Medium | Medium | Firestore offline persistence, offline banner, queued writes (`06` §6.3.3) |
| Firebase sync failure | Low/Medium | High | `SyncStatus` surfaced in the UI, typed `SyncFailure`, rules tests (`11` §11.4) |
| Data privacy / security | Medium | High | User-scoped rules (`05` §5.5.5), HTTPS, trust-boundary analysis (`09` §9.3) — **except OI-07** |
| UI performance | Medium | Medium | Immutable states with `equatable`, rebuild discipline, responsiveness tests |
| Testing delays | Medium | Medium | CI gate from week one of Phase 5 (`12` §12.7) |
| Scope expansion | **High** | Medium | `01` §1.3 is the operative scope; this register prevents proposals becoming facts silently |

### Risks added by this analysis

| Risk | Impact | Mitigation |
|------|--------|------------|
| A quarter of the functional scope has no implementer (OI-05) | High | Reassign or formally descope before Phase 5 begins |
| Gemini rate limit during the final presentation | High — visible failure in front of the assessor | Verify quota, cache results, record a fallback video (`12` §12.6) |
| Firestore region chosen by accident and permanently (A-03) | Medium | Decide before creating the production project |
| Gemini API shape has changed since most tutorials were written (`10` §10.6) | Medium | Verify against official docs at implementation time |

---

## 13.6 What a reviewer should check first

For BassamEmad39's cross-review, in priority order:

1. **Is the entity model right?** (`05` §5.3–5.4) Everything in `06`, `07` and `10` is built on it. A wrong entity here propagates through four documents.
2. **Are the six proposed use cases legitimate**, or did the author over-reach? (`02` §2.3)
3. **Is the five-tab navigation workable** given module ownership? (`08` §8.3)
4. **Is the NFR-03 write-up fair**, or does it overstate the problem? (`03` §3.5)
5. **Do the conflicts in §13.4 match your reading** of the sources?

Record corrections in this file with the date, and update the affected document. Issue #2's final acceptance criterion is *"Obtain cross-review from BassamEmad39 and record corrections"* — this section is where they go.

### Cross-review log

| Date | Reviewer | Finding | Action | Status |
|------|----------|---------|--------|--------|
| _(pending)_ | BassamEmad39 | | | |
