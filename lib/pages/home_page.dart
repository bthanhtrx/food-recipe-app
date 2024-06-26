import 'package:flutter/material.dart';
import 'package:food_recipe_app/pages/home_screen.dart';
import 'package:food_recipe_app/pages/profile_screen.dart';
import 'package:food_recipe_app/pages/saved_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _screens = [HomeScreen(), SavedScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Profile'),
        ],
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
