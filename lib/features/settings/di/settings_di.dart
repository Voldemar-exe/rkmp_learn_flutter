import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/local/settings_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/data/data_sources/remote/settings_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:rkmp_learn_flutter/features/settings/domain/repositories/settings_repository.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/store/settings_view_model.dart';

void registerSettingsDependencies() {
  GetIt.I.registerLazySingleton<SettingsLocalDatasource>(
    () => SettingsLocalDatasource(),
  );
  GetIt.I.registerLazySingleton<SettingsRemoteDatasource>(
    () => SettingsRemoteDatasource(),
  );

  GetIt.I.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      SettingsLocalDatasource(),
      SettingsRemoteDatasource(),
    ),
  );

  GetIt.I.registerLazySingleton<SettingsViewModel>(() => SettingsViewModel());
}
