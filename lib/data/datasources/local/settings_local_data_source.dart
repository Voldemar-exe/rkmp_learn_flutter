import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/app_settings.dart';

class SettingsLocalDataSource {
  final SharedPreferencesAsync _prefs;

  SettingsLocalDataSource(this._prefs);

  Future<AppSettings> getSettings() async {
    try {
      final themeMode = await _prefs.getString('theme_mode') ?? 'system';
      final primaryColor = await _prefs.getInt('primary_color') ?? 0xFF6200EE;

      return AppSettings(
        themeMode: themeMode,
        primaryColorArgb: primaryColor,
      );
    } catch (e) {
      return const AppSettings();
    }
  }

  Future<void> saveSettings(AppSettings settings) async {
    try {
      await _prefs.setString('theme_mode', settings.themeMode);
      await _prefs.setInt('primary_color', settings.primaryColorArgb);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearSettings() async {
    try {
      await saveSettings(const AppSettings());
    } catch (e) {
      rethrow;
    }
  }
}
