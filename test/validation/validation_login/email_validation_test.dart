import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validation_login/email_validation.dart';

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('email');
  });

  group('EmailValidation', () {
    test('Deve retornar string vazia se o email for válido', () {
      final error = sut.validate(field: 'email', value: 'any_email@gmail.com');
      expect(error, '');
    });

    test('Deve retornar erro se o email for inválido', () {
      final error = sut.validate(field: 'email', value: 'invalid_email');
      expect(error, 'Email inválido');
    });

    test('Deve retornar erro se o email for vazio', () {
      final error = sut.validate(field: 'email', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro se o email não tiver @', () {
      final error = sut.validate(field: 'email', value: 'emailgmail.com');
      expect(error, 'Email inválido');
    });

    test('Deve retornar erro se o email não tiver domínio', () {
      final error = sut.validate(field: 'email', value: 'email@');
      expect(error, 'Email inválido');
    });

    test('Deve retornar erro se o email não tiver extensão', () {
      final error = sut.validate(field: 'email', value: 'email@gmail');
      expect(error, 'Email inválido');
    });

    test('Deve aceitar emails com pontos no nome', () {
      final error = sut.validate(field: 'email', value: 'user.name@gmail.com');
      expect(error, '');
    });

    test('Deve aceitar emails com números', () {
      final error = sut.validate(field: 'email', value: 'user123@gmail.com');
      expect(error, '');
    });

    test('Deve retornar string vazia se o campo não for email', () {
      final error = sut.validate(field: 'password', value: 'invalid_email');
      expect(error, '');
    });
  });
}
