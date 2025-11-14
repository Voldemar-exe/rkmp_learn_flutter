class TaskTemplate {
  final String text;
  final List<String> tags;

  TaskTemplate({
    required this.text,
    required this.tags,
  });

  TaskTemplate copyWith({String? text, List<String>? tags}) {
    return TaskTemplate(
      text: text ?? this.text,
      tags: tags ?? List<String>.from(this.tags),
    );
  }
}
