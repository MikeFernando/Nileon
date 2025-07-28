import 'package:flutter/material.dart';

import 'colors.dart';
import 'themes.dart';

class AppTypography {
  static const String fontFamily = 'Manrope';

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
        height: 1.5,
        fontFamily: fontFamily), // Heading 1
    displayMedium: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        height: 1.5,
        fontFamily: fontFamily), // Heading 2
    displaySmall: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w600,
        height: 1.5,
        fontFamily: fontFamily), // Heading 3
    headlineMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.5,
        fontFamily: fontFamily), // Heading 4
    headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.5,
        fontFamily: fontFamily), // Heading 5
    titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.5,
        fontFamily: fontFamily), // Heading 6

    bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.5,
        fontFamily: fontFamily), // Body Large
    bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        color: AppColors.dark100,
        fontFamily: fontFamily), // Body Medium
    bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.5,
        fontFamily: fontFamily), // Body Small
    labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        fontFamily: fontFamily), // Extra Small
  );

  // Métodos para aplicar cores aos textos
  static TextStyle displayLargeWithColor(Color color) {
    return textTheme.displayLarge!.copyWith(color: color);
  }

  static TextStyle displayMediumWithColor(Color color) {
    return textTheme.displayMedium!.copyWith(color: color);
  }

  static TextStyle displaySmallWithColor(Color color) {
    return textTheme.displaySmall!.copyWith(color: color);
  }

  static TextStyle headlineMediumWithColor(Color color) {
    return textTheme.headlineMedium!.copyWith(color: color);
  }

  static TextStyle headlineSmallWithColor(Color color) {
    return textTheme.headlineSmall!.copyWith(color: color);
  }

  static TextStyle titleLargeWithColor(Color color) {
    return textTheme.titleLarge!.copyWith(color: color);
  }

  static TextStyle bodyLargeWithColor(Color color) {
    return textTheme.bodyLarge!.copyWith(color: color);
  }

  static TextStyle bodyMediumWithColor(Color color) {
    return textTheme.bodyMedium!.copyWith(color: color);
  }

  static TextStyle bodySmallWithColor(Color color) {
    return textTheme.bodySmall!.copyWith(color: color);
  }

  static TextStyle labelSmallWithColor(Color color) {
    return textTheme.labelSmall!.copyWith(color: color);
  }

  // Método genérico para aplicar cor a qualquer estilo
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
}
