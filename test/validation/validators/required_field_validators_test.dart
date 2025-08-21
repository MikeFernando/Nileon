import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class FieldValidation {
  String? validate(String value);
}

class RequiredFieldValidatorSpy extends Mock implements FieldValidation {
  final String field;

  RequiredFieldValidatorSpy(this.field);

  @override
  String? validate(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }
}

void main() {
  late RequiredFieldValidatorSpy sut;

  setUp(() {
    sut = RequiredFieldValidatorSpy('any_field');
  });

  test('Deve retornar null se o campo não for vazio', () {
    final error = sut.validate('any_value');

    expect(error, null);
  });

  test('Deve retornar o erro se o campo for vazio', () {
    final error = sut.validate('');

    expect(error, 'Campo obrigatório');
  });
}
