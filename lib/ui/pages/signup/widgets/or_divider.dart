import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

Column orDivider() {
  return Column(
    children: [
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.dark50,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Ou',
              style: TextStyle(
                color: AppColors.dark70,
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.dark50,
              thickness: 1,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
    ],
  );
}
