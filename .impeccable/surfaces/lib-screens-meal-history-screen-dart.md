# Meal History — Shape Brief

## Purpose and audience

Meal History is an Android screen for general users who want to review meal entries. The current work is a visual, UI-only exploration with illustrative examples; it does not represent real user records.

## Status of inputs

### Documented baseline requirements

- **FR-07:** Users can save meals.
- **FR-08:** The system displays meal history.
- **FR-10:** The system synchronizes meal information through Firebase Cloud Firestore.
- **UC-03:** Its main flow describes saving a meal, storing it through the data layer, synchronization, and access from another device. The main flow is marked `[E]` in `02-use-cases.md`.

These are documented requirements, not implementation approval for this UI-only stage. The requirements document identifies the data-layer ownership gap in OI-05 as blocking the save, history, and synchronization capability.

### Proposed source material

- UC-03's authentication precondition, cross-device postcondition, and alternate flows are marked `[P]`.
- **UC-09 — Save Meal** is marked `[P]` in `02-use-cases.md`.
- `08-ui-ux.md` is marked `[P]`. Its §8.4.6 wireframe proposes day headings, meal types, times, nutrition values, sync badges, and swipe-to-delete. These are wireframe ideas, not approved screen requirements.
- The proposed five-tab navigation in §8.3 is not approved. OI-05 also leaves the history/data-layer owner unassigned.

## Selected composition

**Option 2 — Day card stack**, selected by the team for this Shape round (seed `seed:460c232a5730f312`). Use roomy, separate tonal meal cards grouped under simple day headings. Keep the meal type and short meal description easy to scan, with the time presented as secondary context. The composition is approved as visual direction only; the full screen brief remains subject to review.

## Visual direction and hierarchy

- Inherit the selected **Bustan Light** identity and the existing Material 3 conventions: warm pale ground, quiet green tonal cards, forest-green emphasis, rounded surfaces, and IBM Plex Sans typography as used by the application theme.
- Use a single-column, scrollable Android layout with a clear screen title, a prominent sample-content disclosure, and day groups containing separate roomy cards.
- Each sample card may show an illustrative meal type, time, and short meal description. Do not show nutrition figures.
- Keep the interface informational. Do not add card actions, a bottom navigation bar, or an assumed route into or out of this screen.
- Use directional layout values and preserve readable screen-reader order and text scaling. Product name and localization remain unresolved; do not add a wordmark or translations.

## Content and states

- The populated preview uses a small set of clearly marked sample entries grouped under illustrative day labels. The disclosure must state that entries are examples and have not actually been saved or synchronized. Individual cards should also carry a concise example marker so the status remains clear while scanning.
- **UI-only empty-state proposal:** If an exploration needs an empty visual, show a quiet neutral illustration or icon and the line “No examples are shown in this preview.” This is only a visual preview state; it does not define real empty-history behavior or add an action.
- Loading, network error, retry, synchronization, and deletion states are outside this UI-only brief because they would imply unapproved data behavior.

## Explicit exclusions

- No nutrition figures, calorie values, or derived summaries.
- No sync indicators, deletion, swipe actions, filtering, sorting, or date-selection controls.
- No real saving, persistence, Firebase, API, backend, database, or authentication.
- No production navigation or assumption that the proposed five-tab structure is approved.
- No assumption about how a meal reaches this screen or where the user goes next.

## Dependencies and unresolved decisions

- OI-05 leaves ownership of the persistence/data layer and Meal History work unassigned. Real history and synchronization cannot be implemented from this brief.
- Authentication is still proposed in FR-16–FR-19 and UC-04; it is not an approved prerequisite for this preview.
- Product name, localization, entry point, destination, and production navigation remain unresolved.
- The final behavior for saving, persistence, synchronization, deletion, filtering, sorting, and real empty/loading/error states needs team decisions before corresponding behavior is implemented.

## Review boundary

This brief records the selected composition and defines a UI-only visual direction. It does not approve UC-03 or UC-09 as new product scope, resolve OI-05, or authorize implementation of persistence or navigation. No completed screen is in scope for modification.
