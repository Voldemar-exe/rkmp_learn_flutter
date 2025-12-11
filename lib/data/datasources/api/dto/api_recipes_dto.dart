class ApiRecipesDto {
  final int id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final Map<String, String> ingredientsWithMeasure;

  ApiRecipesDto({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.ingredientsWithMeasure,
  });

  factory ApiRecipesDto.fromJson(Map<String, dynamic> json) {
    final imageUrl = (json['imageUrl'] as String?)?.trim() ?? '';

    final ingredients = <String, String>{};
    final rawIngredients = json['ingredientsWithMeasure'] as Map?;
    if (rawIngredients != null) {
      rawIngredients.forEach((key, value) {
        if (key is String && value is String) {
          ingredients[key] = value.trim();
        }
      });
    }

    return ApiRecipesDto(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      area: json['area'] as String,
      instructions: json['instructions'] as String,
      imageUrl: imageUrl,
      ingredientsWithMeasure: ingredients,
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