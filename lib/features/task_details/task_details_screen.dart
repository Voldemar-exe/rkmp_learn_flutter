import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final int taskIndex;
  final String taskText;
  final bool isCompleted;
  final Function(int, bool) onUpdateStatus;

  const TaskDetailScreen({
    super.key,
    required this.taskIndex,
    required this.taskText,
    required this.isCompleted,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Детали задачи')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Задача: $taskText',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Статус: ${isCompleted ? 'Выполнено' : 'Не выполнено'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onUpdateStatus(taskIndex, !isCompleted);
                Navigator.pop(context);
              },
              child: Text(
                isCompleted
                    ? 'Отметить как невыполненное'
                    : 'Отметить как выполненное',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
