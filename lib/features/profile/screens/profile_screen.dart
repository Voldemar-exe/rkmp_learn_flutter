import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/profile/providers/profile_notifier.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/tasks_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showGoalInputDialog(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(profileProvider.notifier).goalController;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Установить цель'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Количество задач',
              hintText: 'Например: 10',
            ),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text.trim());
                if (value != null && value > 0) {
                  ref.read(profileProvider.notifier).updateGoal(value);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showResetConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Сбросить всё?'),
        content: const Text(
          'Все задачи и статистика будут удалены. Шаблоны вернутся к значениям по умолчанию.',
        ),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              ref.read(profileProvider.notifier).resetToDefaults();
              Navigator.of(context).pop();
            },
            child: const Text('Сбросить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String getRemainingText(int remainingCount) {
    if (remainingCount > 0) {
      return 'Осталось: $remainingCount';
    } else {
      return 'Цель выполнена!';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(profileProvider);
    final completedCount = ref.watch(tasksProvider.notifier).completedCount;
    final remaining = user.goal - completedCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Имя: ${user.username}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Цель: ${user.goal} задач',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Осталось: $remaining',
              style: const TextStyle(fontSize: 20, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Router.neglect(context, () => context.go('/tasks-list')),
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 60)),
              child: const Text('Список задач', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showGoalInputDialog(context, ref),
              icon: const Icon(Icons.edit),
              label: const Text('Изменить цель'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _showResetConfirmationDialog(context, ref),
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              label: const Text(
                'Сбросить всё',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
