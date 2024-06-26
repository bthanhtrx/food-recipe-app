import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/common/shared_pref.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Gap(20),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Your Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 1))),
              onSubmitted: (value) {
                ref.read(sharedPrefsProvider).setUserName(value.trim());
              },
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode'),
                Switch(
                  value: ref.watch(isDarkMode),
                  onChanged: (value) {
                    ref.read(appThemeProvider.notifier).state =
                        ref.watch(appThemeProvider) == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark;
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
