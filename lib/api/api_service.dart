import 'dart:convert';

import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:food_recipe_app/secrets/api_key.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<FoodModel>> getListFood(
      {String query = '', String cuisine = ''}) async {
    final url =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&cuisine=$cuisine&apiKey=${apiKey}';
    print('url: $url');
    try {
      final response = await http.get(Uri.parse(url));

      return (jsonDecode(response.body)['results'] as List)
          .map(
            (e) => FoodModel.fromJson(e),
          )
          .toList();
    } catch (e) {
      throw 'Unexpected error occurred: $e';
    }
  }

  Future<RecipeModel> getRecipe(int id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=${apiKey}';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      return RecipeModel.fromJson((jsonDecode(response.body)));
    } catch (e) {
      throw 'Unexpected error occurred: $e';
    }
  }

  Future<RecipeModel> getRandomRecipe() async {
    final url = 'https://api.spoonacular.com/recipes/random?apiKey=${apiKey}';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      return (jsonDecode(response.body)['recipes'] as List)
          .map(
            (e) => RecipeModel.fromJson(e),
          )
          .toList()
          .first;
    } catch (e) {
      throw 'Unexpected error occurred: $e';
    }
  }
}
