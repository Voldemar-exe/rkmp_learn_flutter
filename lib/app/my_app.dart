import 'package:flutter/material.dart';

import 'navigation/app_router.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Практики Нилов В.В. ИКБО-06-22',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter().getRouter(),
    );
  }
}
