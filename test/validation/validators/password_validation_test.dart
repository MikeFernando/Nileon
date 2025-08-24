import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  late PasswordValidation sut;

  setUp(() {
    sut = PasswordValidation('password');
  });

  group('PasswordValidation', () {
    test('Deve retornar string vazia se a senha for válida', () {
      final error = sut.validate(field: 'password', value: 'valid_password');
      expect(error, '');
    });

    test('Deve retornar erro se a senha for vazia', () {
      final error = sut.validate(field: 'password', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro se a senha tiver menos de 8 caracteres', () {
      final error = sut.validate(field: 'password', value: '1234567');
      expect(error, 'Senha deve ter pelo menos 8 caracteres');
    });

    test('Deve retornar erro se a senha tiver exatamente 7 caracteres', () {
      final error = sut.validate(field: 'password', value: '1234567');
      expect(error, 'Senha deve ter pelo menos 8 caracteres');
    });

    test('Deve aceitar senha com exatamente 8 caracteres', () {
      final error = sut.validate(field: 'password', value: '12345678');
      expect(error, '');
    });

    test('Deve aceitar senha com mais de 8 caracteres', () {
      final error = sut.validate(field: 'password', value: '123456789');
      expect(error, '');
    });

    test('Deve retornar string vazia se o campo não for password', () {
      final error = sut.validate(field: 'email', value: 'short');
      expect(error, '');
    });
  });
}
