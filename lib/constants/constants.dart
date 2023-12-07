import '../utils/env/env.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Themes of app.
enum AppTheme {
  /// Light theme.
  light,

  /// Dark theme.
  dark,

  /// System theme.
  auto
}

/// Header for Strapi API request.
final strapiHeader = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${Env.STRAPI_BEARER_TOKEN}',
};

/// A mapping between language locale code, country emoji and enum values
/// and their respective localized string representations.
final Map<Map<String, String>, String Function(AppLocalizations)> languageToLocalKey = {
  {'en': 'gb'}: (localizations) => localizations.english,
  {'et': 'ee'}: (localizations) => localizations.estonian,
  {'ru': 'ru'}: (localizations) => localizations.russian,
};

class LanguageItem {
  final String languageCode;
  final String countryCode;
  final String name;

  LanguageItem(this.languageCode, this.countryCode, this.name);
}

List<LanguageItem> getDropdownItems(AppLocalizations localizations) {
  return languageToLocalKey.entries.map((entry) {
    String code = entry.key.keys.first;
    String countryCode = entry.key.values.first;
    String name = entry.value(localizations);
    return LanguageItem(code, countryCode, name);
  }).toList();
}
