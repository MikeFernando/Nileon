import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../themes/themes.dart';
import '../../../components/components.dart';
import '../signup_presenter.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});

  @override
  State<NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  SignUpPresenter? _presenter;

  @override
  Widget build(BuildContext context) {
    _presenter = Provider.of<SignUpPresenter>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel(label: 'Nome', topPadding: 8),
        const SpacingH(),
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
                    controller: _presenter!.nameController,
                    focusNode: _presenter!.nameFocusNode,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                      if (_presenter!.nameController.text.isNotEmpty) {
                        _presenter!
                            .validateName(_presenter!.nameController.text);
                      }
                    },
                    onEditingComplete: () => _presenter!
                        .validateName(_presenter!.nameController.text),
                    autofillHints: const [AutofillHints.name],
                    decoration: InputDecoration(
                      hintText: 'Digite seu nome',
                      hintStyle: InputDecorationHelper.hintTextStyle,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'lib/ui/assets/svg/user.svg',
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            _presenter!.nameFocusNode.hasFocus
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
                if (snapshot.data != null && snapshot.data!.isNotEmpty)
                  ErrorDisplay(error: snapshot.data!),
              ],
            );
          },
        ),
      ],
    );
  }
}
