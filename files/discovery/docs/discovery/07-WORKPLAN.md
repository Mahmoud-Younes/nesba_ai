---
id: DISC-01-07
title: Nesba Discovery, Section 7 (methodology and work plan)
parent: DISC-01
status: draft
last_verified: 2026-10-11
owner: TBD
---

> **AI NOTES**
> - What this is: Section 7, the work plan for Nesba (نسبة; course-brief title NutriVision): method, calendar, sprints, roles, deliverables, Git workflow. Hub: [DISCOVERY.md](DISCOVERY.md). Read [AI_CONTEXT.md](AI_CONTEXT.md) first.
> - Method: a light, Scrum-inspired process with one-week sprints and four recurring meetings; five members (one mid level, four junior), the trainer is team lead. IDs: `SPR-00` to `SPR-07` (scenario S), `SPR-10` to `SPR-23` (scenario L), `ROL-01` to `ROL-05`, `GIT-01` to `GIT-24`, `DEL-001` to `DEL-110` (three digits).
> - Scenario status: the team gave 2026-12-01 as the project end. From 2026-10-12 that is 7.29 weeks, so scenario S applies and scenario L does not. S fits only at about 2.5 productive days per member per week (`ASM-28` says 2.0); at 2.0 it needs cuts (section 2.3). Scenario L is kept for the case that the date moves.
> - Proposed, not approved: dates, loads, role-to-member mapping and every number marked [A]. Names are [T] until the team confirms.
> - Tags: [V:S-xxx] a cited source states it; [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.

# 7. Methodology and work plan

Part of [DISCOVERY.md](DISCOVERY.md). Group 17 (ONL5_SWD8_G1, Cross-Platform project team); trainer and team lead Eng. Ahmed Kachwaa. Effort numbers come from `04-FEASIBILITY.md` (TD-06) and `05-REQUIREMENTS.md` (sizes S 0.5, M 1, L 2 person-days); nothing is re-estimated here, and the few additions are marked [A] and listed in section 13.

## 1. Method

### 1.1 Chosen process

**A light, Scrum-inspired process with one-week sprints.** The Scrum Guide defines a sprint as a fixed length of one month or less, with sprint planning, a daily scrum, a sprint review and a sprint retrospective, and a definition of done for each increment [V:S-118]. This plan keeps the weekly sprint, planning, review, retrospective and definition of done. It replaces the daily scrum with a written check-in, because the team works about 2.5 days a week, and it keeps only four recurring meetings. It is therefore Scrum-inspired and not full Scrum.

Three reasons, tied to the facts of the course:

1. **Weekly trainer assessment.** Each trainee is assessed every week on interim outputs, so a one-week sprint gives every member something to show each week.
2. **Five students, one mid level and four junior, still learning in the course.** Small batches, a backup for every item, pull-request review and short feedback loops let juniors learn while delivering; the group leader and the trainer review the risky items.
3. **Fixed end date, 2026-12-01.** Time-boxed sprints with a capacity check and a written cut order (05 section 10.5) protect the date; scope moves, the date does not.

**Alternatives rejected.**

| Alternative | Why not |
|---|---|
| Kanban only | No weekly commitment, so it is harder to match the weekly assessment and to check capacity against a fixed date |
| Full Scrum with 2 to 4 week sprints and a daily 15-minute meeting | Sprints that long do not fit a 7.3-week project or the weekly assessment, and the team cannot meet daily at 2.5 working days a week |
| Phase gates only (`GT-01` to `GT-05`) | Too coarse; the gates stay as milestones inside the sprints (section 2.4) |

### 1.2 Roles in the process

| Process role | Held by | Duties |
|---|---|---|
| Group leader | Member A (Mahmoud) | Single contact for the trainer; submits the division-of-tasks report and keeps the weekly reports on time; casts the deciding vote when the team is split |
| Product owner | ROL-05 Product/legal lead (Member E) | Orders the backlog by MoSCoW (05 section 10), accepts items against their acceptance criteria, proposes cuts using the order in 05 section 10.5 |
| Sprint facilitator | Rotates weekly: SPR-00 A, SPR-01 B, SPR-02 C, SPR-03 D, SPR-04 E, SPR-05 A, SPR-06 B, SPR-07 C | Runs planning and the retrospective, keeps the timebox, writes the action |
| Trainer and team lead | Eng. Ahmed Kachwaa | Technical guidance, weekly assessment of each member, answers the scope questions raised in section 12 (for example `OPEN-60`, `OPEN-71`, `OPEN-79`) |
| Reviewer | The backup role of each item (section 4.3) | Reviews the pull request; for the high-risk items the mid-level member also reviews (GIT-06) |

### 1.3 Meetings (at most four recurring)

| Meeting | When | Length | Purpose | Output |
|---|---|---|---|---|
| Sprint planning | Day 1 of the sprint | 60 min | Confirm the sprint goal, pull items from the plan in section 3, check each member's load against the capacity, name the backup for every item | Sprint milestone with issues; board updated |
| Mid-sprint sync | About day 4 | 20 min | Blockers, early warning indicators (section 8), re-balance work between primary and backup | Updated board; blockers with owners |
| Sprint review and demo | Last working day of the sprint, with the trainer when he is available | 45 min | Each member shows what they merged; check the exit criteria; collect trainer feedback | Demo notes; items accepted or returned |
| Retrospective | Right after the review | 20 min | One thing to keep, one to change; the facilitator writes one action with an owner | Action in the next planning |

A **daily written check-in** (not a meeting, 5 minutes, working days only): three lines in the team chat: done, next, blocked.

### 1.4 Artefacts

- **Product backlog:** one GitHub issue per `FR-`, `NFR-` or `US-` in `05-REQUIREMENTS.md`, labelled by priority (GIT-12).
- **Sprint backlog:** the sprint milestone (GIT-14) holding the issues of section 3.
- **Increment:** the `main` branch plus the demo at the sprint review.
- **Decision log:** `ADR-` records in `06-DECISIONS.md`, with the registers `A-ASSUMPTIONS.md` and `C-OPEN-ITEMS.md`.
- **Burn-up:** planned against done person-days per sprint (section 8).

### 1.5 Working agreements

1. Nobody pushes to `main`; every change is a pull request (GIT-08, GIT-09).
2. A pull request gets its first review within 2 working days [A:ASM-56].
3. The author can explain every line of the pull request; the reviewer asks at least one explain-back question (GIT-05).
4. AI assistance is declared in the pull request and reviewed by the author before submission (GIT-05).
5. A blocker is raised in the chat within 24 hours, not at the next meeting.
6. Work in progress is limited to 2 items per member (GIT-13).
7. Every decision that changes scope, a threshold or a technology goes into the registers or an ADR the same week.
8. The weekly report is sent the day before the trainer's assessment (section 9.1).

## 2. Calendar

### 2.1 Inputs and formulas

| Symbol | Meaning | Value |
|---|---|---|
| D0 | Start of SPR-00 (a Monday) | **2026-10-12** [A:ASM-57], first Monday after today; the team confirms or gives the real date (`OPEN-77`) |
| F | Final presentation date | **2026-12-01**, the project end the team gave on 2026-10-11 [A:ASM-58]; if the trainer sets an earlier date, F changes and every date below moves |
| Sprint k | Start and end | start = D0 + 7k days; end = start + 6 days; the last sprint ends on F |
| W | Weeks available | W = (F - D0 + 1) / 7 = 51 / 7 = **7.29** |
| Rule | Which scenario | W at least 14: scenario L; W between 8 and 14: interpolate (section 2.6); W below 8: scenario S with fewer build weeks, which is the present case |

### 2.2 Scenario S calendar

Seven full build sprints and a two-day closing sprint. Capacity per member per sprint is the proposed 2.5 productive days [A:ASM-59] (the closing sprint holds 0.7 days).

| Sprint | Starts | Ends | Days | Capacity |
|---|---|---|---|---|
| SPR-00 | Mon 12 Oct 2026 | Sun 18 Oct 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-01 | Mon 19 Oct 2026 | Sun 25 Oct 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-02 | Mon 26 Oct 2026 | Sun 01 Nov 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-03 | Mon 02 Nov 2026 | Sun 08 Nov 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-04 | Mon 09 Nov 2026 | Sun 15 Nov 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-05 | Mon 16 Nov 2026 | Sun 22 Nov 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-06 | Mon 23 Nov 2026 | Sun 29 Nov 2026 | 7 | 2.5 per member, 12.5 team |
| SPR-07 | Mon 30 Nov 2026 | Tue 01 Dec 2026 | 2 | 0.7 per member, 3.5 team |

Scenario L (14 weeks, `SPR-10` to `SPR-23`) would end on 2027-01-17, after the project end, so it does not apply; it is kept in section 3.2 in case the date moves.

### 2.3 Capacity at the stated end date

`04-FEASIBILITY.md` and `05-REQUIREMENTS.md` assume 5 members times 2 productive days times 8 weeks, which is 80 person-days (`ASM-28`). From 2026-10-12 to 2026-12-01 there are 7.29 weeks, so the same assumption gives 72.9 person-days. The table compares capacity at different productive days per member per week with three demands, all computed from the existing files:

- **S, recipes moved down** (05 section 10.4): 79.5 person-days (spikes 8, report and demo 8, Must without recipes and alternatives, 30 dishes).
- **S, all Must items:** 83.5.
- **S, all Must items plus the Google Play track** (section 2.7, [A:ASM-61]): 86.5.

| Productive days per member per week | Capacity (person-days) | S, recipes moved down | S, all Must items | S, all Must plus Play track |
|---|---|---|---|---|
| 2.0 | 72.9 | short by 6.6 | short by 10.6 | short by 13.6 |
| 2.2 | 80.1 | fits, margin 0.6 | short by 3.4 | short by 6.4 |
| 2.5 | 91.1 | fits, margin 11.6 | fits, margin 7.6 | fits, margin 4.6 |
| 3.0 | 109.3 | fits, margin 29.8 | fits, margin 25.8 | fits, margin 22.8 |

**Reading.** At 2.0 days a week the project cannot reach the end date with the scope of scenario S: it is short by 6.6 person-days even with recipes moved down. Minimum productive days that make each case fit: 2.18 (recipes moved down), 2.29 (all Must items), 2.37 (with the Play track). This plan is scheduled at **2.5 days** a week, which leaves a margin of 4.6 person-days over the largest case. The decision is the team's (`OPEN-78`). If the team stays at 2.0 days, apply these cuts in order and ask the trainer (`OPEN-71`): the Play track (3.0), the recipes and alternatives (`FR-39`, `FR-40`, `FR-41`, 4.0), dishes from 30 to 20 (2.5), then the Should-level items that 05 section 10.5 lists; the remaining shortfall would need Must items that carry brief, safety or legal rules, which this plan does not propose to cut.

### 2.4 Gates re-dated to sprints

The dates in `04-FEASIBILITY.md` assume a start around 2026-10-08 and about 6 weeks of capacity before `GT-05`. At 2.5 days a week the work that each gate needs does not fit that early (for example `GT-01` needs the sync and offline items of the Mobile lead, about 5.5 person-days, including `SPK-04`). The table gives the sprint in which the prerequisites end. The difference is recorded in `OPEN-84`.

| Gate | Date in 04 | Plan date (scenario S) | Scenario L sprint | Owner role | Condition (04) | Note |
|---|---|---|---|---|---|---|
| GT-01 | 2026-10-22 | 2026-11-08, end of SPR-03 | SPR-15 (end 2026-11-22) | ROL-01 Mobile lead | Offline sync safe and UI never blocked; Dio chain works | 17 days later than the 04 date |
| GT-01b | 2026-10-22 | 2026-11-08, end of SPR-03 | SPR-15 (end 2026-11-22) | ROL-04 QA/security lead | No secret in APK; App Check enforced | 17 days later than the 04 date |
| GT-02 | 2026-10-29 | 2026-10-25, end of SPR-01 | SPR-13 (end 2026-11-08) | ROL-02 AI lead | Parse model chosen; free-tier limit recorded | 4 days earlier |
| GT-03 | 2026-10-29 | 2026-11-08, end of SPR-03 | SPR-14 (end 2026-11-15) | ROL-03 Data lead | Local layers resolve enough names; dish table started with reviewer | 10 days later than the 04 date |
| GT-04 | 2026-10-30 | 2026-10-30 (inside SPR-02) | SPR-13 (end 2026-11-08) | ROL-05 Product/legal lead | Pilot data policy and consent text approved; legal read done | External date 2026-10-30 (PDPL) holds regardless of the calendar; the items finish in SPR-02, which ends 2026-11-01 |
| SPK-03 | 2026-11-05 | 2026-11-29, end of SPR-06 | SPR-20 (end 2026-12-27) | ROL-02 AI lead | Accuracy baseline on the 30 reference meals | 24 days later than the 04 date |
| GT-05 | 2026-11-12 | 2026-11-29, end of SPR-06 | SPR-21 (end 2027-01-03) | ROL-01 Mobile lead | End-to-end latency and size measured | 17 days later than the 04 date |

### 2.5 Freeze and rehearsal dates (formulas from F)

| Event | Formula | Date |
|---|---|---|
| Rehearsal 1 | F - 7 days | 2026-11-24 |
| Feature freeze | F - 6 days; only items already in SPR-06 may finish | 2026-11-25 |
| Code freeze | F - 3 days; afterwards only `release-blocker` fixes (GIT-19) | 2026-11-28 |
| Rehearsal 2 (with questions) | F - 2 days | 2026-11-29 |
| Report and slides final | F - 1 day | 2026-11-30 |
| Final presentation | F | 2026-12-01 |

### 2.6 When the end date lies between S and L, or below S

Between S and L the plan interpolates the three quantities of `04-FEASIBILITY.md` TD-06 linearly in W [A:ASM-62], on the basis of 2.0 productive days: spikes from 8 to 12, report and demo from 8 to 10, and the build budget is capacity minus both. The Must demand with 30 dishes is 67.5 person-days (05 section 10.4). Rule: use the L plan (section 3.2) and delete sprints from the Should block (SPR-18 onwards) until the sprint count equals W.

| W (weeks) | End date if D0 is kept | Capacity | Spikes | Report and demo | Build budget | Must demand | Result |
|---|---|---|---|---|---|---|---|
| 8 | 2026-12-06 | 80 | 8.0 | 8.0 | 64.0 | 67.5 | short by 3.5 |
| 9 | 2026-12-13 | 90 | 8.7 | 8.3 | 73.0 | 67.5 | fits, margin 5.5 |
| 10 | 2026-12-20 | 100 | 9.3 | 8.7 | 82.0 | 67.5 | fits, margin 14.5 |
| 11 | 2026-12-27 | 110 | 10.0 | 9.0 | 91.0 | 67.5 | fits, margin 23.5 |
| 12 | 2027-01-03 | 120 | 10.7 | 9.3 | 100.0 | 67.5 | fits, margin 32.5 |
| 13 | 2027-01-10 | 130 | 11.3 | 9.7 | 109.0 | 67.5 | fits, margin 41.5 |
| 14 | 2027-01-17 | 140 | 12.0 | 10.0 | 118.0 | 67.5 | fits, margin 50.5 |

The table shows that, on the basis of 2.0 days, the recipes and alternatives fit again from 9 weeks. If F comes **before** 2026-12-01, each week lost removes 12.5 person-days at 2.5 days a week; cut in the order of section 2.3 and take the decision to the trainer.

### 2.7 Google Play track (new goal of the team)

The team's goal is to publish on Google Play after solving the problem well. For a personal developer account created after 2023-11-13, Google requires a closed test with at least 12 testers opted in continuously for the last 14 days before production access can be requested [V:S-123]. Consequences for the calendar:

- To finish the 14 days before F, the closed test must start by F - 14 = **2026-11-17**; the plan targets the end of SPR-04 (2026-11-15), which ends the 14 days on 2026-11-29.
- How long Google takes to review a production request was not read [U]. Publication on or before F is therefore not guaranteed; the plan treats production publication as possibly after F (`OPEN-79`).
- The rule does not apply to a developer account created earlier; which account will publish is unknown (`OPEN-79`).
- The application id must be final before the first upload (`ADR-29`, `OPEN-61`); decide it by the end of SPR-02 (`OPEN-89`).
- Real testers send meal text to the AI model, which `ASM-32` and `GT-04` restrict; a paid tier or a restricted mode is needed before the closed test (`OPEN-90`).
- The track costs about 3.0 person-days (`r1` to `r4` in section 4.3) and is the first thing to drop if capacity falls (section 2.3).

## 3. Sprint plan

Every `FR-` Must requirement is in exactly one sprint per scenario, with a primary and a backup role (section 4.3). Dependencies are respected (an item sits in the same sprint as, or after, the items it needs). Loads per member and sprint are in section 4.2. The Should items of `05-REQUIREMENTS.md` appear only in scenario L.

### 3.1 Scenario S (applies to the stated end date)

Total planned effort 86.5 person-days: all Must requirements, the work implied by non-functional requirements, 30 dishes, spikes (8), report and demo (8), and the Google Play track (3.0, optional). Scenario S in `05-REQUIREMENTS.md` section 10.4 moved recipes and alternatives down because capacity there was 80; here they stay because the capacity is 2.5 productive days per member (section 2.3). If the team stays at 2.0 days, the cuts of section 2.3 apply and `OPEN-71` needs the trainer.

| Sprint | Dates | Goal | Requirements in scope | Experiments and gates | Decisions to approve | Demo | Exit criteria |
|---|---|---|---|---|---|---|---|
| SPR-00 | 2026-10-12 to 2026-10-18 | Repository, toolchain, approvals, sign-in skeleton, Dio client, data schemas, first model test | FR-01, FR-09, FR-12, FR-13, FR-15, FR-56, FR-57, FR-61, FR-63, FR-65; NFR: NFR-02, NFR-18, NFR-23, NFR-26, NFR-28 | SPK-01 (ROL-02) | All 30 ADRs of 06 section 9, first the ones that need team input: ADR-02 minimum Android, ADR-06 Bloc, ADR-15 sign-in, ADR-24 analytics, ADR-29 release format; OPEN-77 dates; OPEN-78 productive days; OPEN-80 repository visibility | The app builds on the team's phones and shows sign-in and the text box; the repository has protected main and the first reviewed pull requests; the model test table exists | Approvals of 06 section 9 recorded; every member merged at least one pull request; USDA subset loader and dish schema merged; model comparison table (SPK-01) started |
| SPR-01 | 2026-10-19 to 2026-10-25 | Parse works on the test set; sync v0; CI blocks merges; wireframes and first notice screens | FR-17, FR-21, FR-32, FR-33, FR-46, FR-51, FR-66; NFR: NFR-17, NFR-20, NFR-22 | gate GT-02 | GT-02: model and fallback (ADR-16, ADR-17, ADR-18) | A typed meal returns parsed items; a saved meal appears on a second device (sync v0) | GT-02 recorded (model chosen, free-tier limit written down); CI is required on pull requests; compute and totals unit tests pass; 7 wireframes drafted |
| SPR-02 | 2026-10-26 to 2026-11-01 | Consent and privacy path, resolution order, offline writes, history grid, rules tests, legal gate | FR-06, FR-07, FR-10, FR-22, FR-23, FR-25, FR-42, FR-47, FR-49; NFR: NFR-12 | gate GT-04 | GT-04: pilot data policy and consent text; application id (ADR-29, OPEN-89); Play track go or no-go (OPEN-79, OPEN-90) | Consent screen, sign-in, analysis with resolved reference rows, save, grid history; an offline write survives a restart | GT-04 passed by 2026-10-30; at least 10 rules cases pass in CI; 12 dishes entered with sources; application id decided (OPEN-89) |
| SPR-03 | 2026-11-02 to 2026-11-08 | Reviewable analysis with edits, safety refusals, tag check, security gate and release build; evidence for GT-01, GT-01b and GT-03 | FR-02, FR-08, FR-24, FR-36, FR-40, FR-50, FR-55, FR-59; NFR: NFR-03, NFR-04, NFR-05, NFR-06, NFR-08, NFR-09 | SPK-02 (ROL-03); SPK-04 (ROL-01); SPK-05 (ROL-04); gate GT-01; gate GT-01b; gate GT-03; Play track r1; Play track r2 | GT-01, GT-01b and GT-03 outcomes; KC-06 result; recipes decision if needed (OPEN-71) | End-to-end slice with item editing and refusals; offline results (SPK-04); security results (SPK-05); name-resolution results (SPK-02) | GT-01, GT-01b and GT-03 recorded; release bundle built (Play track); privacy policy draft; KC-06 check done and written down |
| SPR-04 | 2026-11-09 to 2026-11-15 | Recipes, delete-account and sign-out paths, secure storage, evaluation run, closed-test start | FR-03, FR-05, FR-11, FR-16, FR-19, FR-37, FR-39, FR-52, FR-58, FR-62, FR-67; NFR: NFR-11, NFR-15, NFR-16, NFR-21 | Play track r3 | Closed-test go or no-go (OPEN-79, OPEN-90) | Restriction-aware recipe screen with the allergen wording; delete-account flow; manual entry offline; closed-test build uploaded with at least 12 testers invited by the end of the sprint if the Play track runs | Every OBJ-08 item present (notice, consent screen, delete path); secure storage done; evaluation CSV exists; testers recruited; trainer review held |
| SPR-05 | 2026-11-16 to 2026-11-22 | Charts, source and AI-estimate labels, alternatives, remaining Must items, device runs | FR-18, FR-27, FR-28, FR-41, FR-43, FR-44, FR-60, FR-69; NFR: NFR-07, NFR-10, NFR-19, NFR-24, NFR-29 | SPK-03 (ROL-02) | What the report may claim (02-COMPETITORS section 2.6); feature freeze scope | Daily chart with its overlay; item source labels and AI-estimate labels; lower-energy alternatives; camera permission flow | Data part of SPK-03 done; timing log works in a test build; feature freeze is next sprint; HYP-01 sessions scheduled |
| SPR-06 | 2026-11-23 to 2026-11-29 | Measurements, accuracy results, remaining items, report draft, rehearsal 1 | FR-35, FR-48, FR-53; NFR: NFR-01, NFR-13, NFR-14, NFR-25, NFR-27 | SPK-03 (ROL-02); SPK-06 (ROL-01); gate GT-05; Play track r4 | GT-05 and SPK-03 outcomes; cuts agreed under the order of 05 section 10.5 | Full demo script end to end; accuracy and latency tables (SPK-03, SPK-06); claims scan clean | GT-05 and SPK-03 recorded; code freeze on F - 3; report draft complete; rehearsal 1 done; HYP-04 session done; every Must item accepted |
| SPR-07 | 2026-11-30 to 2026-12-01 | Final presentation | none | none | None | Final presentation and live demo | Presentation delivered; README final; tag v1.0.0; weekly and final reports sent |

Planned cumulative effort (burn-up baseline):

| Sprint | Planned in sprint (person-days) | Cumulative | Share of total |
|---|---|---|---|
| SPR-00 (12 Oct) | 12.5 | 12.5 | 14% |
| SPR-01 (19 Oct) | 12.5 | 25.0 | 29% |
| SPR-02 (26 Oct) | 12.5 | 37.5 | 43% |
| SPR-03 (02 Nov) | 12.2 | 49.8 | 58% |
| SPR-04 (09 Nov) | 12.5 | 62.2 | 72% |
| SPR-05 (16 Nov) | 12.2 | 74.5 | 86% |
| SPR-06 (23 Nov) | 9.0 | 83.5 | 97% |
| SPR-07 (30 Nov) | 3.0 | 86.5 | 100% |

Sprints SPR-00 to SPR-05 are loaded to the full capacity of every member; the slack sits in SPR-06 (and a little in SPR-03 and SPR-05). A slip in an early sprint therefore brings the cut order of section 8.4 forward, and the weekly capacity re-check (section 8.2) is the main control.

### 3.2 Scenario L (does not apply to the stated end date; kept in case it moves)

Total planned effort 120.5 person-days: Must and Should requirements, work implied by non-functional requirements, 100 dishes, spikes (12), report and demo (10) and the Play track. Capacity per member and sprint is 2.0 days. It needs 14 weeks, which would end on 2027-01-17. The sprint numbers are `SPR-10` for the first L sprint to `SPR-23` for the last. The legal items of `GT-04` are first in the order; if D0 stays at 2026-10-12, the external date 2026-10-30 still binds and the S arrangement of those items is used.

| Sprint | Dates | Goal | Requirements in scope | Experiments and gates | Decisions to approve | Demo | Exit criteria |
|---|---|---|---|---|---|---|---|
| SPR-10 | 2026-10-12 to 2026-10-18 | Focus: Reference data, Localisation, Networking and device, Account, Repository, toolchain and branch rules | FR-01, FR-09, FR-13, FR-56, FR-61, FR-63, FR-65; NFR: NFR-02, NFR-18, NFR-23, NFR-26, NFR-28 | SPK-01 (ROL-02) | All 30 ADRs of 06 section 9, OPEN-77, OPEN-78, OPEN-80 | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-11 | 2026-10-19 to 2026-10-25 | Focus: Profile, Meal entry, Networking and device, Parsing and resolution | FR-02, FR-03, FR-12, FR-15, FR-21, FR-51, FR-55, FR-57, FR-59, FR-66 | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-12 | 2026-10-26 to 2026-11-01 | Focus: Sync and offline, Consent and privacy, Nutrition calculation, Parsing and resolution, Personas and wireframes for 7 screens, CI pipeline | FR-10, FR-23, FR-32, FR-33, FR-46; NFR: NFR-17, NFR-20, NFR-22 | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-13 | 2026-11-02 to 2026-11-08 | Focus: Consent and privacy, Meal entry, Parsing and resolution, Correction, THIRD_PARTY_NOTICES and CI check, Play release build: application id, signing, bundle | FR-06, FR-07, FR-08, FR-11, FR-17, FR-25, FR-37; NFR: NFR-11, NFR-12 | SPK-01 (ROL-02); gate GT-02; gate GT-04; Play track r1 | Gate outcomes: GT-02, GT-04 | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); gates met: GT-02, GT-04 |
| SPR-14 | 2026-11-09 to 2026-11-15 | Focus: Sync and offline, History and charts, Parsing and resolution, Play listing, privacy policy, data-safety answers | FR-22, FR-24, FR-42, FR-47, FR-49 | SPK-02 (ROL-03); gate GT-03; Play track r2 | Gate outcomes: GT-03 | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); gates met: GT-03 |
| SPR-15 | 2026-11-16 to 2026-11-22 | Focus: Safety, Recipes and alternatives, Evaluation tooling, Networking and device, Closed-test tester recruitment and feedback loop | FR-40, FR-50, FR-58, FR-67; NFR: NFR-03, NFR-04, NFR-05, NFR-06, NFR-08, NFR-09 | SPK-04 (ROL-01); SPK-05 (ROL-04); gate GT-01; gate GT-01b; Play track r3 | Gate outcomes: GT-01, GT-01b | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); gates met: GT-01, GT-01b |
| SPR-16 | 2026-11-23 to 2026-11-29 | Focus: Correction, Recipes and alternatives, Meal entry, Account | FR-05, FR-16, FR-19, FR-29, FR-36, FR-39, FR-52, FR-62; NFR: NFR-15, NFR-16, NFR-21 | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-17 | 2026-11-30 to 2026-12-06 | Focus: Meal entry, Parsing and resolution, Account, History and charts, Device runs on minimum Android and 2 test devices | FR-04, FR-20, FR-26, FR-30, FR-31, FR-43, FR-44; NFR: NFR-24 | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-18 | 2026-12-07 to 2026-12-13 | Focus: Localisation, Reference data, Nutrition calculation, Recipes and alternatives, README and technical documentation, Encrypted-traffic configuration and check | FR-14, FR-27, FR-28, FR-34, FR-41, FR-45, FR-60, FR-64, FR-69; NFR: NFR-07, NFR-10, NFR-19 | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-19 | 2026-12-14 to 2026-12-20 | Focus: Meal entry, Evaluation tooling, Correction, Safety, Release hardening and SPK-05 re-run on the release build | FR-18, FR-38, FR-48, FR-53, FR-68, FR-70; NFR: NFR-29 | SPK-03 (ROL-02); Play track r4 | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-20 | 2026-12-21 to 2026-12-27 | Focus: Safety | FR-54 | SPK-03 (ROL-02) | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7) |
| SPR-21 | 2026-12-28 to 2027-01-03 | Focus: Nutrition calculation | FR-35; NFR: NFR-01, NFR-13, NFR-14, NFR-25, NFR-27 | SPK-06 (ROL-01); gate GT-05 | Gate outcomes: GT-05 | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); gates met: GT-05 |
| SPR-22 | 2027-01-04 to 2027-01-10 | Focus: Buffer, defect fixes and rehearsal | none | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); code freeze and rehearsal |
| SPR-23 | 2027-01-11 to 2027-01-17 | Focus: Buffer, defect fixes and rehearsal | none | none | None | Each member shows what they merged in the sprint (section 5) | Planned items meet the definition of done (section 7); code freeze and rehearsal |

