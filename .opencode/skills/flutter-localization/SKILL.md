---
name: flutter-localization
description: Adds or extends localization in a Flutter project using the intl package and the intl_utils CLI. Use when the user asks to "add localization", "add i18n", "add a new language/locale", "translate the app", "add Arabic/RTL support", "wrap a string for translation", "add a new translation key", or works with .arb files / lib/l10n / lib/generated/l10n.dart / S.of(context). Defaults to English + Arabic with RTL support. Uses local ARB files only (no Localizely platform sync). CLI-only workflow — does not depend on any IDE extension.
---

# Flutter Localization (intl + intl_utils CLI)

Bind translations from `.arb` files to a Flutter app using the official [`intl`](https://pub.dev/packages/intl) package, with code generation handled by the [`intl_utils`](https://pub.dev/packages/intl_utils) CLI. Defaults to **English (`en`) + Arabic (`ar`) with RTL support**.

This is the same generator the Flutter Intl IDE extensions wrap — using it directly means the workflow runs anywhere (CI, terminal, any editor) with no extension dependency.

## Assumptions

- `pubspec.yaml` is at the project root.
- ARB files live in `lib/l10n/` and generated code in `lib/generated/`.
- Dart / Flutter SDK is on `PATH`.

---

## One-time tool install

Install `intl_utils` globally on the dev machine (and in CI):

```bash
dart pub global activate intl_utils
```

Make sure `~/.pub-cache/bin` is on `PATH` — the activate step prints a warning if not. After this, the `generate` command is available as:

```bash
dart run intl_utils:generate
```

(works without the global activate too if `intl_utils` is added as a dev dependency, but global is the standard setup).

---

## Decision tree — pick the right workflow

Figure out which of these the user is asking for. Each maps to a section below:

1. **Project has no localization yet** → run the **Initial Setup** flow.
2. **Project is already localized; user wants a new locale** (e.g. "add French") → **Add a Locale**.
3. **User wants to add/edit a translation string** (new key, or change wording) → **Add or Edit a Message**.
4. **User wants to use a string in a widget** (`Text('Hello')` → localized) → **Use a Message in Code**.
5. **User wants RTL / bidirectional behavior to work correctly** → **RTL Support**.
6. **Generated files are stale / `S.of(context).foo` is red** → **Regenerate**.
7. **Something is broken** → **Troubleshooting** (see [reference.md](reference.md)).

If unsure, ask the user which one — don't guess.

---

## 1. Initial Setup (project has no localization)

### Step 1 — Add dependencies to `pubspec.yaml`

Add **`intl`** and **`flutter_localizations`** under `dependencies`, and add the **`flutter_intl`** config block at the root level:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: any  # let Flutter SDK pin the version; see Troubleshooting if conflicts arise

# intl_utils config — keep at root level, not under `flutter:`
flutter_intl:
  enabled: true
  class_name: S          # generated class name, used as S.of(context)
  main_locale: en        # source-of-truth locale; others are translated from this
  arb_dir: lib/l10n      # where intl_<locale>.arb files live
  output_dir: lib/generated  # where generated Dart goes — DO commit, do NOT hand-edit
```

Then:

```bash
flutter pub get
```

> **Note on `intl` version:** `flutter_localizations` pins a specific `intl` version. Using `any` lets the resolver pick the compatible one. If you need to pin explicitly, run `flutter pub get` first, then check `pubspec.lock` for the resolved version.

### Step 2 — Create the ARB directory and main locale file

```bash
mkdir -p lib/l10n
```

Create `lib/l10n/intl_en.arb` with minimal content:

```json
{
  "@@locale": "en"
}
```

Create `lib/l10n/intl_ar.arb`:

```json
{
  "@@locale": "ar"
}
```

### Step 3 — Generate the boilerplate

From the project root:

```bash
dart run intl_utils:generate
```

This creates:

- `lib/generated/l10n.dart` (the `S` class — entry point for translations)
- `lib/generated/intl/messages_all.dart`
- `lib/generated/intl/messages_en.dart`
- `lib/generated/intl/messages_ar.dart`

⚠️ **Do not hand-edit anything in `lib/generated/`** — it is regenerated on every run. But **do commit it** to git; CI builds depend on it (or, alternatively, gitignore it and regenerate in CI — pick one and document it).

### Step 4 — Wire up `MaterialApp`

Edit the app's root widget (usually `lib/main.dart` or `lib/app.dart`):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart'; // adjust path if your output_dir differs

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tell Flutter which locales the app supports.
      supportedLocales: S.delegate.supportedLocales,
      // Delegates load the actual translation tables.
      localizationsDelegates: const [
        S.delegate,                              // your generated translations
        GlobalMaterialLocalizations.delegate,    // Material widget translations
        GlobalWidgetsLocalizations.delegate,     // text direction etc.
        GlobalCupertinoLocalizations.delegate,   // Cupertino widget translations
      ],
      // Pick the best supported locale based on the device locale.
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale == null) return supportedLocales.first;
        for (final supported in supportedLocales) {
          if (supported.languageCode == deviceLocale.languageCode) {
            return supported;
          }
        }
        return supportedLocales.first;
      },
      home: const HomePage(),
    );
  }
}
```

### Step 5 — iOS: declare locales in `Info.plist`

iOS does not pick up locales from Dart automatically. Edit `ios/Runner/Info.plist` and add:

```xml
<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>ar</string>
</array>
```

Without this, iOS users on Arabic devices will still see the app in English.

### Step 6 — Verify

Add one test message (see **Add or Edit a Message** below), regenerate, then run the app. Confirm both locales render. Done.

---

## 2. Add a Locale (project already initialized)

### Step 1 — Create the new ARB file

```bash
echo '{ "@@locale": "fr" }' > lib/l10n/intl_fr.arb
```

(Replace `fr` with whatever locale code you need — `es`, `zh_Hans`, `pt_BR`, etc.)

### Step 2 — Copy keys from the main locale

Open `lib/l10n/intl_en.arb`, copy each translatable key, and paste into the new file with translated values. Keep placeholder names identical (see **Mismatched placeholders** in [reference.md](reference.md)).

### Step 3 — Regenerate

```bash
dart run intl_utils:generate
```

### Step 4 — Update `Info.plist`

Add the new locale code to `ios/Runner/Info.plist` under `CFBundleLocalizations`.

---

## 3. Add or Edit a Message

The main locale's ARB file (`lib/l10n/intl_en.arb`) is the source of truth. Add the key there first, then translate to other locales.

### Simple message

In `lib/l10n/intl_en.arb`:

```json
{
  "@@locale": "en",
  "welcomeMessage": "Welcome!",
  "@welcomeMessage": {
    "description": "Greeting shown on the home screen the first time the app opens"
  }
}
```

In `lib/l10n/intl_ar.arb`:

```json
{
  "@@locale": "ar",
  "welcomeMessage": "أهلاً بك!"
}
```

### Message with a placeholder

```json
{
  "greetUser": "Hello, {name}!",
  "@greetUser": {
    "description": "Greets a logged-in user by name",
    "placeholders": {
      "name": { "type": "String", "example": "Sara" }
    }
  }
}
```

Arabic version:

```json
{
  "greetUser": "مرحباً يا {name}!"
}
```

### Plurals, gender/select, number and date formatting

See [reference.md](reference.md) for ICU plural/select examples, `NumberFormat` / `DateFormat` placeholder metadata, Arabic plural rules, and validation details.

### After editing any ARB file — always regenerate

```bash
dart run intl_utils:generate
```

There is no auto-watch in this CLI-only setup. After every ARB change, run the generator manually. Consider adding a Cursor command or a shell alias:

```bash
alias l10n='dart run intl_utils:generate'
```

### ARB validation rules the generator enforces

- Placeholder names referenced in the message string must be declared in `placeholders`.
- Placeholder names must match across all locales for the same key.
- `plural` placeholders must be `int` (or `num`).
- Every `plural` and `select` block must have an `other` branch.
- Keys must be valid Dart identifiers (camelCase, no spaces, no leading digit).
- ARB is strict JSON — no trailing commas, no comments, no single quotes.

### Naming conventions

- camelCase keys: `welcomeMessage`, `errorNetworkUnavailable`.
- Group by feature with a prefix: `loginButton`, `loginErrorPassword`, `loginHintEmail`.
- Avoid encoding the English wording in the key (`hello` is fine; `helloWorld` is brittle if the wording changes).

---

## 4. Use a Message in Code

Once the key exists in the ARB file and generated code is fresh:

```dart
import 'package:your_app/generated/l10n.dart';

// Simple:
Text(S.of(context).welcomeMessage)

// With a placeholder:
Text(S.of(context).greetUser('Sara'))

// Plural:
Text(S.of(context).itemCount(cart.length))
```

**Replacing existing hardcoded strings:** when migrating a screen, walk through every user-facing `Text(...)`, `SnackBar`, `AlertDialog`, `AppBar(title: ...)`, `hintText`, etc. Each becomes `S.of(context).<key>`. Strings that are not user-facing (debug logs, asset keys, route names) stay as plain literals.

**Outside a `BuildContext`** (e.g. in a service class): use `S.current` (set automatically by the delegate based on the active locale). Prefer passing `context` / `S.of(context)` when possible — it's reactive to locale changes.

---

## 5. RTL Support (Arabic)

Once `ar` is in `supportedLocales`, Flutter automatically flips `Directionality` to RTL when the device runs in Arabic. Most layout works without changes if you follow these rules:

- **Use `EdgeInsetsDirectional`** instead of `EdgeInsets` whenever a side matters semantically (start/end of reading order):

  ```dart
  // ✅ flips correctly in RTL
  padding: const EdgeInsetsDirectional.only(start: 16, end: 8)

  // ❌ stays the same in RTL — wrong for Arabic
  padding: const EdgeInsets.only(left: 16, right: 8)
  ```

- **Use `AlignmentDirectional`** instead of `Alignment` for the same reason (`AlignmentDirectional.centerStart` flips, `Alignment.centerLeft` does not).
- **Icons:** directional icons (back arrow, forward chevron) should use the `_rounded` / `_sharp` directional variants where Flutter provides them, or wrap with `Transform.flip` keyed on `Directionality.of(context)`. Non-directional icons (settings gear, search) stay as-is.
- **`Row` and horizontal layouts** automatically reverse — do not manually swap `children` order for RTL.
- **Numbers, dates, currency:** use `intl`'s `NumberFormat` and `DateFormat` with the current locale; do not concatenate manually. Arabic numerals vs Eastern Arabic numerals (٠١٢٣) are handled by `NumberFormat` based on locale.

For one-off forced direction (e.g. always-LTR username field inside an Arabic app), wrap with `Directionality(textDirection: TextDirection.ltr, child: ...)`.

To force-test RTL without changing device language, add at the top of `MaterialApp`:

```dart
locale: const Locale('ar'),  // remove after testing
```

---

## 6. Regenerate

After editing any ARB file:

```bash
dart run intl_utils:generate
```

If `S.of(context).myKey` still shows red after regeneration:

1. Confirm the key exists in `intl_en.arb` (the main locale). Keys missing from the main locale are not generated, even if they exist in other locales.
2. Confirm `lib/generated/l10n.dart` was actually updated (check git diff).
3. Restart the Dart Analysis Server (`Cmd/Ctrl+Shift+P` → "Dart: Restart Analysis Server").
4. `flutter clean && flutter pub get && dart run intl_utils:generate`.

---

## 7. CI integration

Add to your pipeline (GitHub Actions example):

```yaml
- uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.x'

- run: flutter pub get
- run: dart pub global activate intl_utils
- run: dart run intl_utils:generate
- run: flutter analyze
- run: flutter test
```

Two strategies for `lib/generated/`:

1. **Commit generated files** — CI regenerates and `git diff` should be empty; if not, fail the build (forces devs to commit fresh generated code).
2. **Gitignore generated files** — CI always regenerates before build/test. Cleaner repo, but every fresh checkout needs a generation step before the IDE works.

Pick one and stick to it.

---

## Common pitfalls

- **Editing `lib/generated/` by hand.** It will be overwritten on next `intl_utils:generate`. Edit the ARB file instead.
- **Forgetting to regenerate after editing an ARB.** No watcher in CLI-only setup. Always run `dart run intl_utils:generate`.
- **Forgetting `Info.plist` on iOS.** The app compiles, runs, but ignores Arabic on Arabic devices.
- **Adding a key only to `intl_ar.arb` but not `intl_en.arb`.** The main locale defines the API; missing keys there mean the getter is never generated. Always add to the main locale first.
- **Using `EdgeInsets.only(left: ...)` in shared widgets.** Breaks RTL silently. Use `EdgeInsetsDirectional`.
- **Plural without `other`.** ICU requires it; the generator will throw.
- **Mismatched placeholders between locales.** If `intl_en.arb` has `{name}` and `intl_ar.arb` has `{userName}`, generation fails or runtime crashes. Keep placeholder names identical across locales.

---

## File layout reference

```
project_root/
├── pubspec.yaml                       # contains flutter_intl: block
├── ios/Runner/Info.plist              # CFBundleLocalizations
├── lib/
│   ├── main.dart                      # MaterialApp wired with S.delegate
│   ├── l10n/                          # ← edit these
│   │   ├── intl_en.arb                # main locale, source of truth
│   │   └── intl_ar.arb                # Arabic translations
│   └── generated/                     # ← never hand-edit, regenerated by intl_utils
│       ├── l10n.dart                  # the S class
│       └── intl/
│           ├── messages_all.dart
│           ├── messages_en.dart
│           └── messages_ar.dart
```

---

## Quick command reference

```bash
# Install the generator (once per machine)
dart pub global activate intl_utils

# Regenerate after any ARB edit
dart run intl_utils:generate

# Add a locale
echo '{ "@@locale": "fr" }' > lib/l10n/intl_fr.arb
dart run intl_utils:generate

# Full reset when things are weird
flutter clean && flutter pub get && dart run intl_utils:generate
```

---

## Additional resources

- Full ARB patterns (plurals, select, number/date placeholders) and **Troubleshooting**: [reference.md](reference.md)
