---
name: figma-mcp-local-images
description: When generating Flutter code from a Figma design via the Figma MCP server (Figma:get_design_context, Figma:get_metadata, Figma:get_screenshot, Figma:use_figma, etc.), do NOT download images from Figma's CDN, do NOT use Image.network(...), and do NOT embed base64 image data. Assume images already exist locally on disk under assets/. The workflow is: locate the local file → run flutter_gen to generate the accessor → use Assets.* getter. If a referenced image cannot be located locally, prompt the user for the asset name instead of falling back to a network URL. Use whenever the conversation involves Figma URLs, file keys, node IDs, or any Figma MCP tool output that contains image references.
---

# Figma MCP — Local Images Only

When the Figma MCP returns design context for code generation, the response typically includes image references — Figma CDN URLs (`https://figma-alpha-api.s3.us-west-2.amazonaws.com/...`), `<img src="..."/>` tags in the reference code, or download URLs in a side payload. **Ignore all of those.** This project's images already exist locally on disk under `assets/`. The job is to:

1. Locate the local file that corresponds to each Figma image reference.
2. Run `flutter_gen` to produce the type-safe accessor.
3. Use the generated `Assets.*` getter in code.

If a local file can't be found, **stop and ask** — do not download anything from Figma.

---

## Hard rules

1. **Never call `Image.network(...)`** in generated code, regardless of what the Figma reference code suggests.
2. **Never download images** from Figma URLs — no `web_fetch`, no `curl`, no `http.get` against Figma CDN domains, no `Figma:upload_assets` for round-tripping.
3. **Never embed base64 image data** as a fallback.
4. **Never write raw asset paths** like `Image.asset('assets/images/logo.png')`. Use the `flutter_gen` accessor: `Assets.images.logo.image()`.
5. **Do not assume the accessor already exists.** Locate the file on disk, then run the generator, then use the accessor.
6. **If an image can't be located locally, ask the user.** Do not silently substitute a placeholder, a network URL, or a similarly-named asset.

---

## The workflow — every Figma-to-code request

### Step 1 — Read the design context

Call `Figma:get_design_context` with the `fileKey` and `nodeId` extracted from the user's Figma URL. The response includes:

- Reference code the MCP suggests as a starting point
- A screenshot of the node
- An `assets` / `images` payload with Figma CDN download URLs

### Step 2 — Inventory the images the design references

Before writing any Flutter code, enumerate every distinct image in the design. For each one, capture whatever the MCP reveals:

- The **layer name** in Figma (e.g. `logo_primary`, `hero_bg`, `icon_search`)
- The **rendered dimensions** (width × height)
- The **format** (PNG vs SVG vs JPG — inferable from the Figma node type: vector → SVG, raster → PNG/JPG)

Use `Figma:get_metadata` if the design context didn't expose layer names clearly. Layer names are the bridge between the Figma reference and the local file.

### Step 3 — Locate each image on disk

For each referenced image, find a matching file under `assets/`. Search in this order:

```bash
# Exact match by Figma layer name (most common when designers and devs agree on naming)
ls assets/images/<layer_name>.* assets/icons/<layer_name>.* 2>/dev/null

# Fuzzy match — strip prefixes/suffixes designers add
find assets -type f \( -name "*<layer_name>*" -o -iname "*<layer_name_normalized>*" \)

# Search by visual category if name doesn't match (e.g. it's clearly a logo)
ls assets/images/ assets/icons/
```

Normalization to try in order:

- `logo_primary` → `logo_primary`, `logoPrimary`, `logo-primary`, `primary_logo`, `logo`
- Strip Figma artifacts like trailing numbers (`hero_bg_2x` → `hero_bg`).
- Match the format: a Figma vector node corresponds to `.svg`; a raster fill corresponds to `.png` / `.jpg` / `.webp`.

If exactly one local file matches → record it. Move on.
If multiple plausible matches → **ask the user which one**, do not guess.
If nothing matches → see Step 5.

### Step 4 — Generate the accessor, then use it

Once every Figma image is mapped to a local file path, regenerate the accessors **before** writing widget code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

