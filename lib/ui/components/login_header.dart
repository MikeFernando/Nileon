import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 100),
          height: 200,
          child: Image.asset('lib/ui/assets/logo.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Text(
            'Login'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
