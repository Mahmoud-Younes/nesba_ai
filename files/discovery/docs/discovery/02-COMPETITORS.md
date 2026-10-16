---
id: DISC-01-02
title: Nesba Discovery, Section 2 (competitor analysis)
parent: DISC-01
status: draft
last_verified: 2026-10-07
owner: TBD
---

> **AI NOTES**
> - What this is: Section 2 of the discovery set. Competitor table, dimension matrices, profiles, gaps, positioning and the hands-on test plan. Hub: [DISCOVERY.md](DISCOVERY.md).
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U], [T] and every `?` cell as unknown, never as facts. No app was tested hands-on.
> - IDs defined here: CMP-01 to CMP-17, GAP-01 to GAP-08.
> - Never claim Nesba is the first Arabic AI food tracker. See §2.6.

# 2. Competitor analysis

Part of [DISCOVERY.md](DISCOVERY.md).

## 2.1 Selection and method

- Research dates: 2026-10-05, with a revision pass on 2026-10-07.
- Groups: Global (6 products), Arabic/regional (7 products), Research references (4 items, not competitors). Total 17 rows.
- Global apps are the four named in the brief plus two AI-first apps (Cal AI, MacroFactor).
- Regional apps were found by searching store listings for Arabic and Egyptian AI calorie tracking.
- Evidence tiers: A = vendor site, store listing, paper, law firm. B = independent news or listing aggregator. C = competitor or affiliate blog.
- A claim about a product taken only from tier C is not tagged [V]. It is shown as a conflict or tagged [U].
- Nothing here was tested hands-on. Every `Y` in the matrix means "stated by the vendor listing". Testing is §2.7 (OPEN-25).
- Aggregators (mwm.ai, App Pricing Lab, chrome-stats) reproduce store text or Play data, so they count as tier B.
- A first-pass reading of the App Store badge "Only for iPhone" as "no Android app" was wrong. The badge says the app is built for iPhone rather than iPad. It says nothing about Android (see CMP-08).

## 2.2 Competitor table

| ID | Name | Group | Platforms | Official URL | One-line summary |
|---|---|---|---|---|---|
| CMP-01 | MyFitnessPal | Global | iOS and Android [V:S-019] | https://www.myfitnesspal.com | Established tracker. Paid tiers unlock Meal Scan, Barcode Scan and Voice Log. Owns CMP-05 |
| CMP-02 | YAZIO | Global | iOS listing [V:S-029]; Android listing mirrored by a tier B aggregator [V:S-049] | https://www.yazio.com/en/about-us | Calorie tracker labelled "AI" in its listing, with a PRO subscription |
| CMP-03 | Cronometer | Global | iOS and Android [V:S-031] | https://cronometer.com | Verified-food database with vitamin and mineral detail |
| CMP-04 | Lose It! | Global | iOS listing [V:S-046]; Android listing data via a tier B aggregator [V:S-055] | https://loseit.com (linked from the store listing) | Long-running calorie counter with "Snap It" photo logging |
| CMP-05 | Cal AI | Global (AI-first) | iOS and Android [V:S-042] | https://calai.app | Photo-based calorie estimator that also takes a typed meal description. Acquired by MyFitnessPal, runs standalone [V:S-054] |
| CMP-06 | MacroFactor | Global (AI-first) | iOS and Android [V:S-041] | https://macrofactor.com/press-kit/ | Subscription-only macro tracker. Release notes mention AI custom-food creation |
| CMP-07 | Kam Calorie | Arabic/regional | iOS [V:S-021]; Android not shown on the site [U] | https://www.kamcalorie.app/en | Text, voice and photo logging for Egyptian, Gulf and Levantine dishes |
| CMP-08 | Sahnain | Arabic/regional | iPhone and Android [V:S-023,S-044] | https://apps.apple.com/eg/app/sahnain/id6777599299 | Egyptian-focused logging by text, voice and photo, Arabic or English |
| CMP-09 | Khatwa (Khtwa AI) | Arabic/regional | iOS listing [V:S-024]; Android [U] | https://apps.apple.com/app/id6760194825 | Bilingual food and workout app with AI food scan and AI coach |
| CMP-10 | Zadi | Arabic/regional | iOS [V:S-025]; Android [U] | https://mwm.ai/apps/zadi/6762077377 | AI food scanner with 200+ dishes claimed; English, Arabic, French |
| CMP-11 | Kilo | Arabic/regional | iOS (site title says "for iOS") [V:S-043]; Android not shown [U] | https://kiloappsa.com/ | Saudi-focused tracker with a 151,000+ food database, photo scan and verified restaurant items |
| CMP-12 | Logma | Arabic/regional | iOS listing [V:S-027]; Android [U] | https://apps.apple.com/us/app/logma/id6759130753 | Voice-first tracker for Middle Eastern food |
| CMP-13 | TalkFood | Arabic/regional | iOS listing [V:S-028]; Android [U] | https://apps.apple.com/app/id6757200636 | Voice food tracker, English and Arabic |
| CMP-14 | DietAI24 | Research reference | n/a | [U] | Research framework for nutrition estimation with multimodal LLMs. Seen only as a reference-list entry in S-014 |
| CMP-15 | Open-KNEAD | Research reference | n/a | https://arxiv.org/abs/2607.12911 | Preprint on knowledge-grounded, itemised nutrition estimation [V:S-014] |
| CMP-16 | NutriMLLM | Research reference | n/a | https://arxiv.org/pdf/2606.08948 | Preprint on micronutrient estimation by multimodal LLMs [V:S-012] |
| CMP-17 | NutriBench | Research reference | n/a | https://proceedings.iclr.cc/paper_files/paper/2025/hash/ef3a57e4f26b640e6f90d78cbb011feb-Abstract-Conference.html | Benchmark of 11,857 meal descriptions for LLM nutrition estimation [V:S-013] |

