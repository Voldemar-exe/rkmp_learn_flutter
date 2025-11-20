import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/local/settings_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/remote/settings_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource _localDataSource;
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<AppSettingsEntity> getLocalSettings() async {
    try {
      final localSettings = await _localDataSource.getSettings();
      return localSettings;
    } catch (e) {
      return SettingsConstants.defaultSettings;
    }
  }

  @override
  Future<AppSettingsEntity?> getSettingsForUser(int userId) async {
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
  Future<void> saveSettings(AppSettingsEntity settings, int? userId) async {
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
