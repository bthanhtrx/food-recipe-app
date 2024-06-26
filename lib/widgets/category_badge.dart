import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryBadge extends StatelessWidget {
  final IconData icon;
  final String title;

  const CategoryBadge({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [Icon(icon), Gap(10), Text(title)],
      ),
    );
  }
}
