import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_session_entity.dart';

class AuthSessionModel extends AuthSessionEntity {
  const AuthSessionModel({
    required super.refresh,
    required super.access,
    required super.username,
    required super.firstName,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      access: json["access"] as String,
      refresh: json["refresh"] as String,
      username: json["username"] as String,
      firstName: json["first_name"] as String? ?? '',
    );
  }
}
