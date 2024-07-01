import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/api_provider.dart';
import 'package:food_recipe_app/pages/search_result_screen.dart';
import 'package:gap/gap.dart';

class CategoryBadge extends ConsumerWidget {
  final IconData icon;
  final String title;

  const CategoryBadge({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultScreen(title),
          )),
      child: Container(
        width: 70,
        height: 70,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon), Gap(10), Text(title, style: Theme.of(context).textTheme.titleSmall,)],
        ),
      ),
    );
  }
}
