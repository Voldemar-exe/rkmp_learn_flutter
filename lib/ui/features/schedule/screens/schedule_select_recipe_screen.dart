import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/scheduled_meal.dart';
import '../../../shared/providers/user_recipes_notifier.dart';
import '../delegates/schedule_view_model.dart';

class ScheduleSelectRecipeScreen extends ConsumerWidget {
  final DateTime date;
  final MealTime mealTime;

  const ScheduleSelectRecipeScreen({
    super.key,
    required this.date,
    required this.mealTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipesAsync = ref.watch(userRecipesProvider);
    final viewModel = ref.read(scheduleViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Выбрать рецепт: ${_mealTimeToString(mealTime)}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Дата: ${_formatDate(date)}'),
                Text('Время: ${_mealTimeToString(mealTime)}'),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: recipesAsync.when(
              data: (recipes) {
                if (recipes.isEmpty) {
                  return const Center(child: Text('Нет доступных рецептов'));
                }
                return ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return ListTile(
                      title: Text(recipe.name),
                      subtitle: Text('${recipe.category} • ${recipe.area}'),
                      leading: recipe.imageUrl.isNotEmpty
                          ? Image.network(
                              recipe.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                            )
                          : const Icon(Icons.restaurant),
                      onTap: () {
                        viewModel.assignRecipeToMeal(date, mealTime, recipe);
                        context.pop();
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Ошибка: $error')),
            ),
          ),
        ],
      ),
    );
  }

  String _mealTimeToString(MealTime time) {
    switch (time) {
      case MealTime.breakfast:
        return 'Завтрак';
      case MealTime.lunch:
        return 'Обед';
      case MealTime.dinner:
        return 'Ужин';
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }
}
