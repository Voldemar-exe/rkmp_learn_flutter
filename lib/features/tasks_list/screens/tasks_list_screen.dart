import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/tasks_list/widgets/task_item.dart';
import 'dart:math';
import '../../../core/models/task.dart';
import '../../../core/models/template.dart';
import '../../task_template/screens/template_task_screen.dart';
import '../../stats/screens/stats_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();

}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final List<Template> _templates = [
    Template(text: 'Купить продукты', tags: ['личное', 'дом']),
    Template(text: 'Прочитать книгу', tags: ['учеба', 'развитие']),
    Template(text: 'Сходить в спортзал', tags: ['здоровье', 'спорт']),
    Template(text: 'Позвонить другу', tags: ['социальное']),
    Template(text: 'Убраться в комнате', tags: ['личное', 'дом']),
  ];


  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString();

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

  void _generateAndAddTask() {
    if (_templates.isEmpty) return;
    final random = Random();
    final randomTemplate = _templates[random.nextInt(_templates.length)];
    final newTask = Task(
      id: _generateId(),
      text: randomTemplate.text,
      isCompleted: false,
      tags: randomTemplate.tags,
    );
    setState(() {
      _tasks.add(newTask);
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

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((task) => task.isCompleted).length;
    int pendingCount = _tasks.length - completedCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Формирователь привычек')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _generateAndAddTask,
                  child: const Text('Сгенерировать задание'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateTaskScreen(
                          templates: _templates,
                          onAddTemplate: _addTemplate,
                          onRemoveTemplate: _removeTemplate,
                        ),
                      ),
                    );
                  },
                  child: const Text('Настроить шаблоны'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatsScreen(
                          total: _tasks.length,
                          completed: completedCount,
                          pending: pendingCount,
                          tasks: _tasks,
                        ),
                      ),
                    );
                  },
                  child: const Text('Статистика'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? const Center(
                      child: Text(
                        'Нет заданий. Нажмите "Сгенерировать", чтобы начать!',
                      ),
                    )
                  : ListView(
                      children: _tasks
                          .where((task) => !task.isCompleted)
                          .map(
                            (task) => TaskListItem(
                                task: task,
                                onToggleCompletion: _toggleTaskCompletion,
                                onDelete: _deleteTask
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
