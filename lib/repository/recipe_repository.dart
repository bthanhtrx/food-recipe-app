import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/datasource/api_provider.dart';
import 'package:hive/hive.dart';

final recipeRepositoryProvider = Provider((ref) {
  return RecipeRepository();
},);

class RecipeRepository {
  final detailBox = Hive.box('detail');

  Future getRecipeDetail(int recipeId) async {
    final recipe = detailBox.get(recipeId);

    if(recipe != null) {
      return recipe;
    }

    final recipeFromNetwork = Provider((ref) {
      return ref.watch(recipeProvider(recipeId)).value;
    },);

    return recipeFromNetwork;
  }
}