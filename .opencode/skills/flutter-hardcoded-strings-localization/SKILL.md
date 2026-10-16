---
name: flutter-hardcoded-strings-localization
description: Localize every user-facing string in this Flutter app via intl_utils ARB files, then regenerate. Use whenever adding or changing user-facing Dart text — labels, titles, hints, SnackBar, dialogs, tooltips, semanticsLabel — or building UI from a design. Add a camelCase key to lib/l10n/intl_en.arb (source of truth), mirror it in intl_ar.arb, use S.of(context).key in widgets, and run intl_utils:generate in the same change set.
---

# Hardcoded strings → localization (fit_flow)

When adding or changing **user-facing** text in Dart (labels, titles, hints, `SnackBar`, dialogs, tooltips, `semanticsLabel`, etc.):

1. **No new literals in UI code.** Add a **camelCase** key to `lib/l10n/intl_en.arb` first (source of truth), with an `@key` block and `description` when helpful.
2. **Mirror the key** in `lib/l10n/intl_ar.arb` with the Arabic translation. Placeholder names must match `intl_en.arb` exactly.
3. **Use the generated API** in widgets: `S.of(context).yourKey` (or `S.of(context).yourKey(arg)` for placeholders). Import `package:fit_flow/generated/l10n.dart`.
4. **Regenerate** in the same change set:

   ```bash
   dart run intl_utils:generate
   ```

   Never hand-edit `lib/generated/`.

**Leave as literals** (do not localize): debug logs, analytics event names, route/path strings, raw asset paths, API keys, non-display identifiers. Dynamic content/data from a repository or sample data layer is data, not UI copy — model it as data, not ARB keys.

**RTL:** Prefer `EdgeInsetsDirectional` / `AlignmentDirectional` so Arabic layouts flip correctly. `Row` and horizontal layouts reverse automatically — don't manually swap children.

See the `flutter-localization` skill for full setup, plural/select patterns, and troubleshooting.
