import 'dart:async';

abstract class LoginPresenter {
  Stream<String?> get emailErrorStream;
  Stream<String?> get passwordErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  void isLoading(bool isLoading);
  void auth();
}

class LoginPresenterImpl implements LoginPresenter {
  final StreamController<String?> _emailErrorController =
      StreamController<String?>();
  final StreamController<String?> _passwordErrorController =
      StreamController<String?>();
  final StreamController<bool> _isFormValidController =
      StreamController<bool>();
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValidController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}

  @override
  void isLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  @override
  void auth() {}
}
