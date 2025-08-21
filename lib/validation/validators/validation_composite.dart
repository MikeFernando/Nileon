import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validators;

  ValidationComposite(this.validators);

  @override
  String validate({required String field, required String value}) {
    for (final validator in validators) {
      // Verifica se o validator é para o campo correto
      if (validator.fieldName == field) {
        final error = validator.validate(value);
        if (error != null && error.isNotEmpty) {
          return error;
        }
      }
    }
    return '';
  }
}
