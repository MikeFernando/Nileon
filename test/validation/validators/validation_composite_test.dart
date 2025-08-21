import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/protocols/protocols.dart';
import 'package:nileon/validation/validators/validators.dart';

class FieldValidationSpy implements FieldValidation {
  String? errorMessage;
  String fieldNameValue = 'any_field';

  @override
  String? validate(String? value) => errorMessage;

  @override
  String get fieldName => fieldNameValue;
}

void main() {
  test('Deve retornar null se todos os validadores retornarem null ou vazio',
      () {
    final sut = ValidationComposite([]);

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, '');
  });

  test('Deve retornar o primeiro erro que ocorrer', () {
    final field = 'other_field';
    final firstSpy = FieldValidationSpy();
    firstSpy.errorMessage = 'error';
    firstSpy.fieldNameValue = field;
    final secondSpy = FieldValidationSpy();
    final sut = ValidationComposite([firstSpy, secondSpy]);

    final error = sut.validate(field: field, value: 'any_value');

    expect(error, 'error');
  });

  test('Deve retornar o primeiro erro do campo correto', () {
    final field = 'email';
    final firstSpy = FieldValidationSpy();
    firstSpy.errorMessage = 'error';
    firstSpy.fieldNameValue = field;
    final secondSpy = FieldValidationSpy();
    final sut = ValidationComposite([firstSpy, secondSpy]);

    final error = sut.validate(field: field, value: 'any_value');

    expect(error, 'error');
  });
}
