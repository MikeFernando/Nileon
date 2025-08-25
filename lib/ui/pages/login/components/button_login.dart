import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../login_presenter.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return SizedBox(
      width: double.infinity,
      child: StreamBuilder<bool>(
        stream: presenter.isFormValidStream,
        builder: (context, formSnapshot) {
          return StreamBuilder<bool>(
            stream: presenter.isLoadingStream,
            builder: (context, loadingSnapshot) {
              final isLoading = loadingSnapshot.data ?? false;
              final isFormValid = formSnapshot.data ?? false;

              return Semantics(
                label: 'Botão de login',
                hint: 'Toque para fazer login na sua conta',
                button: true,
                child: ElevatedButton(
                  onPressed:
                      (isFormValid && !isLoading) ? presenter.auth : null,
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
                          'Entrar',
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
