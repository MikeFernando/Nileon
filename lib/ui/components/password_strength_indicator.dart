import 'package:flutter/material.dart';
import 'package:nileon/validation/validators/password_validation.dart';
import 'package:nileon/ui/themes/themes.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;
  final PasswordValidation validation;

  const PasswordStrengthIndicator({
    super.key,
    required this.password,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final strength = validation.getPasswordStrength(password);
    final strengthMessage = validation.getStrengthMessage(strength);
    final strengthColor = Color(validation.getStrengthColor(strength));
    final strengthPercentage = validation.getStrengthPercentage(strength);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barra de progresso
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.dark40,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: strengthPercentage,
              child: Container(
                decoration: BoxDecoration(
                  color: strengthColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          // Mensagem de força
          Text(
            strengthMessage,
            style: AppTypography.bodySmallWithColor(strengthColor),
          ),
        ],
      ),
    );
  }
}
