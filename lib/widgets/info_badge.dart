import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InfoBadge extends StatelessWidget {
  final String content;
  final String title;

  const InfoBadge({super.key, required this.content, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              child: Text(content)),
          Gap(10),
          Text(
            title,
            softWrap: true,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
