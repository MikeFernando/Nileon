import 'dart:async';

abstract class LoginPresenter {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;
  Stream<String?> get mainErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void validateEmailOnFocusLost(String email);
  void validatePasswordOnFocusLost(String password);
  void isLoading(bool isLoading);
  Future<void> auth();
  void dispose();
}
