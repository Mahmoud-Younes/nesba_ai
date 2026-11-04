# 6. Data Flow & System Behaviour

> Deliverable §4.3 (partial) of the trainer's guidelines. GitHub issue #6.
> Diagrams are `[P]`; the flows they depict are `[E]` where traced to UC-01, UC-02 and UC-03 in S3.

---

## 6.1 Context-level data flow diagram (DFD Level 0)

The whole system as one process, with its external entities and the data crossing each boundary.

```mermaid
flowchart LR
    U(["User"])
    SYS["0<br/>NutriVision<br/>System"]
    AUTH[/"Firebase<br/>Authentication"/]
    GEM[/"Google<br/>Gemini API"/]
    USDA[/"USDA FoodData<br/>Central [U]"/]
    FS[("Cloud Firestore")]

    U -->|"credentials, meal description,<br/>dietary restrictions, craving input"| SYS
    SYS -->|"nutritional analysis, advice, recipes,<br/>alternatives, history, charts"| U

    SYS -->|"email/password, Google token"| AUTH
    AUTH -->|"UID, session token, auth errors"| SYS

    SYS -->|"prompt + dietary context"| GEM
    GEM -->|"structured JSON:<br/>macros, advice, recipe"| SYS

    SYS -->|"food search query"| USDA
    USDA -->|"food items,<br/>reference nutrition"| SYS

    SYS -->|"meal, recipe, bookmark,<br/>profile writes"| FS
    FS -->|"synchronized user data"| SYS
```

---

## 6.2 Level-1 data flow diagram

The system decomposed into its major processes and data stores. Process numbering follows the use cases.

```mermaid
flowchart TB
    U(["User"])
    AUTH[/"Firebase Auth"/]
    GEM[/"Gemini API"/]
    USDA[/"USDA [U]"/]

    P4["4.0<br/>Authenticate<br/>User"]
    P5["5.0<br/>Manage Dietary<br/>Profile"]
    P8["8.0<br/>Look Up Food<br/>Nutrition [U]"]
    P1["1.0<br/>Analyze<br/>Meal"]
    P2["2.0<br/>Generate<br/>Recipe"]
    P6["6.0<br/>Discover<br/>Alternative"]
    P9["9.0<br/>Persist &amp;<br/>Sync"]
    P7["7.0<br/>Aggregate &amp;<br/>Visualise"]

    D1[("D1 · users")]
    D2[("D2 · meals")]
    D3[("D3 · recipes")]
    D4[("D4 · alternatives")]
    D5[("D5 · dailySummaries")]
    D6[("D6 · local cache")]

    U -->|credentials| P4
    P4 <-->|verify| AUTH
    P4 -->|UID| D1

    U -->|restrictions, targets| P5
    P5 -->|profile| D1

    U -->|search term| P8
    P8 <-->|query / items| USDA
    P8 -->|selected item| P1

    U -->|meal description| P1
    D1 -->|restrictions| P1
    P1 -->|prompt| GEM
    GEM -->|analysis JSON| P1
    P1 -->|analysis| U
    P1 -->|meal + analysis| P9

    U -->|recipe request| P2
    D2 -->|selected meal| P2
    D1 -->|restrictions| P2
    P2 <-->|prompt / recipe| GEM
    P2 -->|recipe| U
    P2 -->|saved recipe| P9

    U -->|craving| P6
    D1 -->|restrictions, macro goals| P6
    P6 <-->|prompt / alternative| GEM
    P6 -->|comparison| U
    P6 -->|bookmark| P9

    P9 -->|write| D2
    P9 -->|write| D3
    P9 -->|write| D4
    P9 <-->|queue when offline| D6
    P9 -->|totals| D5

    D2 -->|meals| P7
    D5 -->|summaries| P7
    D1 -->|targets| P7
    P7 -->|charts, progress rings| U
```

**Reading the diagram.** Process 9.0 is the single write path to Firestore — every persisting process routes through it rather than writing directly. That is what makes the offline queue (D6) and `syncStatus` handling work in one place (UC-03 A1, NFR-09) instead of being reimplemented per feature.

---

## 6.3 Sequence diagrams

### 6.3.1 UC-01 — Analyze Meal

Traces S3's eight-step main flow across the architectural layers in `04-software-architecture.md`.

