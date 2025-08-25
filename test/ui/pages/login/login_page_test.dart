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

  void setupPresenterMocks({
    Stream<bool>? isLoadingStream,
    Stream<bool>? isFormValidStream,
  }) {
    when(() => presenter.emailErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.passwordErrorStream)
        .thenAnswer((_) => Stream.value(null));
    when(() => presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidStream ?? Stream.value(false));
    when(() => presenter.isLoadingStream)
        .thenAnswer((_) => isLoadingStream ?? Stream.value(false));
    when(() => presenter.mainErrorStream).thenAnswer((_) => Stream.value(null));
    when(() => presenter.emailErrorDisplayStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.passwordErrorDisplayStream)
        .thenAnswer((_) => Stream.value(false));
    when(() => presenter.emailController).thenReturn(TextEditingController());
    when(() => presenter.passwordController)
        .thenReturn(TextEditingController());
    when(() => presenter.emailFocusNode).thenReturn(FocusNode());
    when(() => presenter.passwordFocusNode).thenReturn(FocusNode());
    when(() => presenter.dispose()).thenAnswer((_) {});
  }

  testWidgets('Deve chamar o presenter ao iniciar a página',
      (WidgetTester tester) async {
    setupPresenterMocks(
      isLoadingStream: Stream.fromIterable([false, true, false]),
    );

    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(presenter: presenter),
      ),
    );

    expect(presenter.isLoadingStream, emitsInOrder([false, true, false]));
  });

  testWidgets('Deve renderizar o ButtonRegister na página',
      (WidgetTester tester) async {
    setupPresenterMocks();

    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(presenter: presenter),
      ),
    );

    expect(find.byType(ButtonRegister), findsOneWidget);
  });

  testWidgets('Deve chamar a função onTap ao clicar no ButtonRegister',
      (WidgetTester tester) async {
    bool onTapCalled = false;
    void onTap() {
      onTapCalled = true;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonRegister(onTap: onTap),
        ),
      ),
    );

    await tester.tap(find.byType(GestureDetector), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(onTapCalled, isTrue);
  });

  testWidgets(
      'Deve navegar para a tela de SignUp ao clicar no botão ButtonRegister',
      (WidgetTester tester) async {
    setupPresenterMocks();

    await tester.pumpWidget(
      GetMaterialApp(
        getPages: [
          GetPage(
              name: '/signup',
              page: () => const Scaffold(body: Text('Signup Page'))),
        ],
        home: LoginPage(presenter: presenter),
      ),
    );

    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.byType(ButtonRegister), findsOneWidget);

    final buttonRegister = find.byType(ButtonRegister);
    final gestureDetector = find.descendant(
      of: buttonRegister,
      matching: find.byType(GestureDetector),
    );

    await tester.tap(gestureDetector, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/signup');
  });
}
