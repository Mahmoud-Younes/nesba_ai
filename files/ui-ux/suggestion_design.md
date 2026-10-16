# Nesba (نسبة) — Design Suggestions

> **Status: PROPOSED.** These are suggestions that came out of the competitor study, not team decisions.
> Decision status for every item lives in `ux_decisions_log.md`.
> Date: 2026-10-15 · Scope: design direction, typography, color, layout tokens, core components, RTL rules, accessibility, Flutter notes.

---

## 1. Design direction

- **Name idea:** "نسبة" means ratio / proportion / percentage. Use that as the visual motif: **rings and proportional bars** (calorie ring, macro split). One shape language across the whole app.
- **Tone:** calm, trustworthy, friendly. Never shaming (no red for exceeding a goal).
- **Arabic-first:** native RTL layouts (not a mirrored LTR app). Latin digits (0-9) by default.
- **Differentiation from competitors:**
  - The category is crowded with green (DietAI, FatSecret) → use **teal + apricot**.
  - Clean monetization: no floating countdowns, no sketchy ads, no fully locked data rows.
  - AI transparency: every AI estimate is visible, editable, and shows how sure it is.

---

## 2. Typography

### 2.1 Recommended pair (primary pick)

**IBM Plex Sans Arabic** (Arabic) + **IBM Plex Sans** (Latin text and all numbers).

Why:
- Both belong to the Plex family and are designed to sit together, so mixed lines such as `Protein 18g` or a Latin dish name inside Arabic text look consistent in size and weight.
- Neutral, professional tone, fits a health app with many numbers.
- IBM Plex Sans supports tabular figures (equal-width digits), useful for macro tables and report columns.
- Free (OFL), available on Google Fonts, readable at small sizes.

### 2.2 Alternatives

| Option | Fonts | Pros | Check before choosing |
|---|---|---|---|
| A (friendlier) | **Readex Pro** (Arabic + Latin in one family) | One family, variable weight, readability-oriented, warm | Verify tabular-figure support for tables |
| B (lightest / most common) | **Tajawal** + **Inter** | Very common in Egyptian apps, Inter is excellent for numbers | Two different designers → test pairing in mixed lines |
| Headings only (optional) | **Alexandria** or **Cairo** (Bold) | Stronger personality for titles | Do not use for body text |

The "نسبة" **wordmark** should be custom-designed, not a UI font.

> Verify availability and license on fonts.google.com before bundling. Do a rendering test with real screens (Arabic + Latin + numbers) before freezing the choice.

### 2.3 Type scale (proposed)

Arabic needs larger sizes and taller line height than Latin. `height` below is the Flutter `TextStyle.height` multiplier.

| Token | Size | Weight | Height | Use |
|---|---|---|---|---|
| `display.hero` | 44 sp | SemiBold | 1.1 | "Remaining calories" number |
| `headline` | 24 sp | SemiBold | 1.3 | Screen titles |
| `title.section` | 20 sp | SemiBold | 1.35 | Section headings |
| `title.card` | 16 sp | Medium | 1.4 | Card titles, meal names |
| `body` | 16 sp | Regular | 1.6 | Main text |
| `body.small` | 14 sp | Regular | 1.55 | Secondary text (minimum for Arabic body) |
| `caption` | 13 sp | Regular | 1.5 | Hints, units (minimum size) |
| `label.button` | 15 sp | Medium | 1.2 | Buttons |

### 2.4 Rules

- `letterSpacing: 0` for Arabic. Any tracking breaks the letter connections.
- No italic and no UPPERCASE for Arabic. Use weight and color for emphasis.
- Use 3 weights only: Regular (400), Medium (500), SemiBold (600).
- Numbers: Latin digits (0-9), tabular figures in tables/reports (`FontFeature.tabularFigures()`).
- When formatting numbers with `intl`, pass an explicit `'en'` locale so an Arabic app locale does not switch to Arabic-Indic digits (verify the output).
- Bundle fonts as assets in `pubspec.yaml` instead of runtime download via `google_fonts`: works offline and avoids a font flash on first launch.
- Test with system text scale up to 1.3 and on an older Android device.

---

## 3. Color

Direction: **Teal + Apricot**. Teal = health, trust, calm without looking like a generic "diet green". Apricot = warm, food-related, used sparingly for energy/calories and secondary calls to action.

### 3.1 Core tokens

