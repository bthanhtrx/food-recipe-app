import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InfoBadge extends StatelessWidget {
  final String content;
  final String title;

  const InfoBadge({super.key, required this.content, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.red.shade200,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 60,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )),
          Gap(10),
          Text(
            title,
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
