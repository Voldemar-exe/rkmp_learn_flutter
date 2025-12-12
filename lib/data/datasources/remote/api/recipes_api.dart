import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../dto/api_recipe_dto.dart';

part 'recipes_api.g.dart';

@RestApi(baseUrl: 'https://www.themealdb.com/api/json/v1/1/')
abstract class RecipesApi {
  factory RecipesApi(Dio dio, {String baseUrl}) = _RecipesApi;

  @GET('/search.php')
  Future<RecipeResponse> searchRecipesByName(@Query('s') String query);

  @GET('/search.php')
  Future<RecipeResponse> getRecipesByFirstLetter(@Query('f') String letter);

  @GET('/lookup.php')
  Future<RecipeResponse> getRecipeById(@Query('i') int id);

  @GET('/random.php')
  Future<RecipeResponse> getRandomRecipe();
}
