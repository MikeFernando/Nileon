import 'dart:async';
import 'package:flutter/material.dart';

abstract class LoginPresenter {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get mainErrorStream;

  // Streams para controlar a exibição dos erros
  Stream<bool> get emailErrorDisplayStream;
  Stream<bool> get passwordErrorDisplayStream;

  // Controllers para os campos de texto (para persistir estado)
  TextEditingController get emailController;
  TextEditingController get passwordController;

  // FocusNodes para os campos
  FocusNode get emailFocusNode;
  FocusNode get passwordFocusNode;

  void validateEmail(String email);
  void validatePassword(String password);
  void isLoading(bool isLoading);
  Future<void> auth();

  // Métodos para forçar a exibição dos erros
  void showEmailError();
  void showPasswordError();

  // Métodos para forçar atualização dos streams (útil quando widget é reconstruído)
  void refreshEmailErrorDisplay();
  void refreshPasswordErrorDisplay();

  void dispose();
}
