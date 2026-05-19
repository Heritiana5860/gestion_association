class AuthLoginEntity {
  final String username;
  final String password;
  final String? fName;

  const AuthLoginEntity({
    required this.username,
    required this.password,
    this.fName,
  });
}
