import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_architecture/ui/components/button.dart';
import 'package:flutter_tdd_clean_architecture/ui/pages/login_page.dart';

void main() {
  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
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
}
