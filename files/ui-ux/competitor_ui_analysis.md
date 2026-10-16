# Competitor UI/UX Analysis (Screenshot-based)

> **Evidence only.** This file records what was observed in screenshots. Recommendations derived from it are in `suggestion_design.md`.
> Date: 2026-10-15 · Screenshots captured 2026-10-14 · 30 screens in total.

## 0. Scope and caveats

- Based on **static screenshots only**: no judgment about animation, speed, or full flows.
- App identification:
  - DietAI: name visible in the UI (confirmed).
  - FatSecret: name visible in the Goals screen text (confirmed).
  - "Appediet-like": recipes show a "Verified by Appediet" badge → *likely* Appediet (not confirmed).
  - "YAZIO-like": tab structure (Diary / Recipes / Profile / Pro, Fasting section) → *probably* YAZIO (not confirmed).
  - App C: Arabic dark app, name not visible (unidentified).
- Study patterns and decisions only. **Do not copy visuals or branding.**

## 1. Apps covered

| # | App | Identification | Language / direction | Theme | Screens |
|---|---|---|---|---|---|
| 1 | DietAI | Confirmed | Arabic, RTL | Light, green | 12 |
| 2 | Appediet-like | Likely | English, LTR | Dark, blue | 6 |
| 3 | App C | Unknown | Arabic, RTL | Dark, yellow | 2 |
| 4 | FatSecret | Confirmed | Arabic (machine-translated), RTL | Dark, green | 7 |
| 5 | YAZIO-like | Probably | English UI, Arabic-Indic digits | Dark, teal | 3 |

---

## 2. Per-app findings

### 2.1 DietAI

Screens: log home, food log (database tab), AI log tab, account/goals, weight chart, tracking (nutrient rings), daily diet plan, AI nutritionist chat.

**Strengths**
- Calorie equation on the first screen: goal + exercise − food = remaining. Understood at a glance. Numbers are consistent (TDEE → target → weekly gain → goal date).
- Multimodal AI logging: photo, text description, voice, barcode, with a placeholder example that teaches what to type. Closest to Nesba's core idea.
- Egyptian-localized diet plan (e.g. foul with tahini, baladi bread, tuna pasta) with gram weights, prep time, health benefits, and two buttons per meal: **log** and **replace with AI**.
- Week strip starts on Saturday (regional localization).
- AI chat starts with the user's profile summary, 3 suggested prompts, a 0/500 counter and a medical disclaimer.
- Tracking tab covers vitamins, minerals, heart-health items and nutrients to limit (sugar, caffeine, alcohol).

**Weaknesses**
- Commercial pressure on every screen: a persistent "try free" bar plus a floating "70% off" countdown that covers content (e.g. the "daily total" heading).
- Floating scan button duplicates the "Log" tab icon and covers buttons (breakfast "log" button).
- Rings in the tracking tab clip text ("50g/", "remaining:"); the fourth ring is cut off with no scroll hint.
- Mixed digit systems (Arabic-Indic next to Latin) and a stray comma in the name/age line.
- Weight-change chart with one data point renders as a flat blue block (looks broken). The goal curve is decorative, not data.
- Many screens full of zeros without guidance.
- AI chat screen: large empty area on top, content at the bottom.
- Daily plan totals 2600 kcal while the goal is 2560 kcal.
- "Replace with AI" button has visibly smaller text than other buttons.

### 2.2 Appediet-like (English, dark)

Screens: Progress (charts), Tracker (home), Recipes list, Recipe detail, Nutrients.

**Strengths**
- **Budget card is the hero:** remaining kcal in a gauge, eaten/burned at the sides, macro bars below. Clear hierarchy.
- Empty state as onboarding: "Log 3 days to unlock your Health Report" with 3 meal icons and one clear button.
- Camera button integrated into the bottom bar (center, raised) rather than floating over content.
- Progress page: chips to switch metric; every chart card has the same structure (title, goal, big number, "Last 7 days", dashed goal line, Daily/Weekly/Monthly).
- Recipes: large photos, time/kcal chips, seasonal and editor sections, a personalized suggestion bubble. Recipe detail shows impact on the day budget (e.g. `296 / 397 kcal`, carbs `38 / 50 g`), editable allergens, and a "Verified" badge.
- Light engagement: streak, friends, mood logging.

