import 'package:nesba_ai/core/service/shared_pref/pref_keys.dart';
import 'package:nesba_ai/core/service/shared_pref/shared_pref.dart';

class FontFamilyHelper {
  const FontFamilyHelper._();

  static const String ibmPlexSans = 'IBM Plex Sans';
  static const String ibmPlexSansArabic = 'IBM Plex Sans Arabic';

  static String geLocalozedFontFamily() {
    final currentLanguage = SharedPref().getString(PrefKeys.language);
    if (currentLanguage == 'ar') {
      return ibmPlexSansArabic;
    } else {
      return ibmPlexSans;
    }
  }
}
