import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/recipe.dart';
import '../../../../domain/interfaces/repositories/recipe_repository.dart';
import 'states/recipes_state.dart';

part 'recipes_view_model.g.dart';

@riverpod
class RecipesViewModel extends _$RecipesViewModel {
  late final RecipeRepository _repository;

  @override
  Future<RecipesState> build() async {
    _repository = GetIt.I<RecipeRepository>();
    try {
      final recipes = await _repository.getUserRecipes();
      final recipe = await _repository.getRandomRecipe();
      return RecipesState(
        userRecipes: recipes,
        searchResults: [],
        selectedRecipe: null,
        randomRecipe: recipe,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      print(e);
      return RecipesState(
        userRecipes: [],
        searchResults: [],
        selectedRecipe: null,
        randomRecipe: null,
        isLoading: false,
        error: null,
      );
    }
  }

  Future<void> loadUserRecipes() async {
    _updateState(isLoading: true, error: null);
    try {
      final recipes = await _repository.getUserRecipes();
      _updateState(
        userRecipes: recipes,
        isLoading: false,
      );
    } catch (e) {
      _updateState(error: 'Failed to load recipes', isLoading: false);
    }
  }

  Future<void> searchRecipes(String query) async {
    if (query.isEmpty) {
      _updateState(searchResults: []);
      return;
    }
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.searchRecipesByName(query);
      _updateState(
        searchResults: results,
        isLoading: false,
      );
    } catch (e) {
      _updateState(error: 'Failed to search recipes', isLoading: false);
    }
  }

  Future<void> searchUserRecipes(String query) async {
    if (query.isEmpty) {
      _updateState(searchResults: []);
      return;
    }
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.searchUserRecipesByName(query);
      _updateState(
        searchResults: results,
        isLoading: false,
      );
    } catch (e) {
      _updateState(error: 'Failed to search recipes', isLoading: false);
    }
  }

  Future<void> loadRandomRecipe() async {
    _updateState(isLoading: true, error: null);
    try {
      final recipe = await _repository.getRandomRecipe();
      _updateState(randomRecipe: recipe, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to load random recipe', isLoading: false);
    }
  }

  Future<void> loadRecipeById(int id) async {
    _updateState(isLoading: true, error: null);
    try {
      final recipe = await _repository.getRecipeById(id);
      if (recipe == null) {
        _updateState(error: 'Recipe not found', isLoading: false);
        return;
      }
      _updateState(selectedRecipe: recipe, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to load recipe', isLoading: false);
    }
  }

  Future<void> findRecipesByIngredients(List<String> ingredients) async {
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.getRecipesByIngredients(ingredients);
      _updateState(searchResults: results, isLoading: false);
    } catch (e) {
      _updateState(
        error: 'Failed to find recipes by ingredients',
        isLoading: false,
      );
    }
  }

  void resetSearchResults() {
    _updateState(searchResults: []);
  }

  void selectRecipe(Recipe recipe) {
    _updateState(selectedRecipe: recipe);
  }

  Future<void> saveRecipe(Recipe recipe) async {
    try {
      await _repository.saveRecipe(recipe);
      await loadUserRecipes();
    } catch (e) {
      _updateState(error: 'Failed to save recipe');
    }
  }

  Future<void> removeRecipe(int recipeId) async {
    try {
      await _repository.removeRecipe(recipeId);
      await loadUserRecipes();
    } catch (e) {
      _updateState(error: 'Failed to remove recipe');
    }
  }

  void _updateState({
    List<Recipe>? userRecipes,
    List<Recipe>? searchResults,
    Recipe? selectedRecipe,
    Recipe? randomRecipe,
    bool? isLoading,
    String? error,
  }) {
    state = AsyncValue.data(
      state.value!.copyWith(
        userRecipes: userRecipes ?? state.value!.userRecipes,
        searchResults: searchResults ?? state.value!.searchResults,
        selectedRecipe: selectedRecipe ?? state.value!.selectedRecipe,
        randomRecipe: randomRecipe ?? state.value!.randomRecipe,
        isLoading: isLoading ?? state.value!.isLoading,
        error: error,
      ),
    );
  }
}
