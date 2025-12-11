import 'package:go_router/go_router.dart';

import '../../../core/models/scheduled_meal.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/recipes/screens/recipes_screen.dart';
import '../../features/recipes/screens/recipe_details_screen.dart';
import '../../features/ingredients/screens/ingredients_list_screen.dart';
import '../../features/ingredients/screens/ingredient_add_screen.dart';
import '../../features/schedule/screens/schedule_screen.dart';
import '../../features/schedule/screens/schedule_select_recipe_screen.dart';
import '../../features/statistics/screens/statistics_screen.dart';
import '../../features/home/screens/home_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/home'),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => RegisterScreen(),
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => HomeScreen(),
        routes: [
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => ProfileScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => SettingsScreen(),
          ),
          GoRoute(
            path: '/recipes',
            name: 'recipes',
            builder: (context, state) => RecipesScreen(),
            routes: [
              GoRoute(
                path: '/recipe_details',
                name: 'recipe_details',
                builder: (context, state) => RecipeDetailScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/ingredients',
            name: 'ingredients',
            builder: (context, state) => IngredientsListScreen(),
            routes: [
              GoRoute(
                path: '/add',
                name: 'ingredient_add',
                builder: (context, state) => IngredientAddScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/schedule',
            name: 'schedule',
            builder: (context, state) => ScheduleScreen(),
            routes: [
              GoRoute(
                path: '/select_recipe',
                builder: (context, state) {
                  final extra = state.extra as Map<String, dynamic>;
                  final date = extra['date'] as DateTime;
                  final mealTime = extra['mealTime'] as MealTime;
                  return ScheduleSelectRecipeScreen(
                    date: date,
                    mealTime: mealTime,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/statistics',
            name: 'statistics',
            builder: (context, state) => StatisticsScreen(),
          ),
        ],
      ),
    ],
  );

  GoRouter getRouter() => _router;
}
