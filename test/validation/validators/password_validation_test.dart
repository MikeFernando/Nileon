import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/validators/password_validation.dart';

void main() {
  late PasswordValidation sut;

  setUp(() {
    sut = PasswordValidation('password');
  });

  group('PasswordValidation - Validação Básica', () {
    test('Deve retornar string vazia se a senha for válida', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!');
      expect(error, '');
    });

    test('Deve retornar erro se a senha for vazia', () {
      final error = sut.validate(field: 'password', value: '');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar erro se a senha tiver apenas espaços', () {
      final error = sut.validate(field: 'password', value: '   ');
      expect(error, 'Campo obrigatório');
    });

    test('Deve retornar string vazia se o campo não for password', () {
      final error = sut.validate(field: 'email', value: 'short');
      expect(error, '');
    });
  });

  group('PasswordValidation - Senhas Fracas (NÃO PERMITIR)', () {
    test('Deve bloquear senha com menos de 8 caracteres', () {
      final error = sut.validate(field: 'password', value: 'Abc123!');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha apenas com letras minúsculas', () {
      final error = sut.validate(field: 'password', value: 'abcdefgh');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha apenas com números', () {
      final error = sut.validate(field: 'password', value: '12345678');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha apenas com letras maiúsculas', () {
      final error = sut.validate(field: 'password', value: 'ABCDEFGH');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha com sequência óbvia 123456', () {
      final error = sut.validate(field: 'password', value: 'abc123456def');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha com sequência óbvia abcdef', () {
      final error = sut.validate(field: 'password', value: 'testabcdef123');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha com palavra óbvia password', () {
      final error = sut.validate(field: 'password', value: 'mypassword123');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });

    test('Deve bloquear senha com palavra óbvia senha', () {
      final error = sut.validate(field: 'password', value: 'minhasenha123');
      expect(error,
          'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.');
    });
  });

  group('PasswordValidation - Senhas Médias (PERMITIR, MAS AVISAR)', () {
    test('Deve permitir senha média com 8 caracteres e 2 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass');
      expect(error, '');
    });

    test('Deve permitir senha média com 10 caracteres e 2 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass12');
      expect(error, '');
    });

    test('Deve permitir senha média com 11 caracteres e 2 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123');
      expect(error, '');
    });

    test('Deve permitir senha média com letras e números', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123');
      expect(error, '');
    });

    test('Deve permitir senha média com letras e símbolos', () {
      final error = sut.validate(field: 'password', value: 'ValidPass!@#');
      expect(error, '');
    });
  });

  group('PasswordValidation - Senhas Fortes (RECOMENDAR)', () {
    test('Deve permitir senha forte com 12 caracteres e 3 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!');
      expect(error, '');
    });

    test('Deve permitir senha forte com 15 caracteres e 3 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!@#');
      expect(error, '');
    });

    test('Deve permitir senha forte com 4 categorias', () {
      final error = sut.validate(field: 'password', value: 'ValidPass123!@#');
      expect(error, '');
    });
  });

  group('PasswordValidation - Análise de Força', () {
    test('Deve identificar senha fraca corretamente', () {
      expect(sut.getPasswordStrength('abc123'), PasswordStrength.weak);
      expect(sut.getPasswordStrength('12345678'), PasswordStrength.weak);
      expect(sut.getPasswordStrength('abcdefgh'), PasswordStrength.weak);
      expect(sut.getPasswordStrength('ABCDEFGH'), PasswordStrength.weak);
      expect(sut.getPasswordStrength('abc123456def'), PasswordStrength.weak);
    });

    test('Deve identificar senha média corretamente', () {
      expect(sut.getPasswordStrength('ValidPass'), PasswordStrength.medium);
      expect(sut.getPasswordStrength('ValidPass12'), PasswordStrength.medium);
      expect(sut.getPasswordStrength('ValidPass!@'), PasswordStrength.medium);
    });

    test('Deve identificar senha forte corretamente', () {
      expect(sut.getPasswordStrength('ValidPass123!'), PasswordStrength.strong);
      expect(
          sut.getPasswordStrength('ValidPass123!@#'), PasswordStrength.strong);
      expect(sut.getPasswordStrength('MySecurePassword123!'),
          PasswordStrength.strong);
    });
  });

  group('PasswordValidation - Mensagens de Força', () {
    test('Deve retornar mensagem correta para senha fraca', () {
      expect(sut.getStrengthMessage(PasswordStrength.weak), 'Senha fraca');
    });

    test('Deve retornar mensagem correta para senha média', () {
      expect(sut.getStrengthMessage(PasswordStrength.medium), 'Senha média');
    });

    test('Deve retornar mensagem correta para senha forte', () {
      expect(sut.getStrengthMessage(PasswordStrength.strong), 'Senha forte');
    });
  });

  group('PasswordValidation - Cores de Força', () {
    test('Deve retornar cor vermelha para senha fraca', () {
      expect(sut.getStrengthColor(PasswordStrength.weak), 0xFFF14141);
    });

    test('Deve retornar cor laranja para senha média', () {
      expect(sut.getStrengthColor(PasswordStrength.medium), 0xFFFFD33C);
    });

    test('Deve retornar cor verde para senha forte', () {
      expect(sut.getStrengthColor(PasswordStrength.strong), 0xFF50CD89);
    });
  });

  group('PasswordValidation - Porcentagem de Força', () {
    test('Deve retornar 33% para senha fraca', () {
      expect(sut.getStrengthPercentage(PasswordStrength.weak), 0.33);
    });

    test('Deve retornar 66% para senha média', () {
      expect(sut.getStrengthPercentage(PasswordStrength.medium), 0.66);
    });

    test('Deve retornar 100% para senha forte', () {
      expect(sut.getStrengthPercentage(PasswordStrength.strong), 1.0);
    });
  });

  group('PasswordValidation - Regras de Senha', () {
    test('Deve retornar status correto das regras para senha válida', () {
      final rules = sut.getPasswordRulesStatus('ValidPass123!');
      expect(rules['minLength'], true);
      expect(rules['strongLength'], true);
      expect(rules['uppercase'], true);
      expect(rules['lowercase'], true);
      expect(rules['number'], true);
      expect(rules['special'], true);
      expect(rules['noObviousSequences'], true);
    });

    test('Deve retornar mensagens corretas das regras', () {
      final messages = sut.getPasswordRulesMessages();
      expect(messages['minLength'], 'Mínimo 8 caracteres');
      expect(messages['strongLength'], 'Recomendado 12+ caracteres');
      expect(messages['uppercase'], 'Pelo menos uma letra maiúscula');
      expect(messages['lowercase'], 'Pelo menos uma letra minúscula');
      expect(messages['number'], 'Pelo menos um número');
      expect(messages['special'], 'Pelo menos um caractere especial');
      expect(messages['noObviousSequences'], 'Evitar sequências óbvias');
    });
  });

  group('PasswordValidation - Debug Tests', () {
    test('Deve detectar senha forte corretamente e retornar cor verde', () {
      final testPassword = 'ValidPass123!';
      final strength = sut.getPasswordStrength(testPassword);
      final color = sut.getStrengthColor(strength);
      final percentage = sut.getStrengthPercentage(strength);

      // Testando senha: $testPassword
      // Força detectada: $strength
      // Cor retornada: ${color.toRadixString(16)}
      // Porcentagem: $percentage

      expect(strength, PasswordStrength.strong);
      expect(color, 0xFF50CD89); // AppColors.success
      expect(percentage, 1.0);
    });

    test('Deve detectar senha forte com 4 categorias', () {
      final testPassword = 'MySecurePassword123!';
      final strength = sut.getPasswordStrength(testPassword);
      final color = sut.getStrengthColor(strength);

      // Testando senha: $testPassword
      // Força detectada: $strength
      // Cor retornada: ${color.toRadixString(16)}

      expect(strength, PasswordStrength.strong);
      expect(color, 0xFF50CD89); // AppColors.success
    });

    test('Deve detectar senha forte Riocard@123underline', () {
      final testPassword = 'Riocard@123underline';
      final strength = sut.getPasswordStrength(testPassword);
      final color = sut.getStrengthColor(strength);
      final percentage = sut.getStrengthPercentage(strength);

      // Testando senha: $testPassword
      // Comprimento: ${testPassword.length}
      // Tem maiúscula: ${RegExp(r'[A-Z]').hasMatch(testPassword)}
      // Tem minúscula: ${RegExp(r'[a-z]').hasMatch(testPassword)}
      // Tem número: ${RegExp(r'[0-9]').hasMatch(testPassword)}
      // Tem especial: ${RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(testPassword)}
      // Força detectada: $strength
      // Cor retornada: ${color.toRadixString(16)}
      // Porcentagem: $percentage

      expect(strength, PasswordStrength.strong);
      expect(color, 0xFF50CD89); // AppColors.success
      expect(percentage, 1.0);
    });
  });
}
