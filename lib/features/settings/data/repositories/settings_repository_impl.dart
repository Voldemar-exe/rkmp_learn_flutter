import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/local/settings_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/remote/settings_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _localDatasource;
  final SettingsRemoteDatasource _remoteDatasource;

  SettingsRepositoryImpl(this._localDatasource, this._remoteDatasource);

  @override
  Future<AppSettingsEntity> getLocalSettings() async {
    try {
      final localSettings = await _localDatasource.getSettings();
      return localSettings;
    } catch (e) {
      return SettingsConstants.defaultSettings;
    }
  }

  @override
  Future<AppSettingsEntity?> getSettingsForUser(int userId) async {
    try {
      final remoteSettings = await _remoteDatasource.getSettingsById(userId);
      if (remoteSettings != null) {
        await _localDatasource.saveSettings(remoteSettings);
        return remoteSettings;
      }

      return await _localDatasource.getSettings();
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveSettings(AppSettingsEntity settings, int? userId) async {
    try {
      await _localDatasource.saveSettings(settings);
      if (userId != null) {
        await _remoteDatasource.saveSettings(settings, userId);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearSettings(int? userId) async {
    try {
      await _localDatasource.clearSettings();

      if (userId != null) {
        await _remoteDatasource.clearSettings(userId);
      }
    } catch (e) {
      rethrow;
    }
  }
}
