import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/ui/components/password_strength_indicator.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  group('PasswordStrengthIndicator', () {
    late PasswordValidation validation;

    setUp(() {
      validation = PasswordValidation('password');
    });

    testWidgets('Deve exibir barra vermelha para senha fraca', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'abc123',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a mensagem está correta
      expect(find.text('Senha fraca'), findsOneWidget);

      // Verificar se a cor está sendo aplicada (vermelho)
      final textWidget = tester.widget<Text>(find.text('Senha fraca'));
      expect(textWidget.style?.color, const Color(0xFFF14141));
    });

    testWidgets('Deve exibir barra laranja para senha média', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'ValidPass',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a mensagem está correta
      expect(find.text('Senha média - pode melhorar'), findsOneWidget);

      // Verificar se a cor está sendo aplicada (laranja)
      final textWidget =
          tester.widget<Text>(find.text('Senha média - pode melhorar'));
      expect(textWidget.style?.color, const Color(0xFFFFD33C));
    });

    testWidgets('Deve exibir barra verde para senha forte', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'ValidPass123!',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a mensagem está correta
      expect(find.text('Senha forte'), findsOneWidget);

      // Verificar se a cor está sendo aplicada (verde)
      final textWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(textWidget.style?.color, const Color(0xFF50CD89));
    });

    testWidgets('Deve ocultar indicador quando senha estiver vazia',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: '',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se o indicador não está visível
      expect(find.byType(Container), findsNothing);
    });

    testWidgets(
        'Deve mostrar barra de progresso com largura correta para senha forte',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'ValidPass123!',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a barra de progresso está presente
      expect(find.byType(FractionallySizedBox), findsOneWidget);

      // Verificar se a largura está correta para senha forte (100%)
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 1.0);
    });

    testWidgets('Deve mostrar cores corretas para diferentes forças de senha',
        (tester) async {
      // Teste para senha fraca
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'abc123',
              validation: validation,
            ),
          ),
        ),
      );
      expect(find.text('Senha fraca'), findsOneWidget);
      final weakTextWidget = tester.widget<Text>(find.text('Senha fraca'));
      expect(weakTextWidget.style?.color, const Color(0xFFF14141)); // Vermelho

      // Teste para senha média
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'ValidPass',
              validation: validation,
            ),
          ),
        ),
      );
      expect(find.text('Senha média - pode melhorar'), findsOneWidget);
      final mediumTextWidget =
          tester.widget<Text>(find.text('Senha média - pode melhorar'));
      expect(mediumTextWidget.style?.color, const Color(0xFFFFD33C)); // Laranja

      // Teste para senha forte
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'ValidPass123!',
              validation: validation,
            ),
          ),
        ),
      );
      expect(find.text('Senha forte'), findsOneWidget);
      final strongTextWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(strongTextWidget.style?.color, const Color(0xFF50CD89)); // Verde
    });
  });
}
