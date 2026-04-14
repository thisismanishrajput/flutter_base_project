import 'package:flutter/material.dart';

/// Semantic color tokens shared across light and dark themes.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF3B5BDB);
  static const Color primaryDark = Color(0xFF5C7CFA);
  static const Color secondary = Color(0xFF0CA678);
  static const Color danger = Color(0xFFD6336C);
  static const Color warning = Color(0xFFF08C00);
  static const Color success = Color(0xFF2B8A3E);

  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color darkBackground = Color(0xFF121212);
  static const Color lightSurface = Colors.white;
  static const Color darkSurface = Color(0xFF1E1E1E);

  static const Color lightTextPrimary = Color(0xFF1F2937);
  static const Color darkTextPrimary = Color(0xFFF3F4F6);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
}
