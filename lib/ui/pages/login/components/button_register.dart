import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/themes.dart';

class ButtonRegister extends StatelessWidget {
  final VoidCallback? onTap;

  const ButtonRegister({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Center(
          child: GestureDetector(
            onTap: onTap ?? () => Get.toNamed('/signup'),
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
                    text: ' Registrar',
                    style: TextStyle(
                      color: AppColors.dark100,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
