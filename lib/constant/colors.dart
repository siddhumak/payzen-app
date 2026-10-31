import 'package:flutter/material.dart';
// This file defines the colors and gradients used in the app.

class AppColors {
  static const Color primary = Color(0xFFB71C1C); // Netflix-style red

  static const Color primarydark = Color(0xFFD32F2F); // Deeper Red
  static const Color secondary = Color(0xFFFB7185); // Soft pink-red
  static const Color background = Color(0xFF0D0C1D); // Deep dark background
  static const Color whiteDim = Color(0xCCFFFFFF); // Semi-transparent white
  static const Color blurWhite05 = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color blurWhite10 = Color.fromRGBO(255, 255, 255, 0.10);

  static final List<Color> avatarColors = [
    Color(0xFFEF4444), // Red-500
    Color(0xFFF59E0B), // Amber-500
    Colors.green,
    Colors.lightGreen,
    Colors.amber,
    Colors.deepPurple,
    Colors.blueAccent,
    Color(0xFFF97316), // Orange-500
  ];
}
