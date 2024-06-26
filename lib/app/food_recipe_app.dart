import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/config/theme/app_theme.dart';
import 'package:food_recipe_app/pages/home_page.dart';
import 'package:food_recipe_app/providers/app_provider.dart';

class FoodRecipeApp extends ConsumerWidget {
  const FoodRecipeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(appThemeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: state,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      home: const HomePage(),
    );
  }
}