```mermaid
sequenceDiagram
    actor U as User
    participant V as MealEntryScreen
    participant C as MealAnalysisCubit
    participant UCx as AnalyzeMealUseCase
    participant R as MealRepository
    participant G as GeminiDataSource
    participant D as DioClient
    participant API as Gemini API
    participant FS as FirestoreDataSource

    U->>V: enter meal description
    U->>V: tap Analyze
    V->>C: analyzeMeal(description)
    C->>C: validate input (FR-14)
    alt invalid
        C-->>V: emit ValidationError
        V-->>U: show inline message
    else valid
        C-->>V: emit Loading (FR-15)
        V-->>U: show loading indicator
        C->>UCx: call(description)
        UCx->>R: analyze(description, restrictions)
        R->>G: analyze(prompt)
        G->>D: POST /generateContent
        D->>D: attach API key via interceptor (FR-12)
        D->>API: HTTPS request (NFR-04)
        API-->>D: JSON response
        D-->>G: response
        G->>G: parse and validate schema
        alt malformed JSON
            G-->>R: throw ParsingException
            R-->>UCx: Result.failure(ParsingFailure)
            UCx-->>C: failure
            C-->>V: emit Error (retry)
            V-->>U: controlled error state (FR-11)
        else valid
            G-->>R: MealAnalysisModel
            R->>R: map DTO to entity
            R-->>UCx: Result.success(MealAnalysis)
            UCx-->>C: success
            C-->>V: emit Analyzed(analysis)
            V-->>U: display recommendations (FR-03)
            U->>V: tap Save (UC-09)
            V->>C: saveMeal()
            C->>R: save(meal)
            R->>FS: set users/{uid}/meals/{mealId}
            FS-->>R: ack
            R-->>C: success
            C-->>V: emit Saved
            V-->>U: confirmation
        end
    end
```

### 6.3.2 UC-02 — Generate Alternative Recipe

```mermaid
sequenceDiagram
    actor U as User
    participant V as AIRecipeGeneratorScreen
    participant C as RecipeCubit
    participant UCx as GenerateRecipeUseCase
    participant PR as PromptBuilder
    participant R as RecipeRepository
    participant G as GeminiDataSource
    participant FS as FirestoreDataSource

    U->>V: select meal, set filter chips / allergen toggles
    U->>V: request alternative recipe
    V->>C: generateRecipe(meal, filters)
    C-->>V: emit Loading
    C->>UCx: call(meal, filters)
    UCx->>R: getDietaryProfile()
    R->>FS: read users/{uid}.dietaryProfile
    FS-->>R: restrictions, targets
    R-->>UCx: DietaryProfile
    UCx->>PR: build(meal, profile, filters)
    Note over PR: restrictions injected into prompt (FR-05, UC-02 step 3)
    PR-->>UCx: prompt with strict JSON schema
    UCx->>R: generate(prompt)
    R->>G: generate(prompt)
    G-->>R: Recipe JSON
    R->>R: validate schema, map to entity
    R-->>UCx: Result.success(Recipe)
    UCx-->>C: success
    C-->>V: emit Generated(recipe)
    V-->>U: display recipe detail sheet (FR-04)
    opt user saves
        U->>V: save recipe
        V->>C: saveRecipe()
        C->>R: save(recipe)
        R->>FS: set users/{uid}/recipes/{recipeId}
    end
```

### 6.3.3 UC-03 — Synchronize Meal History

Includes the offline path, which is the part of UC-03 that S3 states as a requirement (NFR-08) but not as a flow.

```mermaid
sequenceDiagram
    actor U as User
    participant V as MealHistoryScreen
    participant C as HistoryCubit
    participant R as MealRepository
    participant L as LocalCache
    participant FS as FirestoreDataSource
    participant CF as Cloud Firestore
    participant D2 as Device 2

    rect rgb(240,245,255)
    Note over U,CF: Save path
    U->>V: save meal
    V->>C: save(meal)
    C->>R: save(meal)
    alt online
        R->>FS: set document
        FS->>CF: write
        CF-->>FS: ack
        R-->>C: Saved(synced)
    else offline
        R->>L: enqueue with syncStatus = pending
        L-->>R: queued
        R-->>C: Saved(pending)
        C-->>V: emit Saved with offline banner
        Note over L,CF: Firestore offline persistence<br/>replays the write on reconnect
        L->>CF: deferred write
        CF-->>L: ack, syncStatus = synced
    end
    end

    rect rgb(245,255,245)
    Note over D2,CF: Retrieval path
    D2->>CF: subscribe users/{uid}/meals
    CF-->>D2: snapshot stream
    Note over D2: StreamBuilder rebuilds history (S5)
    end

    rect rgb(255,245,245)
    Note over R,CF: Failure path (NFR-09)
    R->>FS: set document
    FS-->>R: PermissionDenied / Unavailable
    R-->>C: Result.failure(SyncFailure)
    C-->>V: emit SyncError
    V-->>U: controlled error state, retry offered
    end
```

---

## 6.4 Activity diagram — meal logging and analysis

The end-to-end user workflow, including the decision points that S3 states as requirements (FR-14, FR-11, FR-15).

