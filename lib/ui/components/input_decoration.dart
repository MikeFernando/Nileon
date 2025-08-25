import 'package:flutter/material.dart';
import '../themes/themes.dart';

class InputDecorationHelper {
  static const InputDecoration baseDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.dark30,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: 1.0,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 0,
    ),
  );

  static const TextStyle baseTextStyle = TextStyle(
    color: AppColors.dark100,
    fontFamily: 'Manrope',
    fontSize: 14,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: AppColors.dark80,
    fontFamily: 'Manrope',
    fontSize: 14,
  );
}
