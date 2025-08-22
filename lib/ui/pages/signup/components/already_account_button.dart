import 'package:flutter/material.dart';

import '../../../themes/themes.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Não possui uma conta? ',
              style: TextStyle(
                color: AppColors.dark80,
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: ' Login',
                  style: TextStyle(
                    color: AppColors.dark100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
