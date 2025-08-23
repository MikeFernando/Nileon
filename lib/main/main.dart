import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/themes/app_theme.dart';

import 'factories/factories.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nileon',
      theme: AppTheme.makeAppTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: makeLoginPage),
        GetPage(name: '/add_account', page: makeAddAccountPage),
        GetPage(name: '/google-add-account', page: makeAddAccountPage),
        GetPage(name: '/home', page: makeHomePage),
      ],
    );
  }
}
