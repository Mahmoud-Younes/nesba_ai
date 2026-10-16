---
id: DISC-01-N
title: Nesba Discovery, Section N (project naming)
parent: DISC-01
status: draft
last_verified: 2026-10-07
owner: TBD
---

> **AI NOTES**
> - What this is: name research for the NutriVision app. 53 candidate names, 11 shortlisted, each checked against stores and web search on 2026-10-07, plus the working name `NAME-00` as a baseline. Nothing was registered, published or contacted.
> - Result: `NAME-09` Hessa (حصة, "portion") scores highest (74/100). Fallback is `NAME-10` Nesba (72). The working name `NAME-00` NutriVision ranks last (41) because exact-name food and nutrition products already exist (§6.1).
> - Decision: the team chose **Nesba (نسبة)** (§12, `DEC-01`). The ranking in §7 is kept as research history; Nesba was the fallback there.
> - Limits: Google Play pages, GitHub pages, registrars, social networks and trademark registries could not be reached. No name completed 5 of 7 checks, so `NC-05` is capped at 3 for all names (§6.4). "No hit found" is never clearance.
> - Arabic meanings are team judgement [A] unless a source is given. Only `حصة` has two dictionary sources. A native speaker must confirm the rest (`NOPEN-02`).
> - Tags: [V:NS-xxx] a source states it; [A] team judgement; [U] unverified; [T] for the team to fill. This is not legal advice. Confirm with the supervisor or a lawyer before any commercial use.

# N. Project naming

Part of [DISCOVERY.md](DISCOVERY.md). Own source numbering `NS-` avoids clashes with `S-` in [B-SOURCES.md](B-SOURCES.md). All checks were run on **2026-10-07**.

## 1. Brand brief

NutriVision is an Android-first Flutter app. A person types a meal in their own words, in Arabic or English. AI splits it into items, nutrition is computed from reference data, and every number shows its source. It suggests recipes and healthier alternatives that respect declared dietary restrictions, and meals sync across devices. Users are Arabic-speaking adults in Egypt who eat home-cooked dishes such as koshari (كشري), ful (فول), taameya (طعمية), molokhia (ملوخية) and mahshi (محشي). The team is five students with no budget, and the app is an information tool, not a medical device.

**Five attributes [A]:** trustworthy, friendly, simple, local, clear. Not clinical, not preachy, no body-shaming.

**Naming constraints:** short (≤ 12 characters, ≤ 3 syllables); stable spelling in Arabic and Latin letters; no medical-claim, religious or political words; no competitor names or sound-alikes; no well-known brands.

## 2. Criteria and weights

Weights are a team assumption [A]. Total = 100.

| ID | Criterion | Weight | What a high score means |
|---|---|---|---|
| NC-01 | Meaning and expressiveness | 20 | Evokes food, nutrition, clarity or trust, ideally with an Egyptian or Arabic flavour |
| NC-02 | Memorability and brevity | 15 | ≤ 12 characters, ≤ 3 syllables, easy to recall after one hearing |
| NC-03 | Pronounceability and spelling | 15 | Egyptian speakers say it as intended; one obvious spelling in Arabic and in Latin letters |
| NC-04 | Bilingual fit | 10 | Looks good in Arabic script and in Latin letters; same meaning or no meaning clash |
| NC-05 | Availability | 25 | Rules in §7 (capped at 3 when fewer than 5 checks were completed) |
| NC-06 | Cultural and linguistic safety | 10 | No negative, rude or funny homophone in Egyptian Arabic, MSA, English or French |
| NC-07 | Fit with an information (non-medical) tool | 5 | No medical or diet-shaming implication |

## 3. Landscape

### 3.1 How competitors are named

Names come from [02-COMPETITORS.md](02-COMPETITORS.md) [V:NS-001]. Arabic meanings below are team judgement [A].

| Name | Group | Pattern | Note |
|---|---|---|---|
| MyFitnessPal | Global | English compound ("my" + descriptor + "pal") | Long, descriptive |
| YAZIO | Global | Invented word | Short, no meaning |
| Cronometer | Global | Descriptive compound | Suggests precision |
| Lose It! | Global | English action phrase | Weight-loss framing |
| Cal AI | Global | Abbreviation + "AI" | Uses the crowded "Cal-" and "-AI" patterns |
| MacroFactor | Global | English compound | Descriptive |
| Kam Calorie | Regional | Arabic word + English descriptor | كم, "how much" [A] |
| Sahnain | Regional | Arabic word in Latin letters | Reads as صحنين, "two plates" [A] |
| Khatwa (Khtwa AI) | Regional | Arabic word + "AI" | خطوة, "step" [A] |
| Zadi | Regional | Arabic-looking word | Meaning [U] |
| Kilo | Regional | Borrowed unit word | Shared with the Saudi market |
| Logma | Regional | Arabic everyday word | لقمة, "bite" [A] |
| TalkFood | Regional | English descriptive compound | Says what it does |
| Mezan | Regional (`OPEN-17`, not profiled) | Arabic word | ميزان, "scale" [A] |
| Open-KNEAD, NutriMLLM, NutriBench, DietAI24 | Research references | Technical, "Nutri-" prefix | Not consumer brands |

### 3.2 More food and nutrition app names found on 2026-10-07

| Name | Where seen | Pattern |
|---|---|---|
| Lifesum, FatSecret, MyNetDiary | Independent roundup [V:NS-009] | Invented word, compound, descriptive |
| Carb Manager, Foodvisor, WeightWatchers | Independent roundup [V:NS-010] | Descriptive compound, brand name |
| Akli: AI Calorie & Recipe Scan | App Store [V:NS-011] | Arabic word "my food" + English descriptor |
| أكلي AI | App Store, Saudi dishes [V:NS-012] | Arabic word + "AI" |
| Akly | Listing aggregator [V:NS-013] | Arabic word in Latin letters |
| CalApp, Calz | App Store [V:NS-015,NS-016] | "Cal-" prefix |
| Calo | Meal plans, Gulf [V:NS-017] | "Cal-" prefix |
| Tabak AI | App Store [V:NS-025] | Turkish word "plate" + "AI" |
| AIplate, JustaPlate, Plates | App Store [V:NS-051,NS-052,NS-053] | "Plate" word |
| myTruePlate, PlateLens | Listing aggregators [V:NS-049,NS-050] | "Plate" word + descriptor |

### 3.3 Patterns

**Crowded (avoid):**

1. "Cal-" prefix: Cal AI, CalApp, Calz, Calo.
2. "Nutri-" prefix: NutriVision (several products, §6.1), Nutri Macro [V:NS-055], NutriBench, NutriMLLM.
3. "-AI" suffix: Cal AI, Tabak AI, أكلي AI, Khatwa AI.
4. English "plate": AIplate, JustaPlate, Plates, PlateLens, myTruePlate.
5. The Arabic root أكل ("akl", food or eating): Akli, Akly, أكلي AI, اكلاتك [V:NS-014].

