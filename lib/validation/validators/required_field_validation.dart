import '../protocols/protocols.dart';

class RequiredFieldValidator implements FieldValidation {
  final String field;

  RequiredFieldValidator(this.field);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

  @override
  String get fieldName => field;
}
