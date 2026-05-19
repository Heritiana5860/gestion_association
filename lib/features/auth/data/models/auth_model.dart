import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_login_entity.dart';

class AuthModel extends AuthLoginEntity {
  const AuthModel({
    required super.username,
    required super.password,
    super.fName,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      username: json[InfoKey.username] ?? "",
      password: json[InfoKey.password] ?? "",
      fName: json[InfoKey.fName] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    InfoKey.username: username,
    InfoKey.password: password,
  };
}
