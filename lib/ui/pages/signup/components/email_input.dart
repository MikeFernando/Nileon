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
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _hasFocus = false;
  SignUpPresenter? _presenter;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });

      if (!_focusNode.hasFocus && _controller.text.isNotEmpty) {
        if (mounted && _presenter != null) {
          _presenter!.validateEmail(_controller.text);
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
                  hint: 'Digite seu endereço de email',
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: _presenter!.validateEmail,
                    onEditingComplete: () =>
                        _presenter!.validateEmail(_controller.text),
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
                            _hasFocus ? AppColors.dark100 : AppColors.dark80,
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
