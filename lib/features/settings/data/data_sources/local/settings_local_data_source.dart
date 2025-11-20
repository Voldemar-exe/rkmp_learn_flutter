import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

class SettingsLocalDataSource {
  static final Map<String, dynamic> _storage = {
    'theme_mode': 'system',
    'primary_color': 0xFF6200EE,
  };

  Future<AppSettingsEntity> getSettings() async {
    // Delay simulation
    await Future.delayed(const Duration(milliseconds: 100));

    return AppSettingsEntity(
      themeMode: _getThemeMode(_storage['theme_mode'] as String? ?? 'system'),
      primaryColor: Color(_storage['primary_color'] as int? ?? 0xFF6200EE)
    );
  }

  Future<void> saveSettings(AppSettingsEntity settings) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _storage['theme_mode'] = _getThemeModeString(settings.themeMode);
    _storage['primary_color'] = settings.primaryColor;
  }

  Future<void> clearSettings() async {
    saveSettings(SettingsConstants.defaultSettings);
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