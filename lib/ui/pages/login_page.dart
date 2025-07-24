import 'dart:async';
import 'package:flutter/material.dart';

import '../components/components.dart';
import '../pages/pages.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;
  const LoginPage({super.key, required this.presenter});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  StreamSubscription? _loadingSubscription;

  @override
  void initState() {
    super.initState();
    _loadingSubscription = widget.presenter.isLoadingStream.listen((isLoading) {
      if (mounted) {
        if (isLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Aguarde...', textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        } else {
          Navigator.of(context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    _loadingSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              LoginHeader(),
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: StreamBuilder<String?>(
                        stream: widget.presenter.emailErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            onChanged: widget.presenter.validateEmail,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIconColor:
                                  Theme.of(context).colorScheme.primary,
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email',
                              errorText: snapshot.data?.isEmpty != false
                                  ? null
                                  : snapshot.data,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: StreamBuilder<String?>(
                        stream: widget.presenter.passwordErrorStream,
                        builder: (context, snapshot) {
                          return TextFormField(
                            onChanged: widget.presenter.validatePassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              prefixIconColor:
                                  Theme.of(context).colorScheme.primary,
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Senha',
                              errorText: snapshot.data?.isEmpty != false
                                  ? null
                                  : snapshot.data,
                            ),
                          );
                        },
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: widget.presenter.isFormValidStream,
                      builder: (context, snapshot) {
                        return Button(
                          onPressed: () => widget.presenter.auth(),
                          label: 'Entrar',
                          enabled: snapshot.data ?? false,
                        );
                      },
                    ),
                    CustomTextButton(
                      onPressed: () {},
                      icon: Icons.person_add,
                      label: 'Criar conta',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
