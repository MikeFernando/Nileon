class AccountEntity {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String accessToken;
  final String refreshToken;
  final String role;

  AccountEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.accessToken,
    required this.refreshToken,
    required this.role,
  });
}
