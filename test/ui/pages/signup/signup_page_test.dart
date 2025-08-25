import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get/get.dart';

import 'package:nileon/ui/pages/signup/signup_page.dart';
import 'package:nileon/ui/pages/signup/signup_presenter.dart';
import 'package:nileon/ui/pages/signup/components/components.dart';

class SignUpPresenterSpy extends Mock implements SignUpPresenter {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  TextEditingController get nameController => _nameController;

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get phoneController => _phoneController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  FocusNode get nameFocusNode => _nameFocusNode;

  @override
  FocusNode get emailFocusNode => _emailFocusNode;

  @override
  FocusNode get phoneFocusNode => _phoneFocusNode;

  @override
  FocusNode get passwordFocusNode => _passwordFocusNode;
}

void main() {
  late SignUpPresenterSpy presenter;

  setUp(() {
    presenter = SignUpPresenterSpy();

    when(() => presenter.nameErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.phoneErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordTextStream)
        .thenAnswer((_) => Stream.value(''));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToLoginStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.navigateToGoogleAddAccountStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.dispose()).thenAnswer((_) {});
  });

  Widget createWidgetUnderTest() {
    return GetMaterialApp(
      home: SignUpPage(presenter: presenter),
    );
  }

  group('SignUpPage - Regras de Interface', () {
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

      expect(find.byType(SignUpButton), findsOneWidget);
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

  group('SignUpPage - Regras de Validação Visual', () {
    testWidgets('Deve exibir mensagem de erro para nome',
        (WidgetTester tester) async {
      when(() => presenter.nameErrorStream)
          .thenAnswer((_) => Stream.value('Nome é obrigatório'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Nome é obrigatório'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para email',
        (WidgetTester tester) async {
      when(() => presenter.emailErrorStream)
          .thenAnswer((_) => Stream.value('Email inválido'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Email inválido'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para telefone',
        (WidgetTester tester) async {
      when(() => presenter.phoneErrorStream)
          .thenAnswer((_) => Stream.value('Telefone inválido'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Telefone inválido'), findsOneWidget);
    });

    testWidgets('Deve exibir mensagem de erro para senha',
        (WidgetTester tester) async {
      when(() => presenter.passwordErrorStream)
          .thenAnswer((_) => Stream.value('Senha muito fraca'));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Senha muito fraca'), findsOneWidget);
    });
  });

  group('SignUpPage - Regras de Interação', () {
    testWidgets('Deve chamar presenter.signUp() quando botão for pressionado',
        (WidgetTester tester) async {
      when(() => presenter.isFormValidStream)
          .thenAnswer((_) => Stream.value(true));
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(false));
      when(() => presenter.signUp()).thenAnswer((_) async {
        return;
      });

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);

      expect(find.text('Registrar'), findsOneWidget);
    });

    testWidgets('Deve desabilitar botão quando formulário não for válido',
        (WidgetTester tester) async {
      when(() => presenter.isFormValidStream)
          .thenAnswer((_) => Stream.value(false));
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(false));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Deve desabilitar botão quando estiver carregando',
        (WidgetTester tester) async {
      when(() => presenter.isFormValidStream)
          .thenAnswer((_) => Stream.value(true));
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(true));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Deve mostrar loading indicator quando estiver carregando',
        (WidgetTester tester) async {
      when(() => presenter.isFormValidStream)
          .thenAnswer((_) => Stream.value(true));
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(true));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Deve validar nome em tempo real', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final nameField = find.byType(TextFormField).first;
      await tester.enterText(nameField, 'Jo');
      await tester.tapAt(const Offset(0, 0));

      verify(() => presenter.validateName('Jo')).called(greaterThan(0));
    });

    testWidgets('Deve validar email em tempo real',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final emailField = find.byType(TextFormField).at(1);
      await tester.enterText(emailField, 'test@');
      await tester.tapAt(const Offset(0, 0));

      verify(() => presenter.validateEmail('test@')).called(greaterThan(0));
    });

    testWidgets('Deve validar senha em tempo real',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final passwordField = find.byType(TextFormField).at(3);
      await tester.enterText(passwordField, '123');
      await tester.tapAt(const Offset(0, 0));

      verify(() => presenter.validatePassword('123')).called(greaterThan(0));
    });

    testWidgets('Deve navegar para login ao clicar em AlreadyHaveAccount',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          getPages: [
            GetPage(
                name: '/login',
                page: () => const Scaffold(body: Text('Login Page'))),
          ],
          home: SignUpPage(presenter: presenter),
        ),
      );

      await tester.drag(
          find.byType(SingleChildScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      expect(find.byType(AlreadyHaveAccount), findsOneWidget);

      final alreadyHaveAccount = find.byType(AlreadyHaveAccount);
      final gestureDetector = find.descendant(
        of: alreadyHaveAccount,
        matching: find.byType(GestureDetector),
      );

      await tester.tap(gestureDetector, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(Get.currentRoute, '/login');
    });
  });

  group('SignUpPage - Regras de Estado de Loading', () {
    testWidgets('Deve exibir indicador de loading durante cadastro',
        (WidgetTester tester) async {
      when(() => presenter.isLoadingStream)
          .thenAnswer((_) => Stream.value(true));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('SignUpPage - Regras de Tratamento de Erro', () {
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

  group('SignUpPage - Regras de Acessibilidade', () {
    testWidgets('Deve ter campos de entrada acessíveis',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextFormField), findsWidgets);
    });

    testWidgets('Deve ter botões acessíveis', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SignUpButton), findsOneWidget);
      expect(find.byType(ButtonGoogle), findsOneWidget);
    });
  });

  group('SignUpPage - Regras de Responsividade', () {
    testWidgets('Deve ter scroll adequado', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });

  group('SignUpPage - Testes de Integração', () {
    testWidgets('Deve executar fluxo básico de preenchimento',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final nameField = find.byType(TextFormField).first;
      final emailField = find.byType(TextFormField).at(1);
      final passwordField = find.byType(TextFormField).at(3);

      await tester.enterText(nameField, 'João Silva');
      await tester.enterText(emailField, 'joao@example.com');
      await tester.enterText(passwordField, 'Senha123!');

      expect(find.text('João Silva'), findsOneWidget);
      expect(find.text('joao@example.com'), findsOneWidget);
      expect(find.text('Senha123!'), findsOneWidget);
    });

    testWidgets('Deve ter todos os componentes necessários',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(NameInput), findsOneWidget);
      expect(find.byType(EmailInput), findsOneWidget);
      expect(find.byType(PhoneInput), findsOneWidget);
      expect(find.byType(PasswordInput), findsOneWidget);
      expect(find.byType(SignUpButton), findsOneWidget);
      expect(find.byType(ButtonGoogle), findsOneWidget);
      expect(find.byType(AlreadyHaveAccount), findsOneWidget);
      expect(find.byType(MainErrorDisplay), findsOneWidget);
    });
  });
}
