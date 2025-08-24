import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validators/required_field_validator.dart';

void main() {
  group('RequiredFieldValidator', () {
    late RequiredFieldValidator sut;

    setUp(() {
      sut = RequiredFieldValidator('email');
    });

    test('Deve retornar string vazia para campo válido', () {
      final error = sut.validate(field: 'email', value: 'valid@email.com');
      expect(error, '');
    });

    test('Deve retornar erro para campo vazio', () {
      final error = sut.validate(field: 'email', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro para campo com apenas espaços', () {
      final error = sut.validate(field: 'email', value: '   ');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar string vazia para campo diferente', () {
      final error = sut.validate(field: 'password', value: '');
      expect(error, '');
    });
  });
}
