# Flutter localization — reference (ARB patterns & troubleshooting)

Companion to [SKILL.md](SKILL.md).

---

## Advanced ARB message patterns

### Plurals (ICU syntax)

Plural rules differ across languages — Arabic has six categories (`zero`, `one`, `two`, `few`, `many`, `other`), English has two (`one`, `other`). ICU handles this for you; just provide the forms the language needs. **`other` is required for every language.**

```json
{
  "itemCount": "{count, plural, =0{No items} one{1 item} other{{count} items}}",
  "@itemCount": {
    "description": "Count of items in the cart",
    "placeholders": {
      "count": { "type": "int", "example": "3" }
    }
  }
}
```

Arabic:

```json
{
  "itemCount": "{count, plural, =0{لا توجد عناصر} one{عنصر واحد} two{عنصران} few{{count} عناصر} many{{count} عنصراً} other{{count} عنصر}}"
}
```

### Gender / select

```json
{
  "invitedToParty": "{gender, select, male{He is invited} female{She is invited} other{They are invited}}",
  "@invitedToParty": {
    "placeholders": { "gender": { "type": "String" } }
  }
}
```

### Number formatting

```json
{
  "price": "Total: {amount}",
  "@price": {
    "placeholders": {
      "amount": {
        "type": "double",
        "format": "currency",
        "example": "29.99"
      }
    }
  }
}
```

Format options: `decimalPattern`, `percentPattern`, `currency`, `compact`, `compactLong`, `scientificPattern`.

### Date formatting

```json
{
  "loggedInAt": "Last login: {date}",
  "@loggedInAt": {
    "placeholders": {
      "date": {
        "type": "DateTime",
        "format": "yMMMd",
        "example": "Apr 12, 2026"
      }
    }
  }
}
```

Common skeletons: `yMd`, `yMMMd`, `yMMMMEEEEd`, `Hm`, `jms`. Full list in [`DateFormat`](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html) docs.

---

## Troubleshooting

### `flutter pub get` fails with `intl` version conflict

`flutter_localizations` pins a specific `intl` version. Use `any` to let the resolver pick:

```yaml
dependencies:
  intl: any
```

If `intl_utils` itself wants a different range than your app, update it:

```bash
dart pub global activate intl_utils
```

### `S.of(context)` returns null / throws

`S.of(context)` only works if `S.delegate` is registered in `MaterialApp.localizationsDelegates` AND the current locale is in `supportedLocales`. Check both. Also make sure the widget calling `S.of(context)` is a **descendant** of the `MaterialApp` — calling it from the same widget that builds `MaterialApp` won't work.

For code outside the widget tree, use `S.current` instead.

### `S.of(context).myKey` is red in the editor

Generated code is stale. In order:

1. `dart run intl_utils:generate`.
2. Restart the Dart Analysis Server (`Cmd/Ctrl+Shift+P` → "Dart: Restart Analysis Server").
3. `flutter clean && flutter pub get && dart run intl_utils:generate`.
4. Confirm `myKey` actually exists in `intl_en.arb`.

### Locale change not reflected without restart

By default, `MaterialApp` rebuilds on locale change. If yours doesn't:

- Are you reading the locale from the OS, or from app state? If from app state (e.g. user preference), make sure `MaterialApp(locale: ...)` is wired to a reactive source (Provider / Riverpod / setState).
- After changing locale programmatically, the old `S.current` reference is stale. Always read via `S.of(context)` inside `build`, not cached at widget construction time.

### Hot reload doesn't pick up new ARB strings

Hot reload doesn't re-execute top-level initialization, and generated message catalogs are loaded once. Use **hot restart** (`Shift+R` in `flutter run`) after adding new keys.

### iOS shows English even when device is in Arabic

`Info.plist` is missing locale entries. Edit `ios/Runner/Info.plist`:

```xml
<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>ar</string>
</array>
```

Then `flutter clean` and re-run.

### RTL: layout looks broken in Arabic

Most common causes:

- `EdgeInsets.only(left: ...)` instead of `EdgeInsetsDirectional.only(start: ...)`. Audit: `grep -rn "EdgeInsets.only" lib/`.
- `Alignment.centerLeft` instead of `AlignmentDirectional.centerStart`.
- `Row` with manually-reversed `children` for RTL — remove the manual reversal; `Row` flips automatically.
- A `Directionality(textDirection: TextDirection.ltr, ...)` somewhere overriding the app-wide direction. Search for it.
- Custom-painted widgets (`CustomPainter`) don't auto-flip. Read `Directionality.of(context)` inside `paint` and mirror manually.

### Plural generation throws "missing 'other' branch"

Every `plural` and `select` ICU block requires `other`, even if you think it's unreachable. Add it.

### ARB JSON parse error

ARB is strict JSON — no trailing commas, no comments, no single quotes. Run the generator from the terminal to see the exact line and column of the error.

### `intl_utils` command not found

`~/.pub-cache/bin` is not on `PATH`. Add to your shell profile:

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Or just always invoke via `dart run intl_utils:generate` from the project root, which doesn't need the global tool on `PATH`.

### Mismatched placeholders

If `intl_en.arb` uses `{name}` and `intl_ar.arb` uses `{userName}` for the same key, generation fails or runtime crashes. Keep placeholder names identical across locales.
