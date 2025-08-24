import 'package:nileon/presentation/protocols/validations.dart';

class PasswordValidation implements Validation {
  final String fieldName;

  PasswordValidation(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field != fieldName) return '';

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    if (value.length < 8) {
      return 'Senha deve ter pelo menos 8 caracteres';
    }

    // Verificar se tem pelo menos uma letra maiúscula
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Senha deve conter pelo menos uma letra maiúscula';
    }

    // Verificar se tem pelo menos uma letra minúscula
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Senha deve conter pelo menos uma letra minúscula';
    }

    // Verificar se tem pelo menos um número
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Senha deve conter pelo menos um número';
    }

    // Verificar se tem pelo menos um caractere especial
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Senha deve conter pelo menos um caractere especial';
    }

    return '';
  }

  // Método para obter o status de cada regra individualmente
  Map<String, bool> getPasswordRulesStatus(String value) {
    return {
      'minLength': value.length >= 8,
      'uppercase': RegExp(r'[A-Z]').hasMatch(value),
      'lowercase': RegExp(r'[a-z]').hasMatch(value),
      'number': RegExp(r'[0-9]').hasMatch(value),
      'special': RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value),
    };
  }

  // Método para obter as mensagens das regras
  Map<String, String> getPasswordRulesMessages() {
    return {
      'minLength': 'Mínimo 8 caracteres',
      'uppercase': 'Pelo menos uma letra maiúscula',
      'lowercase': 'Pelo menos uma letra minúscula',
      'number': 'Pelo menos um número',
      'special': 'Pelo menos um caractere especial',
    };
  }
}
