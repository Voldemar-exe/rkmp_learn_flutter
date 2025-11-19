import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/core/constants/app_strings.dart';
import 'package:rkmp_learn_flutter/shared/presentation/navigation/app_router.dart';


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter().getRouter(),
    );
  }
}
