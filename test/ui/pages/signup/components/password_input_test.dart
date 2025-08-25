import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/ui/components/password_strength_indicator.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  group('PasswordInput - PasswordStrengthIndicator Integration', () {
    late PasswordValidation validation;

    setUp(() {
      validation = PasswordValidation('password');
    });

    testWidgets('Deve mostrar barra verde para senha forte', (tester) async {
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

      // Verificar se a mensagem "Senha forte" está sendo exibida
      expect(find.text('Senha forte'), findsOneWidget);

      // Verificar se a cor está sendo aplicada corretamente
      final textWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(textWidget.style?.color, const Color(0xFF50CD89)); // Verde
    });

    testWidgets('Deve mostrar barra vermelha para senha fraca', (tester) async {
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

      // Verificar se a mensagem "Senha fraca" está sendo exibida
      expect(find.text('Senha fraca'), findsOneWidget);

      // Verificar se a cor está sendo aplicada corretamente
      final textWidget = tester.widget<Text>(find.text('Senha fraca'));
      expect(textWidget.style?.color, const Color(0xFFF14141)); // Vermelho
    });

    testWidgets('Deve mostrar barra laranja para senha média', (tester) async {
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

      // Verificar se a mensagem "Senha média" está sendo exibida
      expect(find.text('Senha média'), findsOneWidget);

      // Verificar se a cor está sendo aplicada corretamente
      final textWidget = tester.widget<Text>(find.text('Senha média'));
      expect(textWidget.style?.color, const Color(0xFFFFD33C)); // Laranja
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

    testWidgets(
        'DEBUG: Deve mostrar barra verde para senha forte com 4 categorias',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'MySecurePassword123!',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a mensagem "Senha forte" está sendo exibida
      expect(find.text('Senha forte'), findsOneWidget);

      // Verificar se a cor está sendo aplicada corretamente
      final textWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(textWidget.style?.color, const Color(0xFF50CD89)); // Verde

      // Verificar se a barra de progresso está com largura 100%
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 1.0);

      // DEBUG: Senha forte detectada corretamente com cor verde
    });

    testWidgets(
        'DEBUG: Deve mostrar barra verde para senha Riocard@123underline',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'Riocard@123underline',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se a mensagem "Senha forte" está sendo exibida
      expect(find.text('Senha forte'), findsOneWidget);

      // Verificar se a cor está sendo aplicada corretamente
      final textWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(textWidget.style?.color, const Color(0xFF50CD89)); // Verde

      // Verificar se a barra de progresso está com largura 100%
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 1.0);

      // DEBUG: Senha Riocard@123underline detectada corretamente como forte
    });

    testWidgets('Deve atualizar indicador de força quando senha muda',
        (tester) async {
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

      // Verificar se mostra senha fraca inicialmente
      expect(find.text('Senha fraca'), findsOneWidget);
      final weakTextWidget = tester.widget<Text>(find.text('Senha fraca'));
      expect(weakTextWidget.style?.color, const Color(0xFFF14141)); // Vermelho

      // Atualizar para senha forte
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PasswordStrengthIndicator(
              password: 'Riocard@123underline',
              validation: validation,
            ),
          ),
        ),
      );

      // Verificar se agora mostra senha forte
      expect(find.text('Senha forte'), findsOneWidget);
      final strongTextWidget = tester.widget<Text>(find.text('Senha forte'));
      expect(strongTextWidget.style?.color, const Color(0xFF50CD89)); // Verde

      // DEBUG: Indicador de força atualizado corretamente
    });
  });
}
