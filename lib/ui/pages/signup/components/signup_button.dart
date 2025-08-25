import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../signup_presenter.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<SignUpPresenter>(context);
    return ButtonContainer(
      child: StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        initialData: false,
        builder: (context, formSnapshot) {
          return StreamBuilder<bool>(
            stream: presenter.isLoadingStream,
            initialData: false,
            builder: (context, loadingSnapshot) {
              final isLoading = loadingSnapshot.data ?? false;
              final isFormValid = formSnapshot.data ?? false;

              return Semantics(
                label: 'Botão de registro',
                hint: 'Toque para criar sua conta',
                button: true,
                child: ElevatedButton(
                  onPressed: (isFormValid && !isLoading)
                      ? () async => await presenter.signUp()
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (isFormValid && !isLoading)
                        ? AppColors.primary
                        : AppColors.dark40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 4,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.dark10),
                        )
                      : Text(
                          'Registrar',
                          style: TextStyle(
                            color: (isFormValid && !isLoading)
                                ? AppColors.dark10
                                : AppColors.dark80,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Manrope',
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
