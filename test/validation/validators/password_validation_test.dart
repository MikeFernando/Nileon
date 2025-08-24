import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  late PasswordValidation sut;

  setUp(() {
    sut = PasswordValidation('password');
  });

  group('PasswordValidation', () {
    test('Deve retornar string vazia se a senha for válida', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!');
      expect(error, '');
    });

    test('Deve retornar erro se a senha for vazia', () {
      final error = sut.validate(field: 'password', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro se a senha tiver apenas espaços', () {
      final error = sut.validate(field: 'password', value: '   ');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro se a senha tiver menos de 8 caracteres', () {
      final error = sut.validate(field: 'password', value: 'Abc123!');
      expect(error, 'Senha deve ter pelo menos 8 caracteres');
    });

    test('Deve retornar erro se a senha não tiver letra maiúscula', () {
      final error = sut.validate(field: 'password', value: 'validpass123!');
      expect(error, 'Senha deve conter pelo menos uma letra maiúscula');
    });

    test('Deve retornar erro se a senha não tiver letra minúscula', () {
      final error = sut.validate(field: 'password', value: 'VALIDPASS123!');
      expect(error, 'Senha deve conter pelo menos uma letra minúscula');
    });

    test('Deve retornar erro se a senha não tiver número', () {
      final error = sut.validate(field: 'password', value: 'ValidPass!');
      expect(error, 'Senha deve conter pelo menos um número');
    });

    test('Deve retornar erro se a senha não tiver caractere especial', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123');
      expect(error, 'Senha deve conter pelo menos um caractere especial');
    });

    test('Deve aceitar senha válida com todos os requisitos', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!');
      expect(error, '');
    });

    test('Deve aceitar senha válida com diferentes caracteres especiais', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123@');
      expect(error, '');
    });

    test('Deve retornar string vazia se o campo não for password', () {
      final error = sut.validate(field: 'email', value: 'short');
      expect(error, '');
    });
  });
}