**Meal and dish words** (Wagba, Wagbat, Wajbati, Tabkha, Sofra, Baladi) are also used by food-delivery, recipe and meal-prep services in the region (§6.1). A common Arabic word is easy to say but often taken.

**Worth following:** one short Arabic everyday word, as Logma and Sahnain do. It signals "local" at once.

**Sound-alikes to avoid:** Kam, Kilo, Zadi, Logma, Sahnain, Khatwa, Mezan/Mizan, Akli/Akly, Calo, Tabak AI, PlateLens.

## 4. Long list

Meanings are team judgement [A] unless a source is shown. "Why it fits" is at most 15 words.

| ID | Latin | Arabic | Transliteration | Strategy | Meaning | Why it fits |
|---|---|---|---|---|---|---|
| NAME-01 | Tabkha | طبخة | tabkha | Plate and dish | a cooked dish, home cooking | Home-cooked dishes are the core use. |
| NAME-02 | Wagba | وجبة | wagba | Plate and dish | a meal | The unit users log; Egyptian ج is "g". |
| NAME-03 | Akla | أكلة | akla | Plate and dish | a dish, something to eat | Everyday Egyptian word for a dish. |
| NAME-04 | Sofra | سفرة | sofra | Plate and dish | dining table, laid spread | Evokes the family table. |
| NAME-05 | Tabaq | طبق | tabaq (Egyptian: taba') | Plate and dish | plate, dish | The plainest word for plate. |
| NAME-06 | Lamma | لمّة | lamma | Plate and dish | gathering, get-together | Food as shared family time. |
| NAME-07 | Aklat | أكلات | aklat | Plate and dish | dishes (plural) | Names the range of dishes covered. |
| NAME-08 | Tabliya | طبلية | tabliya | Plate and dish | low round table for family meals | Strong image of Egyptian home meals. |
| NAME-09 | Hessa | حصة | ḥessa | Measure and balance | portion, share [V:NS-037,NS-038] | Portion is the core unit of food logging. |
| NAME-10 | Nesba | نسبة | nesba | Measure and balance | ratio, proportion, percentage | Macro shares of a meal. |
| NAME-11 | Mizan | ميزان | mizan | Measure and balance | scale, balance | Balance of nutrients. |
| NAME-12 | Mazbout | مظبوط | mazbout | Measure and balance | spot on, exactly right | A number that is just right. |
| NAME-13 | Zabt | ضبط | zabt (Egyptian: dabt) | Measure and balance | setting exactly, tuning | Precision of amounts. |
| NAME-14 | Qiyas | قياس | qiyas (Egyptian: 2eyas) | Measure and balance | measurement | The direct word for measuring. |
| NAME-15 | Kayl | كيل | kayl | Measure and balance | measuring by volume | Short; tied to measuring cups. |
| NAME-16 | Mikyal | مكيال | mikyal | Measure and balance | measuring vessel | Image of a measuring cup. |
| NAME-17 | Asl | أصل | asl | Source and trust | origin, root, source | The origin of each number; three letters. |
| NAME-18 | Sanad | سند | sanad | Source and trust | support, backing, reference | Evidence behind every figure. |
| NAME-19 | Manba | منبع | manba (manba3) | Source and trust | wellspring, source | Where each number comes from. |
| NAME-20 | Marja | مرجع | marga3 (Egyptian) | Source and trust | reference | A reference behind the values. |
| NAME-21 | Dalil | دليل | daleel | Source and trust | evidence, guide | Both proof and guidance. |
| NAME-22 | Shaffaf | شفاف | shaffaf | Source and trust | transparent | Names the transparency difference. |
| NAME-23 | Masdar | مصدر | masdar | Source and trust | source | The literal word for source. |
| NAME-24 | Thiqa | ثقة | thiqa (Egyptian: te2a) | Source and trust | trust | The attribute itself. |
| NAME-25 | Akl Sa7 | أكل صح | akl sah | Egyptian dialect | eat right, proper food | Seed phrase from the brief; plain and warm. |
| NAME-26 | Tamam | تمام | tamam | Egyptian dialect | all good, OK | Positive confirmation for a logged meal. |
| NAME-27 | Baladi | بلدي | baladi | Egyptian dialect | local, native, rustic | Local flavour; baladi bread is a staple. |
| NAME-28 | Eish | عيش | 3eish | Egyptian dialect | bread, and "life" in Egyptian speech | Bread as food and life. |
| NAME-29 | Dogri | دوغري | dogri | Egyptian dialect | straightforward, honest | Straight talk about numbers. |
| NAME-30 | Teslam | تسلم | teslam | Egyptian dialect | "bless your hands", praise for a cook | Warm thanks for home cooking. |
| NAME-31 | Kefaya | كفاية | kefaya | Egyptian dialect | enough | A portion that is "enough". |
| NAME-32 | Bel Hana | بالهنا | bel hana | Egyptian dialect | "enjoy" said at the table | Said when a meal is served. |
| NAME-33 | TruePlate | ترو بليت | tru bleit | English compound | true + plate | A plate with honest numbers. |
| NAME-34 | ClearPlate | كلير بليت | kleer bleit | English compound | clear + plate | A plate you can see through. |
| NAME-35 | PlateTrace | بليت تريس | bleit tréis | English compound | plate + trace | Traces each number to its source. |
| NAME-36 | BiteTrace | بايت تريس | bait tréis | English compound | bite + trace | Traces each bite. |
| NAME-37 | BiteWise | بايت وايز | bait wayz | English compound | bite + wise | Informed choices per bite. |
| NAME-38 | SourceBite | سورس بايت | sors bait | English compound | source + bite | Names the source feature. |
| NAME-39 | PlateLens | بليت لنز | bleit lenz | English compound | plate + lens | A closer look at the plate. |
| NAME-40 | TrueBite | ترو بايت | tru bait | English compound | true + bite | Honest numbers per bite. |
| NAME-41 | Tabkhi | طبخي | tabkhi | Coined word | "my cooking" | Personal and home-cooked. |
| NAME-42 | Wagbi | وجبي | wagbi | Coined word | "my meal" (coined possessive) | Personal; short. |
| NAME-43 | Akli | أكلي | akli | Coined word | "my food" | Personal; short. |
| NAME-44 | Haba | حبة | haba | Coined word | a piece, a grain | Counts pieces, such as 5 mahshi. |
| NAME-45 | Aklo | أكلو | aklo | Coined word | coined from akl (food) | Short, easy to say. |
| NAME-46 | Tabelo | تابيلو | tabelo | Coined word | coined from "table" | Reads naturally in both scripts. |
| NAME-47 | Kalo | كالو | kalo | Coined word | echoes "cal" and "eat" | Short; hints at calories. |
| NAME-48 | Aklify | أكليفاي | akli-fay | Hybrid | akl + English "-ify" | Arabic root with an English verb ending. |
| NAME-49 | AklWise | أكل وايز | akl wayz | Hybrid | akl + wise | Informed eating. |
| NAME-50 | Aklens | أكلنز | aklenz | Hybrid | akl + lens | A closer look at food. |
| NAME-51 | BeitBite | بيت بايت | beit bait | Hybrid | home + bite | Home food in two short words. |
| NAME-52 | WagbaWise | وجبة وايز | wagba wayz | Hybrid | meal + wise | Informed meals. |
| NAME-53 | TabkhaLens | طبخة لنز | tabkha lenz | Hybrid | dish + lens | A closer look at a dish. |

Counts: Plate and dish 8, Measure and balance 8, Source and trust 8, Egyptian dialect 8, English compounds 8, Coined words 7, Hybrid 6. Total 53.

## 5. Quick filter

Rules applied: hard rule 6 (no brands, competitors or sound-alikes of competitors, no religious, political or medical-claim words), hard rule 7 (stable Arabic spelling), and length (over 14 characters). Drop reasons that rest on a source show it; the rest are team judgement [A].

### 5.1 Dropped (42)

| ID | Name | Reason dropped |
|---|---|---|
| NAME-05 | Tabaq | Egyptians drop the ق ("taba'"); sound-alike of the calorie app Tabak AI [V:NS-025] |
| NAME-06 | Lamma | Spelling can also read as لما ("when") [U]; weak link to the app's job |
| NAME-07 | Aklat | Plural form sounds technical; shares the crowded "akl" root (§3.3) |
| NAME-08 | Tabliya | Latin spelling unstable (Tabliya, Tablia, Tableya) |
| NAME-11 | Mizan | Sound-alike of the competitor Mezan (`OPEN-17`) |
| NAME-12 | Mazbout | Latin spelling unstable (Mazbout, Mazboot, Mazbot) |
| NAME-13 | Zabt | Egyptians say ض as "d", so the name is read "dabt"; spelling unstable |
| NAME-14 | Qiyas | Also a term in Islamic jurisprudence [U] (religious term); ق is a glottal stop in Egyptian speech |
| NAME-15 | Kayl | English readers say "Kyle"; weak link to food |
| NAME-16 | Mikyal | Latin spelling unstable (Mikyal, Mekyal, Mikyaal) |
| NAME-18 | Sanad | Common given name; widely used in regional brands [U] |
| NAME-19 | Manba | Latin spelling unstable because of ع (Manba, Manba3, Manbaa) |
| NAME-20 | Marja | Latin spelling unstable; also a religious title in some traditions [U] |
| NAME-21 | Dalil | Latin spelling unstable (Dalil, Daleel, Dalyl) |
| NAME-22 | Shaffaf | Latin spelling unstable (Shaffaf, Shafaf, Shaffaaf) |
| NAME-23 | Masdar | Name of a well-known Abu Dhabi company [U], so a well-known brand |
| NAME-24 | Thiqa | ث is said "s" or "t" in Egyptian speech; spelling unstable |
| NAME-25 | Akl Sa7 | Two words; the digit 7 gives unstable Latin spelling (Sa7, Sah, Saha) |
| NAME-26 | Tamam | Very common word; likely crowded and weak link to food [U] |
| NAME-28 | Eish | Latin spelling unstable (Eish, Aish, Aysh) |
| NAME-29 | Dogri | Latin spelling unstable; also the name of an Indian language [U] |
| NAME-30 | Teslam | Root س-ل-م invites a religious reading [A] |
| NAME-31 | Kefaya | Also the name of an Egyptian political movement [U] (political term) |
| NAME-32 | Bel Hana | Two words; the full phrase ends with شفا ("cure"), a medical-claim word [A] |
| NAME-34 | ClearPlate | Arabic spelling unstable (كلير or كليير); crowded "plate" pattern [V:NS-051,NS-052,NS-053] |
| NAME-35 | PlateTrace | Arabic spelling unstable; crowded "plate" pattern |
| NAME-36 | BiteTrace | Arabic spelling unstable; "bite" sounds like "byte" [A] |
| NAME-37 | BiteWise | Arabic spelling unstable; "bite" sounds like "byte" [A] |
| NAME-38 | SourceBite | Arabic spelling unstable (سورس or صورس); long for a short brand |
| NAME-39 | PlateLens | An app with this exact name exists [V:NS-050]; "lens" suggests photo recognition (`SCP-OUT-05`) |
| NAME-40 | TrueBite | Arabic spelling unstable; "bite" sounds like "byte" [A] |
| NAME-43 | Akli | A calorie app with this name exists, also أكلي AI [V:NS-011,NS-012] |
| NAME-44 | Haba | حبة also means a pill or tablet [A] (medical-claim risk) |
| NAME-45 | Aklo | Sound-alike of Akli and Akly [V:NS-011,NS-013] |
| NAME-46 | Tabelo | Weak meaning; Arabic spelling unstable (تابيلو or تبلو) |
| NAME-47 | Kalo | Sound-alike of the meal-plan brand Calo [V:NS-017]; crowded "Cal-" pattern |
| NAME-48 | Aklify | Crowded "akl" root; Akli and Akly exist [V:NS-011,NS-013] |
| NAME-49 | AklWise | Crowded "akl" root; Arabic spelling of "wise" unstable |
| NAME-50 | Aklens | Sound-alike of Akli and Akly; "lens" suggests photo recognition |
| NAME-51 | BeitBite | Latin spelling of "Beit" unstable (Beit, Bayt, Bet); "bite" sounds like "byte" [A] |
| NAME-52 | WagbaWise | Inherits the Wagba conflict (§6.1); Arabic spelling of "wise" unstable |
| NAME-53 | TabkhaLens | Inherits the Tabkha conflict (§6.1); "lens" suggests photo recognition |

### 5.2 Shortlist (11) plus baseline

| ID | Name | Arabic | Strategy | Why kept |
|---|---|---|---|---|
| NAME-00 | NutriVision | نيوتري فيجن | Baseline (course brief) | Working name; must be compared |
| NAME-01 | Tabkha | طبخة | Plate and dish | Best "home-cooked" meaning |
| NAME-02 | Wagba | وجبة | Plate and dish | The unit users log |
| NAME-03 | Akla | أكلة | Plate and dish | Everyday Egyptian word for a dish |
| NAME-04 | Sofra | سفرة | Plate and dish | Family table image |
| NAME-09 | Hessa | حصة | Measure and balance | "Portion" is the app's core unit |
| NAME-10 | Nesba | نسبة | Measure and balance | Proportion and percentage |
| NAME-17 | Asl | أصل | Source and trust | Origin of each number |
| NAME-27 | Baladi | بلدي | Egyptian dialect | Local flavour |
| NAME-33 | TruePlate | ترو بليت | English compound | Transparency in English |
| NAME-41 | Tabkhi | طبخي | Coined word | Personal "my cooking" |
| NAME-42 | Wagbi | وجبي | Coined word | Personal "my meal" |

Four shortlisted names (`NAME-27`, `NAME-33`, `NAME-41`, `NAME-42`) failed the spelling stress test in §6.3. They are rejected under hard rule 7 and cannot be recommended. They stay in the tables because their availability checks were already run.

## 6. Checks

### 6.1 Availability matrix (stores and web)

Status values: `Taken` · `Similar exists` · `No hit found` · `Blocked` · `Not checked`. All checks were run on 2026-10-07 through a web search tool and fetched pages. The tool cannot open a store's own search box, so store checks are search-engine proxies and the results are noisy. **"No hit found" does not mean the name is free.** An empty result can also mean the search was too weak to find it.

| ID | Google Play | App Store | Web search |
|---|---|---|---|
| NAME-00 NutriVision | Not checked | **Taken**: "Nutrivision - AI Nutrition App" [V:NS-003] and "NutriVisions" [V:NS-004] | **Taken**: a research system named NUTRIVISION [V:NS-002]; a Google competition project named NutriVision, India, Flutter [V:NS-005]; a web app named NutriVision AI [V:NS-006]; a public React Native project of that name [V:NS-007] |
| NAME-01 Tabkha | **Taken**: Android listing "طبخة", Food & Drink, seen through an aggregator; Play page not opened [V:NS-019] | **Taken**: "طبخة" recipes app [V:NS-020]. Similar: TabkhaGo, Lebanese home cooking [V:NS-018] | **Taken**: D-Tabkha, a video series on Egyptian food [V:NS-021]; a 2025 cookbook titled Tabkha [V:NS-022] |
| NAME-02 Wagba | Similar exists: developer page "Wagbat" [V:NS-028] | Similar exists: Wagbat [V:NS-027], Wajbati [V:NS-029], Wajjba [V:NS-030] | **Taken**: Wagba, a Cairo ready-to-heat meal service launched January 2026 [V:NS-026]. Similar: Wajba, Bahrain [V:NS-031] |
| NAME-03 Akla | Not checked | Similar exists: Akli [V:NS-011], أكلي AI [V:NS-012], Akly [V:NS-013], اكلاتك [V:NS-014] | No hit found for the exact name in the query run |
| NAME-04 Sofra | Not checked | **Taken**: SofraM, nutrition values for menus [V:NS-032]; MySofra, home-made food ordering [V:NS-033] | **Taken**: Sofra Pro, a recipe and calorie list program [V:NS-034] |
| NAME-09 Hessa | No hit found (weak): the search returned Play developer pages for similar names only, for example HASSAH, a games publisher [V:NS-057]; the Play search box was not used | Similar exists: "hessah" (حصة), an education app by an educational-services publisher, first released September 2024, about 1k+ downloads per an aggregator [V:NS-035,NS-059]; Hassa, food ordering [V:NS-036] | No hit found for the exact name in food or nutrition (two queries) |
| NAME-10 Nesba | No hit found (weak): only developer pages for similar-looking names such as Nessty [V:NS-058]; the Play search box was not used | **Taken, unrelated category**: "Nesba – Tax & Discount", Finance [V:NS-043]. Similar: nessba, education, Kuwait [V:NS-044] | No hit found in food or nutrition (two queries) |
| NAME-17 Asl | Not checked | **Taken, unrelated category**: many sign-language apps named ASL [V:NS-040,NS-041]. Similar: a Saudi real-estate app أصل الخارطة [V:NS-042] | No hit found in food or nutrition (two queries) |
| NAME-27 Baladi | Not checked | **Taken**: "Baladi-بلدي", Egyptian ready-to-cook food [V:NS-045]; a Saudi municipal app named بلدي [V:NS-047] | Similar exists: a food-database entry for a Baladi bread brand [V:NS-048] |
| NAME-33 TruePlate | Not checked | Similar exists, near-exact: myTruePlate [V:NS-049]; AIplate, JustaPlate, Plates [V:NS-051,NS-052,NS-053] | Similar exists: myTruePlate [V:NS-049], PlateLens [V:NS-050] |
| NAME-41 Tabkhi | Not checked | Similar exists: the Tabkha family [V:NS-018,NS-020], Tabak AI [V:NS-025] | No hit found for the exact name; a surname Tabkhi appears in a code repository [V:NS-056] |
| NAME-42 Wagbi | Not checked | Similar exists: Wagbat [V:NS-027], Wajbati [V:NS-029]. Sound-alike in another category: Wag!, pet care [V:NS-054] | No hit found for the exact name; the query returned mostly Wag! pages |

### 6.2 Routes that could not be completed (all names)

| Check | Route tried | Result | Status |
|---|---|---|---|
| GitHub | Web search with `site:github.com` and the names; `github.com/NAME` cannot be fetched because the fetch tool opens only URLs that earlier searches returned | Results were unrelated repositories | Not checked. Search found no relevant account or repository, which is weak evidence only |
| Domains | A registry (RDAP) fetch for `nutrivision.com`; web searches for whois mirrors | The fetch was refused by the tool. Mirror searches returned pages for other domains, none for the names checked | Not checked. `.com`, `.app` and `.com.eg` are all open items (`NOPEN-03`) |
| Social handles | Web search only; the platforms need a login | No public profile page returned for any name | Blocked |
| Trademark (preliminary) | Searches for registry mirrors. WIPO Global Brand Database, EUIPO TMview and the USPTO tool are script-driven and were not reachable | `NAME-00` only: a third-party mirror shows a US record NUTRIVISION (registration 1697318, 1992) marked no longer active, class not confirmed [V:NS-008]. A test search for HESSA returned no matching mark in the mirrors used | `NAME-00`: Similar exists (lapsed US record, mirror only). All others: Not checked. No tool tried covers Egypt |

This is not legal advice. A mirror site is not the registry, and an empty search result is not a trademark search.

### 6.3 Language check

Each name was written in Arabic three ways as a stress test. These are the writer's attempts [A]; the team test in §9 repeats them with real people.

| ID | Egyptian reading | Three Arabic spellings | Spelling | Findings (Egyptian, MSA, English, French) |
|---|---|---|---|---|
| NAME-00 NutriVision | "nyu-tri-vi-zhen"; the "zh" sound does not exist in Egyptian Arabic, so ج is likely said "g" [A] | نيوتريفيجن / نيوتري فيجن / نوتري فيجن | Unstable | Nutrition + vision. No rude homophone found [U] |
| NAME-01 Tabkha | "tab-kha"; English readers may say "tab-ka" [A] | طبخة / طبخه / طبّخة | Stable (ة or ه only) | Used for a home-style eatery [V:NS-023] and a stew [V:NS-024] (tier B and C; regional use varies). Also the title of a 2025 cookbook of recipes from Gaza [V:NS-022], a charged association [A]. English, French: nothing found [U] |
| NAME-02 Wagba | "wag-ba" in Egyptian speech; MSA and Gulf say "wajba", so the Latin spelling varies (Wagba, Wajba) | وجبة / وجبه / وَجبة | Stable in Arabic; Latin varies | Meal. Seen as a meal-service brand [V:NS-026] and as the plural وجبات in a name [V:NS-027]. This is usage, not a dictionary check [U]. English reads "wag" first [A] |
| NAME-03 Akla | "ak-la" | أكلة / اكلة / أكله | Mostly stable (hamza, ة or ه) | Dish [U]. One vowel away from Akli and Akly [V:NS-011,NS-013]. English, French: nothing found [U] |
| NAME-04 Sofra | "sof-ra" | سفرة / سفره / سُفرة | Stable | Unvocalised سفرة can also read "safra" (a trip) in MSA [A]. Turkish-language products use the name [V:NS-032,NS-034]; its Turkish meaning [U]. English, French: nothing found [U] |
| NAME-09 Hessa | "ḥes-sa", with the throaty ح; readers who skip it still say "Hessa" [A] | حصة / حصه / حصّة | Stable; Latin varies (Hessa, Hissa, Hisa) | Portion, share [V:NS-037,NS-038]; borrowed into Swahili as "hisa" [V:NS-039]. Also a school class period: an education app uses حصة for a study session [V:NS-035]; everyday Egyptian use [U]. Also a given name [U]. No rude English or French reading found [U] |
| NAME-10 Nesba | "nes-ba" | نسبة / نسبه / نِسبة | Stable; Latin varies (Nesba, Nisba) | Ratio, percentage: one app uses it for a tax and discount rate [V:NS-043]; one source, so [U]. Shares a root with نسب ("lineage") [U]. English, French: nothing found [U] |
| NAME-17 Asl | "asl" | أصل / اصل / أصْل | Stable | Origin [U]. In English, ASL is American Sign Language and many app listings use that exact name [V:NS-040,NS-041]: a discoverability clash. Egyptians also use "asl" as a filler word [U] |
| NAME-27 Baladi | "ba-la-di" | بلدي / بلدى / بلادي | Unstable (ي or ى; بلادي is a different word, "my country") | Local, rural; an encyclopedia mirror notes a lower-class connotation [V:NS-046], one origin, so [U]. Saudi municipal app uses the name [V:NS-047] |
| NAME-33 TruePlate | Egyptians often change p to b: "tru-bleit" [A] | تروبليت / ترو بلايت / تروبلايت | Unstable | True + plate. myTruePlate exists [V:NS-049] |
| NAME-41 Tabkhi | "tab-khi" | طبخي / طبخى / طباخي | Unstable (طباخي means "my cook") | Also a surname [V:NS-056] |
| NAME-42 Wagbi | "wag-bi" | وجبي / وجبتي / وجبى | Unstable | The usual possessive of "meal" is وجبتي [A], and Wajbati exists [V:NS-029]. English reads "wag" first |

### 6.4 Checks completed per name

A check counts as completed when a page for the intended channel was reached and read for the exact name. Search-engine proxies for GitHub, domains, social handles and trademarks do not count.

| ID | Checks completed (of 7) | Channels reached |
|---|---|---|
| NAME-00 | 2 | App Store, web (a trademark mirror was read, but it is not a registry) |
| NAME-01 | 3 | Google Play (listing via aggregator), App Store, web |
| NAME-02 | 3 | Google Play (developer page), App Store, web |
| NAME-03, 04, 09, 10, 17, 27, 33, 41, 42 | 2 each | App Store, web |

No name reached 5. `NC-05` is capped at 3 for every name. The Google Play developer pages returned for Hessa and Nesba belong to other names, so they do not count as a completed Play check.

## 7. Scoring

Each name is scored 0–5 per criterion. Weighted score = Σ(score × weight) ÷ 5, which gives 0–100. Scores are team judgement [A] based on §4 to §6.

**NC-05 rules:** 5 = at least 5 of 7 checks done and no conflict found; 3 = only near-matches in unrelated categories; 1 = an exact match in food, health or fitness; 0 = an exact match with a well-known brand. **Cap at 3 if fewer than 5 checks were completed.** No name completed 5 checks (§6.4), so 5 is not possible for any name. A score of 2 is used where the only conflicts are one-letter variants in the same category (no exact match, but not unrelated either).

### 7.1 Weighted table

| Rank | ID | Name | NC-01 | NC-02 | NC-03 | NC-04 | NC-05 | NC-06 | NC-07 | Score | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | NAME-09 | Hessa | 4 | 5 | 3 | 4 | 3 | 3 | 5 | **74** | Top 3, recommended |
| 2 | NAME-10 | Nesba | 3 | 5 | 3 | 4 | 3 | 4 | 5 | **72** | Top 3, fallback |
| 3 | NAME-03 | Akla | 4 | 5 | 3 | 4 | 2 | 4 | 5 | 71 | Excluded from top 3: one vowel from the competitors Akli and Akly (hard rule 6) |
| 4 | NAME-17 | Asl | 4 | 5 | 3 | 3 | 3 | 2 | 5 | **70** | Top 3 |
| 5 | NAME-02 | Wagba | 4 | 5 | 3 | 4 | 1 | 5 | 5 | 68 | Exact conflict in Egyptian meal service |
| 6 | NAME-04 | Sofra | 4 | 5 | 4 | 4 | 1 | 3 | 5 | 67 | Exact conflicts in food apps |
| 6 | NAME-01 | Tabkha | 4 | 5 | 4 | 4 | 1 | 3 | 5 | 67 | Exact conflict on Android in Food & Drink |
| 6 | NAME-41 | Tabkhi | 4 | 5 | 3 | 3 | 2 | 3 | 5 | 67 | Rejected: unstable Arabic spelling (rule 7) |
| 9 | NAME-42 | Wagbi | 3 | 5 | 2 | 3 | 2 | 3 | 5 | 60 | Rejected: unstable Arabic spelling (rule 7) |
| 10 | NAME-27 | Baladi | 4 | 4 | 3 | 4 | 1 | 2 | 5 | 59 | Rejected: unstable Arabic spelling (rule 7) |
| 11 | NAME-33 | TruePlate | 4 | 4 | 2 | 3 | 1 | 4 | 5 | 58 | Rejected: unstable Arabic spelling (rule 7) |
| 12 | NAME-00 | NutriVision | 2 | 2 | 2 | 2 | 1 | 4 | 4 | 41 | Baseline, direct conflict |

Weights: NC-01 20, NC-02 15, NC-03 15, NC-04 10, NC-05 25, NC-06 10, NC-07 5 (total 100).

### 7.2 Notes behind the less obvious scores

| Name | Note |
|---|---|
| Hessa | NC-01 4: portion and share are the app's core unit [V:NS-037,NS-038], but the name says nothing about sources. NC-05 3: only unrelated near-matches found (§6.1); not 5 because of the cap. NC-06 3: school class period and given name [U] |
| Nesba | NC-01 3: "ratio" fits macros but not Egyptian home food. NC-05 3: an exact-name Finance app exists, in an unrelated category [V:NS-043] |
| Asl | NC-01 4: "origin" matches the source label difference. NC-04 3: in Latin letters it reads as an acronym. NC-06 2: the exact name ASL is used for American Sign Language apps [V:NS-040,NS-041], which also hurts search and store discovery |
| Akla | NC-05 2: Akli, Akly and أكلي AI sit in the same category [V:NS-011,NS-012,NS-013] |
| Wagba, Tabkha, Sofra | NC-05 1: exact-name products in food (§6.1) |
| NutriVision | NC-05 1: exact-name nutrition products on the App Store [V:NS-003,NS-004], a Google competition project [V:NS-005] and a research system [V:NS-002]. NC-02 2: four syllables. NC-03 2: unstable Arabic spelling and the "zh" sound [A] |

### 7.3 Top 3

1. **NAME-09 Hessa (حصة)**, 74
2. **NAME-10 Nesba (نسبة)**, 72
3. **NAME-17 Asl (أصل)**, 70

The gaps (74, 72, 70) are small next to the uncertainty in judgement scores, in the weights and in the capped availability checks. Treat the order as a lead, not a result. The team test (§9) and the open checks (§10) may reorder it.

### 7.4 Recommendation and fallback

**Recommendation: Hessa (حصة, "portion, share").** "Portion" is the unit the app asks the user to describe and the number it must source. The name is two syllables and five letters, and its Arabic spelling held in the stress test. On 2026-10-07 no exact-name food or nutrition product was found. What was found: an education app named "hessah" with the same Arabic spelling حصة [V:NS-035] and a food-ordering app named Hassa [V:NS-036]. **Not checked:** Google Play pages, GitHub, domains, social handles and trademark registries.

Risks to settle first:

1. Searching حصة in Arabic on a store will likely show the education app first. It looks small (about 1k+ iOS downloads per an aggregator [V:NS-059]), but its Arabic spelling is identical. Test this (`NOPEN-08`).
2. حصة also means a school class [V:NS-035], and Hessa is a given name [U]. A native speaker should say whether either reading hurts a nutrition brand.
3. The Latin spelling varies (Hessa, Hissa, Hisa). Fix one spelling in the store listing and on every screen.

**Fallback: Nesba (نسبة).** It scores 72, but its meaning ("ratio") is further from food, and an exact-name Finance app exists [V:NS-043]. Asl is third because of the ASL clash.

### 7.5 About NutriVision (`NAME-00`)

NutriVision does not rank first. It ranks last (41). The conflict is direct: products with the exact name are already in nutrition on the App Store [V:NS-003,NS-004], in a Google competition entry that is also a Flutter project [V:NS-005], and in a research system [V:NS-002]. A lapsed US trademark record exists in a mirror only [V:NS-008]. Whether the project may be renamed at all is open (`NOPEN-01`).

## 8. Top-3 kit

Taglines are at most 8 words. Play Store short descriptions are at most 80 characters (counts shown). Claims that "every number" shows its source depend on `OBJ-03` and `HYP-03` being met; do not publish them before the evaluation [A]. No accuracy or "first" claims, and nothing medical.

### 8.1 Hessa (حصة)

| Item | Text |
|---|---|
| Arabic tagline | اكتب وجبتك، وشوف مصدر كل رقم (6 words) |
| English tagline | Type your meal. See every source. (6 words) |
| Short description, English | Log meals in your own words. See where every number comes from. (63 characters) |
| Short description, Arabic | سجّل وجبتك بكلامك، وشوف مصدر كل رقم (35 characters) |
| Logo concept 1 | A round plate with one slice lifted out as a portion, and a small check mark |
| Logo concept 2 | The Arabic word حصة in a rounded script, with the loop of ص drawn as a plate rim |
| Logo concept 3 | Lowercase "hessa" where the two s letters lean together as a spoon and a fork |
| Package id | `com.team.hessa` (team to confirm it is unique) |

### 8.2 Nesba (نسبة)

| Item | Text |
|---|---|
| Arabic tagline | كل صنف بنسبته، وكل رقم بمصدره (6 words) |
| English tagline | Every item, its share, its source. (6 words) |
| Short description, English | Describe your meal. See each item's share and source. (53 characters) |
| Short description, Arabic | اوصف وجبتك، وشوف نسبة كل صنف ومصدرها (36 characters) |
| Logo concept 1 | A plate drawn as a ring with three arcs, one for each share of the meal |
| Logo concept 2 | The Arabic word نسبة where the dot of ن is a small round portion |
| Logo concept 3 | A percent sign built from two small bowls and a slash |
| Package id | `com.team.nesba` (team to confirm it is unique) |

### 8.3 Asl (أصل)

| Item | Text |
|---|---|
| Arabic tagline | اعرف أصل كل رقم في طبقك (6 words) |
| English tagline | Know where every number comes from. (6 words) |
| Short description, English | Describe your meal. See the origin of every number. (51 characters) |
| Short description, Arabic | اوصف وجبتك، واعرف أصل كل رقم (28 characters) |
| Logo concept 1 | The Arabic letter أ standing like a root that grows out of a plate |
| Logo concept 2 | A map pin shaped like a bowl, pointing back to the source |
| Logo concept 3 | A lowercase "asl" wordmark with an underline that doubles as a link |
| Package id | `com.team.asl` (team to confirm it is unique) |

## 9. Team test

A quick test with 5–8 people. Every cell is [T] until the team runs it. No results are invented here. Test the top 3 and `NAME-00`. Say each name aloud once, then ask for recall 24 hours later.

### 9.1 Participants

| Person | Age band | Phone | Dialect | Reads Arabic script |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |

### 9.2 Unprompted recall after 24 hours

| Person | Names heard | Names recalled without help | Recalled with a hint | Notes |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |

### 9.3 "Say it" and "write it in Arabic"

| Person | Name | Said it as | Arabic spelling 1 | Arabic spelling 2 | Arabic spelling 3 | Spellings agree? |
|---|---|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] | [T] | [T] |

