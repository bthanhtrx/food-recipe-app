import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:hive/hive.dart';

part 'food_model.g.dart';

@HiveType(typeId: 0)
class FoodModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String imageType;

  FoodModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.imageType});

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        imageType: json['imageType'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'imageType': imageType,
      };

  factory FoodModel.fromRecipeModel(RecipeModel recipe) => FoodModel(
      id: recipe.id as int,
      title: recipe.title,
      image: recipe.image,
      imageType: recipe.imageType);
}
