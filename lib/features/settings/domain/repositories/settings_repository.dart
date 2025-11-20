import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettingsEntity?> getLocalSettings();
  Future<AppSettingsEntity?> getSettingsForUser(int userId);
  Future<void> saveSettings(AppSettingsEntity settings, int? userId);
  Future<void> clearSettings(int? userId);
}