## 4. Roles and task division

### 4.1 Roles

Five roles from `04-FEASIBILITY.md`, mapped to members in the order of the team list; the mapping is a proposal and the team changes it by interest and skill [A:ASM-63]. Skill levels are as the group leader stated: one mid level, four junior, with Cubit, Dio, sqflite and Firebase learned in the course [A:ASM-64]. `ADR-06` allows Cubit for simple screens, so the course skill is enough to start; events and Bloc classes are used where a flow has several steps.

| ID | Role | Member | Owned modules | Must requirements owned end to end | Skills needed |
|---|---|---|---|---|---|
| ROL-01 | Mobile lead | Member A: Mahmoud Ashraf SayedAhmed Younes (proposed, [T] to confirm) | App shell, screens, state, sync and offline, history and charts | 14 Must requirements; for example FR-46 sync, FR-47 offline log, FR-01 signin | Flutter UI, Cubit and Bloc, Firebase Authentication and Firestore, offline behaviour [T] |
| ROL-02 | AI lead | Member B: Ahmed Gomaa Hussein Mokhtar (proposed, [T] to confirm) | Meal parsing pipeline, prompts and schema, model choice and fallback, recipes and alternatives, refusals | 9 Must requirements; for example FR-21 parse, FR-39 recipe, FR-10 ai minimise | Prompt design, structured output, Firebase AI Logic, testing model output [T] |
| ROL-03 | Data lead | Member C: Bassam Emad Kamal Bassam (proposed, [T] to confirm) | Reference data (dishes, USDA subset), name resolution, calculation, audit and evaluation scripts | 11 Must requirements; for example FR-25 resolve order, FR-16 manual entry, FR-18 ask portion | Data cleaning, nutrition sources, unit tests of calculation, scripting [T] |
| ROL-04 | QA/security lead | Member D: Kamel Ali Kamel Mohamed (proposed, [T] to confirm) | CI, networking client, Firestore rules, secrets, secure storage, permissions, release build | 12 Must requirements; for example FR-49 rules, FR-19 barcode scan, FR-56 net client | Dio and interceptors, Firebase rules emulator, CI, Android security basics [T] |
| ROL-05 | Product/legal lead | Member E: Osama Yaser Abdulrazik Eid (proposed, [T] to confirm) | Backlog and acceptance, repository rules, consent and privacy, safety wording, documents, usability sessions, trainer reports | 10 Must requirements; for example FR-06 consent, FR-42 history grid, FR-62 states | Arabic writing, privacy and consent text, documentation, user testing, Git settings [T] |

