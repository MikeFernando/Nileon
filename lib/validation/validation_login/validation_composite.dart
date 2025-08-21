import 'package:nileon/presentation/protocols/validations.dart';

class ValidationComposite implements Validation {
  final List<Validation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({required String field, required String value}) {
    for (final validation in validations) {
      final error = validation.validate(field: field, value: value);
      if (error.isNotEmpty) {
        return error;
      }
    }
    return '';
  }
}

