import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../signup_presenter.dart';
import '../../../../validation/validators/password_validation.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final PasswordValidation _passwordValidation = PasswordValidation('password');
  SignUpPresenter? _presenter;
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<SignUpPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel(label: 'Senha', topPadding: 0),
        const SpacingH(),
        StreamBuilder<String?>(
          stream: _presenter!.passwordErrorStream,
          initialData: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Campo de senha',
                  hint: 'Digite sua senha',
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus &&
                          _presenter!.passwordController.text.isNotEmpty) {
                        _presenter!.validatePassword(
                            _presenter!.passwordController.text);
                      }
                      if (!hasFocus &&
                          _presenter!.passwordController.text.isNotEmpty) {
                        _presenter!.validatePassword(
                            _presenter!.passwordController.text);
                      }
                    },
                    child: TextFormField(
                      controller: _presenter!.passwordController,
                      focusNode: _presenter!.passwordFocusNode,
                      keyboardType: TextInputType.visiblePassword,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                        if (_presenter!.passwordController.text.isNotEmpty) {
                          _presenter!.validatePassword(
                              _presenter!.passwordController.text);
                        }
                      },
                      onChanged: (value) {
                        (value);
                        setState(() {});
                      },
                      onEditingComplete: () {
                        _presenter!.validatePassword(
                            _presenter!.passwordController.text);
                      },
                      obscureText: isObscureText,
                      autofillHints: const [AutofillHints.newPassword],
                      decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        hintStyle: InputDecorationHelper.hintTextStyle,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            'lib/ui/assets/svg/key.svg',
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              _presenter!.passwordFocusNode.hasFocus
                                  ? AppColors.dark100
                                  : AppColors.dark80,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            isObscureText
                                ? 'lib/ui/assets/svg/eye-slash.svg'
                                : 'lib/ui/assets/svg/eye.svg',
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              _presenter!.passwordFocusNode.hasFocus
                                  ? AppColors.dark100
                                  : AppColors.dark80,
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: AppColors.dark30,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: snapshot.hasData &&
                                  snapshot.data != null &&
                                  snapshot.data!.isNotEmpty
                              ? const BorderSide(
                                  color: AppColors.error,
                                  width: 1.0,
                                )
                              : BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            color: snapshot.hasData &&
                                    snapshot.data != null &&
                                    snapshot.data!.isNotEmpty
                                ? AppColors.error
                                : AppColors.primary,
                            width: 1.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                      ),
                      style: InputDecorationHelper.baseTextStyle,
                    ),
                  ),
                ),
                PasswordStrengthIndicator(
                  password: _presenter!.passwordController.text,
                  validation: _passwordValidation,
                ),
                if (snapshot.data != null && snapshot.data!.isNotEmpty)
                  ErrorDisplay(error: snapshot.data!),
              ],
            );
          },
        ),
        const SpacingH(height: 48.0),
      ],
    );
  }
}
