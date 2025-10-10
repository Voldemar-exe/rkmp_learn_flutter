import 'package:flutter/material.dart';
import 'dart:math';

class TemplateTaskScreen extends StatefulWidget {
  final List<String> templates;
  final Function(String) onAddTemplate;
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
  final TextEditingController _controller = TextEditingController();

  late List<String> _localTemplates;

  @override
  void initState() {
    super.initState();
    _localTemplates = List<String>.from(widget.templates);
  }

  @override
  void didUpdateWidget(covariant TemplateTaskScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.templates != widget.templates) {
      _localTemplates = List<String>.from(widget.templates);
    }
  }

  void _addTemplate() {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _localTemplates.add(text);
      });
      widget.onAddTemplate(text);
      _controller.clear();
    }
  }

  void _removeTemplate(int index) {
    widget.onRemoveTemplate(index);
    setState(() {
      _localTemplates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Управление шаблонами задач')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Введите новый шаблон задачи',
                labelText: 'Новый шаблон',
              ),
              onSubmitted: (value) => _addTemplate(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addTemplate,
              child: const Text('Добавить шаблон'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _localTemplates.isEmpty
                  ? const Center(child: Text('Нет шаблонов'))
                  : ListView(
                children: _localTemplates.asMap().entries.map((entry) {
                  int index = entry.key;
                  String template = entry.value;
                  return Dismissible(
                    key: ValueKey(template),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _removeTemplate(index),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(template),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeTemplate(index),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
