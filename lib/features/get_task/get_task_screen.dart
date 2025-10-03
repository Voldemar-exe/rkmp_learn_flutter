import 'package:flutter/material.dart';
import 'dart:math';

class GetTaskScreen extends StatelessWidget {
  final Function(String) onTaskReceived;

  const GetTaskScreen({super.key, required this.onTaskReceived});

  static const List<String> _taskOptions = [
    'Купить продукты',
    'Прочитать книгу',
    'Сходить в спортзал',
    'Позвонить другу',
    'Убраться в комнате',
    'Написать письмо',
    'Посмотреть фильм',
    'Приготовить ужин',
    'Сделать домашнее задание',
    'Сходить на встречу'
  ];

  void _generateAndSendTask(BuildContext context) {
    final random = Random();
    String randomTask = _taskOptions[random.nextInt(_taskOptions.length)];
    onTaskReceived(randomTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Получить задачу'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Нажмите кнопку, чтобы получить новую задачу',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _generateAndSendTask(context),
              child: Text('Сгенерировать задачу'),
            ),
          ],
        ),
      ),
    );
  }
}