### 9.4 First-impression words

| Person | Name | Three words | Feeling (+ / 0 / −) | Any other meaning they heard |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |

### 9.5 Vote

| Person | First choice | Second choice | Rejected name | Why |
|---|---|---|---|---|
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] | [T] |

| Name | First-choice votes | Second-choice votes | Rejections |
|---|---|---|---|
| [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] |
| [T] | [T] | [T] | [T] |

## 10. Open items

| ID | Item | Why | Who |
|---|---|---|---|
| NOPEN-01 | May the trainer or initiative allow the project to be renamed? "NutriVision" comes from the course brief | Everything below is moot if not | Supervisor |
| NOPEN-02 | Who verifies Arabic meanings? Native Egyptian speakers should confirm: Hessa (class period, given name, ح sound), Nesba, Asl, the "safra" reading of Sofra, and rude English or French homophones for all names | Most meanings are [A] or [U] | Team, native speakers |
| NOPEN-03 | Who confirms trademark and domain status before any public launch, and with which tools? Needed: WIPO Global Brand Database, EUIPO TMview, USPTO, the Egyptian registry if reachable, and registrar lookups for `.com`, `.app` and `.com.eg`. Do not register anything before this | No registry or registrar was reachable (§6.2). This is not legal advice | Supervisor or lawyer |
| NOPEN-04 | Arabic-first or bilingual brand? | Changes spelling, logo and store listing | Team |
| NOPEN-05 | Does the team already prefer a name? | The scoring may need a different shortlist | Team |
| NOPEN-06 | Search Google Play directly, in Latin and Arabic script, for the top 3 and record the date | Play pages were not reached | Tester |
| NOPEN-07 | Check GitHub, domains and social handles for the top 3 | Not checked (§6.2) | Tester |
| NOPEN-08 | Search حصة, نسبة and أصل in the Play and App Store search boxes and see what ranks first | An exact-spelling education app exists for حصة [V:NS-035]; ASL apps dominate "Asl" [V:NS-040,NS-041] | Tester |
| NOPEN-09 | Re-run the store checks for all 11 names with the real store search boxes and rescore | The tool used here was a search-engine proxy; results were noisy | Researcher |
| NOPEN-10 | Is the Gaza-cookbook association (`NAME-01`) acceptable if Tabkha is ever revisited? | A charged association [V:NS-022] | Team |
| NOPEN-11 | Supervisor review of the criteria weights | Weights are [A] | Supervisor |
| NOPEN-12 | Confirm tagline claims ("every number", "every source") after `OBJ-03` and `HYP-03` results | A public claim must be true | Team |
| NOPEN-13 | Check dates in this file come from the sandbox clock (2026-10-07). The chat's own date was 2026-10-08, so each date may be one day early. Re-date when the checks are re-run | Avoids a wrong audit trail | Researcher |

