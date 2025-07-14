import 'package:flutter/material.dart';

import '../components/components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIconColor: Theme.of(context).colorScheme.primary,
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextFormField(
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
