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

  test('Não deve notificar o emailErrorStream se o valor for igual ao último',
      () async {
    mockValidation(field: 'email', value: 'Campo obrigatório');

    expectLater(sut.emailErrorStream, emits('Campo obrigatório'));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Deve notificar o isFormValidStream após alterar o email', () async {
    mockValidation(field: 'email', value: '');

    expectLater(sut.isFormValidStream, emits(true));

    sut.validateEmail(email);
  });

  test(
      'Deve notificar o isFormValidStream com false quando há erro de validação',
      () async {
    mockValidation(field: 'email', value: 'Campo obrigatório');

    expectLater(sut.isFormValidStream, emits(false));

    sut.validateEmail(email);
  });

  test('Deve chamar Validation ao alterar a senha', () async {
    final password = faker.internet.password();

    sut.validatePassword(password);

    verify(() => validation.validate(field: 'password', value: password))
        .called(1);
  });

  test('Deve emitir erro no passwordErrorStream se o Validation retornar erro',
      () async {
    final error = 'Campo obrigatório';
    final password = faker.internet.password();
    mockValidation(field: 'password', value: error);

    expectLater(sut.passwordErrorStream, emits(error));

    sut.validatePassword(password);
  });

  test(
      'Deve notificar o passwordErrorStream com null, caso o Validation não retorne erro',
      () async {
    final password = faker.internet.password();
    mockValidation(field: 'password', value: '');

    expectLater(sut.passwordErrorStream, emits(null));

    sut.validatePassword(password);
  });

  test(
      'Não deve notificar o passwordErrorStream se o valor for igual ao último',
      () async {
    final password = faker.internet.password();
    mockValidation(field: 'password', value: 'Campo obrigatório');

    expectLater(sut.passwordErrorStream, emits('Campo obrigatório'));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Deve notificar o isFormValidStream após alterar a senha', () async {
    final password = faker.internet.password();
    mockValidation(field: 'password', value: '');

    expectLater(sut.isFormValidStream, emits(true));

    sut.validatePassword(password);
  });

  test(
      'Deve notificar o isFormValidStream com false quando há erro de validação na senha',
      () async {
    final password = faker.internet.password();
    mockValidation(field: 'password', value: 'Campo obrigatório');

    expectLater(sut.isFormValidStream, emits(false));

    sut.validatePassword(password);
  });
}
