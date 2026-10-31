import 'package:flutter/material.dart';
import 'package:payzen_app/constant/colors.dart';

class AppGradients {
  static const LinearGradient splashBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primarydark, // Darker Red
      AppColors.primary, // Netflix Red
    ],
  );

  static const LinearGradient headingText = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,
      AppColors.secondary,
      Colors.indigo, // Soft pink-red
    ],
  );

  static const LinearGradient gradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, Color(0xFF182848)],
  );

  static LinearGradient gradient2 = LinearGradient(
    colors: [
      Colors.white,
      AppColors.secondary.withOpacity(0.1), // almost white with a pink hue
      // very soft pastel pink
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
  );

  static LinearGradient gradient3 = LinearGradient(
    colors: [
      Color(0xFF8C6E38), // Dark Gold
      Color(0xFFB48847), // Medium Gold
      Color(0xFFD4AF37), // Standard Gold
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient gradient4 = LinearGradient(
    colors: [
      Color(0xFFFFF1F2), // light pinkish white
      Color(0xFFFFE4E6), // soft peach pink
      Color(0xFFFECACA), // pastel red
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