| Role | Light | Dark |
|---|---|---|
| Primary | `#0F766E` | `#4FD1C0` |
| On-primary (text on Primary) | `#FFFFFF` | `#06221E` |
| Primary container | `#D5F2EC` | `#12403A` *(contrast not verified)* |
| Accent (apricot) | `#F59E42` | `#F59E42` |
| On-accent | `#12211E` | `#12211E` |
| Background | `#F6F9F8` | `#0D1614` |
| Surface | `#FFFFFF` | `#15211F` |
| Outline | `#DCE5E2` | `#2C3F3B` |
| Text primary | `#12211E` | `#E8F1EF` |
| Text secondary | `#52635F` | `#9DB0AB` |

Avoid pure black backgrounds and pure white text in dark mode.

### 3.2 Macronutrients

Calories use the Primary color. Macros:

| Macro | Light | Dark |
|---|---|---|
| Protein | `#3E7CB1` | `#6FA8DC` |
| Carbs | `#C27E00` | `#F2BE45` |
| Fat | `#D1627F` | `#E58AA3` |

- Always pair a macro color with a label or icon (never color alone). Test with a color-blind simulator before freezing.
- Dark-mode macro colors and the dark container color are starting points, contrast not computed yet.

### 3.3 Semantic colors

| State | Color | Note |
|---|---|---|
| Success | to be chosen | Keep distinct from Primary teal |
| Warning / over goal | `#E8A317` | Use for exceeding a goal instead of red |
| Error | `#D64545` | 4.38:1 on white: icons and large text only; use a darker shade for small text (to verify) |

### 3.4 Contrast measurements (WCAG, computed 2026-10-15)

AA targets: 4.5:1 normal text, 3:1 large text and graphical objects.

| Pair | Ratio | Verdict |
|---|---|---|
| White on Primary `#0F766E` | 5.47 | OK for button text |
| Text `#12211E` on Background `#F6F9F8` | 15.71 | OK |
| Text secondary `#52635F` on Background | 5.99 | OK |
| Text secondary `#52635F` on white | 6.35 | OK |
| Primary `#0F766E` on Background (icons, links) | 5.17 | OK |
| Primary on container `#D5F2EC` | 4.62 | OK (just above AA) |
| `#12211E` on Accent `#F59E42` | 7.81 | OK |
| Accent `#F59E42` on white | 2.13 | **Fails**: never use apricot as text or thin lines on light backgrounds |
| Dark: Primary `#4FD1C0` on `#0D1614` | 9.82 | OK |
| Dark: text `#E8F1EF` on `#0D1614` | 15.99 | OK |
| Dark: secondary `#9DB0AB` on `#15211F` | 7.27 | OK |
| Dark: `#06221E` on `#4FD1C0` | 8.93 | OK |
| Protein `#3E7CB1` on white | 4.45 | OK for graphics |
| Carbs `#C27E00` on white | 3.34 | OK for graphics (lighter amber `#E5A823` was only 2.11) |
| Fat `#D1627F` on white | 3.64 | OK for graphics |

### 3.5 Usage rules

- Apricot stays under ~10% of any screen.
- **Exceeding the daily goal is shown in apricot with calm wording, not red.**
- Support light and dark theme from day one (`ThemeData` light + dark).
- Do not rely on color alone for meaning (macros, over/under goal).

### 3.6 Alternative direction (not prepared)

If the team wants a warmer look: **Sage green + Terracotta**. Not specified yet; can be prepared with the same token structure and contrast checks.

---

## 4. Layout tokens (proposed defaults)

| Token | Value |
|---|---|
| Spacing scale | 4, 8, 12, 16, 24, 32 dp |
| Screen horizontal padding | 16 dp |
| Card radius | 16 dp |
| Bottom sheet top radius | 24 dp |
| Minimum touch target | 48 × 48 dp |
| Elevation | Prefer outlines/tonal surfaces over heavy shadows |

---

## 5. Core components (patterns taken from the competitor study)

