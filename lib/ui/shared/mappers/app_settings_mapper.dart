import 'package:flutter/material.dart';

import '../../../core/models/app_settings.dart';

extension AppSettingsToUi on AppSettings {
  ThemeMode get themeModeAsEnum {
    switch (themeMode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  Color get primaryColorAsColor => Color(primaryColorArgb);
}

class AppSettingsMapper {
  ThemeMode themeModeFromString(String mode) {
    switch (mode) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      default: return ThemeMode.system;
    }
  }

  String themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }

  int colorToArgb(Color color) {
    return color.value;
  }

  String stringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return 'light';
      case ThemeMode.dark: return 'dark';
      default: return 'system';
    }
  }
}