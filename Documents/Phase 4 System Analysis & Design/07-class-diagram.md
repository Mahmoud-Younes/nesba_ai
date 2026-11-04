# 7. Class Diagram

> Deliverable §4.3 (partial) of the trainer's guidelines. GitHub issue #7.
> **Status: `[P]`.** Every class traces to a requirement, use case or module description. Issue #7 requires the diagram be "requirement-grounded"; §7.5 is the grounding table.

---

## 7.1 Scope of the diagram

A complete class diagram for a nine-feature application would be unreadable on one page. This document presents **three views**:

| View | Covers | Why |
|------|--------|-----|
| §7.2 Domain model | Entities and value objects | The stable core; maps 1:1 to `05-data-model.md` |
| §7.3 Meal analysis slice | Presentation → domain → data for UC-01 | The reference vertical slice every other feature copies |
| §7.4 Cross-cutting | Failures, result type, network, prompt building | The shared infrastructure of `04-software-architecture.md` §4.5 |

Dart conventions: `+` public, `-` private (leading underscore in source), `«abstract»` for interfaces. Entities are immutable — all fields are `final`, with `copyWith` where mutation is needed.

---

## 7.2 Domain model

```mermaid
classDiagram
    direction TB

    class User {
        +String uid
        +String email
        +String? displayName
        +String? photoUrl
        +AuthProvider authProvider
        +Locale locale
        +DateTime createdAt
        +DietaryProfile profile
    }

    class DietaryProfile {
        +List~Restriction~ restrictions
        +int? dailyCalorieTarget
        +int? proteinTargetG
        +int? carbTargetG
        +int? fatTargetG
        +DateTime updatedAt
        +bool hasRestrictions()
        +String toPromptContext()
    }

    class Restriction {
        +RestrictionType type
        +String value
    }

    class Meal {
        +String id
        +String description
        +DateTime loggedAt
        +MealType? mealType
        +SyncStatus syncStatus
        +MealAnalysis? analysis
        +bool isAnalyzed()
        +Meal copyWith()
    }

    class MealAnalysis {
        +int totalCalories
        +Macros macros
        +String healthAssessment
        +String advice
        +String modelName
        +DateTime generatedAt
        +List~AnalyzedItem~ items
    }

    class AnalyzedItem {
        +String name
        +String quantity
        +String unit
        +int calories
        +Macros macros
        +String? foodReferenceId
    }

    class Macros {
        +int proteinG
        +int carbsG
        +int fatG
        +Macros operator+(Macros other)
        +int totalCalories()
    }

    class Recipe {
        +String id
        +String? basedOnMealId
        +String title
        +List~String~ ingredients
        +List~String~ steps
        +int totalCalories
        +Macros macros
        +DateTime savedAt
    }

    class SavedAlternative {
        +String id
        +String cravingInput
        +String alternativeName
        +int caloriesSaved
        +DateTime savedAt
    }

    class DailySummary {
        +DateTime date
        +int totalCalories
        +Macros macros
        +int mealCount
        +double progressTowards(int target)
    }

    class AuthProvider {
        <<enumeration>>
        password
        google
    }

    class SyncStatus {
        <<enumeration>>
        pending
        synced
        failed
    }

    class MealType {
        <<enumeration>>
        breakfast
        lunch
        dinner
        snack
    }

    class RestrictionType {
        <<enumeration>>
        allergen
        diet
        dislike
    }

    User "1" *-- "1" DietaryProfile
    DietaryProfile "1" *-- "0..*" Restriction
    Meal "1" *-- "0..1" MealAnalysis
    MealAnalysis "1" *-- "1..*" AnalyzedItem
    MealAnalysis "1" --> "1" Macros
    AnalyzedItem "1" --> "1" Macros
    Recipe "1" --> "1" Macros
    DailySummary "1" --> "1" Macros
    Recipe "0..*" ..> "0..1" Meal : based on
    User --> AuthProvider
    Meal --> SyncStatus
    Meal --> MealType
    Restriction --> RestrictionType
```

**Design notes.**

