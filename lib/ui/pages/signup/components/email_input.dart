import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../signup_presenter.dart';

class EmailInput extends StatefulWidget {
  const EmailInput({super.key});

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  SignUpPresenter? _presenter;

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<SignUpPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel(label: 'Email'),
        const SpacingH(),
        StreamBuilder<String?>(
          stream: _presenter!.emailErrorStream,
          initialData: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Campo de email',
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus &&
                          _presenter!.emailController.text.isNotEmpty) {
                        _presenter!
                            .validateEmail(_presenter!.emailController.text);
                      }
                      if (!hasFocus &&
                          _presenter!.emailController.text.isNotEmpty) {
                        _presenter!
                            .validateEmail(_presenter!.emailController.text);
                        _presenter!.showEmailError();
                      }
                    },
                    child: TextFormField(
                      controller: _presenter!.emailController,
                      focusNode: _presenter!.emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                        if (_presenter!.emailController.text.isNotEmpty) {
                          _presenter!
                              .validateEmail(_presenter!.emailController.text);
                          _presenter!.showEmailError();
                        }
                      },
                      autofillHints: const [AutofillHints.email],
                      decoration: InputDecoration(
                        hintText: 'Digite seu email',
                        hintStyle: InputDecorationHelper.hintTextStyle,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            'lib/ui/assets/svg/email.svg',
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              _presenter!.emailFocusNode.hasFocus
                                  ? AppColors.dark100
                                  : AppColors.dark80,
                              BlendMode.srcIn,
                            ),
                          ),
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
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty)
                  ErrorDisplay(error: snapshot.data!),
              ],
            );
          },
        ),
        const SpacingH(height: 16),
      ],
    );
  }
}
