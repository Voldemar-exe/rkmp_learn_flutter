class Template {
  final String text;
  final List<String> tags;

  Template({
    required this.text,
    required this.tags,
  });

  Template copyWith({String? text, List<String>? tags}) {
    return Template(
      text: text ?? this.text,
      tags: tags ?? List<String>.from(this.tags),
    );
  }
}
