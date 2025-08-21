import 'package:nileon/validation/validators/validators.dart';

ValidationComposite makeLoginValidation() {
  return ValidationComposite([
    RequiredFieldValidator('email'),
    EmailValidation('email'),
    RequiredFieldValidator('password'),
  ]);
}
