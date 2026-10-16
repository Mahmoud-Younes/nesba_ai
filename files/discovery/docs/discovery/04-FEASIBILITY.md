---
id: DISC-01-04
title: Nesba Discovery, Section 4 (feasibility study)
parent: DISC-01
status: draft
last_verified: 2026-10-10
owner: TBD
---

# 04 - Feasibility Study: Go/No-Go, Risk Register, Methods (Nesba)

## AI NOTES

- Decision: **Conditional Go**. Build the local-first pipeline (LLM parses, code computes, Firestore syncs); three gates (GT-01, GT-02, GT-04) must pass before the pilot.
- Stack: Gemini 3.5 Flash-Lite via Firebase AI Logic (parse) + local Egyptian dish table + bundled USDA subset + Open Food Facts by barcode (resolve) + Dart (compute) + Firestore offline persistence + Dio.
- Top 3 risks: RSK-01 Egypt PDPL cross-border transfer of health-adjacent data (deadline about 1-2 Nov 2026); RSK-02 Gemini free tier lets Google use inputs; RSK-03 no verified reference data for Egyptian dishes (OPEN-21).
- Tags: [V:S-xxx] a source states it; [A:ASM-xxx] assumption; [U] unverified; [T] for the team to fill with real data.
- Treat every [U] and [T] as unknown. The provisional 9xx IDs were renumbered into the registers on 2026-10-09 (section 11).

## 1 Decision summary

Overall decision: **Conditional Go** for the MVP and a restricted pilot. Nothing in the evidence stops the project; several things must be proven by the team's own spikes.

| Layer | Decision | Key evidence | Gate |
|---|---|---|---|
| Parse | `gemini-3.5-flash-lite` through Firebase AI Logic (free tier on Spark for development); `gemini-3.8-flash` as quality fallback | Free tier, price and model list [V:S-075]; AI Logic is free and the Developer API free tier needs no billing account [V:S-078] | GT-02 |
| Resolve | 1) team Egyptian dish table 2) bundled USDA subset (CC0) 3) Open Food Facts by barcode 4) LLM estimate flagged `AI_ESTIMATE` | USDA is public domain, CC0 [V:S-082]; OFF limits and licences [V:S-070] | GT-03 |
| Compute | Dart code, unit-tested; LLM never restates totals | Text-only LLM estimates are strong for energy/macros per 100 g but not exact per item [V:S-056]; grounded designs report F1 0.79-0.89 [V:S-089] | GT-03 |
| Sync | Firestore offline persistence; listen to snapshots; never `await` an offline write in the UI path | Official offline behaviour [V:S-071]; transactions fail offline [V:S-072] | GT-01 |
| Networking | Dio + interceptor chain (User-Agent, App Check token, retry, cache, redacted logs, error mapping) | OFF needs a custom User-Agent and per-user limits [V:S-070] | GT-01 |
| Security | No secret in APK; App Check; Firestore rules with emulator tests | Firebase docs list App Check and rules testing [V:S-071 nav]; to be proven by SPK-05 | GT-01 |
| Legal | Restricted pilot until GT-04; synthetic or consented data only | Egypt PDPL Executive Regulations issued 1 Nov 2025; transfers abroad need a PDPC licence [V:S-084] | GT-04 |
| Not used | Edamam, CalorieNinjas/API Ninjas, Spoonacular, DietlyAPI (as a dependency) | Cost, storage terms, premium-gated fields, free tiers limited to non-commercial or tiny quotas [V:S-063, S-067, S-068, S-085, S-069] | - |

Conditions for "Go" (each maps to a gate in section 7):

| # | Condition | Proven by | By |
|---|---|---|---|
| 1 | Firestore offline loses no data and never blocks the UI in the airplane-mode scenarios | SPK-04 | 2026-10-22 |
| 2 | No secret ships in the APK; AI calls fail without an App Check token | SPK-05 | 2026-10-22 |
| 3 | A pilot data policy is decided before the PDPL compliance date | GT-04 (legal read) | 2026-10-30 |
| 4 | Parser reaches the SPK-01 thresholds on Egyptian dialect | SPK-01 | 2026-10-29 |
| 5 | Local tables resolve enough names to avoid the LLM for most items | SPK-02 | 2026-10-29 |
| 6 | Grounded pipeline beats direct LLM on reference meals | SPK-03 (needs OPEN-21) | 2026-11-05 |

## 2 Scope and method

| Item | Statement |
|---|---|
| Question | Which APIs, AI models and architecture can a zero-budget team of 5 actually use, and what could stop it? |
| Date of research | 2026-10-08. All prices, limits and terms were read on this date unless the source table says "excerpt". |
| Source tiers | A official/papers/government/law firms; B independent/news/aggregators; C vendor or affiliate (conflicts only, never [V]). |
| Not done | No accounts, keys, registrations or live tests. Spikes are designed, not run. |
| Limit 1 | Written without access to the earlier files. On 2026-10-09 the quoted IDs were checked against them: `OBJ-01`, `OBJ-03`, `HYP-02`, `HYP-03`, `OPEN-21`, `OPEN-26`, `SCP-IN-` and `EVD-17` to `EVD-19` match. |
| Limit 2 | New IDs were written as a provisional 9xx block. On 2026-10-09 they were renumbered to continue each register (`S-056` to `S-092`, `ASM-23` to `ASM-37`, `OPEN-36` to `OPEN-51`). Map in section 11. |
| Limit 3 | Registers (`A-ASSUMPTIONS.md`, `B-SOURCES.md`, `C-OPEN-ITEMS.md`) and the `DISCOVERY.md` file map, prefix list and revision log were updated on 2026-10-09. |
| Limit 4 | The self-check script (`tools/check_discovery.py`) was extended with the prefixes `CL-`, `OPT-`, `TD-`, `SPK-`, `GT-`, `RSK-`, `KC-` and run on 2026-10-09. |
| Disclosure | This study was written by Claude, an Anthropic model. Anthropic is one of the vendors compared in TD-02. Its scores follow the same rubric as the others and its price page was read like the others; the team should still weigh this. |
| Scoring | Matrices use 0-5 scores and weights summing to 100. Score = sum(weight x score) / 5, giving 0-100. Weights are team-adjustable [A:ASM-30]. Scores are judgments grounded in the cited facts. |

## 3 Claim ledger (two earlier individual documents: leads, not sources)

Verdicts: Confirmed / Corrected / Unverified / Discarded.

