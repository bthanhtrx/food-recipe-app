import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/search_result_screen.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function? onChanged;

  CustomSearchBar({super.key, required this.hintText, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
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
            child: TextField(style: TextStyle(fontSize: 14, color:Colors.black87),
              controller: controller,
              onChanged: (value) => onChanged!(controller.text.trim()),
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                suffixIcon: IconButton(onPressed: (){
                  onChanged!('');
                  controller.clear();
                }, icon: Icon(Icons.cancel_outlined),)
              ),
              onSubmitted: (value) {
                if(value.trim().isNotEmpty) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultScreen(value.trim()),));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}