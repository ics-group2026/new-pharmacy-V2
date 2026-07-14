import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary green (logo, nav bar, buttons — matches website)
  static const Color primary = Color(0xFF43A047);
  static const Color primaryDark = Color(0xFF2E7D32);
  static const Color primaryLight = Color(0xFFA5D6A7);
  static const Color primaryContainer = Color(0xFFE8F5E9);

  // Secondary amber (discount badges, accent highlights)
  static const Color secondary = Color(0xFFFFC107);
  static const Color secondaryDark = Color(0xFFFF8F00);
  static const Color secondaryContainer = Color(0xFFFFF8E1);

  // Light theme surfaces
  static const Color scaffoldLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color dividerLight = Color(0xFFEEEEEE);

  // Dark theme surfaces
  static const Color scaffoldDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF252525);
  static const Color borderDark = Color(0xFF3A3A3A);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // Text — light mode
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textSecondaryLight = Color(0xFF555555);
  static const Color textHintLight = Color(0xFF9E9E9E);

  // Text — dark mode
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textHintDark = Color(0xFF757575);

  // Flash deals (urgency accent — reads against the green section band,
  // and stays distinct from the amber discount badges)
  static const Color flash = Color(0xFFE53935);
  static const Color flashDark = Color(0xFFB71C1C);

  // Semantic
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF00796B);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1565C0);

  // Legacy aliases (kept for backward compatibility)
  static const Color primaryColor = primary;
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
}
