import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/domain/usecases/update_profile_usecase.dart';
import 'package:rkmp_learn_flutter/domain/usecases/get_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/local/database/dao/ingredient_dao.dart';
import '../../../data/datasources/local/database/dao/recipe_dao.dart';
import '../../../data/datasources/local/database/dao/schedule_dao.dart';
import '../../../data/datasources/local/database/database.dart';
import '../../../domain/usecases/get_user_ingredients_usecase.dart';
import '../../../domain/usecases/get_user_recipes_usecase.dart';
import '../../../domain/usecases/save_profile_usecase.dart';

void registerSharedDependencies() {
  GetIt.I.registerLazySingleton<SharedPreferencesAsync>(
    () => SharedPreferencesAsync(),
  );

  GetIt.I.registerLazySingleton<FlutterSecureStorage>(
    () => FlutterSecureStorage(),
  );

  GetIt.I.registerLazySingleton<AppDatabase>(() => AppDatabase());

  GetIt.I.registerLazySingleton<IngredientDao>(() => IngredientDao(GetIt.I()));
  GetIt.I.registerLazySingleton<RecipeDao>(() => RecipeDao(GetIt.I()));
  GetIt.I.registerLazySingleton<ScheduleDao>(() => ScheduleDao((GetIt.I())));

  GetIt.I.registerLazySingleton<GetUserRecipesUseCase>(
    () => GetUserRecipesUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<GetUserIngredientsWithAmountUseCase>(
    () => GetUserIngredientsWithAmountUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<DeleteProfileUseCase>(
    () => DeleteProfileUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<SaveProfileUseCase>(
        () => SaveProfileUseCase(GetIt.I()),
  );
  GetIt.I.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(GetIt.I()),
  );
}
