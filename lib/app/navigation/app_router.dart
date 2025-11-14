import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/template_form.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/templates_notifier.dart';
import 'package:rkmp_learn_flutter/features/tasks/screens/template/edit_template_screen.dart';
import 'package:rkmp_learn_flutter/features/tasks/screens/template/template_task_screen.dart';

import '../../features/profile/screens/profile_screen.dart';
import '../../features/tasks/screens/stats_screen.dart';
import '../../features/tasks/screens/tasks_list_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/tasks-list',
    routes: [
      GoRoute(
        path: '/tasks-list',
        name: 'tasks-list',
        builder: (context, state) => TasksListScreen(),
        routes: [
          GoRoute(
            path: '/templates',
            name: 'templates',
            builder: (context, state) => TemplateTaskScreen(),
            routes: [
              GoRoute(
                path: '/edit-template/:index',
                name: 'edit-template',
                builder: (context, state) {
                  final index = int.parse(state.pathParameters['index']!);
                  return Consumer(
                    builder: (context, ref, _) {
                      final template = ref.read(templatesProvider)[index];
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref
                            .read(templateFormProvider.notifier)
                            .loadTemplate(template);
                      });
                      return EditTemplateScreen(index: index);
                    },
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/stats',
            name: 'stats',
            builder: (context, state) => StatsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
