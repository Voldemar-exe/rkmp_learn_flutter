import 'package:go_router/go_router.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/tasks_list/screens/tasks_list_screen.dart';
import '../app/app_manager.dart';

class AppRouter {
  final AppManager appManager;

  AppRouter({required this.appManager});

  late final GoRouter _router = GoRouter(
    initialLocation: '/tasks-list',
    routes: [
      GoRoute(
        path: '/tasks-list',
        name: 'tasks-list',
        builder: (context, state) => TaskListScreenWrapper(manager: appManager),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => ProfileScreen(manager: appManager),
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
