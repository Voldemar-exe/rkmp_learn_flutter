import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/features/recipes/presentation/store/recipes_view_model.dart';
import 'package:rkmp_learn_flutter/shared/presentation/providers/user_ingredients_notifier.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(recipesViewModelProvider).value!.selectedRecipe;
    final viewModel = ref.read(recipesViewModelProvider.notifier);
    final userIngredients = ref.watch(userIngredientsProvider);

    if (recipe == null || userIngredients.value == null) {
      return const Scaffold(body: Center(child: Text('Рецепт не загрузился')));
    }

    final ingredients = userIngredients.value!;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () => viewModel.saveRecipe(recipe),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported_outlined, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                recipe.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                '${recipe.category} • ${recipe.area}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ...recipe.ingredientsWithMeasure.entries.map(
                    (entry) {
                  final ingredientName = entry.key;
                  final recipeAmount = entry.value;
                  final userStock = ingredients[ingredientName];

                  String availabilityText;
                  if (userStock != null && userStock > 0) {
                    availabilityText = '$recipeAmount • Есть: $userStock';
                  } else {
                    availabilityText = '$recipeAmount • Нет в наличии';
                  }

                  return ListTile(
                    title: Text(ingredientName),
                    trailing: Text(availabilityText),
                    tileColor: userStock != null && userStock > 0
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                  );
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                recipe.instructions,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
