import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF0A1D37);
const Color lightBackground = Color(0xFFF2F2F2);
const Color darkBackground = Color(0xFF000000);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: lightBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
    elevation: 2,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryBlue,
    foregroundColor: Colors.white,
  ),

  cardColor: Colors.white,

  colorScheme: const ColorScheme.light(
    primary: primaryBlue,
    secondary: Colors.blueGrey,
    background: lightBackground,
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
  ),
);



final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  scaffoldBackgroundColor: darkBackground,

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    foregroundColor: Colors.white,
    elevation: 0,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1F1F1F),
    foregroundColor: Colors.white,
  ),

  cardColor: const Color(0xFF1E1E1E),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1F1F1F),
    secondary: Colors.tealAccent,
    background: darkBackground,
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);
