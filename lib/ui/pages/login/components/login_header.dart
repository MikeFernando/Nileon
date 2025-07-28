import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

Widget loginHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'lib/ui/assets/logo.png',
              width: 21,
              height: 21,
            ),
            const SizedBox(width: 8),
            Text(
              'Nileon',
              style: AppTypography.titleLargeWithColor(AppColors.dark100),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Bem vindo de volta',
          style: AppTypography.headlineMediumWithColor(AppColors.dark100),
        ),
        const SizedBox(height: 8),
        Text(
          'Entre na sua conta para explorar nosso aplicativo',
          style: AppTypography.bodyMediumWithColor(AppColors.dark80),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
