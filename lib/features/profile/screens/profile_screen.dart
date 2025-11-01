import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_manager.dart';

class ProfileScreen extends StatefulWidget {
  final AppManager manager;

  const ProfileScreen({super.key, required this.manager});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _goalController;

  @override
  void initState() {
    super.initState();
    _goalController = TextEditingController(
      text: widget.manager.goal.toString(),
    );
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  void _showGoalInputDialog(BuildContext context) {
    final controller = TextEditingController(
      text: widget.manager.goal.toString(),
    );

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
                setState(() {
                  final value = int.tryParse(controller.text.trim());
                  if (value != null && value > 0) {
                    widget.manager.goal = value;
                  }
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _showResetConfirmationDialog(BuildContext context) {
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
              setState(() {
                Navigator.of(context).pop();
                widget.manager.resetToDefaults();
              });
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
  Widget build(BuildContext context) {
    final goal = widget.manager.goal;
    final remaining = getRemainingText(widget.manager.remaining);

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Имя: ${widget.manager.username}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Цель: $goal задач',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              remaining,
              style: const TextStyle(fontSize: 24, color: Colors.orange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () =>
                  Router.neglect(context, () => context.go('/tasks-list')),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 60), // ширина: 200, высота: 60
              ),
              child: const Text('Список задач', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showGoalInputDialog(context),
              icon: const Icon(Icons.edit),
              label: const Text('Изменить цель'),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _showResetConfirmationDialog(context),
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