### 4.2 Effort per role and the fairness check

The planned effort per role must stay within 20% of the average [rule of this plan]. Totals include requirements, work items, spikes, dish entries and the report share.

| Role | S: person-days | S: against average | L: person-days | L: against average |
|---|---|---|---|---|
| ROL-01 Mobile lead (Member A) | 17.85 | +3.2% | 24.00 | -0.4% |
| ROL-02 AI lead (Member B) | 17.10 | -1.2% | 24.00 | -0.4% |
| ROL-03 Data lead (Member C) | 17.10 | -1.2% | 24.50 | +1.7% |
| ROL-04 QA/security lead (Member D) | 17.10 | -1.2% | 24.00 | -0.4% |
| ROL-05 Product/legal lead (Member E) | 17.35 | +0.3% | 24.00 | -0.4% |

Largest deviation: scenario S 3.2%, scenario L 1.7%, both inside the 20% limit. The mid-level member also reviews the high-risk items (GIT-06), which is not in the effort model; see `PLR-05` in section 11.

Planned person-days per member and sprint, scenario S (capacity 2.5, the last sprint 0.7):

| Sprint | ROL-01 | ROL-02 | ROL-03 | ROL-04 | ROL-05 |
|---|---|---|---|---|---|
| SPR-00 (12 Oct) | 2.50 | 2.50 | 2.50 | 2.50 | 2.50 |
| SPR-01 (19 Oct) | 2.50 | 2.50 | 2.50 | 2.50 | 2.50 |
| SPR-02 (26 Oct) | 2.50 | 2.50 | 2.50 | 2.50 | 2.50 |
| SPR-03 (02 Nov) | 2.25 | 2.50 | 2.50 | 2.50 | 2.50 |
| SPR-04 (09 Nov) | 2.50 | 2.50 | 2.50 | 2.50 | 2.50 |
| SPR-05 (16 Nov) | 2.50 | 2.25 | 2.50 | 2.50 | 2.50 |
| SPR-06 (23 Nov) | 2.50 | 1.75 | 1.50 | 1.50 | 1.75 |
| SPR-07 (30 Nov) | 0.60 | 0.60 | 0.60 | 0.60 | 0.60 |

Scenario L (capacity 2.0):

| Sprint | ROL-01 | ROL-02 | ROL-03 | ROL-04 | ROL-05 |
|---|---|---|---|---|---|
| SPR-10 (12 Oct) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-11 (19 Oct) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-12 (26 Oct) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-13 (02 Nov) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-14 (09 Nov) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-15 (16 Nov) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-16 (23 Nov) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-17 (30 Nov) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-18 (07 Dec) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-19 (14 Dec) | 2.00 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-20 (21 Dec) | 0.50 | 2.00 | 2.00 | 2.00 | 2.00 |
| SPR-21 (28 Dec) | 1.50 | 1.40 | 1.90 | 1.40 | 1.40 |
| SPR-22 (04 Jan) | 1.40 | 0.00 | 0.00 | 0.00 | 0.00 |
| SPR-23 (11 Jan) | 0.60 | 0.60 | 0.60 | 0.60 | 0.60 |

### 4.3 Every requirement with its owner, backup and sprint

Primary and backup are roles; the backup reviews the pull request and takes over if the primary is absent (section 4.6). A functional requirement that is a Should in `05-REQUIREMENTS.md` has no sprint in S.

