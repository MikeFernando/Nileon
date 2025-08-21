import 'package:nileon/presentation/protocols/validations.dart';

class EmailValidation implements Validation {
  final String fieldName;

  EmailValidation(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field != fieldName) return '';

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    // Regex para validar email
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }

    return '';
  }
}
