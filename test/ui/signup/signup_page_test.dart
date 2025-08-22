import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:nileon/ui/pages/signup/signup_page.dart';
import 'package:nileon/ui/pages/signup/signup_presenter.dart';
import 'package:nileon/ui/pages/signup/components/components.dart';

class SignupPresenterSpy extends Mock implements SignupPresenter {}

void main() {
  late SignupPresenterSpy presenter;

  setUp(() {
    presenter = SignupPresenterSpy();

    // Setup default stream responses
    when(() => presenter.nameErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.phoneErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToLoginStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToGoogleSignupStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.dispose()).thenAnswer((_) {});
  });

  Widget createWidgetUnderTest() {
    return GetMaterialApp(
      home: SignupPage(presenter: presenter),
    );
  }

  group('SignupPage - Regras de Interface', () {
    testWidgets('Deve exibir campo de entrada para nome',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(NameInput), findsOneWidget);
      expect(find.text('Nome'), findsOneWidget);
    });

    testWidgets('Deve exibir campo de entrada para email',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EmailInput), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Deve exibir campo de entrada para telefone',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(PhoneInput), findsOneWidget);
      expect(find.text('Telefone'), findsOneWidget);
    });

    testWidgets('Deve exibir campo de entrada para senha',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(PasswordInput), findsOneWidget);
      expect(find.text('Senha'), findsOneWidget);
    });

    testWidgets('Deve exibir botão de registro', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ButtonSignup), findsOneWidget);
      expect(find.text('Registrar'), findsOneWidget);
    });

    testWidgets('Deve exibir botão do Google', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ButtonGoogle), findsOneWidget);
    });

    testWidgets('Deve exibir link para login', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AlreadyHaveAccount), findsOneWidget);
    });
  });

  group('SignupPage - Regras de Validação Visual', () {
    testWidgets('Deve exibir mensagem de erro para nome',
        (WidgetTester tester) async {
      when(() => presenter.nameErrorStream)
          .thenAnswer((_) => Stream.value('Nome obrigatório'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Nome obrigatório'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para email',
        (WidgetTester tester) async {
      when(() => presenter.emailErrorStream)
          .thenAnswer((_) => Stream.value('E-mail obrigatório'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('E-mail obrigatório'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para telefone',
        (WidgetTester tester) async {
      when(() => presenter.phoneErrorStream)
          .thenAnswer((_) => Stream.value('Telefone obrigatório'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Telefone obrigatório'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para senha',
        (WidgetTester tester) async {
      when(() => presenter.passwordErrorStream)
          .thenAnswer((_) => Stream.value('Senha obrigatória'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Senha obrigatória'), findsOneWidget);
    });
  });

  group('SignupPage - Regras de Interação', () {
    testWidgets('Deve validar nome em tempo real', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final nameField = find.byType(TextFormField).first;
      await tester.enterText(nameField, 'Jo');

      verify(() => presenter.validateName('Jo')).called(1);
    });

    testWidgets('Deve validar email em tempo real',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final emailField = find.byType(TextFormField).at(1);
      await tester.enterText(emailField, 'test@');

      verify(() => presenter.validateEmail('test@')).called(1);
    });

    testWidgets('Deve validar telefone em tempo real',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final phoneField = find.byType(TextFormField).at(2);
      await tester.enterText(phoneField, '119');

      verify(() => presenter.validatePhone('119')).called(1);
    });

    testWidgets('Deve validar senha em tempo real',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final passwordField = find.byType(TextFormField).at(3);
      await tester.enterText(passwordField, '123');

      verify(() => presenter.validatePassword('123')).called(1);
    });
  });

  group('SignupPage - Regras de Estado de Loading', () {
    testWidgets('Deve exibir indicador de loading durante cadastro',
        (WidgetTester tester) async {
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(true));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('SignupPage - Regras de Tratamento de Erro', () {
    testWidgets('Deve exibir "E-mail já está em uso"',
        (WidgetTester tester) async {
      when(() => presenter.emailErrorStream)
          .thenAnswer((_) => Stream.value('E-mail já está em uso'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('E-mail já está em uso'), findsOneWidget);
    });

    testWidgets('Deve exibir "Senha muito fraca"', (WidgetTester tester) async {
      when(() => presenter.passwordErrorStream)
          .thenAnswer((_) => Stream.value('Senha muito fraca'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Senha muito fraca'), findsOneWidget);
    });
  });

  group('SignupPage - Regras de Acessibilidade', () {
    testWidgets('Deve ter campos de entrada acessíveis',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('Deve ter botões acessíveis', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ButtonSignup), findsOneWidget);
      expect(find.byType(ButtonGoogle), findsOneWidget);
    });
  });

  group('SignupPage - Regras de Responsividade', () {
    testWidgets('Deve ter scroll adequado', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('SignupPage - Testes de Integração', () {
    testWidgets('Deve executar fluxo básico de preenchimento',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Preencher formulário
      final nameField = find.byType(TextFormField).first;
      final emailField = find.byType(TextFormField).at(1);
      final passwordField = find.byType(TextFormField).at(3);

      await tester.enterText(nameField, 'João Silva');
      await tester.enterText(emailField, 'joao@example.com');
      await tester.enterText(passwordField, 'Senha123!');

      // Verificar que os campos foram preenchidos
      expect(find.text('João Silva'), findsOneWidget);
      expect(find.text('joao@example.com'), findsOneWidget);
      expect(find.text('Senha123!'), findsOneWidget);
    });

    testWidgets('Deve ter todos os componentes necessários',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Verificar presença de todos os componentes principais
      expect(find.byType(NameInput), findsOneWidget);
      expect(find.byType(EmailInput), findsOneWidget);
      expect(find.byType(PhoneInput), findsOneWidget);
      expect(find.byType(PasswordInput), findsOneWidget);
      expect(find.byType(ButtonSignup), findsOneWidget);
      expect(find.byType(ButtonGoogle), findsOneWidget);
      expect(find.byType(AlreadyHaveAccount), findsOneWidget);
      expect(find.byType(MainErrorDisplay), findsOneWidget);
    });
  });
}
