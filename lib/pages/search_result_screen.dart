import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/database/recipe_notifier.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class SearchResultScreen extends ConsumerWidget {
  final String query;

  // final String cuisines;
  // final String diet;
  // final String intolerances;
  // final String servings;

  const SearchResultScreen(this.query, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(foodProvider({
      'query': query,
      'cuisine': ref.read(cuisinesProvider),
      'servings': ref.read(servingsProvider),
      'diet': ref.read(isVeganProvider) ? 'vegan' : '',
      'intolerances': ref.read(isGlutenFreeProvider) ? 'gluten' : '',
    }));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              search.when(
                  data: (data) => Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Gap(10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Consumer(
                            builder: (context, ref, child) {
                              bool isSaved = false;
                              isSaved = ref
                                  .watch(savedRecipeProvider)
                                  .contains(data[index]);

                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecipeScreen(data[index]),
                                    )),
                                child: Card(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10)),
                                            child: Image.network(
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Icon(Icons.warning),
                                              data[index].image,
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: Text(
                                            data[index].title,
                                            maxLines: 3,
                                            softWrap: true,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              isSaved
                                                  ? ref
                                                      .read(savedRecipeProvider
                                                          .notifier)
                                                      .delete(data[index])
                                                  : ref
                                                      .read(savedRecipeProvider
                                                          .notifier)
                                                      .add(data[index]);
                                              // isSaved = !isSaved;
                                            },
                                            icon: isSaved
                                                ? Icon(Icons.favorite_outlined)
                                                : Icon(Icons.favorite_outline)),
                                      ]),
                                ),
                              );
                            },
                          ),
                          itemCount: data.length,
                        ),
                      ),
                  error: (error, stackTrace) => Text('error: $error'),
                  loading: () => const CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
