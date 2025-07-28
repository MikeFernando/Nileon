import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../login_presenter.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscureText = true;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: AppTypography.bodyLargeWithColor(AppColors.dark100),
        ),
        const SizedBox(height: 8),
        StreamBuilder<String?>(
          stream: presenter.passwordErrorStream,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: presenter.validatePassword,
                  obscureText: isObscureText,
                  decoration: InputDecoration(
                    hintText: 'Digite sua senha',
                    hintStyle: TextStyle(
                      color: AppColors.dark80,
                      fontFamily: 'Manrope',
                      fontSize: 14,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'lib/ui/assets/svg/key.svg',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          _hasFocus ? AppColors.dark100 : AppColors.dark80,
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
                          _hasFocus ? AppColors.dark100 : AppColors.dark80,
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
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.0,
                      ),
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
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 61),
      ],
    );
  }
}
