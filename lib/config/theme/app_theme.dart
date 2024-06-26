import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black54,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.black87),

  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.greenAccent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.greenAccent),

  );
}