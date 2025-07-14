import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color.fromARGB(255, 244, 248, 6);
    final primaryColorDark = Color.fromARGB(255, 161, 175, 14);
    final primaryColorLight = Color.fromARGB(255, 230, 238, 153);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: primaryColorDark,
          surface: primaryColorLight,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        buttonTheme: ButtonThemeData(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          splashColor: primaryColorDark,
          highlightColor: primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Nileon',
      home: const LoginPage(),
    );
  }
}
