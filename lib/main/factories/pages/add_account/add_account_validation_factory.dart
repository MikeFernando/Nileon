import 'package:nileon/validation/validation.dart';

ValidationComposite makeAddAccountValidation() {
  return ValidationComposite([
    RequiredFieldValidator('name'),
    NameValidation('name'),
    RequiredFieldValidator('email'),
    EmailValidation('email'),
    RequiredFieldValidator('phone'),
    PhoneValidation('phone'),
    RequiredFieldValidator('password'),
    PasswordValidation('password'),
  ]);
}
