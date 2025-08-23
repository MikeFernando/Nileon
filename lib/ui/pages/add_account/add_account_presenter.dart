import 'dart:async';

abstract class AddAccountPresenter {
  // Streams de erro para cada campo
  Stream<String?> get nameErrorStream;
  Stream<String?> get emailErrorStream;
  Stream<String?> get phoneErrorStream;
  Stream<String?> get passwordErrorStream;

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

  // Métodos de validação ao perder foco
  void validateNameOnFocusLost(String name);
  void validateEmailOnFocusLost(String email);
  void validatePhoneOnFocusLost(String phone);
  void validatePasswordOnFocusLost(String password);

  // Métodos de controle
  void isLoading(bool isLoading);
  Future<void> addAccount();

  // Métodos de navegação
  void navigateToLogin();
  void navigateToGoogleAddAccount();

  // Limpeza de recursos
  void dispose();
}
