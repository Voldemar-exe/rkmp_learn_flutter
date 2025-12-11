import 'package:flutter/material.dart';

import '../../../../core/models/scheduled_meal.dart';

class MealTile extends StatelessWidget {
  final MealTime mealTime;
  final ScheduledMeal? meal;
  final VoidCallback onTap;
  final void Function(String) onActionSelected;

  const MealTile({
    super.key,
    required this.mealTime,
    required this.meal,
    required this.onTap,
    required this.onActionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_getLabel(mealTime)),
      subtitle: _buildSubtitle(context),
      trailing: meal != null
          ? PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'unassign',
                  child: Text('Убрать рецепт'),
                ),
                PopupMenuItem(
                  value: meal!.isEaten ? 'mark_not_eaten' : 'mark_eaten',
                  child: Text(
                    meal!.isEaten
                        ? 'Отметить как "не съедено"'
                        : 'Отметить как "съедено"',
                  ),
                ),
              ],
              onSelected: onActionSelected,
            )
          : null,
      onTap: onTap,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    if (meal == null) return const Text('Нет рецепта');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (meal!.recipe != null)
          Text(meal!.recipe!.name)
        else
          const Text('Нет рецепта'),
        Text(
          meal!.isEaten ? 'Съедено' : 'Не съедено',
          style: TextStyle(color: meal!.isEaten ? Colors.green : Colors.orange),
        ),
      ],
    );
  }
}

String _getLabel(MealTime mealTime) {
  switch (mealTime) {
    case MealTime.breakfast: return 'Завтрак';
    case MealTime.lunch: return 'Обед';
    case MealTime.dinner: return 'Ужин';
  }
}