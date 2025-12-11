import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/app.dart';
import 'package:rkmp_learn_flutter/ui/shared/di/app_di.dart';

void main() {

  AppDI.initializeFeatures();

  runApp(
    ProviderScope(child: MyApp())
  );
}
