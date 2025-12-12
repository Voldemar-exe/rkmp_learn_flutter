import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/datasources/local/settings_local_data_source.dart';
import '../../../../data/datasources/remote/api/settings_api_datasource.dart';
import '../../../../data/repositories/settings_repository_impl.dart';
import '../../../../domain/interfaces/repositories/settings_repository.dart';
import '../delegates/settings_view_model.dart';

void registerSettingsDependencies() {
  GetIt.I.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSource(GetIt.I<SharedPreferencesAsync>()),
  );
  GetIt.I.registerLazySingleton<SettingsApiDataSource>(
    () => SettingsApiDataSource(),
  );

  GetIt.I.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      GetIt.I<SettingsLocalDataSource>(),
      GetIt.I<SettingsApiDataSource>(),
    ),
  );

  GetIt.I.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel());
}