**Weaknesses**
- English only; imperial units (fl oz, lb, oz, cup) for an Egyptian user.
- Paywall at row level: micronutrient rows show only a crown icon, no values.
- Large premium banner on the Progress page.
- Empty charts (zeros) without an explanation.
- Recipes grid: duplicated items, "Loading more data…" with a big empty gap, a recommendation card with a blurred/empty area (probably an image that did not load).
- Recipe detail: two servings steppers (1 at the top, 10 in ingredients), spaghetti under "Snacks".
- Low-contrast hint text ("Swipe right for more").

### 2.3 App C (Arabic, dark, yellow accent)

Screens: home (two scroll positions).

**Strengths**
- Simple home, search first with a camera icon.
- Eaten / burned / net strip.
- Each tile (set goal, track intake, weekly meal plan, BMI) has a one-line description and an info button.

**Weaknesses**
- Ad banner at the very top with gambling/chat-style content (hurts trust in a health app).
- "Remaining" number sits in a flat brown strip without visual emphasis.
- The page is a feature list rather than today's data; no obvious "add meal" action.
- Black info buttons on dark cards (low contrast); pixelated icons/images.
- Typos/inconsistency in labels ("اكلاتي", "الاكل" without hamza).
- Subscription banner with an unrelated meat photo.

### 2.4 FatSecret (Arabic, dark)

Screens: reports (nutrients, macro units, calories tabs), My Goals, community feed, shopping list (empty + add sheet).

**Strengths**
- Goals: macro targets as **percentages with computed grams** next to them (e.g. 50% → 425 g), a "use grams" switch, per-weekday goals.
- Reports: three tabs (nutrients / macros / calories), period picker with arrows, calories split by meal with colors.
- Community feed: meal photos, weight milestones, comments (high engagement but costly to moderate).
- Shopping list: quick add field and unit chips (g, kg, ml, l, piece).

**Weaknesses**
- Machine-translated Arabic ("وحدات الماكرو", "مغذيات كبيرة", "بريميم") and a title left in English ("My Goals").
- Dense tables full of dashes; clipped headers; unclear `[+/-]` column header.
- Goals screen has eight empty input fields with no defaults or guidance.
- Weekly view uses huge totals (23,800 kcal) that are hard to read.
- Weekly macro targets (700 g protein, 1750 g carbs, 469 g fat) do not match the daily goals on the Goals screen (170 / 425 / 113 g × 7): probably stale goals; shows a data-consistency risk.
- Colored bar under usernames in the feed has no legend.
- Dashed-line rendering glitch on the calories chart; empty shopping list is just a sentence in a big empty box.

### 2.5 YAZIO-like (English UI, dark)

Screens: Today (diary), Recipes.

**Strengths**
- Summary gauge for remaining calories with macro bars below (same pattern as the Appediet-like app).
- Each meal row shows its budget and a large "+" button → one-tap logging.
- Steps: two paths, "Connect" for automatic tracking or "Track steps manually".
- Sections share the same structure with a "More" link; weight uses a −/+ stepper inside the card.
- Recipes browsed by groups (category, calorie range, method, diet, cuisine) with recipe counts; horizontal cards reveal part of the next card (scroll hint).

**Weaknesses**
- Arabic-Indic digits inside an English interface; the zero looks like a dot, so "Eaten" shows "·" like a placeholder.
- Number pairs appear reversed (e.g. `771 / 0`), probably a bidi issue.
- Water cups wrap into 6 + 2.
- Long page: Fasting and Notes cards with large illustrations take a lot of space.
- Category icons are emoji while other cards use photos.
- "Around the World" showed Mexican and Asian in the visible part; no Arabic/Egyptian cuisine seen (only part of the list visible).

