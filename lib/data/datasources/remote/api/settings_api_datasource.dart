import '../../../../core/models/app_settings.dart';

class SettingsApiDataSource {
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

  Future<AppSettings?> getSettingsById(int userId) async {
    final settings = _settings.firstWhere(
      (s) => int.parse(s['userId']) == userId,
    );
    return AppSettings(
      themeMode: settings['theme'],
      primaryColorArgb: settings['primaryColor']
    );
  }

  Future<void> clearSettings(int? userId) async {
    saveSettings(AppSettings(), userId);
  }

  Future<void> saveSettings(AppSettings settings, int? userId) async {
    if (userId == null) {
      _settings.add({
        'id': _settings.length.toString(),
        'userId': userId.toString(),
        'theme': settings.themeMode,
        'primaryColor': settings.primaryColorArgb,
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
          'primaryColor': settings.primaryColorArgb,
          'created_at': DateTime.now().toIso8601String(),
        });
        return;
      }
      _settings[index] = {
        'userId': userId.toString(),
        'theme': settings.themeMode,
        'primaryColor': settings.primaryColorArgb,
        'updated_at': DateTime.now().toIso8601String(),
      };
    }
  }
}
