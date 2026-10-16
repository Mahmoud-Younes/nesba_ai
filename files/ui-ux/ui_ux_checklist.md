# UI/UX Phase Checklist (Proposed)

> **Status: PROPOSED.** Use as a working checklist; tick items per screen or per release.
> Date: 2026-10-15

## A. Decisions needed before designing

- [ ] Font pair confirmed after a rendering test (see `suggestion_design.md` §2, §10)
- [ ] Palette confirmed; dark-mode contrast computed
- [ ] Target users and main scenarios written down (who logs, when, why)
- [ ] MVP scope agreed (see `information_architecture.md` §6)
- [ ] Sign-in required or optional?
- [ ] Offline expectations for AI logging (draft + retry?)
- [ ] Design tool and file owner chosen (e.g. Figma) and shared with the team
- [ ] Arabic tone decided (MSA-lite vs dialect) and reviewer named

## B. States for every screen

- [ ] Default / filled
- [ ] Empty (one sentence + one action)
- [ ] Loading (skeleton, not a spinner over blank space)
- [ ] Error with retry
- [ ] Offline
- [ ] Over-goal (apricot, calm wording)
- [ ] Long text / large font scale (130%)
- [ ] Light and dark theme

## C. RTL and Arabic QA

- [ ] No hard-coded left/right; start/end used
- [ ] Directional icons mirrored, non-directional icons not mirrored
- [ ] Number pairs (`value / goal`) render in the right order
- [ ] One digit system everywhere (Latin by default)
- [ ] `letterSpacing: 0` on Arabic text; no italic/UPPERCASE for Arabic
- [ ] No clipped text in rings, chips, table headers (longest labels tested)
- [ ] Mixed Arabic/Latin lines look consistent (e.g. dish names in Latin)
- [ ] Chart axes direction decided and consistent
- [ ] Week starts Saturday (or follows setting)
- [ ] All strings come from the glossary or were reviewed

## D. Accessibility

- [ ] Text contrast ≥ 4.5:1 (3:1 for large text and graphics)
- [ ] Touch targets ≥ 48 dp
- [ ] Meaning never conveyed by color alone (macros, goal status)
- [ ] `Semantics` labels for rings and charts
- [ ] Works at 130% font scale
- [ ] Animations respect reduced-motion

## E. AI-specific UX

- [ ] Estimates are visibly estimates (disclaimer + confidence)
- [ ] Every AI result is editable before and after saving
- [ ] Low-confidence items ask for confirmation
- [ ] AI failure never loses the user's text
- [ ] Slow AI shows progress and can be cancelled
- [ ] Health disclaimer present where advice is given
- [ ] Profile data collection minimal, with a short reason for each field
- [ ] Target calculation explained ("why this number?")

## F. Visual QA

- [ ] Only tokens used (no raw hex in widgets)
- [ ] Spacing from the scale (4/8/12/16/24/32)
- [ ] Consistent card radius and chart card structure
- [ ] Apricot under ~10% of any screen, never used as text on light backgrounds

## G. Handoff to Flutter

- [ ] Tokens file (`app_tokens.dart`) + `ThemeData` light/dark
- [ ] Macro colors in a `ThemeExtension`
- [ ] Fonts bundled as assets (3 weights each)
- [ ] Icons/illustrations exported (SVG where possible)
- [ ] Screen specs include all states from section B
- [ ] Golden/widget tests for key screens in: light, dark, RTL, 130% font scale

## H. Usability test plan (small, capstone-friendly)

- **Participants:** 5 people in the target group (include non-technical users).
- **Prototype:** clickable low-fi/mid-fi of S4, S5, S6, S8.
- **Tasks:**
  1. "You just ate a plate of koshari. Add it." (S5 → S6)
  2. "Fix the portion you think is wrong." (S6)
  3. "How many calories do you have left today?" (S4)
  4. "How did your week look?" (S8)
  5. "Why is your daily target this number?" (S3 / S12)
- **Measure:** task success, time on task, number of wrong taps, comprehension of "remaining" and confidence chips, and one question: "would you trust this number?"
- **Fix first:** anything that 3 of 5 participants stumble on.
