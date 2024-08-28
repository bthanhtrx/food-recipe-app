import 'package:equatable/equatable.dart';

class RecipeParams extends Equatable {
  final String query;
  final String cuisine;
  final int servings;
  final String diet;
  final String intolerances;

  const RecipeParams({required this.query, required this.cuisine, required this.servings, required this.diet, required this.intolerances});

  @override
  List<Object?> get props => [query, cuisine, servings, diet, intolerances];
}