| ID | Claim in earlier documents | Verdict | What the evidence says |
|---|---|---|---|
| CL-01 | J Nutr (July 2026) compared four LLMs on text | **Corrected** | The study exists: Lawabni et al., J Nutr 2026;156(9):101712, epub 2026-07-04 [V:S-057]. A later paper summarises it as 194 frequently eaten US foods, four LLMs, strong agreement for energy and most macros, weaker for several micronutrients [V:S-056]. It does not show a +-15-20% accuracy for Egyptian dishes. Full text not opened (PubMed blocked by reCAPTCHA); exact statistics [U] (OPEN-36). Use only as evidence for energy and macros on item-level queries. |
| CL-02 | Frontiers 2026, nine LLMs vs Chinese table | **Confirmed, with numbers** | 299 Chinese foods, 9 LLMs, 3 runs each, per 100 g edible portion, English batch prompt [V:S-056]. Energy ICC 0.945-0.989 (mean 0.971); energy MAE 9.85 kcal (best model) and 10.24 kcal; 95% limits of agreement about +-55 kcal/100 g; mean energy MAPE 13.4% across models. Micronutrients weaker (mean ICC: vitamin A 0.486, zinc 0.527, iron 0.599). Mean MAPE per model over all 15 components was 60-90%, inflated by near-zero references. Not meals, not portions, not Arabic. Models were July 2026 versions, e.g. Gemini 3.1 Flash-Lite and Claude Sonnet 4.5 ranked mid/low; the ranking is descriptive only. |
| CL-03 | Multimedia Systems (Mar 2026), 88.12% | **Unverified -> Discarded** | A paper of that journal and date exists: "multimodal deep learning framework for nutritional estimation and health-oriented recipe analysis", 32(2), 2026-03-04 [V:S-087]. The 88.12% figure and the task were not found; abstract not read (OPEN-48). A multimodal recipe-analysis model is not text meal logging. Discard. |
| CL-04 | Arabic Cuisine Benchmark 1,597 questions; Jais 2 70B 79.02%, 8B 66.48%; same figures for dialect ID | **Discarded** | One targeted search found no such benchmark. QIMMA lists different Jais 2 values: 70B-Chat average 65.81, 8B-Chat 57.89; AraDiCE column 78.89 (70B) and 65.56 (8B); ArabCulture 83.24 / 68.99 [V:S-058]. The two figures cannot be tied to either benchmark (OPEN-45). Jais 2 itself is real: 8B and 70B open-weight, announced 2025-12-09 [V:S-059]. No Egyptian-dialect claim may be made from these numbers. |
| CL-05 | Jais 2 8B is enough for the MVP | **Rejected for MVP** | Weights are Apache 2.0, but the model card says no inference provider deploys it; a web chat app exists, not an API [V:S-060]. Using it needs hosting; no zero-cost hosting route is documented (rule 6). Recheck at GT-02 (OPEN-47). |
| CL-06 | Edamam Free/$99/$499; Arabic; about 50 requests/day free; caching to cut cost | **Corrected** | Food Database API: Enterprise Basic $14/month (30-day trial, 100,000 calls/month, 50 req/min, caches FoodId and label only), Core $69 (750,000 calls), Plus $299, Unlimited custom; attribution required or suspension; human end-user requests only; data shown to the requesting user, not stored unless permitted [V:S-063]. Nutrition Analysis API is separate: Basic Multilingual $29/month (10-day trial, 10,000 text lines/month, no caching, no commercial use) and lists Arabic among 10 languages via real-time translation to English [V:S-064]. No free plan and no "$99/$499" or "50/day" found. "Cache results to cut cost" would breach the terms on the cheapest plan: confirmed. Read 2026-10-08. |
| CL-07 | BiteRight API: Arabic, clinical rules | **Discarded as an API** | BiteRight is a consumer app (photo/voice/text logging, "medical rules engine"); a product directory lists "API" among platforms [V:S-088, tier C]. No official API docs, pricing or terms found. |
| CL-08 | FatSecret: no Arabic, image only | **Corrected** | Basic: free, self sign-up, 5,000 calls/day, English, attribution. Premier Free (startups, non-profits, students; verification required): unlimited calls, US dataset, premium features, attribution. Premier: 26 languages. NLP and image recognition exist as optional add-ons for Premier and Premier Free with usage-based cost and a 14-day trial [V:S-065]. Arabic in the language list and storage terms not read (OPEN-43). |
| CL-09 | CalorieNinjas: 1,000 requests/month free, best for free text | **Confirmed (shutdown, gating); free quota Discarded** | CalorieNinjas says it is being turned down and moves to API Ninjas [V:S-066]. API Ninjas marks `calories` and `protein_g` as premium fields [V:S-067]. Free plan: $0, evaluation, 3,000 calls/month, non-commercial (personal use and dev/testing/evaluation only); Developer plan $39/month shown [V:S-068]. "1,000/month" not found. |
| CL-10 | DietlyAPI 4.7M+ foods, permanent free tier, text analysis | **Corrected** | Vendor posts give 4.2M+ and 850k+ foods; Starter free tier 30 req/min per IP, non-commercial; Pro EUR 27/month; built on Open Food Facts plus community and "labeled AI-estimated entries" [V:S-069, tier C]. Search is fuzzy name search, not sentence parsing. Arabic [U]. |
| CL-11 | Open Food Facts: fully open, fair use | **Confirmed, with detail** | Live docs: 15 req/min/IP for product reads, 10 req/min/IP for search, per user when calls come from a mobile app; custom User-Agent `AppName/Version (ContactEmail)`; ODbL (database), DbCL (contents), CC BY-SA (images); no plain-text search in the v2 server API (Search-a-licious is separate); v3 current, v2 deprecated; use data exports beyond a few hundred products [V:S-070]. A cached snippet of the same URL showed 100 req/min; the live page says 15. Design for 15. |
| CL-12 | Firestore `set()`/`update()` hang offline; transactions fail; RAM crash; NO-GO as sole mechanism | **Corrected: NO-GO not supported** | Official page (updated 2026-10-06): persistence on by default on Android and Apple; default cache 100 MB, minimum 1 MB; listeners receive local events while offline; writes queue while network is disabled; offline `get` of a missing document errors; offline queries see only cached documents; last write wins [V:S-071]. Transactions fail when offline; batched writes run offline [V:S-072]. That an awaited write completes only on server acknowledgement [U] (not in the fetched text; test in SPK-04). Issues #17643 and #13145 could not be opened by three routes [U] (OPEN-37). Related reports found: #8496 (Android listener after offline update, fixed by a later Firebase Android SDK), #12952 (increment updates may be lost on unstable connection, open), discussion #5708 (offline `get` errors) [V:S-074, tier B]. RAM-crash and multi-user claims [U]. Verdict: Conditional Go with gate GT-01. |
| CL-13 | `riverpod_offline_sync`, `flutter_data_sync_manager` | **Corrected** | Both exist on pub.dev: `riverpod_offline_sync` (versions 0.1.0 to 1.0.6 seen, Hive queue, Firebase integration) and `flutter_data_sync_manager` (^1.0.1; Firestore adapter is "your custom adapter"); also `flutter_offline_sync_manager` 0.1.2 [V:S-086]. Publisher, licence, last release and popularity [U] (OPEN-46). Young, single-purpose packages: not adopted for core data. |
| CL-14 | LLM rephrases the result in natural language | **Design rule kept** | Numbers come from code; the LLM never restates or alters totals. Supported by grounded-pipeline work that keeps database numbers separate from LLM extraction [V:S-089] and by the advice to verify LLM nutrient values against validated tables [V:S-056]. |
| CL-15 | Targets: 4 s, +-20% for 80%, 10 dishes, 50 test dishes, 50 MB, 200 MB RAM | **Table only** | See section 10. No existing `OBJ-` or `HYP-` was changed. |
| CL-16 | Risk register R1-R10 | **Corrected** | Missing risks added (section 8). The deprecation claim is **not confirmed**: the official deprecations page (updated 2026-10-07) shows `gemini-2.5-flash` with no shutdown date, says 2.5 models are limited to past users and not deprecated, and tells new projects to use 3.5 Flash-Lite or 3.8 Flash [V:S-076]. The lifecycle concern is real: `gemini-3.1-flash-lite` shuts down 2027-05-07 (replacement 3.5 Flash-Lite) and 3.8 Flash input/output prices double on 2027-01-01 [V:S-076, S-075]. |
| CL-17 | Recommend CalorieNinjas or DietlyAPI as primary free-text analyser | **Discarded** | Conflicts with the LLM-parses design, CL-09 (shutdown, gated fields) and CL-10 (non-commercial free tier, fuzzy search, Arabic unverified). |

## 4 Working hypothesis: confirmed or changed

| Layer | Verdict | What changed and why |
|---|---|---|
| Parse (LLM to JSON) | Confirmed | Text-only LLMs agree well with reference tables for energy and macros per item, much less for micronutrients [V:S-056]. Parse step only; no numbers trusted from it. |
| Resolve (local first) | Confirmed, refined | USDA data is CC0 so a bundled subset is allowed [V:S-082]. Open Food Facts is fetched live by barcode and **not merged** into the bundled DB, to avoid ODbL share-alike on a derived database [V:S-070] [A:ASM-36]. |
| Compute (Dart) | Confirmed | Reproducibility rule; supports `HYP-03` test (SPK-03). |
| Storage and sync | Confirmed, conditional | Official docs support offline persistence and snapshot listening [V:S-071]. Custom engine only if the SPK-04 trigger in KC-03 fires. |
| Networking | Confirmed | Dio is mandatory; OFF requires a custom User-Agent and limits per user [V:S-070]. |
| AI access | Confirmed with a split | Firebase AI Logic is free and the Gemini Developer API free tier works without billing [V:S-078]. But the free tier lets Google use inputs to improve products [V:S-075], so real-user meal text may only go to a **paid** tier. Flutter SDK name, App Check limited-use token support and processing location are [U] (OPEN-39). |
| Not used: Edamam | Confirmed | No free plan; storage and display limits [V:S-063]. |
| Not used: CalorieNinjas / API Ninjas | Confirmed | Shutdown notice; premium-gated fields; non-commercial free tier [V:S-066, S-067, S-068]. |
| Optional: DietlyAPI | Changed: dropped from the stack | Free tier is non-commercial; includes AI-estimated entries; Arabic [U] [V:S-069, tier C]. Kept only as a comparison candidate in SPK-02. |