- **`Macros` is a value object, not four loose integers.** It appears on `MealAnalysis`, `AnalyzedItem`, `Recipe` and `DailySummary`. Defining `operator+` is what makes Bassam's "daily total calorie/macro summation" (S5) a fold over a list rather than four parallel accumulators — fewer places for an arithmetic bug, and directly unit-testable for KPI-04.
- **`DietaryProfile.toPromptContext()`** is the single place restrictions become prompt text. FR-05 requires restrictions be considered in UC-02 *and* UC-06; putting the conversion on the entity stops two features drifting apart.
- **Composition (filled diamond) is used where `05-data-model.md` embeds** — `User ∘ DietaryProfile`, `Meal ∘ MealAnalysis`. The class diagram and the physical schema agree by construction.

---

## 7.3 Meal analysis vertical slice

The reference pattern. Every other feature follows the same shape with different names.

```mermaid
classDiagram
    direction TB

    class MealEntryScreen {
        <<widget>>
        +Widget build(BuildContext)
        -void _onSubmit()
    }

    class MealAnalysisCubit {
        -AnalyzeMealUseCase _analyzeMeal
        -SaveMealUseCase _saveMeal
        +Future~void~ analyzeMeal(String description)
        +Future~void~ saveMeal()
        -bool _isValid(String)
    }

    class MealAnalysisState {
        <<sealed>>
    }
    class Initial
    class Loading
    class ValidationError {
        +String message
    }
    class Analyzed {
        +MealAnalysis analysis
    }
    class AnalysisError {
        +Failure failure
    }
    class Saved

    class AnalyzeMealUseCase {
        -MealRepository _repository
        +Future~Result~ call(String description)
    }

    class SaveMealUseCase {
        -MealRepository _repository
        +Future~Result~ call(Meal meal)
    }

    class MealRepository {
        <<abstract>>
        +Future~Result~ analyze(String, DietaryProfile)
        +Future~Result~ save(Meal)
        +Stream~List~ watchHistory()
        +Future~Result~ delete(String id)
    }

    class MealRepositoryImpl {
        -GeminiDataSource _gemini
        -FirestoreDataSource _firestore
        -LocalCacheDataSource _cache
        -PromptBuilder _promptBuilder
    }

    class GeminiDataSource {
        -DioClient _dio
        +Future~MealAnalysisModel~ analyze(String prompt)
        -MealAnalysisModel _parseOrThrow(Map json)
    }

    class FirestoreDataSource {
        -FirebaseFirestore _db
        +Future~void~ saveMeal(String uid, MealModel)
        +Stream~List~ watchMeals(String uid)
    }

    class LocalCacheDataSource {
        +Future~void~ enqueue(MealModel)
        +Future~List~ pendingMeals()
    }

    class MealModel {
        +Map~String,dynamic~ toJson()
        +MealModel fromJson(Map)$
        +Meal toEntity()
        +MealModel fromEntity(Meal)$
    }

    MealEntryScreen --> MealAnalysisCubit : intents
    MealAnalysisCubit --> MealAnalysisState : emits
    MealAnalysisState <|-- Initial
    MealAnalysisState <|-- Loading
    MealAnalysisState <|-- ValidationError
    MealAnalysisState <|-- Analyzed
    MealAnalysisState <|-- AnalysisError
    MealAnalysisState <|-- Saved

    MealAnalysisCubit --> AnalyzeMealUseCase
    MealAnalysisCubit --> SaveMealUseCase
    AnalyzeMealUseCase --> MealRepository
    SaveMealUseCase --> MealRepository
    MealRepositoryImpl ..|> MealRepository
    MealRepositoryImpl --> GeminiDataSource
    MealRepositoryImpl --> FirestoreDataSource
    MealRepositoryImpl --> LocalCacheDataSource
    GeminiDataSource --> MealModel
    FirestoreDataSource --> MealModel
    MealModel ..> Meal : maps to
```

**The dependency rule, visible.** `AnalyzeMealUseCase` depends on the abstract `MealRepository`, never on `MealRepositoryImpl`. The arrow from implementation to interface points *into* the domain. This is what lets `11-testing-and-validation.md` unit-test every use case with a mock repository and no Flutter binding — the mechanism behind KPI-04 and NFR-10.

---

## 7.4 Cross-cutting classes

