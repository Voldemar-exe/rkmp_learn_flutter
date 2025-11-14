import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/template_form.dart';
import '../../providers/templates_notifier.dart';
import '../../widgets/template_item.dart';

class TemplateTaskScreen extends ConsumerWidget {
  const TemplateTaskScreen({super.key});

  static const templateAsIdeaImageUrl =
      'https://cdn4.iconfinder.com/data/icons/reputation-management-1-1/66/54-1024.png';
  static const emptyTemplateListImageUrl =
      'https://cdn0.iconfinder.com/data/icons/analytic-investment-and-balanced-scorecard/512/151_inbox_Box_cabinet_document_empty_project-512.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templates = ref.watch(templatesProvider);
    final form = ref.watch(templateFormProvider);
    final formNotifier = ref.watch(templateFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Управление шаблонами')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: templateAsIdeaImageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported, size: 60),
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: formNotifier.templateController,
                    decoration: const InputDecoration(
                      labelText: 'Текст задачи',
                      hintText: 'Например: Сделать зарядку',
                    ),
                    validator: (value) =>
                        value?.trim().isEmpty == true ? 'Введите текст' : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: formNotifier.tagController,
                          decoration: const InputDecoration(
                            labelText: 'Текст тега',
                            hintText: 'Например: Личное',
                          ),
                          validator: (value) => value?.trim().isEmpty == true
                              ? 'Введите текст'
                              : null,
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final template = formNotifier.buildTemplate();
                      if (template != null) {
                        ref
                            .read(templatesProvider.notifier)
                            .addTemplate(template);
                        formNotifier.reset();
                      }
                    },
                    child: const Text('Добавить шаблон'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: templates.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: emptyTemplateListImageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image_not_supported, size: 60),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Нет шаблонов',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: templates.length,
                      itemBuilder: (context, index) {
                        return TemplateItem(
                          template: templates[index],
                          onDelete: () => ref
                              .read(templatesProvider.notifier)
                              .removeTemplate(index),
                          onEdit: () => context.push(
                            "/tasks-list/templates/edit-template/$index",
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