## 5 Work packages

### TD-01 Food data and APIs

**Options.**

| ID | Option | Plan or form checked (date 2026-10-08) |
|---|---|---|
| OPT-01 | USDA FoodData Central: API plus bulk download | Free data.gov key; 1,000 requests/hour/IP default; data CC0 [V:S-082] |
| OPT-02 | Open Food Facts | Public API v3; 15 req/min reads, 10 req/min search; ODbL/DbCL/CC BY-SA [V:S-070] |
| OPT-03 | DietlyAPI | Starter (free, non-commercial, 30 req/min/IP); Pro EUR 27/month [V:S-069, tier C] |
| OPT-04 | API Ninjas Nutrition (CalorieNinjas successor) | Free: 3,000 calls/month, non-commercial; calories and protein premium-only [V:S-067, S-068] |
| OPT-05 | Edamam Food Database / Nutrition Analysis | Enterprise Basic $14/month (trial 30 days) / Basic Multilingual $29/month (trial 10 days) [V:S-063, S-064] |
| OPT-06 | FatSecret Platform | Basic free 5,000 calls/day English; Premier Free for students (verification); NLP add-on paid [V:S-065] |
| OPT-07 | Nutritionix | No official page opened; **not scored** [U] (OPEN-42) |
| OPT-08 | Spoonacular | Free tier of about 50 points/day; cache limited to about one hour [V:S-085, tier B] |
| OPT-09 | Egyptian printed composition tables (National Nutrition Institute 1996 via FAO/INFOODS) | Listed by INFOODS; reuse terms and digital form [U] [V:S-083] |
| OPT-10 | LLM only | Free tier or paid, per TD-02 |
| OPT-11 | Team-built Egyptian dish table (recipes decomposed with USDA ingredient values, dietitian review) | Own data; labour cost [A:ASM-34] |

**Criteria and weights** [A:ASM-30]: C1 licence and storing results in a user log (25); C2 free access and continuity (20); C3 generic and home-cooked coverage (15); C4 Egyptian and Arabic coverage (15); C5 packaged coverage (5); C6 text parsing (5); C7 rate limits (5); C8 Flutter/Dart support (5); C9 key-protection needs (5).

| Option | C1 | C2 | C3 | C4 | C5 | C6 | C7 | C8 | C9 | Score /100 | Gate: per-item source |
|---|---|---|---|---|---|---|---|---|---|---|---|
| OPT-11 team dish table | 4 | 5 | 3 | 4 | 0 | 3 | 5 | 5 | 5 | **79.0** | pass |
| OPT-01 USDA | 5 | 5 | 4 | 1 | 3 | 1 | 4 | 3 | 4 | **75.0** | pass |
| OPT-10 LLM only | 4 | 3 | 4 | 2 | 2 | 5 | 2 | 4 | 3 | 66.0 | **fail** |
| OPT-02 Open Food Facts | 3 | 4 | 1 | 2 | 5 | 1 | 2 | 4 | 5 | 57.0 | pass |
| OPT-09 Egyptian tables | 1 | 3 | 3 | 5 | 0 | 0 | 5 | 3 | 5 | 54.0 | pass |
| OPT-06 FatSecret | 2 | 3 | 3 | 1 | 4 | 3 | 4 | 3 | 2 | 50.0 | pass |
| OPT-03 DietlyAPI | 2 | 3 | 2 | 1 | 4 | 1 | 3 | 3 | 4 | 46.0 | pass |
| OPT-05 Edamam | 1 | 0 | 4 | 2 | 4 | 5 | 4 | 3 | 2 | 41.0 | pass |
| OPT-04 API Ninjas | 3 | 1 | 2 | 1 | 1 | 4 | 2 | 3 | 2 | 40.0 | pass |
| OPT-08 Spoonacular | 1 | 2 | 3 | 1 | 3 | 4 | 1 | 3 | 2 | 38.0 | pass |

Formula example: OPT-11 = (25x4 + 20x5 + 15x3 + 15x4 + 5x0 + 5x3 + 5x5 + 5x5 + 5x5) / 5 = 395 / 5 = 79.0.

**Score notes.**

| Option | Facts behind the scores |
|---|---|
| OPT-11 | C4 4 only if a dietitian reviews entries (RSK-09); C3 limited to the dishes entered (`OBJ-03` asks 100-200). |
| OPT-01 | CC0 and bulk download remove quota and storage risk [V:S-082]; Egyptian dishes absent [A:ASM-34]. |
| OPT-10 | Energy and macros agree well with tables per 100 g [V:S-056], but no per-item source and no reproducibility: fails the "every number shows its source" flow. |
| OPT-02 | Packaged only; rate limits low; share-alike if merged [V:S-070]; Dart package exists on pub.dev [V:S-070]. |
| OPT-09 | Egyptian content but 1996 print edition; reuse terms [U]; usable as a cross-check for OPEN-21, not as a dependency. |
| OPT-05 | No permanent free plan; cheapest plan caches only FoodId and label; attribution mandatory [V:S-063]. |
| OPT-04 | Free tier allows development, testing and evaluation, but the energy field is gated [V:S-067, S-068]. |

**Decision `TD-01`.** Winner: OPT-11 + OPT-01 as layers 1-2 (local, offline, no quota). Runner-up: OPT-02 for barcode lookup of packaged foods only. Others lost on storage terms (OPT-05, OPT-08), shutdown or gating (OPT-04), non-commercial or unclear continuity (OPT-03), or failing the per-item-source gate (OPT-10). OPT-07 not decided [U].

**Kill criterion `KC-01`.** Reverse if SPK-02 shows the local layers resolve fewer than 70% of the 20 dish names within three candidates after the team has entered its first 60 dishes [A], **or** if no dietitian or nutrition reviewer can be found by GT-03. Then move dishes to LLM estimate with a range, labelled `AI_ESTIMATE`, and lower `OBJ-03`.

### TD-02 AI models

