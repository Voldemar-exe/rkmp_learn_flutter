import 'package:rkmp_learn_flutter/features/ingredients/domain/entities/ingredient_entity.dart';

class Ingredient extends IngredientEntity {
  Ingredient({
    required super.id,
    required super.name,
    super.measureUnit,
    super.amount,
  });

  IngredientEntity toEntity() => IngredientEntity(
    id: id,
    name: name,
    measureUnit: measureUnit,
    amount: amount,
  );

  factory Ingredient.fromEntity(IngredientEntity entity) => Ingredient(
    id: entity.id,
    name: entity.name,
    measureUnit: entity.measureUnit,
    amount: entity.amount,
  );

  @override
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