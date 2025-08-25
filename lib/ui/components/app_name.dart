import 'package:flutter/material.dart';
import '../themes/themes.dart';

class AppName extends StatelessWidget {
  const AppName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nileon',
      style: AppTypography.titleLargeWithColor(AppColors.dark100),
    );
  }
}
