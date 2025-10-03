import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  final int total;
  final int completed;
  final int pending;

  const StatsScreen({
    super.key,
    required this.total,
    required this.completed,
    required this.pending,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Статистика')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Статистика по задачам',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildStatItem('Всего задач:', total.toString()),
            SizedBox(height: 10),
            _buildStatItem('Выполнено:', completed.toString()),
            SizedBox(height: 10),
            _buildStatItem('Осталось:', pending.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
