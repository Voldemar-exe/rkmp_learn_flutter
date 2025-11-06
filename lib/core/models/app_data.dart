import 'package:rkmp_learn_flutter/core/models/task.dart';
import 'package:rkmp_learn_flutter/core/models/template.dart';

class AppData {
  String username;
  int goal;
  final List<Task> tasks;
  final List<Template> templates;
  static final List<Template> _templatesDefault = [
    Template(text: 'Купить продукты', tags: ['личное', 'дом']),
    Template(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    Template(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    Template(text: 'Позвонить другу', tags: ['социальное']),
    Template(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];

  AppData({
    required this.username,
    required this.goal,
    required this.tasks,
    List<Template>? templates,
  }) : templates = templates ?? _templatesDefault;

  AppData resetToDefaults() {
    return AppData(
      username: username,
      goal: goal,
      tasks: [],
      templates: List<Template>.from(_templatesDefault),
    );
  }

  AppData copyWith({
    String? username,
    int? goal,
    List<Task>? tasks,
    List<Template>? templates,
  }) {
    return AppData(
      username: username ?? this.username,
      goal: goal ?? this.goal,
      tasks: tasks ?? this.tasks,
      templates: templates ?? this.templates,
    );
  }
}