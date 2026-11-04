# 9. System Deployment & Integration

> Deliverable §4.5 of the trainer's guidelines. GitHub issues #4 and #9.
> Technology choices are `[P]` pending team approval.

---

## 9.1 Technology stack

### Client

| Layer | Technology | Version `[P]` | Requirement | Source |
|-------|-----------|---------------|-------------|--------|
| Framework | Flutter | 3.x stable | OBJ-01 | `[E: S1, S2]` |
| Language | Dart | 3.x | — | `[E: S2]` |
| State management | `flutter_bloc` (Cubit) | ^8.x | NFR-10 | `[E: team decision]` |
| HTTP | `dio` + interceptors | ^5.x | FR-12, OBJ-08 | `[E: S1, S2, S3]` |
| DI | `get_it` + `injectable` | ^7.x / ^2.x | NFR-11 | `[P]` |
| Routing | `go_router` | ^14.x | UC-04 guard | `[P]` |
| Models | `freezed` + `json_serializable` | ^2.x | FR-02 schema enforcement | `[P]` |
| Charts | `fl_chart` | ^0.68.x | FR-09 | `[P]` |
| Localization | `flutter_localizations`, `intl` | SDK | NFR-13 | `[E: team decision]` |
| Local storage | `shared_preferences` | ^2.x | NFR-08 | `[P]` |

### Backend services

> NutriVision has **no custom backend server**. It is a client application integrating managed services. This is a design fact worth stating explicitly, because the trainer's rubric asks for "backend, frontend, and database technologies" and the answer for the backend tier is *Backend-as-a-Service*.

| Service | Role | Requirement | Source |
|---------|------|-------------|--------|
| **Google Gemini API** | Meal analysis, recipe generation, snack alternatives | FR-02, FR-03, FR-04, FR-06 | `[E: team decision 2026-11-04]` |
| **Cloud Firestore** | Document database; multi-device sync; offline persistence | FR-07, FR-08, FR-10 | `[E: S1, S2, S3]` |
| **Firebase Authentication** | Email/password and Google Sign-In | FR-16…FR-19 | `[E: team decision 2026-11-04]` |
| **USDA FoodData Central** | Reference nutrition data and food search | UC-08 | `[U]` — **OI-04** |

### Tooling

| Purpose | Tool |
|---------|------|
| Version control | Git / GitHub — `Mahmoud-Younes/nesba_ai` `[E: S5 — Mahmoud owns repository workflow]` |
| Testing | `flutter_test`, `bloc_test`, `mocktail`, `fake_cloud_firestore`, `http_mock_adapter` `[P]` |
| Linting | `flutter_lints` `[P]` — NFR-11 |
| CI | GitHub Actions `[P]` — see `12-deployment-strategy.md` |

---

## 9.2 Component diagram

```mermaid
flowchart TB
    subgraph APP["NutriVision Flutter Application"]
        direction TB

        subgraph PRESENTATION["Presentation"]
            SCREENS["Feature Screens<br/>9 screens, 5 tabs"]
            CUBITS["Cubits / Blocs"]
            DS["Design System<br/>shared widgets, theme, l10n"]
        end

        subgraph DOMAIN["Domain"]
            ENT["Entities"]
            UCS["Use Cases"]
            REPOI["Repository Interfaces"]
        end

        subgraph DATALAYER["Data"]
            REPOIMPL["Repository Implementations"]
            PB["PromptBuilder"]
            NC["NutritionCalculator"]
            subgraph SOURCES["Data Sources"]
                GEMDS["GeminiDataSource"]
                NUTDS["NutritionDataSource [U]"]
                FSDS["FirestoreDataSource"]
                AUTHDS["AuthDataSource"]
                CACHEDS["LocalCacheDataSource"]
            end
        end

        subgraph CORE["Core Infrastructure"]
            DIO["DioClient<br/>+ Auth / Logging / Retry interceptors"]
            ERR["Failure hierarchy<br/>+ Result type"]
            DI["Dependency Injection"]
        end
    end

    subgraph EXTERNAL["External Services"]
        GEMINI[["Google Gemini API"]]
        USDA[["USDA FoodData Central [U]"]]
        FBAUTH[["Firebase Authentication"]]
        FIRESTORE[("Cloud Firestore")]
    end

    SCREENS --> CUBITS
    SCREENS --> DS
    CUBITS --> UCS
    UCS --> REPOI
    UCS --> ENT
    REPOIMPL -.->|implements| REPOI
    REPOIMPL --> SOURCES
    REPOIMPL --> PB
    REPOIMPL --> ERR
    CUBITS --> NC

    GEMDS --> DIO
    NUTDS --> DIO
    DIO --> GEMINI
    DIO --> USDA
    AUTHDS --> FBAUTH
    FSDS --> FIRESTORE
    CACHEDS -.->|"offline persistence"| FIRESTORE

    DI -.-> CUBITS
    DI -.-> REPOIMPL

    style DOMAIN fill:#e8f4ea,stroke:#2d6a4f
    style PRESENTATION fill:#e7eefc,stroke:#1d4ed8
    style DATALAYER fill:#fdf0e3,stroke:#b45309
    style CORE fill:#f3e8fd,stroke:#7c3aed
    style EXTERNAL fill:#f0f0f0,stroke:#666
```

### Component dependency summary

| Component | Depends on | Depended on by |
|-----------|-----------|----------------|
| Feature Screens | Cubits, Design System | — |
| Cubits | Use Cases, NutritionCalculator | Screens |
| Use Cases | Entities, Repository Interfaces | Cubits |
| Repository Impls | Data Sources, PromptBuilder, Failures | Use Cases (via interface) |
| GeminiDataSource | DioClient | MealRepository, RecipeRepository |
| FirestoreDataSource | Firebase SDK | MealRepository, ProfileRepository |
| AuthDataSource | Firebase Auth SDK | AuthRepository |
| DioClient | Interceptors | Gemini, Nutrition data sources |
| Design System | — | All screens |

