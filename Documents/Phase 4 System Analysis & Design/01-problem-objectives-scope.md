# 1. Problem Statement, Objectives & Scope

> Deliverable §4.1 (partial) of the trainer's guidelines. GitHub issue #2.

---

## 1.1 Problem statement

People who want to manage their diet face a practical gap between *eating* and *understanding what they ate*. Conventional meal-tracking applications require the user to locate each food item in a database and enter portions manually, which is slow, error-prone, and demands nutritional literacy the average user does not have. The result is that users abandon tracking, and the nutritional data they do record is neither interpreted for them nor turned into actionable change.

NutriVision addresses this gap by letting users describe a meal in **natural language** and receive, in return, an AI-generated nutritional analysis, an assessment of whether the meal is a healthy choice, and concrete healthier alternatives and recipes adapted to their stated dietary restrictions `[E: S1 §1 Project Overview]`.

### Problem sub-statements

| ID | Statement | Source |
|----|-----------|--------|
| PS-01 | Manual meal entry is slow and requires the user to know food database terminology. | `[P]` — inferred framing of S1 §1 |
| PS-02 | Raw nutritional numbers are not meaningful to non-expert users without interpretation. | `[E: S3 NFR "Nutritional information should be presented in understandable formats"]` |
| PS-03 | Users receive no actionable guidance on how to improve a meal they have already logged. | `[E: S1 §1 — "healthier alternatives, and customized recipe suggestions"]` |
| PS-04 | Dietary restrictions and allergies are rarely accounted for in generic recommendations. | `[E: S3 US-03, FR-05]` |
| PS-05 | Dietary history is not available across a user's devices. | `[E: S3 US-06, FR-10]` |

> `[P]` PS-01 through PS-05 are an author decomposition of the narrative problem description in S1. The narrative itself is `[E]`; the decomposition into numbered sub-statements is proposed so that objectives and requirements can be traced to specific problems. Pending team approval.

---

## 1.2 Project objectives

Reproduced verbatim in substance from S1 §1 *Project Objectives*, with identifiers assigned for traceability.

| ID | Objective | Source |
|----|-----------|--------|
| OBJ-01 | Develop a cross-platform mobile application using Flutter. | `[E: S1 §1]` |
| OBJ-02 | Allow users to record and manage meals. | `[E: S1 §1]` |
| OBJ-03 | Analyze meal descriptions using Artificial Intelligence. | `[E: S1 §1]` |
| OBJ-04 | Generate personalized nutritional recommendations. | `[E: S1 §1]` |
| OBJ-05 | Provide healthier recipe and snack alternatives. | `[E: S1 §1]` |
| OBJ-06 | Support dietary restrictions and user preferences. | `[E: S1 §1]` |
| OBJ-07 | Synchronize meal data across devices using Firebase Cloud Firestore. | `[E: S1 §1]` |
| OBJ-08 | Implement secure API communication using Dio and Interceptors. | `[E: S1 §1]` |
| OBJ-09 | Provide responsive user interfaces for different screen sizes. | `[E: S1 §1]` |
| OBJ-10 | Validate core logic and UI behaviour through unit and widget testing. | `[E: S1 §1]` |

> **Conflict note (OI-03).** OBJ-01 states "cross-platform." The team's current platform decision is Android-primary, iOS deferred `[E: team decision, 2026-11-04]`, and issue #1 excludes iOS expansion. *Cross-platform* is read here as a property of the **technology choice** (one Flutter codebase, capable of multiple targets) rather than a commitment to ship multiple platforms in this project. This reading requires confirmation.

### Objective-to-problem traceability

| Objective | Addresses |
|-----------|-----------|
| OBJ-02, OBJ-03 | PS-01 |
| OBJ-04 | PS-02 |
| OBJ-05 | PS-03 |
| OBJ-06 | PS-04 |
| OBJ-07 | PS-05 |
| OBJ-01, OBJ-08, OBJ-09, OBJ-10 | Quality objectives — not tied to a single problem statement |

---

## 1.3 Scope

### 1.3.1 In scope

Reproduced from S1 §1 *Project Scope — Included* `[E]`:

- Meal logging and meal history
- AI nutritional analysis
- Personalized recipe generation
- Healthy food alternative suggestions
- Dietary restriction support
- Nutritional charts and dashboard
- Firebase Cloud Firestore synchronization
- Dio-based API communication
- Responsive UI
- Unit and widget testing

