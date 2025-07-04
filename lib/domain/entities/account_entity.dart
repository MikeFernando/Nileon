class AccountEntity {
  final String token;

  AccountEntity({required this.token});

  factory AccountEntity.fromJson(Map json) {
    return AccountEntity(token: json['accessToken']);
  }
}
