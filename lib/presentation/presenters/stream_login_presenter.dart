import 'dart:async';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../protocols/protocols.dart';
import '../../ui/pages/login/login_presenter.dart';

class LoginState {
  final String? emailError;
  final String? passwordError;
  final bool isFormValid;
  final String? email;
  final String? password;

  LoginState({
    this.emailError,
    this.passwordError,
    required this.isFormValid,
    this.email,
    this.password,
  });

  LoginState copyWith({
    String? emailError,
    String? passwordError,
    bool? isFormValid,
    String? email,
    String? password,
  }) {
    return LoginState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      isFormValid: isFormValid ?? this.isFormValid,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;
  final StreamController<LoginState> _stateController =
      StreamController<LoginState>.broadcast();
  final StreamController<bool> _isLoadingController =
      StreamController<bool>.broadcast();
  final StreamController<DomainError?> _mainErrorController =
      StreamController<DomainError?>.broadcast();

  LoginState _currentState = LoginState(isFormValid: false);

  StreamLoginPresenter({
    required this.validation,
    required this.authentication,
  });

  Stream<LoginState> get stateStream => _stateController.stream;
  @override
  Stream<String?> get emailErrorStream =>
      _stateController.stream.map((state) => state.emailError);
  @override
  Stream<String?> get passwordErrorStream =>
      _stateController.stream.map((state) => state.passwordError);
  @override
  Stream<bool> get isFormValidStream =>
      _stateController.stream.map((state) => state.isFormValid);
  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream;
  Stream<DomainError?> get mainErrorStream => _mainErrorController.stream;

  @override
  void validateEmail(String email) {
    final error = validation.validate(field: 'email', value: email);
    final emailError = error.isEmpty ? null : error;

    _currentState = _currentState.copyWith(
      emailError: emailError,
      email: email,
      isFormValid: _isFormValid(emailError, _currentState.passwordError),
    );

    _stateController.add(_currentState);
  }

  @override
  void validatePassword(String password) {
    final error = validation.validate(field: 'password', value: password);
    final passwordError = error.isEmpty ? null : error;

    _currentState = _currentState.copyWith(
      passwordError: passwordError,
      password: password,
      isFormValid: _isFormValid(_currentState.emailError, passwordError),
    );

    _stateController.add(_currentState);
  }

  @override
  void isLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  bool _isFormValid(String? emailError, String? passwordError) {
    return emailError == null && passwordError == null;
  }

  @override
  Future<void> auth() async {
    if (!_currentState.isFormValid) return;

    _isLoadingController.add(true);
    _mainErrorController.add(null);

    try {
      await authentication.auth(AuthenticationParams(
        email: _currentState.email ?? '',
        password: _currentState.password ?? '',
      ));
    } on DomainError catch (error) {
      _mainErrorController.add(error);
    } finally {
      _isLoadingController.add(false);
    }
  }

  @override
  void dispose() {
    _stateController.close();
    _isLoadingController.close();
    _mainErrorController.close();
  }
}
