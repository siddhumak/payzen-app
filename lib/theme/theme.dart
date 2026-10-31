import 'package:flutter/material.dart';

final ThemeData neoPayTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0D0C1D), // dark base
  fontFamily: 'Inter', // use any modern font if available
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFE50914), // Netflix red
    brightness: Brightness.dark,
    primary: const Color(0xFFE50914),
    secondary: const Color(0xFFFB7185), // vibrant pink-red
    background: const Color(0xFF0D0C1D),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(color: Colors.white70),
    labelLarge: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
);
