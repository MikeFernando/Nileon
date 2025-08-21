import 'package:flutter_test/flutter_test.dart';
import 'package:nileon/validation/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Email inválido';
    }

    return null;
  }
}

void main() {
  late EmailValidation sut;

  setUp(() {
    sut = EmailValidation('email');
  });

  test('Deve retornar null se o email for válido', () {
    final error = sut.validate('valid@email.com');
    expect(error, null);
  });

  test('Deve retornar null se o email for válido com subdomínio', () {
    final error = sut.validate('valid@email.co.uk');
    expect(error, null);
  });

  test('Deve retornar null se o email for válido com caracteres especiais', () {
    final error = sut.validate('user.name+tag@domain.com');
    expect(error, null);
  });

  test('Deve retornar erro se o email estiver vazio', () {
    final error = sut.validate('');
    expect(error, 'Campo obrigatório');
  });

  test('Deve retornar erro se o email for null', () {
    final error = sut.validate(null);
    expect(error, 'Campo obrigatório');
  });

  test('Deve retornar erro se o email não tiver @', () {
    final error = sut.validate('invalidemail.com');
    expect(error, 'Email inválido');
  });

  test('Deve retornar erro se o email não tiver domínio', () {
    final error = sut.validate('invalid@');
    expect(error, 'Email inválido');
  });

  test('Deve retornar erro se o email não tiver extensão', () {
    final error = sut.validate('invalid@domain');
    expect(error, 'Email inválido');
  });

  test('Deve retornar erro se o email tiver extensão muito curta', () {
    final error = sut.validate('invalid@domain.a');
    expect(error, 'Email inválido');
  });

  test('Deve retornar erro se o email tiver caracteres inválidos', () {
    final error = sut.validate('invalid@domain!.com');
    expect(error, 'Email inválido');
  });
}
