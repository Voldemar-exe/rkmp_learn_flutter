import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/interfaces/repositories/settings_repository.dart';
import '../../../shared/mappers/app_settings_mapper.dart';
import '../../../shared/providers/auth_notifier.dart';
import '../../../shared/states/auth_state.dart';
import '../../../../core/models/app_settings.dart';
import 'states/settings_state.dart';

part 'settings_view_model.g.dart';

@riverpod
class SettingsViewModel extends _$SettingsViewModel {
  late final SettingsRepository _settingsRepository;

  @override
  Future<SettingsState> build() async {
    _settingsRepository = GetIt.I<SettingsRepository>();
    final settings = await _loadSettings();
    return SettingsState(settings: settings);
  }

  Future<AppSettings> _loadSettings() async {
    try {
      final appSettings = await _settingsRepository.getLocalSettings();
      if (appSettings == null) {
        return AppSettings();
      }
      return appSettings;
    } catch (e) {
      return AppSettings();
    }
  }

  Future<void> updateSettings(AppSettings settings) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final user = await ref.read(checkAuthStatusProvider.future);
      final userId = (user as Authenticated).user.id;
      await _settingsRepository.saveSettings(settings, userId);
      state = AsyncValue.data(state.value!.copyWith(settings: settings));
    } catch (e) {
      // TEST
      throw Exception(e);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> clearSettings() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    final user = await ref.read(checkAuthStatusProvider.future);
    try {
      final userId = (user as Authenticated).user.id;
      await _settingsRepository.clearSettings(userId);
      state = AsyncValue.data(
        state.value!.copyWith(settings: AppSettings()),
      );
    } catch (e) {
      if (user is Unauthenticated) {
        state = AsyncValue.data(
          state.value!.copyWith(settings: AppSettings()),
        );
      }
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(
        themeMode: AppSettingsMapper().stringFromThemeMode(themeMode),
      );
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updatePrimaryColor(Color color) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(
        primaryColorArgb: AppSettingsMapper().colorToArgb(color),
      );
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }
}
