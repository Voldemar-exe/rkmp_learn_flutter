import 'dart:math';

import 'package:flutter/material.dart';
import '../features/stats/screens/stats_screen.dart';
import '../features/task_template/screens/template_task_screen.dart';
import '../features/tasks_list/screens/tasks_list_screen.dart';
import 'package:rkmp_learn_flutter/core/models/task.dart';
import 'package:rkmp_learn_flutter/core/models/template.dart';

enum AppScreen { list, templates, stats }

class TaskAppContainer extends StatefulWidget {
  const TaskAppContainer({super.key});

  @override
  State<TaskAppContainer> createState() => _TaskAppContainerState();
}

class _TaskAppContainerState extends State<TaskAppContainer> {
  AppScreen _currentScreen = AppScreen.list;

  final List<Task> _tasks = [];
  final List<Template> _templates = [
    Template(text: 'Купить продукты', tags: ['личное', 'дом']),
    Template(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    Template(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    Template(text: 'Позвонить другу', tags: ['социальное']),
    Template(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();

  void _generateAndAddTask() {
    if (_templates.isEmpty) return;
    final random = Random();
    final template = _templates[random.nextInt(_templates.length)];
    final task = Task(
      id: _generateId(),
      text: template.text,
      isCompleted: false,
      tags: template.tags,
    );
    setState(() {
      _tasks.add(task);
    });
  }

  void _toggleTaskCompletion(String taskId) {
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == taskId);
      if (index != -1) {
        _tasks[index] = _tasks[index].copyWith(
          isCompleted: !_tasks[index].isCompleted,
        );
      }
    });
  }

  void _deleteTask(String taskId) {
    setState(() {
      _tasks.removeWhere((t) => t.id == taskId);
    });
  }

  void _addTemplate(Template template) {
    setState(() {
      _templates.add(template);
    });
  }

  void _removeTemplate(int index) {
    setState(() {
      _templates.removeAt(index);
    });
  }

  void _showList() => setState(() => _currentScreen = AppScreen.list);
  void _showTemplates() => setState(() => _currentScreen = AppScreen.templates);
  void _showStats() => setState(() => _currentScreen = AppScreen.stats);

  @override
  Widget build(BuildContext context) {
    final completed = _tasks.where((t) => t.isCompleted).length;
    final pending = _tasks.length - completed;

    switch (_currentScreen) {
      case AppScreen.list:
        return TaskListScreen(
          tasks: _tasks,
          onGenerateTask: _generateAndAddTask,
          onToggleTask: _toggleTaskCompletion,
          onDeleteTask: _deleteTask,
          onNavigateToTemplates: _showTemplates,
          onNavigateToStats: _showStats,
        );

      case AppScreen.templates:
        return TemplateTaskScreen(
          templates: _templates,
          onAddTemplate: _addTemplate,
          onRemoveTemplate: _removeTemplate,
          onBack: _showList,
        );

      case AppScreen.stats:
        return StatsScreen(
          total: _tasks.length,
          completed: completed,
          pending: pending,
          tasks: _tasks,
          onBack: _showList,
        );
    }
  }
}