**The domain depends on nothing.** That is the property that makes the layering real rather than nominal, and it is what the architecture review in `11-testing-and-validation.md` checks.

---

## 9.3 Deployment diagram

```mermaid
flowchart TB
    subgraph DEVICE["&lt;&lt;device&gt;&gt; Android Phone / Tablet"]
        direction TB
        subgraph RUNTIME["&lt;&lt;execution environment&gt;&gt; Android Runtime (ART)"]
            APK["&lt;&lt;artifact&gt;&gt;<br/>app-release.apk / .aab<br/><br/>Flutter engine + Dart AOT<br/>NutriVision application"]
            LOCAL[("&lt;&lt;datastore&gt;&gt;<br/>Firestore local cache<br/>+ SharedPreferences")]
        end
        APK --- LOCAL
    end

    subgraph GCLOUD["&lt;&lt;cloud&gt;&gt; Google Cloud Platform"]
        direction TB
        subgraph FBPROJ["&lt;&lt;environment&gt;&gt; Firebase Project"]
            FSNODE[("&lt;&lt;database&gt;&gt;<br/>Cloud Firestore<br/>region: europe-west")]
            AUTHNODE["&lt;&lt;service&gt;&gt;<br/>Firebase Authentication"]
            RULES["&lt;&lt;artifact&gt;&gt;<br/>firestore.rules<br/>firestore.indexes.json"]
        end
        GEMNODE["&lt;&lt;service&gt;&gt;<br/>Gemini API<br/>generativelanguage.googleapis.com"]
        RULES -.->|deployed to| FSNODE
    end

    subgraph USDANODE["&lt;&lt;cloud&gt;&gt; USDA [U]"]
        FDC["&lt;&lt;service&gt;&gt;<br/>FoodData Central API<br/>api.nal.usda.gov"]
    end

    subgraph DIST["&lt;&lt;distribution&gt;&gt;"]
        PLAY["Google Play Console<br/><i>or direct APK</i>"]
    end

    APK -->|"HTTPS / TLS 1.2+<br/>Firestore SDK (gRPC)"| FSNODE
    APK -->|"HTTPS<br/>Firebase Auth SDK"| AUTHNODE
    APK -->|"HTTPS REST<br/>Dio + API key"| GEMNODE
    APK -->|"HTTPS REST [U]"| FDC
    PLAY -.->|installs| DEVICE

    style DEVICE fill:#e7eefc,stroke:#1d4ed8
    style GCLOUD fill:#e8f4ea,stroke:#2d6a4f
    style USDANODE fill:#fdf0e3,stroke:#b45309
```

### Deployment notes

| Aspect | Decision |
|--------|----------|
| **Target platform** | Android only for this project. iOS possible after the training assessment; not a Phase 4 commitment. `[E: team decision 2026-11-04]` |
| **Artifact** | `.aab` for Play Console; `.apk` for direct distribution and trainer demonstration |
| **Minimum SDK** | API 21 (Android 5.0) — Flutter's default `[P]` |
| **Firestore region** | `europe-west` proposed — closest low-latency region to Egypt. **`[P]` and irreversible:** a Firestore location cannot be changed after the database is created. Worth a deliberate decision before anyone clicks create. |
| **No server tier** | Nothing is self-hosted. There is no VM, container, load balancer or custom API server to deploy. |
| **Scaling** | Handled by the managed services. Firestore and Gemini scale without configuration; the application has no scaling surface of its own. |

### Trust boundaries

```mermaid
flowchart LR
    subgraph UNTRUSTED["Untrusted — user-controlled device"]
        A["NutriVision app<br/>+ embedded API key"]
    end
    subgraph TRUSTED["Trusted — server-enforced"]
        B["Firestore Security Rules"]
        C["Firebase Auth token verification"]
    end
    subgraph THIRD["Third-party"]
        D["Gemini API<br/>key-authenticated"]
    end
    A -->|"ID token"| C
    C --> B
    A -->|"API key in header"| D
    style UNTRUSTED fill:#fde8e8,stroke:#c62828
    style TRUSTED fill:#e8f4ea,stroke:#2d6a4f
```

**Everything on the device is untrusted.** Firestore rules (`05` §5.5.5) are the only real enforcement point for FR-18 and NFR-05, because client-side checks can be bypassed. The Gemini API key sits inside the untrusted boundary — the unresolved issue recorded as **OI-07** in `03-requirements.md` §3.5.

---

## 9.4 Integration summary

| Integration | Protocol | Auth | Failure mode | Requirement |
|-------------|----------|------|--------------|-------------|
| Gemini | HTTPS REST, JSON | API key header | Timeout / malformed schema → `ParsingFailure`, retry offered | FR-02, FR-11 |
| Firestore | Firebase SDK (gRPC) | Firebase ID token | Offline queue; `SyncFailure` on reject | FR-10, NFR-09 |
| Firebase Auth | Firebase SDK | — | `AuthFailure`, re-prompt | FR-16, FR-17 |
| USDA `[U]` | HTTPS REST, JSON | API key query param | Degrade to free-text entry only | UC-08 |

All four use HTTPS, satisfying NFR-04.

**Graceful degradation.** If Gemini is unavailable, meals can still be saved without analysis. If USDA is unavailable, meal entry falls back to free text (which is the primary input path anyway, per FR-01). If Firestore is unavailable, writes queue locally. Only Firebase Auth is a hard dependency — without it there is no UID, and therefore no data scope.
