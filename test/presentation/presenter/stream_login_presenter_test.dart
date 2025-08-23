import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:faker/faker.dart';

import 'package:nileon/domain/usecases/usecases.dart';
import 'package:nileon/domain/helpers/helpers.dart';
import 'package:nileon/domain/entities/entities.dart';
import 'package:nileon/presentation/protocols/protocols.dart';
import 'package:nileon/presentation/presenters/stream_login_presenter.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  late StreamLoginPresenter sut;
  late ValidationSpy validation;
  late AuthenticationSpy authentication;
  late String email;
  late String password;

  setUpAll(() {
    registerFallbackValue(AuthenticationParams(email: '', password: ''));
  });

  void mockValidation(String field, String? error) {
    when(() => validation.validate(field: field, value: any(named: 'value')))
        .thenReturn(error ?? '');
  }

  void mockAuthentication() {
    when(() => authentication.auth(any<AuthenticationParams>())).thenAnswer(
      (_) async => AccountEntity(
        id: faker.guid.guid(),
        name: faker.person.name(),
        email: faker.internet.email(),
        phone: faker.phoneNumber.toString(),
        accessToken: faker.guid.guid(),
        refreshToken: faker.guid.guid(),
        role: 'CLIENT',
      ),
    );
  }

  void mockAuthenticationError(DomainError error) {
    when(() => authentication.auth(any<AuthenticationParams>()))
        .thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
      validation: validation,
      authentication: authentication,
    );
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation('email', null);
    mockValidation('password', null);
  });

  group('validateEmail', () {
    test('Deve chamar EmailValidation ao alterar o email', () {
      sut.validateEmail(email);

      verify(() => validation.validate(field: 'email', value: email)).called(1);
    });

    test(
        'Deve notificar o emailErrorStream com o mesmo erro do EmailValidation, caso retorne erro',
        () async {
      final error = 'Email inválido';
      mockValidation('email', error);

      expectLater(sut.emailErrorStream, emits(error));
      sut.validateEmail(email);
    });

    test(
        'Deve notificar o emailErrorStream com null, caso o EmailValidation não retorne erro',
        () async {
      mockValidation('email', null);

      expectLater(sut.emailErrorStream, emits(null));
      sut.validateEmail(email);
    });

    test('Não deve notificar o emailErrorStream se o valor for igual ao último',
        () async {
      final error = 'Email inválido';
      mockValidation('email', error);

      expectLater(sut.emailErrorStream, emits(error));
      sut.validateEmail(email);
      sut.validateEmail(email);
    });

    test('Deve notificar o isFormValidStream após alterar o email', () async {
      mockValidation('password', null);

      expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
      sut.validatePassword(password);
      sut.validateEmail(email);
    });

    test('Deve remover erro quando o email fica vazio', () async {
      final error = 'Email inválido';
      mockValidation('email', error);

      // Primeiro valida com erro
      expectLater(sut.emailErrorStream, emits(error));
      sut.validateEmail('invalid@email');

      // Depois remove o erro quando fica vazio
      expectLater(sut.emailErrorStream, emits(null));
      sut.validateEmail('');
    });

    test('Não deve chamar validação quando o email está vazio', () {
      sut.validateEmail('');

      verifyNever(() =>
          validation.validate(field: 'email', value: any(named: 'value')));
    });
  });

  group('validatePassword', () {
    test('Deve chamar PasswordValidation ao alterar a senha', () {
      sut.validatePassword(password);

      verify(() => validation.validate(field: 'password', value: password))
          .called(1);
    });

    test(
        'Deve notificar o passwordErrorStream com o mesmo erro do PasswordValidation, caso retorne erro',
        () async {
      final error = 'Senha inválida';
      mockValidation('password', error);

      expectLater(sut.passwordErrorStream, emits(error));
      sut.validatePassword(password);
    });

    test(
        'Deve notificar o passwordErrorStream com null, caso o PasswordValidation não retorne erro',
        () async {
      mockValidation('password', null);

      expectLater(sut.passwordErrorStream, emits(null));
      sut.validatePassword(password);
    });

    test(
        'Não deve notificar o passwordErrorStream se o valor for igual ao último',
        () async {
      final error = 'Senha inválida';
      mockValidation('password', error);

      expectLater(sut.passwordErrorStream, emits(error));
      sut.validatePassword(password);
      sut.validatePassword(password);
    });

    test('Deve notificar o isFormValidStream após alterar a senha', () async {
      mockValidation('email', null);

      expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
      sut.validateEmail(email);
      sut.validatePassword(password);
    });

    test('Deve remover erro quando a senha fica vazia', () async {
      final error = 'Senha deve ter pelo menos 8 caracteres';
      mockValidation('password', error);

      // Primeiro valida com erro
      expectLater(sut.passwordErrorStream, emits(error));
      sut.validatePassword('123');

      // Depois remove o erro quando fica vazio
      expectLater(sut.passwordErrorStream, emits(null));
      sut.validatePassword('');
    });

    test('Não deve chamar validação quando a senha está vazia', () {
      sut.validatePassword('');

      verifyNever(() =>
          validation.validate(field: 'password', value: any(named: 'value')));
    });
  });

  group('validateForm', () {
    test(
        'Deve validar que para o formulário estar válido todos os Streams de erro precisam estar null e todos os campos obrigatórios não podem estar vazios',
        () async {
      mockValidation('email', null);
      mockValidation('password', null);

      expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
      sut.validateEmail(email);
      sut.validatePassword(password);
    });

    test('Deve invalidar o formulário se o email estiver vazio', () async {
      mockValidation('email', null);
      mockValidation('password', null);

      expectLater(sut.isFormValidStream, emits(false));
      sut.validateEmail('');
      sut.validatePassword(password);
    });

    test('Deve invalidar o formulário se a senha estiver vazia', () async {
      mockValidation('email', null);
      mockValidation('password', null);

      expectLater(sut.isFormValidStream, emits(false));
      sut.validateEmail(email);
      sut.validatePassword('');
    });

    test('Deve invalidar o formulário se o email tiver erro', () async {
      mockValidation('email', 'Email inválido');
      mockValidation('password', null);

      expectLater(sut.isFormValidStream, emits(false));
      sut.validateEmail(email);
      sut.validatePassword(password);
    });

    test('Deve invalidar o formulário se a senha tiver erro', () async {
      mockValidation('email', null);
      mockValidation('password', 'Senha inválida');

      expectLater(sut.isFormValidStream, emits(false));
      sut.validateEmail(email);
      sut.validatePassword(password);
    });
  });

  group('auth', () {
    test('Deve chamar o Authentication com email e senha corretos', () async {
      mockAuthentication();
      mockValidation('email', null);
      mockValidation('password', null);

      sut.validateEmail(email);
      sut.validatePassword(password);
      await sut.auth();

      verify(() => authentication.auth(any<AuthenticationParams>())).called(1);
    });

    test(
        'Deve notificar o isLoadingStream como true antes de chamar o Authentication',
        () async {
      mockAuthentication();
      mockValidation('email', null);
      mockValidation('password', null);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      await sut.auth();
    });

    test('Deve notificar o isLoadingStream como false no fim do Authentication',
        () async {
      mockAuthentication();
      mockValidation('email', null);
      mockValidation('password', null);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
      await sut.auth();
    });

    test(
        'Deve notificar o mainErrorStream caso o Authentication retorne um DomainError',
        () async {
      mockAuthenticationError(DomainError.invalidCredentials);
      mockValidation('email', null);
      mockValidation('password', null);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(
          sut.mainErrorStream, emitsInOrder([null, 'Credenciais inválidas']));
      await sut.auth();
    });

    test(
        'Deve notificar o mainErrorStream com erro inesperado caso o Authentication retorne DomainError.unexpected',
        () async {
      mockAuthenticationError(DomainError.unexpected);
      mockValidation('email', null);
      mockValidation('password', null);

      sut.validateEmail(email);
      sut.validatePassword(password);

      expectLater(sut.mainErrorStream, emitsInOrder([null, 'Erro inesperado']));
      await sut.auth();
    });
  });

  group('dispose', () {
    test('Deve fechar todos os Streams no dispose', () {
      expect(() => sut.dispose(), returnsNormally);
    });
  });

  tearDown(() {});
}
