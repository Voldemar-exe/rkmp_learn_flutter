import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/app/app_repository.dart';
import 'package:rkmp_learn_flutter/features/tasks_list/widgets/task_item.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const String appIconicImageUrl =
      'https://cdn0.iconfinder.com/data/icons/job-seeker/256/statistic_job_seeker_employee_unemployee_work-512.png';
  static const String emptyListImageUrl =
      'https://cdn0.iconfinder.com/data/icons/competitive-strategy-and-corporate-training/512/175_file_report_invoice_card_checklist-512.png';

  late AppRepository _appRepository;

  @override
  void initState() {
    super.initState();
    _appRepository = GetIt.I<AppRepository>();
  }

  void navigateToTemplates() => context.push('/tasks-list/templates');

  void navigateToStats() => context.push('/tasks-list/stats');

  void navigateToProfile() =>
      Router.neglect(context, () => context.go('/profile'));

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _appRepository.data.tasks
        .where((t) => !t.isCompleted)
        .toList();

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
            onPressed: navigateToProfile,
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
                  onPressed: () => setState(() {
                    _appRepository.generateAndAddTask();
                  }),
                  child: const Text('Сгенерировать задание'),
                ),
                ElevatedButton(
                  onPressed: navigateToTemplates,
                  child: const Text('Настроить шаблоны'),
                ),
                ElevatedButton(
                  onPressed: navigateToStats,
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
                              onToggleCompletion: (id) => setState(() {
                                _appRepository.toggleTask(id);
                              }),
                              onDelete: (id) => setState(() {
                                _appRepository.deleteTask(id);
                              }),
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
