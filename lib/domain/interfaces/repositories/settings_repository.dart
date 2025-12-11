import '../../../core/models/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings?> getLocalSettings();
  Future<AppSettings?> getSettingsForUser(int userId);
  Future<void> saveSettings(AppSettings settings, int? userId);
  Future<void> clearSettings(int? userId);
}
