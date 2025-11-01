import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../app/app_manager.dart';
import '../../../core/models/template.dart';

class EditTemplateScreen extends StatefulWidget {
  final int index;
  final AppManager manager;

  const EditTemplateScreen({
    super.key,
    required this.index,
    required this.manager,
  });

  @override
  State<EditTemplateScreen> createState() => _EditTemplateScreenState();
}

class _EditTemplateScreenState extends State<EditTemplateScreen> {
  late TextEditingController _textController;
  late List<String> _currentTags;
  final TextEditingController _tagsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final template = widget.manager.templates[widget.index];
    _textController = TextEditingController(text: template.text);
    _currentTags = List<String>.from(template.tags);
  }

  @override
  void dispose() {
    _textController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _addTag() {
    final tag = _tagsController.text.trim();
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

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updated = Template(
        text: _textController.text.trim(),
        tags: List<String>.from(_currentTags),
      );
      widget.manager.updateTemplate(widget.index, updated);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать шаблон')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Текст задачи'),
                validator: (v) => v!.trim().isEmpty ? 'Обязательно' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _tagsController,
                      decoration: const InputDecoration(hintText: 'Тег'),
                    ),
                  ),
                  IconButton(onPressed: _addTag, icon: const Icon(Icons.add)),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: _currentTags.map((tag) {
                  return Chip(
                    label: Text('#$tag'),
                    onDeleted: () => _removeTag(tag),
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: _save, child: const Text('Сохранить')),
            ],
          ),
        ),
      ),
    );
  }
}