---

## 3. Cross-cutting findings

1. **Calorie targets differ a lot** across apps: about 2367, 2482, 2560, ≈2570 (read from Arabic-Indic digits) and 3400 kcal. If the test profile was identical, the numbers are not comparable and users cannot know which to trust → show how the target is calculated (DietAI's TDEE info icon is the best example). *Confirm the profile inputs were identical.*
2. **Numbers and bidi are a real Arabic problem:** mixed digit systems (DietAI), a zero that looks like a dot and reversed pairs (YAZIO-like). Choose one digit system and force LTR for numeric pairs.
3. **Arabic terminology is inconsistent** across apps. DietAI's terms (المتبقي، الهدف، الإجمالي اليومي) are the cleanest; FatSecret's are machine-translated.
4. **Home layout patterns:** (a) budget hero + sections (Appediet-like, YAZIO-like); (b) long scroll with equal sections (DietAI); (c) feature tiles (App C). (a) answers "where am I today?" fastest.
5. **Each app has its own noise source:** suspicious ad (C), timers/banner (DietAI), locked rows (Appediet-like), clutter/tables (FatSecret). The YAZIO-like app was the cleanest in what was visible.
6. **Community (FatSecret) is expensive:** mixed content, moderation, privacy, engagement. Not realistic for a 5-person capstone MVP.
7. **Default macro targets look high:** protein targets of 192 g and 186 g/day appeared in two apps for the same test profile. If Nesba computes targets, validate the logic with a nutrition specialist and show a clear disclaimer.
8. **Empty states are weak almost everywhere** except the Appediet-like "Log 3 days to unlock" card.

---

## 4. Comparison matrix

| App | Home | Logging | Arabic / RTL | Standout idea |
|---|---|---|---|---|
| DietAI | Long scroll | AI (text / photo / voice / barcode) | Native, with digit issues | Egyptian plan + "replace with AI" |
| Appediet-like | Budget hero | Camera in bottom bar | No | Recipe impact on daily budget |
| App C | Feature tiles | Search + camera | Native Arabic | Simple tiles with explanations |
| FatSecret | Not seen | Database | Machine-translated | Macro % ↔ grams, weekday goals |
| YAZIO-like | Summary + meals | "+" per meal | No (Arabic-Indic digits) | Recipe browsing by groups |

---

## 5. Patterns worth adopting vs avoiding

**Adopt (adapted):**
- Budget hero with remaining calories (Appediet-like, YAZIO-like).
- "+" button per meal row (YAZIO-like).
- Camera/log action inside the bottom bar (Appediet-like).
- TDEE → target explanation (DietAI).
- Placeholder example in the AI input (DietAI).
- Same structure for every chart card (Appediet-like).
- Macro % with grams side by side (FatSecret).
- Recipe impact on the remaining budget (Appediet-like).
- Meal-by-meal calorie colors in reports (FatSecret).

**Avoid:** see the anti-pattern table in `suggestion_design.md` section 8.

---

## 6. Opportunities for Nesba

1. **Egyptian-first logging:** free text such as "a large plate of koshari and ta'amiya" → AI estimates portions using local units (loaf, spoon, plate, tea glass). Competitor food databases visible in screenshots looked generic; this needs a real test (hypothesis).
2. **AI transparency:** editable items, portions and a confidence level before saving. Not visible in any competitor screenshot.
3. **"Why this number?"** for the daily target.
4. **Helpful first-use states** instead of zeros.
5. **Calm monetization (or none).**
6. **Safe defaults:** reviewed macro logic and clear disclaimers.

## 7. Open questions

- Was the profile data identical in all apps (to explain the calorie target differences)?
- Confirm the identity of the "Appediet-like", "YAZIO-like" and App C apps.
- Are there Arabic/Egyptian foods in the databases of these apps? (needs a hands-on test)
