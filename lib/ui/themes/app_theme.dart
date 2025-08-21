import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.info,
      error: AppColors.error,
      surface: AppColors.dark20,
    ),
    textTheme: AppTypography.textTheme,
    scaffoldBackgroundColor: AppColors.dark10,
  );

  static ThemeData makeAppTheme() {
    return darkTheme;
  }
}
