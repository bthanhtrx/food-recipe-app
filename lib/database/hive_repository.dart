import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:hive/hive.dart';

final hiveRepositoryProvider = Provider((ref) {
  return HiveRepository();
});

class HiveRepository {
  static final userBox = Hive.box('favorite');

  // static addFav(FoodModel item) {
  //   userBox.put(item.id, item);
  //
  // }

  List<FoodModel> getAllRecipes()  {
    // Load recipes from Hive box
    List<FoodModel> data = [];
    final keyList = userBox.keys.toList();
    
    for(int i = 0; i < userBox.length; i++) {
      // if(userBox.get(i) != null) {
      //   data.add(FoodModel.fromJson(userBox.get(i)));
      // }
      data.add(userBox.get(keyList[i]));
    }

    return data;
  }

  void addToFav(FoodModel item) {
    userBox.put(item.id, item);

  }

  void delete(FoodModel item) {
    userBox.delete(item.id);
  }

}
