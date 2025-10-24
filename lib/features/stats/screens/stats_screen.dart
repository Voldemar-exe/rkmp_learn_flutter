import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/stats/widgets/stat_card.dart';

import '../../../app/app_manager.dart';
import '../../../core/models/task.dart';

class StatsScreenWrapper extends StatelessWidget {
  final AppManager manager;

  const StatsScreenWrapper({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    final completed = manager.completedCount;
    final total = manager.tasks.length;
    final pending = total - completed;

    return StatsScreen(
      total: total,
      completed: completed,
      pending: pending,
      tasks: manager.tasks,
      onBack: () => Navigator.of(context).pop(),
    );
  }
}

class StatsScreen extends StatelessWidget {
  static const String statsIconicImageUrl =
      'https://cdn4.iconfinder.com/data/icons/success-filloutline/64/board-stats-report-presentation-diagram-512.png';

  final int total;
  final int completed;
  final int pending;
  final List<Task> tasks;
  final VoidCallback onBack;

  const StatsScreen({
    super.key,
    required this.total,
    required this.completed,
    required this.pending,
    required this.tasks,
    required this.onBack,
  });

  Map<String, int> _getTagCount(List<Task> tasks) {
    final Map<String, int> counts = {};
    for (final task in tasks.where((task) => task.isCompleted)) {
      for (final tag in task.tags) {
        counts[tag] = (counts[tag] ?? 0) + 1;
      }
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final tagCounts = _getTagCount(tasks);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Ваш прогресс',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 20),
                  CachedNetworkImage(
                    imageUrl: statsIconicImageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported, size: 60),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatCard(
                label: 'Всего заданий',
                value: total.toString(),
                color: Colors.blue,
              ),
              StatCard(
                label: 'Выполнено',
                value: completed.toString(),
                color: Colors.green,
              ),
              StatCard(
                label: 'Осталось',
                value: pending.toString(),
                color: Colors.orange,
              ),
              const SizedBox(height: 30),
              Text(
                'Выполненные по категориям:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              ...tagCounts.entries.map((entry) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      entry.value.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  title: Text('#${entry.key}'),
                  trailing: Text('${entry.value} раз'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
