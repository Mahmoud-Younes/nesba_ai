---
version: 1
slug: "lib-screens-meal-detail-screen-dart"
primary_target: "lib/screens/meal_detail_screen.dart"
related_targets: []
---

# Meal Detail — Shape Brief

## Job, audience, and outcome
- Android UI for general users who want to understand a meal in plain language without needing nutrition expertise. Visitor mode: Operate.
- Present a meal's original description, optional meal type, an illustrative nutrition snapshot, illustrative analyzed-item breakdown, and neutral informational recommendation.
- This is visual exploration only. It does not analyze, calculate, save, personalize, or retrieve meal data.

## Selected direction and composition
- Selected visual identity: Bustan Light, consistent with the existing app theme and completed screens.
- Selected composition: **Meal context first.** Keep the page single-column and scrollable in this order: (1) Meal context, (2) Nutrition snapshot, (3) Analyzed items, (4) Recommendation.
- Use a compact app bar titled **Meal Detail**. Do not introduce a product name or wordmark.

## Meal context
This section contains exactly these two fields:

1. **Meal Description (required)**
   - Display the original meal description entered by the user.
   - Preserve its wording; do not invent, infer, or rewrite ingredients.
   - Treat it as read-only display content in this screen exploration.
2. **Meal Type (optional)**
   - Supported values: Breakfast, Lunch, Dinner, Snack.
   - Display the selected value when available.
   - If no type was provided, display **Not specified**.
   - Never infer the meal type from the description.

Do not add meal name, date/time, portion size, source, or other metadata to Meal context. Portion details, if approved later, belong in Analyzed items.

## Content and visual language
- Use the existing Material 3 Bustan Light theme, IBM Plex Sans typography, surface `#F7FBF2`, tonal panel `#EBEFE6`, and primary `#38693C`.
- Use established spacing, rounded tonal surfaces, clear section headings, and a single-column layout that scrolls on compact Android screens. Respect safe areas, system text scaling, logical layout direction, screen-reader semantics, and minimum 48dp touch targets.
- The Nutrition snapshot uses clearly named fields with units: Energy (kcal), Protein (g), Carbohydrates (g), and Fat (g). Any displayed values must be clearly labeled illustrative and not calculated from the meal.
- Show only 2–3 illustrative sample items with illustrative quantities and values. Clearly state that the items and quantities are examples, not detected or verified.
- Recommendation copy must be neutral, informational, and non-medical. Avoid labels such as “Healthy”, “Unhealthy”, or “Perfectly balanced”. Clearly label the recommendation as illustrative and not personalized. Do not imply allergen safety.

## Scope and constraints
- No functional Save or Healthier actions.
- No backend, API, database, persistence, production navigation, or assumptions about a nutrition data source.
- Do not imply that the meal was actually analyzed or that any displayed information is saved or personalized.
- Preserve the project constraints: no image-based meal recognition, barcode scanning, medical advice, or allergen-safety guarantees.
- Product name and localization remain unresolved; do not choose a name, wordmark, language, or translation policy.
- Keep the entry point and future destination unresolved.

## Open decisions
- Future entry point and destination for Meal Detail.
- Whether real nutrition values or item breakdowns will be supported, and what approved source and method would provide them.
- Which sample values, item quantities, and recommendation copy the team approves for a future product experience.
- Any future analysis, loading, empty, or error behavior; none is implemented or implied by this visual exploration.
