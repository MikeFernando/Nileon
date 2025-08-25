import 'package:flutter/material.dart';
import '../themes/themes.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.error,
    this.topPadding = 8.0,
  });

  final String error;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
        error,
        style: const TextStyle(
          color: AppColors.error,
          fontSize: 12,
          fontFamily: 'Manrope',
        ),
      ),
    );
  }
}
