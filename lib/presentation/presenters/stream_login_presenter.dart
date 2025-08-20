import 'dart:async';

import '../protocols/protocols.dart';

class LoginState {
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;

  LoginState({
    this.emailError,
    this.passwordError,
    required this.isFormValid,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? isFormValid,
  }) {
    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

class StreamLoginPresenter {
  final Validation validation;
  final StreamController<LoginState> _stateController =
      StreamController<LoginState>.broadcast();

  LoginState _currentState = LoginState(isFormValid: false);

  StreamLoginPresenter({required this.validation});

  Stream<LoginState> get stateStream => _stateController.stream;
  Stream<String?> get emailErrorStream =>
      _stateController.stream.map((state) => state.emailError);
  Stream<String?> get passwordErrorStream =>
      _stateController.stream.map((state) => state.passwordError);
  Stream<bool> get isFormValidStream =>
      _stateController.stream.map((state) => state.isFormValid);

  void validateEmail(String email) {
    final error = validation.validate(field: 'email', value: email);
    final emailError = error.isEmpty ? null : error;

    _currentState = _currentState.copyWith(
      emailError: emailError,
      isFormValid: _isFormValid(emailError, _currentState.passwordError),
    );

    _stateController.add(_currentState);
  }

  void validatePassword(String password) {
    final error = validation.validate(field: 'password', value: password);
    final passwordError = error.isEmpty ? null : error;

    _currentState = _currentState.copyWith(
      passwordError: passwordError,
      isFormValid: _isFormValid(_currentState.emailError, passwordError),
    );

    _stateController.add(_currentState);
  }

  bool _isFormValid(String? emailError, String? passwordError) {
    return emailError == null && passwordError == null;
  }

  void dispose() {
    _stateController.close();
  }
}
