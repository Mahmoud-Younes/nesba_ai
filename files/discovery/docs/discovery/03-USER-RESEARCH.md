---
id: DISC-01-03
title: Nesba Discovery, Section 3 (user research)
parent: DISC-01
status: draft
last_verified: 2026-10-07
owner: TBD
---

> **AI NOTES**
> - What this is: Section 3 of the discovery set. Research plan, ethics, survey, interview guide, analysis plan, empty result templates and provisional personas. Hub: [DISCOVERY.md](DISCOVERY.md).
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U] and [T] as unknown, never as facts. No primary data exists yet. Personas are PROVISIONAL.
> - IDs defined here: UQ-01 to UQ-08, SQ-01 to SQ-20, IQ-01 to IQ-09, DR-01 to DR-06, TH-01 to TH-10, PER-01 to PER-03, RT-01 to RT-05.
> - The Arabic survey with identical IDs is in [03a-SURVEY-AR.md](03a-SURVEY-AR.md).

# 3. User research

Part of [DISCOVERY.md](DISCOVERY.md). The Arabic survey appendix is in [03a-SURVEY-AR.md](03a-SURVEY-AR.md).

> **No primary data has been collected yet. Everything below is a plan or a template.**

## 3.1 Research questions

| ID | Question | Decision it informs |
|---|---|---|
| UQ-01 | How do people track food today, and why do they stop? | Confirm or revisit the problem framing (`DR-01`) |
| UQ-02 | Do apps find their Egyptian dishes? | Scope and priority of the reference dish table (`OBJ-03`, `DR-06`) |
| UQ-03 | Will people type meals in free text? | Keep free text as the main input, or add pick-lists and voice sooner (`DR-04`) |
| UQ-04 | Do people trust AI-generated numbers, and does a source label help? | Prominence of the source label (`HYP-04`, `DR-05`) |
| UQ-05 | Are people worried about food data going to servers outside Egypt? | Local-only mode priority and consent wording (`DR-02`, `OBJ-08`) |
| UQ-06 | Which features matter most? | MVP order |
| UQ-07 | Which phone, app language and age band do respondents use? | Platform decision (`DR-03`), UI language |
| UQ-08 | Which general dietary restrictions matter? | Restriction list for recipes and alternatives (`OBJ-04`) |

## 3.2 Method

| Method | Plan | Notes |
|---|---|---|
| Online survey | Target n ≥ 50, absolute minimum 30 [A:ASM-11] | 20 questions, `SQ-01` to `SQ-20`. Pilot with 3–5 people first to time it [A:ASM-22] |
| Interviews | 5–8 interviews, 15–20 minutes each | Guide in §3.5. Note-taking, no audio unless the person agrees |
| Usability test (next step) | 5 users, SUS plus short trust questions | Runs after a working prototype. Feeds `HYP-04` |

**Recruitment plan.**

- Channels: university groups, gym and fitness circles, family and friends, workplace chats [A:ASM-11].
- Aim for a spread of age bands, both sexes, and both Android and iPhone users.
- Do not offer incentives that need personal details.
- Record how each respondent was reached (channel code only).

**Limitations (state them in the report).**

- Convenience sample. Not representative of Egypt [A:ASM-11].
- Self-report. People may overstate trust or willingness.
- Small n. Report counts and percentages, not significance claims.
- Survey and interviews reach people who already use phones and apps.
- The Android share in `EVD-07` is web traffic, not respondents. Do not mix them.

## 3.3 Ethics and privacy

| Topic | Decision |
|---|---|
| Who | Adults only (18+). The first question ends the survey for anyone younger |
| Identity | Anonymous. No names, phone numbers, emails, or IDs |
| Health questions | Optional. Limited to general dietary restrictions. No diagnoses, no medication, no weight or height |
| Storage | Team-managed survey tool, location to be confirmed (`OPEN-24`). Many form tools store data outside Egypt [A:ASM-20] |
| Access | The 5 team members and the supervising trainer only |
| Retention | Raw responses deleted 90 days after final grading [A:ASM-21]. Keep only group summaries |
| Interviews | Verbal consent. Participant codes (P01, P02, ...). Notes stored apart from any contact details |

