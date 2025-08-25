import 'package:nileon/presentation/protocols/validations.dart';

enum PasswordStrength {
  weak,
  medium,
  strong,
}

class PasswordValidation implements Validation {
  final String fieldName;

  PasswordValidation(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field != fieldName) return '';

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    final strength = getPasswordStrength(value);

    // Bloquear senhas fracas
    if (strength == PasswordStrength.weak) {
      return 'Senha muito fraca. Use pelo menos 8 caracteres com letras, números e símbolos.';
    }

    return '';
  }

  /// Retorna a força da senha baseada nas novas regras
  PasswordStrength getPasswordStrength(String value) {
    // Verificar se é fraca (não permitir)
    if (_isWeakPassword(value)) {
      return PasswordStrength.weak;
    }

    // Verificar se é forte (recomendar)
    if (_isStrongPassword(value)) {
      return PasswordStrength.strong;
    }

    // Se não é fraca nem forte, é média (permitir, mas avisar)
    return PasswordStrength.medium;
  }

  /// Verifica se a senha é fraca (não permitir)
  bool _isWeakPassword(String value) {
    // Menos de 8 caracteres
    if (value.length < 8) {
      return true;
    }

    // Apenas letras minúsculas
    if (RegExp(r'^[a-z]+$').hasMatch(value)) {
      return true;
    }

    // Apenas números
    if (RegExp(r'^[0-9]+$').hasMatch(value)) {
      return true;
    }

    // Apenas letras maiúsculas
    if (RegExp(r'^[A-Z]+$').hasMatch(value)) {
      return true;
    }

    // Sequências óbvias
    if (_hasObviousSequences(value)) {
      return true;
    }

    return false;
  }

  /// Verifica se a senha é forte (recomendar)
  bool _isStrongPassword(String value) {
    // Pelo menos 12 caracteres
    if (value.length < 12) return false;

    // Contém pelo menos 3 categorias
    int categories = 0;
    if (RegExp(r'[A-Z]').hasMatch(value)) categories++;
    if (RegExp(r'[a-z]').hasMatch(value)) categories++;
    if (RegExp(r'[0-9]').hasMatch(value)) categories++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) categories++;

    return categories >= 3;
  }

  /// Verifica se contém sequências óbvias
  bool _hasObviousSequences(String value) {
    final obviousSequences = [
      '123456',
      '1234567',
      '12345678',
      '123456789',
      '1234567890',
      'abcdef',
      'abcdefg',
      'abcdefgh',
      'qwerty',
      'qwertyu',
      'qwertyui',
      'password',
      'senha',
      'admin',
      'user',
      'test',
    ];

    final lowerValue = value.toLowerCase();

    // Se a senha tem pelo menos 12 caracteres e 3 categorias, não considerar óbvia
    if (value.length >= 12) {
      int categories = 0;
      if (RegExp(r'[A-Z]').hasMatch(value)) categories++;
      if (RegExp(r'[a-z]').hasMatch(value)) categories++;
      if (RegExp(r'[0-9]').hasMatch(value)) categories++;
      if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) categories++;
      if (categories >= 3) {
        return false;
      }
    }

    // Só considerar sequência óbvia se for uma parte significativa da senha
    for (final sequence in obviousSequences) {
      if (lowerValue.contains(sequence)) {
        // Se a sequência é muito longa em relação à senha, considerar óbvia
        if (sequence.length >= value.length * 0.4) {
          return true;
        }
        // Para palavras comuns como 'senha', 'password', considerar óbvia se presente
        if (['senha', 'password', 'admin', 'user', 'test'].contains(sequence)) {
          return true;
        }
      }
    }
    return false;
  }

  /// Retorna a mensagem de força da senha
  String getStrengthMessage(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 'Senha fraca';
      case PasswordStrength.medium:
        return 'Senha média';
      case PasswordStrength.strong:
        return 'Senha forte';
    }
  }

  /// Retorna a cor da força da senha
  int getStrengthColor(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0xFFF14141; // AppColors.error
      case PasswordStrength.medium:
        return 0xFFFFD33C; // AppColors.warning
      case PasswordStrength.strong:
        return 0xFF50CD89; // AppColors.success
    }
  }

  /// Retorna a porcentagem de força da senha (0-100)
  double getStrengthPercentage(PasswordStrength strength) {
    switch (strength) {
      case PasswordStrength.weak:
        return 0.33;
      case PasswordStrength.medium:
        return 0.66;
      case PasswordStrength.strong:
        return 1.0;
    }
  }

  // Método para obter o status de cada regra individualmente
  Map<String, bool> getPasswordRulesStatus(String value) {
    return {
      'minLength': value.length >= 8,
      'strongLength': value.length >= 12,
      'uppercase': RegExp(r'[A-Z]').hasMatch(value),
      'lowercase': RegExp(r'[a-z]').hasMatch(value),
      'number': RegExp(r'[0-9]').hasMatch(value),
      'special': RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value),
      'noObviousSequences': !_hasObviousSequences(value),
    };
  }

  // Método para obter as mensagens das regras
  Map<String, String> getPasswordRulesMessages() {
    return {
      'minLength': 'Mínimo 8 caracteres',
      'strongLength': 'Recomendado 12+ caracteres',
      'uppercase': 'Pelo menos uma letra maiúscula',
      'lowercase': 'Pelo menos uma letra minúscula',
      'number': 'Pelo menos um número',
      'special': 'Pelo menos um caractere especial',
      'noObviousSequences': 'Evitar sequências óbvias',
    };
  }
}
