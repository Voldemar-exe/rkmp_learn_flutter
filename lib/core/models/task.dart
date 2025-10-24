class Task {
  final String id;
  final String text;
  bool isCompleted;
  final List<String> tags;

  Task({
    required this.id,
    required this.text,
    this.isCompleted = false,
    required this.tags,
  });

  Task copyWith({bool? isCompleted}) {
    return Task(
      id: id,
      text: text,
      isCompleted: isCompleted ?? this.isCompleted,
      tags: tags,
    );
  }
}
