import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/core/common/constant.dart';
import 'package:food_recipe_app/database/recipe_notifier.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/model/recipe_model.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:food_recipe_app/widgets/info_badge.dart';
import 'package:gap/gap.dart';
import 'package:read_more_text/read_more_text.dart';

class RecipeScreen extends ConsumerWidget {
  final FoodModel foodModel;

  const RecipeScreen(this.foodModel, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeFuture = ref.watch(recipeProvider(foodModel.id));
    bool isSaved = ref.watch(savedRecipeProvider).contains(foodModel);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          recipeFuture.when(
            data: (data) {
              final ingredients = data.extendedIngredients;
              final instructions = data.analyzedInstructions;

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    backgroundColor: Colors.black87,
                                    body: Center(
                                      child: CachedNetworkImage(
                                        imageUrl: data.image,
                                      ),
                                    ),
                                  ),
                                )),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                    Colors.black,
                                    Colors.transparent,
                                  ],
                                      begin: Alignment.center,
                                      end: Alignment.bottomCenter)
                                  .createShader(
                                Rect.fromLTRB(
                                    0, 0, bounds.width, bounds.height),
                              ),blendMode: BlendMode.dstIn,
                              child: CachedNetworkImage(
                                height: screenHeight * .4,
                                width: screenWidth,
                                imageUrl: data.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 5,
                          right: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white70),
                                    padding: EdgeInsets.all(8),
                                    child: Icon(Icons.arrow_back)),
                              ),
                              IconButton(
                                onPressed: () {
                                  isSaved
                                      ? ref
                                          .read(savedRecipeProvider.notifier)
                                          .delete(foodModel)
                                      : ref
                                          .read(savedRecipeProvider.notifier)
                                          .add(foodModel);
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white70),
                                  padding: EdgeInsets.all(8),
                                  child: isSaved
                                      ? Icon(Icons.favorite_outlined)
                                      : Icon(Icons.favorite_border_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      // Gap(20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Text(
                              data.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Row(children: [

                            ],),
                            Gap(20),
                            ReadMoreText(
                              data.summary.replaceAll(RegExp(r'<[^>]*>'), ''),
                              style: Theme.of(context).textTheme.titleSmall,
                              numLines: 3,
                              readLessText: 'Collapse',
                              readMoreText: 'Expand',
                            ),
                            Gap(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InfoBadge(
                                    content: '${data.servings}',
                                    title: 'Servings'),
                                InfoBadge(
                                    content: '${data.readyInMinutes}',
                                    title: 'Ready'),
                                InfoBadge(
                                    content: '${data.cookingMinutes}',
                                    title: 'Cooking Time'),
                                InfoBadge(
                                    content: '${data.healthScore}',
                                    title: 'Health Score'),
                              ],
                            ),
                            Gap(10),
                            // Container(width: 300, height: 2,decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.black54,)),),
                            _buildIngredientsList(ingredients, context, ref),
                            Gap(10),
                            _buildInstructions(instructions, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) =>
                Text('error: ${error} \n ${stackTrace}'),
            loading: () => CircularProgressIndicator(),
          ),
        ],
      )),
    );
  }

  Widget _buildIngredientsList(List<ExtendedIngredients> ingredients,
      BuildContext context, WidgetRef ref) {
    final unitMeasurement = ref.watch(unitMeasurementProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Gap(5),
          shrinkWrap: true,
          itemCount: ingredients.length,
          itemBuilder: (context, i) => Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          Constant.getIngredientsUrl(ingredients[i].image),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    Gap(10),
                    Expanded(
                        child: Text(
                      ingredients[i].originalName ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                  ],
                ),
              ),
              Gap(30),
              unitMeasurement == 'us'
                  ? Text(
                      '${ingredients[i].measures?.us.amount} ${ingredients[i].measures?.us.unitShort}',
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  : Text(
                      '${ingredients[i].measures?.metric.amount} ${ingredients[i].measures?.metric.unitShort}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions(
      List<AnalyzedInstructions> instructions, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => Text(
                  '${instructions[0].steps[index].number}. ${instructions[0].steps[index].step}',
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
            separatorBuilder: (context, index) => Gap(5),
            itemCount: instructions[0].steps.length)
      ],
    );
  }
}
