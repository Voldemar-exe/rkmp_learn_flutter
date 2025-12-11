import '../../../../../core/models/ingredient.dart';

class IngredientsListState {
  final List<Ingredient> ingredients;
  final List<Ingredient> searchResults;
  final List<Ingredient> availableIngredients;
  final bool isLoading;
  final String? error;

  const IngredientsListState({
    required this.ingredients,
    required this.searchResults,
    required this.availableIngredients,
    this.isLoading = false,
    this.error,
  });

  IngredientsListState copyWith({
    List<Ingredient>? ingredients,
    List<Ingredient>? searchResults,
    List<Ingredient>? availableIngredients,
    bool? isLoading,
    String? error,
  }) {
    return IngredientsListState(
      ingredients: ingredients ?? this.ingredients,
      searchResults: searchResults ?? this.searchResults,
      availableIngredients: availableIngredients ?? this.availableIngredients,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}