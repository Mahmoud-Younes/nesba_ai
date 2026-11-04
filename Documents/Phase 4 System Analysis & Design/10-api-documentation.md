# 10. API Documentation

> Deliverable §4.6 of the trainer's guidelines. GitHub issue #9.
> **Status: `[P]`.** Endpoint shapes verified against vendor documentation on 2026-11-04; exact model identifiers must be re-confirmed at implementation time (see §10.6).

---

## 10.1 Scope of this document

NutriVision **publishes no API of its own.** It has no server tier, no REST endpoints, and no public contract for other systems to call. The trainer's brief says "If the system includes APIs, provide documentation for endpoints and usage" — this document therefore covers the APIs the application **consumes**, which is the applicable reading.

| API | Role | Status |
|-----|------|--------|
| Google Gemini | AI analysis and generation | `[E: team decision 2026-11-04]` |
| Cloud Firestore | Data persistence and sync | `[E: S1, S3]` — consumed via SDK, not REST |
| Firebase Authentication | Identity | `[E: team decision]` — consumed via SDK, not REST |
| USDA FoodData Central | Reference nutrition | `[U]` — **unconfirmed, see OI-04** |

Only Gemini and USDA are consumed as **REST over Dio** and therefore need endpoint documentation. Firebase services are consumed through official SDKs, which expose a typed method surface rather than HTTP endpoints; they are documented in §10.4 at that level.

---

## 10.2 Google Gemini API

### 10.2.1 Connection

| Property | Value |
|----------|-------|
| Base URL | `https://generativelanguage.googleapis.com` |
| Endpoint | `POST /v1beta/interactions` |
| Authentication | `x-goog-api-key: <GEMINI_API_KEY>` request header |
| Content type | `application/json` |
| Transport | HTTPS (NFR-04) |

> **Verified against Google's current Gemini API documentation on 2026-11-04.** The vendor's structured-output documentation shows the `interactions` endpoint with a `response_format` object. Older integration guides describe `/v1beta/models/{model}:generateContent` with `generationConfig.responseSchema`; if the implementer finds that form in a tutorial, the form documented here is the newer one. **Confirm before writing the data source.**

### 10.2.2 Request shape

```json
{
  "model": "<model-id>",
  "input": "<prompt string>",
  "response_format": {
    "type": "text",
    "mime_type": "application/json",
    "schema": { "...JSON Schema object..." }
  }
}
```

| Field | Required | Purpose |
|-------|----------|---------|
| `model` | yes | Model identifier — see §10.6 |
| `input` | yes | The composed prompt from `PromptBuilder` |
| `response_format` | yes for our use | Forces schema-conformant JSON output |
| `stream` | no | Not used; NutriVision shows a loading state (FR-15) rather than streaming tokens |

**`response_format` is the mechanism behind S5's requirement that Ahmed author "prompt templates enforcing strict JSON output schemas."** Declaring the schema server-side is far more reliable than asking for JSON in prose and parsing hopefully. It does not eliminate the failure case — hence UC-01 A3 and `ParsingFailure` — but it makes it rare.

### 10.2.3 Operation — Analyze meal (FR-02, FR-03)

**Response schema**

```json
{
  "type": "object",
  "properties": {
    "totalCalories":     { "type": "integer" },
    "proteinG":          { "type": "integer" },
    "carbsG":            { "type": "integer" },
    "fatG":              { "type": "integer" },
    "healthAssessment":  { "type": "string", "enum": ["healthy", "balanced", "indulgent"] },
    "advice":            { "type": "string" },
    "items": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name":     { "type": "string" },
          "quantity": { "type": "string" },
          "unit":     { "type": "string" },
          "calories": { "type": "integer" },
          "proteinG": { "type": "integer" },
          "carbsG":   { "type": "integer" },
          "fatG":     { "type": "integer" }
        },
        "required": ["name", "quantity", "unit", "calories", "proteinG", "carbsG", "fatG"]
      }
    }
  },
  "required": ["totalCalories", "proteinG", "carbsG", "fatG", "healthAssessment", "advice", "items"]
}
```