DietAI check: no consumer app named DietAI was found in the searches run on 2026-10-05. "DietAI" in the literature points to DietAI24, a research framework. Its original paper was not read, so none of its numbers are used [U] (OPEN-18).

## 2.3 Dimension matrix

Legend: `Y` stated by the vendor, `P` partial, `N` stated absent, `?` unknown, [T] team fills on test day. Price cells use text. Research references are not apps and are excluded.

### Matrix M1: Global

| Dimension | CMP-01 MyFitnessPal | CMP-02 YAZIO | CMP-03 Cronometer | CMP-04 Lose It! | CMP-05 Cal AI | CMP-06 MacroFactor |
|---|---|---|---|---|---|---|
| Pricing model | Freemium (Free, Premium, Premium+) | Freemium (PRO) | Freemium (Gold) | Freemium (free basic, Premium) | Free download, 3-day free trial; prices not shown on the site | Subscription only, 7-day trial |
| Price with currency and date | Premium USD 79.99/yr, Premium+ USD 99.99/yr (company release, 2026-02-24; region not stated). Premium monthly USD 19.99 (US App Store listing) | ? (several USD options, periods unlabelled) | Gold USD 10.99/mo or 59.99/yr (company page and listing) | ? (US listing shows USD 9.99–39.99 options with periods unlabelled; one named "year of premium features" is USD 39.99; tier C says 79.99) | ? (not shown on the official site) | USD 11.99/mo, 47.99/half-year, 71.99/yr (US customers; listing and press kit) |
| Arabic UI | ? | ? (20 languages per a tier B article; Arabic not confirmed) | ? | ? | ? | ? |
| Egyptian/Arabic dish coverage | ? | ? | ? | ? | ? | ? |
| Manual entry | ? | Y | Y | ? | P (own foods and recipes) | Y |
| Barcode | Y (paid) | ? | ? | Y | Y | ? |
| Free-text (NLP) entry | ? | ? | ? | ? | Y (describe your meal) | P |
| Voice entry | Y (paid) | ? | ? | ? | ? | ? |
| Photo AI | Y (paid) | ? | ? | Y (Snap It) | Y | ? |
| Shows source/confidence per item | ? | ? | ? | ? | ? | ? |
| Food database source and size | Over 20M foods (company) | ? | Over 1.1M verified foods (vendor) | Over 50M foods (vendor) | Uses the MFP database after integration | Open Food Facts credited in listing; size ? |
| Verified vs crowdsourced | ? | ? | Verified, curated (company) | ? | ? | ? |
| Micronutrients | ? | ? | Y | ? | ? | ? |
| Recipes / meal plans | Y (Premium+) | Y (PRO) | P (recipe importer, Gold) | ? | ? | ? |
| Dietary-restriction filters | ? | ? | ? | ? | ? | ? |
| Healthy alternatives | ? | ? | ? | ? | ? | ? |
| Offline mode | ? | ? | ? | ? | ? | ? |
| Cross-device sync | ? | ? | ? | ? | ? | ? |
| Data export | ? | ? | ? | ? | ? | ? |
| Privacy statement (where health data is stored) | ? | ? | ? | ? | ? | ? |
| Ads | ? | Y (free; PRO ad-free) | Y (free; Gold ad-free) | Y (Play label "Contains Ads", via aggregator) | ? | N (ad-free premium app) |
| Play Store rating and count (with date) | [T] | [T] | [T] | [T] | [T] | [T] |
| Last update date | [T] | [T] | [T] | [T] | [T] | [T] |

