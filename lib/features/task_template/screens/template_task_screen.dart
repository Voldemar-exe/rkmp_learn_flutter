import 'package:flutter/material.dart';
import '../../../core/models/template.dart';
import '../widgets/template_item.dart';

class TemplateTaskScreen extends StatefulWidget {
  final List<Template> templates;
  final Function(Template) onAddTemplate;
  final Function(int) onRemoveTemplate;

  const TemplateTaskScreen({
    super.key,
    required this.templates,
    required this.onAddTemplate,
    required this.onRemoveTemplate,
  });

  @override
  State<TemplateTaskScreen> createState() => _TemplateTaskScreenState();
}

class _TemplateTaskScreenState extends State<TemplateTaskScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  late List<String> _currentTags;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentTags = [];
  }

  void _addTag() {
    String tag = _tagsController.text.trim();
    if (tag.isNotEmpty && !_currentTags.contains(tag)) {
      setState(() {
        _currentTags.add(tag);
      });
      _tagsController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _currentTags.remove(tag);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newTemplate = Template(
        text: _textController.text.trim(),
        tags: List<String>.from(_currentTags),
      );
      widget.onAddTemplate(newTemplate);
      _textController.clear();
      setState(() {
        _currentTags.clear();
      });
    }
  }

  void removeTemplate(int index) {
    setState(() {
      widget.onRemoveTemplate(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Управление шаблонами')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: 'Текст задачи',
                      hintText: 'Например: Сделать зарядку',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите текст';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tagsController,
                          decoration: const InputDecoration(
                            hintText: 'Добавить тег',
                            labelText: 'Теги',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addTag,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: _currentTags.map((tag) {
                      return Chip(
                        label: Text('#$tag'),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => _removeTag(tag),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Добавить шаблон'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: widget.templates.isEmpty
                  ? const Center(child: Text('Нет шаблонов'))
                  : ListView.builder(
                      itemCount: widget.templates.length,
                      itemBuilder: (context, index) {
                        final template = widget.templates[index];
                        return TemplateItem(
                          template: template,
                          onDelete: () => removeTemplate(index)
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