## 11. Sources

Tiers: A = official or registry page (store listing, official project page, publisher dictionary); B = news, independent review, listing aggregator or mirror; C = blog, forum or self-published page. All pages were accessed on 2026-10-07 unless noted. Some App Store links are shown in the shorter `id` form; they point to the same listing as the longer localized link the search returned.

| NS-ID | Title | URL | Tier | Used for |
|---|---|---|---|---|
| NS-001 | Team file `02-COMPETITORS.md` (uploaded; internal) | not applicable | internal | §3.1 competitor names |
| NS-002 | NUTRIVISION research paper (arXiv 2409.20508; preprint status not checked) | https://arxiv.org/abs/2409.20508v1 | A | `NAME-00` conflict |
| NS-003 | App Store: "Nutrivision - AI Nutrition App" | https://apps.apple.com/us/app/id6473848429 | A | `NAME-00` conflict |
| NS-004 | App Store (Mexico): "NutriVisions" | https://apps.apple.com/mx/app/nutrivisions/id6744881689 | A | `NAME-00` conflict |
| NS-005 | Google AI developer competition project page: NutriVision | https://ai.google.dev/competition/projects/nutrivision?hl=it | A | `NAME-00` conflict |
| NS-006 | NutriVision AI web app, about page | https://photo-nutri-sense.lovable.app/about | C | `NAME-00` conflict |
| NS-007 | Public React Native project "NutriVision AI App" | https://www.rapidnative.com/project/public/A_lK9w4MSkoy7g72fiEPp | C | `NAME-00` conflict |
| NS-008 | US trademark record mirror, NUTRIVISION (registration 1697318) | https://trademarkregistration.app/Trademark/Details/74073646 | B | `NAME-00` trademark, preliminary |
| NS-009 | BGR, best food apps to track calories | https://www.bgr.com/2246095/best-food-apps-to-track-your-calories/ | B | §3.2 |
| NS-010 | Garage Gym Reviews, best calorie counter apps | https://www.garagegymreviews.com/best-calorie-counter-apps | B | §3.2 |
| NS-011 | App Store: Akli: AI Calorie & Recipe Scan | https://apps.apple.com/app/id6749517486 | A | §3.2, §5, §6.1 |
| NS-012 | App Store: أكلي AI | https://apps.apple.com/us/app/-/id6746715867 | A | §3.2, §5, §6.1 |
| NS-013 | Akly, listing text via mwm.ai | https://mwm.ai/apps/akly/6758994088 | B | §3.2, §5, §6.1 |
| NS-014 | App Store: اكلاتك | https://apps.apple.com/us/app/-/id1508399755 | A | §3.3, §6.1 |
| NS-015 | App Store: CalApp | https://apps.apple.com/app/id6621263391 | A | §3.2 |
| NS-016 | App Store: Calz | https://apps.apple.com/app/id6738832996 | A | §3.2 |
| NS-017 | Calo, meal plans | https://calo.app/en-qa/menu?plans=20 | B | §3.2, §5 |
| NS-018 | TabkhaGo, listing text via mwm.ai | https://mwm.ai/apps/tabkhago/6749336140 | B | §6.1 |
| NS-019 | "طبخة" Android listing via AppGoblin (Food & Drink) | https://appgoblin.info/apps/com.sofra | B | §6.1 |
| NS-020 | App Store: "طبخة" recipes | https://apps.apple.com/us/app/-/id1487325513 | A | §6.1 |
| NS-021 | Scene Eats: D-Tabkha, YouTube series on Egyptian food | https://sceneeats.com/Fresh/New-YouTube-Series-D-Tabkha-Celebrates-Egyptian-Food-s-History | B | §6.1 |
| NS-022 | Il Fatto Alimentare: "Tabkha" cookbook of Palestinian recipes from Gaza | https://ilfattoalimentare.it/tabkha-libro-ricette-palestinesi-gaza.html | B | §6.1, §6.3 |
| NS-023 | Executive Magazine: La Tabkha, home-style eatery | https://www.executive-magazine.com/?p=2527 | B | §6.3 |
| NS-024 | eGullet forum thread on tbikha stews | https://forums.egullet.org/topic/65340-tbikhas | C | §6.3 |
| NS-025 | App Store: AI Calorie Tracker, Tabak AI | https://apps.apple.com/vc/app/ai-calorie-tracker-tabak-ai/id6748586049 | A | §3.2, §5, §6.1 |
| NS-026 | Scene Eats: Wagba delivers chef-crafted meals | https://sceneeats.com/InDepth/Wagba-Delivers-Chef-Crafted-Meals-Right-to-Your-House | B | §6.1 |
| NS-027 | App Store: Wagbat | https://apps.apple.com/app/id1437142224 | A | §6.1 |
| NS-028 | Google Play developer page: Wagbat | https://play.google.com/store/apps/developer?id=Wagbat | A | §6.1 |
| NS-029 | App Store (Egypt): Wajbati | https://apps.apple.com/eg/app/wajbati-%D9%88%D8%AC%D8%A8%D8%AA%D9%89/id6751298653 | A | §6.1 |
| NS-030 | App Store: Wajjba | https://apps.apple.com/us/app/id1633438792 | A | §6.1 |
| NS-031 | MENA Startup Digest: Wajba, Bahrain | https://menastartupdigest.com/?p=50532 | B | §6.1 |
| NS-032 | App Store: SofraM | https://apps.apple.com/vg/app/sofram/id1532389419 | A | §6.1, §6.3 |
| NS-033 | App Store: MySofra | https://apps.apple.com/vu/app/mysofra/id1611286425 | A | §6.1 |
| NS-034 | Tamindir: Sofra Pro recipe and calorie program | https://www.tamindir.com/indir/sofra-pro-gida-yemek-tarif-takip-programi/amp/ | B | §6.1, §6.3 |
| NS-035 | App Store (Mexico): hessah (حصة), education | https://apps.apple.com/mx/app/hessah/id6636497016 | A | §6.1, §6.3, §7 |
| NS-036 | App Store (Estonia): Hassa, food ordering | https://apps.apple.com/ee/app/hassa/id6451267395 | A | §6.1 |
| NS-037 | Lane's Lexicon, entry حِصَّة (digitised dictionary) | https://www.laneslexicon.com/word/حصة | A | `NAME-09` meaning |
| NS-038 | Arabic lexicon (Hawramani), root حص | https://arabiclexicon.hawramani.com/%d8%ad%d8%b5/?book=50 | A | `NAME-09` meaning |
| NS-039 | Wiktionary: Swahili "hisa", from Arabic | https://www.wiktionary.com/wiki/hisa | B | `NAME-09` borrowing |
| NS-040 | App Store (Korea): ASL | https://apps.apple.com/kr/app/asl/id6475023042 | A | §6.1, `NAME-17` clash |
| NS-041 | App Store (UAE): ASL sign language learning | https://apps.apple.com/ae/app/asl-sign-language-learn-asl/id1669239956 | A | §6.1, `NAME-17` clash |
| NS-042 | App Store (Saudi Arabia): Assl Alkharita (أصل الخارطة) | https://apps.apple.com/sa/app/assl-alkharita-%D8%A3%D8%B5%D9%84-%D8%A7%D9%84%D8%AE%D8%A7%D8%B1%D8%B7%D8%A9/id6746053231 | A | §6.1 |
| NS-043 | "Nesba – Tax & Discount" listing via AppGoblin | https://www.appgoblin.info/apps/6756324043 | B | §6.1, §6.3 |
| NS-044 | App Store: nessba | https://apps.apple.com/ml/app/nessba/id6749504445 | A | §6.1 |
| NS-045 | App Store: Baladi-بلدي | https://apps.apple.com/us/app/id1617131679 | A | §6.1 |
| NS-046 | Encyclopedia mirror: "Baladi" | https://encycloreader.org/r/wikipedia.php?q=Baladi | B | §6.3 |
| NS-047 | App Store: بلدي (Saudi municipal services) | https://apple.co/3fGFTUx | A | §6.1, §6.3 |
| NS-048 | MyNetDiary: Egyptian whole wheat bread by Baladi | https://www.mynetdiary.com/food/calories-in-egyptian-wholewheat-bread-by-baladi-lb-24242830-0.html | B | §6.1 |
| NS-049 | myTruePlate, listing via Mergeek | https://mergeek.com/latest/aBgrLW6LYYlnj0J3 | B | §3.2, §6.1 |
| NS-050 | PlateLens, company profile via Indexator | https://dev.indexator.ai/companies/platelens | B | §3.2, §5, §6.1 |
| NS-051 | App Store: AIplate | https://apps.apple.com/us/app/-/id6745076417 | A | §3.2, §6.1 |
| NS-052 | App Store: JustaPlate | https://apps.apple.com/app/id6443679685 | A | §3.2, §6.1 |
| NS-053 | App Store: Plates - AI Calorie Tracker | https://apps.apple.com/app/id6756692818 | A | §3.2, §6.1 |
| NS-054 | App Store: Wag! Dog Walkers & Sitters | https://apps.apple.com/us/app/-/id940734609 | A | §6.1 (sound-alike, other category) |
| NS-055 | Nutri Macro calorie tracker, listing via mwm.ai | https://mwm.ai/fr/apps/nutri-macro-calorie-tracker/6766690086 | B | §3.3 |
| NS-056 | GitHub repository PishguVe (author surname Tabkhi) | https://github.com/TeCSAR-UNCC/PishguVe | C | §6.1, §6.3 |
| NS-057 | Google Play developer page: HASSAH | https://play.google.com/store/apps/developer?id=HASSAH | A | §6.1 |
| NS-058 | Google Play developer page: Nessty | https://play.google.com/store/apps/developer?id=Nessty | A | §6.1 |
| NS-059 | hessah (حصة), store-intelligence page via mwm.ai (publisher, release date, downloads) | https://mwm.ai/apps/hessah/6612034008 | B | §6.1, §7.4 |

