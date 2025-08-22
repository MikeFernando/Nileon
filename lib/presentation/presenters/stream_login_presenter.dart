import 'dart:async';
import 'package:nileon/domain/usecases/usecases.dart';
import 'package:nileon/domain/helpers/helpers.dart';
import 'package:nileon/presentation/protocols/protocols.dart';
import 'package:nileon/ui/pages/login/login_presenter.dart';

class StreamLoginPresenter implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;

  final _emailErrorController = StreamController<String?>.broadcast();
  final _passwordErrorController = StreamController<String?>.broadcast();
  final _isFormValidController = StreamController<bool>.broadcast();
  final _isLoadingController = StreamController<bool>.broadcast();
  final _mainErrorController = StreamController<String?>.broadcast();

  String? _email;
  String? _password;
  String? _lastEmailError;
  String? _lastPasswordError;

  StreamLoginPresenter({
    required this.validation,
    required this.authentication,
  }) {
    _isFormValidController.add(false);
    _isLoadingController.add(false);
  }

  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValidController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  @override
  Stream<String?> get mainErrorStream => _mainErrorController.stream;

  @override
  void validateEmail(String email) {
    _email = email;
    _validateEmail();
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _validatePassword();
    _validateForm();
  }

  @override
  void validateEmailOnFocusLost(String email) {
    _email = email;
    _validateEmail();
    _validateForm();
  }

  @override
  void validatePasswordOnFocusLost(String password) {
    _password = password;
    _validatePassword();
    _validateForm();
  }

  @override
  void isLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  @override
  Future<void> auth() async {
    try {
      _mainErrorController.add(null);
      _isLoadingController.add(true);

      final params = AuthenticationParams(
        email: _email ?? '',
        password: _password ?? '',
      );

      await authentication.auth(params);
    } on DomainError catch (error) {
      _mainErrorController.add(_getErrorMessage(error));
    } finally {
      _isLoadingController.add(false);
    }
  }

  @override
  void dispose() {
    _emailErrorController.close();
    _passwordErrorController.close();
    _isFormValidController.close();
    _isLoadingController.close();
    _mainErrorController.close();
  }

  void _validateEmail() {
    // Se o campo estiver vazio, não mostrar erro
    if (_email == null || _email!.isEmpty) {
      if (_lastEmailError != null) {
        _lastEmailError = null;
        _emailErrorController.add(null);
      }
      return;
    }

    final error = validation.validate(field: 'email', value: _email!);

    if (error != _lastEmailError) {
      _lastEmailError = error;
      _emailErrorController.add(error.isEmpty ? null : error);
    }
  }

  void _validatePassword() {
    if (_password == null || _password!.isEmpty) {
      if (_lastPasswordError != null) {
        _lastPasswordError = null;
        _passwordErrorController.add(null);
      }
      return;
    }

    final error = validation.validate(field: 'password', value: _password!);

    if (error != _lastPasswordError) {
      _lastPasswordError = error;
      _passwordErrorController.add(error.isEmpty ? null : error);
    }
  }

  void _validateForm() {
    final isEmailValid = _email != null &&
        _email!.isNotEmpty &&
        (_lastEmailError == null || _lastEmailError!.isEmpty);
    final isPasswordValid = _password != null &&
        _password!.isNotEmpty &&
        (_lastPasswordError == null || _lastPasswordError!.isEmpty);
    final isFormValid = isEmailValid && isPasswordValid;

    _isFormValidController.add(isFormValid);
  }

  String _getErrorMessage(DomainError error) {
    switch (error) {
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas';
      case DomainError.unexpected:
        return 'Erro inesperado';
      case DomainError.emailInUse:
        return 'E-mail já está em uso';
      case DomainError.invalidEmail:
        return 'E-mail inválido';
      case DomainError.weakPassword:
        return 'Senha muito fraca';
      case DomainError.invalidPhone:
        return 'Telefone inválido';
    }
  }
}
