import 'package:flutter_test/flutter_test.dart';

import 'package:nileon/validation/validators/validators.dart';

void main() {
  late RequiredFieldValidator sut;

  setUp(() {
    sut = RequiredFieldValidator('any_field');
  });

  test('Deve retornar null se o campo não for vazio', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Deve retornar o erro se o campo for vazio', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório');
  });

  test('Deve retornar o erro se o campo for nulo', () {
    final error = sut.validate(null);

    expect(error, 'Campo obrigatório');
  });
}
