import 'package:flutter/material.dart';

class AppSettingsEntity {
  final ThemeMode themeMode;
  final Color primaryColor;

  const AppSettingsEntity({
    this.themeMode = ThemeMode.system,
    this.primaryColor = Colors.deepPurple
  });

  AppSettingsEntity copyWith({
    ThemeMode? themeMode,
    Color? primaryColor
  }) {
    return AppSettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor
    );
  }
}