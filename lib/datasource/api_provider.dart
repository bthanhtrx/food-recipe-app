import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_service.dart';
import 'package:food_recipe_app/api/recipe_params.dart';
import 'package:food_recipe_app/core/error/exception.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final recipeProvider = FutureProvider.family<RecipeModel, int>((ref, id) {
  return ref.read(apiProvider).getRecipe(id);
});

final foodProvider = FutureProvider.autoDispose
    .family<List<FoodModel>, RecipeParams>((ref, params) {
  try {
    return ref.read(apiProvider).getListFood(
          query: params.query,
          cuisine: params.cuisine,
          diet: params.diet,
          intolerances: params.intolerances,
          maxServings: params.servings,
        );
  } catch (e) {
    throw NetworkException(e.toString());
  }
});

final randomRecipeProvider = FutureProvider(
  (ref) {
    return ref.read(apiProvider).getRandomRecipe();
  },
);

final similarRecipeProvider = FutureProvider(
  (ref) {},
);
