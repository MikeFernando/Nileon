import '../../domain/entities/account_entity.dart';

import '../http/http_error.dart';

class RemoteAccountModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  RemoteAccountModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone});

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('email') ||
        !json.containsKey('phone')) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone']);
  }

  AccountEntity toEntity() => AccountEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
      );
}
