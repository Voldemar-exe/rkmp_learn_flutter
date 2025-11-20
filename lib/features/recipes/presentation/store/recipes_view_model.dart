import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rkmp_learn_flutter/features/recipes/data/models/recipe.dart';
import 'package:rkmp_learn_flutter/features/recipes/domain/entities/recipe_entity.dart';
import 'package:rkmp_learn_flutter/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:rkmp_learn_flutter/features/recipes/presentation/states/recipes_state.dart';

part 'recipes_view_model.g.dart';

@riverpod
class RecipesViewModel extends _$RecipesViewModel {
  late final RecipeRepository _repository;

  @override
  Future<RecipesState> build() async {
    _repository = GetIt.I<RecipeRepository>();
    loadRandomRecipe();
    return RecipesState(
      userRecipes: [],
      searchResults: [],
      selectedRecipe: null,
      randomRecipe: null,
      isLoading: false,
      error: null,
    );
  }

  Future<void> loadUserRecipes() async {
    _updateState(isLoading: true, error: null);
    try {
      final recipes = await _repository.getUserRecipes();
      _updateState(
        userRecipes: recipes
            .map((recipe) => Recipe.fromEntity(recipe))
            .toList(),
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
        searchResults: results
            .map((recipe) => Recipe.fromEntity(recipe))
            .toList(),
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
        searchResults: results
            .map((recipe) => Recipe.fromEntity(recipe))
            .toList(),
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
      _updateState(randomRecipe: Recipe.fromEntity(recipe), isLoading: false);
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
      _updateState(selectedRecipe: Recipe.fromEntity(recipe), isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to load recipe', isLoading: false);
    }
  }

  Future<void> findRecipesByIngredients(List<String> ingredients) async {
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.getRecipesByIngredients(ingredients);
      _updateState(searchResults: _mapRecipes(results), isLoading: false);
    } catch (e) {
      _updateState(
        error: 'Failed to find recipes by ingredients',
        isLoading: false,
      );
    }
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

  List<Recipe> _mapRecipes(List<RecipeEntity> recipes) {
    return recipes.map((recipe) => Recipe.fromEntity(recipe)).toList();
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
