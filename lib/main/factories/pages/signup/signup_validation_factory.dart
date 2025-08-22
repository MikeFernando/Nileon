import 'package:nileon/validation/validation.dart';

ValidationComposite makeSignupValidation() {
  return ValidationComposite([
    RequiredFieldValidator('name'),
    RequiredFieldValidator('email'),
    EmailValidation('email'),
    RequiredFieldValidator('phone'),
    RequiredFieldValidator('password'),
    PasswordValidation('password'),
  ]);
}
