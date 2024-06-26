import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/database/recipe_notifier.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:gap/gap.dart';

class SearchScreen extends ConsumerWidget {
  final String query;

  const SearchScreen(this.query, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(foodProvider(query));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        isSaved = ref.watch(savedRecipeProvider).contains(data[index]);

                      return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreen(data[index].id),
                          )),
                      child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                                child: Image.network(
                                  data[index].image,
                                  width: 100,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Text(
                                  data[index].title,
                                  maxLines: 3,
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    isSaved ?
                                    ref.read(savedRecipeProvider.notifier).delete(data[index]):
                                    ref.read(savedRecipeProvider.notifier).add(data[index]);
                                    // isSaved = !isSaved;
                                  },
                                  icon: isSaved ? Icon(Icons.favorite_outlined) :Icon(Icons.favorite_outline)),
                            ]),
                      ),
                    );
                    },
                  ),
                  itemCount: data.length,
                ),
              ),
              error: (error, stackTrace) => Text('error: $error'),
              loading: () => const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
