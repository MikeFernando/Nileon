import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/ui/utils/phone_formatter.dart';

void main() {
  group('PhoneFormatter', () {
    group('format', () {
      test('deve retornar string vazia para texto vazio', () {
        final result = PhoneFormatter.format('');
        expect(result, '');
      });

      test('deve retornar string vazia para texto sem números', () {
        final result = PhoneFormatter.format('abc');
        expect(result, '');
      });

      test('deve formatar DDD apenas', () {
        final result = PhoneFormatter.format('11');
        expect(result, '11');
      });

      test('deve formatar DDD + início do número', () {
        final result = PhoneFormatter.format('119999');
        expect(result, '(11) 9999');
      });

      test('deve formatar telefone com 10 dígitos', () {
        final result = PhoneFormatter.format('1199999999');
        expect(result, '(11) 9999-9999');
      });

      test('deve formatar telefone com 11 dígitos', () {
        final result = PhoneFormatter.format('11999999999');
        expect(result, '(11) 99999-9999');
      });

      test('deve formatar telefone com caracteres especiais', () {
        final result = PhoneFormatter.format('11-99999-9999');
        expect(result, '(11) 99999-9999');
      });

      test('deve formatar telefone com espaços', () {
        final result = PhoneFormatter.format('11 99999 9999');
        expect(result, '(11) 99999-9999');
      });
    });

    group('unformat', () {
      test('deve remover formatação de telefone', () {
        final result = PhoneFormatter.unformat('(11) 99999-9999');
        expect(result, '11999999999');
      });

      test('deve remover formatação de telefone com 10 dígitos', () {
        final result = PhoneFormatter.unformat('(11) 9999-9999');
        expect(result, '1199999999');
      });

      test('deve retornar apenas números de texto misto', () {
        final result = PhoneFormatter.unformat('abc11def99999ghi9999');
        expect(result, '11999999999');
      });

      test('deve retornar string vazia para texto sem números', () {
        final result = PhoneFormatter.unformat('abc');
        expect(result, '');
      });
    });

    group('isFullyFormatted', () {
      test('deve retornar true para telefone com 11 dígitos formatado', () {
        final result = PhoneFormatter.isFullyFormatted('(11) 99999-9999');
        expect(result, true);
      });

      test('deve retornar false para telefone com 10 dígitos', () {
        final result = PhoneFormatter.isFullyFormatted('(11) 9999-9999');
        expect(result, false);
      });

      test('deve retornar false para telefone com 12 dígitos', () {
        final result = PhoneFormatter.isFullyFormatted('(11) 999999-9999');
        expect(result, false);
      });

      test('deve retornar false para string vazia', () {
        final result = PhoneFormatter.isFullyFormatted('');
        expect(result, false);
      });

      test('deve retornar false para texto sem números', () {
        final result = PhoneFormatter.isFullyFormatted('abc');
        expect(result, false);
      });
    });
  });
}
