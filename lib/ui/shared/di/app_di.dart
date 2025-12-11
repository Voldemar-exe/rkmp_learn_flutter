import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/ui/features/profile/di/profile_di.dart';
import 'package:rkmp_learn_flutter/ui/shared/di/shared_di.dart';

import '../../features/ingredients/di/ingredients_di.dart';
import '../../features/recipes/di/recipes_di.dart';
import '../../features/schedule/di/schedule_di.dart';
import '../../features/settings/di/settings_di.dart';
import '../../features/statistics/di/statistics_di.dart';
import '../navigation/app_router.dart';
import '../../features/auth/di/auth_di.dart';

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