import 'package:rkmp_learn_flutter/features/auth/di/auth_di.dart';

class AppDI {

  static void initializeFeatures() {
    registerAuthDependencies();
  }
}