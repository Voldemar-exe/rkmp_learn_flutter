class IngredientEntity {
  final int id;
  final String name;
  final String? measureUnit;
  final double? amount;

  IngredientEntity({
    required this.id,
    required this.name,
    this.measureUnit,
    this.amount,
  });

  IngredientEntity copyWith({
    int? id,
    String? name,
    String? measureUnit,
    double? amount,
  }) {
    return IngredientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      measureUnit: measureUnit ?? this.measureUnit,
      amount: amount ?? this.amount,
    );
  }
}