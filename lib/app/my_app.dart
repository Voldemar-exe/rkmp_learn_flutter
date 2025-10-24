import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/app/app_manager.dart';

import 'app_router.dart';

class MyApp extends StatelessWidget {
  final AppManager appManager;

  const MyApp({super.key, required this.appManager});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Практическая работа 7',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter(appManager: appManager).getRouter(),
    );
  }
}
