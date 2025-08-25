import 'package:flutter/material.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Logo(),
              const SpacingW(),
              const AppName(),
            ],
          ),
          const SpacingH(height: 24),
          Text(
            'Bem vindo de volta',
            style: AppTypography.headlineMediumWithColor(AppColors.dark100),
          ),
          const SpacingH(),
          Text(
            'Entre na sua conta para explorar nosso aplicativo',
            style: AppTypography.bodyMediumWithColor(AppColors.dark80),
          ),
          const SpacingH(height: 24),
        ],
      ),
    );
  }
}

Widget loginHeader(BuildContext context) => const LoginHeader();
