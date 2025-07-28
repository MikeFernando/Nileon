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
        builder: (context, snapshot) {
          return ElevatedButton(
            onPressed: snapshot.data == true ? presenter.auth : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  snapshot.data == true ? AppColors.primary : AppColors.dark40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 4,
            ),
            child: Text(
              'Entrar',
              style: TextStyle(
                color:
                    snapshot.data == true ? AppColors.dark10 : AppColors.dark80,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Manrope',
              ),
            ),
          );
        },
      ),
    );
  }
}
