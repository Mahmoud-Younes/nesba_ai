# User Flows (Proposed)

> **Status: PROPOSED.** Diagrams use Mermaid (render in GitHub, VS Code with a Mermaid extension, etc.). Screen IDs refer to `information_architecture.md`.
> Date: 2026-10-15

## F1 — First run

```mermaid
flowchart TD
  A["Open app first time"] --> B["S1 Language and theme"]
  B --> C["S2 Profile setup: age, sex, height, weight, activity, goal"]
  C --> D["S3 Goal result: daily target with explanation"]
  D --> E["S4 Today"]
```

Notes:
- Ask only for what the calculation needs; explain why each input is requested.
- Show the explanation of the target (TDEE and adjustment) on S3, not buried in settings.
- Edge cases: invalid or extreme values → inline validation; the user skips profile → use clearly labelled defaults.

## F2 — Log a meal by text (core flow)

```mermaid
flowchart TD
  A["S4 Today"] --> B["Tap + on a meal row or the central Log action"]
  B --> C["S5 Log: text field and quick chips"]
  C --> D{"Text empty?"}
  D -- yes --> C
  D -- no --> E["Submit"]
  E --> F["Loading: skeleton of the result sheet"]
  F --> G{"AI result"}
  G -- success --> H["S6 Result sheet: items, portions, kcal, macros, confidence"]
  G -- error or timeout --> I["Keep the text, show retry"]
  G -- offline --> J["Save draft, analyze when online"]
  H --> K{"Low-confidence item?"}
  K -- yes --> L["Ask to confirm the portion inline"]
  K -- no --> M["Save"]
  L --> M
  M --> N["S4 Today updated, short AI tip"]
```

Edge cases to design:
- Ambiguous dish name → AI proposes 2–3 interpretations as chips.
- Very large or very small portions → highlight and ask to confirm.
- Multiple meals in one text → split into items, user assigns meal type.
- Repeated/frequent meals → quick chips from history.
- Over-goal result → calm apricot message, no red.

## F3 — Review a day and history

```mermaid
flowchart TD
  A["S4 Today"] --> B["Tap a meal row"]
  B --> C["S7 Meal detail"]
  C --> D{"Action"}
  D -- edit --> E["Edit items and portions"]
  D -- delete --> F["Confirm delete"]
  A --> G["Progress tab"]
  G --> H["S9 Meal history GridView"]
  H --> C
```

## F4 — Weekly progress

```mermaid
flowchart TD
  A["Progress tab"] --> B["S8 Reports"]
  B --> C{"Enough data?"}
  C -- no --> D["Empty state: ghost chart and one explanatory line"]
  C -- yes --> E["Charts: calories, macros, by meal"]
  E --> F["Switch day / week / month"]
```

## F5 — AI recipe suggestion

```mermaid
flowchart TD
  A["Recipes tab"] --> B["Suggested for remaining budget"]
  B --> C{"AI result"}
  C -- success --> D["S11 Recipe detail with impact on today's budget"]
  C -- error --> E["Retry"]
  D --> F["Log this recipe"]
  F --> G["S6 Result sheet prefilled"]
```

## F6 — Edit goals

```mermaid
flowchart TD
  A["Account"] --> B["S12 Goals and targets"]
  B --> C["Edit calorie target or macro percent / grams"]
  C --> D{"Valid?"}
  D -- no --> E["Inline message"]
  D -- yes --> F["Save and refresh Today"]
```

## Global states to cover in every flow

- Offline: banner + what still works.
- Sync pending / sync failed (Firestore).
- AI slow: show progress after ~2 s, allow cancel.
- AI wrong: always editable, never blocks saving.
- Permission denied (camera, notifications).
