import 'dart:async';

import '../protocols/protocols.dart';

class StreamLoginPresenter {
  final Validation validation;
  final StreamController<String?> _emailErrorController =
      StreamController<String?>.broadcast();

  StreamLoginPresenter({required this.validation});

  Stream<String?> get emailErrorStream => _emailErrorController.stream;

  void validateEmail(String email) {
    final error = validation.validate(field: 'email', value: email);
    _emailErrorController.add(error.isEmpty ? null : error);
  }

  void dispose() {
    _emailErrorController.close();
  }
}