### Matrix M2: Arabic/regional

| Dimension | CMP-07 Kam | CMP-08 Sahnain | CMP-09 Khatwa | CMP-10 Zadi | CMP-11 Kilo | CMP-12 Logma | CMP-13 TalkFood |
|---|---|---|---|---|---|---|---|
| Pricing model | Freemium (10 AI logs/mo free; PRO) | Free in listing; in-app purchases not shown | Freemium (in-app purchases) | Freemium (PRO) | Free to start (site) | Freemium (in-app purchases) | Freemium (in-app purchases) |
| Price with currency and date | PRO USD 4.99/mo (site, 2026-10-05) | Free (listing) | Pro USD 6.99/mo, 49.99/yr (US listing) | ? | ? | ? | ? |
| Arabic UI | Y | Y | Y | Y | Y | ? | Y |
| Egyptian/Arabic dish coverage | Y (vendor claim) | Y (vendor claim) | ? | ? (Gulf and Levantine named) | ? (Saudi focus) | ? (Levantine named) | ? |
| Manual entry | ? | ? | Y (manual macros) | ? | ? | ? | ? |
| Barcode | ? | ? | ? | Y | Y | ? | ? |
| Free-text (NLP) entry | Y | Y | ? | ? | Y | ? | ? |
| Voice entry | Y | Y | ? | Y (PRO) | Y | Y | Y |
| Photo AI | Y | Y | Y | Y | Y | ? | ? |
| Shows source/confidence per item | ? | ? | ? | ? | P (restaurant items carry a "verified" badge) | P (citations and method in Settings; per item ?) | ? |
| Food database source and size | Not disclosed (500+ dishes claimed) | ? | Open Food Facts search (listing) | ? (200+ dishes claimed) | 151,000+ foods, 4,000+ brands (vendor) | ? | ? |
| Verified vs crowdsourced | ? | ? | ? | ? | P (restaurant items checked against menus, per vendor) | ? | ? |
| Micronutrients | ? | P (fiber, sugar, water) | ? | Y | ? | ? | ? |
| Recipes / meal plans | ? | ? | ? | ? | ? | ? | ? |
| Dietary-restriction filters | ? | ? | ? | ? | ? | ? | ? |
| Healthy alternatives | ? | ? | ? | ? | ? | ? | ? |
| Offline mode | ? (AI logging needs internet) | ? | ? | ? | ? | ? | ? |
| Cross-device sync | ? | P (backup and restore) | ? | ? | ? | ? | ? |
| Data export | ? | ? | ? | P (PDF reports) | ? | ? | ? |
| Privacy statement (where health data is stored) | ? (claims secure processing) | P (Play data-safety: no data shared with third parties; encrypted in transit; deletion on request; developer-declared) | ? | ? | ? | ? | P (store label says no data collected) |
| Ads | ? | ? | ? | ? | ? | ? | ? |
| Play Store rating and count (with date) | [T] | No rating shown; 500+ downloads (Play page, 2026-10-07) | [T] | [T] | [T] | [T] | [T] |
| Last update date | [T] | 2026-09-24 (Play listing) | [T] | [T] | [T] | [T] | [T] |