**Law.** Egypt's Personal Data Protection Law No. 151 of 2020 treats health data as sensitive [V:S-016]. The Executive Regulations came by Ministerial Decision 816/2025, issued 1 Nov 2025 and public on 25 Dec 2025, with a one-year grace period and enforcement expected from 1 Nov 2026 on a strict reading, with some uncertainty [V:S-017,S-018,S-045]. Regulations call for Arabic privacy notices and written consent for sensitive data [V:S-017]. Whether anonymous survey answers fall under the law, and whether a student project must comply, is not settled here [U] [A:ASM-09,ASM-20]. Ask the supervisor or a legal adviser (`OPEN-20`). Until then, the survey follows the strictest reading: explicit consent, Arabic text, no identifiers.

**Consent text (English).** Use the Arabic version in `03a-SURVEY-AR.md` for Egyptian respondents.

> You are invited to take part in a short anonymous survey for a graduation project of the Digital Egypt Pioneers Initiative about food-logging apps. The project is supervised by a trainer ([T: trainer name]). It takes about [T: minutes, measured in the pilot]. You must be 18 or older.
>
> We do not ask for your name, phone number, email or any ID. Questions about dietary restrictions are optional and ask only about general preferences, not medical diagnoses.
>
> Your answers are stored in [T: survey tool and location]. Only the five team members and our trainer can see them. We will report group summaries only and delete the raw answers on [T: date; proposed 90 days after final grading, ASM-21].
>
> Taking part is voluntary. You can stop at any time by closing the page. By ticking the box you confirm that you are 18 or older and agree to take part. Contact: [T: team email].

## 3.4 Survey instrument

All questions are optional except `SQ-01`, `SQ-02` and the consent box. Likert scales run 1 (not at all) to 5 (very much).

| ID | Question | Type | Answer options / scale | Maps to | Decision it informs |
|---|---|---|---|---|---|
| SQ-01 | Are you 18 or older? | Screener, single choice | Yes / No (No ends the survey) | Ethics | Eligibility |
| SQ-02 | Do you currently live in Egypt? | Screener, single choice | Yes / No | UQ-07 | Sample scope |
| SQ-03 | Which phone do you mainly use? | Single choice | Android / iPhone / Other / No smartphone | UQ-07 | Platform (`DR-03`) |
| SQ-04 | What is your age band? | Single choice | 18–24 / 25–34 / 35–44 / 45–54 / 55+ / Prefer not to say | UQ-07 | Persona calibration |
| SQ-05 | What is your gender? (optional) | Single choice | Female / Male / Prefer not to say | UQ-07 | Cross-tabs |
| SQ-06 | Have you ever tracked what you eat (app, notes, or other)? | Single choice | Never / Tried and stopped / Currently tracking | UQ-01 | Base for `DR-01` |
| SQ-07 | If you tracked, how? | Multi-select | Calorie app / App with food photos / Notes or spreadsheet / Paper / Other | UQ-01 | Competitor shortlist |
| SQ-08 | If you stopped, what were the main reasons? (up to 3) | Multi-select | Took too much time or effort / Could not find my foods / Numbers seemed wrong / Lost motivation / No longer needed / Privacy concerns / Cost / App not in my language / Other | UQ-01, UQ-02 | `DR-01` |
| SQ-09 | About how long did it take to log one meal? | Single choice | Under 1 min / 1–2 min / 3–5 min / Over 5 min / Do not remember | UQ-01 | `HYP-01` baseline |
| SQ-10 | How hard was it to find Egyptian dishes (such as koshari or mahshi) in food apps? | Likert + option | 1–5 / Never tried | UQ-02 | `DR-06` |
| SQ-11 | Which dishes were hard to find? | Open text | Free text | UQ-02 | Dish table priority |
| SQ-12 | How willing are you to type a meal in your own words (for example "two taameya sandwiches and tea")? | Likert | 1–5 | UQ-03 | `DR-04` |
| SQ-13 | Rank how you would like to log meals. | Ranking | Type / Speak / Photo / Pick from a list / Scan barcode | UQ-03, UQ-06 | Input roadmap |
| SQ-14 | How much would you trust calories estimated by AI from your description? | Likert | 1–5 | UQ-04 | `HYP-04` |
| SQ-15 | Would seeing the source of each number make you trust it more? | Likert | 1–5 | UQ-04 | `DR-05` |
| SQ-16 | How concerned are you about food data being sent to servers outside Egypt? | Likert | 1–5 | UQ-05 | `DR-02` |
| SQ-17 | Pick the 3 features that matter most. | Multi-select (max 3) | Calories and macros per item / Source per item / Healthier alternatives / Recipes that match my restrictions / History and charts / Sync across devices / Works offline / Arabic interface / Other | UQ-06 | MVP order |
| SQ-18 | Do you follow any general dietary restriction? (optional, no diagnoses) | Multi-select | None / Vegetarian / Lactose-free / Gluten-free / Low sugar / Low salt / Fasting periods / Other / Prefer not to say | UQ-08 | Restriction list |
| SQ-19 | Which app language do you prefer? | Single choice | Arabic / English / Both | UQ-07 | UI language |
| SQ-20 | What would make you keep using a food-tracking app? | Open text | Free text | UQ-06 | Themes (§3.6) |

