import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

class SettingsLocalDataSource {
  final SharedPreferencesAsync _prefs;

  SettingsLocalDataSource(this._prefs);

  Future<AppSettingsEntity> getSettings() async {
    // Delay simulation
    await Future.delayed(const Duration(milliseconds: 100));

    final themeModeString = await _prefs.getString('theme_mode') ?? 'system';
    final primaryColorInt = await _prefs.getInt('primary_color') ?? 0xFF6200EE;

    return AppSettingsEntity(
      themeMode: _getThemeMode(themeModeString),
      primaryColor: Color(primaryColorInt),
    );
  }

  Future<void> saveSettings(AppSettingsEntity settings) async {
    await Future.delayed(const Duration(milliseconds: 100));

    await _prefs.setString('theme_mode', _getThemeModeString(settings.themeMode));
    await _prefs.setInt('primary_color', settings.primaryColor.value);
  }

  Future<void> clearSettings() async {
    await saveSettings(SettingsConstants.defaultSettings);
  }

  ThemeMode _getThemeMode(String mode) {
    switch (mode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }
}