## 12. Decision

`DEC-01`, recorded on 2026-10-09. The research above was not changed.

| Field | Content |
|---|---|
| Decision | Project name: **Nesba (نسبة)** |
| Decided by | [T: who decided and how] |
| Earlier interim choice | The team had settled on Bel Hana (بالهنا). It was `NAME-32`, dropped at the quick filter in §5.1 and never checked. The team then agreed on Nesba [T: confirm the order of events] |
| Research result | Rank 2 of 12 with 72/100: Hessa 74, Asl 70, baseline NutriVision 41 (§7.1). The research called Nesba the fallback (§7.4) and said the order is a lead, not a result (§7.3) |
| Known facts | Meaning "ratio, percentage"; one source, so [U] (§6.3). An exact-name Finance app, "Nesba – Tax & Discount", exists [V:NS-043]; a similar name, nessba (education, Kuwait), exists [V:NS-044]. Arabic spelling stable (نسبة / نسبه / نِسبة); Latin varies (Nesba, Nisba) (§6.3). `NC-01` scored 3: "ratio" fits macros but not Egyptian home food (§7.2). `NC-05` is capped at 3: no name completed 5 of 7 checks (§6.4) |
| Rationale | [T: the team's reasons]. Reasons the team may give [A]: short and easy to say; stable Arabic spelling; "share" fits the idea of each item's share and source; works on screen as a label |
| Accepted risks | Exact-name Finance app on the stores; meaning further from food than a name like Hessa; Latin spelling variants; trademark, domain and handle checks not done |
| Canonical spellings | Latin: **Nesba**. Arabic: **نسبة**. [A] The team confirms in `OPEN-53` |
| Brand kit | §8.2 (taglines, short descriptions, logo ideas, package id). Do not publish the "every number shows its source" claim before the evaluation (see §8 intro) |
| Revisit triggers | A complaint or takedown notice; a conflicting trademark for software or nutrition services in Egypt; a store listing rejected for similarity; the team plans to commercialise; the trainer does not approve the rename |
| Confirmed by | [T: trainer name, date] |
| Next checks | `OPEN-52` to `OPEN-56` in `C-OPEN-ITEMS.md`. Assumption `ASM-38` |
