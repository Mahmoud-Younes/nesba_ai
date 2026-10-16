---
name: flutter-assets-generate-no-duplicates
description: Add images/assets under assets/ without duplicates, register them once in pubspec.yaml, then run flutter_gen and use the generated Assets.* accessors. Use whenever adding, changing, or referencing an image/SVG/asset, building UI from Figma, or editing the pubspec assets block. Never write raw Image.asset('assets/...') string paths and never register the same file twice.
---

# Images & assets — generate first, no duplicates (fit_flow)

When adding or changing **images or other assets** under `assets/`:

1. **Check for duplicates before adding**
   - Do not list the same path twice under `flutter: assets:` in `pubspec.yaml`.
   - Do not add a second file that duplicates an existing asset for the same use. If a redundant copy was added, remove the extra (not the original) unless the team agrees to replace it.

2. **Register assets correctly**
   - New files must live under a directory already covered by `pubspec.yaml`, or add a new folder line there (trailing slash for directory includes).

3. **Regenerate in the same change set**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

   Run before treating the task as done so `lib/gen/` (e.g. `assets.gen.dart`) matches the filesystem. Never hand-edit `lib/gen/`.

4. **Use generated accessors in UI**
   - Prefer `Assets.images.*` / `Assets.svg.*` from `package:fit_flow/gen/assets.gen.dart`, not `Image.asset('assets/...')` string paths.

**If a Figma design references an image with no local match:** stop and ask the user — do not download from the Figma CDN, use `Image.network`, or embed base64. See the `figma-mcp-local-images` skill. If `flutter_gen` is not wired yet, see the `flutter-gen` skill.
