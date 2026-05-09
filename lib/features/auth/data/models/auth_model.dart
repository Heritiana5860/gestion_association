import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_login_entity.dart';

class AuthModel extends AuthLoginEntity {
  const AuthModel({required super.username, required super.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json['username'] ?? "",
      password: json['password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