This schema maps exactly onto `MealAnalysis` and `AnalyzedItem` in `07-class-diagram.md` §7.2 and onto the embedded `analysis` map in `05-data-model.md` §5.5.2. `healthAssessment` is an enum rather than free text so the UI can render a consistent badge (`08-ui-ux.md` §8.4.3) instead of parsing a sentence.

**Prompt structure** (built by `PromptBuilder.buildAnalysisPrompt`):

```
You are a nutrition analysis assistant.
Analyse the following meal and estimate its nutritional content.

Meal: {description}
Dietary context: {profile.toPromptContext()}
Respond in: {locale}            ← NFR-13; see 08 §8.5.4

Rules:
- Estimate conservatively; do not invent precision you do not have.
- Do not give medical advice.
- Do not guarantee allergen safety.
```

The last two rules are not stylistic. Issue #1 places medical advice and allergen-safety guarantees out of scope, and S1 §4 mitigates inaccurate AI output with disclaimers. Enforcing them in the system prompt is the first line of that mitigation; the UI disclaimer (`08` §8.4.8) is the second.

### 10.2.4 Operation — Generate recipe (FR-04, FR-05)

Same endpoint, different schema and prompt.

```json
{
  "type": "object",
  "properties": {
    "title":         { "type": "string" },
    "ingredients":   { "type": "array", "items": { "type": "string" } },
    "steps":         { "type": "array", "items": { "type": "string" } },
    "totalCalories": { "type": "integer" },
    "proteinG":      { "type": "integer" },
    "carbsG":        { "type": "integer" },
    "fatG":          { "type": "integer" }
  },
  "required": ["title", "ingredients", "steps", "totalCalories", "proteinG", "carbsG", "fatG"]
}
```

The dietary restrictions injected here are what satisfies UC-02 step 3 and FR-05.

### 10.2.5 Operation — Discover alternative (FR-06)

```json
{
  "type": "object",
  "properties": {
    "alternativeName":    { "type": "string" },
    "alternativeCalories":{ "type": "integer" },
    "cravingCalories":    { "type": "integer" },
    "caloriesSaved":      { "type": "integer" },
    "rationale":          { "type": "string" }
  },
  "required": ["alternativeName", "alternativeCalories", "cravingCalories", "caloriesSaved", "rationale"]
}
```

`cravingCalories` and `alternativeCalories` are both requested so that Osama's side-by-side comparison cards (`08` §8.4.5) have both sides from one call rather than two.

### 10.2.6 Error handling

| HTTP | Meaning | Failure type | User-facing behaviour |
|------|---------|--------------|----------------------|
| 400 | Malformed request or schema | `ParsingFailure` | Generic error, retry — a 400 is a bug, log it |
| 401 / 403 | Invalid or missing API key | `AuthFailure` | Generic error; never expose key details |
| 429 | Rate limited | `NetworkFailure` | "Too many requests, try again shortly" |
| 500 / 503 | Upstream fault | `NetworkFailure` | Retry with backoff (RetryInterceptor) |
| timeout | No response | `TimeoutFailure` | Retry offered (NFR-02) |
| 200, bad schema | Response not schema-conformant | `ParsingFailure` | Retry offered (UC-01 A3) |

**Timeouts** `[P]`: connect 10 s, receive 45 s. The receive timeout is deliberately long because generation is slow; KPI-01's ~3 s target explicitly excludes AI operations.

**Retry policy** `[P]`: at most 2 retries, exponential backoff (1 s, 3 s), only on 429/500/503/timeout. Never retry 400 or 401 — the outcome will not change.

---

## 10.3 USDA FoodData Central API `[U]`

> **This entire section is contingent on OI-04.** A team member recalls FoodData Central being discussed; no document records the decision. If nutrition data comes solely from Gemini, this section is deleted, UC-08 is removed, and `FOOD_REFERENCE` / `foodCache` disappear from `05-data-model.md`. **Do not implement against this section until the decision is confirmed.**