**Options** (all names and prices read today from the vendor's own page).

| ID | Option | Free or cheap today | Key facts |
|---|---|---|---|
| OPT-20 | `gemini-3.5-flash-lite` via Firebase AI Logic | Free tier; paid $0.30 in / $2.50 out per 1M tokens (standard) [V:S-075] | Free-tier content used to improve products: yes; paid: no [V:S-075]. Rate limits per project, not per key; free-tier numbers shown only in AI Studio; limits not guaranteed [V:S-077]. |
| OPT-21 | `gemini-3.8-flash` | Free tier; $0.75 / $3.75 until 2026-12-31, then $1.50 / $7.50 [V:S-075] | Higher quality; price doubles on 2027-01-01. |
| OPT-22 | Claude Haiku 5.5 (own proxy) | No free tier; $0.10 / $0.50 per 1M tokens up to 100k prompt; small free credits for new users [V:S-079] | Newer tokenizers can produce up to about 30% more tokens [V:S-079]. No Firebase client path; needs a server proxy. |
| OPT-23 | OpenAI GPT-5.6 Luna (own proxy) | $0.20 / $1.20 per 1M tokens; no free tier shown on the page [V:S-080] | Aggregator sites listed wrong prices for the same model; only the vendor page was used. |
| OPT-24 | Mistral free tier (own proxy) | Free "Experiment" tier reported by news (tier B) [V:S-081] | Limits, data-use terms and region [U] (OPEN-41). |
| OPT-25 | Gemma 4 through the Gemini API | Free tier only, no paid tier [V:S-075] | Open model hosted by Google; Arabic and JSON ability [U]. |
| OPT-26 | Jais 2 (8B/70B) | No hosted endpoint found [V:S-060] | Rejected by rule 6 (CL-05). Not scored. |

**Criteria and weights** [A:ASM-30]: K1 free or very cheap today (25); K2 data use, training and PDPL implications (15); K3 structured JSON output (10); K4 Arabic and Egyptian-dialect evidence (15); K5 key protection and Flutter path (15); K6 lifecycle and deprecation risk (10); K7 quota adequacy for the pilot (5); K8 latency (5, all [U] until SPK-06).

K1 rubric: 5 usable free tier; 4 free tier with unknown limits; 3 cheap with free credit; 2 under $1 per 1,000 analyses, card required; 1 more than that.

| Option | K1 | K2 | K3 | K4 | K5 | K6 | K7 | K8 | Score /100 |
|---|---|---|---|---|---|---|---|---|---|
| OPT-20 Gemini 3.5 Flash-Lite | 5 | 2 | 4 | 2 | 4 | 3 | 3 | 3 | **69.0** |
| OPT-21 Gemini 3.8 Flash | 4 | 2 | 4 | 2 | 4 | 2 | 3 | 2 | 61.0 |
| OPT-25 Gemma 4 (Gemini API) | 4 | 2 | 3 | 2 | 3 | 3 | 3 | 3 | 59.0 |
| OPT-24 Mistral | 3 | 3 | 4 | 2 | 2 | 3 | 3 | 3 | 56.0 |
| OPT-22 Claude Haiku 5.5 | 2 | 3 | 4 | 2 | 2 | 3 | 3 | 3 | 51.0 |
| OPT-23 GPT-5.6 Luna | 2 | 3 | 4 | 2 | 2 | 3 | 3 | 3 | 51.0 |

OPT-22 and OPT-23 tie because the rubric puts both in the same price band; Haiku 5.5 is the cheaper of the two [V:S-079, S-080].

**Arabic and dialect evidence (K4 = 2 for all).** No benchmark of the candidate hosted models on Egyptian dialect was found. Egyptian and Levantine dialect understanding was studied in AraDiCE, which found Arabic-centric models stronger on dialects than general models, but with older models [V:S-061]. A dialect-focused MMLU variant evaluates recent frontier models; only its abstract was seen [V:S-062]. QIMMA gives Jais 2 scores but not for the hosted candidates in the excerpt read [V:S-058]. Marketing claims were ignored. **SPK-01 is the evidence.**

**Decision `TD-02`.** Winner: OPT-20 for development and, on a paid tier, for the pilot. Runner-up: OPT-21 for items where OPT-20 fails the SPK-01 threshold. Plan B: OPT-22 or OPT-23 behind a proxy (needs a server and likely a billing account; Cloud Functions on the free plan [U], OPEN-49).

**Kill criterion `KC-02`.** Reverse if any holds: (a) on Egyptian-dialect inputs OPT-20 and OPT-21 both miss the SPK-01 recall threshold while a Plan B model passes; (b) the free tier is removed or its daily limit falls below the dev need and no billing account exists; (c) the chosen model gets a shutdown date within 90 days; (d) Flutter SDK or App Check cannot protect the call (SPK-05).

**Cost and quota model.** Formula: cost per 1,000 analyses = (in_tokens x price_in + out_tokens x price_out) x 1,000 / 1,000,000.

| Input | Value | Tag |
|---|---|---|
| One analysis | one LLM call | [A:ASM-23] |
| Input tokens | 960 (system prompt + schema 900, meal text 60) | [A:ASM-23] |
| Output tokens, lean | 350 (3-5 items of JSON) | [A:ASM-23] |
| Output tokens, thinking on | 850 (adds 500 thinking tokens, billed as output) | [A:ASM-24] |
| Dev calls | 5 devs x 40 calls/day x 20 days = 4,000 | [A:ASM-27] |
| Spike calls | SPK-01 30 meals x 3 models x 3 runs = 270; SPK-03 30 meals x 2 pipelines x 3 runs = 180 | [A:ASM-27] |
| Pilot calls | 50 users x 3 analyses/day x 14 days = 2,100 | [A:ASM-26] |
| Total calls | 4,000 + 450 + 2,100 = 6,550 | derived |

| Model | Price in / out per 1M [V] | Per 1,000 analyses, lean | Thinking on | Total 6,550 calls, lean |
|---|---|---|---|---|
| gemini-3.5-flash-lite | $0.30 / $2.50 [V:S-075] | $1.16 | $2.41 | $7.62 |
| gemini-3.1-flash-lite | $0.25 / $1.50 [V:S-075] | $0.77 | $1.52 | $5.01 |
| gemini-3.8-flash (to 2026-12-31) | $0.75 / $3.75 [V:S-075] | $2.03 | $3.91 | $13.31 |
| gemini-3.8-flash (from 2027-01-01) | $1.50 / $7.50 [V:S-075] | $4.07 | $7.82 | $26.63 |
| claude-haiku-5-5 | $0.10 / $0.50 [V:S-079] | $0.27 (x1.3 tokens: $0.35) | [U] | $1.78 |
| gpt-5.6-luna | $0.20 / $1.20 [V:S-080] | $0.61 | $1.21 [A] | $4.01 |

Worked example: gemini-3.5-flash-lite lean = (0.96 x 0.30) + (0.35 x 2.50) = 0.288 + 0.875 = $1.163 per 1,000. Pilot only: 2.1 x 1.163 = $2.44. The paid cost is small; the obstacle is that a billing account is needed, not the price.

**Free-tier days of testing.** Formula: days = ceil(N / (L x u)), L = free requests per day for the project, u = usable share (0.8) [A:ASM-25]. L is not published on the rate-limit page; it is shown in AI Studio [V:S-077] ([T] in SPK-01 setup).

| L (requests/day/project) [A] | Days for 6,550 calls | Daily load dev+pilot (200 + 150 = 350) | Fits? |
|---|---|---|---|
| 250 | ceil(6,550 / 200) = 33 | 350 > 250 | No: pilot needs paid tier, or caching of repeated text |
| 1,000 | ceil(6,550 / 800) = 9 | 350 < 1,000 | Yes |

All five developers share one project's limit unless each uses a separate project [V:S-077]. A tier-C source suggests free Flash limits of about 5-15 requests/minute [U]; at 5/min the 270 SPK-01 calls take about 54 minutes.

**Prompt chain (one page).**

| Step | Who | Input | Output | Rules |
|---|---|---|---|---|
| 0 Normalise | Dart | raw text | cleaned text | Convert Arabic-Indic digits, strip diacritics, trim; no meaning change. |
| 1 Parse | LLM | cleaned text + schema | JSON `items[]` | Fields: `name_raw`, `name_en`, `name_ar`, `qty`, `unit`, `grams`, `grams_basis` (`stated`/`typical`/`unknown`), `prep`, `is_packaged`, `barcode_hint`, `confidence` 0-1, `flags[]`. Temperature low [A]; max output tokens capped; schema-constrained output. |
| 2 Validate | Dart | JSON | accepted or retry | Schema check; one retry; then manual-entry fallback. Reject non-food and instruction-like text. |
| 3 Resolve | Dart | items | per-item source | Local dish table -> USDA subset -> OFF by barcode -> `AI_ESTIMATE` (second LLM call returns per-100 g values with a range; always flagged). |
| 4 Compute | Dart | grams x per-100 g | totals | Unit tests; range sanity checks (kcal per 100 g, grams per item). **No LLM restates totals.** |
| 5 Restrictions | Dart | items + user tags | warnings | Allergen and diet checks use tags from data, not LLM opinion. Alternatives drawn from the local table. |

Safety rules in the system prompt and UI: no allergen guarantee ("may contain; check the label"); no diagnosis or treatment advice (for example insulin dosing, extreme diets) - return `refusal:true` with a reason code and a pointer to a professional; treat user text as data, never as instructions; show the source and confidence beside every number.

### TD-03 Sync and local storage

| ID | Option | Facts |
|---|---|---|
| OPT-30 | Firestore offline persistence + snapshot listeners | Default on Android; 100 MB cache; local events while offline; writes queued [V:S-071]; transactions fail offline [V:S-072] |
| OPT-31 | Local DB (drift/SQLite/Hive family) + custom sync to Firestore | Full control; the team writes queue, conflict and retry logic [A] |
| OPT-32 | Third-party sync package | Exist on pub.dev; maturity [U] [V:S-086] |

**Criteria and weights** [A:ASM-30]: W1 meets the brief (Firestore sync) 25; W2 effort and risk for 5 students 20; W3 offline correctness 15; W4 evidence of maturity 15; W5 testability 10; W6 cost and quota 10; W7 control of data location 5.

| Option | W1 | W2 | W3 | W4 | W5 | W6 | W7 | Score /100 |
|---|---|---|---|---|---|---|---|---|
| OPT-30 Firestore offline | 5 | 5 | 3 | 4 | 3 | 4 | 2 | **82.0** |
| OPT-31 Local DB + custom sync | 2 | 1 | 5 | 3 | 5 | 4 | 2 | 58.0 |
| OPT-32 Third-party package | 3 | 3 | 2 | 1 | 2 | 4 | 2 | 50.0 |

W6 for OPT-30: Spark free quota is 1 GiB stored, 50,000 reads, 20,000 writes and 20,000 deletes per day [V:S-073]. Estimated pilot load about 2,000 reads/day [A:ASM-37], far below.

**Decision `TD-03`.** Winner OPT-30. Runner-up OPT-31, used only on escalation. OPT-32 rejected unless OPEN-46 shows a maintained package.

Coding rules for OPT-30: write and forget (do not `await` an offline write in a UI handler); update the UI from snapshot listeners with `hasPendingWrites`/`fromCache` metadata [A]; never use transactions for the meal log; use per-document last-write-wins meal entries with client-generated IDs [A]; set cache size explicitly and test eviction.

**Kill criterion `KC-03` (escalation trigger).** Move to OPT-31 if SPK-04 shows any of: one acknowledged-then-lost write in 20 runs of any scenario; UI blocked longer than 300 ms by a write path after the coding rules are followed; cross-user contamination on account switch; cache eviction removing un-synced writes; reconnect sync over 30 s for 50 queued writes [A].

### TD-04 Client, networking and security

**State management** (scores [A:ASM-30], no external sources; the team may already prefer one).

| Option | Testability 30 | Boilerplate 25 | Fit with stream/snapshot data 25 | Ecosystem 20 [U] | Score |
|---|---|---|---|---|---|
| Riverpod | 5 | 3 | 5 | 4 | **86.0** |
| Bloc | 5 | 2 | 4 | 4 | 76.0 |
| Provider | 3 | 5 | 3 | 3 | 70.0 |

Original proposal: winner Riverpod; runner-up Bloc. **Update 2026-10-10:** the project author asked for Bloc, and `06-DECISIONS.md` ADR-06 now records Bloc (`flutter_bloc`). The scores above are unchanged [A:ASM-30] and Riverpod is the runner-up. Reverse (`KC-04`) if two or more team members cannot build and test a feature with Bloc in one week of onboarding.

| Topic | Decision | Alternatives rejected | Validation |
|---|---|---|---|
| Dio interceptor chain | order: User-Agent -> auth/App Check token -> retry with backoff and jitter -> cache (read-through, per source terms) -> redacted logging -> error mapping | `http` package (brief mandates Dio) | Unit tests with a mock adapter; SPK-06 |
| Secrets | none in APK; AI through Firebase AI Logic + App Check; no third-party key needed (USDA subset bundled, OFF keyless) | key in `--dart-define` (still extractable); key in assets | SPK-05 |
| Secure storage | Android Keystore-backed secure storage for tokens only [A] (ADR-14 changes what is stored: the consent record and the restriction-tag copy, not tokens) | SharedPreferences for tokens | Widget/unit tests with fakes |
| Permissions | request at point of use (camera for barcode; notifications if used); explain, handle denial | request all at launch | Widget tests for denied path |
| Firestore rules | owner-only read/write on `users/{uid}/...`; schema checks on writes; no public collections | open test-mode rules | Emulator-based rules tests in CI [A] |
| Tests | unit (compute, units, parsing validators), widget (log screen, source badges), integration (offline flow) | manual only | CI on every pull request |
| CI | GitHub Actions: analyse, format, test, build debug APK [A] | none | Green badge on `main` |

### TD-05 Legal and data-terms constraints

**Facts used.** Egypt's PDPL Executive Regulations were issued on 1 Nov 2025 (MCIT decision 81/2025); the compliance deadline is about 1-2 Nov 2026 (sources differ) [V:S-084]. Health data is sensitive and needs explicit consent. Transfers abroad (including storing on foreign servers) need a PDPC licence or permit; no adequacy list was published as of 10 Sept 2026 (tier B) [V:S-084]. Whether the licensing regime reaches a student prototype is [U] (OPEN-40). Existing items `EVD-17` to `EVD-19` were not readable; the rows below add to them.

| Flow | Data leaving device | Goes to | Legal basis / control [A] | Open point |
|---|---|---|---|---|
| F1 Sync | meal log, restriction tags, account ID | Firestore (Google), region [U] | Explicit consent; owner-only rules; minimise (tags not diagnoses); pseudonymous ID | Cross-border licence (RSK-01) |
| F2 AI parse | meal text; no user ID; no name | Gemini via Firebase AI Logic | Consent; **paid tier for real users** (free tier lets Google use inputs [V:S-075]); synthetic text on free tier | Processing location [U] (OPEN-39) |
| F3 Barcode | barcode, IP, User-Agent | Open Food Facts | No personal data intended; app contact in User-Agent | None |
| F4 USDA | none if subset bundled | - | Bundled data, CC0 | None |
| F5 Crash/analytics | device model, crash trace | Firebase [A] | Off by default or consent | Decide in GT-04 |
| F6 Survey data | answers | team storage [U] | `EVD-17` to `EVD-19` plus consent text | Link to RSK-10 |

| Licence or terms | Obligation | Plan |
|---|---|---|
| ODbL (OFF database) | attribution; share-alike for derived databases [V:S-070] | Do not merge OFF into the bundled DB; show "Open Food Facts" attribution on barcode results; read OFF's legal guide [A] (OPEN-40) |
| CC BY-SA (OFF images) | attribution, share-alike | Do not store OFF images; link only |
| USDA FDC (CC0) | none required; citation recommended [V:S-082] | Cite in notices |
| Gemini terms | free tier: inputs used to improve products [V:S-075] | Paid tier before real users |
| Edamam, Spoonacular | storage limits [V:S-063, S-085] | Not used |

`THIRD_PARTY_NOTICES` plan: file at repo root and in-app "About" screen listing each dataset (name, licence, URL, retrieval date, what is stored); updated with every data import; checked in CI for presence [A].

**Decision `TD-05`: Conditional Go.** Pilot only with consenting adults and either synthetic data or the paid AI tier. **Kill criterion `KC-05`:** if legal advice (university counsel or a lawyer) says the prototype needs a PDPC licence before any real user data flows, run the pilot on synthetic data only and keep the legal text for the report.

### TD-06 Cost and schedule

**Zero-budget table.**

| Item | Option | Limit | Risk |
|---|---|---|---|
| Backend | Firebase Spark | 1 GiB, 50k reads, 20k writes, 20k deletes per day [V:S-073] | Listener reads grow; RSK-21 |
| Cloud Storage / Functions | avoid; Functions on Spark [U] | tier C says storage left Spark in 2026 [V:S-092] [U] | Plan B proxy blocked (OPEN-49) |
| AI | Gemini free tier | limits in AI Studio only [V:S-077] | RSK-02, RSK-05 |
| Food data | USDA bundled; OFF live | 15/10 req/min [V:S-070] | Rate limit on barcode spikes |
| CI and repo | GitHub free [U] | minutes [U] | Slow builds |
| Distribution | debug/release APK to testers | no store fee | Sideloading friction |
| Dietitian review | volunteer [A] | availability | RSK-09 |

**Effort model** (person-days, [A:ASM-29]).

| Work item | Days | Work item | Days |
|---|---|---|---|
| W1 Setup, CI | 4 | W8 Security (Keystore, permissions, App Check) | 5 |
| W2 Auth, Firestore model, rules + tests | 8 | W9 Tests (unit, widget, integration) | 10 |
| W3 Core UI (GridView/Stack) | 10 | W10 Spikes SPK-01 to SPK-06 | 12 |
| W4 AI pipeline + unit tests | 12 | W11 Recipes and healthier alternatives | 12 |
| W5 USDA subset bundle | 3 | W12 Legal, consent, notices | 4 |
| W6 Egyptian dish table | 0.25 per dish | W13 Report and demo | 10 |
| W7 Dio and interceptors | 4 | Total without W6 | 94 |

Capacity: 5 people x weeks x 2 productive days per person per week [A:ASM-28]. `OPEN-26` (end date) is unknown, so two scenarios.

| Scenario | Weeks | Capacity (pd) | Must | Should | Could | Fit |
|---|---|---|---|---|---|---|
| S short | 8 | 80 | W1-W5, W7, W8, W12, reduced W9 (8), reduced W10 (8), reduced W13 (8), 30 dishes (7.5) = 81.5 (50 + 24 + 7.5; corrected on 2026-10-11, was "about 79") | none | none | Over capacity by 1.5 pd: does not fit as listed. 20 dishes (5.0) would give 79.0, which is tight with no slack: Conditional |
| L long | 14 | 140 | all of S at full size + 100 dishes (25) = about 119 | W11 recipes (12, included above) | 150 dishes (+12.5), polish | Fits with about 21 pd slack |

Items cut first (map to `SCP-IN-` IDs when `DISCOVERY.md` is available; IDs not readable now): (1) healthier-alternative generator, (2) recipe suggestions, (3) charts and analytics screens, (4) any voice or photo input, (5) dish table beyond 30. **Kill criterion `KC-06`:** if by GT-03 less than 60% of W1-W5 is done, cut to scenario S scope and drop recipes.

## 6 Experiments (designed here; the team runs them; all result cells are [T])

Owner roles: Data lead, AI lead, Mobile lead, QA/security lead, Product/legal lead. Thresholds are proposals [A:ASM-30].

### SPK-01 LLM parsing

| Field | Content |
|---|---|
| Purpose | Choose the parse model; test Egyptian dialect (TD-02, KC-02, `HYP-03`) |
| Setup | 3 candidates: `gemini-3.5-flash-lite`, `gemini-3.8-flash`, one of `claude-haiku-5-5` or `gpt-5.6-luna` (check the vendor's model page the day of the run). Read the free-tier request limit in AI Studio and record it. |
| Inputs | 30 meal descriptions: 10 Egyptian dialect, 10 Modern Standard Arabic, 10 English. Two team members label gold items independently; report agreement. |
| Procedure | Same prompt and schema for all models; 3 runs each; fixed low temperature; log raw output, tokens, latency. |
| Metrics | Item recall and precision; quantity and unit accuracy; JSON validity; latency p50/p90; tokens; cost per 1,000. |
| Pass [A] | Recall and precision >= 0.90 overall and >= 0.85 on dialect; quantity/unit >= 0.80; JSON valid >= 0.98; parse latency p90 <= 4 s; cost <= $5 per 1,000. |
| Owner | AI lead |

| Model | Set | Recall | Precision | Qty/unit | JSON valid | p50 s | p90 s | Tokens in/out | $/1,000 | Pass |
|---|---|---|---|---|---|---|---|---|---|---|
| M1 3.5-flash-lite | EG / MSA / EN | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| M2 3.8-flash | EG / MSA / EN | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| M3 Plan B model | EG / MSA / EN | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### SPK-02 Data coverage bake-off

| Field | Content |
|---|---|
| Purpose | Decide the order and content of the resolve layers (TD-01, KC-01) |
| Inputs | 40 names: 20 dishes, 20 ingredients, each with Arabic and English form and a hand-picked correct target |
| Sources | Local dish table (first 60 dishes), bundled USDA subset, OFF name search, optionally DietlyAPI and FatSecret Basic |
| Procedure | Query each source with the same names; judge top 1 and top 3 against the target; compare kcal/100 g to the reference |
| Pass [A] | Local layers: dish hit@3 >= 0.70, ingredient hit@3 >= 0.90; kcal/100 g within +-15% for >= 80% of hits |
| Owner | Data lead |

| Source | Dish hit@1 | Dish hit@3 | Ingr. hit@1 | Ingr. hit@3 | kcal within +-15% | Latency | Notes |
|---|---|---|---|---|---|---|---|
| Local dish table | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| USDA subset | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| OFF name search | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| DietlyAPI (optional) | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### SPK-03 Accuracy against reference values

| Field | Content |
|---|---|
| Purpose | Test `HYP-03` (grounded pipeline beats direct LLM) and `HYP-02` (MAPE <= 20%) |
| Depends on | `OPEN-21` (source of reference values). Cannot run until it is closed. |
| Inputs | The 30 reference meals named in the brief, each with reference energy and macros and a stated portion |
| Procedure | Arm A: direct LLM estimate. Arm B: grounded pipeline (TD-02 chain). 3 runs; bootstrap 95% intervals |
| Metrics | Energy MAPE per meal; MAE for protein, carbohydrate, fat (g); share within +-20% |
| Pass [A] | Arm B MAPE <= 20% and at least 5 points better than Arm A |
| Owner | AI lead + Data lead |

| Arm | Energy MAPE | 95% CI | MAE protein | MAE carb | MAE fat | Within +-20% | Pass |
|---|---|---|---|---|---|---|---|
| A direct LLM | [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| B grounded | [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### SPK-04 Firestore offline

| Field | Content |
|---|---|
| Purpose | Settle CL-12 and the KC-03 trigger |
| Setup | One mid-range and one low-RAM Android device; Firestore with default persistence; listeners with metadata changes; follow the TD-03 coding rules, plus one run that deliberately `await`s an offline write |
| Procedure | Run each scenario 20 times; record frame drops, data loss, duplicates, order, time to sync |
| Pass [A] | 0 lost writes; UI never blocked > 300 ms when rules are followed; 50 queued writes sync <= 30 s after reconnect; cold start offline shows last 7 days <= 1 s |
| Owner | Mobile lead |

| Scenario | Result | What froze or failed and why | Pass |
|---|---|---|---|
| Add meal offline | [T] | [T] | [T] |
| Edit meal offline | [T] | [T] | [T] |
| Delete meal offline | [T] | [T] | [T] |
| Restart app offline | [T] | [T] | [T] |
| Reconnect with 50 queued writes | [T] | [T] | [T] |
| Account switch on one device | [T] | [T] | [T] |
| Low-RAM device | [T] | [T] | [T] |
| Cache size setting (eviction with unsynced writes) | [T] | [T] | [T] |
| Deliberate `await` of offline write | [T] | [T] | [T] |

### SPK-05 Key protection

| Check | Method | Pass | Result |
|---|---|---|---|
| No secret in release APK | decompile, grep for key patterns and URLs | zero secrets | [T] |
| AI call without App Check token | replay request with curl | rejected | [T] |
| AI call from a rooted/emulated device | run on emulator | rejected or limited as designed | [T] |
| Firestore rules | emulator tests: other user, no auth, bad schema | all denied | [T] |
| Dio logs | inspect logs for tokens and meal text | redacted | [T] |
| Flutter SDK and limited-use tokens | read official docs and run a call | works (closes OPEN-39) | [T] |

Owner: QA/security lead.

### SPK-06 Latency and size

| Metric | Method | Target | Result |
|---|---|---|---|
| End-to-end analysis time, p50/p90 | 30 meals, mid-range device, Wi-Fi and 4G | p90 within `OBJ-01` (8 s) | [T] |
| Parse step p90 | from SPK-01 | <= 4 s [A] | [T] |
| Release APK size | `flutter build apk --release` | measure (candidate < 50 MB) | [T] |
| Memory idle / during analysis | profiler | measure (candidate < 200 MB) | [T] |
| Bundled DB size | file size | measure | [T] |

Owner: Mobile lead.

## 7 Go/No-Go and gates

| Dimension | Verdict | Evidence | Conditions | Fallback (Plan B) |
|---|---|---|---|---|
| Data sources | Conditional Go | TD-01; S-082, S-070 | Dish table reaches 30+ dishes with a reviewer; SPK-02 passes | `AI_ESTIMATE` with ranges and lower `OBJ-03` |
| AI | Conditional Go | TD-02; S-075, S-076, S-077 | SPK-01 passes; real-user text only on paid tier | Claude Haiku 5.5 or GPT-5.6 Luna behind a proxy (needs billing; OPEN-49) |
| Arabic and dialect | Conditional Go | no verified benchmark for candidates; S-061 | SPK-01 dialect set passes | Add a normalisation step; few-shot Egyptian examples; fall back to MSA/English prompts; manual entry |
| Sync | Conditional Go | TD-03; S-071, S-072 | SPK-04 passes | Local DB + custom sync (OPT-31) |
| Client and security | Go | TD-04 | SPK-05 passes before any release build is shared | Proxy with Secret Manager [U] |
| Legal | Conditional Go | TD-05; S-084 | GT-04 policy approved | Synthetic-data pilot; demo with team accounts only |
| Cost | Go for development; Conditional for pilot | TD-02 cost model; S-073 | Free tier or a small paid budget with alerts | Cache repeated text; reduce pilot size |
| Schedule | Conditional Go | TD-06 | `OPEN-26` answered; scenario chosen | Scenario S scope |

**Overall decision: Conditional Go.**

| Gate | Must be proven | Spike or action | By [A] |
|---|---|---|---|
| GT-01 | Offline sync safe and UI never blocked; Dio chain works | SPK-04 | 2026-10-22 |
| GT-01b | No secret in APK; App Check enforced | SPK-05 | 2026-10-22 |
| GT-02 | Parse model chosen; free-tier limit recorded; Jais 2 hosted access rechecked | SPK-01 | 2026-10-29 |
| GT-03 | Local layers resolve enough names; dish table started with reviewer | SPK-02, `OPEN-21` | 2026-10-29 (SPK-03 by 2026-11-05) |
| GT-04 | Pilot data policy and consent text approved; legal read done | legal review (OPEN-40) | 2026-10-30 |
| GT-05 | End-to-end latency and size measured | SPK-06 | 2026-11-12 |

| Kill criterion | Trigger | Consequence |
|---|---|---|
| KC-01 | Local layers resolve < 70% of dishes after 60 entered, or no reviewer | Switch dishes to flagged LLM estimates; lower `OBJ-03` |
| KC-02 | Parse model fails dialect threshold; free tier gone; shutdown < 90 days; App Check fails | Use Plan B model or manual entry |
| KC-03 | SPK-04 loss or freeze triggers | Custom sync engine (OPT-31) |
| KC-04 | Bloc onboarding fails in one week (ADR-06) | Use Cubit only, or switch to Riverpod |
| KC-05 | Legal advice requires PDPC licence for any real data | Synthetic-data pilot only |
| KC-06 | < 60% of W1-W5 done by GT-03 | Scenario S scope; drop recipes |

| Critical dependency | Plan B | Cost of Plan B |
|---|---|---|
| AI access | Second vendor behind a proxy; or manual entry with USDA search only | Billing account; server work (W8 +3 pd [A]) |
| Reference data | Dietitian-reviewed table plus INFOODS cross-check if reuse allowed; else flagged LLM ranges | 0.25 pd per dish; legal read of reuse terms |
| Sync | Local DB + custom sync | About 10-15 pd [A] |

## 8 Risk register (sorted by score; P and I on a 1-5 scale)

| ID | Cat | Cause -> event -> consequence | P | I | Score | Early warning | Mitigation | Contingency | Owner | Links | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| RSK-01 | legal | Egypt PDPL regulations apply from about 1-2 Nov 2026 -> meal and restriction data sent abroad (Firebase, Gemini) -> unlicensed transfer of sensitive data, penalties, forced stop | 4 | 5 | 20 | Counsel says licence needed | Pilot policy at GT-04; minimise data; consent; synthetic data | Synthetic-data pilot | Product/legal lead | OPEN-40, ASM-32 | open |
| RSK-02 | legal | Free-tier terms let Google use inputs -> real users' meal text reused -> privacy breach | 4 | 4 | 16 | Any real-user text on free key | Paid tier or synthetic text; send no IDs | Delete test data; stop pilot | AI lead | S-075, ASM-32 | open |
| RSK-03 | data | No verified Egyptian reference data -> wrong or missing values -> inaccurate calories, failed `HYP-02` | 4 | 4 | 16 | SPK-02 hit@3 < 0.70 | Team table from recipes + USDA; cross-check INFOODS | Flagged LLM ranges | Data lead | OPEN-21, OPEN-44, SPK-02 | open |
| RSK-04 | AI | LLM misreads Egyptian dishes or dialect -> wrong items or portions -> bad logs | 4 | 4 | 16 | SPK-01 dialect recall < 0.85 | Aliases table; few-shot; user edits before saving | Plan B model; manual entry | AI lead | SPK-01, `HYP-03` | open |
| RSK-05 | AI/cost | Free quota cut, price rise or model retired -> parse stops -> core flow fails | 4 | 4 | 16 | Deprecation page change; quota errors | Model alias in remote config [A]; weekly page check; 2nd vendor adapter | Switch model; manual entry | AI lead | S-076, S-077, OPEN-38 | open |
| RSK-06 | schedule | End date unknown, scope above capacity -> late or partial delivery | 4 | 4 | 16 | < 60% of W1-W5 at GT-03 | Scenario S/L; cut list | Drop recipes first | Product/legal lead | OPEN-26, ASM-28 | open |
| RSK-07 | AI | LLM restates or invents numbers -> hallucinated totals shown | 3 | 5 | 15 | Totals differ from code | Code computes; schema forbids totals; unit tests; range checks | Hide AI-only values | AI lead | CL-14, SPK-03 | open |
| RSK-08 | product | App suggests food unsafe for an allergy or condition -> harm | 3 | 5 | 15 | Alternative violates a tag in tests | Tag-based checks; no guarantees; disclaimers; refusal rules | Disable alternatives feature | Product/legal lead | ASM-32 | open |
| RSK-09 | team | No dietitian or reviewer -> unverified dish table | 3 | 4 | 12 | No reviewer by GT-03 | Ask university/clinic; publish method and error | Mark entries "unreviewed" | Data lead | OPEN-21, KC-01 | open |
| RSK-10 | legal | Survey or pilot lacks consent or touches minors -> compliance breach | 3 | 4 | 12 | Consent text not approved | Consent and adult-only screen; no identifiers | Delete data | Product/legal lead | EVD-17..19, ASM-32 | open |
| RSK-11 | security | API key in APK or repo -> key leaked -> quota theft | 3 | 4 | 12 | Secret found by SPK-05 | No keys in client; App Check; secret scanning in CI | Rotate keys | QA/security lead | SPK-05 | open |
| RSK-12 | sync | Code awaits offline writes -> UI freezes | 3 | 4 | 12 | Jank in SPK-04 | Write-and-forget rule; code review | Isolate writes in a queue | Mobile lead | CL-12, SPK-04 | open |
| RSK-13 | team | One member overloaded or absent -> bottleneck | 4 | 3 | 12 | Late pull requests | Pair on critical items; WIP limits | Reassign | Product/legal lead | ASM-28 | open |
| RSK-14 | product | Scope creep -> missed core | 4 | 3 | 12 | Backlog grows | Must/Should/Could; change log | Cut list | Product/legal lead | OPEN-26 | open |
| RSK-15 | product | Unit and portion errors (cup, spoon, local units) -> wrong grams | 4 | 3 | 12 | SPK-01 qty accuracy < 0.80 | Unit table with local units; ask when `grams_basis` unknown | Default portions flagged | AI lead | SPK-01 | open |
| RSK-16 | security | Weak Firestore rules -> data exposure | 2 | 5 | 10 | Rules tests fail | Owner-only rules; emulator tests in CI | Lock database | QA/security lead | SPK-05 | open |
| RSK-17 | sync | Offline edge cases (lost increments, listener bugs) | 3 | 3 | 9 | SPK-04 anomalies | No increments; per-entry documents; pin SDK versions | OPT-31 | Mobile lead | S-074, KC-03 | open |
| RSK-18 | legal | Storing data beyond vendor terms | 3 | 3 | 9 | New dependency added | Notices review in PR checklist; avoid Edamam/Spoonacular | Remove the source | Product/legal lead | S-063, S-085 | open |
| RSK-19 | device | Low-RAM devices jank or crash (claim [U]) | 3 | 3 | 9 | SPK-06 memory | Small bundled DB; limit cache | Reduce cache; lite mode | Mobile lead | SPK-04, SPK-06 | open |
| RSK-20 | AI | Silent model change or no dialect evidence -> behaviour shifts | 3 | 3 | 9 | SPK-01 regression | Pin model version; regression set | Roll back | AI lead | SPK-01 | open |
| RSK-21 | cost | Listeners burn Spark read quota | 3 | 3 | 9 | Console usage > 50% | Limit queries; paginate | Reduce pilot size | Mobile lead | S-073, ASM-37 | open |
| RSK-22 | legal | OFF data merged into bundled DB -> ODbL share-alike | 2 | 3 | 6 | OFF rows in DB | Live fetch only; attribution | Release derived data under ODbL | Data lead | S-070, ASM-36 | open |
| RSK-23 | security | App Check attestation fails on some devices or emulators | 3 | 2 | 6 | SPK-05 | Debug provider for tests only | Rate-limit fallback | QA/security lead | OPEN-39 | open |
| RSK-24 | schedule | SDK or API breaking changes (FlutterFire, firebase AI package) | 3 | 2 | 6 | CI failures | Pin versions; upgrade windows | Rollback | Mobile lead | OPEN-39 | open |
| RSK-25 | cost | Paid tier enabled without a hard cap -> unexpected bill | 2 | 3 | 6 | Budget alert | Budget alerts; Gemini spend tier caps [V:S-077] | Disable billing | Product/legal lead | S-077 | open |

5x5 map (rows probability, columns impact):

| P \ I | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| 5 | - | - | - | - | - |
| 4 | - | - | 13, 14, 15 | 02, 03, 04, 05, 06 | 01 |
| 3 | - | 23, 24 | 17, 18, 19, 20, 21 | 09, 10, 11, 12 | 07, 08 |
| 2 | - | - | 22, 25 | - | 16 |
| 1 | - | - | - | - | - |

(IDs shown without the `RSK-` prefix.)

## 9 Methods justification (for the grader)

| Decision | Alternatives rejected | Evidence | Why chosen | Trade-offs | Validation | Related |
|---|---|---|---|---|---|---|
| TD-01 local-first data: dish table + USDA subset + OFF barcode | Edamam, API Ninjas, FatSecret, Spoonacular, DietlyAPI, LLM only | S-063, S-067, S-068, S-082, S-070, S-085, S-069 | Works offline; no quota; per-item source; storing allowed | Dish table costs labour; Egyptian accuracy depends on a reviewer | SPK-02, SPK-03 | `OBJ-03`, `HYP-02`, `HYP-03` |
| TD-02 LLM parses, code computes; Gemini 3.5 Flash-Lite via Firebase AI Logic | Claude Haiku 5.5, GPT-5.6 Luna, Mistral, Jais 2, Gemma 4 | S-075, S-076, S-077, S-078, S-079, S-080, S-060, S-056, S-089 | Only option with a free tier reachable without a key in the app | Free tier uses inputs for product improvement; limits unpublished; dialect unproven | SPK-01, SPK-03, SPK-06 | `OBJ-01`, `HYP-03` |
| TD-03 Firestore offline persistence | Local DB + custom sync; third-party sync packages | S-071, S-072, S-073, S-074, S-086 | Meets the brief with least code | Edge cases; transactions unusable offline | SPK-04 | `OBJ-01` |
| TD-04 Bloc (ADR-06; Riverpod was proposed first), Dio chain, App Check, rules tests | Riverpod, Provider; key in APK; `http` | S-070, S-071 | Testable; brief-compliant; no secrets shipped | Learning curve | SPK-05, SPK-06; unit and widget tests | brief |
| TD-05 Restricted pilot, notices plan | Open public pilot | S-084, S-075, S-070 | Avoids unlicensed transfer and share-alike | Smaller sample | GT-04 | `EVD-17` to `EVD-19` |
| TD-06 Scenario S/L with cut list | Fixed scope | [A:ASM-28], [A:ASM-29] | End date unknown | Estimates are guesses | GT-03 review | `OPEN-26` |

**What would make us change our mind.** We would switch from Firestore-only to a custom sync engine if SPK-04 shows a lost write or an unavoidable UI block. We would drop the Gemini free tier if it disappears, if its limit cannot cover the pilot, or if SPK-01 shows another model clearly better on Egyptian dialect. We would drop the local dish table for flagged LLM estimates if no reviewer or too little time is available. We would stop real-user data flows entirely if legal advice says the prototype needs a PDPC licence. We would revisit a rejected data API if it publishes a permanent free tier that allows storage in a user's log.

## 10 Proposed target changes (for the team; nothing existing was changed)

| Item | Existing | Earlier-document proposal | Evidence | Proposed for team decision |
|---|---|---|---|---|
| Analysis time | `OBJ-01`: 8 s p90 | < 4 s | None yet (SPK-06); only the parse step is network-bound | Keep 8 s p90; add sub-budget parse p90 <= 4 s [A] |
| Accuracy | `HYP-02`: MAPE <= 20% | +-20% for 80% of dishes | Energy MAPE 13.4% mean per 100 g on single foods [V:S-056]; fine-tuned model energy MAE 171-191 kcal vs 652 kcal baseline on 24 h recalls [V:S-090]; meals and portions are harder | Keep `HYP-02`; add "80% of meals within +-25%" only after the SPK-03 baseline |
| Dish count | `OBJ-03`: 100-200 dishes | 10 dishes for MVP | Effort 0.25 pd per dish [A:ASM-29] | Keep `OBJ-03` as Should/Could; floor of 30 dishes in scenario S |
| Test set | 30 reference meals | 50 dishes | Needs `OPEN-21` | Keep 30 meals; SPK-02 uses 40 names |
| App size | none | < 50 MB | None | Measure in SPK-06 first |
| RAM | none | < 200 MB | None | Measure in SPK-06 first |

## 11 Integration into the registers (done 2026-10-09)

The paste-ready rows from the first version of this study were merged into the three registers. Nothing was deleted from the registers.

| Old (provisional) | New |
|---|---|
| `S-9xx` (901 to 937) | `S-056` to `S-092` (new = old - 845) |
| `ASM-9xx` (901 to 915) | `ASM-23` to `ASM-37` (new = old - 878) |
| `OPEN-9xx` (901 to 916) | `OPEN-36` to `OPEN-51` (new = old - 865) |

| Register | New rows |
|---|---|
| `A-ASSUMPTIONS.md` | `ASM-23` to `ASM-37` (this study), `ASM-38` (name decision) |
| `B-SOURCES.md` | `S-056` to `S-092`. Column "Note" says whether the page was opened or read as a search excerpt on 2026-10-08. URLs not recorded in the first version are marked [T] |
| `C-OPEN-ITEMS.md` | `OPEN-36` to `OPEN-51` (this study; `OPEN-51` is closed), `OPEN-52` to `OPEN-56` (naming follow-ups), `OPEN-57` (missing URLs) |
| `DISCOVERY.md` | File map, prefix list, AI NOTES and revision log updated |

## 12 Source notes

All sources used here are rows `S-056` to `S-092` in `B-SOURCES.md`. "Opened" means the page was fetched and read on 2026-10-08; "Excerpt" means it was read only through search-result text. Tier C sources are never used as [V].
