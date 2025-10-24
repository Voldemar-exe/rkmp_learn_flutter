import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rkmp_learn_flutter/features/task_template/screens/edit_template_screen.dart';
import '../../../app/app_manager.dart';
import '../../../core/models/template.dart';
import '../widgets/template_item.dart';

class TemplateTaskScreenWrapper extends StatelessWidget {
  final AppManager manager;

  const TemplateTaskScreenWrapper({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: manager,
      builder: (context, child) {
        return TemplateTaskScreen(
          templates: manager.templates,
          onAddTemplate: manager.addTemplate,
          onRemoveTemplate: manager.removeTemplate,
          onBack: () => Navigator.of(context).pop(),
          onEditTemplate: (index) => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  EditTemplateScreen(index: index, manager: manager),
            ),
          ),
        );
      },
    );
  }
}

class TemplateTaskScreen extends StatefulWidget {
  final List<Template> templates;
  final Function(Template) onAddTemplate;
  final Function(int) onRemoveTemplate;
  final VoidCallback onBack;
  final Function(int) onEditTemplate;

  const TemplateTaskScreen({
    super.key,
    required this.templates,
    required this.onAddTemplate,
    required this.onRemoveTemplate,
    required this.onBack,
    required this.onEditTemplate,
  });

  @override
  State<TemplateTaskScreen> createState() => _TemplateTaskScreenState();
}

class _TemplateTaskScreenState extends State<TemplateTaskScreen> {
  static const templateAsIdeaImageUrl =
      'https://cdn4.iconfinder.com/data/icons/reputation-management-1-1/66/54-1024.png';
  static const emptyTemplateListImageUrl =
      'https://cdn0.iconfinder.com/data/icons/analytic-investment-and-balanced-scorecard/512/151_inbox_Box_cabinet_document_empty_project-512.png';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Управление шаблонами'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
      ),
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
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _textController,
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
                        child: TextField(
                          controller: _tagsController,
                          decoration: const InputDecoration(
                            hintText: 'Добавить тег',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _addTag,
                        icon: const Icon(Icons.add),
                      ),
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
                      itemCount: widget.templates.length,
                      itemBuilder: (context, index) {
                        return TemplateItem(
                          template: widget.templates[index],
                          onDelete: () => widget.onRemoveTemplate(index),
                          onEdit: () => widget.onEditTemplate(index),
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
