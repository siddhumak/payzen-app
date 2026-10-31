import 'package:flutter/material.dart';
import 'package:payzen_app/constant/colors.dart';

/// PayZen Design System Gradients
class AppGradients {
  // Splash background: #061C2B -> #003D46
  static const LinearGradient splashBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.midnightNavy, // #061C2B
      AppColors.deepTeal,     // #003D46
    ],
  );

  // Primary CTA: #003D46 -> #087E78
  static const LinearGradient primaryCTA = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF003D46),
      Color(0xFF087E78),
    ],
  );

  // Premium promotional card: #061C2B -> #087E78
  static const LinearGradient premiumCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF061C2B),
      Color(0xFF087E78),
    ],
  );

  // Logo accent: #19C6AE -> #078F91
  static const LinearGradient logoAccent = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF19C6AE),
      Color(0xFF078F91),
    ],
  );

  // Rewards highlight: #E6FBF5 -> #C8F2E7
  static const LinearGradient rewardsHighlight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE6FBF5),
      Color(0xFFC8F2E7),
    ],
  );

  // Success illustration: #003D46 -> #168568
  static const LinearGradient successIllustration = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF003D46),
      Color(0xFF168568),
    ],
  );

  // Legacy compatibility aliases
  static const LinearGradient headingText = logoAccent;
  static const LinearGradient gradient1 = primaryCTA;
  static const LinearGradient gradient2 = rewardsHighlight;
  static const LinearGradient gradient3 = premiumCard;
  static const LinearGradient gradient4 = primaryCTA;
}
