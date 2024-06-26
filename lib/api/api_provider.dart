import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_service.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});


final recipeProvider = FutureProvider.family<RecipeModel, int>((ref, id) {
  return ref.read(apiProvider).getRecipe(id);
});

final foodProvider = FutureProvider.family<List<FoodModel>, String>((ref, query) {
  return ref.read(apiProvider).getListFood(query: query);
});

final randomRecipeProvider = FutureProvider((ref) {
  return ref.read(apiProvider).getRandomRecipe();
},);
