import 'package:dio/dio.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/api/interceptors/error_handling_interceptor.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/api/interceptors/logging_interceptor.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/api/recipes_api.dart';
import 'package:rkmp_learn_flutter/data/datasources/remote/dto/mappers/api_recipes_mapper.dart';

import '../../../../core/models/recipe.dart';
import 'exceptions.dart';

class RecipesApiDataSource {
  final RecipesApi _api;

  RecipesApiDataSource(this._api);

  Future<Recipe> getRandomRecipe() async {
    try {
      final response = await _api.getRandomRecipe();
      final dto = response.meals!.first;
      return dto.toModel();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }

  Future<List<Recipe>> searchRecipesByName(String query) async {
    if (query.trim().isEmpty) return [];
    try {
      final response = await _api.searchRecipesByName(query);
      final dtos = response.meals ?? [];
      return dtos.map((d) => d.toModel()).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw BadRequestException(
          'API Error ${e.response?.statusCode}: ${e.message}',
        );
      } else if (e.response?.statusCode == 408) {
        throw NetworkException('Network error: ${e.message}');
      } else {
        throw Exception('Unknown Dio error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Recipe?> getRecipeById(int id) async {
    try {
      final response = await _api.getRecipeById(id);
      final dto = response.meals?.firstOrNull;
      return dto?.toModel();
    } catch (e) {
      if (e is DioException) rethrow;
      throw ServerException();
    }
  }

  Future<List<Recipe>> getRecipesByFirstLetter(String letter) async {
    if (letter.isEmpty || letter.length > 1) return [];
    try {
      final response = await _api.getRecipesByFirstLetter(letter);
      final dtos = response.meals ?? [];
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


