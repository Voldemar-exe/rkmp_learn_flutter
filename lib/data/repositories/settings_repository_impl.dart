import '../../domain/interfaces/repositories/settings_repository.dart';
import '../../core/models/app_settings.dart';
import '../datasources/local/settings_local_data_source.dart';
import '../datasources/remote/api/settings_api_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;
  final SettingsApiDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<AppSettings> getLocalSettings() async {
    try {
      final localSettings = await _localDataSource.getSettings();
      return localSettings;
    } catch (e) {
      return AppSettings();
    }
  }

  @override
  Future<AppSettings?> getSettingsForUser(int userId) async {
    try {
      final remoteSettings = await _remoteDataSource.getSettingsById(userId);
      if (remoteSettings != null) {
        await _localDataSource.saveSettings(remoteSettings);
        return remoteSettings;
      }

      return await _localDataSource.getSettings();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings, int? userId) async {
    try {
      await _localDataSource.saveSettings(settings);
      if (userId != null) {
        await _remoteDataSource.saveSettings(settings, userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearSettings(int? userId) async {
    try {
      await _localDataSource.clearSettings();

      if (userId != null) {
        await _remoteDataSource.clearSettings(userId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
