# 3. Functional & Non-Functional Requirements

> Deliverable §4.1 (partial) of the trainer's guidelines. GitHub issue #3.

---

## 3.1 Preface on identifiers

Functional requirements **FR-01 … FR-15** are reproduced from S3 §4 with their original identifiers and wording. They are authoritative and unchanged.

Non-functional requirements in S3 §5 are presented as a two-column category table **with no identifiers**. Identifiers **NFR-01 … NFR-12** are assigned here, in the order the requirements appear in S3, preserving the original wording. *The requirements are `[E]`; the identifiers are `[P]` — a numbering scheme proposed by this document so that design decisions and test cases can cite them.*

**FR-16 … FR-19** and **NFR-13** are new, `[P]`, and arise from decisions taken after the baseline documents were written.

---

## 3.2 User stories

Reproduced from S3 §2 `[E]`.

| ID | Title | Story |
|----|-------|-------|
| US-01 | Record Meal | As a user, I want to enter a description of my meal so that NutriVision can analyze it. |
| US-02 | Nutritional Advice | As a user, I want to receive nutritional advice about my meal so that I can understand whether it is a healthy choice. |
| US-03 | Dietary Restrictions | As a user, I want to specify my dietary restrictions so that recommendations can be customized. |
| US-04 | Recipe Alternatives | As a user, I want to receive healthier recipe alternatives so that I can improve my meals. |
| US-05 | Meal History | As a user, I want to view previous meals so that I can track my dietary habits. |
| US-06 | Synchronization | As a user, I want my meal history to synchronize across devices so that I can access it from different devices. |
| US-07 | Nutritional Dashboard | As a user, I want to see nutritional information in charts so that I can understand my dietary patterns more easily. |

---

## 3.3 Functional requirements

### 3.3.1 Baseline — FR-01 to FR-15 `[E: S3 §4]`

| ID | Requirement | Use case | Module owner (S5) |
|----|-------------|----------|-------------------|
| FR-01 | The system shall allow users to enter meal descriptions. | UC-01 | Mahmoud |
| FR-02 | The system shall analyze meal descriptions using an AI service. | UC-01 | Ahmed |
| FR-03 | The system shall generate nutritional recommendations. | UC-01 | Ahmed |
| FR-04 | The system shall generate customized recipes. | UC-02 | Ahmed |
| FR-05 | The system shall consider dietary restrictions when generating recommendations. | UC-02, UC-05, UC-06 | Ahmed |
| FR-06 | The system shall suggest healthier alternatives to meals or snacks. | UC-02, UC-06 | Osama |
| FR-07 | The system shall allow users to save meals. | UC-09, UC-03 | Kamel — **unassigned** |
| FR-08 | The system shall display meal history. | UC-03 | Kamel — **unassigned** |
| FR-09 | The system shall display nutritional information using charts. | UC-07 | Bassam |
| FR-10 | The system shall synchronize meal information using Firebase Cloud Firestore. | UC-03 | Kamel — **unassigned** |
| FR-11 | The system shall handle API errors and connection failures. | UC-01, UC-02, UC-08 | Mahmoud |
| FR-12 | The system shall support secure API request handling using Dio Interceptors where appropriate. | Cross-cutting | Mahmoud |
| FR-13 | The system shall provide responsive UI layouts. | Cross-cutting | Bassam |
| FR-14 | The system shall validate user input. | UC-01 | Cross-cutting |
| FR-15 | The system shall provide appropriate loading and error states. | Cross-cutting | Mahmoud |

> **Ownership gap.** FR-07, FR-08 and FR-10 are all owned by a module whose assignee is unavailable (OI-05). Together they constitute the entire persistence and synchronization capability, on which UC-03, UC-07 and UC-09 depend.

### 3.3.2 Proposed additions — FR-16 to FR-19 `[P]`

Arising from the authentication decision of 2026-11-04. Authentication is not present as a user story, use case or requirement anywhere in S1–S3, yet it is a precondition for per-user meal history (US-05, US-06) and for NFR-05.

| ID | Requirement | Use case | Status |
|----|-------------|----------|--------|
| FR-16 | The system shall allow users to register and authenticate using email and password. | UC-04 | `[P]` |
| FR-17 | The system shall allow users to authenticate using Google Sign-In. | UC-04 | `[P]` |
| FR-18 | The system shall scope all stored user data to the authenticated user's identity. | UC-03, UC-04 | `[P]` |
| FR-19 | The system shall allow users to sign out and shall clear locally cached user data on sign-out. | UC-04 | `[P]` |