```mermaid
classDiagram
    direction LR

    class Result~T~ {
        <<sealed>>
        +bool isSuccess
        +T? value
        +Failure? failure
        +R fold(onSuccess, onFailure)
    }
    class Success~T~
    class FailureResult~T~

    class Failure {
        <<abstract>>
        +String code
    }
    class NetworkFailure
    class TimeoutFailure
    class ParsingFailure
    class AuthFailure
    class SyncFailure
    class ValidationFailure

    class DioClient {
        -Dio _dio
        +Future~Response~ get(String, Map)
        +Future~Response~ post(String, Object)
    }

    class AuthInterceptor {
        +void onRequest(options, handler)
    }
    class LoggingInterceptor {
        +void onRequest(options, handler)
        +void onError(err, handler)
    }
    class RetryInterceptor {
        +void onError(err, handler)
    }

    class PromptBuilder {
        +String buildAnalysisPrompt(String, DietaryProfile)
        +String buildRecipePrompt(Meal, DietaryProfile, Filters)
        +String buildDiscoveryPrompt(String, DietaryProfile)
        -String _schemaInstruction()
    }

    class NutritionCalculator {
        +DailySummary summarise(List~Meal~, DateTime)
        +double progress(Macros, DietaryProfile)
    }

    Result <|-- Success
    Result <|-- FailureResult
    Failure <|-- NetworkFailure
    Failure <|-- TimeoutFailure
    Failure <|-- ParsingFailure
    Failure <|-- AuthFailure
    Failure <|-- SyncFailure
    Failure <|-- ValidationFailure
    FailureResult --> Failure
    DioClient --> AuthInterceptor
    DioClient --> LoggingInterceptor
    DioClient --> RetryInterceptor
```

`PromptBuilder` is deliberately one class serving all three AI features. S5 splits prompt work across Ahmed (recipes) and Osama (discovery); a shared builder with three methods keeps the strict-JSON schema instruction in one place, so a schema fix benefits both.

---

## 7.5 Requirement grounding

Issue #7 requires the class diagram be grounded in requirements. No class exists without a line in this table.

| Class | Grounded in |
|-------|-------------|
| `User`, `AuthProvider` | FR-16, FR-17, FR-18 `[P]`; UC-04 |
| `DietaryProfile`, `Restriction`, `RestrictionType` | FR-05, US-03, UC-05; S5 "allergen toggles" |
| `Meal`, `MealType`, `SyncStatus` | FR-01, FR-07, FR-10, US-01, US-05; `06` §6.5 state model |
| `MealAnalysis` | FR-02, FR-03, US-02 |
| `AnalyzedItem` | FR-09 — per-item macro breakdown for charts |
| `Macros` | FR-09; S5 Bassam "calorie/macro summation algorithms" |
| `Recipe` | FR-04, US-04, UC-02 |
| `SavedAlternative` | FR-06; S5 Osama "saved healthy favorite alternatives" |
| `DailySummary` | FR-09; S5 Bassam "target progress logic" |
| `MealEntryScreen` and other screens | S5 screen ownership; FR-13 |
| `*Cubit`, `*State` | Team decision 2026-11-04 (Bloc/Cubit); NFR-10 |
| `*UseCase` | NFR-10 — business logic separated from UI |
| `*Repository` / `*RepositoryImpl` | NFR-10, NFR-11, NFR-12 |
| `GeminiDataSource` | FR-02, FR-03, FR-04; team decision (Gemini) |
| `FirestoreDataSource` | FR-10, OBJ-07 |
| `LocalCacheDataSource` | NFR-08; S5 "local cache persistence for offline meal entry" |
| `DioClient`, `AuthInterceptor`, `LoggingInterceptor`, `RetryInterceptor` | FR-12, NFR-02, NFR-04; S1 OBJ-08; S5 Mahmoud's module |
| `MealModel` and other DTOs | S5 Mahmoud "parses external JSON payloads into strongly-typed Dart models" |
| `PromptBuilder` | FR-05; S5 Ahmed "prompt templates enforcing strict JSON output schemas" |
| `NutritionCalculator` | FR-09; S5 Bassam |
| `Result`, `Failure` hierarchy | FR-11, FR-15, NFR-08, NFR-09; `04` §4.5 |

**Classes deliberately absent.** No `FoodReference` class is shown, because it depends on OI-04. No notification, sharing, export, or profile-photo classes exist — nothing in the evidence base requires them, and issue #1 forbids inventing them.
