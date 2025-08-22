import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../signup_presenter.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isObscureText = true;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _hasFocus = false;
  SignupPresenter? _presenter;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });

      // Valida quando o foco sai
      if (!_focusNode.hasFocus && _controller.text.isNotEmpty) {
        // Valida quando o foco sai
        if (mounted && _presenter != null) {
          _presenter!.validatePasswordOnFocusLost(_controller.text);
        }
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<SignupPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha',
          style: AppTypography.bodyLargeWithColor(AppColors.dark100),
        ),
        const SizedBox(height: 8),
        StreamBuilder<String?>(
          stream: _presenter!.passwordErrorStream,
          initialData: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: _presenter!.validatePassword,
                  onEditingComplete: () {
                    _presenter!.validatePasswordOnFocusLost(_controller.text);
                  },
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
                  style: const TextStyle(
                    color: AppColors.dark100,
                    fontFamily: 'Manrope',
                    fontSize: 14,
                  ),
                ),
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 12,
                        fontFamily: 'Manrope',
                      ),
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
