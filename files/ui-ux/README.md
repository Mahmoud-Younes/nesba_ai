# Nesba (نسبة) — UI/UX Phase Docs

Reference docs for the UI/UX phase of **Nesba** (brief title: *NutriVision — AI-Driven Dietary Health Assistant*), a Flutter app, Arabic-first, built by a team of 5 as a graduation capstone.

Brief essentials: AI-generated nutrition advice/recipes from meal descriptions · GridView/Stack UI with meal history and charts · Dio with interceptors for nutrition APIs · Cloud Firestore sync · unit and widget tests.

Created: 2026-10-15 · Language: English (Arabic strings appear only where they are UI text).

## Status legend

- **Observed** — seen in competitor screenshots (`competitor_ui_analysis.md`).
- **Proposed** — suggested, **not** a team decision.
- **Decided** — agreed by the team (tracked in `ux_decisions_log.md`; none yet).

## Reading order

1. `ux_decisions_log.md` — what was proposed, open questions, next steps
2. `suggestion_design.md` — typography, color, tokens, components, RTL, accessibility
3. `information_architecture.md` — navigation, sitemap, screen inventory, MVP scope
4. `user_flows.md` — core flows and edge cases
5. `microcopy_glossary_ar.md` — Arabic terms and sample copy
6. `ui_ux_checklist.md` — states, RTL/accessibility QA, handoff, usability test plan
7. `competitor_ui_analysis.md` — evidence behind the suggestions

## Notes for AI agents using these files

- Treat anything marked **Proposed** as a suggestion. Check `ux_decisions_log.md` for the current status before implementing.
- UI is **Arabic-first, native RTL**. Use `start`/`end`, not left/right. Numbers and `value / goal` pairs render LTR.
- Digits: Latin (0-9) by default. Units: metric.
- Use tokens from `suggestion_design.md`; do not hard-code hex values in widgets.
- Over-goal state uses apricot and calm wording, **never red**.
- No ads, no floating timers, no locked data rows in MVP.
- Arabic strings: use `microcopy_glossary_ar.md`; flag any new string for review.
- Competitor material is for patterns only; do not copy visuals or branding.
- App identities for three competitors are unconfirmed; do not state them as facts.
- Do not invent medical advice or macro defaults; flag for review by a nutrition specialist.
