import 'package:flutter/material.dart';

import '../models/task_template.dart';

class TemplateItem extends StatelessWidget {
  final TaskTemplate template;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TemplateItem({
    super.key,
    required this.template,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(template.text),
        subtitle: Wrap(
          spacing: 6,
          children: template.tags.map((tag) {
            return Chip(
              label: Text('#$tag', style: const TextStyle(fontSize: 12)),
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            );
          }).toList(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.purple),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
