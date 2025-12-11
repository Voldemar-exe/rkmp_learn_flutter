import '../../../../../core/models/recipe.dart';

class RecipesState {
  final List<Recipe> userRecipes;
  final List<Recipe> searchResults;
  final Recipe? selectedRecipe;
  final Recipe? randomRecipe;
  final bool isLoading;
  final String? error;

  RecipesState({
    required this.userRecipes,
    required this.searchResults,
    required this.selectedRecipe,
    required this.randomRecipe,
    required this.isLoading,
    required this.error,
  });

  RecipesState copyWith({
    List<Recipe>? userRecipes,
    List<Recipe>? searchResults,
    Recipe? selectedRecipe,
    Recipe? randomRecipe,
    bool? isLoading,
    String? error,
  }) {
    return RecipesState(
      userRecipes: userRecipes ?? this.userRecipes,
      searchResults: searchResults ?? this.searchResults,
      selectedRecipe: selectedRecipe ?? this.selectedRecipe,
      randomRecipe: randomRecipe ?? this.randomRecipe,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
