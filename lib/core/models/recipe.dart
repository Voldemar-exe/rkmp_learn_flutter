class Recipe {
  final int id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final Map<String, String> ingredientsWithMeasure;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.ingredientsWithMeasure,
  });

  Recipe copyWith({
    int? id,
    String? name,
    String? category,
    String? area,
    String? instructions,
    String? imageUrl,
    Map<String, String>? ingredientsWithMeasure,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      area: area ?? this.area,
      instructions: instructions ?? this.instructions,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredientsWithMeasure:
          ingredientsWithMeasure ?? this.ingredientsWithMeasure,
    );
  }
}
