import 'package:flutter/material.dart';

/// PayZen Design System Color Palette
class AppColors {
  // Brand Primary & Secondary
  static const Color midnightNavy = Color(0xFF061C2B); // Primary brand
  static const Color deepTeal = Color(0xFF003D46);     // Secondary brand
  static const Color electricMint = Color(0xFF19C6AE); // Signature accent
  static const Color warmIvory = Color(0xFFF7F5EF);    // Main background (light mode)
  static const Color pureWhite = Color(0xFFFFFFFF);    // Surface & cards
  static const Color slateBlue = Color(0xFF142D3C);    // Card background (dark mode)

  // Typography
  static const Color deepNavyText = Color(0xFF172B3A); // Primary text
  static const Color mutedSlate = Color(0xFF687986);   // Secondary text

  // Feedback Colors
  static const Color successGreen = Color(0xFF168568); // Successful payments
  static const Color errorCoral = Color(0xFFD95C52);   // Errors & warnings

  // Neutral Tints & Borders
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderSubtle = Color(0x1F172B3A);
  static const Color cardShadow = Color(0x0D061C2B);
  static const Color surfaceGrey = Color(0xFFF3F4F6);

  // Backward-compatibility aliases for legacy code
  static const Color primary = midnightNavy;
  static const Color primarydark = deepTeal;
  static const Color secondary = electricMint;
  static const Color background = warmIvory;
  static const Color whiteDim = Color(0xCCFFFFFF);
  static const Color blurWhite05 = Color.fromRGBO(255, 255, 255, 0.05);
  static const Color blurWhite10 = Color.fromRGBO(255, 255, 255, 0.10);

  static final List<Color> avatarColors = [
    const Color(0xFF003D46),
    const Color(0xFF168568),
    const Color(0xFF19C6AE),
    const Color(0xFF0A5C67),
    const Color(0xFF142D3C),
    const Color(0xFFD95C52),
    const Color(0xFF2563EB),
    const Color(0xFF7C3AED),
  ];
}
