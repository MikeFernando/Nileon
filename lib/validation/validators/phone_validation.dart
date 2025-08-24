import 'package:nileon/presentation/protocols/validations.dart';

class PhoneValidation implements Validation {
  final String fieldName;

  PhoneValidation(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field != fieldName) return '';

    if (value.isEmpty || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }

    // Remove todos os caracteres não numéricos
    final cleanPhone = value.replaceAll(RegExp(r'[^\d]'), '');

    // Validação para telefone brasileiro
    // Deve ter exatamente 11 dígitos (2 DDD + 9 números)
    if (cleanPhone.length != 11) {
      return 'Telefone inválido';
    }

    // Validação de DDD brasileiro (11 a 99)
    final ddd = int.tryParse(cleanPhone.substring(0, 2));
    if (ddd == null || ddd < 11 || ddd > 99) {
      return 'DDD inválido';
    }

    // Validação do número do telefone (deve ter exatamente 9 dígitos)
    final phoneNumber = cleanPhone.substring(2);
    if (phoneNumber.length != 9) {
      return 'Número de telefone inválido';
    }

    return '';
  }
}
