import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../pages/login/login_presenter.dart';

import '../themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      title: 'Nileon',
      home: LoginPage(presenter: LoginPresenterImpl()),
    );
  }
}
