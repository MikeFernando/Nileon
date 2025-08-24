import 'package:flutter_test/flutter_test.dart';

import 'package:nileon/validation/validators/phone_validation.dart';

void main() {
  late PhoneValidation sut;

  setUp(() {
    sut = PhoneValidation('phone');
  });

  group('PhoneValidation', () {
    test('deve retornar erro se o campo não for phone', () {
      final error = sut.validate(field: 'email', value: '11999999999');
      expect(error, isEmpty);
    });

    test('deve retornar erro se o telefone estiver vazio', () {
      final error = sut.validate(field: 'phone', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('deve retornar erro se o telefone tiver apenas espaços', () {
      final error = sut.validate(field: 'phone', value: '   ');
      expect(error, 'Campo obrigatório');
    });

    test('deve retornar erro se o telefone tiver menos de 10 dígitos', () {
      final error = sut.validate(field: 'phone', value: '119999999');
      expect(error, 'Telefone inválido');
    });

    test('deve retornar erro se o telefone tiver mais de 11 dígitos', () {
      final error = sut.validate(field: 'phone', value: '119999999999');
      expect(error, 'Telefone inválido');
    });

    test('deve retornar erro se o DDD for menor que 11', () {
      final error = sut.validate(field: 'phone', value: '1099999999');
      expect(error, 'DDD inválido');
    });

    test('deve retornar erro se o DDD for maior que 99', () {
      final error = sut.validate(field: 'phone', value: '10099999999');
      expect(error, 'DDD inválido');
    });

    test('deve retornar erro se o número do telefone tiver menos de 8 dígitos',
        () {
      final error = sut.validate(field: 'phone', value: '11999999');
      expect(error, 'Telefone inválido');
    });

    test('deve retornar erro se o número do telefone tiver mais de 9 dígitos',
        () {
      final error = sut.validate(field: 'phone', value: '119999999999');
      expect(error, 'Telefone inválido');
    });

    test('deve retornar vazio se o telefone for válido com 10 dígitos', () {
      final error = sut.validate(field: 'phone', value: '1199999999');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o telefone for válido com 11 dígitos', () {
      final error = sut.validate(field: 'phone', value: '11999999999');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o telefone for válido com formatação', () {
      final error = sut.validate(field: 'phone', value: '11 99999 9999');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o telefone for válido com outros caracteres',
        () {
      final error = sut.validate(field: 'phone', value: '(11) 99999-9999');
      expect(error, isEmpty);
    });

    test('deve retornar vazio para DDD válido 11', () {
      final error = sut.validate(field: 'phone', value: '11999999999');
      expect(error, isEmpty);
    });

    test('deve retornar vazio para DDD válido 99', () {
      final error = sut.validate(field: 'phone', value: '99999999999');
      expect(error, isEmpty);
    });
  });
}
