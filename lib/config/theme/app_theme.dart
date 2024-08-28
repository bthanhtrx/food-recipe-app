import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black54,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.black87),
    textTheme: TextTheme(
      titleSmall: TextStyle(fontSize: 14, color: Colors.white70,),
      titleMedium: TextStyle(color: Colors.white70,fontSize: 16),
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.greenAccent,
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.greenAccent),
    textTheme: TextTheme(
      titleSmall: TextStyle(fontSize: 14, color: Colors.black87,),
      titleMedium: TextStyle(color: Colors.black87,fontSize: 16),
      titleLarge: TextStyle(
        fontSize: 22,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
