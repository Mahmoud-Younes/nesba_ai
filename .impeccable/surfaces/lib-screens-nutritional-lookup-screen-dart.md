---
version: 1
slug: "lib-screens-nutritional-lookup-screen-dart"
primary_target: "lib/screens/nutritional_lookup_screen.dart"
related_targets: []
---

# Nutritional Lookup / Log — Shape Brief

## Job, audience, and outcome
- Android UI for general users describing a meal in natural language. Keep the description field as the primary task and make the flow understandable without nutrition expertise. Visitor mode: Operate.
- The screen lets the user enter a meal description, optionally choose Breakfast, Lunch, Dinner, or Snack, and activate Analyze.
- This is a UI-only exploration. It does not perform a real analysis or save a meal.

## Selected direction and composition
- Selected visual identity: Bustan Light, consistent with the existing Login/Register and Onboarding surfaces.
- Selected composition: **Option A — One composer, attached preview.** Keep the multiline meal description, optional meal type, and primary Analyze action together in one tonal panel. Place the illustrative result preview directly below that panel in the same scrollable screen.
- Preserve the natural-language field as the first and most prominent control. Do not add Food Search, extra sections, production navigation, or a product wordmark.

## Visual language and layout
- Reuse the existing Material 3 Bustan Light theme, IBM Plex Sans typography, surface `#F7FBF2`, tonal panel `#EBEFE6`, and primary `#38693C`.
- Use the established 4dp spacing rhythm, 16dp screen/panel insets, 12dp panel corners, outlined white input surface, and stadium primary button. Avoid arbitrary shadows.
- Use a single-column Android layout with safe-area and keyboard-inset handling, scrolling when content or the keyboard requires it, system text scaling, logical layout direction, screen-reader labels, and at least 48dp touch targets.
- Do not choose a product name, logo, translated copy, launch language, or localization policy here.

## Interaction and UI-only states
- **Initial/input:** Show an empty multiline description field. Meal type is optional and single-choice; the exact control style and whether an option is preselected remain open. The selected composition sketch highlights Lunch only to demonstrate a selected visual state.
- **Validation:** An empty description shows a concise validation message. Do not impose a minimum character count or add other validation rules.
- **Loading:** Activating Analyze with non-empty text shows a short simulated loading state. No network request is made.
- **Illustrative result:** After simulated loading, show a result preview inline below the composer. Label the sample content and all sample values clearly as illustrative and not calculated from the user's meal; do not present it as a real AI analysis.
- **Simulated error and retry:** Provide a separate simulated error state with Retry. Retry returns through the short simulated loading state and then shows the illustrative sample result. Do not imply that a real service was contacted or that the user's meal was analyzed.
- Do not add save, history, cancel, search, or navigation behavior.

## Requirements and decisions
- Baseline source requirements: FR-01 (meal descriptions), FR-02 (AI analysis), FR-03 (nutritional recommendations), FR-11 (API/connection errors), FR-13 (responsive UI), FR-14 (input validation), and FR-15 (loading/error states) in `03-requirements.md` §3.3.1. This UI-only screen represents analysis-related states without implementing FR-02 or connecting a service.
- Food Search and UC-08 remain excluded from this surface while OI-04 (nutrition data source) is unresolved. Do not assume USDA, Gemini lookup, or another provider.
- No authentication requirement is added. UC-01's authentication inclusion is marked proposed in `02-use-cases.md` and is outside this screen's UI-only scope.
- Product constraints remain in force: no image-based recognition, barcode scanning, medical advice, or allergen-safety guarantees.
- Open: exact validation wording; meal-type control and default selection; sample fields and values; loading duration; error wording; and any future analysis-result destination. Product name and localization remain unresolved.

