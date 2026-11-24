---
version: 1
slug: "lib-main-dart"
primary_target: "lib/main.dart"
related_targets: []
---

# Login and Register — Surface Brief

## Scope and visitor mode
- New Android access screens for general users tracking and improving their diet; mode: Operate.
- Visual planning only. Authentication is proposed and is not approved for implementation.
- Working journey assumption: returning users sign in to enter the app; new registrants continue to first-run dietary setup. This routing is not a product commitment.

## Audience, task, outcome, and constraints
- Audience may have little or no nutrition expertise; Login/Register is a short, private, one-handed phone task.
- Use email/password as the proposed form pattern shown in Phase 4. Show a Google sign-in button on both screens as UI-only presentation; do not connect a provider or imply authentication is available.
- Preserve product constraints: no image-based meal recognition, barcode scanning, medical advice, or allergen-safety guarantees.
- Android is the only committed platform. Do not infer a tablet support commitment.

## Selected direction and memorable moment
- Selected visual world: Bustan.
- Selected composition: B — Tonal Form Panel, approved for implementation planning.
- Both screens share a separate, prominent heading followed by a restrained tonal panel containing labeled fields, the primary action, and a secondary outlined Google sign-in button separated by an “or” divider. The transition between Login and Register is a clear text link outside the panel.
- Product name and logo are omitted until decided.

## Direction contract

**THESIS:** Make account entry feel clear and trustworthy through one calm, familiar task surface; keep the form, rather than branding or decoration, as the focus.

**OWN-WORLD:** Use Bustan Material 3 roles: warm green-tinted surface (#F7FBF2), tonal surfaceContainer (#EBEFE6), primary #38693C, white onPrimary, clay tertiary #8C4A21 only where needed, IBM Plex Sans Arabic + IBM Plex Sans type pairing, 4dp spacing rhythm, 16dp screen/panel insets, 12dp panel corners, 8dp outlined fields, stadium primary buttons, and no arbitrary card shadows. These are the selected direction’s design tokens; no application theme is changed by this brief.

**STORY:** Returning users enter email and password and submit. New users switch to Register, provide the proposed account fields, and submit. The assumed next routes are the existing app for Login and dietary setup for registration; both remain working assumptions.

**FIRST VIEWPORT:** On a compact Android phone, place the screen heading and short supporting line above a single-column tonal panel. Inside, order labeled fields, the full-width primary action, an “or” divider, and a full-width outlined “Continue with Google” button. Place the reciprocal Login/Register link below the panel. Keep the composition scrollable when the IME is open; do not add a logo, reset link, or decorative hero.

**FORM:** B — Tonal Form Panel, the user-selected composition. The earlier concept round represented a superseded visual world; no seed reference is carried forward.

**FINISH:** unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance

## Shared patterns, states, and accessibility
- Proposed fields: Email and Password on both screens. A Confirm Password field on Register remains a proposal and must not be treated as settled.
- Proposed interactions: show/hide password, required-field and basic email-format feedback, inline submit progress with duplicate-submit prevention, and plain-language errors that keep the user’s email available. The Google button is UI-only; tapping it shows that Google sign-in is not connected. Do not define password strength, complexity, or length rules or show a successful authentication state.
- States to plan: empty/idle, focused, validation error, submitting, service error, and successful route transition. Email verification behavior is unresolved; do not add a verification screen or success claim.
- Use Material 3 outlined text fields, filled primary action, text links, visible labels, clear focus indication, and accessible labels for icon-only controls. Minimum touch target: 48dp; keep at least 8dp between adjacent targets; support system text scaling and screen readers.
- Respect Android system bars and IME/window insets. Keep content in a single scrollable column so fields and the primary action remain reachable above the keyboard; avoid fixed-height layouts and horizontal positioning.
- Use logical start/end alignment and direction-aware layout primitives. This preserves RTL readiness without deciding localization, Arabic copy, or launch languages.

## Selected decisions, proposals, and unresolved items
- Selected: Bustan direction; B — Tonal Form Panel; shared visual language and layout hierarchy above; Android target; a visible, UI-only Google sign-in button on both screens.
- Proposed only: authentication feature; email/password account pattern; visibility toggle; basic validation and interaction states; Confirm Password; routing assumption.
- Unresolved: product name, branding assets/wordmark, localization and launch languages, Confirm Password requirement, password policy, email verification, password reset, and authentication approval.
