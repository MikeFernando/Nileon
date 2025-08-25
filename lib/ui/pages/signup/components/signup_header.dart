import 'package:flutter/material.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

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
            'Crie sua conta',
            style: AppTypography.headlineMediumWithColor(AppColors.dark100),
          ),
          const SpacingH(),
          Text(
            'Serviços de agendamentos simples e inteligente.',
            style: AppTypography.bodyMediumWithColor(AppColors.dark80),
          ),
          const SpacingH(height: 24),
        ],
      ),
    );
  }
}

Widget signUpHeader(BuildContext context) => const SignUpHeader();
