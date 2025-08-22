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

    // Remove espaços extras
    final cleanName = value.trim();

    // Validação de comprimento mínimo
    if (cleanName.length < 2) {
      return 'Nome deve ter pelo menos 2 caracteres';
    }

    // Validação de comprimento máximo
    if (cleanName.length > 100) {
      return 'Nome deve ter no máximo 100 caracteres';
    }

    // Validação de caracteres válidos (apenas letras e espaços)
    final nameRegex = RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');
    if (!nameRegex.hasMatch(cleanName)) {
      return 'Nome deve conter apenas letras';
    }

    // Validação de pelo menos duas palavras (nome e sobrenome)
    final words =
        cleanName.split(' ').where((word) => word.isNotEmpty).toList();
    if (words.length < 2) {
      return 'Digite nome e sobrenome';
    }

    return '';
  }
}
