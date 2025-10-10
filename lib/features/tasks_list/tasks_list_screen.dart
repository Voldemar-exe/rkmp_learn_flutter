import 'package:flutter/material.dart';

import '../completed_tasks/completed_tasks_screen.dart';
import '../get_task/template_task_screen.dart';
import '../stats/stats_screen.dart';
import '../task_details/task_details_screen.dart';

import 'dart:math';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Map<String, dynamic>> _tasks = [];

  final List<String> _taskOptions = [
    'Купить продукты',
    'Прочитать книгу',
    'Сходить в спортзал',
    'Позвонить другу',
    'Убраться в комнате',
    'Написать письмо',
    'Посмотреть фильм',
    'Приготовить ужин',
    'Сделать домашнее задание',
    'Сходить на встречу',
  ];

  void _addOption(String option) {
    if (option.trim().isNotEmpty) {
      setState(() {
        _taskOptions.add(option.trim());
      });
    }
  }

  void _removeOption(int index) {
    setState(() {
      _taskOptions.removeAt(index);
    });
  }

  void _generateAndAddTask() {
    final random = Random();
    String randomTask = _taskOptions[random.nextInt(_taskOptions.length)];
    setState(() {
      _tasks.add({
        'text': randomTask,
        'isCompleted': false,
        'tags': <String>[],
      });
    });
  }

  void _updateTaskStatus(int index, bool isCompleted) {
    setState(() {
      _tasks[index]['isCompleted'] = isCompleted;
    });
  }

  void _updateTaskTags(int index, List<String> newTags) {
    setState(() {
      _tasks[index]['tags'] = newTags;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((task) => task['isCompleted']).length;
    int pendingCount = _tasks.length - completedCount;

    return Scaffold(
      appBar: AppBar(title: const Text('Список задач Нилова В.В.')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _generateAndAddTask,
                  child: const Text('Сгенерировать задачу'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TemplateTaskScreen(
                          templates: _taskOptions,
                          onAddTemplate: _addOption,
                          onRemoveTemplate: _removeOption,
                        ),
                      ),
                    );
                  },
                  child: const Text('Управление шаблонами'),
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
                  ? const Center(child: Text('Нет задач. Сгенерируйте новую.'))
                  : SingleChildScrollView(
                      child: Column(
                        children: _tasks
                            .asMap()
                            .entries
                            .where((entry) => !entry.value['isCompleted'])
                            .map((entry) {
                              int index = entry.key;
                              var task = entry.value;
                              return Card(
                                child: ListTile(
                                  title: Text(task['text']),
                                  subtitle: Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(text: 'Теги: '),
                                        TextSpan(
                                          text:
                                              (task['tags'] as List?)?.join(
                                                ', ',
                                              ) ??
                                              '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _deleteTask(index),
                                        tooltip: 'Удалить задачу',
                                      ),
                                      task['isCompleted']
                                          ? const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.radio_button_unchecked,
                                              color: Colors.grey,
                                            ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskDetailScreen(
                                          taskIndex: index,
                                          taskText: task['text'],
                                          isCompleted: task['isCompleted'],
                                          tags: List<String>.from(
                                            task['tags'] ?? [],
                                          ),
                                          onUpdateStatus: _updateTaskStatus,
                                          onUpdateTags: _updateTaskTags,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            })
                            .toList(),
                      ),
                    ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksScreen(
                      allTasks: _tasks,
                      onUpdateStatus: _updateTaskStatus,
                      onUpdateTags: _updateTaskTags,
                    ),
                  ),
                );
              },
              child: const Text('Просмотр выполненных'),
            ),
          ],
        ),
      ),
    );
  }
}
