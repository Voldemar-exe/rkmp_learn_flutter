import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/tasks/providers/templates_notifier.dart';

import '../models/task.dart';

part 'tasks_notifier.g.dart';

@Riverpod(keepAlive: true)
class TasksNotifier extends _$TasksNotifier {
  @override
  List<Task> build() {
    return [];
  }

  void generateAndAddTask() {
    final randomTemplate = ref
        .read(templatesProvider.notifier)
        .getRandomTemplate();
    if (randomTemplate == null) return;

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: randomTemplate.text,
      isCompleted: false,
      tags: List<String>.from(randomTemplate.tags)
    );
    state = [...state, newTask];
  }

  void addTask(Task task) {
    state = [...state, task];
  }

  void toggleTask(String id) {
    state = state.map((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void resetToDefaults() {
    state = [];
  }

  int get completedCount => state.where((task) => task.isCompleted).length;
}
