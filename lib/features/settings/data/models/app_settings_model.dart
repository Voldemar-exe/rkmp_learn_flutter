import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettingsEntity {
  const AppSettingsModel({
    required super.themeMode,
    required super.primaryColor
  });

  @override
  AppSettingsModel copyWith({
    ThemeMode? themeMode,
    Color? primaryColor
  }) {
    return AppSettingsModel(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor
    );
  }

  AppSettingsModel copyFromModel(AppSettingsModel settings) {
    return AppSettingsModel(
      themeMode: settings.themeMode,
      primaryColor: settings.primaryColor
    );
  }

  factory AppSettingsModel.fromEntity(AppSettingsEntity entity) {
    return AppSettingsModel(
      themeMode: entity.themeMode,
      primaryColor: entity.primaryColor
    );
  }

  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
      themeMode: themeMode,
      primaryColor: primaryColor
    );
  }

  factory AppSettingsModel.defaultSettings() {
    return AppSettingsModel.fromEntity(SettingsConstants.defaultSettings);
  }
}
