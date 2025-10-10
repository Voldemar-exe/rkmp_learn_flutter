import 'package:flutter/material.dart';

import '../completed_tasks/completed_tasks_screen.dart';
import '../get_task/get_task_screen.dart';
import '../stats/stats_screen.dart';
import '../task_details/task_details_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Map<String, dynamic>> _tasks = [];

  void _addTask(String taskText) {
    setState(() {
      _tasks.add({'text': taskText, 'isCompleted': false});
    });
  }

  void _updateTaskStatus(int index, bool isCompleted) {
    setState(() {
      _tasks[index]['isCompleted'] = isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((task) => task['isCompleted']).length;
    int pendingCount = _tasks.length - completedCount;

    return Scaffold(
      appBar: AppBar(title: Text('Список задач Нилова В.В.')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GetTaskScreen(onTaskReceived: _addTask),
                      ),
                    );
                  },
                  child: Text('Получить задачу'),
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
                  child: Text('Статистика'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _tasks.isEmpty
                  ? Text('Нет задач. Получите новую.')
                  : Column(
                      children: _tasks
                          .where((task) => !task['isCompleted'])
                          .map((task) {
                            int index = _tasks.indexOf(task);
                            return Card(
                              child: ListTile(
                                title: Text(task['text']),
                                subtitle: Text(
                                  task['isCompleted']
                                      ? 'Выполнено'
                                      : 'Не выполнено',
                                ),
                                trailing: task['isCompleted']
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                      ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskDetailScreen(
                                        taskIndex: index,
                                        taskText: task['text'],
                                        isCompleted: task['isCompleted'],
                                        onUpdateStatus: _updateTaskStatus,
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksScreen(
                      allTasks: _tasks,
                      onUpdateStatus: _updateTaskStatus,
                    ),
                  ),
                );
              },
              child: Text('Просмотр выполненных'),
            ),
          ],
        ),
      ),
    );
  }
}
