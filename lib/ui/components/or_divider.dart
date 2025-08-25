import 'package:flutter/material.dart';
import '../themes/themes.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.dark40,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'ou',
            style: AppTypography.bodyMediumWithColor(AppColors.dark60),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.dark40,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
