import 'package:flutter/material.dart';

/// Typography builder for theme-specific text styles.
class AppTextStyles {
  const AppTextStyles._();

  /// Creates a text theme mapped to the provided color scheme.
  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: colorScheme.onSurfaceVariant,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: colorScheme.onPrimary,
      ),
    );
  }
}

/// Convenience text-style getters accessible via [BuildContext].
extension AppTypography on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;

  TextStyle get h1 => _textTheme.displayLarge!;
  TextStyle get h2 => _textTheme.displayMedium!;
  TextStyle get h3 => _textTheme.displaySmall!;
  TextStyle get h4 => _textTheme.headlineMedium!;
  TextStyle get h5 => _textTheme.headlineSmall!;
  TextStyle get h6 => _textTheme.titleLarge!;

  TextStyle get bodyLg => _textTheme.bodyLarge!;
  TextStyle get bodyMd => _textTheme.bodyMedium!;
  TextStyle get bodySm => _textTheme.bodySmall!;
  TextStyle get buttonText => _textTheme.labelLarge!;
}
