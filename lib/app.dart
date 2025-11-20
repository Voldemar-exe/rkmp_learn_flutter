import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/core/constants/app_strings.dart';
import 'package:rkmp_learn_flutter/shared/presentation/navigation/app_router.dart';
import 'package:rkmp_learn_flutter/shared/presentation/providers/theme_notifier.dart';


class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider).themeData;

    return MaterialApp.router(
      title: AppStrings.appName,
      theme: themeData,
      darkTheme: themeData,
      themeMode: ref.watch(themeProvider).themeMode,
      routerConfig: AppRouter().getRouter(),
    );
  }
}
