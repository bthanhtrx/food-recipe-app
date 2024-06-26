import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/model/food_model.dart';

import 'hive_repository.dart';

final savedRecipeProvider = StateNotifierProvider<RecipeNotifier, List<FoodModel>>((ref) {
  return RecipeNotifier(ref.read(hiveRepositoryProvider));
},);

class RecipeNotifier extends StateNotifier<List<FoodModel>> {
  final HiveRepository hiveRepository;

  RecipeNotifier(this.hiveRepository) : super([]) {
    _loadFavFromHive();
  }

  void _loadFavFromHive() {
    state = hiveRepository.getAllRecipes();
  }

  void add(FoodModel item) {
    state = [...state, item];
    hiveRepository.addToFav(item);
  }

  void delete(FoodModel item) {
    state = [for (final fav in state)
      if(fav.id != item.id) fav];
  }
}
