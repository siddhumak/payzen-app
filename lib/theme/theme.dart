import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payzen_app/constant/colors.dart';

final ThemeData neoPayTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.warmIvory,
  fontFamily: GoogleFonts.inter().fontFamily,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.midnightNavy,
    onPrimary: AppColors.pureWhite,
    secondary: AppColors.deepTeal,
    onSecondary: AppColors.pureWhite,
    tertiary: AppColors.electricMint,
    onTertiary: AppColors.midnightNavy,
    error: AppColors.errorCoral,
    onError: AppColors.pureWhite,
    surface: AppColors.pureWhite,
    onSurface: AppColors.deepNavyText,
  ),
  textTheme: GoogleFonts.interTextTheme().copyWith(
    headlineLarge: const TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
    ),
    headlineMedium: const TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
    ),
    titleLarge: const TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: const TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: const TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: const TextStyle(
      color: AppColors.mutedSlate,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: const TextStyle(
      color: AppColors.pureWhite,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  ),
  cardTheme: CardTheme(
    color: AppColors.pureWhite,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderLight, width: 1),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.warmIvory,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(color: AppColors.deepNavyText),
    titleTextStyle: TextStyle(
      color: AppColors.deepNavyText,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.pureWhite,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.borderLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.deepTeal, width: 1.5),
    ),
    hintStyle: const TextStyle(color: AppColors.mutedSlate, fontSize: 14),
  ),
);