| ID | Name | Priority | Primary | Backup | Sprint in S | Sprint in L | Effort (person-days) |
|---|---|---|---|---|---|---|---|
| FR-01 | signin | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-00 | SPR-10 | 1.0 |
| FR-02 | no identity | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-03 | SPR-11 | 0.5 |
| FR-03 | secure store | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-04 | SPR-11 | 0.5 |
| FR-04 | password reset | Should | ROL-05 Product/legal lead | Mobile lead (ROL-01) | not in S (Should) | SPR-17 | 0.5 |
| FR-05 | signout clear | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-04 | SPR-16 | 1.0 |
| FR-06 | consent | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-02 | SPR-13 | 1.0 |
| FR-07 | no pre consent | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-02 | SPR-13 | 0.5 |
| FR-08 | consent record | Must | ROL-05 Product/legal lead | QA/security lead (ROL-04) | SPR-03 | SPR-13 | 0.5 |
| FR-09 | analytics off | Must | ROL-04 QA/security lead | Product/legal lead (ROL-05) | SPR-00 | SPR-10 | 0.5 |
| FR-10 | ai minimise | Must | ROL-02 AI lead | QA/security lead (ROL-04) | SPR-02 | SPR-12 | 1.0 |
| FR-11 | delete account | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-04 | SPR-13 | 1.0 |
| FR-12 | restrictions | Must | ROL-05 Product/legal lead | Data lead (ROL-03) | SPR-00 | SPR-11 | 0.5 |
| FR-13 | language | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-00 | SPR-10 | 1.0 |
| FR-14 | units display | Should | ROL-03 Data lead | Product/legal lead (ROL-05) | not in S (Should) | SPR-18 | 1.0 |
| FR-15 | text entry | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-00 | SPR-11 | 0.5 |
| FR-16 | manual entry | Must | ROL-03 Data lead | Mobile lead (ROL-01) | SPR-04 | SPR-16 | 1.0 |
| FR-17 | save meal | Must | ROL-01 Mobile lead | AI lead (ROL-02) | SPR-01 | SPR-13 | 0.5 |
| FR-18 | ask portion | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-05 | SPR-19 | 1.0 |
| FR-19 | barcode scan | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-04 | SPR-16 | 1.0 |
| FR-20 | barcode lookup | Should | ROL-03 Data lead | QA/security lead (ROL-04) | not in S (Should) | SPR-17 | 1.0 |
| FR-21 | parse | Must | ROL-02 AI lead | Data lead (ROL-03) | SPR-01 | SPR-11 | 2.0 |
| FR-22 | validate retry | Must | ROL-02 AI lead | QA/security lead (ROL-04) | SPR-02 | SPR-14 | 1.0 |
| FR-23 | ai timeout | Must | ROL-02 AI lead | QA/security lead (ROL-04) | SPR-02 | SPR-12 | 0.5 |
| FR-24 | injection | Must | ROL-02 AI lead | QA/security lead (ROL-04) | SPR-03 | SPR-14 | 1.0 |
| FR-25 | resolve order | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-02 | SPR-13 | 2.0 |
| FR-26 | candidates | Should | ROL-03 Data lead | Mobile lead (ROL-01) | not in S (Should) | SPR-17 | 1.0 |
| FR-27 | estimate flag | Must | ROL-02 AI lead | Data lead (ROL-03) | SPR-05 | SPR-18 | 1.0 |
| FR-28 | source label | Must | ROL-01 Mobile lead | Data lead (ROL-03) | SPR-05 | SPR-18 | 1.0 |
| FR-29 | aliases | Should | ROL-03 Data lead | AI lead (ROL-02) | not in S (Should) | SPR-16 | 1.0 |
| FR-30 | model config | Should | ROL-02 AI lead | QA/security lead (ROL-04) | not in S (Should) | SPR-17 | 0.5 |
| FR-31 | ai cap | Should | ROL-02 AI lead | Mobile lead (ROL-01) | not in S (Should) | SPR-17 | 0.5 |
| FR-32 | compute | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-01 | SPR-12 | 1.0 |
| FR-33 | totals | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-01 | SPR-12 | 0.5 |
| FR-34 | sanity | Should | ROL-03 Data lead | QA/security lead (ROL-04) | not in S (Should) | SPR-18 | 0.5 |
| FR-35 | macros only | Must | ROL-03 Data lead | Product/legal lead (ROL-05) | SPR-06 | SPR-21 | 0.5 |
| FR-36 | edit item | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-03 | SPR-16 | 1.0 |
| FR-37 | delete meal | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-04 | SPR-13 | 0.5 |
| FR-38 | repeat meal | Should | ROL-01 Mobile lead | Product/legal lead (ROL-05) | not in S (Should) | SPR-19 | 0.5 |
| FR-39 | recipe | Must | ROL-02 AI lead | Data lead (ROL-03) | SPR-04 | SPR-16 | 2.0 |
| FR-40 | tag check | Must | ROL-03 Data lead | QA/security lead (ROL-04) | SPR-03 | SPR-15 | 1.0 |
| FR-41 | alt | Must | ROL-02 AI lead | Data lead (ROL-03) | SPR-05 | SPR-18 | 1.0 |
| FR-42 | history grid | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-02 | SPR-14 | 1.0 |
| FR-43 | chart daily | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-05 | SPR-17 | 1.0 |
| FR-44 | chart overlay | Must | ROL-01 Mobile lead | Product/legal lead (ROL-05) | SPR-05 | SPR-17 | 0.5 |
| FR-45 | chart macro | Should | ROL-01 Mobile lead | Product/legal lead (ROL-05) | not in S (Should) | SPR-18 | 1.0 |
| FR-46 | sync | Must | ROL-01 Mobile lead | AI lead (ROL-02) | SPR-01 | SPR-12 | 2.0 |
| FR-47 | offline log | Must | ROL-01 Mobile lead | Data lead (ROL-03) | SPR-02 | SPR-14 | 2.0 |
| FR-48 | offline ai | Must | ROL-01 Mobile lead | AI lead (ROL-02) | SPR-06 | SPR-19 | 0.5 |
| FR-49 | rules | Must | ROL-04 QA/security lead | Data lead (ROL-03) | SPR-02 | SPR-14 | 2.0 |
| FR-50 | refusal | Must | ROL-02 AI lead | Product/legal lead (ROL-05) | SPR-03 | SPR-15 | 1.0 |
| FR-51 | info notice | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-01 | SPR-11 | 0.5 |
| FR-52 | allergen wording | Must | ROL-05 Product/legal lead | AI lead (ROL-02) | SPR-04 | SPR-16 | 0.5 |
| FR-53 | claims scan | Must | ROL-05 Product/legal lead | QA/security lead (ROL-04) | SPR-06 | SPR-19 | 0.5 |
| FR-54 | item warning | Should | ROL-03 Data lead | Mobile lead (ROL-01) | not in S (Should) | SPR-20 | 1.0 |
| FR-55 | about | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-03 | SPR-11 | 0.5 |
| FR-56 | net client | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-00 | SPR-10 | 1.0 |
| FR-57 | user agent | Must | ROL-04 QA/security lead | Data lead (ROL-03) | SPR-00 | SPR-11 | 0.5 |
| FR-58 | retry | Must | ROL-04 QA/security lead | AI lead (ROL-02) | SPR-04 | SPR-15 | 0.5 |
| FR-59 | redact | Must | ROL-04 QA/security lead | Data lead (ROL-03) | SPR-03 | SPR-11 | 0.5 |
| FR-60 | errmap | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-05 | SPR-18 | 0.5 |
| FR-61 | permissions | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-00 | SPR-10 | 0.5 |
| FR-62 | states | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-04 | SPR-16 | 1.0 |
| FR-63 | dish floor | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-00 | SPR-10 | 1.0 |
| FR-64 | dish target | Should | ROL-03 Data lead | AI lead (ROL-02) | not in S (Should) | SPR-18 | 0.5 |
| FR-65 | usda subset | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-00 | SPR-10 | 1.0 |
| FR-66 | audit | Must | ROL-03 Data lead | QA/security lead (ROL-04) | SPR-01 | SPR-11 | 1.0 |
| FR-67 | eval run | Must | ROL-03 Data lead | QA/security lead (ROL-04) | SPR-04 | SPR-15 | 1.0 |
| FR-68 | eval direct | Should | ROL-02 AI lead | Data lead (ROL-03) | not in S (Should) | SPR-19 | 1.0 |
| FR-69 | timing log | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-05 | SPR-18 | 0.5 |
| FR-70 | label switch | Should | ROL-04 QA/security lead | Product/legal lead (ROL-05) | not in S (Should) | SPR-19 | 0.5 |
| NFR-01 | perf | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-06 | SPR-21 | in FR effort |
| NFR-02 | parse | Should | ROL-02 AI lead | Data lead (ROL-03) | SPR-00 | SPR-10 | in FR effort |
| NFR-03 | local | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-03 | SPR-15 | in FR effort |
| NFR-04 | cold | Should | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-03 | SPR-15 | in FR effort |
| NFR-05 | loss | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-03 | SPR-15 | in FR effort |
| NFR-06 | sync50 | Must | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-03 | SPR-15 | in FR effort |
| NFR-07 | crash | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-05 | SPR-18 | in FR effort |
| NFR-08 | secret | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-03 | SPR-15 | in FR effort |
| NFR-09 | attest | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-03 | SPR-15 | in FR effort |
| NFR-10 | tls | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-05 | SPR-18 | 0.5 (work item) |
| NFR-11 | privacy | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-04 | SPR-13 | in FR effort |
| NFR-12 | notices | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-02 | SPR-13 | 0.5 (work item) |
| NFR-13 | sus | Should | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-06 | SPR-21 | in FR effort |
| NFR-14 | trust | Should | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-06 | SPR-21 | in FR effort |
| NFR-15 | font | Should | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-04 | SPR-16 | in FR effort |
| NFR-16 | target | Should | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-04 | SPR-16 | in FR effort |
| NFR-17 | cov | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-01 | SPR-12 | in FR effort |
| NFR-18 | pr | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-00 | SPR-10 | 2.0 (work item) |
| NFR-19 | docs | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-05 | SPR-18 | 2.0 (work item) |
| NFR-20 | ci | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-01 | SPR-12 | 2.0 (work item) |
| NFR-21 | tests | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-04 | SPR-16 | in FR effort |
| NFR-22 | design | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-01 | SPR-12 | 2.0 (work item) |
| NFR-23 | division | Should | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-00 | SPR-10 | in FR effort |
| NFR-24 | android | Must | ROL-04 QA/security lead | Mobile lead (ROL-01) | SPR-05 | SPR-17 | 1.0 (work item) |
| NFR-25 | size | Should | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-06 | SPR-21 | in FR effort |
| NFR-26 | cost | Must | ROL-05 Product/legal lead | Mobile lead (ROL-01) | SPR-00 | SPR-10 | in FR effort |
| NFR-27 | reads | Should | ROL-01 Mobile lead | QA/security lead (ROL-04) | SPR-06 | SPR-21 | in FR effort |
| NFR-28 | aiquota | Should | ROL-02 AI lead | Data lead (ROL-03) | SPR-00 | SPR-10 | in FR effort |
| NFR-29 | acc | Must | ROL-03 Data lead | AI lead (ROL-02) | SPR-05 | SPR-19 | in FR effort |

### 4.4 Other planned work

