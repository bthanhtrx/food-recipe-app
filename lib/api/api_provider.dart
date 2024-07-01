import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_service.dart';
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
    .family<List<FoodModel>, Map<String, dynamic>>((ref, query) {
  try {
    return ref.read(apiProvider).getListFood(
          query: query['query'] ?? '',
          cuisine: query['cuisine'] ?? '',
          diet: query['diet'] ?? '',
          intolerances: query['intolerances'] ?? '',
          maxServings: query['servings'] ?? 1,
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
