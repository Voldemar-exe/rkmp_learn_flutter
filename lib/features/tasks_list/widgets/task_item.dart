import 'package:flutter/material.dart';

import '../../../core/models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function(String) onToggleCompletion;
  final Function(String) onDelete;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggleCompletion,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.text),
        subtitle: Wrap(
          spacing: 6,
          children: task.tags.map((tag) {
            return Chip(
              label: Text(
                '#$tag',
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainer,
            );
          }).toList(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => onToggleCompletion(task.id),
              visualDensity: VisualDensity.compact,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => onDelete(task.id),
            ),
          ],
        ),
      ),
    );
  }
}