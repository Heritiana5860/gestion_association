import 'package:login_with_unite_test_and_clean_architecture/core/contants/keys/info_key.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/auth/domain/entities/login_params.dart';

class AuthLoginModel extends LoginParams {
  const AuthLoginModel({required super.username, required super.password});

  Map<String, dynamic> toJson() => {
    InfoKey.username: username,
    InfoKey.password: password,
  };
}
