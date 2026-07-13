import 'package:flutter/material.dart';

abstract final class AppColors {
  // Surfaces
  static const Color background = Color(0xFF0E0E11);
  static const Color surface = Color(0xFF17171B);
  static const Color surfaceElevated = Color(0xFF1F1F24);
  static const Color surfaceCard = Color(0xFF1C1C21);
  static const Color divider = Color(0xFF2A2A30);

  // Brand
  static const Color primary = Color(0xFF3D7BFF);
  static const Color primaryDark = Color(0xFF2557D6);
  static const Color primaryGradientStart = Color(0xFF3D7BFF);
  static const Color primaryGradientEnd = Color(0xFF6E42FF);

  // Text
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFA0A0AA);
  static const Color textTertiary = Color(0xFF6B6B75);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic
  static const Color success = Color(0xFF34C979);
  static const Color error = Color(0xFFFF5A5F);
  static const Color warning = Color(0xFFFFB020);

  // Chart
  static const Color chartLine = Color(0xFF3D7BFF);
  static const List<Color> chartFillGradient = [
    Color(0x553D7BFF),
    Color(0x003D7BFF),
  ];

  // Card brand accents (mastercard-style dots on "Your Card")
  static const Color cardAccentRed = Color(0xFFEA4335);
  static const Color cardAccentOrange = Color(0xFFF9A825);

  // Overlay / shimmer
  static const Color shimmerBase = Color(0xFF1C1C21);
  static const Color shimmerHighlight = Color(0xFF2B2B32);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGradientStart, primaryGradientEnd],
  );
}
