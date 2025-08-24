import 'package:nileon/validation/validation.dart';

ValidationComposite makeAddAccountValidation() {
  return ValidationComposite([
    NameValidation('name'),
    RequiredFieldValidator('email'),
    EmailValidation('email'),
    RequiredFieldValidator('phone'),
    PhoneValidation('phone'),
    RequiredFieldValidator('password'),
    PasswordValidation('password'),
  ]);
}
