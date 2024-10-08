import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/model/food_model.dart';

import 'hive_db.dart';

final savedRecipeProvider = StateNotifierProvider<RecipeNotifier, List<FoodModel>>((ref) {
  return RecipeNotifier(ref.read(hiveRepositoryProvider));
},);

class RecipeNotifier extends StateNotifier<List<FoodModel>> {
  final HiveDb hiveDb;

  RecipeNotifier(this.hiveDb) : super([]) {
    _loadFavFromHive();
  }

  void _loadFavFromHive() {
    state = hiveDb.getAllRecipes();
  }

  void add(FoodModel item) {
    state = [...state, item];
    hiveDb.addToFav(item);
  }

  void delete(FoodModel item) {
    state = [for (final fav in state)
      if(fav.id != item.id) fav];

  }
}


