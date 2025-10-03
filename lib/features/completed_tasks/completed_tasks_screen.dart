import 'package:flutter/material.dart';

import '../task_details/task_details_screen.dart';

class CompletedTasksScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allTasks;
  final Function(int, bool) onUpdateStatus;

  const CompletedTasksScreen({
    super.key,
    required this.allTasks,
    required this.onUpdateStatus,
  });

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    var completedTasks = widget.allTasks
        .where((task) => task['isCompleted'])
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Выполненные задачи')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: completedTasks.isEmpty
            ? Center(child: Text('Нет выполненных задач.'))
            : Column(
                children: completedTasks.map((task) {
                  int originalIndex = widget.allTasks.indexOf(task);
                  return Card(
                    child: ListTile(
                      title: Text(task['text']),
                      subtitle: Text('Выполнено'),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(
                              taskIndex: originalIndex,
                              taskText: task['text'],
                              isCompleted: task['isCompleted'],
                              onUpdateStatus: widget.onUpdateStatus,
                            ),
                          ),
                        ).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
