import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/components.dart';
import 'signup_presenter.dart';

import '../../themes/themes.dart';

import 'widgets/or_divider.dart';

class SignUpPage extends StatefulWidget {
  final SignUpPresenter presenter;
  const SignUpPage({super.key, required this.presenter});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    _setupNavigationListeners();
  }

  void _setupNavigationListeners() {
    widget.presenter.navigateToStream.listen((route) {
      if (route != null && mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    });

    widget.presenter.navigateToLoginStream.listen((route) {
      if (route != null && mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    });

    widget.presenter.navigateToGoogleAddAccountStream.listen((route) {
      if (route != null && mounted) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    });
  }

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
                signUpHeader(context),
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
                                const NameInput(),
                                const EmailInput(),
                                const PhoneInput(),
                                const PasswordInput(),
                                const MainErrorDisplay(),
                                const SignUpButton(),
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
