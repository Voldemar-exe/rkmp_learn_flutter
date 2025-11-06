import 'dart:math';
import '../core/models/app_data.dart';
import '../core/models/task.dart';
import '../core/models/template.dart';

abstract class AppDataService {
  void generateAndAddTask();
  void toggleTask(String id);
  void deleteTask(String id);
  void addTemplate(Template t);
  void removeTemplate(int index);
  void updateTemplate(int index, Template updated);
  void resetToDefaults();
}

class AppDataServiceImpl implements AppDataService {
  final void Function(AppData Function(AppData)) _updateData;

  AppDataServiceImpl(this._updateData);

  @override
  void generateAndAddTask() {
    _updateData((prevData) {
      if (prevData.templates.isEmpty) return prevData;
      final random = Random();
      final template =
          prevData.templates[random.nextInt(prevData.templates.length)];
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: template.text,
        isCompleted: false,
        tags: List<String>.from(template.tags),
      );
      final newTasks = List<Task>.from(prevData.tasks);
      newTasks.add(newTask);
      return prevData.copyWith(tasks: newTasks);
    });
  }

  @override
  void toggleTask(String id) {
    _updateData((prevData) {
      final newTasks = List<Task>.from(prevData.tasks);
      final taskIndex = newTasks.indexWhere((t) => t.id == id);
      if (taskIndex != -1) {
        final task = newTasks[taskIndex];
        newTasks[taskIndex] = task.copyWith(isCompleted: !task.isCompleted);
      }
      return prevData.copyWith(tasks: newTasks);
    });
  }

  @override
  void deleteTask(String id) {
    _updateData((prevData) {
      final newTasks = List<Task>.from(prevData.tasks);
      newTasks.removeWhere((t) => t.id == id);
      return prevData.copyWith(tasks: newTasks);
    });
  }

  @override
  void addTemplate(Template t) {
    _updateData((prevData) {
      final newTemplates = List<Template>.from(prevData.templates);
      newTemplates.add(t);
      return prevData.copyWith(templates: newTemplates);
    });
  }

  @override
  void removeTemplate(int index) {
    _updateData((prevData) {
      final newTemplates = List<Template>.from(prevData.templates);
      if (index >= 0 && index < newTemplates.length) {
        newTemplates.removeAt(index);
      }
      return prevData.copyWith(templates: newTemplates);
    });
  }

  @override
  void updateTemplate(int index, Template updated) {
    _updateData((prevData) {
      final newTemplates = List<Template>.from(prevData.templates);
      if (index >= 0 && index < newTemplates.length) {
        newTemplates[index] = updated;
      }
      return prevData.copyWith(templates: newTemplates);
    });
  }

  @override
  void resetToDefaults() {
    _updateData((prevData) => prevData.resetToDefaults());
  }
}
