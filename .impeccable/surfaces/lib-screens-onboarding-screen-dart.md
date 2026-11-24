---
version: 1
slug: "lib-screens-onboarding-screen-dart"
primary_target: "lib/screens/onboarding_screen.dart"
related_targets: ["lib/screens/login_screen.dart","lib/screens/register_screen.dart"]
---

# Onboarding — Shape Brief

## Scope and visitor mode
- Android UI-only onboarding for general users who want to state dietary preferences and restrictions that may inform future recommendations; mode: Operate.
- Support first-run use and a later Settings editing entry point.
- Do not assume authentication, remote/local persistence, or a post-onboarding route.

## Audience, task, outcome, and constraints
- Users may have little or no professional nutrition knowledge; use familiar, beginner-friendly wording.
- Keep the task focused on user-stated dietary preferences and ingredients they prefer to avoid.
- Do not add daily targets, medical conditions, health assessments, or other medical intake.
- The product does not provide medical advice or guarantee allergen safety.
- Android is the only committed platform. Product name and localization remain unresolved.

## Selected direction and content basis
- Selected visual direction: Bustan. Keep the established Login/Register visual language: Material 3, light Bustan palette, IBM Plex Sans typography, tonal surfaces, outlined inputs, and stadium primary actions.
- Selected composition: Option 1 — Two questions, one tonal panel. Place a top-aligned heading above one shared tonal panel; clearly separate Eating Pattern and Ingredients to Avoid inside it.
- Proposed Eating Pattern options (single-select; pending product approval):
  - Vegetarian — “No meat or fish; dairy and eggs may be included.” Prefer suggestions without meat or fish.
  - Vegan — “No foods from animals, including meat, fish, dairy, and eggs.” Prefer suggestions without animal-based foods.
  - Pescatarian — “Fish and seafood are okay; meat and poultry are not.” Prefer suggestions that may include fish or seafood, but not meat or poultry.
- Proposed Ingredients to Avoid options (multi-select; pending product approval): gluten-containing ingredients; Dairy ingredients; and Other.
- Other is optional. Selecting it reveals an optional multiline field; deselecting it hides the field. Preserve its draft text while hidden so it returns if Other is selected again.
- Halal and Kosher are team-review considerations, not approved choices.

## Confirmed Vegan / Dairy interaction
- When Vegan is selected, Dairy remains visible as a non-interactive informational row labeled “Included with Vegan”; it is not represented as an independently selected checkbox.
- If Vegan is deselected, Dairy returns as a normal independent checkbox.
- Preserve a prior explicit Dairy selection across Vegan selection. If there was no explicit Dairy selection before Vegan was selected, restore Dairy unchecked when Vegan is deselected.
- Dairy coverage inherited from Vegan is not a separate user selection.

## Safety, accessibility, and responsive behavior
- Show: “These preferences guide suggestions. They don’t guarantee that a meal or recipe is free from allergens.”
- Keep the disclaimer readable, high contrast, and adjacent to the primary action; do not communicate it by color alone.
- Use accessible radio-group, checkbox, and inherited-coverage semantics; announce the Vegan/Dairy state change to screen readers.
- Provide visible labels, logical focus order, system text scaling, direction-aware layout primitives, and touch targets at least 48dp.
- Use a single scrollable column with Android safe-area and IME-aware behavior. The revealed Other field must remain reachable when the keyboard is open.

## Proposals and unresolved decisions
- UI-only selection state; do not implement authentication, a persistence service, or a real save operation.
- Skip behavior, behavior with no selections, persistence, primary action label/behavior, and post-onboarding destination remain unresolved.
- Exact option wording and treatment of any additional dietary patterns remain subject to team review.
- Localization and launch languages remain unresolved; do not add translated copy or select a product name.

## Direction contract

**THESIS:** Collect user-stated dietary preferences in one familiar Android task, distinguishing a broad eating pattern from ingredients to avoid without splitting the task into separate screens.

**OWN-WORLD:** Use Bustan Light: #F7FBF2 page surface, #EBEFE6 shared tonal panel, #38693C for selected states, IBM Plex Sans, 4dp spacing rhythm, 16dp screen insets, 12dp panel corners, standard Material 3 radio and checkbox controls, and no panel shadow.

**STORY:** Users review proposed dietary choices that may guide future suggestions. Eating Pattern is single-select; Ingredients to Avoid is multi-select. Vegan gives Dairy inherited coverage. Other reveals a multiline field and retains its draft while hidden. These options and their copy remain pending product approval.

**FIRST VIEWPORT:** A top-aligned heading and supporting line precede one full-width shared tonal panel, constrained to the existing 480dp form width. Eating Pattern comes first; a clear internal divider separates Ingredients to Avoid. Keep rows at least 48dp tall. Place the readable allergen disclaimer beside a reserved primary-action area; its label and behavior remain unspecified. The column scrolls when needed.

**FORM:** Option 1 — Two questions, one tonal panel; selected from position 4 in the seeded structure list; seed:6fbae39daec49e49.

**FINISH:** unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
