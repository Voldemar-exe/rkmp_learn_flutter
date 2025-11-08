import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/app/app_repository.dart';
import '../core/models/app_data.dart';
import 'package:get_it/get_it.dart';
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
  GetIt.I.registerSingleton<AppRepository>(appRepositoryImpl);
  runApp(MyApp());
}
