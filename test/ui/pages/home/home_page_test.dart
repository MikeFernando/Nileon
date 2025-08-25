import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nileon/ui/pages/home/home_page.dart';

void main() {
  group('HomePage', () {
    testWidgets('Deve exibir mensagem de sucesso', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('Cadastro realizado com sucesso!'), findsOneWidget);
      expect(find.text('Bem-vindo ao Nileon!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('Deve ter AppBar com título Nileon',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('Nileon'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });
  });
}
