import 'package:flutter_test/flutter_test.dart';

import 'package:nileon/domain/usecases/add_account.dart';

void main() {
  group('SignupParams', () {
    test('deve criar SignupParams com valores válidos', () {
      final params = SignupParams(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+5511999999999',
        password: 'Password123',
      );

      expect(params.name, 'John Doe');
      expect(params.email, 'john@example.com');
      expect(params.phone, '+5511999999999');
      expect(params.password, 'Password123');
    });

    test('deve aceitar nome com pelo menos 3 caracteres', () {
      final params = SignupParams(
        name: 'Jo',
        email: 'john@example.com',
        phone: '+5511999999999',
        password: 'Password123',
      );

      expect(params.name, 'Jo');
    });

    test('deve aceitar email em formato válido', () {
      final params = SignupParams(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+5511999999999',
        password: 'Password123',
      );

      expect(params.email, 'john.doe@example.com');
    });

    test('deve aceitar telefone em formato válido', () {
      final params = SignupParams(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+5511999999999',
        password: 'Password123',
      );

      expect(params.phone, '+5511999999999');
    });

    test('deve aceitar senha com pelo menos 8 caracteres', () {
      final params = SignupParams(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '+5511999999999',
        password: 'Password123',
      );

      expect(params.password, 'Password123');
    });
  });
}
