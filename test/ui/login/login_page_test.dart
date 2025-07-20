import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd_clean_architecture/ui/components/components.dart';
import 'package:flutter_tdd_clean_architecture/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  late LoginPresenterSpy presenter;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Deve apresentar LoginPage com estado inicial correto',
      (tester) async {
    await loadPage(tester);

    final emailChildrenText = find.descendant(
      of: find.bySemanticsLabel('Email'),
      matching: find.byType(Text),
    );

    final passwordChildrenText = find.descendant(
      of: find.bySemanticsLabel('Senha'),
      matching: find.byType(Text),
    );

    expect(
      emailChildrenText,
      findsOneWidget,
      reason:
          'quando um TextFormField tem apenas um filho de texto, significa que não há erros, já que um dos filhos é sempre o texto do label',
    );
    expect(
      passwordChildrenText,
      findsOneWidget,
      reason:
          'quando um TextFormField tem apenas um filho de texto, significa que não há erros, já que um dos filhos é sempre o texto do label',
    );

    final button = tester.widget<Button>(find.byType(Button));

    expect(button.enabled, isFalse);
  });

  testWidgets('Deve chamar o validate com os dados corretos', (tester) async {
    await loadPage(tester);

    final button = find.byType(Button);
    await tester.tap(button);
  });

  testWidgets(
      'Deve chamar o presenter validateEmail e validatePassword quando o usuário digitar no campo Email e Senha',
      (tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);

    verify(presenter.validateEmail(email));
    verify(presenter.validatePassword(password));
  });
}
