import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              text: 'Já possui uma conta? ',
              style: TextStyle(
                color: AppColors.dark80,
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              children: [
                WidgetSpan(
                  child: Semantics(
                    label: 'Link para login',
                    hint: 'Toque para ir para a tela de login',
                    button: true,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      child: Text(
                        ' Login',
                        style: TextStyle(
                          color: AppColors.dark100,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Manrope',
                          fontSize: 14,
                        ),
                      ),
                    ),
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
