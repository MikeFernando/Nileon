import 'dart:async';
import 'package:flutter/material.dart';
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
  final _emailErrorDisplayController = StreamController<bool>.broadcast();
  final _passwordErrorDisplayController = StreamController<bool>.broadcast();

  // Controllers para os campos de texto (persistentes)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // FocusNodes para os campos (persistentes)
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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

    // Configura listeners para os controllers
    _setupControllerListeners();
  }

  void _setupControllerListeners() {
    _emailController.addListener(() {
      validateEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      validatePassword(_passwordController.text);
    });
  }

  // Getters para os controllers
  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  // Getters para os focusNodes
  @override
  FocusNode get emailFocusNode => _emailFocusNode;

  @override
  FocusNode get passwordFocusNode => _passwordFocusNode;

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
  Stream<bool> get emailErrorDisplayStream =>
      _emailErrorDisplayController.stream;

  @override
  Stream<bool> get passwordErrorDisplayStream =>
      _passwordErrorDisplayController.stream;

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
  void showEmailError() {
    _emailErrorDisplayController.add(true);
  }

  @override
  void showPasswordError() {
    _passwordErrorDisplayController.add(true);
  }

  @override
  void refreshEmailErrorDisplay() {
    _emailErrorDisplayController.add(_lastEmailError != null);
  }

  @override
  void refreshPasswordErrorDisplay() {
    _passwordErrorDisplayController.add(_lastPasswordError != null);
  }

  @override
  void dispose() {
    _emailErrorController.close();
    _passwordErrorController.close();
    _isFormValidController.close();
    _isLoadingController.close();
    _mainErrorController.close();
    _emailErrorDisplayController.close();
    _passwordErrorDisplayController.close();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
      case DomainError.invalidData:
        return 'Dados inválidos';
      case DomainError.emailInUse:
        return 'E-mail já está em uso';
      case DomainError.invalidEmail:
        return 'E-mail inválido';
      case DomainError.weakPassword:
        return 'Senha muito fraca';
      case DomainError.invalidPhone:
        return 'Telefone inválido';
      case DomainError.unexpected:
        return 'Erro inesperado';
    }
  }
}
