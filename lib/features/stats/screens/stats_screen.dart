import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/stats/widgets/stat_card.dart';

import '../../../core/models/task.dart';

class StatsScreen extends StatelessWidget {
  final int total;
  final int completed;
  final int pending;
  final List<Task> tasks;

  const StatsScreen({
    super.key,
    required this.total,
    required this.completed,
    required this.pending,
    required this.tasks,
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
      appBar: AppBar(title: const Text('Статистика')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ваш прогресс',
                style: Theme.of(context).textTheme.headlineSmall,
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
