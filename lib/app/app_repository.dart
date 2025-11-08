import 'dart:math';
import '../core/models/app_data.dart';
import '../core/models/task.dart';
import '../core/models/template.dart';

abstract class AppRepository {
  abstract AppData data;
  int get completedCount;
  int get remaining;

  void generateAndAddTask();
  void toggleTask(String id);
  void deleteTask(String id);
  void addTemplate(Template t);
  void removeTemplate(int index);
  void updateTemplate(int index, Template updated);
  void resetToDefaults();
}

class AppRepositoryImpl implements AppRepository {
  @override
  AppData data;

  AppRepositoryImpl({required this.data});

  @override
  void generateAndAddTask() {
    final random = Random();
    final template = data.templates[random.nextInt(data.templates.length)];
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: template.text,
      isCompleted: false,
      tags: List<String>.from(template.tags),
    );
    data.tasks.add(newTask);
  }
  @override
  void toggleTask(String id) {
    final taskIndex = data.tasks.indexWhere((t) => t.id == id);
    if (taskIndex != -1) {
      final task = data.tasks[taskIndex];
      data.tasks[taskIndex] = task.copyWith(isCompleted: !task.isCompleted);
    }
  }
  @override
  void deleteTask(String id) {
    data.tasks.removeWhere((t) => t.id == id);
  }
  @override
  void addTemplate(Template t) {
    data.templates.add(t);
  }
  @override
  void removeTemplate(int index) {
    if (index >= 0 && index < data.templates.length) {
      data.templates.removeAt(index);
    }
  }
  @override
  void updateTemplate(int index, Template updated) {
    if (index >= 0 && index < data.templates.length) {
      data.templates[index] = updated;
    }
  }
  @override
  void resetToDefaults() => data = data.resetToDefaults();
  @override
  int get completedCount => data.tasks.where((t) => t.isCompleted).length;
  @override
  int get remaining => (data.goal - completedCount).clamp(0, data.goal);
}
