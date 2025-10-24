import 'package:go_router/go_router.dart';

import '../features/profile/screens/profile_screen.dart';
import '../features/stats/screens/stats_screen.dart';
import '../features/task_template/screens/edit_template_screen.dart';
import '../features/task_template/screens/template_task_screen.dart';
import '../features/tasks_list/screens/tasks_list_screen.dart';
import 'app_manager.dart';

class AppRouter {
  final AppManager appManager;

  AppRouter({required this.appManager});

  late final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'task-list',
        builder: (context, state) => TaskListScreenWrapper(manager: appManager),
        routes: [
          GoRoute(
            path: 'templates',
            name: 'templates',
            builder: (context, state) =>
                TemplateTaskScreenWrapper(manager: appManager),
          ),
          GoRoute(
            path: 'stats',
            name: 'stats',
            builder: (context, state) => StatsScreenWrapper(manager: appManager),
          ),
          /*GoRoute(
            path: 'edit-template/:index',
            name: 'edit-template',
            builder: (context, state) {
              final index = int.parse(state.pathParameters['index']!);
              return EditTemplateScreen(index: index, manager: appManager);
            },
          ),*/
        ],
      ),
      /*GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => ProfileScreen(manager: appManager),
      ),*/
    ],
  );

  GoRouter getRouter() => _router;
}
