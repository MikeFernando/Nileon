import 'dart:async';

import '../protocols/protocols.dart';

class StreamLoginPresenter {
  final Validation validation;
  final StreamController<String?> _emailErrorController =
      StreamController<String?>.broadcast();
  final StreamController<String?> _passwordErrorController =
      StreamController<String?>.broadcast();
  final StreamController<bool> _isFormValidController =
      StreamController<bool>.broadcast();

  StreamLoginPresenter({required this.validation});

  Stream<String?> get emailErrorStream => _emailErrorController.stream;
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;
  Stream<bool> get isFormValidStream => _isFormValidController.stream;

  void validateEmail(String email) {
    final error = validation.validate(field: 'email', value: email);
    _emailErrorController.add(error.isEmpty ? null : error);
    _isFormValidController.add(error.isEmpty);
  }

  void validatePassword(String password) {
    final error = validation.validate(field: 'password', value: password);
    _passwordErrorController.add(error.isEmpty ? null : error);
    _isFormValidController.add(error.isEmpty);
  }

  void dispose() {
    _emailErrorController.close();
    _passwordErrorController.close();
    _isFormValidController.close();
  }
}
