import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/auth_register_entity.dart';

class AuthRegisterModel extends AuthRegisterEntity {
  const AuthRegisterModel({
    required super.fullName,
    required super.username,
    required super.password,
  });

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    return AuthRegisterModel(
      fullName: json[InfoKey.fullName] as String,
      username: json[InfoKey.username] as String,
      password: json[InfoKey.password] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      InfoKey.fullName: fullName,
      InfoKey.username: username,
      InfoKey.password: password,
    };
  }
}
