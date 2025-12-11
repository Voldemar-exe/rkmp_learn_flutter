import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/ui/shared/mappers/app_settings_mapper.dart';

import '../../../core/models/app_settings.dart';
import '../../features/settings/delegates/settings_view_model.dart';
import '../states/theme_state.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeState build() {
    ref.listen(settingsViewModelProvider, (previous, next) {
      if (next.hasValue && next.value!.settings != null) {
        state = state.copyWith(
          themeMode: next.value!.settings!.themeModeAsEnum,
          themeData: _buildThemeData(
            next.value!.settings!.primaryColorAsColor,
            next.value!.settings!.themeModeAsEnum,
          ),
        );
      }
    });

    return ThemeState(
      themeData: _buildThemeData(
        AppSettings().primaryColorAsColor,
        AppSettings().themeModeAsEnum,
      ),
      themeMode: AppSettings().themeModeAsEnum,
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
