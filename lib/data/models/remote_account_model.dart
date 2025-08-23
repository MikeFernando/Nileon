import '../../domain/entities/account_entity.dart';

import '../http/http_error.dart';

class RemoteAccountModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String accessToken;
  final String refreshToken;
  final String role;

  RemoteAccountModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken') ||
        !json.containsKey('refreshToken') ||
        !json.containsKey('user')) {
      throw HttpError.invalidData;
    }

    final user = json['user'];
    if (!user.containsKey('id') ||
        !user.containsKey('name') ||
        !user.containsKey('email') ||
        !user.containsKey('phone') ||
        !user.containsKey('role')) {
      throw HttpError.invalidData;
    }

    return RemoteAccountModel(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      phone: user['phone'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      role: user['role'],
    );
  }

  AccountEntity toEntity() => AccountEntity(
        id: id,
        name: name,
        email: email,
        phone: phone,
        accessToken: accessToken,
        refreshToken: refreshToken,
        role: role,
      );
}
