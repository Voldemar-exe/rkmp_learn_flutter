import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../../../../data/datasources/local/auth_local_datasource.dart';
import '../../../../data/datasources/remote/api/auth_api.dart';
import '../../../../data/datasources/remote/api/auth_api_datasource.dart';
import '../../../../data/datasources/remote/api/dio_client.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../domain/interfaces/repositories/auth_repository.dart';

void registerAuthDependencies() {
  GetIt.I.registerLazySingleton<AuthApi>(
    () => AuthApi(GetIt.I<DioClient>().instance),
  );

  GetIt.I.registerLazySingleton<AuthApiDataSource>(
    () => AuthApiDataSource(GetIt.I<AuthApi>()),
  );
  GetIt.I.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(GetIt.I<FlutterSecureStorage>()),
  );

  GetIt.I.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );
}
