import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/widgets/info_badge.dart';
import 'package:gap/gap.dart';

class RecipeScreen extends ConsumerWidget {
  final int recipeId;

  const RecipeScreen(this.recipeId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = ref.watch(recipeProvider(recipeId));

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          s.when(
            data: (data) => Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CachedNetworkImage(imageUrl: data.image),
                    Text(
                      data.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(11),
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.greenAccent,
                          border: Border.all(
                            width: 2,
                          )),
                      child: Text(
                        data.summary,
                        softWrap: true,
                      ),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoBadge(
                            content: '${data.servings}', title: 'Servings'),
                        InfoBadge(
                            content: '${data.readyInMinutes}', title: 'Ready'),
                        InfoBadge(
                            content: '${data.cookingMinutes}',
                            title: 'Cooking Time'),
                        InfoBadge(
                            content: '${data.healthScore}',
                            title: 'Health Score'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => Text('error: $error \n $stackTrace'),
            loading: () => CircularProgressIndicator(),
          ),
        ],
      )),
    );
  }
}
