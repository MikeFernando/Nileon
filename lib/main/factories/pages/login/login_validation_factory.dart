import 'package:nileon/validation/validation_login/login_validator_composite.dart';
import 'package:nileon/validation/validation_login/validation_composite.dart';
import 'package:nileon/validation/validation_login/required_field_validator.dart';
import 'package:nileon/validation/validation_login/email_validation.dart';
import 'package:nileon/validation/validation_login/password_validation.dart';

LoginValidatorComposite makeLoginValidation() {
  return LoginValidatorComposite(
    ValidationComposite([
      RequiredFieldValidator('email'),
      EmailValidation('email'),
      RequiredFieldValidator('password'),
      PasswordValidation('password'),
    ]),
  );
}
