import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/app/food_recipe_app.dart';
import 'package:food_recipe_app/model/food_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  Hive.registerAdapter(FoodModelAdapter());
  await Hive.openBox('favorite');


  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const FoodRecipeApp();
  }
}

