---
name: flutter-gen
description: Set up and use the flutter_gen package to generate type-safe accessors for assets, fonts, and colors in a Flutter project. Use when the user asks to "add an image", "add an asset", "use flutter_gen", "set up assets", "add a font", "add a color", "generate assets", or works with files in assets/, lib/gen/, *.gen.dart, Assets.images.*, FontFamily.*, or ColorName.*. Replaces error-prone string paths like Image.asset('assets/images/logo.png') with type-safe getters like Assets.images.logo.image(). CLI-only workflow using build_runner — no IDE extension required.
---

# flutter_gen — type-safe assets, fonts, and colors

[`flutter_gen`](https://pub.dev/packages/flutter_gen) generates Dart code from your `pubspec.yaml` asset declarations so you can write `Assets.images.logo.image()` instead of `Image.asset('assets/images/logo.png')`. Typos become compile errors, IDE autocomplete works, and renaming a file is a refactor instead of a string-search.

## Assumptions

- `pubspec.yaml` is at the project root.
- Assets live under `assets/` (the conventional Flutter layout).
- Generated code goes to `lib/gen/` (the package default).
- This skill uses **`build_runner`** as the generation method — no global tools, no IDE extensions.

---

## Decision tree

1. **Project doesn't have flutter_gen yet** → **Initial Setup**.
2. **User wants to add a new image / SVG / font / asset** → **Adding Assets**.
3. **User wants to use a generated asset in a widget** → **Using Generated Assets**.
4. **User wants colors generated from XML** → **Colors**.
5. **Generated files are stale / `Assets.images.foo` is red** → **Regenerate**.
6. **Something is broken** → **Troubleshooting**.

---

## 1. Initial Setup

### Step 1 — Add dependencies

Edit `pubspec.yaml`:

```yaml
environment:
  sdk: ^3.7.0

dev_dependencies:
  build_runner: ^2.12.0
  flutter_gen_runner:
```

> `flutter_gen_runner` requires `build_runner >= 2.12.0` (it relies on post-process builders with `build_to: source`). Older `build_runner` versions will fail with confusing errors.

If the project also uses `flutter_svg`, `lottie`, or `rive`, make sure those are in `dependencies` (not `dev_dependencies`):

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.0    # only if you have .svg assets
  lottie: ^3.0.0         # only if you have Lottie files
  rive: ^0.13.0          # only if you have .riv files
```

Then:

```bash
flutter pub get
```

### Step 2 — Add the `flutter_gen` config block

Add to `pubspec.yaml` at the **root level** (not under `flutter:`):

```yaml
flutter_gen:
  output: lib/gen/         # default; change only if you want a different folder
  line_length: 80          # optional

  integrations:
    image: true            # generate AssetGenImage with .image() / .provider()
    flutter_svg: true      # generate .svg() returning SvgPicture — needs flutter_svg in deps
    lottie: false          # set true if you use Lottie
    rive: false            # set true if you use Rive
```

Only set integrations to `true` for packages actually in your `dependencies`. A `true` integration without the matching package will fail compilation of the generated file.

### Step 3 — Declare your asset folders

Under the `flutter:` key (the standard Flutter section):

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
    - assets/fonts/        # only if fonts are referenced as fonts: below
```

Trailing-slash paths include **everything in the directory** (non-recursive). For nested folders, list each one or use individual file paths.

### Step 4 — Create the asset folders

```bash
mkdir -p assets/images assets/icons
```

Drop at least one file in each declared folder before running the generator — `flutter_gen` will produce empty stubs otherwise, and `flutter pub get` warns about empty asset directories.

### Step 5 — Generate

```bash
dart run build_runner build --delete-conflicting-outputs
```

This produces `lib/gen/assets.gen.dart`. The `--delete-conflicting-outputs` flag is safe and recommended for the first run; it clears stale generated files.

For active development, run watch mode in a separate terminal so files regenerate automatically:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

### Step 6 — Verify

Drop a placeholder file like `assets/images/test.png`, regenerate, then in any widget:

```dart
import 'package:your_app/gen/assets.gen.dart';

Image testImage = Assets.images.test.image();
```

If autocomplete shows `test`, you're done.

### About `lib/gen/` and git

Two valid strategies — pick one and document it:

- **Commit `lib/gen/`** — devs and CI both have it ready; `git diff` after regen should be empty.
- **Gitignore `lib/gen/`** — CI regenerates before build/test. Cleaner repo, but every fresh checkout needs `dart run build_runner build` before the IDE works.

Most teams commit it. **Never hand-edit anything in `lib/gen/`** either way.

---

## 2. Adding Assets

> **Cursor rule reminder:** if `image-generation-required` and `no-duplicate-image-registration` rules are installed, every image addition must follow them. See those rules for the full process. The summary: image must exist before being referenced in code, and the same file must not be registered twice in `pubspec.yaml`.

### Adding a raster image (PNG, JPG, WebP, GIF)

1. Place the file in the asset folder, e.g. `assets/images/logo.png`.
2. Confirm the **parent folder** is declared in `pubspec.yaml` under `flutter > assets`:
   ```yaml
   flutter:
     assets:
       - assets/images/      # already covers logo.png
   ```
   If the folder is already listed, you do **not** add the file individually — that creates a duplicate registration.
3. Regenerate:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
4. Use it: `Assets.images.logo.image()`.

### Adding an SVG

SVG works like a raster image but generates an `.svg()` method (returning `SvgPicture`) instead of `.image()`. Requires:
- `flutter_svg` in `dependencies`.
- `flutter_gen.integrations.flutter_svg: true` in `pubspec.yaml`.

Steps:

1. Place the file: `assets/icons/menu.svg`.
2. Make sure the folder is declared (and only the folder, not the file again).
3. Regenerate.
4. Use it: `Assets.icons.menu.svg(width: 24, height: 24)`.

**SVG with `vector_graphics_compiler`** (compiles SVG to a binary format at build time, faster runtime decode):

```yaml
flutter:
  assets:
    - assets/icons/                  # other icons covered by folder
    - path: assets/icons/heavy.svg   # individual file with transformer
      transformers:
        - package: vector_graphics_compiler
```

Generated code uses `AssetBytesLoader` automatically for transformed assets — no usage difference at the call site.

> **Watch out:** declaring `assets/icons/` AND `assets/icons/heavy.svg` registers the same file twice. Either declare the folder OR list each file individually with its transformer — not both. See `no-duplicate-image-registration` rule.

### Adding a font

```yaml
flutter:
  fonts:
    - family: Raleway
      fonts:
        - asset: assets/fonts/Raleway-Regular.ttf
        - asset: assets/fonts/Raleway-Italic.ttf
          style: italic
        - asset: assets/fonts/Raleway-Bold.ttf
          weight: 700
```

After regeneration, `lib/gen/fonts.gen.dart` exposes:

```dart
TextStyle(fontFamily: FontFamily.raleway)
```

### Excluding files from generation

```yaml
flutter_gen:
  assets:
    exclude:
      - assets/images/temp/**
      - assets/images/draft.png
```

Glob patterns from `package:glob`. Useful for work-in-progress assets you don't want polluting the generated API yet.

### Naming conventions (auto-applied)

- The root prefix `assets/` or `asset/` is **dropped** from the generated path.
- Folders become nested classes: `assets/images/logo.png` → `Assets.images.logo`.
- Special chars are camelCased: `assets/images/icon@2x.png` → `Assets.images.icon2x`.
- Output style is configurable: `dot-delimiter` (default), `camel-case`, or `snake-case`. Pick one in `flutter_gen.assets.outputs.style` and stick to it.

---

## 3. Using Generated Assets

### Images

```dart
import 'package:your_app/gen/assets.gen.dart';

// As a widget — most common:
Assets.images.logo.image(width: 120, height: 120, fit: BoxFit.contain)

// As an ImageProvider (e.g. for DecorationImage, CircleAvatar):
DecorationImage(image: Assets.images.logo.provider(), fit: BoxFit.cover)

// As a path string (rarely needed; use only when the API requires String):
Image.asset(Assets.images.logo.path)
```

### SVGs

```dart
// Returns SvgPicture (from flutter_svg):
Assets.icons.menu.svg(width: 24, height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn))
```

For SVGs **without** the integration enabled, the generator falls back to a String constant:

```dart
SvgPicture.asset(Assets.icons.menu)   // when integrations.flutter_svg: false
```

Prefer enabling the integration — the typed `.svg()` method is safer.

### Fonts

```dart
Text(
  'Hello',
  style: TextStyle(
    fontFamily: FontFamily.raleway,
    fontFamilyFallback: const [FontFamily.robotoMono],
  ),
)
```

### Lottie / Rive (if integrations enabled)

```dart
Assets.lottie.loading.lottie(width: 200)        // returns Lottie widget
Assets.rive.vehicles.rive(width: 200)           // returns RiveAnimation widget
```

### Image metadata (optional)

If you set `flutter_gen.parse_metadata: true`, the generator reads each image's intrinsic size at build time and adds it to the constant:

```dart
final size = Assets.images.logo.size;   // Size(209.0, 49.0) — known without loading
```

Useful for layouts that need dimensions before the image decodes. Slows generation slightly.

---

## 4. Colors (XML → Dart)

Define colors in an Android-style XML file:

```xml
<!-- assets/color/colors.xml -->
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="brand_primary">#0D47A1</color>
    <color name="brand_accent" type="material">#FF6F00</color>
    <color name="warning" type="material material-accent">#F57F17</color>
</resources>
```

Register in `pubspec.yaml`:

```yaml
flutter_gen:
  colors:
    inputs:
      - assets/color/colors.xml
```

Regenerate. Now:

```dart
Container(color: ColorName.brandPrimary)
TextButton(style: TextButton.styleFrom(foregroundColor: ColorName.brandAccent))
```

The `type="material"` attribute generates a full `MaterialColor` swatch (50–900); add `material-accent` for accent colors. Without `type`, it's a plain `Color`.

---

## 5. Regenerate

After **any** change to assets, fonts, colors, or the `flutter_gen` config:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Or run watch mode once and forget about it:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

If `Assets.images.foo` is red after generation:

1. Confirm the file exists at the expected path on disk.
2. Confirm the folder is declared in `pubspec.yaml > flutter > assets`.
3. Confirm it's not in `flutter_gen.assets.exclude`.
4. Restart the Dart Analysis Server (`Cmd/Ctrl+Shift+P` → "Dart: Restart Analysis Server").
5. `flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs`.

---

## 6. CI integration

GitHub Actions example:

```yaml
- uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.x'

- run: flutter pub get
- run: dart run build_runner build --delete-conflicting-outputs
- run: flutter analyze
- run: flutter test
```

If `lib/gen/` is committed, add a check that regeneration produces no diff:

```yaml
- run: dart run build_runner build --delete-conflicting-outputs
- run: git diff --exit-code lib/gen/   # fails if generated files are out of date
```

---

## 7. Troubleshooting

### `Bad state: No element` from `flutter_gen_runner`

You have a custom `build.yaml` that doesn't include `pubspec.yaml` as a build source. Add it:

```yaml
# build.yaml
targets:
  $default:
    sources:
      include:
        - pubspec.yaml
        - lib/**
        - assets/**
```

### Generation succeeds but the file isn't there / is empty

- Make sure at least one file exists in the declared asset folders. `flutter_gen` skips empty folders silently.
- Check `flutter_gen.assets.exclude` — your file may match an exclude glob.
- Run with verbose logging: `dart run build_runner build --verbose --delete-conflicting-outputs`.

### "The asset does not exist" at runtime, even though `Assets.images.foo` compiles

`flutter_gen` generates code from `pubspec.yaml` declarations, not from the actual filesystem. If the file path changed but `pubspec.yaml` still lists the old folder, generation succeeds but the bundle doesn't contain the file. Check that the file is actually under a folder declared in `flutter > assets`.

### `flutter_gen_runner` conflict with localization (`generate: true`)

Older Flutter localization (`flutter > generate: true`) used a synthetic package that conflicted with `flutter_gen_runner`. Fix:

```yaml
# pubspec.yaml
flutter:
  # generate: true   ← remove
```

```yaml
# l10n.yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
synthetic-package: false
```

(See the `flutter-localization` skill for the recommended `intl_utils` setup, which doesn't have this conflict.)

### SVG `.svg()` method is missing on generated assets

Three things to check, in order:
1. `flutter_svg` is in `dependencies` (not `dev_dependencies`).
2. `flutter_gen.integrations.flutter_svg: true` is set.
3. You ran the generator after enabling it.

### Watch mode doesn't pick up new files

`build_runner watch` watches files declared in `sources.include` (in `build.yaml`). If you added `assets/icons/` to `pubspec.yaml` but `build.yaml` only includes `assets/images/**`, new icons aren't seen. Either widen the include to `assets/**` or stop using a custom `build.yaml`.

### Asset registered twice → analyzer warns about duplicate paths

Common causes: declaring a folder `assets/icons/` AND a specific file `assets/icons/menu.svg` inside it. Fix per the `no-duplicate-image-registration` rule — pick one form, not both.

### `flutter pub get` warns "no file or variants found" for an asset folder

The folder is declared in `pubspec.yaml` but is empty or doesn't exist on disk. Either create the folder + a file, or remove the declaration.

---

## File layout reference

```
project_root/
├── pubspec.yaml                    # flutter_gen: + flutter.assets: blocks
├── build.yaml                      # optional, only if you need custom builder options
├── assets/
│   ├── images/                     # raster images (PNG, JPG, WebP, GIF)
│   ├── icons/                      # SVGs typically
│   ├── fonts/                      # .ttf / .otf font files
│   └── color/colors.xml            # color definitions (optional)
└── lib/
    ├── main.dart
    └── gen/                        # ← generated, never hand-edit
        ├── assets.gen.dart
        ├── fonts.gen.dart
        └── colors.gen.dart
```

---

## Quick command reference

```bash
# One-time setup install (handled by `flutter pub get` once deps are in pubspec)
flutter pub get

# Generate once
dart run build_runner build --delete-conflicting-outputs

# Watch and regenerate on change (run in a side terminal)
dart run build_runner watch --delete-conflicting-outputs

# Nuclear option when things are weird
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```
