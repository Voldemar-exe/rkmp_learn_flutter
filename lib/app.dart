import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:rkmp_learn_flutter/ui/shared/navigation/app_router.dart';
import 'package:rkmp_learn_flutter/ui/shared/providers/theme_notifier.dart';

import 'core/constants/app_strings.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeProvider).themeData;

    return Builder(
      builder: (context) {
        final isTablet = MediaQuery.of(context).size.shortestSide > 600;

        final baseTextScale = MediaQuery.of(context).textScaleFactor;

        final adaptiveTextScale = isTablet
            ? (baseTextScale * 1.25).clamp(1.0, 1.6)
            : baseTextScale;

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(adaptiveTextScale),
          ),
          child: MaterialApp.router(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: themeData,
            darkTheme: themeData,
            themeMode: ref.watch(themeProvider).themeMode,
            routerConfig: GetIt.I<AppRouter>().getRouter(),
          ),
        );
      },
    );
  }
}
