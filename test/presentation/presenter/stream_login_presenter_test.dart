import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nileon/presentation/presenters/presenters.dart';
import 'package:nileon/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

void main() {
  late ValidationSpy validation;
  late StreamLoginPresenter sut;
  String email = faker.internet.email();

  mockValidation({String? field, String? value}) {
    when(() => validation.validate(
        field: field ?? any(named: 'field'),
        value: any(named: 'value'))).thenReturn(value ?? '');
  }

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    when(() => validation.validate(
        field: any(named: 'field'), value: any(named: 'value'))).thenReturn('');
  });

  tearDown(() {
    sut.dispose();
  });

  test('Deve chamar o Validation com os valores corretos', () {
    sut.validateEmail(email);

    verify(() => validation.validate(field: 'email', value: email)).called(1);
  });

  test('Deve emitir erro no emailErrorStream se o Validation retornar erro',
      () async {
    final error = 'Campo obrigatório';
    mockValidation(field: 'email', value: error);

    expectLater(sut.emailErrorStream, emits(error));

    sut.validateEmail(email);
  });

  test(
      'Deve notificar o emailErrorStream com null, caso o Validation não retorne erro',
      () async {
    mockValidation(field: 'email', value: '');

    expectLater(sut.emailErrorStream, emits(null));

    sut.validateEmail(email);
  });
}
