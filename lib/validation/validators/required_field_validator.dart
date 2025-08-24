import 'package:nileon/presentation/protocols/validations.dart';

class RequiredFieldValidator implements Validation {
  final String fieldName;

  RequiredFieldValidator(this.fieldName);

  @override
  String validate({required String field, required String value}) {
    if (field == fieldName && (value.isEmpty || value.trim().isEmpty)) {
      return 'Campo obrigatório';
    }
    return '';
  }
}

