import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/entities/app_settings.dart';

class SettingsConstants {
  static const AppSettingsEntity defaultSettings = AppSettingsEntity(
    themeMode: ThemeMode.system,
    primaryColor: Colors.deepPurple
  );
}