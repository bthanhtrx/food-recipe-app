import 'dart:convert';

import 'package:food_recipe_app/core/error/exception.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:food_recipe_app/core/secrets/api_key.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Future<List<FoodModel>> getListFood({String query = '',
    String cuisine = '',
    String diet = '',
    String intolerances = '',
    int maxServings = 1}) async {
    final url =
        'https://api.spoonacular.com/recipes/complexSearch?query=$query&cuisine=$cuisine&diet=$diet&intolerances=$intolerances&maxServings=$maxServings&apiKey=${apiKey}';
    print('url: $url');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['results'] as List)
          .map(
            (e) => FoodModel.fromJson(e),
      )
          .toList();
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }

  Future<RecipeModel> getRecipe(int id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=${apiKey}';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

    return RecipeModel.fromJson((jsonDecode(response.body)));
    } else {
    throw jsonDecode(response.body)['message'];
    }

    }

  Future<RecipeModel> getRandomRecipe() async {
    final url = 'https://api.spoonacular.com/recipes/random?apiKey=${apiKey}';
    print(url);

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['recipes'] as List)
          .map(
            (e) => RecipeModel.fromJson(e),
      )
          .toList()
          .first;
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }
}
