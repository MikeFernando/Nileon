import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validators/validation_composite.dart';
import 'package:nileon/validation/validators/required_field_validator.dart';
import 'package:nileon/validation/validators/email_validation.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  group('ValidationComposite', () {
    late ValidationComposite sut;

    setUp(() {
      sut = ValidationComposite([
        RequiredFieldValidator('email'),
        EmailValidation('email'),
        RequiredFieldValidator('password'),
        PasswordValidation('password'),
      ]);
    });

    test('Deve retornar string vazia quando todos os campos são válidos', () {
      final error = sut.validate(field: 'email', value: 'valid@email.com');
      expect(error, '');
    });

    test('Deve retornar erro de campo obrigatório para email vazio', () {
      final error = sut.validate(field: 'email', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro de email inválido', () {
      final error = sut.validate(field: 'email', value: 'invalid_email');
      expect(error, 'Email inválido');
    });

    test('Deve retornar erro de campo obrigatório para senha vazia', () {
      final error = sut.validate(field: 'password', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro de senha muito curta', () {
      final error = sut.validate(field: 'password', value: '123');
      expect(error, 'Senha deve ter pelo menos 8 caracteres');
    });
  });
}
