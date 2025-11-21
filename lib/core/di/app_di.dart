import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/features/auth/di/auth_di.dart';
import 'package:rkmp_learn_flutter/features/ingredients//di/ingredients_di.dart';
import 'package:rkmp_learn_flutter/features/profile/di/profile_di.dart';
import 'package:rkmp_learn_flutter/features/recipes/di/recipes_di.dart';
import 'package:rkmp_learn_flutter/features/schedule/di/schedule_di.dart';
import 'package:rkmp_learn_flutter/features/settings/di/settings_di.dart';
import 'package:rkmp_learn_flutter/features/statistics/di/statistics_di.dart';
import 'package:rkmp_learn_flutter/shared/di/shared_di.dart';
import 'package:rkmp_learn_flutter/shared/presentation/navigation/app_router.dart';

class AppDI {
  static void initializeFeatures() {

    GetIt.I.registerLazySingleton(() => AppRouter());

    registerAuthDependencies();
    registerSettingsDependencies();
    registerProfileDependencies();
    registerRecipesDependencies();
    registerIngredientsDependencies();
    registerScheduleDependencies();
    registerStatisticsDependencies();
    registerSharedDependencies();
  }
}