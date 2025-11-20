import 'package:rkmp_learn_flutter/features/settings/data/models/app_settings_model.dart';

class SettingsState {
  final bool isLoading;
  final bool isError;
  final AppSettingsModel? settings;

  const SettingsState({
    this.isLoading = false,
    this.isError = false,
    this.settings,
  });

  SettingsState copyWith({
    bool? isLoading,
    bool? isError,
    AppSettingsModel? settings,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      settings: settings ?? this.settings,
    );
  }
}