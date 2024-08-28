
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/datasource/api_provider.dart';
import 'package:food_recipe_app/api/recipe_params.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:food_recipe_app/widgets/advanced_search_dialog.dart';
import 'package:food_recipe_app/widgets/category_badge.dart';
import 'package:food_recipe_app/widgets/custom_search_bar.dart';
import 'package:food_recipe_app/widgets/recipe_card.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final RecipeParams params = const RecipeParams(query: '', cuisine: '', servings: 1, diet: '', intolerances: '');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();

    final foodFuture = ref.watch(foodProvider(params));
    final randomRecipe = ref.watch(randomRecipeProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Text(
                'Hi ${ref.watch(currentUser)?.displayName ?? ref.watch(userNameProvider)}! 👋',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Got a tasty dish in mind?',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: CustomSearchBar(hintText: 'Search any recipes', controller: searchController,)),
                  GestureDetector(
                    onTap: () => showDialog(
                      builder: (context) => const AdvancedSearchDialog(),
                      context: context,
                    ),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1)),
                        child: Icon(Icons.tune_outlined)),
                  ),
                ],
              ),
              Text('Categories', style: Theme.of(context).textTheme.titleLarge),
              Gap(10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryBadge(
                      icon: Icons.breakfast_dining_outlined,
                      title: 'Breakfast'),
                  CategoryBadge(
                      icon: Icons.lunch_dining_outlined, title: 'Lunch'),
                  CategoryBadge(icon: Icons.dining_outlined, title: 'Dinner'),
                  CategoryBadge(icon: Icons.cookie, title: 'Noodles'),
                  CategoryBadge(
                      icon: Icons.bakery_dining_outlined, title: 'Seafood'),
                ],
              ),
              Gap(20),
              Text('Today Recommended',
                  style: Theme.of(context).textTheme.titleLarge),
              randomRecipe.when(
                data: (data) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RecipeScreen(FoodModel.fromRecipeModel(data)),
                        )),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black,
                                    Colors.transparent
                                  ]).createShader(Rect.fromLTRB(
                                  0, 0, bounds.width, bounds.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: Image.network(data.image),
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            left: 10,
                            child: Text(data.title,
                                style: Theme.of(context).textTheme.titleMedium
                                // textAlign: TextAlign.start,
                                )),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) {
                  print('error: $error');
                  return Text('Error occurred. Try again later.');
                },
                loading: () => CircularProgressIndicator(),
              ),
              Gap(20),
              Text('Suggestions',
                  style: Theme.of(context).textTheme.titleLarge),
              const Gap(20),
              foodFuture.when(
                // skipLoadingOnRefresh: true,
                data: (data) => SizedBox(
                  height: 300,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Gap(10),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeScreen(data[index]),
                          )),
                      child: RecipeCard(
                        foodModel: data[index],
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
                error: (error, stackTrace) {
                  print('error: $error - stack: $stackTrace');
                  return Text('Error occurred. Try again later.');
                },
                loading: () => const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
