---
id: DISC-01-B
title: Nesba Discovery, Section B (source log)
parent: DISC-01
status: draft
last_verified: 2026-10-11
owner: TBD
---

> **AI NOTES**
> - What this is: Section B, the source log for the discovery set. Hub: [DISCOVERY.md](DISCOVERY.md).
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team to fill.
> - Treat [U] and [T] as unknown, never as facts. Tier C rows only show conflicts.
> - IDs defined here: S-001 to S-123, except two withdrawn IDs listed below.
> - Do not reuse a withdrawn ID.

# B. Source log

Part of [DISCOVERY.md](DISCOVERY.md). Every source cited in the body has a row here. Access dates are 2026-10-05 (first pass), 2026-10-07 (revision pass) or 2026-10-08 (`S-056` to `S-092`, added by the feasibility study) or 2026-10-09 (`S-093` to `S-115`, added by the decision log) or 2026-10-10 (`S-116` and `S-117`, added by the final review) or 2026-10-11 (`S-118` to `S-123`, added by the work plan). The `Team check` column is for the team to sign off each source.

Tiers: A = official or academic page (company docs, store listing, peer-reviewed paper, government, law firm). B = independent review, news, or listing aggregator. C = blog by a competitor or affiliate. Preprints are tier A and say "preprint, not peer-reviewed". Tier C rows are used only to show conflicts, never as [V].

