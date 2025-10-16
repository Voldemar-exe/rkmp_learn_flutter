import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/tasks_list/widgets/task_item.dart';
import '../../../core/models/task.dart';

class TaskListScreen extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback onGenerateTask;
  final Function(String) onToggleTask;
  final Function(String) onDeleteTask;
  final VoidCallback onNavigateToTemplates;
  final VoidCallback onNavigateToStats;

  const TaskListScreen({
    super.key,
    required this.tasks,
    required this.onGenerateTask,
    required this.onToggleTask,
    required this.onDeleteTask,
    required this.onNavigateToTemplates,
    required this.onNavigateToStats,
  });

  @override
  Widget build(BuildContext context) {
    final pendingTasks = tasks.where((t) => !t.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Формирователь привычек')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: onGenerateTask,
                  child: const Text('Сгенерировать задание'),
                ),
                ElevatedButton(
                  onPressed: onNavigateToTemplates,
                  child: const Text('Настроить шаблоны'),
                ),
                ElevatedButton(
                  onPressed: onNavigateToStats,
                  child: const Text('Статистика'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: pendingTasks.isEmpty
                  ? const Center(child: Text('Нет заданий...'))
                  : ListView(
                      children: pendingTasks
                          .map(
                            (task) => TaskListItem(
                              task: task,
                              onToggleCompletion: onToggleTask,
                              onDelete: onDeleteTask,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
