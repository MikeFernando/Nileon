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

  test('Deve manter o estado correto quando ambos os campos são validados',
      () async {
    final password = faker.internet.password();

    mockValidation(field: 'email', value: '');
    mockValidation(field: 'password', value: '');

    expectLater(
        sut.stateStream,
        emitsInOrder([
          isA<LoginState>()
              .having((state) => state.emailError, 'emailError', null)
              .having((state) => state.isFormValid, 'isFormValid', true),
          isA<LoginState>()
              .having((state) => state.emailError, 'emailError', null)
              .having((state) => state.passwordError, 'passwordError', null)
              .having((state) => state.isFormValid, 'isFormValid', true),
        ]));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });

  test('Deve manter o estado correto quando um campo tem erro e outro não',
      () async {
    final password = faker.internet.password();

    mockValidation(field: 'email', value: 'Email inválido');
    mockValidation(field: 'password', value: '');

    expectLater(
        sut.stateStream,
        emitsInOrder([
          isA<LoginState>()
              .having(
                  (state) => state.emailError, 'emailError', 'Email inválido')
              .having((state) => state.isFormValid, 'isFormValid', false),
          isA<LoginState>()
              .having(
                  (state) => state.emailError, 'emailError', 'Email inválido')
              .having((state) => state.passwordError, 'passwordError', null)
              .having((state) => state.isFormValid, 'isFormValid', false),
        ]));

    sut.validateEmail(email);
    sut.validatePassword(password);
  });
}
