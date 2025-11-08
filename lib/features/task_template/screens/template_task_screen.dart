import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rkmp_learn_flutter/app/app_repository.dart';
import '../../../core/models/template.dart';
import '../widgets/template_item.dart';

class TemplateTaskScreen extends StatefulWidget {
  const TemplateTaskScreen({super.key});

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

  late AppRepository _appRepository;

  @override
  void initState() {
    super.initState();
    _currentTags = [];
    _appRepository = GetIt.I<AppRepository>();
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
      setState(() {
        _appRepository.addTemplate(newTemplate);
        _textController.clear();
        _currentTags.clear();
      });
    }
  }

  void _navigateToEdit(int index) =>
      context.push("/tasks-list/templates/edit-template/$index");

  @override
  Widget build(BuildContext context) {
    final templates = _appRepository.data.templates;

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
                          onDelete: () => setState(() {
                            _appRepository.removeTemplate(index);
                          }),
                          onEdit: () => _navigateToEdit(index),
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
