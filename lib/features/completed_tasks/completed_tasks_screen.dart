import 'package:flutter/material.dart';

import '../task_details/task_details_screen.dart';

class CompletedTasksScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allTasks;
  final Function(int, bool) onUpdateStatus;
  final Function(int, List<String>) onUpdateTags;

  const CompletedTasksScreen({
    super.key,
    required this.allTasks,
    required this.onUpdateStatus,
    required this.onUpdateTags,
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
      appBar: AppBar(title: const Text('Выполненные задачи')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completedTasks.isEmpty
            ? const Center(child: Text('Нет выполненных задач.'))
            : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, i) {
                  final task = completedTasks[i];
                  int originalIndex = widget.allTasks.indexOf(task);
                  return Card(
                    child: ListTile(
                      title: Text(task['text']),
                      subtitle: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Теги: '),
                            TextSpan(
                              text: (task['tags'] as List?)?.join(', ') ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailScreen(
                              taskIndex: originalIndex,
                              taskText: task['text'],
                              isCompleted: task['isCompleted'],
                              tags: List<String>.from(task['tags'] ?? []),
                              onUpdateStatus: widget.onUpdateStatus,
                              onUpdateTags: widget.onUpdateTags,
                            ),
                          ),
                        ).then((_) => setState(() {}));
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