## 3.5 Interview guide

Start with the consent script. Say the person can skip any question. Do not ask about diagnoses.

| ID | Question | Probes |
|---|---|---|
| IQ-01 | Tell me what you ate yesterday. How would you record it today? | Which tool? How many steps? Which dish was hardest? |
| IQ-02 | Describe the last time you tried to track food. | What triggered it? What happened in week 1? Week 3? |
| IQ-03 | What made you stop or keep going? | Time, motivation, wrong numbers, cost, language |
| IQ-04 | Which of your usual dishes did the app handle badly? | Koshari, mahshi, ful, taameya; portion units (pieces, spoons) |
| IQ-05 | How do you decide whether a calorie number is right? | Do you check a label, a friend, a doctor? |
| IQ-06 | Show a paper mock-up of typing a meal and seeing items with sources. What do you think? | What is confusing? What would you change? |
| IQ-07 | Where do you think your food data should be kept? | Phone only, Egypt, abroad; what would worry you? |
| IQ-08 | Do you follow any general dietary guidance? Who gives it? | How would you want suggestions to respect it? |
| IQ-09 | Who helps you with food or phone apps? Which language do you prefer? | Family helper; Arabic or English; text size |

**Note-taking template.**

| Participant code | Date | Mode | Duration (min) | Context | Key behaviours | Pain points | Quote | Themes (`TH-`) | Follow-ups |
|---|---|---|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

## 3.6 Analysis plan

**Clean first.** Drop respondents who answered "No" to `SQ-01`, did not consent, or finished in an implausibly short time (set the cutoff after the pilot).

**Descriptive statistics.**

- Counts and percentages for single and multi-select items.
- Median and top-2-box share (answers 4–5) for Likert items.
- Mean for `SQ-16` only when the decision rule needs it (`DR-02`).

**Cross-tabs.** By phone type (`SQ-03`), tracking status (`SQ-06`) and age band (`SQ-04`). Show cell counts. Flag any cell under 5.

**Coding scheme for open answers** (`SQ-11`, `SQ-20`, interviews). Two team members code independently, then resolve differences by discussion. Add new themes only after both agree.

| ID | Theme |
|---|---|
| TH-01 | Time or effort of logging |
| TH-02 | Missing or wrong foods in the database |
| TH-03 | Doubt about number accuracy |
| TH-04 | Motivation and habit |
| TH-05 | Privacy and data location |
| TH-06 | Language and Arabic interface |
| TH-07 | Cost and paywalls |
| TH-08 | Dietary restrictions and guidance |
| TH-09 | Family or helper involvement |
| TH-10 | Portion units and home cooking |

**Decision rules.** All are team judgement [A:ASM-15]. Check each rule on the real data, then record the outcome in RT-05.

| ID | Rule | Action |
|---|---|---|
| DR-01 | Fewer than 40% of people who track or quit name time or effort as a main reason (`SQ-08`) | Revisit the problem framing |
| DR-02 | Mean concern about foreign servers (`SQ-16`) is above 4 of 5 | Make a local-only mode a priority |
| DR-03 | Most respondents use iPhone (`SQ-03`) | Revisit the platform decision |
| DR-04 | Median willingness to type (`SQ-12`) is below 3 | Add pick-lists and voice earlier |
| DR-05 | Median source-label trust (`SQ-15`) is below 3 | Lower the prominence of source labels |
| DR-06 | Fewer than 40% rate Egyptian dish finding as hard, 4–5 (`SQ-10`) | Reduce the breadth target of the dish table |

Because the sample is a convenience sample, `DR-03` alone cannot change the platform. Compare with `EVD-07` before acting.

## 3.7 Results templates

All tables below are empty and marked [T].

**RT-01 Respondent profile**

| Item | n | % |
|---|---|---|
| Total valid responses | [T] | [T] |
| Android / iPhone / Other (`SQ-03`) | [T] | [T] |
| Age bands (`SQ-04`) | [T] | [T] |
| Never / Stopped / Currently tracking (`SQ-06`) | [T] | [T] |
| Recruitment channel | [T] | [T] |

