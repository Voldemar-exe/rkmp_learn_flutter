import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/tasks_list/widgets/task_item.dart';
import '../../../core/models/task.dart';

class TaskListScreen extends StatelessWidget {
  static const String appIconicImageUrl =
      'https://cdn0.iconfinder.com/data/icons/job-seeker/256/statistic_job_seeker_employee_unemployee_work-512.png';
  static const String emptyListImageUrl =
      'https://cdn0.iconfinder.com/data/icons/competitive-strategy-and-corporate-training/512/175_file_report_invoice_card_checklist-512.png';

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
      appBar: AppBar(
        title: const Text('Генератор задач'),
        leading: CachedNetworkImage(
          imageUrl: appIconicImageUrl,
          width: 80,
          height: 80,
          fit: BoxFit.contain,
          placeholder: (context, url) => const Icon(Icons.image, size: 24),
          errorWidget: (context, url, error) =>
              const Icon(Icons.broken_image, size: 24),
        ),
      ),
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
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: emptyListImageUrl,
                            width: 200,
                            height: 200,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image_not_supported, size: 60),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Нет активных заданий',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
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
