import 'package:flutter/material.dart';
import '../themes/themes.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    super.key,
    required this.label,
    this.topPadding = 16.0,
  });

  final String label;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        label,
        style: AppTypography.bodyMediumWithColor(AppColors.dark100),
      ),
    );
  }
}
