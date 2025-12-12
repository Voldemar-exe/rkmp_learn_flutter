import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/datasources/local/profile_local_datasource.dart';
import '../../../../data/datasources/remote/api/profile_api_data_source.dart';
import '../../../../data/repositories/profile_repository_impl.dart';
import '../../../../domain/interfaces/repositories/profile_repository.dart';
import '../delegates/profile_view_model.dart';

void registerProfileDependencies() {
  GetIt.I.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(GetIt.I<SharedPreferencesAsync>()),
  );
  GetIt.I.registerLazySingleton<ProfileApiDataSource>(
    () => ProfileApiDataSource(),
  );

  GetIt.I.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );
  GetIt.I.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
}