| Property | Value |
|----------|-------|
| Base URL | `https://api.nal.usda.gov/fdc/v1` |
| Search | `GET /foods/search?query={term}&pageSize={n}&api_key={key}` |
| Detail | `GET /food/{fdcId}?api_key={key}` |
| Authentication | API key as a query parameter |

> **Security note.** FoodData Central authenticates by **query parameter**, which means the key appears in URLs and therefore in any request log. The `LoggingInterceptor` (`07` §7.4) must redact the `api_key` parameter before writing a log line. This is a concrete, easily-missed instance of NFR-03.

**Usage pattern for UC-08:** debounce user input by ~400 ms, request a small `pageSize` for the suggestion list, and fetch full detail only on selection. Cache results in `foodCache/{fdcId}` so repeated lookups of common foods do not re-hit the API.

**Degradation:** if unavailable, the lookup field is hidden and meal entry continues as free text — which is the primary path under FR-01 regardless.

---

## 10.4 Firebase SDK surfaces

Consumed as typed SDK calls, not REST. Documented at method level for completeness.

### Firebase Authentication (FR-16…FR-19)

| Operation | Method | Failure cases |
|-----------|--------|---------------|
| Register | `createUserWithEmailAndPassword` | `email-already-in-use`, `weak-password`, `invalid-email` |
| Sign in | `signInWithEmailAndPassword` | `invalid-credential`, `user-disabled`, `too-many-requests` |
| Google Sign-In | `signInWithCredential(GoogleAuthProvider.credential(...))` | cancelled by user, `account-exists-with-different-credential` |
| Session | `authStateChanges()` stream | — drives the `go_router` redirect guard |
| Sign out | `signOut()` | — must also clear local cache per FR-19 |

### Cloud Firestore (FR-07, FR-08, FR-10)

| Operation | Path | Notes |
|-----------|------|-------|
| Save meal | `users/{uid}/meals/{mealId}` | `set()` with `SetOptions(merge: false)` |
| Watch history | `users/{uid}/meals` | `snapshots()` ordered by `loggedAt` desc — drives StreamBuilder (S5) |
| Delete meal | `users/{uid}/meals/{mealId}` | `delete()` — swipe-to-delete (S5) |
| Read profile | `users/{uid}` | Single document read |
| Write summary | `users/{uid}/dailySummaries/{yyyy-MM-dd}` | Written in the same batch as the meal (see `05` §5.5.3 D3) |

Offline persistence is **enabled by default** on mobile. The offline queue described in UC-03 A1 is provided by the SDK rather than hand-built; `LocalCacheDataSource` exists for preferences and for surfacing `syncStatus` to the UI, not for re-implementing the queue.

---

## 10.5 Cross-cutting interceptor behaviour (FR-12)

Applied by `DioClient` to all REST calls:

| Interceptor | Behaviour |
|-------------|-----------|
| `AuthInterceptor` | Injects `x-goog-api-key` for Gemini; appends `api_key` for USDA |
| `LoggingInterceptor` | Logs method, URL, status, duration. **Redacts `api_key` and `x-goog-api-key`.** Disabled in release builds |
| `RetryInterceptor` | Backoff retry per §10.2.6 |
| Error mapping | Converts `DioException` into the typed `Failure` hierarchy before it leaves the data layer (`04` §4.5) |

---

## 10.6 Implementation-time confirmations

Two things in this document will age and must be checked before coding, not assumed:

| Item | Why |
|------|-----|
| **Model identifier** | Google's current documentation shows `gemini-3.8-flash` in structured-output examples. Model names change frequently and a wrong identifier fails at runtime, not compile time. Pin the chosen model in configuration, record it in `MealAnalysis.modelName` (`05` §5.4) for reproducibility, and verify availability on the project's API key before committing. |
| **Endpoint and field names** | The `interactions` + `response_format` shape documented above reflects Google's current documentation. Many third-party tutorials still show `generateContent` + `generationConfig.responseSchema`. Verify against the official docs at implementation time and update this document if it has moved again. |

Sources: [Gemini API — structured output](https://ai.google.dev/gemini-api/docs/structured-output)