| Item | Requirement or source | Primary | Backup | Sprint in S | Sprint in L | Effort in S | Effort in L |
|---|---|---|---|---|---|---|---|
| Repository, toolchain and branch rules | NFR-18 | ROL-05 Product/legal lead (Member E) | Data lead | SPR-00 | SPR-10 | 2.0 | 2.0 |
| CI pipeline | NFR-20 | ROL-04 QA/security lead (Member D) | Data lead | SPR-01 | SPR-12 | 2.0 | 2.0 |
| README and technical documentation | NFR-19 | ROL-05 Product/legal lead (Member E) | AI lead | SPR-05 | SPR-18 | 2.0 | 2.0 |
| Personas and wireframes for 7 screens | NFR-22 | ROL-05 Product/legal lead (Member E) | Data lead | SPR-01 | SPR-12 | 2.0 | 2.0 |
| THIRD_PARTY_NOTICES and CI check | NFR-12 | ROL-05 Product/legal lead (Member E) | AI lead | SPR-02 | SPR-13 | 0.5 | 0.5 |
| Encrypted-traffic configuration and check | NFR-10 | ROL-04 QA/security lead (Member D) | Data lead | SPR-05 | SPR-18 | 0.5 | 0.5 |
| Device runs on minimum Android and 2 test devices | NFR-24 | ROL-04 QA/security lead (Member D) | Product/legal lead | SPR-05 | SPR-17 | 1.0 | 1.0 |
| Play release build: application id, signing, bundle | Play track [A:ASM-61] | ROL-04 QA/security lead (Member D) | AI lead | SPR-03 | SPR-13 | 0.5 | 0.5 |
| Play listing, privacy policy, data-safety answers | Play track [A:ASM-61] | ROL-05 Product/legal lead (Member E) | QA/security lead | SPR-03 | SPR-14 | 1.0 | 1.0 |
| Closed-test tester recruitment and feedback loop | Play track [A:ASM-61] | ROL-05 Product/legal lead (Member E) | Data lead | SPR-04 | SPR-15 | 1.0 | 1.0 |
| Release hardening and SPK-05 re-run on the release build | Play track [A:ASM-61] | ROL-04 QA/security lead (Member D) | Product/legal lead | SPR-06 | SPR-19 | 0.5 | 0.5 |
| SPK-01 | W10 spike | ROL-02 AI lead (Member B) | Data lead | SPR-00 | SPR-13 | 2.00 | 3.00 |
| SPK-02 | W10 spike | ROL-03 Data lead (Member C) | AI lead | SPR-03 | SPR-14 | 1.50 | 2.00 |
| SPK-03 (AI lead part) | W10 spike | ROL-02 AI lead (Member B) | Data lead | SPR-06 | SPR-20 | 0.75 | 1.00 |
| SPK-03 (Data lead part) | W10 spike | ROL-03 Data lead (Member C) | AI lead | SPR-05 | SPR-19 | 0.75 | 1.00 |
| SPK-04 | W10 spike | ROL-01 Mobile lead (Member A) | QA/security lead | SPR-03 | SPR-15 | 1.00 | 2.00 |
| SPK-05 | W10 spike | ROL-04 QA/security lead (Member D) | Mobile lead | SPR-03 | SPR-15 | 1.00 | 1.50 |
| SPK-06 | W10 spike | ROL-01 Mobile lead (Member A) | QA/security lead | SPR-06 | SPR-21 | 1.00 | 1.50 |
| Dish entries (0.25 per dish) | OBJ-03 | ROL-01 Mobile lead (Member A) | QA/security lead | SPR-01 to SPR-04 | SPR-10 to SPR-18 | 0.75 (3 dishes) | 3.50 (14 dishes) |
| Dish entries (0.25 per dish) | OBJ-03 | ROL-02 AI lead (Member B) | Data lead | SPR-01 to SPR-04 | SPR-10 to SPR-18 | 2.25 (9 dishes) | 5.50 (22 dishes) |
| Dish entries (0.25 per dish) | OBJ-03 | ROL-03 Data lead (Member C) | AI lead | SPR-01 to SPR-04 | SPR-10 to SPR-18 | 2.25 (9 dishes) | 2.50 (10 dishes) |
| Dish entries (0.25 per dish) | OBJ-03 | ROL-04 QA/security lead (Member D) | Mobile lead | SPR-01 to SPR-04 | SPR-10 to SPR-18 | 1.50 (6 dishes) | 7.00 (28 dishes) |
| Dish entries (0.25 per dish) | OBJ-03 | ROL-05 Product/legal lead (Member E) | Mobile lead | SPR-01 to SPR-04 | SPR-10 to SPR-18 | 0.75 (3 dishes) | 6.50 (26 dishes) |
| Report and demo share (W13) | rubric: methods, results | ROL-01 Mobile lead (Member A) | QA/security lead | SPR-06 and SPR-07 | SPR-21 and SPR-23 | 1.6 | 2.0 |
| Report and demo share (W13) | rubric: methods, results | ROL-02 AI lead (Member B) | Data lead | SPR-06 and SPR-07 | SPR-21 and SPR-23 | 1.6 | 2.0 |
| Report and demo share (W13) | rubric: methods, results | ROL-03 Data lead (Member C) | AI lead | SPR-06 and SPR-07 | SPR-21 and SPR-23 | 1.6 | 2.0 |
| Report and demo share (W13) | rubric: methods, results | ROL-04 QA/security lead (Member D) | Mobile lead | SPR-06 and SPR-07 | SPR-21 and SPR-23 | 1.6 | 2.0 |
| Report and demo share (W13) | rubric: methods, results | ROL-05 Product/legal lead (Member E) | Mobile lead | SPR-06 and SPR-07 | SPR-21 and SPR-23 | 1.6 | 2.0 |

### 4.5 Skills matrix (template for the team to fill)

Use 0 (none), 1 (course level), 2 (can do alone), 3 (can teach). Fill it in the first sprint and use it for the reassignment rule.

| Member | Level | Flutter UI | Cubit and Bloc | Dio | Firebase (Auth, Firestore) | sqflite or local storage | Testing (unit, widget) | Git and GitHub | Arabic text and legal wording | Data entry and nutrition sources |
|---|---|---|---|---|---|---|---|---|---|---|
| A Mahmoud | mid (stated) | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| B Ahmed | junior (stated) | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| C Bassam | junior (stated) | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| D Kamel | junior (stated) | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| E Osama | junior (stated) | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### 4.6 Rule for reassigning work

- A member whose planned load for the coming sprint is more than 2.5 days, or who will be absent for more than 3 working days, tells the facilitator at planning.
- The backup role takes the items that cannot be done; the Product/legal lead lists the moves, the group leader confirms them, and the trainer is told in the weekly report.
- After two sprints with done effort below 80% of planned, the team rebalances using the skills matrix and records it in the retrospective.
- A reassigned item keeps its requirement ID and its acceptance criterion; the former primary stays as backup.

## 5. Individual deliverables

One or two deliverables per role and sprint, each with evidence that the trainer's weekly assessment and the final presentation can use. Evidence means a merged pull request, a committed document or table, a passing test or a recorded decision; never lines of code (GIT-20). The deliverables follow the schedule of section 4.3, so they change when an item moves.

### 5.1 Scenario S

| ID | Sprint | Role and member | Deliverable | Evidence |
|---|---|---|---|---|
| DEL-001 | SPR-00 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-01 signin, FR-13 language, FR-15 text entry | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-002 | SPR-00 | ROL-02 AI lead (Member B) | SPK-01 result table and decision note; 2 dishes entered with sources | result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-003 | SPR-00 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-63 dish floor, FR-65 usda subset; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-004 | SPR-00 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-09 analytics off, FR-56 net client, FR-57 user agent, FR-61 permissions | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-005 | SPR-00 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-12 restrictions; Repository, toolchain and branch rules | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for repository, toolchain and branch rules |
| DEL-006 | SPR-01 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-17 save meal, FR-46 sync | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-007 | SPR-01 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-21 parse; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-008 | SPR-01 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-32 compute, FR-33 totals, FR-66 audit | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-009 | SPR-01 | ROL-04 QA/security lead (Member D) | CI pipeline; 2 dishes entered with sources | merged pull request or committed document for ci pipeline; dish rows with source IDs; audit script passes |
| DEL-010 | SPR-01 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-51 info notice; Personas and wireframes for 7 screens | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for personas and wireframes for 7 screens |
| DEL-011 | SPR-02 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-47 offline log; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-012 | SPR-02 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-10 ai minimise, FR-22 validate retry, FR-23 ai timeout | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-013 | SPR-02 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-25 resolve order; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-014 | SPR-02 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-07 no pre consent, FR-49 rules | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-015 | SPR-02 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-06 consent, FR-42 history grid; THIRD_PARTY_NOTICES and CI check | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for third_party_notices and ci check |
| DEL-016 | SPR-03 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-36 edit item; SPK-04 result table and decision note; 1 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-017 | SPR-03 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-24 injection, FR-50 refusal; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-018 | SPR-03 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-40 tag check; SPK-02 result table and decision note | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated |
| DEL-019 | SPR-03 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-59 redact; Play release build: application id, signing, bundle; SPK-05 result table and decision note; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for play release build: application id, signing, bundle; result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-020 | SPR-03 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-02 no identity, FR-08 consent record, FR-55 about; Play listing, privacy policy, data-safety answers | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for play listing, privacy policy, data-safety answers |
| DEL-021 | SPR-04 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-05 signout clear, FR-11 delete account, FR-37 delete meal | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-022 | SPR-04 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-39 recipe; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-023 | SPR-04 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-16 manual entry, FR-67 eval run; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-024 | SPR-04 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-03 secure store, FR-19 barcode scan, FR-58 retry; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-025 | SPR-04 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-52 allergen wording, FR-62 states; Closed-test tester recruitment and feedback loop | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for closed-test tester recruitment and feedback loop |
| DEL-026 | SPR-05 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-28 source label, FR-43 chart daily, FR-44 chart overlay | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-027 | SPR-05 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-27 estimate flag, FR-41 alt; 1 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-028 | SPR-05 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-18 ask portion; SPK-03 (Data lead part) result table and decision note; 3 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-029 | SPR-05 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-60 errmap, FR-69 timing log; Encrypted-traffic configuration and check; Device runs on minimum Android and 2 test devices | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for encrypted-traffic configuration and check; merged pull request or committed document for device runs on minimum android and 2 test devices |
| DEL-030 | SPR-05 | ROL-05 Product/legal lead (Member E) | README and technical documentation; 2 dishes entered with sources | merged pull request or committed document for readme and technical documentation; dish rows with source IDs; audit script passes |
| DEL-031 | SPR-06 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-48 offline ai; SPK-06 result table and decision note; Report section for own area, first draft | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated; report section merged in the repository |
| DEL-032 | SPR-06 | ROL-02 AI lead (Member B) | SPK-03 (AI lead part) result table and decision note; Report section for own area, first draft | result table committed and the gate or register updated; report section merged in the repository |
| DEL-033 | SPR-06 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-35 macros only; Report section for own area, first draft | pull requests merged with CI green; acceptance criterion shown at the review; report section merged in the repository |
| DEL-034 | SPR-06 | ROL-04 QA/security lead (Member D) | Release hardening and SPK-05 re-run on the release build; Report section for own area, first draft | merged pull request or committed document for release hardening and spk-05 re-run on the release build; report section merged in the repository |
| DEL-035 | SPR-06 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-53 claims scan; 1 dishes entered with sources; Report section for own area, first draft | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes; report section merged in the repository |
| DEL-036 | SPR-07 | ROL-01 Mobile lead (Member A) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-037 | SPR-07 | ROL-02 AI lead (Member B) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-038 | SPR-07 | ROL-03 Data lead (Member C) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-039 | SPR-07 | ROL-04 QA/security lead (Member D) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-040 | SPR-07 | ROL-05 Product/legal lead (Member E) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |

### 5.2 Scenario L