1. **Calorie hero** (Stack): ring with *remaining kcal* as the big number in the center; *eaten* and *burned* on the sides; goal chip below that opens "why this number?". If over goal, the ring continues in apricot with a calm label.
2. **Macro bars:** three horizontal bars: label, `value / goal g`, color. Labels always visible.
3. **Meal row:** meal icon, name, `kcal` budget, 48 dp "+" button. One tap starts logging for that meal.
4. **Log input (AI, text-first):** one multiline field with a placeholder example in Egyptian food terms; quick chips (frequent foods); camera is secondary.
5. **AI result sheet:** original text at the top; list of detected items, each with portion stepper (g / piece / cup / spoon), kcal, macros and a **confidence chip** (high / medium / low); "add item" row; total row; primary "Save", secondary "Edit text". Low-confidence items ask for confirmation inline.
6. **Chart card:** title, one big summary number, chart, goal as dashed line, segmented control (day / week / month). Same structure for every metric.
7. **Empty state:** one sentence + one action. Never a screen of zeros. Use a ghost/sample chart with an explanatory line.
8. **Premium prompts (if ever used):** a single, dismissible card in context. Never a floating timer, never covering content.

---

## 6. RTL and Arabic rules

- Build with `Directionality` from the locale; do not hard-code left/right (use `start`/`end`).
- Wrap number pairs such as `0 / 771` and unit strings in an LTR context to avoid reversed order (seen in one competitor).
- Icons that imply direction (back, forward, progress) must mirror; icons that do not (play, camera) must not.
- Charts: time axis direction follows the app locale decision (decide once: RTL time axis or LTR chart inside RTL screen) and stay consistent.
- Week starts on **Saturday** by default for Egypt (make it a setting).
- Avoid clipped text in rings and chips: test with the longest Arabic labels.
- Arabic glossary and microcopy: see `microcopy_glossary_ar.md`.

---

## 7. Accessibility

- Contrast: see section 3.4. Re-check every new color pair.
- Touch targets ≥ 48 dp; spacing between targets ≥ 8 dp.
- Support system font scaling to at least 130% without clipping.
- Never encode meaning with color only (add labels/icons).
- Provide `Semantics` labels for rings and charts (read value and goal, e.g. "remaining 1,200 of 2,400 calories").
- Respect reduced-motion settings for ring/chart animations.

---

## 8. Anti-patterns to avoid (observed in competitors)

| Anti-pattern | Where seen | Instead |
|---|---|---|
| Floating discount countdown over content | DietAI | No floating timers |
| Floating scan button duplicating a tab icon and covering buttons | DietAI | Put the log action inside the bottom bar |
| Ad banner at the top of the home screen with unrelated/sketchy content | Arabic dark app (C) | No ads in MVP |
| Locked rows showing only a crown icon | Appediet-like app | Show real values; gate whole features if needed |
| Charts and rings full of zeros with no guidance | Several | Empty states |
| Clipped text in rings and table headers | DietAI, FatSecret | Test longest strings, allow wrapping |
| Mixed Arabic-Indic and Latin digits | DietAI, YAZIO-like | One numeral system |
| Machine-translated labels ("وحدات الماكرو") | FatSecret | Reviewed glossary |
| Imperial units for Egyptian users (fl oz, lb) | Appediet-like app | Metric by default |
| Red for exceeding a goal | Common | Apricot + calm message |

---

## 9. Flutter implementation notes

- Use Material 3 (`useMaterial3: true`) with `ColorScheme` built from the tokens in section 3.
- Suggested mapping:

| Token | `ColorScheme` field |
|---|---|
| Primary / On-primary | `primary` / `onPrimary` |
| Primary container | `primaryContainer` |
| Accent / On-accent | `secondary` / `onSecondary` |
| Background | `surface` (or `background` on older Flutter) |
| Surface | `surfaceContainer` family |
| Outline | `outline` |
| Text primary | `onSurface` |
| Text secondary | `onSurfaceVariant` |
| Error | `error` |

- Put macro colors in a `ThemeExtension` (e.g. `NesbaColors { protein, carbs, fat }`) so they get light/dark variants and are not hard-coded in widgets.
- Keep all tokens in one file (`app_tokens.dart`) and reference them everywhere; no raw hex in widgets.
- Add golden/widget tests for key states in light, dark and RTL (see `ui_ux_checklist.md`).

---

## 10. Validate before freezing

1. Render 5 key screens with the chosen font pair (Arabic + Latin + numbers) on a real device.
2. Compute contrast for dark-mode macros, dark container, and the final success color.
3. Run a color-blind simulation on macro colors.
4. Confirm tabular-figure support if Readex Pro is chosen.
5. Review with the team and record decisions in `ux_decisions_log.md`.