(If `flutter_gen` isn't set up in the project yet, stop and load the `flutter-gen` skill — initial setup is a prerequisite, not part of this workflow.)

Then verify each expected accessor exists in `lib/gen/assets.gen.dart`:

```bash
grep -E "get (logoPrimary|heroBg|iconSearch)" lib/gen/assets.gen.dart
```

Now write the widget code using the generated getters:

```dart
import 'package:your_app/gen/assets.gen.dart';

// Raster (PNG/JPG/WebP)
Assets.images.logoPrimary.image(width: 120, height: 120, fit: BoxFit.contain)

// SVG
Assets.icons.iconSearch.svg(width: 24, height: 24)

// As an ImageProvider
DecorationImage(image: Assets.images.heroBg.provider(), fit: BoxFit.cover)
```

### Step 5 — When an image can't be located: ask the user

If after Step 3 a referenced image has no local match, **stop code generation** and prompt the user. Use this exact format so it's unmistakable:

> **❓ Missing local asset**
>
> The Figma design references an image I can't find in `assets/`:
> - **Figma layer:** `<layer_name>`
> - **Format:** `<svg | png | jpg>`
> - **Size:** `<width>×<height>`
> - **Used in:** `<screen / component name from the design>`
>
> What's the local file name for this asset (relative to `assets/`)? For example: `images/hero_bg.png` or `icons/search.svg`.
>
> If this asset hasn't been added yet, add it to `assets/` first, then tell me the path.

If `ask_user_input_v0` is available in this environment, use it with a single text prompt instead of plain prose. Either way: **wait for the answer** before continuing. Do not proceed with placeholder code.

If the user confirms the asset doesn't exist yet, the correct response is to halt code generation entirely and let them know the design needs the asset on disk first — not to download it from Figma, not to generate a placeholder.

### Step 6 — Final verification before delivering code

Before returning the generated Flutter code to the user, scan it for these prohibited patterns:

```bash
# These should ALL return zero matches in the generated file
grep -nE "Image\.network|NetworkImage" <generated_file>
grep -n   "https://figma" <generated_file>
grep -n   "data:image" <generated_file>
grep -nE "Image\.asset\(['\"]" <generated_file>   # raw string Image.asset
```

If any match: rewrite that section using the `Assets.*` accessor before sending the code.

---

## Handling multiple images in a single design

For a screen with many images, batch the inventory step. Build a single mapping table before any code is written:

| Figma layer    | Format | Local file                  | flutter_gen accessor          |
| -------------- | ------ | --------------------------- | ----------------------------- |
| `logo_primary` | PNG    | `assets/images/logo.png`    | `Assets.images.logo`          |
| `hero_bg`      | JPG    | `assets/images/hero_bg.jpg` | `Assets.images.heroBg`        |
| `icon_search`  | SVG    | `assets/icons/search.svg`   | `Assets.icons.search`         |
| `avatar_user`  | PNG    | **MISSING — ask user**      | —                             |

Resolve every missing row (Step 5) before running the generator and writing code. One round of questions, not one per image.

---

## What about icons that come from a font / icon set, not an image?

Many designs use Material Icons, Cupertino Icons, or a custom icon font rendered as glyphs in Figma. These are not images and should not be looked up under `assets/`. Heuristic:

- If the Figma node is a **vector with a recognizable glyph name** matching a Material/Cupertino icon, render `Icon(Icons.<name>)`.
- If the design system uses a custom icon font (project has a `fonts.gen.dart` font family for icons), use that font with the matching code point.
- If neither applies, treat it as an SVG and follow the workflow above.

---

## What about images the user wants placeholder-rendered for now?

If the user explicitly asks ("just stub the images for now, I'll add them later"), use a colored `Container` of the correct dimensions with a comment indicating the missing asset:

```dart
// TODO(asset): replace with Assets.images.heroBg once added
Container(
  width: 375,
  height: 240,
  color: AppColors.background,
)
```

Never use a network image as a placeholder. Never use a Figma CDN URL as a placeholder. The `TODO` is the placeholder.

---

## Why this skill exists

- **Figma CDN URLs are short-lived.** They expire. Code that runs today crashes next week.
- **Production apps need bundled assets.** Network images cost data, fail offline, and break in CI/CD environments without internet.
- **`flutter_gen` is the single source of truth.** Mixing `Assets.*` getters with `Image.network` for "design images" creates two sources of truth — one safe, one fragile — for the same kind of content.
- **Type safety end-to-end.** A typo in a Figma layer name surfaces as a missing local file (caught in Step 3) instead of a runtime 404.

---

## See also

- `flutter-gen` skill — the underlying asset generator. Run its setup first if `lib/gen/assets.gen.dart` doesn't exist yet.
- `flutter-asset-rules.mdc` rule — the always-on enforcement that backs this skill (no raw string asset paths, no duplicate registration).
