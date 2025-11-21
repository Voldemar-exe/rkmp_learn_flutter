import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_recipes_use_case.dart';

void registerSharedDependencies() {
  GetIt.I.registerLazySingleton<GetUserRecipesUseCase>(
    () => GetUserRecipesUseCase(GetIt.I()),
  );
}
