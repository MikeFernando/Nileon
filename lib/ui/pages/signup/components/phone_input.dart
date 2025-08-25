import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../../../utils/utils.dart';
import '../signup_presenter.dart';

class PhoneInput extends StatefulWidget {
  const PhoneInput({super.key});

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  SignUpPresenter? _presenter;

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
                Semantics(
                  label: 'Campo de telefone',
                  hint: 'Digite seu número de telefone',
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      // Valida quando o campo ganha foco e tem conteúdo
                      if (hasFocus &&
                          _presenter!.phoneController.text.isNotEmpty) {
                        _presenter!
                            .validatePhone(_presenter!.phoneController.text);
                      }
                      // Valida quando o campo perde foco (para manter erro se inválido)
                      if (!hasFocus &&
                          _presenter!.phoneController.text.isNotEmpty) {
                        _presenter!
                            .validatePhone(_presenter!.phoneController.text);
                      }
                    },
                    child: TextFormField(
                      controller: _presenter!.phoneController,
                      focusNode: _presenter!.phoneFocusNode,
                      keyboardType: TextInputType.phone,
                      onTapOutside: (event) {
                        // Fecha o teclado
                        FocusScope.of(context).unfocus();
                        // Valida quando clica fora do campo
                        if (_presenter!.phoneController.text.isNotEmpty) {
                          _presenter!
                              .validatePhone(_presenter!.phoneController.text);
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      onChanged: (value) {
                        final formattedValue = PhoneFormatter.format(value);
                        if (formattedValue != value) {
                          _presenter!.phoneController.value = TextEditingValue(
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
                            .validatePhone(_presenter!.phoneController.text);
                      },
                      autofillHints: const [AutofillHints.telephoneNumber],
                      decoration: InputDecoration(
                        hintText: '(00) 00000-0000',
                        hintStyle: InputDecorationHelper.hintTextStyle,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                  color: AppColors.dark60,
                                  fontFamily: 'Manrope',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: AppColors.dark50,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ],
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
                if (snapshot.data != null && snapshot.data!.isNotEmpty)
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
