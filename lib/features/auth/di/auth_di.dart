import 'package:get_it/get_it.dart';
import '../data/data_sources/local/auth_local_data_source.dart';
import '../data/data_sources/remote/auth_remote_data_source.dart';
import '../domain/repositories/auth_repository.dart';
import '../data/repositories/auth_repository_impl.dart';

void registerAuthDependencies() {
  GetIt.I.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );
  GetIt.I.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());

  GetIt.I.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(remoteDataSource: GetIt.I(), localDataSource: GetIt.I()),
  );
}