| ID | Sprint | Role and member | Deliverable | Evidence |
|---|---|---|---|---|
| DEL-041 | SPR-10 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-01 signin, FR-13 language | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-042 | SPR-10 | ROL-02 AI lead (Member B) | SPK-01 result table and decision note; 2 dishes entered with sources | result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-043 | SPR-10 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-63 dish floor, FR-65 usda subset | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-044 | SPR-10 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-09 analytics off, FR-56 net client, FR-61 permissions | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-045 | SPR-10 | ROL-05 Product/legal lead (Member E) | Repository, toolchain and branch rules | merged pull request or committed document for repository, toolchain and branch rules |
| DEL-046 | SPR-11 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-15 text entry; 6 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-047 | SPR-11 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-21 parse | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-048 | SPR-11 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-66 audit; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-049 | SPR-11 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-03 secure store, FR-57 user agent, FR-59 redact; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-050 | SPR-11 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-02 no identity, FR-12 restrictions, FR-51 info notice, FR-55 about | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-051 | SPR-12 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-46 sync | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-052 | SPR-12 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-10 ai minimise, FR-23 ai timeout; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-053 | SPR-12 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-32 compute, FR-33 totals; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-054 | SPR-12 | ROL-04 QA/security lead (Member D) | CI pipeline | merged pull request or committed document for ci pipeline |
| DEL-055 | SPR-12 | ROL-05 Product/legal lead (Member E) | Personas and wireframes for 7 screens | merged pull request or committed document for personas and wireframes for 7 screens |
| DEL-056 | SPR-13 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-11 delete account, FR-17 save meal, FR-37 delete meal | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-057 | SPR-13 | ROL-02 AI lead (Member B) | SPK-01 (part 2) result table and decision note; 2 dishes entered with sources | result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-058 | SPR-13 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-25 resolve order | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-059 | SPR-13 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-07 no pre consent; Play release build: application id, signing, bundle; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for play release build: application id, signing, bundle; dish rows with source IDs; audit script passes |
| DEL-060 | SPR-13 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-06 consent, FR-08 consent record; THIRD_PARTY_NOTICES and CI check | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for third_party_notices and ci check |
| DEL-061 | SPR-14 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-47 offline log | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-062 | SPR-14 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-22 validate retry, FR-24 injection | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-063 | SPR-14 | ROL-03 Data lead (Member C) | SPK-02 result table and decision note | result table committed and the gate or register updated |
| DEL-064 | SPR-14 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-49 rules | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-065 | SPR-14 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-42 history grid; Play listing, privacy policy, data-safety answers | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for play listing, privacy policy, data-safety answers |
| DEL-066 | SPR-15 | ROL-01 Mobile lead (Member A) | SPK-04 result table and decision note | result table committed and the gate or register updated |
| DEL-067 | SPR-15 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-50 refusal; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-068 | SPR-15 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-40 tag check, FR-67 eval run | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-069 | SPR-15 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-58 retry; SPK-05 result table and decision note | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated |
| DEL-070 | SPR-15 | ROL-05 Product/legal lead (Member E) | Closed-test tester recruitment and feedback loop; 4 dishes entered with sources | merged pull request or committed document for closed-test tester recruitment and feedback loop; dish rows with source IDs; audit script passes |
| DEL-071 | SPR-16 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-05 signout clear, FR-36 edit item | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-072 | SPR-16 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-39 recipe | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-073 | SPR-16 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-16 manual entry, FR-29 aliases | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-074 | SPR-16 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-19 barcode scan; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-075 | SPR-16 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-52 allergen wording, FR-62 states; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-076 | SPR-17 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-43 chart daily, FR-44 chart overlay; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-077 | SPR-17 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-30 model config, FR-31 ai cap; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-078 | SPR-17 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-20 barcode lookup, FR-26 candidates | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-079 | SPR-17 | ROL-04 QA/security lead (Member D) | Device runs on minimum Android and 2 test devices; 4 dishes entered with sources | merged pull request or committed document for device runs on minimum android and 2 test devices; dish rows with source IDs; audit script passes |
| DEL-080 | SPR-17 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-04 password reset; 6 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-081 | SPR-18 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-28 source label, FR-45 chart macro | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-082 | SPR-18 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-27 estimate flag, FR-41 alt | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-083 | SPR-18 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-14 units display, FR-34 sanity, FR-64 dish target | pull requests merged with CI green; acceptance criterion shown at the review |
| DEL-084 | SPR-18 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-60 errmap, FR-69 timing log; Encrypted-traffic configuration and check; 2 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for encrypted-traffic configuration and check; dish rows with source IDs; audit script passes |
| DEL-085 | SPR-18 | ROL-05 Product/legal lead (Member E) | README and technical documentation | merged pull request or committed document for readme and technical documentation |
| DEL-086 | SPR-19 | ROL-01 Mobile lead (Member A) | Merged and reviewed: FR-38 repeat meal, FR-48 offline ai; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-087 | SPR-19 | ROL-02 AI lead (Member B) | Merged and reviewed: FR-68 eval direct; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-088 | SPR-19 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-18 ask portion; SPK-03 (Data lead part) result table and decision note | pull requests merged with CI green; acceptance criterion shown at the review; result table committed and the gate or register updated |
| DEL-089 | SPR-19 | ROL-04 QA/security lead (Member D) | Merged and reviewed: FR-70 label switch; Release hardening and SPK-05 re-run on the release build; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; merged pull request or committed document for release hardening and spk-05 re-run on the release build; dish rows with source IDs; audit script passes |
| DEL-090 | SPR-19 | ROL-05 Product/legal lead (Member E) | Merged and reviewed: FR-53 claims scan; 6 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-091 | SPR-20 | ROL-01 Mobile lead (Member A) | 2 dishes entered with sources | dish rows with source IDs; audit script passes |
| DEL-092 | SPR-20 | ROL-02 AI lead (Member B) | SPK-03 (AI lead part) result table and decision note; 4 dishes entered with sources | result table committed and the gate or register updated; dish rows with source IDs; audit script passes |
| DEL-093 | SPR-20 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-54 item warning; 4 dishes entered with sources | pull requests merged with CI green; acceptance criterion shown at the review; dish rows with source IDs; audit script passes |
| DEL-094 | SPR-20 | ROL-04 QA/security lead (Member D) | 8 dishes entered with sources | dish rows with source IDs; audit script passes |
| DEL-095 | SPR-20 | ROL-05 Product/legal lead (Member E) | 8 dishes entered with sources | dish rows with source IDs; audit script passes |
| DEL-096 | SPR-21 | ROL-01 Mobile lead (Member A) | SPK-06 result table and decision note | result table committed and the gate or register updated |
| DEL-097 | SPR-21 | ROL-02 AI lead (Member B) | Report section for own area, first draft | report section merged in the repository |
| DEL-098 | SPR-21 | ROL-03 Data lead (Member C) | Merged and reviewed: FR-35 macros only; Report section for own area, first draft | pull requests merged with CI green; acceptance criterion shown at the review; report section merged in the repository |
| DEL-099 | SPR-21 | ROL-04 QA/security lead (Member D) | Report section for own area, first draft | report section merged in the repository |
| DEL-100 | SPR-21 | ROL-05 Product/legal lead (Member E) | Report section for own area, first draft | report section merged in the repository |
| DEL-101 | SPR-22 | ROL-01 Mobile lead (Member A) | Report section for own area, first draft | report section merged in the repository |
| DEL-102 | SPR-22 | ROL-02 AI lead (Member B) | Defect fixes in own modules, review of teammates' pull requests and rehearsal preparation | issues closed with the bug or release-blocker label; reviews done |
| DEL-103 | SPR-22 | ROL-03 Data lead (Member C) | Defect fixes in own modules, review of teammates' pull requests and rehearsal preparation | issues closed with the bug or release-blocker label; reviews done |
| DEL-104 | SPR-22 | ROL-04 QA/security lead (Member D) | Defect fixes in own modules, review of teammates' pull requests and rehearsal preparation | issues closed with the bug or release-blocker label; reviews done |
| DEL-105 | SPR-22 | ROL-05 Product/legal lead (Member E) | Defect fixes in own modules, review of teammates' pull requests and rehearsal preparation | issues closed with the bug or release-blocker label; reviews done |
| DEL-106 | SPR-23 | ROL-01 Mobile lead (Member A) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-107 | SPR-23 | ROL-02 AI lead (Member B) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-108 | SPR-23 | ROL-03 Data lead (Member C) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-109 | SPR-23 | ROL-04 QA/security lead (Member D) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |
| DEL-110 | SPR-23 | ROL-05 Product/legal lead (Member E) | Own part of the final presentation rehearsed and slides merged | slides merged; rehearsal attended |

## 6. Git workflow

The rules follow `06-DECISIONS.md` (ADR-25 to ADR-29): `main` is protected, every merge is a reviewed pull request, CI runs on every pull request. The last column says whether a rule matches 06, extends it or is new; where a rule differs from 06 it is written as a **proposed change**, not applied. The sources are the GitHub flow page [V:S-120], Conventional Commits [V:S-119], the protected-branches page [V:S-121] and the code-owners page [V:S-122].

| ID | Rule | Detail | Basis | Against 06 |
|---|---|---|---|---|
| GIT-01 | Branching model | GitHub flow: short-lived branches from `main`, a pull request for every change, review, then merge; `main` is always buildable [V:S-120]. | ADR-28; S-120 | Same as 06 |
| GIT-02 | Branch names | `type/ID-short-name`, for example `feat/FR-21-parse-schema`. Types `feat`, `fix`, `docs` as in ADR-28; proposed additions `spike`, `test` and `chore` (a change to ADR-28, not applied until the team approves). | ADR-28 | Proposed change |
| GIT-03 | Commit messages | Conventional Commits: `type(scope): description`, with `feat` and `fix` and other types allowed; add `Refs: FR-21` in the body [V:S-119]. | S-119 | Not in 06; compatible |
| GIT-04 | Pull-request size | One requirement or one change per pull request, about 400 changed lines at most [A:ASM-56]; larger work is split into steps that each build and pass tests. | ADR-28 revisit trigger (latency) | Not in 06; compatible |
| GIT-05 | Pull-request template | Sections: requirement IDs, what changed, tests added, notices and ADR link, **AI assistance used and reviewed**, and one **explain-back** question the reviewer asked (Appendix A). | ADR-28; plan rule 6 | Extends 06 |
| GIT-06 | Reviews | One approving review, from someone other than the author (ADR-28). The reviewer is the item's backup role (section 4.3). For these high-risk items the mid-level member also reviews: sync and offline (`FR-46`, `FR-47`), rules (`FR-49`), parse (`FR-21`), secure storage (`FR-03`), network client (`FR-56`). The trainer reviews at the sprint review and is not a required approver. | ADR-28 | Extends 06 |
| GIT-07 | Code owners | A `CODEOWNERS` file maps folders to roles so that the right reviewer is requested automatically (Appendix E). It needs write access for the owners [V:S-122]. "Require review from Code Owners" stays off in the first sprints to avoid blocking; the team may switch it on later. | S-122 | Not in 06; optional |
| GIT-08 | Merge method | Squash and merge; the pull-request title is a Conventional Commit line (GIT-03); delete the branch after the merge. | ADR-28 | Same as 06 |
| GIT-09 | Protected `main` | Require a pull request, one approval and the CI checks of GIT-10; block direct pushes and force-pushes; include administrators. Branch protection is available on GitHub Free only for public repositories; private repositories need a paid plan [V:S-121]. Visibility and plan are open (`OPEN-80`, `ASM-44`). | ADR-28; S-121 | Same as 06; plan open |
| GIT-10 | Required CI checks | analyse, format check, tests with the 80% coverage gate on `domain/`, rules tests in the emulator, secret scan, dependency scan, debug APK build, and `tools/check_discovery.py` for documentation changes (ADR-25, ADR-26, ADR-27, ADR-28). | ADR-25 to ADR-28 | Same as 06 |
| GIT-11 | Issue types | Story (`US-`), task (`FR-` or `NFR-`), bug, spike (`SPK-`), decision (change to an `ADR-` or a register row). Every issue names its requirement ID and sprint. | plan | New |
| GIT-12 | Labels | Type, role (`role:mobile`, `role:ai`, `role:data`, `role:qa-sec`, `role:product`), priority (`must`, `should`, `could`), `blocked`, `release-blocker`, `decision`, `risk` (Appendix D). | plan | New |
| GIT-13 | Board and limits | Columns: Backlog, Ready, In progress (at most 2 per member), In review (at most 3 for the team), Done. A blocked card carries the `blocked` label and the reason [A:ASM-56]. | plan; Scrum Guide on transparency [V:S-118] | New |
| GIT-14 | Milestones | One milestone per sprint (`SPR-00` and so on) holding that sprint's issues; gate milestones `GT-01` to `GT-05` close when their condition is recorded. | plan | New |
| GIT-15 | Tags | Tag the end of each sprint `sprint-NN`, each gate `gt-NN`, closed-test builds `v0.x.0`, and the final build `v1.0.0`. | plan | New |
| GIT-16 | Secrets | No key, token or password in the repository or in build flags; `.env` files are ignored; the secret scan is a required check (ADR-22, ADR-27, `RSK-11`). | ADR-22; ADR-27 | Same as 06 |
| GIT-17 | Decisions and documents | A change to a dependency or an architecture rule updates its ADR in the same pull request (ADR-28); register changes carry the `decision` label and keep `tools/check_discovery.py` passing. | ADR-28 | Same as 06 |
| GIT-18 | Hotfix | Branch `fix/` from `main`, one approval, CI required; no bypass of protection; tag and note it at the next review. | plan | New |
| GIT-19 | Freeze | Feature freeze on F - 6 days, code freeze on F - 3 days (section 2.5); after the code freeze only pull requests labelled `release-blocker` are merged. | plan | New |
| GIT-20 | Evidence of individual work | Each member commits with their own account and name. The weekly evidence is: pull requests authored and merged, reviews done, issues closed, tests and documents added, spike tables and ADR changes. Lines of code and commit counts are not used. The trainer and a grader can read the contributor list and the pull-request history of the repository. | rubric: task division | New |
| GIT-21 | Branch hygiene | Update a branch by rebasing on or merging `main`; never force-push a branch that someone else is using; keep branches under about 3 days old. | S-120 | New |
| GIT-22 | Repository content | Repository holds `docs/discovery/`, `tools/`, the app, tests, `THIRD_PARTY_NOTICES` and a README that follows `NFR-19` (Appendix F lists the sections). | OBJ-07; ADR-28 | Same as 06 |
| GIT-23 | Reviewing AI-written code | Code produced with an AI assistant is read, run and tested by its author before the pull request; the reviewer treats it like any other code and asks the explain-back question. | plan rule 6 | New |
| GIT-24 | Play release files | Signing keys and the upload key are never committed; the release build is made from a tagged commit by the QA/security lead; the application id is fixed before the first upload (`ADR-29`, `OPEN-89`). | ADR-29 | Extends 06 |

