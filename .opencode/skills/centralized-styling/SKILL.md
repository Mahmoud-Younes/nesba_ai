---
name: centralized-styling
description: Enforces centralized styling for this Flutter project. All colors live in app_colors.dart, all gradients in app_gradients.dart, all text styles in app_text_styles.dart. Hardcoded Color, LinearGradient/RadialGradient/SweepGradient, or TextStyle values are forbidden in widget files. Before adding a token, search for an existing match and reuse it; if the name is wrong, rename the constant and all call sites instead of duplicating. For images/assets, reuse existing registered files. Use whenever editing or generating any Dart widget code, building UI from Figma, or adding a color/gradient/text style.
---

# Centralized Styling Rule

**All visual styling values — colors, gradients, text styles — live in three dedicated files and are referenced from there. Nothing else.** Hardcoded styling in widget files is forbidden.

| File | Contains | Class |
|---|---|---|
| `lib/core/theme/app_colors.dart` | Core, reusable `Color` constants | `AppColors` |
| `lib/core/theme/app_gradients.dart` | All reusable `Gradient` constants | `AppGradients` |
| `lib/core/theme/app_text_styles.dart` | Core typography / `TextStyle` constants | `AppTextStyles` |

Images and other assets are **not** in these files; they live under `assets/`, are listed in `pubspec.yaml`, and are accessed via generated `Assets.*` accessors (see `flutter-gen` and `figma-mcp-local-images` skills). The same reuse-before-add idea applies to assets.

## Reuse before you add

Do **not** introduce a second constant for the same visual token.

1. **Search first** in the three theme files (and in widgets for existing references).
   - **Color:** same ARGB / same role as an existing `AppColors.*` → use it.
   - **Gradient:** same type, stops, colors, begin/end → use it.
   - **Text style:** same family, size, weight, height, spacing, default color → use it.
2. **If the value matches but the name is wrong** for how the app now uses it (e.g. an `onboarding`-prefixed token now shared app-wide), **rename** the constant to a name matching current usage and **update every call site in one change**. Prefer one well-named symbol over two names pointing at identical values.
3. **Never** add a duplicate constant "for clarity" when the value is identical.
4. Only when no existing token matches do you **add** a new named constant in the dedicated file, then reference it from widgets.

## Process for every genuinely new value

1. Open the dedicated file (`app_colors.dart`, `app_gradients.dart`, or `app_text_styles.dart`).
2. Add a named constant with a **semantic** name aligned to current usage (not an obsolete Figma label).
3. Save the file.
4. Reference the constant from the widget — never inline the raw value.

Never inline `Color(0xFF...)` / `TextStyle(...)` "for now". Add it to the dedicated file the first time.

## Rules

- **Colors:** `app_colors.dart` holds only `Color`/`MaterialColor` constants. No raw hex in widgets; no `Colors.<name>` from the Material palette outside `app_colors.dart`. Name semantically (`error` not `red`), hierarchy via suffix (`primary`, `primaryLight`). Two names for one value is acceptable only when they are genuinely two roles.
- **Gradients:** `app_gradients.dart` holds only `Gradient` constants and must compose from `AppColors` (never raw hex). Inline gradients in widgets are forbidden even if their colors come from `AppColors` — name the gradient. Name by purpose (`hero`, `splash`), one gradient per role.
- **Text styles:** `app_text_styles.dart` holds only `TextStyle` constants; colors must come from `AppColors`. `copyWith` is fine for one-off per-usage tweaks; if the same `copyWith` chain appears in ~3 places, promote it to a named constant. A `copyWith` so large it redefines most of the style is a new style — add it to `AppTextStyles`. Name by typographic role (`h1`, `bodyLarge`, `button`).

## Detection / audit

These greps must all return zero results:

```bash
grep -rn "Color(0xFF" lib/ --include="*.dart" | grep -v "lib/core/theme/app_colors.dart"
grep -rnE "Colors\.[a-z]" lib/ --include="*.dart" | grep -v "lib/core/theme/app_colors.dart"
grep -rnE "(Linear|Radial|Sweep)Gradient\(" lib/ --include="*.dart" | grep -v "lib/core/theme/app_gradients.dart"
grep -rn "TextStyle(" lib/ --include="*.dart" | grep -v "lib/core/theme/app_text_styles.dart"
```

## Acceptable exceptions (narrow)

- `app_theme.dart` / `ThemeData` builders may **consume** all three to construct `ColorScheme`/`TextTheme` — they don't define new inline values.
- Generated files (`*.gen.dart`, `*.g.dart`, `*.freezed.dart`) are exempt.
- Test files may inline values when verifying a specific rendered color/style.

## Why

Designer changes propagate from one place; dark mode/theming becomes possible; accessibility audits are tractable; naming forces design clarity; new developers find styling in one place.
