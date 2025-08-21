import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/protocols/protocols.dart';
import 'package:nileon/validation/validators/validators.dart';

class FieldValidationSpy implements FieldValidation {
  String? errorMessage;

  @override
  String? validate(String? value) => errorMessage;
}

void main() {
  test('Deve retornar null se todos os validadores retornarem null ou vazio',
      () {
    final sut = ValidationComposite([]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, '');
  });
}