| S-ID | Title | URL | Tier | Access date | Used for | Note | Team check |
|---|---|---|---|---|---|---|---|
| S-001 | NCD-RisC country factsheet, Egypt (underweight and obesity, 2022; Lancet 2024 analysis) | https://ncdrisc.org/downloads/country-pdf/NCD-RisC%20country%20factsheet%20Egypt.pdf | A | 2026-10-07 | EVD-01, EVD-02 |  | [T] |
| S-002 | Global Nutrition Report, Egypt country nutrition profile | https://globalnutritionreport.org/resources/nutrition-profiles/africa/northern-africa/egypt/ | A | 2026-10-05 | EVD-03, EVD-04 |  | [T] |
| S-003 | World Obesity data portal, Egypt adult obesity, DHS 2015 notes | https://data.worldobesity.org/downloader/8efdf2f86f41d731b1af69eb08dd5065.pdf | A | 2026-10-07 | EVD-05 method | Generic DHS note about ever-married women 15–49 does not match S-004; not used for the EHIS sample description | [T] |
| S-004 | Egypt Health Issues Survey 2015 final report (FR313) | https://dhsprogram.com/pubs/pdf/FR313/FR313.pdf | A | 2026-10-07 | EVD-05 sample, population, table locations | Opened in revision pass: front matter, sample tables and contents read. Chapter 5 (BMI tables) not reached; figures stay [U] | [T] |
| S-005 | Statcounter, mobile operating system market share, Egypt (Sept 2026) | https://gs.statcounter.com/os-market-share/mobile/egypt | A | 2026-10-07 | EVD-07 | Chart is script-rendered; only the latest month is visible. An earlier snapshot of the same page shows Oct 2025 | [T] |
| S-006 | Cordeiro et al., "Barriers and Negative Nudges: Exploring Challenges in Food Journaling" (CHI 2015, PMC copy) | https://pmc.ncbi.nlm.nih.gov/articles/PMC4755274 | A | 2026-10-07 | EVD-08, PRB-01 |  | [T] |
| S-007 | University of Washington CSE news item on the same study | https://news.cs.washington.edu/?p=15306 | A | 2026-10-07 | EVD-08 sample sizes | Retrieved through search on 2026-10-07 because the URL was no longer fetchable directly | [T] |
| S-008 | Georgia Tech news item on the same study | https://hg.gatech.edu/node/396701 | A | 2026-10-05 | EVD-09 |  | [T] |
| S-009 | Burke, Wang, Sevick, "Self-monitoring in weight loss: a systematic review" (J Am Diet Assoc 2011) | https://pubmed.ncbi.nlm.nih.gov/21185970/ | A | 2026-10-07 | EVD-10 |  | [T] |
| S-010 | "Slip Buddy App for Weight Management" feasibility trial (JMIR mHealth 2021) | https://mhealth.jmir.org/2021/4/e24249 | A | 2026-10-05 | EVD-11 |  | [T] |
| S-011 | NYU IFP abstract page for a 2021 journal article on dietary self-monitoring methods and habit formation (DOI suffix s41347-021-00203-9) | https://ifp.nyu.edu/2021/journal-article-abstracts/s41347-021-00203-9/ | A | 2026-10-07 | EVD-12 |  | [T] |
| S-012 | NutriMLLM: Multimodal LLMs for Dietary Micronutrient Analysis (arXiv 2606.08948, preprint, not peer-reviewed) | https://arxiv.org/pdf/2606.08948 | A | 2026-10-05 | EVD-13, CMP-16 |  | [T] |
| S-013 | NutriBench (ICLR 2025) | https://proceedings.iclr.cc/paper_files/paper/2025/hash/ef3a57e4f26b640e6f90d78cbb011feb-Abstract-Conference.html | A | 2026-10-07 | EVD-14, CMP-17 |  | [T] |
| S-014 | Open-KNEAD (arXiv 2607.12911, preprint, not peer-reviewed) | https://arxiv.org/abs/2607.12911 | A | 2026-10-05 | EVD-15, CMP-14, CMP-15 |  | [T] |
| S-015 | IDF Diabetes Atlas, 11th edition (Lancet Diabetes Endocrinol, Dec 2025), abstract | https://oar.baker.edu.au/103703 | A | 2026-10-05 | EVD-06 pointer (IDF Atlas, not extracted) |  | [T] |
| S-016 | Law No. 151 of 2020, Personal Data Protection Law, English translation hosted by a law firm | https://eg.andersen.com/wp-content/uploads/2026/02/Law-No.-151-of-2020-1.pdf | A | 2026-10-05 | EVD-17, CON-06 | English translation hosted by a law firm, not the official Arabic text. Official text to be checked (OPEN-31) | [T] |
| S-017 | CMS legal update, "Egypt's PDPL: Executive regulations issued" (13 Jan 2026) | https://cms.law/en/are/legal-updates/egypt-s-pdpl-executive-regulations-issued-one-year-compliance-countdown-begins | A | 2026-10-07 | EVD-18, EVD-19, PRB-07 |  | [T] |
| S-018 | Al Tamimi & Co briefing on the Executive Regulations | https://www.tamimi.com/law_update_articles/from-policy-to-practice-egypt-issues-executive-regulations-of-the-personal-data-protection-law/ | A | 2026-10-07 | EVD-18 (Decision 816/2025) |  | [T] |
| S-019 | MyFitnessPal 2026 Winter Release press release (24 Feb 2026), syndicated copy | https://lite.aol.com/sports/other/story/0022/20260224/9659625.htm | A | 2026-10-07 | CMP-01 | Syndicated copy of a company press release. The release does not state a region for prices | [T] |
| S-020 | TechCrunch, "MyFitnessPal has acquired Cal AI, the viral calorie app built by teens" (2 March 2026) | https://techcrunch.com/2026/03/02/myfitnesspal-has-acquired-cal-ai-the-viral-calorie-app-built-by-teens/ | B | 2026-10-07 | CMP-05 (acquisition, database integration) | Opened directly on 2026-10-07. Published 2 March 2026, 6:00 AM PST. The earlier short URL https://techcrunch.com/?p=3098039 leads to the same article | [T] |
| S-021 | Kam Calorie official site (English) | https://www.kamcalorie.app/en | A | 2026-10-07 | CMP-07 |  | [T] |
| S-023 | Sahnain, App Store listing (Egypt storefront) | https://apps.apple.com/eg/app/sahnain/id6777599299 | A | 2026-10-05 | CMP-08 |  | [T] |
| S-024 | Khatwa: AI Fitness & Nutrition, App Store listing | https://apps.apple.com/app/id6760194825 | A | 2026-10-07 | CMP-09 |  | [T] |
| S-025 | Zadi, listing text via mwm.ai | https://mwm.ai/apps/zadi/6762077377 | B | 2026-10-05 | CMP-10 |  | [T] |
| S-026 | Kilo: Calorie Tracker, listing text via mwm.ai | https://mwm.ai/apps/kilo-calorie-tracker/6760403552 | B | 2026-10-05 | CMP-11 |  | [T] |
| S-027 | Logma, App Store listing | https://apps.apple.com/us/app/logma/id6759130753 | A | 2026-10-05 | CMP-12 |  | [T] |
| S-028 | TalkFood: Voice Food Tracker, App Store listing | https://apps.apple.com/app/id6757200636 | A | 2026-10-05 | CMP-13 |  | [T] |
| S-029 | YAZIO, App Store listing (Paraguay storefront) | https://apps.apple.com/py/app/yazio-ai-calorie-tracker/id946099227?l=en-GB | A | 2026-10-05 | CMP-02 |  | [T] |
| S-030 | Cronometer, App Store listing | https://apps.apple.com/app/cronometer-calorie-counter/id1145935738 | A | 2026-10-07 | CMP-03 |  | [T] |
| S-031 | Cronometer news and press page | https://cronometer.com/blog/?p=46801 | A | 2026-10-07 | CMP-03 pricing, verified data | Company 'News & Press' page. The first pass recorded the URL https://cronometer.com/media for the same content | [T] |
| S-032 | MacroFactor, App Store listing (Argentina storefront) | https://apps.apple.com/ar/app/id1553503471 | A | 2026-10-07 | CMP-06 | Listing states that the prices are for US customers | [T] |
| S-033 | nutriscan.app, MyFitnessPal pricing 2026 guide (claims Lose It! at USD 79.99) | https://nutriscan.app/blog/posts/myfitnesspal-pricing-2026-guide-2ff09c399a | C | 2026-10-05 | CMP-04 price conflict only |  | [T] |
| S-034 | nutriscan.app, Lose It pricing 2026 (claims USD 39.99/yr) | https://nutriscan.app/blog/posts/lose-it-pricing-2026-free-vs-premium-2b4e921555 | C | 2026-10-05 | CMP-04 price conflict only |  | [T] |
| S-035 | recurdash.com, MyFitnessPal pricing tracker (monthly prices) | https://recurdash.com/subscription-pricing/myfitnesspal | C | 2026-10-05 | CMP-01 monthly price ([U]) |  | [T] |
| S-036 | nutriscan.app, MacroFactor cost 2026 (claims AI photo and voice logging) | https://nutriscan.app/blog/posts/macrofactor-cost-2026-free-version-29f5edc98b | C | 2026-10-05 | CMP-06 conflict only |  | [T] |
| S-037 | nutrola.app, "Is MacroFactor worth it" (competitor blog; denies AI photo and voice) | https://nutrola.app/en/blog/is-macrofactor-worth-it-2026 | C | 2026-10-05 | CMP-06 conflict only |  | [T] |
| S-038 | Dayra Life, listing text via mwm.ai | https://mwm.ai/apps/dayra-life/6767976912 | B | 2026-10-05 | OPEN-17 (not profiled) |  | [T] |
| S-040 | Burke, Wang, Sevick, self-monitoring review, PMC full text | https://pmc.ncbi.nlm.nih.gov/articles/PMC3268700/ | A | 2026-10-07 | EVD-10 (14 vs 15 dietary studies; US-based samples) |  | [T] |
| S-041 | MacroFactor press kit | https://macrofactor.com/press-kit/ | A | 2026-10-07 | CMP-06 platforms and price |  | [T] |
| S-042 | Cal AI official site | https://www.calai.app/ | A | 2026-10-07 | CMP-05 platforms, input modes, trial, accuracy FAQ |  | [T] |
| S-043 | Kilo official site | https://kiloappsa.com/ | A | 2026-10-07 | CMP-11, GAP-02 |  | [T] |
| S-044 | Sahnain: Egyptian Calorie Log, Google Play listing | https://play.google.com/store/apps/details?id=com.sahnain.app | A | 2026-10-07 | CMP-08 Android, GAP-01, problem statement | Shows 500+ downloads and an update on 2026-09-24; no rating displayed. Developer identity match with the App Store entry is inferred | [T] |
| S-045 | Baker McKenzie update on Egypt data protection regulations | https://connectontech.bakermckenzie.com/egypt-important-data-protection-update/ | A | 2026-10-07 | EVD-18 |  | [T] |
| S-046 | Lose It!, App Store listing (US storefront) | https://apps.apple.com/us/app/lose-it-calorie-counter/id297368629?uo=4 | A | 2026-10-07 | CMP-04 |  | [T] |
| S-047 | MyFitnessPal, App Store listing (US storefront) | https://apps.apple.com/us/app/myfitnesspal-calorie-counter/id341232718 | A | 2026-10-07 | CMP-01 monthly Premium price |  | [T] |
| S-048 | Nimdzi, lessons in localization: YAZIO | https://www.nimdzi.com/lessons-in-localization-yazio/ | B | 2026-10-07 | CMP-02 languages | States 20 languages without a list | [T] |
| S-049 | App Pricing Lab, YAZIO Google Play data | https://www.apppricinglab.com/app/google_play/com.yazio.android | B | 2026-10-07 | CMP-02 Android listing | Aggregator of public Play data; undated | [T] |
| S-050 | chrome-stats, Miran: Calorie Counter, Android listing data | https://chrome-stats.com/d/com.miranapp.trainee | B | 2026-10-07 | GAP-01 | Aggregator mirroring Play text | [T] |
| S-051 | My Meal Mate smartphone app pilot RCT (J Med Internet Res 2013;15(4):e32) | https://www.jmir.org/2013/4/e32/ | A | 2026-10-07 | EVD-20 | URL form to be confirmed by the team | [T] |
| S-052 | NCD-RisC, worldwide trends in diabetes prevalence and treatment 1990–2022 (PMC copy) | https://pmc.ncbi.nlm.nih.gov/articles/PMC7616842/ | A | 2026-10-07 | EVD-06 method | Method paper; the Egypt number was read from S-053 | [T] |
| S-053 | statisticsoftheworld.com, Egypt diabetes prevalence (age 18+) | https://statisticsoftheworld.com/country/egypt/WHO.DIABETES | B | 2026-10-07 | EVD-06 | Data aggregator repeating a WHO-series estimate. Confirm at the official source (OPEN-32) | [T] |
| S-054 | MyFitnessPal press release on the Cal AI acquisition (2 March 2026), syndicated copy | https://www.messenger-inquirer.com/ap/sports/myfitnesspal-acquires-cal-ai-expanding-on-its-position-as-the-leading-player-in-digital/article_963c4a59-f457-5cbe-ac08-b8dddf14ee54.html | A | 2026-10-07 | CMP-05 acquisition date, revenue conflict | Syndicated company release | [T] |
| S-055 | App Pricing Lab, Lose It! Google Play data | https://apppricinglab.com/app/google_play/com.fitnow.loseit | B | 2026-10-07 | CMP-04 Android listing, ads label | Aggregator of public Play data; undated | [T] |
| S-056 | Frontiers in Nutrition 2026, doi 10.3389/fnut.2026.1952757, nine LLMs vs Chinese food composition table | https://www.frontiersin.org/journals/nutrition/articles/10.3389/fnut.2026.1952757/full | A | 2026-10-08 | CL-01, CL-02, CL-14, section 10 | Opened (full text) | [T] |
| S-057 | PubMed record 42401322, Lawabni et al., J Nutr 2026;156(9):101712 | https://pubmed.ncbi.nlm.nih.gov/42401322/ | A | 2026-10-08 | CL-01 | Excerpt (page blocked) | [T] |
| S-058 | QIMMA, arXiv 2604.03395 | https://arxiv.org/pdf/2604.03395 | A | 2026-10-08 | CL-04 | Excerpt | [T] |
| S-059 | MBZUAI Jais 2 announcement (2025-12-09) and Jais 2 paper listing | https://mbzuai.ac.ae/news/inception-cerebras-and-mbzuai-release-jais-2-the-next-generation-of-the-worlds-leading-arabic-open-weight-llm/ | A | 2026-10-08 | CL-04, CL-05 | Excerpt | [T] |
| S-060 | Hugging Face model card, Jais-2-70B-Chat | https://huggingface.co/inceptionai/Jais-2-70B-Chat | A | 2026-10-08 | CL-05, TD-02 | Excerpt; URL built from the model id in the QIMMA table; confirm | [T] |
| S-061 | AraDiCE, COLING 2025, arXiv 2409.11404 | https://arxiv.org/abs/2409.11404 | A | 2026-10-08 | TD-02 K4 | Excerpt | [T] |
| S-062 | DialectalArabicMMLU, arXiv 2510.27543 | https://arxiv.org/abs/2510.27543 | A | 2026-10-08 | TD-02 K4 | Excerpt (abstract) | [T] |
| S-063 | Edamam Food Database API page, developer.edamam.com/food-database-api | https://developer.edamam.com/food-database-api | A | 2026-10-08 | CL-06, TD-01 | Opened | [T] |
| S-064 | Edamam Nutrition Analysis API page, developer.edamam.com/edamam-nutrition-api | https://developer.edamam.com/edamam-nutrition-api | A | 2026-10-08 | CL-06, TD-01 | Opened | [T] |
| S-065 | FatSecret Platform API editions page and vendor posts on NLP and image add-ons | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | CL-08, TD-01 | Excerpt | [T] |
| S-066 | CalorieNinjas API page (turn-down notice) | https://calorieninjas.com/ | A | 2026-10-08 | CL-09 | Excerpt | [T] |
| S-067 | API Ninjas Nutrition API page | https://api-ninjas.com/api/nutrition | A | 2026-10-08 | CL-09, TD-01 | Excerpt | [T] |
| S-068 | API Ninjas pricing page and terms | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | CL-09, TD-01 | Excerpt | [T] |
| S-069 | DietlyAPI vendor posts (dev.to, Product Hunt, publicapis.dev) | https://dev.to/dietly/taming-open-food-facts-building-a-fast-searchable-nutrition-database-403l https://publicapis.dev/resource/dietlyapi/8ph9ngem | C | 2026-10-08 | CL-10, TD-01 | Excerpt; vendor claims, conflicts only | [T] |
| S-070 | Open Food Facts API introduction, openfoodfacts.github.io/openfoodfacts-server/api/ | https://openfoodfacts.github.io/openfoodfacts-server/api/ | A | 2026-10-08 | CL-11, TD-01, TD-05 | Opened | [T] |
| S-071 | Firebase, "Access data offline", last updated 2026-10-06 | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | CL-12, TD-03 | Opened | [T] |
| S-072 | Firestore transactions and batched writes page | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | CL-12, TD-03 | Excerpt | [T] |
| S-073 | Cloud Firestore pricing and Firebase pricing pages | https://firebase.google.com/pricing | A | 2026-10-08 | TD-03, TD-06 | Excerpt | [T] |
| S-074 | GitHub flutterfire issues #8496 and #12952, discussion #5708 | https://github.com/firebase/flutterfire/issues/8496 https://github.com/firebase/flutterfire/issues/12952 https://github.com/firebase/flutterfire/discussions/5708 | B | 2026-10-08 | CL-12 | Excerpt; URLs built from the repository name and numbers; confirm | [T] |
| S-075 | Gemini API pricing page, ai.google.dev/gemini-api/docs/pricing | https://ai.google.dev/gemini-api/docs/pricing | A | 2026-10-08 | TD-02, TD-05 | Opened | [T] |
| S-076 | Gemini API deprecations page, updated 2026-10-07 | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | CL-16, TD-02 | Opened | [T] |
| S-077 | Gemini API rate-limits page, updated 2026-09-02 | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | TD-02 | Opened | [T] |
| S-078 | Firebase AI Logic pricing page | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | TD-02 | Excerpt | [T] |
| S-079 | Anthropic pricing page, platform.claude.com/docs/en/about-claude/pricing | https://platform.claude.com/docs/en/about-claude/pricing | A | 2026-10-08 | TD-02 | Opened | [T] |
| S-080 | OpenAI API pricing page | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | TD-02 | Opened | [T] |
| S-081 | TechCrunch report on Mistral's free tier; aggregator pages (tier C, not used as `[V]`) | [T: URL not recorded in the first version of 04] | B | 2026-10-08 | TD-02 | Excerpt | [T] |
| S-082 | USDA FoodData Central API guide and download pages | https://fdc.nal.usda.gov/api-guide.html | A | 2026-10-08 | TD-01, TD-05 | Excerpt | [T] |
| S-083 | FAO/INFOODS listings of Egypt food composition tables | https://www.fao.org/infoods/infoods/tables-and-databases/egypt/en | A | 2026-10-08 | TD-01 | Excerpt | [T] |
| S-084 | Egypt PDPL: Law 151 of 2020 text, law-firm notes (Chambers/GLA, Kennedys, Clyde & Co, Consortio), PDPC portal; tier B: Law Lab Africa, Recording Law | [T: URL not recorded in the first version of 04] | A/B | 2026-10-08 | TD-05, RSK-01 | Excerpt; deadline dates differ by source; law-firm pages already logged as S-016, S-017, S-018, S-045 | [T] |
| S-085 | Spoonacular terms and limits via apilayer marketplace and apis.io | [T: URL not recorded in the first version of 04] | B | 2026-10-08 | TD-01 | Excerpt | [T] |
| S-086 | pub.dev pages: `riverpod_offline_sync`, `flutter_data_sync_manager`, `flutter_offline_sync_manager` | https://pub.dev/packages/riverpod_offline_sync https://pub.dev/packages/flutter_data_sync_manager https://pub.dev/packages/flutter_offline_sync_manager | A | 2026-10-08 | CL-13, TD-03 | Excerpt; URLs built from the package names; confirm | [T] |
| S-087 | Bibliographic record, Multimedia Systems 32(2), 2026, doi 10.1007/s00530-025-02151-3 | https://doi.org/10.1007/s00530-025-02151-3 | B | 2026-10-08 | CL-03 | Excerpt | [T] |
| S-088 | BiteRight listings (PeerPush, Trustpilot company text) | [T: URL not recorded in the first version of 04] | C | 2026-10-08 | CL-07 | Excerpt; conflicts only | [T] |
| S-089 | FoodScribe, medRxiv preprint (2026-07-17), grounded LLM + USDA retrieval | [T: URL not recorded in the first version of 04] | A | 2026-10-08 | TD-02, CL-14 | Excerpt; not peer reviewed | [T] |
| S-090 | Carrillo-Larco et al., arXiv 2509.13268, LLM nutrient estimation from text recalls | https://arxiv.org/abs/2509.13268 | A | 2026-10-08 | Section 10 | Excerpt; preprint | [T] |
| S-091 | App listings and posts for Sahnain and Kam Calorie Tracker | [T: URL not recorded in the first version of 04] | B/C | 2026-10-08 | OPEN-50 | Excerpt; leads only | [T] |
| S-092 | Developer blog summary of Firebase plan changes (Cloud Storage on Spark) | [T: URL not recorded in the first version of 04] | C | 2026-10-08 | TD-06 | Excerpt; conflicts only, claim `[U]` | [T] |
| S-093 | Firebase AI Logic, "Implement Firebase App Check to protect APIs from unauthorized clients" | https://firebase.google.com/docs/ai-logic/app-check | A | 2026-10-09 | ADR-16 | Excerpt through search | [T] |
| S-094 | FlutterFire VERSIONS.md (Flutter BoM table; BoM 4.20.0 of 2026-09-14) | https://github.com/firebase/flutterfire/blob/main/VERSIONS.md | A | 2026-10-09 | DEP-07 to DEP-13, DEP-31, ADR-11, ADR-16 | Opened (raw file) | [T] |
| S-095 | FlutterFire CHANGELOG.md (BoM 4.19.1 and 4.20.0 notes) | https://github.com/firebase/flutterfire/blob/main/CHANGELOG.md | A | 2026-10-09 | ADR-11, `06-DECISIONS.md` §6 | Opened (raw file) | [T] |
| S-096 | Flutter blog, "What's new in Flutter 3.47" (2026-08-12) | https://flutter.dev/blog/whats-new-in-flutter-3-47 | A | 2026-10-09 | ADR-02, ADR-03, ADR-04, DEP-01, DEP-30 | Opened | [T] |
| S-097 | Flutter docs, "Migrate to standalone material_ui and cupertino_ui packages" | https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui | A | 2026-10-09 | ADR-04, ADR-10 | Excerpt through search | [T] |
| S-098 | Flutter releases (GitHub release feed) | https://github.com/flutter/flutter/releases | A | 2026-10-09 | ADR-03, DEP-01 | Feed read: newest tags 3.47.7 (2026-09-30) and a 3.49 pre-release. A vendor docs page that listed 3.47.1 as latest was stale and is not used | [T] |
| S-099 | Android Developers, target API level requirements for Google Play | https://developer.android.com/google/play/requirements/target-sdk | A | 2026-10-09 | ADR-02, `06-DECISIONS.md` §6, §8 | Excerpt through search | [T] |
| S-100 | Google Play Console Help, target API level requirement | https://support.google.com/googleplay/android-developer/answer/11926878 | A | 2026-10-09 | ADR-02 | Excerpt through search | [T] |
| S-101 | Gemini API deprecations page, re-read on 2026-10-09 (same page as S-076) | https://ai.google.dev/gemini-api/docs/deprecations | A | 2026-10-09 | ADR-17, DEP-36 | Excerpt through search | [T] |
| S-102 | Firebase pricing page, re-read on 2026-10-09 (same page as S-073) | https://firebase.google.com/pricing | A | 2026-10-09 | ADR-15, ADR-17, ADR-24 | Excerpt through search | [T] |
| S-103 | Android Developers, "Configure the app module" (application ID) | https://developer.android.com/studio/build/application-id | A | 2026-10-09 | ADR-29 | Excerpt. Domain-based naming and the com.example rule were read in a docs.rs copy of the manifest reference; confirm on developer.android.com (OPEN-61) | [T] |
| S-104 | flutter/packages repository: go_router, flutter_lints, material_ui, cupertino_ui | https://github.com/flutter/packages | A | 2026-10-09 | ADR-03, ADR-04, ADR-07, ADR-26, DEP-02, DEP-03, DEP-05, DEP-20 | `pubspec.yaml` and licence read as raw files on the main branch; may be ahead of the published version (OPEN-58) | [T] |
| S-105 | rrousselGit/riverpod repository (flutter_riverpod) | https://github.com/rrousselGit/riverpod | A | 2026-10-09 | ADR-04, ADR-06, DEP-33 | `pubspec.yaml`, changelog, licence and release feed; main branch (OPEN-58) | [T] |
| S-106 | cfug/dio repository | https://github.com/cfug/dio | A | 2026-10-09 | ADR-21, DEP-06 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-107 | felangel/bloc and felangel/mocktail repositories | https://github.com/felangel/bloc https://github.com/felangel/mocktail | A | 2026-10-09 | ADR-06, ADR-08, ADR-25, DEP-04, DEP-19, DEP-40, DEP-41 | `pubspec.yaml` and licence; release date matched for mocktail only (OPEN-58). On 2026-10-10 the `pubspec.yaml`, `CHANGELOG.md` and licence of `bloc`, `flutter_bloc` and `bloc_test` (main branch) were read; release dates were not | [T] |
| S-108 | juliansteenbakker/flutter_secure_storage and mobile_scanner repositories | https://github.com/juliansteenbakker/flutter_secure_storage https://github.com/juliansteenbakker/mobile_scanner | A | 2026-10-09 | ADR-14, ADR-20, DEP-14, DEP-16 | `pubspec.yaml` and licence; README not read (OPEN-58) | [T] |
| S-109 | Baseflow/flutter-permission-handler repository | https://github.com/Baseflow/flutter-permission-handler | A | 2026-10-09 | ADR-20, DEP-15 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-110 | simolus3/drift repository | https://github.com/simolus3/drift | A | 2026-10-09 | ADR-13, DEP-32 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-111 | dart-lang/i18n repository (package intl) | https://github.com/dart-lang/i18n | A | 2026-10-09 | ADR-10, DEP-17 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-112 | imaNNeo/fl_chart repository | https://github.com/imaNNeo/fl_chart | A | 2026-10-09 | ADR-30, DEP-35 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-113 | rrousselGit/freezed repository | https://github.com/rrousselGit/freezed | A | 2026-10-09 | ADR-08, DEP-34 | `pubspec.yaml`, licence and release feed (OPEN-58) | [T] |
| S-114 | npm registry entries for firebase-tools and @firebase/rules-unit-testing | https://registry.npmjs.org/firebase-tools https://registry.npmjs.org/@firebase/rules-unit-testing | A | 2026-10-09 | ADR-12, DEP-21, DEP-22, DEP-23 | Registry JSON read: version, licence, publish date, Node engines | [T] |
| S-115 | GitHub repositories: subosito/flutter-action, actions/checkout, actions/setup-java, actions/setup-node, gitleaks/gitleaks, google/osv-scanner | https://github.com/subosito/flutter-action https://github.com/actions/checkout https://github.com/actions/setup-java https://github.com/actions/setup-node https://github.com/gitleaks/gitleaks https://github.com/google/osv-scanner | A | 2026-10-09 | ADR-22, ADR-23, ADR-27, DEP-24 to DEP-29 | Release feeds and licences read | [T] |
| S-116 | BLoC library documentation, FAQs ("State Not Updating", "When to use Equatable") | https://bloclibrary.dev/faqs | A | 2026-10-10 | ADR-06, ADR-08 | Excerpt through search: emit a new state instance each time; an equal state emitted again is ignored when states use value equality; `emit.forEach` for real-time updates | [T] |
| S-117 | felangel/equatable repository (equatable) | https://github.com/felangel/equatable | A | 2026-10-10 | ADR-06, ADR-08, DEP-42 | `pubspec.yaml`, changelog and licence of the main branch; the published version was not read (OPEN-58) | [T] |
| S-118 | The Scrum Guide, 2020 edition | https://scrumguides.org/docs/scrumguide/v2020/2020-Scrum-Guide-US.pdf | A | 2026-10-11 | SPR-, section 1, section 7 | Sprint of one month or less, planning, daily scrum, review, retrospective, definition of done; read through the PDF text | [T] |
| S-119 | Conventional Commits 1.0.0 | https://www.conventionalcommits.org/en/v1.0.0/ | A | 2026-10-11 | GIT-03, Appendix C | Excerpt through search: commit format `type(scope): description`, `feat` and `fix`, other types allowed | [T] |
| S-120 | GitHub docs, GitHub flow | https://docs.github.com/en/get-started/using-github/github-flow | A | 2026-10-11 | GIT-01, GIT-21 | Excerpt through search: lightweight branch-based workflow, branch, pull request, review, merge | [T] |
| S-121 | GitHub docs, About protected branches | https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches | A | 2026-10-11 | GIT-09, OPEN-80 | Excerpt through search: required reviews and status checks; availability on GitHub Free only for public repositories | [T] |
| S-122 | GitHub docs, About code owners | https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners | A | 2026-10-11 | GIT-07, Appendix E | Excerpt through search: CODEOWNERS file, owners need write access, optional required review | [T] |
| S-123 | Google Play Console Help, app testing requirements for new personal developer accounts | https://support.google.com/googleplay/android-developer/answer/14151465?hl=en | A | 2026-10-11 | Section 2.7, OPEN-79 | Excerpt through search: closed test with at least 12 testers opted in for the last 14 days before production access, for personal accounts created after 2023-11-13; Google review time not read | [T] |

Withdrawn IDs (not reused): S‑022 and S‑039. They were a private person's LinkedIn profile and an aggregator's API-style URL. They are written with non-breaking hyphens so that the check script does not treat them as live references.
