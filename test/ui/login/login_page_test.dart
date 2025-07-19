import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tdd_clean_architecture/ui/components/button.dart';
import 'package:flutter_tdd_clean_architecture/ui/pages/login_page.dart';

void main() {
  testWidgets('Should LoginPage wiht correct initial state', (tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

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
          'when a TextFormField has only one text child, means it has no errors, since one of the children is always the label text',
    );
    expect(
      passwordChildrenText,
      findsOneWidget,
      reason:
          'when a TextFormField has only one text child, means it has no errors, since one of the children is always the label text',
    );

    final button = tester.widget<Button>(find.byType(Button));

    expect(button.enabled, isFalse);
  });
}
