import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../login_presenter.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Email',
          style: AppTypography.bodyLargeWithColor(AppColors.dark100),
        ),
        const SizedBox(height: 8),
        StreamBuilder<String?>(
          stream: presenter.emailErrorStream,
          builder: (context, snapshot) {
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: presenter.validateEmail,
              decoration: InputDecoration(
                hintText: 'Digite seu email',
                hintStyle: TextStyle(
                  color: AppColors.dark80,
                  fontFamily: 'Manrope',
                  fontSize: 14,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'lib/ui/assets/svg/email.svg',
                    width: 20,
                    height: 20,
                  ),
                ),
                filled: true,
                fillColor: AppColors.dark30,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
              ),
              style: const TextStyle(
                color: AppColors.dark100,
                fontFamily: 'Manrope',
                fontSize: 14,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
