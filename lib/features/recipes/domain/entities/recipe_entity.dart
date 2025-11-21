class RecipeEntity {
  final int id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final Map<String, String> ingredientsWithMeasure;

  RecipeEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.ingredientsWithMeasure,
  });

  RecipeEntity copyWith({
    int? id,
    String? name,
    String? category,
    String? area,
    String? instructions,
    String? imageUrl,
    Map<String, String>? ingredientsWithMeasure,
  }) {
    return RecipeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      area: area ?? this.area,
      instructions: instructions ?? this.instructions,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredientsWithMeasure: ingredientsWithMeasure ?? this.ingredientsWithMeasure,
    );
  }

  factory RecipeEntity.fromJson(Map<String, dynamic> json) {
    return RecipeEntity(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      area: json['area'],
      instructions: json['instructions'],
      imageUrl: json['imageUrl'],
      ingredientsWithMeasure: Map<String, String>.from(json['ingredientsWithMeasure']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'area': area,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'ingredientsWithMeasure': ingredientsWithMeasure,
    };
  }
}