## 7. Definition of Ready and Done

The verification columns of `05-REQUIREMENTS.md` (unit, widget, integration, manual, experiment) decide how "done" is shown. The Scrum Guide asks that every increment meets the definition of done [V:S-118].

### 7.1 Per requirement

| | Definition |
|---|---|
| **Ready** | The issue names its `FR-` or `NFR-` ID, the acceptance criterion copied from 05, the primary and the backup role, the effort size, the sprint, and its dependencies are done or in the same sprint; the test approach (the verification column) is written; no open decision blocks it |
| **Done** | Code merged through a reviewed pull request with CI green (GIT-10); the verification named in 05 is run and its result is in the pull request (automated test added, or manual or experiment result recorded); the acceptance criterion is shown at the sprint review; notices and ADR updated when a dependency changed; no secret; the author answered the explain-back question; the issue is closed |

### 7.2 Per story

**Ready:** the `US-` text is clear, its linked requirements are Ready, and its Given/When/Then lines are in the issue (Must stories, 05 section 3.8). **Done:** all linked requirements are Done and the Given/When/Then lines pass in a demo.

### 7.3 Per sprint

**Ready (planning):** every planned item is Ready, each member's load is at most the capacity (2.5 days in SPR-00 to SPR-06 [A:ASM-59]), every item has a backup, the sprint goal is written. **Done (review):** the exit criteria of section 3 are met or the shortfall is written with its cause; the demo was held; the weekly reports are sent; one retrospective action is recorded.

There are 56 Must functional requirements in `05-REQUIREMENTS.md`; each follows 7.1.

## 8. Tracking and risk control

### 8.1 Burn-up

Planned and done person-days per sprint are recorded in one sheet or the board; **done** means Done by section 7.1. The planned baseline is the cumulative column of section 3.1. The trainer sees the chart at each review.

### 8.2 Kill criteria and the capacity check

`KC-06` (04) reads: fewer than 60% of W1 to W5 done by `GT-03` means scenario S scope and dropping recipes. By the end of SPR-03 (the sprint of `GT-03` in this plan, ending 2026-11-08) the S plan completes 27.0 of 37.5 person-days of the W1 to W5 work, which is 72%, at or above the 60% in `KC-06`; at the end of the sprint before (SPR-02, ending 2026-11-01) it is 24.5 of 37.5 (65%). `KC-06` therefore does not fire in the plan, provided "done" means Done by section 7.1 (`OPEN-83`).

Weekly capacity re-check at planning: available productive days per member this week, minus planned items; if the total is below plan by more than 1.0 person-day, apply the cut order.

### 8.3 Early-warning indicators

| Indicator [A:ASM-56] | Where seen | Response |
|---|---|---|
| Done below 80% of planned for two sprints in a row | Burn-up | Rebalance by the rule of section 4.6; apply the cut order |
| A member's planned load above 2.5 days for the next sprint | Planning check | Move items to the backup role |
| A pull request waits more than 2 working days for review | Board (In review) | Reviewer escalates at the mid-sprint sync; ADR-28 revisit trigger |
| Work in progress above the limit (GIT-13) | Board | Finish before starting |
| A spike misses its pass criterion (`SPK-01` to `SPK-06`) | Spike table | Use the kill criterion in 04 (`KC-01` to `KC-04`) |
| Free-tier use above 80% of the daily limit (`NFR-28`) | Provider console | Lower the daily cap (FR-31) or stop real-user text (`GT-04`) |
| Firestore reads above 50% of the daily quota (`NFR-27`) | Firebase console | Limit queries; reduce testers |
| Fewer than 12 testers opted in on the closed-test start date | Play Console | Delay production request; extend recruitment (`r3`) |

### 8.4 Cut order and decision rights

The cut order is the one in `05-REQUIREMENTS.md` section 10.5 (Should items first, then recipes, tag check and alternatives, which need the trainer because they trace to a brief item, `OPEN-71`). Before them, in this plan: the Play track (3.0 person-days), then dishes from 30 to 20. The Product/legal lead proposes a cut, the team decides by majority, the group leader decides a tie, and the trainer is asked for any cut that touches a brief item.

## 9. Reporting to the trainer

### 9.1 Weekly individual report

One page per member per week, sent the day before the weekly assessment [A:ASM-65]. The template is in Appendix G. It lists the planned items (IDs) against the done items with evidence links, days spent, reviews done, blockers, one thing learned, where AI assistance was used and whether the member can explain it, and next week's items. If the trainer's assessment file is available (`OPEN-81`), its headings replace the template's headings.

### 9.2 One-time division-of-tasks report

The course asks the team to tell the trainer how work is divided within 4 weeks of the project booklet announcement; otherwise the trainer may intervene. The announcement date is not known (`OPEN-77`). Formula: due = announcement date + 28 days; this plan sends it at the end of SPR-00, on **2026-10-18** [A], so it is early in any case. Contents, one page: the five members and roles (section 4.1), the calendar and sprint goals (sections 2 and 3), the Must requirements each member owns end to end (4.1), the Git workflow summary (section 6), the skills matrix (4.5), the communication channel (section 10), and the group leader's contact.

### 9.3 Final presentation plan

Each member presents their own part and answers questions about it; the slot length is not known [T]. Speakers and content:

| Member | Name | Part |
|---|---|---|
| Member A | Mahmoud | Team, problem and objectives (`OBJ-01` to `OBJ-08`), architecture, sync and offline, live demo |
| Member B | Ahmed | AI pipeline, prompts and schema, safety refusals, accuracy results (`HYP-02`, `HYP-03`) |
| Member C | Bassam | Reference data and sources, calculation, source labels, dish table audit |
| Member D | Kamel | Security and privacy in the build (rules, secure storage, secrets, networking), tests and CI results |
| Member E | Osama | Users and personas, usability results (`HYP-01`, `HYP-04`), consent and legal, Git workflow and task-division evidence, Play plan |

Question-and-answer preparation matrix (every topic has a primary and a backup answerer):

| Topic | Primary answerer | Backup answerer |
|---|---|---|
| Problem and objectives; why Egyptian dishes | Member A (Mahmoud) | Member E (Osama) |
| Personas and user research | Member E (Osama) | Member A (Mahmoud) |
| Competitors and what we do not claim | Member E (Osama) | Member B (Ahmed) |
| AI pipeline, prompts, model choice and fallback | Member B (Ahmed) | Member C (Bassam) |
| Accuracy numbers and how they were measured | Member B (Ahmed) | Member C (Bassam) |
| Reference data, sources and licences | Member C (Bassam) | Member B (Ahmed) |
| Calculation and unit tests | Member C (Bassam) | Member D (Kamel) |
| Sync, offline behaviour and Firestore rules | Member A (Mahmoud) | Member D (Kamel) |
| Security, secrets, App Check, Dio chain | Member D (Kamel) | Member A (Mahmoud) |
| Privacy, consent and Egypt's data law | Member E (Osama) | Member D (Kamel) |
| Safety, refusals and disclaimers | Member B (Ahmed) | Member E (Osama) |
| Git workflow, reviews and who did what | Member E (Osama) | Member A (Mahmoud) |
| Cuts, risks and what is left for later | Member A (Mahmoud) | Member E (Osama) |
| Google Play release plan | Member D (Kamel) | Member E (Osama) |
| Cost: free tiers and limits | Member B (Ahmed) | Member D (Kamel) |

Rehearsals: rehearsal 1 on **2026-11-24** (F - 7 days), rehearsal 2 with questions on **2026-11-29** (F - 2 days), report and slides final on **2026-11-30**. Each rehearsal is timed, and each member answers two questions about a teammate's part (explain-back).

## 10. Communication and decisions

| Channel | Use | Response time |
|---|---|---|
| Team chat group [T: which app] | Daily check-in, quick questions, blockers | Within 24 hours on working days |
| GitHub issues and pull requests | Work items, reviews, decisions that need a record | First review within 2 working days |
| Registers in the repository (`A-ASSUMPTIONS.md`, `C-OPEN-ITEMS.md`, `06-DECISIONS.md`) | Assumptions, open questions, technology decisions | Updated in the same week as the decision |
| Trainer contact [T: channel] | Scope questions, weekly assessment, review dates | At the weekly review or in the weekly report |

**Recording decisions.** A technology decision is an `ADR-` change by pull request (GIT-17). A process or scope decision is a row in the registers (`ASM-`, `OPEN-`) with its date and owner. The sprint review notes list what was decided.

**Resolving disagreements.** (1) Each side states its case in the chat in writing, within one day. (2) If a measurement can decide it (a spike, a test, a timing), run it and use the number. (3) Otherwise the Product/legal lead proposes, the team votes at the next planning, and the group leader decides a tie. (4) A disagreement about a brief item or the grade goes to the trainer.

**Covering absences.** A member who will be away for more than 3 working days tells the chat and the facilitator; the backup role takes the items (section 4.6). Absence is recorded in the weekly report. Nobody works alone on a high-risk item: its backup reviews every pull request.

## 11. Risks of the plan

Likelihood and impact: H high, M medium, L low [A]. `RSK-` links point to `04-FEASIBILITY.md`.

