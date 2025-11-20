import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/profile/data/data_sources/local/profile_local_data_source.dart';
import 'package:rkmp_learn_flutter/features/profile/data/data_sources/remote/profile_remote_data_source.dart';
import 'package:rkmp_learn_flutter/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:rkmp_learn_flutter/features/profile/domain/repositories/profile_repository.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/store/profile_view_model.dart';

void registerProfileDependencies() {
  GetIt.I.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(),
  );
  GetIt.I.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(),
  );

  GetIt.I.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: GetIt.I(),
      localDataSource: GetIt.I(),
    ),
  );
  GetIt.I.registerLazySingleton<ProfileViewModel>(() => ProfileViewModel());
}
