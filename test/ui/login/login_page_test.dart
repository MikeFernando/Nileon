import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nileon/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenter presenter;
  late StreamController<String?> emailErrorController;
  late StreamController<String?> passwordErrorController;
  late StreamController<bool> isFormValidController;
  late StreamController<bool> isLoadingController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String?>.broadcast();
    passwordErrorController = StreamController<String?>.broadcast();
    isFormValidController = StreamController<bool>.broadcast();
    isLoadingController = StreamController<bool>.broadcast();

    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);

    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);

    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);

    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingController.stream);

    // Inicializa os streams com valores padrão
    emailErrorController.add(null);
    passwordErrorController.add(null);
    isFormValidController.add(false);
    isLoadingController.add(false);

    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
  });

  testWidgets('Deve apresentar LoginPage com estado inicial correto',
      (tester) async {
    await loadPage(tester);

    // Verifica se os campos de email e senha estão presentes
    expect(find.byType(TextFormField), findsNWidgets(2));

    // Verifica se o botão de login está presente
    expect(find.text('Entrar'), findsOneWidget);

    // Verifica se não há loading no estado inicial
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verifica se não há mensagens de erro nos campos
    expect(find.text('any_error'), findsNothing);

    // Verifica se o botão está desabilitado (onPressed == null)
    final elevatedButton = find.byType(ElevatedButton);
    expect(elevatedButton, findsOneWidget);

    final buttonWidget = tester.widget<ElevatedButton>(elevatedButton);
    expect(buttonWidget.onPressed, isNull);
  });

  testWidgets(
      'Deve chamar o auth quando o botão Entrar estiver habilitado e for clicado',
      (tester) async {
    await loadPage(tester);

    // Habilita o formulário
    isFormValidController.add(true);
    await tester.pump();

    // Verifica se o botão está habilitado (onPressed não é null)
    final elevatedButton = find.byType(ElevatedButton);
    expect(elevatedButton, findsOneWidget);

    final buttonWidget = tester.widget<ElevatedButton>(elevatedButton);
    expect(buttonWidget.onPressed, isNotNull);

    // Clica no botão
    await tester.tap(elevatedButton);
    await tester.pump();

    // Verifica se o método auth foi chamado
    verify(() => presenter.auth()).called(1);
  });

  testWidgets(
      'Deve chamar o presenter validateEmail e validatePassword quando o usuário digitar no campo Email e Senha',
      (tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.byType(TextFormField).first, email);

    final password = faker.internet.password();
    await tester.enterText(find.byType(TextFormField).last, password);

    verify(() => presenter.validateEmail(email));
    verify(() => presenter.validatePassword(password));
  });

  testWidgets('Deve apresentar erro se o email ou senha for inválido',
      (tester) async {
    await loadPage(tester);

    emailErrorController.add('any_error');
    await tester.pump();

    passwordErrorController.add('any_error');
    await tester.pump();

    expect(find.text('any_error'), findsNWidgets(2));
  });

  testWidgets('Não deve apresentar erro se o email for válido', (tester) async {
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    expect(
      find.descendant(
        of: find.bySemanticsLabel('Digite seu email'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Não deve apresentar erro se o email estiver com um string vazia',
      (tester) async {
    await loadPage(tester);

    emailErrorController.add('');
    await tester.pump();

    expect(
      find.descendant(
        of: find.bySemanticsLabel('Digite seu email'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Deve mostrar mensagem de erro se a senha for inválida',
      (tester) async {
    await loadPage(tester);

    passwordErrorController.add('any_error');
    await tester.pump();

    expect(find.text('any_error'), findsOneWidget);
  });

  testWidgets(
      'Deve remover mensagem de erro se a senha for válida e não tiver erro',
      (tester) async {
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump();

    expect(find.text('any_error'), findsNothing);
  });

  testWidgets('Não deve apresentar erro se o senha estiver com um string vazia',
      (tester) async {
    await loadPage(tester);

    passwordErrorController.add('');
    await tester.pump();

    expect(
      find.descendant(
        of: find.bySemanticsLabel('Digite sua senha'),
        matching: find.byType(Text),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Deve habilitar o botão se o formulário for válido',
      (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    expect(button.onPressed, isNotNull);
  });

  testWidgets('Deve desabilitar o botão se o formulário for inválido',
      (tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));

    expect(button.onPressed, isNull);
  });

  testWidgets('Deve mostrar loading', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Deve esconder loading', (tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
      'Deve chamar o método de autenticar quando o botão for pressionado',
      (tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pump();

    verify(() => presenter.auth()).called(1);
  });

  testWidgets('Deve fechar streams quando a página for encerrada',
      (tester) async {
    await loadPage(tester);

    await tester.pumpWidget(const SizedBox());

    verify(() => presenter.dispose()).called(1);
  });
}
