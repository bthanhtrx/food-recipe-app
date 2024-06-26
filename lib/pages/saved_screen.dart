import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/database/recipe_notifier.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:gap/gap.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipe = ref.watch(savedRecipeProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(20),
            recipe.isEmpty
                ? const Center(child: Text('No favorite recipes.'))
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Gap(10),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Consumer(
                        builder: (context, ref, child) => Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.endToStart) {
                              ref
                                  .read(savedRecipeProvider.notifier)
                                  .delete(recipe[index]);
                            }
                          },
                          key: Key('${recipe[index].id}'),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RecipeScreen(recipe[index].id),
                                )),
                            child: Card(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        imageUrl: recipe[index].image,
                                        width: 100,
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                      ),
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: Text(
                                        recipe[index].title,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                      itemCount: recipe.length,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
