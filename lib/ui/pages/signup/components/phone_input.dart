import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../signup_presenter.dart';

class PhoneInput extends StatefulWidget {
  const PhoneInput({super.key});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
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
          _presenter!.validatePhoneOnFocusLost(_controller.text);
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

  String _formatPhoneNumber(String text) {
    // Remove todos os caracteres não numéricos
    final cleanText = text.replaceAll(RegExp(r'[^\d]'), '');

    if (cleanText.isEmpty) return '';

    // Formata o telefone brasileiro no padrão (00) 00000-0000
    if (cleanText.length <= 2) {
      return cleanText;
    } else if (cleanText.length <= 6) {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2)}';
    } else if (cleanText.length <= 10) {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2, 6)}-${cleanText.substring(6)}';
    } else {
      return '(${cleanText.substring(0, 2)}) ${cleanText.substring(2, 7)}-${cleanText.substring(7)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<SignUpPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel(label: 'Telefone', topPadding: 0),
        const SpacingH(),
        StreamBuilder<String?>(
          stream: _presenter!.phoneErrorStream,
          initialData: null,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.dark30,
                    borderRadius: BorderRadius.circular(32),
                    border: snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.isNotEmpty
                        ? Border.all(
                            color: AppColors.error,
                            width: 1.0,
                          )
                        : _hasFocus
                            ? Border.all(
                                color: AppColors.primary,
                                width: 1.0,
                              )
                            : null,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: const Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Text(
                                      '🇧🇷',
                                      style: TextStyle(
                                        fontSize: 18,
                                        height: 1.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SpacingW(),
                              Text(
                                '+55',
                                style: TextStyle(
                                  color: AppColors.dark80,
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          color: AppColors.dark50,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _controller,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: (value) {
                              final formattedValue = _formatPhoneNumber(value);
                              if (formattedValue != value) {
                                _controller.value = TextEditingValue(
                                  text: formattedValue,
                                  selection: TextSelection.collapsed(
                                    offset: formattedValue.length,
                                  ),
                                );
                              }
                              _presenter!.validatePhone(formattedValue);
                            },
                            onEditingComplete: () {
                              _presenter!
                                  .validatePhoneOnFocusLost(_controller.text);
                            },
                            autofillHints: const [
                              AutofillHints.telephoneNumber
                            ],
                            decoration: const InputDecoration(
                              hintText: '(00) 00000-0000',
                              hintStyle: InputDecorationHelper.hintTextStyle,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                            style: InputDecorationHelper.baseTextStyle,
                          ),
                        ),
                      ],
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
        const SpacingH(height: 18),
      ],
    );
  }
}
