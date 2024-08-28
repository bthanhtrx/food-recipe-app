import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/datasource/recipe_notifier.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class SavedScreen extends ConsumerStatefulWidget {
  const SavedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedScreenState();
}

class _SavedScreenState extends ConsumerState<SavedScreen> {
  late List<FoodModel> recipe;
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    recipe = ref.watch(savedRecipeProvider);
    final authState = ref.watch(currentUserStream);

    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: authState.when(
              data: (data) {

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Text(
                      'Saved',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Search saved recipes',
                      ),
                      controller: searchController,
                      onChanged: (value) => searchRecipe(value),
                    ),
                    recipe.isEmpty
                        ? Center(
                            child: Text(
                              'No favorite recipes.',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Gap(10),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Consumer(
                                builder: (context, ref, child) => Dismissible(
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
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
                                              RecipeScreen(recipe[index]),
                                        )),
                                    child: Card(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10)),
                                              child: CachedNetworkImage(
                                                imageUrl: recipe[index].image,
                                                width: 100,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                              ),
                                            ),
                                            const Gap(10),
                                            Expanded(
                                              child: Text(recipe[index].title,
                                                  maxLines: 3,
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
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
                );
              },
              error: (error, stackTrace) {},
              loading: () => const CircularProgressIndicator(),
            )),
      ),
    );
  }

  void searchRecipe(String query) {
    final recipeSearchTitle = ref.read(savedRecipeProvider).where((element) {
      final title = element.title;
      return title.trim().toLowerCase().contains(query.toLowerCase());
    }).toList();
    print('search: $recipeSearchTitle');
    setState(() {
      recipe = recipeSearchTitle;
    });
  }
}
