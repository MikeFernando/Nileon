import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../signup_presenter.dart';

import '../../../themes/themes.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
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
          _presenter!.validateNameOnFocusLost(_controller.text);
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
        const SizedBox(height: 18),
        Text(
          'Nome',
          style: AppTypography.bodyMediumWithColor(AppColors.dark100),
        ),
        const SizedBox(height: 8),
        StreamBuilder<String?>(
          stream: _presenter!.nameErrorStream,
          initialData: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Campo de nome',
                  hint: 'Digite seu nome completo',
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: _presenter!.validateName,
                    onEditingComplete: () =>
                        _presenter!.validateNameOnFocusLost(_controller.text),
                    autofillHints: const [AutofillHints.name],
                    decoration: InputDecoration(
                      hintText: 'Digite seu nome',
                      hintStyle: TextStyle(
                        color: AppColors.dark80,
                        fontFamily: 'Manrope',
                        fontSize: 14,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'lib/ui/assets/svg/user.svg',
                          width: 18,
                          height: 18,
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
                    style: const TextStyle(
                      color: AppColors.dark100,
                      fontFamily: 'Manrope',
                      fontSize: 14,
                    ),
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
      ],
    );
  }
}