> A corresponding user story **US-08 — Authentication** `[P]`: *As a user, I want to sign in securely so that my meal history is private to me and available on my devices.*

---

## 3.4 Non-functional requirements

Wording reproduced from S3 §5 `[E]`; identifiers `[P]`.

### Performance

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-01 | The UI should remain responsive and unnecessary widget rebuilds should be minimized. | Widget tests + profile-mode rebuild inspection; KPI-01, KPI-06 |
| NFR-02 | API operations should provide suitable loading indicators and controlled timeouts. | Widget tests on loading states; Dio timeout configuration review; KPI-01 |

### Security

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-03 | API credentials should not be hardcoded into publicly exposed source code. | Source review; secret scanning. **See the architectural risk in §3.5.** |
| NFR-04 | External communication should use HTTPS. | Dio configuration review; all endpoints are HTTPS by default |
| NFR-05 | Firebase Security Rules should restrict unauthorized access. | Firestore rules unit tests; depends on FR-18 |

### Usability

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-06 | The interface should be simple, intuitive and easy to navigate. | Usability evaluation; KPI-07 |
| NFR-07 | Nutritional information should be presented in understandable formats. | Usability evaluation; chart review |

### Reliability

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-08 | Network failures should be handled gracefully without crashing the application. | Unit tests with simulated failures; KPI-02, KPI-05 |
| NFR-09 | Synchronization failures should produce controlled error states. | Unit tests with a fake Firestore; KPI-03 |

### Maintainability

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-10 | Business logic should be separated from UI components. | Architecture review against `04-software-architecture.md` |
| NFR-11 | The codebase should follow modular organization and consistent naming. | Lint configuration; code review |

### Scalability

| ID | Requirement | Verification |
|----|-------------|--------------|
| NFR-12 | The architecture should allow future features such as barcode scanning, image recognition and wearable integration. | Architecture review — the repository pattern must allow a new meal-input source without changing the domain layer |

### Proposed addition

| ID | Requirement | Status |
|----|-------------|--------|
| NFR-13 | The application shall support Arabic and English, including full right-to-left layout mirroring in Arabic. | `[P]` — team decision 2026-11-04; required to be specified by issue #1 |

---

## 3.5 Requirement conflict requiring a decision

> **NFR-03 versus the current integration design — this is the most significant technical issue in the package.**

NFR-03 requires that API credentials not be hardcoded into publicly exposed source code. S5 assigns Mahmoud a "Dio Service Layer with custom Interceptors for API key encryption."

A Flutter mobile application is a **client**, and any key it holds is extractable from the APK regardless of obfuscation, `--dart-define`, or interceptor-level encryption — the key must exist in plaintext in memory at the moment the request is signed. Calling the Gemini API directly from the device therefore cannot satisfy NFR-03 in the strict sense; it can only raise the effort required to extract the key.

Two options:

| Option | Description | NFR-03 | Cost |
|--------|-------------|--------|------|
| **A — Direct client calls** `[P]` | The app calls Gemini directly. The key is injected at build time via `--dart-define` and never committed to Git. | **Partially satisfied.** Key is absent from source control but present in the shipped binary. | None — matches the current plan |
| **B — Cloud Functions proxy** `[P]` | A Firebase Cloud Function holds the key; the app calls the function with its Firebase ID token. | **Satisfied.** The key never leaves the server. | One Cloud Function; Firebase Blaze plan may be required |

**Author recommendation:** Option A for the training project, with NFR-03 explicitly recorded as *partially satisfied* and Option B documented as the production path. This is honest about the limitation rather than claiming a security property the design does not have. **This is a decision for the team and ideally for the trainer — tracked as OI-07.**

---

## 3.6 Requirement traceability summary

| Objective | Requirements |
|-----------|--------------|
| OBJ-01 | NFR-13, FR-13 |
| OBJ-02 | FR-01, FR-07, FR-08 |
| OBJ-03 | FR-02 |
| OBJ-04 | FR-03 |
| OBJ-05 | FR-04, FR-06 |
| OBJ-06 | FR-05 |
| OBJ-07 | FR-10, FR-18 |
| OBJ-08 | FR-12, NFR-03, NFR-04 |
| OBJ-09 | FR-13, NFR-01 |
| OBJ-10 | See `11-testing-and-validation.md` |

Every objective OBJ-01…OBJ-10 traces to at least one requirement, and every requirement FR-01…FR-19 traces to at least one use case (see §2.4).
