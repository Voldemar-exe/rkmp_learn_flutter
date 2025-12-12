import 'package:dio/dio.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/dto/mappers/api_recipes_mapper.dart';

import '../../../../core/models/recipe.dart';
import '../dto/api_recipe_dto.dart';
import 'dio_client.dart';
import 'exceptions.dart';

class RecipesApiDataSource {
  final Dio _dio;

  RecipesApiDataSource(DioClient dioClient) : _dio = dioClient.instance;

  Future<Recipe> getRandomRecipe() async {
    try {
      final response = await _dio.get('random.php');
      final data = MealResponse.fromJson(response.data);
      final dto = data.meals!.first;
      return dto.toModel();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }

  Future<List<Recipe>> searchRecipesByName(String query) async {
    if (query.trim().isEmpty) return [];
    try {
      final response = await _dio.get(
        'search.php',
        queryParameters: {'s': query},
      );
      final data = MealResponse.fromJson(response.data);
      final dtos = data.meals ?? [];
      return dtos.map((d) => d.toModel()).toList();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }

  Future<Recipe?> getRecipeById(int id) async {
    try {
      final response = await _dio.get('lookup.php', queryParameters: {'i': id});
      final data = MealResponse.fromJson(response.data);
      final dto = data.meals?.firstOrNull;
      return dto?.toModel();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }

  Future<List<Recipe>> getRecipesByFirstLetter(String letter) async {
    if (letter.isEmpty || letter.length > 1) return [];
    try {
      final response = await _dio.get(
        'search.php',
        queryParameters: {'f': letter},
      );
      final data = MealResponse.fromJson(response.data);
      final dtos = data.meals ?? [];
      return dtos.map((d) => d.toModel()).toList();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }
}

extension FirstWhereExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
