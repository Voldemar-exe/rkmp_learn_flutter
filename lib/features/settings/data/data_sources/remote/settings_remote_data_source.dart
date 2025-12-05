import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

class SettingsRemoteDataSource {
  static final List<Map<String, dynamic>> _settings = [
    {
      'id': '1',
      'userId': '1',
      'theme': 'system',
      'primaryColor': '0xFF6200EE',
      'created_at': DateTime.now().toIso8601String(),
    },
    {
      'id': '2',
      'userId': '2',
      'theme': 'system',
      'primaryColor': '0xFF6200EE',
      'created_at': DateTime.now().toIso8601String(),
    },
  ];

  Future<AppSettingsEntity?> getSettingsById(int userId) async {
    final settings = _settings.firstWhere(
      (s) => int.parse(s['userId']) == userId,
    );
    return AppSettingsEntity(
      themeMode: _getThemeMode(settings['theme']),
      primaryColor: Color(int.parse(settings['primaryColor'], radix: 16))
    );
  }

  ThemeMode _getThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> clearSettings(int? userId) async {
    saveSettings(SettingsConstants.defaultSettings, userId);
  }

  Future<void> saveSettings(AppSettingsEntity settings, int? userId) async {
    if (userId == null) {
      _settings.add({
        'id': _settings.length.toString(),
        'userId': userId.toString(),
        'theme': settings.themeMode,
        'primaryColor': settings.primaryColor.value,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      final index = _settings.indexWhere(
        (s) => int.parse(s['userId']) == userId,
      );
      if (index == -1) {
        _settings.add({
          'id': _settings.length.toString(),
          'userId': userId.toString(),
          'theme': settings.themeMode,
          'primaryColor': settings.primaryColor.value,
          'created_at': DateTime.now().toIso8601String(),
        });
        return;
      }
      _settings[index] = {
        'userId': userId.toString(),
        'theme': settings.themeMode,
        'primaryColor': settings.primaryColor.value,
        'updated_at': DateTime.now().toIso8601String(),
      };
    }
  }
}