### Matrix evidence

| App | Cells supported | Source |
|---|---|---|
| CMP-01 | Tiers, annual prices, barcode, voice, photo, meal planner, database size | S-019 |
| CMP-01 | Monthly Premium price | S-047 |
| CMP-02 | Freemium PRO, manual diary, meal plans, ads | S-029 |
| CMP-03 | Gold price, database size, verified data, micronutrients, ads | S-030, S-031 |
| CMP-04 | Freemium, Snap It, barcode, database size, price options | S-046 |
| CMP-04 | Ads label on Google Play | S-055 |
| CMP-05 | Photo, barcode and typed-description input, own foods, trial, MFP database integration | S-042, S-020 |
| CMP-06 | Price, no free tier, AI custom food, Open Food Facts credit | S-032, S-041 |
| CMP-07 | Languages, dishes, input modes, price, free-tier limits | S-021 |
| CMP-08 | Languages, dishes, input modes, backup, nutrients; Play data | S-023, S-044 |
| CMP-09 | Languages, AI scan, Open Food Facts search, manual macros, price | S-024 |
| CMP-10 | Languages, barcode, voice, photo, nutrient reports, PDF | S-025 |
| CMP-11 | Arabic, barcode, voice and text, photo, database size, verified badge | S-043, S-026 |
| CMP-12 | Voice, citations in Settings | S-027 |
| CMP-13 | Languages, voice, privacy label | S-028 |

Any cell not listed here is `?` or [T].

## 2.4 Profiles

### CMP-01 MyFitnessPal

- Target user: general weight and nutrition tracking [A:ASM-10].
- Pricing: Premium USD 79.99/yr, Premium+ USD 99.99/yr; the company release (2026-02-24) does not state a region [V:S-019]. Premium monthly USD 19.99 in the US App Store listing [V:S-047]. Premium+ monthly USD 24.99 appears in tier C only (S-035) [U].
- Input methods: Meal Scan, Barcode Scan, Voice Log in Premium [V:S-019].
- AI use: photo-based Meal Scan [V:S-019].
- Data source: "over 20 million foods", per the company [V:S-019].
- Arabic support: not found in the sources read [U].
- Strengths: scale, meal planner in Premium+ [V:S-019].
- Weaknesses: core logging tools sit behind a paywall [V:S-019].
- Not checked: Arabic UI, Egyptian dishes, offline, export, privacy location, store rating.

### CMP-02 YAZIO

- Target user: weight loss and fasting [V:S-029].
- Pricing: PRO subscription. The listing shows several USD options with no period labels, so no single price is stated [U] (OPEN-11).
- Input methods: food diary [V:S-029]. Other methods not stated.
- AI use: labelled "AI calorie tracker"; scope not stated [V:S-029].
- Platforms: Android listing data mirrored by a tier B aggregator, which marks it as containing ads [V:S-049].
- Data source: seed claim of 4M+ items not verified [U].
- Arabic support: a localization-industry article says 20 languages, without a list [V:S-048]. Arabic not confirmed [U].
- Strengths: PRO adds meal plans and ad-free use [V:S-029].
- Weaknesses: not assessable without testing.
- Not checked: language list, database, export, privacy.

### CMP-03 Cronometer

