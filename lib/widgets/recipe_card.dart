import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/firebase_auth_service.dart';
import 'package:food_recipe_app/api/firestore_service.dart';
import 'package:food_recipe_app/datasource/recipe_notifier.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class RecipeCard extends StatefulWidget {
  final FoodModel foodModel;

  const RecipeCard({super.key, required this.foodModel});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        width: 200,
        height: 300,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: widget.foodModel.image,
                    )),
                Gap(10),
                Text(
                  widget.foodModel.title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
            Positioned(
                top: 4,
                right: 5,
                child: Consumer(
                  builder: (context, ref, child) {
                    print(ref.read(savedRecipeProvider));
                    _isFav = ref.read(savedRecipeProvider).any(
                          (element) => element.id == widget.foodModel.id,
                        );
                    // .contains(widget.foodModel);
                    // print('item: ${widget.foodModel.title} - $_isFav');
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_isFav) {
                              ref
                                  .read(savedRecipeProvider.notifier)
                                  .delete(widget.foodModel);


                            } else {
                              ref
                                  .read(savedRecipeProvider.notifier)
                                  .add(widget.foodModel);

                            }
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color: Colors.red.shade300),
                            child: _isFav
                                ? Icon(
                                    Icons.favorite_outlined,
                                    color: Colors.white,
                                  )
                                : Icon(Icons.favorite_outline_outlined)));
                  },
                )),
          ],
        ));
  }
}
