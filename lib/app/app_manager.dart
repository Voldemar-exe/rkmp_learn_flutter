import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../core/models/task.dart';
import '../core/models/template.dart';

class AppManager with ChangeNotifier {
  String username = 'Нилов В.В. ИКБО-06-22';
  int goal = 5;

  final List<Task> tasks = [];
  final List<Template> _templatesDefault = [
    Template(text: 'Купить продукты', tags: ['личное', 'дом']),
    Template(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    Template(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    Template(text: 'Позвонить другу', tags: ['социальное']),
    Template(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];
  final List<Template> templates = [
    Template(text: 'Купить продукты', tags: ['личное', 'дом']),
    Template(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    Template(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    Template(text: 'Позвонить другу', tags: ['социальное']),
    Template(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();

  void generateAndAddTask() {
    if (templates.isEmpty) return;
    final random = Random();
    final template = templates[random.nextInt(templates.length)];
    tasks.add(
      Task(
        id: _generateId(),
        text: template.text,
        isCompleted: false,
        tags: template.tags,
      ),
    );
    notifyListeners();
  }

  void toggleTask(String id) {
    final task = tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  void deleteTask(String id) {
    tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void addTemplate(Template t) {
    templates.add(t);
    notifyListeners();
  }

  void removeTemplate(int index) {
    templates.removeAt(index);
    notifyListeners();
  }

  void updateTemplate(int index, Template updated) {
    templates[index] = updated;
    notifyListeners();
  }

  void resetToDefaults() {
    tasks.clear();
    templates.clear();
    for (var t in _templatesDefault) {
      templates.add(t);
    }
    notifyListeners();
  }

  int get completedCount => tasks.where((t) => t.isCompleted).length;

  int get remaining => (goal - completedCount).clamp(0, goal);
}
