import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'signup_presenter.dart';

import '../../themes/themes.dart';

import 'widgets/or_divider.dart';

class SignupPage extends StatefulWidget {
  final SignupPresenter presenter;
  const SignupPage({super.key, required this.presenter});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark30,
      body: Stack(
        fit: StackFit.expand,
        children: [
          backgroundImage(),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                signupHeader(context),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.dark10,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        top: 8,
                        bottom: 16,
                      ),
                      child: SingleChildScrollView(
                        child: Provider.value(
                          value: widget.presenter,
                          child: Form(
                            key: GlobalKey<FormState>(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const EmailInput(),
                                const PhoneInput(),
                                const PasswordInput(),
                                const MainErrorDisplay(),
                                const ButtonSignup(),
                                orDivider(),
                                const ButtonGoogle(),
                                const AlreadyHaveAccount(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
