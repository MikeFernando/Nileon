import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add(SignupParams params);
}

class SignupParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  SignupParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
