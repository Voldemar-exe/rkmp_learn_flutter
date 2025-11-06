import 'package:flutter/material.dart';
import '../core/models/app_data.dart';
import 'app_manager.dart';
import 'my_app.dart';

void main() {
  final initialData = AppData(
    username: 'Нилов В.В. ИКБО-06-22',
    goal: 5,
    tasks: [],
  );
  runApp(AppManager(initialData: initialData, child: MyApp()));
}
