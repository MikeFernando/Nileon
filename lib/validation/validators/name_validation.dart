import 'package:nileon/presentation/protocols/validations.dart';

class NameValidation implements Validation {
  final String fieldName;

  NameValidation(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field != fieldName) return '';

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    final cleanName = value.trim();

    if (cleanName.length < 3) {
      return 'Nome deve ter pelo menos 3 caracteres';
    }

    if (cleanName.length > 100) {
      return 'Nome deve ter no máximo 100 caracteres';
    }

    final nameRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    if (!nameRegex.hasMatch(cleanName)) {
      return 'Nome deve conter apenas letras';
    }

    return '';
  }
}