Added to scope after the baseline documents were written:

| Item | Status | Note |
|------|--------|------|
| User authentication (email/password + Google Sign-In) | `[E: team decision, 2026-11-04]` | Not present in S1–S3 as a user story or functional requirement. Required because meal history is per-user and Firestore security rules must scope data by user identity. New requirements FR-16…FR-19 are proposed in `03-requirements.md`. |
| Arabic and English localization with RTL support | `[E: team decision, 2026-11-04]` | Issue #1 requires the localization and RTL approach be specified for subsequent Flutter implementation. Approach documented in `08-ui-ux.md`. |
| USDA FoodData Central nutrition lookup | `[U]` | Recalled by a team member, no documentary source. If confirmed, this is the data source behind `NutritionalLookupScreen` (S5, Mahmoud's module). If not confirmed, all nutritional values originate from Gemini, which materially changes `10-api-documentation.md` and the accuracy risk in S1 §4. **Blocking — see OI-04.** |

### 1.3.2 Out of scope

Per S6 (issue #1) `[E]`:

- Admin portal or web portal
- iOS as a Phase 4 deliverable
- Payments and social features
- Photo / image-based meal recognition
- Medical advice
- Allergen-safety guarantees

Per S2 §3, the following are recorded as **future enhancements**, explicitly outside Phase 4 but which the architecture must not preclude (NFR-12) `[E]`:

- Wearable device integration
- Barcode-based food recognition
- Image-based meal recognition
- Advanced nutritional analytics
- Personalized weekly meal plans
- Integration with professional nutritionists
- Additional language support beyond Arabic/English
- Integration with trusted nutritional databases
- Offline or partially offline intelligent assistance

> **Resolved non-conflict.** The project name *NutriVision* suggests image recognition, and issue #1 lists "photo recognition" as out of scope. These are consistent: S2 §3 places image-based meal recognition in *Suggested Improvements* (future work), and S3 NFR-12 requires only that the architecture permit it later. No contradiction exists.

### 1.3.3 Scope control

S1 §4 rates **scope expansion** as the project's only *High* probability risk, with the mitigation "maintain a clearly defined project scope and prioritize core features" `[E]`. This document is the operative scope definition for Phase 4. Any addition to §1.3.1 after team approval should be recorded here with a date and an approver.

---

## 1.4 Stakeholders

Reproduced from S3 §1 `[E]`:

| Stakeholder | Needs / expectations |
|-------------|----------------------|
| End users | Simple meal logging, understandable nutritional information, personalized recommendations, privacy and secure storage. |
| Project supervisor / lecturer | Clear objectives, strong documentation, technical implementation, testing, and evidence of project planning. |
| Development team (Ahmed, Kamel, Osama, Mahmoud, Bassam) | Clear requirements, architecture, APIs, backend services, development tools and testing strategy. |

> **Open item (OI-05).** S5 assigns Kamel the *Real-Time Firestore Sync & Meal History Module*. Issue #1 records that KamelAli545 is unavailable and did not accept the repository invitation. That module carries FR-07, FR-08, FR-10, US-05, US-06 and the whole of UC-03 — approximately one quarter of the functional scope — and currently has no owner. This is a **scope and delivery risk, not a design problem**: the design in this package assumes the module is built. Ownership must be reassigned or the scope formally reduced.

---

## 1.5 Success criteria

From S1 §5 (KPIs) `[E]`:

| ID | KPI | Target |
|----|-----|--------|
| KPI-01 | Application response time | ≤ ~3 seconds for normal non-AI UI/API operations |
| KPI-02 | API error handling | All identified API failure scenarios produce controlled user feedback |
| KPI-03 | Firebase synchronization | Successful synchronization under normal connectivity |
| KPI-04 | Test pass rate | ≥ 90% for implemented automated tests |
| KPI-05 | Crash / error rate | Minimised during functional and usability testing |
| KPI-06 | UI responsiveness | Core screens operate correctly across supported screen sizes |
| KPI-07 | User adoption | Measured during usability evaluation |
| KPI-08 | Meal logging completion | Percentage of attempted meal entries successfully saved |

KPI-01 deliberately excludes AI operations; Gemini latency is not controllable by the application. The loading-state requirement (FR-15) and the timeout requirement (NFR-02) exist to make that latency tolerable rather than to bound it.