- Target user: users who want nutrient detail [V:S-030].
- Pricing: Gold USD 10.99/mo or 59.99/yr [V:S-031,S-030]. Tier C sources give other annual prices; the company page prevails.
- Platforms: web, iOS and Android, per the company [V:S-031].
- Input methods: manual logging from a database [V:S-030].
- AI use: none stated [U].
- Data source: over 1.1 million verified foods, per the vendor [V:S-030,S-031].
- Arabic support: not found [U].
- Strengths: verified data, vitamins and minerals [V:S-030].
- Weaknesses: free tier shows ads [V:S-031].
- Ratings: the company page quotes store ratings with no count or date, so they are not used [V:S-031].
- Not checked: Egyptian dishes, AI features, export.

### CMP-04 Lose It!

- Target user: calorie counting [A:ASM-10].
- Pricing: the US listing shows Premium options between USD 9.99 and 39.99 plus lifetime options, with periods unlabelled. One option named "year of premium features" costs USD 39.99 [V:S-046]. One tier C page says USD 79.99 (S-033, S-034); no such option appears in the listing. The period stays [U] (OPEN-12).
- Input methods: "Snap It" photo logging [V:S-046].
- Platforms: a Google Play listing from the same developer exists; tier B aggregators show it with a "Contains Ads" label [V:S-055].
- Barcode scanner and a database of over 50 million foods, per the vendor [V:S-046].
- AI use and Arabic support: not found [U].
- Strengths and weaknesses: not assessable.
- Not checked: official membership page, language list.

### CMP-05 Cal AI

- Target user: users who want speed over accuracy, per MyFitnessPal's CEO in press coverage [V:S-020].
- Pricing: not shown on the official site, which offers a 3-day free trial [V:S-042].
- Input methods: photo, barcode, or a typed description; custom foods and recipes [V:S-042].
- AI use: calorie estimation from photos [V:S-020]. The site's FAQ says about 80% accurate (vendor) [V:S-042].
- Data source: integrated with the MyFitnessPal database after the deal closed in December [V:S-020].
- Platforms: App Store and Google Play links on the official site [V:S-042].
- Arabic support: not found [U].
- Ownership: MyFitnessPal announced the acquisition on 2 March 2026; the app stays standalone [V:S-054].
- Revenue: the company release quotes over USD 40M in sales in 12 months, while press coverage quotes over USD 30M annual revenue. Conflict, so none is used [U].
- Not checked: price, language list.

### CMP-06 MacroFactor

- Target user: users who track macros closely [A:ASM-10].
- Pricing: USD 11.99/mo, 47.99/half-year, 71.99/yr for US customers; 7-day trial; no free tier [V:S-032,S-041].
- Platforms: App Store or Google Play, per the press kit [V:S-041].
- Input methods: food log. Release notes mention AI custom-food creation and label scanning [V:S-032].
- AI use: photo and voice logging are claimed by one tier C page and denied by another (S-036, S-037). Conflict [U] (OPEN-14).
- Data source: listing credits Open Food Facts [V:S-032].
- Arabic support: not found [U].
- Strengths: no ads [V:S-032].
- Weaknesses: paid only [V:S-032].

### CMP-07 Kam Calorie

- Target user: Arabic speakers; Egyptian, Gulf and Levantine cuisine [V:S-021].
- Pricing: Free with 10 AI meal logs a month; PRO USD 4.99/mo with 300 AI meal logs (site, 2026-10-05) [V:S-021].
- Input methods: voice, photo, text, in Arabic or English [V:S-021].
- AI use: breaks a meal into items and portions; detects cooking methods [V:S-021].
- Data source: the site does not disclose its data source or AI provider; it says only that it uses "the latest AI models" [U] (OPEN-16).
- Arabic support: Arabic and English; Egyptian dishes include koshari (كشري), ful (فول), ta'ameya (طعمية), molokhia (ملوخية), hawawshi, fiteer [V:S-021].
- Strengths (vendor): portions in pieces, cups and spoons [V:S-021].
- Weaknesses: the site shows an App Store download and iOS requirements only; Android not shown [V:S-021]. The accuracy figure, speed figures and the phrase "clinical-grade accuracy" on the site have no stated method [U].
- Not checked: Android availability, privacy policy, real accuracy, offline use.

