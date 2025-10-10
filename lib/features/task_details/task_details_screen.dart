import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  final int taskIndex;
  final String taskText;
  final bool isCompleted;
  final List<String> tags;
  final Function(int, bool) onUpdateStatus;
  final Function(int, List<String>) onUpdateTags;

  const TaskDetailScreen({
    super.key,
    required this.taskIndex,
    required this.taskText,
    required this.isCompleted,
    required this.tags,
    required this.onUpdateStatus,
    required this.onUpdateTags,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late List<String> _tags;
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tags = List<String>.from(widget.tags);
  }

  void _saveTags() {
    widget.onUpdateTags(widget.taskIndex, _tags);
  }

  void _addTag() {
    String tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
      });
      _tagController.clear();
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали задачи')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Задача: ${widget.taskText}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Статус: ${widget.isCompleted ? 'Выполнено' : 'Не выполнено'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onUpdateStatus(widget.taskIndex, !widget.isCompleted);
                Navigator.pop(context);
              },
              child: Text(
                widget.isCompleted
                    ? 'Отметить как невыполненное'
                    : 'Отметить как выполненное',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Теги:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(hintText: 'Введите тег'),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTag),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _tags.isEmpty
                  ? const Center(child: Text('Нет тегов'))
                  : ListView.separated(
                      itemCount: _tags.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        String tag = _tags[index];
                        return Dismissible(
                          key: ValueKey(tag),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => _removeTag(tag),
                          child: ListTile(
                            title: Text('#$tag'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeTag(tag),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveTags();
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
