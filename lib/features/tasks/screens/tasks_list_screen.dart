import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/tasks_notifier.dart';
import 'package:rkmp_learn_flutter/features/tasks/widgets/task_item.dart';

class TasksListScreen extends ConsumerWidget {
  const TasksListScreen({super.key});

  static const String appIconicImageUrl =
      'https://cdn0.iconfinder.com/data/icons/job-seeker/256/statistic_job_seeker_employee_unemployee_work-512.png';
  static const String emptyListImageUrl =
      'https://cdn0.iconfinder.com/data/icons/competitive-strategy-and-corporate-training/512/175_file_report_invoice_card_checklist-512.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingTasks = ref.watch(
      tasksProvider.select((tasks) {
        return tasks.where((t) => !t.isCompleted).toList();
      }),
    );

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
        actions: [
          IconButton(
            onPressed: () =>
                Router.neglect(context, () => context.go('/profile')),
            icon: Icon(Icons.person, size: 36),
          ),
          SizedBox(width: 36),
        ],
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
                  onPressed: () =>
                      ref.read(tasksProvider.notifier).generateAndAddTask(),
                  child: const Text('Сгенерировать задание'),
                ),
                ElevatedButton(
                  onPressed: () => context.push('/tasks-list/templates'),
                  child: const Text('Настроить шаблоны'),
                ),
                ElevatedButton(
                  onPressed: () => context.push('/tasks-list/stats'),
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
                              onToggleCompletion: (id) => ref
                                  .read(tasksProvider.notifier)
                                  .toggleTask(id),
                              onDelete: (id) => ref
                                  .read(tasksProvider.notifier)
                                  .deleteTask(id),
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