### CMP-08 Sahnain

- Target user: Egyptian and Middle Eastern meals [V:S-023].
- Pricing: listed as Free; in-app purchases not shown [V:S-023].
- Input methods: text, voice, photo, meal list, water; the Play listing adds nutrition-label analysis [V:S-023,S-044].
- AI use: estimates calories, protein, carbs, fats, fiber, sugar [V:S-023].
- Data source: not stated [U].
- Arabic support: Arabic and English; examples include koshary, foul, hawawshi, baladi bread [V:S-023].
- Platforms: App Store (the badge "Only for iPhone" means iPhone rather than iPad) and a Google Play listing, "Sahnain: Egyptian Calorie Log", with 500+ downloads and an update on 2026-09-24 [V:S-023,S-044]. Whether the two developer entries are the same person is inferred from the shared app name and feature text [A:ASM-16].
- Strengths: backup and restore; AI consent controls; states it is not a medical device [V:S-023].
- Weaknesses: very small user base so far; no usable rating on either store [V:S-023,S-044].
- Not checked: accuracy, data location.

### CMP-09 Khatwa

- Target user: bilingual users who want food and workout tracking [V:S-024].
- Pricing: Free with in-app purchases; Pro USD 6.99/mo or 49.99/yr in the US listing [V:S-024].
- Input methods: AI food scan, food search through Open Food Facts, manual macros [V:S-024].
- AI use: food scan and an AI coach that uses logged data [V:S-024].
- Data source: Open Food Facts [V:S-024].
- Arabic support: English and Arabic [V:S-024].
- Strengths: combined nutrition and training [V:S-024].
- Weaknesses: no text or voice entry stated [U]. Not enough ratings to display [V:S-024].
- Not checked: Egyptian dishes, Android.

### CMP-10 Zadi

- Target user: Arabic, Gulf, South Asian and international dishes [V:S-025].
- Pricing: PRO tier; price not captured [U].
- Input methods: photo, voice, barcode, menu scan [V:S-025].
- AI use: scanner, coach, adaptive targets [V:S-025].
- Data source: not stated [U].
- Arabic support: English, Arabic, French [V:S-025].
- Strengths: weekly vitamin and mineral dashboard; PDF reports [V:S-025].
- Weaknesses: Egyptian dishes not named; iOS app [V:S-025]. Listing is via an aggregator (tier B).
- Not checked: Android, accuracy, pricing.

### CMP-11 Kilo

- Target user: users in Saudi Arabia [V:S-043].
- Pricing: "Free to start"; paid options not captured [V:S-043].
- Input methods: search, barcode scanner, photo scan, voice and text logging; values from the photo scan stay editable [V:S-043].
- AI use: photo scan that reads a plate ingredient by ingredient, for home cooking [V:S-043].
- Data source: 151,000+ foods and 4,000+ brands, per the vendor. Restaurant items carry a "verified" badge and are checked against published menus or official nutrition tables, per the vendor [V:S-043].
- Arabic support: Arabic and English interface and search [V:S-043,S-026].
- Strengths: local depth for Saudi food and chains [V:S-043].
- Weaknesses: Egyptian relevance unknown [U]. The site title says "for iOS" and links only to the App Store [V:S-043].
- Not checked: Android, pricing, accuracy.

### CMP-12 Logma

- Target user: people who prefer speaking to typing; Middle Eastern food, with Lebanese dishes named [V:S-027].
- Pricing: Free with in-app purchases [V:S-027].
- Input methods: voice [V:S-027].
- AI use: AI estimates of nutritional values [V:S-027].
- Data source: not stated. Source citations and method are available in Settings [V:S-027].
- Arabic support: Arabic dishes named; UI language not stated [U].
- Strengths: claims citations in Settings [V:S-027].
- Weaknesses: Egyptian dishes not named [V:S-027].
- Not checked: how detailed the citations are.

