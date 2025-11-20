import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:rkmp_learn_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:rkmp_learn_flutter/features/ingredients/presentation/screens/ingredient_add_screen.dart';
import 'package:rkmp_learn_flutter/features/ingredients/presentation/screens/ingredients_list_screen.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/screens/profile_screen.dart';
import 'package:rkmp_learn_flutter/features/recipes/presentation/screens/recipe_details_screen.dart';
import 'package:rkmp_learn_flutter/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:rkmp_learn_flutter/features/settings/presentation/screens/settings_screen.dart';

class AppRouter {
  late final GoRouter _router = GoRouter(
    initialLocation: '/login',
    routes: [
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
              builder: (context, state) => RecipeDetailScreen()
            ),
          ]
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
        ]
      )
    ],
  );

  GoRouter getRouter() => _router;
}
