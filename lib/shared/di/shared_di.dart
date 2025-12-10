import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/shared/data/database/dao/ingredient_dao.dart';
import 'package:rkmp_learn_flutter/shared/data/database/dao/recipe_dao.dart';
import 'package:rkmp_learn_flutter/shared/data/database/dao/schedule_dao.dart';
import 'package:rkmp_learn_flutter/shared/data/database/database.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/delete_profile_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_ingredients_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_recipes_use_case.dart';
import 'package:rkmp_learn_flutter/shared/domain/use_cases/get_user_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerSharedDependencies() {
  GetIt.I.registerLazySingleton<SharedPreferencesAsync>(
    () => SharedPreferencesAsync(),
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

  GetIt.I.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(GetIt.I()),
  );
}
