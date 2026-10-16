# UX Decisions Log & Conversation Record

> Purpose: document the UI/UX study conversation, what was **proposed**, what is still **open**, and what to do next.
> Date: 2026-10-15 · Status legend: **Proposed** (suggested, not agreed) · **Open** (needs input) · **Decided** (team agreed — none yet).

## 1. Conversation timeline

| Step | Request | Output |
|---|---|---|
| 1 | Act as a senior UI/UX designer and study existing competitor examples (18 screenshots: DietAI + a second English dark app) | Per-app strengths/weaknesses, comparison table, opportunities, design principles |
| 2 | 12 more screenshots (3 more apps: an Arabic dark app, FatSecret, a YAZIO-like app) | Per-app analysis, cross-cutting findings, updated recommendations |
| 3 | Suggest Arabic and English fonts and colors | Font pair options, type scale, palette with computed contrast |
| 4 | Write `suggestion_design.md` and other files documenting the conversation and anything important for the UI/UX phase | This folder (`ui-ux/`) |

## 2. Decisions and proposals

| ID | Topic | Proposal | Status |
|---|---|---|---|
| D-01 | Fonts | IBM Plex Sans Arabic + IBM Plex Sans; alternatives: Readex Pro, or Tajawal + Inter | Proposed |
| D-02 | Color direction | Teal `#0F766E` + Apricot `#F59E42`; alt: Sage + Terracotta | Proposed |
| D-03 | Digits | Latin digits (0-9) by default | Proposed |
| D-04 | Navigation | Bottom bar with a central Log action integrated in the bar | Proposed |
| D-05 | Home hierarchy | Remaining-calories hero → macros → meals → AI tip | Proposed |
| D-06 | AI logging | Text-first, editable result with confidence levels | Proposed |
| D-07 | Monetization | No ads, no floating timers, no fully locked data rows | Proposed |
| D-08 | Over-goal state | Apricot + calm message, not red | Proposed |
| D-09 | Units | Metric by default | Proposed |
| D-10 | Themes | Light and dark from day one | Proposed |
| D-11 | Scope | Community, shopping list, fasting are out of MVP | Proposed |
| D-12 | Week start | Saturday by default (setting) | Proposed |
| D-13 | Arabic copy | Reviewed glossary; gender-neutral phrasing | Proposed |

## 3. Open questions

1. Was the profile data identical in all competitor apps? (Calorie targets ranged from about 2367 to 3400.)
2. Confirm the identity of the "Appediet-like", "YAZIO-like" and the Arabic dark app.
3. Final font choice after a rendering test on real screens.
4. Target users and main scenarios (who, goal types, age range).
5. Is sign-in required for MVP, or optional?
6. Offline behavior for AI logging.
7. Arabic voice: MSA-lite or Egyptian dialect, and who reviews the text.
8. Design tool and owner inside the team.
9. Do competitor databases contain Egyptian foods? (hands-on test needed)

## 4. Observations and assumptions to keep in mind

- All findings come from static screenshots.
- Contrast ratios were computed for the light-mode palette and several dark-mode pairs; dark-mode macro colors and the dark container color are **not** verified.
- Default macro targets in two competitors looked high; a nutrition specialist should review any default logic Nesba uses.
- Competitor visuals and branding are references for patterns only.

## 5. Suggested next steps

1. Team review of this folder; mark decisions as **Decided** here.
2. Font rendering test with real screens (Arabic + Latin + numbers).
3. Finish the token set (dark-mode contrast, success color) and build `app_tokens.dart` + `ThemeData`.
4. Low-fi wireframes for S4, S5, S6, S8 (see `information_architecture.md`).
5. Hands-on test of competitor apps with Egyptian food inputs.
6. Usability test with 5 users (see `ui_ux_checklist.md` §H).
7. Update `competitor_ui_analysis.md` after confirming app identities.

## 6. File index

| File | Contents |
|---|---|
| `README.md` | Entry point, reading order, notes for AI agents |
| `suggestion_design.md` | Direction, typography, color, tokens, components, RTL, accessibility, Flutter notes |
| `competitor_ui_analysis.md` | Evidence from 30 screenshots across 5 apps |
| `information_architecture.md` | Navigation, sitemap, screen inventory, MVP scope |
| `user_flows.md` | Core flows with edge cases (Mermaid) |
| `microcopy_glossary_ar.md` | Arabic glossary and sample microcopy |
| `ui_ux_checklist.md` | Checklists and a usability test plan |
| `ux_decisions_log.md` | This file |
