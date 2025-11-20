import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/core/constants/settings_constants.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/store/settings_view_model.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/theme_state.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeState build() {
    ref.listen(settingsViewModelProvider, (previous, next) {
      if (next.hasValue && next.value!.settings != null) {
        state = state.copyWith(
          themeMode: next.value!.settings!.themeMode,
          themeData: _buildThemeData(
            next.value!.settings!.primaryColor,
            next.value!.settings!.themeMode,
          ),
        );
      }
    });

    return ThemeState(
      themeData: _buildThemeData(
        SettingsConstants.defaultSettings.primaryColor,
        SettingsConstants.defaultSettings.themeMode,
      ),
      themeMode: SettingsConstants.defaultSettings.themeMode,
    );
  }
}

ThemeData _buildThemeData(Color primaryColor, ThemeMode themeMode) {
  final isDark = themeMode == ThemeMode.dark;

  return ThemeData(
    useMaterial3: true,
    brightness: isDark ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
    ),
  );
}