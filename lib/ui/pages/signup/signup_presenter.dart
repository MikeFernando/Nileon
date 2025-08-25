import 'dart:async';

abstract class SignUpPresenter {
  // Streams de erro para cada campo
  Stream<String?> get nameErrorStream;
  Stream<String?> get emailErrorStream;
  Stream<String?> get phoneErrorStream;
  Stream<String?> get passwordErrorStream;

  // Stream para texto da senha (para regras em tempo real)
  Stream<String> get passwordTextStream;

  // Streams de estado
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get mainErrorStream;

  // Streams de navegação
  Stream<String?> get navigateToStream;
  Stream<String?> get navigateToLoginStream;
  Stream<String?> get navigateToGoogleAddAccountStream;

  // Métodos de validação em tempo real
  void validateName(String name);
  void validateEmail(String email);
  void validatePhone(String phone);
  void validatePassword(String password);



  // Métodos de controle
  void isLoading(bool isLoading);
  Future<void> signUp();

  // Métodos de navegação
  void navigateToLogin();
  void navigateToGoogleAddAccount();

  // Limpeza de recursos
  void dispose();
}