| ID | Risk | Likelihood | Impact | Mitigation | Link |
|---|---|---|---|---|---|
| PLR-01 | The end date or final presentation date is earlier than 2026-12-01 | M | H | The calendar is formula-driven from F (section 2.1); cut in the order of section 8.4; ask the trainer for the exact date now (`OPEN-77`) | RSK-06 |
| PLR-02 | Members give less than the 2.5 productive days a week this plan needs (the course also takes time) | H | H | Weekly capacity re-check (section 8.2); decide in SPR-00 (`OPEN-78`); apply the cuts of section 2.3 | RSK-06, RSK-13 |
| PLR-03 | Juniors work slower than the effort sizes assume (they assume Flutter experience, `ASM-47`) | H | M | Pair on high-risk items; trainer and mid-level review; velocity check after SPR-01 and SPR-02 (section 8.3) | RSK-13 |
| PLR-04 | The gate dates of 04 cannot be met at this capacity | H | M | Re-dated in section 2.4; the team accepts or changes them (`OPEN-84`) | RSK-06 |
| PLR-05 | The group leader is both Mobile lead and the main reviewer, so review load is not in the effort model | H | M | The backup reviews first; the mid-level member reviews only the high-risk list (GIT-06); rotate the facilitator; if review time exceeds 1 day a week, move one Mobile item to the backup | RSK-13 |
| PLR-06 | The repository is private on a free plan, so protected `main` cannot be enforced | M | H | Decide visibility and plan in SPR-00 (`OPEN-80`); fall back to a team rule plus manual checks and record it | ADR-28 |
| PLR-07 | Members cannot explain code written with an AI assistant | M | H | Disclosure and explain-back in every pull request (GIT-05, GIT-23); rehearsal questions on teammates' parts (section 9.3) | plan rule 6 |
| PLR-08 | The Google Play goal competes with the core scope and the data rules | H | M | Play track is optional and first to drop (section 2.3); real-user text needs the paid tier or a restricted mode (`OPEN-90`); closed test only after `GT-04` | RSK-01, RSK-02, RSK-25 |
| PLR-09 | Dish table or its reviewer is not ready for SPK-02 and GT-03 | M | H | Everyone enters dishes in SPR-01 to SPR-04; SPK-02 runs on what exists (`OPEN-86`); mark entries unreviewed | RSK-03, RSK-09, KC-01 |
| PLR-10 | Free-tier AI quota or model changes during development | M | H | Daily cap, model identifier in remote configuration, manual entry fallback (05) | RSK-05, KC-02 |
| PLR-11 | Weekly assessment expects different outputs from what the plan delivers | M | M | Ask for the assessment file (`OPEN-81`); align the weekly report headings | rubric |
| PLR-12 | Course topics (Cubit, sqflite) differ from the chosen stack (Bloc and Firestore offline), which may confuse juniors | M | M | Cubit first (ADR-06); ask the trainer whether local sqflite storage is expected (`OPEN-82`); KC-04 fallback | KC-04 |

## 12. Appendices (templates)

The team copies these into the repository later (for example under `.github/`); this plan creates none of those files.

### Appendix A. Pull-request template

```
## Summary
<!-- What changed and why, in two or three sentences -->

## Requirement IDs
<!-- For example: FR-21, NFR-17, US-03 -->

## Tests
- [ ] Unit tests added or updated
- [ ] Widget tests added or updated (if UI changed)
- [ ] Integration or emulator tests run (if sync, rules or offline changed)
- [ ] Acceptance criterion from 05-REQUIREMENTS.md checked: <!-- how -->

## Notices and decisions
- [ ] Dependency or data change: THIRD_PARTY_NOTICES and the ADR updated
- [ ] No secret, key or token added

## AI assistance
- [ ] I used an AI assistant: <!-- where and for what; or write "none" -->
- [ ] I read, ran and can explain every changed line

## Review
Explain-back question asked by the reviewer: <!-- question and the author's answer in one line -->
```

### Appendix B. Issue templates

```
---
name: Story
about: A user story from 05-REQUIREMENTS.md
labels: story
---
**Story ID:** US-
**As a** ... **I want** ... **so that** ...
**Linked requirements:** FR-, NFR-
**Given / When / Then:**
- Given ... when ... then ...
**Sprint:** SPR-   **Primary role / backup role:**
```

```
---
name: Bug
about: Something does not work as the requirement says
labels: bug
---
**Requirement ID:** FR-  
**Steps to reproduce:**
1.
**Expected / actual:**
**Device and Android version:**
**Release blocker?** yes / no
```

```
---
name: Spike
about: A time-boxed experiment (SPK-01 to SPK-06)
labels: spike
---
**Spike ID:** SPK-   **Gate:** GT-
**Question:**
**Pass criterion (from 04-FEASIBILITY.md):**
**Time box (person-days):**
**Result table and decision note (path):**
**Primary role / backup role:**
```

### Appendix C. Conventional Commit examples [V:S-119]

```
feat(parse): validate the item schema and retry once
fix(sync): keep one meal when two devices edit it
docs(adr): record Bloc for state management
test(rules): add cross-user read and write cases
chore(ci): pin the Flutter version
```

### Appendix D. Labels

| Group | Labels |
|---|---|
| type | story, task, bug, spike, decision |
| role | role:mobile, role:ai, role:data, role:qa-sec, role:product |
| priority | must, should, could |
| flow | blocked, release-blocker |
| other | risk, docs, play-track |

### Appendix E. Board columns and CODEOWNERS example [V:S-122]

Board columns: Backlog, Ready, In progress (limit 2 per member), In review (limit 3), Done.

```
# Reviewer requests by folder (replace the handles)
*                       @[T: group-leader]
/lib/                   @[T: mobile-lead]
/lib/**/domain/         @[T: data-lead]
/lib/**/ai/             @[T: ai-lead]
/lib/core/network/      @[T: qa-security-lead]
/firestore.rules        @[T: qa-security-lead]
/test/                  @[T: qa-security-lead]
/assets/reference/      @[T: data-lead]
/docs/                  @[T: product-legal-lead]
/tools/                 @[T: data-lead]
/.github/               @[T: product-legal-lead]
```

### Appendix F. README sections (from `NFR-19`)

1. How to build and run
2. Architecture and folders
3. Data sources and licences
4. Test commands and CI
5. Security notes (secrets, rules, permissions)
6. Task division (who owns what)

### Appendix G. Weekly individual report (one page)

```
Week / sprint: SPR-__    Member: ______    Role: ______    Date sent: ______
1. Planned items (IDs and effort): ______
2. Done items with evidence (pull request numbers, documents, tables): ______
3. Planned but not done, and why: ______
4. Days spent this week: ____ (plan: 2.5)    Reviews done: ____    Issues closed: ____
5. Blockers and help needed from the team or the trainer: ______
6. One thing I learned: ______
7. Where I used an AI assistant, and can I explain it? (yes / partly / no): ______
8. Next week's items (IDs): ______
```

### Appendix H. Sprint review checklist

- [ ] Every item of the sprint is Done by section 7.1, or its shortfall is written with the cause
- [ ] Each member showed their own merged work and answered one question
- [ ] Exit criteria of the sprint (section 3) checked one by one
- [ ] CI is green on `main`; no direct pushes happened
- [ ] Burn-up updated; capacity for next sprint checked
- [ ] Risks and open items updated (registers); decisions recorded
- [ ] Weekly reports sent; trainer feedback written down
- [ ] Retrospective action chosen, with an owner

## 13. Open items and assumptions added

The rows themselves are in `A-ASSUMPTIONS.md` (`ASM-56` to `ASM-65`), `C-OPEN-ITEMS.md` (`OPEN-77` to `OPEN-90`) and `B-SOURCES.md` (`S-118` to `S-123`); the lists below only point to them. `OPEN-26` and `OPEN-28` were answered in part by the team on 2026-10-11 and carry a note in their result cell.

### 13.1 Assumptions

| Topic | Assumption ID |
|---|---|
| Process thresholds of the work plan: first review within 2 working days, pull request of about 400 changed lin... | ASM-56 |
| Sprint 0 starts on Monday 2026-10-12, the first Monday after today, and a sprint is 7 days | ASM-57 |
| The final presentation is on 2026-12-01, the project end stated by the team, unless the trainer sets an earlie... | ASM-58 |
| The S plan assumes 2.5 productive days per member per week in SPR-00 to SPR-06 and 0.7 in SPR-07; the four mee... | ASM-59 |
| Split of existing totals: the spikes of TD-06 (8 in S, 12 in L) across SPK-01 to SPK-06 as 2.0/1.5/1.5/1.0/1.0... | ASM-60 |
| The Google Play track costs 3.0 person-days in total: build and signing 0.5, listing and privacy policy 1.0, t... | ASM-61 |
| Between S and L, spikes, report and demo and the dish count grow linearly with the weeks available, on the bas... | ASM-62 |
| Roles map to members in the order of the team list: Member A Mahmoud (Mobile lead), B Ahmed Gomaa (AI lead), C... | ASM-63 |
| Skill levels as the group leader stated: one mid level and four junior, with Cubit, Dio, sqflite and Firebase ... | ASM-64 |
| The trainer assesses each member once a week on a weekday not yet known; the weekly report is due the day befo... | ASM-65 |

### 13.2 Open items

| Topic | Open item ID |
|---|---|
| Real dates: project start, booklet announcement date, weekday of the weekly assessment, and the exact final pr... | OPEN-77 |
| How many productive days a week can each member give until 2026-12-01: 2.5 as this plan assumes, or 2.0 with t... | OPEN-78 |
| Is publication on Google Play inside the graded scope and the 2026-12-01 deadline, or after it? Which develope... | OPEN-79 |
| Is the repository public or private, and does the team plan allow protected branches and required reviews? Git... | OPEN-80 |
| The trainer's weekly individual assessment form, if it exists | OPEN-81 |
| The course teaches sqflite, Dio and Cubit. Does the trainer expect local sqflite storage and Cubit-only state,... | OPEN-82 |
| How `KC-06` counts progress: 04 does not say what "done" means for the W1 to W5 work (37.5 person-days in the ... | OPEN-83 |
| The gate dates in `04-FEASIBILITY.md` (2026-10-22 to 2026-11-12) cannot be met at this capacity: `GT-01`, `GT-... | OPEN-84 |
| In `05-REQUIREMENTS.md` the Open Food Facts lookup (FR-20) is a Should, but the brief item "Dio with intercept... | OPEN-85 |
| `SPK-02` in `04-FEASIBILITY.md` uses the first 60 dishes; the S plan has 17 dishes by the end of SPR-03 and 30... | OPEN-86 |
| The direct-estimate arm of `HYP-03` (FR-68) is a Should and is not in the S plan, so `HYP-03` has no evidence ... | OPEN-87 |
| The evaluation sessions (timing for `HYP-01`, SUS for `HYP-04`, any survey analysis) have no line in TD-06 or ... | OPEN-88 |
| The application id must be final before the first Play upload (early in SPR-03): decide it by the end of SPR-0... | OPEN-89 |
| Closed-test users would send real meal text to the AI model, which `ASM-32` and `GT-04` restrict to consenting... | OPEN-90 |

### 13.3 Sources

| Source | ID |
|---|---|
| The Scrum Guide, 2020 edition | S-118 |
| Conventional Commits 1.0.0 | S-119 |
| GitHub docs, GitHub flow | S-120 |
| GitHub docs, About protected branches | S-121 |
| GitHub docs, About code owners | S-122 |
| Google Play Console Help, app testing requirements for new personal developer accounts | S-123 |

### 13.4 Inconsistencies found in the existing files

- `04-FEASIBILITY.md` gate dates do not fit the capacity of the stated end date (`OPEN-84`); `KC-06` holds in the plan but does not define "done" (`OPEN-83`).
- `05-REQUIREMENTS.md` makes the Open Food Facts lookup a Should although the Dio brief item has no other live consumer in scenario S (`OPEN-85`).
- `SPK-02` assumes 60 dishes and `HYP-03` needs a Should item that S does not schedule (`OPEN-86`, `OPEN-87`).
- `ASM-42` (no Google Play release during the course) and the placeholder application id of `ADR-29` no longer match the team goal (`OPEN-79`, `OPEN-89`).
- `ASM-44` (the GitHub plan supports protected branches) may be false for a private repository on a free plan (`OPEN-80`).
