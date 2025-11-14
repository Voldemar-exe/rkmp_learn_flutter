import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/template_form.dart';
import '../../providers/templates_notifier.dart';

class EditTemplateScreen extends ConsumerWidget {
  final int index;

  const EditTemplateScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(templateFormProvider);
    final formNotifier = ref.watch(templateFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать шаблон')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: formNotifier.templateController,
                decoration: const InputDecoration(labelText: 'Текст задачи'),
                validator: (v) => v!.trim().isEmpty ? 'Обязательно' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: formNotifier.tagController,
                      decoration: const InputDecoration(hintText: 'Тег'),
                    ),
                  ),
                  IconButton(
                    onPressed: formNotifier.addTag,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: form.tags.map((tag) {
                  return Chip(
                    label: Text('#$tag'),
                    onDeleted: () => formNotifier.removeTag(tag),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  final template = formNotifier.buildTemplate();
                  if (template != null) {
                    ref
                        .read(templatesProvider.notifier)
                        .updateTemplate(index, template);
                    formNotifier.reset();
                    context.pop();
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
