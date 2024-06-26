

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/common/shared_pref.dart';

final appThemeProvider = StateProvider((ref) {
  return ThemeMode.light;
},);

final isDarkMode = StateProvider((ref) {
  return ref.watch(appThemeProvider) == ThemeMode.dark;
});

final userNameProvider = StateProvider((ref) async{
  return await ref.watch(sharedPrefsProvider).userName;
},);