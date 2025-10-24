import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/app/app_manager.dart';
import 'my_app.dart';

void main() {
  final appManager = AppManager();
  runApp(MyApp(appManager: appManager));
}
