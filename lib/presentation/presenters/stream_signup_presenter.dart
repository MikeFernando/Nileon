import 'dart:async';

import '../../domain/usecases/usecases.dart';
import '../../domain/helpers/helpers.dart';

import '../../presentation/protocols/protocols.dart';
import '../../ui/pages/signup/signup_presenter.dart';

class StreamSignUpPresenter implements SignUpPresenter {
  final Validation validation;
  final AddAccount addAccount;

  // Controllers para streams de erro
  final _nameErrorController = StreamController<String?>.broadcast();
  final _emailErrorController = StreamController<String?>.broadcast();
  final _phoneErrorController = StreamController<String?>.broadcast();
  final _passwordErrorController = StreamController<String?>.broadcast();

  // Controller para stream do texto da senha (para regras em tempo real)
  final _passwordTextController = StreamController<String>.broadcast();

  // Controllers para streams de estado
  final _isFormValidController = StreamController<bool>.broadcast();
  final _isLoadingController = StreamController<bool>.broadcast();
  final _mainErrorController = StreamController<String?>.broadcast();

  // Controllers para streams de navegação
  final _navigateToController = StreamController<String?>.broadcast();
  final _navigateToLoginController = StreamController<String?>.broadcast();
  final _navigateToGoogleAddAccountController =
      StreamController<String?>.broadcast();

  // Variáveis de estado
  String? _name;
  String? _email;
  String? _phone;
  String? _password;

  // Últimos erros para evitar notificações desnecessárias
  String? _lastNameError;
  String? _lastEmailError;
  String? _lastPhoneError;
  String? _lastPasswordError;

  StreamSignUpPresenter({
    required this.validation,
    required this.addAccount,
  }) {
    // Inicializa todos os streams com valores padrão
    _nameErrorController.add(null);
    _emailErrorController.add(null);
    _phoneErrorController.add(null);
    _passwordErrorController.add(null);
    _isFormValidController.add(false);
    _isLoadingController.add(false);
    _mainErrorController.add(null);
    _navigateToController.add(null);
    _navigateToLoginController.add(null);
    _navigateToGoogleAddAccountController.add(null);
  }

  @override
  Stream<String?> get nameErrorStream => _nameErrorController.stream;

  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  @override
  Stream<String?> get phoneErrorStream => _phoneErrorController.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;

  @override
  Stream<String> get passwordTextStream => _passwordTextController.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValidController.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  @override
  Stream<String?> get mainErrorStream => _mainErrorController.stream;

  @override
  Stream<String?> get navigateToStream => _navigateToController.stream;

  @override
  Stream<String?> get navigateToLoginStream =>
      _navigateToLoginController.stream;

  @override
  Stream<String?> get navigateToGoogleAddAccountStream =>
      _navigateToGoogleAddAccountController.stream;

  @override
  void validateName(String name) {
    _name = name;
    _validateName();
    _validateForm();
  }

  @override
  void validateEmail(String email) {
    _email = email;
    _validateEmail();
    _validateForm();
  }

  @override
  void validatePhone(String phone) {
    _phone = phone;
    _validatePhone();
    _validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordTextController.add(password);
    _validatePassword();
    _validateForm();
  }

  @override
  void isLoading(bool isLoading) {
    _isLoadingController.add(isLoading);
  }

  @override
  Future<void> signUp() async {
    try {
      _mainErrorController.add(null);
      _isLoadingController.add(true);

      final cleanPhone = _phone?.replaceAll(RegExp(r'[^\d]'), '') ?? '';

      final params = AddAccountParams(
        name: _name ?? '',
        email: _email ?? '',
        phone: cleanPhone,
        password: _password ?? '',
      );

      await addAccount.add(params);
      _navigateToController.add('/home');
    } on DomainError catch (error) {
      _mainErrorController.add(_getErrorMessage(error));
    } catch (e) {
      _mainErrorController.add('Erro inesperado: $e');
    } finally {
      _isLoadingController.add(false);
    }
  }

  @override
  void navigateToLogin() {
    _navigateToLoginController.add('/login');
  }

  @override
  void navigateToGoogleAddAccount() {
    _navigateToGoogleAddAccountController.add('/google-add-account');
  }

  @override
  void dispose() {
    _nameErrorController.close();
    _emailErrorController.close();
    _phoneErrorController.close();
    _passwordErrorController.close();
    _passwordTextController.close();
    _isFormValidController.close();
    _isLoadingController.close();
    _mainErrorController.close();
    _navigateToController.close();
    _navigateToLoginController.close();
    _navigateToGoogleAddAccountController.close();
  }

  void _validateName() {
    if (_name == null || _name!.isEmpty) {
      if (_lastNameError != null) {
        _lastNameError = null;
        _nameErrorController.add(null);
      }
      return;
    }

    final error = validation.validate(field: 'name', value: _name!);

    if (error != _lastNameError) {
      _lastNameError = error;
      _nameErrorController.add(error.isEmpty ? null : error);
    }
  }

  void _validateEmail() {
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

  void _validatePhone() {
    if (_phone == null || _phone!.isEmpty) {
      if (_lastPhoneError != null) {
        _lastPhoneError = null;
        _phoneErrorController.add(null);
      }
      return;
    }

    final error = validation.validate(field: 'phone', value: _phone!);

    if (error != _lastPhoneError) {
      _lastPhoneError = error;
      _phoneErrorController.add(error.isEmpty ? null : error);
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
    final isNameValid = _name != null &&
        _name!.isNotEmpty &&
        (_lastNameError == null || _lastNameError!.isEmpty);
    final isEmailValid = _email != null &&
        _email!.isNotEmpty &&
        (_lastEmailError == null || _lastEmailError!.isEmpty);
    final isPhoneValid = _phone != null &&
        _phone!.isNotEmpty &&
        (_lastPhoneError == null || _lastPhoneError!.isEmpty);
    final isPasswordValid = _password != null &&
        _password!.isNotEmpty &&
        (_lastPasswordError == null || _lastPasswordError!.isEmpty);

    final isFormValid =
        isNameValid && isEmailValid && isPhoneValid && isPasswordValid;

    _isFormValidController.add(isFormValid);
  }

  String _getErrorMessage(DomainError error) {
    switch (error) {
      case DomainError.invalidCredentials:
        return 'Credenciais inválidas';
      case DomainError.emailInUse:
        return 'E-mail já está em uso';
      case DomainError.invalidEmail:
        return 'E-mail inválido';
      case DomainError.weakPassword:
        return 'Senha muito fraca';
      case DomainError.invalidPhone:
        return 'Telefone inválido';
      case DomainError.invalidData:
        return 'Dados inválidos';
      case DomainError.unexpected:
        return 'Erro inesperado';
    }
  }
}
