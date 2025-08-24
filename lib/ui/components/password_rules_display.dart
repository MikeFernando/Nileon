import 'package:flutter/material.dart';
import 'package:nileon/validation/validators/password_validation.dart';
import 'package:nileon/ui/themes/themes.dart';

class PasswordRulesDisplay extends StatelessWidget {
  final String password;
  final PasswordValidation validation;

  const PasswordRulesDisplay({
    super.key,
    required this.password,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) {
      return const SizedBox.shrink();
    }

    final rulesStatus = validation.getPasswordRulesStatus(password);
    final rulesMessages = validation.getPasswordRulesMessages();

    final allRulesCompleted =
        rulesStatus.values.every((isCompleted) => isCompleted);

    if (allRulesCompleted) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.dark20,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.dark40,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requisitos da senha:',
            style: AppTypography.bodyMediumWithColor(AppColors.dark80),
          ),
          const SizedBox(height: 8),
          ...rulesMessages.entries.map((entry) {
            final isCompleted = rulesStatus[entry.key] ?? false;
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                entry.value,
                style: AppTypography.bodySmallWithColor(
                  isCompleted ? AppColors.success : AppColors.error,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
