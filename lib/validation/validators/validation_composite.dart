import '../../presentation/protocols/protocols.dart';
import '../protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validators;

  ValidationComposite(this.validators);

  @override
  String validate({required String field, required String value}) {
    for (final validator in validators) {
      final error = validator.validate(value);
      if (error != null && error.isNotEmpty) {
        return error;
      }
    }
    return '';
  }
}
