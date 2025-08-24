import 'package:flutter_test/flutter_test.dart';

import 'package:nileon/validation/validators/name_validation.dart';

void main() {
  late NameValidation sut;

  setUp(() {
    sut = NameValidation('name');
  });

  group('NameValidation', () {
    test('deve retornar erro se o campo não for name', () {
      final error = sut.validate(field: 'email', value: 'João Silva');
      expect(error, isEmpty);
    });

    test('deve retornar erro se o nome estiver vazio', () {
      final error = sut.validate(field: 'name', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('deve retornar erro se o nome tiver apenas espaços', () {
      final error = sut.validate(field: 'name', value: '   ');
      expect(error, 'Campo obrigatório');
    });

    test('deve retornar erro se o nome tiver menos de 3 caracteres', () {
      final error = sut.validate(field: 'name', value: 'Jo');
      expect(error, 'Nome deve ter pelo menos 3 caracteres');
    });

    test('deve retornar erro se o nome tiver mais de 100 caracteres', () {
      final longName = 'A' * 101;
      final error = sut.validate(field: 'name', value: longName);
      expect(error, 'Nome deve ter no máximo 100 caracteres');
    });

    test('deve retornar erro se o nome contiver números', () {
      final error = sut.validate(field: 'name', value: 'João123 Silva');
      expect(error, 'Nome deve conter apenas letras');
    });

    test('deve retornar erro se o nome contiver caracteres especiais inválidos',
        () {
      final error = sut.validate(field: 'name', value: 'João@Silva');
      expect(error, 'Nome deve conter apenas letras');
    });

    test('deve retornar vazio se tiver apenas uma palavra válida', () {
      final error = sut.validate(field: 'name', value: 'João');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o nome for válido com duas palavras', () {
      final error = sut.validate(field: 'name', value: 'João Silva');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o nome for válido com três palavras', () {
      final error = sut.validate(field: 'name', value: 'João Pedro Silva');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o nome tiver exatamente 3 caracteres', () {
      final error = sut.validate(field: 'name', value: 'Ana');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o nome tiver acentos', () {
      final error = sut.validate(field: 'name', value: 'João Silva');
      expect(error, isEmpty);
    });

    test('deve retornar vazio se o nome tiver espaços extras', () {
      final error = sut.validate(field: 'name', value: '  João   Silva  ');
      expect(error, isEmpty);
    });

    test('deve retornar vazio para nome com hífen', () {
      final error = sut.validate(field: 'name', value: 'João Silva Santos');
      expect(error, isEmpty);
    });
  });
}
