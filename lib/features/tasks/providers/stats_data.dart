import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/tasks_notifier.dart';

import '../models/stats.dart';

part 'generated_code/stats_data.g.dart';

@riverpod
Stats statsData(Ref ref) {
  final tasks = ref.read(tasksProvider);

  final completedTasks = tasks.where((task) => task.isCompleted).toList();
  final total = tasks.length;
  final completed = completedTasks.length;
  final pending = total - completed;

  final Map<String, int> tagCounts = {};
  for (final task in completedTasks) {
    for (final tag in task.tags) {
      tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
    }
  }

  return Stats(
    total: total,
    completed: completed,
    pending: pending,
    tagCounts: tagCounts,
  );
}