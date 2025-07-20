import 'package:flutter/material.dart';

import '../components/components.dart';
import '../pages/pages.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;
  const LoginPage({super.key, required this.presenter});

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
                      stream: presenter.emailErrorStream,
                      builder: (context, snapshot) {
                        return TextFormField(
                          onChanged: presenter.validateEmail,
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
                    child: TextFormField(
                      onChanged: presenter.validatePassword,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        prefixIconColor: Theme.of(context).colorScheme.primary,
                        prefixIcon: Icon(Icons.lock),
                        labelText: 'Senha',
                      ),
                    ),
                  ),
                  Button(
                    onPressed: () {},
                    label: 'Entrar',
                    enabled: false,
                  ),
                  CustomTextButton(
                    onPressed: () {},
                    icon: Icons.person_add,
                    label: 'Criar conta',
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
