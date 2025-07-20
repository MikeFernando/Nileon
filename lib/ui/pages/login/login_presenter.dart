import 'dart:async';

abstract class LoginPresenter {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;

  void validateEmail(String email);
  void validatePassword(String password);
}

class LoginPresenterImpl implements LoginPresenter {
  final StreamController<String?> _emailErrorController =
      StreamController<String?>();
  final StreamController<String?> _passwordErrorController =
      StreamController<String?>();

  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;

  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}
}
