import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/stats/screens/stats_screen.dart';
import 'package:rkmp_learn_flutter/features/task_template/screens/edit_template_screen.dart';
import 'package:rkmp_learn_flutter/features/task_template/screens/template_task_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/tasks_list/screens/tasks_list_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/tasks-list',
    routes: [
      GoRoute(
        path: '/tasks-list',
        name: 'tasks-list',
        builder: (context, state) => TaskListScreen(),
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
                  return EditTemplateScreen(index: index);
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
