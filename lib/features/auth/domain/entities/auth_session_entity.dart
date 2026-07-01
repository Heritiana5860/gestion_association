class AuthSessionEntity {
  final String refresh;
  final String access;
  final String username;
  final String firstName;

  const AuthSessionEntity({
    required this.refresh,
    required this.access,
    required this.username,
    required this.firstName,
  });
}
