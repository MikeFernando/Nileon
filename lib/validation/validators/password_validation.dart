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

    return '';
  }
}
