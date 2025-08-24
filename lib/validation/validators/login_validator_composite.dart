import 'package:nileon/presentation/protocols/validations.dart';
import 'package:nileon/validation/validators/validation_composite.dart';

class LoginValidatorComposite implements Validation {
  final ValidationComposite validation;

  LoginValidatorComposite(this.validation);

  @override
  String validate({required String field, required String value}) {
    return validation.validate(field: field, value: value);
  }
}
