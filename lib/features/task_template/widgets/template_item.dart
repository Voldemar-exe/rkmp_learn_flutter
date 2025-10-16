import 'package:flutter/material.dart';

import '../../../core/models/template.dart';

class TemplateItem extends StatelessWidget {
  final Template template;
  final VoidCallback onDelete;

  const TemplateItem({
    super.key,
    required this.template,
    required this.onDelete,
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
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}