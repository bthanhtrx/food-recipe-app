import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/pages/recipe_screen.dart';
import 'package:food_recipe_app/widgets/category_badge.dart';
import 'package:food_recipe_app/widgets/custom_search_bar.dart';
import 'package:food_recipe_app/widgets/recipe_card.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodFuture = ref.watch(foodProvider(''));
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
              CustomSearchBar(),
              Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Gap(10),
              Row(
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
                      icon: Icons.bakery_dining_outlined, title: 'Bakes'),
                ],
              ),
              Gap(20),
              Text(
                'Today Recommended',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              randomRecipe.when(
                data: (data) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeScreen(data.id as int),
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
                                child: Image.network(data.image))),
                        Positioned(
                            bottom: 10,
                            left: 0,
                            child: Text(
                              data.title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                              // textAlign: TextAlign.start,
                            )),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text('error: $error');
                },
                loading: () => CircularProgressIndicator(),
              ),
              Gap(20),
              const Text(
                'Suggestions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const Gap(20),
              foodFuture.when(
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
                            builder: (context) => RecipeScreen(data[index].id),
                          )),
                      child: RecipeCard(
                        foodModel: data[index],
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
                error: (error, stackTrace) => Text('error: $error'),
                loading: () => const CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
