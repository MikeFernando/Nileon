import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nileon/ui/pages/login/login_page.dart';
import 'package:nileon/ui/pages/login/login_presenter.dart';
import 'package:nileon/ui/pages/login/components/button_register.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenterSpy presenter;

  setUp(() {
    presenter = LoginPresenterSpy();
  });

  testWidgets('Deve chamar o presenter ao iniciar a página',
      (WidgetTester tester) async {
    // Arrange
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => Stream.fromIterable([false, true, false]));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.dispose()).thenAnswer((_) {});

    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(presenter: presenter),
      ),
    );

    // Assert
    expect(presenter.isLoadingStream, emitsInOrder([false, true, false]));
  });

  testWidgets('Deve renderizar o ButtonRegister na página',
      (WidgetTester tester) async {
    // Arrange
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.dispose()).thenAnswer((_) {});

    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(presenter: presenter),
      ),
    );

    // Assert
    expect(find.byType(ButtonRegister), findsOneWidget);
  });

  testWidgets('Deve chamar a função onTap ao clicar no ButtonRegister',
      (WidgetTester tester) async {
    // Arrange
    bool onTapCalled = false;
    void onTap() {
      onTapCalled = true;
    }

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonRegister(onTap: onTap),
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector), warnIfMissed: false);
    await tester.pumpAndSettle();

    // Assert
    expect(onTapCalled, isTrue);
  });

  testWidgets(
      'Deve navegar para a tela de add account ao clicar no botão ButtonRegister',
      (WidgetTester tester) async {
    // Arrange
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.dispose()).thenAnswer((_) {});

    // Act
    await tester.pumpWidget(
      GetMaterialApp(
        getPages: [
          GetPage(
              name: '/add_account',
              page: () => const Scaffold(body: Text('Add Account Page'))),
        ],
        home: LoginPage(presenter: presenter),
      ),
    );

    // Scroll para garantir que o ButtonRegister esteja visível
    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Verificar se o ButtonRegister está visível antes de clicar
    expect(find.byType(ButtonRegister), findsOneWidget);

    // Encontrar o GestureDetector dentro do ButtonRegister
    final buttonRegister = find.byType(ButtonRegister);
    final gestureDetector = find.descendant(
      of: buttonRegister,
      matching: find.byType(GestureDetector),
    );

    await tester.tap(gestureDetector, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Assert - verificar se a navegação foi chamada
    expect(Get.currentRoute, '/add_account');
  });
}
