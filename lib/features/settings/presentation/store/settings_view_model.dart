import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/settings/data/models/app_settings_model.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/repositories/settings_repository.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/states/settings_state.dart';
import 'package:rkmp_learn_flutter/shared/presentation/providers/auth_notifier.dart';
import 'package:rkmp_learn_flutter/shared/presentation/states/auth_state.dart';

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

  Future<AppSettingsModel> _loadSettings() async {
    try {
      final entity = await _settingsRepository.getLocalSettings();
      if (entity == null) {
        return AppSettingsModel.defaultSettings();
      }
      return AppSettingsModel.fromEntity(entity);
    } catch (e) {
      return AppSettingsModel.defaultSettings();
    }
  }

  Future<void> updateSettings(AppSettingsModel settings) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    try {
      final user = (ref.read(checkAuthStatusProvider) as Authenticated).user;
      await _settingsRepository.saveSettings(settings.toEntity(), user.id);
      state = AsyncValue.data(state.value!.copyWith(settings: settings));
    } catch (e) {
      // TEST
      throw Exception(e);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> clearSettings() async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    final user = ref.read(checkAuthStatusProvider);
    try {
      final userId = (user as Authenticated).user.id;
      await _settingsRepository.clearSettings(userId);
      state = AsyncValue.data(
        state.value!.copyWith(settings: AppSettingsModel.defaultSettings()),
      );
    } catch (e) {
      if (user is Unauthenticated) {
        state = AsyncValue.data(
          state.value!.copyWith(settings: AppSettingsModel.defaultSettings()),
        );
      }
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(
        themeMode: themeMode,
      );
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }

  Future<void> updatePrimaryColor(Color color) async {
    state = AsyncValue.data(state.value!.copyWith(isLoading: true));
    if (state.value!.settings != null) {
      final updatedSettings = state.value!.settings!.copyWith(
        primaryColor: color,
      );
      await updateSettings(updatedSettings);
    }
    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
  }
}
