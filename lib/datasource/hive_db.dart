import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:hive/hive.dart';

final hiveRepositoryProvider = Provider((ref) {
  return HiveDb();
});

class HiveDb {
  static final favBox = Hive.box('favorite');
  static final detailBox = Hive.box('detail');

  List<FoodModel> getAllRecipes()  {
    // Load recipes from Hive box
    List<FoodModel> data = [];
    final keyList = favBox.keys.toList();
    
    for(int i = 0; i < favBox.length; i++) {
      // if(userBox.get(i) != null) {
      //   data.add(FoodModel.fromJson(userBox.get(i)));
      // }
      data.add(favBox.get(keyList[i]));
    }

    return data;
  }

  void addToFav(FoodModel item) {
    favBox.put(item.id, item);

  }

  void deleteFromFav(FoodModel item) {
    favBox.delete(item.id);
  }

  void addToDetail(RecipeModel item) {
    detailBox.put(item.id, item);
  }

  RecipeModel? getRecipeModel(int id) {
    final keyList = detailBox.keys.toList();

    for(int i = 0; i < keyList.length; i++) {
      if(detailBox.get(keyList[i]).id == id) {
        return detailBox.get(keyList[i]);
      }
    }
    return null;
  }

  void deleteFromDetail(RecipeModel item) {
    detailBox.delete(item.id);
  }

}
