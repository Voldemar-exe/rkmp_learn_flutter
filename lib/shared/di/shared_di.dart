import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/delete_profile_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_ingredients_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_recipes_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_use_case.dart';

void registerSharedDependencies() {
  GetIt.I.registerLazySingleton<GetUserRecipesUseCase>(
    () => GetUserRecipesUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<GetUserIngredientsWithAmountUseCase>(
    () => GetUserIngredientsWithAmountUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<DeleteProfileUseCase>(
    () => DeleteProfileUseCase(GetIt.I()),
  );

  GetIt.I.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(GetIt.I()),
  );
}
