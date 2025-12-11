class Ingredient {
  final int id;
  final String name;
  final String? measureUnit;
  final double? amount;

  Ingredient({
    required this.id,
    required this.name,
    this.measureUnit,
    this.amount,
  });

  Ingredient copyWith({
    int? id,
    String? name,
    String? measureUnit,
    double? amount,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      measureUnit: measureUnit ?? this.measureUnit,
      amount: amount ?? this.amount,
    );
  }
}