**RT-02 Answers per question**

| SQ ID | n answered | Summary (counts, median, top-2-box) | Notes |
|---|---|---|---|
| SQ-01 to SQ-20 | [T] | [T] | [T] |

**RT-03 Theme counts**

| Theme | Survey mentions | Interview mentions | Example paraphrase |
|---|---|---|---|
| TH-01 to TH-10 | [T] | [T] | [T] |

**RT-04 Interview summary**

| Participant code | Main behaviours | Main pain points | Reaction to `IQ-06` mock-up | Themes |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

**RT-05 Decision-rule outcomes**

| Rule | Value observed | Fired? (Y/N) | Action taken |
|---|---|---|---|
| DR-01 to DR-06 | [T] | [T] | [T] |

## 3.8 Personas

All personas are `PROVISIONAL`: hypotheses built from cited public evidence and team judgement. They are not research findings. Names are fictional.

### PER-01 Mona (fictional)

- Age band: early 30s. Status: `PROVISIONAL`.
- Context: working woman who cooks at home and wants gradual weight loss [A:ASM-12].
- Devices and language: Android phone, Arabic first, some English [A:ASM-01].
- Current tracking: has tried a calorie app and may have stopped [A:ASM-12].
- Goals: steady weight change without long logging sessions.
- Frustrations: multi-ingredient dishes are slow to enter and often missing [V:S-006,S-008].
- Needs from Nesba: describe a meal in her own words; see each item and its source.
- Design implications: free-text box first; Arabic UI; one-tap edit of portions in household units.
- Evidence: women's obesity prevalence gives context [V:S-001]; Android share [V:S-005]; logging barriers [V:S-006].
- Quote: [T] fill from interviews.
- Validation: `SQ-06` to `SQ-10`, `SQ-12`; `IQ-01` to `IQ-04`.

### PER-02 Karim (fictional)

- Age band: around 21. Status: `PROVISIONAL`.
- Context: university student who trains at the gym and tracks protein [A:ASM-12].
- Devices and language: Android phone, English apps, Arabic for food names [A:ASM-12].
- Current tracking: uses a global app; may hit paywalls, since barcode, voice and meal scan are paid in one major app [V:S-019].
- Goals: hit a daily protein target with minimal effort.
- Frustrations: Egyptian foods (ful, taameya, koshari) are hard to find or log accurately [U].
- Needs from Nesba: protein per item, quick entry, history chart.
- Design implications: show macros per item with source; fast repeat of common meals.
- Evidence: [V:S-019] for paywall; the rest [A:ASM-12].
- Quote: [T] fill from interviews.
- Validation: `SQ-07`, `SQ-08`, `SQ-13`, `SQ-17`; `IQ-02`, `IQ-04`.

### PER-03 Samir (fictional)

- Age band: around 55. Status: `PROVISIONAL`.
- Context: follows a doctor's general dietary guidance, helped by a family member; finds English-only apps hard to use [A:ASM-12].
- Devices and language: Android phone, Arabic only, large text helps [A:ASM-12].
- Current tracking: probably none, or paper notes [A:ASM-12].
- Goals: follow guidance without confusion.
- Frustrations: English interface and small text [A:ASM-12].
- Needs from Nesba: Arabic-first screens, simple flow, suggestions that respect declared restrictions. No medical advice.
- Design implications: large type; helper can enter meals; clear "information only" notice.
- Evidence: [A:ASM-12]. Current Egyptian diabetes figure is not retrieved [U].
- Quote: [T] fill from interviews.
- Validation: `SQ-04`, `SQ-18`, `SQ-19`; `IQ-08`, `IQ-09`.

### Update procedure

1. Close the survey and finish interviews. Fill RT-01 to RT-05.
2. For each persona, list the facts that data supports and those it does not.
3. Replace [A] evidence with [V] evidence from the team's own data, citing the survey or interview codes.
4. Edit goals, frustrations and needs to match the themes. Drop any detail with no support.
5. Add quotes only from real interviews, marked with the participant code.
6. Change status from `PROVISIONAL` to `VALIDATED`, or merge, split, or delete the persona.
7. Record the change in the log below and bump `status` in the front matter.

**Change log**

| Date | Persona | Change | Evidence (codes) | By |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |

## 3.9 Optional appendix

The survey and consent text translated to Arabic, with identical IDs, are in [03a-SURVEY-AR.md](03a-SURVEY-AR.md). It is the only Arabic content in this set.
