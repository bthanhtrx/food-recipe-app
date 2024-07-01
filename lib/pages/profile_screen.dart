import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/core/common/shared_pref.dart';
import 'package:food_recipe_app/providers/app_provider.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
nameController.text = ref.watch(userNameProvider);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Name'),
                Spacer(),
                Expanded(
                  child: TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 1))),
                    onSubmitted: (value) {
                      ref.read(userNameProvider.notifier).setUserName(value.trim());
                    },
                  ),
                ),
              ],
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Unit of measurement'),
                DropdownMenu(
                  initialSelection: ref.watch(unitMeasurementProvider),
                  dropdownMenuEntries: ['us', 'metric']
                      .map(
                        (e) => DropdownMenuEntry(label: e, value: e),
                      )
                      .toList(),
                  inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onSelected: (value) {
                    ref.read(unitMeasurementProvider.notifier).setUnitMeasurement(value!);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
