import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/login/login_page.dart';
import '../pages/login/login_presenter.dart';

import '../themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nileon',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginPage(presenter: LoginPresenterImpl()),
    );
  }
}
