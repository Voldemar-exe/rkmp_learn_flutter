import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rkmp_learn_flutter/features/profile/presentation/store/profile_view_model.dart';

class GoalInputDialog extends ConsumerWidget {
  final TextEditingController controller;

  const GoalInputDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              ref.read(profileViewModelProvider.notifier).updateGoal(value);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
