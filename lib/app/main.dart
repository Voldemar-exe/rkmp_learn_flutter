import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/app/app_manager_inherited.dart';
import 'package:rkmp_learn_flutter/app/app_repository.dart';
import '../core/models/app_data.dart';
import 'my_app.dart';

void main() {
  final initialData = AppData(
    username: 'Нилов В.В. ИКБО-06-22',
    goal: 5,
    tasks: [],
  );
  final AppRepositoryImpl appRepositoryImpl = AppRepositoryImpl(
    data: initialData,
  );
  runApp(AppManagerInherited(appRepository: appRepositoryImpl, child: MyApp()));
}