```mermaid
flowchart TD
    START(["Start"]) --> AUTHQ{"Authenticated?"}
    AUTHQ -->|No| LOGIN["Show login screen<br/>(UC-04)"]
    LOGIN --> AUTHOK{"Credentials<br/>valid?"}
    AUTHOK -->|No| LOGINERR["Show auth error"] --> LOGIN
    AUTHOK -->|Yes| HOME
    AUTHQ -->|Yes| HOME["Show dashboard"]

    HOME --> ENTRY["Open meal entry"]
    ENTRY --> TYPE["Enter meal description"]
    TYPE --> LOOKUPQ{"Use food<br/>lookup?"}
    LOOKUPQ -->|Yes| SEARCH["Search food database [U]<br/>(UC-08)"] --> PICK["Select item"] --> VALIDATE
    LOOKUPQ -->|No| VALIDATE["Validate input<br/>(FR-14)"]

    VALIDATE --> VALID{"Valid?"}
    VALID -->|No| VERR["Show validation message"] --> TYPE
    VALID -->|Yes| NET{"Network<br/>available?"}

    NET -->|No| OFFLINE["Show offline banner<br/>(NFR-08)"] --> TYPE
    NET -->|Yes| LOAD["Show loading state<br/>(FR-15)"]

    LOAD --> READPROF["Read dietary restrictions<br/>(FR-05)"]
    READPROF --> PROMPT["Build prompt"]
    PROMPT --> CALL["Call Gemini<br/>(FR-02)"]

    CALL --> RESP{"Response<br/>received?"}
    RESP -->|"Timeout / error"| AERR["Show controlled error<br/>(FR-11)"] --> RETRYQ{"Retry?"}
    RETRYQ -->|Yes| CALL
    RETRYQ -->|No| HOME

    RESP -->|Yes| SCHEMA{"Schema<br/>valid?"}
    SCHEMA -->|No| AERR
    SCHEMA -->|Yes| SHOW["Display analysis<br/>and advice (FR-03)"]

    SHOW --> SAVEQ{"Save meal?"}
    SAVEQ -->|No| HOME
    SAVEQ -->|Yes| SAVE["Persist meal<br/>(UC-09, FR-07)"]
    SAVE --> SYNC["Sync to Firestore<br/>(FR-10)"]
    SYNC --> SYNCOK{"Sync<br/>succeeded?"}
    SYNCOK -->|No| QUEUE["Queue locally,<br/>mark pending (NFR-09)"] --> DASH
    SYNCOK -->|Yes| DASH["Update daily summary<br/>and dashboard (FR-09)"]
    DASH --> END(["End"])
```

---

## 6.5 State diagram — meal record lifecycle

> **Object modelled:** a `Meal` record, from first keystroke to synchronized storage.
>
> `[P]` **No state model exists anywhere in the evidence base.** Issue #1 forbids inventing states. Every state below is therefore derived from a stated requirement and cited; the *set* of states is proposed and requires approval. The `syncStatus` field in `05-data-model.md` persists the three terminal sync states.

```mermaid
stateDiagram-v2
    [*] --> Draft

    Draft --> Validating : submit
    Draft --> [*] : discard

    Validating --> Draft : invalid (FR-14)
    Validating --> Submitted : valid

    Submitted --> Analyzing : request sent (FR-02)
    Submitted --> AnalysisFailed : offline / no network (NFR-08)

    Analyzing --> Analyzed : valid JSON received
    Analyzing --> AnalysisFailed : timeout, transport error,<br/>or malformed schema (FR-11)

    AnalysisFailed --> Submitted : retry
    AnalysisFailed --> [*] : abandon

    Analyzed --> [*] : viewed, not saved
    Analyzed --> SyncPending : user saves (FR-07)

    SyncPending --> Synced : write acknowledged (FR-10)
    SyncPending --> SyncFailed : write rejected or<br/>offline (NFR-09)

    SyncFailed --> SyncPending : automatic retry on reconnect
    SyncFailed --> Synced : queued write replayed

    Synced --> Deleted : user deletes<br/>(swipe-to-delete, S5)
    Deleted --> [*]
```

### State derivation

| State | Derived from |
|-------|--------------|
| `Draft` | UC-01 step 2 — user enters description |
| `Validating` | FR-14 / UC-01 step 4 |
| `Submitted` | UC-01 step 3, step 5 |
| `Analyzing` | UC-01 step 6 — AI analyzes the meal; FR-15 requires this be visible |
| `Analyzed` | UC-01 step 7, postcondition |
| `AnalysisFailed` | FR-11; S5 "error recovery for malformed AI responses" |
| `SyncPending` | UC-03 A1, offline cache persistence (S5) |
| `Synced` | UC-03 step 3, FR-10 |
| `SyncFailed` | NFR-09 — "controlled error states" |
| `Deleted` | S5 — Kamel's module, "swipe-to-delete" |

**Note on `Analyzed → [*]`.** A meal analyzed but not saved is discarded; UC-01 step 8 says the user *can* save, not that saving is automatic. This is why UC-09 is modelled as `«extend»` rather than part of UC-01's main flow.

---

## 6.6 Coverage

| Diagram | Requirements exercised |
|---------|------------------------|
| Context DFD | System boundary; all external integrations |
| Level-1 DFD | FR-01…FR-10, FR-16…FR-18 |
| Sequence UC-01 | FR-01, FR-02, FR-03, FR-11, FR-12, FR-14, FR-15, NFR-04 |
| Sequence UC-02 | FR-04, FR-05, FR-06 |
| Sequence UC-03 | FR-07, FR-08, FR-10, NFR-08, NFR-09 |
| Activity | FR-01…FR-03, FR-05, FR-07, FR-09…FR-11, FR-14, FR-15 |
| State | FR-02, FR-07, FR-10, FR-11, FR-14, NFR-08, NFR-09 |
