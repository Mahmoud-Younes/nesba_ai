# Information Architecture & Screen Inventory (Proposed)

> **Status: PROPOSED.** Needs team review. Built from the competitor study and the NutriVision brief.
> Date: 2026-10-15

## 1. Brief → UI mapping

| Brief requirement | UI surface |
|---|---|
| AI-generated nutrition advice from meal descriptions | Log screen (text input) → AI result sheet → short advice card on Today |
| AI-generated recipes | Recipes tab: "Suggested for your remaining budget" (AI) |
| GridView / Stack UI with meal history | Meal history: day-grouped GridView of meal cards; Today hero built with Stack (ring + overlays) |
| Charts | Reports screen: calories (day / week / month) and macro split |
| Cloud Firestore sync across devices | Sync status in Account, offline banner, draft states |
| Dio with interceptors for nutrition APIs | Loading / error / retry states in the Log flow |
| Unit and widget tests | Golden/widget tests per screen state (see `ui_ux_checklist.md`) |

## 2. Navigation (proposed)

Bottom bar, 4 destinations + a **central Log action** (raised, inside the bar, not floating over content).

Order in RTL (right → left): **Today (اليوم)** · **Recipes (الوصفات)** · **[+ Log (تسجيل)]** · **Progress (التقدّم)** · **Account (حسابي)**

Why: one primary action always reachable; no duplicate floating button; matches the best-performing pattern in the study.

## 3. Sitemap

```
Onboarding
  ├─ Language & theme
  ├─ Profile setup
  └─ Goal result (TDEE → target, with explanation)
Today
  ├─ Calorie hero + macros
  ├─ Meals (breakfast, lunch, dinner, snack) → Meal detail
  ├─ AI tip card
  └─ Water / weight (Phase 2)
Log (central action)
  ├─ Text input + quick chips
  └─ AI result sheet (edit items, confidence, save)
Recipes
  ├─ Suggested for remaining budget (AI)
  └─ Recipe detail
Progress
  ├─ Reports (day / week / month)
  └─ Meal history (GridView)
Account
  ├─ Goals & targets
  ├─ Settings (theme, language, units, week start)
  └─ Sync / sign-in
```

## 4. Screen inventory

| ID | Screen | Purpose | Priority | States to design |
|---|---|---|---|---|
| S1 | Onboarding: language + theme | First setup | MVP | default |
| S2 | Profile setup | Inputs for target calculation | MVP | validation errors |
| S3 | Goal result | Show target and *why* | MVP | default |
| S4 | Today | Daily budget and meals | MVP | empty, loading, over-goal, offline |
| S5 | Log | Describe a meal | MVP | empty text, typing, loading, error, offline draft |
| S6 | AI result sheet | Review/edit AI estimate | MVP | loading skeleton, low-confidence, error |
| S7 | Meal detail | View/edit a logged meal | MVP | default, delete confirm |
| S8 | Reports | Charts over time | MVP | empty, partial data, full |
| S9 | Meal history | Browse past meals (GridView) | MVP | empty, long list |
| S10 | Recipes (AI suggestions) | Ideas that fit the budget | MVP (basic) | loading, error, empty |
| S11 | Recipe detail | Ingredients, steps, impact on budget | MVP (basic) | default |
| S12 | Goals & targets | Edit targets (macros % ↔ grams) | MVP | validation |
| S13 | Settings | Theme, language, units, week start | MVP | default |
| S14 | Sign-in / sync | Account and sync status | MVP or P2 (team decision) | signed out, syncing, error |
| S15 | AI nutritionist chat | Ask about today's data | Phase 2 | empty with suggested prompts, loading |
| S16 | Water / weight trackers | Extra tracking | Phase 2 | empty, default |
| S17 | Photo logging | Camera input | Phase 2 | permission denied |

## 5. Content specs for key screens (top → bottom)

### Today (S4)
1. Date strip (week starts Saturday) — current day highlighted.
2. **Calorie hero:** ring, remaining kcal (big), eaten / burned, goal chip → "why this number?".
3. **Macro bars** (protein, carbs, fat) with labels.
4. **AI tip card** (one short sentence, dismissible).
5. **Meal rows:** icon, name, budget, "+" button.
6. (Phase 2) water, weight.
- Empty: the hero shows the full budget and a single line: no meals logged yet.
- Over goal: ring continues in apricot, calm message.

### Log (S5)
1. Multiline text field with an example placeholder (Egyptian dishes).
2. Meal-type selector (defaults from time of day).
3. Quick chips: frequent foods.
4. Submit button (disabled while empty).
5. Secondary: camera (Phase 2), history of descriptions.

### AI result sheet (S6)
1. Original text (editable via "Edit text").
2. Items list: name, portion stepper + unit, kcal, macros, **confidence chip**.
3. "Add item" row.
4. Totals row (kcal + macros) and the effect on today's remaining calories.
5. Save (primary) / Edit text (secondary).
6. Disclaimer line: values are estimates.

### Reports (S8)
- Segmented control: day / week / month.
- Chart cards with identical structure: title, big number, chart, dashed goal line.
- Calories by meal (colors), macro split vs target.
- Empty: ghost chart + one explanatory line.

### Goals & targets (S12)
- Calorie target with "why" explanation (TDEE and adjustment).
- Macro targets as % and grams side by side, switch between them.
- Optional per-weekday goals (Phase 2).
- Defaults pre-filled; no screens of empty fields.

## 6. Scope proposal

**MVP (must show the core value):** S1–S14 above, with AI text logging, editable result, reports, basic AI recipe suggestions, goals, settings, offline-friendly drafts.

**Phase 2:** AI chat, water and weight trackers, photo logging, weekly plan.

**Later / not now:** community feed, shopping list, fasting, payments/premium, health-platform integrations, voice logging.

Reasons: a 5-person capstone team, the brief's emphasis on AI advice + history + charts + sync, and the cost of community/moderation seen in the study.

## 7. Data display rules (proposed)

- Digits: Latin (0-9) by default; optional Arabic-Indic setting later.
- Units: metric only (g, ml, kg); calories as "سعرة" / kcal.
- Rounding: kcal as whole numbers; grams as whole numbers (one decimal only under 10 g).
- Week starts on Saturday (setting).
- Number pairs (`value / goal`) always rendered LTR inside RTL screens.
- Over-goal values shown in apricot, never red.
