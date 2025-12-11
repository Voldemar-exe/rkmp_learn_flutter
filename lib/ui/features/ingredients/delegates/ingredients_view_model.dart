import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/ingredient.dart';
import '../../../../domain/interfaces/repositories/ingredient_repository.dart';
import 'states/ingredients_list_state.dart';

part 'ingredients_view_model.g.dart';

@riverpod
class IngredientsViewModel extends _$IngredientsViewModel {
  late final IngredientRepository _repository;

  @override
  Future<IngredientsListState> build() async {
    _repository = GetIt.I<IngredientRepository>();

    try {
      final ingredients = await _repository.getUserIngredients();
      final availableIngredients = await _repository.getAvailableIngredients();

      _listenToDatabaseChanges();

      return IngredientsListState(
        ingredients: ingredients,
        searchResults: [],
        availableIngredients: availableIngredients,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      return IngredientsListState(
        ingredients: [],
        searchResults: [],
        availableIngredients: [],
        isLoading: false,
        error: 'Failed to load ingredients: $e',
      );
    }
  }

  void _listenToDatabaseChanges() {
    _repository.watchUserIngredients().listen((ingredients) {
      _updateState(ingredients: ingredients);
    });
  }

  Future<void> loadUserIngredients() async {
    _updateState(isLoading: true, error: null);
    try {
      final ingredients = await _repository.getUserIngredients();
      _updateState(
        ingredients: ingredients,
        searchResults: [],
        isLoading: false,
      );
    } catch (e) {
      _updateState(error: 'Failed to load ingredients', isLoading: false);
    }
  }

  Future<void> loadAvailableIngredients() async {
    _updateState(isLoading: true, error: null);
    try {
      final ingredients = await _repository.getAvailableIngredients();
      _updateState(availableIngredients: ingredients, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to load ingredients', isLoading: false);
    }
  }

  Future<void> searchIngredients(String query) async {
    if (query.isEmpty) {
      _updateState(searchResults: []);
      return;
    }
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.searchAvailableIngredientsByName(query);
      _updateState(searchResults: results, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to search ingredients', isLoading: false);
    }
  }

  Future<void> searchAvailableIngredients(String query) async {
    if (query.isEmpty) {
      _updateState(searchResults: []);
      return;
    }
    _updateState(isLoading: true, error: null);
    try {
      final results = await _repository.searchAvailableIngredientsByName(query);
      _updateState(searchResults: results, isLoading: false);
    } catch (e) {
      _updateState(error: 'Failed to search ingredients', isLoading: false);
    }
  }

  Future<void> addOrUpdateIngredient(Ingredient ingredient) async {
    try {
      await _repository.addOrUpdateIngredient(ingredient);
      await loadUserIngredients();
    } catch (e) {
      _updateState(error: 'Failed to add/update ingredient with: $e');
    }
  }

  Future<void> removeIngredient(int ingredientId) async {
    try {
      await _repository.removeIngredient(ingredientId);
      await loadUserIngredients();
    } catch (e) {
      _updateState(error: 'Failed to remove ingredient');
    }
  }

  Future<void> addAmount(int ingredientId, double amount) async {
    try {
      await _repository.addAmount(ingredientId, amount);
      await loadUserIngredients();
    } catch (e) {
      _updateState(error: 'Failed to add amount');
    }
  }

  Future<void> consumeAmount(int ingredientId, double amount) async {
    try {
      await _repository.consumeAmount(ingredientId, amount);
      await loadUserIngredients();
    } catch (e) {
      _updateState(error: 'Failed to consume amount');
    }
  }

  void _updateState({
    List<Ingredient>? ingredients,
    List<Ingredient>? searchResults,
    List<Ingredient>? availableIngredients,
    bool? isLoading,
    String? error,
  }) {
    state = AsyncValue.data(
      state.value!.copyWith(
        ingredients: ingredients ?? state.value!.ingredients,
        searchResults: searchResults ?? state.value!.searchResults,
        availableIngredients:
            availableIngredients ?? state.value!.availableIngredients,
        isLoading: isLoading ?? state.value!.isLoading,
        error: error,
      ),
    );
  }
}
