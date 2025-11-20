import 'package:rkmp_learn_flutter/features/auth/di/auth_di.dart';
import 'package:rkmp_learn_flutter/features/settings/di/settings_di.dart';

class AppDI {

  static void initializeFeatures() {
    registerAuthDependencies();
    registerSettingsDependencies();
  }
}