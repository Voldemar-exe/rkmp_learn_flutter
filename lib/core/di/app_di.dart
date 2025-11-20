import 'package:rkmp_learn_flutter/features/auth/di/auth_di.dart';
import 'package:rkmp_learn_flutter/features/ingredients//di/recipes_di.dart';
import 'package:rkmp_learn_flutter/features/profile/di/profile_di.dart';
import 'package:rkmp_learn_flutter/features/recipes/di/recipes_di.dart';
import 'package:rkmp_learn_flutter/features/settings/di/settings_di.dart';

class AppDI {
  static void initializeFeatures() {
    registerAuthDependencies();
    registerSettingsDependencies();
    registerProfileDependencies();
    registerRecipesDependencies();
    registerIngredientsDependencies();
  }
}