### CMP-13 TalkFood

- Target user: voice-first loggers [V:S-028].
- Pricing: Free with in-app purchases [V:S-028].
- Input methods: voice in English or Arabic; Siri and Shortcuts [V:S-028].
- AI use: turns a spoken meal into calories and macros [V:S-028].
- Data source: not stated [U].
- Arabic support: 15 listed languages, including Arabic [V:S-028].
- Strengths: wide language list [V:S-028].
- Weaknesses: the store label says no data is collected; this sits oddly with cloud AI and is a vendor statement only [U].
- Not checked: Egyptian dish coverage, Android.

### Research references (CMP-14 to CMP-17)

- CMP-14 DietAI24: seen only as a citation in S-014. Original paper not read; no numbers used [U].
- CMP-15 Open-KNEAD (preprint, July 2026): image-based, itemised, grounded to a US food database [V:S-014].
- CMP-16 NutriMLLM (preprint, June 2026): shows weak micronutrient knowledge in general models [V:S-012].
- CMP-17 NutriBench (ICLR 2025): text-based benchmark with carbohydrate focus [V:S-013].

## 2.5 Gap analysis

| ID | Gap | Evidence | Opportunity | Feasibility (5 students) | Linked OBJ | Status |
|---|---|---|---|---|---|---|
| GAP-01 | Android availability of Arabic-first AI loggers | Sahnain has a Google Play listing [V:S-044]; Miran, a Saudi and Middle Eastern scanner built for Arabic and English users, is listed on Android by a tier B aggregator [V:S-050]; the Kam Calorie and Kilo sites show the App Store only [V:S-021,S-043]; others unknown [U] | None as a gap. "Android-first" stays a platform choice | H | OBJ-01 | Closed (at least one Egyptian-focused logger is on Google Play) |
| GAP-02 | Per-item source label | Logma mentions citations in Settings [V:S-027]. Kilo marks restaurant items as verified against menus [V:S-043]. Others unknown [U] | Source shown beside every item, including home dishes | M | OBJ-03 | Small; partly closed for restaurant items |
| GAP-03 | Published accuracy test on Egyptian meals | Vendors state accuracy with no method: Kam 95% [V:S-021]; Cal AI's FAQ says about 80% [V:S-042]. No independent test found in searches of 2026-10-05 and 2026-10-07; not exhaustive [U] | Public test on 30 reference meals | M | OBJ-02 | Open [A:ASM-14] |
| GAP-04 | Recipes and alternatives that respect restrictions, in an Arabic logger | No Arabic logger listing mentions them [V:S-021,S-023,S-024,S-025]. Global apps have meal plans [V:S-019,S-029] | Restriction-aware suggestions for Egyptian dishes | M | OBJ-04 | Open [A:ASM-14] |
| GAP-05 | Cross-device sync and portability | Sahnain lists backup and restore [V:S-023]. Others unknown [U] | Firestore sync with tested rules | H | OBJ-05 | Small or unknown |
| GAP-06 | Free-text and voice entry in Arabic | Offered by Kam, Sahnain, Kilo, TalkFood [V:S-021,S-023,S-043,S-028] | None | none | none | Closed |
| GAP-07 | Clear statement of where health data is stored | Rules are strict [V:S-017]. Sahnain declares its Play data-safety answers [V:S-044]. Other app statements unverified [U] | Plain Arabic privacy notice and consent | M | OBJ-08 | Open [A:ASM-09] |
| GAP-08 | Depth of Egyptian dish coverage and portion units | Kam claims portions in pieces, spoons and cups [V:S-021]. Quality untested [U] | Sourced dish table with household measures | M | OBJ-03 | Small until tested |

Honest summary: free-text and voice logging for Egyptian dishes already exist (GAP-06), including on Android (GAP-01). The remaining space is source transparency, tested accuracy, and restriction-aware suggestions.

## 2.6 Positioning

**One sentence.** Nesba is an Android-first Arabic and English meal logger that turns a free-text description into per-item nutrition with a visible source, and checks recipes and alternatives against the user's declared dietary restrictions [A:ASM-14].

