import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

/// Here we set and get shared preferences values. We set them in settings
/// screen and get them in BLoC.
class DeviceSettings {

  /// Set String [value] for specified [valueKey].
  Future<bool> setStringValue(String valueKey, String? value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      final existingValue = await getStringValue(valueKey);
      return prefs.setString(valueKey, existingValue);
    }

    return prefs.setString(valueKey, value);
  }

  /// Set bool [value] for specified [valueKey].
  Future<bool> setBoolValue(String valueKey, {bool? value}) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      final existingValue = await getBoolValue(valueKey);
      return prefs.setBool(valueKey, existingValue);
    }

    return prefs.setBool(valueKey, value);
  }

  /// Get value by its [valueKey].
  Future<String> getStringValue(String valueKey) async {
    final prefs = await SharedPreferences.getInstance();

    if (valueKey == 'language_code') {
      return prefs.getString(valueKey) ?? PlatformDispatcher.instance.locales.first.languageCode;
    }
    if (valueKey == 'theme') {
      return prefs.getString(valueKey) ?? 'AppTheme.auto';
    }
    return '';
  }
  /// Get String value by its [valueKey].
  Future<bool> getBoolValue(String valueKey) async {
    final prefs = await SharedPreferences.getInstance();
    if (valueKey == 'tutorial_passed') {
      return prefs.getBool(valueKey) ?? false;
    }
    if (valueKey == 'first_load') {
      return prefs.getBool(valueKey) ?? false;
    }
    return false;
  }
}
