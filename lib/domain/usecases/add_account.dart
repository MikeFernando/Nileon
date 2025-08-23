import '../entities/entities.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams {
  final String name;
  final String email;
  final String phone;
  final String password;

  AddAccountParams({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}