**Three differentiators** (all [A:ASM-14] until the hands-on test and objectives are met):

1. A visible source for every number, backed by a sourced Egyptian reference table (OBJ-03).
2. Recipes and healthier alternatives that never violate a declared restriction, proven by automated tests (OBJ-04).
3. A published accuracy test on 30 Egyptian reference meals (OBJ-02).

**Claims we must NOT make.**

- "First Arabic AI calorie app" or "first Egyptian food tracker". Competitors already use "first" about themselves [V:S-021,S-026].
- "No solution exists" for Arabic or Egyptian food logging.
- "No Arabic or Egyptian AI logger exists on Android", or "the only Arabic-first Android app". Sahnain and Miran are on Android [V:S-044,S-050].
- "Only app with Egyptian dishes" or "only app with sources". Logma mentions citations and Kilo shows verified badges on restaurant items [V:S-027,S-043].
- "Most accurate", "clinical-grade", or any accuracy number before OBJ-02 is measured. Kam's site uses the phrase "clinical-grade accuracy" without a method [V:S-021].
- "Faster than competitors" before the timing test.
- "Better than MyFitnessPal" or any comparative claim without test data.
- Any diagnosis, treatment, dosing, or allergen-safety claim.
- Any price or feature of a competitor that conflicts across sources.

## 2.7 Hands-on test protocol

The team installs 5 apps and logs the same 6 meals.

**Android status of each candidate** (from the sources above; the team's own devices are not known, OPEN-29).

| App | Android status | Evidence |
|---|---|---|
| CMP-01 MyFitnessPal | Available | S-019 |
| CMP-02 YAZIO | Listed on Google Play | S-049 (tier B) |
| CMP-03 Cronometer | Available | S-031 |
| CMP-05 Cal AI | Available | S-042 |
| CMP-06 MacroFactor | Available (paid only) | S-041 |
| CMP-08 Sahnain | Available | S-044 |
| CMP-04 Lose It! | Listed on Google Play | S-055 (tier B) |
| CMP-07, CMP-09, CMP-10, CMP-11, CMP-12, CMP-13 | Not confirmed | [U] |

**Shortlist** [A:ASM-10]. The app is Android-first, so the first five are apps with a confirmed Android build:

1. CMP-08 Sahnain (Arabic and Egyptian focus).
2. CMP-01 MyFitnessPal (paid tiers needed for scan and voice).
3. CMP-02 YAZIO.
4. CMP-05 Cal AI.
5. CMP-03 Cronometer.

**Alternates** (use when a device or account is missing): CMP-06 MacroFactor (paid only), CMP-07 Kam Calorie (needs an iPhone), CMP-09 Khatwa (needs an iPhone). If an iPhone is available (OPEN-29), swap CMP-03 and CMP-05 for CMP-07 and CMP-09, because those two have Arabic interfaces and no confirmed Android build.

**Meals (use these exact descriptions).**

1. Koshari (كشري) plate.
2. Ful medames (فول مدمس) with baladi bread (عيش بلدي).
3. Taameya (طعمية) sandwich, 4 pieces.
4. Molokhia (ملوخية) with rice and chicken.
5. Mahshi (محشي), 5 pieces.
6. Feteer meshaltet (فطير مشلتت) with honey.

**Rules.**

- Fresh install and a new account per app. Note the tier used (free or paid).
- For any paid tier, record the price shown in the Egyptian Play Store, in EGP, on the test day.
- Same device per platform, same network, one tester per app.
- Time starts when the add-food screen opens and stops when the entry is saved.
- Count taps from the same start to the same stop.
- Record the store rating, rating count, last update date and app language on the test day.
- Do not edit a result to match a reference. Record what the app shows.

**Results (empty).**

| app | meal | found? (Y/N) | time to log (s) | taps | calories shown | source shown? | notes | tester | device and OS | app version | tier (free/paid) | date |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |  |  |  |  |  |
