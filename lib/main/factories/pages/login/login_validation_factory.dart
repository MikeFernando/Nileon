import '../../../../validation/validation.dart';

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
