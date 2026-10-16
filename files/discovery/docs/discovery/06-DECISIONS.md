---
id: DISC-01-06
title: Nesba Discovery, Section 6 (platform and technology decisions)
parent: DISC-01
status: draft
last_verified: 2026-10-10
owner: TBD
---

> **AI NOTES**
> - What this is: the architecture decision log for Nesba (نسبة; course-brief title NutriVision). 30 decisions (`ADR-01` to `ADR-30`) and a dependency register (`DEP-01` onward). Hub: [DISCOVERY.md](DISCOVERY.md). Read [AI_CONTEXT.md](AI_CONTEXT.md) first.
> - Every decision is `Proposed`. Only the team sets `Accepted`; approval cells are [T]. Decisions marked "Needs team input" carry a default and the criteria.
> - Stack in one line: Flutter 3.47.x (Dart 3.13) + `material_ui` + Bloc (`flutter_bloc`; chosen by the project author on 2026-10-10, ADR-06) + go_router + Firebase (Auth, Firestore offline, App Check, AI Logic, Remote Config) + Dio for Open Food Facts + bundled local reference data + GitHub Actions.
> - Volatile facts (Flutter and Android levels, FlutterFire versions, Gemini model lifecycle, package versions) were read on 2026-10-09 and are listed with re-check dates in §8.
> - `FR-`, `NFR-`, `DAT-` and `INT-` IDs are defined in `05-REQUIREMENTS.md`; section 11 maps each decision to them and records the coverage check (`OPEN-67` closed on 2026-10-10). Drivers in the ADR tables still use `OBJ-`, `CON-`, `SCP-`, `RSK-`, `TD-` and course-brief items.
> - Tags: [V:S-xxx] a cited source states it (for vendor pages, it is the vendor's claim); [A:ASM-xx] assumption; [U] unverified; [T] for the team. Treat [U] and [T] as unknown, never as facts.

# 6. Platform and technology decisions

## 1 Decision summary

| ADR | Decision | Status | Main reason | Validation | Needs team input? |
|---|---|---|---|---|---|
| ADR-01 | Android is the only target for now; iOS deferred | Proposed | Brief and `CON-04`; Android is 83.4% of Egyptian mobile web traffic (Sept 2026) | GT-01 to GT-05 on Android devices | No |
| ADR-02 | `compileSdk` and `targetSdk` follow Flutter's variables (API 36); `minSdk` API 24 | Proposed | Google Play requires API 36 for new apps and updates since 2026-08-31 | Build and run on the lowest team device | **Yes** (`OPEN-27`) |
| ADR-03 | Pin Flutter 3.47.x (Dart 3.13), Java 17, and the Gradle, AGP and Kotlin versions of the Flutter template | Proposed | Reproducible builds; packages need Flutter 3.44 or 3.47 | CI uses the same pin | No |
| ADR-04 | Use the standalone `material_ui` package from day one | Proposed | Core Material is scheduled for deprecation in the November stable release | `dart fix` clean; widget tests | No |
| ADR-05 | Feature-first folders; Dart-only domain layer | Proposed | `OBJ-06` coverage; five people work in parallel | Coverage of `domain/` at least 80% | No |
| ADR-06 | Bloc (`flutter_bloc`) for state, Cubit where simple (changes TD-04) | Proposed | Explicit events and states for multi-step flows; the project author's choice | KC-04 onboarding check | Confirm at approval |
| ADR-07 | `go_router` for navigation | Proposed | Redirect-based auth guard; deep links | Widget tests for redirects | No |
| ADR-08 | Hand-written immutable models; no code generation | Proposed | Fewer moving parts; LLM output needs explicit validation anyway | Fixture-based unit tests | No |
| ADR-09 | Sealed `Result` and typed `AppFailure` at layer boundaries | Proposed | No raw exceptions reach the UI | Mapping unit tests | No |
| ADR-10 | gen-l10n ARB files; Arabic default; right-to-left | Proposed | `SCP-IN-02`; Arabic-first personas | RTL and large-font widget tests | No |
| ADR-11 | Firestore offline persistence; write and forget (TD-03) | Proposed | Meets the brief with least code | SPK-04, GT-01 | No |
| ADR-12 | Per-entry documents; owner-only rules; emulator rules tests | Proposed | `OBJ-05`; `RSK-16` | At least 10 rules tests in CI | No |
| ADR-13 | Bundled JSON loaded into memory; `drift` only on a size trigger | Proposed | Avoids a database dependency for 100–200 dishes plus a USDA subset | SPK-06 size and startup | No |
| ADR-14 | `flutter_secure_storage` for the consent record and restriction profile | Proposed | Brief: Keystore; `OBJ-08` | Unit tests; device check | No |
| ADR-15 | Firebase Authentication with email and password only | Proposed | Least personal data; no paid SMS path | Rules and account-switch tests | **Yes** |
| ADR-16 | `firebase_ai` with App Check; no key in the app (TD-02) | Proposed | `RSK-11`; official App Check path for Flutter | SPK-05 | No |
| ADR-17 | Model id in Remote Config with allow-list and fallback chain | Proposed | `RSK-05`: a model can be retired | Fallback unit test; SPK-01 | No |
| ADR-18 | Schema-constrained JSON parse, validated in Dart; no totals from the model | Proposed | `RSK-07`; every number shows its source | SPK-01 thresholds | No |
| ADR-19 | Resolve order: dish table, USDA subset, Open Food Facts, `AI_ESTIMATE` (TD-01) | Proposed | Per-item source; no quota; licence safe | SPK-02, KC-01 | No |
| ADR-20 | `mobile_scanner` with `permission_handler`, requested at point of use | Proposed (conditional) | Barcode is "maybe later"; the brief needs a runtime permission | Denied-path widget tests | No (`OPEN-60`) |
| ADR-21 | Dio with a fixed interceptor chain (TD-04) | Proposed | Brief; Open Food Facts needs a User-Agent and limits | Mock-adapter tests | No |
| ADR-22 | No secrets in the app; obfuscated release; secret scanning | Proposed | `RSK-11` | SPK-05 decompile check | No |
| ADR-23 | OSV scan, `THIRD_PARTY_NOTICES`, in-app licence page | Proposed | TD-05; ODbL and CC0 obligations | CI presence check | No |
| ADR-24 | No analytics; crash reporting off by default | Proposed | `OBJ-08`; `RSK-01` | Settings test; GT-04 | **Yes** |
| ADR-25 | `flutter_test`, `integration_test`, `mocktail`; coverage gate | Proposed | Brief; `OBJ-06` | CI | No |
| ADR-26 | `flutter_lints` plus strict analysis and format check | Proposed | `OBJ-07` | CI | No |
| ADR-27 | GitHub Actions on every pull request | Proposed | `OBJ-07`; zero budget | Green `main` | No |
| ADR-28 | Protected `main`, reviewed pull requests, ADR upkeep | Proposed | `OBJ-07` | Repository settings | No |
| ADR-29 | App Bundle for release, APK for testers; fix the application id before any upload | Proposed | An id cannot change after publishing | Build in CI | **Yes** |
| ADR-30 | `GridView` and `Stack` with custom-painted charts; `fl_chart` optional | Proposed | Brief names GridView and Stack | Widget tests; SPK-06 | No |

## 2 Decision drivers

| Driver | Statement | Shapes |
|---|---|---|
| CON-01 | Budget is zero; free tiers only | ADR-15, ADR-16, ADR-24, ADR-27 |
| CON-03 | Team of five students | ADR-05, ADR-06, ADR-08, ADR-28 |
| CON-04 | Android first | ADR-01, ADR-02 |
| CON-06 | Health data is sensitive; cross-border transfer needs authorisation | ADR-15, ADR-16, ADR-24 |
| CON-07 | Course brief (below) | All |
| OBJ-01 | Analysis p90 at most 8 s | ADR-16, ADR-17, ADR-21 |
| OBJ-05 | Cross-user rules tests pass | ADR-12 |
| OBJ-06 | At least 80% coverage of the calculation layer | ADR-05, ADR-25 |
| OBJ-07 | Every merge through a reviewed pull request | ADR-26, ADR-27, ADR-28 |
| OBJ-08 | Arabic privacy notice, consent, delete-account path | ADR-14, ADR-15, ADR-24 |
| RSK-05 | Quota cut, price rise or model retired | ADR-17 |
| RSK-11 | Key in the APK leaks | ADR-16, ADR-22 |
| RSK-24 | SDK or API breaking changes | ADR-03, ADR-04 |

**Course-brief coverage.** Each mandatory brief item maps to at least one decision.

| Brief item | ADR |
|---|---|
| Flutter UI | ADR-03, ADR-04, ADR-05 |
| Dio with interceptors for external nutrition APIs, handled securely | ADR-21, ADR-22 |
| Cloud Firestore sync across devices | ADR-11, ADR-12 |
| GridView and Stack for history and charts | ADR-30 |
| Unit and widget tests | ADR-25 |
| Git and GitHub with branches and pull requests | ADR-27, ADR-28 |
| Technical documentation and README | ADR-28 |
| Android Keystore | ADR-14 |
| Runtime permissions | ADR-20 (conditional; `OPEN-60`) |

**Feasibility work packages.** `TD-01` is covered by ADR-19 and ADR-13; `TD-02` by ADR-16, ADR-17 and ADR-18; `TD-03` by ADR-11; `TD-04` by ADR-06, ADR-12, ADR-14, ADR-21 and ADR-25; `TD-05` by ADR-23 and ADR-24. `TD-06` (cost and schedule) is not a technology decision. It stays in `04-FEASIBILITY.md` and is merged here only through ADR-27 and ADR-28, which apply its zero-budget rules. Two decisions differ from a `TD-` text: ADR-14 stores the consent record and restriction profile instead of tokens (see ADR-14), and ADR-06 uses Bloc instead of Riverpod at the project author's request.

## 3 Decisions

### Platform

### ADR-01 Android first and only; iOS deferred

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief names Flutter and Android security basics. Android carried 83.4% of Egyptian mobile web traffic in Sept 2026 [V:S-005]. The team has no budget and iOS device access is unknown [A:ASM-35]. |
| Decision | We will build and test Android only. Dart code stays platform-neutral outside the data layer, but no iOS build runs in CI. |
| Drivers | SCP-OUT-01, CON-04, CON-01, brief (Android security basics) |
| Reason | Every extra platform multiplies test devices and signing work for five students. An iOS build also needs Apple hardware and signing, which adds upkeep with no brief requirement [A:ASM-35]. |
| Consequences | Good: smaller test matrix. Bad: iPhone users are excluded; `DR-03` may reopen this. |
| Validation | `GT-01` to `GT-05` on Android devices. |
| Revisit when | `DR-03` fires (most respondents use iPhone) or the team gains Apple hardware and a trainer-approved scope change. |
| Links | SCP-OUT-01, CON-04, DR-03, ASM-01, ASM-35, S-005 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Android and iOS from the start | Wider reach | Needs Apple hardware and signing [A:ASM-35] | No budget or requirement |
| Web or installable web app | No store | No Keystore or runtime permissions; brief is Android | Fails the brief |

### ADR-02 Android API levels

| Field | Content |
|---|---|
| Status | Proposed. **Needs team input** (`OPEN-27`) |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Google Play requires new apps and updates to target Android 16 (API 36) since 2026-08-31 [V:S-099,S-100]. Flutter 3.47 sets `flutter.compileSdkVersion` and `flutter.targetSdkVersion` to API 36 and `flutter.minSdkVersion` to API 24 [V:S-096]. |
| Decision | We will use Flutter's three variables in the Gradle files and not hard-code API numbers. Default minimum is API 24 (Android 7.0). |
| Drivers | CON-04, RSK-24, brief (Android security basics) |
| Reason | Following the SDK variables keeps the target at the Play requirement through upgrades. API 24 is the Flutter default, so the team adds no extra compatibility burden. |
| Consequences | Good: Play-ready target. Bad: phones older than Android 7.0 are excluded. Plugin minimums (Firebase Android SDK, scanner, secure storage) were not read (`OPEN-62`). |
| Validation | Run the app on the lowest-API team device; CI builds with the default variables. |
| Revisit when | A team device runs below API 24, or a plugin raises its minimum above 24. |
| Links | CON-04, OPEN-27, OPEN-62, ASM-41, S-096, S-099, S-100 |

**Default recommendation and criteria.** Keep API 24 unless the lowest device the team or testers own is older. Decide with the list of devices (`ASM-35`) and the testers' phones.

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Minimum API 26 or 28 | Newer platform APIs | Excludes more testers; no evidence of need | No driver |
| Minimum below 24 | Wider reach | Below Flutter's default; plugin support unknown (`OPEN-62`) | Unproven |
| Hard-coded target 35 | Works today | Below the Play requirement for any new upload [V:S-099] | Fails Play rule |

### ADR-03 Flutter, Dart and toolchain policy

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Flutter 3.47 was announced on 2026-08-12 [V:S-096]; the newest 3.47 patch tag seen was 3.47.7 on 2026-09-30 [V:S-098]. A 3.49 pre-release tag also exists [V:S-098]. Flutter 3.47 is verified with Java 17, Kotlin Gradle plugin 2.4.0, Android Gradle plugin 9.1.0 and Gradle 9.3.1 [V:S-096]. `go_router` needs Flutter 3.44 or newer, and `material_ui` needs 3.47 or newer (main-branch pubspecs) [V:S-104]. |
| Decision | We will pin the 3.47 stable line (Dart 3.13) in `pubspec.yaml`, in CI and in the README, and keep the Gradle, AGP and Kotlin versions that the Flutter template generates. Upgrades happen only between milestones, after reading the release notes. |
| Drivers | CON-03, OBJ-07, RSK-24 |
| Reason | Five machines on different Flutter versions give different results. The ecosystem moved fast: the standalone Material packages arrived in 3.47 and the core libraries are slated for formal deprecation in the November stable [V:S-096]. |
| Consequences | Good: same build everywhere. Bad: upgrade work is deliberate, not automatic. |
| Validation | `flutter --version` check in CI; clean `flutter doctor` on every machine. |
| Revisit when | The November stable release ships, a plugin requires a newer Flutter, or a security fix needs it. |
| Links | RSK-24, ASM-39, S-096, S-098, S-104 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Track `stable` on every machine | Always current | Machines drift; surprises mid-project | Breaks reproducibility |
| Older 3.41 line | More mature | Newer packages need 3.44 or 3.47 [V:S-104] | Locks out current versions |
| Beta or pre-release channel | Early features | Unstable; 3.49 only pre-release [V:S-098] | Risk without benefit |

### ADR-04 Standalone `material_ui`

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Flutter 3.47 published `material_ui` and `cupertino_ui` 1.0 as standalone packages. The core libraries still ship in this release and are scheduled for formal deprecation in the November stable release [V:S-096,S-097]. The migration guide offers `dart fix --apply --code=migrate_design_widgets` for imports [V:S-097]. Other ecosystem packages are moving too: Riverpod's main branch already depends on `material_ui` [V:S-105]. |
| Decision | We will build on `package:material_ui/material_ui.dart` from the first commit and take localisation delegates from it. `cupertino_ui` arrives only as a dependency. |
| Drivers | RSK-24, CON-03 |
| Reason | Starting on the old imports means a forced migration during the project. Ecosystem packages are already moving. |
| Consequences | Good: no later migration. Bad: tutorials still show `package:flutter/material.dart`; the packages release weekly and are at version 1.x [V:S-096,S-104]. A package still on the old imports may need the compatibility bridge described in the migration guide [V:S-097]. |
| Validation | `dart fix` reports nothing; a CI grep forbids `package:flutter/material.dart`; widget tests pass. |
| Revisit when | A required package cannot work with the bridge, or `material_ui` ships a breaking 2.0 during the project. |
| Links | RSK-24, ASM-39, S-096, S-097, S-104 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Keep `package:flutter/material.dart` | Matches current tutorials | Core libraries slated for deprecation in November [V:S-096] | Postpones a forced migration |
| Mix both with the compatibility bridge | Gradual | Types from the two libraries are not interchangeable [V:S-097] | Extra complexity |
| Custom design system | Full control | Large effort for five students | Over budget |

### App structure

### ADR-05 Architecture and folder layout

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Five students work in parallel. `OBJ-06` needs at least 80% line coverage of the calculation layer. |
| Decision | We will use feature-first folders (`lib/features/<feature>/presentation`, `domain`, `data`) and a `lib/core/` for networking, errors, theme and localisation. Blocs and Cubits live in each feature's `presentation` folder (ADR-06). The `domain` code (parsing validators, units, nutrient maths, restriction checks) imports no Flutter and no Firebase. Repositories are interfaces in `domain`, implemented in `data`. |
| Drivers | OBJ-06, CON-03, brief (unit and widget tests, documentation) |
| Reason | Feature folders reduce merge conflicts between people; a pure `domain` makes the coverage target measurable and the maths testable without a device. |
| Consequences | Good: parallel work; fast tests. Bad: some mapping boilerplate between layers. |
| Validation | Coverage report for `lib/**/domain/**` at least 80%; a CI check fails if `domain` imports `package:flutter` or `firebase_*` [A]. |
| Revisit when | A retrospective at `GT-03` shows the layout slows reviews. |
| Links | OBJ-06, TD-04, ASM-43 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Layer-first folders | Simple to explain | A feature is spread over many folders | Harder for parallel work |
| Logic inside widgets and `setState` | Fastest start | Cannot be unit tested; fails `OBJ-06` | Fails the target |
| Strict clean architecture with a use-case class per call | Very explicit | Heavy boilerplate for the time available | Cost over benefit |

### ADR-06 State management

| Field | Content |
|---|---|
| Status | Proposed. Changed from Riverpod to Bloc on 2026-10-10 at the project author's request; the team confirms at approval |
| Date | Proposed 2026-10-09; changed 2026-10-10; accepted [T] |
| Context | `04-FEASIBILITY.md` (TD-04) scored Riverpod 86, Bloc 76, Provider 70 on testability, boilerplate, fit with stream data and ecosystem, with [A:ASM-30] scores and no external sources, and proposed Riverpod. The project author asked for Bloc instead. `flutter_bloc` 9.1.1 depends on `bloc` ^9.0.0 and `provider` ^6.0.0, and `bloc_test` 10.0.0 depends on `bloc` ^9.1.0 (main-branch pubspecs, where `bloc` is 9.2.1) [V:S-107]. The Bloc FAQ says to emit a new state instance each time, that a state equal to the previous one is ignored when states use value equality, that `emit.forEach` can react to real-time updates, and that one state class with a status field suits screens that must keep data after an error [V:S-116]. |
| Decision | We will use `flutter_bloc` (with `bloc` 9.x) without code generation: a Cubit for simple screens (settings, history, consent) and a Bloc with events for flows with several steps (meal analysis, sign-in). One Bloc or Cubit per feature sits in `presentation/` and uses repository interfaces from `domain/` (ADR-05). Repository streams, including Firestore snapshots, are consumed inside the Bloc with `emit.forEach`. States are immutable, have value equality (ADR-08) and are always new instances; a screen that must keep its data after an error uses one state class with a status field [V:S-116]. |
| Drivers | OBJ-06, CON-03, brief (unit and widget tests), the project author's choice |
| Reason | Explicit events and states match the multi-step analysis flow (parse, validate, retry, review, save) and read clearly in tests, where each Bloc runs against fake repositories. The author chose it, which lowers the onboarding risk behind `KC-04`. The cost is real: TD-04 scored Bloc lower on boilerplate (2 against 3) and on fit with stream data (4 against 5) [A:ASM-30]. |
| Consequences | Good: one explicit pattern; testable with `bloc_test` (ADR-25); no code generation. Bad: more boilerplate than Riverpod; equality must be written by hand or with `equatable` (DEP-42), because Bloc ignores a state equal to the previous one; `flutter_bloc` brings `provider` as a transitive dependency [V:S-107]. Published constraints should be confirmed (`OPEN-58`). |
| Validation | Each member builds and tests one small Cubit and one Bloc in the first week (`KC-04`); `bloc_test` cases for the analysis flow; widget tests with fake repositories. |
| Revisit when | `KC-04` fires: two or more members cannot build and test a feature in one week. Then use Cubit only, or return to Riverpod (the TD-04 runner-up). |
| Links | TD-04, KC-04, ASM-30, S-105, S-107, S-116 |

**Decision source and criteria.** Bloc was requested by the project author on 2026-10-10 and the team confirms it at approval. Change it only if `KC-04` fires.

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Riverpod (`flutter_riverpod` 3.4.3) | Highest TD-04 score (86); overridable providers; composes with snapshot streams | Dart ^3.12.0 on the main branch, which also adds a `material_ui` dependency [V:S-105]; less explicit event trail | Not chosen: the project author prefers Bloc; runner-up |
| Cubit only, no events | Less boilerplate | Loses the explicit events of multi-step flows | Allowed per screen; this ADR uses Cubit where a screen is simple |
| Provider | Simplest | Weaker for async streams (TD-04 score); already a dependency of `flutter_bloc` | Lower fit as the main pattern |
| `setState` or `ValueNotifier` only | No dependency | Does not scale; hard to test | Fails `OBJ-06` |

### ADR-07 Navigation

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The app needs sign-in redirects, a history screen and deep links to meal entries. `go_router` 18.0.2 is maintained in the Flutter packages repository and requires Flutter 3.44 or newer [V:S-104]. |
| Decision | We will use `go_router` with string paths and one redirect function driven by the auth and consent state held in Blocs (ADR-06). |
| Drivers | OBJ-08, CON-03 |
| Reason | One place decides who may see which screen, which supports the consent-first flow. It is a first-party package. |
| Consequences | Good: central guard. Bad: major versions change APIs; pin and read the changelog. |
| Validation | Widget tests: signed-out user is redirected; no consent means no analysis screen. |
| Revisit when | A major version breaks the redirect API, or the route count stays under five and the guard is trivial. |
| Links | OBJ-08, S-104 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Plain `Navigator` push and pop | No dependency | Guards and deep links done by hand | More code |
| `auto_route` | Typed routes | Code generation (ADR-08) | Adds `build_runner` |

### ADR-08 Models and serialisation

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | About ten model types are expected [A:ASM-43]. The LLM output must be validated field by field (ADR-18). `freezed` 4.0.2 needs Dart 3.13 or newer and analyzer 14 (main-branch pubspec) [V:S-113]. |
| Decision | We will write immutable classes by hand (`final` fields, `copyWith` where needed), use sealed classes for variants, and write `fromJson` and `toJson` with explicit validation. Classes used as Bloc states also get explicit `==` and `hashCode` (`equatable` is a candidate, DEP-42). No `build_runner` in the MVP. |
| Drivers | CON-03, RSK-07, RSK-24 |
| Reason | The parse step needs custom validation that generators do not give. Skipping code generation keeps CI faster and avoids tying the project to analyzer versions. |
| Consequences | Good: fewer tools. Bad: more typing; mistakes are possible in copyWith and equality, and Bloc ignores a state equal to the previous one, so equality must be right (ADR-06). |
| Validation | Unit tests with JSON fixtures from SPK-01, round-trip tests for every model. |
| Revisit when | More than 25 model types, or three or more serialisation bugs reach a pull request. |
| Links | ASM-43, RSK-07, S-113 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `freezed` with `json_serializable` | Less boilerplate | Code generation; `freezed` 4 needs Dart 3.13 and analyzer 14 [V:S-113] | Tooling coupling |
| `json_serializable` only | Generated JSON | Still needs `build_runner` | Same cost |

### ADR-09 Error handling and result types

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Failures come from Dio, Firebase, App Check, quota limits and offline use. The UI must show an Arabic or English message, never a stack trace. |
| Decision | We will return a sealed `Result` (success or `AppFailure`) from repositories and use Dart pattern matching in the UI. `AppFailure` has typed cases: network, rate limit, auth, app check, validation, offline, unknown. Interceptors and Firebase wrappers map exceptions once. |
| Drivers | OBJ-06, RSK-12, TD-04 |
| Reason | One mapping table is unit-testable and keeps messages consistent. Dart's own sealed classes avoid a functional-programming package. |
| Consequences | Good: predictable UI states. Bad: every repository call must return `Result`. |
| Validation | Unit tests for each mapping; widget tests for the failure states. |
| Revisit when | The team finds the pattern too heavy after the first two features. |
| Links | TD-04, RSK-12 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Throw and catch everywhere | Least code | Failures leak to the UI; hard to test | Fragile |
| `fpdart` or `dartz` | Rich types | Extra dependency and learning curve | Not needed |

### ADR-10 Localisation and right-to-left

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Users type and read Arabic or English (`SCP-IN-02`). The migration guide says the Material and Cupertino localisation delegates moved with the standalone packages [V:S-097]. `intl` 0.20.3 is current [V:S-111]. |
| Decision | We will use Flutter's generated localisation (ARB files and `intl`), Arabic as the default, English as the second language, and the delegates from `material_ui`. Digit and diacritic normalisation (`TD-02` step 0) runs in the domain layer, not in the UI. |
| Drivers | SCP-IN-02, PER-03, OBJ-08 |
| Reason | Compile-time checked strings and built-in right-to-left support need no extra runtime package. |
| Consequences | Good: standard tooling. Bad: two ARB files to keep in step; the privacy notice must be in Arabic (CON-06). |
| Validation | Widget tests in right-to-left layout and at 200% font scale; unit tests for normalisation. |
| Revisit when | A third language is requested. |
| Links | SCP-IN-02, PER-03, CON-06, S-097, S-111 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `easy_localization` | Runtime JSON files | Extra dependency; weaker compile-time checks (not assessed [U]) | Not needed |
| Hand-written string maps | No tooling | Easy to miss keys; no plural support | Error-prone |

### Data and sync

### ADR-11 Firestore sync with offline persistence

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-03` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Official docs say persistence is on by default on Android with a 100 MB default cache; listeners receive local events while offline; writes queue; transactions fail offline [V:S-071,S-072]. `cloud_firestore` 6.10.0 fixes timed-out transaction handling on Android [V:S-094,S-095]. |
| Decision | We will use Firestore offline persistence and snapshot listeners. Writes are write-and-forget (no `await` in the UI path, wrapped in `unawaited` where needed). The UI reads `hasPendingWrites` and `fromCache`. No transactions for the meal log. Cache size is set explicitly. |
| Drivers | Brief (Firestore sync), OBJ-01, RSK-12, RSK-17 |
| Reason | It meets the brief with the least code (TD-03 score 82 against 58 and 50). |
| Consequences | Good: little sync code. Bad: offline edge cases need proof; an awaited offline write completes only on server acknowledgement [U] (SPK-04). |
| Validation | SPK-04 and `GT-01`; lint rule `unawaited_futures` (ADR-26). |
| Revisit when | `KC-03` fires. |
| Links | TD-03, KC-03, SPK-04, GT-01, RSK-12, RSK-17, S-071, S-072, S-094, S-095 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Local database plus custom sync (`OPT-31`) | Full control | About 10–15 person-days [A]; the team writes queue and conflicts | Only on `KC-03` |
| Third-party sync packages (`OPT-32`) | Less code | Young packages; maturity unknown [V:S-086] | Unproven |
| Turn persistence off and require a connection | Simplest | Meal logging fails offline, which is the main use case [A:ASM-37] | Hurts the core flow |

### ADR-12 Firestore data model, rules and rules tests

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Meal text and restriction tags are sensitive-adjacent (`CON-06`). `OBJ-05` needs cross-user tests. `@firebase/rules-unit-testing` 6.0.0 requires Node 24.12 or newer; `firebase-tools` 15.33.0 requires Node 20 or newer [V:S-114]. |
| Decision | We will use `users/{uid}` (profile: restriction tags, consent version) and `users/{uid}/meals/{mealId}` (one document per entry, client-generated id, items with `source_id`, `source_type`, grams, per-100 g values, flag, computed totals). Rules deny by default, allow only the owner, and check field names, types and sizes. Rules are tested in the Firebase emulator in CI. |
| Drivers | OBJ-05, OBJ-08, RSK-16, RSK-17, CON-06 |
| Reason | Per-entry documents avoid lost increments (RSK-17). Owner-only rules plus emulator tests prove the cross-user claim instead of assuming it. |
| Consequences | Good: tested security. Bad: CI needs Node 24.12 or newer (`ASM-39`); the emulator step adds minutes. |
| Validation | At least 10 cases (other user, no auth, bad schema, oversized document, delete) pass in CI (`OBJ-05`); SPK-05. |
| Revisit when | Rules tests take over 5 minutes [A], or Node 24 is not available on CI. |
| Links | OBJ-05, RSK-16, RSK-17, SPK-05, ASM-33, ASM-39, S-114 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Console clicks only | No setup | Not repeatable; no proof | Fails `OBJ-05` |
| Open test-mode rules | Fastest | Data exposure | Unsafe |
| Mock Firestore package in unit tests | Fast | Does not run the real rules engine [A] | Cannot test rules |

### ADR-13 Local reference-data store

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The team table has 100–200 dishes (`OBJ-03`) and the bundled USDA subset is CC0 [V:S-082]. Size and startup cost are unmeasured. `drift` 2.35.2 is MIT and needs Dart 3.10 or newer [V:S-110]. |
| Decision | We will ship the data as JSON assets generated by scripts under `tool/` from reviewed CSV files. Each row has `source_id`, licence and `data_version`. The app loads it once into in-memory alias indexes. |
| Drivers | OBJ-03, OBJ-01, CON-03, RSK-19, TD-01 |
| Reason | No database dependency, no code generation, and offline by design. |
| Consequences | Good: simple and testable. Bad: memory use grows with the data; no SQL search. |
| Validation | SPK-06 measures bundled size and cold parse time on the low-RAM device. |
| Revisit when | Bundled data exceeds about 10 MB or cold parse exceeds about 500 ms on the low-RAM device [A:ASM-40]. Then move to `drift` (SQLite). |
| Links | TD-01, OBJ-03, ASM-40, SPK-06, S-082, S-110 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `drift` (SQLite) now | SQL queries; scales | Needs `build_runner`; native library | Escalation only |
| `sqflite`, Isar, Hive or ObjectBox | Embedded stores | Not assessed [U]; extra native code | No evidence of need |

### ADR-14 Secure local storage

| Field | Content |
|---|---|
| Status | Proposed. Differs from `TD-04` (what is stored) |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `TD-04` proposed secure storage "for tokens only" [A]. Firebase Authentication keeps its own session, so tokens are not ours to store. The brief asks for Android Keystore use. `flutter_secure_storage` 11.1.0 is BSD-3-Clause and needs Dart 3.8 or newer [V:S-108]. That the Android implementation uses the Keystore comes from the package's purpose and its README was not read [U] (`OPEN-58`). |
| Decision | We will store the consent record (version, time) and the local copy of declared restriction tags in `flutter_secure_storage`. We will not store Firebase tokens or API keys. |
| Drivers | OBJ-08, CON-06, brief (Keystore) |
| Reason | These are the only locally persisted items with privacy weight, and the consent record must survive reinstalls of the cache but never leave the device unprotected. |
| Consequences | Good: meets the Keystore item with a real use. Bad: data is lost on uninstall; migration needs care. |
| Validation | Unit tests with a fake store; a manual device check that values are not readable in plain text. |
| Revisit when | Firebase Authentication or another feature needs a local secret. |
| Links | TD-04, OBJ-08, CON-06, S-108, OPEN-58 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `shared_preferences` | Simple | Plain text | Weak for consent and tags |
| Custom platform channel to the Keystore | Full control | Native code to write and test | Over budget |
| Store nothing locally | No risk | Fails the brief's Keystore item [A] | Fails the brief |

### ADR-15 Authentication

| Field | Content |
|---|---|
| Status | Proposed. **Needs team input** (`OPEN-59`) |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Sync needs a stable user id for owner-only rules. The pricing page lists Authentication among products with no-cost Spark usage and shows phone number verification as pay-as-you-go [V:S-102]. Auth quotas were not read [U]. |
| Decision | We will use Firebase Authentication with email and password only. No phone number, no social sign-in in the MVP. Account deletion removes the user's documents (`OBJ-08`). |
| Drivers | CON-01, CON-06, OBJ-08, OBJ-05 |
| Reason | It collects the least personal data and avoids a paid path. |
| Consequences | Good: simple, free. Bad: users must remember a password; a password reset flow is needed. |
| Validation | Rules tests with two users; the account-switch scenario in SPK-04; a delete-account test. |
| Revisit when | Usability tests show sign-up friction, or `GT-04` requires another method. |
| Links | OBJ-05, OBJ-08, CON-06, OPEN-59, ASM-45, S-102 |

**Default recommendation and criteria.** Email and password. Choose Google sign-in only if the team accepts the extra SDK and the email it returns.

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Google sign-in | One tap | Extra package and Play services; not assessed [U] | Adds dependency |
| Anonymous only | No personal data | No stable identity across devices | Fails cross-device sync |
| Phone sign-in | Familiar | Collects phone numbers; phone verification is pay-as-you-go [V:S-102] | Cost and personal data |

### AI and data sources

### ADR-16 AI access path

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-02` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | Firebase AI Logic is a proxy gateway that works with App Check. In Flutter, App Check must be passed explicitly: `FirebaseAI.googleAI(appCheck: FirebaseAppCheck.instance, useLimitedUseAppCheckTokens: true)`. Replay protection is announced as future [V:S-093]. `firebase_ai` 4.0.0 (Apache-2.0) and `firebase_app_check` 0.4.8 are in Flutter BoM 4.20.0 of 2026-09-14 [V:S-094]. The Gemini free tier lets Google use inputs, so real-user text needs a paid tier [V:S-075] (`TD-02`, `RSK-02`). |
| Decision | We will call Gemini only through `firebase_ai` with App Check and limited-use tokens. No API key ships in the app. Free tier for development and synthetic text; a paid tier or synthetic text for any pilot. |
| Drivers | RSK-11, RSK-02, RSK-01, CON-01, CON-06, OBJ-01 |
| Reason | `TD-02` found it to be the only candidate path with a free tier that needs no key in the client [V:S-078]. App Check blocks calls from other clients. |
| Consequences | Good: no secret in the APK. Bad: free-tier limits are shown only in AI Studio (`OPEN-38`); processing location is unknown (`OPEN-39`); the Android App Check provider and its device limits were not read (`OPEN-65`). |
| Validation | SPK-05: a replayed request without a token is rejected. |
| Revisit when | `KC-02` fires (free tier removed, App Check cannot protect the call, or no model passes SPK-01). |
| Links | TD-02, KC-02, SPK-05, GT-04, RSK-01, RSK-02, RSK-11, OPEN-38, OPEN-39, OPEN-65, S-075, S-078, S-079, S-080, S-093, S-094 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Gemini key inside the app | Fastest | Extractable key; quota theft (`RSK-11`) | Fails SPK-05 |
| Own proxy on Cloud Functions | Key stays on the server | Needs server work; use on the free plan is unknown (`OPEN-49`) | Plan B only |
| Another vendor behind a proxy | Different model | No free tier shown; needs a server proxy [V:S-079,S-080] | Plan B only |

### ADR-17 Model selection rule and Remote Config

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | On 2026-10-09 the official deprecations page lists `gemini-3.1-flash-lite` with a shutdown on 2027-05-07 and `gemini-3.5-flash-lite` as its replacement, with no shutdown announced for the replacement [V:S-101]. Remote Config appears among the Firebase products with no-cost usage [V:S-102]; `firebase_remote_config` 6.7.0 is in BoM 4.20.0 [V:S-094]. |
| Decision | We will keep the parse model id and the fallback id in Remote Config, with in-app defaults (`gemini-3.5-flash-lite`, then `gemini-3.8-flash`) and a client-side allow-list. If the remote value is not on the list, the default is used. If both fail, the app offers manual entry. |
| Drivers | RSK-05, RSK-20, OBJ-01 |
| Reason | A retired model then costs a console change, not an app release. The allow-list stops a bad value from sending text to an unknown model. |
| Consequences | Good: fast switch. Bad: a remote change can alter behaviour silently, so the SPK-01 regression set must run before any change [A]. |
| Validation | Unit test: invalid remote value falls back; SPK-01 rerun on each model change. |
| Revisit when | A model gets a shutdown date within 90 days (`KC-02`). |
| Links | TD-02, KC-02, RSK-05, RSK-20, SPK-01, S-094, S-101, S-102 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Hard-coded model id | Simplest | Needs an app release when a model is retired [V:S-101] | Slow response |
| "Latest" alias | Always current | Silent behaviour change (`RSK-20`) | Unsafe |
| Server chooses the model | Central control | Needs a server (`OPEN-49`) | Plan B only |

### ADR-18 Parse contract

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-02` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | In a test on 299 Chinese foods, nine LLMs agreed closely with a food composition table for energy and less for several micronutrients; the data are Chinese, not Egyptian [V:S-056]. The model must never restate totals (`RSK-07`). |
| Decision | We will ask for schema-constrained JSON (`items[]` with `name_raw`, `name_en`, `name_ar`, `qty`, `unit`, `grams`, `grams_basis`, `prep`, `is_packaged`, `barcode_hint`, `confidence`, `flags`) at low temperature and capped output. Dart validates the schema, retries once, then falls back to manual entry. Non-food or instruction-like text is rejected. Medical-advice requests return a refusal code with a pointer to a professional. |
| Drivers | RSK-07, RSK-15, SCP-OUT-04, SCP-OUT-06, OBJ-01 |
| Reason | A validated structure is the contract that keeps numbers in code and sources visible. |
| Consequences | Good: reproducible totals. Bad: a stricter schema may lower recall on dialect input. Whether `firebase_ai` exposes a response schema for the chosen model in Flutter was not read [U] (`OPEN-66`). |
| Validation | SPK-01: recall and precision, quantity accuracy, JSON validity at least 0.98 [A]; golden fixtures in unit tests. |
| Revisit when | SPK-01 misses its thresholds on the dialect set (`KC-02`). |
| Links | TD-02, RSK-07, RSK-15, SPK-01, OPEN-66, S-056 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Free text plus regular expressions | No schema | Fragile | Error-prone |
| Model returns totals | Fewer steps | Hallucinated totals (`RSK-07`) | Fails the rule |
| Function calling | Structured | Not tested here [U] | No evidence |

### ADR-19 Reference-data resolution order

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-01` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `TD-01` scored the team table 79, USDA 75, LLM-only 66 (fails the per-item-source gate), Open Food Facts 57. USDA data is CC0 [V:S-082]. Open Food Facts is ODbL for the database [V:S-070]. |
| Decision | We will resolve each item in this order: (1) team Egyptian dish table, (2) bundled USDA subset, (3) Open Food Facts by barcode, fetched live and never merged into the bundled data, (4) model estimate flagged `AI_ESTIMATE` with a range. Matching uses normalised Arabic and English aliases and shows the top three candidates when confidence is low [A]. Each stored item keeps `source_id`, `source_type` and `data_version`. |
| Drivers | OBJ-03, OBJ-02, RSK-03, RSK-22, PRB-03 |
| Reason | Local layers work offline with no quota and give a per-item source. Not merging Open Food Facts avoids the share-alike duty (`RSK-22`). |
| Consequences | Good: traceable numbers. Bad: the dish table costs labour (0.25 person-days per dish [A:ASM-29]) and needs a reviewer (`RSK-09`). |
| Validation | SPK-02: dish hit@3 at least 0.70 and ingredient hit@3 at least 0.90 [A]; `KC-01`. |
| Revisit when | `KC-01` fires. |
| Links | TD-01, KC-01, SPK-02, OBJ-03, RSK-03, RSK-09, RSK-22, ASM-29, ASM-34, ASM-36, S-070, S-082 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| LLM only | No data work | No per-item source; not reproducible | Fails the source rule |
| Paid or quota-limited nutrition APIs | Large coverage | Storage and display limits, premium-gated fields, non-commercial free tiers [V:S-063,S-067,S-068] | Rejected in `TD-01` |
| Merge Open Food Facts into the bundled data | One store | ODbL share-alike [V:S-070] | Licence risk |

### ADR-20 Barcode scanning and runtime permissions

| Field | Content |
|---|---|
| Status | Proposed (conditional). Barcode is in the "maybe later" list of `DISCOVERY.md` §1.5 |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief asks for runtime permissions. The camera is the planned runtime permission. `mobile_scanner` 7.4.2 is BSD-3-Clause (Dart 3.7, Flutter 3.29); `permission_handler` 13.0.2 is MIT (Dart 3.6, Flutter 3.24) [V:S-108,S-109]. |
| Decision | If barcode scanning enters scope, we will use `mobile_scanner` and `permission_handler`, ask for the camera only when the user taps "scan", show a reason first, and handle denied and permanently denied states. Open Food Facts lookup runs through Dio (ADR-21). |
| Drivers | Brief (runtime permissions), OBJ-08, CON-07 |
| Reason | Requesting at the point of use is the least intrusive pattern and shows the brief item clearly. |
| Consequences | Good: a real permission flow. Bad: barcode is "maybe later", so if it stays out another runtime permission must be found (`OPEN-60`). The Android minimum of both plugins was not read (`OPEN-62`). |
| Validation | Widget tests for the denied and permanently denied paths; a manual device test. |
| Revisit when | Scope is fixed at `GT-03`. |
| Links | OPEN-60, OPEN-62, ASM-46, S-108, S-109 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Scanner's own permission prompt only | Less code | Less control over the explanation; not assessed [U] | Weaker for the brief |
| Manual barcode typing | No permission | Poor usability; no permission demo | Fails the brief item |
| ML Kit plus `camera` directly | Flexible | More code; not assessed [U] | Over budget |

### Networking and security

### ADR-21 Dio and the interceptor chain

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-04` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief mandates Dio with interceptors. Open Food Facts needs a custom User-Agent in the form `AppName/Version (ContactEmail)` and limits of 15 requests a minute for reads and 10 for search, per user from a mobile app [V:S-070]. `dio` 5.11.1 is MIT [V:S-106]. The Gemini call goes through `firebase_ai`, not Dio. |
| Decision | We will use one `Dio` per base URL with timeouts and this chain: User-Agent, App Check or auth header (only for our own endpoints, never for Open Food Facts), retry with backoff and jitter (GET only), read-through cache that respects each source's terms, redacted logging, error mapping to `AppFailure`. The retry interceptor is written in the project. |
| Drivers | Brief (Dio), OBJ-01, RSK-18, CON-06 |
| Reason | A small, tested chain meets the brief and the Open Food Facts rules without extra packages. |
| Consequences | Good: control. Bad: we maintain the retry code. |
| Validation | Unit tests with a mock adapter for each interceptor; SPK-06 timing. |
| Revisit when | The retry code grows beyond about 100 lines [A]. |
| Links | TD-04, OBJ-01, RSK-18, S-070, S-106 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `http` package | Smaller | The brief mandates Dio | Fails the brief |
| `dio_smart_retry` | Ready retry | Extra dependency; not assessed [U] | Small to write |
| `retrofit` or `chopper` | Typed clients | Code generation (ADR-08) | Adds `build_runner` |

### ADR-22 Secrets policy and release hardening

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-04` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `RSK-11`: a key in the APK or repository leaks. USDA data is bundled and Open Food Facts needs no key, so no third-party key is needed (`TD-04`). Gitleaks 8.30.1 is MIT [V:S-115]. |
| Decision | We will keep no secret in the repository or app: no keys in `--dart-define`, assets or `.env`. The release keystore stays outside the repository. Release builds use code shrinking and Dart obfuscation with split debug info [A] (`OPEN-63`). CI runs secret scanning on every pull request. |
| Drivers | RSK-11, RSK-16, CON-06, brief (Android security basics) |
| Reason | Values placed in the app can be extracted [A]; scanning catches mistakes before merge. |
| Consequences | Good: no leak path. Bad: obfuscated stack traces need the debug-info files. |
| Validation | SPK-05: decompile the release APK and search for key patterns and URLs; secret scan green. |
| Revisit when | A feature needs a secret in the client (then use a server). |
| Links | TD-04, RSK-11, SPK-05, OPEN-63, S-115 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Key in `--dart-define` | Easy | Still extractable [A] | Fails SPK-05 |
| Key in assets | Easy | Extractable | Fails SPK-05 |
| No scanning | No setup | Mistakes reach `main` | Weak |

### ADR-23 Dependency, licence and notices checks

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-05` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | ODbL, DbCL and CC BY-SA apply to Open Food Facts; USDA data is CC0 [V:S-070,S-082]. OSV-Scanner 2.6.0 is Apache-2.0 [V:S-115]. That it reads `pubspec.lock` was not checked [U] (`OPEN-63`). |
| Decision | We will keep `THIRD_PARTY_NOTICES` at the repository root and in an in-app About screen (dataset name, licence, URL, retrieval date, what is stored). We will show package licences with the Flutter licence page [A]. CI fails if the notices file is missing, and runs OSV-Scanner on the lock file. |
| Drivers | TD-05, RSK-18, RSK-22, OBJ-07 |
| Reason | The data licences carry attribution duties. A check in CI keeps them from being forgotten. |
| Consequences | Good: auditable. Bad: the notices file needs an update with every data import. |
| Validation | CI presence check; a scan report attached to each release candidate. |
| Revisit when | The scanner cannot read the Dart lock file. |
| Links | TD-05, RSK-18, RSK-22, OPEN-63, S-070, S-082, S-115 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Manual review only | No tooling | Easy to skip | Weak |
| Platform-native dependency alerts | Built into GitHub | Pub support not assessed [U] | Unverified |

### ADR-24 Privacy-safe logging, crash reporting and analytics

| Field | Content |
|---|---|
| Status | Proposed. **Needs team input** |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `TD-05` flow F5 (crash and analytics data) is open. Crashlytics and Analytics appear among the products with no-cost usage [V:S-102]; `firebase_crashlytics` 5.4.0 is in BoM 4.20.0 [V:S-094]. Sending data abroad needs authorisation (`CON-06`). |
| Decision | We will add no analytics package. Crash reporting is not added in the MVP. Logging uses redaction (no meal text, no tokens). If the team later adds Crashlytics, collection stays disabled until the user opts in. |
| Drivers | OBJ-08, RSK-01, RSK-10, CON-06 |
| Reason | Every extra data flow abroad adds legal work before `GT-04`. |
| Consequences | Good: fewer flows. Bad: less visibility in the pilot; testers send bug reports by hand. |
| Validation | A settings test shows no collection without opt-in; the `GT-04` review. |
| Revisit when | `GT-04` approves an opt-in crash flow, or the pilot needs remote diagnostics. |
| Links | TD-05, OBJ-08, RSK-01, RSK-10, S-094, S-102 |

**Default recommendation and criteria.** No crash reporting and no analytics in the MVP. Choose opt-in Crashlytics only if the trainer or legal reviewer accepts the data flow.

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Crashlytics on by default | Full visibility | Data leaves the device without consent | Conflicts with `CON-06` |
| Third-party tracker | Rich data | Another vendor and data flow; not assessed [U] | Extra legal work |
| Opt-in Crashlytics | Visibility with consent | Needs a consent screen and review | Possible later |

### Quality and delivery

### ADR-25 Test stack and coverage gate

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-04` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief requires unit and widget tests; `OBJ-06` sets 80% for the calculation layer. `mocktail` 1.0.5 is MIT; its last release was 2024-06-12 [V:S-107]. `bloc_test` 10.0.0 is MIT and depends on `bloc` ^9.1.0 (main-branch pubspec) [V:S-107]. |
| Decision | We will use `flutter_test` (unit and widget), `integration_test` (the offline flow on a device or emulator), `mocktail` for fakes (no code generation) and `bloc_test` for Bloc and Cubit tests. Coverage comes from `flutter test --coverage`, filtered to `domain/`, with a script that fails below 80%. Rules tests run in the emulator (ADR-12). |
| Drivers | Brief, OBJ-06, RSK-12 |
| Reason | The SDK packages need no extra dependency; `mocktail` avoids `build_runner`. |
| Consequences | Good: one test command per layer. Bad: `mocktail` is older; a Dart upgrade could break it. |
| Validation | CI; a coverage report per pull request. |
| Revisit when | `mocktail` fails on the pinned Dart version. |
| Links | TD-04, OBJ-06, RSK-12, S-107 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `mockito` | Common | Code generation | Adds `build_runner` |
| Hand-written fakes only | No dependency | More code | Slower |
| Test Blocs with `flutter_test` streams only | No extra dependency | More code per Bloc test | `bloc_test` shortens it [A] |

### ADR-26 Static analysis and formatting

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `flutter_lints` 6.0.0 is maintained in the Flutter packages repository and needs Dart 3.11 or newer [V:S-104]. |
| Decision | We will use `flutter_lints` with `strict-casts`, `strict-inference` and `strict-raw-types`, plus `avoid_print`, `always_use_package_imports` and `unawaited_futures`. `dart format --set-exit-if-changed` runs in CI. Intentional write-and-forget calls use `unawaited()`. |
| Drivers | OBJ-07, RSK-12 |
| Reason | `unawaited_futures` turns the ADR-11 rule into a checked rule. |
| Consequences | Good: consistent code. Bad: some warnings to fix at the start. |
| Validation | `flutter analyze` and format check green in CI. |
| Revisit when | The rule set blocks work without value. |
| Links | OBJ-07, RSK-12, S-104 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `very_good_analysis` | Stricter | Extra dependency; not assessed here [U] | Not needed |
| Defaults only | No setup | Misses the write-and-forget rule | Weaker |

### ADR-27 Continuous integration

| Field | Content |
|---|---|
| Status | Proposed. Imported from `TD-04` |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief requires Git and GitHub with pull requests. `subosito/flutter-action` v2.23.0 (MIT, 2026-03-25), `actions/checkout` v7.0.1, `actions/setup-java` v6.0.1 and `actions/setup-node` v7.1.0 are current [V:S-115]. Free CI minutes were not read [U] (`TD-06`). |
| Decision | We will run GitHub Actions on every pull request: checkout, Java 17 (`setup-java`), Flutter pinned to the ADR-03 version, `pub get`, analyse, format check, tests with coverage gate, Node 24 (`setup-node`) with the Firebase emulator rules tests, secret scan, dependency scan, and a debug APK build. Actions are pinned to a full commit SHA recorded beside the version [A]. |
| Drivers | OBJ-07, OBJ-06, OBJ-05, CON-01 |
| Reason | It is free for the repository, close to the code, and the brief names GitHub. |
| Consequences | Good: every merge is checked. Bad: build minutes may run out [U]; the emulator step is slow. |
| Validation | A green check on `main`; total run under about 15 minutes [A]. |
| Revisit when | Minutes run out or runs exceed the target. |
| Links | OBJ-05, OBJ-06, OBJ-07, ASM-39, S-115 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| Other hosted CI free tiers | Mobile focus | Limits not read [U] | Unverified |
| Scripts run locally | No cost | Not enforced | Fails `OBJ-07` |
| Manual Flutter install in CI | No third-party action | More script upkeep | More work |

### ADR-28 Branching, pull requests and documentation upkeep

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | `OBJ-07` needs every merge through a reviewed pull request, a README and technical documentation. |
| Decision | We will protect `main`, work on short-lived `feat/`, `fix/` and `docs/` branches, require one approving review and a green CI run, and squash merge. A pull-request template has a checklist (tests, notices, ADR link). Any change to a dependency or an architecture rule updates its ADR in the same pull request. `tools/check_discovery.py` runs for documentation changes. |
| Drivers | OBJ-07, CON-03, brief (Git and GitHub, documentation) |
| Reason | Small, reviewed changes suit five people, and tying ADRs to pull requests keeps this log honest. |
| Consequences | Good: traceability. Bad: review latency. Needs a GitHub plan that supports required reviews [A:ASM-44]. |
| Validation | Repository settings screenshot; 100% of merges through pull requests (`OBJ-07`). |
| Revisit when | Review latency exceeds two days regularly [A]. |
| Links | OBJ-07, ASM-44, S-115 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| GitFlow | Release branches | Overhead for five people | Too heavy |
| Direct pushes to `main` | Fast | Fails `OBJ-07` | Fails the target |

### ADR-29 Release format and application id

| Field | Content |
|---|---|
| Status | Proposed. **Needs team input** (`OPEN-61`) |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | A Google Play application id must be unique, should be based on a domain the publisher owns, cannot use `com.example`, and must not change after publishing; a change makes Play treat the upload as a new app [V:S-103]. `NAMING.md` §8.2 suggests `com.team.nesba` and asks the team to confirm uniqueness. `team.com` is not known to belong to the team [A]. |
| Decision | We will build an Android App Bundle for any store upload and an APK for testers during the course (`TD-06`). We will set `applicationId` explicitly and fix it before any upload. Until the team owns a suitable domain, `com.team.nesba` is a placeholder for tester builds only. |
| Drivers | CON-01, OBJ-07, brief (Git and GitHub) |
| Reason | The id is permanent, so the choice is cheap now and expensive later. |
| Consequences | Good: no accidental publication under a borrowed namespace. Bad: a later change of id means a new app identity for testers. |
| Validation | CI builds the bundle weekly; a checklist item before the first upload. |
| Revisit when | The team picks a domain (`OPEN-55`) or plans a Play release (`ASM-42`). |
| Links | OPEN-55, OPEN-61, ASM-42, NAMING.md §8.2, S-103 |

**Default recommendation and criteria.** Use the reverse of a domain the team controls plus `.nesba`. If none exists, keep the placeholder for tester builds and decide before any upload.

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `com.example.*` | Default in templates | Forbidden by Google Play [V:S-103] | Cannot be uploaded |
| Rename after publishing | Flexible | Treated as a new app [V:S-103] | Loses installs |

### ADR-30 History and charts

| Field | Content |
|---|---|
| Status | Proposed |
| Date | Proposed 2026-10-09; accepted [T] |
| Context | The brief names `GridView` and `Stack` for meal history and nutrition charts (`SCP-IN-05`). `fl_chart` 1.2.0 is MIT and was released 2025-09-15 [V:S-112]. |
| Decision | We will build history with `GridView` and the charts as small `Stack` and `CustomPainter` widgets (bars and rings for energy and macros). `fl_chart` stays an option if axes and tooltips become necessary. |
| Drivers | SCP-IN-05, brief (GridView and Stack), CON-03, OBJ-01 |
| Reason | It follows the brief literally and avoids a dependency for two or three simple chart types. |
| Consequences | Good: no chart package. Bad: custom painting takes time; accessibility labels must be added by hand. |
| Validation | Widget tests with semantics labels; SPK-06 frame timing on the low-RAM device. |
| Revisit when | More than three chart types or axis labels are required [A]. |
| Links | SCP-IN-05, SPK-06, S-112 |

**Alternatives**

| Option | Pros | Cons | Why not |
|---|---|---|---|
| `fl_chart` now | Rich charts | A dependency; the brief names Stack | Not needed yet |
| Text list only | Simplest | No chart; fails the brief | Fails the brief |

## 4 Rejected technologies

| Technology | Why not | Evidence | Revisit when |
|---|---|---|---|
| Edamam Food Database API | No permanent free plan; storage and display limits | [V:S-063] | A free, storable plan appears |
| CalorieNinjas and API Ninjas | Turn-down notice; premium-gated fields; non-commercial free tier | [V:S-066,S-067,S-068] | Terms change |
| Spoonacular and DietlyAPI | Tiny free quotas, short cache limits, non-commercial tiers | [V:S-085]; DietlyAPI only tier C [U] | Terms change |
| Custom sync engine (local database plus own sync, OPT-31) | Costs about 10–15 person-days [A] and is needed only if offline persistence fails | [A]; `TD-03` | `KC-03` fires |
| Third-party offline-sync packages (OPT-32) | Maturity unknown | [V:S-086] | A maintained package is shown (`OPEN-46`) |
| iOS target | No Apple hardware or requirement | ADR-01 | `DR-03` fires |
| Self-hosted models (Jais 2, open models on own servers) | No hosted endpoint found; hosting has a cost and the budget is zero | [V:S-060] | GT-02 recheck finds a free hosted route (`OPEN-47`) |
| Third-party analytics by default | Extra data flow abroad before `GT-04` | ADR-24 | The pilot needs it and legal review accepts it |
| API key in `--dart-define`, assets or `.env` | Extractable from the app | [A]; ADR-22 | A server proxy exists |
| `http` package for external APIs | The brief mandates Dio | ADR-21 | Never for the brief item |
| Code generation in the MVP (`freezed`, `json_serializable`, `retrofit`) | Adds `build_runner` and analyzer coupling | [V:S-113]; ADR-08 | More than 25 model types |
| Riverpod (`flutter_riverpod`) for state | The project author chose Bloc; both meet the brief; TD-04 scored Riverpod higher (86 against 76) [A:ASM-30] | ADR-06; [V:S-105] | `KC-04` fires |
| Phone-number sign-in | Collects phone numbers; phone verification is pay-as-you-go | [V:S-102] | Legal review accepts it and the budget allows |
| Web or installable web app | No Keystore or runtime permissions | ADR-01 | Brief changes |

## 5 Dependency register

Versions of Dart packages were read from each package's official repository on 2026-10-09 (main-branch `pubspec.yaml`, which can be ahead of the published version), and Firebase plugin versions from the Flutter BoM table. The pub.dev pages were not opened, so the pub.dev publisher and published date need the team's check (`OPEN-58`). "Publisher" shows the repository owner where the pub.dev publisher is [T].

| ID | Package or service | Purpose | Version found | Publisher | Licence | Last release date | Flutter or Dart constraint | Evidence | ADR | Team check |
|---|---|---|---|---|---|---|---|---|---|---|
| DEP-01 | Flutter SDK | UI framework and tools | 3.47.x stable (newest tag seen 3.47.7) | Flutter team (flutter/flutter) | BSD-style (BSD-3-Clause text) | 2026-09-30 (tag) | Bundles the Dart 3.13 line; `material_ui` needs Dart ^3.13 | S-096, S-098, S-104 | ADR-03 | [T] |
| DEP-02 | material_ui | UI components | 1.6.0 | Flutter team (flutter/packages) | BSD-style | [T] | Dart ^3.13.0; Flutter >=3.47.0 (main-branch pubspec) | S-104, S-097 | ADR-04 | [T] |
| DEP-03 | cupertino_ui | Transitive dependency of `material_ui` | 1.1.2 | Flutter team (flutter/packages) | BSD-style (repository licence) | [T] | [T] | S-104 | ADR-04 | [T] |
| DEP-04 | flutter_bloc | State management widgets for Bloc and Cubit | 9.1.1 | GitHub owner felangel; pub.dev publisher [T] | MIT | [T] | Dart >=2.14.0 <4.0.0; depends on `bloc` ^9.0.0 and `provider` ^6.0.0 (main-branch pubspec) | S-107 | ADR-06 | [T] |
| DEP-05 | go_router | Navigation | 18.0.2 | Flutter team (flutter/packages) | BSD-style | [T] | Dart ^3.12.0; Flutter >=3.44.0 | S-104 | ADR-07 | [T] |
| DEP-06 | dio | HTTP client | 5.11.1 | GitHub owner cfug; pub.dev publisher [T] | MIT | 2026-07-29 | Dart >=2.18.0 <4.0.0 | S-106 | ADR-21 | [T] |
| DEP-07 | firebase_core | Firebase initialisation | 4.15.0 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | Dart ^3.6.0; Flutter >=3.27.0 (BoM) | S-094 | ADR-11, ADR-16 | [T] |
| DEP-08 | cloud_firestore | Sync and offline persistence | 6.10.0 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094, S-095 | ADR-11, ADR-12 | [T] |
| DEP-09 | firebase_auth | Sign-in | 6.7.0 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094 | ADR-15 | [T] |
| DEP-10 | firebase_app_check | Client attestation | 0.4.8 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094, S-093 | ADR-16 | [T] |
| DEP-11 | firebase_ai | Gemini through Firebase AI Logic | 4.0.0 | Firebase (firebase/flutterfire) | Apache-2.0 | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094, S-095, S-093 | ADR-16, ADR-17, ADR-18 | [T] |
| DEP-12 | firebase_remote_config | Model id and feature flags | 6.7.0 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094 | ADR-17 | [T] |
| DEP-13 | firebase_crashlytics | Optional crash reports, off by default | 5.4.0 | Firebase (firebase/flutterfire) | BSD-style | 2026-09-14 (BoM 4.20.0) | As the BoM | S-094 | ADR-24 | [T] |
| DEP-14 | flutter_secure_storage | Keystore-backed local storage | 11.1.0 | GitHub owner juliansteenbakker; pub.dev publisher [T] | BSD-3-Clause | [T] | Dart >=3.8.0; Flutter >=3.19.0 | S-108 | ADR-14 | [T] |
| DEP-15 | permission_handler | Runtime permissions | 13.0.2 | GitHub owner Baseflow; pub.dev publisher [T] | MIT | 2026-09-04 | Dart ^3.6.0; Flutter >=3.24.0 | S-109 | ADR-20 | [T] |
| DEP-16 | mobile_scanner | Barcode scanning (conditional) | 7.4.2 | GitHub owner juliansteenbakker; pub.dev publisher [T] | BSD-3-Clause | 2026-09-09 | Dart ^3.7.0; Flutter >=3.29.0 | S-108 | ADR-20 | [T] |
| DEP-17 | intl | Localisation | 0.20.3 | Dart team (dart-lang/i18n) | BSD-style | 2025-12-30 | Dart ^3.9.0 | S-111 | ADR-10 | [T] |
| DEP-18 | flutter_test and integration_test | Unit, widget and integration tests | With the Flutter SDK | Flutter team | BSD-style | With the SDK | With the SDK | S-096 | ADR-25 | [T] |
| DEP-19 | mocktail | Test fakes without code generation | 1.0.5 | GitHub owner felangel; pub.dev publisher [T] | MIT | 2024-06-12 | Dart >=2.12.0 <4.0.0 | S-107 | ADR-25 | [T] |
| DEP-20 | flutter_lints | Lint rule set | 6.0.0 | Flutter team (flutter/packages) | BSD-style | [T] | Dart ^3.11.0 | S-104 | ADR-26 | [T] |
| DEP-21 | firebase-tools (npm) | Firebase emulator | 15.33.0 | Firebase | MIT | 2026-10-08 | Node >=20 | S-114 | ADR-12 | [T] |
| DEP-22 | @firebase/rules-unit-testing (npm) | Firestore rules tests | 6.0.0 | Firebase | Apache-2.0 | 2026-10-07 | Node >=24.12.0 | S-114 | ADR-12 | [T] |
| DEP-23 | Node.js 24 | Runtime for the rules tests | 24.12.0 or newer (derived) | [T] | [T] | n/a | Required by the rules-testing package | S-114 | ADR-12, ADR-27 | [T] |
| DEP-24 | subosito/flutter-action | CI: install Flutter | v2.23.0 | GitHub owner subosito | MIT | 2026-03-25 | n/a | S-115 | ADR-27 | [T] |
| DEP-25 | actions/checkout | CI: get the code | v7.0.1 | GitHub | MIT | 2026-07-17 | n/a | S-115 | ADR-27 | [T] |
| DEP-26 | actions/setup-java | CI: Java 17 | v6.0.1 | GitHub | MIT | 2026-09-09 | n/a | S-115 | ADR-27 | [T] |
| DEP-27 | actions/setup-node | CI: Node 24 | v7.1.0 | GitHub | MIT | 2026-10-08 | n/a | S-115 | ADR-27 | [T] |
| DEP-28 | gitleaks | CI: secret scanning | v8.30.1 | GitHub owner gitleaks | MIT | 2025-11-26 | n/a | S-115 | ADR-22, ADR-27 | [T] |
| DEP-29 | OSV-Scanner | CI: dependency vulnerability scan | v2.6.0 | Google (google/osv-scanner) | Apache-2.0 | 2026-08-17 | n/a; reading `pubspec.lock` not checked [U] | S-115 | ADR-23, ADR-27 | [T] |
| DEP-30 | Android build toolchain | Gradle, AGP, Kotlin Gradle plugin, Java | AGP 9.1.0; Gradle 9.3.1; Kotlin Gradle plugin 2.4.0; Java 17 minimum | Per the Flutter 3.47 template | [T] | 2026-08-12 (Flutter 3.47) | Set by the Flutter template | S-096 | ADR-03 | [T] |
| DEP-31 | Firebase Android SDK | Native layer behind the plugins | 34.19.0 | Firebase | [T] | 2026-09-14 (BoM 4.20.0) | minSdk not read [U] | S-094 | ADR-02 | [T] |
| DEP-32 | drift (candidate) | SQLite layer if the data grows | 2.35.2 | GitHub owner simolus3 | MIT | 2026-10-07 | Dart >=3.10.0 <4.0.0 | S-110 | ADR-13 | [T] |
| DEP-33 | flutter_riverpod (runner-up, not adopted) | Alternative state management | 3.4.3 | GitHub owner rrousselGit; pub.dev publisher [T] | MIT | 2026-09-03 (release); changelog says 2026-09-04 | Dart ^3.12.0 (main-branch pubspec; main also adds a `material_ui` dependency) | S-105 | ADR-06 | [T] |
| DEP-34 | freezed (candidate, not adopted) | Code generation for models | 4.0.2 | GitHub owner rrousselGit | MIT | 2026-08-29 | Dart >=3.13.0 and analyzer 14 (main-branch pubspec) | S-113 | ADR-08 | [T] |
| DEP-35 | fl_chart (candidate) | Optional charts | 1.2.0 | GitHub owner imaNNeo | MIT | 2025-09-15 | [T] | S-112 | ADR-30 | [T] |
| DEP-36 | Gemini models (service) | Meal parsing: `gemini-3.5-flash-lite`, fallback `gemini-3.8-flash` | As named | Google | Service terms [T] | No shutdown announced for 3.5 Flash-Lite on 2026-10-09 | n/a | S-101, S-075 | ADR-16, ADR-17 | [T] |
| DEP-37 | Open Food Facts API (service and data) | Barcode lookup | Live API | Open Food Facts | ODbL, DbCL, CC BY-SA | Live | n/a | S-070 | ADR-19, ADR-21 | [T] |
| DEP-38 | USDA FoodData Central subset (data) | Bundled ingredient values | Snapshot [T] | USDA | CC0 | [T] | n/a | S-082 | ADR-13, ADR-19 | [T] |
| DEP-39 | Team Egyptian dish table (data) | Bundled dish values | Team-built | Team | Team licence [T] | [T] | n/a | [A:ASM-34] | ADR-13, ADR-19 | [T] |
| DEP-40 | bloc | Core Bloc and Cubit classes (dependency of `flutter_bloc`) | 9.2.1 on the main branch | GitHub owner felangel | MIT | [T] | Dart >=2.14.0 <4.0.0 | S-107 | ADR-06 | [T] |
| DEP-41 | bloc_test | Tests for Bloc and Cubit | 10.0.0 | GitHub owner felangel | MIT | [T] | Dart >=2.14.0 <4.0.0; depends on `bloc` ^9.1.0 and `mocktail` ^1.0.0 | S-107 | ADR-25 | [T] |
| DEP-42 | equatable (candidate) | Value equality for Bloc states, if the team prefers it to hand-written equality | 3.0.0 on the main branch; published version not read | GitHub owner felangel | MIT | [T] | Dart >=3.0.0 <4.0.0 | S-117 | ADR-06, ADR-08 | [T] |

## 6 Compatibility notes

| Pair or topic | Constraint | Source | Check before upgrading |
|---|---|---|---|
| Flutter and `material_ui` | `material_ui` needs Flutter 3.47 or newer and Dart 3.13 (main-branch pubspec) | [V:S-104] | Upgrade Flutter and `material_ui` together |
| Flutter and `go_router` 18 | Flutter 3.44 or newer; Dart 3.12 | [V:S-104] | Read the changelog before a major version |
| `flutter_bloc` 9.1.1 | Depends on `bloc` ^9.0.0 and `provider` ^6.0.0; Dart >=2.14.0 <4.0.0 (main-branch pubspec, where `bloc` is 9.2.1) | [V:S-107] | Confirm the published constraints on pub.dev (`OPEN-58`); upgrade `bloc`, `flutter_bloc` and `bloc_test` together |
| FlutterFire BoM 4.20.0 | Dart 3.6 or newer, Flutter 3.27 or newer; native Android SDK 34.19.0 | [V:S-094] | Upgrade all Firebase plugins together, by BoM |
| FlutterFire and Flutter 3.47 toolchain | BoM 4.19.1 notes mention aligning the Android toolchain with Flutter 3.47 and Kotlin Gradle plugin 2.3.0; the Flutter 3.47 template lists 2.4.0 | [V:S-095,S-096] | Run a clean Android build after every upgrade |
| `firebase_ai` 4.0.0 | The 4.0.0 breaking change removed Imagen support; the package replaced `firebase_vertexai`; Flutter must pass App Check explicitly | [V:S-095,S-093] | Re-read the App Check page when upgrading |
| Android toolchain | AGP 9.1.0, Gradle 9.3.1, Kotlin Gradle plugin 2.4.0, Java 17 | [V:S-096] | Do not hand-edit; follow the Flutter template |
| Rules tests | `@firebase/rules-unit-testing` 6.0.0 needs Node 24.12 or newer; `firebase-tools` 15.33.0 needs Node 20 or newer | [V:S-114] | Keep CI on Node 24 |
| `freezed` 4 (not adopted) | Dart 3.13 or newer and analyzer 14 | [V:S-113] | Only if ADR-08 is revisited |
| Plugin minSdk | `mobile_scanner`, `flutter_secure_storage`, `permission_handler` and the Firebase Android SDK were not checked against Flutter's minSdk 24 | [U] | `OPEN-62`; build on the lowest device |
| Play target API | API 36 for new apps and updates since 2026-08-31; Flutter 3.47 defaults to 36 | [V:S-099,S-096] | Re-check each July [A] |
| Gemini model ids | `gemini-3.1-flash-lite` shuts down 2027-05-07; `gemini-3.5-flash-lite` has no shutdown date announced | [V:S-101] | Check the page weekly during development |
| `mocktail` 1.0.5 | Last release 2024-06-12 | [V:S-107] | Check it runs on the pinned Dart version in CI [A] |
| `bloc_test` 10.0.0 | Depends on `bloc` ^9.1.0 | [V:S-107] | Keep it aligned with `bloc` |
| `equatable` 3.0.0 (candidate) | The 3.0.0 changelog removes `EquatableMixin` and the `runtimeType` check; the published version was not read | [V:S-117] | Read pub.dev before adopting |

## 7 Validation plan

| ADR | Experiment, gate or test | Pass criterion | Owner role |
|---|---|---|---|
| ADR-01 | GT-01 to GT-05 on Android devices | All gates run on devices | Mobile lead |
| ADR-02 | Run on the lowest team device; CI build with Flutter defaults | App starts and passes smoke test | Mobile lead |
| ADR-03 | CI version check; `flutter doctor` on each machine | Same version everywhere | Mobile lead |
| ADR-04 | `dart fix` run; CI grep for old imports; widget tests | No old imports; tests green | Mobile lead |
| ADR-05 | Coverage of `domain/`; import check | At least 80%; no forbidden imports | Mobile lead |
| ADR-06 | KC-04 onboarding week; `bloc_test` cases for the analysis flow | Two members build and test one Cubit and one Bloc in one week | Mobile lead |
| ADR-07 | Widget tests for redirects | Signed-out and no-consent users are redirected | Mobile lead |
| ADR-08 | Fixture and round-trip unit tests | All models round-trip | Mobile lead |
| ADR-09 | Mapping unit tests; failure-state widget tests | Every failure type has a message | Mobile lead |
| ADR-10 | RTL and 200% font-scale widget tests | No overflow; strings in both languages | Mobile lead |
| ADR-11 | SPK-04; GT-01 | No UI freeze; no data loss offline | Mobile lead |
| ADR-12 | Emulator rules tests in CI (OBJ-05) | At least 10 cases pass | QA/security lead |
| ADR-13 | SPK-06 size and cold parse | Under about 10 MB and 500 ms [A] | Data lead |
| ADR-14 | Unit tests with a fake store; manual device check | No plain-text values in app storage | QA/security lead |
| ADR-15 | Two-user rules tests; delete-account test | No cross-user access; data removed | Backend lead |
| ADR-16 | SPK-05 | Call without token rejected | QA/security lead |
| ADR-17 | Fallback unit test; SPK-01 rerun | Invalid value falls back; thresholds met | AI lead |
| ADR-18 | SPK-01 | Recall, precision and JSON validity thresholds | AI lead |
| ADR-19 | SPK-02; KC-01 | Dish hit@3 at least 0.70 [A] | Data lead |
| ADR-20 | Denied-path widget tests; device test | Graceful denied and permanent-denied flow | Mobile lead |
| ADR-21 | Mock-adapter tests per interceptor; SPK-06 | Chain order and retry behave as specified | Mobile lead |
| ADR-22 | SPK-05 decompile search; secret scan | No keys or secrets found | QA/security lead |
| ADR-23 | CI presence check; scan report | Notices file present; scan green | Product/legal lead |
| ADR-24 | Settings test; GT-04 review | No collection without opt-in | Product/legal lead |
| ADR-25 | CI coverage gate | At least 80% on `domain/` | Mobile lead |
| ADR-26 | CI analyse and format | No warnings; formatted | Mobile lead |
| ADR-27 | Green run on every pull request | Run under about 15 minutes [A] | QA/security lead |
| ADR-28 | Repository settings; merge history | 100% of merges through reviewed pull requests | Product/legal lead |
| ADR-29 | Weekly bundle build; pre-upload checklist | Bundle builds; id decided before upload | Mobile lead |
| ADR-30 | Widget tests with semantics; SPK-06 frames | Labels present; no jank | Mobile lead |

## 8 Volatile facts

| Fact | Value | Source | Checked | Re-check by |
|---|---|---|---|---|
| Flutter stable line | 3.47 announced 2026-08-12; newest 3.47 tag seen 3.47.7 (2026-09-30); a 3.49 pre-release tag exists | S-096, S-098 | 2026-10-09 | 2026-11-10 (November stable) |
| Flutter Android defaults and toolchain | compile and target API 36; min API 24; Java 17; AGP 9.1.0; Gradle 9.3.1; Kotlin Gradle plugin 2.4.0 | S-096 | 2026-10-09 | Every Flutter upgrade |
| Google Play target API | API 36 required for new apps and updates since 2026-08-31 | S-099, S-100 | 2026-10-09 | Each July [A] |
| Core Material and Cupertino libraries | Formal deprecation planned in the November stable release | S-096 | 2026-10-09 | 2026-11-10 |
| FlutterFire Flutter BoM | 4.20.0 released 2026-09-14; plugin versions in §5 | S-094 | 2026-10-09 | 2026-11-09 (monthly) [A] |
| Gemini model lifecycle | `gemini-3.1-flash-lite` shuts down 2027-05-07; `gemini-3.5-flash-lite` has no shutdown announced | S-101 | 2026-10-09; model ids `gemini-3.5-flash-lite` and `gemini-3.8-flash` seen again on the page on 2026-10-10 (the 3.1 shutdown date was not visible in the search excerpt [U]) | Weekly during development (RSK-05) |
| Gemini prices and free-tier terms | Kept from `04-FEASIBILITY.md`; not re-read on 2026-10-09 [U] | S-075 | 2026-10-08 | Before GT-02 (2026-10-29) |
| Firebase plans | Spark has no-cost use of Remote Config, App Check and Crashlytics; phone verification is pay-as-you-go | S-102 | 2026-10-09 | Before GT-04 |
| Dart and npm package versions | See §5 | S-104 to S-115 | 2026-10-09 | Before each milestone |
| Node requirement for rules tests | 24.12 or newer | S-114 | 2026-10-09 | When the rules-testing package upgrades |
| Egypt data protection enforcement | Expected from 2026-11-01 with some uncertainty | S-017, S-018, S-045 | 2026-10-07 | 2026-10-30 |

## 9 Approval

| ADR | Proposed decision | Approvers | Date | Notes |
|---|---|---|---|---|
| ADR-01 | Android only; iOS deferred | [T] | [T] |  |
| ADR-02 | API 36 target; minimum API 24 | [T] | [T] | Needs team input |
| ADR-03 | Pin Flutter 3.47.x | [T] | [T] |  |
| ADR-04 | `material_ui` from day one | [T] | [T] |  |
| ADR-05 | Feature-first layers | [T] | [T] |  |
| ADR-06 | Bloc (`flutter_bloc`) | [T] | [T] | Project author's choice; confirm |
| ADR-07 | `go_router` | [T] | [T] |  |
| ADR-08 | Hand-written models | [T] | [T] |  |
| ADR-09 | Sealed `Result` | [T] | [T] |  |
| ADR-10 | gen-l10n, Arabic default | [T] | [T] |  |
| ADR-11 | Firestore offline persistence | [T] | [T] |  |
| ADR-12 | Owner-only rules with emulator tests | [T] | [T] |  |
| ADR-13 | Bundled JSON reference data | [T] | [T] |  |
| ADR-14 | Secure storage for consent and tags | [T] | [T] | Differs from TD-04 |
| ADR-15 | Email and password sign-in | [T] | [T] | Needs team input |
| ADR-16 | `firebase_ai` with App Check | [T] | [T] |  |
| ADR-17 | Model id in Remote Config | [T] | [T] |  |
| ADR-18 | Schema-constrained parse | [T] | [T] |  |
| ADR-19 | Resolve order | [T] | [T] |  |
| ADR-20 | Barcode with permission flow | [T] | [T] | Conditional |
| ADR-21 | Dio interceptor chain | [T] | [T] |  |
| ADR-22 | No secrets; obfuscated release | [T] | [T] |  |
| ADR-23 | OSV scan and notices | [T] | [T] |  |
| ADR-24 | No analytics; crash reporting off | [T] | [T] | Needs team input |
| ADR-25 | Test stack and coverage gate | [T] | [T] |  |
| ADR-26 | Lints and format | [T] | [T] |  |
| ADR-27 | GitHub Actions | [T] | [T] |  |
| ADR-28 | Protected `main`, reviewed pull requests | [T] | [T] |  |
| ADR-29 | App Bundle; fix the application id | [T] | [T] | Needs team input |
| ADR-30 | GridView and Stack charts | [T] | [T] |  |

**Needs team input.** Each item has a default; the team confirms or changes it.

| ADR | Question for the team | Default |
|---|---|---|
| ADR-02 | What is the oldest Android version on a team or tester phone? | Minimum API 24 |
| ADR-06 | Does the team accept Bloc, the project author's choice (it replaces the TD-04 proposal of Riverpod)? | Bloc |
| ADR-15 | Email and password only, or add Google sign-in? | Email and password |
| ADR-24 | May the pilot send opt-in crash reports abroad? | No crash reporting and no analytics |
| ADR-29 | Which domain does the team own, if any? | Placeholder id for tester builds only |


## 10 Open items and assumptions added

Defined in `A-ASSUMPTIONS.md` and `C-OPEN-ITEMS.md`.

| ID | Summary |
|---|---|
| ASM-39 | Team machines and CI can run Flutter 3.47.x, Java 17 and Node 24.12 or newer |
| ASM-40 | Bundled data stays under about 10 MB and parses in under about 500 ms |
| ASM-41 | The team's lowest device runs Android 7.0 (API 24) or newer |
| ASM-42 | No Google Play release during the course |
| ASM-43 | About ten model types; hand-written models are enough |
| ASM-44 | The team's GitHub plan supports required reviews |
| ASM-45 | Email and password sign-in stays inside the no-cost limits for the pilot |
| ASM-46 | A reason screen plus the system dialog satisfies the runtime-permission item |

| ID | Summary |
|---|---|
| OPEN-58 | Open the pub.dev pages: publisher, published date, constraints |
| OPEN-59 | Read Firebase Authentication quotas; decide sign-in methods |
| OPEN-60 | Which feature shows runtime permissions if barcode stays out of scope? |
| OPEN-61 | Application id: domain ownership and Play uniqueness |
| OPEN-62 | Minimum Android version of the plugins against Flutter's minSdk 24 |
| OPEN-63 | Confirm OSV-Scanner on `pubspec.lock`, obfuscation flags and the licence page |
| OPEN-64 | Re-read Gemini price and limit pages before GT-02 |
| OPEN-65 | Read the App Check provider for Android and its limits |
| OPEN-66 | Does `firebase_ai` expose a response schema for the chosen model? |
| OPEN-67 | `05-REQUIREMENTS.md` was missing; re-run the coverage rules when it exists |

## 11 Requirement coverage

Cross-check made on 2026-10-10, when `05-REQUIREMENTS.md` became available (`OPEN-67`, now closed). It maps each decision to the `FR-` and `NFR-` it serves, lists requirements that no decision covers, and lists the differences found and how each was resolved. The mapping is a judgement by the reviewer and is `Proposed` like the ADRs.

### 11.1 Decisions to requirements

| ADR | Decision | Requirements it serves |
|---|---|---|
| ADR-01 | Android first and only; iOS deferred | NFR-24 |
| ADR-02 | Android API levels | NFR-24 |
| ADR-03 | Flutter, Dart and toolchain policy | NFR-24 |
| ADR-04 | Standalone `material_ui` | none (platform or process policy) |
| ADR-05 | Architecture and folder layout | FR-18, FR-32, FR-33, FR-34, FR-35, FR-40, NFR-17 |
| ADR-06 | State management | FR-36, FR-38, FR-62 |
| ADR-07 | Navigation | FR-06, FR-07 |
| ADR-08 | Models and serialisation | FR-21, FR-22 |
| ADR-09 | Error handling and result types | FR-22, FR-23, FR-32, FR-48, FR-60, FR-62, NFR-07 |
| ADR-10 | Localisation and right-to-left | FR-06, FR-13, FR-15, FR-51, FR-52, FR-53, NFR-15 |
| ADR-11 | Firestore sync with offline persistence | FR-05, FR-17, FR-37, FR-42, FR-46, FR-47, NFR-03, NFR-04, NFR-05, NFR-06, NFR-27 |
| ADR-12 | Firestore data model, rules and rules tests | FR-01, FR-05, FR-08, FR-11, FR-12, FR-17, FR-28, FR-37, FR-46, FR-49, NFR-27 |
| ADR-13 | Local reference-data store | FR-14, FR-16, FR-25, FR-29, FR-40, FR-41, FR-54, FR-63, FR-64, FR-65, FR-66, FR-67, NFR-04, NFR-25 |
| ADR-14 | Secure local storage | FR-03, FR-06, FR-08, FR-12, NFR-11 |
| ADR-15 | Authentication | FR-01, FR-02, FR-04, FR-05, FR-11, NFR-11, NFR-26 |
| ADR-16 | AI access path | FR-10, FR-21, FR-23, FR-39, FR-48, NFR-01, NFR-02, NFR-08, NFR-09, NFR-26, NFR-28 |
| ADR-17 | Model selection rule and Remote Config | FR-30, NFR-01, NFR-02, NFR-28 |
| ADR-18 | Parse contract | FR-10, FR-18, FR-21, FR-22, FR-24, FR-27, FR-39, FR-50, NFR-29 |
| ADR-19 | Reference-data resolution order | FR-16, FR-20, FR-25, FR-26, FR-27, FR-28, FR-29, FR-39, FR-40, FR-41, FR-54, FR-63, FR-65, NFR-29 |
| ADR-20 | Barcode scanning and runtime permissions | FR-19, FR-61 |
| ADR-21 | Dio and the interceptor chain | FR-20, FR-56, FR-57, FR-58, FR-59, FR-60, NFR-01 |
| ADR-22 | Secrets policy and release hardening | FR-59, NFR-08 |
| ADR-23 | Dependency, licence and notices checks | FR-55, NFR-12 |
| ADR-24 | Privacy-safe logging, crash reporting and analytics | FR-07, FR-09, NFR-11, NFR-26 |
| ADR-25 | Test stack and coverage gate | FR-67, FR-68, NFR-07, NFR-17, NFR-21 |
| ADR-26 | Static analysis and formatting | NFR-20 |
| ADR-27 | Continuous integration | FR-53, FR-66, NFR-20, NFR-26 |
| ADR-28 | Branching, pull requests and documentation upkeep | NFR-18, NFR-19, NFR-23 |
| ADR-29 | Release format and application id | none (platform or process policy) |
| ADR-30 | History and charts | FR-42, FR-43, FR-44, FR-45, NFR-25 |

### 11.2 Requirements with no decision

| Requirement | Priority | Name | Finding |
|---|---|---|---|
| FR-31 | Should | The system shall limit each user to 30 analyses per day and shall show the rem... | No ADR says where the daily counter lives. `OPEN-76` |
| FR-69 | Must | Test builds shall write a local timing log of start of entry, start of analysi... | No ADR separates test builds from release builds. `OPEN-74` |
| FR-70 | Should | Test builds shall let the tester hide the source labels, and release builds sh... | Same gap as the timing log. `OPEN-74` |
| NFR-10 | Must | All network traffic shall use encrypted connections, and cleartext traffic sha... | No ADR on encrypted traffic; the Android default was not read [U]. `OPEN-75` |
| NFR-13 | Should | The System Usability Scale score shall be at least 68 with at least 5 users. | Usability test, no technology needed |
| NFR-14 | Should | The trust item (1 to 5) shall be at least 4.0 with source labels and higher th... | Usability test, no technology needed |
| NFR-16 | Should | Interactive elements shall be at least 48 by 48 dp. | Interaction design value; no technology decision |
| NFR-22 | Must | The documentation shall contain the three personas, marked provisional or vali... | Process requirement (personas and wireframes); no technology decision |

### 11.3 Differences between this log and the requirements

| Topic | Difference | Resolution |
|---|---|---|
| Secure storage | 05 first said the Keystore holds sign-in tokens (from TD-04); ADR-14 stores the consent record and the restriction-tag copy and leaves the Firebase session to the SDK | FR-03 rewritten; DAT-03, DAT-13 and INT-07 aligned in 05 |
| Analytics | ADR-24 adds no analytics and no crash reporting in the MVP; 05 required an opt-in event path | FR-09 now says nothing is sent without opt-in |
| Sign-in | ADR-15 proposes email and password; a reset flow is needed | FR-04 added; 05 no longer has its own sign-in open item (`OPEN-59`) |
| Model identifier | ADR-17 keeps the model id in Remote Config; 05 had dropped this as a design detail | FR-30 added (Should) |
| Error classes | ADR-09 lists sign-in and App Check failures; 05 had other classes | FR-60 now has 7 classes |
| Retry | ADR-21 retries GET only | FR-58 says GET only |
| Barcode and permission | ADR-20 is conditional on barcode scope; 05 had made the scan a Must | Same question, now one item: `OPEN-60` |
| Consent data | ADR-12 keeps the consent version in the cloud profile; ADR-14 keeps the record on the device | DAT-03 aligned; legal read in `OPEN-72` |
| Size limit | 05 is at its limit of 70 functional requirements after the two ADR-driven additions | The optional energy goal was dropped (now in the Won't list) |
| State management | ADR-06 now uses Bloc; TD-04 and KC-04 in `04-FEASIBILITY.md` had proposed Riverpod | 04 carries an update note; 05 names no library |
| Identifiers | Step 5 and step 6 both started at `ASM-39` and `OPEN-58` | Step 5 rows moved to `ASM-47` to `ASM-55` and `OPEN-68` to `OPEN-76` |
