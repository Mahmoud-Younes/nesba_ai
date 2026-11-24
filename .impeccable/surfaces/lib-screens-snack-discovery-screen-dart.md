---
version: 1
slug: "lib-screens-snack-discovery-screen-dart"
primary_target: "lib/screens/snack_discovery_screen.dart"
related_targets: ["lib/screens/ai_recipe_generator_screen.dart", "lib/screens/onboarding_screen.dart"]
---

# Snack Discovery — Shape Brief

**Shape status: Approved.** This approval covers the visual direction and the explicitly confirmed UI interaction decisions below; it does not approve the proposed product use case or service behavior.

## Job, audience, and outcome
- Android UI for general users who want an alternative idea for a snack they are craving. The user enters the craving as free text; this flow does not assume a snack was selected elsewhere. Visitor mode: Operate.
- This is a visual exploration, not real snack discovery or generation. The chosen composition is **Option 2 — Craving-to-alternative pair**.
- The UI should make the user's original craving and the alternative idea unmistakably distinct, with plain language and no nutrition expertise required.

## Confirmed scope and selected composition
- Use the selected **Bustan Light** visual identity and existing Material 3 conventions. Build for Android as a single-column mobile screen with accessible scrolling and system text scaling.
- Keep the **free-text craving input in its own card**. Use a clear heading, a short explanation, and a helpful example placeholder; example: “A chocolate bar”.
- Show **Preference context** only when explicit preference data is supplied to this flow. Keep it read-only, with no edit controls. Hide the entire section when no preference data is supplied. Do not assume a saved dietary profile, persistence, macro goals, or approved preference labels. Any labels in a sketch or preview are illustrative only.
- Place a primary **Discover alternatives** action after the craving and optional context.
- Keep Discover alternatives disabled while the craving field is empty or contains only whitespace. Enable it as soon as the field contains non-whitespace text. Do not show an error message or validation banner for an empty field.
- After a UI-only simulated loading state, show a separate comparison area with two vertically paired cards: **Your craving** repeats the user's entered words, and **Alternative idea** contains the illustrative sample. A quiet connector between cards may reinforce the relationship. Keep both labels visible when scrolling.
- The sample alternative may show a title plus illustrative supporting content, such as example ingredients and a short preparation note. Clearly mark all of it as sample preview content, not real AI output or personalized advice.

## Visual direction and accessibility
- Inherit the established Bustan Light tokens: page surface `#F7FBF2`, tonal surface `#EBEFE6`, primary `#38693C`, IBM Plex Sans, and the current 4dp spacing rhythm.
- Use clear headings, logical reading order, direction-aware layout, screen-reader labels, visible focus, and minimum 48dp action targets. The free-text field remains the primary task.
- Use a scrollable single column that remains usable on compact Android screens and at large system text sizes. RTL readiness is a layout constraint only; do not choose language, copy translation, or localization policy.
- Do not add bottom or production navigation, a product name, or wordmark.

## Interaction and states
- **Initial:** The craving field is empty and shows its example placeholder. No alternative result is shown yet. If preference data is absent, omit its section completely.
- **Craving action availability:** Discover alternatives is disabled for empty or whitespace-only input and enabled as soon as non-whitespace text is entered. Do not display an empty-field error or validation banner.
- **Preference context:** When explicitly supplied, present it as read-only context. The absence of supplied context does not create an empty-state message or profile prompt.
- **Loading (UI-only):** Tapping Discover alternatives shows a short simulated loading state. It makes no API, backend, database, or AI request. Keep the action's pending state accessible and clearly describe this as a preview.
- **Illustrative result:** After the simulation, show the repeated original craving and a distinct Alternative idea card with example content. Suggested sample disclosure: “Illustrative preview only · not AI-generated or personalized.” No sample values or claims should appear as verified, calculated, or tailored.
- **Empty result and error/retry:** Empty-result behavior, service error, retry flow, and loading duration/copy remain unresolved. Any later visual proposal must not imply real service integration.

## Requirements and approval status
- **Baseline system requirement:** FR-06 says the system should suggest healthier alternatives to meals or snacks. FR-05 concerns dietary restrictions and FR-15 requires loading/error states; FR-13 covers responsive UI. See `03-requirements.md` §3.3.1. These requirements do not approve real AI, data, profile, or persistence behavior for this UI-only stage.
- **Proposed use case:** UC-06 `[P]` in `02-use-cases.md` describes entering a craving, adding dietary restrictions and macro goals to a prompt, receiving a Gemini alternative, displaying a side-by-side comparison, and bookmarking it. Only free-text craving entry is confirmed for this exploration. Macro goals, Gemini integration, bookmarking, and the stored-profile assumptions are excluded.
- **Proposed wireframe:** `08-ui-ux.md` §8.4.5 shows calorie/sugar figures, “saves” copy, Bookmark, Swap, and bottom navigation. These are not approved and are excluded here. The document is marked `[P]`; its wireframe is a proposal, not a requirement.
- **Selected design decision:** Option 2 — Craving-to-alternative pair, selected as the second card in the Snack Discovery composition round (`seed:2596fe2d336017d9`). This approves the composition direction only; it does not approve UC-06 as a product feature or its backend requirements.

## Scope and exclusions
- UI-only local simulation; no real AI, API, backend, database, persistence, authentication, bookmarks, swap behavior, or production navigation.
- No nutrition figures, calorie/sugar savings, health ratings, health guarantees, medical claims, allergen toggles, or allergen-safety guarantees.
- Do not assume a saved profile or macro goals. Do not add preference editing controls or present sample preference labels as approved choices.
- Keep product name, localization, entry point, and destination unresolved.

## Open decisions
- Whether UC-06 is approved as a product feature; its current use-case status is `[P]`.
- Empty-result behavior, loading duration and copy, and any error/retry presentation.
- Whether and how explicit preference data reaches this screen, and which preference labels (if any) are approved. Do not assume profile persistence.
- Future source and method for any nutrition comparisons; OI-04 leaves the nutrition provider unresolved.
- Future AI provider, request/response schema, retry details, and API-key/security architecture; P-16/P-17 are proposed and OI-07 remains open.
- Bookmarking or saving and data ownership/persistence; these remain outside scope, with OI-05 unresolved.
- Production entry point, destination, product name, and localization policy.

## Direction contract

**THESIS:** Let the user's craving lead, then make the sample alternative easy to compare without implying a health judgment or real generation.

**OWN-WORLD:** Bustan Light page and tonal surfaces, IBM Plex Sans, the established spacing rhythm, rounded Material 3 surfaces, and the existing green primary action. No added brand identity or decorative nutrition metrics.

**STORY:** The user types a craving. Explicitly supplied preference context may appear read-only; without it, the section is absent. Discover alternatives shows a simulated loading state and then two distinct cards: the original craving and a clearly illustrative alternative.

**FIRST VIEWPORT:** A neutral heading and short explanation; a dedicated craving-input card with a helpful example; optional read-only preference context only when supplied; and a full-width Discover alternatives action. After simulation, the result section repeats the craving and shows the separate Alternative idea card. The one-column page scrolls on compact screens.

**FORM:** Option 2 — Craving-to-alternative pair; selected from the second card in the composition round; seed:2596fe2d336017d9.

**FINISH:** Shape approval covers visual direction only. Product approval, all service behavior, navigation, and persistence remain outside this brief.
