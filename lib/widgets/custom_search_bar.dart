import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/search_screen.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "What ingredient you have today?",
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                if(value.trim().isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(value.trim()),));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}